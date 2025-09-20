import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/add_payment_methode.controller.dart';

class AddPaymentMethodeScreen extends GetView<AddPaymentMethodeController> {
  const AddPaymentMethodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add payment", centerTitle: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Obx(() {
              return GestureDetector(
                onTap: (){
                  controller.stripeActivation();
                },
                child: _PaymentMethodSelection(
                  isActive: controller.stripeActive.value,
                  svgIcon: AppImages.stripe,
                  title: 'Stripe',
                ),
              );
            }),
            SizedBox(
              height: 16.h,
            ),
            Obx(() {
              return GestureDetector(
                onTap: (){
                  controller.googlePayActivation();
                },
                child: _PaymentMethodSelection(
                  isActive: controller.googlePayActive.value,
                  svgIcon: AppImages.googlePay,
                  title: 'Google Pay',
                ),
              );
            }),
            Spacer(),
            PrimaryButton(onPressed: (){
controller.myWalletController.isWalletEmpty.value=false;
              Get.back();
            }, text: 'Add',width: double.infinity,),
            SizedBox(
              height: 16.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _PaymentMethodSelection({
    required bool isActive,
    required String svgIcon,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: Colors.transparent,
        border: Border.all(
          width: 1.w,
          color: isActive == false
              ? AppColors.neutral800
              : AppColors.primary1000,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(svgIcon, height: 24.h, width: 24.w),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
