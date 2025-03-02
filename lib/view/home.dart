import 'package:flutter/material.dart';
import 'package:nex2u/view/profilescreen.dart';
import 'package:nex2u/viewModel/bottom_view_model.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';
import 'farmlands.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomViewModel>(context, listen: false).bottom(context);
      if (mounted) setState(() {}); // Ensure the widget is still active
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomViewModel>(context);
    var response = bottomProvider.bottomresponse;

    if (response == null || response.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("")),
      );
    }

    // if (bottomProvider.isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    // if (response == null || response.isEmpty) {
    //   return const Center(child: Text("No menu items available"));
    // }

    // **Generate Pages & Bottom Navigation Items Dynamically**
    List<Widget> pages = [];
    List<BottomNavigationBarItem> bottomItems = [];

    for (var item in response ??= []) {
      Widget page;
      switch (item.menuTitle?.toLowerCase()) {
        case 'home':
          page = const HomeScreen();
          break;
        case 'profile':
          page = const ProfileScreen();
          break;
        case 'farmlands':
          page = const Farmlands();
          break;
        default:
          page = const Center(child: Text("Page Not Found"));
      }

      pages.add(page);
      bottomItems.add(
        BottomNavigationBarItem(
          icon: item.menuIcon != null && item.menuIcon!.startsWith("http")
              ? Image.network(item.menuIcon!, width: 24, height: 24)
              : Image.asset(item.menuIcon ?? "assets/default.png",
                  width: 24, height: 24),
          activeIcon: item.selectedIcon != null &&
                  item.selectedIcon!.startsWith("http")
              ? Image.network(item.selectedIcon!,
                  width: 24, height: 24, color: Color(0xFF8280FF))
              : Image.asset(item.selectedIcon ?? "assets/default_selected.png",
                  width: 24, height: 24),
          label: item.menuTitle ?? "",
        ),
      );
    }

    _pages = pages;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
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
        items: bottomItems,
      ),
    );
  }
}
