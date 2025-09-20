import 'package:get/get.dart';

 import '../../../../presentation/goLive/goLive/controllers/sell_screen.controller.dart';

class SellScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellScreenController>(
      () => SellScreenController(),
    );
  }
}
