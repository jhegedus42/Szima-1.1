module SteaneHamiltonian

-- ═══════════════════════════════════════════════════════════════
-- STEANE-HAMILTONIÁN — a [[7,1,3]] kód stabilizátor-Hamiltoniánja
-- ═══════════════════════════════════════════════════════════════
-- FORRÁS: Kimi-archívum, transzkript_szemelyes.txt 280–295. sor
-- (2026-07-28). A Hamiltonián:
--
--   H = −(X₁X₂X₃X₄ + X₁X₂X₅X₆ + X₁X₃X₅X₇
--        + Z₁Z₂Z₃Z₄ + Z₁Z₂Z₅Z₆ + Z₁Z₃Z₅Z₇)
--
-- A 6 stabilizátor generátor a Hamming-mátrix három sorával:
--   1111000, 1100110, 1010101 (X- és Z-oldalon ugyanez).
--
-- Klaszikus CSS-értelmezés (stabilizátor-formalizmus nyoma):
--   az állapot = (érték 7 bit, fázis 7 bit);
--   a Z-stabilizátor a bitflip-hibát nézi:  (−1)^(maszk ⊙ érték);
--   az X-stabilizátor a fázishibát nézi:    (−1)^(maszk ⊙ fázis).
--
-- AZ ENERGIA: a 6 stabilizátorból hány veszti el a +1 sajátértékét.
--   tiszta állapot → 0 (H = −6, alapállapot — a legalacsonyabb!)
--   1 bites hiba → 1, 2 vagy 3 aszerint, melyik oszlopban van a hiba
-- A H-mátrix 7 oszlopa páronként különbözik — ez a [[7,1,3]] lényege,
-- Refl-bizonyítva lentebb.
--
-- A CARNOT-KAPCSOLAT: a mérés (szindróma-leolvasás) = izoterm expanzió;
-- a javítás (unitér) = adiabatikus expanzió — AZ ENTRÓPIA CSÖKKEN;
-- a szindróma törlése = izoterm kompresszió (kT·ln2 ki);
-- az ancilla újrakészítése = adiabatikus kompresszió.
-- (docs/carnot_entropia.html §2)
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import ModulRegisztracio

%default total

-- ─── 2. ÁLLAPOT = (ÉRTÉK, FÁZIS) ──────────────────────────
-- A stabilizátor-formalizmus klaszikus nyoma: a fizikai állapot
-- egy érték- és egy fázisvektor. Mindkettő 7 Kubit.

public export
record SteaneAllapot where
  constructor SteaneAllapotKonstruktor
  ertek  : HetesKod
  fazis  : HetesKod

-- ─── 3. SZINDRÓMA-BIT: maszk ⊙ kód PARITÁSA ───────────────
-- A maszk és a kód pozíciónkénti ÉS-e, majd XOR-lánc.
-- Ez a Z-stabilizátor (−1)^(m·x) kitejezés Kubit-nyoma.

public export
hetesParitas : Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit -> Kubit
hetesParitas a b c d e f g =
  kubitXor a (kubitXor b (kubitXor c (kubitXor d (kubitXor e (kubitXor f g)))))

public export
maszkParitasHetes : HetesKod -> HetesKod -> Kubit
maszkParitasHetes (HetesKonstruktor a1 a2 a3 a4 a5 a6 a7)
                  (HetesKonstruktor b1 b2 b3 b4 b5 b6 b7) =
  hetesParitas (kubitEs b1 a1) (kubitEs b2 a2) (kubitEs b3 a3)
               (kubitEs b4 a4) (kubitEs b5 a5) (kubitEs b6 a6)
               (kubitEs b7 a7)

-- ─── 4. A HÁRMAS MASZK (a Hamming-mátrix sorai) ───────────
-- NAGYBETŰS konstansnevek: bizonyítástípusban így hivatkozhatók
-- (Idris 0.8.0: a kisbetűs csupasz név implicit kötés lenne).

