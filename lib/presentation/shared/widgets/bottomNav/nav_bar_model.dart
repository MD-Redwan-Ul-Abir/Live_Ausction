import 'package:flutter/material.dart';

class CustomNavItem {
  final String svgAssetPath;
  final String label;
  final VoidCallback? onPressed;
  final bool isFloatingButton;

  CustomNavItem({
    required this.svgAssetPath,
    required this.label,
    this.onPressed,
    this.isFloatingButton = false,
  });
}