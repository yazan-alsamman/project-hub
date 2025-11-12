import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/core/services/services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  Myservices myservices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    // السماح بالوصول إلى جميع الصفحات بدون تحقق من onBoarding أو تسجيل الدخول
    if (route == AppRoute.projectDashboard ||
        route == AppRoute.analytics ||
        route == AppRoute.projects ||
        route == AppRoute.team ||
        route == AppRoute.tasks ||
        route == AppRoute.settings) {
      return null;
    }

    // التحقق من حالة onBoarding فقط للصفحة الرئيسية
    String? onBoardingStatus = myservices.sharedPreferences.getString(
      "onBoarding",
    );

    // إذا كان المستخدم قد شاهد onBoarding من قبل، توجهه إلى تسجيل الدخول
    if (onBoardingStatus == "1") {
      return const RouteSettings(name: AppRoute.login);
    }

    // إذا لم يشاهد onBoarding من قبل، اتركه يشاهدها
    return null;
  }
}
