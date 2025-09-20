import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../controllers/add_product.controller.dart';

class ChoseSales extends GetView<AddProductController> {
  const ChoseSales({super.key});



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose sales format',
            style: AppTextStyles.H6_Medium.copyWith(color: AppColors.neutral50),
          ),
          SizedBox(height: 4.h),
          Text(
            'Set a Starting price you’re comfortable with that will \nget buyers interested . Lower price is more \nEngaging',
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral200,
            ),
          ),
          SizedBox(height: 24.h),


          Container(
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.neutral800,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child:

              TabBar(
                controller: controller.tabController,
                onTap: controller.changeTab,
                labelPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                indicatorWeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                labelColor: AppColors.primary700,
                unselectedLabelColor: AppColors.primary700,
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text('Auction', style: AppTextStyles
                            .paragraph_2_Regular.copyWith(
                            color: controller.tabIndex == 0 ? AppColors
                                .neutral950 : AppColors.neutral50
                        ));
                      }),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Obx(() {
                        return Text(
                            'Buy it Now',
                            style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: controller.tabIndex == 1 ? AppColors
                                    .neutral950 : AppColors.neutral50
                            ));
                      }),
                    ),
                  ),
                ],
              )


          ),
          SizedBox(height: 32.h),



          // Dynamic Price Field based on selected tab
          Obx(() {
            final isAuction = controller.tabIndex == 0;
            return _buildPriceField(
              isAuction ? 'Starting Bid*' : 'Buying Price',
              isAuction ? controller.startingBid.value : controller.buyNowPrice.value,
              isAuction ? controller.updateStartingBid : controller.updateBuyNowPrice,

            );
          }),
        ],
      ),
    );


  }


  Widget _buildPriceField(String label, double value,
      Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(controller.tabIndex==0?'Price':label, style: TextStyle(color: Colors.white70)),
        SizedBox(height: 8.h),
        if(controller.tabIndex==0)
        CustomTextFormFieldTwo(hintText: label),
        if(controller.tabIndex==1)

          CustomTextFormFieldTwo(hintText: 'Price*'),

      ],
    );
  }


}


// // Color Dropdown
// Obx(() => CustomTextFormFieldTwo(
// hintText: 'Select color',
// labelText: 'Color*',
// dropDownItems: colorItems,
// selectedValue: controller.selectedColor.value,
// onChanged: (value) {
// controller.updateColor(value ?? '');
// },
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please select a color';
// }
// return null;
// },
// )),
// SizedBox(height: 16.h),
//
// // Size Dropdown
// Obx(() => CustomTextFormFieldTwo(
// hintText: 'Select size',
// labelText: 'Size*',
// dropDownItems: sizeItems,
// selectedValue: controller.selectedSize.value,
// onChanged: (value) {
// controller.updateSize(value ?? '');
// },
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please select a size';
// }
// return null;
// },
// )),
// SizedBox(height: 16.h),
//
// // Sales Format Dropdown
// Obx(() => CustomTextFormFieldTwo(
// hintText: 'Select sales format',
// labelText: 'Sales Format*',
// dropDownItems: salesFormatItems,
// selectedValue: controller.salesFormat.value,
// onChanged: (value) {
// controller.updateSalesFormat(value ?? '');
// },
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please select sales format';
// }
// return null;
// },
// )),
// SizedBox(height: 16.h),
//
// // Starting Bid Price
// Obx(() => CustomTextFormFieldTwo(
// hintText: 'Enter starting bid amount',
// labelText: 'Starting Bid*',
// keyboardType: 'number',
// controller: TextEditingController(text: controller.startingBid.value.toString()),
// onChanged: (value) => controller.updateStartingBid(value ?? ''),
// validator: (value) {
// if (value == null || value.trim().isEmpty) {
// return 'Starting bid is required';
// }
// final price = double.tryParse(value.trim());
// if (price == null || price <= 0) {
// return 'Please enter a valid price';
// }
// return null;
// },
// )),
// SizedBox(height: 16.h),
//
// // Buy Now Price
// Obx(() => CustomTextFormFieldTwo(
// hintText: 'Enter buy now price',
// labelText: 'Buy Now Price*',
// keyboardType: 'number',
// controller: TextEditingController(text: controller.buyNowPrice.value.toString()),
// onChanged: (value) => controller.updateBuyNowPrice(value ?? ''),
// validator: (value) {
// if (value == null || value.trim().isEmpty) {
// return 'Buy now price is required';
// }
// final price = double.tryParse(value.trim());
// if (price == null || price <= 0) {
// return 'Please enter a valid price';
// }
// return null;
// },
// )),