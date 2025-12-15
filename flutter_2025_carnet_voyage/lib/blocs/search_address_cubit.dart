import 'package:flutter_2025_carnet_voyage/models/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_2025_carnet_voyage/blocs/sortie_cubit.dart';

class SearchAddressCubit extends Cubit<List<Address>> {
  SearchAddressCubit() : super([]);

  final SortieCubit sortieCubit = SortieCubit();

  void loadAddresses(List<Address> addresses) {
    emit(addresses);
  }

  void updateLocation(List<Address> newLocation) {
    emit(newLocation);
  }
}
