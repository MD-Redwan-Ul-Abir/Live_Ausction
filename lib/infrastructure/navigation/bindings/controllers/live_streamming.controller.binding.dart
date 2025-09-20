import 'package:get/get.dart';

import '../../../../presentation/home/liveStreamming/controllers/live_streamming.controller.dart';

class LiveStreammingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveStreammingController>(
      () => LiveStreammingController(),
    );
  }
}
