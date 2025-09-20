import 'dart:ui';

import 'package:get/get.dart';

class SuccessScreenController extends GetxController {
  RxString title = "".obs;
  RxString secondButtonText = "o".obs;
  RxString subTitle = "".obs;
  RxString buttonText = "Next".obs;
  VoidCallback? onPressed;
  VoidCallback? onSecondButtonPress;
  bool secondButtonActive = false;

  void initializeSuccessScreen({
    required String title,
    String? secondButtonText = '',
    required String subTitle,
    required VoidCallback onPressed,
    bool? secondButtonActive=false,
    VoidCallback? onSecondButtonPress,
    String buttonText = "Next",
  }) {
    this.title.value = title;
    this.secondButtonText.value = secondButtonText!;
    this.subTitle.value = subTitle;
    this.onPressed = onPressed;
    this.onSecondButtonPress = onSecondButtonPress;
    this.buttonText.value = buttonText;
    this.secondButtonActive = secondButtonActive!;
  }

  void handleButtonPress() {
    if (onPressed != null) {
      onPressed!();
    }
  }

  void handleSecondButtonPress() {
    if (onSecondButtonPress != null) {
      onSecondButtonPress!();
    }
  }
}
