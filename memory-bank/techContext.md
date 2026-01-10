# Kontekst Techniczny - Przyrodnicy

## Stos technologiczny

### Framework i jezyk
- **Flutter**: Najnowsza stabilna wersja (3.x)
- **Dart**: Jezyk programowania Flutter
- **Platformy**: Android + iOS

### Zaleznosci (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Audio
  audioplayers: ^5.0.0    # Odtwarzanie dzwiekow

  # Opcjonalnie w przyszlosci:
  # flutter_svg: ^2.0.0   # Grafika wektorowa
  # provider: ^6.0.0      # State management (jesli potrzeba)

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0   # Linting
```

### Bez backendu
- Aplikacja dziala w 100% offline
- Brak Supabase, Firebase, ani innych uslug
- Wszystkie dane w lokalnym state

## Srodowisko deweloperskie

### Wymagania systemowe
- **System**: macOS (dostepny)
- **Flutter SDK**: Do zainstalowania/weryfikacji
- **Xcode**: Do budowania iOS
- **Android Studio**: Do budowania Android i emulatorow

### Weryfikacja srodowiska
```bash
# Sprawdz status Flutter
flutter doctor

# Powinno pokazac:
# [✓] Flutter
# [✓] Android toolchain
# [✓] Xcode
# [✓] VS Code lub Android Studio
```

### Komendy deweloperskie

```bash
# Utworz nowy projekt (jesli nie istnieje)
flutter create przyrodnicy

# Uruchom na emulatorze/urzadzeniu
flutter run

# Uruchom na konkretnej platformie
flutter run -d android
flutter run -d ios

# Hot reload (w trakcie dzialania)
r   # w terminalu

# Hot restart
R   # w terminalu

# Build debug
flutter build apk --debug
flutter build ios --debug

# Build release
flutter build apk --release
flutter build ios --release

# Testy
flutter test

# Analiza kodu
flutter analyze

# Formatowanie
dart format lib/
```

## Struktura projektu Flutter

```
przyrodnicy/
├── lib/
│   ├── main.dart                 # Punkt wejscia
│   ├── screens/                  # Ekrany
│   │   ├── splash_screen.dart
│   │   ├── forest_screen.dart
│   │   ├── counting_game_screen.dart
│   │   └── color_match_screen.dart
│   ├── widgets/                  # Komponenty
│   ├── utils/                    # Narzedzia
│   └── models/                   # Modele (opcjonalnie)
├── assets/
│   ├── images/                   # Grafiki
│   └── sounds/                   # Dzwieki
├── android/                      # Android config
├── ios/                          # iOS config
├── test/                         # Testy
├── pubspec.yaml                  # Zaleznosci
└── README.md                     # Dokumentacja
```

## Konfiguracja assetow

### pubspec.yaml
```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/sounds/

  # Opcjonalnie - custom fonts
  # fonts:
  #   - family: Nunito
  #     fonts:
  #       - asset: assets/fonts/Nunito-Regular.ttf
  #       - asset: assets/fonts/Nunito-Bold.ttf
  #         weight: 700
```

### Uzycie assetow w kodzie
```dart
// Obrazki
Image.asset('assets/images/forest_bg.png')

