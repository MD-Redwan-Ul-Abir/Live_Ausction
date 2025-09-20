import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../shared/widgets/imagePicker/imagePickerController.dart';

class AddProductController extends GetxController with GetSingleTickerProviderStateMixin {
  late PageController pageController;
 ///====================page 2 ====================
  late TabController tabController;
  final RxInt tabIndex = 0.obs;



  void changeTab(int index) {
    tabIndex.value = index;
    tabController.animateTo(index);
  }
  ///======================
  var currentStep = 0.obs;
  final int totalSteps = 4;

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

  // Dropdown options
  final List<String> categories = ['Everyday Electronics', 'Fashion', 'Home'];
  final List<String> subcategories = ['Phone', 'Laptop', 'Tablet'];
  final List<String> colors = ['Green', 'Red', 'Blue', 'Black', 'White'];
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this);

    // Initialize image picker controller if not already initialized
    if (!Get.isRegistered<imagePickerController>()) {
      Get.put(imagePickerController());
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    tabController.dispose();
    super.onClose();
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1 && currentStep.value != 1) {
      currentStep.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentStep.value == 1) {
      if (tabIndex.value == 0) {
        changeTab(1);
      } else if (tabIndex.value == 1) {  // Fixed: added .value
        currentStep.value++;
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // Handle finish action
      _showSuccessDialog();
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

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Color(0xFF2A2A2A),
        title: Text('Success!', style: TextStyle(color: Colors.white)),
        content: Text(
          'Your Product has been added to your show.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
           // onPressed: (){},
           onPressed: () => Get.offAllNamed(Routes.MAIN_APP),
            child: Text('OK', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
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

  String get buttonText => currentStep.value == totalSteps - 1 ? 'Finish' : 'Next';
}