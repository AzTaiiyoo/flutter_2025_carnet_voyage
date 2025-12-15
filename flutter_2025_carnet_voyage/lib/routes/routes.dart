import 'package:flutter/cupertino.dart';


class Routes {
  static const String home = '/home';
  static const String addCompany = '/add_company';
  static const String searchAddress = '/search_address';

  static Map<String, WidgetBuilder> get allRoutes => {
    //home: (_) => const Home(),
    //addCompany: (_) => const AddCompany(),
    //searchAddress: (_) => const SearchAddress(),
  };
}