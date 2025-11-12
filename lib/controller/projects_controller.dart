import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/data/Models/project_model.dart';
import 'package:junior/data/repository/projects_repository.dart';

abstract class ProjectsController extends GetxController {
  List<ProjectModel> get projects;
  String get selectedFilter;
  StatusRequest get statusRequest;
  void selectFilter(String filter);
  void loadProjects();
}

class ProjectsControllerImp extends ProjectsController {
  final ProjectsRepository _repository = ProjectsRepository();

  List<ProjectModel> _projects = [];
  String _selectedFilter = 'All';
  StatusRequest _statusRequest = StatusRequest.none;

  @override
  List<ProjectModel> get projects => _projects;

  @override
  String get selectedFilter => _selectedFilter;

  @override
  StatusRequest get statusRequest => _statusRequest;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  @override
  void selectFilter(String filter) {
    _selectedFilter = filter;
    _updateProjects();
    update();
  }

  @override
  void loadProjects() async {
    _statusRequest = StatusRequest.loading;
    update();

    final result = await _repository.getProjects(
      status: _selectedFilter == 'All' ? null : _selectedFilter,
    );

    result.fold(
      (error) {
        _statusRequest = error;
        _projects = [];
        update();
      },
      (projects) {
        _projects = projects;
        _statusRequest = StatusRequest.success;
        update();
      },
    );
  }

  void _updateProjects() {
    // If we have projects loaded, filter them locally
    // Otherwise, reload from API
    if (_projects.isNotEmpty) {
      if (_selectedFilter == 'All') {
        loadProjects();
      } else {
        final filteredProjects = _projects
            .where((project) => project.status == _selectedFilter.toLowerCase())
            .toList();
        _projects = filteredProjects;
        update();
      }
    } else {
      loadProjects();
    }
  }

  /// Refresh projects list
  void refreshProjects() {
    loadProjects();
  }
}
