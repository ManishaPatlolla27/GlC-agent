import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/alerts/AlertResponse.dart';
import 'package:nex2u/repo/alert_repository.dart';

class AlertViewModel with ChangeNotifier {
  late BuildContext context;
  List<AlertsList>? _alertresponse = [];
  final AlertRepository _profileRepository = AlertRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<AlertsList>? get alertresponse => _alertresponse;

  // Fetch profile details
  Future<void> alerts(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<AlertsList> response = await _profileRepository.getalerts();

      if (response.isNotEmpty) {
        _alertresponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Helper to update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
