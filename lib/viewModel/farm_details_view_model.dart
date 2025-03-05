import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/repo/farmdetails_repository.dart';

import '../models/farmlands/farm_details_response.dart';

class FarmDetailsViewModel with ChangeNotifier {
  late BuildContext context;
  FarmDetailsResponse? _trackFarmlandResponse;
  final FarmdetailsRepository _profileRepository = FarmdetailsRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  FarmDetailsResponse? get trackFarmlandResponse => _trackFarmlandResponse;

  // Fetch profile details
  Future<void> getfarmdetails(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FarmDetailsResponse response =
          await _profileRepository.getfarmdetails(context, status);

      if (response.farmlandId != null) {
        _trackFarmlandResponse = response;
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
