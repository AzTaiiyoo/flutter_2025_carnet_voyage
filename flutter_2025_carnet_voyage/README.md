# 📱 Application de Notation d'Activités - Flutter

## 📋 Description du Projet

Application mobile permettant d'enregistrer et de noter toutes vos activités et sorties avec photos, notes et informations météo.

### Fonctionnalités Principales

- ✅ Enregistrer des sorties avec notes, photos et notation
- 🗺️ Sélection de lieux via carte interactive
- 📍 Recherche d'adresses et géolocalisation
- ☀️ Affichage des informations météo du lieu
- 📸 Prise de photos avec la caméra
- ⭐ Notation des lieux visités

## 🏗️ Architecture

Le projet suit une architecture **Clean Architecture** avec le pattern **BLoC/Cubit** :

```
lib/
├── models/               # Modèles de données
├── repositories/         # Accès aux données (API, SharedPreferences)
├── blocs/               # Logique métier (Cubits)
└── ui/                  # Interface utilisateur
    ├── screens/         # Écrans complets
    ├── views/           # Composants de vue
    └── widgets/         # Widgets réutilisables
```

### Modèles (`lib/models/`)

- **Activity** : Activité/sortie avec note, photos, description, lieu, météo, date
- **Location** : Coordonnées GPS + adresse complète
- **WeatherInfo** : Informations météo (température, conditions)
- **PlaceDetails** : Détails d'un lieu (optionnel, via Foursquare)

### Repositories (`lib/repositories/`)

- **ActivityRepository** : Gestion de la persistence (SharedPreferences)
- **GeocodingRepository** : Recherche d'adresses et géocodage
- **WeatherRepository** : API OpenWeatherMap
- **GeolocationRepository** : Service de géolocalisation
- **PlacesRepository** : API Foursquare (optionnel)

### Cubits (`lib/blocs/`)

- **ActivityCubit** : CRUD des activités
- **MapCubit** : État de la carte (position, sélection)
- **SearchLocationCubit** : Recherche d'adresses
- **WeatherCubit** : Récupération météo
- **CameraCubit** : Gestion photos (optionnel)

### UI (`lib/ui/`)

#### Screens (3 écrans principaux)

1. **HomeScreen** : Liste de toutes les activités
2. **MapScreen** : Carte interactive + recherche d'adresse + météo
3. **ActivityDetailScreen** : Création/édition d'une activité

#### Widgets

- **ActivityCard** : Carte affichant une activité
- **LocationSearchBar** : Barre de recherche d'adresse
- **RatingWidget** : Notation par étoiles
- **PhotoPicker** : Sélecteur de photos
- **WeatherDisplay** : Affichage de la météo

## 🎯 Flux Utilisateur

```
1. HomeScreen (liste vide au départ)
   ↓ [Bouton "Nouvelle Activité"]
2. MapScreen (recherche adresse + carte + météo)
   ↓ [Clic sur la carte]
3. ActivityDetailScreen (note + photo + description)
   ↓ [Sauvegarde]
4. Retour HomeScreen (avec nouvelle activité)
```

## 📦 Dépendances

### Déjà installées

```yaml
flutter_bloc: ^9.1.1 # State management
shared_preferences: ^2.5.3 # Persistence locale
flutter_map: ^8.2.2 # Carte interactive
latlong2: ^0.9.1 # Coordonnées GPS
http: ^1.2.2 # Requêtes HTTP
```

### À installer

```bash
flutter pub add geolocator
flutter pub add geocoding
flutter pub add image_picker
flutter pub add permission_handler
flutter pub add intl
```

## 🔑 APIs à Configurer

### OpenWeatherMap (Météo)

1. Créer un compte sur [openweathermap.org](https://openweathermap.org/api)
2. Obtenir une clé API gratuite
3. La stocker dans un fichier de configuration

### Foursquare (Optionnel - Détails des lieux)

1. Créer un compte sur [Foursquare Developers](https://developer.foursquare.com/)
2. Obtenir une clé API
3. La stocker dans un fichier de configuration

## 🚀 Installation

```bash
# Cloner le projet
git clone [URL_DU_REPO]
cd eseo_s9_2025

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

## 📱 Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
```

### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Cette app a besoin de votre position pour afficher des activités à proximité</string>
<key>NSCameraUsageDescription</key>
<string>Cette app a besoin de la caméra pour prendre des photos</string>
```

## 🧪 Tests

```bash
# Lancer les tests
flutter test

# Analyser le code
flutter analyze
```

## 📝 Conventions de Code

- **Nommage** : camelCase pour variables/méthodes, PascalCase pour classes
- **State Management** : Utiliser Cubit pour toute la logique métier
- **UI** : Séparer les widgets réutilisables dans `ui/widgets/`
- **Repositories** : Toutes les interactions avec données externes
- **Models** : Inclure `toJson()` et `fromJson()` pour sérialisation

## 📂 Structure des Données (SharedPreferences)

Les activités sont stockées localement sous forme de JSON :

```json
{
  "id": "uuid",
  "title": "Visite Tour Eiffel",
  "description": "Belle journée à Paris",
  "rating": 5,
  "location": {
    "latitude": 48.8584,
    "longitude": 2.2945,
    "address": "Champ de Mars, Paris"
  },
  "weather": {
    "temperature": 22,
    "condition": "ensoleillé"
  },
  "photos": ["path/to/photo1.jpg", "path/to/photo2.jpg"],
  "createdAt": "2025-12-15T10:30:00Z"
}
```

## 🤝 Contribution

1. Créer une branche pour chaque fonctionnalité
2. Respecter l'architecture définie
3. Tester avant de merger
4. Documenter les nouvelles fonctionnalités

## 👥 Équipe

- Votre nom
- Nom du collègue

---

**Version** : 1.0.0  
**Date** : Décembre 2025
