import 'package:get/get.dart';

import '../../../../presentation/goLive/live/controllers/live.controller.dart';
import '../../../../presentation/goLive/setCamere/controllers/set_camere.controller.dart';

class LiveControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveController>(
      () => LiveController(),
    );  Get.lazyPut<SetCamereController>(
      () => SetCamereController(),
    );
  }
}
