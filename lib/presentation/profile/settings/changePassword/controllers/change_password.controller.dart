import 'package:get/get.dart';

import '../../../../../infrastructure/navigation/routes.dart';
import '../../../../auth/successScreen/controllers/success_screen.controller.dart';

class ChangePasswordController extends GetxController {
  final SuccessScreenController successScreenController = Get.put(
    SuccessScreenController(),
  );
  void navigateToRegistrationSuccess() {
    Get.find<SuccessScreenController>().initializeSuccessScreen(
      title: "You have Successfully",
      subTitle: "Updated Password",
      buttonText: "Back to Home",
      onPressed: () {
        Get.offAllNamed(Routes.MAIN_APP);
      },
    );
    Get.toNamed(Routes.SUCCESS_SCREEN);
  }
}
