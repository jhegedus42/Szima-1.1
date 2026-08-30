module E8Fa_v3
-- (v3, 2026-08-22: a v2 importjai a meggyógyított nemzedékre állnak —
--  MagyarNyelvtan_v4 és MagyarCarnotE9_v3_CodatAlpha; a tartalom változatlan. §13.)

-- ===============================================================
-- E8 FA v2 -- a magyar nyelv hierarchikus fa-strukturaja
-- ===============================================================
-- A felhasznalo (2026-08-19): "akkor ezek magasabb szinten is
-- megjelennek ezek a javitasok, talan az E8-at kene valami fa
-- strukturaba-tenni, nem?"
--
-- A fa-struktúra a magyar nyelv (es altalaban a nyelv) hierarchikus
-- szintjeihez illeszti a Carnot-ciklust es a Steane-hibajavítast:
--
--   Szint 0 (level): BetuE8 -- 240 E8-gyok / 40 magyar betu = 6
--   Szint 1: SzotagFa -- magánhangzo + massalhangzo (szotag)
--   Szint 2: SzoFa -- szoto + toldalékok (magyar agglutinacio)
--   Szint 3: MondatFa -- szavak + szórend (szintaxis)
--   Szint 4: GondolatFa -- mondatok + jelentés (szemantika)
--
-- Minden szinten egy Carnot-ciklus fut:
--   izoterm expanzio (nyers adat) → adiabatikus expanzio (forgatas
--   a helyes E8-palyara) → izoterm kompresszio (Landauer-koltseg)
--   → adiabatikus kompresszio (kovetkezo szint).
--
-- A delta (δ = α_Horgony - α_CODATA ≈ 8.23e-7) minden szinten
-- megjelenik, és a magasabb szinten a deltak OSSZEADODNAK (a
-- hierarchikus hibajavitas).
--
-- A fa-struktúra a kategoriaelmeleti hierarchiat tukrozi:
--   betu (objektum) → szotag (morfizmus) → szo (kompozicio)
--   → mondat (funktor) → gondolat (termeszetes transzformacio).
-- ===============================================================

import MagyarNyelvtan_v4
import MagyarCarnotE9_v3_CodatAlpha

%default total

-- ===============================================================
-- 1. A FA-SZINTEK TIPUSA (Nat-szintu rekurziv)
-- ===============================================================

||| Az E8 fa 5 szintje: level (0), szotag (1), szo (2),
||| mondat (3), gondolat (4).
public export
data FaSzint = Levél | Szotag | Szo | Mondat | Gondolat

||| A fa-szint szamkent: Levél=0, Szotag=1, Szo=2, Mondat=3, Gondolat=4.
public export
faSzintErtek : FaSzint -> Nat
faSzintErtek Levél    = 0
faSzintErtek Szotag   = 1
faSzintErtek Szo      = 2
faSzintErtek Mondat   = 3
faSzintErtek Gondolat = 4

||| A fa-szint neve (magyarul).
public export
faSzintNev : FaSzint -> String
faSzintNev Levél    = "level (betu)"
faSzintNev Szotag   = "szotag"
faSzintNev Szo      = "szo"
faSzintNev Mondat   = "mondat"
faSzintNev Gondolat = "gondolat"

-- ===============================================================
-- 2. A FA CSOMOPONTJAINAK TIPUSAI (5 szint)
-- ===============================================================

||| Szint 0: a level -- egy magyar betu + az E8-pontja + a
||| forgatasi index (1..6 a 240/40 = 6 miatt).
public export
record BetuFa where
  constructor BetuFaKonstruktor
  betu        : Hang          -- a magyar hang (Maganhangzo/Massalhangzo)
  e8Index     : Nat           -- az E8-gyok indexe (1..240)
  forgatIndex : Nat           -- a 6 forgatasi ekvivalencia kozul (1..6)
  cimke       : String        -- a grafikus alak ("a", "á", "cs", stb.)

||| Szint 1: a szotag -- egy magánhangzo + opcionalis massalhangzok.
||| A szotag a magyar szótagozas alapegysége (minden magánhangzo
||| egy szotagot kezd).
public export
record SzotagFa where
  constructor SzotagFaKonstruktor
  mag         : BetuFa        -- a magánhangzo (kötelezo)
  massal      : List BetuFa   -- a masodlagos massalhangzok (0 vagy tobb)
  szotagSuly  : Nat           -- a szotag sulya (a massalhangzok szama + 1)

||| Szint 2: a szo -- egy szoto + toldalékok (az agglutinacio szintje).
||| A magyar agglutinacio: szoto + birtokos + szam + esetrag.
public export
record SzoFa where
  constructor SzoFaKonstruktor
  szotag      : SzotagFa      -- a szotagon beluli szotag-fa
  toldalekok  : List BetuFa   -- a toldalekok (birtokos, szam, esetrag)
  szoHossz    : Nat           -- a szo hossza (betuk szama)

