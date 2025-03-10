import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/farmlands/farm_land_response.dart';
import 'package:nex2u/view/filter_widget.dart';
import 'package:nex2u/viewModel/farm_land_view_model.dart';
import 'package:provider/provider.dart';

import '../page_routing/app_routes.dart';
import 'farmlanddetails.dart';

class Searchlands extends StatefulWidget {
  const Searchlands({super.key});

  @override
  State<Searchlands> createState() => _SearchLandState();
}

class _SearchLandState extends State<Searchlands> {
  List<FarmLandList> farmlandSections = [];
  late String seeall = "Farmlands"; // Default value to prevent null errors

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//  final storage = const FlutterSecureStorage();

  FlutterSecureStorage storage = FlutterSecureStorage(); // Initialize once
  @override
  void initState() {
    super.initState();
    loadFarmlands();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final provider = Provider.of<FarmLandViewModel>(context, listen: false);
        await provider.getStateListApi(context);
      },
    );
  }

  Future<void> loadFarmlands() async {
    const storage = FlutterSecureStorage();
    String? storedValue = await storage.read(key: "seeall");

    if (storedValue != null) {
      setState(() {
        seeall = storedValue;
      });

      final provider = Provider.of<FarmLandViewModel>(context, listen: false);
      await provider.getseeall(context, seeall);
      setState(() {
        farmlandSections = provider.farmlandresponse ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      // Assign Global Key
      endDrawer: const FilterSelectionWidget(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevents the default drawer icon
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(seeall, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${farmlandSections.length} Farmlands Listing",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      color: Colors.black, width: 1), // Black border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Slightly smaller border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8), // Reduced width
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keeps the button compact
                  children: const [
                    Text("Filter",
                        style: TextStyle(
                            color: Colors.black)), // Text on the right
                    SizedBox(width: 5), // Spacing between text and icon
                    Icon(Icons.filter_list,
                        color: Colors.black), // Icon on the left
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: farmlandSections.length,
                itemBuilder: (context, index) {
                  return farmlandCard(farmlandSections[index]);
                },
              ),
            ),
          ],
        ),
      ),
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
                    padding:
                        const EdgeInsets.all(8), // Adds space around the text
                    decoration: const BoxDecoration(
                      color: Colors.white, // White background
                      // borderRadius:
                      //     BorderRadius.circular(8), // Optional: Adds rounded corners
                    ),
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
                                      if (storage.read(key: "code") != "" &&
                                          storage.read(key: "code1") != "") {
                                        Navigator.pushNamed(
                                            context, AppRoutes.compareboth);
                                      } else {
                                        Navigator.pushNamed(
                                            context, AppRoutes.compareadd);
                                      }
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
                                      if (storage.read(key: "code") != "" &&
                                          storage.read(key: "code1") != "") {
                                        Navigator.pushNamed(
                                            context, AppRoutes.compareboth);
                                      } else {
                                        Navigator.pushNamed(
                                            context, AppRoutes.compareadd);
                                      }
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
