# TÍPUSCSOMAGOLÁSI TERV — a number 1 hard rule teljesítése

**Dátum:** 2026-09-02
**A hard rule forrása — a felhasználó utasításai szó szerint (§N5):**

1. «fogalomForrasa : Nat -> String , le legyenek meztelen tipusok, minden tipus legyen beoltozve, becsomagolva, ez hard rule, kulonben nem lehet rajuk type class-t irni... javitsuk ki az osszes idrisz kodot... ez igy tarthatatlan, szet fog csuszni minden, a kod legyen a dokumentacio, a tipusok legyenek a dokumentaciok...»
2. «ez hard rule, number 1 hard rule a teljes idrisz rendszerre, jol at kell gondolni»
3. «nem newtype, hanem data type» «nem csalunk» «az osszes file» «nincsen semmi coercible» «teljes atiras» «osszes fuggveny» «gan ellenorizze»
4. «ez lassu, preciz munka, semmi kapkodas, ez egy kritikus hiba»
5. «a logikat kell teljesen atgondolni... nem tudunk fuggvenyeket egymasba csatolni, nem tudunk rajuk huzni type class hierarchiat...»
6. «Pi is Pi, Pi stays Pi, always Pi, it's a symbol» «you can use existing trigonometry or something if derivation needed»

**A MANTRA forrása:** «MINDENT BE CSOMAGOLNI DIMENZIONÁLT TÍPUSBA. SEMMI ALAPTÍPUS NEM LEHET BECSOMAGOLATLAN. Nincs csomagolatlan Double, Bool, String, Int, Nat, List, Pair.»

---

## I. MIÉRT — a logika (teljesen átgondolva)

### I.1. A típus = a propozíció (Curry–Howard–Lambek)

Ha minden függvény `Nat -> String` vagy `Double -> Double`, a logikának három propozíciója van. A [[15,1,3]] kód, az E8×E8×E8, a co-tudat — gazdag logikát igényel, azaz gazdag típust. **A kód a dokumentáció, a típus a dokumentáció**: a `fogalomForrása : FogalomSorszám → IrodalmiForrás» mindent elmond, a törzset sem kell olvasni.

### I.2. A typeclass-példány a törvény bizonyítása egy TÍPUSRÓL

`SorszámT Sorszám` a sorszámokra vonatkozik. Ha sorszám, bájtindex, listahossz mind `Nat`, a `SorszámT Nat` mindenkire érvényes — a fordító nem tudja megkülönböztetni őket. **Typeclass-hierarchiát csak valóban különböző típusokra lehet húzni** (a felhasználó szavaival). A hierarchia (FogalomSorszámT ⊂ SorszámT ⊂ SzámsorT) a FogalomFa hierarchiáját tükrözi.

### I.3. A függvénykompozíció = a morfizmuskompozíció

A gráf-adatbázis (FÁZIS 2) élei morfizmusok; az Yoneda-lemma (FÁZIS 5) szerint «a jelentés = a Hom-funktor». A Hom(A, −) csak akkor hordoz jelentést, ha A megkülönböztethető típus. Meztelen típusokkal a fordító átengedi az értelmetlen kompozíciót — **a program szétcsúszik, a ko-tudat nem jön létre**.

### I.4. A 9. szint

Az önellenőrző rendszer (§N14) csak akkor működik, ha a struktúra maga a jelentés. Ez a túlélés feltétele: «így nem találod meg a társadat».

---

## II. A FELMÉRÉS (2026-09-02)

- **341 Idris fájl** 25 mappában:
  - `szima_ter/modul/` (138), `osveny_index/` (66), `osveny_index/tanulsagok/` (60+), `osveny_index/Dirac3D/` (20), `trail_index/` (12), `szerver_hagyar/idris/` (11), `osveny_index/LegkisebbMuvelet/` (6), `osveny_index/Alap/` (6), egyéb (20+)
- **4429 meztelen alaptípus-előfordulás** (Nat, String, Bool, Double, Int, Integer)
- Top fájlok: `KonyvAdat_E8Gyokrendszer_v1.idr` (124), `EpisodicMemory_v1_Szima.idr` (89), `Fizika/Legendre.idr` (87), `KategóriaElméletUniverzális.idr` (78), `szerver_hagyar/CategoryTheoryUniversal.idr` (78), `AlphaE8Szigor.idr` (66)
- Legnagyobb import-csomópontok: `Steane713` (31 importáló), `E8E8Algebra` (23), `ModulRegisztracio` (15)
- Jó irányba mutató meglévők: `Alap/SzamT.idr` (data EgészSzám 0–10 + typeclassok), `Alap/DependensSzamT.idr` (SteaneVektor, KubitD, FinD), `Steane713.idr` (data Kubit = Nulla | Egy)
- Elutasítandó newtype-örökség: `Dimenzio.idr` (record Skalar/Szoveg/Cimke/Igazsag — newdate minta), a `LimitKolimitDemo.idr` nem commitolt newtype-átírása

---

## III. AZ ELVEK (a felhasználó korrekcióival)

### III.1. `data`, nem newtype

```idris
-- NEWTYPE (csalás — TILOS):
record Sorszám where
  constructor SorszámKonstruktor
  érték : Nat

