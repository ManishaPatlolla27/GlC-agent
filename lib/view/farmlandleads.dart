import 'package:flutter/material.dart';

import 'farmlanddetails.dart';

class FarmlandLeadScreen extends StatefulWidget {
  const FarmlandLeadScreen({super.key});

  @override
  FarmlandsScreenState createState() => FarmlandsScreenState();
}

class FarmlandsScreenState extends State<FarmlandLeadScreen> {
  final formKey = GlobalKey<FormState>();
  final List<Map<String, String>> farmlandList = [
    {'id': 'GLCSOS 02', 'location': 'East Godavari, AP', 'status': 'Pending'},
    {'id': 'GLCSOS 03', 'location': 'East Godavari, AP', 'status': 'Completed'},
    {'id': 'GLCSOS 04', 'location': 'East Godavari, AP', 'status': 'Pending'},
    {'id': 'GLCSOS 05', 'location': 'East Godavari, AP', 'status': 'Rejected'},
    {'id': 'GLCSOS 06', 'location': 'East Godavari, AP', 'status': 'Pending'},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensures full white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Buyer Leads", style: TextStyle(color: Colors.black)),
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16), // Added right padding
            child: Image.asset(
              'assets/filter.png', // Use your custom asset for filter
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8280FF), Color(0xFF5B5A94)],
                ),
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/curvelyframe.png'),
                  fit: BoxFit.cover, // Ensures the image covers the container
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Showing Total List",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "28",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: farmlandList.length,
                itemBuilder: (context, index) {
                  final farmland = farmlandList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 8), // Adjusted spacing
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/farmland.png',
                          width: 70, // Reduced image size
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "ID: ${farmland['id']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            farmland['location']!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onTap: () {
                        // Handle onTap, navigate to a new screen with details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PendingFarmlanddetailsScreen(),
                          ),
                        );
                      },
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
