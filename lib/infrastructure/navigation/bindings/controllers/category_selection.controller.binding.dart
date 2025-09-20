import 'package:get/get.dart';

import '../../../../presentation/setupProfile/categorySelection/controllers/category_selection.controller.dart';

class CategorySelectionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorySelectionController>(
      () => CategorySelectionController(),
    );
  }
}
