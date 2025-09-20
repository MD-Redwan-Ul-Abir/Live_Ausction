import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:live_auction_marketplace/infrastructure/theme/app_colors.dart';
import 'package:live_auction_marketplace/infrastructure/theme/text_styles.dart';
import 'package:live_auction_marketplace/infrastructure/utils/app_images.dart';

class CustomSlider extends StatefulWidget {
  final double width;
  final double sliderWidth;
  final double height;
  final VoidCallback onSlideComplete;
  final Color borderColor;
  final Color buttonColor;
  final Color backgroundColor;
  final double borderWidth;
  final String text;
  final String buttonText;
  final TextStyle? textStyle;
  final double borderRadius;

  const CustomSlider({
    Key? key,
    required this.width,
    required this.height,
    required this.onSlideComplete,
    this.borderColor = Colors.grey,
    this.buttonColor = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.text = 'Slide to confirm',
    this.textStyle,
    this.borderRadius = 100.0,
    this.sliderWidth = 160,
    this.buttonText = '',
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _isDragging = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // Calculate the maximum drag distance
    // Available space = total width - button width - (2 * spacing from borders)
    final spacing = widget.borderWidth; // Space from borders
    final maxDragDistance = widget.width - widget.sliderWidth - (4 * spacing);

    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx)
          .clamp(0.0, maxDragDistance);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Calculate threshold based on the actual available drag distance
    final spacing = widget.borderWidth;
    final maxDragDistance = widget.width - widget.sliderWidth - (2 * spacing);
    final threshold = maxDragDistance * 0.8; // 80% threshold

    if (_dragPosition >= threshold) {
      // Slide completed
      widget.onSlideComplete();
      _resetToOriginalPosition();
    } else {
      // Slide not completed, animate back to start
      _resetToOriginalPosition();
    }

    setState(() {
      _isDragging = false;
    });
  }

  void _resetToOriginalPosition() {
    _animation = Tween<double>(
      begin: _dragPosition,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.reset();
    _animationController.forward();

    _animation.addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        children: [
          // Background text
          Positioned.fill(
            child: Center(
              child: Text(
                widget.text,
                style: widget.textStyle ??
                    TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          // Slider button
          Positioned(
            left: widget.borderWidth + _dragPosition, // Consistent spacing from border
            top: widget.borderWidth, // Consistent spacing from border
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: widget.sliderWidth,
                height: widget.height - (4 * widget.borderWidth), // Account for top and bottom borders
                decoration: BoxDecoration(
                  color: widget.buttonColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius - 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.buttonText,
                      // style: AppTextStyles.paragraph_2_Regular.copyWith(
                      //   color: AppColors.neutral950,
                      // ),
                      style: widget.textStyle,
                    ),
                    const SizedBox(width: 14),
                    Transform.rotate(
                      angle: 3.14159,
                      child: SvgPicture.asset(
                        AppImages.interfaceArrowsButtonLeftDoubleArrowArrowsDoubleLeftStreamlineCore,
                        color: AppColors.neutral950,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}