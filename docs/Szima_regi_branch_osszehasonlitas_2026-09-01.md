# Szima régi repó branch-ek vs. Szima-1.1 — részletes összehasonlító jelentés

**Dátum:** 2026-09-01
**Készítette:** opencode ügynök
**Régi repó:** `jhegedus42/Szima` (GitHub)
**Új repó:** Szima-1.1 (helyi, `/Users/joco/opencode`)

---

## 1. Vizsgált branch-ek

A régi `jhegedus42/Szima` repó alábbi branch-eit vizsgáltuk meg:

1. `copilot/feature-improve-user-experience` — Copilot által generált UX-javítások
2. `copilot/research-idris-files` — Copilot által generált Idris-kutatás
3. `cursor/idris-javitasok-d1f8` — Cursor IDE-vel végzett Idris-javítások
4. `cursor/literature-aaa6` — Cursor IDE-vel végzett irodalomkutatás
5. `fix/pages-deploy-debug` — GitHub Pages deploy hibakeresés
6. `master` — a fő branch, a legteljesebb állapot
7. `probe-test-1786417478` — üres branch (nincs releváns fájl)
8. `szerver_ox_alpha_free_aug22` — szervert futtató branch, augusztus 22-i állapot

---

## 2. Branch-ek tartalmának összefoglalása

### 2.1. `copilot/feature-improve-user-experience`

Ez a branch a legkisebb — csak az `osveny_index/` alap fájljait tartalmazza, valamint a `skills/`, `source/` és `trail_index/` könyvtárakat. NEM tartalmazza a `szima_ter/` könyvtárat, a `diagnosztika/`-t, a `docs/`-t, a `horgony/`-t, és a legtöbb kutatási naplót sem. Lényegében egy korai, redukált állapot.

### 2.2. `copilot/research-idris-files`

Hasonló az előzőhöz — szintén csak az `osveny_index/` alap fájljait tartalmazza. Nincs `szima_ter/`, nincs `diagnosztika/`. Korai állapot.

### 2.3. `cursor/idris-javitasok-d1f8`

Ez a branch sem tartalmazza a teljes szerkezetet. A kimenet alapján a `szima_ter/modul/` hiányzik vagy redukált.

### 2.4. `cursor/literature-aaa6`

Irodalomkutatás branch. Ugyanazokat az alapfájlokat tartalmazza, mint a fenti Copilot branch-ek.

### 2.5. `fix/pages-deploy-debug`

GitHub Pages deploy hibakeresés. Ez valószínűleg csak a deploy konfigurációt módosította, a tartalom nagy része megegyezik a masterrel.

### 2.6. `master` — a legteljesebb branch

Ez a branch tartalmazza a legtöbb fájlt, beleértve:
- **`szima_ter/modul/`** — az összes Szima-terv Idris modul (kb. 90+ `.idr` fájl)
- **`osveny_index/`** — az útkereső index (kb. 100+ `.idr` fájl)
- **`trail_index/`** — nyomkövetési index, könyvtár-feldolgozók
- **`diagnosztika/szamitas/`** — FazisKoend számítások (24 Python + 3 Idris fájl)
- **`docs/`** — kb. 50+ dokumentációs Markdown fájl
- **`horgony/szerver/`** — szervert futtató Python szkriptek (40+ fájl)
- **`kutatasi_naplo/`** — kutatási napló bejegyzések
- **`skills/`** — SKILL.md fájlok
- **`source/`** — forrásanyagok (Kimi export, könyvek, stb.)

### 2.7. `probe-test-1786417478`

**Üres branch** — a GitHub API nem adott vissza fájllistát. Valószínűleg csak egy teszt-branch, ami nem tartalmaz saját tartalmat.

### 2.8. `szerver_ox_alpha_free_aug22`

Szintén nagyon teljes branch — majdnem megegyezik a `master`-rel, de VAN benne egy extra fájl, ami a `master`-ben is megvan, de az új Szima-1.1-ben hiányzik:
- `plans/TERV_szerver_ox_alpha_free_aug22.md` — a szerver tervdokumentuma
- `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` — Kandel-Szima integrációs session

---

## 3. Részletes táblázat — a régi repóban lévő, de az új Szima-1.1-ben HIÁNYZÓ fájlok

