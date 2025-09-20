import 'package:get/get.dart';

import '../../../../main.dart';

class AccountController extends GetxController {
  static AppController get to => Get.find();

  late   String userRole =  '';

  @override
  void onInit() {

    super.onInit();
    userRole = AppController.to.role.value;
  }
}
