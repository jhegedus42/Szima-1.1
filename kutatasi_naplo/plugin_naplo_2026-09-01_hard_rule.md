# Kutatási napló — 2026-09-01 (a hard rule és a projekt-keresés)

## A felhasználó kérdései (szó szerint, §N5)
- „hard rule : keress az osvenyben is, az egesz projektben mielott barmit is csinalsz, valoszinu, hogy letezik mar relevans munka, informacio a projektben"
- „probaljuk ujra" (ötször — az előző alügynök-küldés limit miatt elbukott)

## Mit csináltunk

### 1. A hard rule érvényesítése
A felhasználó új hard rule-t adott: mielőtt bármit csinálok, előbb végig kell keresni az egész projektben. Ez a §N11 és §N12 kiterjesztése: előbb a PROJEKTBEN keressünk.

### 2. A projekt-keresés (közvetlenül, alügynök nélkül — a limit miatt)
Előre tervezett keresések (§N12) az egész projektre: `osveny_index/`, `szima_ter/modul/`, `docs/`, `kutatasi_naplo/`, `trail_index/`, `diagnosztika/`.

### 3. A FŐ FELFEDEZÉSEK

**A magyar↔kínai fordító MÁR LÉTEZIK** (a felhasználó igaza):
- `szima_ter/modul/MagyarKinaiPar_v2.idr` (336 sor): forditF/forditG functor-pár
- `szima_ter/modul/MagyarKinaiInverz_v2.idr` (157 sor): AZ INVERZ VIZSGÁLAT — Refl-bizonyítással! A lefordulás = az inverz egyezik; az elutasítás = információveszteség (a magyar Múlt elveszik!)
- Összesen 8 magyar-kínai modul, 3068 sor, MIND lefordul

**A CODATA α⁻¹ MÁR LÉTEZIK:**
- `szima_ter/modul/MagyarCarnotE9_v3_CodatAlpha.idr` (339 sor): alphaInverzCodat = 137.035999177, alphaInverzHorgony = 137.036, delta = 8.23e-7

**A FazisT / YCombinatorFazisT MÁR LÉTEZIK:**
- `osveny_index/KvantumY.idr` (264 sor): kvantumY, aranyMetszes, aranyMetszesSzoog

### 4. §24-sértés bevallása
A `ForditoPrototipus.idr` (322 sor, 77ebbdb) újraírta, ami már létezett — §24-sértés. A hard rule éppen ezt akarta megelőzni. A fájl marad (§13: nem törölhető), de a további munka a `szima_ter/modul/` meglévő moduljaira épüljön.

### 5. A javított következő lépések
1. **A forditF bővítése toldalékokkal** (rag=X, jel=Z, képző=Y) — a valóban hiányzó rész
2. **A FazisKoend Python-számítások Idris-portolása** (a CODATA-lánc) — a `diagnosztika/szamitas/` 24 Python-fájlja
3. **A Kandel 15 chunk áthozatala** (alacsony prioritás)

## Push
- `9af85aa` — HARD RULE betartva: projekt-keresés jelentés

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★