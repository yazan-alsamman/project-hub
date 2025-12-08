import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/core/services/services.dart';
import 'package:junior/data/static/onBoarding_data.dart';
abstract class OnBoardingController extends GetxController {
  next();
  onPageChanged(int index);
  resetOnBoarding(); // دالة لإعادة تعيين حالة onBoarding
}
class OnBoardingControllerImp extends OnBoardingController {
  late PageController pageController;
  int currentPage = 0;
  Myservices myservices = Get.find();
  @override
  next() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myservices.sharedPreferences.setString("onBoarding", "1");
      Get.offAllNamed(AppRoute.login);
    } else {
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }
  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
  @override
  resetOnBoarding() {
    myservices.sharedPreferences.remove("onBoarding");
    Get.offAllNamed("/");
  }
}
