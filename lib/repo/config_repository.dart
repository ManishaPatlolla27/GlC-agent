import 'package:nex2u/data/api_urls.dart';
import 'package:nex2u/data/base_api_client.dart';
import 'package:nex2u/models/endpoints/api_end_points_response.dart';
import 'package:nex2u/models/resources/config_reponse.dart';

class ConfigRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  // Login method using BaseApiClient
  Future<ConfigResponse?> fetchConfig({
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _apiClient.get<ConfigResponse>(
        ApiConstants.configApi, // Your login endpoint
        fromJson: (json) => ConfigResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
        queryParams: queryParams, // Pass dynamic query params
        headers: headers, // Pass dynamic headers
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  fetchApiEndPoint({required Map<String, dynamic> queryParams}) async {
    try {
      final response = await _apiClient.get<ApiEndPointsResponse>(
        ApiConstants.getEndPoints, // Your login endpoint
        fromJson: (json) =>
            ApiEndPointsResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
        queryParams: queryParams, // Pass dynamic query params
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
