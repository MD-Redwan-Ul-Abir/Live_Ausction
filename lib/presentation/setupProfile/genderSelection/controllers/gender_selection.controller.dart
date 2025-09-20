import 'package:get/get.dart';

class GenderSelectionController extends GetxController {
  final RxString selectedRole = ''.obs;
  void selectRole(String role) {
    selectedRole.value = role;
  }
}
