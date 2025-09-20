import 'package:get/get.dart';

import '../../../../presentation/profile/Account/controllers/account.controller.dart';
import '../../../../presentation/categories/controllers/categories.controller.dart';
import '../../../../presentation/goLive/goLive/controllers/sell_screen.controller.dart';
import '../../../../presentation/home/homeScreen/controllers/home.controller.dart';
import '../../../../presentation/main_app/controllers/main_app.controller.dart';
import '../../../../presentation/myOrder/order/controllers/my_order.controller.dart';
import '../../../../presentation/myOrder/orderDetails/controllers/order_details.controller.dart';
import '../../../../presentation/tools/toolsScreen/controllers/tools.controller.dart';

class MainAppControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainAppController>(() => MainAppController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    Get.lazyPut<AccountController>(() => AccountController());
    Get.lazyPut<MyOrderController>(() => MyOrderController());
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController());
    Get.lazyPut<SellScreenController>(() => SellScreenController());
    Get.lazyPut<ToolsController>(() => ToolsController());
  }
}
