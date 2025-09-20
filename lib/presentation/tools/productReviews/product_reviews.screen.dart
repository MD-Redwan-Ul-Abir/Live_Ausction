import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/product_reviews.controller.dart';

class ProductReviewsScreen extends GetView<ProductReviewsController> {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(

        appBar: CustomAppBar(
          title: 'Reviews',
          centerTitle: true,

        ),
        body: Obx(() => ListView.separated(
          padding:   EdgeInsets.symmetric(horizontal: 24.w,vertical: 20.h),
          itemCount: controller.reviews.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final review = controller.reviews[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey[800],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          review.productImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.watch,
                                color: Colors.white54,
                                size: 24,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                      SizedBox(width: 12.w),

                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.productName,
                            style: AppTextStyles.paragraph_2_Regular.copyWith(color: AppColors.neutral50),
                          ),
                            SizedBox(height: 4.h),

                          // Star Rating
                          Row(
                            children: List.generate(5, (starIndex) {

                              return Padding(
                                padding:   EdgeInsets.only(right: 4.w),
                                child: SvgPicture.asset(starIndex < review.rating? AppImages.ratingsIcon2:AppImages.ratingsIcon,height: 12.h,width: 12.w,),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                  SizedBox(height: 8.h),

                // Date
                Text(
                  review.date,
                  style:  AppTextStyles.captionRegular.copyWith(color: AppColors.neutral100),
                ),
                  SizedBox(height: 12.h),

                // Reply Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height:40 .h,
                        decoration: BoxDecoration(
                          color: AppColors.neutral800,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: TextField(

                          maxLines: 5,
                          controller: controller.replyControllers[index],
                          style:   AppTextStyles.paragraph_2_Regular.copyWith(color: AppColors.neutral50),
                          decoration:   InputDecoration(

                            hintText: 'Reply',
                            hintStyle: AppTextStyles.buttonRegular.copyWith(color: AppColors.neutral200),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 7.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: 12.w),

                    // Send Button
                    GestureDetector(
                      onTap: () => controller.sendReply(index),
                      child: Container(
                        height:40 .h,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color:   Color(0xFFFFB800),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child:   Center(
                          child: Text(
                            'Send',
                            style:  AppTextStyles. paragraph_1_Regular.copyWith(color: AppColors.neutral950),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )),



      ),
    );
  }
}


//        appBar: CustomAppBar(title: 'Reviews', centerTitle: true),