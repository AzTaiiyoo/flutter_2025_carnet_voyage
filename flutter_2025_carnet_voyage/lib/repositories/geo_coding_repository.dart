import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_2025_carnet_voyage/models/address.dart';

/// Repository pour les opérations de géocodage
/// Utilise l'API Nominatim (OpenStreetMap) - fonctionne sur toutes les plateformes
class GeoCodingRepository {
  const GeoCodingRepository();

  static const String _baseUrl = 'https://nominatim.openstreetmap.org';

  /// Recherche d'adresses à partir d'une requête texte
  ///
  /// [query] est la chaîne de recherche (ex: "Tour Eiffel, Paris")
  /// Retourne une liste d'[Address] correspondantes
  Future<List<Address>> searchAddresses(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final Uri uri = Uri.parse(
        '$_baseUrl/search?q=${Uri.encodeComponent(query)}&format=json&addressdetails=1&limit=5',
      );

      final http.Response response = await http.get(
        uri,
        headers: {
          'User-Agent': 'FlutterCarnetVoyage/1.0',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        return results.map((json) => Address.fromNominatim(json)).toList();
      } else {
        throw GeoCodingException(
          'Erreur API Nominatim: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw GeoCodingException('Erreur lors de la recherche d\'adresses: $e');
    }
  }

  /// Reverse geocoding: convertit des coordonnées GPS en adresse
  ///
  /// [latitude] et [longitude] sont les coordonnées du lieu
  /// Retourne une [Address] ou null si non trouvée
  Future<Address?> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final Uri uri = Uri.parse(
        '$_baseUrl/reverse?lat=$latitude&lon=$longitude&format=json&addressdetails=1',
      );

      final http.Response response = await http.get(
        uri,
        headers: {
          'User-Agent': 'FlutterCarnetVoyage/1.0',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json.containsKey('error')) {
          return null;
        }
        return Address.fromNominatim(json);
      }
      return null;
    } catch (e) {
      throw GeoCodingException(
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
      final List<Address> addresses = await searchAddresses(address);
      if (addresses.isNotEmpty && addresses.first.hasCoordinates) {
        return (addresses.first.latitude!, addresses.first.longitude!);
      }
      return null;
    } catch (e) {
      throw GeoCodingException(
        'Erreur lors de la récupération des coordonnées: $e',
      );
    }
  }
}

/// Exception personnalisée pour les erreurs de géocodage
class GeoCodingException implements Exception {
  final String message;

  const GeoCodingException(this.message);

  @override
  String toString() => 'GeoCodingException: $message';
}