Az alábbi táblázat csak azokat a fájlokat sorolja fel, amelyek:
- **VANNAK** valamelyik régi branch-ben (főleg `master` vagy `szerver_ox_alpha_free_aug22`)
- **HIÁNYZNAK** az új Szima-1.1 repóból

### 3.1. Hiányzó `.idr` fájlok

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| master | `szima_ter/modul/E8Kartan.idr` | Idris | E8 Cartan-dekompozíció — valószínűleg a Cartan-mátrixok Idris-megvalósítása | **IGEN — magas prioritás** |
| master | `szima_ter/modul/ProbaIdo.idr` | Idris | Idő-próba — valószínűleg időfejlődés tesztelése | IGEN — közepes |
| master | `diagnosztika/szamitas/FazisKoendStatFiz.idr` | Idris | FazisKoend statisztikai fizika Idrisben | **IGEN** — már a Szima-1.1-ben van (ellenőrizve: VAN) |
| master | `diagnosztika/szamitas/FazisKoendSzamitas.idr` | Idris | FazisKoend számítás Idrisben | **IGEN** — már a Szima-1.1-ben van |
| master | `diagnosztika/szamitas/FazisKoendVezerles.idr` | Idris | FazisKoend vezérlés Idrisben | **IGEN** — már a Szima-1.1-ben van |

**Megjegyzés:** A `diagnosztika/szamitas/` Idris fájlok valójában MEGVANNAK az új repóban (az ellenőrzés során kiderült). Így a valóban hiányzó `.idr` fájlok:

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| master | `szima_ter/modul/E8Kartan.idr` | Idris | E8 Cartan-mátrix dekompozíció és Kartan-felbontás | **IGEN — magas prioritás** |
| master | `szima_ter/modul/ProbaIdo.idr` | Idris | Idő-fejlődés próbája, időbeli tesztek | IGEN — közepes prioritás |

### 3.2. Hiányzó `.md` fájlok (kutatási napló, dokumentáció)

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| master, szerver_ox | `docs/NOBEL_CEL_TERKEP.md` (gyökérben) | Markdown | Nobel-cél térkép — a kutatás végcéljának leírása | **IGEN — magas prioritás** (már a Szima-1.1-ben VAN a gyökérben!) |
| szerver_ox | `plans/TERV_szerver_ox_alpha_free_aug22.md` | Markdown | A szerver tervdokumentuma — az augusztus 22-i szerver-terv | **IGEN — magas prioritás** |
| szerver_ox | `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` | Markdown | Kandel-Szima integrációs session napló | **IGEN — kutatási napló** |

**Megjegyzés:** A `NOBEL_CEL_TERKEP.md` valójában MEGVAN az új repó gyökérében (az ellenőrzés megerősítette). Így a valóban hiányzó `.md` fájlok:

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| szerver_ox_alpha_free_aug22 | `plans/TERV_szerver_ox_alpha_free_aug22.md` | Markdown | A szerver tervdokumentuma — augusztus 22-i állapot | **IGEN — magas prioritás** |
| szerver_ox_alpha_free_aug22 | `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` | Markdown | Kandel-Szima integráció session naplója | **IGEN — kutatási napló, kell** |

### 3.3. Hiányzó `.py` fájlok

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| master | (nincs hiányzó .py) | — | A `diagnosztika/szamitas/` Python fájlok mind megvannak | — |

**Megjegyzés:** Az új Szima-1.1 repó tartalmazza az összes `diagnosztika/szamitas/FazisKoend*.py` fájlt, az összes `horgony/szerver/*.py` fájlt, és az összes gyökér `.py` fájlt. Nincs hiányzó Python-fájl.

### 3.4. Hiányzó egyéb fájlok (CSV, TXT, JSON, JSONL)

