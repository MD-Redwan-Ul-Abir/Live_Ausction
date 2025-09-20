import 'package:get/get.dart';

import '../../../../infrastructure/utils/app_images.dart';

class ProductSelectionController extends GetxController {
  // List to store selected item titles
  final RxList<String> selectedItems = <String>[].obs;

  final List<Map<String, String>> itemSelection = [
    {'image': AppImages.selectionImage1, 'title': 'Sneakers'},
    {'image': AppImages.selectionImage2, 'title': 'Sports cards'},
    {'image': AppImages.selectionImage3, 'title': 'Video Games'},
    {'image': AppImages.selectionImage1, 'title': 'Sneakers'},
    {'image': AppImages.selectionImage2, 'title': 'Sports cards'},
    {'image': AppImages.selectionImage3, 'title': 'Video Games'},
    {'image': AppImages.selectionImage1, 'title': 'Sneakers'},
    {'image': AppImages.selectionImage2, 'title': 'Sports cards'},
    {'image': AppImages.selectionImage3, 'title': 'Video Games'},    {'image': AppImages.selectionImage1, 'title': 'Sneakers'},
    {'image': AppImages.selectionImage2, 'title': 'Sports cards'},
    {'image': AppImages.selectionImage3, 'title': 'Video Games'},
  ];

  // Method to toggle item selection
  void toggleItemSelection(String title) {
    if (selectedItems.contains(title)) {
      selectedItems.remove(title);
    } else {
      selectedItems.add(title);
    }
  }

  // Method to check if item is selected
  bool isItemSelected(String title) {
    return selectedItems.contains(title);
  }

  // Method to get selected items count
  int get selectedItemsCount => selectedItems.length;

  // Method to clear all selections
  void clearSelections() {
    selectedItems.clear();
  }
}