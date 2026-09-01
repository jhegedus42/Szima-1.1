# Kutatási napló — 2026-09-01 — a 000.02 KÉSZ: a teljes szótár (3460 szó + prozódia) + GAN-ellenőrzés

## A felhasználó üzenete (szó szerint, §N5)

„folytassuk"

## A 000.02 befejezése — a teljes szótár

### Az `összesSzó : List HuWord` generálása (sed — §N8: nem Python)
- a `grep '^public export [navd]_'` → 3460 név, az utelső vessző nélkül (a záró vessző az Idris2-ben TILTOTT — mini-teszt bizonyította)
- a blokk a `HungarianLexicon_v2_Szima.idr` végére
- **fordul** ✓ (`idris2 --check` — a 3460 elemű literál átment a typechecken)

### A `SzotarHid_v2.idr` bővítése
- `teljesSzótár : Szotar = map huWordJelentés összesSzó` (a Szotar = List SzoJelentes, Paragrafus 53–54)
- `teljesProzódiaSzótár : List (String, Prozódia)` — mind a 3460 szó prozódiával
- **CSAPDA (rögzítve):** a `map huWordToJelentes összesSzó` NEM fordul — «Mismatch between: HuWord and HuWord»: a v1-es függvény v1-HuWord-ön dolgozik, az összesSzó v2-est ad. Megoldás: `huWordJelentés` (v2-adaptáció, a §24-kommentben dokumentálva: a típuskülönbség miatt önálló verzió, a v1 logikáját híven követve; a v1 marad és használható).

### A futás eredménye (§N14/3)
```
összesSzó hossza:        3460
lexiconSize (a lexikon): 3460
EGYEZNEK: True
teljesSzótár mérete:     3460
teljesProzódiaSzótár:    3460 szó prozódiával
```

## A GAN-ellenőrzés (§N14/1 — task-alügynök, „csak hozzátesz")

### 1. A ritmus-hibajavítás finomítása — a d=1 felismerés
- A magánhangzó-kvantitás tisztán bináris csatorna (7 pár, ebből 5 CSAK hosszúságban tér el: i–í, o–ó, ö–ő, u–ú, ü–ű; 2 hossz+s minőségben: a–á, e–é — Siptár & Törkenczy 2000) → ~1 bit/szótag.
- **DE a magyar szókincs kódtávolsága d=1** («birtok»/«bírtok» két LEGÁLIS kódszó Hamming-1) → CSAK DETEKTÁLÁS garantált, a determinisztikus KORREKCIÓ nem → a jövőbeli korrekció típusa `Maybe` (honest típus — a d=1 tétel típus-szintű fordítása!).
- **CSS-párhuzam (a [[7,1,3]] szó-szintű megfelelője):** X-hiba ↔ kvantitás-flip; Z-hiba (fázis) ↔ jelentés-fázis-flip (a huWordJelentés Algebra→fázis mezője szó szerint FÁZIS!). A szó TÖBB független determinisztikus csatornán utazik (kvantitás + hangrend + fonetikus + jelentés-fázis), a hibát az EGYÜTTES szindróma lokalizálja.
- **Hangrend = második INGYENES paritás-csatorna** (a toldalék-hangrend determinisztikus) → `hangrendEllenőrző` a jövőben.
- **Geminát-csatorna TILTVÁNYA** (Siptár 1995: kevés minimálpár — gyenge csatorna, nem paritás).
- **ProzódiaSzindróma-típus** terve: Bool → (MelyikSzótag, MelyikBit).

### 2. A hangsúly-determinizmus kategóriaelméleti szerepe
- **Iniciális objektum:** a szótagsor kategóriájában a 0. szótag; a determinizmus = az iniciális objektum EGYEDISÉGE.
- **Természeti transzformáció:** σ_{F(w)} = F(σ_w) — a hangsúly NEM MOZDUL EL a toldalékolás alatt; **Idrisben BIZONYÍTHATÓ lemma: az append nem változtatja a lista fejét (Refl!)** — jövőbeli gépi ellenőrzött tétel.
- **Fixpont:** a hangsúlyozott szótagkezdet fixpontja az agglutinációs monoid-hatásnak — a szótár lemmái kanonikus reprezentánsok.
- **Gauge/keret:** nulla entrópiájú globális koordináta-rendszer — a szindróma értelmezésének alapja.
- Finomítás (Blaho & Szeredi, WCCFL 28): σ természetes a RAGASZTÓ-funktorokra, de NEM a kompozíció-funktorra (összetett szavak másodlagos hangsúlya).

### 3. Hiányzó mező-javaslatok (a 011.10-ben a tervbe olvadnak)
gyakorisági rang (Bayes-prior + a neutralizáció oka — Mády), szófaj, ragozási paradigma (generátorrendszer — az agglutináció = szabad monoid-hatás), **minimálpár-gráf (a confusability-gráf!)**, kollokációk, hangrend-mező, etimológiai réteg, regiszter.
- Mérési javaslat: a 3460 szó kvantitás-mintázat-hisztogramja → a csatorna entrópiája; a minimálpár-gráf élszáma = a d=1 zóna mérete (§N14/5 vizualizáció).

### 4. Irodalom-bővítés (§N14/4)
Siptár & Törkenczy 2000; Szende 1999 (LAPSyD); Blaho & Szeredi (WCCFL 28); Steane 1996 + Calderbank–Shor 1996 (CSS); Kornai (On Hungarian Morphology); errorcorrectionzoo.org/c/steane.

## A verifikáció (§N14 — mind a 6 szint)
1. GAN ✓ (fent) 2. Fordítás ✓ (6/6 modul + a v2 3460-es literállal) 3. Numerikus ✓ (3460=3460, EGYEZNEK: True) 4. Irodalom ✓ (5+ forrás) 5. Vizualizáció ✓ (a main táblázata) 6. Interaktív ✓ (getLine — a ritmus-műszer)

## A todo állapota
- 000.02 → KÉSZ; a következő: **000.03 Lumo-szókincs bővítés** (Folyamatban)
- KÉSZ: 5 (011.01, 011.05, 011.08, 000.01, 000.02)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★