import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/text_styles.dart';
import '../../infrastructure/utils/app_images.dart';

class productDetilsCard extends StatefulWidget {

  /// progressStatusText and isShearActive can not be not empty and true at the same time

  final String imageUrl;
  final bool? isShearActive;
  final bool? isFollowCountActive;
  final int followCount;

  final String progressStatusText;
  final String shopName;
  final String? productOwnerPicture;
  final VoidCallback? onSellerProfileImageTab;

  const productDetilsCard({
    super.key,
    required this.imageUrl,
    this.isShearActive = false,
    required this.followCount,
    required this.shopName,
    this.productOwnerPicture,
    this.isFollowCountActive = false,

      this.progressStatusText="", this.onSellerProfileImageTab,
  });

  @override
  State<productDetilsCard> createState() => _productDetilsCardState();
}

class _productDetilsCardState extends State<productDetilsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[800],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: widget.imageUrl.isNotEmpty
                ? Image.asset(
                    widget.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                            size: 40.sp,
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[800],
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[600],
                        size: 40.sp,
                      ),
                    ),
                  ),
          ),
          //Share icon
          // if(isShearActive==)
          if (widget.isShearActive == true&&  widget.progressStatusText=="")
            Positioned(
              top: 14.h,
              right: 13.w,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColors.neutral500,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.interfaceShareShareTransmitStreamlineCore,
                    color: AppColors.neutral50,
                  ),
                ),
              ),
            ),
          if (widget.isShearActive == false&& widget.progressStatusText!="")
            Positioned(
              top: 14.h,
              right: 13.w,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.progressStatusText == 'In Progress'
                      ? AppColors.primary600   // green
                      : widget.progressStatusText == 'Delivered'
                      ? AppColors.green700 // yellow (Delivered)
                      : widget.progressStatusText == 'Cancel'
                      ? AppColors.red700 // red (Cancel)
                      : AppColors.neutral400, // default/fallback
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 19.w,vertical: 7.w),
                    child: Text(widget.progressStatusText,style: AppTextStyles.buttonRegular.copyWith(color: AppColors.neutral50),),
                  ),
                ),
              ),
            ),


          Positioned(
            bottom: 13.h,
            left: 12.w,
            right: 8.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onSellerProfileImageTab,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: AppColors.defaultTextColor,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child:
                                widget.productOwnerPicture != null &&
                                    widget.productOwnerPicture!.isNotEmpty
                                ? Image.asset(
                                    widget.productOwnerPicture!,
                                    width: 16.w,
                                    height: 16.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        AppImages.profilePic,
                                        width: 16.w,
                                        height: 16.w,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    AppImages.profilePic,
                                    width: 16.w,
                                    height: 16.w,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          widget.shopName,
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isFollowCountActive == true)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      '${formatNumberShort(widget.followCount)} Followers',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatNumberShort(int number) {
    return number < 1000
        ? number.toString()
        : number < 1000000
        ? '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)} K'
        : '${(number / 1000000).toStringAsFixed(number % 1000000 == 0 ? 0 : 1)} M';
  }
}
