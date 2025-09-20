import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../components/selectionCard.dart';
import 'controllers/personal.controller.dart';

class PersonalScreen extends GetView<PersonalController> {
  const PersonalScreen({super.key});

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
                Selectioncard(
                  title: 'Jane Cooper',
                  trailingIcon: false,
                  svgPath: AppImages
                      .interfaceSecurityShieldProfileShieldSecureSecurityProfilePersonStreamlineCore,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Jane245@gmail.com',
                  trailingIcon: false,
                  svgPath: AppImages
                      .mailSendEnvelopeEnvelopeEmailMessageUnopenedSealedCloseStreamlineCore,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: '(480) 555-3434',
                  trailingIcon: false,
                  svgPath: AppImages
                      .phoneTelephoneAndroidPhoneMobileDeviceSmartphoneIphoneStreamlineCore,
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: '2955 washterimer RD. santa area, sans Fransicco',
                  trailingIcon: false,
                  svgPath: AppImages
                      .travelMapLocationPinNavigationMapMapsPinGpsLocationStreamlineCore,
                  onTap: () {},
                ),
                SizedBox(height: 32.h),
                PrimaryButton(width: double.infinity,onPressed: (){

                  Get.toNamed(Routes.UPDATE_PROFILE);
                }, text: "Edit Profile")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
