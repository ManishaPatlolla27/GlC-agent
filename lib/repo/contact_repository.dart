import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/resources/faq_response.dart';
import 'package:provider/provider.dart';

import '../data/base_api_client.dart';
import '../models/resources/create_message.dart';
import '../viewModel/configuration_view_model.dart';

class ContactRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<FaqResponse> getfaq(BuildContext context) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);
    try {
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      final response = await _apiClient.get<FaqResponse>(
        configService.enpoints!.gETFAQS.toString(), // API endpoint
        fromJson: (json) => FaqResponse.fromJson(json),
        headers: headers,
      );

      return response;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<bool> createmessage(
      CreateMessage createAlertRequest, BuildContext context) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);

    try {
      final response = await _apiClient.postWithoutJson(
        configService.enpoints!.sENDMESSAGE.toString(), // API endpoint
        createAlertRequest.toJson(), // Convert request to JSON
        isJson: true, // Content-Type: application/json
      );

      // If response is not null or an empty string, consider it successful
      return response != null && response != false;
    } catch (e) {
      debugPrint('createfarmland failed: $e');
      return false; // Return false on failure
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
