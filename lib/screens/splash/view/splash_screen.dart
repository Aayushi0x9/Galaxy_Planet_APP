import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_controller.dart';
import 'package:galaxy_planets/screens/home/view/home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      final planetController = Get.put(PlanetController());
      await planetController.loadPlanets();
      await planetController.loadFavorites();
      Get.off(() => const HomeScreen());
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'Galaxy Planets',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
