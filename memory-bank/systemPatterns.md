# Wzorce Systemowe - Przyrodnicy

## Przeglad architektury

### Architektura aplikacji Flutter
- **Typ**: Aplikacja mobilna (Android + iOS)
- **Framework**: Flutter z Dart
- **State Management**: setState (MVP), mozliwosc migracji do Provider
- **Nawigacja**: Navigator 2.0 lub go_router
- **Dane**: Lokalny state, bez backendu

## Struktura projektu Flutter

```
przyrodnicy/
├── lib/
│   ├── main.dart              # Punkt wejscia aplikacji
│   ├── screens/               # Ekrany aplikacji
│   │   ├── splash_screen.dart
│   │   ├── forest_screen.dart
│   │   ├── counting_game_screen.dart
│   │   └── color_match_screen.dart
│   ├── widgets/               # Komponenty UI
│   │   ├── game_button.dart
│   │   ├── home_button.dart
│   │   ├── forest_clearing.dart
│   │   └── draggable_item.dart
│   ├── utils/                 # Funkcje pomocnicze
│   │   ├── sounds.dart
│   │   └── colors.dart
│   └── models/                # Modele danych (jesli potrzebne)
│       └── game_state.dart
├── assets/
│   ├── images/               # Grafiki PNG/SVG
│   ├── sounds/               # Dzwieki MP3/WAV
│   └── fonts/                # Czcionki (opcjonalnie)
├── android/                  # Konfiguracja Android
├── ios/                      # Konfiguracja iOS
├── test/                     # Testy
└── pubspec.yaml             # Zaleznosci
```

## Wzorce Flutter

### Wzorzec 1: StatefulWidget dla gier

```dart
class CountingGameScreen extends StatefulWidget {
  @override
  _CountingGameScreenState createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen> {
  int currentCount = 0;
  List<int> options = [];

  @override
  void initState() {
    super.initState();
    _generateNewRound();
  }

  void _generateNewRound() {
    setState(() {
      currentCount = Random().nextInt(5) + 1;
      options = _generateOptions(currentCount);
    });
  }

  void _checkAnswer(int selected) {
    if (selected == currentCount) {
      _playSuccessSound();
      _generateNewRound();
    } else {
      _playTryAgainSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ... UI
          ],
        ),
      ),
    );
  }
}
```

### Wzorzec 2: Nawigacja miedzy ekranami

```dart
// Przejscie do gry
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => CountingGameScreen()),
);

// Powrot do lasu (glownego ekranu)
Navigator.pop(context);

// Lub z animacja
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
      CountingGameScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
);
```

### Wzorzec 3: Drag and Drop dla dzieci

```dart
class DraggableColorItem extends StatelessWidget {
  final String color;
  final String itemType;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: color,
      feedback: Material(
        elevation: 4,
        child: _buildItem(scale: 1.1),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItem(),
      ),
      child: _buildItem(),
    );
  }
}

class ColorDropTarget extends StatelessWidget {
  final String targetColor;
  final Function(String) onCorrectDrop;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (data) {
        if (data == targetColor) {
          onCorrectDrop(data);
        }
      },
      onWillAccept: (data) => true,
      builder: (context, candidateData, rejectedData) {
        return Container(
          // ... UI pudelka
        );
      },
    );
  }
}
```

### Wzorzec 4: Odtwarzanie dzwiekow

```dart
import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSuccess() async {
    await _player.play(AssetSource('sounds/success.mp3'));
  }

  static Future<void> playTryAgain() async {
    await _player.play(AssetSource('sounds/try_again.mp3'));
  }

  static Future<void> playTap() async {
    await _player.play(AssetSource('sounds/tap.mp3'));
  }
}
```

## Konwencje nazewnictwa

### Pliki
- Nazwy plikow: snake_case (`counting_game_screen.dart`)
- Klasy: PascalCase (`CountingGameScreen`)
- Zmienne/funkcje: camelCase (`currentCount`, `generateNewRound`)
- Stale: SCREAMING_SNAKE_CASE lub camelCase z `const`

