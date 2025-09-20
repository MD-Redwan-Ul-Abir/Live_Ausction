import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../home/liveStreamming/userWidgetOfLiveStreamming/userLiveWidget.dart';
import 'controllers/live.controller.dart';

class LiveScreen extends GetView<LiveController> {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Stack(
          children: [
            // Full screen camera preview
            Positioned.fill(
              child: Obx(() {
                // Error state
                if (controller.errorMessage.value.isNotEmpty) {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Camera Error',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () =>
                                controller.initializeVideoPlayer(),
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Loading state
                if (controller.isLoading.value) {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primary1000,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Loading camera...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Camera preview
                if (controller.isCameraInitialized.value &&
                    controller.cameraController != null &&
                    controller.cameraController!.value.isInitialized) {
                  try {
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.cameraController!.value.previewSize!.height,
                        height: controller.cameraController!.value.previewSize!.width,
                        child: CameraPreview(controller.cameraController!),
                      ),
                    );
                  } catch (e) {
                    return Container(
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          'Camera preview error',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Camera not available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),

            ///-------- main ui component is here for user-------------------
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              // CRITICAL: Must have bottom constraint
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
                child: UserLiveWidget( ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}