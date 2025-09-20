import 'package:get/get.dart';

import '../../../../presentation/setupProfile/howDoesItWorks/controllers/how_does_it_works.controller.dart';

class HowDoesItWorksControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowDoesItWorksController>(
      () => HowDoesItWorksController(),
    );
  }
}
