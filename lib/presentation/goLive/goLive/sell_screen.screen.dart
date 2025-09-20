import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/sell_screen.controller.dart';

class SellScreenScreen extends GetView<SellScreenController> {
  const SellScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Go live",
          centerTitle: true,
          donotShowLeadingIcon: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              Text(
                'Select Your Show',
                style: AppTextStyles.H5_Regular.copyWith(
                  color: AppColors.neutral50,
                ),
              ),

              SizedBox(height: 16.h),

              // Use Expanded to give ListView proper constraints
              Expanded(
                child: ListView.builder(
                  itemCount: controller.liveCardList.length,
                  itemBuilder: (context, index) {
                    final item = controller.liveCardList[index];
                    return _liveCard(
                      buttonText: item['liveStatus'] == true
                          ? 'Go Live'
                          : item['date'],
                      isLive: item['liveStatus'] == true,
                      onTab: () {

                        if (item['liveStatus'] == true) {
      Get.toNamed(Routes.SET_CAMERE);
                        } else {

                        }
                      },
                      item: item,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liveCard({
    required String buttonText,
    VoidCallback? onTab,
    bool isLive = false,
    required Map<String, dynamic> item,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Orderdetailscard(
            isShedule: true,
            // You might want to add these parameters to Orderdetailscard:
            // name: item['name'],
            // size: item['size'],
            // price: item['price'],
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            textColor: isLive ? AppColors.neutral950 : AppColors.neutral50,
            backgroundColor: isLive
                ? AppColors.primary1000
                : AppColors.neutral800,
            onPressed: onTab,
            text: buttonText,
            width: double.infinity,
            svgAsset: isLive
                ? AppImages.redDot
                : AppImages
                .interfaceTimeResetTimeClockResetStopwatchCircleMeasureLoadingStreamlineCore,
            svgColor: isLive?AppColors.red500:AppColors.neutral50,
          ),
        ],
      ),
    );
  }
}