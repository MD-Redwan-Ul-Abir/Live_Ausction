import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/how_does_it_works.controller.dart';

class HowDoesItWorksScreen extends GetView<HowDoesItWorksController> {
  const HowDoesItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "How does it works?", centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 38.h),
              Obx(() {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    height: 329.h,
                    width: double.infinity,
                    color: Colors.transparent,
                    // This will show if image doesn't cover fully
                    child: Image.asset(
                        controller.selectedWorkList[controller.currentIndex
                            .value]['image'] ?? '', fit: BoxFit.cover),
                  ),
                );
              }),

              SizedBox(height: 28.h),
              Obx(() {
                return Text(
                  controller.selectedWorkList[controller.currentIndex
                      .value]['title'] ?? '',
                  style: AppTextStyles.H6_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                );
              }),
              SizedBox(height: 8.h),
              Obx(() {
                return SizedBox(
                  width: 254.w,
                  child: Text(
                    controller.selectedWorkList[controller.currentIndex
                        .value]['subTitle'] ?? '',
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral300,
                    ), textAlign: TextAlign.center,
                  ),
                );
              }),
              Spacer(),
              Obx(() {
                return PrimaryButton(
                  width: double.infinity,
                  onPressed: () {
                    if (controller.currentIndex.value <
                        controller.selectedWorkList.length - 1) {
                      controller.currentIndex.value++;
                    } else {
                      Get.offAllNamed(Routes.MAIN_APP);
                    }
                  },
                  text: controller.currentIndex.value <
                          controller.selectedWorkList.length - 1
                      ? 'Next'
                      : 'Got it',
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
