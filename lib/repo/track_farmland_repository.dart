import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/trackfarmland/track_farm_land_response.dart';
import 'package:provider/provider.dart';

import '../data/api_urls.dart';
import '../data/base_api_client.dart';
import '../viewModel/configuration_view_model.dart';

class TrackFarmlandRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<TrackFarmlandResponse> getTrackFarm(
      BuildContext context, String status) async {
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

      final response = await _apiClient.get<TrackFarmlandResponse>(
        "${configService.enpoints!.tRACKMYFARMLANDSTATUS}/$status" ??
            ApiConstants.createAlert, // API endpoint
        fromJson: (json) => TrackFarmlandResponse.fromJson(json),
        headers: headers,
      );

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
