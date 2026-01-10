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

  // Dostepne kolory
  final Map<String, Color> _colors = {
    'red': AppColors.red,
    'blue': AppColors.blue,
    'yellow': AppColors.yellow,
    'green': AppColors.green,
  };

  // Przedmioty z kolorami
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

  // Stan przeciagania (nieuzywane w MVP, ale przygotowane na przyszlosc)
  // ignore: unused_field
  bool _isDragging = false;

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
      // Losuj kolor
      List<String> colorKeys = _colors.keys.toList();
      _currentColor = colorKeys[_random.nextInt(colorKeys.length)];

      // Losuj przedmiot z tego koloru
      List<String> items = _itemsByColor[_currentColor]!;
      _currentItem = items[_random.nextInt(items.length)];

      _showSuccess = false;
      _showTryAgain = false;
      _isDragging = false;
    });
  }

  void _onDragEnd(String targetColor) {
    setState(() {
      _isDragging = false;
    });

    if (targetColor == _currentColor) {
      // Poprawne dopasowanie!
      setState(() {
        _showSuccess = true;
        _score++;
      });
      _successController.forward(from: 0);

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          _generateNewItem();
        }
      });
    } else {
      // Bledne dopasowanie
      setState(() {
        _showTryAgain = true;
      });
      _bounceController.forward(from: 0).then((_) {
        if (mounted) {
          setState(() => _showTryAgain = false);
        }
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
            colors: [
              Color(0xFFFFF8E1), // Jasny kremowy
              Color(0xFFFFECB3), // Cieplejszy kremowy
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Gorny pasek
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    HomeButton(onTap: () => Navigator.of(context).pop()),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '⭐ $_score',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),

              // Kolorowe kosze (gora)
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _colors.entries.map((entry) {
                      return _buildColorBasket(entry.key, entry.value);
                    }).toList(),
                  ),
                ),
              ),

              // Komunikaty
              if (_showSuccess)
                AnimatedBuilder(
                  animation: _successController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + _successController.value * 0.2,
                      child: child,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '🎉 Świetnie! 🎉',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                ),

              if (_showTryAgain)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Spróbuj inny kolor! 🤔',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                    ),
                  ),
                ),

              // Przedmiot do przeciagniecia (dol)
              Expanded(
                flex: 2,
                child: Center(
                  child: _buildDraggableItem(),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorBasket(String colorName, Color color) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        _onDragEnd(colorName);
      },
      builder: (context, candidateData, rejectedData) {
        bool isHighlighted = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isHighlighted ? 100 : 90,
          height: isHighlighted ? 120 : 110,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            border: Border.all(
              color: isHighlighted ? Colors.white : Colors.black26,
              width: isHighlighted ? 4 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(isHighlighted ? 0.6 : 0.3),
                blurRadius: isHighlighted ? 20 : 10,
                spreadRadius: isHighlighted ? 5 : 0,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '🧺',
              style: TextStyle(fontSize: 40),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDraggableItem() {
    if (_showSuccess) {
      return const SizedBox.shrink();
    }

    return Draggable<String>(
      data: _currentColor,
      onDragStarted: () {
        setState(() {
          _isDragging = true;
        });
      },
      onDragEnd: (details) {
        setState(() {
          _isDragging = false;
        });
      },
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _colors[_currentColor]!.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              _currentItem,
              style: const TextStyle(fontSize: 70),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItemContainer(),
      ),
      child: AnimatedBuilder(
        animation: _bounceController,
        builder: (context, child) {
          double shake = 0;
          if (_showTryAgain) {
            shake = sin(_bounceController.value * pi * 4) * 10;
          }
          return Transform.translate(
            offset: Offset(shake, 0),
            child: child,
          );
        },
        child: _buildItemContainer(),
      ),
    );
  }

  Widget _buildItemContainer() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: _colors[_currentColor]!,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: _colors[_currentColor]!.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _currentItem,
          style: const TextStyle(fontSize: 70),
        ),
      ),
    );
  }
}
