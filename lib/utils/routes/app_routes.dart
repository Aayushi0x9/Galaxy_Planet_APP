import 'package:flutter/material.dart';
import 'package:galaxy_planets/screens/detail/view/detail_screen.dart';
import 'package:galaxy_planets/screens/favourite/view/favourite_screen.dart';
import 'package:galaxy_planets/screens/home/view/home_screen.dart';
import 'package:galaxy_planets/screens/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = 'home';
  // static const String home = '/';
  static const String detail = '/detail';
  static const String fav = '/fav';

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.detail: (context) => const DetailScreen(),
    AppRoutes.fav: (context) => const FavouriteScreen()
  };
}
