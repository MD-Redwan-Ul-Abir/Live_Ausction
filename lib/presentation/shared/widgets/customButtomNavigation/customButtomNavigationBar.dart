// main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
 import 'package:live_auction_marketplace/presentation/categories/categories.screen.dart';
import 'package:live_auction_marketplace/presentation/myOrder/order/my_order.screen.dart';
import "package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart";

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';



import '../../../profile/Account/account.screen.dart';
import '../../../home/homeScreen/home.screen.dart';
import 'buttomNavController.dart';

class MainScreen extends StatelessWidget {
  final NavController navController = Get.put(NavController());
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() => [
    HomeScreen(),
    CategoriesScreen(),
    MyOrderScreen(),
    AccountScreen()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: Obx(
        () => SvgPicture.asset(
          navController.currentIndex.value == 0
              ? AppImages.homeActive
              : AppImages.homeInactive,
        ),
      ),
      title: ("Home"),
      activeColorPrimary: AppColors.primary1000,
      inactiveColorPrimary: AppColors.neutral500,
    ),
    PersistentBottomNavBarItem(
      contentPadding: 0,
      icon: Obx(
        () => SvgPicture.asset(
          navController.currentIndex.value == 1
              ? AppImages.bookingActive
              : AppImages.bookingInactive,
        ),
      ),
      title: ("Categories"),
      activeColorPrimary: AppColors.primary1000,
      inactiveColorPrimary: AppColors.neutral500,
    ),
    PersistentBottomNavBarItem(
      icon: Obx(
        () => SvgPicture.asset(
          navController.currentIndex.value == 2
              ? AppImages.personActive
              : AppImages.personInactive,
        ),
      ),
      title: ("My Order"),
      textStyle: AppTextStyles.captionRegular,
      activeColorPrimary: AppColors.primary1000,
      inactiveColorPrimary: AppColors.neutral500,
    ),
    PersistentBottomNavBarItem(
      icon: Obx(
        () => SvgPicture.asset(
          navController.currentIndex.value == 3
              ? AppImages.personActive
              : AppImages.personInactive,
        ),
      ),
      title: ("Account"),
      textStyle: AppTextStyles.captionRegular,
      activeColorPrimary: AppColors.primary1000,
      inactiveColorPrimary: AppColors.neutral500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
      child: PersistentTabView(
        backgroundColor: AppColors.defaultBlack,
        context,
        navBarHeight: 54.h,

        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style1,
        onItemSelected: (index) {
          navController.changeTab(index);
          _controller.index = index;
        },
      ),
    );
  }
}
