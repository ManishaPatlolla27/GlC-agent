import 'package:flutter/material.dart';

class CompareFarmlandsScreen extends StatelessWidget {
  const CompareFarmlandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Compare Farmlands",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png",
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GLCSOS 01",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            "West Godavari, AP",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        "₹ 2,500,000.00 per acre",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.close, color: Colors.black54),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the button
              children: [
                SizedBox(
                  width: 250, // Adjust the width as needed
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF8280FF),
                      side: const BorderSide(color: Color(0xFF8280FF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("+ Add Farmland"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Similar Farmlands",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400, // Define a proper height
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15)),
                                  child: Image.network(
                                    'https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png',
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text("New",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Unknown",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 16, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text("Unknown",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Crop",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Chip(
                                              label: const Text("Corn"),
                                              backgroundColor:
                                                  const Color(0xFFCFCFF6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), // Adjust the radius as needed
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Chip(
                                              label: const Text("Potato"),
                                              backgroundColor:
                                                  const Color(0xFFCFCFF6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20), // Adjust the radius as needed
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Min. Investment",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text(
                                        'Rs. 0.00',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8280FF)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 145, // Adjust the width as needed
                                        child: ElevatedButton(
                                          onPressed: () async {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF8280FF),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          child: const Text("View Details",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        width: 145, // Adjust the width as needed
                                        child: ElevatedButton(
                                          onPressed: () async {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFF8280FF),
                                            side: const BorderSide(
                                                color: Color(0xFF8280FF)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          child: const Text("Compare"),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
