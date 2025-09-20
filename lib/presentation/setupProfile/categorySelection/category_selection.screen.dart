import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/category_selection.controller.dart';

class CategorySelectionScreen extends GetView<CategorySelectionController> {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Set Up Your Profile",
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 38.h),
              Text(
                'Tell us a bit more',
                style: AppTextStyles.H6_Regular,
              ),
              SizedBox(height: 4.h),
              Text(
                'Pick only what you’re passionate about.',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral300,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Video games',
                style: AppTextStyles.paragraph_1_Regular,
              ), SizedBox(height: 8.h),
              Obx(() {
                // Access selectedCategories to trigger rebuilds
                controller.selectedCategories.length;
                return _buildFilterButtons(controller.videoGamesList);
              }),
              SizedBox(height: 32.h),
              Text(
                'Toys & Hobbies',
                style: AppTextStyles.paragraph_1_Regular,
              ), SizedBox(height: 8.h),
              Obx(() {
                // Access selectedCategories to trigger rebuilds
                controller.selectedCategories.length;
                return _buildFilterButtons(controller.toysList);
              }),
              SizedBox(height: 32.h),
              Text(
                'Video games',
                style: AppTextStyles.paragraph_1_Regular,
              ), SizedBox(height: 8.h),
              Obx(() {
                // Access selectedCategories to trigger rebuilds
                controller.selectedCategories.length;
                return _buildFilterButtons(controller.electronicsList);
              }),
              SizedBox(height: 32.h),

              Spacer(),

              // Obx(
              //       () => controller.selectedItemsCount > 0
              //       ? Padding(
              //     padding: EdgeInsets.only(bottom: 8.h),
              //     child: Text(
              //       'Selected: ${controller.selectedItems.join(", ")}',
              //       style: AppTextStyles.captionRegular.copyWith(
              //         color: AppColors.neutral300,
              //         fontSize: 10.sp,
              //       ),
              //     ),
              //   )
              //       : SizedBox.shrink(),
              // ),
              PrimaryButton(
                width: double.infinity,
                onPressed: () {
Get.toNamed(Routes.HOW_DOES_IT_WORKS);

                },
                text: 'Next',
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons(List buttonList) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: buttonList.map((category) {
        bool isSelected = controller.isCategorySelected(category);
        return GestureDetector(
          onTap: () {
            controller.toggleCategorySelection(category);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary1000
                  : AppColors.neutral800,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              category,
              style: AppTextStyles.paragraph_1_Regular.copyWith(

                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

}
