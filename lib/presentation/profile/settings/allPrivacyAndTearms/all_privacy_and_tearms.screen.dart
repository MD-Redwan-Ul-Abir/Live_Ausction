import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/all_privacy_and_tearms.controller.dart';

class AllPrivacyAndTearmsScreen extends GetView<AllPrivacyAndTearmsController> {
  const AllPrivacyAndTearmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: controller.appBarTitle.value,
          centerTitle: true,
          showBackButton: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Text(
                        controller.bodyText.value,
                        style: AppTextStyles.paragraph_2_Regular.copyWith(
                            color: AppColors.neutral200,
                            height: 1.5.h
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  PrimaryButton(
                    width: double.infinity,
                    onPressed: () {
                      Get.offAllNamed(Routes.MAIN_APP);
                    },
                    text: "Back to Home",
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}