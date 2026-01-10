import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class HomeButton extends StatefulWidget {
  final VoidCallback onTap;

  const HomeButton({super.key, required this.onTap});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.cream,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.forestGreen,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: _isPressed ? 2 : 8,
                offset: Offset(0, _isPressed ? 2 : 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '🏠',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
