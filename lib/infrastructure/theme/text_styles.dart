import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  ///------------------------------Regular Text Style----------------------------------

  static TextStyle H1_Regular = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H2_Regular = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H3_Regular = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H4_Regular = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H5_Regular = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H6_Regular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle paragraph_1_Regular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,

  );
  static TextStyle paragraph_2_Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle buttonRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
    height: 1.5.h
  );
  static TextStyle captionRegular = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );

  ///------------------------------Medium Text Style----------------------------------

  static TextStyle H1_Medium = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H2_Medium = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H3_Medium = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H4_Medium = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H5_Medium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H6_Medium = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle paragraph_1_Medium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle paragraph_2_Medium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle buttonMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle captionMedium = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );

  ///------------------------------Bold Text Style----------------------------------

  static TextStyle H1_Bold = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontFamilyFallback: const ['Arial', 'sans-serif'],
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H2_Bold = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H3_Bold = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H4_Bold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H5_Bold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle H6_Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle paragraph_1_Bold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle paragraph_2_Bold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle buttonBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
  static TextStyle captionBold = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: AppColors.defaultTextColor,
    letterSpacing: 0,
  );
}