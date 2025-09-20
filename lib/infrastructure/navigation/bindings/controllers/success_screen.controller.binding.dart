import 'package:get/get.dart';

import '../../../../presentation/auth/successScreen/controllers/success_screen.controller.dart';

class SuccessScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessScreenController>(
      () => SuccessScreenController(),
    );
  }
}
