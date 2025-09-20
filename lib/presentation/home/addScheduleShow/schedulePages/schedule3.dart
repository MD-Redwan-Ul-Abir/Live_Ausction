import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../scheduleShow/controllers/schedule_show.controller.dart';

class Schedule3 extends StatefulWidget {
  const Schedule3({super.key});

  @override
  State<Schedule3> createState() => _Schedule3State();
}

class _Schedule3State extends State<Schedule3> {
  ScheduleShowController scheduleShowController =
  Get.find<ScheduleShowController>();
  RxInt selectedValue = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Live Listing',
        centerTitle: true,
        onBackPressed: () {
          scheduleShowController.previousStep();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              'Everyday Electronics',
              style: AppTextStyles.H6_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),

            SizedBox(height: 4.h),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Obx(() {
                      return GestureDetector(onTap: () {
                        selectedValue.value = index;
                      }, child: _products(
                          isSelected: selectedValue.value == index
                      ));
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _products({bool? isSelected}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 16.w,
          width: 16.w,
          decoration: BoxDecoration(
            color: isSelected! ? AppColors.primary1000 : Colors.transparent,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(width: 1.w, color: AppColors.neutral50),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          height: 120.w,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.primary1000,
            borderRadius: BorderRadius.circular(22.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.r),
            child: Image.asset(AppImages.watchPic, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vintage Rolex Watch',
              style: AppTextStyles.paragraph_1_Regular.copyWith(
                  color: AppColors.neutral50,
                  height: 1.5.h
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'One Size',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                  color: AppColors.neutral500,
                  height: 1.5.h
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '\$5,000',
              style: AppTextStyles.paragraph_1_Medium.copyWith(
                  color: AppColors.neutral50,
                  height: 1.5.h
              ),
            ),
          ],
        ),
      ],
    );
  }
}
