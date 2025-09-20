import 'package:get/get.dart';

import '../../../../presentation/tools/Orders/controllers/orders.controller.dart';

class OrdersControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(),
    );
  }
}
