import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> carouselImages = [
    'assets/slider1.png',
    'assets/slider2.png',
    'assets/slider3.png',
  ];

  final List<String> titles = [
    'Smart\nGrowth',
    'Lead Learn\nGrow Achieve',
    'Stay\nMotivated',
  ];

  final List<String> descriptions = [
    'Set a goal based on how active you are,\nor how active you’d like to be, each day.',
    'Keep learning and pushing forward.\nAchieve your goals with consistency.',
    'Stay inspired with personalized tips\nand reminders to keep going.',
  ];

  void _onNextPressed() {
    if (_currentIndex < carouselImages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image Carousel
          CarouselSlider.builder(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              autoPlay: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemCount: carouselImages.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    carouselImages[index],
                    fit: BoxFit.cover,
                  ),
                  // Overlay Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Title & Description
                  Positioned(
                    bottom: 200,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          descriptions[index],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Top Progress Indicators
          Positioned(
            top: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(carouselImages.length, (index) {
                return Container(
                  width: 90,
                  height: 4,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),

          // Bottom Navigation
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Next Button
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF8280FF),
                  ),
                  child: IconButton(
                    onPressed: _onNextPressed,
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
