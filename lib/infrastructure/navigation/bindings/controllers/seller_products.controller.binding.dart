import 'package:get/get.dart';

import '../../../../presentation/tools/sellerProducts/controllers/seller_products.controller.dart';

class SellerProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProductsController>(
      () => SellerProductsController(),
    );
  }
}
