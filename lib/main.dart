import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_pages.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/viewModel/forgot_password_view_model.dart';
import 'package:nex2u/viewModel/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppPages.routes,
        initialRoute: AppRoutes.initial,
        title: "Nex2U",
      ),
    );
  }
}
