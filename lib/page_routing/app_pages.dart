import 'package:flutter/material.dart';
import 'package:nex2u/page_routing/app_routes.dart';
import 'package:nex2u/view/comparebothfarmland.dart';
import 'package:nex2u/view/mappointerpick.dart';
import 'package:nex2u/view/myshortlist.dart';
import 'package:nex2u/view/notification.dart';
import 'package:nex2u/view/onboarding.dart';
import 'package:nex2u/view/passwordupdate.dart';
import 'package:nex2u/view/validateotp.dart';

import '../view/allfarmlands.dart';
import '../view/buyeralert.dart';
import '../view/campare_farmland.dart';
import '../view/compareFarmLands.dart';
import '../view/create_alert.dart';
import '../view/dashboard.dart';
import '../view/editprofile.dart';
import '../view/forgotpassword.dart';
import '../view/home.dart';
import '../view/login.dart';
import '../view/searchfarmlandscreen.dart';
import '../view/splash_view.dart';

class AppPages {
  AppPages._();
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.splash: (context) => const SplashView(),
      AppRoutes.onboard: (context) => const OnboardingScreen(),
      AppRoutes.login: (context) => const LoginScreen(),
      AppRoutes.forgot: (context) => const ForgotPasswordScreen(),
      AppRoutes.validate: (context) => const ValidateOtpScreen(),
      AppRoutes.password: (context) => const PasswordUpdateScreen(),
      AppRoutes.home: (context) => const HomePage(),
      AppRoutes.alert: (context) => const CreateAlertScreen(),
      AppRoutes.editprofile: (context) => const EditProfileScreen(),
      AppRoutes.myshortlist: (context) => const MyShortlistsScreen(),
      AppRoutes.buyer: (context) => const BuyerAlertScreen(),
      AppRoutes.search: (context) => const SearchFarmlandScreen(),
      AppRoutes.dashboard: (context) => const HomeScreen(),
      AppRoutes.allfarmland: (context) => const FarmlandsScreen(),
      AppRoutes.notifications: (context) => const NotificationsScreen(),
      AppRoutes.map: (context) => const HomeMap(),
      AppRoutes.compare: (context) => const CompareFarmlands(),
      AppRoutes.compareadd: (context) => const CompareFarmlandsScreen(),
      AppRoutes.compareboth: (context) => const CompareBothFarmlandsScreen(),
    };
  }
}
