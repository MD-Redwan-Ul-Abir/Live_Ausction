import 'package:get/get.dart';

import '../../../../presentation/auth/forgetPassword/verifyEmail/controllers/verify_email.controller.dart';

class VerifyEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyEmailController>(
      () => VerifyEmailController(),
    );
  }
}