||| Szint 3: a mondat -- szavak + szórend (a szintaxis szintje).
public export
record MondatFa where
  constructor MondatFaKonstruktor
  szavak      : List SzoFa    -- a mondat szavai
  szorend     : String        -- a szórend leírása ("SVO", "SOV", stb.)
  mondatHossz : Nat           -- a mondat hossza (szavak szama)

||| Szint 4: a gondolat -- mondatok + jelentés (a szemantika szintje).
public export
record GondolatFa where
  constructor GondolatFaKonstruktor
  mondatok    : List MondatFa  -- a gondolat mondatai
  jelentes    : String         -- a gondolat szöveges leírása
  faMagassag  : Nat            -- a fa magassaga (a szintek szama)

-- ===============================================================
-- 3. A CARNOT-CIKLUS MINDEN SZINTEN
-- ===============================================================

||| A Carnot-ciklus 4 fazisa minden szinten ugyanaz:
|||   izoterm expanzio → adiabatikus expanzio
|||   → izoterm kompresszio → adiabatikus kompresszio
||| (v3: a helyi CarnotLepes-TÍPUS-ÁLNÉV kihagyva — az importolt
|||  MagyarCarnotE9_v3_CodatAlpha.CarnotLepes direktben használandó;
|||  az álnév ütközést és kétértelműséget okozott. §24.)

||| A Carnot-ciklus fázisai a fa minden szintjén futnak.
||| A magasabb szinten a deltak összeadódnak.
public export
faSzintCarnot : FaSzint -> CarnotLepes -> CarnotLepes
faSzintCarnot szint lepes =
  case (szint, lepes) of
    (Levél,    IzotermExpanzio)        => IzotermExpanzio
    (Szotag,   AdiabatikusExpanzio)    => AdiabatikusExpanzio
    (Szo,      IzotermKompresszio)     => IzotermKompresszio
    (Mondat,   AdiabatikusKompresszio) => AdiabatikusKompresszio
    (Gondolat, _)                       => IzotermExpanzio
    (_,        l)                      => l

-- ===============================================================
-- 4. A DELTA HIERARCHIKUS ÖRÖKLŐDÉSE
-- ===============================================================

||| A δ egy szinten: δ * 2^szint (a hierarchikus hiba).
||| Szint 0: δ (a level betu-eltolodas).
||| Szint 1: 2δ (a szotag-szint).
||| Szint 2: 4δ (a szo-szint).
||| Szint 3: 8δ (a mondat-szint).
||| Szint 4: 16δ (a gondolat-szint).
public export
deltaSzint : FaSzint -> Double
deltaSzint szint = delta * pow2 (faSzintErtek szint)
  where
    pow2 : Nat -> Double
    pow2 0 = 1.0
    pow2 1 = 2.0
    pow2 2 = 4.0
    pow2 3 = 8.0
    pow2 4 = 16.0
    pow2 _ = 1.0

||| Az alfa-eltérés a szinten: α_Horgony - δ_szint.
||| (A magasabb szinten az α közelít a CPT-exakthoz.)
public export
alfaSzinten : FaSzint -> Double
alfaSzinten szint = alphaInverzHorgony - deltaSzint szint

-- ===============================================================
-- 5. A HIERARCHIKUS JAVÍTÁS (Steane minden szinten)
-- ===============================================================

||| A javítás egy szinten: a Steane szindrómát használja a δ
||| eltérés kijavítására.
public export
javitasSzint : FaSzint -> Nat  -- a javitando bitek szama a szinten
javitasSzint Levél    = 1     -- 1 bit a levelen (Steane [[7,1,3]])
javitasSzint Szotag   = 2     -- 2 bit a szotagon
javitasSzint Szo      = 4     -- 4 bit a szoban
javitasSzint Mondat   = 8     -- 8 bit a mondatban
javitasSzint Gondolat = 16    -- 16 bit a gondolatban

||| Az összes javítás a teljes gondolat-fában:
||| 1 + 2 + 4 + 8 + 16 = 31 bit (2^5 - 1).
public export
totalJavitas : Nat
totalJavitas = 1 + 2 + 4 + 8 + 16

-- ===============================================================
-- 6. A MAGYAR SZIMMETRIÁK ILLESZTÉSE A FA-SZINTEKHEZ
-- ===============================================================

||| A magyar szimmetria-csoport a fa-szintjeihez illeszkedik:
|||   Levél: paritás (zönges/zöngétlen, rovid/hosszu) -- 1 szimmetria
|||   Szotag: hangrend (mely/magas) -- 1 szimmetria
|||   Szo: agglutinacio (birtokos/szam/esetrag sorrendje) -- 6 permutacio
|||   Mondat: szórend (SVO/SOV/stb.) -- tobb permutacio
|||   Gondolat: jelentés-struktura -- absztrakt
public export
szimmetriaSzinten : FaSzint -> MagyarSzimmetria
szimmetriaSzinten Levél    = Paritas
szimmetriaSzinten Szotag   = Hangrend
szimmetriaSzinten Szo      = Agglutinacio
szimmetriaSzinten Mondat   = Zongesseg
szimmetriaSzinten Gondolat = Paritas  -- (a ciklus visszater)