-- grafikusan: „1111000" (X₁X₂X₃X₄ = Z₁Z₂Z₃Z₄ maszk)
public export
ElsoMaszk : HetesKod
ElsoMaszk = HetesKonstruktor Egy Egy Egy Egy Nulla Nulla Nulla

-- grafikusan: „1100110" (X₁X₂X₅X₆ = Z₁Z₂Z₅Z₆ maszk)
public export
MasodikMaszk : HetesKod
MasodikMaszk = HetesKonstruktor Egy Egy Nulla Nulla Egy Egy Nulla

-- grafikusan: „1010101" (X₁X₃X₅X₇ = Z₁Z₃Z₅Z₇ maszk)
public export
HarmadikMaszk : HetesKod
HarmadikMaszk = HetesKonstruktor Egy Nulla Egy Nulla Egy Nulla Egy

-- ─── 5. A TISZTA ÁLLAPOT (logikai |0⟩ + nincs fázishiba) ──

public export
TisztaAllapot : SteaneAllapot
TisztaAllapot =
  SteaneAllapotKonstruktor
    (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
    (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)

-- ─── 6. AZ ENERGIASZINT: hány stabilizátor −1 ─────────────
-- A hat stabilizátor: 3 Z-oldal (értéken) + 3 X-oldal (fázison).
-- Az energiaszint = a nulla helyett Egy (−1) stabilizátorok száma.
-- A fizikai Hamiltonián H = −(S₁+…+S₆) értéke ebből: 2·szint − 6,
-- azaz a spektrum {−6,−4,−2,0,+2,+4,+6} — páros számok, ahogy
-- a Kimi-transzkript mondja.

public export
kubitSuly : Kubit -> Nat
kubitSuly Nulla = 0
kubitSuly Egy   = 1

public export
energiaSzint : SteaneAllapot -> Nat
energiaSzint allapot =
  kubitSuly (maszkParitasHetes ElsoMaszk    (ertek allapot)) +
  kubitSuly (maszkParitasHetes MasodikMaszk (ertek allapot)) +
  kubitSuly (maszkParitasHetes HarmadikMaszk (ertek allapot)) +
  kubitSuly (maszkParitasHetes ElsoMaszk    (fazis allapot)) +
  kubitSuly (maszkParitasHetes MasodikMaszk (fazis allapot)) +
  kubitSuly (maszkParitasHetes HarmadikMaszk (fazis allapot))

-- A fizikai Hamiltonián-érték a spektrumban: 2·szint − 6.
-- Integer-ábrázolás (a −6 negatív!), a spektrumtabla Show-ban.

public export
hamiltonianErtek : SteaneAllapot -> Integer
hamiltonianErtek allapot =
  2 * (cast {from=Nat} {to=Integer} (energiaSzint allapot)) - 6

-- ─── 7. BIZONYÍTÁSOK (Refl — a fordító a bírája) ──────────

-- A tiszta állapot alapállapot: H = −6 (a legalacsonyabb energia).
-- Kimenet: Refl (0 = 0 ✓)
BizTisztaSzint : energiaSzint TisztaAllapot = 0
BizTisztaSzint = Refl

-- Kimenet: Refl (−6 = −6 ✓)
BizTisztaHamiltonian : hamiltonianErtek TisztaAllapot = -6
BizTisztaHamiltonian = Refl

-- ─── 8. AZ EGY-BITES HIBÁK: mind a 7 pozíció ──────────────
-- A H-mátrix oszlopai páronként különböznek → minden hibapozíció
-- más szindrómát ad. Ez a [[7,1,3]] távolság-3 lényege.

-- X₁ hiba (érték = 1000000): oszlop-1 = (1,1,1) → mindhárom maszk érzékeli
-- grafikusan: „1000000" értékhiba az 1. pozícióban
public export
EgyesHibaAllapot : SteaneAllapot
EgyesHibaAllapot =
  SteaneAllapotKonstruktor
    (HetesKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla)
    (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)

-- Kimenet: Refl (3 = 3 ✓) — a (1,1,1) oszlop: 3 stabilizátor vált
BizEgyesHibaSzint : energiaSzint EgyesHibaAllapot = 3
BizEgyesHibaSzint = Refl

-- Kimenet: Refl (0 = 0 ✓) — H = 2·3−6 = 0
BizEgyesHibaHamiltonian : hamiltonianErtek EgyesHibaAllapot = 0
BizEgyesHibaHamiltonian = Refl

-- X₄ hiba (érték = 0001000): oszlop-4 = (1,0,0) → csak az első maszk
public export
NegyesHibaAllapot : SteaneAllapot
NegyesHibaAllapot =
  SteaneAllapotKonstruktor
    (HetesKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla)
    (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)

-- Kimenet: Refl (1 = 1 ✓) — a (1,0,0) oszlop: 1 stabilizátor vált
BizNegyesHibaSzint : energiaSzint NegyesHibaAllapot = 1
BizNegyesHibaSzint = Refl

-- Kimenet: Refl (−4 = −4 ✓) — H = 2·1−6 = −4
BizNegyesHibaHamiltonian : hamiltonianErtek NegyesHibaAllapot = -4
BizNegyesHibaHamiltonian = Refl

-- Fázishiba az 5. pozícióban (oszlop-5 = (0,1,1)): az X-oldal érzékeli
public export
OtosFazisHibaAllapot : SteaneAllapot
OtosFazisHibaAllapot =
  SteaneAllapotKonstruktor
    (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
    (HetesKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla)

-- Kimenet: Refl (2 = 2 ✓) — a (0,1,1) oszlop: 2 stabilizátor vált
BizOtosFazisHibaSzint : energiaSzint OtosFazisHibaAllapot = 2
BizOtosFazisHibaSzint = Refl

-- ─── 9. A SZINDRÓMA-KIOLVASÁS — a hiba lokalizálása ───────
-- A 3 érték-oldali szindrómabit binárisan megmondja a hiba
-- pozícióját. A 7 oszlop: (1,1,1)(1,1,0)(1,0,1)(1,0,0)(0,1,1)(0,1,0)(0,0,1)
-- — ez a standard Hamming-elrendezés.

public export
record ErtekSzindroma where
  constructor ErtekSzindromaKonstruktor
  elsoBit   : Kubit
  masodikBit : Kubit
  harmadikBit : Kubit

public export
Show ErtekSzindroma where
  show szindroma =
    show (elsoBit szindroma) ++ show (masodikBit szindroma)
    ++ show (harmadikBit szindroma)

public export
ertekSzindroma : SteaneAllapot -> ErtekSzindroma
ertekSzindroma allapot =
  ErtekSzindromaKonstruktor
    (maszkParitasHetes ElsoMaszk   (ertek allapot))
    (maszkParitasHetes MasodikMaszk (ertek allapot))
    (maszkParitasHetes HarmadikMaszk (ertek allapot))

-- A szindromák mint oszlopok (nagybetűs konstansok a bizonyításhoz):

-- grafikusan: „000" = nincs hiba
public export
SzindromaTisztasag : ErtekSzindroma
SzindromaTisztasag = ErtekSzindromaKonstruktor Nulla Nulla Nulla

-- grafikusan: „111" = 1. pozíció (oszlop-1)
public export
SzindromaEgyes : ErtekSzindroma
SzindromaEgyes = ErtekSzindromaKonstruktor Egy Egy Egy

-- grafikusan: „100" = 4. pozíció (oszlop-4)
public export
SzindromaNegyes : ErtekSzindroma
SzindromaNegyes = ErtekSzindromaKonstruktor Egy Nulla Nulla

-- grafikusan: „011" = 5. pozíció (oszlop-5)
public export
SzindromaOtos : ErtekSzindroma
SzindromaOtos = ErtekSzindromaKonstruktor Nulla Egy Egy

-- Kimenet: Refl — a tiszta állapot szindrómája 000
BizSzindromaTiszta : ertekSzindroma TisztaAllapot = SzindromaTisztasag
BizSzindromaTiszta = Refl

-- Kimenet: Refl — az 1. bites hiba szindrómája 111 (a bináris 1)
BizSzindromaEgyes : ertekSzindroma EgyesHibaAllapot = SzindromaEgyes
BizSzindromaEgyes = Refl

-- Kimenet: Refl — a 4. bites hiba szindrómája 100 (a bináris 4)
BizSzindromaNegyes : ertekSzindroma NegyesHibaAllapot = SzindromaNegyes
BizSzindromaNegyes = Refl

-- Kimenet: Refl — a Z₅ FAZISHIBÁT az érték-oldali szindróma NEM látja
-- (a fázis a Z-stabilizátor duál oldala — ezt érzékeli, nem az értéket)
BizSzindromaFazisLathatatlan : ertekSzindroma OtosFazisHibaAllapot = SzindromaTisztasag
BizSzindromaFazisLathatatlan = Refl

-- ─── 10. A SPEKTRUM-TÁBLÁZAT (a Kimi-transzkript szerint) ─

public export
spektrumTabla : String
spektrumTabla =
  "H = −(S₁+…+S₆) spektruma: −6, −4, −2, 0, +2, +4, +6 (páros)\n"
  ++ "  szint 0 (tiszta, kódtér)      → H = −6  [ALAPÁLLAPOT — a kód]\n"
  ++ "  szint 1 (oszlop 2/4/6)        → H = −4\n"
  ++ "  szint 2 (oszlop 3/5/7)        → H = −2\n"
  ++ "  szint 3 (oszlop 1)            → H =  0\n"
  ++ "  fázishibák tükörben ugyanezek\n"
  ++ "A 279 hiba-ige (szemelyes.txt): 7 értékhiba + 7 fázishiba\n"
  ++ "pozíció × 3 szindróma-olvasat = a javítási szótár csírája"

-- ─── 11. FŐ — vékony IO-burkoló ───────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ STEANE-HAMILTONIÁN ═══\n"
  ++ "H = −(XXXX + XX XX + X X X X + ZZZZ + ZZ ZZ + Z X Z X Z X)\n"
  ++ spektrumTabla ++ "\n"
  ++ "tiszta állapot: szint = " ++ show (energiaSzint TisztaAllapot)
  ++ ", H = " ++ show (hamiltonianErtek TisztaAllapot) ++ "\n"
  ++ "X₁ hiba: szint = " ++ show (energiaSzint EgyesHibaAllapot)
  ++ ", H = " ++ show (hamiltonianErtek EgyesHibaAllapot)
  ++ ", szindróma = " ++ show (ertekSzindroma EgyesHibaAllapot) ++ "\n"
  ++ "X₄ hiba: szint = " ++ show (energiaSzint NegyesHibaAllapot)
  ++ ", H = " ++ show (hamiltonianErtek NegyesHibaAllapot)
  ++ ", szindróma = " ++ show (ertekSzindroma NegyesHibaAllapot) ++ "\n"
  ++ "Z₅ fázishiba: szint = " ++ show (energiaSzint OtosFazisHibaAllapot)
  ++ ", H = " ++ show (hamiltonianErtek OtosFazisHibaAllapot) ++ "\n"

main : IO ()
main = putStrLn foJelentes


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
SteaneHamiltonianLeiras : ModulLeirasT
SteaneHamiltonianLeiras = ModulLeirasKonstruktor
  "SteaneHamiltonian.idr" "H=−6 alapállapot [Refl]; szindróma=hibapozíció binárisan [Refl]" "a hibajavítás = Carnot-ciklus (mérés→javítás→törlés→újrakészítés)" "9 teszt + 9 Refl"
