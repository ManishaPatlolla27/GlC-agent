import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/dashboard/dashboard_response.dart';
import 'package:nex2u/repo/dashboard_repository.dart';

class DashboardViewModel with ChangeNotifier {
  late BuildContext context;
  DashboardResponse? _dashboardresponse;
  final DashboardRepository _profileRepository = DashboardRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  DashboardResponse? get dashboardresponse => _dashboardresponse;

  // Fetch profile details
  Future<void> dashboard(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      DashboardResponse response = await _profileRepository.getdashboard();

      if (response.firstName != null) {
        _dashboardresponse = response;

        // Save to secure storage
        await _storage.write(key: 'firstname', value: response.firstName);
        await _storage.write(key: 'lastname', value: response.lastName);
        await _storage.write(key: 'email', value: response.userEmail);
        await _storage.write(key: 'mobile', value: response.mobileNumber);
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
