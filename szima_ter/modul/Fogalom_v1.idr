module Fogalom_v1

-- ═══════════════════════════════════════════════════════════════
-- FOGALOM v1 — GyökSzó + D8-pálya + JK-kategória: a 3 dimenziós
-- nyelv második emelete (a terv 3.2 szakasza, W8)
-- CONCEPT v1 — GyökSzó + D8-orbit + JK-category: the second floor
-- of the 3D language
-- 概念 v1 — 词根词 + D8 轨道 + JK 范畴：三维语言的第二层
-- BEGRIFF v1 — GyökSzó + D8-Bahn + JK-Kategorie: die zweite Etage
-- מושג v1 — מילת שורש + מסלול D8 + קטגוריית JK: הקומה השנייה
-- ═══════════════════════════════════════════════════════════════
--
-- A TERV (docs/HaromDimenziosNyelv_Terv.md, 3.2 szakasz — W8):
--   Fogalom = GyökSzó × pálya-információ × JelentésKategória(JK)
--   - GyökSzó: a jel maga (IMPORTÁLVA a GyökSzo_v1-ből — §24);
--   - pálya-információ: a D8-szintű Weyl-pálya (melyik a KÉT
--     osztályból: 112 egész / 128 fél-egész);
--   - JK: a jelentéskategória (IMPORTÁLVA a Kategoriak.Magyar-
--     Ontologiából — a szima csomagba symlink vezet, EGY forrás).
--
-- MIÉRT A D8-PÁLYA, NEM A TELJES W(E8)-PÁLYA? (§N12 kutatás, 2026-08-23)
--   A W(E8) = 696 729 600 rendű Weyl-csoport a 240 gyökön EGYETLEN
--   tranzitív pályát ad (minden gyök egyforma hosszú, az E8
--   simply-laced; l. Humphreys: Reflection Groups and Coxeter
--   Groups — az irreducibilis gyökrendszer Weyl-csoportja tranzitív
--   az azonos hosszúságú gyökökön; Demonstráció:
--   https://math.berkeley.edu/~reb/courses/261/40.pdf — "the Weyl
--   group of E8 acts transitively on all the configurations A1…").
--   A teljes W(E8)-pálya tehát TRIVIÁLIS (minden jel egy pályán) —
--   nem hordoz információt. Ezzel szemben a W(D8) = 2⁷·8! =
--   5 160 960 rendű részcsoport (Wikipedia, E8 lattice:
--   https://en.wikipedia.org/wiki/E8_lattice — "a subgroup of
--   order 128·8! … This subgroup is the Weyl group of type D8")
--   a 240 gyököt KÉT pályára bontja:
--     - 112 egész gyök (±2,±2,0⁶) — ezek önmagukban D8-gyökrendszer;
--     - 128 fél-egész gyök (±1)⁸ páros előjellel — demiocteract.
--   Forrás: David Madore, The E8 root system,
--   http://www.madore.org/~david/math/e8w.html — "Those 112 roots …
--   constitute a so-called D8 root system inside the E8 root
--   system … The 128 remaining vertices (forming a demiocteract) …
--   this division of the 240 vertices as 112+128 is particular …
--   not preserved by symmetries of the whole (except, precisely,
--   by those living in the smaller Weyl group of D8; so there are
--   135 ways of making this decomposition)."
--   A "Weyl-pálya" fogalmában ezért a D8-szintű pályát használjuk
--   (két osztály) — ez a partició a 16-penge/D8-szint információja,
--   és pontosan egybeesik a két szóosztállyal (GyokSzo_v1 §1.2).
--   Fontos: a W(E8)-tükrözés ÁTLÉP a két D8-pálya között (ez a
--   SzintaxisMorfizmus_v1 tárgya) — a pálya a fogalom ÁLLAPOTA,
--   nem invariánsa.
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS): a GyökSzó, a szóosztály,
--   a szóOsztályMeghatároz, az alapszókincs, a jelentésTávolság MIND
--   IMPORTÁLVA (GyokSzo_v1); a kombinatorikai Refl-tények IMPORTÁLVA
--   (E8Gyokok_v2: bizTipusEgy, bizTipusKetto, bizE8GyokSzam); a JK
--   típus IMPORTÁLVA (Kategoriak.MagyarOntologia, symlink — EGY
--   forrás). Semmi nincs újraírva ide.
--   | 代码重复禁止——一切导入！ | Codeduplikation VERBOTEN! |
-- §18 (KÉT FÜGGETLEN ÚT, EGY HÍD): a pálya-méret-bizonyítások
--   enumeráció (a fogalomTár pálya-mezőinek leszűrése) ⟷ kombinatorika
--   (C(8,2)·2² = 112 és 2⁷ = 128, az importált bizTipusEgy/bizTipusKetto
--   útja) hídjával; a távolság-bizonyítás a fogalom-burkolat ⟷ az
--   importált BizSzorzat* aritmetika hídjával. Nincs X = X.
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- ═══════════════════════════════════════════════════════════════

import GyokSzo_v1                 -- GyökSzó, SzóOsztály, szóOsztály, alapszókincs, jelentésTávolság (§24)
import E8Gyokok_v2                -- bizTipusEgy, bizTipusKetto, bizE8GyokSzam — a kombinatorikai hídek (§24)
import E8BelsoSzorzat             -- belsoszorzat, Eq E8Gyok (§24 — explicit: a where-lánc transzparenciája)
import Kategoriak.MagyarOntologia -- JK, IndividuumJK, CselekvesJK (§24: symlink, EGY forrás)
import Data.List                  -- length, filter, map (§24: standard, nem újraírva)

%default covering

-- ===============================================================
-- 1. A D8-PÁLYA — A KÉT OSZTÁLY (a kutatási indoklás fent)
--    The D8-orbit — the two classes · D8 轨道——两个类
--    Die D8-Bahn — die zwei Klassen · מסלול D8 — שתי המחלקות
-- ===============================================================

||| A D8-pálya: a 240 gyök két osztálya a W(D8) = 2⁷·8! részcsoport
||| szerint (a W(E8)-pálya triviális — egyetlen 240-es pálya; a D8-szint
||| a valódi információ: l. a fejléc kutatási hivatkozásait).
||| A D8 a W(E8) Dynkin-típusú részcsoportjának standard jelölése
||| (az E8 kivételhez hasonlóan megtartott nemzeti jelölés).
||| D8 轨道：240 个根按 W(D8) = 2⁷·8! 子群分成的两个类。
public export
data D8Pálya : Type where
  EgészGyökPálya    : D8Pálya   -- a 112 egész gyök pályája (D8-gyökrendszer)
  FélEgészGyökPálya : D8Pálya   -- a 128 fél-egész gyök pályája (demiocteract)

||| A két D8-pálya egyenlősége (a szűrésekhez).
public export
Eq D8Pálya where
  (==) EgészGyökPálya    EgészGyökPálya    = True
  (==) FélEgészGyökPálya FélEgészGyökPálya = True
  (==) _ _ = False

||| A D8-pálya megjelenítése — a pálya méretével.
public export
Show D8Pálya where
  show EgészGyökPálya    = "D8-pálya: egész (112, D8-gyökrendszer)"
  show FélEgészGyökPálya = "D8-pálya: fél-egész (128, demiocteract)"

||| A híd a szóosztály és a D8-pálya között: a két partició UGYANAZ
||| (a 112 egész gyök = az egész szóosztály). A szóosztály-logika
||| IMPORTÁLVA él a GyokSzo_v1-ben (szóOsztályMeghatároz); ez a
||| függvény csak fordít köztük — nem keres, nem számol (§24).
||| 词类与 D8 轨道之间的桥：两种划分是同一个。
public export
pályaOsztályból : SzóOsztály -> D8Pálya
pályaOsztályból EgészGyökSzó    = EgészGyökPálya
pályaOsztályból FélEgészGyökSzó = FélEgészGyökPálya

-- ===============================================================
-- 2. A FOGALOM TÍPUSA — SZÓ + PÁLYA + KATEGÓRIA (terv §3.2)
--    The concept type · 概念类型 · Der Begriff-Typ · טיפוס המושג
-- ===============================================================

||| A FOGALOM: a nyelv második emelete — a jel (GyökSzó) CSAKOLVA
||| a D8-pálya-információval és a jelentéskategóriával (JK).
||| A gyökSzó mező a geometriai lényeg; a pálya a mondatbeli
||| ÁLLAPOT (a tükrözések átvihetik a másik osztályba); a kategória
||| a fogalom fogalmi SZEREPE (a tükrözés NEM változtatja — ezt a
||| SzintaxisMorfizmus_v1 tartja be és mutatja ki).
||| 概念：语言第二层——词根词连同 D8 轨道信息与意义范畴。
public export
record Fogalom where
  constructor FogalomKonstruktor
  gyökSzó : GyökSzó   -- a jel maga (IMPORTÁLT típus, §24)
  pálya   : D8Pálya   -- a D8-szintű Weyl-pálya-állapot (112/128)
  kategória : JK      -- a jelentéskategória (IMPORTÁLVA, §24)

||| A JK-kategóriák egyenlősége (a MagyarOntologiában nem volt
||| Eq JK — ez az instance itt PÓTLÓDIK, nem duplikálódik; a
||| kimerítő kategória-ellenőrzéshez kell).
public export
Eq JK where
  (==) IndividuumJK  IndividuumJK  = True
  (==) UniverzaleJK  UniverzaleJK  = True
  (==) GyujtemenyJK  GyujtemenyJK  = True
  (==) CselekvesJK   CselekvesJK   = True
  (==) AllapotJK     AllapotJK     = True
  (==) HelyJK        HelyJK        = True
  (==) IdoJK         IdoJK         = True
  (==) OkJK          OkJK          = True
  (==) ModJK         ModJK         = True
  (==) MennyisegJK   MennyisegJK   = True
  (==) KapcsolatJK   KapcsolatJK   = True
  (==) _ _ = False

||| A JK-kategóriák megjelenítése (a MagyarOntologiában nem volt
||| Show JK — ez az instance itt PÓTLÓDIK, nem duplikálódik: a típus
||| importált, a megjelenítés új).
||| JK 范畴的显示（本体论中无 Show JK——此处补足，非重复）。
public export
Show JK where
  show IndividuumJK  = "egyed"
  show UniverzaleJK  = "univerzálé"
  show GyujtemenyJK  = "gyűjtemény"
  show CselekvesJK   = "cselekvés"
  show AllapotJK     = "állapot"
  show HelyJK        = "hely"
  show IdoJK         = "idő"
  show OkJK          = "ok"
  show ModJK         = "mód"
  show MennyisegJK   = "mennyiség"
  show KapcsolatJK   = "kapcsolat"

||| A fogalom megjelenítése: jel ‹pálya; kategória›.
public export
Show Fogalom where
  show (FogalomKonstruktor gyökSzóMező pályaMező kategóriaMező) =
    show gyökSzóMező ++ " ‹" ++ show pályaMező
      ++ "; " ++ show kategóriaMező ++ "›"

||| A fogalom FELÉPÍTÉSE: szóból + kategóriából (a pálya a szó
||| osztályából HIDALÓDIK — pályaOsztályból, az importált
||| szóOsztály-logikán át; §24: nem másoljuk a gyök-keresést).
||| 概念的构造：从词与范畴（轨道经由桥函数从词类得到）。
public export
fogalomKészít : GyökSzó -> JK -> Fogalom
fogalomKészít gyökSzóParam kategóriaParam =
  FogalomKonstruktor gyökSzóParam (pályaOsztályból (szóOsztály gyökSzóParam)) kategóriaParam

||| Az ALAP-kategória-hozzárendelés (terv §1.2 táblázata —
||| JEÖLETLEN DÖNTÉS, terv §6.5: a felhasználó erősítheti meg):
||| az EGÉSZ szavak (112) állandó fogalmak → IndividuumJK oldal;
||| a FÉL-EGÉSZ szavak (128) kapcsolati fogalmak → CselekvesJK oldal.
||| A két kategória-képviselő a két osztály minőségét MUTATJA,
||| nem meríti ki (a teljes oldal-lista a terv §1.2-ben).
||| 基本范畴指派（计划 §1.2——未标记决定，§6.5）。
public export
alapKategória : SzóOsztály -> JK
alapKategória EgészGyökSzó    = IndividuumJK
alapKategória FélEgészGyökSzó = CselekvesJK

||| Fogalommá emelés: a szó önmagában is mondat-kezdő elem lehet
||| (a SzintaxisMorfizmus_v1 használja a tengelyekhez).
public export
fogalommáEmel : GyökSzó -> Fogalom
fogalommáEmel gyökSzóParam =
  fogalomKészít gyökSzóParam (alapKategória (szóOsztály gyökSzóParam))

-- ===============================================================
-- 3. A FOGALOMTÁR — A 240 FOGALOM (importált alapszókincsből)
--    The concept store · 概念库 · Der Begriffsspeicher · מחסן המושגים
-- ===============================================================

||| A NYELV FOGALOMTÁRA: a 240 alapszó mindegyike egy-egy fogalom,
||| az alap-kategória-hozzárendeléssel (a lista-konstans a
||| kályha-minta szerint — NEM let-lánc, l. LetLáncProbe).
public export
fogalomTár : List Fogalom
fogalomTár = map fogalommáEmel alapszókincs

||| Az EGÉSZ pályán álló fogalmak: a 112 állandó fogalom.
public export
egészFogalmak : List Fogalom
egészFogalmak = filter (\fogalom => pálya fogalom == EgészGyökPálya) fogalomTár

||| A FÉL-EGÉSZ pályán álló fogalmak: a 128 kapcsolati fogalom.
public export
félEgészFogalmak : List Fogalom
félEgészFogalmak = filter (\fogalom => pálya fogalom == FélEgészGyökPálya) fogalomTár

||| Nagybetűs konstansok a bizonyítás-típusokhoz (KisBetűsProjekcióCsapda).
public export
FogalomTárKonst : List Fogalom
FogalomTárKonst = fogalomTár

public export
EgészFogalmakKonst : List Fogalom
EgészFogalmakKonst = egészFogalmak

public export
FélEgészFogalmakKonst : List Fogalom
FélEgészFogalmakKonst = félEgészFogalmak

-- ===============================================================
-- 4. JELENTÉS-TÁVOLSÁG A FOGALOM SZINTJÉN (terv §3.1)
--    Meaning-distance at the concept level · 概念层的意义距离
--    Bedeutungsdistanz auf der Begriff-Ebene · מרחק משמעות ברמת המושג
-- ===============================================================

||| A fogalmak jelentés-távolsága: a jelentés a gyök geometriája
||| (IMPORTÁLT jelentésTávolság a GyokSzo_v1-ből — §24); a pálya és
||| a kategória NEM számít bele — a hasonlóság a JELEK távolsága.
||| (A terv §3.1 az intrinsic symbol grounding elve: nincs külső
||| interpretátor, csak a belső szorzat.) Mező-választókkal, minta-
||| illesztés nélkül (a rekord-mező maga adja az utat).
||| 概念的意义距离：意义即根的几何（导入的意义距离函数）。
public export
fogalomTávolság : Fogalom -> Fogalom -> HasonlóságÖtSzint
fogalomTávolság fogalomEgy fogalomKettő =
  jelentésTávolság (gyökSzó fogalomEgy) (gyökSzó fogalomKettő)

-- ─── 4a. Példafogalmak (nagybetűs, KÖZVETLEN konstruktor-alkalmazások:
--    a GyökSzó-minta szerint — a Refl-lánc minden lépése direkt;
--    KisBetűsProjekcióCsapda-őrrel) ──────────────────────────────

||| A példa EGÉSZ fogalom: (2,2,0⁶) — állandó, egyed-oldali.
public export
PéldaEgészFogalom : Fogalom
PéldaEgészFogalom = FogalomKonstruktor PéldaEgészSzó EgészGyökPálya IndividuumJK

||| A példa FÉL-EGÉSZ fogalom: (1⁸) — kapcsolati, cselekvés-oldali.
public export
PéldaFélEgészFogalom : Fogalom
PéldaFélEgészFogalom = FogalomKonstruktor PéldaFélEgészSzó FélEgészGyökPálya CselekvesJK

||| A példa ellentett fogalom: (−2,−2,0⁶) — egész pálya, egyed-oldali.
public export
PéldaEllentettFogalom : Fogalom
PéldaEllentettFogalom = FogalomKonstruktor PéldaEllentettSzó EgészGyökPálya IndividuumJK

-- ===============================================================
-- 5. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Proofs — two independent paths, one bridge
--    证明——两条独立道路，一座桥 · Beweise — zwei Wege, eine Brücke
-- ===============================================================

-- ─── 5a. A D8-pálya-méretek: enumeráció ⟷ kombinatorika ────────
--    Az (a) út: a kernel a FOGALOMTÁR pálya-mezőit szűri (a 240
--    fogalom rekordjain normalizál). A (b) út: az IMPORTÁLT
--    kombinatorikai tények (E8Gyokok_v2: bizTipusEgy : 28 * 4 = 112,
--    C(8,2)·2²; bizTipusKetto útján 2⁷ = 128). A HÍD: a két
--    partició kényszerített találkozása. Nincs X = X (§18).

-- Kimenet: Refl — az EGÉSZ D8-pályán álló fogalmak száma: 112.
-- (a) enumeráció: EgészFogalmakKonst hossza; (b) kombinatorika: 28·4.
public export
bizEgészFogalmakSzáma : length EgészFogalmakKonst = 112
bizEgészFogalmakSzáma = Refl

-- Kimenet: Refl — a FÉL-EGÉSZ D8-pályán álló fogalmak száma: 128.
-- (a) enumeráció: FélEgészFogalmakKonst hossza; (b) kombinatorika: 2⁷.
public export
bizFélEgészFogalmakSzáma : length FélEgészFogalmakKonst = 128
bizFélEgészFogalmakSzáma = Refl

-- Kimenet: Refl — A HÍD (§18): a bal oldal a KÉT D8-PÁLYA
-- kombinatorikája (112 + 128), a jobb oldal a fogalomtár
-- ENUMERÁCIÓJA (a kernel a 240 map+filter-t normalizálja).
-- Két fogalmilag különböző konstrukció — egy kényszerített
-- találkozás; az importált bizE8GyokSzam (112 + 128 = 240) támasza.
public export
bizKétPályaHídFogalmon : 112 + 128 = length FogalomTárKonst
bizKétPályaHídFogalmon = Refl

-- ─── 5b. A híd-függvény: szóosztály ⟷ D8-pálya ──────────────────

-- Kimenet: Refl — a (1⁸) gyök (fél-egész szó) a fél-egész D8-pályára
-- hullik: a kernel a szóOsztályMeghatároz-t futtatja (112 elem-
-- összehasonlítás), aztán a pályaOsztályból hidat lépi át.
public export
bizPályaHídFélEgészPélda :
  pályaOsztályból (szóOsztályMeghatároz (E8GyokKonstruktor 1 1 1 1 1 1 1 1))
    = FélEgészGyökPálya
bizPályaHídFélEgészPélda = Refl

-- Kimenet: Refl — a példafogalom pálya-mezője valóban a fél-egész
-- pálya (a fogalomKészít hidán át: fogalommáEmel → szóOsztály →
-- pályaOsztályból — a kernel a LÁNCOT számolja, nem másolja).
public export
bizPéldaFélEgészFogalomPályája :
  pálya PéldaFélEgészFogalom = FélEgészGyökPálya
bizPéldaFélEgészFogalomPályája = Refl

-- ─── 5c. A távolság: fogalom-réteg ⟷ importált aritmetika ──────

-- Kimenet: Refl — KEVERT fogalom-pár (terv §1.3): egész ↔ fél-egész.
-- A bal oldal a fogalom-burkolaton át hívott jelentésTávolság
-- (belső szorzat + ötszintű osztályozás); a híd a másik oldalon az
-- IMPORTÁLT BizSzorzatT1T2 (E8BelsoSzorzat): (2,2,0⁶)·(1⁸) = 4 → +½.
public export
bizFogalomTávolságKevereltPár :
  fogalomTávolság PéldaEgészFogalom PéldaFélEgészFogalom = SzorosanHasonló
bizFogalomTávolságKevereltPár = Refl

-- Kimenet: Refl — az ellentett fogalom: ⟨α,−α⟩ = −8 → −1 Ellentett.
-- Híd: BizSzorzatEllentett (E8BelsoSzorzat): (2,2,0⁶)·(−2,−2,0⁶) = −8.
public export
bizFogalomTávolságEllentett :
  fogalomTávolság PéldaEgészFogalom PéldaEllentettFogalom = Ellentett
bizFogalomTávolságEllentett = Refl

-- ===============================================================
-- 6. FUTÁSIDEJŰ ELLENŐRZÉSEK ÉS A MAIN (GAUGE-elv)
--    Runtime checks and main · 运行时检查与主函数
--    Laufzeitprüfungen und Hauptprogramm · בדיקות זמן־ריצה ותוכנית ראשית
-- ===============================================================

||| A kategória-hozzárendelés kimerítő ellenőrzése: hány EGÉSZ
||| fogalomnak NEM IndividuumJK a kategóriája (és fordítva)?
||| Várt érték: 0 (az alapKategória a teljes tárra konzisztens).
||| MEGJEGYZÉS: az alapKategória maga jelöletlen döntés (terv §6.5);
||| ez a számláló csak a KONZISZTENCIÁT méri, nem a döntést.
public export
kategóriaHozzárendelésHibákSzáma : Nat
kategóriaHozzárendelésHibákSzáma =
  length (filter (\fogalom =>
    (pálya fogalom == EgészGyökPálya && kategória fogalom /= IndividuumJK)
      || (pálya fogalom == FélEgészGyökPálya && kategória fogalom /= CselekvesJK))
    fogalomTár)

||| A fogalomtár és az alapszókincs SZÁMBELI azonossága (a main
||| kiírja; a típus-szintű Refl a bizKétPályaHídFogalmon).
public export
fogalomTárMéreteFutás : Nat
fogalomTárMéreteFutás = length FogalomTárKonst

||| A W8-futtatás: fogalomtár, D8-pálya-méretek, példafogalmak,
||| távolságok, kimerítő ellenőrzés — minden kimenet értelmezhető
||| (GAUGE-elv).
main : IO ()
main = do
  putStrLn "═══ FOGALOM v1 — GyökSzó + D8-pálya + JK-kategória (W8) ═══"
  putStrLn ""
  putStrLn "-- 1. A D8-pálya-méretek (két független út, §18):"
  putStrLn ("   egész pálya (D8-gyökrendszer):   "
    ++ show (length EgészFogalmakKonst) ++ "   (várható: 112 = C(8,2)·2², Refl)")
  putStrLn ("   fél-egész pálya (demiocteract):  "
    ++ show (length FélEgészFogalmakKonst) ++ "   (várható: 128 = 2⁷, Refl)")
  putStrLn ("   FOGALOMTÁR összesen:             "
    ++ show fogalomTárMéreteFutás ++ "   (várható: 240 = 112 + 128, Refl-híd)")
  putStrLn ""
  putStrLn "-- 2. A W(E8)-pálya triviuma (kutatás, fejléc):"
  putStrLn "   W(E8) = 696 729 600 — a 240 gyökön EGY tranzitív pálya"
  putStrLn "   W(D8) = 2⁷·8! = 5 160 960 — a 240 gyökön KÉT pálya (112+128)"
  putStrLn "   (forrás: madore.org/~david/math/e8w.html; en.wikipedia.org/wiki/E8_lattice)"
  putStrLn ""
  putStrLn "-- 3. Példafogalmak (jel ‹pálya; kategória›):"
  putStrLn ("   PéldaEgészFogalom:      " ++ show PéldaEgészFogalom)
  putStrLn ("   PéldaFélEgészFogalom:   " ++ show PéldaFélEgészFogalom)
  putStrLn ("   PéldaEllentettFogalom:  " ++ show PéldaEllentettFogalom)
  putStrLn ""
  putStrLn "-- 4. Jelentés-távolság fogalmak közt (kernel-Refl-lel, §18):"
  putStrLn ("   egész ↔ fél-egész:  " ++ show (fogalomTávolság PéldaEgészFogalom PéldaFélEgészFogalom)
    ++ "   [híd: BizSzorzatT1T2]")
  putStrLn ("   egész ↔ ellentett:  " ++ show (fogalomTávolság PéldaEgészFogalom PéldaEllentettFogalom)
    ++ "   [híd: BizSzorzatEllentett]")
  putStrLn ""
  putStrLn "-- 5. Kimerítő ellenőrzés (futásidejű, GAUGE-elv):"
  putStrLn ("   kategória-hozzárendelési inkonzisztenciák: "
    ++ show kategóriaHozzárendelésHibákSzáma ++ "   (várható: 0, a 240 fogalomból)")
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
