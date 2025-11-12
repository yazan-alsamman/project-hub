import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:junior/core/class/middleware/middleware.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/data/static/team_members_data.dart';
import 'package:junior/view/screens/Tasks/tasks_Screen.dart';
import 'package:junior/view/screens/auth/login.dart';
import 'package:junior/view/screens/onBoarding.dart';
import 'package:junior/view/screens/projects/project_Screen.dart';
import 'package:junior/view/screens/projects/project_details_screen.dart';
import 'package:junior/view/screens/settings/settings.dart';
import 'package:junior/view/screens/team/team_screen.dart';
import 'package:junior/view/screens/team/member_detail_screen.dart';
import 'package:junior/view/screens/analytics/analytics_Screen.dart';
import 'package:junior/view/screens/project dashboard/project_dashboard_screen.dart';
import 'package:junior/data/Models/project_model.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/",
    page: () => const OnBoarding(),
    middlewares: [MyMiddleWare()],
  ),
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.team, page: () => const TeamScreen()),
  GetPage(name: AppRoute.tasks, page: () => const TasksScreen()),
  GetPage(name: AppRoute.settings, page: () => const SettingsScreen()),
  GetPage(name: AppRoute.projects, page: () => const ProjectScreen()),
  GetPage(name: AppRoute.analytics, page: () => const AnalyticsScreen()),
  GetPage(
    name: AppRoute.projectDashboard,
    page: () => const ProjectDashboardScreen(),
  ),
  GetPage(
    name: AppRoute.memberDetail,
    page: () {
      final member = Get.arguments as TeamMember;
      return MemberDetailScreen(member: member);
    },
  ),
  GetPage(
    name: AppRoute.projectDetails,
    page: () {
      final project = Get.arguments as ProjectModel;
      return ProjectDetailsScreen(project: project);
    },
  ),
];