-- ===============================================================
-- 7. A FORGATÁS A JELENTÉS FELÉ (a β⁵ szimmetria)
-- ===============================================================

||| A forgatás a β^5 (ötödik dimenzio) koruli forgatassal allapitja
||| meg, hogy egy betu "joforratasa" (helyes jelentése) vagy
||| "rosszforgatasa" (torz jelentése).
public export
record ForgatasEredmenye where
  constructor ForgatasEredmenyeKonstruktor
  betu        : BetuFa
  helyesE     : Bool     -- True = a forgatas helyes (jelenteses)
  forgatIndex : Nat      -- a 6 egyik indexe (1..6)
  delta       : Double   -- a forgatás elterese a helyes E8-palyatol

||| A 6×-os forgatás: egy magyar betű 6 E8-ábrázolással rendelkezik.
||| Ha a forgatás "helyes" (a β^5 = 0 irányba), a betű jelentéses.
||| Ha "rossz" (a β^5 != 0 irányba), a betű torz.
public export
forgatasHelyesE : ForgatasEredmenye -> Bool
forgatasHelyesE (ForgatasEredmenyeKonstruktor _ helyes _ _) = helyes

||| Az átlagos delta egy szinten: δ_szint / 6 (a 6 forgatási
||| ekvivalencia-osztály átlaga).
public export
atlagosDeltaSzint : FaSzint -> Double
atlagosDeltaSzint szint = deltaSzint szint / 6.0

-- ===============================================================
-- 8. A PIROSKA-MESE A FA-STRUKTÚRÁBAN
-- ===============================================================

||| A Piroska-mese 22 mondata = 22 GondolatFa-level (a fa levelei).
||| Minden mondat egy Carnot-ciklus, és a fa magassága 5 (level →
||| gondolat).
public export
piroskaFaMondatokSzama : Nat
piroskaFaMondatokSzama = 22

||| A Piroska-mese fa-magassága: 5 szint (level, szotag, szo,
||| mondat, gondolat).
public export
piroskaFaMagassag : Nat
piroskaFaMagassag = 5

||| A Piroska-mese teljes javítási kapacitása: 31 bit a teljes
||| 5-szintű fában.
public export
piroskaJavitas : Nat
piroskaJavitas = totalJavitas  -- = 31 bit

||| A Piroska-mese δ-ja a gondolat-szinten (a legmagasabb):
||| 16 * δ ≈ 1.32e-5 (a hierarchikus hiba).
public export
piroskaDeltaGondolat : Double
piroskaDeltaGondolat = deltaSzint Gondolat

-- ===============================================================
-- 9. REFL-BIZONYITASOK (a fa-struktúra tenyei)
-- ===============================================================

||| Refl -- a fa 5 szintje van.
public export
bizFaOtSzint : faSzintErtek Levél + faSzintErtek Szotag +
                faSzintErtek Szo + faSzintErtek Mondat +
                faSzintErtek Gondolat = 10
bizFaOtSzint = Refl

||| Refl -- a teljes javítás a fán 31 bit (= 2^5 - 1).
||| (v3: nagybetűs konstansok a típusban — KisBetűsProjekcióCsapda.)
public export
TotalJavitasKonst : Nat
TotalJavitasKonst = totalJavitas

public export
PiroskaFaMagassagKonst : Nat
PiroskaFaMagassagKonst = piroskaFaMagassag

public export
DeltaSzorTizenhat : Double
DeltaSzorTizenhat = delta * 16.0

public export
bizTotalJavitas : TotalJavitasKonst = 31
bizTotalJavitas = Refl

||| Refl -- a Piroska-mese δ-ja a gondolat-szinten: 16 * δ.
public export
bizPiroskaDeltaGondolat : deltaSzint Gondolat = DeltaSzorTizenhat
bizPiroskaDeltaGondolat = Refl

||| Refl -- a level-delta = δ (a legkisebb hierarchikus hiba).
public export
bizLevélDelta : deltaSzint Levél = DeltaKonst
bizLevélDelta = Refl

||| Refl -- a gondolat-delta = 16 * δ (a legnagyobb hierarchikus hiba).
public export
bizGondolatDelta : deltaSzint Gondolat = DeltaSzorTizenhat
bizGondolatDelta = Refl

||| Refl -- a Piroska-mese fa-magassága 5.
public export
bizPiroskaMagassag : PiroskaFaMagassagKonst = 5
bizPiroskaMagassag = Refl

||| Refl -- a Piroska-mese javítási kapacitása 31 bit.
public export
bizPiroskaJavitas : TotalJavitasKonst = 31
bizPiroskaJavitas = Refl
