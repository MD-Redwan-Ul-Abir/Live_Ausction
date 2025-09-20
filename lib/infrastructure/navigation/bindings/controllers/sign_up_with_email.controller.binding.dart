import 'package:get/get.dart';

import '../../../../presentation/auth/signUpWithEmail/controllers/sign_up_with_email.controller.dart';

class SignUpWithEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpWithEmailController>(
      () => SignUpWithEmailController(),
    );
  }
}
