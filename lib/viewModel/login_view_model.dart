import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/login/LoginRequest.dart';
import '../models/login/LoginResponse.dart';
import '../page_routing/app_routes.dart';
import '../repo/login_repository.dart';
import '../res/validation_alert.dart';
import '../utils/internet_connectivity.dart';

class LoginViewModel with ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var context;

  validateAndLogin(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController) async {
    this.context = context;
    if (await isNetworkAvailable()) {
      // Simulate network request
      if (!context.mounted) return;
      await loginUser(emailController.text, passwordController.text, context);
    }
  }

  // Function to validate mobile number
  bool _validateMobileNumber(String mobileNumber) {
    const validNumberPattern = r"^[6-9][0-9]{9}$";
    RegExp regExp = RegExp(validNumberPattern);

    return regExp.hasMatch(mobileNumber);
  }

  final LoginRepository _loginRepository = LoginRepository();
  bool _isLoading = false;
  String errorMessage = '';

  bool get getLoadingStatus => _isLoading;

  String get getErrorMessage => errorMessage;

  // Call the login method
  Future<void> loginUser(
      String login, String password, BuildContext context) async {
    try {
      _setLoading(true);
      final request = LoginRequest(loginId: login, passCode: password);
      // Call the login method from LoginRepository
      LoginResponse response = await _loginRepository.login(request);

      // Handle success response
      if (response.accessToken != null) {
        if (!context.mounted) return;
        _showSuccessDialog('Loggedin successfully', context);
        const storage = FlutterSecureStorage();
        await storage.write(key: 'userloggedin', value: 'true');
        Navigator.pushNamed(context, AppRoutes.home);
        // You can also navigate to the next screen
        // Navigator.pushNamed(context, '/otpVerification');
      } else {
        // Handle failure case (e.g., OTP not sent)
        _showErrorDialog('Failed to send OTP: ${response.message}', context);
      }
    } catch (e) {
      // Handle any exceptions or network errors
      _showErrorDialog('Login failed: $e', context);
    } finally {
      _setLoading(false);
    }
  }

  // Helper to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Show success message or dialog
  void _showSuccessDialog(String message, BuildContext context) {
    ValidationIoSAlert().showAlert(context,
        description: message); // Implement your success dialog or snackbar here
    debugPrint(message); // or use showDialog, showSnackBar, etc.
  }

  // Show error message or dialog
  void _showErrorDialog(String message, BuildContext context) {
    ValidationIoSAlert().showAlert(context, description: message);
    debugPrint(message); // or use showDialog, showSnackBar, etc.
  }
}
