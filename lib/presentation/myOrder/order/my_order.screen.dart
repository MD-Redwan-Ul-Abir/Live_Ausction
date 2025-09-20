import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/presentation/myOrder/widget/orderDetailsCard.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../commonWidgets/customSelectionButton.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/my_order.controller.dart';


class MyOrderScreen extends GetView<MyOrderController> {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "My Orders",
          centerTitle: true,
          donotShowLeadingIcon: true,
        ),
        body: Column(
          children: [
        SizedBox(
          height: 16.h,
        ),
            SizedBox(
              height: 32.h,
              child: ListView.builder(
                itemCount: controller.myOrder.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Obx(() {
                      return Padding(
                        padding: index == 0
                            ? EdgeInsets.only(left: 20.w)
                            : EdgeInsets.all(0),
                        child: SelectableButton(
                          text: controller.myOrder[index]['buttonName'],
                          isSelected: controller.orderSelected.value == index,
                          onTap: () => controller.onCategorySelected(index),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            // Expandable scrollable content section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Obx(() {
                  // You can add loading state or empty state here based on controller state
                  if (controller.isLoading.value == true) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary1000,
                      ),
                    );
                  }

                  // You can filter orders based on selected category here
                  final ordersToShow = controller.getFilteredOrders();

                  if (ordersToShow.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    itemCount: ordersToShow.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.ORDER_DETAILS);
                            controller.orderDetailsController.shopName = 'Jirah Shop';
                            //controller.orderDetailsController.shopName = ordersToShow[index][''];
                            controller.orderDetailsController.shopImageUrl = AppImages.productOwner;
                            controller.orderDetailsController.productImageUrl = ordersToShow[index]['image'];
                            controller.orderDetailsController.status = ordersToShow[index]['status'];
                            controller.orderDetailsController.productTitle = ordersToShow[index]['productName'];
                            controller.orderDetailsController.size = ordersToShow[index]['size'];
                            controller.orderDetailsController.price = ordersToShow[index]['price'];
                            controller.orderDetailsController.qty = ordersToShow[index]['qty'];
                            controller.orderDetailsController.deliveryMethods = ordersToShow[index]['deliveryMethod'];
                          },
                          child: Orderdetailscard(
                            orderData: ordersToShow[index],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your orders will appear here',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}