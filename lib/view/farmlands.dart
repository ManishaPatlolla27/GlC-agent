import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../page_routing/app_routes.dart';
import 'farmlanddetails.dart';

class Farmlands extends StatefulWidget {
  const Farmlands({super.key});

  @override
  State<Farmlands> createState() => _FarmLandState();
}

class _FarmLandState extends State<Farmlands> {
  final List<String> carouselImages = [
    'assets/farmland.png',
    'assets/farmland.png',
    'assets/farmland.png',
  ];

  final List<String> farmlandImages = [
    'assets/farmland.png',
    'assets/farmland.png',
    'assets/farmland.png',
  ];

  int _currentIndex = 0;

  Set<int> wishlist = {};

  void toggleWishlist(int index) {
    setState(() {
      if (wishlist.contains(index)) {
        wishlist.remove(index);
      } else {
        wishlist.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extends body behind status bar
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false, // Allows content to extend into the status bar
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Background
              Stack(
                children: [
                  Container(
                    height: 350, // Ensure it covers the status bar
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bgframland.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context)
                                .padding
                                .top), // Adjust for status bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Farmlands',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.search);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: Icon(Icons.search,
                                    color: Color(0xFF8280FF)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Carousel Slider
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 180,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: carouselImages.map((imagePath) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PendingFarmlanddetailsScreen(),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Image.asset(imagePath,
                                        fit: BoxFit.cover,
                                        width: double.infinity),
                                    const Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'The Most Searched Farmland',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('GLCSOS 01',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text('East Godavari, AP',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.arrow_outward,
                                            color: Color(0xFF8280FF)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            carouselImages.length,
                            (index) => Container(
                              width: 6.0,
                              height: 6.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Farmlands',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: farmlandImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PendingFarmlanddetailsScreen(),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                farmlandImages[index],
                                fit: BoxFit.cover,
                                width: 132,
                                height: 156,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('GLCSOS 002',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const Text('₹15L',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Farmlands',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: farmlandImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PendingFarmlanddetailsScreen(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  farmlandImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 160,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => toggleWishlist(index),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 14, // Reduced size
                                    child: Icon(
                                      wishlist.contains(index)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: wishlist.contains(index)
                                          ? const Color(0xFF8280FF)
                                          : Colors.grey,
                                      size: 16, // Reduced icon size
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GLCSOS 002',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text('₹15L',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('East Godavari, AP',
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Popular',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: farmlandImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PendingFarmlanddetailsScreen(),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                farmlandImages[index],
                                fit: BoxFit.cover,
                                width: 132,
                                height: 156,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text('GLCSOS 002',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('₹15L', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
