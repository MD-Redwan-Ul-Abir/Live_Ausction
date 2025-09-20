import 'package:get/get.dart';

import '../../../../presentation/setupProfile/guideLine/controllers/guide_line.controller.dart';

class GuideLineControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuideLineController>(
      () => GuideLineController(),
    );
  }
}
