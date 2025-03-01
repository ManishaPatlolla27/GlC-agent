import 'package:flutter/material.dart';

class FarmlandStatusScreen extends StatefulWidget {
  const FarmlandStatusScreen({super.key});

  @override
  State<FarmlandStatusScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<FarmlandStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {Navigator.pop(context);}, // Add navigation function
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "GLCSOS 02, ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: "East Godavari",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Top Farmland Image
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/farmland.png'), // Change this to actual image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Status Container
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Status
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Current Status: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "Pending from CCS",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Stepper Timeline
                          _buildTimelineStep(
                            title: "Field Officer Data Uploaded",
                            status: "Completed",
                            isCompleted: true,
                          ),
                          _buildTimelineStep(
                            title: "CCS Team",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Regional Officer Data Uploads",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Local Intelligence Data Uploads",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Legality Officer",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Agriculture Certification Officer",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Land & Boundary Officer",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Valuation Officer",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Local Intelligence Officer",
                            status: "Pending",
                          ),
                          _buildTimelineStep(
                            title: "Super Admin",
                            status: "Pending",
                             isLastStep: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // "Live in Website" Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Live in Website",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.landscape),
            label: "Farmlands",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
  required String title,
  required String status,
  bool isCompleted = false,
  bool isLastStep = false, // New parameter to check if this is the last step
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
                      ? Color(0xFF8280FF).withOpacity(0.2) 
                      : Colors.grey.withOpacity(0.2), // Glow effect
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isCompleted ? Color(0xFF8280FF) : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          if (!isLastStep) ...[ // Hide the vertical line for the last step
            const SizedBox(height: 5),
            Container(
              width: 2,
              height: 40,
              color: isCompleted ? Color(0xFF8280FF) : Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 5),
          ],
        ],
      ),
      const SizedBox(width: 16), // Increased gap between pointer and text
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isCompleted ? Color(0xFF8280FF) : Colors.black,
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
