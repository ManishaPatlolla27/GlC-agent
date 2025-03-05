import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/profile/profile_menu_response.dart';

import '../repo/profile_menu_repository.dart';

class ProfileMenuViewModel with ChangeNotifier {
  late BuildContext context;
  List<ProfileMenuList>? _bottomresponse = [];
  final ProfileMenuRepository _profileRepository = ProfileMenuRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<ProfileMenuList>? get bottomresponse => _bottomresponse;

  // Fetch profile details
  Future<void> profilemenu(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<ProfileMenuList> response =
          await _profileRepository.getprofilemenu();

      if (response.isNotEmpty) {
        _bottomresponse = response;
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
