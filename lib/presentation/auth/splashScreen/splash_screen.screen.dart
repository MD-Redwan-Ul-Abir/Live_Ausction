import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';
import 'package:live_auction_marketplace/presentation/auth/splashScreen/productMovement.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/text_styles.dart';
import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({super.key});

  @override
  State<SplashScreenScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> with SingleTickerProviderStateMixin{
  final SplashScreenController splashScreenController = Get.find<SplashScreenController>();

  late AnimationController animationController;
  AlignmentTween alignmentTween = AlignmentTween(begin: Alignment(0,0.06),end: Alignment.center);
  Animation<Alignment> animation = AlwaysStoppedAnimation(Alignment.center);
  late Animation<double> jellyAnimation;
  late Animation<Color?> backgroundColorAnimation;
  bool showProductMovement = false;

  @override
  void initState() {
    super.initState();
    splashScreenController.startSplashTimer();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2200), // Extended to accommodate color change
    );

    animationController.forward();
    animation = animationController.drive(alignmentTween.chain(CurveTween(curve: Curves.easeInOutBack)));

    jellyAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Background color animation - starts at 1800ms and takes 400ms to complete
    backgroundColorAnimation = ColorTween(
      begin: AppColors.primary1000,
      end: AppColors.neutral950,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(0.82, 1.0, curve: Curves.easeInOut), // 0.82 = 1800ms, 1.0 = 2200ms (400ms duration)
    ));

    // Delay showing ProductMovement by 800ms
    Future.delayed(Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          showProductMovement = true;
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: backgroundColorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: backgroundColorAnimation.value,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                // Only show ProductMovement after 600ms delay
                if (showProductMovement)
                  const ProductMovement(),

                // Main logo animation
                AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Align(
                        alignment: animation.value,
                        child: Transform.scale(
                          scale: 0.8 + (jellyAnimation.value * 0.2), // Scale from 0.8 to 1.0
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(0, 1, sin(jellyAnimation.value * pi * 4) * 0.1), // Jelly wobble
                            child: Image.asset(
                              AppImages.bgRemovedIcon,
                              height: 150.h,
                              width: 150.w,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback widget if image fails to load
                                return Container(
                                  height: 150.h,
                                  width: 150.w,
                                  color: Colors.grey,
                                  child: Icon(Icons.error, color: Colors.red),
                                );
                              },
                            ),
                          ),
                        ),
                      ).animate().scale(duration: Duration(milliseconds: 200));
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}