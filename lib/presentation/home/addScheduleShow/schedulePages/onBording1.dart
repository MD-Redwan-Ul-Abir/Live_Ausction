import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

class Onbording1 extends StatelessWidget {
  const Onbording1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight, // Start from right
                end: Alignment.centerLeft, // End at left
                colors: [
                  Color(0xFFFFC300), // Replace with your start color
                  Color(0xFFFFD342), // Replace with your end color
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 72.w,
                  width: 72.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Text(
                      'T',
                      style: AppTextStyles.paragraph_1_Bold.copyWith(
                        color: AppColors.primary950,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Let’s Prepare for your show!',
                  style: AppTextStyles.H6_Medium.copyWith(
                    color: AppColors.neutral950,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Use this guide to learn the basics of going live for\nthe first time.',
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              // height: 294.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(width: 1.w, color: AppColors.primary1000),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 17.5.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Started',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: AppColors.neutral50,
                        height: 1.5.h,
                      ),
                    ),
                    Text(
                      'you can see all the rules of the Schedule a \nshow',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral300,
                        height: 1.5.h,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _rules(dateAndTime: '2/12, 6:00 PM', data: 'Show Scheduled'),
                    SizedBox(height: 16.h),
                    _rules(dateAndTime: null, data: 'Add more Products'),
                    SizedBox(height: 16.h),
                    _rules(dateAndTime: null, data: 'Rehearse going live'),
                    SizedBox(height: 16.h),
                    _rules(dateAndTime: null, data: 'Brings in buyer'),
                    SizedBox(height: 16.h),
                    _rules(dateAndTime: null, data: 'Preview show and go live'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rules({String? dateAndTime, String? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          height: 20.w,
          width: 20.w,
          decoration: BoxDecoration(
            color: AppColors.green600,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppImages.checkMate,
              height: 12.w,
              width: 12.w,
              color: AppColors.neutral50,
            ),
          ),
        ),
        SizedBox(width: 12.w, ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( height: 1.h),
            Text(
              data!,
              style: AppTextStyles.buttonRegular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            if (dateAndTime != null)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  dateAndTime,
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.neutral300,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
