import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/favourite/favourite_response.dart';
import 'package:provider/provider.dart';

import '../data/base_api_client.dart';
import '../viewModel/configuration_view_model.dart';

class FavRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<FavouriteResponse> getfav(BuildContext context) async {
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

      final response = await _apiClient.get<FavouriteResponse>(
        "/lms-api/agent-farmland/getMyFavoriteFarmlands", // API endpoint
        fromJson: (json) => FavouriteResponse.fromJson(json),
        headers: headers,
      );

      return response;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<bool> toggleFavoriteFarmland({
    required int farmlandId,
    required bool isFavorite,
    required BuildContext context,
  }) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);

    try {
      final response = await _apiClient.put<bool>(
        "${configService.enpoints?.fAVORITEORUNFAVORITEFARMLAND}/$farmlandId/$isFavorite",
        fromJson: (data) => data as bool, // Convert API response to boolean
      );
      return response;
    } catch (e) {
      rethrow;
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
