import 'package:get/get.dart';

 import '../../../../presentation/profile/settings/storeInformation/controllers/schedule_action_settings.controller.dart';


class ScheduleActionSettingsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<storeInformationController>(
      () => storeInformationController(),
    );
  }
}
