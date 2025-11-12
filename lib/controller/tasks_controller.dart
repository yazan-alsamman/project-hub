import 'package:get/get.dart';
import 'package:junior/data/Models/task_model.dart';
import 'package:junior/controller/filter_button_controller.dart';

abstract class TasksController extends GetxController {}

class TasksControllerImp extends TasksController {
  List<TaskModel> allTasks = [
    TaskModel(
      title: "Implement user authentication API",
      subtitle: "OAuth2 implementation with JWT tokens",
      category: "E-Commerce Platform",
      priority: "High",
      dueDate: "Dec 8, 2024",
      assigneeName: "John Dev",
      assigneeInitials: "JD",
      status: "In Progress",
      priorityColor: "error",
      avatarColor: "primary",
    ),
    TaskModel(
      title: "Design mobile app wireframes",
      subtitle: "Create UX mockups for iOS and Android",
      category: "Product Design",
      priority: "Medium",
      dueDate: "Dec 12, 2024",
      assigneeName: "Sarah Designer",
      assigneeInitials: "SD",
      status: "In Progress",
      priorityColor: "orange",
      avatarColor: "purple",
    ),
    TaskModel(
      title: "Write API documentation",
      subtitle: "Document all REST endpoints and examples",
      category: "Documentation",
      priority: "Low",
      dueDate: "Dec 15, 2024",
      assigneeName: "Alex Writer",
      assigneeInitials: "AW",
      status: "In Progress",
      priorityColor: "green",
      avatarColor: "blue",
    ),
    TaskModel(
      title: "Design landing page mockups",
      subtitle: "Create 3 variations for A/B testing",
      category: "Mobile App Redesign",
      priority: "High",
      dueDate: "Nov 25, 2024",
      assigneeName: "Sarah Design",
      assigneeInitials: "SD",
      status: "Completed",
      priorityColor: "error",
      avatarColor: "purple",
    ),
    TaskModel(
      title: "API documentation",
      subtitle: "Complete OpenAPI spec and examples",
      category: "API Integration",
      priority: "Medium",
      dueDate: "Dec 15, 2024",
      assigneeName: "Mike Tech Writer",
      assigneeInitials: "MTW",
      status: "Pending",
      priorityColor: "orange",
      avatarColor: "purple",
    ),
  ];

  List<TaskModel> get filteredTasks {
    final filterController = Get.find<FilterButtonController>();
    if (filterController.selectedFilter == 'All') {
      return allTasks;
    }
    return allTasks
        .where((task) => task.status == filterController.selectedFilter)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
