import 'package:get/get.dart';

import '../../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/utils/api_content.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../../infrastructure/utils/secure_storage_helper.dart';
import '../../../shared/widgets/customButtomNavigation/customButtomNavigationBar.dart';

class SplashScreenController extends GetxController {

  List<String> images = [
    AppImages.p6, AppImages.p2, AppImages.p7, AppImages.p5,
    AppImages.p3, AppImages.p8, AppImages.p9, AppImages.p2,
    AppImages.p6, AppImages.p5, AppImages.p8, AppImages.p1,
    AppImages.p7, AppImages.p5, AppImages.p4, AppImages.p6,
    AppImages.p9, AppImages.p2, AppImages.p6, AppImages.p5,
  ];


 Future<void> startSplashTimer() async {
   String role = await SecureStorageHelper.getString(ApiConstants.userRole);
   Future.delayed(Duration(milliseconds: 2600),() async {


    if(role.isNotEmpty){
      Get.offAllNamed(Routes.MAIN_APP);
      //Get.offAllNamed(Routes.ROLE_SELECTION);

    }else{
      Get.offAllNamed(Routes.ROLE_SELECTION);
    }

   });
 }
}
