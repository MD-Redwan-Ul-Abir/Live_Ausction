import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/guide_line.controller.dart';

class GuideLineScreen extends GetView<GuideLineController> {
  const GuideLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "",
          showBackButton: false,
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GestureDetector(
                onTap: () {
                  // controller.navigationSelection();
                  Get.offAllNamed(Routes.MAIN_APP);
                },
                child: SvgPicture.asset(
                  AppImages
                      .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
                  height: 16.h,
                  width: 16.w,
                  color: AppColors.neutral50,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text('Let’s get Started!', style: AppTextStyles.H6_Regular),
                SizedBox(height: 4.h),
                Text(
                  'Before you kick off your selling journey,please agree to these Guidelines.',
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral300,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.doIcon, height: 16.h, width: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      "Do",
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.5.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.doList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.neutral500,
                          ),
                        ),
                        child: Padding(
                          padding:   EdgeInsets.symmetric(horizontal: 12.w,vertical: 13.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.doList[index]['title'] ?? '',
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.primary50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.avoid, height: 16.h, width: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      "Avoid",
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.5.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.avoidList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(

                         decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.neutral500,
                          ),
                        ),
                        child: Padding(
                          padding:   EdgeInsets.symmetric(horizontal: 12.w,vertical: 13.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.avoidList[index]['title'] ?? '',
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.primary50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            side: BorderSide(
                              color: AppColors.neutral400,
                              width: 1.w,
                            ),
                          ),
                        ),
                        child: Checkbox(
                          value: controller.isAgreed.value,
                          onChanged: (value) {
                            controller.toggleAgreement();
                          },
                          activeColor: AppColors.neutral800,
                          checkColor: AppColors.primary400,
                         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        ),
                      ),
                    )),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "Agree all of the rules? if you maintain the rule\nplease check mark it.",
                        style: AppTextStyles.buttonRegular.copyWith(
                          color: AppColors.neutral200,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Obx(() => PrimaryButton(
                  isActive: controller.isAgreed.value,
                  width: double.infinity,
                  onPressed: () {
                    controller.navigationSelection();
                  },
                  text: 'Got it!',
                )),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}