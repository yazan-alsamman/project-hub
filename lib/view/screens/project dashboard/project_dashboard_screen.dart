import 'package:flutter/material.dart';
import 'package:junior/controller/customDrawer_controller.dart';
import 'package:get/get.dart';
import 'package:junior/controller/project_dashboard_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/responsive.dart';
import 'package:junior/core/constant/routes.dart';

import 'package:junior/view/widgets/common/custom_app_bar.dart';
import 'package:junior/view/widgets/common/custom_drawer.dart';
import 'package:junior/view/widgets/common/project_dashboard_card.dart';
import 'package:junior/view/widgets/common/project_dashboard_information_card.dart';
import 'package:junior/view/widgets/common/sort_dropdown.dart';

class ProjectDashboardScreen extends StatelessWidget {
  const ProjectDashboardScreen({super.key});

  void _showProjectOptions(BuildContext context, project) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Project'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share Project'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete Project',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
              child: GetBuilder<ProjectDashboardControllerImp>(
                builder: (controller) => Padding(
                  padding: Responsive.padding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Sort Dropdown
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Projects",
                              style: TextStyle(
                                fontSize: Responsive.fontSize(
                                  context,
                                  mobile: 24,
                                ),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          SortDropdown(
                            selectedOption: controller.selectedSortOption,
                            onChanged: (option) {
                              controller.changeSortOption(option);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.spacing(context, mobile: 20)),

                      // Dashboard Cards - Grid Layout for Tablets
                      Responsive.isTablet(context) ||
                              Responsive.isDesktop(context)
                          ? GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: Responsive.columnCount(context),
                              crossAxisSpacing: Responsive.spacing(
                                context,
                                mobile: 16,
                              ),
                              mainAxisSpacing: Responsive.spacing(
                                context,
                                mobile: 16,
                              ),
                              childAspectRatio: 2.5,
                              children: [
                                ProjectDashboardCard(
                                  title: "Active Projects",
                                  value: "24",
                                  icon: Icons.folder,
                                  backgroundColor: const Color(0xFF3B82F6),
                                  iconBackgroundColor: const Color(0xFF60A5FA),
                                ),
                                ProjectDashboardCard(
                                  title: "Total Tasks",
                                  value: "156",
                                  icon: Icons.check_box,
                                  backgroundColor: const Color(0xFF8B5CF6),
                                  iconBackgroundColor: const Color(0xFFA78BFA),
                                ),
                                ProjectDashboardCard(
                                  title: "Team Members",
                                  value: "18",
                                  icon: Icons.people,
                                  backgroundColor: const Color(0xFF10B981),
                                  iconBackgroundColor: const Color(0xFF34D399),
                                ),
                                ProjectDashboardCard(
                                  title: "Completion Rate",
                                  value: "87%",
                                  icon: Icons.emoji_events,
                                  backgroundColor: const Color(0xFFF59E0B),
                                  iconBackgroundColor: const Color(0xFFFBBF24),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // Active Projects Card
                                SizedBox(
                                  width: double.infinity,
                                  height: Responsive.containerHeight(
                                    context,
                                    mobile: 120,
                                  ),
                                  child: ProjectDashboardCard(
                                    title: "Active Projects",
                                    value: "24",
                                    icon: Icons.folder,
                                    backgroundColor: const Color(0xFF3B82F6),
                                    iconBackgroundColor: const Color(
                                      0xFF60A5FA,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: Responsive.spacing(
                                    context,
                                    mobile: 16,
                                  ),
                                ),

                                // Total Tasks Card
                                SizedBox(
                                  width: double.infinity,
                                  height: Responsive.containerHeight(
                                    context,
                                    mobile: 120,
                                  ),
                                  child: ProjectDashboardCard(
                                    title: "Total Tasks",
                                    value: "156",
                                    icon: Icons.check_box,
                                    backgroundColor: const Color(0xFF8B5CF6),
                                    iconBackgroundColor: const Color(
                                      0xFFA78BFA,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: Responsive.spacing(
                                    context,
                                    mobile: 16,
                                  ),
                                ),

                                // Team Members Card
                                SizedBox(
                                  width: double.infinity,
                                  height: Responsive.containerHeight(
                                    context,
                                    mobile: 120,
                                  ),
                                  child: ProjectDashboardCard(
                                    title: "Team Members",
                                    value: "18",
                                    icon: Icons.people,
                                    backgroundColor: const Color(0xFF10B981),
                                    iconBackgroundColor: const Color(
                                      0xFF34D399,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: Responsive.spacing(
                                    context,
                                    mobile: 16,
                                  ),
                                ),

                                // Completion Rate Card
                                SizedBox(
                                  width: double.infinity,
                                  height: Responsive.containerHeight(
                                    context,
                                    mobile: 120,
                                  ),
                                  child: ProjectDashboardCard(
                                    title: "Completion Rate",
                                    value: "87%",
                                    icon: Icons.emoji_events,
                                    backgroundColor: const Color(0xFFF59E0B),
                                    iconBackgroundColor: const Color(
                                      0xFFFBBF24,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                      SizedBox(height: Responsive.spacing(context, mobile: 24)),

                      // Projects List
                      Text(
                        "Project Details",
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, mobile: 20),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, mobile: 16)),

                      // Project Information Cards
                      ...controller.projects
                          .map(
                            (project) => ProjectDashboardInformationCard(
                              project: project,
                              onTap: () {
                                Get.toNamed(
                                  AppRoute.projectDetails,
                                  arguments: project,
                                );
                              },
                              onMoreTap: () {
                                // Handle more options
                                _showProjectOptions(context, project);
                              },
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
