import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_2025_carnet_voyage/models/weather_info.dart';
import 'package:flutter_2025_carnet_voyage/config/api_keys.dart';

/// Repository pour récupérer les données météo via l'API OpenWeatherMap
class WeatherRepository {
  const WeatherRepository();

  /// Récupère les informations météo pour des coordonnées GPS
  ///
  /// [latitude] et [longitude] sont les coordonnées du lieu
  /// Retourne un [WeatherInfo] avec toutes les informations météo
  Future<WeatherInfo> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final String url =
        '${ApiKeys.openWeatherMapBaseUrl}/weather'
        '?lat=$latitude'
        '&lon=$longitude'
        '&appid=${ApiKeys.openWeatherMapApiKey}'
        '&units=metric'
        '&lang=fr';

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return WeatherInfo.fromOpenWeatherMap(json);
    } else if (response.statusCode == 401) {
      throw WeatherException(
        'Clé API invalide. Vérifiez votre clé OpenWeatherMap.',
      );
    } else {
      throw WeatherException(
        'Erreur lors de la récupération de la météo: ${response.statusCode}',
      );
    }
  }

  /// Récupère les informations météo pour une ville
  ///
  /// [cityName] est le nom de la ville
  /// Retourne un [WeatherInfo] avec toutes les informations météo
  Future<WeatherInfo> getWeatherByCity(String cityName) async {
    final String url =
        '${ApiKeys.openWeatherMapBaseUrl}/weather'
        '?q=${Uri.encodeComponent(cityName)}'
        '&appid=${ApiKeys.openWeatherMapApiKey}'
        '&units=metric'
        '&lang=fr';

    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return WeatherInfo.fromOpenWeatherMap(json);
    } else if (response.statusCode == 404) {
      throw WeatherException('Ville non trouvée: $cityName');
    } else if (response.statusCode == 401) {
      throw WeatherException(
        'Clé API invalide. Vérifiez votre clé OpenWeatherMap.',
      );
    } else {
      throw WeatherException(
        'Erreur lors de la récupération de la météo: ${response.statusCode}',
      );
    }
  }
}

/// Exception personnalisée pour les erreurs météo
class WeatherException implements Exception {
  final String message;

  const WeatherException(this.message);

  @override
  String toString() => 'WeatherException: $message';
}
