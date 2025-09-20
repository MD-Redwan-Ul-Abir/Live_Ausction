import 'package:get/get.dart';

import '../../../../presentation/home/sellerHomeScreen/sellerHome/controllers/seller_home.controller.dart';

class SellerHomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerHomeController>(
      () => SellerHomeController(),
    );
  }
}
