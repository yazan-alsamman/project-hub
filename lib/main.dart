import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/services/services.dart';
import 'package:junior/routes.dart';

import 'package:junior/controller/login_controller.dart';
import 'package:junior/controller/onBoarding_controller.dart';
import 'package:junior/controller/team_controller.dart';
import 'package:junior/controller/tasks_controller.dart';
import 'package:junior/controller/settings_controller.dart';
import 'package:junior/controller/filter_button_controller.dart';
import 'package:junior/controller/customAppBar_controller.dart';
import 'package:junior/controller/customDrawer_controller.dart';
import 'package:junior/controller/projects_controller.dart';
import 'package:junior/controller/analytics_controller.dart';
import 'package:junior/controller/project_dashboard_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  // Register the controllers permanently
  Get.put(LoginControllerImpl(), permanent: true);
  Get.put(OnBoardingControllerImp(), permanent: true);
  Get.put(TeamControllerImp(), permanent: true);
  Get.put(TasksControllerImp(), permanent: true);
  Get.put(SettingsControllerImp(), permanent: true);
  Get.put(FilterButtonController(), permanent: true);
  Get.put(CustomappbarControllerImp(), permanent: true);
  Get.put(CustomDrawerControllerImp(), permanent: true);
  Get.put(ProjectsControllerImp(), permanent: true);
  Get.put(AnalyticsControllerImp(), permanent: true);
  Get.put(ProjectDashboardControllerImp(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, getPages: routes);
  }
}
