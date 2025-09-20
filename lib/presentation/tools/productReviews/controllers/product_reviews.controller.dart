import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/utils/app_images.dart';

class Review {
  final String productName;
  final String productImage;
  final double rating;
  final String date;
  final String userAvatar;

  Review({
    required this.productName,
    required this.productImage,
    required this.rating,
    required this.date,
    required this.userAvatar,
  });
}

class ProductReviewsController extends GetxController {
  RxList<Review> reviews = <Review>[
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 4.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: "assets/images/avatar3.jpg",
    ), Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 4.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: "assets/images/avatar3.jpg",
    ), Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 4.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: "assets/images/avatar3.jpg",
    ), Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 4.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: "assets/images/avatar3.jpg",
    ), Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 4.0,
      date: "Ahmed 12 May",
      userAvatar: AppImages.watchPic,
    ),
    Review(
      productName: "Vintage Rolex watch",
      productImage: AppImages.watchPic,
      rating: 5.0,
      date: "Ahmed 12 May",
      userAvatar: "assets/images/avatar3.jpg",
    ),

  ].obs;

  List<TextEditingController> replyControllers = <TextEditingController>[];

  @override
  void onInit() {
    super.onInit();
    // Initialize reply controllers for each review
    for (int i = 0; i < reviews.length; i++) {
      replyControllers.add(TextEditingController());
    }
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var controller in replyControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void sendReply(int index) {
    final replyText = replyControllers[index].text.trim();
    if (replyText.isNotEmpty) {
      // Handle send reply logic here
      print("Reply sent for review $index: $replyText");
      replyControllers[index].clear();
    }
  }
}