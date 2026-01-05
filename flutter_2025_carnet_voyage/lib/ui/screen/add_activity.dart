import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/address.dart';
import '../../models/sortie.dart';
import '../../blocs/sortie_cubit.dart';
import '../../blocs/map_cubit.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme_extensions.dart';
import '../widget/add_activity_form/form_card.dart';
import '../widget/add_activity_form/section_header.dart';
import '../widget/add_activity_form/photo_picker_section.dart';
import '../widget/add_activity_form/address_section.dart';
import '../widget/add_activity_form/date_picker_field.dart';
import '../widget/add_activity_form/rating_input.dart';

/// Écran d'ajout d'une nouvelle sortie
/// Design Life-log premium avec formulaire structuré
class AddActivity extends StatefulWidget {
  final VoidCallback? onNavigateToMap;
  final VoidCallback? onNavigateToList;
  final Sortie? sortieToEdit;

  const AddActivity({
    super.key,
    this.onNavigateToMap,
    this.onNavigateToList,
    this.sortieToEdit,
  });

  bool get isEditing => sortieToEdit != null;

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  double _rating = 0;
  String? _imagePath;
  double? _latitude;
  double? _longitude;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void didUpdateWidget(AddActivity oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sortieToEdit != oldWidget.sortieToEdit) {
      _initializeForm();
    }
  }

  void _initializeForm() {
    if (widget.sortieToEdit != null) {
      final sortie = widget.sortieToEdit!;
      _nameController.text = sortie.name;
      _streetController.text = sortie.address.street ?? '';
      _cityController.text = sortie.address.city;
      _postcodeController.text = sortie.address.postcode ?? '';
      _noteController.text = sortie.note ?? '';
      _selectedDate = sortie.date;
      _rating = sortie.rating ?? 0;
      _imagePath = sortie.imageUrl;
      _latitude = sortie.address.latitude;
      _longitude = sortie.address.longitude;
    } else {
      _nameController.clear();
      _streetController.clear();
      _cityController.clear();
      _postcodeController.clear();
      _noteController.clear();
      _selectedDate = DateTime.now();
      _rating = 0;
      _imagePath = null;
      _latitude = null;
      _longitude = null;
    }
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!widget.isEditing) {
      final mapState = context.read<MapCubit>().state;
      if (mapState.hasSelectedAddress) {
        final Address address = mapState.selectedAddress!;
        _streetController.text = address.street ?? '';
        _cityController.text = address.city;
        _postcodeController.text = address.postcode ?? '';
        _latitude = address.latitude;
        _longitude = address.longitude;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _streetController.clear();
      _cityController.clear();
      _postcodeController.clear();
      _noteController.clear();
      _selectedDate = DateTime.now();
      _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      _rating = 0;
      _imagePath = null;
      _latitude = null;
      _longitude = null;
    });
    context.read<MapCubit>().clearSelection();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final Address address = Address(
        street: _streetController.text.isNotEmpty ? _streetController.text : null,
        city: _cityController.text,
        postcode: _postcodeController.text,
        latitude: _latitude,
        longitude: _longitude,
      );

      final Sortie sortie = Sortie(
        id: widget.isEditing
            ? widget.sortieToEdit!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        address: address,
        date: _selectedDate,
        note: _noteController.text.isNotEmpty ? _noteController.text : null,
        rating: _rating > 0 ? _rating : null,
        imageUrl: _imagePath,
      );

      if (widget.isEditing) {
        context.read<SortieCubit>().updateSortie(
              widget.sortieToEdit!.id,
              sortie,
            );
      } else {
        context.read<SortieCubit>().addSortie(sortie);
      }

      _resetForm();

      if (widget.onNavigateToList != null) {
        widget.onNavigateToList!();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Sortie modifiée avec succès !'
                : 'Sortie ajoutée avec succès !',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lifeLogTheme = Theme.of(context).extension<LifeLogThemeExtension>()!;

    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state.hasSelectedAddress) {
          final Address address = state.selectedAddress!;
          setState(() {
            _streetController.text = address.street ?? '';
            _cityController.text = address.city;
            _postcodeController.text = address.postcode ?? '';
            _latitude = address.latitude;
            _longitude = address.longitude;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isEditing ? 'Modifier la sortie' : 'Ajouter une sortie',
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: AppSpacing.screenPadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Nom de l'activité
                  _buildNameSection(lifeLogTheme),
                  SizedBox(height: AppSpacing.ms),

                  // Photo
                  PhotoPickerSection(
                    imagePath: _imagePath,
                    onImageChanged: (path) {
                      setState(() => _imagePath = path);
                    },
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Adresse
                  AddressSection(
                    streetController: _streetController,
                    cityController: _cityController,
                    postcodeController: _postcodeController,
                    onNavigateToMap: widget.onNavigateToMap,
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Date
                  DatePickerField(
                    controller: _dateController,
                    selectedDate: _selectedDate,
                    onDateChanged: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Notes
                  _buildNotesSection(lifeLogTheme),
                  SizedBox(height: AppSpacing.ms),

                  // Rating
                  RatingInput(
                    rating: _rating,
                    onRatingChanged: (value) {
                      setState(() => _rating = value);
                    },
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Bouton Submit
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameSection(LifeLogThemeExtension lifeLogTheme) {
    return FormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.label,
            title: 'Nom',
          ),
          SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nom de la sortie',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le nom de la sortie';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(LifeLogThemeExtension lifeLogTheme) {
    return FormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.notes,
            title: 'Notes',
          ),
          SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Commentaires (optionnel)',
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton.icon(
      onPressed: _submitForm,
      icon: Icon(widget.isEditing ? Icons.save : Icons.add),
      label: Text(
        widget.isEditing ? 'Enregistrer' : 'Ajouter la sortie',
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
