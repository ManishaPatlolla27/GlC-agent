import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/welcomescreen/WelcomeScreenResponse.dart';
import 'package:nex2u/repo/welcome_repository.dart';

class WelcomeViewModel with ChangeNotifier {
  late BuildContext context;
  WelcomeScreenResponse? _dashboardresponse;
  final WelcomeRepository _profileRepository = WelcomeRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  WelcomeScreenResponse? get dashboardresponse => _dashboardresponse;

  // Fetch profile details
  Future<void> welcome(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      WelcomeScreenResponse response = await _profileRepository.getwelcome(
        headers: {'accept': 'application/json', 'GLC-Language': 'ENGLISH'},
      );

      if (response.welcomeScreens != null &&
          response.welcomeScreens!.isNotEmpty) {
        _dashboardresponse = response;
        notifyListeners();
      } else {
        _errorMessage = 'No data found';
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
