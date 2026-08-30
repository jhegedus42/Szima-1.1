module Dimenzio

-- ═══════════════════════════════════════════════════════════════
-- DIMENZIONÁLT TÍPUSOK — MINDEN BECSOMAGOLVA
-- ═══════════════════════════════════════════════════════════════
-- Egyetlen csomagolatlan Double, Bool, String sem.
-- Minden fizikai mennyiség saját típusba csomagolva.
-- Hierarchikus típusok typeclass-okon keresztül.

-- ─── ALAP TÍPUSOK ─────────────────────────────────────────

||| Skalár érték (dimenzió nélküli szám).
public export
record Skalar where
  constructor SkalarKonstruktor
  ertek : Double

||| Szöveg (String helyett).
public export
record Szoveg where
  constructor SzovegKonstruktor
  tartalom : String

||| Címke (String helyett, nevesítve).
public export
record Cimke where
  constructor CimkeKonstruktor
  nev : String

||| Leírás (String helyett).
public export
record Leiras where
  constructor LeirasKonstruktor
  szoveg : String

||| Logikai érték (Bool helyett, nevesítve).
public export
record Igazsag where
  constructor IgazsagKonstruktor
  ertek : Bool

-- ─── FIZIKAI MENNYISÉGEK ──────────────────────────────────

||| Hossz (méter).
public export
record Hossz where
  constructor HosszKonstruktor
  meter : Double

||| Idő (másodperc).
public export
record IdoMennyiseg where
  constructor IdoMennyisegKonstruktor
  masodperc : Double

||| Tömeg (kilogramm).
public export
record TomegMennyiseg where
  constructor TomegKonstruktor
  kilogramm : Double

||| Hőmérséklet (kelvin).
public export
record HomersekletMennyiseg where
  constructor HomersekletKonstruktor
  kelvin : Double

||| Energia (joule).
public export
record EnergiaMennyiseg where
  constructor EnergiaKonstruktor
  joule : Double

||| Erő (newton).
public export
record EroMennyiseg where
  constructor EroKonstruktor
  newton : Double

||| Nyomás (pascal).
public export
record NyomasMennyiseg where
  constructor NyomasKonstruktor
  pascal : Double

||| Térfogat (m³).
public export
record TerfogatMennyiseg where
  constructor TerfogatKonstruktor
  kobmeter : Double

||| Entrópia (J/K).
public export
record EntropiaMennyiseg where
  constructor EntropiaKonstruktor
  joulePerKelvin : Double

||| Frekvencia (Hz).
public export
record FrekvenciaMennyiseg where
  constructor FrekvenciaKonstruktor
  hertz : Double

||| Sebesség (m/s).
public export
record SebessegMennyiseg where
  constructor SebessegKonstruktor
  meterPerMasodperc : Double

||| Gyorsulás (m/s²).
public export
record GyorsulasMennyiseg where
  constructor GyorsulasKonstruktor
  meterPerMasodpercNegyzet : Double

||| Impulzus (kg·m/s).
public export
record ImpulzusMennyiseg where
  constructor ImpulzusKonstruktor
  kilogrammMeterPerMasodperc : Double

||| Távolság (m, mint Hossz de szemantikailag más).
public export
record TavolsagMennyiseg where
  constructor TavolsagKonstruktor
  meter : Double

||| Terület (m²).
public export
record TeruletMennyiseg where
  constructor TeruletKonstruktor
  negyzetmeter : Double

||| Szög (radián).
public export
record SzogMennyiseg where
  constructor SzogKonstruktor
  radian : Double

-- ─── FUNKCIÓ TÍPUSOK (csomagolt függvények) ───────────────

||| Lagrange-függvény: L(q, q̇) → Energia.
public export
record LagrangeFuggveny where
  constructor LagrangeKonstruktor
  ertek : Hossz -> SebessegMennyiseg -> EnergiaMennyiseg

||| Hamilton-függvény: H(q, p) → Energia.
public export
record HamiltonFuggveny where
  constructor HamiltonKonstruktor
  ertek : Hossz -> ImpulzusMennyiseg -> EnergiaMennyiseg

||| Metrika: g(v, w) → Skalár.
public export
record MetrikaFuggveny where
  constructor MetrikaFuggvenyKonstruktor
  ertek : (Hossz, Hossz) -> (Hossz, Hossz) -> Skalar

||| Potenciál: U(S, V) → Energia.
public export
record PotencialFuggveny where
  constructor PotencialKonstruktor
  ertek : EntropiaMennyiseg -> TerfogatMennyiseg -> EnergiaMennyiseg

||| Termodynamikai potenciál (általános).
public export
record TermodynamikaiPotencialFuggveny where
  constructor TermPotencialKonstruktor
  ertek : HomersekletMennyiseg -> NyomasMennyiseg -> EnergiaMennyiseg

-- ─── TYPECLASS HIERARCHIA ─────────────────────────────────

||| Alap: minden fizikai mennyiségnek van értéke.
public export
interface FizikaiMennyisegT (a : Type) where
  skalarErtek : a -> Skalar

||| Energia típusú mennyiségek.
public export
interface FizikaiMennyisegT a => EnergiaT a where
  jouleErtek : a -> EnergiaMennyiseg

||| Kinetikai energia.
public export
interface EnergiaT a => KinetikaiEnergiaT a where
  sebessegbol : TomegMennyiseg -> SebessegMennyiseg -> a

