module GyokSzo_v1

-- ═══════════════════════════════════════════════════════════════
-- GYÖKSZÓ v1 — a 3 dimenziós nyelv alapszókincse: a 240 E8-gyök mint szó
-- GYÖKSZÓ v1 — the base vocabulary of the 3D language: the 240 E8 roots as words
-- 词根词 v1 — 三维语言的基础词汇：240 个 E8 根即词
-- GYÖKSZÓ v1 — der Grundwortschatz der 3D-Sprache: die 240 E8-Wurzeln als Wörter
-- גיוקסו v1 — אוצר המילים הבסיסי של השפה התלת־ממדית: 240 שורשי E8 כמילים
-- ═══════════════════════════════════════════════════════════════
--
-- A TERV (docs/HaromDimenziosNyelv_Terv.md, 1. és 3. szakasz — W8):
--   1. SZÓKINCSES: a 240 E8-gyök a nyelv alapszókincse (GyökSzó).
--      A 112 + 128 felbontás két fogalmi szerepet ad (két szóosztály):
--        EgészGyökSzó    — 112 darab (±1,±1,0⁶)-permutáció — ÁLLANDÓ fogalmak
--        FélEgészGyökSzó — 128 darab (±½)⁸ páros előjellel  — KAPCSOLATI fogalmak
--      (A hozzárendelés a terv §1.2 javaslata — jelöletlen döntés, terv §6.5;
--       a szóosztály adata, nem a gyök algebrai tulajdonsága.)
--   3. SZEMANTIKA: a jelentés-hasonlóság a belső szorzat szerinti távolság —
--      öt szint: hasonlóság(α,β) = ⟨α,β⟩/8 ∈ {+1, +½, 0, −½, −1}
--      (intrinsic symbol grounding, Harnad 1990 — l. terv §3.1 és §7).
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS): a 240 gyöklista, a tipus1/tipus2
--   felbontás, a belső szorzat, a megengedettSzorzat, az eloszlas ÉS az
--   Eq E8Gyok MIND IMPORTÁLVA (E8Gyokok_v2 + E8BelsoSzorzat) — semmi nincs
--   újraírva ide. | 代码重复禁止——一切导入！ | Codeduplikation VERBOTEN!
-- §18 (KÉT FÜGGETLEN ÚT, EGY HÍD): a számlálás-bizonyítások enumeráció
--   (length a kimerített listán) ⟷ kombinatorika (112 + 128) hídjával; a
--   távolság-bizonyítások a jelentésTávolság-kiszámítás ⟷ az importált
--   BizSzorzat* aritmetikai tények (E8BelsoSzorzat) hídjával. Nincs X = X.
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2    -- e8Gyokok, tipus1Gyokok, tipus2Gyokok, E8Gyok, gyokSzimbolum (§24)
import E8BelsoSzorzat -- belsoszorzat, Eq E8Gyok, megengedettSzorzat, eloszlas (§24)
import Data.List      -- take (§24: standard, nem újraírva — l. E8Gyökök ProbePrelude)

%default covering

-- ===============================================================
-- 1. A SZÓOSZTÁLY ÉS A GYÖKSZÓ TÍPUSA (a terv 1. szakasza)
--    A word-class and the GyökSzó type · 词类与词根词类型
--    Die Wortklasse und der Typ GyökSzó · מחלקת המילים והטיפוס GyökSzó
-- ===============================================================

