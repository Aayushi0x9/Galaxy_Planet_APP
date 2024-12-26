import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetController extends GetxController {
  RxList<String> favorites = <String>[].obs;
  RxList<Map<String, dynamic>> planets = <Map<String, dynamic>>[].obs;

  Future<void> loadPlanets() async {
    final String response =
        await rootBundle.loadString('assets/data/planet.json');
    final data = json.decode(response) as List;
    planets.value = data.map((e) => e as Map<String, dynamic>).toList();
  }

  Future<void> toggleFavorite(String planetName) async {
    if (favorites.contains(planetName)) {
      favorites.remove(planetName);
    } else {
      favorites.add(planetName);
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favorites);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favorites.value = prefs.getStringList('favorites') ?? [];
  }
}
