import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nex2u/data/api_urls.dart';

class BaseApiClient {
  late Dio _dio;
  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  BaseApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? authToken = await getToken();
        options.headers['Authorization'] = 'Bearer $authToken';

        log("""
[API Request]
URL: ${options.uri}
Method: ${options.method}
Headers: ${options.headers}
Query Parameters: ${options.queryParameters}
Body: ${options.data}
  """);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log("""
[API Response]
URL: ${response.requestOptions.uri}
Status Code: ${response.statusCode}
Headers: ${response.headers}
Data: ${response.data}
""");
        return handler.next(response);
      },
      onError: (error, handler) {
        log("""
[API Error]
URL: ${error.requestOptions.uri}
Error: ${error.message}
Status Code: ${error.response?.statusCode}
Error Data: ${error.response?.data}
Error Headers: ${error.response?.headers}
""");
        return handler.next(error);
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }

  Future<T> get<T>(
    String url, {
    required T Function(dynamic) fromJson,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    bool isJson = true,
  }) async {
    try {
      final options = Options(
        headers: headers ?? {},
        contentType: isJson ? 'application/json' : 'application/octet-stream',
      );

      Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: options,
      );
      debugPrint("Response Data: ${response.data}");
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> post<T>(
    String url,
    dynamic payload, {
    required T Function(dynamic) fromJson,
    Map<String, String>? headers,
    bool isFormData = false,
    bool isJson = true,
    bool isMultipart = false,
  }) async {
    try {
      final options = Options(
        headers: headers ?? {},
        contentType: isFormData
            ? 'application/x-www-form-urlencoded'
            : isJson
                ? 'application/json'
                : isMultipart
                    ? 'multipart/form-data'
                    : 'application/octet-stream',
      );

      debugPrint("POST Request to: $url");
      debugPrint("Headers: ${options.headers}");
      debugPrint("Payload: $payload");

      Response response;
      if (isMultipart) {
        response = await _dio.post(url,
            data: FormData.fromMap(payload), options: options);
      } else {
        response = await _dio.post(url, data: payload, options: options);
      }

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");

      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      debugPrint("DioException: ${e.message}");
      debugPrint("DioException Details: ${e.response?.data}");
      _handleError(e);
      rethrow;
    }
  }

  /// **New PUT Method**
  Future<T> put<T>(
    String url, {
    dynamic payload,
    required T Function(dynamic) fromJson,
    Map<String, String>? headers,
    bool isJson = true,
  }) async {
    try {
      final options = Options(
        headers: headers ?? {},
        contentType: isJson ? 'application/json' : 'application/octet-stream',
      );

      Response response = await _dio.put(
        url,
        data: payload,
        options: options,
      );

      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<dynamic> postWithoutJson(
    String url,
    dynamic payload, {
    Map<String, String>? headers,
    bool isFormData = false,
    bool isJson = true,
    bool isMultipart = false,
  }) async {
    try {
      final options = Options(
        headers: headers ?? {},
        contentType: isFormData
            ? 'application/x-www-form-urlencoded'
            : isJson
                ? 'application/json'
                : isMultipart
                    ? 'multipart/form-data'
                    : 'application/octet-stream',
      );

      Response response;
      if (isMultipart) {
        response = await _dio.post(url,
            data: FormData.fromMap(payload), options: options);
      } else {
        response = await _dio.post(url, data: payload, options: options);
      }

      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  T _handleResponse<T>(Response response, T Function(dynamic) fromJson) {
    if (response.statusCode == 200) {
      return fromJson(response.data);
    } else if (response.statusCode == 201) {
      return fromJson(response.data);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void _handleError(DioException error) {
    if (error.response != null) {
      final int statusCode = error.response?.statusCode ?? 0;
      switch (statusCode) {
        case 400:
          throw Exception('Bad Request: ${error.response?.data}');
        case 401:
          throw Exception('Unauthorized');
        case 500:
          throw Exception('Internal Server Error');
        default:
          throw Exception('An unknown error occurred');
      }
    } else {
      throw Exception('Network error or timeout');
    }
  }
}
