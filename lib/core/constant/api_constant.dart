/// API Constants for the application
///
/// This file contains all API endpoints and configuration
class ApiConstant {
  // Base URL - يجب تغييرها حسب الـ backend الخاص بك
  // Example: 'https://api.yourdomain.com'
  // For development: 'http://localhost:8000' or 'http://10.0.2.2:8000' (Android emulator)
  // For testing: 'https://api-staging.yourdomain.com'
  static const String baseUrl = 'https://api.yourdomain.com/api/v1';

  // API Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // API Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';

  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';

  // Projects Endpoints
  static const String projects = '/projects';
  static const String projectDetails = '/projects/{id}';
  static const String createProject = '/projects';
  static const String updateProject = '/projects/{id}';
  static const String deleteProject = '/projects/{id}';
  static const String projectStats = '/projects/stats';

  // Tasks Endpoints
  static const String tasks = '/tasks';
  static const String taskDetails = '/tasks/{id}';
  static const String createTask = '/tasks';
  static const String updateTask = '/tasks/{id}';
  static const String deleteTask = '/tasks/{id}';
  static const String taskByProject = '/projects/{projectId}/tasks';

  // Team Endpoints
  static const String teamMembers = '/team/members';
  static const String teamMemberDetails = '/team/members/{id}';
  static const String addTeamMember = '/team/members';
  static const String updateTeamMember = '/team/members/{id}';
  static const String removeTeamMember = '/team/members/{id}';
  static const String teamByProject = '/projects/{projectId}/team';

  // Analytics Endpoints
  static const String analytics = '/analytics';
  static const String analyticsDashboard = '/analytics/dashboard';
  static const String analyticsProjects = '/analytics/projects';
  static const String analyticsTasks = '/analytics/tasks';

  // Settings Endpoints
  static const String settings = '/settings';
  static const String updateSettings = '/settings';
  static const String notifications = '/settings/notifications';

  // File Upload Endpoints
  static const String uploadFile = '/upload';
  static const String uploadAvatar = '/upload/avatar';

  // Helper method to replace path parameters
  static String replacePathParams(String path, Map<String, String> params) {
    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }

  // Helper method to build full URL
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

  // Helper method to build URL with path parameters
  static String buildUrlWithParams(
    String endpoint,
    Map<String, String> params,
  ) {
    final path = replacePathParams(endpoint, params);
    return buildUrl(path);
  }
}
