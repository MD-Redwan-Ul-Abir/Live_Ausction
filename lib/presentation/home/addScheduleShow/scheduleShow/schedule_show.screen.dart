import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../schedulePages/onBording1.dart';
import '../schedulePages/onBording2.dart';
import '../schedulePages/schedule1.dart';
import '../schedulePages/schedule2.dart';
import '../schedulePages/schedule3.dart';
import '../schedulePages/schedule4.dart';
import 'controllers/schedule_show.controller.dart';

class ScheduleShowScreen extends GetView<ScheduleShowController> {
  const ScheduleShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Animated Content Area - This should take remaining space
            Expanded(
              child: Obx(() {
                return PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    if (controller.firstTime.value)
                      _buildScrollableStep(Onbording1()),
                    if (controller.firstTime.value)
                      _buildScrollableStep(Onbording2()),
                    _buildScrollableStep(Schedule1()),
                    _buildScrollableStep(Schedule2()),
                    _buildScrollableStep(Schedule3()),
                    _buildScrollableStep(Schedule4()),
                  ],
                );
              }),
            ),

            // Fixed Bottom Button
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableStep(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.neutral700,
            width: 1.w,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          return PrimaryButton(
            width: double.infinity,
            onPressed: controller.nextStep,
            text: controller.currentStep.value == controller.totalSteps.value - 1
                ? 'Finish'
                : 'Next',
          );
        }),
      ),
    );
  }
}