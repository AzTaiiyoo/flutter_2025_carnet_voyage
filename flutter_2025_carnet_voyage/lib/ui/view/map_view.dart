import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// custom imports
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/ui/widget/address_search_bar.dart';
import 'package:flutter_2025_carnet_voyage/ui/widget/address_info_widget.dart';

class MapView extends StatefulWidget {
  final VoidCallback? onNavigateToAddActivity;

  const MapView({super.key, this.onNavigateToAddActivity});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  LatLng? _previousPosition;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        // Déplacer la carte vers la nouvelle position seulement si les coordonnées ont changé
        if (state.hasSelectedAddress && state.selectedAddress!.hasCoordinates) {
          final LatLng newPosition = LatLng(
            state.selectedAddress!.latitude!,
            state.selectedAddress!.longitude!,
          );

          // Comparer les coordonnées directement
          if (_previousPosition == null ||
              _previousPosition!.latitude != newPosition.latitude ||
              _previousPosition!.longitude != newPosition.longitude) {
            _mapController.move(newPosition, 15.0);
            _previousPosition = newPosition;
          }
        }
        // Réinitialiser si la sélection est effacée
        if (!state.hasSelectedAddress) {
          _previousPosition = null;
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Barre de recherche en haut
                      const AddressSearchBar(),

                      const SizedBox(height: 8),

                      // Widget d'informations météo/localisation (avec hauteur max)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.35,
                        ),
                        child: const SingleChildScrollView(
                          child: AddressInfoWidget(),
                        ),
                      ),
                    ],
                  ),
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
    if (state.selectedAddress != null &&
        widget.onNavigateToAddActivity != null) {
      // Naviguer vers AddActivity via callback
      widget.onNavigateToAddActivity!();
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
