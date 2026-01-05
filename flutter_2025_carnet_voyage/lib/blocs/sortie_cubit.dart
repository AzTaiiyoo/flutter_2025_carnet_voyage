import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/sortie.dart';
import '../models/address.dart';

class SortieCubit extends Cubit<List<Sortie>> {
  SortieCubit() : super(_getDefaultSorties());

  static List<Sortie> _getDefaultSorties() {
    return [
      Sortie(
        id: '1',
        name: 'Tour Eiffel',
        address: Address(
          street: 'Champ de Mars',
          city: 'Paris',
          postcode: '75007',
        ),
        date: DateTime(2024, 12, 10),
        note:
            'Magnifique vue sur Paris ! Un incontournable de la capitale française.',
        rating: 5.0,
        imageUrl: null,
      ),
      Sortie(
        id: '2',
        name: 'Mont Saint-Michel',
        address: Address(
          street: null,
          city: 'Le Mont-Saint-Michel',
          postcode: '50170',
        ),
        date: DateTime(2024, 11, 15),
        note:
            'Architecture médiévale impressionnante. Les marées sont spectaculaires.',
        rating: 4.8,
        imageUrl: null,
      ),
      Sortie(
        id: '3',
        name: 'Château de Versailles',
        address: Address(
          street: 'Place d\'Armes',
          city: 'Versailles',
          postcode: '78000',
        ),
        date: DateTime(2024, 10, 20),
        note:
            'Le château et ses jardins sont somptueux. Prévoir une journée complète.',
        rating: 4.9,
        imageUrl: null,
      ),
      Sortie(
        id: '4',
        name: 'Calanques de Cassis',
        address: Address(
          street: 'Port de Cassis',
          city: 'Cassis',
          postcode: '13260',
        ),
        date: DateTime(2024, 9, 5),
        note:
            'Eau turquoise et falaises magnifiques. Parfait pour la randonnée.',
        rating: 4.7,
        imageUrl: null,
      ),
      Sortie(
        id: '5',
        name: 'Strasbourg - Petite France',
        address: Address(
          street: 'Quartier de la Petite France',
          city: 'Strasbourg',
          postcode: '67000',
        ),
        date: DateTime(2024, 8, 12),
        note: 'Charmant quartier avec ses maisons à colombages et canaux.',
        rating: 4.6,
        imageUrl: null,
      ),
    ];
  }

  void addSortie(Sortie sortie) {
    emit([...state, sortie]);
  }

  void updateSortie(String id, Sortie updatedSortie) {
    emit(
      state.map((sortie) => sortie.id == id ? updatedSortie : sortie).toList(),
    );
  }

  void deleteSortie(String id) {
    emit(state.where((sortie) => sortie.id != id).toList());
  }

  void clearAllSorties() {
    emit([]);
  }

  void resetToDefault() {
    emit(_getDefaultSorties());
  }
}
