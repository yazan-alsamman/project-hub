import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/controller/customDrawer_controller.dart';
import 'package:junior/controller/team_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/data/static/team_members_data.dart';
import 'package:junior/view/widgets/common/custom_app_bar.dart';
import 'package:junior/view/widgets/common/custom_drawer.dart';
import 'package:junior/view/widgets/common/header.dart';
import 'package:junior/view/widgets/common/info_container.dart';
import 'package:junior/view/widgets/common/member_card.dart';
import 'package:junior/core/constant/routes.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

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
              child: GetBuilder<TeamControllerImp>(
                builder: (controller) => Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(title: "Team", subtitle: "Manage your team members and roles", buttonText: "Add Member", buttonIcon: Icons.person_add, onPressed: (){}),

                      const SizedBox(height: 30),
                      Column(
                        children: [
                          Row(
                            children: [
                              InformationContainer(
                                title: "Total Members",
                                value: "${teamMembers.length}",
                              ),
                              SizedBox(width: 20),
                              InformationContainer(
                                title: "Active now",
                                value:
                                    "${teamMembers.where((m) => m.status == 'Active').length}",
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              InformationContainer(
                                title: "Busy",
                                value:
                                    "${teamMembers.where((m) => m.status == 'Busy').length}",
                              ),
                              SizedBox(width: 20),
                              InformationContainer(
                                title: "Away",
                                value:
                                    "${teamMembers.where((m) => m.status == 'Away').length}",
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          Row(
                            children: [
                              InformationContainer(
                                title: "Departments",
                                value: "6",
                              ),
                              SizedBox(width: 20),
                              InformationContainer(
                                title: "Avg. Projects",
                                value: "3.2",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // قسم أعضاء الفريق
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team Members",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${teamMembers.length} members",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // قائمة بطاقات أعضاء الفريق
                  ...teamMembers
                      .map(
                        (member) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MemberCard(
                            name: member.name,
                            position: member.position,
                            status: member.status,
                            statusColor: member.statusColor,
                            icon: member.icon,
                            email: member.email,
                            phone: member.phone,
                            location: member.location,
                            activeProjects: member.activeProjects,
                            onTap: () {
                              Get.toNamed(
                                AppRoute.memberDetail,
                                arguments: member,
                              );
                            },
                            onViewProjects: () {
                              print('View projects for ${member.name}');
                              // يمكن إضافة التنقل إلى صفحة مشاريع العضو هنا
                            },
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
