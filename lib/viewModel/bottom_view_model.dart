import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/bottom/bottom_response.dart';

import '../repo/bottom_repository.dart';

class BottomViewModel with ChangeNotifier {
  late BuildContext context;
  List<BottomResponse>? _bottomresponse = [];
  final BottomRepository _profileRepository = BottomRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<BottomResponse>? get bottomresponse => _bottomresponse;

  // Fetch profile details
  Future<void> bottom(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<BottomResponse> response = await _profileRepository.getBottom();

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
