import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/profile/walletSection/myWallet/controllers/my_wallet.controller.dart';

class AddPaymentMethodeController extends GetxController {

  final MyWalletController myWalletController = Get.find<MyWalletController>();


  RxBool stripeActive = false.obs;
  RxBool googlePayActive = false.obs;

  void stripeActivation(){
     stripeActive.value = true;
     googlePayActive.value = false;
  }
  void googlePayActivation(){
     stripeActive.value = false;
     googlePayActive.value = true;
  }

}
