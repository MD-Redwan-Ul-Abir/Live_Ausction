import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/appbar/custom_appbar.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/api_content.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../../infrastructure/utils/secure_storage_helper.dart';
import '../../shared/widgets/imagePicker/custom_image_picker.dart';
import '../../shared/widgets/imagePicker/imagePickerController.dart';
import '../components/selectionCard.dart';

import 'controllers/account.controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final   imagePickerController imageController = Get.put(imagePickerController());

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Profile",
          centerTitle: true,
          donotShowLeadingIcon: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _profileImageUpload(imageController,context),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Personal Information',
                  svgPath: AppImages
                      .interfaceSecurityShieldProfileShieldSecureSecurityProfilePersonStreamlineCore,
                  onTap: () {
                    Get.toNamed(Routes.PERSONAL);
                  },
                ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Wallet',
                  svgPath: AppImages.wallet_svgrepo_com_1,
                  onTap: () {
                    Get.toNamed(Routes.MY_WALLET);
                  },
                ),
                // for developing purpose this condition is    if (controller.userRole == "buyer").
                // in final version the condition should be    if (controller.userRole != "buyer")
                if (controller.userRole != "buyer")
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Selectioncard(
                      title: 'Schedule Auction Settings',
                      svgPath: AppImages
                          .interfaceTimeResetTimeClockResetStopwatchCircleMeasureLoadingStreamlineCore,
                      onTap: () {
                        Get.toNamed(Routes.AUSTION_SETTINGS);
                      },
                    ),
                  ),
                // for developing purpose this condition is    if (controller.userRole == "buyer").
                // in final version the condition should be    if (controller.userRole != "buyer")
                if (controller.userRole != "buyer")
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Selectioncard(
                      title: 'Give way Settings',
                      svgPath: AppImages.giftIcon,
                      onTap: () {
                        Get.toNamed(Routes.GIVE_AWAY);
                      },
                    ),
                  ),
                SizedBox(height: 16.h),
                Selectioncard(
                  title: 'Settings',
                  svgPath: AppImages
                      .interfaceSettingPieChartCogSettingGraphCogStreamlineCore,
                  onTap: () {
                    Get.toNamed(Routes.SETTINGS);
                  },
                ),

                SizedBox(height: 64.h),
                _logOut(),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logOut(){
    return  GestureDetector(
      onTap: () async {
       await SecureStorageHelper.remove(ApiConstants.userRole);
       Get.offAllNamed(
         Routes.ROLE_SELECTION
       );

      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1.w, color: AppColors.red500),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages
                    .interfaceLogoutCircleArrowEnterRightLogoutPointCircleStreamlineCore,
                height: 16.h,
                width: 16.w,
                color: AppColors.red500,
              ),
              SizedBox(width: 8.57.w),
              Text(
                "Log Out",
                style: AppTextStyles.paragraph_2_Regular.copyWith(
                  color: AppColors.red500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImageUpload(    imagePickerController imageController,
      BuildContext context,) {
    return Container(
      height: 280.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.neutral900,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Profile",
            style: AppTextStyles.H6_Regular.copyWith(
              color: AppColors.neutral50,
            ),
          ),
          SizedBox(height: 18.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: (){
                    showImagePickerOption(context, imageController);
                  },
                  child: Container(
                    height: 120.w,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(width: 2.w, color: AppColors.primary50),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100.r),
                      child: Image.asset(
                        AppImages.bidingPerson,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showImagePickerOption(context, imageController);
                },
                child: SvgPicture.asset(
                  AppImages
                      .imageCamera1PhotosPictureCameraPhotographyPhotoPicturesStreamlineCore,
                  height: 24.h,
                  width: 24.w,
                  color: AppColors.defaultTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "Jane Cooper",
            style: AppTextStyles.H5_Regular.copyWith(
              color: AppColors.neutral50,
            ),
          ),
        ],
      ),
    );
  }
}

// Selectioncard(
// title: 'Personal',
// svgPath: AppImages
//     .interfaceSecurityShieldProfileShieldSecureSecurityProfilePersonStreamlineCore,
// onTap: () {
// print("==============");
// },
// ),
