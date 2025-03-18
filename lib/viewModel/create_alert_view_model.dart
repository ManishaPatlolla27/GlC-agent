import 'package:flutter/material.dart';
import 'package:nex2u/models/createAlert/create_alert_request.dart';
import 'package:nex2u/repo/create_alert_repository.dart';

import '../models/alerts/alert_submit_response.dart';

class CreateAlertViewModel extends ChangeNotifier {
  final CreateAlertRepository _createAlertRepository = CreateAlertRepository();
  AlertSubmitResponse? _trackFarmlandResponse;
  bool _isLoading = false;
  setLoadingStatus(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  bool _otpSent = false;

  bool get otpSent => _otpSent;
  AlertSubmitResponse? get trackFarmlandResponse => _trackFarmlandResponse;
  // Future<void> createAlert(
  //     CreateAlertRequest createAlertRequest, BuildContext context) async {
  //   try {
  //     _isLoading = true;
  //     AlertSubmitResponse response =
  //         await _createAlertRepository.createAlert(createAlertRequest, context);
  //
  //     if (response.alertId != null) {
  //       _isLoading = false;
  //     } else {
  //       _isLoading = false;
  //     }
  //   } catch (e) {
  //     _isLoading = false;
  //     if (!context.mounted) return;
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  Future<void> createAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    try {
      _isLoading = true;

      AlertSubmitResponse response =
          await _createAlertRepository.createAlert(createAlertRequest, context);

      if (response.alertId != null) {
        _isLoading = false;
        _trackFarmlandResponse = response;
      } else {
        _isLoading = false;
      }
    } catch (e) {
      _isLoading = false;
    } finally {
      _isLoading = false;
    }
  }

  // Future<void> createAlert(
  //     CreateAlertRequest createAlertRequest, BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   _otpSent =
  //       await _createAlertRepository.createAlert(createAlertRequest, context);
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }

  Future<void> createBuyerAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _otpSent = await _createAlertRepository.createbuyerAlert(
        createAlertRequest, context);

    _isLoading = false;
    notifyListeners();
  }
}
