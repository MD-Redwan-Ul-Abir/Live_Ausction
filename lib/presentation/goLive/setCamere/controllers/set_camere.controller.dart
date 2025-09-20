import 'package:get/get.dart';
import 'package:camera/camera.dart';

import '../../../../infrastructure/navigation/routes.dart';

class SetCamereController extends GetxController {

  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    // Don't dispose camera here since it will be used in LiveScreen
    // Only dispose when the live stream actually ends
    super.onClose();
  }

  Future<void> initializeCamera() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Get available cameras
      cameras = await availableCameras();

      if (cameras.isEmpty) {
        error.value = 'No cameras available on this device';
        isLoading.value = false;
        return;
      }

      // Initialize with front camera if available, otherwise use first camera
      selectedCameraIndex = cameras.indexWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );
      if (selectedCameraIndex == -1) {
        selectedCameraIndex = 0;
      }

      await _initializeCameraController();
    } catch (e) {
      error.value = 'Failed to initialize camera: ${e.toString()}';
      isLoading.value = false;
    }
  }

  Future<void> _initializeCameraController() async {
    try {
      // Set loading state
      isLoading.value = true;
      isCameraInitialized.value = false;
      error.value = '';

      // Dispose previous controller if exists and wait for complete disposal
      if (cameraController != null) {
        await cameraController!.dispose();
        cameraController = null;
        // Add a small delay to ensure complete disposal
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Create new controller
      cameraController = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.medium,
        enableAudio: false,
      );

      // Initialize the controller
      await cameraController!.initialize();

      // Only set initialized to true if controller is still valid
      if (cameraController != null && cameraController!.value.isInitialized) {
        isCameraInitialized.value = true;
        isLoading.value = false;
      } else {
        throw Exception('Camera controller initialization failed');
      }
    } catch (e) {
      error.value = 'Camera initialization failed: ${e.toString()}';
      isLoading.value = false;
      isCameraInitialized.value = false;

      // Ensure controller is disposed on error
      await cameraController?.dispose();
      cameraController = null;
    }
  }

  Future<void> switchCamera() async {
    if (cameras.length < 2 || isLoading.value) return;

    try {
      // Update selected camera index
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

      // Reinitialize with new camera
      await _initializeCameraController();
    } catch (e) {
      error.value = 'Failed to switch camera: ${e.toString()}';
      // Try to reinitialize with original camera
      selectedCameraIndex = (selectedCameraIndex - 1 + cameras.length) % cameras.length;
      await _initializeCameraController();
    }
  }

  Future<void> disposeCamera() async {
    await cameraController?.dispose();
    cameraController = null;
    isCameraInitialized.value = false;
  }

  void startAction() {
    if (isCameraInitialized.value && cameraController != null) {
      // Put the controller in GetX dependency injection so LiveController can find it
      Get.put<SetCamereController>(this, permanent: true);

      // Navigate to live screen with camera controller ready
      Get.toNamed(Routes.LIVE);
      print('Start button pressed - Camera ready for live streaming');
    } else {
      print('Camera not initialized, cannot start live streaming');
    }
  }

  // Add method to properly dispose camera when live streaming ends
  void endLiveStream() {
    disposeCamera();
  }
}