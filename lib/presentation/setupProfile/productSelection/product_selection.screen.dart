import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/product_selection.controller.dart';

class ProductSelectionScreen extends GetView<ProductSelectionController> {
  const ProductSelectionScreen({super.key});

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
                'What do you like to shop for?',
                style: AppTextStyles.H6_Regular,
              ),
              SizedBox(height: 4.h),
              Text(
                'Pick a few to get Started',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral300,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 448.h,
                child: Obx(
                  () {
                    // Access the observable list to trigger rebuilds
                    controller.selectedItems.length;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 16.w, // Spacing between columns
                        mainAxisSpacing: 0, // Spacing between rows
                        childAspectRatio: 0.85, // Width/height ratio of each item
                      ),
                      itemCount: controller.itemSelection.length,
                      itemBuilder: (context, index) {
                        final item = controller.itemSelection[index];
                        final title = item['title'] ?? '';
                        final image = item['image'] ?? '';
                        final isSelected = controller.selectedItems.contains(title);

                        return GestureDetector(
                          onTap: () {
                            controller.toggleItemSelection(title);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 72.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: AppColors.primary50,
                                      border: isSelected
                                          ? Border.all(
                                        color: Color(0xFF000000),
                                        width: 2.w,
                                      )
                                          : null,
                                    ),
                                    child: Center(
                                      child: Image.asset(image),
                                    ),
                                  ),
                                  // Radio button positioned at top-right
                                  Positioned(
                                    top: 6.h,
                                    right: 6.w,
                                    child: Container(
                                      width: 16.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? AppColors.primary400
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: isSelected
                                              ? Color(0xFF000000)
                                              : Color(0xFF000000),
                                          width: 1.5.w,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Center(
                                        child: Container(
                                          width: 6.w,
                                          height: 6.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary400,
                                          ),
                                        ),
                                      )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                title,
                                style: AppTextStyles.captionRegular.copyWith(
                                  color: AppColors.neutral50,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
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

                  if (controller.selectedItemsCount > 0) {
                    print('Selected items: ${controller.selectedItems}');
                  Get.toNamed(Routes.CATEGORY_SELECTION);
                  }
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
}