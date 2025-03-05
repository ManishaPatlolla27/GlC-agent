import 'package:flutter/material.dart';
import 'package:nex2u/models/favourite/FavouriteResponse.dart';
import 'package:nex2u/viewModel/fav_view_model.dart';
import 'package:provider/provider.dart';

class MyShortlistsScreen extends StatefulWidget {
  const MyShortlistsScreen({super.key});

  @override
  MyShortlistsScreenState createState() => MyShortlistsScreenState();
}

class MyShortlistsScreenState extends State<MyShortlistsScreen> {
  List<FavList> farmlands = [];

  void toggleWishlist(int index) {
    setState(() {
      farmlands.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<FavViewModel>(context, listen: false);
      await provider.getfav(context);

      setState(() {
        farmlands = provider.favResponse?.favlist ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Text("Profile",
                style: TextStyle(color: Colors.black, fontSize: 16)),
            SizedBox(width: 5),
            Text("/ My Shortlists",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: farmlands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7, // Adjusted for proper spacing
          ),
          itemBuilder: (context, index) {
            final item = farmlands[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // ✅ Fixes the overflow issue
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item.thumbnailImage.toString(),
                          height: 220, // Increased height
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => toggleWishlist(index),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Icon(
                              Icons.favorite,
                              color: Color(0xFF8280FF),
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(item.farmlandCode.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item.regionName.toString(),
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
                // const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₹ " + item.landCost.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
