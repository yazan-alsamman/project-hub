import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/view/widgets/common/build_menu_item.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String)? onItemTap;

  const CustomDrawer({super.key, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.gradientStart],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'john.doe@company.com',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildMenuItem(
                    icon: Icons.group,
                    title: 'Team',
                    onTap: () {
                      Get.offAllNamed(AppRoute.team);
                    },
                  ),
                  buildMenuItem(
                    icon: Icons.assignment,
                    title: 'Tasks',
                    onTap: () {
                      Get.offAllNamed(AppRoute.tasks);
                    },
                  ),
                  buildMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Get.offAllNamed(AppRoute.settings);
                    },
                  ),
                  buildMenuItem(
                    icon: Icons.folder,
                    title: 'Projects',
                    onTap: () {
                      Get.offAllNamed(AppRoute.projects);
                    },
                  ),
                  buildMenuItem(
                    icon: Icons.analytics,
                    title: 'Analytics',
                    onTap: () {
                      Get.offAllNamed(AppRoute.analytics);
                    },
                  ),
                  buildMenuItem(
                    icon: Icons.dashboard,
                    title: 'Project Dashboard',
                    onTap: () {
                      Get.offAllNamed(AppRoute.projectDashboard);
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Divider(color: AppColor.borderColor, height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                leading: Icon(Icons.logout, color: AppColor.errorColor),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColor.errorColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Get.offAllNamed(AppRoute.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
