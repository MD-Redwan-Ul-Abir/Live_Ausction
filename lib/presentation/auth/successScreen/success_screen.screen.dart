import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/success_screen.controller.dart';

class SuccessScreenScreen extends StatefulWidget {
  const SuccessScreenScreen({super.key});

  @override
  State<SuccessScreenScreen> createState() => _SuccessScreenScreenState();
}

class _SuccessScreenScreenState extends State<SuccessScreenScreen> {
  final SuccessScreenController successScreenController =
      Get.find<SuccessScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,

      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 278.h),
              Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.primary600,
                ),
                child: Center(child: SvgPicture.asset(AppImages.checkMate)),
              ),
              SizedBox(height: 12.h),
              Obx(() {
                return Text(
                  successScreenController.title.value,
                  style: AppTextStyles.H5_Regular,
                );
              }),
              SizedBox(height: 4.h),
              Obx(() {
                return Text(
                  successScreenController.subTitle.value,
                  style: AppTextStyles.paragraph_1_Regular,
                );
              }),
              Spacer(),
              Obx(() {
                return PrimaryButton(
                  width: double.infinity,
                  onPressed: successScreenController.handleButtonPress,
                  text: successScreenController.buttonText.value,
                );
              }),
              SizedBox(
                height: 16.h,
              ),
              if (successScreenController.secondButtonActive)
                Obx(() {
                  return PrimaryButton(
                    backgroundColor: AppColors.neutral800,
                    textColor: AppColors.neutral50,
                    width: double.infinity,
                    onPressed: successScreenController.handleSecondButtonPress,
                    text: successScreenController.secondButtonText.value,
                  );
                }),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