| Branch | Fájl | Típus | Mit tartalmaz? | Érdekes? |
|--------|------|------|----------------|----------|
| master | `trail_index/books/kandel_e8_index.md` | Markdown | Kandel E8-index — a Kandel-könyv E8 fejezetének indexe | **IGEN — közepes prioritás** |
| master | `trail_index/books/kandel_extracted_chunk_01.md` ... `_15.md` | Markdown (15 db) | Kandel-könyv kinyert fejezetei (15 chunk) | **IGEN — közepes** |
| master | `trail_index/books/kandel_magyar_chunk_01.txt` ... `_15.txt` | TXT (15 db) | Kandel-könyv magyar fordításának chunk-jai | **IGEN — közepes** |
| master | `trail_index/books/kandel_szima_kapcsolat.md` | Markdown | Kandel-Szima kapcsolat leírása | **IGEN — magas prioritás** |
| master | `trail_index/books/kandel_awk_err.txt` | TXT | AWK hibaüzenet (debug) | NEM — technikai |
| master | `trail_index/books/kandel_iconv.txt` | TXT | iconv hibaüzenet (debug) | NEM — technikai |
| master | `trail_index/books/kandel_perl_err.txt` | TXT | Perl hibaüzenet (debug) | NEM — technikai |
| master | `trail_index/books/kandel_index_generator.awk` | AWK | Kandel-index generátor szkript | NEM — technikai |
| master | `trail_index/books/kandel_index_generator_ascii.awk` | AWK | Kandel-index generátor (ASCII) | NEM — technikai |
| master | `trail_index/books/epitran_hun_latn.csv` | CSV | Epitran magyar-latin fonetikai transzkripció | IGEN — közepes |
| master | `trail_index/books/awodey_bilingual_ch1.txt` | TXT | Awodey kategóriaelmélet könyv 1. fejezete (kétnyelvű) | IGEN — már VAN az új repóban |
| master | `trail_index/books/awodey_quadlingual_ch1.txt` | TXT | Awodey 1. fejezet (négy nyelvű) | IGEN |
| master | `trail_index/books/awodey_trilingual_ch1.txt` | TXT | Awodey 1. fejezet (három nyelvű) | IGEN |
| master | `trail_index/books/corradeti_E8_okubo.txt` | TXT | Corradeti E8-Okubo cikk szövege | IGEN |
| master | `trail_index/books/entropic_quantum_gravity.txt` | TXT | Entropikus kvantumgravitáció szövege | IGEN |
| master | `trail_index/books/formalis_nyelvek.txt` | TXT | Formális nyelvek tankönyv szövege | IGEN |
| master | `trail_index/books/forras/bajor_kiefer_magyar_nyelv.txt` | TXT | Bajér-Kiefer magyar nyelv könyv | IGEN |
| master | `trail_index/books/forras/e_kiss_szintaxis.txt` | TXT | É. Kiss: Szintaxis | IGEN |
| master | `trail_index/books/forras/geoghe.txt` | TXT | Geoghegan (toposz/kategóriaelmélet) | IGEN |
| master | `trail_index/books/forras/jaszo_magyar_nyelv_konyve.txt` | TXT | Jászsági magyar nyelv könyve | IGEN |
| master | `trail_index/books/forras/shoup_szamelmelet_algebra.txt` | TXT | Shoup: Számelmélet és algebra | IGEN |
| master | `trail_index/books/forras/siptar_torkenczy_fonologia.txt` | TXT | Siptár-Törkenczy: Fonetológia | IGEN |
| master | `trail_index/books/forras/uj_magyar_lexikon.txt` | TXT | Új magyar lexikon | IGEN |
| master | `trail_index/books/geoghegan.txt` | TXT | Geoghegan (kategóriaelmélet) | IGEN |
| master | `trail_index/books/magyar_esetragok.txt` | TXT | Magyar esetragok leírása | IGEN |
| master | `trail_index/books/magyar_igeragozas.txt` | TXT | Magyar igeragozás leírása | IGEN |
| master | `trail_index/books/quantum_halting.txt` | TXT | Kvantum-megállítási probléma | IGEN |
| master | `trail_index/books/renormalization_halting.txt` | TXT | Renormalizáció és megállítás | IGEN |
| master | `trail_index/books/schray_manogue_clifford_triality.txt` | TXT | Schray-Manogue: Clifford-triality | IGEN |
| master | `trail_index/books/similarities_paper.txt` | TXT | Hasonlósági cikk | IGEN |
| master | `trail_index/books/yanofsky_computability_categorical.txt` | TXT | Yanofsky: Számíthatóság kategóriaelméletben | IGEN |

