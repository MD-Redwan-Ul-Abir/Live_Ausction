import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../commonWidgets/prductViewCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/buttons/primary_buttons.dart';
import 'controllers/order_details.controller.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Order details", centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            // AppImages.product1
            // AppImages.productOwner
            // 'In progress'
            children: [
              productDetilsCard(
                imageUrl: controller.productImageUrl,
                isShearActive: false,
                followCount: 5500,
                shopName: controller.shopName,
                productOwnerPicture: controller.shopImageUrl,
                progressStatusText: controller.status,
                isFollowCountActive: false,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      controller.productTitle,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                        height: 1.5.h
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding:   EdgeInsets.only(right: 15.w),
                      child: Text(
                        controller.price,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.paragraph_1_Bold.copyWith(
                          color: AppColors.neutral50,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  controller.deliveryMethods,
                  style: AppTextStyles.paragraph_2_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Qty : ${controller.qty}",
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  // "Size : Medium | Large | Small",
                  controller.size,
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
              ),
              Spacer(),

              PrimaryButton(
                backgroundColor: controller.status == 'In Progress'
                    ? AppColors.primary1000
                    : AppColors.neutral950,
                borderColor: AppColors.neutral800,
                onPressed: () async {

                  if (controller.status == 'In Progress') {
                    Get.toNamed(Routes.TRACK_ORDER);
                  } else {
                    Get.toNamed(Routes.REVIEW_PRODUCT);
                  }
                },
                text: controller.status == 'In Progress'
                    ? 'Track Products'
                    : 'Write Review',
                textColor: controller.status == 'In Progress'
                    ? AppColors.neutral950
                    : AppColors.neutral50,

                width: double.infinity,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
