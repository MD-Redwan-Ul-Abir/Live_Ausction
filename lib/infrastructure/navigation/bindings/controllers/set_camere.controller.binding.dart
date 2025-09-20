import 'package:get/get.dart';

import '../../../../presentation/goLive/setCamere/controllers/set_camere.controller.dart';

class SetCamereControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetCamereController>(
      () => SetCamereController(),
    );
  }
}
