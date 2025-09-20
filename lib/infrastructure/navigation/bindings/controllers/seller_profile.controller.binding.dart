import 'package:get/get.dart';

import '../../../../presentation/home/sellerProfile/controllers/seller_profile.controller.dart';

class SellerProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerProfileController>(
      () => SellerProfileController(),
    );
  }
}
