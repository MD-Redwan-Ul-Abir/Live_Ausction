import 'package:get/get.dart';

 import '../../../../presentation/messaging/conversations/controllers/conversations.controller.dart';

class ConversationsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationsController>(
      () => ConversationsController(),
    );
  }
}
