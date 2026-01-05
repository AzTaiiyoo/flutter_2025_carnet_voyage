import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/sortie.dart';
import '../repositories/sortie_repository.dart';

class SortieCubit extends Cubit<List<Sortie>> {
  final SortieRepository _repository;

  SortieCubit({required SortieRepository repository})
      : _repository = repository,
        super([]);

  /// Charge les sorties depuis le stockage local.
  Future<void> loadSorties() async {
    final sorties = await _repository.loadSorties();
    emit(sorties);
  }

  Future<void> addSortie(Sortie sortie) async {
    emit([...state, sortie]);
    await _repository.saveSorties(state);
  }

  Future<void> updateSortie(String id, Sortie updatedSortie) async {
    emit(
      state.map((sortie) => sortie.id == id ? updatedSortie : sortie).toList(),
    );
    await _repository.saveSorties(state);
  }

  Future<void> deleteSortie(String id) async {
    emit(state.where((sortie) => sortie.id != id).toList());
    await _repository.saveSorties(state);
  }

  Future<void> clearAllSorties() async {
    emit([]);
    await _repository.clearData();
  }
}

