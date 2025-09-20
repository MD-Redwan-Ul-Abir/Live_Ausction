import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';

// Step model to hold step data
class OrderStep {
  final String time;
  final String text;
  final OrderStepState state;

  OrderStep({
    required this.time,
    required this.text,
    required this.state,
  });
}

// Enum for step states
enum OrderStepState {
  completed,
  current,
  upcoming,
}

// Custom Order Status Stepper Widget
class OrderStatusStepper extends StatelessWidget {
  final List<OrderStep> steps;
  final String title;

  const OrderStatusStepper({
    Key? key,
    required this.steps,
    this.title = "Your Order Status",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return _buildStepItem(steps[index], index, steps.length);
      },
    );
  }

  Widget _buildStepItem(OrderStep step, int index, int totalSteps) {
    bool isLast = index == totalSteps - 1;
    bool isFinalStep = index == 0; // Since list is reversed, first item is the final step
    bool showTickMark = step.state == OrderStepState.current && isFinalStep;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Circle and line
        Column(
          children: [
            _buildCircle(step.state, showTickMark),
            if (!isLast) _buildConnectingLine(step.state, index, totalSteps),
          ],
        ),
        SizedBox(width: 16.w),
        // Right side - Content
        Expanded(
          child: _buildStepContent(step),
        ),
      ],
    );
  }

  Widget _buildCircle(OrderStepState state, bool showTickMark) {
    Color circleColor;
    Widget circleChild;

    switch (state) {
      case OrderStepState.completed:
        circleColor = const Color(0xFF4CAF50); // Green
        circleChild = Icon(
          Icons.check,
          color: Colors.white,
          size: 12.sp,
        );
        break;
      case OrderStepState.current:
      // If it's the final step and current, show tick mark like completed
        if (showTickMark) {
          circleColor = const Color(0xFF4CAF50); // Green
          circleChild = Icon(
            Icons.check,
            color: Colors.white,
            size: 12.sp,
          );
        } else {
          circleColor = AppColors.primary50; // Yellow/Orange
          circleChild = Container(
            width: 8.w,
            height: 8.h,
            decoration: const BoxDecoration(
              color: AppColors.primary1000,
              shape: BoxShape.circle,
            ),
          );
        }
        break;
      case OrderStepState.upcoming:
        circleColor = const Color(0xFF5A5A5A); // Gray
        circleChild = Container(
          width: 8.w,
          height: 8.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );
        break;
    }

    return Container(
      width: 16.w,
      height: 16.h,
      decoration: BoxDecoration(
        color: circleColor,
        shape: BoxShape.circle,
      ),
      child: Center(child: circleChild),
    );
  }

  Widget _buildConnectingLine(OrderStepState currentState, int index, int totalSteps) {
    bool isActive = currentState == OrderStepState.completed;

    return Container(
      width: 1.w,
      height: 80.h,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF5A5A5A),
        borderRadius: BorderRadius.circular(1.r),
      ),
    );
  }

  Widget _buildStepContent(OrderStep step) {
    Color backgroundColor;
    Color textColor;
    Color timeBackgroundColor;
    Color timeTextColor;
    Color borderColor;

    switch (step.state) {
      case OrderStepState.completed:
        backgroundColor = AppColors.green700; // Green
        textColor = AppColors.neutral50;
        timeBackgroundColor = AppColors.primary600;
        timeTextColor = AppColors.primary50;
        borderColor = Colors.transparent;
        break;
      case OrderStepState.current:
        backgroundColor = AppColors.primary100; // Light yellow
        textColor = AppColors.neutral950;
        timeBackgroundColor = AppColors.green600;
        timeTextColor = AppColors.primary50;
        borderColor = Colors.transparent;
        break;
      case OrderStepState.upcoming:
        backgroundColor = Colors.transparent; // Light green
        textColor = AppColors.neutral50;
        timeBackgroundColor = AppColors.neutral800;
        timeTextColor =AppColors.neutral50;
        borderColor = AppColors.neutral800;
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 11.5.h),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
              width: 1.w,
              color: borderColor
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w,  vertical: 4.h),
            decoration: BoxDecoration(
              color: timeBackgroundColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              step.time,

              style: AppTextStyles.buttonRegular.copyWith(
                  color: timeTextColor,
                  height: 1.5.h
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Step text
          Text(
            step.text,

            style: AppTextStyles.paragraph_2_Medium.copyWith(
                color: textColor,
                fontSize: 15.sp
            ),
          ),
        ],
      ),
    );
  }
}