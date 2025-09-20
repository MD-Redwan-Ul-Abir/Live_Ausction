import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/custom_text_form_field.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import '../../shared/widgets/imagePicker/custom_image_picker.dart';
import '../../shared/widgets/imagePicker/imagePickerController.dart';
import '../components/selectionCard.dart';
import 'controllers/update_profile.controller.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Personal Information", centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColors.neutral900,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120.w,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              width: 2.w,
                              color: AppColors.primary50,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(100.r),
                            child: Image.asset(
                              AppImages.bidingPerson,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        Text(
                          "Jane Cooper",
                          style: AppTextStyles.H5_Regular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                CustomTextFormField(
                  hintText: "Update Name",
                  prefixSvg: AppImages
                      .interfaceSecurityShieldProfileShieldSecureSecurityProfilePersonStreamlineCore,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  hintText: "Update Email",
                  keyboardType: 'email',
                  prefixSvg: AppImages
                      .mailSendEnvelopeEnvelopeEmailMessageUnopenedSealedCloseStreamlineCore,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  hintText: "Update Phone Number",
                  prefixSvg: AppImages
                      .phoneTelephoneAndroidPhoneMobileDeviceSmartphoneIphoneStreamlineCore,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  hintText: "Address",
                 // keyboardType: 'multiline',
                  prefixSvg: AppImages
                      .travelMapLocationPinNavigationMapMapsPinGpsLocationStreamlineCore,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  width: double.infinity,
                  onPressed: () {

                  },
                  text: "Update Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
