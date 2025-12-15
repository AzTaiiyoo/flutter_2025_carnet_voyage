/// Modèle représentant les informations météo d'un lieu
class WeatherInfo {
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int visibility;
  final String locationName;

  const WeatherInfo({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.locationName,
  });

  /// Factory pour créer WeatherInfo depuis la réponse OpenWeatherMap
  factory WeatherInfo.fromOpenWeatherMap(Map<String, dynamic> json) {
    final Map<String, dynamic> main = json['main'] ?? {};
    final Map<String, dynamic> wind = json['wind'] ?? {};
    final List<dynamic> weather = json['weather'] ?? [];
    final Map<String, dynamic> weatherData = weather.isNotEmpty
        ? weather[0]
        : {};

    return WeatherInfo(
      temperature: (main['temp'] as num?)?.toDouble() ?? 0.0,
      description: weatherData['description'] ?? 'Inconnu',
      icon: weatherData['icon'] ?? '01d',
      humidity: main['humidity'] ?? 0,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      visibility: ((json['visibility'] as num?) ?? 10000) ~/ 1000, // en km
      locationName: json['name'] ?? 'Lieu inconnu',
    );
  }

  /// Sérialisation JSON
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'visibility': visibility,
      'locationName': locationName,
    };
  }

  /// Désérialisation JSON
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? 'Inconnu',
      icon: json['icon'] ?? '01d',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
      visibility: json['visibility'] ?? 10,
      locationName: json['locationName'] ?? 'Lieu inconnu',
    );
  }

  /// Retourne l'URL de l'icône météo OpenWeatherMap
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';

  /// Retourne la température formatée
  String get formattedTemperature => '${temperature.round()}°C';

  /// Retourne la vitesse du vent formatée
  String get formattedWindSpeed => '${windSpeed.round()} km/h';

  /// Retourne la visibilité formatée
  String get formattedVisibility => '$visibility km';

  /// Retourne l'humidité formatée
  String get formattedHumidity => '$humidity%';

  @override
  String toString() {
    return 'WeatherInfo(temp: $formattedTemperature, desc: $description, '
        'humidity: $formattedHumidity, wind: $formattedWindSpeed)';
  }
}