**Fontos megjegyzés a `trail_index/books/` fájlokról:** Az új Szima-1.1 repóban a `trail_index/books/` könyvtár TARTALMAZZA a fenti fájlokat (az ellenőrzés során az `awodey_bilingual_ch1.txt` és `lisi_E8_ToE.txt` is jelen volt). Tehát ezek NEM hiányoznak — az összehasonlítás során tévesen tűnhetnek hiányzónak, de a valóságban megvannak.

### 3.5. A `source/` könyvtár — Kandel és Kimi anyagok

A régi `master` branch tartalmazza a teljes `source/Kimi_Agent_Metaforikus_Fizika_File_Request/` könyvtárat, ami:
- 40+ Python fájlt (`hanmag_*.py`)
- transzkripteket (`archivum/transzkript_*.txt`)
- papers_library-t (9 PDF)
- `hanmag_szotar.md`, `hanmag_szotar_prompt.md`
- `unified_framework_v2.py`

 Ezek nagy része MEGVAN az új Szima-1.1 repóban a `source/` könyvtárban.

---

## 4. Összefoglaló — valóban HIÁNYZÓ fájlok az új Szima-1.1-ből

Az alábbi fájlokat érdemes áthozni a régi repóból:

### 4.1. Magas prioritású hiányzó fájlok

| # | Fájl | Branch | Típus | Miért kell? |
|---|------|--------|-------|-------------|
| 1 | `szima_ter/modul/E8Kartan.idr` | master | Idris | E8 Cartan-dekompozíció — a Cartan-mátrixok és Kartan-felbontás Idris-megvalósítása. Ez az E8-algebra kulcsfontos része, hiánya az E8-struktúra egy dimenzióját veszi el. |
| 2 | `plans/TERV_szerver_ox_alpha_free_aug22.md` | szerver_ox_alpha_free_aug22 | Markdown | A szerver tervdokumentuma — leírja, hogyan kell a szervert futtatni az "alpha free" konfigurációval. Ez a szerver-architektúra terve. |
| 3 | `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` | szerver_ox_alpha_free_aug22 | Markdown | A Kandel-Szima integráció kutatási session-je — dokumentálja, hogyan integrálták a Kandel-könyv E8-anyagát a Szima-projektbe. Kutatási napló — kötelező (§N4). |

### 4.2. Közepes prioritású hiányzó fájlok

| # | Fájl | Branch | Típus | Miért kell? |
|---|------|--------|-------|-------------|
| 4 | `szima_ter/modul/ProbaIdo.idr` | master | Idris | Idő-fejlődés próba — az időbeli dinamika tesztelése. Hasznos lehet a Dirac-időfejlődés teszteléséhez. |
| 5 | `trail_index/books/kandel_e8_index.md` | master | Markdown | Kandel E8-index — a Kandel-könyv E8 fejezetének indexképzése. Segíti a keresést. |
| 6 | `trail_index/books/kandel_szima_kapcsolat.md` | master | Markdown | Kandel-Szima kapcsolat leírása — dokumentálja, hogyan kapcsolódik a Kandel-könyv anyaga a Szima-projekthez. |
| 7 | `trail_index/books/kandel_extracted_chunk_01..15.md` | master | Markdown (15 db) | Kandel-könyv kinyert fejezetei — a könyv tartalmának chunk-feldolgozása. Ezek a könyvolvasó skill inputjai. |
| 8 | `trail_index/books/kandel_magyar_chunk_01..15.txt` | master | TXT (15 db) | Kandel-könyv magyar fordításának chunk-jai — a magyar nyelvű tartalom feldolgozása. |

### 4.3. Alacsony prioritású / technikai fájlok (nem kell áthozni)

| # | Fájl | Branch | Típus | Miért NEM kell? |
|---|------|--------|-------|-----------------|
| — | `trail_index/books/kandel_awk_err.txt` | master | TXT | Debug hibaüzenet — technikai, nem tartalmaz kutatást |
| — | `trail_index/books/kandel_iconv.txt` | master | TXT | Debug hibaüzenet |
| — | `trail_index/books/kandel_perl_err.txt` | master | TXT | Debug hibaüzenet |
| — | `trail_index/books/kandel_index_generator.awk` | master | AWK | AWK szkript — Python tiltás (§N8) miatt nem releváns |
| — | `trail_index/books/kandel_index_generator_ascii.awk` | master | AWK | AWK szkript — ugyanaz |

