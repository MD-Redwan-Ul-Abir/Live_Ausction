import 'package:get/get.dart';

import '../../../shared/widgets/imagePicker/imagePickerController.dart';

class ReviewProductController extends GetxController {
  final imagePickerController imageController = Get.find<imagePickerController>();


  @override
  Future<void> onInit() async {
    super.onInit();
    rating.value = 0.0;

  }

  final count = 0.obs;
  RxDouble rating = 0.0.obs;

  void updateRating(double newRating) {
    rating.value = newRating;
  }


  void resetRating() {
    rating.value = 0.0;
  }
}