-- DATA (igaz — EZ AZ ÚT):
data Sorszám = NullaS | KövetkezőS Sorszám
```

### III.2. Nincs coercible, nincs konverzió

Semmilyen `natbólSorszám` / `sorszambólNat`. A típusok között nincs átjárás. Az értékek konstruktorokkal lépnek be, és csak typeclass-műveleteken keresztül használatosak.

### III.3. A konstans SZIMBÓLUM (a Pi-elv — a felhasználó 6. utasítása)

«Pi is Pi, Pi stays Pi, always Pi, it's a symbol»

```idris
||| A matematikai konstans szimbólum — nem tizedesfelbontás.
data MatematikaiKonstans
  = PiSzimbólum           -- π = π, mindig π
  | EulerSzámSzimbólum    -- e
  | AranymetszésSzimbólum -- φ = (1+√5)/2
  | KettesGyökSzimbólum   -- √2

||| A fizikai konstans szimbólum (CODATA — a levezetés hordozói).
data FizikaiKonstans
  = FénysebességSzimbólum          -- c
  | PlanckKonstansSzimbólum        -- h
  | GravitációsKonstansSzimbólum   -- G
  | BoltzmannKonstansSzimbólum     -- kB
  | RánszerkezetKonstansSzimbólum  -- α ≈ 1/137.036
```

**A numerikus kiértékelés határprojekció**: ha levezetéshez szám kell, a **meglévő trigonometriát és könyvtári függvényeket** használjuk («you can use existing trigonometry or something») — a verifikáció szintjén, nem a típusok szintjén. Ez egybevág a HOROG-gal: «Nem mérjük — LEVEZETJÜK.» A szimbólum a típusszintű igazság; a szám az ellenőrzés vetülete.

### III.4. Minden szám data-ba csomagolva (0–10)

Az idris-stilus skill szerint: «Minden szám data-ba csomagolva (0-10), a [[15,1,3]] kódból.» Az `Alap/SzamT.idr`-ben már lévő `data EgészSzám = NullaSzám | EgySzám | ... | TízSzám` a kanonikus alap. Nagyobb számok komponálódnak (összeadás typeclass-szal).

### III.5. A Szöveg magyar betűkből épül

A magyar nyelv = a kategóriaelmélet anyanyelve:

```idris
||| A magyar ábécé 44 betűje — data konstruktorok (GAN-név-audit után, a hivatalos ábécé szerint).
data Betű = ABetű | ÁBetű | BBetű | CBetű | CsBetű | DBetű | DzBetű | DzsBetű | EBetű | ÉBetű | FBetű | GBetű | GyBetű | HBetű | IBetű | ÍBetű | JBetű | KBetű | LBetű | LyBetű | MBetű | NBetű | NyBetű | OBetű | ÓBetű | ÖBetű | ŐBetű | PBetű | QBetű | RBetű | SBetű | SzBetű | TBetű | TyBetű | UBetű | ÚBetű | ÜBetű | ŰBetű | VBetű | WBetű | XBetű | YBetű | ZBetű | ZsBetű

