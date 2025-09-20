import 'package:get/get.dart';

import '../../../../presentation/categories/controllers/categories.controller.dart';

class CategoriesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
    );
  }
}
