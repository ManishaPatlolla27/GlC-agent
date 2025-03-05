import 'package:flutter/material.dart';
import 'package:nex2u/models/farmlands/FarmLandResponse.dart';
import 'package:nex2u/viewModel/trackfarmland_view_model.dart';
import 'package:provider/provider.dart';

import '../models/trackfarmland/TrackFarmLandResponse.dart';

class FarmlandStatusScreen extends StatefulWidget {
  final FarmLandList farm;
  const FarmlandStatusScreen({Key? key, required this.farm}) : super(key: key);

  @override
  State<FarmlandStatusScreen> createState() => _FarmlandStatusScreenState();
}

class _FarmlandStatusScreenState extends State<FarmlandStatusScreen> {
  late TrackfarmlandViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = Provider.of<TrackfarmlandViewModel>(context, listen: false);
      _viewModel.getTrackFarm(context, widget.farm.farmlandId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<TrackfarmlandViewModel>(context);
    final response = dashboardViewModel.trackFarmlandResponse;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          response!.farmlandCode.toString(),
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<TrackfarmlandViewModel>(
        builder: (context, viewModel, child) {
          TrackFarmlandResponse? farmland = viewModel.trackFarmlandResponse;
          if (farmland == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Top Farmland Image
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: farmland.thumbnailImage != null
                            ? NetworkImage(farmland.thumbnailImage!)
                            : const AssetImage('assets/farmland.png')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Status Timeline Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Status
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Current Status: ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: farmland.farmlandStatus ?? "Unknown",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Dynamic Timeline
                        if (farmland.statusTrack != null &&
                            farmland.statusTrack!.isNotEmpty)
                          Column(
                            children: List.generate(
                                farmland.statusTrack!.length, (index) {
                              StatusTrack step = farmland.statusTrack![index];
                              bool isCompleted = step.status == "Completed";
                              bool isLastStep =
                                  index == farmland.statusTrack!.length - 1;

                              return _buildTimelineStep(
                                title: step.title ?? "Unknown Step",
                                status: step.status ?? "Pending",
                                isCompleted: isCompleted,
                                isLastStep: isLastStep,
                              );
                            }),
                          )
                        else
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No status updates available.",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Live in Website" Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 3, // Vertical bar
                          height: 24,
                          color: Color(
                              0xFF8280FF), // Adjust to match the exact shade
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Live in Website",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(
                                0xFF8280FF), // Matches the text color in the image
                          ),
                        ),
                        const Spacer(),
                        if (response?.liveInWebSite ?? false)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          )
                        else
                          Image.asset(
                            "assets/unselect.png",
                            width: 24,
                            height: 24,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String status,
    bool isCompleted = false,
    bool isLastStep = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF8280FF).withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isCompleted ? const Color(0xFF8280FF) : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            if (!isLastStep) ...[
              const SizedBox(height: 5),
              Container(
                width: 2,
                height: 40,
                color: isCompleted
                    ? const Color(0xFF8280FF)
                    : Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(height: 5),
            ],
          ],
        ),
        const SizedBox(width: 16), // Space between dot and text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isCompleted ? const Color(0xFF8280FF) : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                color: isCompleted ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
