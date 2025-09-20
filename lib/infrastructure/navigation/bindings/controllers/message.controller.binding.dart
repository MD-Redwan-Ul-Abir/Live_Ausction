import 'package:get/get.dart';

 import '../../../../presentation/messaging/message/controllers/message.controller.dart';

class MessageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );
  }
}
