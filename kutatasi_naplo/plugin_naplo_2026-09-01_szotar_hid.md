# Kutatási napló — 2026-09-01 (szótár-híd)

## A felhasználó kérdése (szó szerint, §N5)
- „a szotarat boviteni kellene, illetve meg kene erteni, hogyan fog ez mukodni, horgony-nak mar voltak erre otletei (esetleg nezd meg a baby ai-t)"

## Mit csináltunk

### 1. A projekt-keresés (a hard rule szerint — előre tervezve)
- **BabyAGI_v1_Szima.idr** (191 sor): a 15 szint (Symbol → Mind), a `learnWord` (szó → harmónia → aminosav → fehérje → manifold), a `sleepFilter` (az alvás szűrése)
- **HungarianLexicon_v1_Szima.idr** (6952 sor): **3460 magyar szó**, mindegyik huRoot-tal (tő!), huRole-lal (Object=főnév, Morphism=ige), huAlgebrával (hangrend!) — DE a szavak privátok (csak a típusok publikusak)
- **Paragrafus.idr**: a komplex bájt kódolás (Szotar, szotarKeres, Peldaszotar — 4 szó, kézzel írt vektorokkal), a `Main.idr` FUT
- **TERV.md 3.1/3.5/3.6**: a Horgoney-csapat szótár-bővítési terve:
  - 3.1: tőmetszés (`szotarKeresTomesterrel`) — a „hazugsagot" nem találja a „hazugsag" tövet
  - 3.5: a szótár bővítése a source/-ból, ko-okkurencia-becsléssel
  - 3.6: a KisAI kiterjesztése komplex bájtokkal

### 2. A megértés — hogyan fog működni
A rendszer két úton dolgozik ugyanazon a jelentésen:
1. **A Paragrafus-út**: szó → HuWord (szófaj, hangrend) → 8-dimenziós komplex jelentésvektor → komplex bájt → a mondat kódolása
2. **A BabyAGI-út**: szó → Analysis (hangrend, toldalék) → aminosav → polipeptid → fehérje → manifold → HolographicMind (a learnWord = tanulás, sleepFilter = alvás)

A két út a jelentésen találkozik. A fordítási Carnot-ciklus (ForditasCarnot.idr) a jelentésvektoron keresztül viszi át a mondatot magyar↔kínai (a forditF/forditG functor-páron).

### 3. A szótár-híd megépítése (SzotarHid_v1.idr, 322 sor)
- A lexikon szavai privátok → a híd publikus MINTA-szavakat definiál (MkHu-val, ugyanazokkal az adatokkal)
- `huWordToJelentes`: a HuWord → a 8-dimenziós komplex vektor generálása
- `szótárKeresésTömesterrel`: a TERV.md 3.1 megoldása — a toldalék levágásával való keresés

### 4. A jelentésvektor-generálás elve
- ObjectRole (főnév) → tér=1, mód=1 (a dolog a térben van)
- MorphismRole (ige) → idő=1, okság=1 (a cselekvés időben zajlik)
- PropertyRole (tulajdonság) → szín=1
- ModifierRole (módosító) → hang=1
- Additive (mély hangrend) → fázis=+1; Multiplicative (magas) → fázis=+i

### 5. A tő-keresés eredménye (futásidejű teszt)
- 'hazugságot' → -ot → 'hazugság' → MEGTALÁLVA ✓ (tér=1, mód=1)
- 'embernek' → -nek → 'ember' ✓ (fázis=+i — a magas hangrend!)
- 'farkasokat' → -okat → 'farkas' ✓ (szín=1; a kombinált toldalék!)

### 6. A napló fontos tanulsága (§25): az ékezet INFORMÁCIÓ
A szótárban „hazugság" (ékezetes) van — a „hazugsagot" (ékezet nélküli) bemenet NEM találja. Ez HELYES viselkedés: az ékezet információ (a hosszú á ≠ rövid a!). A bemenet is ékezetes legyen.

### 7. A String-operációk Refl-korlátja (a TERV.md szabálya)
A végződikToldalékkal / levágToldalékot String-műveletek NEM redukálódnak Refl-hez — a TERV.md pontosan ezt mondja: „a szótári keresés ==-e nem redukálódik Refl-lel — futásidejű ellenőrzés". Ezért a toldalék-tesztek futásidejű Show-ellenőrzéssel működnek. A szerepDimenziók és hangrendFázis viszont Refl-lel bizonyítottak (6 Refl).

## Push
- `0b82ecb` — SzotarHid_v1.idr: a szótár-híd (322 sor, 6 Refl + futásidejű tesztek)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★