# Brief Projektu: Przyrodnicy

## Stos Technologiczny

- **Framework**: Flutter (najnowsza stabilna wersja)
- **Jezyk**: Dart
- **Platformy docelowe**: Android + iOS
- **Backend**: Brak (lokalny state, bez serwera)
- **State Management**: Wbudowany Flutter state (setState, ewentualnie Provider)
- **Animacje**: Wbudowane animacje Flutter
- **Audio**: Pakiet audioplayers lub flutter_sound do dzwiekow
- **Grafika**: Wektorowe ilustracje (SVG) lub PNG z przezroczystoscia

## Przeglad Projektu

**Przyrodnicy** to edukacyjna aplikacja mobilna dla dzieci w wieku 3-7 lat. Aplikacja uczy poprzez zabaw w przyrodniczym klimacie - dzieci eksploruja interaktywny las i ucza sie podstaw: liczenia, rozpoznawania kolorow, liter, cyfr oraz przyrody.

Projekt ma podwojny cel:
1. **Cel edukacyjny** - stworzyc wartosciowa aplikacje dla wlasnych dzieci autora
2. **Cel nauki** - nauczyc sie frameworka Flutter w praktyce

Aplikacja jest calkowicie darmowa, bez reklam i platnosci in-app. Jest przeznaczona do prywatnego uzytku rodzinnego.

## Problem do rozwiazania

### Obecna sytuacja
Rodzice szukajacy prostych aplikacji edukacyjnych dla malych dzieci napotykaja problemy:
- Wiekszosc aplikacji dla dzieci jest pelna reklam
- Wiele wymaga platnosci lub subskrypcji
- Czesto sa przeladowane funkcjami i myla male dzieci
- Trudno znalezc cos prostego i bezpiecznego

### Rozwiazanie
Przyrodnicy to minimalistyczna, bezpieczna aplikacja ktora:
- Nie ma zadnych reklam ani platnosci
- Ma bardzo prosty interfejs dla samodzielnego uzycia przez dzieci
- Skupia sie na kilku podstawowych aktywnosciach edukacyjnych
- Uzywa przyjaznej estetyki inspirowanej natura

### Wartosc dla uzytkownika
- Dziecko moze bezpiecznie bawic sie samodzielnie
- Rodzic ma spokoj - brak niechcianych zakupow czy reklam
- Dziecko uczy sie przez zabaw w przyjemnym srodowisku

## Uzytkownicy docelowi

### Glowny uzytkownik: Dziecko (3-7 lat)

**Charakterystyka:**
- Wiek: 3-7 lat (przedszkolaki i wczesna szkola podstawowa)
- Umiejetnosci czytania: Brak lub poczatkowe
- Zdolnosc motoryczna: Rozwijajaca sie - potrzeba duzych przyciskow i gestow
- Czas koncentracji: Krotki (5-10 minut na aktywnosc)
- Sposob interakcji: Dotyk palcem, proste gesty (tap, drag)

**Potrzeby:**
- Duze, kolorowe elementy interfejsu
- Natychmiastowa informacja zwrotna (dzwieki, animacje)
- Brak tekstu - komunikacja przez ikony i dzwieki
- Brak frustracji - latwiejszy poziom trudnosci
- Atrakcyjna wizualnie grafika przyrodnicza

**Cel w aplikacji:**
- Zabawa i eksploracja
- Nauka przez interakcje
- Poczucie sukcesu i radosci

### Drugorzedny uzytkownik: Rodzic

**Charakterystyka:**
- Wiek: 25-45 lat
- Relacja: Rodzic dziecka uzywajacego aplikacji
- Interakcja: Minimalna - uruchamia aplikacje dla dziecka

**Potrzeby:**
- Pewnosc, ze aplikacja jest bezpieczna
- Brak niechcianych powiadomien lub zakupow
- Prosta instalacja i uruchomienie

## Przeplyw Uzytkownika (User Flow)

### Ekran startowy
1. Dziecko uruchamia aplikacje (lub rodzic uruchamia dla dziecka)
2. Pojawia sie animowany ekran powitalny z logo "Przyrodnicy"
3. Krotka animacja przejscia do glownego ekranu

