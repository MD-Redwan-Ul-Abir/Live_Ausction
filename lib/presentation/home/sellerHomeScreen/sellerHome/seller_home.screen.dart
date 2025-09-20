import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../myOrder/widget/orderDetailsCard.dart';
import 'controllers/seller_home.controller.dart';

class SellerHomeScreen extends GetView<SellerHomeController> {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral950,
      appBar: AppBar(
        backgroundColor: AppColors.neutral950,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: GestureDetector(
            onTap: (){
              Get.toNamed(Routes.PERSONAL);
            },
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage(AppImages.productOwner),
            ),
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jack Mama',
              style: AppTextStyles.paragraph_1_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Follower 2655',
              style: AppTextStyles.buttonRegular.copyWith(
                color: AppColors.neutral200,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.NOTIFICATIONS);
                  },
                  child: SvgPicture.asset(AppImages.notificatioContainer),
                ),
              ],
            ),
          ),
        ],
        foregroundColor: AppColors.neutral50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Overview',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  Text(
                    '17/7/25',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Stats Section
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Order',
                      '45',
                      AppColors.primary400,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildStatCard('Shipping', '12', AppColors.red500),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildStatCard(
                      'Reviews',
                      '120',
                      AppColors.secondary600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              Text(
                'Your Upcoming Live show',
                style: AppTextStyles.paragraph_1_Regular.copyWith(
                  color: AppColors.neutral50,
                ),
              ),
              SizedBox(height: 16.h),

              // Live Show Items
              ...List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Orderdetailscard(isShedule: true),
                ),
              ),

              SizedBox(height: 32.h),

              // Schedule Button
              PrimaryButton(
                width: double.infinity,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.primary1000,
                textColor: AppColors.primary1000,
                onPressed: () {
                  Get.toNamed(Routes.SCHEDULE_SHOW);
                },
                text: 'Schedule a Show',
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.neutral800, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral300,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppTextStyles.H6_Regular.copyWith(color: valueColor),
          ),
        ],
      ),
    );
  }

  // Widget _buildLiveShowItem() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular()
  //         ),
  //       )
  //     ],
  //   );
  // }
}
