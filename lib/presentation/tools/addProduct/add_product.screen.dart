import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:live_auction_marketplace/presentation/tools/addProduct/pages/step1.dart';
import 'package:live_auction_marketplace/presentation/tools/addProduct/pages/step2.dart';
import 'package:live_auction_marketplace/presentation/tools/addProduct/pages/step3.dart';
import 'package:live_auction_marketplace/presentation/tools/addProduct/pages/step4.dart';

import '../../../infrastructure/utils/app_images.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import 'controllers/add_product.controller.dart';

class AddProductScreen extends GetView<AddProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Products",
        centerTitle: true,
        onBackPressed: () {
          if (controller.currentStep > 0 && controller.currentStep < 4) {
            controller.previousStep();
          } else {
            Get.back();
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Animated Content Area - This should take remaining space
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  _buildScrollableStep(CreateProduct()),
                  _buildScrollableStep(ChoseSales()),
                  _buildScrollableStep(ChooseSize()),
                  _buildScrollableStep(Finished()),
                ],
              ),
            ),

            // Fixed Bottom Button
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableStep(Widget child) {
    return SingleChildScrollView(
      child: child,
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.neutral700,
            width: 1.0,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          return PrimaryButton(
            width: double.infinity,
            onPressed: controller.nextStep,
            // text: "Next"
            text: controller.currentStep.value == 3 ? 'Finish' : 'Next',
          );
        }),
      ),
    );
  }
}