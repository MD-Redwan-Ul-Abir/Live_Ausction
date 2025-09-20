import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import '../../../../infrastructure/utils/app_images.dart';

class CustomSearchField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showClearButton;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry? contentPadding;

  const CustomSearchField({
    Key? key,
    this.hintText = 'Search for products',
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onClear,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.showClearButton = true,
    this.focusNode,
    this.textInputAction = TextInputAction.search,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _hasText = _controller.text.isNotEmpty;

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onFocusChanged() {
    if (_hasFocus != _focusNode.hasFocus) {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    }
  }

  void _clearText() {
    _controller.clear();
    widget.onClear?.call();
    _focusNode.requestFocus();
  }

  Color get _borderColor {
    if (_hasFocus) {
      return AppColors.primary1000;
    }
    return AppColors.neutral500;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: _borderColor,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          // Search Icon
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: widget.prefixIcon ??
                SvgPicture.asset(
                  AppImages.interfaceSearchGlassSearchMagnifyingStreamlineCore,
                  color: AppColors.neutral50,
                  width: 16.w,
                  height: 16.h,
                ),
          ),
          SizedBox(width: 8.w),

          // Text Field
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              onSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              style: AppTextStyles.paragraph_2_Regular.copyWith(
                color: AppColors.neutral50,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.paragraph_2_Regular,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: widget.contentPadding ?? EdgeInsets.zero,
                isDense: true,
              ),
              cursorColor: AppColors.primary1000,
            ),
          ),

          // Clear Button or Suffix Icon
          if (_hasText && widget.showClearButton)
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: GestureDetector(
                onTap: _clearText,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.neutral600,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12.w,
                    color: AppColors.neutral200,
                  ),
                ),
              ),
            )
          else if (widget.suffixIcon != null)
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: widget.suffixIcon!,
            )
          else
            SizedBox(width: 16.w), // Maintain consistent padding
        ],
      ),
    );
  }
}
