import 'package:get/get.dart';

import '../../../../infrastructure/utils/app_images.dart';
import '../../../../main.dart';

class HowDoesItWorksController extends GetxController {
  static AppController get to => Get.find();

  List<Map<String, String>> selectedWorkList = [];
  RxInt currentIndex = 0.obs;

  // LoggerHelper.info("User role is: ${AppController.to.role.value}");
  //
  //
  // AppController.to.setRole(selectedRole.value);

  @override
  void onInit() {
    super.onInit();

    if (AppController.to.role.value == 'Buyer') {
      selectedWorkList = [
        {'image': AppImages.productImage, 'title': 'Watch & Shop','subTitle':'Join a live show to Purchase items, chat with Sellers in real time.'},
        {'image': AppImages.productImage, 'title': 'Swipe to Bid','subTitle':'Bid on items in a live Show to purchase. shop with confidence,get the item your ordered or your Money Back.'},
      ];
    }else{
      selectedWorkList = [
        {'image': AppImages.sitePic, 'title': 'Creating a Show','subTitle':'Join a live show to Purchase items, chat with Sellers in real time.'},
        {'image': AppImages.productImage, 'title': 'Scheduling your Show','subTitle':'Bid on items in a live Show to purchase. shop with confidence,get the item your ordered or your Money Back.'},
      ];
    }
  }
}
