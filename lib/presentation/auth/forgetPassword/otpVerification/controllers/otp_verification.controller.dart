import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationController extends GetxController {
  final otpTextEditingController = TextEditingController();
  final StreamController<ErrorAnimationType> errorController =
  StreamController<ErrorAnimationType>();
  RxList<int?> pinValues = List<int?>.filled(6, null).obs;
  RxInt currentPinIndex = 0.obs;
  RxBool isPinComplete = false.obs;
}
