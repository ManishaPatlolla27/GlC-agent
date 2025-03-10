import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/viewModel/farm_details_view_model.dart';
import 'package:provider/provider.dart';

import '../models/farmlands/farm_details_response.dart';
import '../viewModel/fav_view_model.dart';

class PendingFarmlanddetailsScreen extends StatefulWidget {
  const PendingFarmlanddetailsScreen({super.key});

  @override
  FarmlandsScreenState createState() => FarmlandsScreenState();
}

String? farmid = "";
int _currentIndex = 0;

class FarmlandsScreenState extends State<PendingFarmlanddetailsScreen> {
  List<Features> farmlandSections = [];
  FarmDetailsResponse? farmDetailsResponse;
  late List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    loadFarmlands();
  }

  void toggleWishlist(bool value) async {
    final favProvider = Provider.of<FavViewModel>(context, listen: false);
    setState(() {
      favProvider.togglefav(
          farmDetailsResponse!.farmlandId!.toInt(), value, context);
    });
  }

  FlutterSecureStorage storage = FlutterSecureStorage(); // Initialize once

  Future<void> loadFarmlands() async {
    farmid = await storage.read(key: "farmid");
    print(farmid);

    if (farmid == null) return; // Ensure seeall is not null before proceeding

    final provider = Provider.of<FarmDetailsViewModel>(context, listen: false);
    await provider.getfarmdetails(context, farmid!);

    if (!mounted) return; // Prevent calling setState on an unmounted widget

    setState(() {
      farmDetailsResponse = provider.trackFarmlandResponse!;
      farmlandSections = provider.trackFarmlandResponse?.features ?? [];
      _imageUrls = provider.trackFarmlandResponse?.farmlandImages ?? [];
    });
  }

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
                            items: _imageUrls.map((imageUrl) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    // Changed from AssetImage to NetworkImage
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                          Positioned(
                            top: 60,
                            right: 15,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  toggleWishlist(
                                      !(farmDetailsResponse?.isFavorite ??
                                          false));
                                  farmDetailsResponse?.isFavorite =
                                      !(farmDetailsResponse?.isFavorite ??
                                          false);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child:
                                    getFavoriteIcon(), // Using the function here
                              ),
                            ),
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        farmDetailsResponse?.farmlandCode ??
                                            "".toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: Colors.grey, size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                              farmDetailsResponse?.areaName ??
                                                  "".toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (storage.read(key: "compare") == "") {
                                        await storage.write(
                                            key: 'farmid',
                                            value: farmDetailsResponse
                                                ?.farmlandId
                                                .toString());
                                        await storage.write(
                                            key: 'code',
                                            value: farmDetailsResponse
                                                ?.farmlandCode
                                                .toString());
                                        await storage.write(
                                            key: 'area',
                                            value: farmDetailsResponse?.areaName
                                                .toString());
                                        await storage.write(
                                          key: 'cost',
                                          value:
                                              "₹${farmDetailsResponse?.landCost?.toString() ?? 'N/A'} / acre",
                                        );
                                        await storage.write(
                                            key: 'image',
                                            value: farmDetailsResponse!
                                                .farmlandImages![0]
                                                .toString());
                                        if (storage.read(key: "code") != "" &&
                                            storage.read(key: "code1") != "") {
                                          Navigator.pushNamed(
                                              context, AppRoutes.compareboth);
                                        } else {
                                          Navigator.pushNamed(
                                              context, AppRoutes.compareadd);
                                        }
                                      } else {
                                        await storage.write(
                                            key: 'farmid1',
                                            value: farmDetailsResponse
                                                ?.farmlandId
                                                .toString());
                                        await storage.write(
                                            key: 'code1',
                                            value: farmDetailsResponse
                                                ?.farmlandCode
                                                .toString());
                                        await storage.write(
                                            key: 'area1',
                                            value: farmDetailsResponse?.areaName
                                                .toString());
                                        await storage.write(
                                          key: 'cost1',
                                          value:
                                              "₹${farmDetailsResponse?.landCost?.toString() ?? 'N/A'} / acre",
                                        );
                                        await storage.write(
                                            key: 'image1',
                                            value: farmDetailsResponse!
                                                .farmlandImages![0]
                                                .toString());
                                        if (storage.read(key: "code") != "" &&
                                            storage.read(key: "code1") != "") {
                                          Navigator.pushNamed(
                                              context, AppRoutes.compareboth);
                                        } else {
                                          Navigator.pushNamed(
                                              context, AppRoutes.compareadd);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF8280FF),
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          color: Color(0xFF8280FF)),
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

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // **Dynamic Sections**
                              ...farmlandSections.map((feature) {
                                return _buildCardSection(
                                  feature.title ?? "Unknown",
                                  feature.details ?? [],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cost:",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(
                        "₹${farmDetailsResponse?.landCost?.toString() ?? 'N/A'} / acre",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await storage.write(
                          key: 'farmid',
                          value: farmDetailsResponse?.farmlandId.toString());
                      Navigator.pushNamed(context, AppRoutes.buyer);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8280FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
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
          Text(title,
              style: const TextStyle(fontSize: 14, color: Colors.black)),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
          Text(title,
              style: const TextStyle(fontSize: 14, color: Colors.black)),
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
  Widget _buildCardSection(String title, List<Details> details) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: details.asMap().entries.map((entry) {
                int index = entry.key;
                Details detail = entry.value;
                Widget row;

                if (detail.value == "true") {
                  row = _buildFacilityRow(detail.title.toString(), true);
                } else if (detail.value == "false") {
                  row = _buildFacilityRow(detail.title.toString(), false);
                } else {
                  row = _buildInfoRow(
                      detail.title.toString(), detail.value.toString());
                }

                return Column(
                  children: [
                    row,
                    if (index != details.length - 1)
                      const Divider(), // Add line except for the last item
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFavoriteIcon() {
    if (farmDetailsResponse?.isFavorite == true) {
      return const Icon(
        Icons.favorite,
        color: Color(0xFF8280FF),
        size: 16,
      );
    } else {
      return const Icon(
        Icons.favorite_border,
        size: 16,
      );
    }
  }
}
