import 'package:flutter/material.dart';

class GameObject extends StatefulWidget {
  final String emoji;
  final bool showSuccess;
  final int delay;

  const GameObject({
    super.key,
    required this.emoji,
    this.showSuccess = false,
    this.delay = 0,
  });

  @override
  State<GameObject> createState() => _GameObjectState();
}

class _GameObjectState extends State<GameObject>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(GameObject oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showSuccess && !oldWidget.showSuccess) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward(from: 0);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        double bounce = 0;
        if (widget.showSuccess) {
          bounce = _bounceAnimation.value * -30;
        }
        return Transform.translate(
          offset: Offset(0, bounce),
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.emoji,
            style: const TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }
}
