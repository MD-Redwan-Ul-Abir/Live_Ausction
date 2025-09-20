import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../scheduleShow/controllers/schedule_show.controller.dart';

class Schedule4 extends StatefulWidget {
  const Schedule4({super.key});

  @override
  State<Schedule4> createState() => _Schedule4State();
}

class _Schedule4State extends State<Schedule4> {
  ScheduleShowController scheduleShowController =
      Get.find<ScheduleShowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Schedule a Show',
        centerTitle: true,
        onBackPressed: () {
          scheduleShowController.previousStep();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Here’s a preview of your show',
                style: AppTextStyles.H6_Regular.copyWith(
                  color: AppColors.neutral50,
                ),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'This is how your show will appear to buyers. you can\nalways edit the details later.',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral200,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              width: 220.w,
              decoration: BoxDecoration(
                color: AppColors.neutral800,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 16.h,
                  bottom: 9.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 24.w,
                          width: 24.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              AppImages.productOwner,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Jack Mama',
                          style: AppTextStyles.paragraph_2_Regular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Stack(
                      children: [
                        Container(
                          height: 234.w,
                          width: 188.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              AppImages.enjoy,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 8.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.neutral50,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Padding(
                              padding:   EdgeInsets.symmetric(vertical: 4.5.h,horizontal: 11.5.w),
                              child: Text(
                                '2/12,6:00PM',
                                style: AppTextStyles.captionRegular.copyWith(
                                  color: AppColors.neutral950,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Electronics',
                      style: AppTextStyles.paragraph_2_Medium.copyWith(
                        color: AppColors.neutral50,
                      ),

                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Everyday Electronics',
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.neutral200,
                      ),

                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
