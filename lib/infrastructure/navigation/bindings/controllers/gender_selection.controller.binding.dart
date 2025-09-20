import 'package:get/get.dart';

import '../../../../presentation/setupProfile/genderSelection/controllers/gender_selection.controller.dart';

class GenderSelectionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenderSelectionController>(
      () => GenderSelectionController(),
    );
  }
}
