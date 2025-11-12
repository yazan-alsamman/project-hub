import 'package:get/get.dart';

abstract class CustomappbarController extends GetxController {
  void updateNotificationCount(int count);
  void addNotification();
  void clearNotifications();
  void updateSearchQuery(String query);
  void onNotificationTap();
  void onUserProfileTap();
  void onMenuItemTap(String item);
}
class CustomappbarControllerImp extends GetxController {
  // متغيرات الحالة
  var notificationCount = 3.obs;
  var searchQuery = ''.obs;

  // دالة لتحديث عدد الإشعارات
  void updateNotificationCount(int count) {
    notificationCount.value = count;
  }

  // دالة لإضافة إشعار
  void addNotification() {
    notificationCount.value++;
  }

  // دالة لحذف جميع الإشعارات
  void clearNotifications() {
    notificationCount.value = 0;
  }

  // دالة لتحديث نص البحث
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // دالة للتعامل مع النقر على الإشعارات
  void onNotificationTap() {
    clearNotifications();
  }

  // دالة للتعامل مع النقر على ملف المستخدم
  void onUserProfileTap() {
    print('User profile tapped');
  }

  // دالة للتعامل مع النقر على عناصر القائمة
  
}
