import 'package:flutter/material.dart';
import 'package:nex2u/view/buyerdetails.dart';
import 'package:nex2u/viewModel/farm_land_view_model.dart';
import 'package:provider/provider.dart';

class FarmlandLeadScreen extends StatefulWidget {
  const FarmlandLeadScreen({super.key});

  @override
  FarmlandLeadScreenState createState() => FarmlandLeadScreenState();
}

class FarmlandLeadScreenState extends State<FarmlandLeadScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FarmLandViewModel>(context, listen: false)
          .getFarmLeads(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensures full white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Buyer Leads",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/filter.png', width: 24, height: 24),
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
              child: Consumer<FarmLandViewModel>(
                builder: (context, farmleadsprovider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Showing Total List",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${farmleadsprovider.bottomresponse?.length}", // Dynamic count
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
                builder: (context, farmleadsprovider, _) {
                  final response = farmleadsprovider.bottomresponse;

                  if (response!.isEmpty) {
                    return const Center(child: Text("No leads available"));
                  }

                  return ListView.builder(
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      final farmland = response[index];

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
                            "ID: ${farmland.leadCode}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            farmland.areaName! +
                                "," +
                                farmland.stateName.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
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
                                    BuyerViewScreen(farm: farmland),
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
