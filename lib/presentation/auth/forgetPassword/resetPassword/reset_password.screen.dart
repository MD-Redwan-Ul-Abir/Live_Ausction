import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import 'controllers/reset_password.controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Reset Password',
          centerTitle: true,
      
          leadingIcon:
          AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 38.h),
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
      
      
              SizedBox(height:24.h),
              PrimaryButton(width: double.infinity,onPressed: (){
                controller.navigateToRegistrationSuccess();
              }, text: "Reset Password"),
      
            ],
          ),
        ),
      ),
    );
  }
}
