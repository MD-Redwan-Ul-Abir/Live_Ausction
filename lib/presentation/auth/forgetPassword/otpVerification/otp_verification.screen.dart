import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/otp_verification.controller.dart';

class OtpVerificationScreen extends GetView<OtpVerificationController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Verify OTP',
          centerTitle: true,
      
          leadingIcon:
              AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 38.h),
              PinCodeTextField(
      
                appContext: context,
                length: 6,
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeBorderWidth: 1.r,
                  borderRadius: BorderRadius.circular(8.r),
                  fieldHeight: 57.h,
                  fieldWidth: 44.w,
                  activeFillColor: AppColors.neutral800,
                  inactiveFillColor: AppColors.neutral800,
                  selectedFillColor: AppColors.neutral800,
                  activeColor: AppColors.primary1000,
                  inactiveColor: Colors.transparent,
                  selectedColor: AppColors.primary1000,
                ),
                cursorColor:AppColors.primary1000,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: controller.errorController,
                controller: controller.otpTextEditingController,
                keyboardType: TextInputType.number,
                textStyle: AppTextStyles.paragraph_1_Regular.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.neutral50,
                ),
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
                onChanged: (value) {
                  controller.isPinComplete.value = value.length == 6;
                },
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Didn’t Receive the code?',style: AppTextStyles.buttonRegular,)
                  ,Text('Resend',style: AppTextStyles.buttonRegular,)
                ],
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                width: double.infinity,
                onPressed: () {
                  Get.toNamed(Routes.RESET_PASSWORD);
                },
                text: "Verify Now",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
