import 'package:get/get.dart';

 import '../../../../presentation/myOrder/order/controllers/my_order.controller.dart';
import '../../../../presentation/myOrder/orderDetails/controllers/order_details.controller.dart';

class MyOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyOrderController>(
      () => MyOrderController(),
    ); Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(),
    );
  }
}
