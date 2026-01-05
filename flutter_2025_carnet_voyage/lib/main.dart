import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_2025_carnet_voyage/routes/routes.dart';
import 'package:flutter_2025_carnet_voyage/blocs/sortie_cubit.dart';
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/blocs/theme_cubit.dart';
import 'package:flutter_2025_carnet_voyage/repositories/geo_coding_repository.dart';
import 'package:flutter_2025_carnet_voyage/repositories/weather_repository.dart';
import 'package:flutter_2025_carnet_voyage/core/theme/app_theme.dart';
import 'package:flutter_2025_carnet_voyage/repositories/sortie_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Création des repositories (peuvent être partagés)
    const GeoCodingRepository geoCodingRepository = GeoCodingRepository();
    const WeatherRepository weatherRepository = WeatherRepository();
    final SortieRepository sortieRepository = SortieRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeoCodingRepository>.value(
          value: geoCodingRepository,
        ),
        RepositoryProvider<WeatherRepository>.value(value: weatherRepository),
        RepositoryProvider<SortieRepository>.value(value: sortieRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          // Cubit pour les sorties (liste) avec persistance
          BlocProvider<SortieCubit>(
            create: (context) =>
                SortieCubit(repository: sortieRepository)..loadSorties(),
          ),
          // Cubit pour la carte
          BlocProvider<MapCubit>(
            create: (context) => MapCubit(
              geoCodingRepository: geoCodingRepository,
              weatherRepository: weatherRepository,
            ),
          ),
          // Cubit pour le thème
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        ],
        // BlocBuilder pour reconstruire MaterialApp quand le thème change
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'Carnet de Voyage',
              debugShowCheckedModeBanner: false,

              // Localisations
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('fr', 'FR'), Locale('en', 'US')],
              locale: const Locale('fr', 'FR'),

              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeMode,
              routes: Routes.allRoutes,
              initialRoute: Routes.home,
            );
          },
        ),
      ),
    );
  }
}
