import 'package:get/get.dart';
import 'package:junior/core/services/services.dart';

/// Authentication Service
///
/// Handles:
/// - Token storage and retrieval
/// - User authentication state
/// - Login/logout functionality
class AuthService {
  // Get shared preferences instance
  final Myservices _services = Get.find();

  // Token keys
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  /// Save authentication token
  Future<void> saveToken(String token) async {
    await _services.sharedPreferences.setString(_tokenKey, token);
  }

  /// Get authentication token
  Future<String?> getToken() async {
    return _services.sharedPreferences.getString(_tokenKey);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String refreshToken) async {
    await _services.sharedPreferences.setString(_refreshTokenKey, refreshToken);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return _services.sharedPreferences.getString(_refreshTokenKey);
  }

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    await _services.sharedPreferences.setString(_userIdKey, userId);
  }

  /// Get user ID
  Future<String?> getUserId() async {
    return _services.sharedPreferences.getString(_userIdKey);
  }

  /// Save user email
  Future<void> saveUserEmail(String email) async {
    await _services.sharedPreferences.setString(_userEmailKey, email);
  }

  /// Get user email
  Future<String?> getUserEmail() async {
    return _services.sharedPreferences.getString(_userEmailKey);
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all authentication data
  Future<void> logout() async {
    await _services.sharedPreferences.remove(_tokenKey);
    await _services.sharedPreferences.remove(_refreshTokenKey);
    await _services.sharedPreferences.remove(_userIdKey);
    await _services.sharedPreferences.remove(_userEmailKey);
  }

  /// Save authentication data
  Future<void> saveAuthData({
    required String token,
    required String refreshToken,
    required String userId,
    required String email,
  }) async {
    await saveToken(token);
    await saveRefreshToken(refreshToken);
    await saveUserId(userId);
    await saveUserEmail(email);
  }
}
