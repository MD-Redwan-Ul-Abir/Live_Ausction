import 'package:get/get.dart';

import '../../../../presentation/home/addScheduleShow/scheduleShow/controllers/schedule_show.controller.dart';

class ScheduleShowControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleShowController>(
      () => ScheduleShowController(),
    );
  }
}
