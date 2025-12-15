import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// custom imports
import 'package:flutter_2025_carnet_voyage/ui/widget/address_search_bar.dart';
import 'package:flutter_2025_carnet_voyage/ui/widget/address_info_widget.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélection du lieu'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddressSearchBar(), // Votre widget de recherche
          ),
        ),
      ),
      body: Column(
        children: [
          // Widget d'informations météo/localisation en haut
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: AddressInfoWidget(), // Vos infos (météo, coordonnées, etc.)
          ),

          // Carte qui prend tout l'espace restant
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(47.466671, -0.55),
                initialZoom: 13.0,
                onTap: (tapPosition, point) {
                  // Gérer le clic sur la carte
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                // Ajouter un marqueur pour la position sélectionnée
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Valider la sélection et retourner
        },
        icon: const Icon(Icons.check),
        label: const Text('Valider'),
      ),
    );
  }
}
