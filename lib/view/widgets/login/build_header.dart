import 'package:flutter/material.dart';
import 'package:junior/core/constant/color.dart';

class BuildHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const BuildHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Column(
      children: [
        // Icon
        Container(
          width: isTablet ? 80 : 60,
          height: isTablet ? 80 : 60,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.mail_outline,
            color: Colors.white,
            size: isTablet ? 40 : 30,
          ),
        ),
        SizedBox(height: isTablet ? 32 : 24),

        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 32 : 28,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        SizedBox(height: isTablet ? 12 : 8),

        // Subtitle
        Text(
          subtitle,
          style: TextStyle(
            fontSize: isTablet ? 18 : 16,
            color: AppColor.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
