import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/farmlands/FramlandLeadsResponse.dart';
import 'package:nex2u/repo/farm_land_repository.dart';

import '../models/farmlands/FarmLandResponse.dart';

class FarmLandViewModel with ChangeNotifier {
  late BuildContext context;
  List<FarmLandLeadList>? _bottomresponse = [];
  List<FarmLandList>? _farmlandresponse = [];
  final FarmLandRepository _profileRepository = FarmLandRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<FarmLandLeadList>? get bottomresponse => _bottomresponse;
  List<FarmLandList>? get farmlandresponse => _farmlandresponse;

  // Fetch profile details
  Future<void> getFarmLeads(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandLeadList> response =
          await _profileRepository.getFarmLeads(context);

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

  Future<void> getFarmLands(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandList> response =
          await _profileRepository.getFarmLands(context, status);

      if (response.isNotEmpty) {
        _farmlandresponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getseeall(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandList> response =
          await _profileRepository.getseeall(context, status);

      if (response.isNotEmpty) {
        _farmlandresponse = response;
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
