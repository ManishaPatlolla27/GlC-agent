import 'package:flutter/material.dart';
import 'package:nex2u/models/createAlert/CreateAlertRequest.dart';
import 'package:nex2u/repo/create_alert_repository.dart';

class CreateAlertViewModel extends ChangeNotifier {
  final CreateAlertRepository _createAlertRepository = CreateAlertRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _otpSent = false;

  bool get otpSent => _otpSent;

  Future<void> createAlert(
      CreateAlertRequest createAlertRequest, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _otpSent =
        await _createAlertRepository.createAlert(createAlertRequest, context);

    _isLoading = false;
    notifyListeners();
  }

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
