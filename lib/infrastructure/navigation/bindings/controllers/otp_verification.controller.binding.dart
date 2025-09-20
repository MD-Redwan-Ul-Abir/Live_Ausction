import 'package:get/get.dart';

import '../../../../presentation/auth/forgetPassword/otpVerification/controllers/otp_verification.controller.dart';

class OtpVerificationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationController>(
      () => OtpVerificationController(),
    );
  }
}
