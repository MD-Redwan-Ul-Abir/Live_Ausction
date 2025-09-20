import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onStart;
  final VoidCallback? onComplete;
  final VoidCallback? onReset;
  final double? size;
  final double? strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle? textStyle;

  const CountdownTimer({
    Key? key,
    required this.initialSeconds,
    this.onStart,
    this.onComplete,
    this.onReset,
    this.size,
    this.strokeWidth,
    this.progressColor = Colors.amber,
    this.backgroundColor = Colors.grey,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _timer;
  int _currentSeconds = 0;
  bool _isRunning = false;
  bool _isIdle = true; // Track idle state

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.initialSeconds;

    _animationController = AnimationController(
      duration: Duration(seconds: widget.initialSeconds),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSeconds != widget.initialSeconds) {
      _resetTimer();
    }
  }

  // Public method to start timer from external button
  void start() {
    startTimer();
  }

  // Public method to reset timer from external button
  void reset() {
    _resetTimer();
  }

  // Public method to pause timer
  void pause() {
    if (_isRunning) {
      _timer?.cancel();
      _animationController.stop();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _isIdle = false; // No longer idle when started
    });

    widget.onStart?.call();

    // Start the circular animation
    _animationController.forward();

    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          _completeTimer();
        }
      });
    });
  }

  void _completeTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });

    widget.onComplete?.call();

    // Auto reset after completion
    Future.delayed(const Duration(milliseconds: 500), () {
      _resetTimer();
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _animationController.reset();

    setState(() {
      _currentSeconds = widget.initialSeconds;
      _isRunning = false;
      _isIdle = true; // Back to idle state after reset
    });

    widget.onReset?.call();
  }

  String _formatTime(int seconds) {
    if (seconds >= 60) {
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      return '${minutes}m ${remainingSeconds}s';
    } else {
      return '${seconds} sec';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerSize = widget.size ?? 200.w;
    final calculatedStrokeWidth = widget.strokeWidth ?? (timerSize * 0.06);

    return Container(
      width: timerSize,
      height: timerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: timerSize,
            height: timerSize,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: calculatedStrokeWidth,
              backgroundColor: widget.backgroundColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.backgroundColor.withOpacity(0.3),
              ),
            ),
          ),
          // Animated progress circle
          SizedBox(
            width: timerSize,
            height: timerSize,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: _animation.value,
                  strokeWidth: calculatedStrokeWidth,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
                  strokeCap: StrokeCap.round,
                );
              },
            ),
          ),
          // Center content - Show "Start" when idle, otherwise show timer
          Text(
            _isIdle ? 'Start' : _formatTime(_currentSeconds),
            style: widget.textStyle ??
                TextStyle(
                  fontSize: (timerSize * 0.12).sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}