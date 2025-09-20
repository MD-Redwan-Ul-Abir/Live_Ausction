import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/my_income.controller.dart';

class MyIncomeScreen extends GetView<MyIncomeController> {
  const MyIncomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Income', centerTitle: true, ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 1.w, color: AppColors.neutral500),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My wallet',
                          style: AppTextStyles.captionRegular.copyWith(
                            color: AppColors.neutral500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '\$23,344',
                          style: AppTextStyles.H5_Medium.copyWith(
                            color: AppColors.primary700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    child: SvgPicture.asset(
                      AppImages.accountBalanceDesign,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text('Received payment',style: AppTextStyles.paragraph_2_Regular.copyWith(color: AppColors.neutral50),),
           SizedBox(
             height: 8.h,
           ),
            Expanded(
              child: ListView.builder(itemCount: 3,itemBuilder: (context,index){
                return Padding(
                  padding:   EdgeInsets.symmetric(vertical: 8.h),
                  child: Orderdetailscard(isShedule: false,doNotShowButtons: true),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
