import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';

class Orderdetailscard extends StatelessWidget {
  final Map<String, dynamic>? orderData;

  final bool isShedule;
  final VoidCallback? onTab;
  final VoidCallback ? onEditButtonPressed;

  final bool isEdit;
  final bool isEditing;
  final bool doNotShowButtons;

  const Orderdetailscard({
    super.key,
    this.orderData,
    this.isShedule = false,
    this.isEdit = false,
    this.isEditing = false,
    this.doNotShowButtons = false,
    this.onTab, this.onEditButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final productName = orderData?['productName'] ?? 'Vintage Rolex Watch';
    final size = orderData?['size'] ?? 'One Size';
    final price = orderData?['price'] ?? '\$5,000';
    final status = orderData?['status'] ?? 'pending';
    final imageUrl = orderData?['image'] ?? AppImages.watchPic;

    return GestureDetector(
      onTap: onTab,
      child: SizedBox(
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
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.paragraph_1_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    size,
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    price,
                    style: AppTextStyles.paragraph_1_Medium.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  Spacer(),
                  if (isEdit == false &&
                      isShedule == false &&
                      doNotShowButtons == false)
                    Text(
                      _getStatusText(status),
                      style: AppTextStyles.paragraph_2_Medium.copyWith(
                        color: _getStatusColor(status),
                      ),
                    ),
                  if (isShedule == true) _sceduleButton(),

                  if(isEdit==true)
                    _editButton(onEditPressed: onEditButtonPressed),


                  if (doNotShowButtons == true) SizedBox(height: 24.h),

                  SizedBox(height: 2.h),
                ],
              ),
            ),

            if (status.toLowerCase() == 'delivered' &&
                doNotShowButtons == false)
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.RETURN_PRODUCT);
                },
                child: SvgPicture.asset(
                  AppImages
                      .interfaceSettingMenuVerticalNavigationVerticalThreeCircleButtonMenuDotsStreamlineCore,
                  color: AppColors.neutral50,
                ),
              ),
          ],
        ),
      ),
    );
  }
///------------------Edit Button-----------------
  Widget _editButton({VoidCallback? onEditPressed}){
    return  GestureDetector(
      onTap: onEditPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral800,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          child: Text(
            'Edit Product',
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral50,
            ),
          ),
        ),
      ),
    );
  }
  ///---------------shedule

  Widget _sceduleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.neutral800,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImages
                      .interfaceTimeResetTimeClockResetStopwatchCircleMeasureLoadingStreamlineCore,
                  color: AppColors.neutral50,
                ),
                SizedBox(width: 10.w),

                Text(
                  '24 May,9:00 PM',
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
              ],
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
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
    );
  }

  // Method to get status color based on status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.primary600; // Yellow/Orange for pending
      case 'cancel':
        return AppColors.red500; // Red for cancelled
      case 'delivered':
        return AppColors.green500; // Green for delivered
      default:
        return AppColors.primary600; // Default color
    }
  }

  // Method to format status text (capitalize first letter)
  String _getStatusText(String status) {
    return status.substring(0, 1).toUpperCase() + status.substring(1);
  }
}
