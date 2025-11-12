import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/data/repository/auth_repository.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
}

class LoginControllerImpl extends LoginController {
  final AuthRepository _authRepository = AuthRepository();

  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isLoading = false;
  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  login() async {
    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading = true;
    statusRequest = StatusRequest.loading;
    update();

    final result = await _authRepository.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading = false;

    result.fold(
      (error) {
        statusRequest = error;
        update();

        String errorMessage = 'Login failed';
        switch (error) {
          case StatusRequest.offlineFailure:
            errorMessage = 'No internet connection';
            break;
          case StatusRequest.serverFailure:
            errorMessage = 'Invalid email or password';
            break;
          case StatusRequest.timeoutException:
            errorMessage = 'Request timeout. Please try again';
            break;
          default:
            errorMessage = 'An error occurred. Please try again';
        }

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (data) {
        statusRequest = StatusRequest.success;
        update();

        // Navigate to home
        Get.offNamed(AppRoute.projectDashboard);

        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  @override
  goToForgetPassword() {
    // Navigate to forgot password screen
    // Get.toNamed(AppRoute.forgotPassword);
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }
}
