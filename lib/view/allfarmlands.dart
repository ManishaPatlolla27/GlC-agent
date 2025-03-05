import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nex2u/models/alerts/AlertResponse.dart';
import 'package:nex2u/viewModel/alert_view_model.dart';
import 'package:provider/provider.dart';

import '../viewModel/farm_land_view_model.dart';
import 'alertdetails.dart';
import 'farmlandstatus.dart';

class FarmlandsScreen extends StatefulWidget {
  const FarmlandsScreen({super.key});

  @override
  FarmlandsScreenState createState() => FarmlandsScreenState();
}

class FarmlandsScreenState extends State<FarmlandsScreen> {
  bool isAlertSelected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FarmLandViewModel>(context, listen: false)
          .getFarmLands(context, "All");
      Provider.of<AlertViewModel>(context, listen: false).alerts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final alertViewModel = Provider.of<AlertViewModel>(context);
    final response = alertViewModel.alertresponse;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "All Farmlands",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTabSelector(),
            const SizedBox(height: 20),
            _buildInfoCard(),
            const SizedBox(height: 16),
            Expanded(
                child: isAlertSelected
                    ? _buildAlertList(response)
                    : _buildFarmlandList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabItem("Alerts", true),
          ),
          Expanded(
            child: _buildTabItem("Farmlands", false),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => isAlertSelected = selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: (isAlertSelected == selected)
              ? const Color(0xFF8280FF)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color:
                (isAlertSelected == selected) ? Colors.white : Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Consumer2<FarmLandViewModel, AlertViewModel>(
      builder: (context, farmLandProvider, alertProvider, _) {
        final count = isAlertSelected
            ? alertProvider.alertresponse?.length ?? 0
            : farmLandProvider.farmlandresponse?.length ?? 0;
        return Container(
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
                  Text(
                    isAlertSelected ? "Total Alerts" : "Total Farmlands",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    count.toString(), // Dynamic count
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
        );
      },
    );
  }

  Widget _buildAlertList(List<AlertsList>? alerts) {
    return ListView.builder(
      itemCount: alerts?.length,
      itemBuilder: (context, index) {
        final alert = alerts?[index];

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            color: Colors.white,
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(8),
              iconColor: Colors.grey,
              collapsedIconColor: Colors.grey,
              maintainState: true,
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      alert!.thumbnailImage ?? "",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/logo.png", width: 70, height: 70),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID: ${alert.alertCode ?? 'N/A'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _formatDate(alert.createdOn),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Status: ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${alert.alertStatus ?? 'Unknown'}",
                              style: TextStyle(
                                color: getStatusColor(alert.alertStatus ?? ""),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              childrenPadding: EdgeInsets.only(left: 90, right: 16, bottom: 12),
              onExpansionChanged: (isExpanded) {
                if (isExpanded) {
                  Future.delayed(
                    Duration(milliseconds: 300), // Small delay for smooth UI
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlertViewScreen(farm: alert),
                        ),
                      );
                    },
                  );
                }
              },
              children: [
                const Divider(color: Colors.black26),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Farmland ID: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${alert.farmlandCode ?? 'N/A'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "Date of Creation: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _formatDate(alert.createdOn),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to format the date
  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Unknown';
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  Widget _buildFarmlandList() {
    return Consumer<FarmLandViewModel>(
      builder: (context, farmLandProvider, _) {
        final farmlands = farmLandProvider.farmlandresponse ?? [];
        if (farmlands.isEmpty) {
          return const Center(child: Text("No farmlands available"));
        }
        return ListView.builder(
          itemCount: farmlands.length,
          itemBuilder: (context, index) {
            final farm = farmlands[index];

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
                    farm.thumbnailImage ?? "",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/logo.png"),
                  ),
                ),
                title: Text(
                  "ID: ${farm.farmlandCode}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${farm.areaName}, ${farm.stateName ?? ''}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Status: ${farm.farmlandStatus}",
                      style: TextStyle(
                        color: getStatusColor(farm.farmlandStatus ?? ""),
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
                      builder: (context) => FarmlandStatusScreen(farm: farm),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Completed':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Critical':
        return Colors.red;
      case 'Moderate':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
