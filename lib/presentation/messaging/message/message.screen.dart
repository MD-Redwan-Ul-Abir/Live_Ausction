import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/custom_text_form_field.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/message.controller.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.neutral950,
        appBar: CustomAppBar(
          title: "Message",
          centerTitle: true,
showBackButton: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: CustomTextFormField(
                hintText: 'Search Name',
                prefixSvg: AppImages.searchIcon,
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: 4, // As shown in the screenshot
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CONVERSATIONS);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric( vertical: 8.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.neutral800,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    child: Row(
                      children: [
                        // Profile Image
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            image: DecorationImage(
                              image: AssetImage(AppImages.chatPerson),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Message Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hazrat Ali',
                                    style: AppTextStyles.paragraph_2_Regular.copyWith(

                                    ),
                                  ),
                                  Container(
                                    width: 16.w,
                                    height: 16.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.red500,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Please Send us Carefully',
                                      style: AppTextStyles.buttonRegular.copyWith(
                                        color: AppColors.neutral400,
                                        fontSize: 12.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Today',
                                    style: AppTextStyles.buttonRegular.copyWith(
                                      color: AppColors.neutral400,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ),
                  );
                },
              ),
            ),
            // Bottom emoji icon

          ],
        ),
      ),
    );
  }
}
