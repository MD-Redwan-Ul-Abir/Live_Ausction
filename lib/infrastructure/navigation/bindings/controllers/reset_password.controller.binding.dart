import 'package:get/get.dart';

import '../../../../presentation/auth/forgetPassword/resetPassword/controllers/reset_password.controller.dart';
import '../../../../presentation/auth/successScreen/controllers/success_screen.controller.dart';

class ResetPasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
    Get.lazyPut<SuccessScreenController>(
          () => SuccessScreenController(),
    );
  }
}
