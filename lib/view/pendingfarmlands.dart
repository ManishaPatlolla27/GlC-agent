import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/farm_land_view_model.dart';
import 'farmlandstatus.dart';

class PendingFarmlandsScreen extends StatefulWidget {
  const PendingFarmlandsScreen({super.key});

  @override
  PendingFarmlandsScreenState createState() => PendingFarmlandsScreenState();
}

class PendingFarmlandsScreenState extends State<PendingFarmlandsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FarmLandViewModel>(context, listen: false)
          .getFarmLands(context, "Pending");
    });
  }

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
        title: const Text("Pending Farmlands",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
                  fit: BoxFit.cover,
                ),
              ),
              child: Consumer<FarmLandViewModel>(
                builder: (context, farmLandProvider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Showing Total List",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${farmLandProvider.farmlandresponse?.length}", // Dynamic count
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Consumer<FarmLandViewModel>(
                builder: (context, farmLandProvider, _) {
                  final farmlandList = farmLandProvider.farmlandresponse;

                  if (farmlandList!.isEmpty) {
                    return const Center(
                        child: Text("No pending farmlands found"));
                  }

                  return ListView.builder(
                    itemCount: farmlandList.length,
                    itemBuilder: (context, index) {
                      final farmland = farmlandList[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              farmland.thumbnailImage ?? "",
                              width: 85,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/logo.png"),
                            ),
                          ),
                          title: Text(
                            "ID: ${farmland.farmlandCode}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                farmland.areaName! +
                                    "," +
                                    farmland.stateName.toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                "Status: ${farmland.farmlandStatus}",
                                style: TextStyle(
                                  color: getStatusColor(
                                      farmland.farmlandStatus ?? ""),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FarmlandStatusScreen(farm: farmland),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
