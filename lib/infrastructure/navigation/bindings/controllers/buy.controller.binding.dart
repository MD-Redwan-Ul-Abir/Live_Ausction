import 'package:get/get.dart';

import '../../../../presentation/buy/controllers/buy.controller.dart';

class BuyControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyController>(
      () => BuyController(),
    );
  }
}
