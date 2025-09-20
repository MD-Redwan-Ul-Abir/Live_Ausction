import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/text_styles.dart';

class Textbox extends StatelessWidget {
  final String Title;
  final String Subtitle;

  const Textbox({super.key, required this.Title, required this.Subtitle,    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(width: 1.w, color: AppColors.neutral800),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              Title,
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.neutral200,
                height: 1.5.h,
              ),
            ),
            Text(
              Subtitle,
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
                height: 1.5.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
