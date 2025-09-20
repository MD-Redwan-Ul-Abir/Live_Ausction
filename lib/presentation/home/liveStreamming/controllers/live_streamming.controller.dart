import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import '../../../../infrastructure/utils/app_images.dart';
import '../../../../main.dart';

class LiveStreammingController extends GetxController {

  static AppController get to => Get.find();

  Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  var playVideos = true ;

  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  String user = '';

  @override
  void onInit() {
    super.onInit();
    // Force portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize video player with your video source
    initializeVideoPlayer();
  }

  @override
  void onClose() {
    // Clean up video player
    videoPlayerController.value?.dispose();

    // Reset orientation to system default
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.onClose();
  }

  void initializeVideoPlayer() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // FIXED: Ensure proper asset path
      print('Initializing video with asset: ${AppImages.date}');

      // Create controller with asset
 videoPlayerController.value = VideoPlayerController.asset(AppImages.demoVideo2);

      // FIXED: Add listener for initialization
      videoPlayerController.value!.addListener(() {
        if (videoPlayerController.value!.value.hasError) {
          hasError.value = true;
          errorMessage.value = 'Video player error: ${videoPlayerController.value!.value.errorDescription}';
          isLoading.value = false;
          print('Video player error: ${videoPlayerController.value!.value.errorDescription}');
        }
      });

      // Initialize the video
      await videoPlayerController.value!.initialize();

      // FIXED: Check if initialization was successful
      if (videoPlayerController.value!.value.isInitialized) {
        print('Video initialized successfully');
        print('Video duration: ${videoPlayerController.value!.value.duration}');
        print('Video size: ${videoPlayerController.value!.value.size}');

        // Set video to loop (optional)
        videoPlayerController.value!.setLooping(true);

        // FIXED: Add small delay before auto-play to ensure everything is ready
        await Future.delayed(Duration(milliseconds: 100));

        // Auto-play the video (optional)
        playVideo();

        isLoading.value = false;
      } else {
        throw Exception('Video failed to initialize');
      }

    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load video: $e';
      isLoading.value = false;
      print('Video initialization error: $e');

      // FIXED: Print more detailed error information
      print('Asset path being used: ${AppImages.demoVideo}');
      print('Make sure the video file exists in the assets folder and is declared in pubspec.yaml');
    }
  }

  void playVideo() {
    if (videoPlayerController.value != null &&
        videoPlayerController.value!.value.isInitialized) {
      videoPlayerController.value?.play();
      print('Playing video');
    } else {
      print('Cannot play video - controller not initialized');
    }
  }

  void pauseVideo() {
    if (videoPlayerController.value != null &&
        videoPlayerController.value!.value.isInitialized) {
      videoPlayerController.value?.pause();
      print('Pausing video');
    }
  }

  void resetVideo() {
    if (videoPlayerController.value != null &&
        videoPlayerController.value!.value.isInitialized) {
      videoPlayerController.value?.seekTo(Duration.zero);
    }
  }

  void togglePlayPause() {
    if (videoPlayerController.value != null &&
        videoPlayerController.value!.value.isInitialized) {
      if (videoPlayerController.value!.value.isPlaying) {
        pauseVideo();
      } else {
        playVideo();
      }
    }
  }


  void changeVideoSource(String videoUrl) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Dispose current controller
      await videoPlayerController.value?.dispose();

      // Create new controller with new source
      videoPlayerController.value = VideoPlayerController.network(videoUrl);
      await videoPlayerController.value!.initialize();

      videoPlayerController.value!.setLooping(true);
      playVideo();

      isLoading.value = false;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load new video: $e';
      isLoading.value = false;
      print('Video source change error: $e');
    }
  }
}