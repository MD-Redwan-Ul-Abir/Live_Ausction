import 'package:get/get.dart';

import '../../../../../infrastructure/navigation/routes.dart';
import '../../../successScreen/controllers/success_screen.controller.dart';

class ResetPasswordController extends GetxController {
  void navigateToRegistrationSuccess() {

    Get.find<SuccessScreenController>().initializeSuccessScreen(
      title: "Password reset successful",
      subTitle: "You just Login",
      buttonText: "Back to Login",
      onPressed: () {
        Get.offAllNamed(Routes.LOG_IN);
      },
    );
    Get.toNamed(Routes.SUCCESS_SCREEN);
  }
}
