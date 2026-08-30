---
name: idris-stilus
description: >
  BETÖLTENDŐ MINDEN IDRIS KÓD ÍRÁSA ELŐTT. Ez a skill kötelező protokoll.
  1. Olvasd el a 3 MD fájlt a gyökérkönyvtárban: MANTRA.md, HOROG.md, AGENTS.md
  2. Tanulmányozd a meglévő Idris kód stílusát: tisztán típusokkal, a fordító
     írja a programot. SOHA pattern matching. Csak dependent types + typeclass.
  3. A típus annyira pontos, hogy csak egy implementáció lehetséges.
  4. Minden szám data-ba csomagolva (0-10). Minden művelet typeclass.
  5. SOHA ne használj Pythont. Csak Idris.
---

# Idris Stílus — Kötelező Protokoll Minden Kód Írása Előtt

## Betöltési Sorrend

```
1. Olvasd: /Users/joco/opencode/MANTRA.md
2. Olvasd: /Users/joco/opencode/HOROG.md
3. Olvasd: /Users/joco/opencode/AGENTS.md
4. Tanulmányozd a meglévő .idr fájlok stílusát
5. Csak utána írj kódot
```

## A Szabályok (MANTRA.md + HOROG.md + AGENTS.md)

### Típus Szabályok
1. MINDENT be csomagolni dimenzionált típusba
2. Semmi csomagolatlan Double, Bool, String, Int, Nat, List, Pair
3. Hierarchikus típusok typeclass-okon keresztül
4. A bizonyítás kimenetét kommentben a propozíció elé

### Idris Stílus Szabályok
1. **SOHA pattern matching** — mindent dependent type-okkal
2. A típus annyira pontos, hogy csak egy implementáció lehetséges
3. A fordító írja a programot — te csak a típust adod meg
4. Minden szám data-ba csomagolva (0-10), a [[15,1,3]] kódból
5. Minden művelet typeclass instance
6. Typeclass hierarchia: FelcsoportT → MonoidT → CsoportT → ...
7. Refl = minden bizonyítás alapja
8. Wadler "free proof": a polimorf típus bizonyítja a törvényt

### Tiltások
- SOHA Python
- SOHA pattern matching (kivével: Refl bizonyításnál case-by-case)
- SOHA törlés engedély nélkül
- SOHA módosítás meglévő kódon (csak ADD)
- SOHA rövidítés
- Semmi 10-nél nagyobb szám generálásához

### Commit Ritmus
- Minden 10. függényváltoztatás után: git add -A && git commit && git push

## A Meglévő Kód Stílusa

```
-- SZABÁLY: a típus mondja meg mit csinál, ne a pattern match
-- ROSSZ:
f Nulla = 0
f Egy = 1

-- JÓ:
record KubitErtek (k : KubitD) where
  konstruktor KubitErtekKonstruktor
  ertek : case k of
    NullaD => 0
    EgyD => 1

-- vagy typeclass-szal:
interface KubitErtekT (k : KubitD) where
  ertek : Nat

KubitErtekT NullaD where
  ertek = 0

KubitErtekT EgyD where
  ertek = 1
```

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `MANTRA.md` | Mantra, típus szabályok, hierarchia |
| `HOROG.md` | Szindrómák, bírák, könyv index, célok |
| `AGENTS.md` | Ügynök szabályok, környezet, eszközök |
| `osveny_index/Alap/KategoriaT.idr` | 49 typeclass |
| `osveny_index/Alap/DependensSzamT.idr` | Dependent types |
| `osveny_index/Steane713Dependent.idr` | Steane kód dependent types-szal |