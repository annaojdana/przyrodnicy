import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Wymusz orientacje pozioma (landscape) - lepsza dla dzieci
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Ukryj pasek systemowy dla pelnoekranowego doswiadczenia
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const PrzyrodnicyApp());
}

class PrzyrodnicyApp extends StatelessWidget {
  const PrzyrodnicyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Przyrodnicy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A7C59), // Forest green
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
