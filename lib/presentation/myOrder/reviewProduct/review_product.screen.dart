import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/customRatings/customRatings.dart';

import '../../shared/widgets/imagePicker/custom_image_picker.dart';
import 'controllers/review_product.controller.dart';


class ReviewProductScreen extends GetView<ReviewProductController> {
  const ReviewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: "Reviews", centerTitle: true),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your Rating',
                  style: AppTextStyles.H5_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                SizedBox(height: 12.h),
                Obx(
                      () => CustomSvgRatingBar(
                    rating: controller.rating.value,
                    fullIconPath: AppImages.ratingsIcon2,
                    halfIconPath: AppImages.ratingsIcon2Empty,
                    emptyIconPath: AppImages.ratingsIcon2Empty,
                    onRatingChanged: (newRating) {
                      controller.updateRating(newRating);
                    },
                  ),
                ),
                SizedBox(height: 32.h),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Write Review',
                    style: AppTextStyles.paragraph_2_Medium.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormFieldTwo(
                  hintText: 'Type Review here',
                  keyboardType: 'multiline',
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '10/1000',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Image picker section
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Add Images',
                    style: AppTextStyles.paragraph_2_Medium.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Image picker and preview section
                Column(
                  children: [
                    // Add image button
                    GestureDetector(
                      onTap: () {
                        showImagePickerOption(context, controller.imageController);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.neutral800,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: AppColors.neutral300,
                              size: 24.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Add Images',
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.neutral300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Selected images preview
                    Obx(() {
                      if (controller.imageController.selectedImages.isEmpty) {
                        return SizedBox.shrink();
                      }

                      return Container(
                        margin: EdgeInsets.only(top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Images (${controller.imageController.selectedImages.length}/3)',
                              style: AppTextStyles.captionRegular.copyWith(
                                color: AppColors.neutral300,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: controller.imageController.selectedImages.asMap().entries.map((entry) {
                                int index = entry.key;
                                File image = entry.value;

                                return Stack(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(
                                          color: AppColors.neutral200,
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4.h,
                                      right: 4.w,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.imageController.removeImage(index);
                                        },
                                        child: Container(
                                          width: 20.w,
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 12.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),

                SizedBox(height: 32.h),

                PrimaryButton(
                  onPressed: () {},
                  text: 'Submit Review',
                  width: double.infinity,
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}