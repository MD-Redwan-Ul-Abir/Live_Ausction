import 'package:get/get.dart';

import '../../../../presentation/myOrder/trackOrder/controllers/track_order.controller.dart';

class TrackOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(
      () => TrackOrderController(),
    );
  }
}
