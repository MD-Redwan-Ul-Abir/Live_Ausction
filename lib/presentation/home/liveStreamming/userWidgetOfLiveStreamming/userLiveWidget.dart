import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../../main.dart';
import '../../../commonWidgets/customSliderWidget.dart';
import '../../../commonWidgets/customTimer.dart';
import '../../../commonWidgets/glassButton.dart';
import '../../../goLive/live/controllers/live.controller.dart';
import '../../../shared/widgets/custom_text_form_field.dart';

class UserLiveWidget extends StatefulWidget {
  const UserLiveWidget({super.key});

  @override
  State<UserLiveWidget> createState() => _UserLiveWidgetState();
}

class _UserLiveWidgetState extends State<UserLiveWidget> {
   String? selectedProduct;
  TextEditingController buyerNameController = TextEditingController();

   List<Map<String, String>> availableProducts = [
     {'id': '1', 'name': 'Nike Air Max Sneakers', 'price': '\$25.00'},
     {'id': '2', 'name': 'Vintage Rolex Watch', 'price': '\$5,000.00'},
     {'id': '3', 'name': 'Samsung Galaxy Phone', 'price': '\$800.00'},
     {'id': '4', 'name': 'MacBook Pro Laptop', 'price': '\$2,500.00'},
     {'id': '5', 'name': 'Designer Handbag', 'price': '\$450.00'},
     {'id': '6', 'name': 'Nike Air Max Sneakers V2', 'price': '\$25.00'},
     {'id': '7', 'name': 'Vintage Rolex Watch V2', 'price': '\$5,000.00'},
     {'id': '8', 'name': 'Samsung Galaxy Phone V2', 'price': '\$800.00'},
     {'id': '9', 'name': 'MacBook Pro Laptop V2', 'price': '\$2,500.00'},
     {'id': '10', 'name': 'Designer Handbag V2', 'price': '\$450.00'},
     {'id': '11', 'name': 'Nike Air Max Sneakers V3', 'price': '\$25.00'},
     {'id': '12', 'name': 'Vintage Rolex Watch V3', 'price': '\$5,000.00'},
   ];


