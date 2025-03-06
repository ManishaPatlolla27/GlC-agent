import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nex2u/models/favourite/favourite_response.dart';
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
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Remove from Shortlist"),
        content:
            const Text("Do you want to remove this item from the shortlist?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text("Yes"),
            onPressed: () async {
              final favProvider =
                  Provider.of<FavViewModel>(context, listen: false);
              final item = farmlands[index];

              await favProvider.togglefav(item.farmlandId!, false, context);
              if (favProvider.favSent == true) {
                setState(() {
                  farmlands.removeAt(index);
                  Navigator.pop(context);
                });
              } else {}
            },
          ),
        ],
      ),
    );
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
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final item = farmlands[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item.thumbnailImage.toString(),
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
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
                Text(item.farmlandCode ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item.regionName ?? "",
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₹ ${item.landCost ?? ''}",
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
