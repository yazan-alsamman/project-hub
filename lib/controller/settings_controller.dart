import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {}

class SettingsControllerImp extends SettingsController {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();
  String selectedTimezone = 'UTC';
  String selectedLanguage = 'English';

  // Notification settings
  bool enableNotifications = false;
  bool emailNotifications = false;
  bool pushNotifications = false;

  void updateTimezone(String timezone) {
    selectedTimezone = timezone;
    update();
  }

  void updateLanguage(String language) {
    selectedLanguage = language;
    update();
  }

  void toggleNotifications(bool value) {
    enableNotifications = value;
    update();
  }

  void toggleEmailNotifications(bool value) {
    emailNotifications = value;
    update();
  }

  void togglePushNotifications(bool value) {
    pushNotifications = value;
    update();
  }

  void navigateToChangePassword() {
    print('Navigate to Change Password');
    // Add navigation logic here
  }

  void navigateToApiKeys() {
    print('Navigate to API Keys');
    // Add navigation logic here
  }

  void navigateToManageMembers() {
    print('Navigate to Manage Members');
    // Add navigation logic here
  }

  void navigateToRolesPermissions() {
    print('Navigate to Roles & Permissions');
    // Add navigation logic here
  }

  void navigateToBilling() {
    print('Navigate to Billing');
    // Add navigation logic here
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    companyNameController.dispose();
    adminEmailController.dispose();
    super.onClose();
  }
}
