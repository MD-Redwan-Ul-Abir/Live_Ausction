import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';
import '../../../../infrastructure/utils/app_images.dart';
import '../../../shared/widgets/imagePicker/custom_image_picker.dart';
import '../../../shared/widgets/imagePicker/imagePickerController.dart';
import '../controllers/add_product.controller.dart';

class CreateProduct extends GetView<AddProductController> {
  const CreateProduct({super.key});

  // Category dropdown items from controller
  List<DropdownMenuItem<String>> get categoryItems => controller.categories
      .map(
        (category) => DropdownMenuItem(value: category, child: Text(category)),
      )
      .toList();

  // Subcategory dropdown items from controller
  List<DropdownMenuItem<String>> get subcategoryItems => controller
      .subcategories
      .map(
        (subcategory) =>
            DropdownMenuItem(value: subcategory, child: Text(subcategory)),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    final imagePickerController imageController = Get.put(
      imagePickerController(),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create a Product',
            style: AppTextStyles.H6_Medium.copyWith(color: AppColors.neutral50),
          ),
          SizedBox(height: 4.h),
          Text(
            'Detailed product listing show up better in searches. \nMore visibility means more buyers.',
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral200,
            ),
          ),
          SizedBox(height: 24.h),

          Obx(() => _buildImageGrid(imageController, context)),
          SizedBox(height: imageController.selectedImages.isEmpty ? 8.h : 0),
          Obx(
            () => Text(
              'Photo : ${imageController.selectedImages.length}/8 Maximum',
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.neutral200,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Product Details',
            style: AppTextStyles.paragraph_1_Regular.copyWith(
              color: AppColors.neutral50,
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
        ],
      ),
    );
  }

  Widget _buildImageGrid(
    imagePickerController imageController,
    BuildContext context,
  ) {
    List<Widget> imageWidgets = [];

    // Add existing images
    for (int i = 0; i < imageController.selectedImages.length; i++) {
      imageWidgets.add(
        _photoAddition(
          imageFile: imageController.selectedImages[i],
          onDelete: () => imageController.removeImage(i),
        ),
      );
    }

    // Add the "Add Photo" button if less than 8 images
    if (imageController.selectedImages.length < 8) {
      imageWidgets.add(_addPhoto(imageController, context));
    }

    // If no images and only the add button, show it full width
    if (imageWidgets.length == 1 && imageController.selectedImages.isEmpty) {
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
              color: AppColors.neutral50,
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

  Widget _photoAddition({
    required dynamic imageFile, // Can be File or String
    required VoidCallback onDelete,
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
                ? Image.asset(imageFile, fit: BoxFit.cover)
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
                  color: AppColors.neutral50,
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
}
