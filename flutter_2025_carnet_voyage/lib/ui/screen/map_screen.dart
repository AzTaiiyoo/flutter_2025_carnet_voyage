import 'package:flutter/material.dart';
import 'package:flutter_2025_carnet_voyage/ui/view/map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return MapView();
  }
}
