import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/bottom/bottom_response.dart';

import '../data/api_urls.dart';
import '../data/base_api_client.dart';

class BottomRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<BottomResponse>> getBottom() async {
    try {
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      final response = await _apiClient.get<BottomList>(
        ApiConstants.bottom,
        fromJson: (json) => BottomList.fromJson(json as List<dynamic>),
        headers: headers,
      );

      return response.bottomlist;
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
