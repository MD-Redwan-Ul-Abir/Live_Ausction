import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import 'controllers/role_selection.controller.dart';

class RoleSelectionScreen extends GetView<RoleSelectionController> {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              Text(
                'MouvBid',
                style: AppTextStyles.H1_Bold.copyWith(
                  color: AppColors.primary1000,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "The Live Shopping Marketplace. Buy,sell and\nconnect around the things you love.",
                style: AppTextStyles.paragraph_2_Regular.copyWith(
                  color: AppColors.neutral300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Text(
                "Are You Seller or Buyer?",
                style: AppTextStyles.paragraph_1_Regular.copyWith(
                  color: AppColors.neutral50,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),

              // Selection buttons
              Obx(() {
                return _selectionButton(
                  title: "Seller",

                  isSelected: controller.selectedRole.value == 'seller',
                  onTap: () => controller.selectRole('seller'),
                );
              }),
              SizedBox(height: 16.h),
              Obx(() {
                return _selectionButton(
                  title: "Buyer",

                  isSelected: controller.selectedRole.value == 'buyer',
                  onTap: () => controller.selectRole('buyer'),
                );
              }),

              Spacer(flex: 3),
              Obx(() {
                return PrimaryButton(
                  width: double.infinity,
                  isActive: controller.selectedRole.value.isNotEmpty,
                  onPressed: () {
                    controller.proceedToNext();
                  },
                  text: 'Next',
                );
              }),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectionButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary1000 : AppColors.neutral800,
          borderRadius: BorderRadius.circular(
            100.r,
          ), // Half of height for pill shape
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.buttonRegular.copyWith(
                  color: isSelected
                      ? AppColors.neutral950
                      : AppColors.neutral50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: 16.h,
              height: 16.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.neutral950
                      : AppColors.neutral50,
                  width: 1.w,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
