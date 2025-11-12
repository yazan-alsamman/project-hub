import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/responsive.dart';
import 'package:junior/controller/customAppBar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final bool showNotifications;
  final bool showUserProfile;
  final bool showHamburgerMenu;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.title,
    this.showSearch = true,
    this.showNotifications = true,
    this.showUserProfile = true,
    this.showHamburgerMenu = true,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    // Try to get controller safely
    try {
      final controller = Get.find<CustomappbarControllerImp>();
      return _buildAppBarWithController(controller);
    } catch (e) {
      // If controller not found, return simple AppBar
      return AppBar(backgroundColor: Colors.white, elevation: 0);
    }
  }

  Widget _buildAppBarWithController(CustomappbarControllerImp controller) {
    return Builder(
      builder: (context) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Back Button
            if (showBackButton) ...[
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.textColor,
                  size: Responsive.iconSize(context, mobile: 20),
                ),
              ),
              SizedBox(width: Responsive.spacing(context, mobile: 8)),
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, mobile: 18),
                      fontWeight: FontWeight.bold,
                      color: AppColor.textColor,
                    ),
                  ),
                ),
            ] else ...[
              // Hamburger Menu
              if (showHamburgerMenu) ...[
                _buildHamburgerMenu(context),
                SizedBox(width: Responsive.spacing(context, mobile: 16)),
              ],

              // Search Bar
              if (showSearch) ...[
                Expanded(child: _buildSearchBar(context, controller)),
                SizedBox(width: Responsive.spacing(context, mobile: 12)),
              ],

              // Search Icon (hidden on mobile)
              if (showSearch && !Responsive.isMobile(context)) ...[
                _buildSearchIcon(context),
                SizedBox(width: Responsive.spacing(context, mobile: 16)),
              ],

              // Notification Bell
              if (showNotifications) ...[
                _buildNotificationBell(context, controller),
                SizedBox(width: Responsive.spacing(context, mobile: 16)),
              ],

              // User Profile
              if (showUserProfile) ...[_buildUserProfile(context, controller)],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHamburgerMenu(BuildContext context) {
    return Builder(
      builder: (builderContext) => GestureDetector(
        onTap: () {
          // Default action - open drawer
          Scaffold.of(builderContext).openDrawer();
        },
        child: Container(
          padding: EdgeInsets.all(Responsive.spacing(context, mobile: 8)),
          child: Icon(
            Icons.menu,
            color: AppColor.textSecondaryColor,
            size: Responsive.iconSize(context, mobile: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    CustomappbarControllerImp controller,
  ) {
    return Container(
      height: Responsive.size(context, mobile: 40),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(
          Responsive.borderRadius(context, mobile: 20),
        ),
        border: Border.all(color: AppColor.borderColor, width: 1),
      ),
      child: TextField(
        onChanged: (query) {
          controller.updateSearchQuery(query);
        },
        decoration: InputDecoration(
          hintText: 'Search projects, tasks...',
          hintStyle: TextStyle(
            color: AppColor.textSecondaryColor,
            fontSize: Responsive.fontSize(context, mobile: 14),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.spacing(context, mobile: 16),
            vertical: Responsive.spacing(context, mobile: 12),
          ),
        ),
        style: TextStyle(
          color: AppColor.textColor,
          fontSize: Responsive.fontSize(context, mobile: 14),
        ),
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Search icon action (optional)
      },
      child: Container(
        padding: EdgeInsets.all(Responsive.spacing(context, mobile: 8)),
        child: Icon(
          Icons.search,
          color: AppColor.textSecondaryColor,
          size: Responsive.iconSize(context, mobile: 24),
        ),
      ),
    );
  }

  Widget _buildNotificationBell(
    BuildContext context,
    CustomappbarControllerImp controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.onNotificationTap();
          _showNotificationDialog(controller.notificationCount.value);
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.spacing(context, mobile: 8)),
              child: Icon(
                Icons.notifications_outlined,
                color: AppColor.textSecondaryColor,
                size: Responsive.iconSize(context, mobile: 24),
              ),
            ),
            if (controller.notificationCount.value > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: Responsive.size(context, mobile: 12),
                  height: Responsive.size(context, mobile: 12),
                  decoration: BoxDecoration(
                    color: AppColor.errorColor,
                    borderRadius: BorderRadius.circular(
                      Responsive.size(context, mobile: 6),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(
    BuildContext context,
    CustomappbarControllerImp controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.onUserProfileTap();
        _showUserMenu();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Responsive.size(context, mobile: 36),
            height: Responsive.size(context, mobile: 36),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColor.primaryColor, AppColor.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(
                Responsive.size(context, mobile: 18),
              ),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: Responsive.iconSize(context, mobile: 20),
            ),
          ),
          SizedBox(width: Responsive.spacing(context, mobile: 4)),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColor.textSecondaryColor,
            size: Responsive.iconSize(context, mobile: 16),
          ),
        ],
      ),
    );
  }

  void _showNotificationDialog(int count) {
    Get.dialog(
      AlertDialog(
        title: const Text('Notifications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (count == 0)
              const Text('No new notifications')
            else
              Text('You have $count new notifications'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showUserMenu() {
    Get.dialog(
      AlertDialog(
        title: const Text('User Menu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Get.back();
                // Navigate to profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Get.back();
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Get.back();
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
