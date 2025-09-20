import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final Color iconColor;
  final String? leadingIcon;
  final Color? leadingIconColor;
  final bool? donotShowLeadingIcon;
  final Widget? customLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor = AppColors.neutral950,
    this.iconColor = Colors.black,
    this.customLeading,
    this.leadingIcon,
    this.leadingIconColor,
    this.donotShowLeadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: _shouldShowLeading(),
      leading: _buildLeading(),
      title: Text(
        title,
        style: AppTextStyles.H6_Regular.copyWith(color: AppColors.defaultTextColor),
      ),
      actions: actions,
      scrolledUnderElevation: 0,
      elevation: 0,
    );
  }

  bool _shouldShowLeading() {
    // Don't automatically show leading if donotShowLeadingIcon is true
    if (donotShowLeadingIcon == true) {
      return false;
    }

    // Don't automatically show leading if we have a custom leading widget
    if (customLeading != null) {
      return false;
    }

    // Show automatic leading only if showBackButton is true
    return showBackButton;
  }

  Widget? _buildLeading() {
    // If donotShowLeadingIcon is true, don't show any leading widget
    if (donotShowLeadingIcon == true) {
      return null;
    }

    // If customLeading is provided, use it
    if (customLeading != null) {
      return customLeading;
    }

    // If showBackButton is true, show the back button
    if (showBackButton) {
      return IconButton(
        icon: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: SvgPicture.asset(
            leadingIcon ?? AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
            height: 16.h,
            width: 16.w,
            color: leadingIconColor ?? AppColors.defaultTextColor,
          ),
        ),
        onPressed: onBackPressed ?? () => Get.back(),
      );
    }

    // Default case: no leading widget
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}