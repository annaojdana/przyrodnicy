# CLAUDE.md

## Instrukcje Memory Bank
**Na poczatku kazdej sesji MUSISZ przeczytac memory-bank/handbook.md i wszystkie pliki z memory-bank/.**

## Podstawowe zasady

- Zawsze zacznij od planu przed implementacja (kontynuuj gdy jestes pewien)
- TDD jest obowiazkowe: cala logika musi byc pokryta testami przed finalizacja
- Utrzymuj kod prosty i czytelny: stosuj KISS, SOLID, DRY, unikaj over-engineeringu
- Commituj czesto z jasnymi opisami
- Wycofaj zmiany jesli bledy sie powtarzaja lub powstaja petle
- Utrzymuj CLAUDE.md zwiezle - szczegoly w memory-bank/
- Weryfikuj plany i kod z uzytkownikiem na kluczowych etapach
- Memory Bank to zrodlo prawdy - zawsze aktualizuj

## Polityka TDD

**Cykl Red-Green-Refactor:**
1. RED - Napisz test ktory nie przechodzi
2. GREEN - Napisz minimalny kod aby test przeszedl
3. REFACTOR - Posprzataj kod zachowujac zielone testy

## Projekt: Przyrodnicy

Aplikacja mobilna Flutter dla dzieci 3-7 lat z grami edukacyjnymi.

### Tech Stack
- Flutter/Dart
- Android + iOS
- Brak backendu (lokalny state)

### MVP Scope
- Ekran powitalny
- Interaktywny las (glowny hub)
- Gra: Liczenie obiektow
- Gra: Dopasuj kolory

### Komendy

```bash
flutter doctor          # Sprawdz srodowisko
flutter run             # Uruchom aplikacje
flutter test            # Uruchom testy
flutter analyze         # Analiza kodu
flutter build apk       # Build Android
flutter build ios       # Build iOS
```

### Struktura projektu

```
lib/
  main.dart
  screens/    # Ekrany (Scaffold)
  widgets/    # Komponenty UI
  utils/      # Pomocnicze funkcje
assets/
  images/     # Grafiki
  sounds/     # Dzwieki
```

## Zasady dla dzieci

- Duze elementy dotykowe (min 64x64)
- Brak tekstu - komunikacja przez ikony
- Pozytywne wzmocnienie - bledy nie sa karane
- Orientacja landscape
- Aplikacja offline (bez internetu)
