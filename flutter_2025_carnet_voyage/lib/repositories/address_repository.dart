import 'package:geocoding/geocoding.dart';
import 'package:flutter_2025_carnet_voyage/models/address.dart';

/// Repository pour la recherche d'adresses
/// Utilise le package `geocoding` (services natifs Android/iOS)
class AddressRepository {
  const AddressRepository();

  /// Recherche d'adresses à partir d'une requête texte
  ///
  /// [query] est la chaîne de recherche (ex: "Tour Eiffel, Paris")
  /// Retourne une liste d'[Address] correspondantes
  Future<List<Address>> fetchAddresses(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      // Recherche des localisations correspondant à la requête
      final List<Location> locations = await locationFromAddress(query);
      final List<Address> addresses = [];

      // Pour chaque localisation, on récupère les détails de l'adresse
      for (final Location location in locations) {
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        if (placemarks.isNotEmpty) {
          addresses.add(
            Address.fromPlacemark(
              placemarks.first,
              lat: location.latitude,
              lon: location.longitude,
            ),
          );
        }
      }

      return addresses;
    } catch (e) {
      throw AddressRepositoryException(
        'Erreur lors de la recherche d\'adresses: $e',
      );
    }
  }

  /// Recherche d'adresse à partir de coordonnées (reverse geocoding)
  ///
  /// [latitude] et [longitude] sont les coordonnées du lieu
  /// Retourne une [Address] ou null si non trouvée
  Future<Address?> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        return Address.fromPlacemark(
          placemarks.first,
          lat: latitude,
          lon: longitude,
        );
      }
      return null;
    } catch (e) {
      throw AddressRepositoryException(
        'Erreur lors de la conversion des coordonnées en adresse: $e',
      );
    }
  }

  /// Récupère les coordonnées d'une adresse
  ///
  /// [address] est l'adresse textuelle
  /// Retourne les coordonnées (latitude, longitude) ou null
  Future<(double, double)?> getCoordinatesFromAddress(String address) async {
    try {
      final List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        return (locations.first.latitude, locations.first.longitude);
      }
      return null;
    } catch (e) {
      throw AddressRepositoryException(
        'Erreur lors de la récupération des coordonnées: $e',
      );
    }
  }
}

/// Exception personnalisée pour les erreurs de recherche d'adresses
class AddressRepositoryException implements Exception {
  final String message;

  const AddressRepositoryException(this.message);

  @override
  String toString() => 'AddressRepositoryException: $message';
}
