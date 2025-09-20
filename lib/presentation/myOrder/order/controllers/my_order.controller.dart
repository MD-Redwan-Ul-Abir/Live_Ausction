import 'package:get/get.dart';

import '../../../../infrastructure/utils/app_images.dart';
import '../../orderDetails/controllers/order_details.controller.dart';



class MyOrderController extends GetxController {
  RxInt orderSelected = 0.obs;
  RxBool isLoading = false.obs;
  final OrderDetailsController orderDetailsController = Get.find<OrderDetailsController>();


  var allOrders = <Map<String, dynamic>>[].obs;

  // Fixed categories with matching status
  List<Map<String, dynamic>> myOrder = [
    {'buttonName': 'All', 'status': 'All'},
    {'buttonName': 'In Progress', 'status': 'In Progress'},
    {'buttonName': 'Delivered', 'status': 'Delivered'},
    {'buttonName': 'Cancel', 'status': 'Cancel'},
  ];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      allOrders.value = [
        {
          'id': '1',
          'productName': 'Vintage Rolex WatchVintage Rolex WatchVintage Rolex Watch',
          'size': 'One Size',
          'price': '\$5,000',
          'status': 'In Progress',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-25',
          'qty': 5,
          'deliveryMethod': 'On air \$50',
        },
        {
          'id': '2',
          'productName': 'Gaming Console',
          'size': 'Standard',
          'price': '\$499',
          'status': 'Delivered',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-20',
          'qty': 12,
          'deliveryMethod': 'Free Delivery',
        },
        {
          'id': '3',
          'productName': 'Smart Phone',
          'size': '128GB',
          'price': '\$899',
          'status': 'Delivered',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-15',
          'qty': 13,
          'deliveryMethod': 'Free Delivery',
        },
        {
          'id': '4',
          'productName': 'Laptop',
          'size': '16GB RAM',
          'price': '\$1,299',
          'status': 'Cancel',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-10',
          'qty': 75,
          'deliveryMethod': 'On air \$50',
        },
        {
          'id': '5',
          'productName': 'Headphones',
          'size': 'Universal',
          'price': '\$199',
          'status': 'In Progress',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-28', 'qty': 5,
          'deliveryMethod': 'On air \$50',
        },
        {
          'id': '6',
          'productName': 'Tablet',
          'size': '64GB',
          'price': '\$399',
          'status': 'Delivered',
          'image': AppImages.watchPic,
          'orderDate': '2024-08-22',
          'qty': 8,
          'deliveryMethod': 'Free Delivery',
        },
      ];

      isLoading.value = false;
    });
  }

  void onCategorySelected(int index) {
    orderSelected.value = index;
  }

  // ✅ Filtering based on selected category
  List<Map<String, dynamic>> getFilteredOrders() {
    final selected = myOrder[orderSelected.value]['status'];
    if (selected == 'All') {
      return allOrders;
    }
    return allOrders.where((order) => order['status'] == selected).toList();
  }

  // ✅ Count orders per category
  int getOrdersCount(String status) {
    if (status == 'All') return allOrders.length;
    return allOrders.where((order) => order['status'] == status).length;
  }
}
