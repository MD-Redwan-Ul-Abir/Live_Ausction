import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../../infrastructure/utils/secure_storage_helper.dart';
import '../../commonWidgets/prductViewCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/product_details.controller.dart';

class ProductDetailsScreen extends GetView<ProductDetailsController> {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Product details",
          centerTitle: true,
          leadingIcon:
              AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
              productDetilsCard(
                imageUrl: AppImages.product1,
                isShearActive: false,
                followCount: 5500,
                shopName: 'Jirah Shop',
                onSellerProfileImageTab: (){
                  Get.toNamed(Routes.SELLER_PROFILE);
                },
                productOwnerPicture: AppImages.productOwner,
                // progressStatusText: 'Delivered',
                isFollowCountActive: false,
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.SELLER_PROFILE);
                  },

                  child: Text('View Shop',style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.primary100
                  ),),
                ),
              ),
                SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Best Electronics 2025,Start with ',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Text(
                      '\$6',
                      style: AppTextStyles.paragraph_1_Bold.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Free Delivery",
                  style: AppTextStyles.paragraph_2_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Qty : 40",
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Size : Medium | Large | Small",
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.neutral500, width: 1.w),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, color: AppColors.red500, size: 8.r),
                          SizedBox(width: 4.w),
                          Text(
                            'Live Bid Schedule',
                            style: AppTextStyles.buttonRegular,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppImages
                                .interfaceCalendarDateWeekSevenSevenCalendarDateWeekDayMonthStreamlineCore,
                            height: 12.h,
                            width: 12.w,
                            color: AppColors.neutral50,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Date :  27 May',
                            style: AppTextStyles.paragraph_2_Regular,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppImages
                                .interfaceTimeAlarmNotificationAlertBellWakeClockAlarmStreamlineCore,
                            height: 12.h,
                            width: 12.w,
                            color: AppColors.neutral50,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Time : 7:00 PM',
                            style: AppTextStyles.paragraph_2_Regular,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppImages
                                .interfaceTimeStopWatchTimerCountdownClockStreamlineCore,
                            height: 12.h,
                            width: 12.w,
                            color: AppColors.neutral50,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Duration : 15 Min',
                            style: AppTextStyles.paragraph_2_Regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 24.h),

              PrimaryButton(
                onPressed: () async {
                 // await SecureStorageHelper.remove("userRole");
                },
                text: "Pre - Bid",
                backgroundColor: AppColors.neutral100,
                width: double.infinity,
              ),
              SizedBox(height: 24.h),

              PrimaryButton(
                onPressed: () async {
                  Get.toNamed(Routes.DIRECT_BUY_PRODUCT);
                },
                text: "Buy Now",

                width: double.infinity,
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
