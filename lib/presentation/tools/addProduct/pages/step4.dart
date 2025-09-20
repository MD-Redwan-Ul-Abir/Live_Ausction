import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../myOrder/widget/orderDetailsCard.dart';
import '../controllers/add_product.controller.dart';

class Finished extends GetView<AddProductController> {
  const Finished({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height -
          200.h, // Account for appbar and button
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80.h),
                    child: Text(
                      'Success!Your Product has been added\nto your show.',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: AppColors.primary700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Products (1)',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _productDetails(),
                  // Add some bottom padding to ensure content doesn't get hidden behind the schedule section
                  SizedBox(height: 200.h),
                ],
              ),
            ),
            // Position schedule section at bottom right
            Positioned(bottom: 0.h, right: 0, child: _sheduleScetion()),
          ],
        ),
      ),
    );
  }

  Widget _sheduleScetion() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SCHEDULE_SHOW);
          },
          child: Container(
            width: 160.w,
            decoration: BoxDecoration(
              color: AppColors.neutral800,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppImages.Plus),
                  SizedBox(width: 8.w),
                  Text(
                    'Create Schedule',
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SET_CAMERE);
          },
          child: Container(
            width: 160.w,
            decoration: BoxDecoration(
              color: AppColors.neutral800,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppImages.goLive),
                  SizedBox(width: 8.w),
                  Text(
                    'Go Live',
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(height: 12.h),
        // GestureDetector(
        //   onTap: () {
        //    // controller.onClose();
        //     // Get.offAllNamed(Routes.MAIN_APP);
        //      // Get.offAndToNamed(Routes.ADD_PRODUCT);
        //       Get.offAllNamed(Routes.ADD_PRODUCT);
        //   },
        //   child: Container(
        //     width: 160.w,
        //     decoration: BoxDecoration(
        //       color: AppColors.neutral800,
        //       borderRadius: BorderRadius.circular(100.r),
        //     ),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           SvgPicture.asset(AppImages.Plus),
        //           SizedBox(width: 8.w),
        //           Text(
        //             'Add New Product',
        //             style: AppTextStyles.buttonRegular.copyWith(
        //               color: AppColors.neutral50,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _productDetails() {
    return SizedBox(
      height: 120.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120.w,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.r),
              child: Image.asset(AppImages.watchPic, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vintage Rolex Watch',
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.paragraph_1_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "size",
                  style: AppTextStyles.paragraph_2_Regular.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                Spacer(),
                Text(
                  "\$5,000",
                  style: AppTextStyles.paragraph_1_Medium.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral800,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 7.h,
                        ),
                        child: Text(
                          'Edit Listing',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral800,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages
                                .interfaceDeleteBin1RemoveDeleteEmptyBinTrashGarbageStreamlineCore,
                            color: AppColors.neutral50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
