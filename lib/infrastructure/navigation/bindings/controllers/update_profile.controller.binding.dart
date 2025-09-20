import 'package:get/get.dart';

import '../../../../presentation/profile/updateProfile/controllers/update_profile.controller.dart';

class UpdateProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(),
    );
  }
}
