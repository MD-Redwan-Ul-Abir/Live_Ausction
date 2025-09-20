import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

class HomeController extends GetxController {
  var items = <Map<String, dynamic>>[].obs;
  var filteredItems = <Map<String, dynamic>>[].obs;
  var allItems = <Map<String, dynamic>>[];
  RxBool showLoadMoreIcon = false.obs;
  RxBool isScrolling = false.obs;
  RxBool isAtBottom = false.obs;

  RxInt selectedTypeButtonIndex = 0.obs;
  RxInt selectedFilterButtonIndex = 0.obs;

  RxString searchQuery = ''.obs;
  RxBool isSearching = false.obs;
  RxBool searchFieldSelected = false.obs;


  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Scroll controller for automatic loading
  final ScrollController scrollController = ScrollController();

  // Debounce timer for search
  Timer? _debounceTimer;
  
  // Timer for scroll detection
  Timer? _scrollTimer;

  List<Map<String, dynamic>> buttonData = [
    {'buttonName': 'For You'},
    {'buttonName': 'Electronics'},
    {'buttonName': 'Kids'},
    {'buttonName': 'Video Games'},
  ];
  List<Map<String, dynamic>> filterButtonData = [
    {'buttonName': 'Top Sellers'},
    {'buttonName': 'New Products'},
    {'buttonName': 'Low price'},
    {'buttonName': 'High Price'},

  ];

  // Loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialItems();
    _setupScrollListener();
    _setupLoadMoreLogic();


    searchFocusNode.addListener(_onSearchFocusChanged);

