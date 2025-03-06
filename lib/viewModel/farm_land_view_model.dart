import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/farmlands/farmland_leads_response.dart';
import 'package:nex2u/models/farmlands/similar_request.dart';
import 'package:nex2u/repo/farm_land_repository.dart';

import '../models/farmlands/farm_land_response.dart';

class FarmLandViewModel with ChangeNotifier {
  late BuildContext context;
  List<FarmLandLeadList>? _bottomresponse = [];
  List<FarmLandList>? _farmlandresponse = [];
  FarmLandResponse? _farmlandresponse2;
  final FarmLandRepository _profileRepository = FarmLandRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<FarmLandLeadList>? get bottomresponse => _bottomresponse;
  List<FarmLandList>? get farmlandresponse => _farmlandresponse;
  FarmLandResponse? get farmlandresponse2 => _farmlandresponse2;
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

  Future<void> getsimilar(
      BuildContext context, SimilarRequest similarrequest) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FarmLandResponse response =
          await _profileRepository.getsimilar(context, similarrequest);

      if (response.farmlandlist.isNotEmpty) {
        _farmlandresponse2 = response;
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

  Future<void> getStateList(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      final response = await _profileRepository.getStateList(context);

      if ((response.stateList ?? []).isNotEmpty) {
        // _farmlandresponse2 = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }
}
