import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// custom imports
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/ui/widget/address_search_bar.dart';
import 'package:flutter_2025_carnet_voyage/ui/widget/address_info_widget.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        // Déplacer la carte vers la nouvelle position
        if (state.hasSelectedAddress && state.selectedAddress!.hasCoordinates) {
          _mapController.move(
            LatLng(
              state.selectedAddress!.latitude!,
              state.selectedAddress!.longitude!,
            ),
            15.0, // Zoom plus proche lors d'une sélection
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Carte en arrière-plan (prend tout l'écran)
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: state.currentPosition,
                  initialZoom: 13.0,
                  onTap: (tapPosition, point) {
                    // Gérer le clic sur la carte
                    context.read<MapCubit>().onMapTap(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  // Marqueur pour la position sélectionnée
                  if (state.hasSelectedAddress &&
                      state.selectedAddress!.hasCoordinates)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            state.selectedAddress!.latitude!,
                            state.selectedAddress!.longitude!,
                          ),
                          width: 50,
                          height: 50,
                          child: const _LocationMarker(),
                        ),
                      ],
                    ),
                ],
              ),

              // Contenu superposé
              SafeArea(
                child: Column(
                  children: [
                    // Barre de recherche en haut
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const AddressSearchBar(),
                    ),

                    // Widget d'informations météo/localisation
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const AddressInfoWidget(),
                    ),

                    // Spacer pour pousser le bouton vers le bas
                    const Spacer(),
                  ],
                ),
              ),

              // Indicateur de chargement
              if (state.isLoading)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
          // Bouton de validation
          floatingActionButton: state.hasSelectedAddress
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _onValidateSelection(context, state);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Valider'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  void _onValidateSelection(BuildContext context, MapState state) {
    // TODO: Naviguer vers l'écran de création de sortie avec l'adresse
    if (state.selectedAddress != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Adresse sélectionnée: ${state.selectedAddress}'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );

      // TODO: Remplacer par la navigation vers l'écran de création
      // Navigator.pushNamed(context, Routes.createActivity, arguments: state.selectedAddress);
    }
  }
}

/// Widget de marqueur personnalisé pour la position sélectionnée
class _LocationMarker extends StatelessWidget {
  const _LocationMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.location_on, color: Colors.white, size: 32),
    );
  }
}
