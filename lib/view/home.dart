import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nex2u/view/profilescreen.dart';

import 'dashboard.dart';
import 'farmlands.dart'; // Import if needed

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Default selected index

  // Define the list of pages
  final List<Widget> _pages = [
    const HomeScreen(),
    const Farmlands(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Prevent the back press and show the custom exit alert
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Do you really want to exit?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Do not exit
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop(); // Exit the app
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex, // Maintain the state of pages
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF8280FF),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 20,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? const Color(0xFF8280FF) : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset("assets/home.png", width: 24, height: 24),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1 ? const Color(0xFF8280FF) : Colors.grey,
                  BlendMode.srcIn,
                ),
                child:
                    Image.asset("assets/farmlands.png", width: 24, height: 24),
              ),
              label: "Farmlands",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2 ? const Color(0xFF8280FF) : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset("assets/profile.png", width: 24, height: 24),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
