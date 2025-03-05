import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/notifications/NotificationResponse.dart';

import '../repo/notification_repository.dart';

class NotificationViewModel with ChangeNotifier {
  late BuildContext context;
  NotificationResponse? _trackFarmlandResponse;
  final NotificationRepository _profileRepository = NotificationRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  NotificationResponse? get trackFarmlandResponse => _trackFarmlandResponse;

  // Fetch profile details
  Future<void> getNotification(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      NotificationResponse response =
          await _profileRepository.getDiscovery(context);

      if (response.notificationlist != null) {
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
