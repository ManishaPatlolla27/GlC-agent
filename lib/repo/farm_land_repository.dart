import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/farmlands/farmland_leads_response.dart';
import 'package:nex2u/models/filter/filter_states_model.dart';
import 'package:provider/provider.dart';

import '../data/api_urls.dart';
import '../data/base_api_client.dart';
import '../models/farmlands/farm_land_response.dart';
import '../models/farmlands/farmland_home_response.dart';
import '../models/farmlands/similar_request.dart';
import '../viewModel/configuration_view_model.dart';

class FarmLandRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<FarmLandLeadList>> getFarmLeads(BuildContext context) async {
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

      final response = await _apiClient.get<FarmLandLeadsResponse>(
        configService.enpoints?.gETMYFARMLEADS.toString() ??
            ApiConstants.createAlert, // API endpoint
        fromJson: (json) =>
            FarmLandLeadsResponse.fromJson(json as List<dynamic>),
        headers: headers,
      );

      return response.farmlandleadslist;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<List<FarmLandHomeList>> getFarmLands(
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

      final response = await _apiClient.get<FarmLandHomeResponse>(
        "${configService.enpoints!.gETMYFARMLANDS}/$status", // API endpoint
        fromJson: (json) =>
            FarmLandHomeResponse.fromJson(json as List<dynamic>),
        headers: headers,
      );

      return response.farmlandlist;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<List<FarmLandList>> getseeall(
      BuildContext context, String status) async {
    // final configService =
    //     Provider.of<ConfigurationViewModel>(context, listen: false);
    try {
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      final response = await _apiClient.get<FarmLandResponse>(
        "/lms-api/agent-farmland/seeAllFarmlands/$status", // API endpoint
        fromJson: (json) => FarmLandResponse.fromJson(json as List<dynamic>),
        headers: headers,
      );

      return response.farmlandlist;
    } catch (e) {
      throw FetchProfileException('Failed to fetch profile: $e');
    }
  }

  Future<FarmLandResponse> getsimilar(
      BuildContext context, SimilarRequest similarRequest) async {
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

      final String endpoint =
          configService.enpoints?.sIMILARFARMLANDS ?? ApiConstants.similar;

      final response = await _apiClient.post<FarmLandResponse>(
        endpoint, // API endpoint
        similarRequest.toJson(), // Convert to JSON
        headers: headers,
        fromJson: (json) => FarmLandResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
      );

      return response;
    } on AuthException catch (e) {
      throw AuthException("Authentication error: ${e.message}");
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<FilterStateResponse> getStateListService(BuildContext context) async {
    // final configService =
    //     Provider.of<ConfigurationViewModel>(context, listen: false);
    try {
      final String? token = await _storage.read(key: "auth_token");

      if (token == null || token.isEmpty) {
        throw AuthException("Authentication token is missing or invalid!");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
      final response = await _apiClient.get<FilterStateResponse>(
        ApiConstants.filterStateApi, // API endpoint
        headers: headers,
        fromJson: (json) =>
            FilterStateResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
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
