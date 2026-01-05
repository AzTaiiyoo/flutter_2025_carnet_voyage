import 'package:geocoding/geocoding.dart';

class Address {
  final String? street;
  final String city;
  final String? postcode;
  final double? latitude;
  final double? longitude;

  Address({
    this.street,
    required this.city,
    this.postcode,
    this.latitude,
    this.longitude,
  });

  /// Factory pour créer une Address depuis un Placemark (package geocoding)
  factory Address.fromPlacemark(
    Placemark placemark, {
    double? lat,
    double? lon,
  }) {
    // Construction de la rue (numéro + nom)
    String? street;
    if (placemark.subThoroughfare != null && placemark.thoroughfare != null) {
      street = '${placemark.subThoroughfare} ${placemark.thoroughfare}';
    } else if (placemark.thoroughfare != null) {
      street = placemark.thoroughfare;
    } else if (placemark.street != null) {
      street = placemark.street;
    }

    return Address(
      street: street,
      city:
          placemark.locality ??
          placemark.subAdministrativeArea ??
          'Ville inconnue',
      postcode: placemark.postalCode ?? '00000',
      latitude: lat,
      longitude: lon,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? properties = json['properties'];
    return Address(
      street: properties?['street'] ?? json['street'],
      city: properties?['city'] ?? json['city'] ?? 'Ville inconnue',
      postcode: properties?['postcode'] ?? json['postcode'] ?? '00000',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'postcode': postcode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    final parts = <String>[];
    if (street != null && street!.isNotEmpty) {
      parts.add(street!);
    }
    parts.add(city);
    if (postcode != null && postcode!.isNotEmpty) {
      parts.add(postcode!);
    }
    return parts.join(', ');
  }

  /// Retourne une version courte de l'adresse (ville uniquement)
  String get shortAddress => city;

  /// Retourne les coordonnées formatées
  String get formattedCoordinates {
    if (latitude != null && longitude != null) {
      return '${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}';
    }
    return 'Coordonnées inconnues';
  }

  /// Vérifie si l'adresse a des coordonnées
  bool get hasCoordinates => latitude != null && longitude != null;

  factory Address.fromGeoJson(Map<String, dynamic> json) {
    final Map<String, dynamic> properties = json['properties'] ?? {};
    final List<dynamic>? coordinates = json['geometry']?['coordinates'];

    final String? street = properties['name'];
    final String city =
        properties['city'] ?? properties['municipality'] ?? 'Ville inconnue';
    final String postcode = properties['postcode'] ?? '00000';

    return Address(
      street: street,
      city: city,
      postcode: postcode,
      longitude: coordinates?[0]?.toDouble(),
      latitude: coordinates?[1]?.toDouble(),
    );
  }

  /// Factory pour créer une Address depuis la réponse Nominatim (OpenStreetMap)
  factory Address.fromNominatim(Map<String, dynamic> json) {
    final Map<String, dynamic> addressDetails = json['address'] ?? {};

    // Construction de la rue
    String? street;
    final String? road = addressDetails['road'];
    final String? houseNumber = addressDetails['house_number'];
    if (road != null) {
      street = houseNumber != null ? '$houseNumber $road' : road;
    }

    // Déterminer la ville (plusieurs possibilités dans Nominatim)
    final String city = addressDetails['city'] ??
        addressDetails['town'] ??
        addressDetails['village'] ??
        addressDetails['municipality'] ??
        addressDetails['county'] ??
        json['display_name']?.split(',').first ??
        'Lieu inconnu';

    // Code postal
    final String postcode = addressDetails['postcode'] ?? '';

    // Coordonnées
    final double? lat = double.tryParse(json['lat']?.toString() ?? '');
    final double? lon = double.tryParse(json['lon']?.toString() ?? '');

    return Address(
      street: street,
      city: city,
      postcode: postcode,
      latitude: lat,
      longitude: lon,
    );
  }
}
