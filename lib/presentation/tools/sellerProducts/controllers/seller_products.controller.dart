import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

import '../../../../infrastructure/navigation/routes.dart';

class SellerProductsController extends GetxController {
  var orderButtonData = <Map<String, dynamic>>[].obs;

  // Search related properties
  var products = <Map<String, dynamic>>[].obs;
  var filteredProducts = <Map<String, dynamic>>[].obs;
  var allProducts = <Map<String, dynamic>>[];

  RxString searchQuery = ''.obs;
  RxBool isSearching = false.obs;
  RxBool searchFieldSelected = false.obs;
  RxInt selectedOrderButton = 0.obs;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Debounce timer for search
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    loadInitialProducts();
    _updateButtonCounts();
    
    searchFocusNode.addListener(_onSearchFocusChanged);
    searchQuery.listen((query) {
      _performSearch(query);
    });
  }
  ///================================for editing image screen======================
  var title = ''.obs;
  var category = 'Everyday Electronics'.obs;
  var subcategory = 'Phone'.obs;
  var description = ''.obs;
  var stockAvailable = 24.obs;
  var salesFormat = 'Auction'.obs;
  var startingBid = 1.0.obs;
  var buyNowPrice = 143.0.obs;
  var selectedColor = 'Green'.obs;
  var selectedSize = 'XL'.obs;

  // Dropdown options
  final List<String> categories = ['Everyday Electronics', 'Fashion', 'Home'];
  final List<String> subcategories = ['Phone', 'Laptop', 'Tablet'];
  final List<String> colors = ['Green', 'Red', 'Blue', 'Black', 'White'];
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  
  // Current editing product
  var currentEditingProductId = ''.obs;
  
  // Methods for editing functionality
  void updateTitle(String value) => title.value = value;
  void updateCategory(String value) => category.value = value;
  void updateSubcategory(String value) => subcategory.value = value;
  void updateDescription(String value) => description.value = value;
  void updateColor(String value) => selectedColor.value = value;
  void updateSize(String value) => selectedSize.value = value;
  
  void incrementStock() => stockAvailable.value++;
  void decrementStock() {
    if (stockAvailable.value > 0) stockAvailable.value--;
  }
  
  void updateStartingBid(double value) => startingBid.value = value;
  void updateBuyNowPrice(double value) => buyNowPrice.value = value;
  
  // Load product data for editing
  void loadProductForEditing(String productId) {
    currentEditingProductId.value = productId;
    final product = allProducts.firstWhere((p) => p['id'] == productId);
    
    title.value = product['productName'] ?? '';
    description.value = product['description'] ?? '';
    stockAvailable.value = product['stock'] ?? 1;
    
    // Map product category to available dropdown options
    String productCategory = product['category'] ?? '';
    String mappedCategory = _mapCategoryToDropdown(productCategory);
    category.value = mappedCategory;
    
    selectedColor.value = 'Green'; // Default or from product
    selectedSize.value = 'XL'; // Default or from product
    
    // Parse price if available
    final priceString = product['price'] ?? '\$0';
    final priceValue = double.tryParse(priceString.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
    startingBid.value = priceValue * 0.8; // Example: 80% of current price
    buyNowPrice.value = priceValue;
  }
  
  // Map product categories to available dropdown categories
  String _mapCategoryToDropdown(String productCategory) {
    switch (productCategory.toLowerCase()) {
      case 'watches':
      case 'electronics':
        return 'Everyday Electronics';
      case 'fashion':
      case 'clothing':
        return 'Fashion';
      case 'home':
      case 'furniture':
        return 'Home';
      case 'kids':
        return 'Fashion'; // Map kids to Fashion as fallback
      case 'video games':
        return 'Everyday Electronics'; // Map video games to Electronics
      default:
        return 'Everyday Electronics'; // Default fallback
    }
  }
  
  // Save edited product
  void saveEditedProduct() {
    if (currentEditingProductId.value.isEmpty) return;
    
    final productIndex = allProducts.indexWhere((p) => p['id'] == currentEditingProductId.value);
    if (productIndex != -1) {
      allProducts[productIndex]['productName'] = title.value;
      allProducts[productIndex]['description'] = description.value;
      allProducts[productIndex]['stock'] = stockAvailable.value;
      allProducts[productIndex]['category'] = category.value;
      allProducts[productIndex]['price'] = '\$${buyNowPrice.value.toStringAsFixed(0)}';
      
      // Update reactive lists
      products.value = List.from(allProducts);
      filteredProducts.value = List.from(allProducts);
      _updateButtonCounts();

      Get.toNamed(Routes.EDIT_PRODUCT2);
    }
  }
  ///---------------------------------------------------------------------------

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.removeListener(_onSearchFocusChanged);
    searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _onSearchFocusChanged() {
    if (searchFocusNode.hasFocus) {
      onSearchFieldSelected();
    } else {
      onSearchFieldDeselected();
    }
  }

  void onSearchFieldSelected() {
    searchFieldSelected.value = true;
  }

  void onSearchFieldDeselected() {
    searchFieldSelected.value = false;
  }

  void loadInitialProducts() {
    allProducts = [
      {
        'id': '1',
        'productName': 'Vintage Rolex Submariner',
        'price': '\$5,200',
        'status': 'Active',
        'dateAdded': '2024-01-15',
        'category': 'Watches',
        'description': 'Authentic vintage Rolex Submariner in excellent condition',
        'imageUrl': AppImages.watchPic,
        'stock': 1,
        'keywords': ['rolex', 'watch', 'vintage', 'submariner', 'luxury'],
      },
      {
        'id': '2',
        'productName': 'Gaming Laptop RTX 4070',
        'price': '\$1,899',
        'status': 'Active',
        'dateAdded': '2024-01-20',
        'category': 'Electronics',
        'description': 'High-performance gaming laptop with RTX 4070',
        'imageUrl': AppImages.product1,
        'stock': 5,
        'keywords': ['laptop', 'gaming', 'rtx', 'electronics', 'computer'],
      },
      {
        'id': '3',
        'productName': 'Educational Kids Tablet',
        'price': '\$299',
        'status': 'Inactive',
        'dateAdded': '2024-01-18',
        'category': 'Kids',
        'description': 'Interactive learning tablet for children',
        'imageUrl': AppImages.product2,
        'stock': 0,
        'keywords': ['kids', 'tablet', 'educational', 'learning', 'children'],
      },
      {
        'id': '4',
        'productName': 'Smartphone Pro Max',
        'price': '\$999',
        'status': 'Pending',
        'dateAdded': '2024-01-22',
        'category': 'Electronics',
        'description': 'Latest smartphone with advanced features',
        'imageUrl': AppImages.product3,
        'stock': 3,
        'keywords': ['smartphone', 'phone', 'mobile', 'electronics', 'pro'],
      },
      {
        'id': '5',
        'productName': 'Wireless Headphones',
        'price': '\$199',
        'status': 'Active',
        'dateAdded': '2024-01-25',
        'category': 'Electronics',
        'description': 'Premium wireless headphones with noise cancelling',
        'imageUrl': AppImages.product4,
        'stock': 10,
        'keywords': ['headphones', 'wireless', 'audio', 'music', 'electronics'],
      },
      {
        'id': '6',
        'productName': 'Designer Watch Collection',
        'price': '\$850',
        'status': 'out of stock',
        'dateAdded': '2024-01-10',
        'category': 'Watches',
        'description': 'Luxury designer watch with premium materials',
        'imageUrl': AppImages.watchPic,
        'stock': 0,
        'keywords': ['watch', 'designer', 'luxury', 'collection', 'premium'],
      },
      // Adding more sample data to make realistic counts
      {
        'id': '7',
        'productName': 'Smart Watch Series 9',
        'price': '\$399',
        'status': 'Active',
        'dateAdded': '2024-01-28',
        'category': 'Electronics',
        'description': 'Latest smart watch with health monitoring',
        'imageUrl': AppImages.watchPic,
        'stock': 8,
        'keywords': ['smartwatch', 'health', 'fitness', 'electronics', 'wearable'],
      },
      {
        'id': '8',
        'productName': 'Bluetooth Speaker',
        'price': '\$79',
        'status': 'Inactive',
        'dateAdded': '2024-01-30',
        'category': 'Electronics',
        'description': 'Portable Bluetooth speaker with great sound',
        'imageUrl': AppImages.product4,
        'stock': 0,
        'keywords': ['speaker', 'bluetooth', 'portable', 'music', 'audio'],
      },
    ];

    products.value = List.from(allProducts);
    filteredProducts.value = List.from(allProducts);
  }

  void _updateButtonCounts() {
    final activeCount = allProducts.where((p) => p['status'] == 'Active').length;
    final inactiveCount = allProducts.where((p) => p['status'] == 'Inactive').length;
    final pendingCount = allProducts.where((p) => p['status'] == 'Pending').length;
    final outOfStockCount = allProducts.where((p) => p['status'] == 'out of stock').length;

    orderButtonData.value = [
      {'buttonName': 'Active($activeCount)'},
      {'buttonName': 'Inactive($inactiveCount)'},
      {'buttonName': 'Pending($pendingCount)'},
      {'buttonName': 'Out of stock($outOfStockCount)'},
    ];
  }

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      searchQuery.value = query.trim();
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _filterByCategory(selectedOrderButton.value);
      isSearching.value = false;
      return;
    }

    isSearching.value = true;

    final searchResults = allProducts.where((product) {
      final productName = product['productName'].toString().toLowerCase();
      final description = product['description'].toString().toLowerCase();
      final category = product['category'].toString().toLowerCase();
      final status = product['status'].toString().toLowerCase();
      final keywords = List<String>.from(product['keywords'] ?? []);

      final searchTerm = query.toLowerCase();

      return productName.contains(searchTerm) ||
          description.contains(searchTerm) ||
          category.contains(searchTerm) ||
          status.contains(searchTerm) ||
          keywords.any((keyword) => keyword.toLowerCase().contains(searchTerm));
    }).toList();

    if (selectedOrderButton.value != 0) {
      final selectedStatus = _getStatusFromIndex(selectedOrderButton.value);
      final categoryFilteredResults = searchResults.where((product) {
        return product['status'].toString().toLowerCase() == selectedStatus.toLowerCase();
      }).toList();
      filteredProducts.value = categoryFilteredResults;
    } else {
      filteredProducts.value = searchResults;
    }

    products.value = List.from(filteredProducts);
    isSearching.value = false;
  }

  String _getStatusFromIndex(int index) {
    switch (index) {
      case 1:
        return 'Inactive';
      case 2:
        return 'Pending';
      case 3:
        return 'out of stock';
      default:
        return 'Active';
    }
  }

  void onCategorySelected(int index) {
    selectedOrderButton.value = index;

    if (searchQuery.value.isNotEmpty) {
      _performSearch(searchQuery.value);
    } else {
      _filterByCategory(index);
    }
  }

  void _filterByCategory(int categoryIndex) {
    if (categoryIndex == 0) {
      products.value = List.from(allProducts);
    } else {
      final selectedStatus = _getStatusFromIndex(categoryIndex);
      final categoryProducts = allProducts.where((product) {
        return product['status'].toString().toLowerCase() == selectedStatus.toLowerCase();
      }).toList();
      products.value = categoryProducts;
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterByCategory(selectedOrderButton.value);
  }

  void onSearchSubmitted(String query) {
    // Handle search submission logic here
  }

  // Method to add new products and update counts
  void addProduct(Map<String, dynamic> newProduct) {
    allProducts.add(newProduct);
    products.value = List.from(allProducts);
    filteredProducts.value = List.from(allProducts);
    _updateButtonCounts();
  }

  // Method to remove product and update counts
  void removeProduct(String productId) {
    allProducts.removeWhere((product) => product['id'] == productId);
    products.value = List.from(allProducts);
    filteredProducts.value = List.from(allProducts);
    _updateButtonCounts();
  }

  // Method to update product status and counts
  void updateProductStatus(String productId, String newStatus) {
    final productIndex = allProducts.indexWhere((product) => product['id'] == productId);
    if (productIndex != -1) {
      allProducts[productIndex]['status'] = newStatus;
      products.value = List.from(allProducts);
      filteredProducts.value = List.from(allProducts);
      _updateButtonCounts();
    }
  }
}