### Ekrany vs Widgety
- `screens/` - pelnoekranowe widoki (Scaffold)
- `widgets/` - komponenty wielokrotnego uzytku

### Nazwy ekranow
- `XxxScreen` - pelny ekran
- `XxxWidget` - komponent
- `XxxButton` - przycisk
- `XxxDialog` - dialog

## Wzorce UI/UX dla dzieci

### Rozmiary dotykowe
```dart
// Minimalne rozmiary przyciskow dla dzieci
const double minTouchTarget = 64.0; // wieksze niz standardowe 48

// Przyklad przycisku
SizedBox(
  width: 80,
  height: 80,
  child: ElevatedButton(
    onPressed: () {},
    child: Text('1'),
  ),
)
```

### Kolory projektu
```dart
class AppColors {
  static const Color forestGreen = Color(0xFF4A7C59);
  static const Color lightGreen = Color(0xFF8FBC8F);
  static const Color brown = Color(0xFF8B4513);
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color cream = Color(0xFFFFF8DC);
  static const Color gold = Color(0xFFFFD700);

  // Kolory do gry
  static const Color red = Color(0xFFE74C3C);
  static const Color blue = Color(0xFF3498DB);
  static const Color yellow = Color(0xFFF1C40F);
  static const Color green = Color(0xFF2ECC71);
}
```

### Animacje
```dart
// Animacja sukcesu - "taniec" obiektu
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.elasticOut,
  transform: Matrix4.identity()..scale(isSuccess ? 1.2 : 1.0),
  child: child,
)

// Animacja bledu - potrzasniecie
AnimatedBuilder(
  animation: _shakeController,
  builder: (context, child) {
    return Transform.translate(
      offset: Offset(sin(_shakeController.value * pi * 4) * 10, 0),
      child: child,
    );
  },
)
```

## Obsluga bledow

### Zasady
- Bledy uzytkownika (bledna odpowiedz) - NIE sa bledami technicznymi
- Bledy techniczne - logowac do konsoli, nie pokazywac uzytkownikowi
- Dziecko nigdy nie powinno widziec komunikatu o bledzie

### Przyklad
```dart
void _loadSound() async {
  try {
    await _player.setSource(AssetSource('sounds/success.mp3'));
  } catch (e) {
    // Log do debug, nie pokazuj uzytkownikowi
    debugPrint('Failed to load sound: $e');
    // Aplikacja dziala dalej bez dzwieku
  }
}
```

## Testowanie

### Struktura testow
```
test/
├── widget_test.dart           # Podstawowe testy widgetow
├── screens/
│   ├── counting_game_test.dart
│   └── color_match_test.dart
└── utils/
    └── game_logic_test.dart
```

### Przyklad testu
```dart
testWidgets('Counting game shows correct number of objects', (tester) async {
  await tester.pumpWidget(MaterialApp(home: CountingGameScreen()));

  // Sprawdz czy sa obiekty na ekranie
  expect(find.byType(GameObject), findsWidgets);
});
```

## Zasady jakosci kodu

### KISS (Keep It Simple)
- Proste rozwiazania sa lepsze
- Unikaj przedwczesnej optymalizacji
- Jeden plik moze miec wiele klas jesli sa powiazane

### DRY (Don't Repeat Yourself)
- Wspolne style do osobnych klas
- Wspolna logika do funkcji pomocniczych
- Ale nie przesadzaj z abstrakcja w MVP

### YAGNI (You Aren't Gonna Need It)
- Nie dodawaj funkcji "na przyszlosc"
- Implementuj tylko to co jest w MVP
- Refaktoryzuj gdy faktycznie potrzeba

## Bezpieczenstwo

### Brak dostepu do sieci
```yaml
# pubspec.yaml - NIE dodawaj http, dio, itp.
dependencies:
  flutter:
    sdk: flutter
  audioplayers: ^5.0.0
  # Brak pakietow sieciowych
```

### Brak uprawnien
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<!-- NIE dodawaj: INTERNET, ACCESS_NETWORK_STATE, itp. -->
```

## Orientacja ekranu

```dart
// main.dart - wymuszenie orientacji poziomej
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}
```
