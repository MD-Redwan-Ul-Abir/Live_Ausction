import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/text_styles.dart';
import '../../../infrastructure/utils/app_images.dart';

class CustomTextFormFieldTwo extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final Color? dropdownHintTextColor;
  final int? prefixIconHeight;
  final int? prefixIconWeight;
  final int? sufixIconHeight;
  final int? sufixIconWeight;
  final Color? hintColor;
  final int? maxlength;
  final int? boxHeight;
  final String? keyboardType;
  final dynamic suffixSvg;
  final EdgeInsetsGeometry? prefixPadding;
  final dynamic prefixSvg;
  final List<DropdownMenuItem<String>>? dropDownItems;
  final Color? dropdownIconColor;
  final Color? filledColor;
  final Color? hintTextColor;
  final bool? filledstatus;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final double? dropdownHeight;
  final double? dropdownWidth;
  final GlobalKey<FormState>? formKey;
  final bool isEnabled;
  final bool readOnly;
  final ValueChanged<String?>? onSaved, onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTapSuffix;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? suffixIcon;
  final Color? cursorColor;
  final bool? showFocusedBorder;

  // Dropdown color parameters
  final Color? dropdownBackgroundColor;
  final Color? dropdownTextColor;
  final Color? dropdownSelectedTextColor;
  final Color? dropdownBorderColor;
  final Color? dropdownFocusedBorderColor;
  final AlignmentGeometry? dropdownAlignment;

  // DateTime picker parameters
  final bool enableDatePicker;     // NEW: Separate date picker
  final bool enableTimePicker;     // NEW: Separate time picker
  final bool enableDateTimePicker; // Combined date+time picker
  final DateTime? initialDateTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DatePickerMode? datePickerMode;
  final String? dateFormat; // e.g., 'dd/MM/yyyy', 'HH:mm', 'yyyy-MM-dd HH:mm'
  final bool showTimePicker;
  final TimeOfDay? initialTime;
  final ValueChanged<DateTime?>? onDateTimeChanged;

  // Custom DateTime picker icon parameters
  final String? dateTimePickerIcon;
  final double? dateTimeIconHeight;
  final double? dateTimeIconWidth;
  final Color? dateTimeIconColor;
  final EdgeInsetsGeometry? dateTimeIconPadding;

  const CustomTextFormFieldTwo({
    super.key,
    required this.hintText,
    this.labelText,
    this.labelStyle,
    this.suffixSvg,
    this.prefixSvg,
    this.hintColor,
    this.maxlength,
    this.boxHeight,
    this.keyboardType,
    this.dropDownItems,
    this.controller,
    this.prefixPadding,
    this.dropdownIconColor,
    this.filledColor,
    this.hintTextColor,
    this.selectedValue,
    this.onChanged,
    this.dropdownHeight,
    this.dropdownWidth,
    this.filledstatus,
    this.formKey,
    this.isEnabled = true,
    this.readOnly = false,
    this.onSaved,
    this.validator,
    this.onTapSuffix,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.suffixIcon,
    this.showFocusedBorder = false,
    this.prefixIconHeight,
    this.prefixIconWeight,
    this.sufixIconHeight,
    this.sufixIconWeight,
    this.dropdownHintTextColor,
    this.cursorColor,
    this.dropdownBackgroundColor = AppColors.primary700,
    this.dropdownTextColor,
    this.dropdownSelectedTextColor,
    this.dropdownBorderColor,
    this.dropdownFocusedBorderColor,
    this.dropdownAlignment,

    // DateTime picker defaults
    this.enableDatePicker = false,
    this.enableTimePicker = false,
    this.enableDateTimePicker = false,
    this.initialDateTime,
    this.firstDate,
    this.lastDate,
    this.datePickerMode = DatePickerMode.day,
    this.dateFormat,
    this.showTimePicker = false,
    this.initialTime,
    this.onDateTimeChanged,

    // Custom DateTime picker icon defaults
    this.dateTimePickerIcon,
    this.dateTimeIconHeight,
    this.dateTimeIconWidth,
    this.dateTimeIconColor,
    this.dateTimeIconPadding,
  });

  @override
  State<CustomTextFormFieldTwo> createState() => _CustomTextFormFieldTwoState();
}

class _CustomTextFormFieldTwoState extends State<CustomTextFormFieldTwo> {
  bool _obscureText = true;
  DateTime? _selectedDateTime;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
    _selectedTime = widget.initialTime;

