import 'package:flutter/material.dart';
import 'package:nex2u/data/base_api_client.dart';

import '../data/api_urls.dart';

class ForgotRepository {
  final BaseApiClient _apiClient = BaseApiClient();

  Future<bool> sendOtp(String loginId) async {
    try {
      return await _apiClient.get<bool>(
        ApiConstants.forgotpassword + loginId,
        fromJson: (data) => data as bool,
        headers: {'accept': 'application/json'},
      );
    } catch (e) {
      debugPrint("Error sending OTP: $e");
      return false; // Return false if request fails
    }
  }

  Future<bool> updatePassword({
    required String loginId,
    required String password,
    required String oldPassword,
    required String verificationCode,
  }) async {
    try {
      final response = await _apiClient.post<bool>(
        ApiConstants.validateotp,
        {
          "loginId": loginId,
          "password": password,
          "oldPassword": oldPassword,
          "verificationCode": verificationCode,
        },
        fromJson: (data) => data as bool, // Convert response to boolean
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