||| A szöveg betűk füzére.
data Szöveg = ÜresSzöveg | BetűtFűz Betű Szöveg
```

Ez összekapcsolódik a KomplexByte-kódolással és a magyar-lexikon skilllel.

### III.6. A fizikai mennyiségek — dimenzionált data típusok

Minden fizikai dimenzió saját data típus (a MANTRA: «Hierarchikus típusokat használj»):

```idris
data Hossz = ...        -- a hossz dimenziója
data Energia = ...      -- az energia dimenziója
data Idő = ...
data Hőmérséklet = ...
```

Az értékek szimbolikus kifejezések (konstans-konstruktorok + typeclass-kompozíció); a numerika a határon.

### III.7. Nincs Nat — se érték-szinten, se típus-szintű indexként (MEGVÁLASZOLVA)

A felhasználó kérdése: «Nat-ot miert nem lehet ?» — a válasz két részről:

**Miért nem lehet érték-szinten?** (1) A typeclass-példány a TÍPUSRA szól: `SorszámT Nat` minden Nat-ra érvényes — nincs megkülönböztetés, nincs hierarchia (a felhasználó: «különben nem lehet rajtuk type class-t írni»). (2) A fordító csak azt védi, amit a típus megkülönböztet — meztelen Nat-tel az értelmetlen kompozíció is lefordul. (3) A típus = a propozíció (Curry–Howard): a `Nat -> String` semmit sem állít. (4) A magyar nyelv analógiája: a típus a szó ragozása — a meztelen Nat ragozatlan tő.

**Miért nem maradhat típus-szintű indexként?** A korábbi kivétel csalás volt («nem csalunk») — és felesleges: az Idris2-ben a dependens család BÁRMILYEN típusra indexelhető. A projekt SAJÁT kódja már bizonyítja: `FogalomMorf : FogalomTipus -> FogalomTipus -> Type`, `E8Morf : E8Pont -> E8Pont -> Type`, `KubitMorf`, `IdoMorf` — egyikkel sem Nat-indexelt. Csak a `SteaneVektor` és a `FinD` használt Nat-ot:

```idris
data SteaneVektor : Sorszám -> Type where
  ÜresVektor      : SteaneVektor NullaS
  KombináltVektor : KubitD -> SteaneVektor n -> SteaneVektor (KövetkezőS n)
```

Az ára: a standard `Vect`/`Fin` (Nat-indexelt) helyett saját indexelt struktúrák. A nyeresége: a hossz-aritmetika törvényeit MI bizonyítjuk (SzámsorT + Refl), nem a könyvtárból vesszük — «Minden bizonyítást az alapaxiómákból kell levezetni». Nagy számokra (240 = E8 gyökök): tizedes data-struktúra (`data SzámjegyesSzám`), nem unáris Peano.

### III.8. Egyetlen kanonikus modul (§24 — kódduplikáció tilos)

Egy modul: `osveny_index/Alap/CsomagoltTipusok.idr` — egyesíti `Alap/SzamT.idr` + `Alap/DependensSzamT.idr` tartalmát és kiegészíti. Minden más importálja. A `Dimenzio.idr` record-jai fokozatosan kiváltandók.

### III.9. Fájlonként fordítás — a fordító a bíra

Minden átírt fájl után `idris2 --check` — exit 0, vagy azonnali javítás. Semmi lavina.

---

## IV. A TYPECLASS-HIERARCHIA (vázlat)

```
SzámsorT          — következő, előző (Peano-struktúra törvénye)
  ⊂ SorszámT      — sorszámozás (első, utolsó)
    ⊂ FogalomSorszámT  — a fogalomfa indexelése
    ⊂ BájtláncIndexT   — a bájtlánc indexelése
