import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/buy/buy.screen.dart';
 import 'package:live_auction_marketplace/presentation/tools/toolsScreen/tools.screen.dart';
import '../../infrastructure/utils/app_images.dart';

import '../profile/Account/account.screen.dart';
import '../home/homeScreen/home.screen.dart';
import '../home/sellerHomeScreen/sellerHome/seller_home.screen.dart';
import '../goLive/goLive/sell_screen.screen.dart';
import '../messaging/message/message.screen.dart';
import '../shared/widgets/bottomNav/custom_nav_bar.dart';
import '../shared/widgets/bottomNav/nav_bar_model.dart';

import '../categories/categories.screen.dart';
import '../myOrder/order/my_order.screen.dart';

import 'controllers/main_app.controller.dart';

class MainAppScreen extends GetView<MainAppController> {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Obx(() => _buildCurrentScreen()),
        bottomNavigationBar: Obx(
          () => CustomBottomNavBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            items: [
              CustomNavItem(
                svgAssetPath: AppImages
                    .interfaceHome2DoorEntranceHomeHouseMapRoofRoundStreamlineCore,
                label: 'Home',
              ),
              CustomNavItem(
                // svgAssetPath:  AppImages.interfaceSearchGlassSearchMagnifyingStreamlineCore,
                // label: 'Categories',
                svgAssetPath: controller.buyerSelected == true
                    ? AppImages
                          .interfaceSearchGlassSearchMagnifyingStreamlineCore
                    : AppImages.toolsIcon,
                label: controller.buyerSelected == true
                    ? 'Categories'
                    : 'Tools',
              ),
              CustomNavItem(
                svgAssetPath: AppImages.buyerNavbar,
                // label: 'Sell',
                label: controller.buyerSelected == true ? 'Sell' : 'Go Live',
                isFloatingButton: true,
              ),
              CustomNavItem(
                // svgAssetPath: AppImages.buyerNavbar,
                svgAssetPath: controller.buyerSelected == true
                    ? AppImages.buyerNavbar
                    : AppImages.messageIcon,

                label: controller.buyerSelected == true
                    ? 'My Order'
                    : 'Message',
              ),
              CustomNavItem(
                svgAssetPath: AppImages
                    .interfaceSecurityShieldProfileShieldSecureSecurityProfilePersonStreamlineCore,

                // label: 'Account',
                label: controller.buyerSelected == true ? 'Account' : 'Me',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (controller.currentIndex.value) {
      case 0:
        return controller.buyerSelected == true
            ? HomeScreen()
            : SellerHomeScreen();
      case 1:
        return controller.buyerSelected == true
            ? CategoriesScreen()
            : ToolsScreen();
      case 2:
        return controller.buyerSelected == true
            ? BuyScreen()
            : SellScreenScreen();
      case 3:
        return controller.buyerSelected == true
            ? MyOrderScreen()
            : MessageScreen();
      case 4:
        return const AccountScreen();
      default:
        return const HomeScreen();
    }
  }
}
