import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/presentation/profile/settings/allPrivacyAndTearms/controllers/all_privacy_and_tearms.controller.dart';

import '../../../../../infrastructure/navigation/routes.dart';
import '../../../../../main.dart';


class SettingsController extends GetxController {
  final AllPrivacyAndTearmsController allPrivacyAndTearmsController =
      Get.find<AllPrivacyAndTearmsController>();
  static AppController get to => Get.find();
  late   String userRole =  '';

  @override
  void onInit() {

    super.onInit();
    userRole = AppController.to.role.value;
  }

  final String bodyText =
      "Lorem ipsum dolor sit amet consectetur. Ultrices id feugiat venenatis habitant mattis viverra elementum purus volutpat. Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere. Ullamcorper viverra tortor lobortis viverra auctor egestas. Nulla condimentum ac metus quam turpis gravida ut velit. Porta justo lacus consequat sed platea. Ut dui massa quam elit faucibus consectetur sapien aenean auctor. Felis ipsum amet justo in. Netus amet in egestas sed auctor lorem. Justo ullamcorper velit habitasse lorem eu arcu. Non enim a elit urna eget nibh quisque donec condimentum. Elit ut pellentesque neque in quis at viverra. Nisl etiam tristique odio eget convallis.";

  void privacyPolicy() {
    allPrivacyAndTearmsController.appBarTitle.value = 'Privacy Policy';
    allPrivacyAndTearmsController.bodyText.value = bodyText;
    Get.toNamed(Routes.ALL_PRIVACY_AND_TEARMS);
  }

  void termsAndCondition() {
    allPrivacyAndTearmsController.appBarTitle.value = 'Terms & Condition';
    allPrivacyAndTearmsController.bodyText.value = bodyText;
    Get.toNamed(Routes.ALL_PRIVACY_AND_TEARMS);
  }

  void aboutUs() {
    allPrivacyAndTearmsController.appBarTitle.value = 'About Us';
    allPrivacyAndTearmsController.bodyText.value = bodyText;
    Get.toNamed(Routes.ALL_PRIVACY_AND_TEARMS);
  }
}
