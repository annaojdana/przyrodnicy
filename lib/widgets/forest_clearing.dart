import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ForestClearing extends StatefulWidget {
  final String icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final double? size;

  const ForestClearing({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.size,
  });

  @override
  State<ForestClearing> createState() => _ForestClearingState();
}

class _ForestClearingState extends State<ForestClearing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final clearingSize = widget.size ?? 140.0;
    final iconSize = clearingSize * 0.36;
    final labelSize = clearingSize * 0.115;
    final borderWidth = clearingSize > 100 ? 4.0 : 3.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          width: clearingSize,
          height: clearingSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                widget.color.withValues(alpha: 0.3),
                AppColors.lightGreen,
                AppColors.forestGreen,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
            border: Border.all(
              color: widget.color,
              width: borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.4),
                blurRadius: _isPressed ? 5 : 15,
                spreadRadius: _isPressed ? 0 : 5,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.icon,
                style: TextStyle(fontSize: iconSize),
              ),
              SizedBox(height: clearingSize * 0.035),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: labelSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.cream,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 3,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
