# Memory Bank - Podrecznik

## Cel Memory Bank

Memory Bank to system dokumentacji projektowej, ktory zapewnia ciaglosc kontekstu miedzy sesjami pracy z Claude. Kazda nowa sesja zaczyna sie od "czystej karty" - Claude nie pamieta poprzednich rozmow. Dlatego Memory Bank jest kluczowy.

## Wymagane dzialania na poczatku kazdej sesji

1. **ZAWSZE** przeczytaj wszystkie pliki z folderu `memory-bank/`
2. Zacznij od `projectbrief.md` - to fundament projektu
3. Sprawdz `activeContext.md` - co jest aktualnie w trakcie
4. Przejrzyj `progress.md` - co juz zostalo zrobione

## Struktura plikow

```
memory-bank/
├── handbook.md        # Ten plik - instrukcje obslugi Memory Bank
├── projectbrief.md    # Glowny brief projektu (NAJWAZNIEJSZY)
├── productContext.md  # Kontekst produktowy - dlaczego projekt istnieje
├── activeContext.md   # Aktualny kontekst pracy
├── systemPatterns.md  # Wzorce architektoniczne i konwencje
├── techContext.md     # Kontekst techniczny - stack, narzedzia
└── progress.md        # Postep prac i historia zmian
```

## Hierarchia waznosci

1. **projectbrief.md** - zrodlo prawdy o wymaganiach
2. **techContext.md** - jak budujemy
3. **systemPatterns.md** - jakich wzorcow uzywamy
4. **activeContext.md** - nad czym teraz pracujemy
5. **progress.md** - co juz zrobilismy

## Zasady aktualizacji

### Kiedy aktualizowac Memory Bank:

- Po zakonczeniu znaczacej funkcjonalnosci
- Gdy odkryjesz nowy wzorzec lub konwencje
- Gdy zmienia sie kierunek projektu
- Na koniec sesji roboczej
- Gdy uzytkownik poprosi o aktualizacje

### Co aktualizowac:

- `activeContext.md` - najczesciej, przy kazdej zmianie fokusa
- `progress.md` - po ukonczeniu zadan
- `systemPatterns.md` - gdy ustalasz nowe wzorce
- `techContext.md` - gdy dodajesz nowe technologie
- `projectbrief.md` - rzadko, tylko gdy zmieniaja sie wymagania

## Przepływ pracy

```
Poczatek sesji:
┌─────────────────────────────────────┐
│  1. Przeczytaj CLAUDE.md            │
│  2. Przeczytaj memory-bank/         │
│  3. Zrozum aktualny kontekst        │
│  4. Kontynuuj prace                 │
└─────────────────────────────────────┘

Koniec sesji:
┌─────────────────────────────────────┐
│  1. Zaktualizuj activeContext.md    │
│  2. Zaktualizuj progress.md         │
│  3. Zapisz wazne decyzje            │
│  4. Commituj zmiany                 │
└─────────────────────────────────────┘
```

## Wazne przypomnienia

- Memory Bank jest JEDYNYM zrodlem prawdy miedzy sesjami
- Nie polegaj na pamieci - wszystko musi byc zapisane
- Utrzymuj dokumenty aktualne i zwiezle
- Usuwaj nieaktualne informacje
- Priorytetyzuj czytelnosc nad kompletnosc
