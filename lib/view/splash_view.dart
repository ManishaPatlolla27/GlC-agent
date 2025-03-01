import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/page_routing/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds
    const storage = FlutterSecureStorage();
    final userExists = await storage.read(key: 'userloggedin');

    if (!mounted) return;

    if (userExists == 'true') {
      Navigator.pushNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
      ),
    );
  }
}