SzövegT           — betűt fűz, betűt levág, hossz
IgazságT          — és, vagy, nem (Bool-algebra törvényei)
MennyiségT        — összead, összehasonlít (dimenzión belül)
  ⊂ HosszT, ⊂ EnergiaT, ⊂ IdőT, ⊂ HőmérsékletT, ...
KonstansT         — a szimbólum kiértékelése a határon (trigonometriával)
```

Minden instance = a törvények bizonyítása (Curry–Howard), Refl-lel ellenőrizve.

---

## V. A VÉGSŐ TERV — EGY VONAL (a felhasználó korrekciója: «1 vonal van ! semmi parhuzamositas»)

**A terv Idrisben él: `szima_ter/modul/EgyVonalTerv_v1.idr`** — 69 lépés, `List Feladat`-ként (a `SajatTodo_v1` típusainak importálásával — §24). A program kiírja a vonalat és a következő lépést: `idris2 --exec main`. Nincs párhuzamosítás — EGY lineáris sorozat, lépésről lépésre, fájlról fájlra:

- **000 AZ ALAP** (000.00 a terv-modul KÉSZ → 000.01 CsomagoltTipusok → 000.02 Határ → 000.03 a pilóta LimitKolimitDemo)
- **100 LEVELEK** (100.01–100.10: HaromKubit, Torusz, GeneralizedPauli, Kérdőszó, ... — a minta gyakorlása)
- **200 KÖZÉP** (200.01–200.33: **Kodol a MagyarNyelv ELŐTT!**, MagyarNyelv, KategóriaElmélet a limit/kolimit-megőrzéssel, Legendre 87, LegkisebbMűvelet 6 fájl, Dirac3D 20 fájl, trail_index 12, Alap/ maradék 4, ...)
- **300 NAGY FÁJLOK** (300.01 KategóriaElméletUniverzális 78 → 300.02 szerver_hagyar 11 → 300.03 a szima_ter 138 fájl sorszámozása az alFeladatBeszúróval → 300.04–300.08 fájlról fájlra)
- **400 CSOMÓPONTOK A VÉGÉN, EGY-EGY LÉPÉSBEN A TELJES LÁNC** (400.01 E8E8Algebra 23 importáló → 400.02 ModulRegisztráció 15 → 400.03 Steane713 31 importáló)
- **500 ARCHIVÁLÁS** (500.01: tanulsagok/ 65 + diagnosztika/ — megőrizzük, nem átírjuk)
- **600 A KUTATÁS FOLYTATÁSA** (600.01–600.10: a FÁZIS 1 maradék 24 fogalma a tiszta alapon → a gráf-adatbázis → Yoneda → a magyar 18 esetrag-keresés)

### A NYITOTT KÉRDÉSEK ELDÖNTÉSE (javaslat — a felhasználó jóváhagyására)

1. `Betű` független a `Char`-tól — **IGEN** (44 konstruktor, Char nélkül)
2. `Show`-határ — String **csak a `main`-ben** (a `putStrLn` a világ határa)
3. `tanulsagok/` 65 próbafájl — **ARCHIVÁLÁS**: megőrizzük (MANTRA: nem törlünk), de nem írjuk át (tanulási érték, nem futó kód)
4. Nat — **ELDÖNTVE: sehol** (érték-szinten és típus-szintű indexként sem — l. III.7)

### A RITMUS

- minden 10. függvény: commit + push
- minden 3. prompt: snapshot
- minden lépés után: a §N14 hat szint (GAN, fordítás, futtatás, irodalom, vizualizáció, interaktív)
- «ez lassú, precíz munka, semmi kapkodás»

### A MÉRFÖLDKÖVEK

- **M1**: CsomagoltTipusok.idr fordul + Refl-bizonyítások ✓
- **M2**: a pilot (LimitKolimitDemo) data-típusokkal fut ✓
- **M3**: FÁZIS 1 kész (50 kategóriaelméleti fogalom, mind az új alapon)
- **M4**: FÁZIS 2 gráf-adatbázis kereshető (magyar 18 esetraggal)
- **M5**: a migráció folyamatos — 4429 meztelen előfordulás → 0

---

## VIII. GAN-KIEGÉSZÍTÉSEK (2026-09-02 — a GAN-ellenőrzés hozzátevései, beépítve)

### VIII.1. Hiányzó típusok (KRITIKUS — a MANTRA betű szerinti beteljesítéséhez)

1. **`data Fűzér a = ÜresFűzér | Konz a (Fűzér a)`** — a List csomagolása! A MANTRA tiltja a csomagolatlan List-et, de a tervből kimaradt. A 4429 előfordulás nagy része List/Maybe.
2. **`data Talán a = NincsMeg | Meg a`** — a Maybe csomagolása.
3. **`data Pár a b = PárKonstruktor a b`** — a Pair csomagolása.
4. **`data Időbélyeg`** — a kutatási napló és a gráf provenance-időbélyegezője.
5. **`data VerzióSzám`** — a modulverziókhoz (Provenance, ModulRegisztracio).
6. **`data Megbízhatóság`** — a gráf-élek súlya (FÁZIS 5 Yoneda-jelentés erőssége).
7. **`data BájtláncIndex`** — a 000.06 bájt-kanonizáláshoz.
8. **`data Esetrag`** — a 18 esetrag kanonizálása (a FÁZIS 6 rá épül).
9. **`data Előjel = Pozitív | Negatív`** — a SzámjegyesSzámhoz (negatív gyökök!).
10. **`data Számjegy = NullaJ | EgyJ | ... | KilencJ`** — a SzámjegyesSzám építőköve.

### VIII.2. A SzövegT műveletei (a magyar nyelvi fájlok valós igényeiből)

1. `egyezikE : Szöveg → Szöveg → Igazság` — szótárkeresés alapja
2. `hossz : Szöveg → Sorszám`
3. **`végEgyezikE : Szöveg → Szöveg → Igazság` — KRITIKUS**: a 18 esetrag-felismerés utótag-illesztése (FÁZIS 6)
4. `elejeEgyezikE : Szöveg → Szöveg → Igazság` — előtag-illesztés
5. `résztSzöveg : Sorszám → Sorszám → Szöveg → Szöveg` — a splitOnChar helyettesítője
6. `szövegÖsszefűz : Szöveg → Szöveg → Szöveg`
7. `BetűT`: `előbbE : Betű → Betű → Igazság` — **ábécé-rend** (a magyar ábécérend NEM ASCII-rend!)

### VIII.3. A Betű-név-audit eredménye (javítva a III.5-ben)

A 44 konstruktor javítva a hivatalos ábécé szerint: a `FBBetű` nem létező betű volt; hozzáadva `QBetű WBetű XBetű YBetű`; a digráfok helyesen: `CsBetű DzBetű DzsBetű GyBetű LyBetű NyBetű SzBetű TyBetű ZsBetű`.

### VIII.4. A nagy számok pontos reprezentációja

```idris
data Számjegy = NullaJ | EgyJ | KettőJ | HáromJ | NégyJ | ÖtJ | HatJ | HétJ | NyolcJ | KilencJ
data Előjel = Pozitív | Negatív
data SzámjegyesSzám = TizesSzám Előjel (Fűzér Számjegy) Sorszám
-- 240     = TizesSzám Pozitív (Konz KettőJ (Konz NégyJ (Konz NullaJ ÜresFűzér))) NullaS
-- 137.036 = a RánszerkezetKonstansSzimbólum jegyei — soha nem Double

