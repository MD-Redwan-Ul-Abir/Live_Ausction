import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../myOrder/widget/orderDetailsCard.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';

class EditProduct2 extends StatefulWidget {
  const EditProduct2({super.key});

  @override
  State<EditProduct2> createState() => _EditProduct2State();
}

class _EditProduct2State extends State<EditProduct2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Edit Products', centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:   EdgeInsets.only(top:80.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Success!Your Product has been\nSuccessfully updated',
                      style: AppTextStyles.paragraph_1_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 18.w),
                      child: Orderdetailscard(
                        onEditButtonPressed: () {



                        },
                        isEdit: true,

                        onTab: () {

                        },
                      ),
                    )

                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 16.w),
                child: PrimaryButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.MAIN_APP);
                  },
                  text: 'Finish',
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
