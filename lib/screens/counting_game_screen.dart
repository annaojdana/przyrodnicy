import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/home_button.dart';
import '../widgets/game_object.dart';
import '../widgets/answer_button.dart';

class CountingGameScreen extends StatefulWidget {
  const CountingGameScreen({super.key});

  @override
  State<CountingGameScreen> createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen>
    with TickerProviderStateMixin {
  final Random _random = Random();

  int _currentCount = 0;
  List<int> _options = [];
  int _correctAnswer = 0;

  bool _showSuccess = false;
  bool _showTryAgain = false;

  late AnimationController _successController;
  late AnimationController _shakeController;

  // Lista obiektow przyrodniczych
  final List<String> _objects = ['🍎', '🌸', '🦋', '🐞', '🌻', '🍄', '🌺', '🍀'];
  String _currentObject = '🍎';

  @override
  void initState() {
    super.initState();

    _successController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _generateNewRound();
  }

  @override
  void dispose() {
    _successController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _generateNewRound() {
    setState(() {
      _currentCount = _random.nextInt(5) + 1; // 1-5 obiektow
      _correctAnswer = _currentCount;
      _currentObject = _objects[_random.nextInt(_objects.length)];
      _showSuccess = false;
      _showTryAgain = false;

      // Generuj 3 opcje (wlaczajac poprawna odpowiedz)
      Set<int> optionsSet = {_correctAnswer};
      while (optionsSet.length < 3) {
        int option = _random.nextInt(5) + 1;
        optionsSet.add(option);
      }
      _options = optionsSet.toList()..shuffle();
    });
  }

  void _checkAnswer(int selected) {
    if (_showSuccess) return; // Ignoruj klikniecia podczas animacji

    if (selected == _correctAnswer) {
      // Poprawna odpowiedz!
      setState(() => _showSuccess = true);
      _successController.forward(from: 0);

      // Przejdz do nowej rundy po animacji
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _generateNewRound();
        }
      });
    } else {
      // Bledna odpowiedz
      setState(() => _showTryAgain = true);
      _shakeController.forward(from: 0).then((_) {
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
              Color(0xFFE8F5E9), // Bardzo jasna zielen
              Color(0xFFC8E6C9), // Jasna zielen
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Gorny pasek z przyciskiem powrotu
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    HomeButton(onTap: () => Navigator.of(context).pop()),
                    const Spacer(),
                    // Wskazowka
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Policz i wybierz!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.forestGreen,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 60), // Balans dla przycisku home
                  ],
                ),
              ),

              // Obszar z obiektami do policzenia
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      double shake = 0;
                      if (_showTryAgain) {
                        shake = sin(_shakeController.value * pi * 4) * 10;
                      }
                      return Transform.translate(
                        offset: Offset(shake, 0),
                        child: child,
                      );
                    },
                    child: AnimatedBuilder(
                      animation: _successController,
                      builder: (context, child) {
                        double scale = 1.0;
                        if (_showSuccess) {
                          scale = 1.0 + sin(_successController.value * pi) * 0.2;
                        }
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(_currentCount, (index) {
                          return GameObject(
                            emoji: _currentObject,
                            showSuccess: _showSuccess,
                            delay: index * 100,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),

              // Komunikat sukcesu
              if (_showSuccess)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '🎉 Brawo! 🎉',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                ),

              // Komunikat "sprobuj jeszcze raz"
              if (_showTryAgain)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Spróbuj jeszcze raz! 💪',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brown,
                    ),
                  ),
                ),

              // Przyciski z odpowiedziami
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _options.map((option) {
                      return AnswerButton(
                        number: option,
                        onTap: () => _checkAnswer(option),
                        isCorrect: _showSuccess && option == _correctAnswer,
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
