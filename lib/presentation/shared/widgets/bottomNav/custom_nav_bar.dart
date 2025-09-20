import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../main.dart';
import '../../../main_app/controllers/main_app.controller.dart';
import 'nav_bar_model.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CustomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double cornerRadius;
  final double elevation;
  final double height;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor = AppColors.defaultBlack,
    this.selectedItemColor = AppColors.primary1000,
    this.unselectedItemColor = AppColors.neutral500,
    this.cornerRadius = 100,
    this.elevation = 0.0,
    this.height = 54, // Increased height to accommodate the floating button
  });
  static AppController get to => Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Navigation Bar
          Material(
            elevation: elevation,
            color: backgroundColor,
            shadowColor: Colors.black.withOpacity(0.1),
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(cornerRadius),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,

                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              height: height.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // First two items (Home, Categories)
                  ...items.take(2).map((item) {
                    final index = items.indexOf(item);
                    final isSelected = index == currentIndex;

                    return Expanded(
                      child: InkWell(
                        onTap: () => onTap(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              item.svgAssetPath,
                              color: isSelected ? selectedItemColor : unselectedItemColor,
                              width: 16.w,
                              height: 16.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item.label,
                              style: AppTextStyles.captionRegular.copyWith(
                                color: isSelected ? selectedItemColor : unselectedItemColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  // Empty space for the center floating button
                  Expanded(child: SizedBox()),

                  // Last two items (My Order, Account)
                  ...items.skip(3).map((item) {
                    final index = items.indexOf(item);
                    final isSelected = index == currentIndex;

                    return Expanded(
                      child: InkWell(
                        onTap: () => onTap(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              item.svgAssetPath,
                              color: isSelected ? selectedItemColor : unselectedItemColor,
                              width: 16.w,
                              height: 16.w,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item.label,
                              style: AppTextStyles.captionRegular.copyWith(
                                color: isSelected ? selectedItemColor : unselectedItemColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // Floating Center Button (Sell button) - Properly centered
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(2), // Index 2 for the center button
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary1000, // Yellow/amber color like in the image
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   if(AppController.to.role.value!="buyer")
                      Padding(
                        padding:   EdgeInsets.only(bottom: 2.w),
                        child: Icon(
                          Icons.circle, // Or use SvgPicture.asset if you have an SVG
                          color: AppColors.red500,
                          size: 6.sp,
                        ),
                      ),
                      Text(
                        items[2].label, // "Sell" text
                        style: AppTextStyles.captionRegular.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.neutral950,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}