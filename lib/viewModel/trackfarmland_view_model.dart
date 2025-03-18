import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/trackfarmland/track_farm_land_response.dart';

import '../repo/track_farmland_repository.dart';

class TrackfarmlandViewModel with ChangeNotifier {
  late BuildContext context;
  TrackFarmlandResponse? _trackFarmlandResponse;
  final TrackFarmlandRepository _profileRepository = TrackFarmlandRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  TrackFarmlandResponse? get trackFarmlandResponse => _trackFarmlandResponse;

  // Fetch farmland tracking details
  Future<void> getTrackFarm(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _trackFarmlandResponse = null; // Reset previous data before fetching new
      _errorMessage = '';

      TrackFarmlandResponse response =
          await _profileRepository.getTrackFarm(context, status);

      if (response.farmlandId != null) {
        _trackFarmlandResponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Helper to update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Helper to clear errors
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
