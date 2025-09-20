import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

import '../../../infrastructure/navigation/routes.dart';

import '../../commonWidgets/customSelectionButton.dart';
import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';


import '../../shared/widgets/customSearchBar/customSearchField.dart';
import 'controllers/seller_products.controller.dart';

class SellerProductsScreen extends GetView<SellerProductsController> {
  const SellerProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Products', centerTitle: true),
        body: Obx(
          () => Column(
            children: [
              SizedBox(height: 20.h),

              // Search Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        hintText: 'Search for products',
                        onChanged: controller.onSearchChanged,
                        onSubmitted: controller.onSearchSubmitted,
                        onClear: controller.clearSearch,
                        textInputAction: TextInputAction.search,
                        onTap: () {
                          controller.onSearchFieldSelected();
                        },
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Category Filter Buttons
              SizedBox(
                height: 32.h,
                child: ListView.builder(
                  itemCount: controller.orderButtonData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Obx(() {
                        return Padding(
                          padding: index == 0
                              ? EdgeInsets.only(left: 20.w)
                              : EdgeInsets.all(0),
                          child: SelectableButton(
                            text: controller.orderButtonData[index]['buttonName'],
                            isSelected: controller.selectedOrderButton.value == index,
                            onTap: () => controller.onCategorySelected(index),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Search Results Info
              Obx(() {
                if (controller.searchQuery.value.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text(
                          '${controller.products.length} products Found',
                          style: AppTextStyles.paragraph_2_Regular
                              .copyWith(color: AppColors.neutral50),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              if (controller.searchQuery.value.isNotEmpty)
                SizedBox(height: 12.h),

              // Products List
              Expanded(
                child: Obx(() {
                  if (controller.isSearching.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.products.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 24.w,
                        ),
                        child: Orderdetailscard(
                          onEditButtonPressed: () {
                            // Pass the product ID to edit screen
                            final productId = controller.products[index]['id'] ?? '';
                            Get.toNamed(Routes.EDIT_PRODUCT1, arguments: productId);
                          },
                          isEdit: true,
                          onTab: () {
                            Get.toNamed(Routes.SELLER_ORDER_DETAILS);
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.interfaceSearchGlassSearchMagnifyingStreamlineCore,
            height: 64.h,
            width: 64.w,
            colorFilter: ColorFilter.mode(
              AppColors.neutral400,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No products found',
            style: AppTextStyles.paragraph_1_Regular.copyWith(
              color: AppColors.neutral400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with different keywords',
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: controller.clearSearch,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary1000,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Text(
                'Clear Search',
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral950,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
