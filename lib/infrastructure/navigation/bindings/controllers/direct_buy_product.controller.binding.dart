import 'package:get/get.dart';

import '../../../../presentation/home/directBuyProduct/controllers/direct_buy_product.controller.dart';

class DirectBuyProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectBuyProductController>(
      () => DirectBuyProductController(),
    );
  }
}
