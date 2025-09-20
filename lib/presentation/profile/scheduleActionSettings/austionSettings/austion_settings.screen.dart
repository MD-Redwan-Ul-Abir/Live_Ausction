import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../commonWidgets/customSelectionButton.dart';
import '../../../commonWidgets/textBox.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/austion_settings.controller.dart';
import 'package:flutter/cupertino.dart';

class AustionSettingsScreen extends GetView<AustionSettingsController> {
  const AustionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: "Auction Settings", centerTitle: false),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomTextFormFieldTwo(
                hintText: "15 Min",
                labelText: "Live Sessions Time (Mins)",
                keyboardType: "number",
              ),
              SizedBox(height: 16.h),
              CustomTextFormFieldTwo(
                hintText: "\$2",
                labelText: "Starting Bid",
                keyboardType: "number",
              ),
              SizedBox(height: 16.h),
              CustomTextFormFieldTwo(
                hintText: "15 Sec",
                labelText: "Required Time",
                keyboardType: "number",
              ),
              SizedBox(height: 16.h),
              Text(
                "Counter Bid Time",
                style: AppTextStyles.H6_Medium.copyWith(
                  color: AppColors.neutral50,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "When the auction has less than 10 Seconds remaining , any new bids will reset the timer to the selected amount.",
                style: AppTextStyles.buttonRegular.copyWith(
                  color: AppColors.neutral200,
                  height: 1.5.h,
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 32.h,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Obx(() {
                        return Padding(
                          padding: index == 0
                              ? EdgeInsets.only(left: 0.w)
                              : EdgeInsets.all(0),
                          child: SelectableButton(
                            text: controller.timeSelection[index]['buttonName'],
                            isSelected:
                            controller.timeSelectionIndex.value == index,
                            onTap: () => controller.onTimeSelection(index),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() {
                return Textbox(Title: 'Counter Bi Time', Subtitle: '${controller.timeSelection[controller.timeSelectionIndex.value]['value']} Sec');
              }),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sudden Death',
                          style: AppTextStyles.H6_Medium.copyWith(
                            color: AppColors.neutral50,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'This Means when you\'re down to 00:01, the\nlast person to bid wins!',
                          style: AppTextStyles.buttonRegular.copyWith(
                            color: AppColors.neutral200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                        () =>
                        Transform.scale(
                          scale: 0.85,
                          child: CupertinoSwitch(
                            activeColor: AppColors.primary1000,
                            trackColor: AppColors.neutral300,
                            thumbColor: AppColors.neutral50,
                            value: controller.active.value,
                            onChanged: (bool value) {
                              controller.active.value = value;
                            },
                          ),
                        ),
                  ),
                ],
              ),
              SizedBox(height: 72.h),
              PrimaryButton(
                width: double.infinity,
                onPressed: () {},
                text: 'Set Auction',
              ),
              SizedBox(height: 16.h),
              PrimaryButton(
                width: double.infinity,
                onPressed: () {},
                text: 'Cancel',
                backgroundColor: AppColors.neutral800,
                textColor: AppColors.neutral50,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}