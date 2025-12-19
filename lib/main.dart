import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/core/services/services.dart';
import 'package:junior/routes.dart';
import 'package:junior/controller/auth/login_controller.dart';
import 'package:junior/controller/auth/onBoarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  // Initialize only essential controllers at app start
  Get.put(LoginControllerImpl(), permanent: true);
  Get.put(OnBoardingControllerImp(), permanent: true);
  // Other controllers will be initialized after successful login
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
