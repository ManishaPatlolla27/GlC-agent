import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/view/search.dart';

class PendingFarmlanddetailsScreen extends StatefulWidget {
  const PendingFarmlanddetailsScreen({super.key});

  @override
  FarmlandsScreenState createState() => FarmlandsScreenState();
}

int _currentIndex = 0;
final List<String> _imageUrls = [
  'assets/farmland.png',
  'assets/farmland.png',
  'assets/farmland.png',
];

class FarmlandsScreenState extends State<PendingFarmlanddetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          // Carousel Slider for images
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 360,
                              autoPlay: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: _imageUrls.map((imagePath) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Dots Indicator
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _imageUrls.asMap().entries.map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == entry.key
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          // Back Button & Title
                          Positioned(
                            top: 40,
                            left: 16,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const Text(
                                  "Farmlands",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),

                          // Favorite Icon
                          const Positioned(
                            top: 50,
                            right: 16,
                            child: Icon(Icons.favorite_border,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Farmland Details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Section
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "GLCSOS 02",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.grey, size: 16),
                                          SizedBox(width: 4),
                                          Text("East Godavari, AP",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Searchlands(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF8280FF),
                                      side:
                                          const BorderSide(color: Color(0xFF8280FF)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: const Text("Compare"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Key Features Section
                        _buildCardSection("Key Feature:", [
                          _buildInfoRow("Land Extend:", "150 Acres"),
                          _buildDivider(),
                          _buildInfoRow("Road Approach", "50 Meters"),
                          _buildDivider(),
                          _buildInfoRow("Electricity Connection", "3 Phase"),
                          _buildDivider(),
                          _buildInfoRow("Water Facility", "Bore (100 Meters)"),
                        ]),

                        // Facilities Section
                        _buildCardSection("Facilities:", [
                          _buildFacilityRow("Railway Facility", true),
                          _buildDivider(),
                          _buildFacilityRow("Airport Facility", true),
                          _buildDivider(),
                          _buildFacilityRow("Hospitals", true),
                          _buildDivider(),
                          _buildFacilityRow("Ground Water", false),
                        ]),

                        // Cultivation Section
                        _buildCardSection("Cultivations:", [
                          _buildInfoRow("Current Cultivation", "Rice"),
                          _buildDivider(),
                          _buildInfoRow(
                              "Types of Crops can be Grown", "Rice, Cotton"),
                          _buildDivider(),
                          _buildInfoRow(
                              "Future Crops Suggestions", "Sugar Cane"),
                          _buildDivider(),
                          _buildInfoRow("Soil Type", "Alfisol (Black Soil)"),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Cost Section with Button
          Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            elevation: 4,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cost:",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(
                        "₹2,50,00,000.00 / acre",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.buyer);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8280FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text("Send Leads",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for Info Row
  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
          Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Helper function for Facility Row
  Widget _buildFacilityRow(String title, bool isAvailable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
          Icon(
            isAvailable ? Icons.check : Icons.close,
            color: isAvailable ? Colors.green : Colors.red,
            size: 18,
          ),
        ],
      ),
    );
  }

  // Card Section for Key Features, Facilities, Cultivations
  Widget _buildCardSection(String title, List<Widget> children) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.add),
              ],
            ),
            const SizedBox(height: 8),
            Column(children: children),
          ],
        ),
      ),
    );
  }

  // Divider Line
  Widget _buildDivider() {
    return Divider(color: Colors.grey[300], thickness: 1);
  }
}
