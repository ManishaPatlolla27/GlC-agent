import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nex2u/models/resources/config_reponse.dart';
import 'package:nex2u/repo/config_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfigurationViewModel with ChangeNotifier {
  ConfigResponse? appConfig;
  Future<void> loadConfig() async {
    try {
      final repository = ConfigRepository();
      final deviceType = Platform.isAndroid ? "Android" : "iOS";
      final response = await repository.fetchConfig(
        queryParams: {'device': deviceType}, // Pass query parameters
        headers: {
          'accept': 'application/json',
          'GLC-Language': 'ENGLISH'
        }, // Pass headers
      );
      if (response != null) {
        appConfig = response;
        notifyListeners();
      }
    } catch (e) {
      _showToast("Error loading: $e");
    }
  }

  Future<void> loadApiEndPoints() async {
    try {
      final repository = ConfigRepository();

      final response = await repository.fetchApiEndPoint(
        queryParams: {
          "env": "dev",
          "version": "1.0",
        },
      );
      if (response != null) {
        appConfig = response;
        notifyListeners();
      }
    } catch (e) {
      _showToast("Error loading: $e");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
