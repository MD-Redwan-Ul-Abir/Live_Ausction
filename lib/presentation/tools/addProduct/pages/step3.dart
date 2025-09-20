import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../commonWidgets/customTextFormFieldTwo.dart';
import '../controllers/add_product.controller.dart';

class ChooseSize extends GetView<AddProductController> {
  const ChooseSize({super.key});



  // Color dropdown items from controller
  List<DropdownMenuItem<String>> get colorItems => controller.colors
      .map((color) => DropdownMenuItem(value: color, child: Text(color)))
      .toList();

  // Size dropdown items from controller
  List<DropdownMenuItem<String>> get sizeItems => controller.sizes
      .map((size) => DropdownMenuItem(value: size, child: Text(size)))
      .toList();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Size & color',
            style: AppTextStyles.H6_Medium.copyWith(color: AppColors.neutral50),
          ),
          SizedBox(height: 4.h),
          Text(
            'Set a Starting price you’re comfortable with that will \nget buyers interested . Lower price is more \nEngaging',
            style: AppTextStyles.buttonRegular.copyWith(
              color: AppColors.neutral200,
            ),
          ),
          SizedBox(height: 32.h),
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

        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    RxString value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value.value,
            dropdownColor: Color(0xFF2A2A2A),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white54),
            style: TextStyle(color: Colors.white),
            isExpanded: true,
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: (newValue) => onChanged(newValue!),
          ),
        ),
      ),
    );
  }
}
