import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import 'controllers/verify_email.controller.dart';

class VerifyEmailScreen extends GetView<VerifyEmailController> {
  const VerifyEmailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:CustomAppBar(
          title: 'Forget Password',
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
              SizedBox(height: 24.h),
      
      
      
              PrimaryButton(width: double.infinity,onPressed: (){
      
                Get.toNamed(Routes.OTP_VERIFICATION);
              }, text: "Get OTP"),
      
      
            ],
          ),
        ),
      ),
    );
  }
}
