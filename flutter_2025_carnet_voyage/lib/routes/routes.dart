import 'package:flutter/cupertino.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/map_screen.dart';
import 'package:flutter_2025_carnet_voyage/ui/screen/home.dart';

class Routes {
  static const String home = '/home';
  static const String map = '/map';
  static const String searchAddress = '/search_address';

  static Map<String, WidgetBuilder> get allRoutes => {
    home: (_) => const Home(),
    map: (_) => const MapScreen(),
    //searchAddress: (_) => const SearchAddress(),
  };
}
