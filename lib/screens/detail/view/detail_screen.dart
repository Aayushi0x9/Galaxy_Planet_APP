import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_controller.dart';
import 'package:galaxy_planets/screens/favourite/view/favourite_screen.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? slideAnimation;
  late LiquidController liquidController;

  PlanetController planetController = Get.find();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller!.forward();
    liquidController = LiquidController();

    slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller!, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    int initialIndex = Get.arguments ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Planet Details"),
        backgroundColor: const Color(0xFF2E3B55),
        elevation: 8,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.to(() => const FavouriteScreen()),
          ),
        ],
      ),
      body: LiquidSwipe.builder(
        itemCount: planetController.planets.length,
        liquidController: liquidController,
        enableLoop: false,
        initialPage: initialIndex,
        positionSlideIcon: 0.8,
        waveType: WaveType.liquidReveal,
        itemBuilder: (context, index) {
          final planet = planetController.planets[index];
          return buildPlanetPage(planet, index);
        },
      ),
    );
  }

  Widget buildPlanetPage(Map<String, dynamic> planet, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                index.isEven ? 'assets/images/1.jpg' : 'assets/images/2.jpg'),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Planet image with rotation
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                AnimatedBuilder(
                  animation: controller!,
                  builder: (context, child) {
                    return AnimatedRotation(
                      duration: Duration.zero,
                      turns: controller!.value,
                      child: Hero(
                        tag: 'a1_$index',
                        child: Image.network(
                          planet['image'],
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
                Obx(() => IconButton(
                      icon: Icon(
                        planetController.favorites.contains(planet['name'])
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () =>
                          planetController.toggleFavorite(planet['name']),
                    )),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),

            // Slide Transition for information section
            SlideTransition(
              position: slideAnimation!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPlanetInfoCard(planet['name'], 24, FontWeight.bold),
                  const SizedBox(height: 8),
                  buildPlanetInfoCard(
                      'Position: ${planet['position']}', 18, FontWeight.normal),
                  const SizedBox(height: 8),
                  buildPlanetInfoCard(
                      'Distance from Sun: ${planet['distance']} million km',
                      18,
                      FontWeight.normal),
                  const SizedBox(height: 8),
                  buildPlanetInfoCard(
                      'Orbital Velocity: ${planet['velocity']} km/s',
                      18,
                      FontWeight.normal),
                  const SizedBox(height: 16),
                  buildPlanetInfoCard(
                      planet['description'], 16, FontWeight.normal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create the info cards with a professional look
  Widget buildPlanetInfoCard(
      String text, double fontSize, FontWeight fontWeight) {
    return Card(
      color: Colors.grey.shade800,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: Colors.white) // Dark text color for contrast
            ),
      ),
    );
  }
}
