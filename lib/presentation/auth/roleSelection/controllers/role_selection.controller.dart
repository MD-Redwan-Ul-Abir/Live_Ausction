import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/log_helper.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/utils/api_content.dart';
import '../../../../infrastructure/utils/secure_storage_helper.dart';
import '../../../../main.dart';

class RoleSelectionController extends GetxController {
  final RxString selectedRole = ''.obs;

  static AppController get to => Get.find();

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void proceedToNext() {
    if (selectedRole.value.isNotEmpty) {
      _saveRolePreference(selectedRole.value);

      if (selectedRole.value == 'seller') {
        // LoggerHelper.warn("Going to meet ${selectedRole.value}");
        print('Navigating to seller flow');
      } else {
        // LoggerHelper.error("Going to meet ${selectedRole.value}");
        print('Navigating to buyer flow');
      }
    }
  }

  Future<void> _saveRolePreference(String role) async {
    await SecureStorageHelper.setString(ApiConstants.userRole, role);

     LoggerHelper.info("User role is: ${AppController.to.role.value}");


    AppController.to.setRole(selectedRole.value);

     //bool loggedIn = AppController.to.isLoggedIn.value;

    Get.toNamed(Routes.SIGN_UP_WITH_EMAIL);

    //String role = await SecureStorageHelper.getString("role");
    // LoggerHelper.info("Going to meet $role");
    //SecureStorageHelper.remove("userRole");
  }
}
