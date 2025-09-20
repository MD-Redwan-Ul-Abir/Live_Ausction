import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/set_camere.controller.dart';

class SetCamereScreen extends GetView<SetCamereController> {
  const SetCamereScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Set Camera", centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 116.h),
                child: Column(
                  children: [
                    // Camera preview or placeholder
                    Obx(() => _buildCameraWidget()),
                    SizedBox(height: 8.h),
                    Obx(() => Text(
                      controller.isCameraInitialized.value
                          ? 'You can Adjust Your Camera'
                          : controller.error.value.isNotEmpty
                          ? controller.error.value
                          : 'Loading Camera...',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: controller.error.value.isNotEmpty
                            ? AppColors.red500
                            : AppColors.neutral300,
                        height: 1.5.h,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              Spacer(),
              // Switch camera button (only show if camera is working and multiple cameras available)
              Obx(() => controller.isCameraInitialized.value && controller.cameras.length > 1
                  ? Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: OutlinedButton.icon(
                  onPressed: controller.switchCamera,
                  icon: Icon(Icons.flip_camera_ios, size: 20.sp),
                  label: Text('Switch Camera'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary500,
                    side: BorderSide(color: AppColors.primary500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                ),
              )
                  : SizedBox.shrink()),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Obx(() => PrimaryButton(
                  onPressed: (controller.isCameraInitialized.value && !controller.isLoading.value)
                      ? controller.startAction
                      : null,
                  text: 'Start',
                  width: double.infinity,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraWidget() {
    if (controller.isLoading.value) {
      return _buildLoadingWidget();
    } else if (controller.error.value.isNotEmpty) {
      return _buildErrorWidget();
    } else if (controller.isCameraInitialized.value && controller.cameraController != null) {
      return _buildCameraPreview();
    } else {
      return _buildPlaceholderWidget();
    }
  }

  Widget _buildCameraPreview() {
    return Container(
      height: 343.h,
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutral800,
      ),
      clipBehavior: Clip.hardEdge,
      child: AspectRatio(
        aspectRatio: controller.cameraController!.value.aspectRatio,
        child: CameraPreview(controller.cameraController!),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      height: 343.h,
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutral800,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary500,
              strokeWidth: 2.w,
            ),
            SizedBox(height: 12.h),
            Text(
              'Initializing Camera...',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 343.h,
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutral800,
        border: Border.all(color: AppColors.red500.withOpacity(0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.red500,
              size: 32.sp,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Camera Error',
                style: AppTextStyles.paragraph_1_Medium.copyWith(
                  color: AppColors.red500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: controller.initializeCamera,
              child: Text(
                'Retry',
                style: TextStyle(color: AppColors.primary500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderWidget() {
    return Container(
      height: 343.h,
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutral800,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppImages.imageCamera2PhotosPictureCameraPhotographyPhotoPicturesStreamlineCore,
          color: AppColors.neutral50,
          height: 24.h,
          width: 24.w,
        ),
      ),
    );
  }
}