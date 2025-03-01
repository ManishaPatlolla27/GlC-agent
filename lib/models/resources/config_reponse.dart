import 'package:flutter/material.dart';

class ConfigResponse {
  final String? introBg;
  final String? splashBg;
  final String? appLogo;
  final String? loginIdLabel;
  final String? forgotPasswordLabel;
  final String? passwordLabel;
  final String? introTitle;
  final String? loginButton;
  final Color? primaryColor;

  ConfigResponse({
    this.introBg,
    this.splashBg,
    this.appLogo,
    this.loginIdLabel,
    this.forgotPasswordLabel,
    this.passwordLabel,
    this.introTitle,
    this.loginButton,
    this.primaryColor,
  });

  // Factory method to create an instance from JSON
  factory ConfigResponse.fromJson(Map<String, dynamic> json) {
    return ConfigResponse(
      introBg: json['INTRO_BG'],
      splashBg: json['SPLASH_BG'],
      appLogo: json['APP_LOGO'],
      loginIdLabel: json['LOGIN_ID_LABEL'],
      forgotPasswordLabel: json['FORGOT_PASSWORD_LABEL'],
      passwordLabel: json['PASSWORD_LABEL'],
      introTitle: json['INTRO_TITLE'],
      loginButton: json['LOGIN_BUTTON'],
      primaryColor: _convertHexToColor(json['PRIMARY_COLOR']),
    );
  }

  static Color? _convertHexToColor(String? hexColor) {
    if (hexColor == null) return null;
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse("0xFF$hexColor"));
  }
}
