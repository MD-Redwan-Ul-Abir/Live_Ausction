import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final String errorText;
  final String? selectedValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropDown({
    super.key,
    required this.hintText,
    required this.errorText,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedValue,
      hint: Text(
        hintText,
        style: AppTextStyles.paragraph_2_Regular.copyWith(
          color: AppColors.neutral50,
          fontSize: 12.sp
        ),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.neutral950,
        contentPadding: EdgeInsets.only(top: 18.h, bottom: 18.h, right: 8.w, left: 4.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.neutral800), // Default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.neutral800), // Enabled border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: AppColors.primary1000, width: 1.w), // Red border when selected/focused
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: Colors.red), // Red border for errors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: Colors.red, width: 2.0), // Red border when focused with error
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300.h,
        // width: 400.w, // Custom width

        decoration: BoxDecoration(
          color: AppColors.primary950,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.primary950, width: 1.w),
        ),
        offset: const Offset(0, -4), // To adjust dropdown position
      ),
      iconStyleData: IconStyleData(
        icon: Transform.rotate(
          angle: 3.14 / 2,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: SvgPicture.asset(
              AppImages.interfaceArrowsButtonRightArrowRightKeyboardStreamlineCore,
              height: 24.h,
              width: 24.w,
              color: AppColors.neutral50,
            ),
          ),
        ),
      ),
      style: AppTextStyles.paragraph_2_Regular.copyWith(color: AppColors.neutral50),
    );
  }
}