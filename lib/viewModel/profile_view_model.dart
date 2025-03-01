import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/profile/ProfileResponse.dart';
import 'package:nex2u/repo/profile_repository.dart';

class ProfileViewModel with ChangeNotifier {
  late BuildContext context;
  ProfileResponse? _profileresponse;
  final ProfileRepository _profileRepository = ProfileRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  ProfileResponse? get profileresponse => _profileresponse;

  // Fetch profile details
  Future<void> profile(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      ProfileResponse response = await _profileRepository.getProfile();

      if (response.firstName != null) {
        _profileresponse = response;
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
