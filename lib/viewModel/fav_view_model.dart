import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/favourite/favourite_response.dart';
import 'package:nex2u/repo/fav_repository.dart';

class FavViewModel with ChangeNotifier {
  late BuildContext context;
  FavouriteResponse? _favResponse;
  final FavRepository _profileRepository = FavRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  FavouriteResponse? get favResponse => _favResponse;

  // Fetch profile details
  Future<void> getfav(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FavouriteResponse response = await _profileRepository.getfav(context);

      if (response.favlist != null) {
        _favResponse = response;
      } else {
        _errorMessage = 'Invalid fav data received';
      }
    } catch (e) {
      _errorMessage = 'Failed to load fav: $e';
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
