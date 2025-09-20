import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import 'imagePickerController.dart';

void showImagePickerOption(
    BuildContext context,
    imagePickerController controller,
    ) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Optional: Add a handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Row(
                  children: [
                    // Pick from gallery
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage(ImageSource.gallery);
                          Get.back();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                              color: AppColors.primary800,
                            ),
                            SizedBox(height: 8.h),
                            Text("Gallery", style: AppTextStyles.paragraph_1_Regular),
                          ],
                        ),
                      ),
                    ),
                    // Pick from camera
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage(ImageSource.camera);
                          Get.back();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                              color: AppColors.primary800,
                            ),
                            SizedBox(height: 8.h),
                            Text("Camera", style: AppTextStyles.paragraph_1_Regular),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}