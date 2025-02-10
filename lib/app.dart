import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/theme_controller.dart';
import 'package:galaxy_planets/utils/routes/app_routes.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.themeMode.value,
        routes: AppRoutes.routes,
      );
    });
  }
}
