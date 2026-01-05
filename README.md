# 🗺️ Carnet de Voyage - Application Flutter

[![Flutter](https://img.shields.io/badge/Flutter-3.38.3-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10.1-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Une application Flutter moderne pour enregistrer et gérer vos activités et sorties avec géolocalisation, météo et photos.

## 📋 Table des matières

- [Aperçu](#-aperçu)
- [Fonctionnalités](#-fonctionnalités)
- [Architecture](#-architecture)
- [Structure du projet](#-structure-du-projet)
- [Technologies utilisées](#-technologies-utilisées)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Utilisation](#-utilisation)
- [APIs et services](#-apis-et-services)
- [Permissions](#-permissions)

## 🎯 Aperçu

**Carnet de Voyage** est une application Flutter développée dans le cadre du projet du cours Flutter. Elle permet aux utilisateurs de documenter leurs sorties et activités en enregistrant des informations détaillées incluant la localisation, la météo, des photos et des notes personnelles.

### Objectif du projet

Développer une application Flutter pour noter toutes les activités/sorties réalisées avec :

- Enregistrement et suppression des sorties avec notes et photos
- Recherche d'informations sur des lieux, villes et météo
- Sélection d'informations selon la géolocalisation
- Notation de lieux (système d'étoiles)

## ✨ Fonctionnalités

### 📱 Écrans principaux

#### 1. **Accueil - Liste des sorties**

- Affichage de toutes les sorties enregistrées
- Cartes interactives pour chaque sortie
- Visualisation rapide : photo, nom, lieu, date, note
- Actions : éditer ou supprimer une sortie
- Navigation fluide vers les autres écrans

#### 2. **Carte interactive**

- Visualisation cartographique avec Flutter Map
- Recherche d'adresses via barre de recherche
- Reverse geocoding : sélection d'un point sur la carte
- Affichage des informations météo en temps réel
- Marqueurs pour les activités enregistrées
- Centrage initial sur Angers, France

#### 3. **Ajouter une sortie**

- Formulaire complet et intuitif
- Champs disponibles :
  - **Nom** : titre de l'activité
  - **Photo** : capture via caméra ou galerie
  - **Adresse** : sélection via carte ou recherche
  - **Date** : sélecteur de date
  - **Commentaire** : notes personnelles
  - **Note** : système d'étoiles (0-5)
- Validation des données
- Sauvegarde locale persistante

#### 4. **Modifier une sortie**

- Modification de toutes les informations d'une sortie existante
- Pré-remplissage du formulaire avec les données actuelles
- Mise à jour en temps réel

### 🎨 Fonctionnalités supplémentaires

- **Thème clair/sombre** : basculement dynamique
- **Design premium** : palette de couleurs nature, typographie Google Fonts
- **Persistance des données** : sauvegarde locale avec SharedPreferences
- **Gestion d'état** : architecture BLoC/Cubit

## 🏗️ Architecture

L'application suit les principes de la **Clean Architecture** pour garantir la maintenabilité, la testabilité et la séparation des responsabilités.

### Principes architecturaux

```
┌─────────────────────────────────────────────────────────────┐
│                     Presentation Layer                       │
│                    (UI + State Management)                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Screens    │  │    Widgets   │  │     BLoC     │      │
│  │              │  │              │  │   (Cubits)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      Domain Layer                            │
│                        (Models)                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Sortie     │  │   Address    │  │ WeatherInfo  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│                     (Repositories)                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Sortie     │  │  GeoCoding   │  │   Weather    │      │
│  │  Repository  │  │  Repository  │  │  Repository  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   External Services                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │SharedPrefs   │  │  Nominatim   │  │OpenWeatherMap│      │
│  │   (Local)    │  │     API      │  │     API      │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

### Couches de l'architecture

#### 1. **Presentation Layer** (`lib/ui/` et `lib/blocs/`)

**Responsabilité** : Gestion de l'interface utilisateur et de l'état de l'application

- **Screens** (`lib/ui/screen/`) : Écrans principaux de l'application

  - `home.dart` : Écran principal avec navigation
  - `add_sortie.dart` : Formulaire d'ajout/modification
  - `map_screen.dart` : Écran carte standalone

- **Views** (`lib/ui/view/`) : Vues réutilisables

  - `home_view.dart` : Vue liste des sorties (accueil)
  - `map_view.dart` : Vue carte intégrée

- **Widgets** (`lib/ui/widget/`) : Composants UI réutilisables

  - Widgets de formulaire (sections, champs)
  - Cartes d'affichage
  - Composants de carte interactive

- **BLoC/Cubit** (`lib/blocs/`) : Gestion d'état avec le pattern BLoC
  - `sortie_cubit.dart` : Gestion des sorties (CRUD)
  - `map_cubit.dart` : Gestion de l'état de la carte
  - `theme_cubit.dart` : Gestion du thème clair/sombre
  - `search_address_cubit.dart` : Gestion de la recherche d'adresses

#### 2. **Domain Layer** (`lib/models/`)

**Responsabilité** : Définition des entités métier et logique de domaine

- `sortie.dart` : Modèle d'une sortie/activité

  - Propriétés : id, nom, adresse, date, note, rating, imageUrl
  - Sérialisation JSON (toJson/fromJson)

- `address.dart` : Modèle d'adresse

  - Propriétés : street, city, postcode, latitude, longitude
  - Factories multiples : fromPlacemark, fromNominatim, fromGeoJson
  - Méthodes utilitaires : toString, shortAddress, formattedCoordinates

- `weather_info.dart` : Modèle d'informations météorologiques
  - Données météo depuis OpenWeatherMap API

#### 3. **Data Layer** (`lib/repositories/`)

**Responsabilité** : Accès aux données et communication avec les services externes

- `sortie_repository.dart` : Persistance locale des sorties

  - Utilise SharedPreferences
  - Méthodes : loadSorties, saveSorties, hasData, clearData
  - Sérialisation/désérialisation JSON

- `geo_coding_repository.dart` : Services de géocodage

  - API : Nominatim (OpenStreetMap)
  - Méthodes :
    - `searchAddresses(query)` : recherche d'adresses
    - `getAddressFromCoordinates(lat, lon)` : reverse geocoding
    - `getCoordinatesFromAddress(address)` : géocodage direct

- `weather_repository.dart` : Services météorologiques

  - API : OpenWeatherMap
  - Méthodes :
    - `getWeatherByCoordinates(lat, lon)` : météo par coordonnées
    - `getWeatherByCity(cityName)` : météo par ville

- `address_repository.dart` : Gestion des adresses

#### 4. **Core Layer** (`lib/core/`)

**Responsabilité** : Éléments transversaux et configuration

- **Theme** (`lib/core/theme/`) : Système de design
  - `app_theme.dart` : Thèmes clair et sombre
  - `app_colors.dart` : Palette de couleurs
  - `app_text_styles.dart` : Styles typographiques
  - `app_spacing.dart` : Espacements et dimensions
  - `app_shadows.dart` : Ombres et élévations
  - `app_theme_extensions.dart` : Extensions de thème

#### 5. **Configuration** (`lib/config/`)

**Responsabilité** : Configuration de l'application

- `api_keys.dart` : Clés API (OpenWeatherMap)

#### 6. **Routing** (`lib/routes/`)

**Responsabilité** : Navigation de l'application

- `routes.dart` : Définition des routes nommées

## 📁 Structure du projet

```
flutter_2025_carnet_voyage/
├── lib/
│   ├── main.dart                      # Point d'entrée de l'application
│   │
│   ├── blocs/                         # Gestion d'état (BLoC/Cubit)
│   │   ├── map_cubit.dart            # État de la carte
│   │   ├── search_address_cubit.dart # Recherche d'adresses
│   │   ├── sortie_cubit.dart         # CRUD des sorties
│   │   └── theme_cubit.dart          # Thème clair/sombre
│   │
│   ├── config/                        # Configuration
│   │   └── api_keys.dart             # Clés API
│   │
│   ├── core/                          # Éléments transversaux
│   │   └── theme/                    # Système de design
│   │       ├── app_colors.dart       # Palette de couleurs
│   │       ├── app_shadows.dart      # Ombres
│   │       ├── app_spacing.dart      # Espacements
│   │       ├── app_text_styles.dart  # Typographie
│   │       ├── app_theme.dart        # Thèmes
│   │       └── app_theme_extensions.dart
│   │
│   ├── models/                        # Modèles de données
│   │   ├── address.dart              # Modèle Adresse
│   │   ├── sortie.dart               # Modèle Sortie
│   │   └── weather_info.dart         # Modèle Météo
│   │
│   ├── repositories/                  # Couche d'accès aux données
│   │   ├── address_repository.dart   # Repository adresses
│   │   ├── geo_coding_repository.dart # Géocodage
│   │   ├── sortie_repository.dart    # Persistance sorties
│   │   └── weather_repository.dart   # API météo
│   │
│   ├── routes/                        # Navigation
│   │   └── routes.dart               # Routes nommées
│   │
│   └── ui/                            # Interface utilisateur
│       ├── screen/                   # Écrans principaux
│       │   ├── add_sortie.dart      # Ajout/modification
│       │   ├── home.dart            # Écran principal
│       │   └── map_screen.dart      # Écran carte
│       │
│       ├── view/                     # Vues réutilisables
│       │   ├── home_view.dart       # Vue liste des sorties
│       │   └── map_view.dart        # Vue carte
│       │
│       └── widget/                   # Composants UI
│           ├── add_sortie_form/     # Widgets formulaire
│           │   ├── address_section.dart
│           │   ├── date_picker_field.dart
│           │   ├── form_card.dart
│           │   ├── photo_picker_section.dart
│           │   ├── rating_input.dart
│           │   └── section_header.dart
│           ├── sortie_marker_widget.dart
│           ├── address_info_widget.dart
│           ├── address_search_bar.dart
│           ├── photo_dialog.dart
│           └── sortie_card.dart
│
├── android/                           # Configuration Android
├── ios/                              # Configuration iOS
├── macos/                            # Configuration macOS
├── web/                              # Configuration Web
├── test/                             # Tests unitaires
│
├── pubspec.yaml                      # Dépendances et métadonnées
├── analysis_options.yaml             # Configuration linter
└── README.md                         # Documentation
```

## 🛠️ Technologies utilisées

### Framework et langage

- **Flutter** : 3.38.3 (Channel stable)
- **Dart SDK** : ^3.10.1

### Packages principaux

#### Gestion d'état

- **flutter_bloc** (^9.1.1) : Pattern BLoC pour la gestion d'état réactive

#### Persistance

- **shared_preferences** (^2.5.3) : Stockage local clé-valeur

#### Cartographie et géolocalisation

- **flutter_map** (^8.2.2) : Affichage de cartes interactives
- **latlong2** (^0.9.1) : Manipulation de coordonnées GPS
- **geolocator** (^14.0.2) : Accès à la position GPS
- **geocoding** (^4.0.0) : Conversion adresses ↔ coordonnées

#### Réseau et APIs

- **http** (^1.2.2) : Requêtes HTTP pour les APIs

#### Interface utilisateur

- **google_fonts** (^6.3.3) : Typographie premium
- **cupertino_icons** (^1.0.8) : Icônes iOS
- **intl** (^0.20.2) : Internationalisation et formatage
- **flutter_localizations** : Support multilingue

#### Médias

- **image_picker** (^1.2.1) : Sélection photos/caméra
- **permission_handler** (^12.0.1) : Gestion des permissions

### APIs externes

#### OpenWeatherMap API

- **Usage** : Récupération des données météorologiques
- **Endpoints** :
  - `/weather` : Météo actuelle par coordonnées ou ville
- **Paramètres** : unités métriques, langue française
- **Documentation** : [openweathermap.org/api](https://openweathermap.org/api)

#### Nominatim API (OpenStreetMap)

- **Usage** : Géocodage et reverse geocoding
- **Endpoints** :
  - `/search` : Recherche d'adresses
  - `/reverse` : Conversion coordonnées → adresse
- **Avantages** : Gratuit, sans clé API, multi-plateforme
- **Documentation** : [nominatim.org](https://nominatim.org)

## 🚀 Installation

### Prérequis

- Flutter SDK 3.38.3 ou supérieur
- Dart SDK 3.10.1 ou supérieur
- Un éditeur (VS Code, Android Studio, IntelliJ)
- Pour iOS : Xcode et CocoaPods
- Pour Android : Android Studio et SDK

### Étapes d'installation

1. **Cloner le repository**

```bash
git clone <repository-url>
cd flutter_2025_carnet_voyage
```

2. **Naviguer vers le projet Flutter**

```bash
cd flutter_2025_carnet_voyage
```

3. **Installer les dépendances**

```bash
flutter pub get
```

4. **Vérifier l'installation**

```bash
flutter doctor
```

5. **Lancer l'application**

```bash
# Sur un émulateur/simulateur
flutter run

# Sur un appareil spécifique
flutter run -d <device-id>

# En mode web
flutter run -d chrome

# En mode web avec port personnalisé
flutter run -d web-server --web-port 8080
```

## ⚙️ Configuration

### Configuration de l'API OpenWeatherMap

1. **Obtenir une clé API**

   - Créez un compte gratuit sur [openweathermap.org](https://openweathermap.org/api)
   - Générez une clé API dans votre dashboard

2. **Configurer la clé dans l'application**
   - Ouvrez le fichier `lib/config/api_keys.dart`
   - Remplacez la valeur de `openWeatherMapApiKey` par votre clé :

```dart
class ApiKeys {
  static const String openWeatherMapApiKey = 'VOTRE_CLE_API_ICI';
  static const String openWeatherMapBaseUrl =
      'https://api.openweathermap.org/data/2.5';
}
```

> ⚠️ **Important** : Ne committez jamais vos vraies clés API dans un repository public ! Cela a été fait sur certains commit du projet car aucun réel impact de coût, mais c'est une mauvaise pratique.

### Configuration des permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSCameraUsageDescription</key>
<string>Cette application a besoin d'accéder à la caméra pour prendre des photos.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Cette application a besoin d'accéder à votre position.</string>
```

## 📖 Utilisation

### Ajouter une sortie

1. Appuyez sur le bouton **+** dans la barre d'application
2. Remplissez le formulaire :
   - **Nom** : Donnez un titre à votre sortie
   - **Photo** : Prenez une photo ou sélectionnez-en une
   - **Adresse** : Recherchez ou sélectionnez sur la carte
   - **Date** : Choisissez la date de la sortie
   - **Commentaire** : Ajoutez vos impressions
   - **Note** : Évaluez votre expérience (0-5 étoiles)
3. Appuyez sur **Enregistrer**

### Modifier une sortie

1. Dans la liste, appuyez sur une carte de sortie
2. Modifiez les informations souhaitées
3. Appuyez sur **Enregistrer**

### Supprimer une sortie

1. Dans la liste, glissez une carte vers la gauche
2. Appuyez sur l'icône de suppression
3. Confirmez la suppression

### Utiliser la carte

1. Accédez à l'onglet **Carte**
2. **Rechercher une adresse** :
   - Utilisez la barre de recherche en haut
   - Sélectionnez un résultat
3. **Sélectionner un point** :
   - Appuyez directement sur la carte
   - L'adresse et la météo s'affichent automatiquement

### Changer de thème

- Appuyez sur l'icône soleil/lune dans la barre d'application
- Le thème bascule entre clair et sombre

## 🔑 APIs et services

### Services utilisés

| Service               | Type  | Usage                   | Authentification   |
| --------------------- | ----- | ----------------------- | ------------------ |
| **Caméra**            | Natif | Capture de photos       | Permission requise |
| **SharedPreferences** | Local | Persistance des données | Aucune             |
| **Nominatim**         | API   | Géocodage               | Aucune             |
| **OpenWeatherMap**    | API   | Météo                   | Clé API requise    |

### Gestion des erreurs API

L'application gère les erreurs suivantes :

- **Erreurs réseau** : Affichage d'un message d'erreur
- **Clé API invalide** : Message explicite pour OpenWeatherMap
- **Adresse non trouvée** : Création d'une adresse temporaire avec coordonnées
- **Météo indisponible** : Continuation sans données météo

## 🔐 Permissions

### Permissions requises

| Permission       | Plateforme   | Usage             | Obligatoire |
| ---------------- | ------------ | ----------------- | ----------- |
| **Caméra**       | iOS, Android | Capture de photos | Oui         |
| **Localisation** | iOS, Android | Géolocalisation   | Non\*       |
| **Internet**     | Toutes       | APIs externes     | Oui         |

\* _La localisation n'est pas obligatoire, l'utilisateur peut sélectionner manuellement une adresse_

### Gestion des permissions

L'application utilise le package `permission_handler` pour :

- Demander les permissions au moment opportun
- Gérer les refus de permissions
- Fournir des alternatives (ex : sélection manuelle d'adresse)

## 📝 Notes de développement

### Bonnes pratiques appliquées

- ✅ **Clean Architecture** : Séparation claire des responsabilités
- ✅ **BLoC Pattern** : Gestion d'état réactive et testable
- ✅ **Dependency Injection** : Repositories fournis via Provider
- ✅ **Immutabilité** : Modèles immutables avec const constructors
- ✅ **Error Handling** : Exceptions personnalisées et gestion d'erreurs
- ✅ **Code Documentation** : Commentaires et documentation Dart
- ✅ **Responsive Design** : Adaptation multi-plateformes
- ✅ **Theming** : Système de design cohérent et personnalisable

---

## Utilisation de l'IA

Les modèles **Claude Opus 4.5** et **Gemini Flash 3.0** ont été utilisés de la manière suivante :

- Auto-complétion de certains commentaires
- Auto-complétion et recommandations de certaines portions de codes "complexes" (ex: stockage des géolocalisations)
- Source de documentation (pour les concepts inconnus)
- Planification des étapes de développement
- Guidage de correctif à appliquer (en cas de bugs)
- Analyse de certaines erreurs et certains warnings
- Rédaction **complète** de l'architecture pour le theming.
- Embelissement du README

> ⚠️ **Important** : Il est nécessaire de rappeler que l'IA a été utilisé ici comme un outil pour accélérer le développement et non pas pour remplacer le développement manuel. Aucune porition du code présent dans cette application n'est incompris et est "bêtement" entièrement généré par IA.

---

## Auteur

- `Kiran BONHOMME`
- `Sitraka RASOLDIER`