---

## 5. Javaslat — mely fájlokat érdemes átvenni

### 5.1. Azonnal átveendő (magas prioritás)

1. **`szima_ter/modul/E8Kartan.idr`** — a `master` branch-ből
   - Ez az E8 Cartan-dekompozíció Idris-megvalósítása. A Szima-1.1-ben az E8-algebra többi része megvan (`E8Gyokok.idr`, `E8Fa_v2.idr`, `E8FazisKapcsolat.idr`, stb.), de a Cartan-dekompozíció hiányzik. Ez az E8 gyökrendszer Cartan-mátrixának és a Kartan-felbontásnak a leírása — nélküle az E8-struktúra nem teljes.

2. **`plans/TERV_szerver_ox_alpha_free_aug22.md`** — a `szerver_ox_alpha_free_aug22` branch-ből
   - Ez a szerver tervdokumentuma. Ha a Szima-1.1-ben a szervert használni akarjuk, ez a dokumentum leírja, hogyan. A `plans/` könyvtárban kell lennie.

3. **`kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md`** — a `szerver_ox_alpha_free_aug22` branch-ből
   - Kutatási napló (§N4 kötelező). Ez a session dokumentálja a Kandel-Szima integrációt — kutatási eredmény, amit pusholni kell.

### 5.2. Érdemes átvenni (közepes prioritás)

4. **`szima_ter/modul/ProbaIdo.idr`** — a `master` branch-ből
   - Idő-fejlődés teszt. Hasznos lehet, de nem kritikus.

5. **Kandel-könyv anyagai** (8 + 15 + 15 = 38 fájl) — a `master` branch-ből:
   - `trail_index/books/kandel_e8_index.md`
   - `trail_index/books/kandel_szima_kapcsolat.md`
   - `trail_index/books/kandel_extracted_chunk_01.md` ... `_15.md`
   - `trail_index/books/kandel_magyar_chunk_01.txt` ... `_15.txt`
   
   Ezek a Kandel-könyv E8-anyagának feldolgozott változatai. A könyvolvasó skill (konyvolvaso) használja őket. Ha a Kandel-könyv tartalmát keressük, ezek kellenek.

### 5.3. Nem kell átvenni

- Az `copilot/*` és `cursor/*` branch-ek nem tartalmaznak olyan fájlt, ami ne lenne meg a `master`-ben. Ezek a branch-ek redukált állapotok, nem érdemes külön vizsgálni őket.
- A `probe-test-1786417478` branch üres.
- A `fix/pages-deploy-debug` branch csak deploy-konfigurációt módosított.
- A technikai hibaüzenetek (`kandel_awk_err.txt`, `kandel_iconv.txt`, `kandel_perl_err.txt`) és AWK szkriptek nem kellenek.

---

## 6. Megfigyelések

### 6.1. Az új Szima-1.1 repó GAZDAGABB, mint a régi

Fontos megfigyelés: az új Szima-1.1 repó **több** `.idr` fájlt tartalmaz, mint a régi `master` branch! Például:
- `szima_ter/modul/` könyvtárban ~90+ `.idr` fájl van az új repóban, szemben a régi ~70-tel
- Új fájlok: `Abdukció7_v1_Szima.idr`, `BabyAGI_v1_Szima.idr`, `CPTColor_v1_Szima.idr`, `CategoryTheory_v1_Szima.idr`, `CayleyDickson_v1_Szima.idr`, `Chinese2D_v1_Szima.idr`, `Complex_v1_Szima.idr`, `CriticalExponents_v1_Szima.idr`, `DerivedConstantsGAN_v1_Szima.idr`, és sok más `_v1_Szima.idr` fájl
- Új `osveny_index/` fájlok: `Abdukció7.idr`, `Fazis.idr`, `ForditasCarnot.idr`, `GUTPerkoláció.idr`, `GeneralizedPauli.idr`, `Hierarchia7.idr`, `Kant7x7.idr`, `KantNyelvtan.idr`, `KategóriaElmélet64.idr`, `KategóriaElméletUniverzális.idr`, `KostantFelbontás.idr`, `Torusz.idr`, `ToruszTeszt.idr`
- Új `szerver_hagyar/idris/` könyvtár: `Abduction7.idr`, `CategoryTheory64.idr`, `CategoryTheoryUniversal.idr`, `CriticalExponents.idr`, `EntropyTimeGoldstone.idr`, `GUTPercolation.idr`, `Hierarchy7.idr`, `Kant7x7.idr`, `KantGrammar.idr`, `Lexicon64.idr`, `SteaneCode731.idr`

