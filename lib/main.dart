import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_pages.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/viewModel/bottom_view_model.dart';
import 'package:nex2u/viewModel/configuration_view_model.dart';
import 'package:nex2u/viewModel/dashboard_viewmodel.dart';
import 'package:nex2u/viewModel/forgot_password_view_model.dart';
import 'package:nex2u/viewModel/login_view_model.dart';
import 'package:nex2u/viewModel/profile_menu_view_model.dart';
import 'package:nex2u/viewModel/profile_view_model.dart';
import 'package:nex2u/viewModel/welcome_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configService = ConfigurationViewModel();
  await configService.loadConfig();
  await configService.loadApiEndPoints();

  runApp(
    ChangeNotifierProvider(
      create: (_) => configService,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configService = Provider.of<ConfigurationViewModel>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => WelcomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileMenuViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Green Land Capital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: configService.appConfig?.primaryColor ?? Colors.blue,
        ),
        routes: AppPages.routes,
        initialRoute: AppRoutes.initial,
      ),
    );
  }
}
