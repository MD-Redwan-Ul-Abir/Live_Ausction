import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../commonWidgets/prductViewCard.dart';
import '../../commonWidgets/gridDetailsCard.dart';
import '../../commonWidgets/customSelectionButton.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'component/ownerProfileStatus.dart';
import 'component/reviewCard.dart'; // Import the ReviewCard
import 'controllers/seller_profile.controller.dart';

class SellerProfileScreen extends GetView<SellerProfileController> {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Seller Profile", centerTitle: true),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: productDetilsCard(
                  imageUrl: AppImages.product1,
                  isShearActive: true,
                  isFollowCountActive: true,
                  followCount: 5500,
                  shopName: 'Jirah Shop',
                  onSellerProfileImageTab: () {
                    // Get.toNamed(Routes.SELLER_PROFILE);
                  },
                  productOwnerPicture: AppImages.productOwner,
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: OwnerProfileStatus(),
              ),
              SizedBox(height: 17.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Description',
                  style: AppTextStyles.H6_Regular.copyWith(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Welcome to my creative corner! I specialize in handcrafted handcrafted, eco-friendly products made with love and care. Every piece is unique and made to bring joy to your space or gifting experience."',
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                    height: 1.5.h,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: PrimaryButton(
                  onPressed: () {},
                  text: 'Follow',
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                  borderColor: AppColors.neutral800,
                  textColor: AppColors.neutral50,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: PrimaryButton(
                  onPressed: () {},
                  text: 'Chat/Message',
                  svgAsset: AppImages.mailChatBubbleTypingOvalMessagesMessageBubbleTypingChatStreamlineCore,
                  width: double.infinity,
                  backgroundColor: Colors.transparent,
                  borderColor: AppColors.neutral800,
                  textColor: AppColors.neutral50,
                ),
              ),
              SizedBox(height: 27.h),
              Container(
                height: 1.h,
                width: double.infinity,
                color: AppColors.neutral800,
              ),
              SizedBox(height: 25.h),

              // Tab Selection Buttons
              SizedBox(
                height: 32.h,
                child: ListView.builder(
                  itemCount: controller.tabData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Obx(() {
                        return Padding(
                          padding: index == 0
                              ? EdgeInsets.only(left: 24.w)
                              : EdgeInsets.all(0),
                          child: SelectableButton(
                            text: controller.tabData[index]['buttonName'],
                            isSelected: controller.selectedTabIndex.value == index,
                            onTap: () => controller.onTabSelected(index),
                            activeBgColor: AppColors.primary1000,
                            inactiveBgColor: Colors.transparent,
                            activeBorderColor: true,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Content based on selected tab
              Obx(() {
                if (controller.selectedTabIndex.value == 2) {
                  // Reviews tab - show review cards
                  return _buildReviewsSection();
                } else {
                  // Products, Shows, Past Shows tabs - grid view
                  return _buildGridSection();
                }
              }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridSection() {
    return Obx(() {
      if (controller.filteredItems.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Center(
            child: Text(
              'No items found',
              style: AppTextStyles.paragraph_1_Regular.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 0.64,
          ),
          itemCount: controller.filteredItems.length,
          itemBuilder: (context, index) {
            final item = controller.filteredItems[index];
            return GestureDetector(
              onTap: () {
                // Navigate based on item type
                if (item['type'] == 'product') {
                  Get.toNamed(Routes.PRODUCT_DETAILS);
                } else if (item['type'] == 'show') {
                  Get.toNamed(Routes.LIVE_STREAMMING);
                } else if (item['type'] == 'pastShow') {
                  Get.toNamed(Routes.PRODUCT_DETAILS); // or specific past show route
                }
              },
              child: gridCard(
                imageUrl: item['imageUrl'] ?? '',
                title: item['title'] ?? '',
                isLive: item['isLive'] ?? false,
                liveViewerCount: item['viewerCount'] ?? 0,
                shopName: item['shopName'] ?? '',
                productOwnerPicture: item['ownerPic'],
                pastOrPresentDate: item['pastOrPresentDate'] ?? '',
                isPatOrPresentActive: item['isPatOrPresentActive'] ?? false,
                // For past shows, you might want to show the date instead of live count
                //customOverlayText: item['type'] == 'pastShow' ? item['showText'] : null,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildReviewsSection() {
    return Obx(() {
      if (controller.reviewsData.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Center(
            child: Text(
              'No reviews yet',
              style: AppTextStyles.paragraph_1_Regular.copyWith(
                color: AppColors.neutral400,
              ),
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall rating summary (optional)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.neutral800,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.star,
                  //   size: 20.w,
                  //   color: AppColors.primary1000,
                  // ),
                  SvgPicture.asset(AppImages.ratingsIcon2),
                  SizedBox(width: 8.w),
                  Text(
                    '4.7',
                    style: AppTextStyles.paragraph_1_Bold.copyWith(
                      color: AppColors.neutral50,

                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '(${controller.reviewsData.length} reviews)',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral300,
                    ),
                  ),
                ],
              ),
            ),

            // Review cards list
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.reviewsData.length,
              itemBuilder: (context, index) {
                final review = controller.reviewsData[index];
                return ReviewCard(
                  userName: review['userName'],
                  userImage: review['userImage'],
                  rating: review['rating'],
                  date: review['date'],
                  reviewText: review['reviewText'],
                  expandedText: review['expandedText'],
                );
              },
            ),
          ],
        ),
      );
    });
  }
}