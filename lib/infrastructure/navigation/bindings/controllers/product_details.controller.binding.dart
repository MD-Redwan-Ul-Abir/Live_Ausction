import 'package:get/get.dart';

import '../../../../presentation/home/productDetails/controllers/product_details.controller.dart';

class ProductDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
    );
  }
}