||| Potenciális energia.
public export
interface EnergiaT a => PotencialisEnergiaT a where
  magassagbol : TomegMennyiseg -> Hossz -> a

||| Hossz típusú mennyiségek.
public export
interface FizikaiMennyisegT a => HosszT a where
  meterErtek : a -> Hossz

||| Idő típusú mennyiségek.
public export
interface FizikaiMennyisegT a => IdoT a where
  masodpercErtek : a -> IdoMennyiseg

||| Tömeg típusú mennyiségek.
public export
interface FizikaiMennyisegT a => TomegT a where
  kilogrammErtek : a -> TomegMennyiseg

||| Hőmérséklet típusú mennyiségek.
public export
interface FizikaiMennyisegT a => HomersekletT a where
  kelvinErtek : a -> HomersekletMennyiseg

-- ─── TYPECLASS INSTANCE-OK ────────────────────────────────

public export
FizikaiMennyisegT EnergiaMennyiseg where
  skalarErtek (EnergiaKonstruktor j) = SkalarKonstruktor j

public export
EnergiaT EnergiaMennyiseg where
  jouleErtek e = e

public export
FizikaiMennyisegT Hossz where
  skalarErtek (HosszKonstruktor m) = SkalarKonstruktor m

public export
HosszT Hossz where
  meterErtek h = h

public export
FizikaiMennyisegT IdoMennyiseg where
  skalarErtek (IdoMennyisegKonstruktor s) = SkalarKonstruktor s

public export
IdoT IdoMennyiseg where
  masodpercErtek i = i

public export
FizikaiMennyisegT TomegMennyiseg where
  skalarErtek (TomegKonstruktor kg) = SkalarKonstruktor kg

public export
TomegT TomegMennyiseg where
  kilogrammErtek t = t

public export
FizikaiMennyisegT HomersekletMennyiseg where
  skalarErtek (HomersekletKonstruktor k) = SkalarKonstruktor k

public export
HomersekletT HomersekletMennyiseg where
  kelvinErtek h = h

public export
FizikaiMennyisegT SebessegMennyiseg where
  skalarErtek (SebessegKonstruktor v) = SkalarKonstruktor v

public export
FizikaiMennyisegT Skalar where
  skalarErtek s = s

public export
FizikaiMennyisegT FrekvenciaMennyiseg where
  skalarErtek (FrekvenciaKonstruktor hz) = SkalarKonstruktor hz

public export
FizikaiMennyisegT ImpulzusMennyiseg where
  skalarErtek (ImpulzusKonstruktor p) = SkalarKonstruktor p

public export
FizikaiMennyisegT SzogMennyiseg where
  skalarErtek (SzogKonstruktor r) = SkalarKonstruktor r

public export
FizikaiMennyisegT TeruletMennyiseg where
  skalarErtek (TeruletKonstruktor t) = SkalarKonstruktor t

public export
FizikaiMennyisegT EntropiaMennyiseg where
  skalarErtek (EntropiaKonstruktor e) = SkalarKonstruktor e

public export
FizikaiMennyisegT NyomasMennyiseg where
  skalarErtek (NyomasKonstruktor p) = SkalarKonstruktor p

public export
FizikaiMennyisegT TerfogatMennyiseg where
  skalarErtek (TerfogatKonstruktor v) = SkalarKonstruktor v

public export
FizikaiMennyisegT EroMennyiseg where
  skalarErtek (EroKonstruktor n) = SkalarKonstruktor n

public export
FizikaiMennyisegT TavolsagMennyiseg where
  skalarErtek (TavolsagKonstruktor m) = SkalarKonstruktor m

-- ─── ARITMETIKAI SEGÉDFÜGGVÉNYEK ──────────────────────────

||| Skalár összeadás.
public export
skalarOsszead : Skalar -> Skalar -> Skalar
skalarOsszead (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a + b)

||| Skalár kivonás.
public export
skalarKivon : Skalar -> Skalar -> Skalar
skalarKivon (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a - b)

||| Skalár szorzás.
public export
skalarSzoroz : Skalar -> Skalar -> Skalar
skolarSzoroz (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a * b)

||| Skalár osztás.
public export
skalarOszt : Skalar -> Skalar -> Skalar
skalarOszt (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a / b)

||| Skalár gyökvonás.
public export
skalarGyok : Skalar -> Skalar
skalarGyok (SkalarKonstruktor a) = SkalarKonstruktor (sqrt a)

||| Skalár abszolút érték.
public export
skalarAbs : Skalar -> Skalar
skalarAbs (SkalarKonstruktor a) = SkalarKonstruktor (abs a)

||| Skalár π.
public export
skalarPi : Skalar
skalarPi = SkalarKonstruktor pi

||| Skalár logaritmus (természetes).
public export
skalarLog : Skalar -> Skalar
skalarLog (SkalarKonstruktor a) = SkalarKonstruktor (log a)

||| Skalár koszinusz.
public export
skalarCos : Skalar -> Skalar
skalarCos (SkalarKonstruktor a) = SkalarKonstruktor (cos a)

||| Skalár szinusz.
public export
skalarSin : Skalar -> Skalar
skalarSin (SkalarKonstruktor a) = SkalarKonstruktor (sin a)

||| Skalár hatványozás.
public export
skalarHatvany : Skalar -> Skalar -> Skalar
skalarHatvany (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a ** b)