import 'package:get/get.dart';

import '../../../../presentation/profile/walletSection/addPaymentMethode/controllers/add_payment_methode.controller.dart';
import '../../../../presentation/profile/walletSection/myWallet/controllers/my_wallet.controller.dart';

class AddPaymentMethodeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPaymentMethodeController>(
      () => AddPaymentMethodeController(),
    );    Get.lazyPut<MyWalletController>(
      () => MyWalletController(),
    );
  }
}
