import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';

import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/return_product.controller.dart';

class ReturnProductScreen extends GetView<ReturnProductController> {
  const ReturnProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: "Return", centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.h,
              ),
              CustomTextFormFieldTwo(
                hintText: 'Write your Reason why are you return this Product?',
                keyboardType: 'multiline',

              ),
              SizedBox(
                height: 32.h,
              ),
              PrimaryButton(onPressed: (){}, text: 'Submit',width: double.infinity,)
            ],
          ),
        ),
      ),
    );
  }
}
