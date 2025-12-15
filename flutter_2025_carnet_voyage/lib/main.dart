import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_2025_carnet_voyage/routes/routes.dart';
import 'package:flutter_2025_carnet_voyage/blocs/sortie_cubit.dart';
import 'package:flutter_2025_carnet_voyage/blocs/map_cubit.dart';
import 'package:flutter_2025_carnet_voyage/repositories/geo_coding_repository.dart';
import 'package:flutter_2025_carnet_voyage/repositories/weather_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Création des repositories (peuvent être partagés)
    const GeoCodingRepository geoCodingRepository = GeoCodingRepository();
    const WeatherRepository weatherRepository = WeatherRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeoCodingRepository>.value(
          value: geoCodingRepository,
        ),
        RepositoryProvider<WeatherRepository>.value(
          value: weatherRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Cubit pour les sorties (liste)
          BlocProvider<SortieCubit>(
            create: (context) => SortieCubit(),
          ),
          // Cubit pour la carte
          BlocProvider<MapCubit>(
            create: (context) => MapCubit(
              geoCodingRepository: geoCodingRepository,
              weatherRepository: weatherRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Carnet de Voyage',
          debugShowCheckedModeBanner: false,

          // Localisations
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr', 'FR'),
            Locale('en', 'US'),
          ],
          locale: const Locale('fr', 'FR'),

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            useMaterial3: true,
          ),
          routes: Routes.allRoutes,
          initialRoute: Routes.home,
        ),
      ),
    );
  }
}
