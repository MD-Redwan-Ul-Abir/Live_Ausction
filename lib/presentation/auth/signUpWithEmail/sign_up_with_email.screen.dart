import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import 'controllers/sign_up_with_email.controller.dart';

class SignUpWithEmailScreen extends GetView<SignUpWithEmailController> {
  const SignUpWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 176.h),
              Text(
                'MouvBid',
                style: AppTextStyles.H1_Bold.copyWith(
                  color: AppColors.primary1000,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "The Live Shopping Marketplace. Buy,sell and\nconnect around the things you love.",
                style: AppTextStyles.paragraph_2_Regular.copyWith(
                  color: AppColors.neutral300,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.h),
              PrimaryButton(
                backgroundColor: AppColors.neutral800,
                svgAsset: AppImages
                    .mailSendEnvelopeEnvelopeEmailMessageUnopenedSealedCloseStreamlineCore,
                width: double.infinity,
                onPressed: () {
                  Get.toNamed(Routes.SIGN_UP);
      
                },
                text: "Sign Up With Email",
                textColor: AppColors.neutral50,
              ),
              SizedBox(height: 12.h),
              Text(
                'OR',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral300,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 32.h,
                    width: 32.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutral800,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(AppImages.facebookIcon),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    height: 32.h,
                    width: 32.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutral800,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(AppImages.googleIcon),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                    TextSpan(
                      text: 'Log in',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.primary600,
                      ),recognizer: TapGestureRecognizer() ..onTap = () {
      
                      Get.toNamed(Routes.LOG_IN);
      
                    },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