### Glowny ekran - Las z polanami
1. Dziecko widzi interaktywna scene lasu
2. W lesie sa widoczne rozne polany/obszary (kazda = inna gra)
3. Elementy lasu sa animowane (liscie sie ruszaja, ptaki lataja)
4. Dziecko dotyka polane, zeby wejsc do gry

**Elementy interaktywne na glownym ekranie:**
- **Polana Liczbowa** - prowadzi do gry "Liczenie obiektow"
- **Polana Kolorowa** - prowadzi do gry "Dopasuj kolory"
- Przyszlosciowo: dodatkowe polany dla nowych gier

### Gra 1: Liczenie obiektow

**Przebieg:**
1. Ekran pokazuje scene z przyrodniczymi obiektami (np. jablka, motyle, kwiaty)
2. Na ekranie pojawia sie od 1 do 5 obiektow (losowa ilosc)
3. Obiekty sa duze, wyrazne, latwe do policzenia
4. Na dole ekranu sa 3 przyciski z cyframi (np. 2, 3, 4)
5. Dziecko liczy obiekty i wybiera odpowiednia cyfre
6. **Poprawna odpowiedz:**
   - Radosny dzwiek sukcesu
   - Obiekty wykonuja "taniec zwyciestwa" (animacja)
   - Przejscie do nastepnej rundy
7. **Bledna odpowiedz:**
   - Lagodny dzwiek "sprobuj jeszcze raz"
   - Obiekty delikatnie sie trzesa
   - Mozna sprobowac ponownie (bez kary)

**Mechanika:**
- Poziom trudnosci: 1-5 obiektow (staly w MVP)
- Rundy: Nieskonczone (dziecko gra ile chce)
- Wyjscie: Przycisk "domku" w rogu wraca do lasu

### Gra 2: Dopasuj kolory (Drag & Drop)

**Przebieg:**
1. Ekran podzielony na dwie czesci:
   - Gora: Kolorowe pudelka/koszyki (3-4 kolory)
   - Dol: Przedmioty do posortowania
2. Przedmioty to elementy przyrody: liscie, kwiaty, owoce, motyle
3. Dziecko przeciaga przedmiot do pudelka o odpowiednim kolorze
4. **Poprawne dopasowanie:**
   - Przedmiot "wpada" do pudelka z animacja
   - Dzwiek sukcesu
   - Pojawia sie nowy przedmiot
5. **Bledne dopasowanie:**
   - Przedmiot "odbija sie" i wraca na miejsce
   - Lagodny dzwiek zachety do kolejnej proby

**Mechanika:**
- Kolory: Czerwony, Niebieski, Zolty, Zielony (podstawowe)
- Przedmioty: Losowe z puli ~15-20 ilustracji
- Wyjscie: Przycisk "domku" wraca do lasu

### Powrot do lasu
- Z kazdej gry mozna wrocic przyciskiem "domku"
- Animacja przejscia z powrotem do glownego ekranu

## Specyfikacja funkcjonalnosci

### F1: Ekran powitalny (Splash Screen)
- Animowane logo "Przyrodnicy"
- Czas wyswietlania: 2-3 sekundy
- Animacja przejscia do glownego ekranu

### F2: Glowny ekran - Interaktywny Las
- Tlo: Ilustracja lasu w stylu naturalnym/ekologicznym
- Animowane elementy dekoracyjne (liscie, ptaki, chmury)
- 2 interaktywne polany (przyciski do gier)
- Kazda polana ma charakterystyczna ikone
- Efekt dotykowy przy nacisnieciu polany

### F3: Gra - Liczenie obiektow
- Generowanie losowej liczby obiektow (1-5)
- Wyswietlanie 3 opcji odpowiedzi (cyfry)
- Obsluga dotyku na przyciskach
- Dzwieki sukcesu i zachety
- Animacje obiektow
- Przycisk powrotu do lasu

### F4: Gra - Dopasuj kolory
- Implementacja drag & drop dla dzieci
- 4 kolorowe "kosze" (cel upuszczenia)
- Pula kolorowych przedmiotow
- Detekcja poprawnego/blednego dopasowania
- Dzwieki i animacje feedbacku
- Przycisk powrotu do lasu

### F5: System dzwiekow
- Dzwieki sukcesu (radosne)
- Dzwieki zachety (przy bledzie)
- Dzwieki interakcji (dotyk przyciskow)
- Mozliwosc wyciszenia (opcjonalnie w MVP)

