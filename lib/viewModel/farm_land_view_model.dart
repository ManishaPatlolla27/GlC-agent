import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/farmlands/farmland_home_response.dart';
import 'package:nex2u/models/farmlands/farmland_leads_response.dart';
import 'package:nex2u/models/farmlands/similar_request.dart';
import 'package:nex2u/models/filter/filter_states_model.dart';
import 'package:nex2u/repo/farm_land_repository.dart';

import '../models/farmlands/farm_land_response.dart';

class FarmLandViewModel with ChangeNotifier {
  List<FarmLandLeadList>? _bottomresponse = [];
  List<FarmLandList>? _farmlandresponse = [];
  List<FarmLandHomeList>? _farmlandhomeresponse = [];
  FarmLandResponse? _farmlandresponse2;
  List<FilterStateModel>? stateList;

  final FarmLandRepository farmRepository = FarmLandRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  List<FarmLandLeadList>? get bottomresponse => _bottomresponse;
  List<FarmLandList>? get farmlandresponse => _farmlandresponse;
  List<FarmLandHomeList>? get farmlandhomeresponse => _farmlandhomeresponse;
  FarmLandResponse? get farmlandresponse2 => _farmlandresponse2;
  List<FilterStateModel>? get getStateList => stateList;

  // Fetch farmland leads
  Future<void> getFarmLeads(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandLeadList>? response =
          await farmRepository.getFarmLeads(context);

      if (response != null && response.isNotEmpty) {
        _bottomresponse = response;
      } else {
        _errorMessage = 'No farm leads found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load farm leads: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Fetch farmland data based on status
  Future<void> getFarmLands(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandHomeList>? response =
          await farmRepository.getFarmLands(context, status);

      if (response != null) {
        _farmlandhomeresponse = response;
      } else {
        _errorMessage = 'No farmlands found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load farmlands: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Fetch 'See All' farmlands
  Future<void> getseeall(BuildContext context, String status) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      List<FarmLandList>? response =
          await farmRepository.getseeall(context, status);

      if (response != null && response.isNotEmpty) {
        _farmlandresponse = response;
      } else {
        _errorMessage = 'No data found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Fetch similar farmlands
  Future<void> getsimilar(
      BuildContext context, SimilarRequest similarRequest) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FarmLandResponse? response =
          await farmRepository.getsimilar(context, similarRequest);

      if (response != null) {
        _farmlandresponse2 = response;
      } else {
        _errorMessage = 'No similar farmland found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load similar farmlands: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Fetch states list
  Future<void> getStateListApi(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      final response = await farmRepository.getStateListService(context);

      if (response.stateList != null && response.stateList!.isNotEmpty) {
        stateList = response.stateList;
      } else {
        _errorMessage = 'No states found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load states: $e';
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
