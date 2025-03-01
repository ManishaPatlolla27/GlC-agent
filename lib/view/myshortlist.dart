import 'package:flutter/material.dart';

class MyShortlistsScreen extends StatefulWidget {
  const MyShortlistsScreen({super.key});

  @override
  _MyShortlistsScreenState createState() => _MyShortlistsScreenState();
}

class _MyShortlistsScreenState extends State<MyShortlistsScreen> {
  List<Map<String, dynamic>> farmlands = [
    {
      "id": 1,
      "name": "GLCSOS 002",
      "location": "East Godavari, AP",
      "price": "₹15L",
      "rating": 5.0,
      "image": "assets/farmland.png",
      "isFavorite": true
    },
    {
      "id": 2,
      "name": "GLCSOS 002",
      "location": "East Godavari, AP",
      "price": "₹15L",
      "rating": 5.0,
      "image": "assets/farmland.png",
      "isFavorite": true
    },
    {
      "id": 3,
      "name": "GLCSOS 002",
      "location": "East Godavari, AP",
      "price": "₹15L",
      "rating": 5.0,
      "image": "assets/farmland.png",
      "isFavorite": true
    },
    {
      "id": 4,
      "name": "GLCSOS 002",
      "location": "East Godavari, AP",
      "price": "₹15L",
      "rating": 5.0,
      "image": "assets/farmland.png",
      "isFavorite": true
    },
  ];

  void toggleWishlist(int index) {
    setState(() {
      farmlands.removeAt(index);
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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        child: Image.asset(
                          item["image"],
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
                          child: CircleAvatar(
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
                SizedBox(height: 8),
                Text(item["name"],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item["location"],
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item["price"],
                        style: TextStyle(
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
