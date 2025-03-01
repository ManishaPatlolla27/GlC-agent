import 'package:flutter/material.dart';

class SearchFarmlandScreen extends StatefulWidget {
  const SearchFarmlandScreen({super.key});

  @override
  _SearchFarmlandScreenState createState() => _SearchFarmlandScreenState();
}

class _SearchFarmlandScreenState extends State<SearchFarmlandScreen> {
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
      color: Colors.white, // Ensuring the background is white
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
              activeColor: Color(0xFF8280FF),
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
        buildFarmlandCard(),
      ],
    );
  }

  Widget buildFarmlandCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  "assets/farmland.png",
                  height: 150,
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "New",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
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
                  "Exclusive Property",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Text(
                  "GLCSOS 01",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      "Tanuku, West Godavari, AP",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Crop Type",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    buildTag("Corn"),
                    const SizedBox(width: 8),
                    buildTag("Potato"),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Min. Investment",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs. 100000.00",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "View Details",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text("Compare"),
                    ),
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

  Widget buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: Colors.blueAccent)),
    );
  }
}
