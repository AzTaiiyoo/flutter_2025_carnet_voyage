import 'package:flutter/material.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/home.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/map_screen.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/add_activity.dart';

class Routes {
  static const String home = '/home';
  static const String map = '/map';
  static const String searchAddress = '/search_address';
  static const String addActivity = '/add_activity';

  static Map<String, WidgetBuilder> get allRoutes => {
    home: (_) => const Home(),
    map: (_) => const MapScreen(),
    addActivity: (_) => const AddActivity(),
    //searchAddress: (_) => const SearchAddress(),
  };
}
