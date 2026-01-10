import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/home_button.dart';

class ColorMatchScreen extends StatefulWidget {
  const ColorMatchScreen({super.key});

  @override
  State<ColorMatchScreen> createState() => _ColorMatchScreenState();
}

class _ColorMatchScreenState extends State<ColorMatchScreen>
    with TickerProviderStateMixin {
  final Random _random = Random();

  late AnimationController _successController;
  late AnimationController _bounceController;

  final Map<String, Color> _colors = {
    'red': AppColors.red,
    'blue': AppColors.blue,
    'yellow': AppColors.yellow,
    'green': AppColors.green,
  };

  final Map<String, List<String>> _itemsByColor = {
    'red': ['🍎', '🍓', '🌹', '❤️', '🍒'],
    'blue': ['🫐', '🦋', '💙', '🐳', '💎'],
    'yellow': ['🌻', '⭐', '🍋', '💛', '🌙'],
    'green': ['🍀', '🥒', '🥝', '💚', '🌿'],
  };

  String _currentColor = 'red';
  String _currentItem = '🍎';
  bool _showSuccess = false;
  bool _showTryAgain = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _generateNewItem();
  }

  @override
  void dispose() {
    _successController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _generateNewItem() {
    setState(() {
      List<String> colorKeys = _colors.keys.toList();
      _currentColor = colorKeys[_random.nextInt(colorKeys.length)];
      List<String> items = _itemsByColor[_currentColor]!;
      _currentItem = items[_random.nextInt(items.length)];
      _showSuccess = false;
      _showTryAgain = false;
    });
  }

  void _onDragEnd(String targetColor) {
    if (targetColor == _currentColor) {
      setState(() {
        _showSuccess = true;
        _score++;
      });
      _successController.forward(from: 0);
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) _generateNewItem();
      });
    } else {
      setState(() => _showTryAgain = true);
      _bounceController.forward(from: 0).then((_) {
        if (mounted) setState(() => _showTryAgain = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsywne rozmiary
              final screenWidth = constraints.maxWidth;
              final isSmallScreen = screenWidth < 400;

              final basketSize = isSmallScreen
                  ? (screenWidth - 40) / 4 - 8 // 4 kosze z marginesami
                  : 80.0;
              final itemSize = isSmallScreen ? 80.0 : 100.0;
              final fontSize = isSmallScreen ? 40.0 : 50.0;

              final buttonSize = isSmallScreen ? 45.0 : 60.0;

              return Column(
                children: [
                  // Gorny pasek
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeButton(
                          onTap: () => Navigator.of(context).pop(),
                          size: buttonSize,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 10 : 16,
                            vertical: isSmallScreen ? 6 : 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '⭐ $_score',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                        SizedBox(width: buttonSize),
                      ],
                    ),
                  ),

                  // Kolorowe kosze
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _colors.entries.map((entry) {
                          return _buildColorBasket(
                            entry.key,
                            entry.value,
                            basketSize,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Komunikaty
                  SizedBox(
                    height: 50,
                    child: _showSuccess
                        ? AnimatedBuilder(
                            animation: _successController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1.0 + _successController.value * 0.2,
                                child: child,
                              );
                            },
                            child: Text(
                              '🎉 Świetnie! 🎉',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gold,
                              ),
                            ),
                          )
                        : _showTryAgain
                            ? Text(
                                'Spróbuj jeszcze! 🤔',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 18 : 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.brown,
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),

                  // Przedmiot do przeciagniecia
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: _buildDraggableItem(itemSize, fontSize),
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 10 : 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColorBasket(String colorName, Color color, double size) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => _onDragEnd(colorName),
      builder: (context, candidateData, rejectedData) {
        bool isHighlighted = candidateData.isNotEmpty;
        final displaySize = isHighlighted ? size * 1.1 : size;
        final emojiSize = size * 0.45;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: displaySize,
          height: displaySize * 1.2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size * 0.12),
              topRight: Radius.circular(size * 0.12),
              bottomLeft: Radius.circular(size * 0.35),
              bottomRight: Radius.circular(size * 0.35),
            ),
            border: Border.all(
              color: isHighlighted ? Colors.white : Colors.black26,
              width: isHighlighted ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: isHighlighted ? 0.6 : 0.3),
                blurRadius: isHighlighted ? 15 : 8,
                spreadRadius: isHighlighted ? 3 : 0,
              ),
            ],
          ),
          child: Center(
            child: Text('🧺', style: TextStyle(fontSize: emojiSize)),
          ),
        );
      },
    );
  }

  Widget _buildDraggableItem(double size, double fontSize) {
    if (_showSuccess) return const SizedBox.shrink();

    return Draggable<String>(
      data: _currentColor,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _colors[_currentColor]!.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(_currentItem, style: TextStyle(fontSize: fontSize)),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItemContainer(size, fontSize),
      ),
      child: AnimatedBuilder(
        animation: _bounceController,
        builder: (context, child) {
          double shake = 0;
          if (_showTryAgain) {
            shake = sin(_bounceController.value * pi * 4) * 10;
          }
          return Transform.translate(offset: Offset(shake, 0), child: child);
        },
        child: _buildItemContainer(size, fontSize),
      ),
    );
  }

  Widget _buildItemContainer(double size, double fontSize) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: _colors[_currentColor]!, width: 4),
        boxShadow: [
          BoxShadow(
            color: _colors[_currentColor]!.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(_currentItem, style: TextStyle(fontSize: fontSize)),
      ),
    );
  }
}
