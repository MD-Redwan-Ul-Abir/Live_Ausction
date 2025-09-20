import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import 'controllers/change_password.controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password", centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              CustomTextFormField(
                keyboardType: 'visiblePassword',
                hintText: "Old Password",
                prefixSvg: AppImages
                    .interfaceLockCombinationComboLockLockedPadlockSecureSecurityShieldKeyholeStreamlineCore,
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                keyboardType: 'visiblePassword',
                hintText: "Set New Password",
                prefixSvg: AppImages
                    .interfaceLockCombinationComboLockLockedPadlockSecureSecurityShieldKeyholeStreamlineCore,
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                keyboardType: 'visiblePassword',
                hintText: "Re-type New Password",
                prefixSvg: AppImages
                    .interfaceLockCombinationComboLockLockedPadlockSecureSecurityShieldKeyholeStreamlineCore,
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Forgot password?",
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.primary400,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryButton(
                width: double.infinity,
                onPressed: () {
                  controller.navigateToRegistrationSuccess();
                },
                text: "Update Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
