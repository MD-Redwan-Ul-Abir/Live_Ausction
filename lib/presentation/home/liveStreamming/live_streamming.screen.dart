import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
 import 'package:live_auction_marketplace/presentation/home/liveStreamming/userWidgetOfLiveStreamming/userLiveWidget.dart';
import 'package:video_player/video_player.dart';

import 'controllers/live_streamming.controller.dart';

class LiveStreammingScreen extends GetView<LiveStreammingController> {
  const LiveStreammingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Stack(
          children: [
           // Full screen video player
            if(controller.playVideos)
            Positioned.fill(
              child: Obx(() {
                // FIXED: Better error handling and loading states
                if (controller.hasError.value) {
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
                            'Video Error',
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
                            onPressed: () => controller.initializeVideoPlayer(),
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

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
                            'Loading video...',
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

                if (controller.videoPlayerController.value != null &&
                    controller
                        .videoPlayerController
                        .value!
                        .value
                        .isInitialized) {
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller
                          .videoPlayerController
                          .value!
                          .value
                          .size
                          .width,
                      height: controller
                          .videoPlayerController
                          .value!
                          .value
                          .size
                          .height,
                      child: VideoPlayer(
                        controller.videoPlayerController.value!,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        'Video not available',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  );
                }
              }),
            ),
            Positioned.fill(child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,   // Gradient starts here
                  end: Alignment.topCenter, // Gradient ends here
                  colors: [
                   Colors.black.withOpacity(0.3),

                    AppColors.neutral950.withOpacity(0.1), // Blue
                  ],
                ),
              ),

            )
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



// Positioned.fill(
//   child: Image.network(
//     'https://images.pexels.com/photos/33532359/pexels-photo-33532359.jpeg'
//     ,fit: BoxFit.cover,
//   ),
// ),
// The LiquidGlass widget sits on top
// Center(
//   child: LiquidGlass(
//     settings: LiquidGlassSettings(
//       refractiveIndex: 1.5,
//       lightAngle: 5*pi,
//       thickness: 20
//     ),
//     shape: LiquidRoundedSuperellipse(
//       borderRadius: Radius.circular(50),
//     ),
//     child: const SizedBox(
//       height: 200,
//       width: 200,
//       child: Center(
//         child: FlutterLogo(size: 100),
//       ),
//     ),
//   ),
// ),