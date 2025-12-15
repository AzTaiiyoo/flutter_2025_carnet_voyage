import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLocationCubit extends Cubit<String> {
  SearchLocationCubit() : super('');

  void updateLocation(String newLocation) {
    emit(newLocation);
  }
}
