import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/address.dart';
import '../../models/sortie.dart';
import '../../blocs/sortie_cubit.dart';
import '../../blocs/map_cubit.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_theme_extensions.dart';

/// Écran d'ajout d'une nouvelle sortie
/// Design Life-log premium avec formulaire structuré
class AddActivity extends StatefulWidget {
  final VoidCallback? onNavigateToMap;
  final VoidCallback? onNavigateToList;

  const AddActivity({super.key, this.onNavigateToMap, this.onNavigateToList});

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
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Récupérer l'adresse depuis le MapCubit si elle existe
    final mapState = context.read<MapCubit>().state;
    if (mapState.hasSelectedAddress) {
      final Address address = mapState.selectedAddress!;
      _streetController.text = address.street ?? '';
      _cityController.text = address.city;
      _postcodeController.text = address.postcode;
    }
  }

  void _navigateToMap() {
    // Naviguer vers la carte pour sélectionner une adresse via callback
    if (widget.onNavigateToMap != null) {
      widget.onNavigateToMap!();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;

    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        // Mettre à jour les champs d'adresse quand une adresse est sélectionnée
        if (state.hasSelectedAddress) {
          final Address address = state.selectedAddress!;
          setState(() {
            _streetController.text = address.street ?? '';
            _cityController.text = address.city;
            _postcodeController.text = address.postcode;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ajouter une sortie',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: colorScheme.primaryContainer,
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
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context: context,
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
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Section Photo
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context: context,
                          icon: Icons.photo_camera,
                          title: 'Photo (optionnel)',
                        ),
                        SizedBox(height: AppSpacing.md),
                        if (_imagePath != null) ...[
                          // Aperçu de l'image
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: AppSpacing.photoRadius,
                                child: Image.file(
                                  File(_imagePath!),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: AppSpacing.sm,
                                right: AppSpacing.sm,
                                child: GestureDetector(
                                  onTap: _removeImage,
                                  child: Container(
                                    padding: EdgeInsets.all(AppSpacing.xs),
                                    decoration: BoxDecoration(
                                      color: colorScheme.error.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: colorScheme.onError,
                                      size: AppSpacing.iconMs,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.ms),
                        ],
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickImageFromGallery,
                                icon: const Icon(Icons.photo_library),
                                label: const Text('Galerie'),
                              ),
                            ),
                            SizedBox(width: AppSpacing.ms),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickImageFromCamera,
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Appareil'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Section Adresse
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    onTap: _navigateToMap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: lifeLogTheme.iconColorSecondary,
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Text(
                              'Adresse',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.map, color: colorScheme.primary),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              'Choisir sur la carte',
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _streetController,
                          decoration: const InputDecoration(
                            labelText: 'Rue (optionnel)',
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: AppSpacing.ms),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  labelText: 'Ville',
                                ),
                                enabled: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ville requise';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: AppSpacing.ms),
                            Expanded(
                              child: TextFormField(
                                controller: _postcodeController,
                                decoration: const InputDecoration(
                                  labelText: 'Code postal',
                                ),
                                enabled: false,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Requis';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Date
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context: context,
                          icon: Icons.calendar_today,
                          title: 'Date',
                        ),
                        SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: const InputDecoration(
                            labelText: 'Date de la sortie',
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez sélectionner une date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Note / Commentaire
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context: context,
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
                  ),
                  SizedBox(height: AppSpacing.ms),

                  // Rating
                  _buildCard(
                    context: context,
                    lifeLogTheme: lifeLogTheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context: context,
                          icon: Icons.star,
                          title: 'Note',
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: lifeLogTheme.ratingStarColor,
                                size: 36,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1.0;
                                });
                              },
                            );
                          }),
                        ),
                        if (_rating > 0)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _rating = 0;
                                });
                              },
                              child: const Text('Effacer la note'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),

                  // Bouton Ajouter
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final Address address = Address(
                          street: _streetController.text.isNotEmpty
                              ? _streetController.text
                              : null,
                          city: _cityController.text,
                          postcode: _postcodeController.text,
                        );

                        final Sortie newSortie = Sortie(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: _nameController.text,
                          address: address,
                          date: _selectedDate,
                          note: _noteController.text.isNotEmpty
                              ? _noteController.text
                              : null,
                          rating: _rating > 0 ? _rating : null,
                          imageUrl: _imagePath,
                        );
                        context.read<SortieCubit>().addSortie(newSortie);

                        // Naviguer vers la liste via callback (IndexedStack, pas Navigator)
                        if (widget.onNavigateToList != null) {
                          widget.onNavigateToList!();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Sortie ajoutée avec succès !'),
                            backgroundColor: colorScheme.secondary,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter la sortie'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Construit une carte avec le style Life-log
  Widget _buildCard({
    required BuildContext context,
    required LifeLogThemeExtension lifeLogTheme,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: lifeLogTheme.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.cardRadius,
          child: Padding(padding: AppSpacing.cardPadding, child: child),
        ),
      ),
    );
  }

  /// Construit un en-tête de section avec icône et titre
  Widget _buildSectionHeader({
    required BuildContext context,
    required IconData icon,
    required String title,
  }) {
    final theme = Theme.of(context);
    final lifeLogTheme = theme.extension<LifeLogThemeExtension>()!;
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Icon(icon, color: lifeLogTheme.iconColorSecondary),
        SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
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
    });
    context.read<MapCubit>().clearSelection();
  }
}
