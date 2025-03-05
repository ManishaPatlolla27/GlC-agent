import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/profile/profile_response.dart';
import 'package:nex2u/models/update_profile_pic_request.dart';
import 'package:nex2u/viewModel/configuration_view_model.dart';
import 'package:provider/provider.dart';
import '../data/api_urls.dart';
import '../data/base_api_client.dart';

class ProfileRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<ProfileResponse> getProfile() async {
    try {
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      final response = await _apiClient.get<ProfileResponse>(
        ApiConstants.profile,
        fromJson: (json) => ProfileResponse.fromJson(json),
        headers: headers,
      );

      return response;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<bool?> updateProfile(
      UpdateProfilePicRequest payload, BuildContext context) async {
    try {
      final request = {
        "user_id": payload.userId,
        "file": await MultipartFile.fromFile(payload.imageFile,
            filename: payload.imageFile.split('/').last),
      };
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      if (!context.mounted) return null;
      final configService =
          Provider.of<ConfigurationViewModel>(context, listen: false);
      final response = await _apiClient.postWithoutJson(
          configService.enpoints?.uPDATEMYPROFILEPIC.toString() ??
              ApiConstants.createAlert, // API endpoint
          request, // Convert request to JSON
          headers: headers,
          isJson: true, // Content-Type: application/json
          isMultipart: true);

      return response;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }
}

// Custom Exception for Authentication Issues
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

// Custom Exception for Profile Fetching Issues
class FetchProfileException implements Exception {
  final String message;
  FetchProfileException(this.message);

  @override
  String toString() => 'FetchProfileException: $message';
}