### F6: Nawigacja
- Prosta nawigacja bez tekstu
- Ikony zamiast napisow
- Przycisk "domek" do powrotu
- Animacje przejsc miedzy ekranami

## Schemat bazy danych / State

W MVP nie ma bazy danych. Stan aplikacji:

```dart
// Glowny stan aplikacji
class AppState {
  bool isSoundEnabled = true;  // Czy dzwieki wlaczone
}

// Stan gry Liczenie
class CountingGameState {
  int currentCount;      // Ile obiektow na ekranie (1-5)
  List<int> options;     // 3 opcje do wyboru
  int correctAnswer;     // Poprawna odpowiedz
}

// Stan gry Kolory
class ColorMatchState {
  String currentItemColor;  // Kolor aktualnego przedmiotu
  String currentItemType;   // Typ przedmiotu (lisc, kwiat, etc.)
}
```

## Wymagania techniczne

### Wydajnosc
- Plynne animacje (60 FPS)
- Szybkie ladowanie (<2 sekundy)
- Brak lagów przy drag & drop

### Kompatybilnosc
- Android 6.0+ (API 23+)
- iOS 12.0+
- Orientacja: Tylko pozioma (landscape) - lepsze dla dzieci
- Rozdzielczosc: Responsywne, adaptacja do roznych ekranow

### Bezpieczenstwo
- Brak dostepu do internetu (offline-first)
- Brak zbierania danych
- Brak reklam i analityki
- Brak linkow zewnetrznych

### Dostepnosc
- Duze elementy dotykowe (min 48x48 dp)
- Wysoki kontrast kolorow
- Dzwieki jako uzupelnienie, nie jedyna informacja

## Ograniczenia i zakres MVP

### W zakresie MVP:
- Ekran powitalny z animacja
- Glowny ekran - interaktywny las
- 2 gry edukacyjne (Liczenie, Kolory)
- Podstawowe dzwieki
- Prosta nawigacja
- Dzialanie offline

### Poza zakresem MVP (przyszle wersje):
- Dodatkowe gry (litery, ksztalty, zwierzeta)
- System nagrod / odznak
- Profil dziecka
- Statystyki dla rodzica
- Lokalizacja (inne jezyki)
- Publikacja w sklepach

## Styl wizualny

### Paleta kolorow (naturalna/ekologiczna)
- **Glowna zielen**: #4A7C59 (lesna zielen)
- **Jasna zielen**: #8FBC8F (liscie)
- **Brazowy**: #8B4513 (drewno, pnie)
- **Blekitny**: #87CEEB (niebo)
- **Kremowy**: #FFF8DC (tla, akcenty)
- **Akcent**: #FFD700 (zloty, dla sukcesu)

### Typografia
- Duze, czytelne czcionki
- Zaokraglone ksztalty liter (przyjazne dla dzieci)
- Minimalny tekst - glownie ikony

### Ilustracje
- Styl: Plaski (flat) z delikatnymi cieniami
- Postacie: Przyjazne zwierzeta lesne (opcjonalnie)
- Obiekty: Proste, rozpoznawalne ksztalty
- Kolory: Naturalne, stonowane, ale wyrazne

## Harmonogram

Brak sztywnych terminow - projekt realizowany w wolnym czasie dla nauki Flutter.

**Sugerowana kolejnosc prac:**
1. Setup projektu Flutter
2. Ekran powitalny
3. Glowny ekran (las) - statyczny
4. Gra Liczenie - podstawowa wersja
5. Gra Kolory - podstawowa wersja
6. Animacje i dzwieki
7. Animacje glownego ekranu
8. Testowanie i poprawki
9. Build na urzadzenia

## Zaleznosci i integracje

### Wymagane pakiety Flutter:
- `audioplayers` - odtwarzanie dzwiekow
- `flutter_svg` - obsluga grafiki wektorowej (opcjonalnie)

### Wymagane narzedzia:
- Flutter SDK
- Android Studio lub VS Code z pluginem Flutter
- Xcode (dla iOS)
- Emulatory lub fizyczne urzadzenia testowe

### Zasoby graficzne:
- Do stworzenia lub pobrania z darmowych zrodel
- Styl: naturalny, przyjazny dzieciom
- Format: PNG lub SVG
