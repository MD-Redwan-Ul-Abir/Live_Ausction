import 'package:get/get.dart';

import '../../../../presentation/myOrder/returnProduct/controllers/return_product.controller.dart';

class ReturnProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnProductController>(
      () => ReturnProductController(),
    );
  }
}
