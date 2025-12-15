import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_2025_carnet_voyage/models/address.dart';
import 'package:flutter_2025_carnet_voyage/models/weather_info.dart';
import 'package:flutter_2025_carnet_voyage/repositories/geo_coding_repository.dart';
import 'package:flutter_2025_carnet_voyage/repositories/weather_repository.dart';

/// État de la carte
class MapState {
  final LatLng currentPosition;
  final Address? selectedAddress;
  final WeatherInfo? weather;
  final bool isLoading;
  final String? errorMessage;
  final List<Address> searchResults;

  const MapState({
    required this.currentPosition,
    this.selectedAddress,
    this.weather,
    this.isLoading = false,
    this.errorMessage,
    this.searchResults = const [],
  });

  /// État initial centré sur Angers
  factory MapState.initial() {
    return MapState(
      currentPosition: LatLng(47.466671, -0.55), // Angers
    );
  }

  /// Copie de l'état avec modifications
  MapState copyWith({
    LatLng? currentPosition,
    Address? selectedAddress,
    WeatherInfo? weather,
    bool? isLoading,
    String? errorMessage,
    List<Address>? searchResults,
    bool clearAddress = false,
    bool clearWeather = false,
    bool clearError = false,
  }) {
    return MapState(
      currentPosition: currentPosition ?? this.currentPosition,
      selectedAddress: clearAddress
          ? null
          : (selectedAddress ?? this.selectedAddress),
      weather: clearWeather ? null : (weather ?? this.weather),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      searchResults: searchResults ?? this.searchResults,
    );
  }

  /// Vérifie si une adresse est sélectionnée
  bool get hasSelectedAddress => selectedAddress != null;

  /// Vérifie si la météo est disponible
  bool get hasWeather => weather != null;
}

/// Cubit pour gérer l'état de la carte
class MapCubit extends Cubit<MapState> {
  final GeoCodingRepository _geoCodingRepository;
  final WeatherRepository _weatherRepository;

  MapCubit({
    required GeoCodingRepository geoCodingRepository,
    required WeatherRepository weatherRepository,
  }) : _geoCodingRepository = geoCodingRepository,
       _weatherRepository = weatherRepository,
       super(MapState.initial());

  /// Recherche d'adresses
  Future<void> searchAddresses(String query) async {
    if (query.trim().isEmpty) {
      emit(state.copyWith(searchResults: []));
      return;
    }

    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final List<Address> results = await _geoCodingRepository.searchAddresses(
        query,
      );
      emit(state.copyWith(searchResults: results, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Erreur lors de la recherche: $e',
          searchResults: [],
        ),
      );
    }
  }

  /// Sélection d'une adresse (depuis la recherche ou un clic sur la carte)
  Future<void> selectAddress(Address address) async {
    if (!address.hasCoordinates) {
      emit(
        state.copyWith(errorMessage: 'Cette adresse n\'a pas de coordonnées'),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        selectedAddress: address,
        currentPosition: LatLng(address.latitude!, address.longitude!),
        searchResults: [], // Clear search results after selection
      ),
    );

    // Récupérer la météo pour cette adresse
    await _fetchWeather(address.latitude!, address.longitude!);
  }

  /// Clic sur la carte : convertit les coordonnées en adresse
  Future<void> onMapTap(LatLng position) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        currentPosition: position,
        clearAddress: true,
        clearWeather: true,
      ),
    );

    try {
      // Reverse geocoding pour obtenir l'adresse
      final Address? address = await _geoCodingRepository
          .getAddressFromCoordinates(
            latitude: position.latitude,
            longitude: position.longitude,
          );

      if (address != null) {
        emit(state.copyWith(selectedAddress: address, isLoading: false));

        // Récupérer la météo
        await _fetchWeather(position.latitude, position.longitude);
      } else {
        // Créer une adresse temporaire avec seulement les coordonnées
        final Address tempAddress = Address(
          city: 'Position sélectionnée',
          postcode: '',
          latitude: position.latitude,
          longitude: position.longitude,
        );
        emit(state.copyWith(selectedAddress: tempAddress, isLoading: false));

        await _fetchWeather(position.latitude, position.longitude);
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Erreur lors de la récupération de l\'adresse: $e',
        ),
      );
    }
  }

  /// Récupère la météo pour les coordonnées données
  Future<void> _fetchWeather(double latitude, double longitude) async {
    try {
      final WeatherInfo weather = await _weatherRepository
          .getWeatherByCoordinates(latitude: latitude, longitude: longitude);
      emit(state.copyWith(weather: weather, isLoading: false));
    } catch (e) {
      // En cas d'erreur météo, on continue sans météo
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Impossible de récupérer la météo',
        ),
      );
    }
  }

  /// Déplace la carte vers une position
  void moveToPosition(LatLng position) {
    emit(state.copyWith(currentPosition: position));
  }

  /// Efface l'erreur
  void clearError() {
    emit(state.copyWith(clearError: true));
  }

  /// Efface la sélection
  void clearSelection() {
    emit(
      state.copyWith(clearAddress: true, clearWeather: true, searchResults: []),
    );
  }
}
