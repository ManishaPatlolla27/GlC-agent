import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/data/api_urls.dart';
import 'package:nex2u/data/base_api_client.dart';

import '../models/login/LoginRequest.dart';
import '../models/login/LoginResponse.dart';

class LoginRepository {
  final BaseApiClient _apiClient = BaseApiClient();
  final _storage = const FlutterSecureStorage();
  // Login method using BaseApiClient
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final response = await _apiClient.post<LoginResponse>(
        ApiConstants.loginUrl, // Your login endpoint
        loginRequest.toJson(), // Convert to JSON
        fromJson: (json) => LoginResponse.fromJson(json), // Parse response
        isJson: true, // Content-Type: application/json
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // // Login method using BaseApiClient
  // Future<OtpResponse> validateOtp(OtpRequest otpRequest) async {
  //   try {
  //     final response = await _apiClient.post<OtpResponse>(
  //       ApiConstants.otpUrl, // Your login endpoint
  //       otpRequest.toJson(), // Convert to JSON
  //       fromJson: (json) => OtpResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //     );
  //
  //     return response;
  //   } catch (e) {
  //     throw Exception('Otp Validation failed: $e');
  //   }
  // }
  //
  // Future<String?> getToken() async {
  //   return await _storage.read(key: 'auth_token');
  // }
  //
  // Future<PersonalDetailsResponse> personalDetailsApi(
  //   PersonalDetailsRequest request,
  // ) async {
  //   try {
  //     String? authToken = await getToken();
  //
  //     final headers = {
  //       'Authorization': 'Bearer $authToken',
  //       'Content-Type': 'application/json',
  //     };
  //
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //       ApiConstants.requestEmailOtp, // Your login endpoint
  //       request.toJson(), // Convert to JSON
  //       fromJson: (json) =>
  //           PersonalDetailsResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //       headers: headers, // Add headers including the Authorization token
  //     );
  //
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to log your personal details: $e');
  //   }
  // }
  //
  // Future<PersonalDetailsResponse> updateDobApi(DobRequest request) async {
  //   try {
  //     String? authToken = await getToken();
  //
  //     final headers = {
  //       'Authorization': 'Bearer $authToken',
  //       'Content-Type': 'application/json',
  //     };
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //         ApiConstants.addDob, // Your login endpoint
  //         request.toJson(), // Convert to JSON
  //         fromJson: (json) =>
  //             PersonalDetailsResponse.fromJson(json), // Parse response
  //         isJson: true,
  //         headers: headers // Content-Type: application/json
  //         );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to update DoB: $e');
  //   }
  // }
  //
  // Future<PersonalDetailsResponse> updateGenderApi(GenderRequest request) async {
  //   try {
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //       ApiConstants.gender, // Your login endpoint
  //       request.toJson(), // Convert to JSON
  //       fromJson: (json) =>
  //           PersonalDetailsResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to update Gender: $e');
  //   }
  // }
  //
  // Future<PersonalDetailsResponse> updateHeightApi(
  //     AddHeightRequest request) async {
  //   try {
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //       ApiConstants.height, // Your login endpoint
  //       request.toJson(), // Convert to JSON
  //       fromJson: (json) =>
  //           PersonalDetailsResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to update Height: $e');
  //   }
  // }
  //
  // Future<PersonalDetailsResponse> updateLanguagesApi(
  //     AddLanguageRequest request) async {
  //   try {
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //       ApiConstants.language, // Your login endpoint
  //       request.toJson(), // Convert to JSON
  //       fromJson: (json) =>
  //           PersonalDetailsResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to update Languages: $e');
  //   }
  // }
  //
  // Future<PersonalDetailsResponse> updateInterestsApi(
  //     AddInterestsRequest request) async {
  //   try {
  //     final response = await _apiClient.post<PersonalDetailsResponse>(
  //       ApiConstants.interest, // Your login endpoint
  //       request.toJson(), // Convert to JSON
  //       fromJson: (json) =>
  //           PersonalDetailsResponse.fromJson(json), // Parse response
  //       isJson: true, // Content-Type: application/json
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Unable to update Languages: $e');
  //   }
  // }
}