// Dzwieki
await player.play(AssetSource('sounds/success.mp3'));
```

## Konfiguracja Android

### android/app/build.gradle
```gradle
android {
    compileSdkVersion 34

    defaultConfig {
        applicationId "com.example.przyrodnicy"
        minSdkVersion 23        // Android 6.0+
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

### Bez uprawnien sieciowych
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<manifest xmlns:android="...">
    <!-- NIE DODAWAJ: -->
    <!-- <uses-permission android:name="android.permission.INTERNET"/> -->

    <application ...>
        <!-- ... -->
    </application>
</manifest>
```

## Konfiguracja iOS

### ios/Runner/Info.plist
```xml
<!-- Orientacja tylko landscape -->
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationLandscapeLeft</string>
    <string>UIInterfaceOrientationLandscapeRight</string>
</array>
```

### Minimalna wersja iOS
- iOS 12.0+ (domyslna dla Flutter)

## Wzorce kodowania Dart/Flutter

### Formatowanie
```dart
// Uzyj dart format
dart format lib/

// Lub w VS Code: Format Document (Shift+Alt+F)
```

### Import statements
```dart
// Kolejnosc importow:
// 1. Dart SDK
import 'dart:math';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. Zewnetrzne pakiety
import 'package:audioplayers/audioplayers.dart';

// 4. Lokalne pliki
import '../widgets/game_button.dart';
import '../utils/sounds.dart';
```

### Null safety
```dart
// Flutter 3.x wymaga null safety
String? nullableString;  // moze byc null
String nonNullableString = '';  // nie moze byc null

// Sprawdzanie null
if (nullableString != null) {
  print(nullableString!);  // ! = jestem pewien ze nie null
}

// Lub
print(nullableString ?? 'default');  // ?? = wartosc domyslna
```

## Zarzadzanie stanem (MVP)

### Prosty setState
```dart
class _MyScreenState extends State<MyScreen> {
  int counter = 0;

  void _increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$counter');
  }
}
```

### Przyszlosciowo: Provider (jesli potrzeba)
```dart
// Jesli aplikacja sie rozrosnie, mozna dodac Provider
// Ale dla MVP - setState wystarczy
```

## Wydajnosc

### Cele wydajnosciowe
- Start aplikacji: < 3 sekundy
- Animacje: 60 FPS
- Brak lagów przy drag & drop

### Optymalizacje
```dart
// Uzyj const gdzie mozliwe
const Text('Hello');
const SizedBox(height: 16);

// Unikaj niepotrzebnych rebuild
// Wydzielaj widgety do osobnych klas
```

## Debugowanie

### Flutter DevTools
```bash
# Uruchom DevTools
flutter pub global activate devtools
devtools
```

### Logowanie
```dart
// Debug print (tylko w debug mode)
debugPrint('Stan gry: $currentCount');

// Nie uzywaj print() - uzywaj debugPrint()
```

### Hot Reload vs Hot Restart
- **Hot Reload (r)**: Szybkie, zachowuje state
- **Hot Restart (R)**: Resetuje state, wolniejsze

## Testowanie

### Typy testow
```dart
// test/widget_test.dart
testWidgets('Counter increments', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

### Uruchamianie testow
```bash
# Wszystkie testy
flutter test

# Konkretny plik
flutter test test/widget_test.dart

# Z coverage
flutter test --coverage
```

## Zasoby graficzne

### Formaty
- **PNG**: Dla bitmapowych ilustracji
- **SVG**: Dla wektorowych (wymaga flutter_svg)

### Zrodla darmowych grafik
- Freepik.com (z atrybutami)
- unDraw.co (open source)
- Flaticon.com (z atrybutami)
- Tworzenie wlasnych w Figma/Canva

### Specyfikacja grafik
- Rozdzielczosc: 2x i 3x dla roznych ekranow
- Styl: Plaski (flat), przyjazny dzieciom
- Kolory: Paleta naturalna (zielenie, brazy, blekity)

## Zasoby audio

### Formaty
- **MP3**: Uniwersalny, mniejszy rozmiar
- **WAV**: Lepsza jakosc, wiekszy rozmiar

### Wymagane dzwieki
- success.mp3 - radosny dzwiek sukcesu
- try_again.mp3 - lagodna zacheta
- tap.mp3 - dzwiek dotkniecia (opcjonalnie)
- background.mp3 - muzyka tla (opcjonalnie)

### Zrodla darmowych dzwiekow
- Freesound.org (Creative Commons)
- Zapsplat.com (darmowe z rejestracją)

## Zmienne srodowiskowe

### Nie potrzebne w MVP
Aplikacja nie uzywa backendu ani zewnetrznych API, wiec nie ma zmiennych srodowiskowych.

## Wersjonowanie

### Semantic Versioning
```
MAJOR.MINOR.PATCH
1.0.0 - pierwsza wersja MVP
1.1.0 - nowa funkcjonalnosc
1.1.1 - bugfix
```

### pubspec.yaml
```yaml
name: przyrodnicy
description: Edukacyjna aplikacja dla dzieci
version: 0.1.0+1  # version + build number
```

## CI/CD

### Nie w MVP
Dla prywatnego projektu edukacyjnego CI/CD nie jest priorytetem.

### Przyszlosciowo (opcjonalnie)
- GitHub Actions dla testow
- Fastlane dla deploymentu
