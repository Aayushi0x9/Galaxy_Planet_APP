import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_controller.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  PlanetController planetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Planets'),
        backgroundColor: const Color(0xFF2E3B55), // Deep blue for dark theme
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Obx(() {
        if (planetController.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.favorite_border, size: 100, color: Colors.grey),
                SizedBox(height: 20),
                Text(
                  'No favorites yet!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: planetController.favorites.length,
          itemBuilder: (context, index) {
            final planetName = planetController.favorites[index];
            final planet = planetController.planets.firstWhere(
              (p) => p['name'] == planetName,
            );

            if (planet == null) return const SizedBox();

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: const Color(0xFF1C1E26),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(planet['image']),
                  radius: 30,
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  planet['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  planet['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.redAccent),
                  onPressed: () =>
                      planetController.toggleFavorite(planet['name']),
                ),
                onTap: () {
                  Get.toNamed('/detail',
                      arguments: planetController.planets
                          .indexWhere((p) => p['name'] == planet['name']));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
