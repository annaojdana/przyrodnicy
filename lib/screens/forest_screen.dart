import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/forest_clearing.dart';
import 'counting_game_screen.dart';
import 'color_match_screen.dart';

class ForestScreen extends StatefulWidget {
  const ForestScreen({super.key});

  @override
  State<ForestScreen> createState() => _ForestScreenState();
}

class _ForestScreenState extends State<ForestScreen>
    with TickerProviderStateMixin {
  late AnimationController _cloudController;
  late AnimationController _leavesController;

  @override
  void initState() {
    super.initState();

    // Animacja chmur
    _cloudController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Animacja lisci
    _leavesController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cloudController.dispose();
    _leavesController.dispose();
    super.dispose();
  }

  void _navigateToCountingGame() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CountingGameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToColorGame() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ColorMatchScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Tlo - gradient nieba
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF87CEEB), // Jasne niebo
                  Color(0xFFB0E0E6), // Jasnoniebieskie
                ],
                stops: [0.0, 0.6],
              ),
            ),
          ),

          // Animowane chmury
          AnimatedBuilder(
            animation: _cloudController,
            builder: (context, child) {
              return Positioned(
                top: 30,
                left: -100 + (_cloudController.value * 500),
                child: Opacity(
                  opacity: 0.8,
                  child: Text(
                    '☁️',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _cloudController,
            builder: (context, child) {
              return Positioned(
                top: 80,
                right: -100 + (_cloudController.value * 400),
                child: Opacity(
                  opacity: 0.6,
                  child: Text(
                    '☁️',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              );
            },
          ),

          // Slonce
          Positioned(
            top: 20,
            right: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // Tlo lasu - trawa i drzewa
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8FBC8F), // Jasna zielen
                    Color(0xFF4A7C59), // Ciemna zielen
                  ],
                ),
              ),
            ),
          ),

          // Drzewa w tle
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            left: 20,
            child: _buildTree(120),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.4,
            right: 40,
            child: _buildTree(100),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.38,
            left: MediaQuery.of(context).size.width * 0.3,
            child: _buildTree(140),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            right: MediaQuery.of(context).size.width * 0.25,
            child: _buildTree(110),
          ),

          // Animowane liscie
          AnimatedBuilder(
            animation: _leavesController,
            builder: (context, child) {
              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.3 +
                    (_leavesController.value * 10),
                left: 50,
                child: Opacity(
                  opacity: 0.7,
                  child: Text('🍃', style: TextStyle(fontSize: 30)),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _leavesController,
            builder: (context, child) {
              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35 -
                    (_leavesController.value * 8),
                right: 80,
                child: Opacity(
                  opacity: 0.6,
                  child: Text('🍂', style: TextStyle(fontSize: 25)),
                ),
              );
            },
          ),

          // Polany (przyciski do gier)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.15,
            child: ForestClearing(
              icon: '🔢',
              label: 'Liczenie',
              color: AppColors.gold,
              onTap: _navigateToCountingGame,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.width * 0.15,
            child: ForestClearing(
              icon: '🎨',
              label: 'Kolory',
              color: AppColors.red,
              onTap: _navigateToColorGame,
            ),
          ),

          // Ptaki
          Positioned(
            top: 100,
            left: 100,
            child: Text('🐦', style: TextStyle(fontSize: 25)),
          ),
          Positioned(
            top: 120,
            left: 140,
            child: Text('🐦', style: TextStyle(fontSize: 20)),
          ),

          // Motyle
          AnimatedBuilder(
            animation: _leavesController,
            builder: (context, child) {
              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.4 +
                    (_leavesController.value * 15),
                left: MediaQuery.of(context).size.width * 0.5 +
                    (_leavesController.value * 20),
                child: Text('🦋', style: TextStyle(fontSize: 30)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTree(double height) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Korona drzewa
        Container(
          width: height * 0.8,
          height: height * 0.6,
          decoration: BoxDecoration(
            color: AppColors.forestGreen,
            borderRadius: BorderRadius.circular(height * 0.4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
        ),
        // Pien
        Container(
          width: height * 0.15,
          height: height * 0.3,
          decoration: BoxDecoration(
            color: AppColors.brown,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