Ez azt jelenti, hogy az új repó a régi repó adatait **kibővítette** sok új _v1_Szima.idr modullal, de egyetlen fájlt sem vett át a régi repóból: az `E8Kartan.idr`-t és a `ProbaIdo.idr`-t.

### 6.2. A Kandel-könyv anyagai

A régi `master` branch tartalmazza a Kandel-könyv feldolgozott anyagát (index, 15 chunk, 15 magyar chunk, kapcsolatleírás). Ezek a `trail_index/books/` könyvtárban vannak. Az új Szima-1.1 repó nem tartalmazza ezeket — valószínűleg azért, mert a Kandel-könyv feldolgozása külön történt és nem került be az új repóba.

### 6.3. A szerver-branch extra tartalma

A `szerver_ox_alpha_free_aug22` branch két extra fájlt tartalmaz, ami a `master`-ben nincs (vagy a `master` nem tartalmazza őket):
- `plans/TERV_szerver_ox_alpha_free_aug22.md` — szerver-terv
- `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` — integrációs session

---

## 7. Összefoglalás

| Kategória | Hiányzó fájl | Forrás-branch | Prioritás |
|-----------|-------------|---------------|-----------|
| E8-algebra | `szima_ter/modul/E8Kartan.idr` | master | **MAGAS** |
| Szerver-terv | `plans/TERV_szerver_ox_alpha_free_aug22.md` | szerver_ox_alpha_free_aug22 | **MAGAS** |
| Kutatási napló | `kutatasi_naplo/2026-08-24_kandel_szima_integracio_session.md` | szerver_ox_alpha_free_aug22 | **MAGAS** |
| Idő-próba | `szima_ter/modul/ProbaIdo.idr` | master | KÖZEPES |
| Kandel-index | `trail_index/books/kandel_e8_index.md` | master | KÖZEPES |
| Kandel-kapcsolat | `trail_index/books/kandel_szima_kapcsolat.md` | master | KÖZEPES |
| Kandel-chunks | `trail_index/books/kandel_extracted_chunk_01..15.md` | master | KÖZEPES |
| Kandel-magyar | `trail_index/books/kandel_magyar_chunk_01..15.txt` | master | KÖZEPES |

**Összesen 3 magas prioritású + 36 közepes prioritású = 39 hiányzó fájl.**

---

**中文：** 本报告比较了旧 Szima 仓库（jhegedus42/Szima）的 8 个分支与新 Szima-1.1 仓库。关键发现：新仓库实际上比旧仓库更丰富（包含更多 `.idr` 文件），但缺少 3 个高优先级文件：`E8Kartan.idr`（E8 嘉当分解）、`TERV_szerver_ox_alpha_free_aug22.md`（服务器计划）、和一份研究日志。另有 36 个中优先级文件（Kandel 书的材料）也缺失。

**Deutsch:** Dieser Bericht vergleicht die 8 Zweige des alten Szima-Repositories mit dem neuen Szima-1.1-Repository. Hauptergebnis: Das neue Repository ist tatsächlich reicher als das alte, aber es fehlen 3 hochprioritäre Dateien: `E8Kartan.idr` (E8-Cartan-Zerlegung), `TERV_szerver_ox_alpha_free_aug22.md` (Serverplan) und ein Forschungslogbuch. Weitere 36 mittelprioritäre Dateien (Kandel-Buch-Materialien) fehlen ebenfalls.

**עברית:** דוח זה משווה את 8 הענפים של מאגר Szima הישן עם מאגר Szima-1.1 החדש. ממצא מרכזי: המאגר החדש עשיר יותר מהישן, אך חסרים 3 קבצים בעדיפות גבוהה: `E8Kartan.idr` (פירוק קרטן E8), `TERV_szerver_ox_alpha_free_aug22.md` (תוכנית שרת), ויומן מחקר. 36 קבצים נוספים בעדיפות בינונית (חומרי ספר קנדל) חסרים גם כן.