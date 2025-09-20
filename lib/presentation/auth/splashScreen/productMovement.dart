import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../infrastructure/utils/app_images.dart';

class ProductMovement extends StatefulWidget {
  const ProductMovement({super.key});

  @override
  State<ProductMovement> createState() => _ProductMovementState();
}

class _ProductMovementState extends State<ProductMovement> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  // 24 elements in 3 layers (8 each)
  List<ElementData> elements = [];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );

    _initializeElements();
    startAnimation();
  }

  void _initializeElements() {
    elements.clear();

    final random = math.Random();

    // Generate random corner/edge position
    Alignment getRandomCornerPosition() {
      // All possible edge/corner positions
      List<Alignment> cornerPositions = [
        Alignment(-0.7, -0.9),   // Top Left
        Alignment(0.01, -0.65),    // Top Center
        Alignment(0.9, -0.8),    // Top Right
        Alignment(-0.85, -0.1),    // Center Left
        Alignment(0.78, 0.16),     // Center Right
        Alignment(-0.8, 0.72),    // Bottom Left
        Alignment(0.0, 0.9),     // Bottom Center
        Alignment(0.9, 0.9),     // Bottom Right
      ];

      // Pick a random corner/edge position
      Alignment basePos = cornerPositions[random.nextInt(cornerPositions.length)];

      // Add small random variation to make positions unique
      double variance = 0.15;
      double x = basePos.x + (random.nextDouble() - 0.5) * variance;
      double y = basePos.y + (random.nextDouble() - 0.5) * variance;

      // Keep values in valid range but maintain edge positioning
      if (basePos.x != 0) {
        x = x.clamp(basePos.x > 0 ? 0.7 : -1.0, basePos.x > 0 ? 1.0 : -0.7);
      }
      if (basePos.y != 0) {
        y = y.clamp(basePos.y > 0 ? 0.7 : -1.0, basePos.y > 0 ? 1.0 : -0.7);
      }

      return Alignment(x, y);
    }

    // Layer 1 - Fixed positions at edges (elements 1-8)
    List<Alignment> layer1Positions = [
      Alignment(-0.9, -0.9),   // Top Left
      Alignment(0.0, -0.9),    // Top Center
      Alignment(0.9, -0.9),    // Top Right
      Alignment(-0.9, 0.0),    // Center Left
      Alignment(0.9, 0.0),     // Center Right
      Alignment(-0.9, 0.9),    // Bottom Left
      Alignment(0.0, 0.9),     // Bottom Center
      Alignment(0.9, 0.9),     // Bottom Right
    ];

    // Layer 2 - Random positions spread across all corners (elements 9-16)
    List<Alignment> layer2Positions = [];
    for (int i = 0; i < 8; i++) {
      layer2Positions.add(getRandomCornerPosition());
    }

    // Layer 3 - Random positions spread across all corners (elements 17-24)
    List<Alignment> layer3Positions = [];
    for (int i = 0; i < 8; i++) {
      layer3Positions.add(getRandomCornerPosition());
    }

    List<String> images = [
      AppImages.p6, AppImages.p2, AppImages.p7, AppImages.p5,
      AppImages.p3, AppImages.p8, AppImages.p9, AppImages.p2,
      AppImages.p6, AppImages.p5, AppImages.p8, AppImages.p1,
      AppImages.p7, AppImages.p5, AppImages.p4, AppImages.p6,
      AppImages.p9, AppImages.p2, AppImages.p6, AppImages.p5,
    ];

    // Create elements for all 3 layers
    for (int i = 0; i < 8; i++) {
      elements.add(ElementData(
        id: i + 1,
        startPosition: layer1Positions[i],
        imageUrl: images[i],
        layer: 1,
        startDelay: 0.0,
      ));
    }

    for (int i = 0; i < 8; i++) {
      elements.add(ElementData(
        id: i + 9,
        startPosition: layer2Positions[i],
        imageUrl: images[i + 8],
        layer: 2,
        startDelay: 0.33, // Start when layer 1 reaches 1/3 distance
      ));
    }

    for (int i = 0; i < 4; i++) { // Reduced to 4 to prevent index out of bounds
      elements.add(ElementData(
        id: i + 17,
        startPosition: layer3Positions[i],
        imageUrl: images[i + 16],
        layer: 3,
        startDelay: 0.66, // Start when layer 1 reaches 2/3 distance
      ));
    }
  }

  void startAnimation() async {
    await animationController.forward();
    //await animationController.reverse();
  }

  // Calculate stretching based on direction to center
  Map<String, double> getStretch(ElementData element, double progress) {
    // Only stretch if this element has started moving
    if (progress < element.startDelay) return {'scaleX': 1.0, 'scaleY': 1.0};

    double adjustedProgress = ((progress - element.startDelay) / (1.0 - element.startDelay)).clamp(0.0, 1.0);
    if (adjustedProgress <= 0) return {'scaleX': 1.0, 'scaleY': 1.0};

    double dx = element.startPosition.x;
    double dy = element.startPosition.y;
    double distance = math.sqrt(dx * dx + dy * dy);

    // Create stretching curve - stretch more at beginning, return to normal at end
    double stretchCurve = math.sin(adjustedProgress * math.pi);

    // Calculate stretch factor based on distance (farther elements stretch more)
    double maxStretch = 1.0 + (distance * 1.5);
    double currentStretch = 1.0 + (maxStretch - 1.0) * stretchCurve;

    // Calculate stretch direction (towards center)
    double scaleX = 1.0;
    double scaleY = 1.0;

    if (dx.abs() < 0.01) {
      // Element is on vertical axis (top center or bottom center)
      scaleY = currentStretch;
      scaleX = 1.0 / math.sqrt(currentStretch); // Compensate to maintain volume
    } else if (dy.abs() < 0.01) {
      // Element is on horizontal axis (center left or center right)
      scaleX = currentStretch;
      scaleY = 1.0 / math.sqrt(currentStretch); // Compensate to maintain volume
    } else {
      // Element is diagonal - stretch along the line to center
      double ratio = dx.abs() / dy.abs();
      if (ratio > 1) {
        scaleX = currentStretch;
        scaleY = 1.0 + (currentStretch - 1.0) / ratio;
      } else {
        scaleY = currentStretch;
        scaleX = 1.0 + (currentStretch - 1.0) * ratio;
      }
    }

    return {'scaleX': scaleX, 'scaleY': scaleY};
  }

  // Calculate current position with easing
  Alignment getCurrentPosition(ElementData element, double progress) {
    // Don't move until this element's start delay
    if (progress < element.startDelay) return element.startPosition;

    double adjustedProgress = ((progress - element.startDelay) / (1.0 - element.startDelay)).clamp(0.0, 1.0);

    // Use ease-out curve for realistic deceleration
    double easedProgress = 1 - math.pow(1 - adjustedProgress, 3).toDouble();

    return Alignment.lerp(element.startPosition, Alignment.center, easedProgress)!;
  }

  // Calculate opacity for visibility timing
  double getOpacity(ElementData element, double progress) {
    // Elements are completely invisible until their start delay
    if (progress < element.startDelay) return 0.0;

    // Quick fade in when the element becomes visible
    double fadeProgress = (progress - element.startDelay) * 20; // Fast fade in
    return fadeProgress.clamp(0.0, 1.0);
  }

  // Calculate rotation to align stretch with direction to center
  double getRotation(ElementData element) {
    double dx = element.startPosition.x;
    double dy = element.startPosition.y;

    // No rotation needed for elements on axes
    if (dx.abs() < 0.01 || dy.abs() < 0.01) {
      return 0.0;
    }

    // Calculate angle from element to center
    return math.atan2(-dy, -dx) - math.pi / 2;
  }

  // Helper function to get Layer 1 progress (for display purposes)
  double getLayer1Progress() {
    // Find any Layer 1 element and calculate its progress towards center
    var layer1Element = elements.firstWhere((e) => e.layer == 1);
    Alignment currentPos = getCurrentPosition(layer1Element, animationController.value);

    // Calculate distance from start to current position
    double startDistance = math.sqrt(
        layer1Element.startPosition.x * layer1Element.startPosition.x +
            layer1Element.startPosition.y * layer1Element.startPosition.y
    );
    double currentDistance = math.sqrt(
        currentPos.x * currentPos.x +
            currentPos.y * currentPos.y
    );

    // Progress is how much of the distance has been covered
    return ((startDistance - currentDistance) / startDistance).clamp(0.0, 1.0);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return just the animated content without Scaffold
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Animation elements
              ...elements.map((element) {
                double progress = animationController.value;
                Alignment currentPosition = getCurrentPosition(element, progress);
                Map<String, double> stretch = getStretch(element, progress);
                double opacity = getOpacity(element, progress);
                double rotation = getRotation(element);

                return Align(
                  alignment: currentPosition,
                  child: Opacity(
                    opacity: opacity,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(rotation)
                        ..scale(stretch['scaleX'], stretch['scaleY'])
                        ..rotateZ(-rotation),
                      child: Image.asset(
                        element.imageUrl,
                        height: (40.h + (element.layer * 2)).toDouble(),
                        width: (40.w + (element.layer * 2)).toDouble(),
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback for missing images
                          return Container(
                            height: (40 + (element.layer * 2)).toDouble(),
                            width: (40 + (element.layer * 2)).toDouble(),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[600],
                              size: 16,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

class ElementData {
  final int id;
  final Alignment startPosition;
  final String imageUrl;
  final int layer;
  final double startDelay;

  ElementData({
    required this.id,
    required this.startPosition,
    required this.imageUrl,
    required this.layer,
    required this.startDelay,
  });
}