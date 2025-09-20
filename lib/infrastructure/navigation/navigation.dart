import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:live_auction_marketplace/presentation/tools/Orders/ordersDetails.dart';
import 'package:live_auction_marketplace/presentation/tools/sellerProducts/editProduct.dart';
import 'package:live_auction_marketplace/presentation/tools/sellerProducts/editProduct2.dart';

import '../../config.dart';
import '../../presentation/auth/splashScreen/splash_screen.screen.dart';
import '../../presentation/profile/Account/account.screen.dart';
import '../../presentation/profile/settings/storeInformation/schedule_action_settings.screen.dart';
import '../../presentation/home/directBuyProduct/direct_buy_product.screen.dart';
import '../../presentation/home/liveStreamming/live_streamming.screen.dart';
import '../../presentation/main_app/main_app.screen.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'bindings/controllers/main_app.controller.binding.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.MAIN_APP,
      page: () => const MainAppScreen(),
      binding: MainAppControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenScreen(),
      binding: SplashScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.ROLE_SELECTION,
      page: () => const RoleSelectionScreen(),
      binding: RoleSelectionControllerBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP_WITH_EMAIL,
      page: () => const SignUpWithEmailScreen(),
      binding: SignUpWithEmailControllerBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const SignUpScreen(),
      binding: SignUpControllerBinding(),
    ),
    GetPage(
      name: Routes.SUCCESS_SCREEN,
      page: () => const SuccessScreenScreen(),
      binding: SuccessScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.LOG_IN,
      page: () => const LogInScreen(),
      binding: LogInControllerBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_EMAIL,
      page: () => const VerifyEmailScreen(),
      binding: VerifyEmailControllerBinding(),
    ),
    GetPage(
      name: Routes.OTP_VERIFICATION,
      page: () => const OtpVerificationScreen(),
      binding: OtpVerificationControllerBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.SELLER_INFORMATION,
      page: () => const SellerInformationScreen(),
      binding: SellerInformationControllerBinding(),
    ),
    GetPage(
      name: Routes.GUIDE_LINE,
      page: () => const GuideLineScreen(),
      binding: GuideLineControllerBinding(),
    ),
    GetPage(
      name: Routes.GENDER_SELECTION,
      page: () => const GenderSelectionScreen(),
      binding: GenderSelectionControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_SELECTION,
      page: () => const ProductSelectionScreen(),
      binding: ProductSelectionControllerBinding(),
    ),
    GetPage(
      name: Routes.CATEGORY_SELECTION,
      page: () => const CategorySelectionScreen(),
      binding: CategorySelectionControllerBinding(),
    ),
    GetPage(
      name: Routes.HOW_DOES_IT_WORKS,
      page: () => const HowDoesItWorksScreen(),
      binding: HowDoesItWorksControllerBinding(),
    ),
    GetPage(
      name: Routes.CATEGORIES,
      page: () => const CategoriesScreen(),
      binding: CategoriesControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_ORDER,
      page: () => const MyOrderScreen(),
      binding: MyOrderControllerBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => const AccountScreen(),
      binding: AccountControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsControllerBinding(),
    ),
    GetPage(
      name: Routes.LIVE_STREAMMING,
      page: () => const LiveStreammingScreen(),
      binding: LiveStreammingControllerBinding(),
    ),
    GetPage(
      name: Routes.DIRECT_BUY_PRODUCT,
      page: () => const DirectBuyProductScreen(),
      binding: DirectBuyProductControllerBinding(),
    ),
    GetPage(
      name: Routes.SELL_SCREEN,
      page: () => const SellScreenScreen(),
      binding: SellScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.SELLER_HOME,
      page: () => const SellerHomeScreen(),
      binding: SellerHomeControllerBinding(),
    ),
    GetPage(
      name: Routes.TOOLS,
      page: () => const ToolsScreen(),
      binding: ToolsControllerBinding(),
    ),
    GetPage(
      name: Routes.MESSAGEPage,
      page: () => const MessageScreen(),
      binding: MessageControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.PERSONAL,
      page: () => const PersonalScreen(),
      binding: PersonalControllerBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PROFILE,
      page: () => const UpdateProfileScreen(),
      binding: UpdateProfileControllerBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsScreen(),
      binding: SettingsControllerBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.ALL_PRIVACY_AND_TEARMS,
      page: () => const AllPrivacyAndTearmsScreen(),
      binding: AllPrivacyAndTearmsControllerBinding(),
    ),
    GetPage(
      name: Routes.STORE_INFORMATION,
      page: () => const StoreInformationScreen(),
      binding: ScheduleActionSettingsControllerBinding(),
    ),
    GetPage(
      name: Routes.AUSTION_SETTINGS,
      page: () => const AustionSettingsScreen(),
      binding: AustionSettingsControllerBinding(),
    ),
    GetPage(
      name: Routes.GIVE_AWAY,
      page: () => const GiveAwayScreen(),
      binding: GiveAwayControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_WALLET,
      page: () => const MyWalletScreen(),
      binding: MyWalletControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_PAYMENT_METHODE,
      page: () => const AddPaymentMethodeScreen(),
      binding: AddPaymentMethodeControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS,
      page: () => const OrderDetailsScreen(),
      binding: OrderDetailsControllerBinding(),
    ),
    GetPage(
      name: Routes.TRACK_ORDER,
      page: () => const TrackOrderScreen(),
      binding: TrackOrderControllerBinding(),
    ),
    GetPage(
      name: Routes.REVIEW_PRODUCT,
      page: () => const ReviewProductScreen(),
      binding: ReviewProductControllerBinding(),
    ),
    GetPage(
      name: Routes.RETURN_PRODUCT,
      page: () => const ReturnProductScreen(),
      binding: ReturnProductControllerBinding(),
    ),
    GetPage(
      name: Routes.SELLER_PROFILE,
      page: () => const SellerProfileScreen(),
      binding: SellerProfileControllerBinding(),
    ),
    GetPage(
      name: Routes.BUY,
      page: () => const BuyScreen(),
      binding: BuyControllerBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationsScreen(),
      binding: NotificationsControllerBinding(),
    ),
    GetPage(
      name: Routes.CONVERSATIONS,
      page: () => const ConversationsScreen(),
      binding: ConversationsControllerBinding(),
    ),
    GetPage(
      name: Routes.SET_CAMERE,
      page: () => const SetCamereScreen(),
      binding: SetCamereControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_PRODUCT,
      page: () => const AddProductScreen(),
      binding: AddProductControllerBinding(),
    ),
    GetPage(
      name: Routes.LIVE,
      page: () => const LiveScreen(),
      binding: LiveControllerBinding(),
    ),
    GetPage(
      name: Routes.SCHEDULE_SHOW,
      page: () => const ScheduleShowScreen(),
      binding: ScheduleShowControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_INCOME,
      page: () => const MyIncomeScreen(),
      binding: MyIncomeControllerBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => const OrdersScreen(),
      binding: OrdersControllerBinding(),
    ),
    GetPage(
      name: Routes.SELLER_ORDER_DETAILS,
      page: () => const OrdersBetails(),
      binding: OrdersControllerBinding(),
    ),
    GetPage(
      name: Routes.SELLER_PRODUCTS,
      page: () => const SellerProductsScreen(),
      binding: SellerProductsControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_REVIEWS,
      page: () => const ProductReviewsScreen(),
      binding: ProductReviewsControllerBinding(),
    ), GetPage(
      name: Routes.EDIT_PRODUCT1,
      page: () => const EditProduct(),
      binding: SellerProductsControllerBinding(),
    ), GetPage(
      name: Routes.EDIT_PRODUCT2,
      page: () => const EditProduct2(),
      binding: SellerProductsControllerBinding(),
    ),
  ];
}
