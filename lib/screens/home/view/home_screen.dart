import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_controller.dart';
import 'package:galaxy_planets/controller/theme_controller.dart';
import 'package:galaxy_planets/screens/favourite/view/favourite_screen.dart';
import 'package:galaxy_planets/utils/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlanetController planetController = Get.put(PlanetController());
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3B55),
        elevation: 8,
        title: const Text('Galaxy Planets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.to(() => const FavouriteScreen()),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Galaxy Planets',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Change Theme'),
              subtitle: Obx(() {
                switch (themeController.themeMode.value) {
                  case ThemeMode.light:
                    return const Text('Current: Light Theme');
                  case ThemeMode.dark:
                    return const Text('Current: Dark Theme');
                  default:
                    return const Text('Current: System Theme');
                }
              }),
              onTap: () {
                _showThemeDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (planetController.planets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.only(top: 20, right: 16),
          child: ListView.builder(
            itemCount: planetController.planets.length,
            itemBuilder: (context, index) {
              final planet = planetController.planets[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(vertical: 20),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  leading: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.detail, arguments: index);
                    },
                    child: Hero(
                      tag: 'a1_$index',
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            planet['image'],
                          )),
                    ),
                  ),
                  title: Text(planet['name']),
                  trailing: Obx(() => IconButton(
                        icon: Icon(
                          planetController.favorites.contains(planet['name'])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          // color: planetController.favorites
                          //         .contains(planet['name'])
                          //     ? Colors.red
                          //     : Colors.white,
                        ),
                        onPressed: () =>
                            planetController.toggleFavorite(planet['name']),
                      )),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(planet['description']),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('Light Theme'),
                value: ThemeMode.light,
                groupValue: themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    themeController.setTheme(value);
                    Get.back();
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark Theme'),
                value: ThemeMode.dark,
                groupValue: themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    themeController.setTheme(value);
                    Get.back();
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('System Theme'),
                value: ThemeMode.system,
                groupValue: themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    themeController.setTheme(value);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
