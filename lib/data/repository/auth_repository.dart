import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/api_constant.dart';
import 'package:junior/core/services/api_service.dart';
import 'package:junior/core/services/auth_service.dart';
import 'package:junior/data/Models/api_response_model.dart';
class AuthRepository {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  Future<Either<StatusRequest, Map<String, dynamic>>> login({
    required String username,
    required String password,
  }) async {
    print('🔵 ====== AUTH REPOSITORY LOGIN CALLED ======');
    debugPrint('🔵 AuthRepository login called');
    print('Username: $username');
    print('Password length: ${password.length}');
    try {
      print('🔵 Calling API service...');
      final result = await _apiService.post(
        ApiConstant.login,
        body: {'username': username, 'password': password},
        requiresAuth: false,
      );
      print('🔵 API service returned result');
      return result.fold(
        (error) {
          debugPrint('🔴 AuthRepository login error: $error');
          return Left(error);
        },
        (response) async {
          try {
            debugPrint('🟢 AuthRepository login response received');
            debugPrint('Response keys: ${response.keys}');
            if (response['success'] == true && response['data'] != null) {
              final data = response['data'] as Map<String, dynamic>;
              debugPrint('Data keys: ${data.keys}');
              if (data['user'] == null) {
                debugPrint('🔴 User data is null');
                return const Left(StatusRequest.serverFailure);
              }
              final user = data['user'] as Map<String, dynamic>;
              debugPrint('User keys: ${user.keys}');
              String? companyId;
              if (user['companyId'] != null) {
                if (user['companyId'] is Map<String, dynamic>) {
                  companyId = (user['companyId'] as Map<String, dynamic>)['_id']
                      ?.toString();
                } else {
                  companyId = user['companyId']?.toString();
                }
              }
              await _authService.saveAuthData(
                token: data['token']?.toString() ?? '',
                refreshToken: data['refreshToken']?.toString() ?? '',
                userId: user['_id']?.toString() ?? '',
                email: user['email']?.toString() ?? '',
                username: user['username']?.toString() ?? username,
                role: user['role'] != null
                    ? (user['role'] as Map<String, dynamic>)['name']
                              ?.toString() ??
                          ''
                    : '',
              );
              if (companyId != null && companyId.isNotEmpty) {
                await _authService.saveCompanyId(companyId);
                debugPrint('✅ CompanyId saved: $companyId');
              } else {
                debugPrint('⚠️ CompanyId not found in user data');
              }
              debugPrint('✅ Authentication data saved successfully');
              return Right(response);
            } else {
              debugPrint(
                '🔴 Login failed: success=${response['success']}, data=${response['data']}',
              );
              debugPrint('Message: ${response['message']}');
              return const Left(StatusRequest.serverFailure);
            }
          } catch (e, stackTrace) {
            debugPrint('🔴 Login parsing error: $e');
            debugPrint('Stack trace: $stackTrace');
            return const Left(StatusRequest.serverException);
          }
        },
      );
    } catch (e) {
      debugPrint('Login error: $e');
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final result = await _apiService.post(
        ApiConstant.register,
        body: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
        requiresAuth: false,
      );
      return result.fold((error) => Left(error), (response) async {
        try {
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );
          if (apiResponse.success && apiResponse.data != null) {
            final data = apiResponse.data!;
            if (data['token'] != null) {
              await _authService.saveAuthData(
                token: data['token'] ?? '',
                refreshToken: data['refresh_token'] ?? '',
                userId: data['user']['id']?.toString() ?? '',
                email: data['user']['email'] ?? email,
              );
            }
            return Right(data);
          } else {
            return const Left(StatusRequest.serverFailure);
          }
        } catch (e) {
          return const Left(StatusRequest.serverException);
        }
      });
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, bool>> logout() async {
    debugPrint('🚪 Logout called');
    try {
      final refreshTokenValue = await _authService.getRefreshToken();
      Map<String, dynamic>? body;
      if (refreshTokenValue != null && refreshTokenValue.isNotEmpty) {
        body = {'refreshToken': refreshTokenValue};
        debugPrint('🔵 Sending logout request with refreshToken');
      } else {
        debugPrint('⚠️ No refresh token found, sending logout without it');
      }
      final result = await _apiService.post(
        ApiConstant.logout,
        body: body,
        requiresAuth: true, // May need auth token
      );
      await _authService.logout();
      debugPrint('✅ Local authentication data cleared');
      return result.fold(
        (error) {
          debugPrint('⚠️ Logout API failed, but logged out locally: $error');
          return const Right(true);
        },
        (response) {
          try {
            debugPrint('🟢 Logout API response received');
            debugPrint('Response keys: ${response.keys}');
            if (response['success'] == true) {
              debugPrint('✅ Logout successful');
              return const Right(true);
            } else {
              debugPrint(
                '⚠️ Logout response indicates failure, but logged out locally',
              );
              return const Right(true);
            }
          } catch (e) {
            debugPrint('⚠️ Error parsing logout response: $e');
            return const Right(true);
          }
        },
      );
    } catch (e) {
      debugPrint('🔴 Logout error: $e');
      await _authService.logout();
      return const Right(true);
    }
  }
  Future<Either<StatusRequest, Map<String, dynamic>>> refreshToken() async {
    debugPrint('🔄 Refresh token called');
    try {
      final refreshTokenValue = await _authService.getRefreshToken();
      if (refreshTokenValue == null || refreshTokenValue.isEmpty) {
        debugPrint('🔴 No refresh token found');
        return const Left(StatusRequest.serverFailure);
      }
      debugPrint('🔵 Calling refresh token API...');
      final result = await _apiService.post(
        ApiConstant.refreshToken,
        body: {'refreshToken': refreshTokenValue},
        requiresAuth: false,
      );
      return result.fold(
        (error) {
          debugPrint('🔴 Refresh token error: $error');
          return Left(error);
        },
        (response) async {
          try {
            debugPrint('🟢 Refresh token response received');
            debugPrint('Response keys: ${response.keys}');
            if (response['success'] == true && response['data'] != null) {
              final data = response['data'] as Map<String, dynamic>;
              debugPrint('Data keys: ${data.keys}');
              final newToken = data['token']?.toString() ?? '';
              final newRefreshToken = data['refreshToken']?.toString() ?? '';
              if (newToken.isEmpty) {
                debugPrint('🔴 New token is empty');
                return const Left(StatusRequest.serverFailure);
              }
              await _authService.saveToken(newToken);
              if (newRefreshToken.isNotEmpty) {
                await _authService.saveRefreshToken(newRefreshToken);
              }
              debugPrint('✅ Tokens refreshed successfully');
              return Right(response);
            } else {
              debugPrint(
                '🔴 Refresh token failed: success=${response['success']}, data=${response['data']}',
              );
              debugPrint('Message: ${response['message']}');
              return const Left(StatusRequest.serverFailure);
            }
          } catch (e, stackTrace) {
            debugPrint('🔴 Refresh token parsing error: $e');
            debugPrint('Stack trace: $stackTrace');
            return const Left(StatusRequest.serverException);
          }
        },
      );
    } catch (e) {
      debugPrint('🔴 Refresh token error: $e');
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, bool>> forgotPassword(String email) async {
    try {
      final result = await _apiService.post(
        ApiConstant.forgotPassword,
        body: {'email': email},
        requiresAuth: false,
      );
      return result.fold((error) => Left(error), (response) {
        try {
          final apiResponse = ApiResponseModel.fromJson(response, null);
          return Right(apiResponse.success);
        } catch (e) {
          return const Left(StatusRequest.serverException);
        }
      });
    } catch (e) {
      return const Left(StatusRequest.serverException);
    }
  }
}
