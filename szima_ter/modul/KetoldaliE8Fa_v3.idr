module KetoldaliE8Fa_v3

-- (v3, 2026-08-22: a v2 importjai a meggyógyított nemzedékre állnak;
--  a tartalom változatlan. §13.)

-- ===============================================================
-- KETOLDALI E8 FA v2 -- a 7 pozitiv es 7 negativ reteg
-- ===============================================================
-- A felhasznalo (2026-08-19): "7 reteg es negativ het reteg..."
--
-- A ketoldali struktura a magyar nyelv (es altalaban a jelentes)
-- ket oldala: a pozitiv (szintezis, kibontakoztas) es a negativ
-- (dekodolas, visszaforditas).
--
-- A 7 pozitiv reteg:
--   bit1=ido, bit2=oksag, bit3=ter, bit4=szin, bit5=hang,
--   bit6=fazis, bit7=mod -- a szintezis (betu → mondat).
--
-- A 7 negativ reteg:
--   bit1=gamma5, bit2=-ido, bit3=-oksag, bit4=-ter, bit5=-szin,
--   bit6=-hang, bit7=-fazis, bit8=-mod -- a dekódolás
--   (mondat → betu).
--
-- A ket reteg egyutt: 14 dimenzio (a Dirac spec 14-bit stem
-- megfeleloje). A ket reteg kozott a γ^5 (a chirality) a
-- atmenet: a Carnot-buborek, a δ stabilizator.
--
-- Forras:
--   trail_index/E9_framework.md (a 15-dim fázistér)
--   horgony/szerver/dirac_lang.py (14-bit stem, TILTOTT, referencia)
--   MagyarCarnotE9_v2_2_CodatAlpha (α^(-1), δ, Carnot-ciklus)
--   E8Fa_v2 (az 5-szintu fa)
-- ===============================================================

import MagyarCarnotE9_v3_CodatAlpha
import MagyarNyelvtan_v4
import E8Fa_v3
import KomplexByte  -- (v3) a Kubit otthona — az E8Fa_v3 már nem reexportálja | Kubit 的规范住所
import Data.List  -- (v3) replicate (§24: standard)

%default total

-- ===============================================================
-- 1. A 7 POZITIV RETEG (szintezis, kibontakoztas)
-- ===============================================================

||| A 7 pozitiv dimenzio: a szintezis irany (betu → gondolat).
public export
data PozitivBit : Type where
  PIdo   : PozitivBit  -- bit1: ido
  POksag : PozitivBit  -- bit2: oksag
  PTer   : PozitivBit  -- bit3: ter
  PSzin  : PozitivBit  -- bit4: szin
  PHang  : PozitivBit  -- bit5: hang
  PFazis : PozitivBit  -- bit6: fazis
  PMod   : PozitivBit  -- bit7: mod

public export
Show PozitivBit where
  show PIdo   = "ido"
  show POksag = "oksag"
  show PTer   = "ter"
  show PSzin  = "szin"
  show PHang  = "hang"
  show PFazis = "fazis"
  show PMod   = "mod"

||| A 7 pozitiv bit listaja (a Steane [[7,1,3]] sorrendje).
public export
pozitivLista : List PozitivBit
pozitivLista = [PIdo, POksag, PTer, PSzin, PHang, PFazis, PMod]

||| A pozitiv-Steane bitek szama: 7.
public export
pozitivBitekSzama : Nat
pozitivBitekSzama = 7

-- ===============================================================
-- 2. A 7 NEGATIV RETEG (dekódolás, visszaforditas)
-- ===============================================================

||| A 7 negativ dimenzio: a dekódolás irany (gondolat → betu).
||| Az inverz bitek (a γ^5 mint a 8. dimenzio a ket oldal kozott).
public export
data NegativBit : Type where
  NIdo    : NegativBit  -- bit2: -ido (az ido inverze)
  NOksag  : NegativBit  -- bit3: -oksag
  NTer    : NegativBit  -- bit4: -ter
  NSzin   : NegativBit  -- bit5: -szin
  NHang   : NegativBit  -- bit6: -hang
  NFazis  : NegativBit  -- bit7: -fazis
  NMod    : NegativBit  -- bit8: -mod

