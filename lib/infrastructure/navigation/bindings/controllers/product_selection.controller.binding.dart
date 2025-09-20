import 'package:get/get.dart';

import '../../../../presentation/setupProfile/productSelection/controllers/product_selection.controller.dart';

class ProductSelectionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductSelectionController>(
      () => ProductSelectionController(),
    );
  }
}
