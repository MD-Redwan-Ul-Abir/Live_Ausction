import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/custom_text_form_field.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/imagePicker/custom_image_picker.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../../main.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/seller_information.controller.dart';

class SellerInformationScreen extends GetView<SellerInformationController> {
  const SellerInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Seller Information',
          centerTitle: true,
          onBackPressed: () {
            if (controller.currentPage.value == 1) {
              controller.previousPage();
            } else {
              Get.back();
            }
          },
          leadingIcon:
              AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,

        ),
        body: Column(
          children: [
            // Progress Bar
            SizedBox(height: 38.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              height: 8.h,
              child: Obx(
                () => LinearProgressIndicator(
                  value: controller.progress,
                  backgroundColor: AppColors.neutral800,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary1000,
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
      
            // Page Content
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [_buildSelfieScreen(), _buildIDInfoScreen(context)],
              ),
            ),
      
            // Bottom Buttons
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelfieScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 12.h),
          Text('Hey Alex!', style: AppTextStyles.H5_Medium),
          SizedBox(height: 4.h),
          Text(
            "You’re applying for Seller",
            style: AppTextStyles.buttonRegular,
          ),
          SizedBox(height: 24.h),

          // Selfie Circle
          GestureDetector(
            onTap: () {
              controller.takeSelfie();
            },
            child: Obx(
              () => controller.selfieImage.value != null
                  ? Container(
                      width: 124.w,
                      height: 124.w,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.file(
                          controller.selfieImage.value!,
                          width: 124.w,
                          height: 124.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : DottedBorder(
                      options: CircularDottedBorderOptions(
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
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.roundedCamera,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Take Selfie',
                              style: AppTextStyles.buttonRegular,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildIDInfoScreen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Enter your NId Information',
                style: AppTextStyles.paragraph_1_Medium.copyWith(
                  color: AppColors.neutral50,
                ),
              ),
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Front of ID Card',
                        style: AppTextStyles.paragraph_1_Regular.copyWith(
                          color: AppColors.neutral50,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'please ensure a clear\nphoto',
                        style: AppTextStyles.buttonRegular.copyWith(
                          color: AppColors.neutral200,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.frontIdImage.value != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.file(
                          controller.frontIdImage.value!,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Back of ID Card',
                        style: AppTextStyles.paragraph_1_Regular.copyWith(
                          color: AppColors.neutral50,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'please ensure a clear\nphoto',
                        style: AppTextStyles.buttonRegular.copyWith(
                          color: AppColors.neutral200,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.backIdImage.value != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: Image.file(
                          controller.backIdImage.value!,
                          width: 124.w,
                          height: 124.w,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return _buildUploadBox(context, isFront: false);
                  }),
                ],
              ),

              SizedBox(height: 24.h),

              // Business ID
              Text(
                'Business ID (optional)',
                style: AppTextStyles.paragraph_2_Regular,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(hintText: 'Enter your business ID'),

              SizedBox(height: 24.h),

              // Seller Address
              Text('Seller Address', style: AppTextStyles.paragraph_2_Regular),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: 'Address',
                controller: controller.addressController,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context, bool isFront) {
    showModalBottomSheet(
      backgroundColor: AppColors.neutral950,
      context: context,
      builder: (_) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding:   EdgeInsets.all(18.sp),
            child: Row(
              children: [
                // Pick from gallery
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFront
                          ? controller.pickFrontIdImage(ImageSource.gallery)
                          : controller.pickBackIdImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          size: 50.w,
                          color: AppColors.primary1000,
                        ),
                        SizedBox(height: 8.h),
                        Text("Gallery", style: AppTextStyles.paragraph_1_Regular),
                      ],
                    ),
                  ),
                ),
                // Pick from camera
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFront
                          ? controller.pickFrontIdImage(ImageSource.camera)
                          : controller.pickBackIdImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 50.w,
                          color: AppColors.primary1000,
                        ),
                        SizedBox(height: 8.h),
                        Text("Camera", style: AppTextStyles.paragraph_1_Regular),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadBox(BuildContext context, {required bool isFront}) {
    return GestureDetector(
      onTap: () => _showImagePicker(context, isFront),
      child: Obx(() {
        File? selectedImage = isFront
            ? controller.frontIdImage.value
            : controller.backIdImage.value;

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

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Obx(
        () => Row(
          children: [
            if (controller.currentPage.value < 1)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PrimaryButton(
                      width: 148.w,
                      backgroundColor: AppColors.neutral800,
                      textColor: AppColors.defaultTextColor,
                      onPressed: () {},
                      text: "Save",
                    ),

                    PrimaryButton(
                      width: 148.w,
                      onPressed: () {
                        controller.nextPage();
                      },
                      text: "Next",
                    ),
                  ],
                ),
              ),

            if (controller.currentPage.value == 1)
              Expanded(
                child: PrimaryButton(
                  width: double.infinity,
                  onPressed: () {
                    controller.validateSignup();
                  },
                  text: 'Sign Up',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
