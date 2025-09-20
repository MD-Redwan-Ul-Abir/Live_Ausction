import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/tools.controller.dart';

class ToolsScreen extends GetView<ToolsController> {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tools", centerTitle: true, showBackButton: false,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Function',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return _functionButton(
                    hasDoubleText: true,
                    isSelected: controller.isAddProductSelected.value,
                    svgPath: AppImages
                        .interfaceAdd1ExpandCrossButtonsButtonMoreRemovePlusAddStreamlineCore,
                    buttonText: 'Add\nProduct',
                    onTap: () async {
                      controller.isAddProductSelected.value = true;
                      await Future.delayed(Duration(milliseconds: 100));
                      Get.toNamed(Routes.ADD_PRODUCT);
                      controller.isAddProductSelected.value = false;
                    },
                  );
                }),
                SizedBox(width: 16.w),
                Obx(() {
                  return _functionButton(
                    hasDoubleText: false,
                    isSelected: controller.isProductSelected.value,
                    svgPath: AppImages
                        .productGiving,
                    buttonText: 'Product',
                    onTap: () async {
                      controller.isProductSelected.value = true;
                      await Future.delayed(Duration(milliseconds: 100));
                      Get.toNamed(Routes.SELLER_PRODUCTS);
                      controller.isProductSelected.value = false;
                    },
                  );
                }),
                SizedBox(width: 16.w),
                Obx(() {
                  return _functionButton(
                    hasDoubleText: false,
                    isSelected: controller.isOrderSelected.value,
                    svgPath: AppImages
                        .orderList,
                    buttonText: 'Order',
                    onTap: () async {
                      controller.isOrderSelected.value = true;
                      await Future.delayed(Duration(milliseconds: 100));
                      Get.toNamed(Routes.ORDERS);
                      controller.isOrderSelected.value = false;
                    },
                  );
                }),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return _functionButton(
                    hasDoubleText: true,
                    isSelected: controller.isManagerReviewSelected.value,
                    svgPath: AppImages
                        .managerReview,
                    buttonText: 'Manager\nreview',
                    onTap: () async {
                      controller.isManagerReviewSelected.value = true;
                      await Future.delayed(Duration(milliseconds: 100));

                      Get.toNamed(Routes.PRODUCT_REVIEWS);
                      controller.isManagerReviewSelected.value = false;
                    },
                  );
                }),
                SizedBox(width: 16.w),
                Obx(() {
                  return _functionButton(
                      hasDoubleText: false,
                    isSelected:    controller.isIncomeSelected.value,
                    svgPath: AppImages
                        .dollarBag,
                    buttonText: 'My income',
                    onTap: () async {
                      controller.isIncomeSelected.value = true;
                      await Future.delayed(Duration(milliseconds: 100));
                      Get.toNamed(Routes.MY_INCOME);
                      controller.isIncomeSelected.value = false;


                    },
                  );
                }),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _functionButton({
    required bool isSelected,
    required bool hasDoubleText,
    required String svgPath,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1.w, color: isSelected
              ? AppColors.primary1000
              : AppColors.neutral500,),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical:hasDoubleText ==true?0: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgPath,
                  color: isSelected
                      ? AppColors.primary1000
                      : AppColors.neutral500,
                ),
                Text(
                  buttonText,
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: isSelected
                        ? AppColors.primary1000
                        : AppColors.neutral500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
