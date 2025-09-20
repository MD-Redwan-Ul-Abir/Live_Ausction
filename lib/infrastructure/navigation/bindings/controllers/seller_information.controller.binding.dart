import 'package:get/get.dart';

import '../../../../presentation/auth/sellerInformation/controllers/seller_information.controller.dart';

class SellerInformationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerInformationController>(
      () => SellerInformationController(),
    );
  }
}
