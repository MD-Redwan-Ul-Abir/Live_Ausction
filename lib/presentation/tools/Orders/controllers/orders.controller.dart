import 'package:get/get.dart';

class OrdersController extends GetxController {
  List<Map<String, dynamic>> orderButtonData = [
    {'buttonName': 'Total Orders'},
    {'buttonName': 'Shipping'},
    {'buttonName': 'Delivered'},
    {'buttonName': 'Returned'},
  ];



  RxString searchQuery = ''.obs;
  RxInt selectedOrderButton = 0.obs;

  void onCategorySelected(int index) {
    selectedOrderButton.value = index;


  }
}
