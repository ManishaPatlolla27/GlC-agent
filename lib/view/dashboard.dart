import 'package:flutter/material.dart';
import 'package:nex2u/models/dashboard/dashboard_response.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/view/pendingfarmlands.dart';
import 'package:provider/provider.dart';

import '../viewModel/configuration_view_model.dart';
import '../viewModel/dashboard_viewmodel.dart';
import 'allfarmlands.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DashboardViewModel>(context, listen: false)
          .dashboard(context);
      if (mounted) setState(() {}); // Ensures UI updates safely
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DashboardViewModel>(context, listen: false).dashboard(context);
    if (mounted) setState(() {}); // Ensure UI updates safely
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    final configService = Provider.of<ConfigurationViewModel>(context);
    final response = dashboardViewModel.dashboardresponse;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/menu.png', // Ensure this asset exists in pubspec.yaml
            width: 24,
            height: 24,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.alert),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEB8801),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Ensures the button wraps its content
              children: const [
                Text("Alert", style: TextStyle(color: Colors.white)),
                SizedBox(width: 8), // Space between text and icon
                Icon(Icons.add, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
            child: Image.asset(
              'assets/notification.png',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome Back,",
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text(response?.firstName?.toString() ?? "User",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Amount / Credits Toggle
            toggleAmountCredits(),

            const SizedBox(height: 16),

            // Show Earnings or Credits Card
            isAmountSelected ? earningsCard(response) : creditsCard(response),

            const SizedBox(height: 16),

            // Grid Items
            Expanded(
              child: response?.farmlandAnalytics != null
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1,
                      ),
                      itemCount: response?.farmlandAnalytics?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = response?.farmlandAnalytics?[index];
                        if (item == null) return const SizedBox();
                        return gridItem(item.title.toString(),
                            item.count.toString(), item.icon.toString());
                      },
                    )
                  : const Center(child: Text("")),
            ),
          ],
        ),
      ),
    );
  }

  // Toggle Switch for Amount / Credits
  Widget toggleAmountCredits() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          toggleButton("Amount", isAmountSelected, true),
          toggleButton("Credits", !isAmountSelected, false),
        ],
      ),
    );
  }

  // Toggle Button
  Widget toggleButton(String title, bool isSelected, bool selectAmount) {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);
    return GestureDetector(
      onTap: () => setState(() => isAmountSelected = selectAmount),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 52),
        decoration: BoxDecoration(
          color: isSelected
              ? configService.appConfig?.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Earnings Card
  Widget earningsCard(DashboardResponse? response) {
    return infoCard(
      "Total Earnings",
      isAmountVisible
          ? "₹ ${response?.totalEarnings?.toString() ?? '0.00'}"
          : "₹ XXXXXXX.XX",
      Icons.currency_rupee,
      () => setState(() => isAmountVisible = !isAmountVisible),
      isAmountVisible ? Icons.visibility : Icons.visibility_off,
    );
  }

  // Credits Card
  Widget creditsCard(DashboardResponse? response) {
    return infoCard(
      "Available Credits",
      "Coming Soon",
      null,
      null,
      null,
      assetImage: 'assets/coins.png',
    );
  }

  // Generic Info Card
  Widget infoCard(String title, String amount, IconData? watermarkIcon,
      VoidCallback? toggleVisibility, IconData? visibilityIcon,
      {String? assetImage}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF8280FF), Color(0xFF5B5A94)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          if (watermarkIcon != null)
            Positioned(
              top: 25,
              right: 20,
              child: Opacity(
                opacity: 0.06,
                child: Icon(watermarkIcon, size: 70, color: Colors.white),
              ),
            ),
          if (assetImage != null)
            Positioned(
              top: 30,
              right: 20,
              child: Image.asset(assetImage, height: 48, color: Colors.white),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.arrow_outward,
                      color: Colors.white, size: 18),
                ),
              ]),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(amount,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  if (toggleVisibility != null)
                    GestureDetector(
                        onTap: toggleVisibility,
                        child: Icon(visibilityIcon, color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Grid Item
  Widget gridItem(String title, String count, String iconPath) {
    return GestureDetector(
      onTap: () {
        if (title == "All Farmlands") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FarmlandsScreen()));
        } else if (title == "Pending Farmlands") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PendingFarmlandsScreen()));
        } else if (title == "Approved Farmlands") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ApprovedFarmlandsScreen()));
        } else if (title == "Farmlands Leads") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FarmlandLeadScreen()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon at the top
            Image.network(
              iconPath,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset("assets/logo.png"),
              width: 55,
              height: 55,
            ),
            const SizedBox(height: 8),

            // Title text
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Count and Arrow in Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
