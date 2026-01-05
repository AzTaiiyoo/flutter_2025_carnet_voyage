import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  void setThemeMode(ThemeMode mode) {
    emit(mode);
  }

  void setLightMode() => emit(ThemeMode.light);
  void setDarkMode() => emit(ThemeMode.dark);
  void setSystemMode() => emit(ThemeMode.system);

  bool get isDarkMode => state == ThemeMode.dark;
  bool get isLightMode => state == ThemeMode.light;
  bool get isSystemMode => state == ThemeMode.system;
}
