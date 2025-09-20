import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiveAwayController extends GetxController {
  // Text controllers
  final TextEditingController titleController = TextEditingController();

  // Selected values for dropdowns
  var selectedGiveAwayType = Rxn<String>();
  var selectedAttachedAuction = Rxn<String>();

  // Dropdown lists
  var giveAwayTypeList = <DropdownMenuItem<String>>[].obs;
  var attachedAuctionList = <DropdownMenuItem<String>>[].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize dropdown data
    loadGiveAwayTypes();
    loadAttachedAuctions();
  }

  // Method to update give away type selection
  void updateGiveAwayType(String? value) {
    selectedGiveAwayType.value = value;
  }

  // Method to update attached auction selection
  void updateAttachedAuction(String? value) {
    selectedAttachedAuction.value = value;
  }

  // Load give away types
  void loadGiveAwayTypes() {
    List<String> types = [
      'Most shared stream',
      'Most Purchases',


    ];

    giveAwayTypeList.value = types.map((type) {
      return DropdownMenuItem<String>(
        value: type.toLowerCase().replaceAll(' ', '_'),
        child: Text(type),
      );
    }).toList();
  }

  // Load attached auctions
  void loadAttachedAuctions() {
    List<String> auctions = [
      'Auction 1 - Electronics',
      'Auction 2 - Fashion',
      'Auction 3 - Home & Garden',
      'Auction 4 - Sports',
      'Auction 5 - Books',
    ];

    attachedAuctionList.value = auctions.map((auction) {
      return DropdownMenuItem<String>(
        value: auction.toLowerCase().replaceAll(' ', '_').replaceAll('-', ''),
        child: Text(auction),
      );
    }).toList();
  }

  // Method to reset all selections
  void resetAllSelections() {
    selectedGiveAwayType.value = null;
    selectedAttachedAuction.value = null;
    titleController.clear();
  }

  // Method to validate form
  bool validateForm() {
    return titleController.text.trim().isNotEmpty &&
        selectedGiveAwayType.value != null &&
        selectedAttachedAuction.value != null;
  }

  // Method to get form data
  Map<String, String?> getFormData() {
    return {
      'title': titleController.text.trim(),
      'giveAwayType': selectedGiveAwayType.value,
      'attachedAuction': selectedAttachedAuction.value,
    };
  }

  // Method to submit form (placeholder for API call)
  Future<bool> submitGiveAway() async {
    isLoading.value = true;
    try {

      await Future.delayed(Duration(seconds: 2));


      final formData = getFormData();
      print('Submitting give away: $formData');


      resetAllSelections();

      isLoading.value = false;


      return true;
    } catch (e) {
      isLoading.value = false;

      return false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}