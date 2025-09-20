import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/appbar/custom_appbar.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/custom_text_form_field.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/utils/app_images.dart';
import 'controllers/sign_up.controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Sign Up",
          centerTitle: true,
          leadingIcon: AppImages
              .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 38.h),
      
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Full Name*',
                    style: AppTextStyles.paragraph_2_Regular,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  hintText: "Name",
                  prefixSvg: AppImages
                      .interfaceShareUserHumanPersonShareSignalTransmitUserStreamlineCore,
                ),
                SizedBox(height: 16.h),
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
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Address',
                    style: AppTextStyles.paragraph_2_Regular,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  hintText: "Washington, Livia,1212",
                  prefixSvg: AppImages
                      .mailSendEnvelopeEnvelopeEmailMessageUnopenedSealedCloseStreamlineCore,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Phone Number',
                    style: AppTextStyles.paragraph_2_Regular,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutral800,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    // Clip the ripple effect
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {},
                      onInputValidated: (bool value) {},
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                        leadingPadding: 16.w,
                        trailingSpace: false,
                        setSelectorButtonAsPrefixIcon: true,
                        showFlags: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: AppTextStyles.paragraph_2_Regular
                          .copyWith(color: AppColors.defaultTextColor),
                      textStyle: TextStyle(
                        color: AppColors.defaultTextColor,
                        fontSize: 16.sp,
                      ),
                      hintText: "Phone number",
                      initialValue: controller.number,
                      textFieldController: controller.controller,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      inputDecoration: InputDecoration(
                        hintText: "Phone number",
                        hintStyle: AppTextStyles.paragraph_2_Regular,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 15.h,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      spaceBetweenSelectorAndTextField: 0,
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By creating an account, I accept the ',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms \n& Conditions & Privacy Policy.',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.primary600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  width: double.infinity,
                  onPressed: () {
                    controller.navigateToRegistrationSuccess();
                  },
                  text: "Sign UP",
                ),
                SizedBox(height: 12.h),
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
      ),
    );
  }
}