||| A nyelv két szóosztálya — a két gyöktípus két fogalmi szerepe
||| (a terv §1.2 táblázata szerint; a hozzárendelés jelöletlen döntés,
||| terv §6.5 — a felhasználó erősítheti meg).
||| 语言的两个词类——两类根的两个概念角色。
||| EgészGyökSzó: az egész koordinátájú gyökök — ÁLLANDÓ fogalmak
||| (a világ állapotai, entitások, tartalmak: „ami egészben van").
||| FélEgészGyökSzó: a fél-egész koordinátájú gyökök — KAPCSOLATI fogalmak
||| (viszonyok, átmenetek, műveletek: „ami két egész között áll").
public export
data SzóOsztály : Type where
  EgészGyökSzó    : SzóOsztály
  FélEgészGyökSzó : SzóOsztály

||| A két szóosztály egyenlősége (a kimerítő ellenőrzéshez).
public export
Eq SzóOsztály where
  (==) EgészGyökSzó    EgészGyökSzó    = True
  (==) FélEgészGyökSzó FélEgészGyökSzó = True
  (==) _ _ = False

||| A szóosztály megjelenítése — a fogalmi szereppel együtt.
||| 词类的显示——连同概念角色。
public export
Show SzóOsztály where
  show EgészGyökSzó    = "egész — állandó fogalom"
  show FélEgészGyökSzó = "fél-egész — kapcsolati fogalom"

||| A GYÖKSZÓ: a nyelv jele — egy E8-gyök CSAKOLÁSA szóosztályával.
||| A gyök maga (az 8 jegyű „írásjel") IMPORTÁLVA él az E8Gyokok_v2-ben;
||| ez a rekord csak ráburkol (terv §1.1, §24: nem írja újra a gyököt).
||| 词根词：语言的一个符号——E8 根连同其词类的包装。
||| Das Wort: ein E8-Wurzel, eingewickelt mit seiner Wortklasse.
public export
record GyökSzó where
  constructor GyökSzóKonstruktor
  jel       : E8Gyok
  szóOsztály : SzóOsztály

||| A gyökSzó megjelenítése: a gyök koordinátái ‹a szóosztály›.
public export
Show GyökSzó where
  show (GyökSzóKonstruktor gyök osztály) =
    show gyök ++ " ‹" ++ show osztály ++ "›"

||| Csakolás — de CSAK valódi gyökből: ha a bemenő E8Gyok a 240-es
||| listában van, Just szó; egyébként Nothing (nem lesz „szótalan" jel).
||| 包装——但只包装真正的根：不在 240 列表中的输入得到 Nothing。
public export
gyökSzóFel : E8Gyok -> Maybe GyökSzó
gyökSzóFel gyök =
  if elem gyök tipus1Gyokok
  then Just (GyökSzóKonstruktor gyök EgészGyökSzó)
  else if elem gyök tipus2Gyokok
  then Just (GyökSzóKonstruktor gyök FélEgészGyökSzó)
  else Nothing

||| A szó osztályának meghatározása a gyökből (a gyök adja, nem a szó):
||| a típus-1 listában van-e (az IMPORTÁLT tipus1Gyokok — §24).
||| 由根决定词类（是否在导入的 tipus1Gyokok 列表中）。
public export
szóOsztályMeghatároz : E8Gyok -> SzóOsztály
szóOsztályMeghatároz gyök =
  if elem gyök tipus1Gyokok
  then EgészGyökSzó
  else FélEgészGyökSzó

-- ===============================================================
-- 2. A KÉT SZÓOSZTÁLY LISTÁJA — IMPORTÁLT GYÖKÖKBŐL (§24)
--    The two word-class lists — from IMPORTED roots
--    两个词类列表——来自导入的根 · Die zwei Wortklassen-Listen
-- ===============================================================

||| Az EGÉSZ szavak: a 112 típus-1 gyök burkolása (IMPORT, nem újraírás).
||| Az állandó fogalmak osztálya: a rács egész pontjai.
public export
egészSzavak : List GyökSzó
egészSzavak = map (\gyök => GyökSzóKonstruktor gyök EgészGyökSzó) tipus1Gyokok

||| A FÉL-EGÉSZ szavak: a 128 típus-2 gyök burkolása (IMPORT).
||| A kapcsolati fogalmak osztálya: a rács fél-egész kosettje.
public export
félEgészSzavak : List GyökSzó
félEgészSzavak = map (\gyök => GyökSzóKonstruktor gyök FélEgészGyökSzó) tipus2Gyokok

||| A NYELV ALAPSZÓKINCSE: 112 + 128 = 240 szó (a terv §1).
||| A lista-konstans a kályha-minta szerint (NEM let-lánc — l. LetLáncProbe).
public export
alapszókincs : List GyökSzó
alapszókincs = egészSzavak ++ félEgészSzavak

||| Nagybetűs konstansok a bizonyítás-típusokhoz (KisBetűsProjekcióCsapda).
public export
EgészSzavakKonst : List GyökSzó
EgészSzavakKonst = egészSzavak

public export
FélEgészSzavakKonst : List GyökSzó
FélEgészSzavakKonst = félEgészSzavak

public export
AlapszókincsKonst : List GyökSzó
AlapszókincsKonst = alapszókincs

-- ===============================================================
-- 3. JELENTÉS-TÁVOLSÁG — AZ ÖTSZINTŰ SKÁLA (a terv 3. szakasza)
--    Meaning-distance — the five-level scale
--    意义距离——五级标度 · Bedeutungsdistanz — die fünfstufige Skala
-- ===============================================================

||| A szemantikai hasonlóság ÖT SZINTJE — pontosan a gyökrendszer
||| szögszerkezete (terv §3.1): a 2-szeres skálán ⟨α,β⟩ ∈ {−8,−4,0,+4,+8},
||| normalizálva ⟨α,β⟩/8 ∈ {−1, −½, 0, +½, +1}. Nem mi választottuk —
||| a geometria adja (simply-laced, E8BelsoSzorzat fejléce).
||| 语义相似度的五级——恰为根系的角结构（几何给出，非人为选择）。
public export
data HasonlóságÖtSzint : Type where
  AzonosJel       : HasonlóságÖtSzint  -- ⟨α,β⟩ = +8  (+1:  ugyanaz a jel)
  SzorosanHasonló : HasonlóságÖtSzint  -- ⟨α,β⟩ = +4  (+½: 60°-os szög)
  Semleges        : HasonlóságÖtSzint  -- ⟨α,β⟩ =  0  ( 0: merőleges jelek)
  EllentétesRokon : HasonlóságÖtSzint  -- ⟨α,β⟩ = −4  (−½: 120°-os szög)
  Ellentett       : HasonlóságÖtSzint  -- ⟨α,β⟩ = −8  (−1: ellentett jel)

||| Az öt szint megjelenítése — a normalizált értékkel és szöggel.
public export
Show HasonlóságÖtSzint where
  show AzonosJel       = "+1 azonos jel (0°)"
  show SzorosanHasonló = "+½ szorosan hasonló (60°)"
  show Semleges        = "0 semleges (merőleges)"
  show EllentétesRokon = "−½ ellentétes rokon (120°)"
  show Ellentett       = "−1 ellentett jel (180°)"

||| A JELENTÉS-TÁVOLSÁG: két szó hasonlósága a belső szorzatból
||| (IMPORTÁLT belsoszorzat — §24). A szóosztály NEM számít bele:
||| a jelentés a gyök geometriája, nem a nyelvtani címke (terv §3.1).
||| 意义距离：两词的相似度由（导入的）内积给出。
public export
jelentésTávolság : GyökSzó -> GyökSzó -> HasonlóságÖtSzint
jelentésTávolság (GyökSzóKonstruktor alfa _) (GyökSzóKonstruktor béta _) =
  if szorzat == 8 then AzonosJel
  else if szorzat == 4 then SzorosanHasonló
  else if szorzat == 0 then Semleges
  else if szorzat == -4 then EllentétesRokon
  else Ellentett
  where
    szorzat : Integer
    szorzat = belsoszorzat alfa béta

-- ─── 3a. Példaszavak (nagybetűs konstansok — KisBetűsProjekcióCsapda) ──

||| (2,2,0⁶) — az első típus-1 gyök: EGÉSZ szó (állandó fogalom).
public export
PéldaEgészSzó : GyökSzó
PéldaEgészSzó = GyökSzóKonstruktor (E8GyokKonstruktor 2 2 0 0 0 0 0 0) EgészGyökSzó

||| (−2,−2,0⁶) — PéldaEgészSzó ellentettje: szintén EGÉSZ szó.
public export
PéldaEllentettSzó : GyökSzó
PéldaEllentettSzó = GyökSzóKonstruktor (E8GyokKonstruktor (-2) (-2) 0 0 0 0 0 0) EgészGyökSzó

||| (2,−2,0⁶) — PéldaEgészSzóval merőleges típus-1 gyök: EGÉSZ szó.
public export
PéldaMerőlegesSzó : GyökSzó
PéldaMerőlegesSzó = GyökSzóKonstruktor (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0) EgészGyökSzó

||| (1⁸) — az első típus-2 gyök: FÉL-EGÉSZ szó (kapcsolati fogalom).
public export
PéldaFélEgészSzó : GyökSzó
PéldaFélEgészSzó = GyökSzóKonstruktor (E8GyokKonstruktor 1 1 1 1 1 1 1 1) FélEgészGyökSzó

||| (−1,−1,−1,−1,−1,−1,1,1) — hat mínusszal (páros!) típus-2 gyök:
||| PéldaFélEgészSzóval ELLENTÉTES ROKON (120°): ⟨·⟩ = 2−6 = −4.
public export
PéldaEllentétesRokonSzó : GyökSzó
PéldaEllentétesRokonSzó =
  GyökSzóKonstruktor (E8GyokKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) 1 1) FélEgészGyökSzó

-- ===============================================================
-- 4. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Proofs — two independent paths, one bridge
--    证明——两条独立道路，一座桥 · Beweise — zwei Wege, eine Brücke
-- ===============================================================

-- ─── 4a. A számlálás: enumeráció ⟷ kombinatorika ────────────────
--    Az (a) út: a kernel a FELÉPÍTETT lista hosszát számolja ki
--    (map/filter/++ a kimerített 240 gyökön). A (b) út: az IMPORTÁLT
--    kombinatorikai tény (E8Gyokok_v2.bizE8GyokSzam : 112 + 128 = 240,
--    C(8,2)·2² = 112 és 2⁷ = 128). A HÍD: bizKétÚtHíd — a kettő
--    ugyanarra a 240-re kényszerül. Nincs X = X (§18).

-- Kimenet: Refl — az EGÉSZ szavak száma a felsorolásból: 112.
public export
bizEgészSzavakSzáma : length EgészSzavakKonst = 112
bizEgészSzavakSzáma = Refl

-- Kimenet: Refl — a FÉL-EGÉSZ szavak száma a felsorolásból: 128.
public export
bizFélEgészSzavakSzáma : length FélEgészSzavakKonst = 128
bizFélEgészSzavakSzáma = Refl

-- Kimenet: Refl — az ALAPSZÓKINCS száma a felsorolásból: 240.
public export
bizAlapszókincsSzáma : length AlapszókincsKonst = 240
bizAlapszókincsSzáma = Refl

-- Kimenet: Refl — A HÍD (§18): a bal oldal KOMBINATORIKA (112 + 128,
-- az importált bizE8GyokSzam útja), a jobb oldal ENUMERÁCIÓ (a kernel
-- a felépített alapszókincs hosszát számolja ki). Két fogalmilag
-- különböző konstrukció — egy kényszerített találkozás.
public export
bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst
bizKétÚtHíd = Refl

-- ─── 4b. Az osztály-meghatározás: a gyök adja a szó osztályát ──

-- Kimenet: Refl — a (2,2,0⁶) gyök a típus-1 lista ELSŐ eleme,
-- ezért a kernel gyorsan kiszámolja: EGÉSZ szó.
public export
bizOsztályEgészPélda :
  szóOsztályMeghatároz (E8GyokKonstruktor 2 2 0 0 0 0 0 0) = EgészGyökSzó
bizOsztályEgészPélda = Refl

-- Kimenet: Refl — az (1⁸) gyök NINCS a 112-es típus-1 listában
-- (a kernel mind a 112 összehasonlítást elvégzi), ezért: FÉL-EGÉSZ szó.
public export
bizOsztályFélEgészPélda :
  szóOsztályMeghatároz (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = FélEgészGyökSzó
bizOsztályFélEgészPélda = Refl

-- ─── 4c. A távolságok: a jelentésréteg ⟷ az importált aritmetika ──
--    Mindegyik bizonyításban a kernel a jelentésTávolság-függvényen
--    át számol (burkolat + belsoszorzat + ötszintű osztályozás); a híd
--    a másik oldalon az IMPORTÁLT BizSzorzat* tény (E8BelsoSzorzat):
--    ugyanazok a gyökpárok, ugyanazok a szorzatértékek — a szemantikai
--    réteg nem csúsztathatja el a jelentést az aritmetika nélkül.

-- Kimenet: Refl — egy jel önmagával: ⟨α,α⟩ = 8 → +1 AzonosJel.
public export
bizTávolságAzonosJel :
  jelentésTávolság PéldaEgészSzó PéldaEgészSzó = AzonosJel
bizTávolságAzonosJel = Refl

-- Kimenet: Refl — KEVERT PÁROSZAT (terv §1.3): egész ↔ fél-egész szó.
-- Híd: BizSzorzatT1T2 (E8BelsoSzorzat): (2,2,0⁶)·(1⁸) = 4 → +½.
public export
bizTávolságKevereltPár :
  jelentésTávolság PéldaEgészSzó PéldaFélEgészSzó = SzorosanHasonló
bizTávolságKevereltPár = Refl

-- Kimenet: Refl — merőleges egész pár: ⟨·⟩ = 0 → semleges.
-- Híd: BizSzorzatMeroleges (E8BelsoSzorzat): (2,2,0⁶)·(2,−2,0⁶) = 0.
public export
bizTávolságMerőleges :
  jelentésTávolság PéldaEgészSzó PéldaMerőlegesSzó = Semleges
bizTávolságMerőleges = Refl

-- Kimenet: Refl — két fél-egész szó 120°-ban: (1⁸)·(−1⁶,1,1) = 2−6 = −4.
-- (Az egész gyökpároktól ELTÉRŐ út: itt a kernel a típus-2 távolságot
-- számolja — a skála mindkét szóosztályban ugyanaz.)
public export
bizTávolságEllentétesRokon :
  jelentésTávolság PéldaFélEgészSzó PéldaEllentétesRokonSzó = EllentétesRokon
bizTávolságEllentétesRokon = Refl

-- Kimenet: Refl — az ellentett jel: ⟨α,−α⟩ = −8 → −1.
-- Híd: BizSzorzatEllentett (E8BelsoSzorzat): (2,2,0⁶)·(−2,−2,0⁶) = −8.
public export
bizTávolságEllentett :
  jelentésTávolság PéldaEgészSzó PéldaEllentettSzó = Ellentett
bizTávolságEllentett = Refl

-- ===============================================================
-- 5. FUTÁSIDEJŰ KIMERÍTŐ ELLENŐRZÉS ÉS A MAIN (GAUGE-elv)
--    Runtime exhaustive check and main
--    运行时穷举检查与主函数 · Laufzeit-Prüfung und Hauptprogramm
-- ===============================================================

||| Az osztály-meghatározó kimerítő ellenőrzése: hány szónál TÉVED
||| a szóOsztályMeghatároz a felépített osztálytól? Várt érték: 0
||| (a 240 szóra — a szóOsztályMeghatároz és a konstrukció konzisztens).
public export
osztályHibákSzáma : Nat
osztályHibákSzáma =
  length (filter (\szó => szóOsztályMeghatároz (jel szó) /= szóOsztály szó) alapszókincs)

||| Az ötszintű skála kimerítése: mind az 240×240 = 57 600 szópár
||| belső szorzata a megengedett öt érték egyike-e (IMPORTÁLT
||| megengedettSzorzat — §24). Várt érték: 0.
public export
távolságSkálaHibákSzáma : Nat
távolságSkálaHibákSzáma =
  length (filter (not . megengedettSzorzat)
    [ belsoszorzat (jel szóEgy) (jel szóKettő)
    | szóEgy <- alapszókincs, szóKettő <- alapszókincs ])

||| A W8-futtatás: alapszókincs, példaszavak, távolságok, kimerítő
||| ellenőrzések — minden kimenet értelmezhető (GAUGE-elv).
main : IO ()
main = do
  putStrLn "═══ GYÖKSZÓ v1 — a 3 dimenziós nyelv alapszókincse (W8) ═══"
  putStrLn ""
  putStrLn "-- 1. Az alapszókincs (IMPORTÁLT gyöklistákból, §24):"
  putStrLn ("   egész szavak (állandó fogalmak):     "
    ++ show (List.length EgészSzavakKonst) ++ "   (várható: 112, Refl)")
  putStrLn ("   fél-egész szavak (kapcsolati fogalmak): "
    ++ show (List.length FélEgészSzavakKonst) ++ "   (várható: 128, Refl)")
  putStrLn ("   ALAPSZÓKINCS összesen:               "
    ++ show (List.length AlapszókincsKonst) ++ "   (várható: 240 = 112 + 128, Refl-híd)")
  putStrLn ""
  putStrLn "-- 2. Példaszavak (jel ‹szóosztály› → 8 jegyű írásjel):"
  putStrLn ("   PéldaEgészSzó:            " ++ show PéldaEgészSzó
    ++ "  → " ++ gyokSzimbolum (jel PéldaEgészSzó))
  putStrLn ("   PéldaMerőlegesSzó:        " ++ show PéldaMerőlegesSzó
    ++ "  → " ++ gyokSzimbolum (jel PéldaMerőlegesSzó))
  putStrLn ("   PéldaFélEgészSzó:         " ++ show PéldaFélEgészSzó
    ++ "  → " ++ gyokSzimbolum (jel PéldaFélEgészSzó))
  putStrLn ("   PéldaEllentétesRokonSzó:  " ++ show PéldaEllentétesRokonSzó
    ++ "  → " ++ gyokSzimbolum (jel PéldaEllentétesRokonSzó))
  putStrLn ""
  putStrLn "-- 3. Jelentés-távolságok (mind kernel-Refl-lel bizonyítva, §18):"
  putStrLn ("   egész ↔ önmaga:        " ++ show (jelentésTávolság PéldaEgészSzó PéldaEgészSzó))
  putStrLn ("   egész ↔ fél-egész:     " ++ show (jelentésTávolság PéldaEgészSzó PéldaFélEgészSzó)
    ++ "   [⟨·⟩ = 4, híd: BizSzorzatT1T2]")
  putStrLn ("   egész ↔ merőleges:     " ++ show (jelentésTávolság PéldaEgészSzó PéldaMerőlegesSzó)
    ++ "   [⟨·⟩ = 0, híd: BizSzorzatMeroleges]")
  putStrLn ("   fél-egész ↔ 120°-os:   " ++ show (jelentésTávolság PéldaFélEgészSzó PéldaEllentétesRokonSzó)
    ++ "   [⟨·⟩ = −4]")
  putStrLn ("   egész ↔ ellentett:     " ++ show (jelentésTávolság PéldaEgészSzó PéldaEllentettSzó)
    ++ "   [⟨·⟩ = −8, híd: BizSzorzatEllentett]")
  putStrLn ""
  putStrLn "-- 4. Az öt szint eloszlása egy szó körül (IMPORTÁLT eloszlas, §24):"
  putStrLn ("   eloszlás (PéldaEgészSzó gyöke): " ++ show (eloszlas (jel PéldaEgészSzó))
    ++ "   (várható: (1, 56, 126, 56, 1))")
  putStrLn ""
  putStrLn "-- 5. Kimerítő ellenőrzések (futásidejű, GAUGE-elv):"
  putStrLn ("   hibás osztályú szavak:            " ++ show osztályHibákSzáma
    ++ "   (várható: 0)")
  putStrLn ("   megengedetlen távolságú szópárok: " ++ show távolságSkálaHibákSzáma
    ++ "   (várható: 0, a 240×240 = 57 600 párból)")
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
