import 'package:get/get.dart';

import '../../../../presentation/tools/myIncome/controllers/my_income.controller.dart';

class MyIncomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyIncomeController>(
      () => MyIncomeController(),
    );
  }
}
