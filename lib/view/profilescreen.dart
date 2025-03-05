import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/viewModel/dashboard_viewmodel.dart';
import 'package:nex2u/viewModel/profile_menu_view_model.dart';
import 'package:nex2u/viewModel/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).profile(context);
      Provider.of<DashboardViewModel>(context, listen: false)
          .dashboard(context);
      Provider.of<ProfileMenuViewModel>(context, listen: false)
          .profilemenu(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profilemenuViewModel = Provider.of<ProfileMenuViewModel>(context);
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    final profilemenuresponse = profilemenuViewModel.bottomresponse;

    final response = profileViewModel.profileresponse;
    final dashboardresponse = dashboardViewModel.dashboardresponse;

    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content at the top
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "${response?.firstName ?? ''} ${response?.lastName ?? ''}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(response?.userId.toString() ?? '',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Text(response?.mobileNumber.toString() ?? '',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Text(response?.userEmail.toString() ?? '',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(thickness: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      dashboardresponse?.totalEarnings.toString() ?? '0',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Amount", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey), // Divider between items
                Column(
                  children: [
                    Text(
                      dashboardresponse?.totalCredits.toString() ?? '0',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Credits", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
          if (profilemenuresponse != null && profilemenuresponse.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: profilemenuresponse.length,
                itemBuilder: (context, index) {
                  final menu = profilemenuresponse[index];
                  return ListTile(
                    leading: Image.network(menu.menuIcon ?? "",
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/home.png"),
                        width: 20,
                        height: 20),
                    title: Text(menu.menuTitle ?? "Unknown"),
                    onTap: () {
                      if (menu.menuTitle == "My Shortlists") {
                        Navigator.pushNamed(context, AppRoutes.myshortlist);
                      } else if (menu.menuTitle == "Notifications") {
                        Navigator.pushNamed(context, AppRoutes.notifications);
                      } else if (menu.menuTitle == "Total Farm Alerts") {
                        Navigator.pushNamed(context, AppRoutes.allfarmland);
                      }
                    },
                  );
                },
              ),
            ),
          Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
              const storage = FlutterSecureStorage();
              storage.write(key: 'userloggedin', value: 'false');
            },
          ),
        ],
      ),
    );
  }
}
