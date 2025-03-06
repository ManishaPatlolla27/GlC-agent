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
  final storage = const FlutterSecureStorage();
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
      key: _scaffoldKey, // Assign Global Key
      drawer: const FilterDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(seeall, style: const TextStyle(color: Colors.black)),
      ),
      endDrawer: const FilterSelectionWidget(),
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
              child: ElevatedButton.icon(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                label:
                    const Text("Filter", style: TextStyle(color: Colors.black)),
                icon: const Icon(Icons.filter_list, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
}

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8, // 80% width
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Text(
              "Filter",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Search By State",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: "e.g. Andhra Pradesh",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Search",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
