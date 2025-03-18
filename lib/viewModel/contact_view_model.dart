import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/models/resources/faq_response.dart';
import 'package:nex2u/repo/contact_repository.dart';

import '../models/resources/create_message.dart';

class ContactViewModel with ChangeNotifier {
  late BuildContext context;
  FaqResponse? _faqresponse;
  final ContactRepository _profileRepository = ContactRepository();
  bool _isLoading = false;
  String _errorMessage = '';

  bool _otpSent = false;

  bool get otpSent => _otpSent;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Getters
  bool get getLoadingStatus => _isLoading;
  String get getErrorMessage => _errorMessage;
  FaqResponse? get faqresponse => _faqresponse;

  // Fetch profile details
  Future<void> getfaq(BuildContext context) async {
    try {
      _setLoading(true);
      _errorMessage = '';

      FaqResponse response = await _profileRepository.getfaq(context);

      if (response.faqs != null) {
        _faqresponse = response;
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

  Future<void> createmessage(
      CreateMessage createAlertRequest, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _otpSent =
        await _profileRepository.createmessage(createAlertRequest, context);

    _isLoading = false;
    notifyListeners();
  }
}
