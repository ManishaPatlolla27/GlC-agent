import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/view/allfarmlands.dart';
import 'package:nex2u/view/pendingfarmlands.dart';

import 'approvedfarmland.dart';
import 'farmlandleads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAmountSelected = true; // Track selected tab
  bool isAmountVisible = false; // Track if amount is visible
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(
              left: 16, top: 0, bottom: 0, right: 0), // Increased left padding
          child: Image.asset(
            'assets/menu.png', // Replace with your actual asset path
            width: 24, // Adjust size as needed
            height: 24,
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.alert);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEB8801),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: Icon(Icons.add, color: Colors.white),
            label: Text("Alert", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            child: Image.asset(
              'assets/notification.png', // Replace with your actual asset path
              width: 24, // Adjust size as needed
              height: 24,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back,",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              "Ram",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            // Amount / Credits Toggle
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAmountSelected = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 52),
                      decoration: BoxDecoration(
                        color: isAmountSelected
                            ? Color(0xFF8280FF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Amount",
                        style: TextStyle(
                          color:
                              isAmountSelected ? Colors.white : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isAmountSelected = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 52),
                      decoration: BoxDecoration(
                        color: !isAmountSelected
                            ? Color(0xFF8280FF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Credits",
                        style: TextStyle(
                          color:
                              !isAmountSelected ? Colors.white : Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Show Earnings Card only if Amount tab is selected
            if (isAmountSelected)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8280FF), Color(0xFF5B5A94)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Rupee Watermark (Bottom Right)
                    Positioned(
                      top: 25,
                      bottom: 0,
                      right: 20,
                      child: Opacity(
                        opacity: 0.06,
                        child: Icon(
                          Icons.currency_rupee,
                          size: 90,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Main Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: "Total Earnings" & Arrow Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Earnings",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white),
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(Icons.arrow_outward,
                                  color: Colors.white, size: 18),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Amount & Eye Icon
                        Row(
                          children: [
                            Text(
                              isAmountVisible ? "₹ 20,000.00" : "₹ XXXXXXX.XX",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAmountVisible = !isAmountVisible;
                                });
                              },
                              child: Icon(
                                isAmountVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8280FF), Color(0xFF5B5A94)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Rupee Watermark (Bottom Right)
                    Positioned(
                      top: 30,
                      bottom: 0,
                      right: 20,
                      child: Image.asset(
                        'assets/coins.png',
                        height: 48,
                        color: Colors.white,
                      ),
                    ),

                    // Main Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Row: "Total Earnings" & Arrow Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Available Credits",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white),
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(Icons.arrow_outward,
                                  color: Colors.white, size: 18),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Amount & Eye Icon
                        Row(
                          children: [
                            Text(
                              "Comming Soon",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),

            // Grid Items
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1,
                children: [
                  gridItem("All Farmlands", "28", 'assets/allfarmlandicon.png'),
                  gridItem(
                    "Pending Farmlands",
                    "24",
                    'assets/pendingfarmlands.png',
                  ),
                  gridItem(
                    "Approved Farmlands",
                    "13",
                    'assets/approvedfarmland.png',
                  ),
                  gridItem(
                    "Buyer Leads",
                    "26",
                    'assets/farmlandleads.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Grid Item
  Widget gridItem(String title, String count, String iconPath) {
    return GestureDetector(
        onTap: () {
          if (title == "All Farmlands") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FarmlandsScreen()),
            );
          } else if (title == "Pending Farmlands") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PendingFarmlandsScreen()),
            );
          } else if (title == "Approved Farmlands") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ApprovedFarmlandsScreen()),
            );
          } else if (title == "Buyer Leads") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FarmlandLeadScreen()),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 2,
                offset: Offset(0, 4), // Slight elevation
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Stack(
            children: [
              // Top-left Icon
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  iconPath,
                  width: 52,
                  height: 52,
                ),
              ),

              // Main Content: Title + Number & Arrow Row
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to left
                children: [
                  SizedBox(height: 70), // Space for top-left icon
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(104, 3, 3, 3)),
                  ),
                  SizedBox(height: 10),

                  // Row with Number & Right Arrow
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Space out elements
                    children: [
                      Text(
                        count,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

// Tab Button Widget
}
