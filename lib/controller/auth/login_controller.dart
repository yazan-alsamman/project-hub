import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/class/statusrequest.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/routes.dart';
import 'package:junior/core/services/controllers_initializer.dart';
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
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  @override
  login() async {
    print('🔵 ====== LOGIN FUNCTION CALLED ======');
    debugPrint('🔵 Login started');
    print('🔵 Login started - PRINT VERSION');
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primaryColor,
        colorText: AppColor.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    isLoading = true;
    statusRequest = StatusRequest.loading;
    update();
    print('🔵 Calling repository login...');
    debugPrint('Username: ${usernameController.text}');
    debugPrint('Password length: ${passwordController.text.length}');
    final result = await _authRepository.login(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );
    isLoading = false;
    result.fold(
      (error) {
        print('🔴 Login error: $error');
        debugPrint('🔴 Login error: $error');
        String errorMsg = 'Login failed. Please try again.';
        if (error == StatusRequest.serverFailure) {
          errorMsg = 'Invalid username or password.';
        } else if (error == StatusRequest.offlineFailure) {
          errorMsg = 'No internet connection. Please check your network.';
        } else if (error == StatusRequest.timeoutException) {
          errorMsg = 'Request timed out. Please try again.';
        } else if (error == StatusRequest.serverException) {
          errorMsg = 'An unexpected server error occurred.';
        }
        statusRequest = error;
        update();
        Get.snackbar(
          'Error',
          errorMsg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.errorColor,
          colorText: AppColor.white,
          icon: const Icon(
            Icons.error_outline,
            color: AppColor.white,
            size: 28,
          ),
          duration: const Duration(seconds: 5),
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
        );
      },
      (response) {
        print('✅ Login successful');
        debugPrint('✅ Login successful');
        debugPrint('Response: $response');
        statusRequest = StatusRequest.success;
        update();
        // Initialize all controllers after successful login
        debugPrint('🔄 Initializing all controllers after login...');
        ControllersInitializer.initializeControllers();
        debugPrint('✅ All controllers initialized');
        Get.offNamed(AppRoute.team);
      },
    );
  }
  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
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