    searchQuery.listen((query) {
      _performSearch(query);
    });
  }

  void _onSearchFocusChanged() {
    if (searchFocusNode.hasFocus) {
      onSearchFieldSelected();
    } else {

      onSearchFieldDeselected();
    }
  }

  void onSearchFieldSelected() {
    searchFieldSelected.value=true;
  }

  void onSearchFieldDeselected(){
    searchFieldSelected.value = false;
  }

  // @override
  // void onClose() {
  //   searchController.dispose();
  //   searchFocusNode.removeListener(_onSearchFocusChanged); // Don't forget this
  //   searchFocusNode.dispose();
  //   scrollController.dispose();
  //   _debounceTimer?.cancel();
  //   _scrollTimer?.cancel();
  //   super.onClose();
  // }
  void _setupScrollListener() {
    scrollController.addListener(() {
      // Detect if user is scrolling
      isScrolling.value = true;
      
      // Cancel previous timer and set new one
      _scrollTimer?.cancel();
      _scrollTimer = Timer(const Duration(milliseconds: 150), () {
        isScrolling.value = false;
      });

      // Check if user is at bottom
      if (scrollController.position.pixels >= 
          scrollController.position.maxScrollExtent - 50) {
        isAtBottom.value = true;
        // Load more when user is 50 pixels from bottom
        if (!isLoading.value) {
          loadMoreItems();
        }
      } else {
        isAtBottom.value = false;
      }
    });
  }

  void _setupLoadMoreLogic() {
    // Initially show load more icon (when app starts with 4 items)
    Future.delayed(const Duration(milliseconds: 500), () {
      showLoadMoreIcon.value = true;
    });
    
    // Listen to scroll state and loading state changes
    ever(isScrolling, (scrolling) {
      _updateLoadMoreIconVisibility();
    });
    
    ever(isLoading, (loading) {
      _updateLoadMoreIconVisibility();
    });
    
    ever(isAtBottom, (atBottom) {
      _updateLoadMoreIconVisibility();
    });
  }

  void _updateLoadMoreIconVisibility() {
    if (isScrolling.value) {
      // Hide while scrolling
      showLoadMoreIcon.value = false;
    } else if (isAtBottom.value) {
      // Show when at bottom and not scrolling
      showLoadMoreIcon.value = true;
    } else if (items.length <= 4) {
      // Show initially when only 4 items
      showLoadMoreIcon.value = true;
    } else {
      // Hide in other cases
      showLoadMoreIcon.value = false;
    }
  }

  void loadInitialItems() {
    allItems = [
      {
        'imageUrl': AppImages.product1,
        'title': 'Best Electronics 2025,Start with Free Delivery',
        'isLive': true,
        'viewerCount': 34,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'category': 'Electronics',
        'keywords': ['electronics', 'delivery', 'free', 'best', '2025'],
      },
      {
        'imageUrl': AppImages.product2,
        'title': 'Gaming Console Bundle - Latest Generation',
        'isLive': true,
        'viewerCount': 64,
        'shopName': 'GameHub Store',
        'ownerPic': AppImages.productOwner,
        'category': 'Video Games',
        'keywords': ['gaming', 'console', 'bundle', 'video', 'games'],
      },
      {
        'imageUrl': AppImages.product3,
        'title': 'Kids Educational Toys - Learning Made Fun',
        'isLive': true,
        'viewerCount': 19,
        'shopName': 'Kids Paradise',
        'ownerPic': AppImages.productOwner,
        'category': 'Kids',
        'keywords': ['kids', 'educational', 'toys', 'learning', 'fun'],
      },
      {
        'imageUrl': AppImages.product4,
        'title': 'Smart Home Electronics Bundle',
        'isLive': false,
        'viewerCount': 64,
        'shopName': 'Tech Haven',
        'ownerPic': AppImages.productOwner,
        'category': 'Electronics',
        'keywords': ['smart', 'home', 'electronics', 'bundle', 'tech'],
      },{
        'imageUrl': AppImages.product1,
        'title': 'Best Electronics 2025,Start with Free Delivery',
        'isLive': true,
        'viewerCount': 34,
        'shopName': 'Jirah Shop',
        'ownerPic': AppImages.productOwner,
        'category': 'Electronics',
        'keywords': ['electronics', 'delivery', 'free', 'best', '2025'],
      },
      {
        'imageUrl': AppImages.product2,
        'title': 'Gaming Console Bundle - Latest Generation',
        'isLive': true,
        'viewerCount': 64,
        'shopName': 'GameHub Store',
        'ownerPic': AppImages.productOwner,
        'category': 'Video Games',
        'keywords': ['gaming', 'console', 'bundle', 'video', 'games'],
      },
      {
        'imageUrl': AppImages.product3,
        'title': 'Kids Educational Toys - Learning Made Fun',
        'isLive': true,
        'viewerCount': 19,
        'shopName': 'Kids Paradise',
        'ownerPic': AppImages.productOwner,
        'category': 'Kids',
        'keywords': ['kids', 'educational', 'toys', 'learning', 'fun'],
      },
      {
        'imageUrl': AppImages.product4,
        'title': 'Smart Home Electronics Bundle',
        'isLive': false,
        'viewerCount': 64,
        'shopName': 'Tech Haven',
        'ownerPic': AppImages.productOwner,
        'category': 'Electronics',
        'keywords': ['smart', 'home', 'electronics', 'bundle', 'tech'],
      },
    ];

    items.value = List.from(allItems);
    filteredItems.value = List.from(allItems);
  }

  void onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Set new timer with debounce
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      searchQuery.value = query.trim();
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {

      _filterByCategory(selectedTypeButtonIndex.value);
      isSearching.value = false;
      return;
    }

    isSearching.value = true;

    final searchResults = allItems.where((item) {
      final title = item['title'].toString().toLowerCase();
      final shopName = item['shopName'].toString().toLowerCase();
      final category = item['category'].toString().toLowerCase();
      final keywords = List<String>.from(item['keywords'] ?? []);

      final searchTerm = query.toLowerCase();

      return title.contains(searchTerm) ||
          shopName.contains(searchTerm) ||
          category.contains(searchTerm) ||
          keywords.any((keyword) => keyword.toLowerCase().contains(searchTerm));
    }).toList();


    if (selectedTypeButtonIndex.value != 0) {
      final selectedCategory = buttonData[selectedTypeButtonIndex.value]['buttonName'];
      final categoryFilteredResults = searchResults.where((item) {
        return item['category'] == selectedCategory;
      }).toList();
      filteredItems.value = categoryFilteredResults;
    } else {
      filteredItems.value = searchResults;
    }

    items.value = List.from(filteredItems);
    isSearching.value = false;
  }

  void onFilterButtonSelect(int index){
    selectedFilterButtonIndex.value=index;
  }


  void onCategorySelected(int index) {
    selectedTypeButtonIndex.value = index;

    if (searchQuery.value.isNotEmpty) {

      _performSearch(searchQuery.value);
    } else {

      _filterByCategory(index);
    }
  }

  void _filterByCategory(int categoryIndex) {
    if (categoryIndex == 0) {

      items.value = List.from(allItems);
    } else {
      final selectedCategory = buttonData[categoryIndex]['buttonName'];
      final categoryItems = allItems.where((item) {
        return item['category'] == selectedCategory;
      }).toList();
      items.value = categoryItems;
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterByCategory(selectedTypeButtonIndex.value);
  }

  void onSearchSubmitted(String query) {
    // Handle search submission (e.g., analytics, recent searches)
    print('Search submitted: $query');

    // Optional: Add to recent searches
    _addToRecentSearches(query);
  }

  void _addToRecentSearches(String query) {

  }

  void loadMoreItems() {
    if (isLoading.value) return;

    isLoading.value = true;
    showLoadMoreIcon.value = false; // Hide immediately when loading starts

    Future.delayed(const Duration(milliseconds: 800), () {
      final newItems = [
        {
          'imageUrl': AppImages.product1,
          'title': 'New Electronics Arrival - Limited Edition',
          'isLive': true,
          'viewerCount': 45,
          'shopName': 'Tech World',
          'ownerPic': AppImages.productOwner,
          'category': 'Electronics',
          'keywords': ['electronics', 'new', 'limited', 'edition'],
        },
        {
          'imageUrl': AppImages.product2,
          'title': 'Kids Learning Tablet - Educational Fun',
          'isLive': true,
          'viewerCount': 32,
          'shopName': 'Smart Kids',
          'ownerPic': AppImages.productOwner,
          'category': 'Kids',
          'keywords': ['kids', 'learning', 'tablet', 'educational'],
        },
      ];

      allItems.addAll(newItems);

      // Update current view based on search/filter state
      if (searchQuery.value.isNotEmpty) {
        _performSearch(searchQuery.value);
      } else {
        _filterByCategory(selectedTypeButtonIndex.value);
      }

      isLoading.value = false;
      // Don't show the icon after loading - it will only show when user scrolls to bottom again
    });
  }

}