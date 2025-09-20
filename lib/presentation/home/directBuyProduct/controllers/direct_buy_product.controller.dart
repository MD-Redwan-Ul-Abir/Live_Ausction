import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../auth/successScreen/controllers/success_screen.controller.dart';

class DirectBuyProductController extends GetxController {
  final SuccessScreenController successScreenController = Get.put(
    SuccessScreenController(),
  );
  RxBool stripeSelected = false.obs;
  RxBool googlePaySelected = false.obs;

  Future<void> selectStripe() async {
    stripeSelected.value = true;
    googlePaySelected.value = false;
  }

  Future<void> selectGooglePay() async {
    googlePaySelected.value = true;
    stripeSelected.value = false;
  }

  void navigateToRegistrationSuccess() {
    Get.find<SuccessScreenController>().initializeSuccessScreen(
      title: "Payment Successful",
      subTitle: "Your Item will Ship soon",
      buttonText: "Track Order",
      secondButtonText: "Go to My Orders",
      secondButtonActive: true,
      onPressed: () {
        Get.offAllNamed(Routes.TRACK_ORDER);
      },
      onSecondButtonPress: () {
        Get.offAllNamed(Routes.MAIN_APP);
      },
    );

    Get.toNamed(Routes.SUCCESS_SCREEN);
  }
}
