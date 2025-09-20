import 'package:get/get.dart';

import '../../../../presentation/tools/addProduct/controllers/add_product.controller.dart';

class AddProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(
      () => AddProductController(),
    );
  }
}
