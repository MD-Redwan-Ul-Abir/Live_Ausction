import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../commonWidgets/customStapprStatus.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/track_order.controller.dart';

class TrackOrderScreen extends GetView<TrackOrderController> {
  const TrackOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Your Order Status", centerTitle: true,onBackPressed: (){
          Get.toNamed(Routes.MAIN_APP);
        },),
        body: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OrderStatusStepper(
                  steps: controller.incompleteSteps,
                  title: "Your Order Status",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
