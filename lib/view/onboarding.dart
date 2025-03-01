import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nex2u/models/welcomescreen/WelcomeScreenResponse.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/viewModel/welcome_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  List<WelcomeScreens> carouselImages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<WelcomeViewModel>(context, listen: false);
      await provider.welcome(context);
      carouselImages = provider.dashboardresponse?.welcomeScreens ?? [];
    });
  }

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
    final welcomeViewModel = Provider.of<WelcomeViewModel>(context);

    // if (response == null || response.welcomeScreens == null) {
    //   return const Center(child: CircularProgressIndicator());
    // }

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
                  Image.network(
                    carouselImages[index].imageUrl.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/logo.png"),
                  ),
                  // Overlay Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.7), // ✅ Fixed
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
                          carouselImages[index].title.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          carouselImages[index].description.toString(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9), // ✅ Fixed
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
                        : Colors.white.withOpacity(0.4), // ✅ Fixed
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
