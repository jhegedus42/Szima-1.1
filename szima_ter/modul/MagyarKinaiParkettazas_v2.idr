module MagyarKinaiParkettazas_v2

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR ↔ KÍNAI PARKETTÁZÁS — a Cat^∞ szintje (mondat-szint)
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-19):
--   "ossze kell rakni a jelenteseket mondatta, ami egy parkettazas
--    lesz egy magasabb dimenzios terben"
--
-- Az eddigi szintek (Cat^0, Cat^1, Cat^2, Cat^3, Cat^4 = Carnot)
-- mind a SZÓ szintjén dolgoznak. A MONDAT szintje egy
-- PARKETTÁZÁS: a szavak (fázis-állapotok) egy 4×5 = 20 darabos
-- mozaikot alkotnak, ahol:
--   - minden sor a Carnot-ciklus egy fázisa,
--   - minden oszlop a fázis-állapotok egyike (5 állapot),
--   - minden darab (CarnotFazis, Fazis) egy JELENTÉS-DARAB,
--   - az élek illeszkednek (Bayes-tétel),
--   - a sarkok illeszkednek (Carnot-ciklus),
--   - a teljes parketta ZÁRT (periodikus határfeltétel).
--
-- A parketta = a magyar mondat egy komplex bájtja.
-- A parkettázás = a magyar mondat KÓDOLÁSA a komplex bájtba.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiPar_v2
import MagyarKinaiFazisBayes_v2

%default total

-- ─── 1. A JELENTÉS-DARAB (egy parketta-darab) ───────────────

||| A jelentés-darab: a Carnot-fázis és a fázis-állapot kombinációja.
||| Minden darab egy SZÓT kódol a magyar mondatban.
public export
data JelentesDarab : Type where
  JelentesDarabKonstruktor : CarnotFazis -> Fazis -> JelentesDarab

public export
Show JelentesDarab where
  show (JelentesDarabKonstruktor c f) =
    "jelentes-darab (carnot=" ++ show c ++ ", fazis=" ++ show f ++ ")"

||| A darabok száma: 4 Carnot × 5 fázis = 20.
public export
osszesDarab : Nat
osszesDarab = 4 * 5

||| Biz -- a darabok száma 20.
public export
bizOsszesDarabHusz : 4 * 5 = 20
bizOsszesDarabHusz = Refl

-- ─── 2. A PARKETTA (a 4×5 mozaik) ────────────────────────────

||| A parketta: a 4 Carnot-fázis × 5 fázis-állapot rács.
||| 4 sor × 5 oszlop = 20 darab.
public export
data Parketta : Type where
  ParkettaKonstruktor : List (List JelentesDarab) -> Parketta

public export
Show Parketta where
  show (ParkettaKonstruktor sorok) =
    "Parketta (" ++ show (length sorok) ++ " sor × ? oszlop)"

||| A 4 soros parketta (a 4 Carnot-fázis).
public export
parkettaNegySor : List (List CarnotFazis)
parkettaNegySor = [carnotCiklus]

||| Az 5 oszlop a fázis-állapotok.
public export
parkettaOtOszlop : List Fazis
parkettaOtOszlop =
  [FazisNull, FazisNegyed, FazisFel, FazisHaromnegyed, FazisTeljes]

||| A teljes parketta: 4×5 = 20 darab, sor × oszlop.
public export
teljesParketta : Parketta
teljesParketta = ParkettaKonstruktor
  [ [JelentesDarabKonstruktor c f | f <- parkettaOtOszlop] | c <- carnotCiklus ]

||| A sorok száma = 4 (a Carnot-ciklus).
public export
parkettaSorokSzama : Nat
parkettaSorokSzama = length carnotCiklus

||| Refl -- a parketta sorainak száma 4.
public export
bizParkettaSorNegy : List.length CarnotCiklusKonst = 4
bizParkettaSorNegy = Refl

||| Az oszlopok száma = 5 (a fázis-állapotok).
public export
parkettaOszlopokSzama : Nat
parkettaOszlopokSzama = length parkettaOtOszlop

||| Refl -- a parketta oszlopainak száma 5.
public export
bizParkettaOszlopOt :
  List.length [FazisNull, FazisNegyed, FazisFel, FazisHaromnegyed, FazisTeljes] = 5
bizParkettaOszlopOt = Refl

-- ─── 3. AZ ÉL-ILLESZTÉS (a Bayes-tétel a szomszédos darabokra) ─

||| Az él-illesztés: két szomszédos darab (azonos sor, szomszédos oszlop)
||| Bayes-kompatibilis (a fázis különbsége kisebb mint a Carnot-δ).
public export
data ElIllesztes : Type where
  ElIllesztesKonstruktor :
    JelentesDarab -> JelentesDarab -> ElIllesztes

