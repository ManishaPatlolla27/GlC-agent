import 'package:flutter/material.dart';

import '../page_routing/app_routes.dart';
import 'farmlandstatus.dart';

class FarmlandsScreen extends StatefulWidget {
  const FarmlandsScreen({super.key});

  @override
  _FarmlandsScreenState createState() => _FarmlandsScreenState();
}

class _FarmlandsScreenState extends State<FarmlandsScreen> {
  bool isAmountSelected = true; // Track selected tab

  final List<Map<String, String>> farmlandList = [
    {'id': 'GLCSOS 02', 'location': 'East Godavari, AP', 'status': 'Pending'},
    {'id': 'GLCSOS 03', 'location': 'East Godavari, AP', 'status': 'Completed'},
    {'id': 'GLCSOS 04', 'location': 'East Godavari, AP', 'status': 'Pending'},
    {'id': 'GLCSOS 05', 'location': 'East Godavari, AP', 'status': 'Rejected'},
    {'id': 'GLCSOS 06', 'location': 'East Godavari, AP', 'status': 'Pending'},
  ];

  final List<Map<String, String>> alertsList = [
    {'id': 'ALRT001', 'location': 'East Godavari, AP', 'status': 'Critical'},
    {'id': 'ALRT002', 'location': 'West Godavari, AP', 'status': 'Moderate'},
    {'id': 'ALRT003', 'location': 'Guntur, AP', 'status': 'Low'},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Critical':
        return Colors.red;
      case 'Moderate':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decide which list to display based on selection
    final List<Map<String, String>> currentList =
        isAmountSelected ? alertsList : farmlandList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("All Farmlands", style: TextStyle(color: Colors.black)),
        leading: Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/filter.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle Tabs
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAmountSelected = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isAmountSelected
                              ? Color(0xFF8280FF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Alerts",
                          style: TextStyle(
                            color: isAmountSelected
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAmountSelected = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isAmountSelected
                              ? Color(0xFF8280FF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Farmlands",
                          style: TextStyle(
                            color: !isAmountSelected
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic "Showing Total List" Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8280FF), Color(0xFF5B5A94)],
                ),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/curvelyframe.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAmountSelected
                        ? "Total Alerts"
                        : "Showing Total Farmlands",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    currentList.length.toString(), // Dynamic count
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Dynamic List Section
            Expanded(
              child: ListView.builder(
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final item = currentList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          isAmountSelected
                              ? 'assets/farmland.png' // Alerts Image
                              : 'assets/farmland.png', // Farmlands Image
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "ID: ${item['id']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['location']!,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "Status: ${item['status']}",
                            style: TextStyle(
                              color: getStatusColor(item['status']!),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onTap: () {
                        if (isAmountSelected)
                          Navigator.pushNamed(context, AppRoutes.alertdetails);
                        else
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FarmlandStatusScreen(),
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
