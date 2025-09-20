import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../../../shared/widgets/buttons/primary_buttons.dart';
import '../../components/selectionCard.dart';

import 'controllers/settings.controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Settings", centerTitle: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
if(controller.userRole !="buyer")
                Padding(
                  padding:   EdgeInsets.only(top: 16.h),
                  child: Selectioncard(
                    title: 'Store Information',
                    trailingIcon: true,
                    svgPath: AppImages
                        .storeIcon,
                    onTap: () {
                      Get.toNamed(Routes.STORE_INFORMATION);
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Change Password',
                  trailingIcon: true,
                  svgPath: AppImages
                      .interfaceLockCombinationComboLockLockedPadlockSecureSecurityShieldKeyholeStreamlineCore,
                  onTap: () {
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Privacy Policy',
                  trailingIcon: true,
                  svgPath: AppImages
                      .interfaceSecurityShield2ShieldProtectionSecurityDefendCrimeWarCoverStreamlineCore,
                  onTap: () {
                    controller.privacyPolicy();
                  },
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Terms & Conditions',
                  trailingIcon: true,
                  svgPath: AppImages
                      .interfaceAlertWarningTriangleFrameAlertWarningTriangleExclamationCautionStreamlineCore,
                  onTap: () {
                    controller.termsAndCondition();
                  },
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'About Us',
                  trailingIcon: true,
                  svgPath: AppImages
                      .interfaceAlertInformationCircleInformationFrameInfoMoreHelpPointCircleStreamlineCore,
                  onTap: () {
                    controller.aboutUs();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
