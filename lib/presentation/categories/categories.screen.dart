import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/text_styles.dart';
import '../../infrastructure/utils/app_images.dart';
import '../commonWidgets/gridDetailsCard.dart';
import '../shared/widgets/customSearchBar/customSearchField.dart';
import 'controllers/categories.controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesController categoriesController= Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(

        body:    Obx(
          () => Column(
        children: [
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    controller: categoriesController.searchController,
                    focusNode: categoriesController.searchFocusNode,
                    hintText: 'Search for products',
                    onChanged: categoriesController.onSearchChanged,
                    onSubmitted: categoriesController.onSearchSubmitted,
                    onClear: categoriesController.clearSearch,
                    textInputAction: TextInputAction.search,
                    onTap: () {
                      categoriesController
                          .onSearchFieldSelected(); // Add this method to your controller
                    },
                  ),
                ),


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:   EdgeInsets.only(left: 30.w,right: 10.w),
                      child: GestureDetector(
                        onTap: (){
                          categoriesController.onSearchFieldDeselected();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: SvgPicture.asset(
                          AppImages
                              .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
                          color: AppColors.neutral50,
                          height: 16.h,
                          width: 16.w,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Category Filter Buttons


            Padding(
              padding: EdgeInsets.all(0),
              child: SizedBox(
                height: 32.h,
                child: ListView.builder(
                  itemCount: categoriesController.filterButtonData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            categoriesController.onFilterButtonSelect(index);
                          },
                          child: Padding(
                            padding: index==0?  EdgeInsets.only(left: 20.w):EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  100.r,
                                ),
                                color:
                                categoriesController
                                    .selectedFilterButtonIndex
                                    .value ==
                                    index
                                    ? AppColors.primary1000
                                    : AppColors.neutral800,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 13.h,
                                    vertical: 7.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        categoriesController
                                            .filterButtonData[index]['buttonName'],
                                        style: AppTextStyles
                                            .buttonRegular
                                            .copyWith(
                                          color:
                                          categoriesController
                                              .selectedFilterButtonIndex
                                              .value ==
                                              index
                                              ? AppColors.neutral950
                                              : AppColors.neutral50,
                                        ),
                                      ),

                                      // if (index == 0)
                                      //   Padding(
                                      //     padding: EdgeInsets.only(
                                      //       left: 8.w,
                                      //     ),
                                      //     child: SvgPicture.asset(
                                      //       AppImages.filter,
                                      //       height: 16.h,
                                      //       width: 16.w,
                                      //       color:
                                      //       categoriesController
                                      //           .selectedFilterButtonIndex
                                      //           .value ==
                                      //           index
                                      //           ? AppColors.neutral950
                                      //           : AppColors.neutral50,
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          SizedBox(height: 20.h),

          // Search Results Info (Optional)
          Obx(() {
            if (categoriesController.searchQuery.value.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      '${categoriesController.items.length} products Found',
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),

                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),

          if (categoriesController.searchQuery.value.isNotEmpty)
            SizedBox(height: 12.h),

          // Grid View with Search Results
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() {
                if (categoriesController.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (categoriesController.items.isEmpty) {
                  return _buildEmptyState();
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    // Detect when user starts to scroll
                    if (scrollInfo is ScrollStartNotification) {
                      if (!categoriesController.hasLoadedMoreOnScroll.value && 
                          categoriesController.items.length == 4 && 
                          !categoriesController.isLoading.value) {
                        categoriesController.hasLoadedMoreOnScroll.value = true;
                        categoriesController.loadMoreItemsOnScroll();
                      }
                    }
                    return false;
                  },
                  child: GridView.builder(
                    controller: categoriesController.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 0.665,
                    ),
                    itemCount: categoriesController.items.length,
                    itemBuilder: (context, index) {
                    final item = categoriesController.items[index];
                    return GestureDetector(
                      onTap: (){
                        // Dismiss keyboard before navigation
                        FocusManager.instance.primaryFocus?.unfocus();
                        categoriesController.onSearchFieldDeselected();
                        
                        if(  item['isLive']==false){
                          Get.toNamed(Routes.PRODUCT_DETAILS);
                        }
                        else{
                          Get.toNamed(Routes.LIVE_STREAMMING);
                        }

                      },
                      child: gridCard(
                        imageUrl: item['imageUrl'] ?? '',
                        title: item['title'] ?? '',
                        isLive: item['isLive'] ?? false,
                        liveViewerCount: item['viewerCount'] ?? 0,
                        shopName: item['shopName'] ?? '',
                        productOwnerPicture: item['ownerPic'],
                      ),
                    );
                  },
                  ),
                );
              }),
            ),
          ),
          Obx(() {
            if (categoriesController.showLoadMoreIcon.value) {
              return Transform.rotate(
                angle: 90 * (math.pi / 180),
                child: GestureDetector(
                  onTap: categoriesController.loadMoreItems,
                  child: SvgPicture.asset(
                    AppImages
                        .interfaceArrowsRightCircle2ArrowKeyboardCircleButtonRightStreamlineCore,
                    height: 16.h,
                    width: 16.h,
                    color: AppColors.primary400,
                  ),
                ),
              );
            }
            return const SizedBox.shrink(); // or Container() for empty state
          }),
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
            color: AppColors.neutral400,
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
            onTap: categoriesController.clearSearch,
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
