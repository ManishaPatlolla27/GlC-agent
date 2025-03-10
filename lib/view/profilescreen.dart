import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final provider = Provider.of<ProfileViewModel>(context, listen: false);

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      if (!mounted) return;
      await provider.updateProfile(_imageFile ?? File(''), context);
    }
  }

  void showDeleteAccountDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/warning.png', // Replace with your warning icon
                height: 60,
              ),
              const SizedBox(height: 10),
              const Text(
                'Account Deletion',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Are you sure you want to delete your account?',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Your account will be deleted within\n5-7 working days from the date of\nrequest for deletion of account.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.redAccent),
              ),
              isDestructiveAction: true,
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Don't Delete",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showImagePickerOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("Select Profile Picture"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text("Capture from Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text("Upload from Gallery"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
        title: const Text("My Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.home, (route) => false);
            ;
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content at the top
              children: [
                GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (profileViewModel
                                              .profileresponse?.profileImage !=
                                          null &&
                                      profileViewModel.profileresponse!
                                          .profileImage!.isNotEmpty
                                  ? NetworkImage(profileViewModel
                                      .profileresponse!.profileImage!)
                                  : null),
                          child: (_imageFile == null &&
                                  (profileViewModel
                                          .profileresponse?.profileImage ==
                                      null))
                              ? const Icon(Icons.camera_alt,
                                  size: 40, color: Colors.white)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.purple, size: 20),
                              onPressed: () {
                                _showImagePickerOptions();
                              },
                              padding: EdgeInsets.zero, // Remove extra padding
                              constraints:
                                  BoxConstraints(), // Prevents extra space
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "${response?.firstName ?? ''} ${response?.lastName ?? ''}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("ID: ${response?.userCode}",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text("+91-${response!.mobileNumber}",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.grey, size: 16),
                    const SizedBox(width: 8),
                    Text(response.userEmail.toString(),
                        style: const TextStyle(color: Colors.grey)),
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
                Column(
                  children: [
                    Text(
                      dashboardresponse?.totalEarnings.toString() ?? '0',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text("Amount", style: TextStyle(color: Colors.grey)),
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
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text("Credits", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
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
                      } else if (menu.menuTitle == "Delete My Account") {
                        showDeleteAccountDialog(context);
                      }
                    },
                  );
                },
              ),
            ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Log Out", style: TextStyle(color: Colors.red)),
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