  @override
  void dispose() {
    buyerNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,

      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (AppController.to.role.value == "buyer")
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.h),
              _profile(),
            ],
          ),
        if (AppController.to.role.value != "buyer")
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.h),
              _closeLive(),
            ],
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _tabBarComponent(),
            SizedBox(height: 24.h),
            writeSomething(),
            SizedBox(height: 24.h),
            _productDetails(),
            if (AppController.to.role.value == "buyer")
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: _customBid(),
              ),
            if (AppController.to.role.value != "buyer")
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: _nextProduct(),
              ),
          ],
        ),
      ],
    );
  }

  ///------------------Next product for seller--------------

  Widget _nextProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryButton(
          onPressed: () {
            Get.bottomSheet(
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                child: Container(
                  height: Get.height * 0.40345,
                  decoration: BoxDecoration(
                    color: AppColors.neutral950, // Dark background color
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: 16.w),
                            Spacer(),

                            // Congratulations text
                            Text(
                              'Nike Air Max 2',
                              style: AppTextStyles.H5_Regular.copyWith(
                                color: AppColors.primary600,
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  AppImages
                                      .interfaceDeleteCircleButtonDeleteRemoveAddCircleButtonsStreamlineCore,
                                  color: AppColors.neutral50,
                                  height: 16.w,
                                  width: 16.w,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.h),


                        CustomTextFormField(
                          hintText: 'Enter Bidding Time (sec)',
                          keyboardType: 'number',
                        ),

                        Spacer(),
                        Column(
                          children: [Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryButton(
                                backgroundColor: AppColors.neutral200,
                                onPressed: () {
                                  Get.snackbar("Moved!", "This item will be at the last of the queue of products",backgroundColor: AppColors.primary950,colorText: AppColors.primary1000);
                                },
                                text: 'Move Next Item',

                              ),PrimaryButton(
                                onPressed: () {
                                  Get.snackbar("Time updated", "Biding time for the product has been changed",backgroundColor: AppColors.green800,colorText: AppColors.neutral200);

                                },
                                text: 'Save Bid Time',

                              ),
                            ],
                          ),],
                        ),
                        //


                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: true,
            );
          },
          text: 'Update Product',
          backgroundColor: AppColors.neutral200,
        ),
        PrimaryButton(onPressed: () {
          Get.snackbar("Next product added", "You can now start biding for this product",backgroundColor: AppColors.primary600,colorText: AppColors.neutral50);

        }, text: 'Add Next'),
      ],
    );
  }

  ///--------------Close Live for seller------------------
  Widget _closeLive() {
    return GestureDetector(
      onTap: () {
        // Dispose camera controller before navigating away
        try {
          final liveController = Get.find<LiveController>();
          liveController.disposeCamera();
        } catch (e) {
          print('Error disposing camera: $e');
        }

        Get.offAllNamed(Routes.MAIN_APP);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages
                .interfaceDelete1RemoveAddButtonButtonsDeleteStreamlineCore,
            height: 14.86.h,
            width: 14.86.w,
            color: AppColors.red500,
          ),
          SizedBox(width: 12.w),
          Text(
            'Close Live',
            style: AppTextStyles.paragraph_1_Medium.copyWith(
              color: AppColors.red700,
            ),
          ),
        ],
      ),
    );
  }

  ///--------------profile component for buyer screen-------------
  Widget _profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SELLER_PROFILE);
          },
          child: Container(
            height: 32.w,
            width: 32.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.asset(AppImages.productOwner, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jirah Shop',
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.defaultTextColor,
                shadows: [
                  Shadow(
                    offset: Offset(0.5, 0), // horizontal & vertical offset
                    blurRadius: 2, // softness of the shadow
                    color: AppColors.neutral500, // shadow color
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImages.ratingsIcon2,
                  height: 12.w,
                  width: 12.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  '4.9',
                  style: AppTextStyles.buttonRegular.copyWith(
                    color: AppColors.defaultTextColor,
                    shadows: [
                      Shadow(
                        offset: Offset(0.5, 0), // horizontal & vertical offset
                        blurRadius: 2, // softness of the shadow
                        color: AppColors.neutral500, // shadow color
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.primary400,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 1.h,
                    ),
                    child: Text(
                      'Follow',
                      style: AppTextStyles.buttonRegular.copyWith(
                        color: AppColors.neutral950,
                        height: 1.5.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
///----------------Give way functionality for give way button----------------------

  Future _giveWay() {
    return Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        child: Container(
          height: Get.height * 0.50,
          decoration: BoxDecoration(
            color: AppColors.neutral950,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32.r),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // IMPORTANT: Prevents overflow
                children: [
                  // Header with close button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 16.w),
                      Spacer(),
                      Text(
                        'Give way Buyer',
                        style: AppTextStyles.H5_Regular.copyWith(
                          color: AppColors.primary600,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          buyerNameController.clear();
                          setState(() {
                            selectedProduct = null;
                          });
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          AppImages.interfaceDeleteCircleButtonDeleteRemoveAddCircleButtonsStreamlineCore,
                          color: AppColors.neutral50,
                          height: 16.w,
                          width: 16.w,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Buyer Name Input - FIXED: Added proper constraints
                  CustomTextFormField(
                    controller: buyerNameController,
                    hintText: 'Enter Buyer Name',
                    keyboardType: 'text',
                  ),

                  SizedBox(height: 16.h),

                  Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutral800,
                      border: Border.all(
                        color: AppColors.neutral950,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: DropdownButton2<String>(
                      value: selectedProduct,
                      isExpanded: true,
                      hint: Text(
                        'Select Give way Product',
                        style: AppTextStyles.paragraph_2_Regular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      style: AppTextStyles.paragraph_2_Regular.copyWith(
                        color: AppColors.neutral50,
                      ),
                      underline: SizedBox(),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.neutral300,
                        ),
                      ),
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: AppColors.neutral800,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.neutral950,
                            width: 1.w,
                          ),
                        ),
                        maxHeight: 200.h,
                        offset: Offset(0, -5),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                      ),
                      items: availableProducts.map((product) {
                        return DropdownMenuItem<String>(
                          value: product['id'], // Make sure this matches the data type of selectedProduct
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                width: constraints.maxWidth,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          product['name']!,
                                          style: AppTextStyles.paragraph_2_Regular.copyWith(
                                            color: AppColors.neutral50,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          product['price']!,
                                          style: AppTextStyles.paragraph_2_Medium.copyWith(
                                            color: AppColors.primary400,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        print('Selected value: $newValue');
                        print('Available products: $availableProducts');
                        setState(() {
                          selectedProduct = newValue;
                        });
                        print('selectedProduct after setState: $selectedProduct');
                      },
                    ),
                  ),
                  // Selected product details - FIXED: Constrained height
                  if (selectedProduct != null) ...[
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 60.h,
                        maxHeight: 80.h, // Prevent excessive growth
                      ),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary950.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.primary600.withOpacity(0.3),
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Selected Product:',
                            style: AppTextStyles.buttonRegular.copyWith(
                              color: AppColors.primary400,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            availableProducts.firstWhere(
                                  (product) => product['id'] == selectedProduct,
                            )['name']!,
                            style: AppTextStyles.paragraph_2_Medium.copyWith(
                              color: AppColors.neutral50,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],

                  // FIXED: Use Expanded instead of Spacer for better control
                  Expanded(child: SizedBox()),

                  // Send Gift Button - FIXED: Proper constraints
                  PrimaryButton(
                    width: double.infinity,
                    onPressed: () {

                      Get.snackbar(
                        "Gift Sent",
                        "You have given away 'productName' to 'buyerName'",
                        backgroundColor: AppColors.green800,
                        colorText: AppColors.neutral50,
                        duration: Duration(seconds: 3),
                      );

                      // Clear form data
                      buyerNameController.clear();
                      setState(() {
                        selectedProduct = null;
                      });
                    },
                    text: 'Send Gift',
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
    ).then((_) {
      // Clear form when bottom sheet is dismissed
      buyerNameController.clear();
      setState(() {
        selectedProduct = null;
      });
    });
  }


  ///--------------svg button component-------------
  Widget _tabBarComponent() {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ------------------send gift-----------------------
          //if (AppController.to.role.value != "buyer")
          GestureDetector(
            onTap: (){
              _giveWay();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.giftIcon),
                SizedBox(height: 4.h),
                Text('Give\nway', style: AppTextStyles.buttonRegular),
              ],
            ),
          ),

          /// ------------------View Count-----------------------
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              SvgPicture.asset(
                AppImages.interfaceEditViewEyeEyeballOpenViewStreamlineCore,
                color: AppColors.neutral50,
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(height: 4.h),
              Text('1.2k', style: AppTextStyles.buttonRegular),
            ],
          ),

          /// ------------------Shear -----------------------
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              SvgPicture.asset(
                AppImages.interfaceShareShareTransmitStreamlineCore,
                color: AppColors.neutral50,
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(height: 4.h),
              Text('Share', style: AppTextStyles.buttonRegular),
            ],
          ),

          /// ------------------wallet -----------------------
          if (AppController.to.role.value == "buyer")
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                SvgPicture.asset(
                  AppImages.wallet_svgrepo_com_1,
                  color: AppColors.neutral50,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(height: 4.h),
                Text('wallet', style: AppTextStyles.buttonRegular),
              ],
            ),

          /// ------------------view Shop -----------------------
          if (AppController.to.role.value == "buyer")
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                SvgPicture.asset(
                  AppImages.storeIcon,
                  color: AppColors.neutral50,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(height: 4.h),
                Text('View\nShop', style: AppTextStyles.buttonRegular),
              ],
            ),
        ],
      ),
    );
  }

  ///--------------write button and timer component-------------

  Widget writeSomething() {
    final GlobalKey<CountdownTimerState> timer1Key = GlobalKey();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GlassButton(
          text: 'Write Something',
          width: 252.w,
          onPressed: () {
            Get.bottomSheet(
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: Get.height * 0.7, // 70% of screen height
                    decoration: BoxDecoration(
                      color: AppColors.neutral50.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Handle bar
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.neutral50.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Messages ListView
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount: 8, // Same as your image
                            itemBuilder: (context, index) {
                              final messages = [
                                {
                                  'sender': 'Sarah',
                                  'message': 'This product is original \$25',
                                  'color': Colors.yellow,
                                },
                                {
                                  'sender': 'John',
                                  'message': 'This product is original \$25',
                                  'color': Colors.yellow,
                                },
                                {
                                  'sender': 'Mike',
                                  'message': 'This product is original \$25',
                                  'color': Colors.yellow,
                                },
                                {
                                  'sender': 'Anna',
                                  'message': 'This product is original \$25',
                                  'color': Colors.yellow,
                                },
                                {
                                  'sender': 'David',
                                  'message': 'This product is original \$25',
                                  'color': Colors.lightBlue,
                                },
                                {
                                  'sender': 'Emma',
                                  'message': 'This product is original \$25',
                                  'color': Colors.grey,
                                },
                                {
                                  'sender': 'Tom',
                                  'message': 'This product is original \$25',
                                  'color': Colors.blue,
                                },
                                {
                                  'sender': 'Lisa',
                                  'message': 'This product is original \$25',
                                  'color': Colors.pink,
                                },
                              ];

                              final message = messages[index];

                              return Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    // Avatar circle
                                    Container(
                                      width: 32.w,
                                      height: 32.w,
                                      decoration: BoxDecoration(
                                        color: message['color'] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          (message['sender'] as String)[0]
                                              .toUpperCase(),
                                          style: AppTextStyles
                                              .paragraph_2_Medium
                                              .copyWith(
                                                color: AppColors.neutral950,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),

                                    // Message content
                                    Expanded(
                                      child: Text(
                                        message['message'] as String,
                                        style: AppTextStyles.paragraph_2_Regular
                                            .copyWith(
                                              color: AppColors.neutral50,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(12.r),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.neutral50.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Message',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.send,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: true,
            );
          },
        ),
        GestureDetector(
          onTap: () {
            if (AppController.to.role.value != "buyer") {
              timer1Key.currentState?.start();
            }
          },
          child: CountdownTimer(
            key: timer1Key,
            initialSeconds: 12,
            size: 48.w,
            progressColor: AppColors.primary1000,
            backgroundColor: AppColors.neutral800,
            strokeWidth: 4.w,

            // Manual thickness
            textStyle: AppTextStyles.captionRegular.copyWith(
              color: AppColors.neutral50,
              // shadows:
            ),
            onStart: () => print('Timer 1 started!'),
            onComplete: () => print('Timer 1 completed!'),
            onReset: () => print('Timer 1 reset!'),
          ),
        ),
      ],
    );
  }

  ///--------------product Details component-------------

  Widget _productDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 64.w,
          width: 64.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(AppImages.product2, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          height: 64.h,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nike Air Max Sneakers',
                style: AppTextStyles.paragraph_1_Bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Size: 34-44', style: AppTextStyles.buttonRegular),
                  SizedBox(width: 8.w),
                  Icon(Icons.circle, size: 8.sp, color: AppColors.primary300),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text('New', style: AppTextStyles.buttonRegular),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.circle, size: 8.sp, color: AppColors.primary300),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      '1 Available',
                      style: AppTextStyles.buttonRegular,
                    ),
                  ),
                ],
              ),
              Text('\$4.13', style: AppTextStyles.buttonBold),
            ],
          ),
        ),
      ],
    );
  }

  ///--------------custom bid Row component-------------

  Widget _customBid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: GlassButton(
            text: 'Custom',
            width: 100.w,
            onPressed: () {
              Get.bottomSheet(
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                  child: Container(
                    height: Get.height * 0.4828, // 48% of screen height
                    decoration: BoxDecoration(
                      color: AppColors.neutral950, // Dark background color
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: SvgPicture.asset(
                                AppImages
                                    .interfaceDeleteCircleButtonDeleteRemoveAddCircleButtonsStreamlineCore,
                                color: AppColors.neutral50,
                                height: 16.w,
                                width: 16.w,
                              ),
                            ),
                          ),

                          // Congratulations text
                          Text(
                            'Custom Bid',
                            style: AppTextStyles.H5_Regular.copyWith(
                              color: AppColors.primary600,
                            ),
                          ),

                          SizedBox(height: 28.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Enter Custom Bid',
                              style: AppTextStyles.paragraph_1_Regular.copyWith(
                                color: AppColors.neutral50,
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          CustomTextFormFieldTwo(
                            hintText: 'Enter Your Custom Bid',
                            keyboardType: 'number',
                          ),

                          Spacer(),
                          PrimaryButton(
                            onPressed: () {
                              Get.back();
                            },
                            text: 'Send',
                            width: double.infinity,
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible: true,
                enableDrag: true,
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: CustomSlider(
            width: 196.w,
            height: 48.h,
            sliderWidth: 160.w,
            borderWidth: 1.w,
            text: '',
            buttonText: 'Bid\$22',
            borderColor: AppColors.primary200,
            buttonColor: AppColors.primary1000,
            backgroundColor: Colors.transparent,
            textStyle: AppTextStyles.paragraph_2_Regular.copyWith(
              color: AppColors.neutral950,
            ),
            onSlideComplete: () {
              Get.bottomSheet(
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                  child: Container(
                    height: Get.height * 0.4828, // 48% of screen height
                    decoration: BoxDecoration(
                      color: AppColors.neutral950, // Dark background color
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 16.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: SvgPicture.asset(
                                  AppImages
                                      .interfaceDeleteCircleButtonDeleteRemoveAddCircleButtonsStreamlineCore,
                                  color: AppColors.neutral50,
                                  height: 16.w,
                                  width: 16.w,
                                ),
                              ),
                            ),

                            // Congratulations text
                            Text(
                              'Congratulations',
                              style: AppTextStyles.H5_Regular.copyWith(
                                color: AppColors.primary600,
                              ),
                            ),

                            SizedBox(height: 4.h),

                            // Subtitle
                            Text(
                              'You Won the Bit of the Product',
                              style: AppTextStyles.buttonRegular.copyWith(
                                color: AppColors.neutral500,
                              ),
                            ),
                            SizedBox(height: 28.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120.w,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.asset(
                                      AppImages.product2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                SizedBox(
                                  height: 120.h,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Vintage Rolex Watch',
                                          style: AppTextStyles
                                              .paragraph_1_Regular
                                              .copyWith(
                                                color: AppColors.neutral50,
                                              ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'One Size',
                                          style: AppTextStyles
                                              .paragraph_2_Medium
                                              .copyWith(
                                                color: AppColors.neutral500,
                                              ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Text(
                                          '\$5,000',
                                          style: AppTextStyles
                                              .paragraph_1_Medium
                                              .copyWith(
                                                color: AppColors.neutral50,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 28.h),
                            PrimaryButton(
                              onPressed: () {},
                              text: 'Go to payment',
                              width: double.infinity,
                            ),
                            SizedBox(height: 16.h),

                            PrimaryButton(
                              backgroundColor: Colors.transparent,
                              borderColor: AppColors.primary1000,
                              textColor: AppColors.primary1000,
                              onPressed: () {},
                              text: 'Add to cart',
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                isDismissible: true,
                enableDrag: true,
              );
            },
          ),
        ),
      ],
    );
  }
}
