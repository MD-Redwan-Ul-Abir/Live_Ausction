import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_auction_marketplace/infrastructure/utils/log_helper.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../shared/widgets/imagePicker/imagePickerController.dart';
import '../../successScreen/controllers/success_screen.controller.dart';

class SellerInformationController extends GetxController {

  PageController pageController = PageController();
  final imageController = Get.put(imagePickerController());


  // Observable variables
  final currentPage = 0.obs;
  final totalPages = 2;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Selfie image
  final Rx<File?> selfieImage = Rx<File?>(null);
  
  // ID card images
  final Rx<File?> frontIdImage = Rx<File?>(null);
  final Rx<File?> backIdImage = Rx<File?>(null);

  final businessIdController = TextEditingController();
  final addressController = TextEditingController();


  double get progress => (currentPage.value + 1) / totalPages;


  @override
  void onClose() {
    pageController.dispose();
    businessIdController.dispose();
    addressController.dispose();
    super.onClose();
  }

  // Navigate to next page
  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      if (pageController.hasClients) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // Handle final submission
      _submitSellerInformation();
    }
  }

  // Navigate to previous page
  void previousPage() {
    if (currentPage.value > 0) {
      if (pageController.hasClients) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  // Handle page change
  void onPageChanged(int page) {
    currentPage.value = page;
  }

  // Handle selfie capture
  Future<void> takeSelfie() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );
      
      if (photo != null) {
        selfieImage.value = File(photo.path);
      }
    } catch (e) {
     LoggerHelper.error(e);
    }
  }


  void selectFrontIdImage() {
    if (imageController.selectedImages.isNotEmpty) {
      frontIdImage.value = imageController.selectedImages.last;
      imageController.clearAllImages();
    }
  }
  
  // Handle back ID card image selection
  void selectBackIdImage() {
    if (imageController.selectedImages.isNotEmpty) {
      backIdImage.value = imageController.selectedImages.last;
      imageController.clearAllImages();
    }
  }

  // Pick front ID card image
  Future<void> pickFrontIdImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      frontIdImage.value = File(pickedFile.path);
    }
  }

  // Pick back ID card image
  Future<void> pickBackIdImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      backIdImage.value = File(pickedFile.path);
    }
  }

  // Validate current page data
  bool _validateCurrentPage() {
    switch (currentPage.value) {
      case 0:

        return true;
      case 1:

        return addressController.text.isNotEmpty;
      case 2:
        return true;
      default:
        return false;
    }
  }

void validateSignup(){
  // Check if front ID card is uploaded
  if (frontIdImage.value == null) {
    Get.snackbar(
      '!! Warning !!',
      'Front of ID card is required',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  // Check if back ID card is uploaded
  if (backIdImage.value == null) {
    Get.snackbar(
      '!! Warning !!',
      'Back of ID card is required',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  // Check if address is filled
  if (addressController.text.trim().isEmpty) {
    Get.snackbar(
      '!! Warning !!',
      'Address field is required',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return;
  }

  Get.find<SuccessScreenController>().initializeSuccessScreen(
    title: "Sign up successful",
    subTitle: "Please Check your Email",
    buttonText: "Next",
    onPressed: () {
      Get.offAllNamed(Routes.GUIDE_LINE);
    },
  );
  Get.toNamed(Routes.SUCCESS_SCREEN);
}
  // Save current page data
  void saveCurrentPage() {
    if (_validateCurrentPage()) {
      Get.snackbar('Success', 'Data saved successfully');
    } else {
      Get.snackbar('Error', 'Please fill all required fields');
    }
  }

  // Submit seller information
  void _submitSellerInformation() {
    if (_validateAllPages()) {
      // TODO: Implement API call to submit seller information
      Get.snackbar('Success', 'Seller information submitted successfully!');

      // Navigate to next screen or close
      // Get.offNamed('/dashboard'); // Example navigation
    } else {
      Get.snackbar('Error', 'Please complete all required information');
    }
  }

  // Validate all pages
  bool _validateAllPages() {
    // TODO: Add comprehensive validation for all pages
    return addressController.text.isNotEmpty;
  }

  // Skip the process
  void skipProcess() {
    Get.dialog(
      AlertDialog(
        title: const Text('Skip Seller Registration?'),
        content: const Text('You can complete this process later from your profile settings.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Navigate to main app or dashboard
              Get.snackbar('Info', 'Seller registration skipped');
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}