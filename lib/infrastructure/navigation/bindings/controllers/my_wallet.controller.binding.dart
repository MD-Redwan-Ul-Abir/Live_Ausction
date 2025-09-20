import 'package:get/get.dart';

import '../../../../presentation/profile/walletSection/myWallet/controllers/my_wallet.controller.dart';

class MyWalletControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(
      () => MyWalletController(),
    );
  }
}
