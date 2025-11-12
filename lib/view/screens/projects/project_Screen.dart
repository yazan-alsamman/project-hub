import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/controller/customDrawer_controller.dart';
import 'package:junior/controller/filter_button_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/responsive.dart';
import 'package:junior/controller/projects_controller.dart';
import 'package:junior/view/widgets/common/custom_app_bar.dart';
import 'package:junior/view/widgets/common/custom_drawer.dart';
import 'package:junior/view/widgets/common/filter_button.dart';
import 'package:junior/view/widgets/common/header.dart';
import 'package:junior/view/widgets/common/project_card.dart';
import 'package:junior/core/constant/routes.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

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
              child: GetBuilder<ProjectsControllerImp>(
                builder: (controller) => Padding(
                  padding: Responsive.padding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: "Projects",
                        subtitle: "Manage and organize all your projects",
                        buttonText: "New Project",
                        buttonIcon: Icons.add,
                        onPressed: () {},
                      ),

                      SizedBox(height: Responsive.spacing(context, mobile: 30)),
                      GetBuilder<FilterButtonController>(
                        builder: (filterController) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: AppColor.textSecondaryColor,
                                size: Responsive.iconSize(context, mobile: 20),
                              ),
                              SizedBox(
                                width: Responsive.spacing(context, mobile: 12),
                              ),
                              FilterButton(
                                text: "All",
                                isSelected:
                                    filterController.selectedFilter == 'All',
                                onPressed: () {
                                  filterController.selectFilter('All');
                                },
                              ),
                              SizedBox(
                                width: Responsive.spacing(context, mobile: 8),
                              ),
                              FilterButton(
                                text: "Active",
                                isSelected:
                                    filterController.selectedFilter == 'Active',
                                onPressed: () {
                                  filterController.selectFilter('Active');
                                },
                              ),
                              SizedBox(
                                width: Responsive.spacing(context, mobile: 8),
                              ),
                              FilterButton(
                                text: "Completed",
                                isSelected:
                                    filterController.selectedFilter ==
                                    'Completed',
                                onPressed: () {
                                  filterController.selectFilter('Completed');
                                },
                              ),
                              SizedBox(
                                width: Responsive.spacing(context, mobile: 8),
                              ),
                              FilterButton(
                                text: "Planned",
                                isSelected:
                                    filterController.selectedFilter ==
                                    'Planned',
                                onPressed: () {
                                  filterController.selectFilter('Planned');
                                },
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

            // Projects List
            GetBuilder<ProjectsControllerImp>(
              builder: (controller) => Padding(
                padding: Responsive.padding(context),
                child: controller.projects.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Responsive.spacing(context, mobile: 50),
                            ),
                            Icon(
                              Icons.folder_open_outlined,
                              size: Responsive.size(context, mobile: 64),
                              color: AppColor.textSecondaryColor.withOpacity(
                                0.5,
                              ),
                            ),
                            SizedBox(
                              height: Responsive.spacing(context, mobile: 16),
                            ),
                            Text(
                              'No projects found',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(
                                  context,
                                  mobile: 18,
                                ),
                                color: AppColor.textSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: Responsive.spacing(context, mobile: 8),
                            ),
                            Text(
                              'Try selecting a different filter',
                              style: TextStyle(
                                fontSize: Responsive.fontSize(
                                  context,
                                  mobile: 14,
                                ),
                                color: AppColor.textSecondaryColor.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.projects.length,
                        itemBuilder: (context, index) {
                          final project = controller.projects[index];
                          return ProjectCard(
                            title: project.title,
                            company: project.company,
                            description: project.description,
                            progress: project.progress,
                            startDate: project.startDate,
                            endDate: project.endDate,
                            teamMembers: project.teamMembers,
                            status: project.status,
                            onTap: () {
                              // Navigate to project details
                              print(
                                'Navigating to project details for: ${project.title}',
                              );
                              Get.toNamed(
                                AppRoute.projectDetails,
                                arguments: project,
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
