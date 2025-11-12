import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/api_constant.dart';
import 'package:junior/core/services/auth_service.dart';
import 'package:junior/core/functions/checkinternet.dart';

/// API Service - Main service for handling all HTTP requests
///
/// This service handles:
/// - GET, POST, PUT, DELETE requests
/// - Authentication headers
/// - Error handling
/// - Response parsing
/// - Network connectivity checks
class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Get auth service instance
  final AuthService _authService = AuthService();

  /// Make GET request
  Future<Either<StatusRequest, Map<String, dynamic>>> get(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      // Check internet connection
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      // Build URL
      String url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);

      // Add query parameters
      if (queryParams != null && queryParams.isNotEmpty) {
        final uri = Uri.parse(url);
        url = uri
            .replace(queryParameters: {...uri.queryParameters, ...queryParams})
            .toString();
      }

      // Prepare headers
      final headers = await _buildHeaders(requiresAuth);

      // Make request
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(ApiConstant.connectTimeout);

      // Handle response
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }

  /// Make POST request
  Future<Either<StatusRequest, Map<String, dynamic>>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      // Check internet connection
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      // Build URL
      final url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);

      // Prepare headers
      final headers = await _buildHeaders(requiresAuth);

      // Prepare body
      final bodyJson = body != null ? jsonEncode(body) : null;

      // Make request
      final response = await http
          .post(Uri.parse(url), headers: headers, body: bodyJson)
          .timeout(ApiConstant.connectTimeout);

      // Handle response
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }

  /// Make PUT request
  Future<Either<StatusRequest, Map<String, dynamic>>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      // Check internet connection
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      // Build URL
      final url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);

      // Prepare headers
      final headers = await _buildHeaders(requiresAuth);

      // Prepare body
      final bodyJson = body != null ? jsonEncode(body) : null;

      // Make request
      final response = await http
          .put(Uri.parse(url), headers: headers, body: bodyJson)
          .timeout(ApiConstant.connectTimeout);

      // Handle response
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }

  /// Make DELETE request
  Future<Either<StatusRequest, Map<String, dynamic>>> delete(
    String endpoint, {
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      // Check internet connection
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      // Build URL
      final url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);

      // Prepare headers
      final headers = await _buildHeaders(requiresAuth);

      // Make request
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(ApiConstant.connectTimeout);

      // Handle response
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }

  /// Build headers with authentication
  Future<Map<String, String>> _buildHeaders(bool requiresAuth) async {
    final headers = <String, String>{
      'Content-Type': ApiConstant.contentType,
      'Accept': ApiConstant.accept,
    };

    // Add authentication token if required
    if (requiresAuth) {
      final token = await _authService.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  /// Handle HTTP response
  Either<StatusRequest, Map<String, dynamic>> _handleResponse(
    http.Response response,
  ) {
    try {
      // Parse response body
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Check status code
      switch (response.statusCode) {
        case 200:
        case 201:
          return Right(responseBody);
        case 400:
          // Bad Request
          return const Left(StatusRequest.serverFailure);
        case 401:
          // Unauthorized - Token expired or invalid
          _authService.logout();
          return const Left(StatusRequest.serverFailure);
        case 403:
          // Forbidden
          return const Left(StatusRequest.serverFailure);
        case 404:
          // Not Found
          return const Left(StatusRequest.serverFailure);
        case 500:
        case 502:
        case 503:
          // Server Error
          return const Left(StatusRequest.serverFailure);
        default:
          return const Left(StatusRequest.serverFailure);
      }
    } catch (e) {
      // Invalid JSON response
      return const Left(StatusRequest.serverException);
    }
  }
}
