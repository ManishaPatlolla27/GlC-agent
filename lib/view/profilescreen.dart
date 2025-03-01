import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content at the top
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Ram Kishore",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("ID: 579SD32", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // Mobile Number & Email (Moved below profile image)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Text("+91-9123456789",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Text("rkishore@gmail.com",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          const Divider(thickness: 1),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      "₹10000.00",
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
                const Column(
                  children: [
                    Text(
                      "20",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Credits", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          const Divider(thickness: 1),

          _buildProfileOption(
              Icons.account_balance_wallet, "Total Farm Alerts"),
          _buildProfileOption(Icons.favorite_border, "My Shortlists"),
          _buildProfileOption(Icons.notifications_none, "Notifications"),
          _buildProfileOption(Icons.help_outline, "Help"),

          const Spacer(),

          const Divider(thickness: 1),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: () {
        if (title == "My Shortlists") {
          Navigator.pushNamed(context, AppRoutes.myshortlist);
        } else if (title == "Notifications") {
          Navigator.pushNamed(context, AppRoutes.notifications);
        }
      },
    );
  }
}
