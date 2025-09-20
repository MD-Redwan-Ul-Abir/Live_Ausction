import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/commonWidgets/customTextFormFieldTwo.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../shared/widgets/appbar/custom_appbar.dart';
import '../scheduleShow/controllers/schedule_show.controller.dart';

class Schedule1 extends GetView<ScheduleShowController> {
  const Schedule1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Schedule a Show', centerTitle: true,
      onBackPressed: (){
        controller.previousStep();
      },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            CustomTextFormFieldTwo(
              hintText: 'Enter your Show Tittle',
              labelText: 'Title*',
              onChanged: (value) => controller.updateTitle(value!),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => CustomTextFormFieldTwo(
                hintText: 'Everyday Electronics',
                labelText: 'Category*',
                selectedValue: controller.category.value,
                onChanged: (newValue) {
                  controller.updateCategory(newValue!);
                },
                dropDownItems: controller.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => CustomTextFormFieldTwo(
                hintText: 'Everyday Electronics',
                labelText: 'Subcategory*',
                selectedValue: controller.subcategory.value,
                onChanged: (newValue) {
                  controller.updateSubcategory(newValue!);
                },
                dropDownItems: controller.subcategories.map((subcategory) {
                  return DropdownMenuItem(
                    value: subcategory,
                    child: Text(subcategory),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFormFieldTwo(
              hintText: 'Select Date',
              labelText: 'Date*',
              enableDateTimePicker: true,
              dateFormat: 'dd/MM/yyyy',
              initialDateTime: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              dateTimePickerIcon: AppImages.calenderDate,
              dateTimeIconPadding: EdgeInsets.all(16.0),
              onDateTimeChanged: (DateTime? selectedDate) {
                print('Selected date: $selectedDate');
              },
            ),
            SizedBox(height: 16.h),
            CustomTextFormFieldTwo(
              hintText: 'Select time',
              labelText: 'Time*',
              dateTimePickerIcon: AppImages.interfaceTimeResetTimeClockResetStopwatchCircleMeasureLoadingStreamlineCore,
              enableTimePicker: true,
              dateFormat: 'HH:mm',
              initialTime: TimeOfDay(hour: 9, minute: 0),
              onDateTimeChanged: (DateTime? selectedTime) {
                print('Selected time: ${selectedTime?.hour}:${selectedTime?.minute}');
              },
            ),
          ],
        ),
      ),
    );
  }
}