import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/presentation/home/addScheduleShow/scheduleShow/controllers/schedule_show.controller.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/imagePicker/custom_image_picker.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/imagePicker/imagePickerController.dart';

class Schedule2 extends StatefulWidget {
  const Schedule2({super.key});

  @override
  State<Schedule2> createState() => _Schedule2State();
}

class _Schedule2State extends State<Schedule2> {
  ScheduleShowController scheduleShowController =
      Get.find<ScheduleShowController>();
  final imageController = Get.put(imagePickerController());


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
        padding:   EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload your Show \nThumbnail',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'please ensure a clear photo',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral200,
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (scheduleShowController.thumbnail.value != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: Image.file(
                        scheduleShowController.thumbnail.value!,
                        width: 124.w,
                        height: 124.w,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return _buildUploadBox(context, isFront: true);
                }),
              ],
            ),
            SizedBox(height: 16.h),


            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
  Widget _buildUploadBox(BuildContext context, {required bool isFront}) {
    return GestureDetector(
      onTap: () => showImagePickerOption(context, imageController),
      child: Obx(() {
        File? selectedImage =  scheduleShowController.thumbnail.value;


        return Padding(
          padding: EdgeInsets.all(1.sp),
          child: DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [5, 5],
              color: AppColors.neutral200,
              strokeWidth: 1.w,
              borderPadding: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
            ),
            child: Container(
              width: 124.w,
              height: 124.w,
              decoration: BoxDecoration(
                color: AppColors.neutral800,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages
                        .interfaceAdd1ExpandCrossButtonsButtonMoreRemovePlusAddStreamlineCore,
                    height: 22.29.w,
                    width: 22.29.w,
                    color: AppColors.neutral50,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Upload\nPhoto',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }


}
