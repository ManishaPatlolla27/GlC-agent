import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/states/states_response.dart';
import 'package:nex2u/viewModel/state_view_model.dart';
import 'package:provider/provider.dart';

import '../models/farmlands/farm_land_response.dart';
import '../page_routing/app_routes.dart';
import '../viewModel/farm_land_view_model.dart';
import 'farmlanddetails.dart';

class SearchFarmlandScreen extends StatefulWidget {
  const SearchFarmlandScreen({super.key});

  @override
  SearchFarmlandScreenState createState() => SearchFarmlandScreenState();
}

class SearchFarmlandScreenState extends State<SearchFarmlandScreen> {
  String? seeall = "";
  List<FarmLandList> farmlandSections = [];
  String? selectedStateName;
  String? selectedStateId;
  String? selectedDistId;
  String? selectedDistrict;
  List<StatesList> statelist = [];
  List<StatesList> districtList = [];
  RangeValues budgetRange = const RangeValues(15, 80);
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
    final stateprovider = Provider.of<StateViewModel>(context, listen: false);
    await stateprovider.getstates(context);

    setState(() {
      farmlandSections = provider.farmlandresponse ?? [];
      statelist = stateprovider.stateResponse?.stateslist ?? [];
    });
  }

  Future<void> loadStates() async {
    final stateProvider = Provider.of<StateViewModel>(context, listen: false);
    await stateProvider.getregion(context, selectedStateId.toString());

    setState(() {
      districtList = stateProvider.stateResponse?.stateslist ?? [];
    });
  }

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

            // State Dropdown
            buildDropdownField(
              "Select State",
              statelist.map((state) => state.label ?? "").toList(),
              (value) {
                final selectedState = statelist.firstWhere(
                  (state) => state.label == value,
                );

                setState(() {
                  selectedStateName = selectedState.label;
                  selectedStateId = selectedState.id;
                  selectedDistrict = null;
                  loadStates();
                  // districtList = selectedState.districts ?? [];
                });

                debugPrint(
                    "Selected State: $selectedStateName, ID: $selectedStateId");
              },
            ),

            const SizedBox(height: 12),

            // District Dropdown
            buildDropdownField(
              "Select District",
              districtList.map((district) => district.label ?? "").toList(),
              (value) {
                final selecteDistrict = districtList.firstWhere(
                  (state) => state.label == value,
                );
                setState(() {
                  selectedDistrict = selecteDistrict.label;
                  selectedDistId = selecteDistrict.id;
                });

                debugPrint("Selected District: $selectedDistrict");
              },
            ),

            const SizedBox(height: 20),

            // Budget Range
            const Text("Budget", style: TextStyle(fontWeight: FontWeight.bold)),
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

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint(
                      "Searching with State ID: $selectedStateId, District: $selectedDistrict");
                },
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
          height: 430, // Set a specific height to avoid constraints issues
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: farmlandSections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: farmlandCard(farmlandSections[index])),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget farmlandCard(FarmLandList farmland) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
        ],
      ),
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
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.9,
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
            padding: const EdgeInsets.only(
                bottom: 8.0, left: 8.0, right: 8.0, top: 8.0),
            child: Card(
              color: const Color(0xFFDFDFDF),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Exclusive Property",
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          farmland.farmlandCode ?? "Unknown",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              farmland.areaName ?? "Unknown",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFF2F4F5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Crop",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Row(
                                children: farmland.cropTypes != null &&
                                        farmland.cropTypes!.isNotEmpty
                                    ? farmland.cropTypes!.map((crop) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6.0),
                                          child: Chip(
                                            label: Text(
                                              crop,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            backgroundColor:
                                                const Color(0xFFCFCFF6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : [
                                        const Text("No crops available",
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Min. Investment",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                'Rs. ${farmland.landCost != null ? farmland.landCost!.toStringAsFixed(2) : '0.00'}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8280FF)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 135,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    const storage = FlutterSecureStorage();
                                    await storage.write(
                                        key: 'farmid',
                                        value: farmland.farmlandId.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PendingFarmlanddetailsScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8280FF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  child: const Text("View Details",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 135,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.compareadd);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color(0xFF8280FF),
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
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
      value: options.contains(selectedStateName) ? selectedStateName : null,
      items: options
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
