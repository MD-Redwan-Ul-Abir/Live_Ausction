import 'package:get/get.dart';

import '../../../../presentation/tools/productReviews/controllers/product_reviews.controller.dart';

class ProductReviewsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductReviewsController>(
      () => ProductReviewsController(),
    );
  }
}
