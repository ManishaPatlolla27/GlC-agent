import 'package:flutter/material.dart';

class CompareFarmlands extends StatefulWidget {
  const CompareFarmlands({super.key});

  @override
  _CompareFarmlandsState createState() => _CompareFarmlandsState();
}

class _CompareFarmlandsState extends State<CompareFarmlands> {
  bool keyFeatureExpanded = true;
  bool facilitiesExpanded = false;
  bool cultivationExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Compare Farmlands", style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _buildFarmlandCard(
                      "GLCSOS 01",
                      "₹2,500,000.00 per acre",
                      "https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png",
                      true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "VS",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _buildFarmlandCard(
                      "GLCSOS 02",
                      "₹1,600,000.00 per acre",
                      "https://glc-dev-resources.s3.ap-south-1.amazonaws.com/FarmlandImages/farmlandimage.png",
                      false,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildExpandableSection("Key Feature", keyFeatureExpanded, () {
              setState(() => keyFeatureExpanded = !keyFeatureExpanded);
            }, [
              _buildComparisonRow("Land Extend", "150 Acres", "150 Acres"),
              _buildComparisonRow("Road Approach", "100 Meters", "100 Meters"),
              _buildComparisonRow(
                  "Electricity Connection", "3 Phase", "3 Phase"),
              _buildComparisonRow(
                  "Water Facility", "Bore (100 Meters)", "Bore (100 Meters)"),
            ]),
            _buildExpandableSection("Facilities", facilitiesExpanded, () {
              setState(() => facilitiesExpanded = !facilitiesExpanded);
            }, [
              _buildComparisonRow("Railway Facility", "✔", "✔"),
              _buildComparisonRow("Airport Facility", "✔", "✔"),
              _buildComparisonRow("Hospital Facility", "✔", "✔"),
            ]),
            _buildExpandableSection("Cultivation", cultivationExpanded, () {
              setState(() => cultivationExpanded = !cultivationExpanded);
            }, [
              _buildComparisonRow("Current Cultivation", "Rice", "Rice"),
              _buildComparisonRow(
                  "Types of Crop", "Rice, Wheat, Corn", "Rice, Wheat, Corn"),
              _buildComparisonRow("Soil Type", "Alfisol", "Alfisol"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmlandCard(
      String title, String price, String imagePath, bool isLeftAligned) {
    return Align(
      alignment: isLeftAligned ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imagePath,
                    width: 140, height: 60, fit: BoxFit.cover),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4)
                    ],
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(fontSize: 12, color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(String title, bool isExpanded,
      VoidCallback onTap, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color for the section
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: Container(
                child: Image.asset(
                  isExpanded ? "assets/minus.png" : "assets/plus.png",
                  width: 24,
                  height: 24,
                ),
              ),
              onTap: onTap,
            ),
            if (isExpanded)
              Container(
                color: Colors.white, // Background color for expanded content
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(children: children),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String feature, String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 1),
          Text(feature, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: Text(value1, textAlign: TextAlign.start)),
              Expanded(child: Text(value2, textAlign: TextAlign.end)),
            ],
          ),
        ],
      ),
    );
  }
}
