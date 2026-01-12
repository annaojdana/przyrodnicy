# Przyrodnicy

Edukacyjna aplikacja mobilna dla dzieci w wieku 3-7 lat. Dzieci eksplorują interaktywny las i uczą się podstaw: liczenia, rozpoznawania kolorów i przyrody.

## Funkcje

- **Interaktywny las** - główny hub z animowanymi elementami
- **Gra: Liczenie obiektów** - dziecko liczy elementy przyrody i wybiera poprawną cyfrę
- **Gra: Dopasuj kolory** - przeciąganie kolorowych przedmiotów do odpowiednich koszyków

## Cechy

- Bez reklam i płatności
- Działa offline
- Duże elementy dotykowe dla małych dzieci
- Komunikacja przez ikony (bez tekstu)
- Pozytywne wzmocnienie - błędy nie są karane
- Orientacja pozioma (landscape)

## Wymagania

- Flutter SDK 3.27+
- Android SDK (dla buildu Android)
- Xcode (dla buildu iOS)

## Uruchomienie

```bash
# Sprawdź środowisko
flutter doctor

# Pobierz zależności
flutter pub get

# Uruchom aplikację
flutter run
```

## Build

```bash
# Android APK (debug)
flutter build apk --debug

# Android APK (release)
flutter build apk --release

# iOS
flutter build ios
```

Plik APK znajdziesz w: `build/app/outputs/flutter-apk/`

## Struktura projektu

```
lib/
  main.dart           # Punkt wejścia aplikacji
  screens/            # Ekrany (splash, las, gry)
  widgets/            # Komponenty UI
  utils/              # Funkcje pomocnicze
assets/
  images/             # Grafiki
  sounds/             # Dźwięki
```

## Tech Stack

- Flutter / Dart
- Android + iOS
- Lokalny state (bez backendu)

## Licencja

Projekt prywatny - do użytku rodzinnego.
