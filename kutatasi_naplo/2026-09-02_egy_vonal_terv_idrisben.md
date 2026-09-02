# Kutatási napló — 2026-09-02 — «1 vonal van !» (az egyvonalas terv Idrisben)

## A felhasználó utasítása szó szerint (§N5)

«1 vonal van ! semmi parhuzamositas, az egy vonalat megtervezzuk, lepesrol lepesre, file-rol, file-ra, es az idriszt hasznaljuk a todo es terv elkeszitesere, olvasd el az ehhez kapcsolodo reszeket a projektben»

## Amit elolvastam (§N11 — a kapcsolódó részek)

1. **`szima_ter/modul/SajatTodo_v1.idr`** (557 sor) — a meglévő Idris-todo: `data Állapot` (Kész/Folyamatban/Vár), `data Prioritás` (Magas/Közepes/Alacsony), `record Feladat` (feladatSzáma, feladatCíme, feladatÁllapota, feladatPrioritása, feladatFájlja — `MkFeladat` konstruktor), 0-paddingolt sorszámok, állapotMódosító + alFeladatBeszúró, interaktív main. Ez az EGYETLEN todo-típus (§24).
2. **`horgony/szerver/TODOS/GenTodo.idr`** — grep-alapú TODO-markdown-generátor (eltérő cél; nem ezt a mintát követjük).
3. **`docs/TipusCsomagolasiTerv_2026-09-02.md`** — a saját tervem (a „három vonal" szekciója ELVETENDÓ — a felhasználó korrekciója).

## Az elkészült munka

### EgyVonalTerv_v1.idr — A TERV IDRISBEN

**Fájl:** `szima_ter/modul/EgyVonalTerv_v1.idr`
**Fordul:** `idris2 --check` = exit 0 ✓
**Fut:** `idris2 --exec main` = kiírja a 69 lépést + a következő lépést ✓

A terv EGY lineáris sorozat — `egyVonal : List Feladat` (a SajatTodo_v1 típusainak importálásával — §24, nincs duplikáció). Lekérdezések: `következőLépés`, `készLépésekSzáma`, `összesLépésSzáma` (69), `szakaszLépései`.

### A vonal szakaszai (69 lépés)

- **000 AZ ALAP** — 000.00 a terv-modul (KÉSZ) → 000.01 CsomagoltTípusok (minden data típus + typeclassok + Refl) → 000.02 Határ-modul → 000.03 a pilóta (LimitKolimitDemo data-típusokkal)
- **100 LEVELEK** (100.01–100.10) — HaromKubit, Torusz, GeneralizedPauli, Kérdőszó, Hipotetikus, KettőKategória, CayleyDickson, DiracGammaMátrixok, LejeuneTranszformáció, ToruszTeszt+Steane713Dependent
- **200 KÖZÉP** (200.01–200.33) — **Kodol (200.01) a MagyarNyelv (200.02) ELŐTT** (GAN függőségi él!), MagyarNyelvtan, FogalomFa, FázisAlgebra, KategóriaElmélet (a 10 limit/kolimit + GAN-kiegészítések megőrzése), KostantFelbontás_v2, Komplex, KvantumY, HadamardTávolság, E8Gyökrendszer (E8Koordináta!), OktonionAlgebra, HánMagyarKódolás (Betű/Szöveg), SzabályParszer, Kereső, Szótár (végEgyezikE!), Kant*, K_E9, LegkisebbMűvelet 6 fájl, **Legendre (87!)**, Geometria (HosszMennyiség), LawvereGödel, Dirac3D 20 fájl, Index fájlok, MiértLánc, Alap/ maradék 4, trail_index 12 (FaVizualizáció-együttés), SteaneHamiltonian, Rendszer
- **300 NAGY FÁJLOK** (300.01–300.08) — KategóriaElméletUniverzális (78), szerver_hagyar 11, **300.03: a szima_ter 138 fájljának sorszámozása az alFeladatBeszúróval** (a vonal saját magát bővíti!), AlphaSteane sorozat, SzótárHíd_v2 (végEgyezikE kritikus), E8Gyökök+KönyvAdat (124!), EpisodicMemory (89)+BabyAGI+Kémia+Műszerefal, a maradék
- **400 CSOMÓPONTOK A LEGVÉGÉN, EGY-EGY LÉPÉSBEN A TELJES LÁNC** — 400.01 E8E8Algebra (23 importáló) → 400.02 ModulRegisztráció (15) → 400.03 Steane713 (31 importáló — az UTOLSÓ)
- **500 ARCHIVÁLÁS** — tanulsagok/ 65 + diagnosztika/ (megőrzés, nem átírás)
- **600 A KUTATÁS FOLYTATÁSA** (600.01–600.10) — FÁZIS 1 maradék 24 fogalom (monada/komonád → morfizmus → funktor → magasabb → **dagger/kompakt zárt/szalagos/nyom (a SAJÁT!)** → toposz) → a gráf-adatbázis → a koncepciók/élek → Yoneda → a magyar 18 esetrag-keresés

### Önreflexivitás

A terv-modul maga is a vonal része: amikor a migráció a szima_ter fájlokhoz ér (300.03+), EZ A MODUL IS data-típusokra írható át — a terv a saját fejlődésének tervét is tartalmazza.

### A tervdokumentum frissítve

`docs/TipusCsomagolasiTerv_2026-09-02.md` V. szakasz: a „három vonal" ELVETVE — EGY VONAL (a terv Idrisben él, a dok csak összefoglal).

## A következő lépés (a program szerint)

`[VÁR] 000.01 CsomagoltTípusok: minden data típus + typeclassok + Refl-bizonyítások + SteaneVektor : Sorszám → Type (MAGAS)`

## Következtetés

A terv mostantól Idris-kód — nem markdown, nem beépített todo. A vonal 69 lépésből áll, a következő lépés a 000.01 (az alap-modul). «Lassú, precíz munka, semmi kapkodás.»

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★