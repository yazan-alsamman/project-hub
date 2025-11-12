import 'package:dartz/dartz.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/api_constant.dart';
import 'package:junior/core/services/api_service.dart';
import 'package:junior/data/Models/api_response_model.dart';
import 'package:junior/data/Models/project_model.dart';

/// Projects Repository
///
/// Handles all project-related API calls
///
/// Usage:
/// ```dart
/// final repository = ProjectsRepository();
/// final result = await repository.getProjects();
/// result.fold(
///   (error) => print('Error: $error'),
///   (projects) => print('Projects: $projects'),
/// );
/// ```
class ProjectsRepository {
  final ApiService _apiService = ApiService();

  /// Get all projects
  Future<Either<StatusRequest, List<ProjectModel>>> getProjects({
    String? status,
    int? page,
    int? perPage,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (status != null && status != 'All') {
        queryParams['status'] = status.toLowerCase();
      }
      if (page != null) {
        queryParams['page'] = page.toString();
      }
      if (perPage != null) {
        queryParams['per_page'] = perPage.toString();
      }

      // Make API call
      final result = await _apiService.get(
        ApiConstant.projects,
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<List<dynamic>>.fromJson(
            response,
            (data) => data as List<dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Convert to ProjectModel list
            final projects = apiResponse.data!
                .map(
                  (item) => ProjectModel.fromJson(item as Map<String, dynamic>),
                )
                .toList();
            return Right(projects);
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

  /// Get project by ID
  Future<Either<StatusRequest, ProjectModel>> getProjectById(String id) async {
    try {
      // Make API call
      final result = await _apiService.get(
        ApiConstant.projectDetails,
        pathParams: {'id': id},
      );

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Convert to ProjectModel
            final project = ProjectModel.fromJson(apiResponse.data!);
            return Right(project);
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

  /// Create new project
  Future<Either<StatusRequest, ProjectModel>> createProject(
    Map<String, dynamic> projectData,
  ) async {
    try {
      // Make API call
      final result = await _apiService.post(
        ApiConstant.createProject,
        body: projectData,
      );

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Convert to ProjectModel
            final project = ProjectModel.fromJson(apiResponse.data!);
            return Right(project);
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

  /// Update project
  Future<Either<StatusRequest, ProjectModel>> updateProject(
    String id,
    Map<String, dynamic> projectData,
  ) async {
    try {
      // Make API call
      final result = await _apiService.put(
        ApiConstant.updateProject,
        pathParams: {'id': id},
        body: projectData,
      );

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            // Convert to ProjectModel
            final project = ProjectModel.fromJson(apiResponse.data!);
            return Right(project);
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

  /// Delete project
  Future<Either<StatusRequest, bool>> deleteProject(String id) async {
    try {
      // Make API call
      final result = await _apiService.delete(
        ApiConstant.deleteProject,
        pathParams: {'id': id},
      );

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel.fromJson(response, null);

          if (apiResponse.success) {
            return const Right(true);
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

  /// Get project statistics
  Future<Either<StatusRequest, Map<String, dynamic>>> getProjectStats() async {
    try {
      // Make API call
      final result = await _apiService.get(ApiConstant.projectStats);

      return result.fold((error) => Left(error), (response) {
        try {
          // Parse response
          final apiResponse = ApiResponseModel<Map<String, dynamic>>.fromJson(
            response,
            (data) => data as Map<String, dynamic>,
          );

          if (apiResponse.success && apiResponse.data != null) {
            return Right(apiResponse.data!);
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
}
