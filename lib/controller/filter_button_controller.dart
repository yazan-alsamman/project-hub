import 'package:get/get.dart';
import 'package:junior/controller/tasks_controller.dart';
import 'package:junior/controller/projects_controller.dart';

class FilterButtonController extends GetxController {
  String selectedFilter = 'All';

  void selectFilter(String filter) {
    selectedFilter = filter;
    update(); // This triggers GetBuilder to rebuild

    // Also update TasksController to rebuild filtered tasks
    if (Get.isRegistered<TasksControllerImp>()) {
      Get.find<TasksControllerImp>().update();
    }

    // Also update ProjectsController to rebuild filtered projects
    if (Get.isRegistered<ProjectsControllerImp>()) {
      Get.find<ProjectsControllerImp>().selectFilter(filter);
    }
  }

  bool isSelected(String filter) {
    return selectedFilter == filter;
  }
}
