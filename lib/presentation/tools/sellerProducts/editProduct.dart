import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_auction_marketplace/presentation/shared/widgets/buttons/primary_buttons.dart';
import 'package:live_auction_marketplace/presentation/tools/sellerProducts/controllers/seller_products.controller.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';
import '../../commonWidgets/customTextFormFieldTwo.dart';
import '../../shared/widgets/appbar/custom_appbar.dart';
import '../../shared/widgets/imagePicker/custom_image_picker.dart';
import '../../shared/widgets/imagePicker/imagePickerController.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final imagePickerController imageController = Get.put(
    imagePickerController(),
  );
  final SellerProductsController controller =
      Get.find<SellerProductsController>();

  // Text controllers for price fields
  late TextEditingController startingBidController;
  late TextEditingController buyNowController;
  
  // Worker subscriptions for cleanup
  late Worker startingBidWorker;
  late Worker buyNowWorker;

  List<DropdownMenuItem<String>> get categoryItems => controller.categories
      .map(
        (category) => DropdownMenuItem(value: category, child: Text(category)),
      )
      .toList();

  List<DropdownMenuItem<String>> get subcategoryItems => controller
      .subcategories
      .map(
        (subcategory) =>
            DropdownMenuItem(value: subcategory, child: Text(subcategory)),
      )
      .toList();

  List<DropdownMenuItem<String>> get colorItems => controller.colors
      .map((color) => DropdownMenuItem(value: color, child: Text(color)))
      .toList();

  List<DropdownMenuItem<String>> get sizeItems => controller.sizes
      .map((size) => DropdownMenuItem(value: size, child: Text(size)))
      .toList();

  @override
  void initState() {
    super.initState();

    // Initialize text controllers first
    startingBidController = TextEditingController();
    buyNowController = TextEditingController();

    // Get productId from arguments if available
    final productId = Get.arguments as String?;
    if (productId != null && productId.isNotEmpty) {
      controller.loadProductForEditing(productId);
    }

    // Set initial values after loading product data
    startingBidController.text = controller.startingBid.value.toStringAsFixed(2);
    buyNowController.text = controller.buyNowPrice.value.toStringAsFixed(2);

    // Listen to controller changes and update text controllers
    startingBidWorker = ever(controller.startingBid, (value) {
      if (!mounted) return; // Check if widget is still mounted
      startingBidController.text = value.toStringAsFixed(2);
    });
    buyNowWorker = ever(controller.buyNowPrice, (value) {
      if (!mounted) return; // Check if widget is still mounted
      buyNowController.text = value.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {

    startingBidWorker.dispose();
    buyNowWorker.dispose();
    

    startingBidController.dispose();
    buyNowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Edit Products', centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create a Product',
                    style: AppTextStyles.H6_Medium.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Detailed product listing show up better in searches. \nMore visibility means more buyers.',
                    style: AppTextStyles.buttonRegular.copyWith(
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Obx(() => _buildImageGrid(imageController, context)),

                Obx(() {
                  int totalImages = imageController.selectedImages.length;
                  // Add existing image count if editing
                  if (controller.currentEditingProductId.value.isNotEmpty) {
                    try {
                      final product = controller.allProducts.firstWhere(
                        (p) =>
                            p['id'] == controller.currentEditingProductId.value,
                      );
                      if (product['imageUrl'] != null) {
                        totalImages += 1;
                      }
                    } catch (e) {
                      // Product not found
                    }
                  }

                  return Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Photo : $totalImages/8 Maximum',
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.neutral200,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Product Details',
                    style: AppTextStyles.paragraph_1_Regular.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Product Title
                CustomTextFormFieldTwo(
                  hintText: 'Enter product title',
                  labelText: 'Title*',
                  controller: TextEditingController(text: controller.title.value),
                  onChanged: (value) => controller.updateTitle(value ?? ''),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product title is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Title must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Category Dropdown
                Obx(
                  () => CustomTextFormFieldTwo(
                    hintText: 'Select category',
                    labelText: 'Category*',
                    dropDownItems: categoryItems,
                    selectedValue: controller.category.value,
                    onChanged: (value) {
                      controller.updateCategory(value ?? '');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // Subcategory Dropdown
                Obx(
                  () => CustomTextFormFieldTwo(
                    hintText: 'Select subcategory',
                    labelText: 'Subcategory*',
                    dropDownItems: subcategoryItems,
                    selectedValue: controller.subcategory.value,
                    onChanged: (value) {
                      controller.updateSubcategory(value ?? '');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a subcategory';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                // Description
                CustomTextFormFieldTwo(
                  hintText: 'Description',

                  keyboardType: 'multiline',
                  controller: TextEditingController(
                    text: controller.description.value,
                  ),
                  onChanged: (value) => controller.updateDescription(value ?? ''),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product description is required';
                    }
                    if (value.trim().length < 20) {
                      return 'Description must be at least 20 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 17.5.h),

                // Stock Available with increment/decrement
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Stock Available*',
                        style: AppTextStyles.paragraph_2_Regular.copyWith(
                          color: AppColors.neutral200,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.decrementStock,
                      child: Container(
                        height: 24.w,
                        width: 24.w,
                        decoration: BoxDecoration(
                          color: AppColors.neutral800,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: AppColors.neutral50,
                          size: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Obx(
                          () => GestureDetector(
                        onTap: () => _showStockInputDialog(context),
                        child: Container(
                          height: 24.w,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: AppColors.neutral800,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: Text(
                              '${controller.stockAvailable.value}',
                              style: AppTextStyles.buttonRegular.copyWith(
                                color: AppColors.neutral50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: controller.incrementStock,
                      child: Container(
                        height: 24.w,
                        width: 24.w,
                        decoration: BoxDecoration(
                          color: AppColors.neutral800,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.neutral50,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),




                SizedBox(height: 24.h),
                // Starting Bid
                CustomTextFormFieldTwo(
                  hintText: 'Starting Bid*',
                  labelText: 'Starting Bid*',
                  controller: startingBidController,
                  keyboardType: 'number',
                  onChanged: (value) {
                    final price = double.tryParse(value ?? '0') ?? 0.0;
                    controller.updateStartingBid(price);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Starting bid is required';
                    }
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Buy it Now Price
                CustomTextFormFieldTwo(
                  hintText: 'Buy it Now',
                  labelText: 'Buy it Now',
                  controller: buyNowController,
                  keyboardType: 'number',
                  onChanged: (value) {
                    final price = double.tryParse(value ?? '0') ?? 0.0;
                    controller.updateBuyNowPrice(price);
                  },
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'Please enter a valid price';
                      }
                      final startingBid =
                          double.tryParse(startingBidController.text) ?? 0;
                      if (price <= startingBid) {
                        return 'Buy now price must be higher than starting bid';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                Obx(
                  () => CustomTextFormFieldTwo(
                    hintText: 'Select color',

                    dropdownAlignment: Alignment.topLeft,
                    labelText: 'Color*',
                    dropDownItems: colorItems,
                    selectedValue: controller.selectedColor.value,
                    onChanged: (value) {
                      controller.updateColor(value ?? '');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a color';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // Size Dropdown
                Obx(
                  () => CustomTextFormFieldTwo(
                    hintText: 'Select size',
                    labelText: 'Size*',
                    dropDownItems: sizeItems,
                    selectedValue: controller.selectedSize.value,
                    onChanged: (value) {
                      controller.updateSize(value ?? '');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a size';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  onPressed: () {
                    controller.saveEditedProduct();
                  },
                  text: 'Next',
                  width: double.infinity,
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid(
    imagePickerController imageController,
    BuildContext context,
  ) {
    List<Widget> imageWidgets = [];

    // Add existing product image (if editing)
    if (controller.currentEditingProductId.value.isNotEmpty) {
      try {
        final product = controller.allProducts.firstWhere(
          (p) => p['id'] == controller.currentEditingProductId.value,
        );
        if (product['imageUrl'] != null) {
          imageWidgets.add(
            _photoAddition(
              imageFile: product['imageUrl'],
              // This will be a String (asset path)
              onDelete: () {
                // Remove the existing image reference
                // You could implement logic to mark image for deletion
              },
              isExistingImage: true,
            ),
          );
        }
      } catch (e) {
        // Product not found, continue without existing image
      }
    }

    // Add newly selected images (Files)
    for (int i = 0; i < imageController.selectedImages.length; i++) {
      imageWidgets.add(
        _photoAddition(
          imageFile: imageController.selectedImages[i], // This will be a File
          onDelete: () => imageController.removeImage(i),
          isExistingImage: false,
        ),
      );
    }

    // Calculate total images (existing + new)
    int totalImages = imageWidgets.length;

    // Add the "Add Photo" button if less than 8 images
    if (totalImages < 8) {
      imageWidgets.add(_addPhoto(imageController, context));
    }

    // If no images and only the add button, show it full width
    if (imageWidgets.length == 1 && totalImages == 0) {
      return Column(children: imageWidgets);
    }

    return _buildDynamicGrid(imageWidgets);
  }

  Widget _buildDynamicGrid(List<Widget> widgets) {
    List<Widget> rows = [];
    int itemsPerRow = 3; // You can adjust this based on your needs

    for (int i = 0; i < widgets.length; i += itemsPerRow) {
      List<Widget> rowChildren = [];

      // Get the widgets for this row
      int end = (i + itemsPerRow < widgets.length)
          ? i + itemsPerRow
          : widgets.length;
      List<Widget> rowWidgets = widgets.sublist(i, end);

      // Add widgets with spacers between them
      for (int j = 0; j < rowWidgets.length; j++) {
        // Wrap each widget in Expanded for equal distribution
        rowChildren.add(Expanded(flex: 1, child: rowWidgets[j]));

        // Add spacer between items (not after the last item)
        if (j < rowWidgets.length - 1) {
          rowChildren.add(SizedBox(width: 12.w)); // Fixed spacing between items
        }
      }

      // If this row has fewer items than itemsPerRow, add empty expanded widgets
      // to maintain consistent sizing
      while (rowChildren.length < (itemsPerRow * 2 - 1)) {
        // *2-1 accounts for spacers
        if (rowChildren.isNotEmpty) {
          rowChildren.add(SizedBox(width: 12.w));
        }
        rowChildren.add(
          Expanded(
            flex: 1,
            child: SizedBox(), // Empty space to maintain grid alignment
          ),
        );
      }

      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(children: rowChildren),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _addPhoto(
    imagePickerController imageController,
    BuildContext context,
  ) {
    // Check if we have any images to determine container size
    bool hasImages = imageController.selectedImages.isNotEmpty;

    return GestureDetector(
      onTap: () {
        showImagePickerOption(context, imageController);
      },
      child: Container(
        height: 120.h,
        width: hasImages ? double.infinity : double.infinity,
        // Now always uses available width
        decoration: BoxDecoration(
          color: AppColors.neutral800,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages
                  .imagePictureLandscape2PhotosPhotoLandscapePicturePhotographyCameraPicturesStreamlineCore,
              height: 16.h,
              width: 16.w,
              colorFilter: ColorFilter.mode(
                AppColors.neutral50,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Add Photo',
              style: AppTextStyles.buttonRegular.copyWith(
                color: AppColors.neutral50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStockInputDialog(BuildContext context) {
    final TextEditingController stockController = TextEditingController(
      text: controller.stockAvailable.value.toString(),
    );

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.neutral900,
        title: Text(
          'Enter Stock Quantity',
          style: AppTextStyles.H6_Medium.copyWith(color: AppColors.neutral50),
        ),
        content: TextField(
          controller: stockController,
          keyboardType: TextInputType.number,
          style: AppTextStyles.paragraph_1_Regular.copyWith(
            color: AppColors.neutral50,
          ),
          decoration: InputDecoration(
            hintText: 'Enter quantity',
            hintStyle: AppTextStyles.paragraph_1_Regular.copyWith(
              color: AppColors.neutral200,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.neutral800),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.primary1000),
            ),
            filled: true,
            fillColor: AppColors.neutral800,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.neutral200),
            ),
          ),
          TextButton(
            onPressed: () {
              final int? newStock = int.tryParse(stockController.text);
              if (newStock != null && newStock >= 0) {
                controller.stockAvailable.value = newStock;
                Get.back();
              } else {
                // Show error or just close dialog
                Get.snackbar(
                  'Invalid Input',
                  'Please enter a valid number (0 or greater)',
                  backgroundColor: AppColors.red500,
                  colorText: AppColors.neutral50,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text(
              'OK',
              style: TextStyle(color: AppColors.primary1000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoAddition({
    required dynamic imageFile, // Can be File or String
    required VoidCallback onDelete,
    bool isExistingImage = false,
  }) {
    return Stack(
      children: [
        Container(
          height: 120.h,
          width: double.infinity, // Now uses available width from Expanded
          decoration: BoxDecoration(
            color: AppColors.neutral800,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: imageFile is String
                ? Image.asset(
                    imageFile,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.neutral800,
                        child: Icon(
                          Icons.image,
                          color: AppColors.neutral400,
                          size: 40.sp,
                        ),
                      );
                    },
                  )
                : Image.file(imageFile, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 7.w,
          top: 6.h,
          child: GestureDetector(
            onTap: onDelete,
            child: Container(
              height: 16.w,
              width: 16.w,
              decoration: BoxDecoration(
                color: AppColors.neutral950,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppImages
                      .interfaceDeleteBin1RemoveDeleteEmptyBinTrashGarbageStreamlineCore,
                  colorFilter: ColorFilter.mode(
                    AppColors.neutral50,
                    BlendMode.srcIn,
                  ),
                  height: 8.h,
                  width: 8.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
