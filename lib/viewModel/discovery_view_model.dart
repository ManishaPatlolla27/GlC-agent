import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/discovery/discovery_response.dart';
import 'package:nex2u/repo/discovery_repository.dart';

class DiscoveryViewModel with ChangeNotifier {
  late BuildContext context;
  DiscoveryResponse? _trackFarmlandResponse;
  final DiscoveryRepository _profileRepository = DiscoveryRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  DiscoveryResponse? get trackFarmlandResponse => _trackFarmlandResponse;

  // Fetch profile details
  Future<void> getDiscovery(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      DiscoveryResponse response =
          await _profileRepository.getDiscovery(context);

      if (response.bottomlist != null) {
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
