import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/data/api_urls.dart';
import 'package:nex2u/data/base_api_client.dart';
import 'package:nex2u/models/alerts/alert_submit_response.dart';
import 'package:provider/provider.dart';

import '../models/createAlert/create_alert_request.dart';
import '../viewModel/configuration_view_model.dart';

class CreateAlertRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final storage = const FlutterSecureStorage();

  Future<AlertSubmitResponse> createAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);
    try {
      final response = await _apiClient.post<AlertSubmitResponse>(
        configService.enpoints?.cREATEFARMLANDALERT.toString() ??
            ApiConstants.createAlert, // API endpointr login endpoint
        createAlertRequest.toJson(), // Convert to JSON
        fromJson: (json) =>
            AlertSubmitResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<bool> createbuyerAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);

    try {
      final response = await _apiClient.postWithoutJson(
        ApiConstants.createBuyerAlert, // API endpoint
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
