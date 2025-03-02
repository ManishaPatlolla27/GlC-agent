import 'package:flutter/material.dart';
import 'package:nex2u/repo/forgot_repository.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotRepository _forgotPasswordRepository = ForgotRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _otpSent = false;
  bool get otpSent => _otpSent;

  Future<void> requestOtp(String loginId) async {
    _isLoading = true;
    notifyListeners();

    _otpSent = await _forgotPasswordRepository.sendOtp(loginId);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> validateOtp(String loginId, String otp) async {
    _isLoading = true;
    notifyListeners();

    _otpSent = await _forgotPasswordRepository.validateOtp(
        verificationCode: otp, loginId: loginId);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changepassword(String loginId, String otp) async {
    _isLoading = true;
    notifyListeners();

    _otpSent = await _forgotPasswordRepository.changepassword(
        loginId: loginId, password: otp);

    _isLoading = false;
    notifyListeners();
  }
}
