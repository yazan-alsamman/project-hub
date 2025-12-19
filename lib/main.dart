import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/core/services/services.dart';
import 'package:junior/routes.dart';
import 'package:junior/controller/auth/login_controller.dart';
import 'package:junior/controller/auth/onBoarding_controller.dart';
import 'package:junior/controller/employee/team_controller.dart';
import 'package:junior/controller/task/tasks_controller.dart';
import 'package:junior/controller/common/settings_controller.dart';
import 'package:junior/controller/common/filter_button_controller.dart';
import 'package:junior/controller/common/customAppBar_controller.dart';
import 'package:junior/controller/common/customDrawer_controller.dart';
import 'package:junior/controller/project/projects_controller.dart';
import 'package:junior/controller/common/analytics_controller.dart';
import 'package:junior/controller/project/project_dashboard_controller.dart';
import 'package:junior/controller/employee/add_employee_controller.dart';
import 'package:junior/controller/project/add_project_controller.dart';
import 'package:junior/controller/auth/add_client_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
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
  Get.put(AddEmployeeControllerImp(), permanent: true);
  Get.put(AddProjectControllerImp(), permanent: true);
  Get.put(AddClientControllerImp(), permanent: true);
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.splash,
      getPages: routes,
    );
  }
}
