import 'package:dartz/dartz.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/api_constant.dart';
import 'package:junior/core/services/api_service.dart';
import 'package:junior/core/services/auth_service.dart';
import 'package:junior/data/Models/api_response_model.dart';

/// Authentication Repository
///
/// Handles authentication-related API calls
class AuthRepository {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  /// Login user
  Future<Either<StatusRequest, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Make API call
      final result = await _apiService.post(
        ApiConstant.login,
        body: {'email': email, 'password': password},
        requiresAuth: false,
      );

      return result.fold((error) => Left(error), (response) async {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Save authentication data
            final data = apiResponse.data!;
            await _authService.saveAuthData(
              token: data['token'] ?? '',
              refreshToken: data['refresh_token'] ?? '',
              userId: data['user']['id']?.toString() ?? '',
              email: data['user']['email'] ?? email,
            );

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

  /// Register user
  Future<Either<StatusRequest, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      // Make API call
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
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Save authentication data if token is provided
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

  /// Logout user
  Future<Either<StatusRequest, bool>> logout() async {
    try {
      // Make API call
      final result = await _apiService.post(ApiConstant.logout);

      // Clear local authentication data regardless of API response
      await _authService.logout();

      return result.fold(
        (error) => const Right(true), // Logout locally even if API fails
        (response) {
          try {
            final apiResponse = ApiResponseModel.fromJson(response, null);
            return Right(apiResponse.success);
          } catch (e) {
            return const Right(true);
          }
        },
      );
    } catch (e) {
      // Clear local data even if API call fails
      await _authService.logout();
      return const Right(true);
    }
  }

  /// Refresh authentication token
  Future<Either<StatusRequest, String>> refreshToken() async {
    try {
      final refreshToken = await _authService.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return const Left(StatusRequest.serverFailure);
      }

      // Make API call
      final result = await _apiService.post(
        ApiConstant.refreshToken,
        body: {'refresh_token': refreshToken},
        requiresAuth: false,
      );

      return result.fold((error) => Left(error), (response) async {
        try {
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            final token = apiResponse.data!['token'] as String;
            await _authService.saveToken(token);
            return Right(token);
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

  /// Forgot password
  Future<Either<StatusRequest, bool>> forgotPassword(String email) async {
    try {
      // Make API call
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
