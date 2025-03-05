import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/data/api_urls.dart';
import 'package:nex2u/data/base_api_client.dart';
import 'package:provider/provider.dart';

import '../models/createAlert/create_alert_request.dart';
import '../viewModel/configuration_view_model.dart';

class CreateAlertRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final storage = const FlutterSecureStorage();

  Future<bool> createAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    final configService =
        Provider.of<ConfigurationViewModel>(context, listen: false);

    try {
      final response = await _apiClient.postWithoutJson(
        configService.enpoints?.cREATEFARMLANDALERT.toString() ??
            ApiConstants.createAlert, // API endpoint
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

  Future<bool> createbuyerAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    // final configService =
    //     Provider.of<ConfigurationViewModel>(context, listen: false);

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
