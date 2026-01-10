import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AnswerButton extends StatefulWidget {
  final int number;
  final VoidCallback onTap;
  final bool isCorrect;
  final double? size;

  const AnswerButton({
    super.key,
    required this.number,
    required this.onTap,
    this.isCorrect = false,
    this.size,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final buttonSize = widget.size ?? 100.0;
    final fontSize = buttonSize * 0.48;
    final borderRadius = buttonSize * 0.2;
    final borderWidth = buttonSize > 70 ? 4.0 : 3.0;

    Color bgColor = AppColors.cream;
    if (widget.isCorrect) {
      bgColor = AppColors.gold;
    }

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: AppColors.forestGreen,
              width: borderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: _isPressed ? 4 : 10,
                offset: Offset(0, _isPressed ? 2 : 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${widget.number}',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.forestGreen,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
