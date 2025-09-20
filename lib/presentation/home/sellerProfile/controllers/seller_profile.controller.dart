import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

class SellerProfileController extends GetxController {
  RxInt selectedTabIndex = 0.obs;

  // Tab data
  List<Map<String, dynamic>> tabData = [
    {'buttonName': 'Products'},
    {'buttonName': 'Shows'},
    {'buttonName': 'Reviews'},
    {'buttonName': 'Past Shows'},
  ];

  // All items data
  var allItems = <Map<String, dynamic>>[];
  var filteredItems = <Map<String, dynamic>>[].obs;

  // Review data
  var reviewsData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialItems();
    loadReviewsData();
    _filterByTab(0); // Initialize with Products tab
  }

  void loadInitialItems() {
    allItems = [
      // Products (no live count, no special text)
      {
        'imageUrl': AppImages.product1,
        'title': 'Best Electronics 2025,Start with Free Delivery',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'product', // product, show, review, pastShow
        'hasText': false,
        'hasLiveCount': false,

      }, {
        'imageUrl': AppImages.product1,
        'title': 'Best Electronics 2025,Start with Free Delivery',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'pastShow', // product, show, review, pastShow
        'hasText': false,
        'hasLiveCount': false,
        'isPatOrPresentActive': true,
        'pastOrPresentDate': '1 Hour latter',
      }, {
        'imageUrl': AppImages.product1,
        'title': 'Best Electronics 2025,Start with Free Delivery',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'pastShow', // product, show, review, pastShow
        'hasText': false,
        'hasLiveCount': false,
        'isPatOrPresentActive': true,
        'pastOrPresentDate': '2 days ago',
      },
      {
        'imageUrl': AppImages.product2,
        'title': 'Smart Home Electronics Bundle',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'product',
        'hasText': false,
        'hasLiveCount': false,
      },

      // Shows (has both live count and text)
      {
        'imageUrl': AppImages.product3,
        'title': 'Live Gaming Console Showcase',
        'isLive': true,
        'viewerCount': 234,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'show',
        'hasText': true,
        'hasLiveCount': true,
        'showText': 'Live Now',
      },
      {
        'imageUrl': AppImages.product4,
        'title': 'Tech Review & Demo Session',
        'isLive': true,
        'viewerCount': 156,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'show',
        'hasText': true,
        'hasLiveCount': true,
        'showText': 'Live Now',
      },

      // Past Shows (has text but no live count)
      {
        'imageUrl': AppImages.product1,
        'title': 'Electronics Launch Event',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'pastShow',
        'hasText': true,
        'hasLiveCount': false,
        'showText': '2 days ago',
        'isPatOrPresentActive': true,
        'pastOrPresentDate': '2 days ago',
      },
      {
        'imageUrl': AppImages.product2,
        'title': 'Product Demo Session',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'pastShow',
        'hasText': true,
        'hasLiveCount': false,
        'showText': '1 week ago',
        'isPatOrPresentActive': true,
        'pastOrPresentDate': '2 days ago',
      },

      // More products
      {
        'imageUrl': AppImages.product3,
        'title': 'Premium Headphones Collection',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'product',
        'hasText': false,
        'hasLiveCount': false,
      },
      {
        'imageUrl': AppImages.product4,
        'title': 'Wireless Speaker Set',
        'isLive': false,
        'viewerCount': 0,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'type': 'product',
        'hasText': false,
        'hasLiveCount': false,
      },
    ];

    filteredItems.value = List.from(allItems);
  }

  void loadReviewsData() {
    reviewsData.value = [
      {
        'userName': 'Sarah Johnson',
        'userImage': AppImages.productOwner,
        'rating': 5.0,
        'date': '2 days ago',
        'reviewText': 'Amazing quality and fast shipping! The product exceeded my expectations.',
        'expandedText': 'The attention to detail is incredible and the customer service was outstanding. I will definitely be ordering again soon. Highly recommend this seller to anyone looking for quality products.',
      },
      {
        'userName': 'Michael Chen',
        'userImage': AppImages.productOwner,
        'rating': 4.5,
        'date': '1 week ago',
        'reviewText': 'Great seller with excellent communication. Product arrived exactly as described.',
        'expandedText': 'The packaging was secure and the item quality is top-notch. Delivery was prompt and the seller was very responsive to my questions. Would definitely purchase from this seller again.',
      },
      {
        'userName': 'Emma Rodriguez',
        'userImage': AppImages.productOwner,
        'rating': 5.0,
        'date': '2 weeks ago',
        'reviewText': 'Absolutely love my purchase! Beautiful craftsmanship and arrived quickly.',
        'expandedText': null, // No expanded text for this review
      },
      {
        'userName': 'David Kumar',
        'userImage': AppImages.productOwner,
        'rating': 4.0,
        'date': '3 weeks ago',
        'reviewText': 'Good quality product, though shipping took a bit longer than expected.',
        'expandedText': 'Overall satisfied with the purchase. The item matches the description perfectly and the seller was helpful when I had questions. Minor issue with delivery timing but the product quality makes up for it.',
      },
      {
        'userName': 'Lisa Thompson',
        'userImage': AppImages.productOwner,
        'rating': 5.0,
        'date': '1 month ago',
        'reviewText': 'Fantastic experience! The seller is very professional and the product quality is outstanding.',
        'expandedText': 'From order to delivery, everything was smooth. The item was well-packaged and exactly what I was looking for. The seller even followed up to ensure I was satisfied. Excellent service all around!',
      },
      {
        'userName': 'Alex Wilson',
        'userImage': AppImages.productOwner,
        'rating': 4.5,
        'date': '1 month ago',
        'reviewText': 'Very happy with this purchase. Great value for money and reliable seller.',
        'expandedText': 'The product arrived in perfect condition and works exactly as advertised. Seller communicated well throughout the process and was very accommodating with my special requests.',
      },
    ];
  }

  void onTabSelected(int index) {
    selectedTabIndex.value = index;
    _filterByTab(index);
  }

  void _filterByTab(int tabIndex) {
    switch (tabIndex) {
      case 0: // Products
        filteredItems.value = allItems.where((item) => item['type'] == 'product').toList();
        break;
      case 1: // Shows
        filteredItems.value = allItems.where((item) => item['type'] == 'show').toList();
        break;
      case 2: // Reviews
      // Reviews are handled separately in reviewsData
        filteredItems.value = [];
        break;
      case 3: // Past Shows
        filteredItems.value = allItems.where((item) => item['type'] == 'pastShow').toList();
        break;
      default:
        filteredItems.value = List.from(allItems);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}