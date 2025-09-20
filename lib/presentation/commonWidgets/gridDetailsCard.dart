import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../infrastructure/utils/app_images.dart';

class gridCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final bool isLive;
  final bool isPatOrPresentActive;

  final int liveViewerCount;
  final String? pastOrPresentDate;
  final String shopName;
  final String? productOwnerPicture;

  const gridCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isLive = false,
    this.liveViewerCount = 0,
    required this.shopName,
    this.productOwnerPicture,   this.pastOrPresentDate, this.isPatOrPresentActive=false,
  });

  @override
  State<gridCard> createState() => _gridCardState();
}

class _gridCardState extends State<gridCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed height image container
          Container(
            height: 200.h, // Fixed height for consistent image container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey[800],
            ),
            child: Stack(
              children: [
                // Main image
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

                // Live Badge
                if (widget.isPatOrPresentActive && widget.isLive==false)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green600,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child:Text(
                        widget.pastOrPresentDate!,
                        style: AppTextStyles.captionRegular.copyWith(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                // pastOrPresentDate
                if (widget.isLive && widget.isPatOrPresentActive==false)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red500,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Live',
                            style: AppTextStyles.captionRegular.copyWith(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            width: 4.w,
                            height: 4.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${widget.liveViewerCount}',
                            style: AppTextStyles.captionRegular.copyWith(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Shop info overlay at bottom
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  right: 8.w,
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
              ],
            ),
          ),

          // Title section outside the image with flexible height
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
              child: Text(
                widget.title,
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral50,
                  height: 1.3,

                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
