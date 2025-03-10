import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/states/states_response.dart';
import 'package:nex2u/view/search.dart';
import 'package:nex2u/viewModel/state_view_model.dart';
import 'package:provider/provider.dart';

import '../models/farmlands/farm_land_response.dart';
import '../page_routing/app_routes.dart';
import '../viewModel/farm_land_view_model.dart';
import 'farmlanddetails.dart';

class CompareFarmlandsScreen extends StatefulWidget {
  const CompareFarmlandsScreen({super.key});

  @override
  FarmlandsScreenState createState() => FarmlandsScreenState();
}

class FarmlandsScreenState extends State<CompareFarmlandsScreen> {
  String? seeall = "";
  List<FarmLandList> farmlandSections = [];
  String? selectedStateName;
  String? selectedStateId;
  String? selectedDistId;
  String? selectedDistrict;
  List<StatesList> statelist = [];
  List<StatesList> districtList = [];
  RangeValues budgetRange = const RangeValues(15, 80);
  FlutterSecureStorage storage = FlutterSecureStorage(); // Initialize once

  String? farmid = "";
  String? code = "";
  String? area = "";
  String? cost = "";
  String? image = "";

  String? farmid1 = "";
  String? code1 = "";
  String? area1 = "";
  String? cost1 = "";
  String? image1 = "";
  @override
  void initState() {
    super.initState();
    loadFarmlands();
    loaddata();
  }

  Future<void> loaddata() async {
    farmid = await storage.read(key: "farmid");
    code = await storage.read(key: "code");
    area = await storage.read(key: "area");
    cost = await storage.read(key: "cost");
    image = await storage.read(key: "image");

    farmid1 = await storage.read(key: "farmid1");
    code1 = await storage.read(key: "code1");
    area1 = await storage.read(key: "area1");
    cost1 = await storage.read(key: "cost1");
    image1 = await storage.read(key: "image1");
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
          "Compare Farmlands",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image ?? image1!,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code ?? code1!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          area ?? area1!,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      cost ?? cost1!,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.close, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Searchlands(),
                      ),
                    );
                  },
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
        ],
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
                                  onPressed: () async {
                                    if (storage.read(key: "code") == "") {
                                      await storage.write(
                                          key: 'farmid',
                                          value:
                                              farmland.farmlandId.toString());
                                      await storage.write(
                                          key: 'code',
                                          value:
                                              farmland.farmlandCode.toString());
                                      await storage.write(
                                          key: 'area',
                                          value: farmland.areaName.toString());
                                      await storage.write(
                                        key: 'cost',
                                        value:
                                            "₹${farmland.landCost?.toString() ?? 'N/A'} / acre",
                                      );
                                      await storage.write(
                                          key: 'image',
                                          value: farmland.thumbnailImage!
                                              .toString());
                                      Navigator.pushNamed(
                                          context, AppRoutes.compareadd);
                                    } else {
                                      await storage.write(
                                          key: 'farmid1',
                                          value:
                                              farmland.farmlandId.toString());
                                      await storage.write(
                                          key: 'code1',
                                          value:
                                              farmland.farmlandCode.toString());
                                      await storage.write(
                                          key: 'area1',
                                          value: farmland.areaName.toString());
                                      await storage.write(
                                        key: 'cost1',
                                        value:
                                            "₹${farmland.landCost?.toString() ?? 'N/A'} / acre",
                                      );
                                      await storage.write(
                                          key: 'image1',
                                          value: farmland.thumbnailImage!
                                              .toString());
                                      Navigator.pushNamed(
                                          context, AppRoutes.compareadd);
                                    }
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
}