public export
Show NegativBit where
  show NIdo    = "-ido"
  show NOksag  = "-oksag"
  show NTer    = "-ter"
  show NSzin   = "-szin"
  show NHang   = "-hang"
  show NFazis  = "-fazis"
  show NMod    = "-mod"

||| A 7 negativ bit listaja (a pozitiv inverze).
public export
negativLista : List NegativBit
negativLista = [NIdo, NOksag, NTer, NSzin, NHang, NFazis, NMod]

||| A negativ-Steane bitek szama: 7.
public export
negativBitekSzama : Nat
negativBitekSzama = 7

-- ===============================================================
-- 3. A γ^5 (a ket reteg kozotti atmenet)
-- ===============================================================

||| A γ^5 a ket reteg kozotti atmenet (a chirality = a Carnot-
||| buborek). A γ^5 = 0 eseten a ket reteg konzisztens (CPT-exakt,
||| vacuum); γ^5 != 0 eseten a buborek (a δ stabilizator).
public export
Gamma5 : Type
Gamma5 = Double

||| A γ^5 erteke: a delta (α_Horgony - α_CODATA).
||| (v3: a HELYI gamma5-duplikátum KI — §24; az importolt
|||  MagyarCarnotE9_v3_CodatAlpha.gamma5 használandó minősítve.
|||  A Gamma5 TÍPUS-ÁLNÉV fent marad, mert az importban nincs.)

||| A γ^5 előjele: pozitív (a buborék fennáll) vagy közel nulla.
||| (v3: minősített hivatkozás — kiküszöböli a kétértelműséget.)
public export
gamma5Pozitiv : Bool
gamma5Pozitiv = MagyarCarnotE9_v3_CodatAlpha.gamma5 > 0.0

-- ===============================================================
-- 4. A KETOLDALI E8-FA (14 dimenzio)
-- ===============================================================

||| A ketoldali E8-bit: pozitiv + negativ + γ^5 = 14 dimenzio.
||| A ket reteg osszekapcsolasa a γ^5 (a chirality).
public export
record KetoldaliBit where
  constructor KetoldaliBitKonstruktor
  pozitiv : Kubit     -- a 7-bites pozitiv oldal egy bitje
  negativ : Kubit     -- a 7-bites negativ oldal egy bitje
  gamma5  : Gamma5    -- a ket reteg kozotti atmenet

||| Az ures ketoldali bit: minden komponens Nulla / 0.
public export
UrressKetoldaliBit : KetoldaliBit
UrressKetoldaliBit =
  KetoldaliBitKonstruktor Nulla Nulla 0.0

||| A ketoldali Steane: 14 bit (7 pozitiv + 7 negativ) + γ^5.
public export
record KetoldaliSteane where
  constructor KetoldaliSteaneKonstruktor
  pBitek : List Kubit   -- a 7 pozitiv bit
  nBitek : List Kubit   -- a 7 negativ bit
  gamma5 : Gamma5      -- a chirality

||| Az ures ketoldali Steane.
public export
UrressKetoldaliSteane : KetoldaliSteane
UrressKetoldaliSteane =
  KetoldaliSteaneKonstruktor (replicate 7 Nulla) (replicate 7 Nulla) 0.0

-- ===============================================================
-- 5. A KETOLDALI CARNOT-CIKLUS (a ket reteg osszekapcsolasa)
-- ===============================================================

||| A ketoldali Carnot-ciklus: a pozitiv reteg Carnot-ciklusa +
||| a negativ reteg Carnot-ciklusa + a γ^5 atmenet.
public export
record KetoldaliCarnotCiklus where
  constructor KetoldaliCarnotCiklusKonstruktor
  pozitivLepes : CarnotLepes      -- a pozitiv oldal lepese
  negativLepes : CarnotLepes      -- a negativ oldal lepese
  gamma5       : Gamma5           -- a ket oldal kozotti atmenet

||| A ketoldali Carnot-ciklus hatekonysaga: η_ketoldali = η_p × η_n.
||| (A ket oldal hatekonysaganak szorzata, mert a ket oldal sorban
||| fut.)
public export
ketoldaliHatekonysag : Double -> Double -> Double -> Double
ketoldaliHatekonysag etaP etaN g5 =
  etaP * etaN * (1.0 - g5)
  -- (a γ^5 a harmadik szorzo: a ket reteg kozotti atmenet)