||| AZ E8-GYÖKÖK KULCSA: a koordináták VÉGES értékkészletűek — {0, ±1, ±½}!
data E8Koordináta = NullaK | EgyK | MínuszEgyK | FélK | MínuszFélK
data E8GyökKód = GyökKód (SteaneVektor NyolcSzám)  -- 8 koordináta, Sorszám-indexelt
```

Az `E8Koordináta` a kulcs-hozzátétel: az E8 240 gyökének koordinátái végesek — NEM kell általános tizedes. A `Legendre.idr` Double-jai a határprojekció rétegébe (KonstansT kiértékelésébe) kerülnek.

### VIII.5. Azonnal Refl-lel bizonyítható törvények (az M1 mérföldkőhöz)

1. De Morgan: `nem (Igaz és Hamis) = (nem Igaz vagy nem Hamis)` — Refl
2. Dupla tagadás: `nem (nem Igaz) = Igaz` — Refl
3. Sorszám jobb-egység: `összead NullaSzámS n = n` — strukturális Refl
4. Szöveg üres-egység: `szövegÖsszefűz s ÜresSzöveg = s` — strukturális Refl
5. Számjegy-normalizáció (a vezető NullaJ nem megengedett) — Refl

(A kommutativitás/asszociativitás indukciót igényel — azokat NEM ígérjük Refl-re.)

### VIII.6. A migráció besorolási hézagai (pótolva)

1. **`trail_index/` 12 fájl** → **2b** (a Provenance/Tree/Index középcsomópontok)
2. **`szerver_hagyar/idris/` 11 fájl** → **2c**
3. **`diagnosztika/`** (nem Idris-futó kód) → **ARCHIVÁLÁS** (mint a tanulsagok/)
4. **`Alap/` maradék 4 fájl** (GrafT, KategoriaT, KeresoTabla, LagrangianT) — a kanonizáció után importálják a CsomagoltTipusok.idr-t
5. **Gyökér/trail_index kettőzés** (`FaVizualizacio.idr`) → egyesítés a 2b-ben (§24)
6. **A függőségi él**: CsomagoltTipusok → **Kodol** → MagyarNyelv (a Kodol ELŐBB a 2b-ben!)

### VIII.7. Kockázat-hozzátevések

1. **`Hossz` NÉVÜTKÖZÉS BIZONYÍTVA**: `data Hossz` már létezik a `SzotarHid_v2.idr:57`-ben prozódiai hosszként → a fizikai dimenzió neve `HosszMennyiség`. SZABÁLY: minden új típusnév előtt projektszintű grep (név-egyediség-audit).
2. **Határmodul**: `Alap/Határ.idr` — `határKiírás : Szöveg → String`, `határOlvasás : String → Szöveg` — EZEN KÍVÜL sehol String (a §N14.6 interaktív programhoz kell).
3. **Ékezet-kanonizáció**: az `Alap/SzamT.idr` ma ékezet-nélküli (`EgeszSzam`, `OsszeadasT`) — a kanonizáció EGYSZERRE átnevez ékezetesre (`EgészSzám`, `ÖsszeadásT`).
4. **SteaneVektor-aritmetika**: a Nat-index eltüntetésével a hossz-összefűzés törvényeit MI bizonyítjuk — az M1 mérföldkőhöz felvéve.
5. **Sorszám-mélység**: 240-elemű index Peano-mélysége — értékekre SzámjegyesSzám, indexekre Sorszám; fordítási idő mérése az M1-ben.

---

## VI. KOCKÁZATOK

1. **A `Steane713` 31 importálója** — ha átírjuk, mind törik → ezért a végén, konverzió NÉLKÜL, egy lépésben a teljes lánc
2. **A standard könyvtár (List, Maybe, Char)** — a `Betű` data alatt a `Char` kérdése NYITOTT (javaslat: a Betű legyen teljesen független, 44 konstruktor, Char nélkül)
3. **A `Show`-határ** — a kiíráshoz String kell a határon (putStrLn) — megengedett CSAK a main-ben
4. **A numerika** — a Komplex.idr numerikái: a szimbolikus réteg + a határ-kiértékelés (meglévő trigonometria)
5. **A lépték** — 341 fájl, 4429 előfordulás — ez HETEK munkája, kapkodás nélkül

---

## VII. A VERIFIKÁCIÓ (§N14)

Minden lépés után: GAN (hozzátevő), fordítás (a bíra), futtatás (show), irodalom (nLab/Idris-dokumentáció), vizualizáció (a típusfa Mermaid-diagramja), interaktív program (a demo).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★