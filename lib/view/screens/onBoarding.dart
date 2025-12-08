import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/controller/auth/onBoarding_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/view/widgets/onBoarding/custtombuttononboarding.dart';
import 'package:junior/view/widgets/onBoarding/dotcontroller.dart';
import 'package:junior/view/widgets/onBoarding/slider.dart';
class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 4, child: CustomSliderOnBoarding()),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CustomDotControllerOnBoarding(),
                  SizedBox(height: 20),
                  Spacer(flex: 2),
                  CustomButtonOnBoarding(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
