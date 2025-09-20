import 'package:get/get.dart';

import '../../../../presentation/profile/Account/controllers/account.controller.dart';


class AccountControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
  }
}
