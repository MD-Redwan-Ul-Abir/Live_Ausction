import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../../setCamere/controllers/set_camere.controller.dart';

class LiveController extends GetxController {
  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getCameraFromSetCameraController();
  }

  void _getCameraFromSetCameraController() {
    try {
      // Import the SetCamereController class first
      final setCameraController = Get.find<SetCamereController>();

      if (setCameraController.cameraController != null &&
          setCameraController.isCameraInitialized.value) {
        // Use the same camera controller instance
        cameraController = setCameraController.cameraController;
        isCameraInitialized.value = true;
        isLoading.value = false;
        errorMessage.value = '';

        print('Camera controller successfully transferred from SetCameraScreen');
      } else {
        throw Exception('Camera not properly initialized in SetCameraScreen');
      }
    } catch (e) {
      errorMessage.value = 'Failed to get camera from previous screen: ${e.toString()}';
      isLoading.value = false;
      print('Error getting camera controller: $e');
    }
  }

  void initializeVideoPlayer() {
    // Retry getting camera from SetCameraController
    isLoading.value = true;
    errorMessage.value = '';
    _getCameraFromSetCameraController();
  }

  void disposeCamera() {
    try {
      // First update our state to prevent UI issues
      isCameraInitialized.value = false;
      isLoading.value = false;
      cameraController = null;
      
      // Then dispose the actual camera
      final setCameraController = Get.find<SetCamereController>();
      setCameraController.endLiveStream();
    } catch (e) {
      print('Error disposing camera from LiveController: $e');
    }
  }

  @override
  void onClose() {
    // Don't dispose the camera controller here as it's owned by SetCamereController
    super.onClose();
  }
}