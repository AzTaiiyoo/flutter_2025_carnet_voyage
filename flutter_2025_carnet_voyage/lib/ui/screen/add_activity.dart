import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/address.dart';
import '../../models/sortie.dart';
import '../../blocs/sortie_cubit.dart';
import '../../blocs/map_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        // Mettre à jour les champs quand une adresse est sélectionnée
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
          title: const Text('Ajouter une sortie'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Nom de l'activité
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.label, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text(
                                'Nom',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nom de la sortie',
                              border: OutlineInputBorder(),
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
                  ),
                  const SizedBox(height: 12),

                  // Section Adresse
                  Card(
                    child: InkWell(
                      onTap: _navigateToMap,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Adresse',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.map,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Choisir sur la carte',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _streetController,
                              decoration: const InputDecoration(
                                labelText: 'Rue (optionnel)',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: _cityController,
                                    decoration: const InputDecoration(
                                      labelText: 'Ville',
                                      border: OutlineInputBorder(),
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
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _postcodeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Code postal',
                                      border: OutlineInputBorder(),
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
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Date
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            decoration: const InputDecoration(
                              labelText: 'Date de la sortie',
                              border: OutlineInputBorder(),
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
                  ),
                  const SizedBox(height: 12),

                  // Note / Commentaire
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.notes, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text(
                                'Notes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _noteController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Commentaires (optionnel)',
                              border: OutlineInputBorder(),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Rating
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text(
                                'Note',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < _rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
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
                  ),
                  const SizedBox(height: 24),

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
                          imageUrl: null,
                        );
                        context.read<SortieCubit>().addSortie(newSortie);

                        // Nettoyer les champs
                        _resetForm();

                        // Revenir à la liste
                        if (widget.onNavigateToList != null) {
                          widget.onNavigateToList!();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sortie ajoutée avec succès !'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Ajouter la sortie'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
