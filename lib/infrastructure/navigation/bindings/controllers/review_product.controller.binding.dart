import 'package:get/get.dart';

import '../../../../presentation/myOrder/reviewProduct/controllers/review_product.controller.dart';
import '../../../../presentation/shared/widgets/imagePicker/imagePickerController.dart';

class ReviewProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewProductController>(
      () => ReviewProductController(),
    ); Get.lazyPut<imagePickerController>(
      () => imagePickerController(),
    );
  }
}
