import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:provider/provider.dart';

import '../viewModel/configuration_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _navigateAfterDelay();
      },
    );
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2)); // Delay for 2 seconds
    const storage = FlutterSecureStorage();
    final userExists = await storage.read(key: 'userloggedin');

    if (!mounted) return;

    if (userExists == 'true') {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final configService = Provider.of<ConfigurationViewModel>(context);
    debugPrint("Splash Background URL: ${configService.appConfig?.splashBg}");

    return Scaffold(
      body: Stack(
        children: [
          /// Background Image with Loading & Error Handling
          Positioned.fill(
            child: Image.network(
              configService.appConfig?.splashBg?.trim() ?? "",
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show loader while loading
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/logo.png", // Fallback image
                  fit: BoxFit.fill,
                );
              },
            ),
          ),

          /// App Logo
          Center(
            child: Image.network(
              configService.appConfig?.appLogo ?? "",
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset("assets/logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
