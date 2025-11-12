import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/controller/customDrawer_controller.dart';
import 'package:junior/controller/tasks_controller.dart';
import 'package:junior/controller/filter_button_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/view/widgets/common/custom_app_bar.dart';
import 'package:junior/view/widgets/common/custom_drawer.dart';
import 'package:junior/view/widgets/common/filter_button.dart';
import 'package:junior/view/widgets/common/header.dart';
import 'package:junior/view/widgets/common/task_card.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerControllerImp customDrawerController =
        Get.find<CustomDrawerControllerImp>();

    return Scaffold(
      drawer: CustomDrawer(
        onItemTap: (item) {
          customDrawerController.onMenuItemTap(item);
        },
      ),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColor.backgroundColor,
              child: GetBuilder<TasksControllerImp>(
                builder: (controller) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: "Tasks",
                        subtitle: "Track and manage all your project tasks",
                        buttonText: "New Task",
                        buttonIcon: Icons.add,
                        onPressed: () {},
                      ),

                      const SizedBox(height: 30),
                      GetBuilder<FilterButtonController>(
                        builder: (filterController) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: AppColor.textSecondaryColor,
                              ),
                              const SizedBox(width: 12),
                              FilterButton(
                                text: "All",
                                isSelected:
                                    filterController.selectedFilter == 'All',
                                onPressed: () =>
                                    filterController.selectFilter('All'),
                              ),
                              const SizedBox(width: 8),
                              FilterButton(
                                text: "In Progress",
                                isSelected:
                                    filterController.selectedFilter ==
                                    'In Progress',
                                onPressed: () => filterController.selectFilter(
                                  'In Progress',
                                ),
                              ),
                              const SizedBox(width: 8),
                              FilterButton(
                                text: "Completed",
                                isSelected:
                                    filterController.selectedFilter ==
                                    'Completed',
                                onPressed: () =>
                                    filterController.selectFilter('Completed'),
                              ),
                              const SizedBox(width: 8),
                              FilterButton(
                                text: "Pending",
                                isSelected:
                                    filterController.selectedFilter ==
                                    'Pending',
                                onPressed: () =>
                                    filterController.selectFilter('Pending'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tasks List
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Task Cards - Dynamic Filtering
                  GetBuilder<TasksControllerImp>(
                    builder: (tasksController) {
                      final filteredTasks = tasksController.filteredTasks;
                      return Column(
                        children: filteredTasks.map((task) {
                          Color priorityColor;
                          Color avatarColor;
                          bool isCompleted = task.status == 'Completed';
                          bool isPending = task.status == 'Pending';

                          // Parse priority color
                          switch (task.priorityColor) {
                            case 'error':
                              priorityColor = AppColor.errorColor;
                              break;
                            case 'orange':
                              priorityColor = Colors.orange;
                              break;
                            case 'green':
                              priorityColor = Colors.green;
                              break;
                            default:
                              priorityColor = AppColor.errorColor;
                          }

                          // Parse avatar color
                          switch (task.avatarColor) {
                            case 'primary':
                              avatarColor = AppColor.primaryColor;
                              break;
                            case 'purple':
                              avatarColor = Colors.purple;
                              break;
                            case 'blue':
                              avatarColor = Colors.blue;
                              break;
                            default:
                              avatarColor = AppColor.primaryColor;
                          }

                          return TaskCard(
                            title: task.title,
                            subtitle: task.subtitle,
                            category: task.category,
                            priority: task.priority,
                            dueDate: task.dueDate,
                            assigneeName: task.assigneeName,
                            assigneeInitials: task.assigneeInitials,
                            priorityColor: priorityColor,
                            avatarColor: avatarColor,
                            isCompleted: isCompleted,
                            isPending: isPending,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
