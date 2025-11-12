import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/controller/login_controller.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/view/widgets/common/main_button.dart';
import 'package:junior/view/widgets/login/build_header.dart';
import 'package:junior/view/widgets/login/inputfields.dart';
import 'package:junior/view/widgets/login/options.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImpl controller = Get.find<LoginControllerImpl>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.gradientStart,
              AppColor.gradientMiddle, // #8B5CF6
              AppColor.gradientEnd, // #6B46C1
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width > 600
                      ? 500
                      : MediaQuery.of(context).size.width * 0.9,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width > 600 ? 40.0 : 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Section
                      const BuildHeader(
                        title: "Welcome Back",
                        subtitle: "Sign in to continue to ProjectHub",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      // Input Fields
                      InputFields(
                        emailController: controller.emailController,
                        passwordController: controller.passwordController,
                        hintText: "your@email.com",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      // Remember Me & Forgot Password
                      const Options(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      // Sign In Button
                      _buildSignInButton(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),

                      // Sign Up Link
                      _buildSignUpLink(context),

                      // Reset OnBoarding Button (for testing)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      /// _buildResetOnBoardingButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      width: double.infinity,
      height: isTablet ? 56 : 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.primaryColor, AppColor.gradientStart],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MainButton(
        icon: Icons.arrow_forward_outlined,
        onPressed: () {
          Get.offAllNamed(AppRoute.team);
        },
        text: "Sign in",
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: AppColor.textSecondaryColor,
            fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to sign up
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }

  /*Widget _buildResetOnBoardingButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // إعادة تعيين onBoarding للاختبار
        Get.find<OnBoardingControllerImp>().resetOnBoarding();
      },
      child: Text(
        'Reset OnBoarding (Test)',
        style: TextStyle(
          color: AppColor.textSecondaryColor,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
  */
}
