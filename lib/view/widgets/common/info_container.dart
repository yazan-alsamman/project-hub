import 'package:flutter/material.dart';
import 'package:junior/core/constant/color.dart';
import 'package:junior/core/constant/responsive.dart';
class InformationContainer extends StatelessWidget {
  final String title;
  final String value;
  const InformationContainer({
    super.key,
    required this.title,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          Responsive.borderRadius(context, mobile: 12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            offset: const Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: AppColor.borderColor,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      width: Responsive.containerWidth(context, mobile: 150),
      height: Responsive.containerHeight(context, mobile: 90),
      child: Padding(
        padding: Responsive.padding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, mobile: 12),
                color: AppColor.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Responsive.spacing(context, mobile: 4)),
            Text(
              value,
              style: TextStyle(
                fontSize: Responsive.fontSize(context, mobile: 24),
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
