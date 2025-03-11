import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Key _pageKey = UniqueKey(); // Unique key to force rebuild

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
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  }),
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

    List<BottomNavigationBarItem> bottomItems = [];
    for (var item in response) {
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

    Widget getPage(String? title) {
      switch (title?.toLowerCase()) {
        case 'home':
          return HomeScreen(key: _pageKey);
        case 'farmlands':
          return Farmlands(key: _pageKey);
        case 'profile':
          return ProfileScreen(key: _pageKey);
        default:
          return const Center(child: Text("Page Not Found"));
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _onWillPop(),
      child: Scaffold(
        body: getPage(response[_currentIndex].menuTitle),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex == index) {
              // If same tab is tapped, refresh by updating the key
              setState(() {
                _pageKey = UniqueKey();
              });
            } else {
              setState(() {
                _currentIndex = index;
                _pageKey = UniqueKey(); // Reset key when switching tabs
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
