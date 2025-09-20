import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/appbar/custom_appbar.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/custom_text_form_field.dart';
import 'controllers/log_in.controller.dart';

class LogInScreen extends GetView<LogInController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Log in',
          centerTitle: true,
          leadingIcon: AppImages
              .interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 38.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email*',
                  style: AppTextStyles.paragraph_2_Regular,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: "example@gmail.com",
                prefixSvg: AppImages
                    .mailSendEnvelopeEnvelopeEmailMessageUnopenedSealedCloseStreamlineCore,
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password*',
                  style: AppTextStyles.paragraph_2_Regular,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                keyboardType: 'visiblePassword',
                hintText: "Password",
                prefixSvg: AppImages
                    .interfaceLockCombinationComboLockLockedPadlockSecureSecurityShieldKeyholeStreamlineCore,
              ),
              SizedBox(height:12.h),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.VERIFY_EMAIL);
                  },
                  child: Text(
                    'Forget password?',
                    style: AppTextStyles.buttonRegular.copyWith(color: AppColors.primary600),
                  ),
                ),
              ),
              SizedBox(height:24.h),
              PrimaryButton(width: double.infinity,onPressed: (){
                Get.offAllNamed(Routes.MAIN_APP);
              }, text: "Log in"),
      
              SizedBox(height: 23.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.primary600,
                      ),recognizer: TapGestureRecognizer() ..onTap = () {
      
                      Get.toNamed(Routes.SIGN_UP_WITH_EMAIL);
      
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
