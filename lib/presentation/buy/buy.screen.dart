import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/utils/app_images.dart';
import 'controllers/buy.controller.dart';

class BuyScreen extends GetView<BuyController> {
  const BuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset(
                AppImages.sellerDefaultIcon,
                height: 120.h,
                width: 120.w,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text('Do You Want to be Seller?',style: AppTextStyles.H6_Medium.copyWith(
                color: AppColors.primary700
              ),),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(width: 148.w,backgroundColor: AppColors.neutral800,onPressed: (){
                    Get.back();
                  }, text: "No",textColor: AppColors.neutral50,),
                  PrimaryButton(width: 148.w,onPressed: (){
                    Get.offAllNamed(Routes.ROLE_SELECTION);
                  }, text: "yes"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
