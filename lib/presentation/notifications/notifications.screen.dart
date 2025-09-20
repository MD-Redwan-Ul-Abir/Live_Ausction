import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

import '../../infrastructure/utils/app_images.dart';
import '../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/notifications.controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", centerTitle: false),

      body:  Padding(
        padding:   EdgeInsets.only(top: 8.h),
        child: ListView.builder(itemCount: 20,itemBuilder: (context,index){

          return Padding(
            padding:   EdgeInsets.symmetric(horizontal: 24.w,vertical: 8.h),
            child: Container(

              decoration: BoxDecoration(
                  color: AppColors.neutral800,
                  borderRadius: BorderRadius.circular(4.r)
              ),
              child:  Padding(
                padding:   EdgeInsets.symmetric(vertical: 14.h,horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(AppImages.person2), // Replace with your image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Notification Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Notification Title
                          Text(
                            "Your Room Cleaning Completed",
                            style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.neutral50
                            ),
                          ),

                          SizedBox(height: 4.h),

                          // Notification Message
                          Text(
                            "please Approve the Job and give feedback for me.",
                            style: AppTextStyles.buttonRegular.copyWith(
                              color: AppColors.neutral200
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8.w),

                    // Timestamp
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}