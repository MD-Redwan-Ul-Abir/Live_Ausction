import 'package:get/get.dart';

import '../../../../presentation/profile/personal/controllers/personal.controller.dart';

class PersonalControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalController>(
      () => PersonalController(),
    );
  }
}