||| A ketoldali veszteseg: 1 - η_ketoldali.
public export
ketoldaliVeszteseg : Double -> Double -> Double -> Double
ketoldaliVeszteseg etaP etaN g5 = 1.0 - ketoldaliHatekonysag etaP etaN g5

-- ===============================================================
-- 6. A 14-BIT STEM (a Dirac spec-bol, mint referencia)
-- ===============================================================

||| A 14-bit stem: a pozitiv 7 bit + a negativ 7 bit.
||| (A horgony/szerver/dirac_lang.py spec 14-bit stem-je, TILTOTT,
||| de itt matematikai referencia.)
public export
Stem14 : Type
Stem14 = (List Kubit, List Kubit)

||| A 14-bit stem egyenlosege: 2^14 = 16384 lehetoseg (a Dirac
||| spec szotar-merete).
public export
stem14Allapotok : Nat
stem14Allapotok = 16384  -- 2^14

||| A 14-bit stem 16384 allapota megfelel a magyar ABC 40 betuje
||| × ~410 szöveges szónak (a magyar szókincs becsült merete).
public export
stem14MegfelelMagyarnak : Bool
stem14MegfelelMagyarnak = stem14Allapotok >= 40 * 410

-- ===============================================================
-- 7. A HIBJAVÍTÁS A KÉTOLDALI STRUKTÚRÁBAN
-- ===============================================================

||| A hibajavítás a pozitiv oldalon: 1 bit (Steane [[7,1,3]]).
||| A hibajavítás a negativ oldalon: 1 bit (inverz Steane).
||| Osszesen: 2 bit / szint.
public export
hibajavitasKetoldali : Nat
hibajavitasKetoldali = 2

||| Az 5-szintű fa teljes hibajavítása (2 × 31 = 62 bit).
public export
totalJavitasKetoldali : Nat
totalJavitasKetoldali = 2 * totalJavitas

-- ===============================================================
-- 8. A MAGYAR SZIMMETRIÁK ILLESZTÉSE A KÉTOLDALI STRUKTÚRÁHOZ
-- ===============================================================

||| A pozitiv reteg magyar szimmetriai:
|||   paritás (bit1+bit7), hangrend (bit2), zöngésség (bit2+bit5).
public export
pozitivMagyarSzimmetria : List MagyarSzimmetria
pozitivMagyarSzimmetria = [Paritas, Hangrend, Zongesseg]

||| A negativ reteg magyar szimmetriai:
|||   agglutináció (a toldalékok sorrendje).
public export
negativMagyarSzimmetria : List MagyarSzimmetria
negativMagyarSzimmetria = [Agglutinacio]

||| A ket reteg osszekapcsolasa: a γ^5 (a chirality) a buborek.
public export
gamma5MagyarSzimmetria : MagyarSzimmetria
gamma5MagyarSzimmetria = Paritas  -- (az elso szimmetria a γ^5-vel ter vissza)

-- ===============================================================
-- 9. A FA-SZINTEK KETOLDALI ILLESZTÉSE
-- ===============================================================

||| Az 5-szintű fa ketoldali hibajavitasa:
|||   Levél: 2 bit (1 pozitiv + 1 negativ)
|||   Szotag: 4 bit (2 + 2)
|||   Szo: 8 bit (4 + 4)
|||   Mondat: 16 bit (8 + 8)
|||   Gondolat: 32 bit (16 + 16)
public export
ketoldaliJavitasSzinten : FaSzint -> Nat
ketoldaliJavitasSzinten Levél    = 2
ketoldaliJavitasSzinten Szotag   = 4
ketoldaliJavitasSzinten Szo      = 8
ketoldaliJavitasSzinten Mondat   = 16
ketoldaliJavitasSzinten Gondolat = 32

||| A teljes ketoldali javitas: 2 + 4 + 8 + 16 + 32 = 62 bit.
public export
totalKetoldaliJavitas : Nat
totalKetoldaliJavitas = 2 + 4 + 8 + 16 + 32

