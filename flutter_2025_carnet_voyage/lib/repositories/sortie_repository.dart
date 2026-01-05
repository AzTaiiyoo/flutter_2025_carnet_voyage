import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sortie.dart';


class SortieRepository {
  static const String _storageKey = 'sorties_list';

  Future<List<Sortie>> loadSorties() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => Sortie.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveSorties(List<Sortie> sorties) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        sorties.map((sortie) => sortie.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    await prefs.setString(_storageKey, jsonString);
  }

  Future<bool> hasData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_storageKey);
  }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
