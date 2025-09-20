import 'package:get/get.dart';

class CategorySelectionController extends GetxController {
  final List<String> videoGamesList = ["Retro games", "Modern Games"];
  final List<String> toysList = [
    "Disney",
    "Action Figures",
    "Funko",
    "Star wars",
    "Dolls",
    "Models & kits",

  ];
  final List<String> electronicsList = [
    "Everyday Electronics",
    "Cameras",
    "Phone",
    "Batteries",
    "Models & kits",
  ];

  // List to store selected categories for multiple selection
  final RxList<String> selectedCategories = <String>[].obs;

  // Method to toggle category selection (add/remove)
  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Method to check if a category is selected
  bool isCategorySelected(String category) {
    return selectedCategories.contains(category);
  }

  // Method to clear all selected categories
  void clearSelectedCategories() {
    selectedCategories.clear();
  }

  // Getter for selected categories count
  int get selectedCategoriesCount => selectedCategories.length;

  // Legacy methods for backward compatibility (if needed)
  void setSelectedCategory(String category) {
    toggleCategorySelection(category);
  }

  // Legacy getter that returns first selected category or empty string
  String get selectedCategory => selectedCategories.isNotEmpty ? selectedCategories.first : '';
}
