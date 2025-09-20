import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/imagePicker/custom_image_picker.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/imagePicker/imagePickerController.dart';

import '../../../commonWidgets/customTextFormFieldTwo.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/schedule_action_settings.controller.dart';

class StoreInformationScreen extends GetView<storeInformationController> {
  const StoreInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePickerController imageController = Get.put(
      imagePickerController(),
    );

    return Scaffold(
      appBar: CustomAppBar(title: "Store Information", centerTitle: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12.h),

            // Wrap the conditional UI in Obx to make it reactive
            Obx(() {
              if (imageController.selectedImages.isNotEmpty) {
                return Stack(
                  children: [
                    Container(
                      height: 200.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(width: 1.w, color: AppColors.neutral800),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.file(
                          imageController.selectedImages.first,
                          height: 200.h,
                          width: 200.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Add remove button
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () {
                          imageController.removeImage(0);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ),
                    // Add edit button
                    Positioned(
                      bottom: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () {
                          showImagePickerOption(context, imageController);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary800,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    showImagePickerOption(context, imageController);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(width: 1.w, color: AppColors.neutral800),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: InkWell(
                        onTap: () {
                          showImagePickerOption(context, imageController);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 13.5.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Store Logo',
                                style: AppTextStyles.paragraph_2_Regular.copyWith(
                                  color: AppColors.neutral200,
                                ),
                              ),
                              SvgPicture.asset(
                                AppImages
                                    .interfaceAddSquareSquareRemoveCrossButtonsAddPlusButtonStreamlineCore,
                                height: 14.86.h,
                                width: 14.86.w,
                                color: AppColors.neutral50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),

            SizedBox(height: 14.h),
            CustomTextFormFieldTwo(hintText: "Store Name"),
            SizedBox(height: 24.h),
            PrimaryButton(
              width: double.infinity,
              onPressed: () {},
              text: "Update",
            ),
          ],
        ),
      ),
    );
  }
}