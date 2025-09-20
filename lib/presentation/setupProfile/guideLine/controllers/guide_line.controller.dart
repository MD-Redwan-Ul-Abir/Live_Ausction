import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../main.dart';

class GuideLineController extends GetxController {
  static AppController get to => Get.find();

  // Observable for checkbox state
  var isAgreed = false.obs;

  final List<Map<String, String>> doList = [
    {
      'title': 'Place bids only if I intend to complete the purchase'
    },
    {
      'title': 'Make payment immediately after winning an auction'
    },
    {
      'title': 'Understand that all bids are final and binding'
    },
    {
      'title': 'Use MouvBid for lawful purposes only'
    },
    {
      'title': 'Treat sellers and fellow buyers with respect'
    },
  ];

  final List<Map<String, String>> avoidList = [
    {
      'title': 'Avoid abusive or inappropriate behavior during livestreams'
    },
    {
      'title': 'Not attempt to purchase prohibited items (e.g., drugs, weapons, counterfeit goods)'
    },
  ];

  // Method to toggle checkbox state
  void toggleAgreement() {
    isAgreed.value = !isAgreed.value;
  }

  void navigationSelection() {
    if (AppController.to.role.value == 'seller') {
      Get.toNamed(Routes.PRODUCT_SELECTION);
    } else {
      Get.offAllNamed(Routes.GENDER_SELECTION);
    }
  }
}