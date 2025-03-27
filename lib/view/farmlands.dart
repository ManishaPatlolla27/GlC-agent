import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/view/search.dart';
import 'package:nex2u/viewModel/discovery_view_model.dart';
import 'package:provider/provider.dart';

import '../models/discovery/discovery_response.dart';
import '../page_routing/app_routes.dart';
import '../viewModel/fav_view_model.dart';
import 'farmlanddetails.dart';

class Farmlands extends StatefulWidget {
  const Farmlands({super.key});

  @override
  State<Farmlands> createState() => _FarmLandState();
}

class _FarmLandState extends State<Farmlands> {
  int _currentIndex = 0;
  Set<int> wishlist = {};
  FlutterSecureStorage storage = const FlutterSecureStorage();
  List<DiscoveryList> farmlandSections = [];
  bool isLoading = true; // Track loading state

  void toggleWishlist(int index, FarmlandsList2 farmland) async {
    final favProvider = Provider.of<FavViewModel>(context, listen: false);
    setState(() {
      farmland.isFavorite = !(farmland.isFavorite ?? false);
      if (wishlist.contains(index)) {
        wishlist.remove(index);
        favProvider.togglefav(
            farmlandSections
                .expand((e) => e.farmlands ?? [])
                .toList()[index]
                .farmlandId,
            false,
            context);
      } else {
        wishlist.add(index);
        favProvider.togglefav(
            farmlandSections
                .expand((e) => e.farmlands ?? [])
                .toList()[index]
                .farmlandId,
            true,
            context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFarmlandData(); // Fetch data when the screen initializes
  }

  Future<void> _fetchFarmlandData() async {
    try {
      final provider = Provider.of<DiscoveryViewModel>(context, listen: false);
      await provider.getDiscovery(context);
      setState(() {
        farmlandSections = provider.trackFarmlandResponse?.bottomlist ?? [];
        isLoading = false; // Stop loading after data is fetched
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading if there's an error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load data: $e")),
      );
    }
  }

  Future<void> _clearStoredData() async {
    await storage.delete(key: "code");
    await storage.delete(key: "code1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(), // Show loader
              )
            : farmlandSections.isEmpty
                ? const Center(
                    child: Text(
                      "No farmlands available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildDynamicContent(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 350,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bgframland.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              _buildAppBar(),
              const SizedBox(height: 16),
              if (farmlandSections.isNotEmpty &&
                  farmlandSections[0].farmlands != null)
                _buildCarousel(farmlandSections[0].farmlands!),
              const SizedBox(height: 8),
              if (farmlandSections.isNotEmpty &&
                  farmlandSections[0].farmlands != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    farmlandSections[0].farmlands!.length,
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
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home, (route) => false);
                  _clearStoredData();
                }),
            const SizedBox(width: 8),
            const Text(
              'Farmlands',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.search);
            _clearStoredData();
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            child: Icon(Icons.search, color: Color(0xFF8280FF)),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicContent() {
    return Column(
      children: List.generate(farmlandSections.length, (index) {
        var section = farmlandSections[index];
        var itemCount = section.farmlands?.length ?? 0;

        if (index == 0) {
          return const SizedBox(); // Skip as carousel is already built
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(section.title.toString(), () async {
              _clearStoredData();
              await storage.write(
                  key: 'seeall', value: section.code.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Searchlands(),
                ),
              );
            }, itemCount),
            if (index == 1)
              section.farmlands != null && section.farmlands!.isNotEmpty
                  ? _buildHorizontalList(section.farmlands!)
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
            else if (index == 2)
              section.farmlands != null && section.farmlands!.isNotEmpty
                  ? _buildVerticalList(section.farmlands!)
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
            else if (index == 3)
              section.farmlands != null && section.farmlands!.isNotEmpty
                  ? _buildVerticalList(section.farmlands!)
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "No data available",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
          ],
        );
      }),
    );
  }

  Widget _buildCarousel(List<FarmlandsList2> farmlands) {
    return CarouselSlider(
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
      items: farmlands.map((farmland) {
        return GestureDetector(
          onTap: () async {
            _clearStoredData();
            await storage.write(
                key: 'farmid', value: farmland.farmlandId.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PendingFarmlanddetailsScreen(),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Image.network(
                  farmland.thumbnailImage.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "The Most Searched\nFarmland",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(farmland.farmlandCode.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text('${farmland.areaName}, ${farmland.stateName}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_outward, color: Color(0xFF8280FF)),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(
      String title, VoidCallback onSeeAllPressed, int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (itemCount > 1) // Hide "See All" if there's only one item
            GestureDetector(
              onTap: onSeeAllPressed,
              child: const Text(
                'See All',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<FarmlandsList2> farmlands) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: farmlands.length,
        itemBuilder: (context, index) {
          var farmland = farmlands[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    _clearStoredData();
                    await storage.write(
                        key: 'farmid', value: farmland.farmlandId.toString());
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
                    child: Image.network(
                      farmland.thumbnailImage.toString(),
                      fit: BoxFit.cover,
                      width: 132,
                      height: 156,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(farmland.farmlandCode.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${farmland.landCost! ~/ 100000}L',
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalList(List<FarmlandsList2> farmlands) {
    return Column(
      children: farmlands.map((farmland) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  _clearStoredData();
                  await storage.write(
                      key: 'farmid', value: farmland.farmlandId.toString());
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
                      child: Image.network(
                        farmland.thumbnailImage.toString(),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 160,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: GestureDetector(
                        onTap: () {
                          toggleWishlist(farmlands.indexOf(farmland), farmland);
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: getFavoriteIcon(farmland.isFavorite)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(farmland.farmlandCode.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹${farmland.landCost! ~/ 100000}L',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('${farmland.areaName}, ${farmland.stateName}',
                  style: const TextStyle(color: Colors.black54)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget getFavoriteIcon(bool? isFavorite) {
    if (isFavorite == true) {
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
