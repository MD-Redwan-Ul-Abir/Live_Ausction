import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../commonWidgets/customSelectionButton.dart';
import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/orders.controller.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders', centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          //  activeBorderColor: true,
                          // inactiveBgColor: Colors.transparent,
                          text: controller.orderButtonData[index]['buttonName'],
                          isSelected:
                              controller.selectedOrderButton.value == index,
                          onTap: () => controller.onCategorySelected(index),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            SizedBox(height: 32.h),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 24.w,
                    ),
                    child: Orderdetailscard(
                      isShedule: false,
                      doNotShowButtons: true,
                      onTab: () {
                        Get.toNamed(Routes.SELLER_ORDER_DETAILS);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
