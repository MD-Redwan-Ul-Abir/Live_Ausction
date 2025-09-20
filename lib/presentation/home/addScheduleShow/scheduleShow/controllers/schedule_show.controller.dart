import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/navigation/routes.dart';
import '../../../../shared/widgets/imagePicker/imagePickerController.dart';

class ScheduleShowController extends GetxController {
  late PageController pageController;

  var currentStep = 0.obs;
  final RxInt totalSteps = 4.obs;
  final Rx<File?> thumbnail = Rx<File?>(null);

  // Form data observables
  var title = ''.obs;
  var category = 'Everyday Electronics'.obs;
  var subcategory = 'Phone'.obs;
  var description = ''.obs;
  var stockAvailable = 24.obs;
  var salesFormat = 'Auction'.obs;
  var startingBid = 1.0.obs;
  var buyNowPrice = 143.0.obs;
  var selectedColor = 'Green'.obs;
  var selectedSize = 'XL'.obs;
  var firstTime = true.obs;

  // Dropdown options
  final List<String> categories = ['Everyday Electronics', 'Fashion', 'Home'];
  final List<String> subcategories = ['Phone', 'Laptop', 'Tablet'];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();


    totalSteps.value = firstTime.value ? 6 : 4;

    if (!Get.isRegistered<imagePickerController>()) {
      Get.put(imagePickerController());
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }



  void nextStep() {
    if (currentStep.value < totalSteps.value - 1) {

      currentStep.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle finish action - this is the last step

      firstTime.value = false;

      Get.offAllNamed(Routes.MAIN_APP);
      }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void incrementStock() {
    stockAvailable.value++;
  }

  void decrementStock() {
    if (stockAvailable.value > 0) {
      stockAvailable.value--;
    }
  }

  void updateTitle(String value) {
    title.value = value;
  }

  void updateCategory(String value) {
    category.value = value;
  }

  void updateSubcategory(String value) {
    subcategory.value = value;
  }

  void updateDescription(String value) {
    description.value = value;
  }

  void updateSalesFormat(String value) {
    salesFormat.value = value;
  }

  void updateStartingBid(String value) {
    startingBid.value = double.tryParse(value) ?? 1.0;
  }

  void updateBuyNowPrice(String value) {
    buyNowPrice.value = double.tryParse(value) ?? 143.0;
  }

  void updateColor(String value) {
    selectedColor.value = value;
  }

  void updateSize(String value) {
    selectedSize.value = value;
  }

  String get buttonText => currentStep.value == totalSteps.value - 1 ? 'Finish' : 'Next';
}