    // Parse initial values from controller text
    if (widget.controller?.text.isNotEmpty == true) {
      _parseInitialValue();
    }
  }

  void _parseInitialValue() {
    try {
      if (widget.controller?.text.isNotEmpty == true) {
        final text = widget.controller!.text;

        if (widget.enableTimePicker && !widget.enableDatePicker && !widget.enableDateTimePicker) {
          // Time only parsing
          final timeParts = text.split(':');
          if (timeParts.length >= 2) {
            final hour = int.tryParse(timeParts[0]);
            final minute = int.tryParse(timeParts[1]);
            if (hour != null && minute != null) {
              _selectedTime = TimeOfDay(hour: hour, minute: minute);
            }
          }
        } else {
          // Date or DateTime parsing
          _selectedDateTime = DateTime.tryParse(text);
        }
      }
    } catch (e) {
      // If parsing fails, keep initial values
      _selectedDateTime = widget.initialDateTime;
      _selectedTime = widget.initialTime;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    if (widget.dateFormat != null) {
      switch (widget.dateFormat) {
        case 'dd/MM/yyyy':
          return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
        case 'MM/dd/yyyy':
          return '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}/${dateTime.year}';
        case 'yyyy-MM-dd':
          return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
        case 'yyyy-MM-dd HH:mm':
          return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
        case 'HH:mm':
          return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
        case 'hh:mm a':
          final hour12 = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
          final ampm = dateTime.hour < 12 ? 'AM' : 'PM';
          return '${hour12.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $ampm';
        default:
          return widget.showTimePicker || widget.enableDateTimePicker
              ? '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}'
              : '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    }

    // Default formatting based on picker type
    if (widget.enableTimePicker && !widget.enableDatePicker && !widget.enableDateTimePicker) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (widget.showTimePicker || widget.enableDateTimePicker) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  String _formatTime(TimeOfDay time) {
    if (widget.dateFormat == 'hh:mm a') {
      final hour12 = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
      final ampm = time.hour < 12 ? 'AM' : 'PM';
      return '${hour12.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $ampm';
    }
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  ThemeData _getPickerTheme() {
    return Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: AppColors.primary950,
        onPrimary: AppColors.neutral50,
        surface: AppColors.primary500,
        onSurface: AppColors.primary950,
        background: AppColors.neutral950,
        onBackground: AppColors.neutral50,
      ),
      dialogBackgroundColor: AppColors.primary500,
      textTheme: Theme.of(context).textTheme.copyWith(
        headlineSmall: TextStyle(
          color: AppColors.neutral50,
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: AppColors.neutral50,
          fontSize: 16.sp,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primary950,
          fontSize: 14.sp,
        ),
        labelLarge: TextStyle(
          color: AppColors.primary950,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      dividerColor: AppColors.neutral700,
    );
  }

  Future<void> _selectDateTime() async {
    if (!widget.isEnabled || widget.readOnly) return;

    final pickerTheme = _getPickerTheme();

    // Date only picker
    if (widget.enableDatePicker && !widget.enableTimePicker && !widget.enableDateTimePicker) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDateTime ?? widget.initialDateTime ?? DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2100),
        initialDatePickerMode: widget.datePickerMode ?? DatePickerMode.day,
        builder: (context, child) => Theme(data: pickerTheme, child: child!),
      );

      if (pickedDate != null) {
        setState(() {
          _selectedDateTime = pickedDate;
          widget.controller?.text = _formatDateTime(pickedDate);
        });
        widget.onDateTimeChanged?.call(pickedDate);
        widget.onChanged?.call(_formatDateTime(pickedDate));
      }
      return;
    }

    // Time only picker
    if (widget.enableTimePicker && !widget.enableDatePicker && !widget.enableDateTimePicker) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? widget.initialTime ?? TimeOfDay.now(),
        builder: (context, child) => Theme(data: pickerTheme, child: child!),
      );

      if (pickedTime != null) {
        // Create a DateTime object with today's date and selected time
        final now = DateTime.now();
        final dateTimeWithSelectedTime = DateTime(
          now.year,
          now.month,
          now.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedTime = pickedTime;
          _selectedDateTime = dateTimeWithSelectedTime;
          widget.controller?.text = _formatTime(pickedTime);
        });
        widget.onDateTimeChanged?.call(dateTimeWithSelectedTime);
        widget.onChanged?.call(_formatTime(pickedTime));
      }
      return;
    }

    // Combined DateTime picker or legacy enableDateTimePicker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? widget.initialDateTime ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      initialDatePickerMode: widget.datePickerMode ?? DatePickerMode.day,
      builder: (context, child) => Theme(data: pickerTheme, child: child!),
    );

    if (pickedDate != null) {
      DateTime finalDateTime = pickedDate;

      if (widget.showTimePicker || widget.enableDateTimePicker) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: widget.initialTime ?? TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
          builder: (context, child) => Theme(data: pickerTheme, child: child!),
        );

        if (pickedTime != null) {
          finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }
      }

      setState(() {
        _selectedDateTime = finalDateTime;
        widget.controller?.text = _formatDateTime(finalDateTime);
      });
      widget.onDateTimeChanged?.call(finalDateTime);
      widget.onChanged?.call(_formatDateTime(finalDateTime));
    }
  }

  TextInputType? _getKeyboardType(String? type) {
    switch (type) {
      case 'text':
        return TextInputType.text;
      case 'number':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'multiline':
        return TextInputType.multiline;
      case 'datetime':
        return TextInputType.datetime;
      case 'url':
        return TextInputType.url;
      case 'visiblePassword':
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  bool get _isPasswordField => widget.keyboardType == 'visiblePassword';
  bool get _isDateTimeField => widget.enableDateTimePicker || widget.enableDatePicker || widget.enableTimePicker || widget.keyboardType == 'datetime';

  @override
  Widget build(BuildContext context) {
    if (widget.dropDownItems != null && widget.dropDownItems!.isNotEmpty) {
      return _buildDropdownField();
    }

    return _buildTextFormField();
  }

  Widget _buildDropdownField() {
    return IgnorePointer(
      ignoring: !widget.isEnabled || widget.readOnly,
      child: DropdownButtonFormField<String>(
        value: widget.selectedValue,
        items: widget.dropDownItems?.map((item) {
          return DropdownMenuItem<String>(
            value: item.value,
            child: Text(
              item.child is Text ? (item.child as Text).data ?? '' : item.value ?? '',
              style: AppTextStyles.buttonRegular.copyWith(
                color: widget.dropdownTextColor ?? AppColors.neutral50,
              ),
            ),
          );
        }).toList(),
        onChanged: widget.isEnabled && !widget.readOnly ? widget.onChanged : null,
        decoration: _inputDecoration(context, isDropdown: true),
        style: AppTextStyles.buttonRegular.copyWith(
          color: widget.dropdownSelectedTextColor ?? AppColors.neutral50,
        ),
        dropdownColor: widget.dropdownBackgroundColor ?? AppColors.neutral950,
        iconEnabledColor: widget.dropdownIconColor ?? AppColors.neutral50,
        alignment: widget.dropdownAlignment ?? AlignmentDirectional.centerStart,
        icon: Transform.rotate(
          angle: 3.14 / -2,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AppImages.interfaceArrowsButtonLeftArrowKeyboardLeftStreamlineCore,
              height: 16.h,
              width: 16.w,
              color: widget.dropdownIconColor ?? AppColors.neutral50,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: widget.controller,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      enabled: widget.isEnabled,
      readOnly: widget.readOnly || _isDateTimeField,
      onChanged: widget.isEnabled && !widget.readOnly ? widget.onChanged : null,
      onSaved: widget.onSaved,
      cursorColor: widget.cursorColor ?? AppColors.primary500,
      onFieldSubmitted: widget.onFieldSubmitted,
      onTap: _isDateTimeField ? _selectDateTime : null,
      validator: (value) {
        final customError = widget.validator?.call(value);
        if (customError != null) return customError;

        if (widget.keyboardType == 'email') {
          const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
          final allowedDomains = [
            'gmail.com',
            'yahoo.com',
            'outlook.com',
            'icloud.com',
            'hotmail.com',
            'live.com',
            'protonmail.com'
          ];

          if (value == null || value.trim().isEmpty) {
            return 'Email is required';
          } else if (!RegExp(emailRegex).hasMatch(value.trim())) {
            return 'Enter a valid email address';
          } else {
            final domain = value.trim().split('@').last.toLowerCase();
            if (!allowedDomains.contains(domain)) {
              return 'Please use a valid email provider (e.g. gmail.com)';
            }
          }

          return null;
        }

        return null;
      },
      maxLength: widget.maxlength,
      obscureText: _isPasswordField ? _obscureText : false,
      keyboardType: _isDateTimeField ? TextInputType.none : _getKeyboardType(widget.keyboardType),
      minLines: widget.keyboardType == 'multiline' ? 5 : 1,
      maxLines: widget.keyboardType == 'multiline' ? null : 1,
      decoration: _inputDecoration(context),
      style: AppTextStyles.buttonRegular.copyWith(
        color: AppColors.neutral50,
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, {bool isDropdown = false}) {
    return InputDecoration(
      label: (widget.labelText != null && widget.labelText!.trim().isNotEmpty)
          ? Text(
        widget.labelText!,
        style: widget.labelStyle ??
            AppTextStyles.captionRegular.copyWith(
              color: AppColors.neutral200,
              fontSize: 14.sp,
            ),
      )
          : null,
      hintText: widget.hintText,
      hintStyle: AppTextStyles.buttonRegular.copyWith(
        color: widget.dropdownHintTextColor ?? widget.hintTextColor ?? AppColors.neutral200,
        fontSize: 13.sp,
      ),
      filled: widget.filledstatus ?? true,
      fillColor: widget.filledColor ?? (widget.isEnabled ? AppColors.neutral950 : AppColors.neutral800),
      contentPadding: EdgeInsets.symmetric(
        vertical: widget.boxHeight?.toDouble() ?? 13.5.h,
        horizontal: 20.w,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: BorderSide(
          color: isDropdown
              ? (widget.dropdownBorderColor ?? AppColors.neutral800)
              : AppColors.neutral800,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: BorderSide(
          color: isDropdown
              ? (widget.dropdownBorderColor ?? AppColors.neutral800)
              : AppColors.neutral800,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: BorderSide(
          color: isDropdown
              ? (widget.dropdownFocusedBorderColor ?? AppColors.primary500)
              : AppColors.primary500,
          width: 1.w,
        ),
      ),
      prefixIcon: _buildPrefixIcon(context),
      suffixIcon: _buildSuffixIcon(context),
    );
  }

  Widget? _buildPrefixIcon(BuildContext context) {
    if (widget.prefixSvg is String) {
      return Padding(
        padding: EdgeInsets.only(left: 10.w, top: 16.h, bottom: 16.h, right: 4.w),
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: SvgPicture.asset(
            widget.prefixSvg!,
            height: widget.prefixIconHeight?.toDouble() ?? 14.h,
            width: widget.prefixIconWeight?.toDouble() ?? 14.w,
            fit: BoxFit.contain,
            color: AppColors.neutral50,
          ),
        ),
      );
    } else if (widget.prefixSvg != null) {
      return Padding(
        padding: widget.prefixPadding ?? EdgeInsets.all(12.sp),
        child: widget.prefixSvg,
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    // Password field handling
    if (_isPasswordField && !widget.readOnly) {
      return IconButton(
        icon: widget.suffixSvg != null && _obscureText
            ? _buildCustomSuffixIcon(context)!
            : SvgPicture.asset(
          _obscureText ? AppImages.passwordOff : AppImages.passwordOn,
          height: 18.h,
          width: 18.w,
          color: AppColors.neutral50,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    // DateTime field with custom or default icon
    if (_isDateTimeField) {
      IconData defaultIcon = Icons.calendar_today;

      // Choose appropriate icon based on picker type
      if (widget.enableTimePicker && !widget.enableDatePicker && !widget.enableDateTimePicker) {
        defaultIcon = Icons.access_time;
      } else if (widget.enableDateTimePicker || (widget.enableDatePicker && widget.showTimePicker)) {
        defaultIcon = Icons.schedule;
      }

      return GestureDetector(
        onTap: _selectDateTime,
        child: Padding(
          padding: widget.dateTimeIconPadding ?? EdgeInsets.all(20.sp),
          child: widget.dateTimePickerIcon != null
              ? SvgPicture.asset(
            widget.dateTimePickerIcon!,
            height: widget.dateTimeIconHeight ?? 16.h,
            width: widget.dateTimeIconWidth ?? 16.w,
            color: widget.dateTimeIconColor ?? AppColors.neutral50,
            fit: BoxFit.contain,
          )
              : Icon(
            defaultIcon,
            size: 16.h,
            color: widget.dateTimeIconColor ?? AppColors.neutral50,
          ),
        ),
      );
    }

    // Custom suffix icon
    return _buildCustomSuffixIcon(context);
  }

  Widget? _buildCustomSuffixIcon(BuildContext context) {
    if (widget.suffixSvg is String) {
      return GestureDetector(
        onTap: widget.onTapSuffix,
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SvgPicture.asset(
            widget.suffixSvg!,
            height: widget.sufixIconHeight?.toDouble() ?? 16.h,
            width: widget.sufixIconWeight?.toDouble() ?? 16.h,
            color: AppColors.neutral50,
          ),
        ),
      );
    } else if (widget.suffixSvg != null) {
      return Padding(padding: EdgeInsets.all(10.sp), child: widget.suffixSvg);
    }
    return null;
  }
}