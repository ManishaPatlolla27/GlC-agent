import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/farmlands/FarmLandResponse.dart';
import '../viewModel/farm_land_view_model.dart';

class SearchFarmlandScreen extends StatefulWidget {
  const SearchFarmlandScreen({super.key});

  @override
  SearchFarmlandScreenState createState() => SearchFarmlandScreenState();
}

class SearchFarmlandScreenState extends State<SearchFarmlandScreen> {
  String? seeall = "";
  List<FarmLandList> farmlandSections = [];

  @override
  void initState() {
    super.initState();
    loadFarmlands();
  }

  Future<void> loadFarmlands() async {
    const storage = FlutterSecureStorage();
    seeall = await storage.read(key: "seeall");

    if (seeall == null) return;
    final provider = Provider.of<FarmLandViewModel>(context, listen: false);
    await provider.getseeall(context, seeall!);
    setState(() {
      farmlandSections = provider.farmlandresponse ?? [];
    });
  }

  String? selectedState;
  String? selectedDistrict;
  RangeValues budgetRange = const RangeValues(15, 80);

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
          "Search Farmlands",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchCard(),
            const SizedBox(height: 20),
            buildSimilarFarmlandsSection(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Find your Farmland",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            buildDropdownField("Select State", ["State 1", "State 2"], (value) {
              setState(() => selectedState = value);
            }),
            const SizedBox(height: 12),
            buildDropdownField("Select District", ["District 1", "District 2"],
                (value) {
              setState(() => selectedDistrict = value);
            }),
            const SizedBox(height: 20),
            const Text(
              "Budget",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${budgetRange.start.toInt()} Lacs"),
                Text("${budgetRange.end.toInt()} Lacs"),
              ],
            ),
            RangeSlider(
              values: budgetRange,
              min: 5,
              max: 200,
              activeColor: const Color(0xFF8280FF),
              inactiveColor: Colors.grey[300],
              onChanged: (RangeValues values) {
                setState(() {
                  budgetRange = values;
                });
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("5 L",
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
                Text("2 Cr",
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8280FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSimilarFarmlandsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Similar Farmlands",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 400, // Set a specific height to avoid constraints issues
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: farmlandSections.length,
            itemBuilder: (context, index) {
              return farmlandCard(farmlandSections[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget farmlandCard(FarmLandList farmland) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  farmland.thumbnailImage ?? 'https://via.placeholder.com/150',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("New",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  farmland.farmlandCode ?? "Unknown",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(farmland.areaName ?? "Unknown",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Crop",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text("Corn"),
                            backgroundColor: Color(0xFFCFCFF6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the radius as needed
                            ),
                          ),
                          SizedBox(width: 6),
                          Chip(
                            label: Text("Potato"),
                            backgroundColor: Color(0xFFCFCFF6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the radius as needed
                            ),
                          ),
                        ])
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Min. Investment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(
                      'Rs. ${farmland.landCost != null ? farmland.landCost!.toStringAsFixed(2) : '0.00'}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8280FF)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 145, // Adjust the width as needed
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8280FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("View Details",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 145, // Adjust the width as needed
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFF8280FF),
                          side: const BorderSide(color: Color(0xFF8280FF)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
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
    );
  }

  Widget buildDropdownField(
      String label, List<String> options, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: options
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
