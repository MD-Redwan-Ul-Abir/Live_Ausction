import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

class OwnerProfileStatus extends StatelessWidget {
  const OwnerProfileStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.neutral800,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Rating Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.ratingsIcon2,
                        color: AppColors.neutral50,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '4.9',
                        style: AppTextStyles.paragraph_2_Regular.copyWith(
                          color: AppColors.neutral50,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Rating',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),

              // Divider
              Container(
                height: double.infinity,
                width: 1.5.w,
                color: AppColors.neutral600,
              ),

              // Reviews Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1.4 K',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Reviews',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),

              // Divider
              Container(
                height: double.infinity,
                width: 1.5.w,
                color: AppColors.neutral600,
              ),

              // Sold Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7.4 K',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Sold',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),

              // Divider
              Container(
                height: double.infinity,
                width: 1.5.w,
                color: AppColors.neutral600,
              ),

              // Ship Time Column
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avg 2d',
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Ship Time',
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}