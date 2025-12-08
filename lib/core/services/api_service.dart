import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/api_constant.dart';
import 'package:junior/core/services/auth_service.dart';
import 'package:junior/core/functions/checkinternet.dart';
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();
  final AuthService _authService = AuthService();
  Future<Either<StatusRequest, Map<String, dynamic>>> get(
    String endpoint, {
    Map<String, String>? queryParams,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }
      String url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);
      if (queryParams != null && queryParams.isNotEmpty) {
        final uri = Uri.parse(url);
        url = uri
            .replace(queryParameters: {...uri.queryParameters, ...queryParams})
            .toString();
      }
      debugPrint('🔵 GET Request URL: $url');
      debugPrint('🔵 Query params: $queryParams');
      final headers = await _buildHeaders(requiresAuth);
      debugPrint('🔵 Headers: $headers');
      debugPrint('🔵 Making GET request...');
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(ApiConstant.connectTimeout);
      debugPrint('🔵 Response status: ${response.statusCode}');
      debugPrint('🔵 Response body length: ${response.body.length}');
      debugPrint('🔵 Response body: ${response.body}');
      return _handleResponse(response);
    } catch (e, stackTrace) {
      debugPrint('🔴 GET request exception: $e');
      debugPrint('🔴 Exception type: ${e.runtimeType}');
      debugPrint('🔴 Stack trace: $stackTrace');
      if (e.toString().contains('TimeoutException')) {
        debugPrint('🔴 Timeout exception detected');
        return const Left(StatusRequest.timeoutException);
      }
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Failed host lookup') ||
          e.toString().contains('Network is unreachable')) {
        debugPrint('🔴 Network exception detected');
        return const Left(StatusRequest.offlineFailure);
      }
      debugPrint('🔴 Server exception detected');
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, Map<String, dynamic>>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    print('🔵 ====== API SERVICE POST CALLED ======');
    debugPrint('🔵 API SERVICE POST CALLED');
    print('Endpoint: $endpoint');
    final url = pathParams != null
        ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
        : ApiConstant.buildUrl(endpoint);
    try {
      print('🔵 ====== API POST Request ======');
      print('URL: $url');
      debugPrint('🔵 API POST Request:');
      debugPrint('URL: $url');
      final hasInternet = await checkInternet();
      if (!hasInternet) {
        debugPrint(
          '⚠️ Connectivity check failed, but proceeding with API call',
        );
        debugPrint(
          '💡 This is normal for real devices - API call will handle connection errors',
        );
        debugPrint(
          '💡 Make sure IP address is set correctly in api_constant.dart',
        );
      }
      final headers = await _buildHeaders(requiresAuth);
      final bodyJson = body != null ? jsonEncode(body) : null;
      debugPrint('Headers: $headers');
      debugPrint('Body: $bodyJson');
      debugPrint('📤 Sending HTTP POST request...');
      debugPrint(
        '⏱️ Timeout set to: ${ApiConstant.connectTimeout.inSeconds} seconds',
      );
      final response = await http
          .post(Uri.parse(url), headers: headers, body: bodyJson)
          .timeout(
            ApiConstant.connectTimeout,
            onTimeout: () {
              debugPrint(
                '⏰ REQUEST TIMEOUT after ${ApiConstant.connectTimeout.inSeconds} seconds',
              );
              debugPrint('🔴 Failed to connect to: $url');
              throw TimeoutException(
                'Connection timeout',
                ApiConstant.connectTimeout,
              );
            },
          );
      debugPrint('🟢 API Response received:');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      return _handleResponse(response);
    } catch (e, stackTrace) {
      debugPrint('🔴 API Error occurred:');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Error message: $e');
      debugPrint('Stack trace: $stackTrace');
      if (e is TimeoutException) {
        debugPrint(
          '⏰ TIMEOUT ERROR: Request took longer than ${ApiConstant.connectTimeout.inSeconds} seconds',
        );
        debugPrint('💡 Check if server is running and accessible at: $url');
        return const Left(StatusRequest.timeoutException);
      }
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Failed host lookup') ||
          e.toString().contains('Network is unreachable')) {
        debugPrint('🌐 NETWORK ERROR: Cannot reach server');
        debugPrint('💡 Check network connection and IP address: $url');
        return const Left(StatusRequest.offlineFailure);
      }
      if (e.toString().contains('Connection refused')) {
        debugPrint(
          '🚫 CONNECTION REFUSED: Server is not listening or firewall blocked',
        );
        debugPrint('💡 Make sure server is running on port 5000');
        return const Left(StatusRequest.offlineFailure);
      }
      debugPrint('❌ UNKNOWN ERROR: $e');
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, Map<String, dynamic>>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }
      final url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);
      final headers = await _buildHeaders(requiresAuth);
      final bodyJson = body != null ? jsonEncode(body) : null;
      final response = await http
          .put(Uri.parse(url), headers: headers, body: bodyJson)
          .timeout(ApiConstant.connectTimeout);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, Map<String, dynamic>>> delete(
    String endpoint, {
    Map<String, String>? pathParams,
    bool requiresAuth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }
      final url = pathParams != null
          ? ApiConstant.buildUrlWithParams(endpoint, pathParams)
          : ApiConstant.buildUrl(endpoint);
      final headers = await _buildHeaders(requiresAuth);
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(ApiConstant.connectTimeout);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        return const Left(StatusRequest.timeoutException);
      }
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Map<String, String>> _buildHeaders(bool requiresAuth) async {
    final headers = <String, String>{
      'Content-Type': ApiConstant.contentType,
      'Accept': ApiConstant.accept,
    };
    if (requiresAuth) {
      final token = await _authService.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
  Either<StatusRequest, Map<String, dynamic>> _handleResponse(
    http.Response response,
  ) {
    try {
      debugPrint('📥 Handling response with status: ${response.statusCode}');
      if (response.body.isEmpty) {
        debugPrint('🔴 Empty response body');
        return const Left(StatusRequest.serverException);
      }
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      debugPrint('📦 Parsed response body successfully');
      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint('✅ Success status code: ${response.statusCode}');
          return Right(responseBody);
        case 400:
          debugPrint('🔴 Bad Request (400)');
          debugPrint('Response: ${response.body}');
          return Right(responseBody);
        case 401:
          debugPrint('🔴 Unauthorized (401)');
          _authService.logout();
          return Right(responseBody);
        case 403:
          debugPrint('🔴 Forbidden (403) - Insufficient permissions/role');
          debugPrint('Response: ${response.body}');
          if (responseBody['message'] != null) {
            final message = responseBody['message'].toString();
            debugPrint('Error message: $message');
            if (message.contains('insufficient role') ||
                message.contains('Forbidden') ||
                message.contains('permission')) {
              debugPrint('⚠️ User does not have required permissions');
            }
          }
          return Right(responseBody);
        case 404:
          debugPrint('🔴 Not Found (404)');
          debugPrint('Response: ${response.body}');
          return Right(responseBody);
        case 500:
        case 502:
        case 503:
          debugPrint('🔴 Server Error (${response.statusCode})');
          debugPrint('Response: ${response.body}');
          return Right(responseBody);
        default:
          debugPrint('🔴 Unknown status code: ${response.statusCode}');
          debugPrint('Response: ${response.body}');
          return Right(responseBody);
      }
    } catch (e, stackTrace) {
      debugPrint('🔴 Error parsing response: $e');
      debugPrint('Response body: ${response.body}');
      debugPrint('Stack trace: $stackTrace');
      return const Left(StatusRequest.serverException);
    }
  }
}
