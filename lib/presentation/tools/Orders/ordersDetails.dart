import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';

class OrdersBetails extends StatelessWidget {
  const OrdersBetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders Details', centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buyer Information',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: BoxBorder.all(color: AppColors.neutral500, width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Name',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          'Buyer Information',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Phone Name',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          '+8801938448223',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Payment Method',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          'Google Pay',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Text(
              'Product Details',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: BoxBorder.all(color: AppColors.neutral500, width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Orderdetailscard(
                      isShedule: false,
                      doNotShowButtons: true,
                      onTab: () {

                      },
                    )
                  ],
                ),
              ),
            ), SizedBox(height: 24.h),

            Text(
              'Shipping Details',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: BoxBorder.all(color: AppColors.neutral500, width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Receiver',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          'Fahmidul Islam',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Receiver Phone Name',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          '+8801938448223',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Details Address',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ), Text(
                          'Bijoy soroni, new polton,Dhaka',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
