import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const _themeKey = 'theme_mode';
  late Rx<ThemeMode> themeMode;

  @override
  void onInit() {
    super.onInit();
    themeMode = ThemeMode.system.obs; // Default to system theme
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString(_themeKey);

    if (theme != null) {
      themeMode.value = ThemeMode.values.firstWhere(
        (e) => e.toString() == theme,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    themeMode.value = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
  }
}
