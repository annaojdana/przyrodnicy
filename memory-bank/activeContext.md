# Aktywny Kontekst - Przyrodnicy

## Aktualny fokus pracy

### Stan: MVP zaimplementowane
Wszystkie glowne ekrany i gry MVP zostaly zaimplementowane. Aplikacja buduje sie poprawnie.

## Co zostalo zrobione

### Sesja 2 (2026-01-10) - /first-prompt
- Zainstalowano Flutter SDK 3.27.2
- Utworzono projekt Flutter
- Zaimplementowano wszystkie ekrany MVP:
  - Splash Screen (animowany ekran powitalny)
  - Forest Screen (interaktywny las z polanami)
  - Counting Game (gra Liczenie 1-5)
  - Color Match Game (gra Dopasuj kolory - drag & drop)
- Utworzono widgety pomocnicze:
  - HomeButton (przycisk powrotu)
  - ForestClearing (polana w lesie)
  - GameObject (obiekt do liczenia)
  - AnswerButton (przycisk odpowiedzi)
- Build web zakonczony sukcesem

## Nastepne kroki

### Krotkoterminowe
1. Dodac dzwieki (sukces, zacheta)
2. Testowac na emulatorze Android/iOS
3. Skonfigurowac Android SDK (flutter doctor pokazuje brak)
4. Zainstalowac CocoaPods dla iOS

### Sredniokresowe
1. Dodac wiecej obiektow/przedmiotow do gier
2. Poprawic animacje
3. Dodac grafiki (zamiast emoji)
4. Testowac z dziecmi

## Struktura projektu

```
lib/
├── main.dart
├── screens/
│   ├── splash_screen.dart
│   ├── forest_screen.dart
│   ├── counting_game_screen.dart
│   └── color_match_screen.dart
├── widgets/
│   ├── home_button.dart
│   ├── forest_clearing.dart
│   ├── game_object.dart
│   └── answer_button.dart
└── utils/
    └── app_colors.dart
```

## Decyzje podjete

### Grafika
- [x] Uzyto emoji zamiast grafik (prostsze na start)
- Mozna pozniej zastapic prawdziwymi ilustracjami

### State Management
- [x] Uzyto setState - wystarczajace dla MVP

### Struktura projektu
- [x] screens/, widgets/, utils/ - prosta i czytelna

## Kontekst techniczny

### Srodowisko
- System: macOS (Darwin)
- Flutter: 3.27.2 (zainstalowany w ~/flutter)
- PATH: Dodano do ~/.zshrc

### Flutter Doctor Status
- [OK] Flutter
- [!] Android toolchain - brak Android SDK
- [!] Xcode - brak CocoaPods
- [OK] Chrome
- [OK] VS Code

### Repozytorium
- Remote: https://github.com/annaojdana/przyrodnicy.git
- Branch: main
- Stan: Kod zaimplementowany, nie scommitowany

## Notatki z sesji

### Sesja 1 (2026-01-10)
- Przeprowadzono wywiad projektowy
- Ustalono nazwe: Przyrodnicy
- Utworzono Memory Bank
- Skonfigurowano Git

### Sesja 2 (2026-01-10)
- Zainstalowano Flutter
- Zaimplementowano cale MVP
- Build web OK

## Znane problemy

### Do naprawienia
- Ostrzezenia o deprecated `withOpacity` (info tylko, nie blokuje)
- Brak Android SDK (potrzebny do testow na Android)
- Brak CocoaPods (potrzebny do budowy iOS)

### Nie blokujace
- Aplikacja uzywa emoji zamiast grafik (zamierzone dla MVP)
