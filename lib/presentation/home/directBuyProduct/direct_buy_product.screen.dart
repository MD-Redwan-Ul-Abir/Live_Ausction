import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/utils/app_images.dart';
import '../../commonWidgets/prductViewCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/direct_buy_product.controller.dart';

class DirectBuyProductScreen extends GetView<DirectBuyProductController> {
  const DirectBuyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "",
          leadingIconColor: AppColors.neutral50,
          leadingIcon: AppImages
              .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
          showBackButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  'Review & Payment',
                  style: AppTextStyles.H6_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                SizedBox(height: 8.h),
                productDetilsCard(
                  imageUrl: AppImages.product1,
                  isShearActive: false,
                  followCount: 5500,
                  shopName: 'Jirah Shop',
                  productOwnerPicture: AppImages.productOwner,

                  isFollowCountActive: false,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Best Electronics 2025,Start with ',
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Text(
                        '\$6',
                        style: AppTextStyles.paragraph_1_Bold.copyWith(
                          color: AppColors.neutral50,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Free Delivery",
                    style: AppTextStyles.paragraph_2_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Qty : 40",
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Size : Medium | Large | Small",
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.neutral800, width: 1.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bid Amount',
                              style: AppTextStyles.buttonRegular,
                            ),
                            Text(
                              "\$5000",
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.neutral200,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping Fee',
                              style: AppTextStyles.buttonRegular,
                            ),
                            Text(
                              "Standard",
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.neutral200,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estimated Total',
                              style: AppTextStyles.buttonRegular,
                            ),
                            Text(
                              "\$5050",
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                color: AppColors.primary400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Shipping Address',
                  style: AppTextStyles.H6_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                SizedBox(height: 8.h),
                _shippingInformation('Mr. Thomas', AppImages.personIcon),
                SizedBox(height: 16.h),
                _shippingInformation('01315679597', AppImages.phoneCallingSvg),
                SizedBox(height: 16.h),
                _shippingInformation(
                    'Mirpur, Dhaka, Bangladesh', AppImages.locationIcon2),
                SizedBox(height: 24.h),
                Text(
                  'Shipping Address',
                  style: AppTextStyles.H6_Regular.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.neutral800, width: 1.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppImages.stripe, height: 24.h, width: 24.w,)
                            ,
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'pay with Stripe',
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                  color: AppColors.neutral200),
                            ),
                            Spacer(),
                            Obx(() {
                              return GestureDetector(
                                onTap: (){
                                  controller.selectStripe();
                                },
                                child: _paymentSelectionButton(
                                    controller.stripeSelected.value

                                ),
                              );
                            })
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppImages.googlePay, height: 24.h,
                              width: 24.w,)
                            ,
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'Google Pay',
                              style: AppTextStyles.paragraph_2_Regular.copyWith(
                                  color: AppColors.neutral200),
                            ),
                            Spacer(),
                            Obx(() {
                              return GestureDetector(
                                onTap: (){
                                  controller.selectGooglePay();
                                },
                                child: _paymentSelectionButton(
                                    controller.googlePaySelected.value),
                              );
                            })
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                PrimaryButton(
                    width: double.infinity, onPressed: () {
                      controller.navigateToRegistrationSuccess();
                }, text: "Pay Now"),
                SizedBox(height: 16.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shippingInformation(String text, String svgPath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral800, width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SvgPicture.asset(
            svgPath, height: 16.h, width: 16.w, color: AppColors.neutral50,),
          SizedBox(
            width: 8.w,
          ),
          Text(text, style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral50),)
        ]),
      ),
    );
  }

  Widget _paymentSelectionButton(bool isSelected) {
    return Container(
      height: 20.w,
      width: 20.w,
      decoration: BoxDecoration(
          color: isSelected ? AppColors.neutral800 : AppColors.neutral950,
          borderRadius: BorderRadius.circular(100.r),
          border: BoxBorder.all(
              width: 1.w,
              color: AppColors.neutral800
          )
      ),
      child: Center(
        child: Icon(Icons.circle, size: 8.r,
          color: isSelected ? AppColors.primary400 : Colors.transparent,),
      ),

    );
  }
}