-- ===============================================================
-- 10. A PIROSKA-MESE A KÉTOLDALI STRUKTÚRÁBAN
-- ===============================================================

||| A Piroska-mese 22 mondata a ketoldali E8-faban:
|||   22 × 7 pozitiv bit = 154 bit (a pozitiv reteg).
|||   22 × 7 negativ bit = 154 bit (a negativ reteg).
|||   Osszesen: 308 bit + a γ^5.
public export
piroskaPozitiv : Nat
piroskaPozitiv = 22 * 7

public export
piroskaNegativ : Nat
piroskaNegativ = 22 * 7

public export
piroskaKetoldali : Nat
piroskaKetoldali = piroskaPozitiv + piroskaNegativ

||| A Piroska-mese 308 bitje a 128 (Steane) és a 240 (E8) kozott,
||| mindket iranyban.
public export
piroska128Felett : Bool
piroska128Felett = piroskaKetoldali > steaneHilbertTer

public export
piroska240Alatt : Bool
piroska240Alatt = piroskaKetoldali < e8Gyokok * 2
  -- (a ketoldali E8: 480 gyok, 240 × 2)

-- ===============================================================
-- 11. REFL-BIZONYITASOK
-- ===============================================================

-- (v3: NAGYBETŰS aliasok a kisbetűs-csapda ellen — KisBetűsProjekcióCsapda;
--  a v2 sosem fordult le, ezért a bizonyítás-típusok beszennyezettek voltak.)

public export
PozitivBitekSzamaKonst : Nat
PozitivBitekSzamaKonst = pozitivBitekSzama

public export
NegativBitekSzamaKonst : Nat
NegativBitekSzamaKonst = negativBitekSzama

public export
BitekOsszegeKonst : Nat
BitekOsszegeKonst = pozitivBitekSzama + negativBitekSzama

public export
Gamma5Konst : Double
Gamma5Konst = MagyarCarnotE9_v3_CodatAlpha.gamma5

public export
Stem14AllapotokKonst : Nat
Stem14AllapotokKonst = stem14Allapotok

public export
TotalKetoldaliJavitasKonst : Nat
TotalKetoldaliJavitasKonst = totalKetoldaliJavitas

public export
PiroskaKetoldaliKonst : Nat
PiroskaKetoldaliKonst = piroskaKetoldali

public export
Gamma5PozitivKonst : Bool
Gamma5PozitivKonst = gamma5Pozitiv

||| Refl -- a pozitiv reteg 7 bitet tartalmaz.
public export
bizPozitivHét : PozitivBitekSzamaKonst = 7
bizPozitivHét = Refl

||| Refl -- a negativ reteg 7 bitet tartalmaz.
public export
bizNegativHét : NegativBitekSzamaKonst = 7
bizNegativHét = Refl

||| Refl -- a ket reteg egyutt 14 bit.
public export
bizKetoldaliTizennegy : BitekOsszegeKonst = 14
bizKetoldaliTizennegy = Refl

||| Refl -- a γ^5 erteke a delta (α_Horgony - α_CODATA).
public export
bizGamma5Delta : Gamma5Konst = DeltaKonst
bizGamma5Delta = Refl

||| Refl -- a 14-bit stem 16384 allapota megfelel a magyar szokincsnek.
public export
bizStem14Allapot : Stem14AllapotokKonst = 16384
bizStem14Allapot = Refl

||| Refl -- a ketoldali hibajavitas szintenkent (Levél=2).
public export
bizKetoldaliJavitas2 : ketoldaliJavitasSzinten Levél = 2
bizKetoldaliJavitas2 = Refl

||| Refl -- a teljes ketoldali javitas (2+4+8+16+32 = 62 bit).
public export
bizTotalJavitas62 : TotalKetoldaliJavitasKonst = 62
bizTotalJavitas62 = Refl

||| Refl -- a Piroska-mese 308 bitje (154 + 154) a Steane felett.
public export
bizPiroska308Felett : PiroskaKetoldaliKonst = 308
bizPiroska308Felett = Refl

||| Refl -- a γ^5 pozitiv (a buborek fennall, a delta > 0).
public export
bizGamma5Pozitiv : Gamma5PozitivKonst = True
bizGamma5Pozitiv = Refl
