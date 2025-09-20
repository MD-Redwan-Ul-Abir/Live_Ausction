import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';


class ReviewCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final double rating;
  final String date;
  final String reviewText;
  final String? expandedText;

  const ReviewCard({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.date,
    required this.reviewText,
    this.expandedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isExpanded = false.obs;
    bool hasExpandedText = expandedText != null && expandedText!.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info and date
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundImage: AssetImage(userImage),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Row(
                      children: [
                        // Star rating
                        // Icon(
                        //   Icons.star,
                        //   size: 16.w,
                        //   color: AppColors.primary1000,
                        // ),
                        SvgPicture.asset(AppImages.ratingsIcon2),
                        SizedBox(width: 4.w),
                        Text(
                          rating.toString(),
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: AppTextStyles.captionRegular.copyWith(
                  color: AppColors.neutral300,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review text with expand/collapse functionality
          Obx(() {
            String displayText = reviewText;

            if (isExpanded.value && hasExpandedText) {
              // Show full text when expanded
              displayText = reviewText + ' ' + expandedText!;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayText,
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                    height: 1.4.h,
                  ),
                  maxLines: isExpanded.value ? null : 2,
                  overflow: isExpanded.value ? null : TextOverflow.ellipsis,
                ),

                // See More / See Less button
                if (hasExpandedText)
                  GestureDetector(
                    onTap: () {
                      isExpanded.value = !isExpanded.value;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          Text(
                            isExpanded.value ? 'See Less' : 'See More',
                            style: AppTextStyles.buttonRegular.copyWith(
                              color: AppColors.primary1000,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Transform.rotate(
                            angle: isExpanded.value ? 3.14159 : 0, // 180 degrees if expanded
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 16.w,
                              color: AppColors.primary1000,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}