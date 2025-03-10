import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomViewModel>(context, listen: false).bottom(context);
    });
  }

  Future<bool> _onWillPop() async {
    return await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you want to exit the app?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomViewModel>(context);
    var response = bottomProvider.bottomresponse;

    if (response == null || response.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> pages = [];
    List<BottomNavigationBarItem> bottomItems = [];

    for (var item in response) {
      Widget page;
      switch (item.menuTitle?.toLowerCase()) {
        case 'home':
          page = const HomeScreen(key: ValueKey('home'));
          break;
        case 'profile':
          page = const ProfileScreen(key: ValueKey('profile'));
          break;
        case 'farmlands':
          page = const Farmlands(key: ValueKey('farmlands'));
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
                  width: 24, height: 24, color: const Color(0xFF8280FF))
              : Image.asset(item.selectedIcon ?? "assets/default_selected.png",
                  width: 24, height: 24),
          label: item.menuTitle ?? "",
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pages[_currentIndex], // Use direct widget instead of IndexedStack
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex == index) {
              // Reload the current page by pushing it again
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => pages[index]),
              );
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
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
      ),
    );
  }
}
