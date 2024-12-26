import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3B55),
        elevation: 8,
        title: Text('Galaxy Planets'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Get.to(() => FavouriteScreen()),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Obx(() {
        if (planetController.planets.isEmpty) {
          return Center(child: CircularProgressIndicator());
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
                  tilePadding: EdgeInsets.symmetric(vertical: 20),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  leading: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.detail, arguments: index);
                    },
                    child: Hero(
                      tag: 'a1',
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
                          color: planetController.favorites
                                  .contains(planet['name'])
                              ? Colors.red
                              : Colors.white,
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
}
