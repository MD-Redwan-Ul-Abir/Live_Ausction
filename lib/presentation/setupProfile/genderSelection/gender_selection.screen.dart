import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/gender_selection.controller.dart';

class GenderSelectionScreen extends GetView<GenderSelectionController> {
  const GenderSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Set Up Your Profile",
          centerTitle: true,
          showBackButton: false,
      
        ),
        body: Padding(
          padding:   EdgeInsets.symmetric( horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 38.h,
              ),
              Text('What’s Your Gender?', style: AppTextStyles.H6_Regular,) ,
      
              SizedBox(
                height: 4.h,
              ),
              Text('This Allows us to Suggest more relevant categories.', style: AppTextStyles.buttonRegular.copyWith(color: AppColors.neutral300),) ,
              SizedBox(
                height: 24.h,
              ),
              Obx(() {
                return _selectionButton(
                  title: "Female",
      
                  isSelected: controller.selectedRole.value == 'Female',
                  onTap: () => controller.selectRole('Female'),
                );
              }),
              SizedBox(height: 16.h),
              Obx(() {
                return _selectionButton(
                  title: "Male",
      
                  isSelected: controller.selectedRole.value == 'Male',
                  onTap: () => controller.selectRole('Male'),
                );
              }),
              Spacer(),
              Obx(() {
                return PrimaryButton(
                  width: double.infinity,
                  isActive: controller.selectedRole.value.isNotEmpty,
                  onPressed: () {
      Get.toNamed(Routes.PRODUCT_SELECTION);
                  },
                  text: 'Next',
                );
              }),
              SizedBox(
                height: 16.h,
              )
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
