import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/my_wallet.controller.dart';

class MyWalletScreen extends GetView<MyWalletController> {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "wallet", centerTitle: false),

        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: controller.isWalletEmpty.value == true
                ? _noWallet()
                : _wallet(),
          );
        }),
      ),
    );
  }

  Widget _noWallet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          'No wallet Yet !',
          style: AppTextStyles.H3_Regular.copyWith(color: AppColors.neutral50),
        ),
        SizedBox(height: 24.h),
        Text(
          'payment Method :',
          style: AppTextStyles.paragraph_2_Regular.copyWith(
            color: AppColors.neutral50,
          ),
        ),
        SizedBox(height: 12.h),
        _addPaymentMethode(onTab: () { Get.toNamed(Routes.ADD_PAYMENT_METHODE); })

      ],
    );
  }

  Widget _wallet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1.w, color: AppColors.neutral500),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My wallet',
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$23,344',
                      style: AppTextStyles.H5_Medium.copyWith(
                        color: AppColors.primary700,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  AppImages.accountBalanceDesign,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        PrimaryButton(
          onPressed: () {},
          text: 'Withdraw request',
          width: double.infinity,
        ),
        SizedBox(height: 24.h),
        Text(
          'payment Method :',
          style: AppTextStyles.paragraph_2_Regular.copyWith(
            color: AppColors.neutral50,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImages.stripe, height: 24.h, width: 24.w),
            SizedBox(width: 8.w),
            Text(
              'Stripe',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral200,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImages.googlePay, height: 24.h, width: 24.w),
            SizedBox(width: 8.w),
            Text(
              'Google Pay',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral200,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'payment Method :',
          style: AppTextStyles.paragraph_2_Regular.copyWith(
            color: AppColors.neutral50,
          ),
        ),
        SizedBox(height: 12.h),

        _addPaymentMethode(onTab: () { Get.toNamed(Routes.ADD_PAYMENT_METHODE); })
      ],
    );
  }
  Widget _addPaymentMethode({required VoidCallback onTab}){
    return GestureDetector(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral800,
          borderRadius: BorderRadius.circular(100.r)
        ),
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 14.w,vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
      SvgPicture.asset(AppImages.Plus),
              SizedBox(
                width: 8.w,
              ),
              Text('Add payment Method',style: AppTextStyles.buttonRegular.copyWith(color: AppColors.neutral50),)
            ],
          ),
        ),
      ),
    );
  }
}
