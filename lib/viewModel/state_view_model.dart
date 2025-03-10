import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/states/filter_response.dart';
import 'package:nex2u/models/states/states_response.dart';
import 'package:nex2u/repo/state_repository.dart';

class StateViewModel with ChangeNotifier {
  late BuildContext context;
  StatesResponse? _stateResponse;
  FilterResponse? _filterResponse;
  final StateRepository _profileRepository = StateRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  StatesResponse? get stateResponse => _stateResponse;
  FilterResponse? get filterResponse => _filterResponse;

  // Fetch profile details
  Future<void> getstates(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      StatesResponse response = await _profileRepository.getstates(context);

      if (response.stateslist != null) {
        _stateResponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getregion(BuildContext context, String region) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      StatesResponse response =
          await _profileRepository.getregion(context, region);

      if (response.stateslist != null) {
        _stateResponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getarea(BuildContext context, String region) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      StatesResponse response =
          await _profileRepository.getarea(context, region);

      if (response.stateslist != null) {
        _stateResponse = response;
      } else {
        _errorMessage = 'Invalid profile data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load profile: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getfilter(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FilterResponse response = await _profileRepository.getfilter(context);

      if (response != null) {
        _filterResponse = response;
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
