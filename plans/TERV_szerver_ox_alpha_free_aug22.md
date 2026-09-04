# ÉJSZAKAI FEJLESZTÉSI TERV — szerver_ox_alpha_free_aug22 branch
# 2026-08-22 éjszaka, gondnok önálló vezetéssel (Joco reggel tér vissza)

## CÉL
E8-algebra felfedezése Idris2-BEN ÉS Lean4-BEN, a Szima projekt stílusában:
minden állítás Refl-bizonyítva (Idris) / taktikával bizonyítva (Lean),
numerikus ellenőrzés Idris Double-lel. Master: TILOS.

## FÁZIS 0 — Alapok (azonnal)
- [x] branch: szerver_ox_alpha_free_aug22
- [ ] szabály-előírás olvasás: MANTRA.md, skills/idris-stilus/SKILL.md,
      osveny_index/tanulsagok/OLVASD.md (alügynökkel összegyezve)
- [ ] baseline: 49/49 modul fordul ✓ (mérve: 2026-08-22)

## FÁZIS 1 — E8 GYÖKÉRRENDSZER IDRISBEN (éjjel főmű)
Új modul(ok) — semmit nem módosítunk (§13 FŐ SZABÁLY):
- `szima_ter/modul/E8GyokerRendszer.idr`
  * E8 Cartan-mátrix (8×8, Int)
  * 8 egyszerű gyök élszámításból → 240 gyök felsorolása
    (even koordináták Z^8/2 ∪ félig forgatott — Borcherds/Conway-séma)
  * bizonyítások: a gyöklista hossza = 240 (kimerítő számítás, §18(b)),
    páronkénti szögkoszinusz-tábla szimmetriája, gyök-hossz = √2 (Double)
- `szima_ter/modul/E8GyokerNumerika.idr` — Double numerika + Show-tesztek
- docs/ dashboard-számok frissítése (§0: nyilvános ellenőrizhetőség)

## FÁZIS 2 — LEAN TWIN (párhuzamos igazolás)
- elan telepítés (user kérés: Idris ÉS Lean)
- `SzimaLean/E8Gyokek.lean`: ugyanaz a 240-gyök tény Lean4-ben
  (Mathlib nélkül is: List + decEq elegendő; ha Mathlib megy: finset szám)
- Lean build zöld = független ellenőrző réteg

## FÁZIS 3 — KeresoTabla kitöltés (49 bejegyzés × 4 tábla)
- KategoriaT.idr-ből kiszedett nevek alapján adat-modul `_v1`

## SZABÁLYOK (AGENTS.md kötelező)
§13 új fájl mindenhez | magyar ékezetes azonosítók | rövidítés tilos |
Python munkafolyamatban tilos | 3 hiba → keresés | snapshot 3 promptonként |
alügynökök olvasnak | kontextus tiszta: leletek azonnal naplóba

## NAPLÓ
kutatasi_naplo/2026-08-22_ejszaka_szerver_branch.md — futó beszámoló