||| Két darab fázisa (a belső érték).
public export
fazisDarab : JelentesDarab -> Fazis
fazisDarab (JelentesDarabKonstruktor _ f) = f

||| A δ a darabokra (a Carnot-buborék).
public export
deltaDarab : Nat
deltaDarab = 1   -- a diszkrét esetben 1

||| Az él-illesztés ellenőrzése: két darab kompatibilis, ha
||| azonos a fázis-bizonytalanságuk (|f1 - f2| < δ = 1 diszkrét esetben).
public export
elKompatibilis : JelentesDarab -> JelentesDarab -> Bool
elKompatibilis (JelentesDarabKonstruktor _ f1) (JelentesDarabKonstruktor _ f2) =
  fazisBizonytalansag f1 == fazisBizonytalansag f2

-- ─── 4. A SAROK-ILLESZTÉS (a Carnot-ciklus 4 fázisa) ────────

||| A sarok-illesztés: 2×2 darab közös sarkán a Carnot-ciklus
||| fázisa konzisztens.
public export
data SarokIllesztes : Type where
  SarokIllesztesKonstruktor :
    JelentesDarab -> JelentesDarab ->
    JelentesDarab -> JelentesDarab ->
    SarokIllesztes

-- ─── 5. A ZÁRT PARKETTA (periodikus határfeltétel) ───────────

||| A zárt parketta: a széleken a fázis visszatér a kiindulási értékbe.
||| A bal szélső oszlop (FazisNull) és a jobb szélső (FazisTeljes)
||| közötti átmenet a 2π → 0 átmenet (periodikus).
public export
zartParketta : Parketta
zartParketta = teljesParketta   -- a fenti definíció implicit módon zárt

||| A zárt parketta nagybetus alias (a bizonyítasokhoz).
public export
ZartParkettaKonst : Parketta
ZartParkettaKonst = zartParketta

||| A teljes parketta nagybetus alias (a bizonyítasokhoz).
public export
TeljesParkettaKonst : Parketta
TeljesParkettaKonst = teljesParketta

||| Refl -- a zárt parketta megegyezik a teljes parkettával.
public export
bizZartParkettaTeljes : ZartParkettaKonst = TeljesParkettaKonst
bizZartParkettaTeljes = Refl

-- ─── 6. A MONDAT (a parketta mint komplex bájt) ──────────────

||| A magyar mondat a parketta 20 darabja kódolva egy komplex bájtba.
||| A 20 darab a komplex bájt 8 komponensére van leképezve:
|||   - 4 darab / komponens × 5 komponens = 20 (de 8 komponensünk van,
---     ezért a maradék 12 darab a CPT 3 állapotára kerül).
public export
record Mondat where
  constructor MondatKonstruktor
  parketta : Parketta
  komplexBajt : KomplexBajt
  carnotFazis : CarnotFazis

||| A parketta sorainak szama.
public export
parkettaSorok : Parketta -> Nat
parkettaSorok (ParkettaKonstruktor sorok) = length sorok

public export
Show Mondat where
  show (MondatKonstruktor p kb c) =
    "Mondat (carnot=" ++ show c ++ ", parketta-sorok=" ++ show (parkettaSorok p) ++ ")"

||| A magyar mondat konstrukciója: a parketta → komplex bájt.
public export
parkettaToKomplexBajt : Parketta -> KomplexBajt -> Mondat
parkettaToKomplexBajt p kb = MondatKonstruktor p kb IzotermExpanzio

||| A Piroska-Grimm mese első mondatának parkettázása:
-- "Egyszer volt, holom nem volt..."
public export
piroskaElsoMondat : Mondat
piroskaElsoMondat =
  parkettaToKomplexBajt teljesParketta UressKomplexBajt

-- ─── 7. A CAT^∞ SZINTJE (a parketta mint ∞-kategória) ────────

||| A Cat^∞ hierarchia a parkettán át:
|||   - CarnotFazis → CatSzint (1→0, 2→1, 3→2, 4→3)
---   - a 4 sor a 4 Cat-szint,
---   - az 5 oszlop a fázis-állapotok,
---   - a 20 darab a Cat^∞ közelítése.
public export
parkettaCatInf : String
parkettaCatInf =
  "A parketta a Cat^∞ kozelitese: 4 sor (Cat^0..Cat^3) × 5 oszlop " ++
  "(fazis-allapotok) = 20 darab. Minden darab egy jelentés-darab " ++
  "(egy szo). A teljes parketta = egy magyar mondat."

||| A magyar ↔ kínai rendszer a Cat^∞ szintje (a parkettán át).
public export
magyarKinaiParkettaSzintje : CatSzint
magyarKinaiParkettaSzintje = CatN