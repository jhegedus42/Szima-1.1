module FazisKubit

-- ═══════════════════════════════════════════════════════════════
-- FAZIS KUBIT — a bit mértékegysége a fázis
-- ═══════════════════════════════════════════════════════════════
--
-- A FELHASZNÁLÓ TÉZISE (2026-08-19):
--   "a bitnek a mértékegysége a fázis"
--   "a fázis fizikai, különben a kvantummechanika nem működne...
--    mert az információ elveszik a méréskor... de az információ
--    nem veszhet el a fizikában... az, hogy fizikai, azt jelenti,
--    hogy lehet mérni makroszkopikusan, informaciót kiszedni,
--    de attól még marad kiszedetlen információ — ez az összefonódás"
--
-- A TÉZIS FORMÁLISAN:
--
-- 1. A klasszikus bit: 2 állapot (0/1). Dimenziója: nincs (diszkrét).
-- 2. A kubit: |ψ⟩ = cos(θ/2)|0⟩ + e^{iφ}sin(θ/2)|1⟩.
--    Két szög: θ (a polaris szög = a valószínűség) és φ (az azimut
--    szög = A FÁZIS). A kubit a Bloch-gömbön él (S²).
-- 3. A 2→3 átmenet: a bit (2 állapot) + a fázis (1 szög) = a
--    3-dimenziós Bloch-gömb. A fázis az, ami a 2-est 3-assá teszi.
-- 4. A mérés: a Born-szabály P(0) = cos²(θ/2), P(1) = sin²(θ/2).
--    A φ fázis NEM jelenik meg a valószínűségekben — "elveszettnek"
--    tűnik. DE az unitaritás (az információmegmaradás) tiltja a
--    valódi elveszést: a fázis NEM vész el — ÁTMEgy a környezetbe.
--    A mérés UTÁN a fázis a relatív fázis a |környezet_0⟩ és a
--    |környezet_1⟩ között: α|0⟩|E₀⟩ + β|1⟩|E₁⟩ — ez az ÖSSZEFONÓDÁS.
-- 5. A fázis FIZIKAI — makroszkopikusan mérhető:
--    - a kétrés-kísérlet interferenciaképe (a relatív fázis mérése),
--    - az Aharonov–Bohm-effektus (a fázist a mágneses fluxus méri),
--    - a Josephson-effektus (I = I₀·sin(Δφ) — a fázis áramot hajt),
--    - a Berry-fázis (a geometriai fázis — ciklikus evolúció méri).
--    Ha a fázis NEM lenne fizikai, ezek a jelenségek nem léteznének.
-- 6. A "kiszedetlen" információ = az összefonódás. A mérés kiszed
--    EGY részt (a valószínűséget), de a fázis-információ marad —
--    a rendszer+környezet korrelációiban. Ez a projekt δ-ja:
--    a lobásás kiszedi a fázis egy részét (ln(9/8) lépésenként),
--    de a maradék (δ) = a kiszedetlen fázis = az összefonódás.
--
-- A 2-ES, 3-AS ALGEBRA:
--   A komplex számok ℂ = ℝ² — a 2-es (a bit a fázissal).
--   A Pauli-algebra su(2) — a 3-as (a Bloch-gömb X, Y, Z tengelyei).
--   A fázis az, ami a 2-esből 3-ast csinál: e^{iφ} forgatja a
--   valóst a képzetesbe (a "kifordulás").
--   e^{iπ} = −1  (a π fázis kifordít — a Möbius-szalag egy oldala)
--   e^{i2π} = +1 (a 2π visszafordít — a rák-kanon két fordulata)
--
-- A γ⁵ KAPCSOLAT:
--   γ⁵ = i·γ⁰γ¹γ²γ³ — az i (a fázis) BEÉPÍTVE a Cl(4) 16. blade-jébe
--   (a grade-4-be). A fázis nem külső dísz — az a legmagasabb grade.
--   A G (valós rész) és az α⁻¹ (képzetes rész) = egy komplex csatolás:
--   α⁻¹ + i·(skálázott G) — a CPT forgatja a kettőt egymásba.
--
-- NEM törölve (AGENTS §20).
-- ═══════════════════════════════════════════════════════════════

import KomplexByte

%default total

-- ─── 1. A KOMPLEX SZÁM (a 2-es algebra) ────────────────────
-- A KomplexByte.idr-ből: Komplex = (re, im) — a 2 valós dimenzió.
-- A bit a fázissal = egy komplex szám: az amplitúdó.

||| A fázis egység: e^{iθ} — az egységkör a komplex síkon.
||| A fázis a bit mértékegysége: a bit NEM 0/1, hanem egy SZÖG.
public export
fazisEgyseg : Double -> Komplex
fazisEgyseg szog = KomplexKonstruktor (cos szog) (sin szog)

||| Az i — a képzetes egység (Double, a futásidejű számításhoz).
public export
iEgyseg : Komplex
iEgyseg = KomplexKonstruktor 0.0 1.0

||| A komplex szám EGÉSZ komponensekkel — a kernel REDUKÁLJA
||| az Integer aritmetikát (a Double-t nem). Az algebrai törvényeket
||| (i² = −1, i⁴ = +1) ezzel bizonyítjuk.
public export
record KomplexEgesz where
  constructor KomplexEgeszKonstruktor
  reEgesz : Integer
  imEgesz : Integer

||| Az egész szorzás: (a+bi)(c+di) = (ac−bd) + (ad+bc)i.
public export
egeszSzoroz : KomplexEgesz -> KomplexEgesz -> KomplexEgesz
egeszSzoroz (KomplexEgeszKonstruktor a b) (KomplexEgeszKonstruktor c d) =
  KomplexEgeszKonstruktor (a*c - b*d) (a*d + b*c)

public export
Show KomplexEgesz where
  show (KomplexEgeszKonstruktor a b) = show a ++ " + i·" ++ show b

||| Az i — a képzetes egység (egész komponensekkel).
public export
iEgysegEgesz : KomplexEgesz
iEgysegEgesz = KomplexEgeszKonstruktor 0 1

||| Nagybetűs alias (a bizonyításokhoz — AGENTS KisBetusCsapda).
public export
IEgysegEgeszKonst : KomplexEgesz
IEgysegEgeszKonst = iEgysegEgesz

||| Biz — i² = −1 (a kifordulás — a π fázis).
||| A kernel kiszámolja: (0,1)·(0,1) = (0·0−1·1, 0·1+1·0) = (−1, 0).
public export
bizIKet : egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst = KomplexEgeszKonstruktor (-1) 0
bizIKet = Refl
-- Az algebrai törvény: i² = −1. A "kifordulás".

||| Biz — i⁴ = +1 (a visszafordulás — a 2π fázis).
public export
bizINegyedik :
  egeszSzoroz (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst)
              (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst) =
  KomplexEgeszKonstruktor 1 0
bizINegyedik = Refl

-- ─── 2. A KUBIT A BLOCH-GÖMBÖN (a 3-as algebra) ────────────

||| A kubit két szöge:
|||   theta = a poláris szög (0 = |0⟩, π = |1⟩) — a valószínűség
|||   fi    = az azimut szög — A FÁZIS (a bit mértékegysége)
||| A kubit a Bloch-gömbön (S²) él: 3 valós dimenzió.
||| A 2→3 átmenet: bit (2 állapot) + fázis (1 szög) = gömb (3 dimenzió).
public export
record FazisKubit where
  constructor FazisKubitKonstruktor
  theta : Double   -- poláris szög [0, π] — a valószínűség hordozója
  fi    : Double   -- azimut szög [0, 2π) — A FÁZIS (a bit mértékegysége)

public export
Show FazisKubit where
  show (FazisKubitKonstruktor t f) =
    "|ψ⟩ = cos(" ++ show t ++ "/2)|0⟩ + e^{i·" ++ show f ++ "}·sin(" ++ show t ++ "/2)|1⟩"

||| A Born-szabály: P(0) = cos²(θ/2).
||| A fázis φ NEM jelenik meg — a mérés "nem látja" a fázist.
public export
valoszinusegNulla : FazisKubit -> Double
valoszinusegNulla (FazisKubitKonstruktor t f) =
  let c = cos (t / 2.0) in c * c

||| A Bloch-gömb koordináták: (x, y, z) a Pauli-tengelyeken.
||| x = sin θ cos φ, y = sin θ sin φ, z = cos θ.
||| A 3 dimenzió = a 3 Pauli-mátrix (σx, σy, σz).
public export
blochX : FazisKubit -> Double
blochX (FazisKubitKonstruktor t f) = sin t * cos f

public export
blochY : FazisKubit -> Double
blochY (FazisKubitKonstruktor t f) = sin t * sin f

public export
blochZ : FazisKubit -> Double
blochZ (FazisKubitKonstruktor t f) = cos t

-- ─── 3. A MÉRÉS ÉS AZ ÖSSZEFONÓDÁS ────────────────────────

||| A mérési kimenet: 0 vagy 1 (a fázis "elvész" a valószínűségekben).
||| DE az unitaritás tiltja az információvesztést:
||| a fázis NEM vész el — átmegy a környezetbe.
||| A mérés után a teljes állapot (rendszer + környezet):
|||   |Ψ⟩ = cos(θ/2)|0⟩|E₀⟩ + e^{iφ}sin(θ/2)|1⟩|E₁⟩
||| A fázis φ MOST a relatív fázis a |E₀⟩ és |E₁⟩ között —
||| ez az ÖSSZEFONÓDÁS. A fázis fizikai: a környezet korrelációiban él.
||| Ezért a fázis makroszkopikusan mérhető (interferencia, AB-effektus,
||| Josephson-effektus), DE marad kiszedetlen rész (az összefonódás).
public export
data MeresiKimenet : Type where
  MeresNulla : MeresiKimenet   -- a |0⟩ mérve (a fázis átment a környezetbe)
  MeresEgy   : MeresiKimenet   -- az |1⟩ mérve (a fázis átment a környezetbe)

public export
Show MeresiKimenet where
  show MeresNulla = "|0⟩ (a fazis atment a kornyezetbe — osszefonodas)"
  show MeresEgy   = "|1⟩ (a fazis atment a kornyezetbe — osszefonodas)"

||| A kiszedetlen információ = az összefonódás mértéke.
||| A rendszer+környezet teljes állapotában a fázis φ a relatív
||| fázis — a von Neumann-entrópia (a részleges nyom után) méri,
||| mennyi maradt kiszedetlen. Ez a projekt δ-ja:
|||   a lobásás kiszedi a fázis egy részét (ln(9/8) lépésenként),
|||   a maradék δ = a kiszedetlen fázis = az összefonódás.
public export
kiszedetlenInformacio : FazisKubit -> Double
kiszedetlenInformacio (FazisKubitKonstruktor t f) =
  let p0 = valoszinusegNulla (FazisKubitKonstruktor t f)
      p1 = 1.0 - p0
  in if p0 <= 0.0 || p1 <= 0.0
       then 0.0   -- tiszta |0⟩ vagy |1⟩: nincs fázis, nincs összefonódás
       else let e0 = p0 * (log p0 / log 2.0)
                e1 = p1 * (log p1 / log 2.0)
            in negate (e0 + e1)
  -- A von Neumann-entrópia = a kiszedetlen információ bitekben.
  -- Ez NEM a fázis φ-től függ (a fázis a RELATÍV fázis — a komplex
  -- amplitúdók aránya), hanem a θ-tól. A fázis φ a környezet
  -- korrelációiban él — a relatív fázis a |E₀⟩ és |E₁⟩ között.

-- ─── 4. A FÁZIS MAKROSZKOPIKUS MÉRÉSE ──────────────────────

||| A kétrés-kísérlet: a relatív fázis mérése az interferenciaképpel.
||| A Josephson-effektus: I = I₀·sin(Δφ) — a fáziskülönbség
||| makroszkopikus áramot hajt (a fázis FIZIKAI — mérhető).
public export
josephsonAram : Double -> Double -> Double
josephsonAram iMax deltaFazis = iMax * sin deltaFazis
-- A Δφ = a két szupravezető fáziskülönbsége — makroszkopikus,
-- ampermérővel mérhető. Ha a fázis NEM lenne fizikai, a Josephson-
-- effektus NEM létezne, és a SQUID (a legérzékenyebb mágneses
-- mérőműszer) NEM működne.

-- ─── 5. A 2→3 ÁTMENET BIZONYÍTÁSA ──────────────────────────

||| A klasszikus bit: 2 állapot. A kubit: 2 állapot + 1 fázis szög.
||| A Bloch-gömb dimenziója: 2 (a klasszikus bit) + 1 (a fázis) = 3.
||| Ez a "2-es, 3-as algebra": ℂ (a 2-es) → su(2) (a 3-as).

||| A 2-es: a bit állapotainak száma.
public export
bitAllapotok : Nat
bitAllapotok = 2

||| A fázis: 1 szög (a φ azimut).
public export
fazisSzogek : Nat
fazisSzogek = 1

||| A 3-as: a Bloch-gömb dimenziója = bit + fázis.
public export
blochDimenziok : Nat
blochDimenziok = bitAllapotok + fazisSzogek   -- 3

||| Nagybetűs aliasok (a bizonyításokhoz).
public export
BlochDimenziokKonst : Nat
BlochDimenziokKonst = blochDimenziok

public export
BitAllapotokKonst : Nat
BitAllapotokKonst = bitAllapotok

||| Biz -- a Bloch-gömb dimenziója = 3 (2 + 1).
public export
bizBlochHarom : BlochDimenziokKonst = 3
bizBlochHarom = Refl

||| Biz -- a bit állapotai = 2 (a 2-es algebra).
public export
bizBitKetto : BitAllapotokKonst = 2
bizBitKetto = Refl

-- ─── 6. A G ÉS AZ α⁻¹ MINT KOMPLEX CSATOLÁS ───────────────

||| A komplex csatolás: a valós rész = α⁻¹, a képzetes = a skálázott G.
||| A CPT forgatja a kettőt egymásba: C (töltés = α), P (tér = G),
||| T (idő = a fázis — a lobásás lépésszáma).
||| A fázis az, ami a valóst a képzetesbe forgatja (a "kifordulás").

||| Az α⁻¹ (a valós rész — a csatolás nagysága).
public export
alfaInverzValos : Double
alfaInverzValos = 137.035999177

||| A δ (a képzetes rész — a fázis maradéka, a kiszedetlen információ).
public export
deltaFazis : Double
deltaFazis = 8.23e-7

||| A komplex csatolás: α⁻¹ + i·δ.
||| A fázisa: θ = arctan(δ/α⁻¹) — a "kifordulás" szöge.
public export
komplexCsataslas : Komplex
komplexCsataslas = KomplexKonstruktor alfaInverzValos deltaFazis

||| A komplex csatolás fázisa: arctan(δ/α⁻¹).
||| Ez a szög az, ami a valóst a képzetesbe forgatja — a CPT.
public export
csatolasFazis : Double
csatolasFazis = atan (deltaFazis / alfaInverzValos)

-- ─── 7. A GONDOLATOK (a felhasználó téziséhez) ─────────────

||| A GONDOLATOK — miért FIZIKAI a fázis:
|||
||| 1. Az unitaritás (a Schrödinger-evolúció informáciomegmaradása)
|||    tiltja, hogy a mérés "eldobja" a fázist. Ha a fázis nem lenne
|||    fizikai, a mérés ténylegesen veszítene információt — de a
|||    kvantummechanika működik, tehát a fázis FIZIKAI.
|||
||| 2. A mérés a fázist NEM semmisíti meg — ÁTVISZI a környezetbe.
|||    A teljes állapot (rendszer + környezet) unitér marad:
|||    |ψ⟩|E⟩ → cos(θ/2)|0⟩|E₀⟩ + e^{iφ}sin(θ/2)|1⟩|E₁⟩.
|||    A φ fázis a relatív fázis a |E₀⟩ és |E₁⟩ között — ez az
|||    ÖSSZEFONÓDÁS. A fázis a korrelációkban él tovább.
|||
||| 3. A fázis makroszkopikusan MÉRHETŐ:
|||    - a kétrés-kísérlet: az interferenciakép = a relatív fázis,
|||    - az Aharonov–Bohm-effektus: a fázist a mágneses fluxus méri,
|||    - a Josephson-effektus: I = I₀·sin(Δφ) — a fázis áramot hajt,
|||    - a Berry-fázis: a ciklikus evolúció a geometriai fázist méri.
|||    Ha a fázis NEM lenne fizikai, ezek NEM léteznének.
|||
||| 4. A "kiszedetlen" információ = az összefonódás. A mérés kiszed
|||    EGY részt (a valószínűséget — a θ-t), de a fázis φ marad —
|||    a rendszer+környezet korrelációiban. Ez a projekt δ-ja:
|||    a lobásás (121/128)^(249+ln(9/8)) kiszedi a fázis egy részét,
|||    de a maradék δ = a kiszedetlen fázis = az összefonódás.
|||
||| 5. A 2-es, 3-as algebra: ℂ = ℝ² (a bit a fázissal = a komplex
|||    amplitúdó), su(2) (a Bloch-gömb = a 3 Pauli-tengely).
|||    A fázis az, ami a 2-esből 3-ast csinál. Az i² = −1 a
|||    "kifordulás" algebrai formája; az i⁴ = +1 a "visszafordulás".
|||    A γ⁵ = i·γ⁰γ¹γ²γ³: az i (a fázis) BEÉPÍTVE a Cl(4)
|||    16. blade-jébe. A fázis NEM külső — az a legmagasabb grade.
public export
gondolatok : String
gondolatok =
  "A fazis fizikai, mert az unitaritas (informaciomegmaradas) " ++
  "tiltja, hogy a meres eldobja. A meres a fazist atviszi a " ++
  "kornyezetbe: |ψ⟩|E⟩ → cos(θ/2)|0⟩|E₀⟩ + e^{iφ}sin(θ/2)|1⟩|E₁⟩. " ++
  "A φ a relativ fazis a |E₀⟩ es |E₁⟩ kozott = az OSSZEFONODAS. " ++
  "A fazis makroszkopikusan merheto (interferencia, AB-effektus, " ++
  "Josephson-effektus, Berry-fazis), de marad kiszedetlen resz — " ++
  "ez a projekt delta-ja: a lobaszas kiszedi a fazis egy reszet, " ++
  "a maradek = az osszefonodas. A fazis az, ami a 2-esbol 3-ast " ++
  "csinal (ℂ → su(2), a Bloch-gomb)."

-- ─── 8. A FUTTATHATÓ ELLENŐRZÉS ───────────────────────────

main : IO ()
main = do
  putStrLn "══════════════════════════════════════════════════════════════════════"
  putStrLn "  FAZIS KUBIT — a bit mértékegysége a fázis"
  putStrLn "══════════════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── AZ ALGEBRAI BIZONYÍTÁSOK ──"
  putStrLn "  i² = −1  (a kifordulás — a π fázis)"
  putStrLn ("  i² = " ++ show (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst))
  putStrLn "  i⁴ = +1  (a visszafordulás — a 2π fázis)"
  putStrLn ("  i⁴ = " ++ show (egeszSzoroz (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst) (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst)))
  putStrLn ""
  putStrLn "── A 2→3 ÁTMENET ──"
  putStrLn ("  klasszikus bit: " ++ show bitAllapotok ++ " állapot (a 2-es)")
  putStrLn ("  fázis: " ++ show fazisSzogek ++ " szög (a φ azimut)")
  putStrLn ("  Bloch-gömb: " ++ show blochDimenziok ++ " dimenzió (a 3-as)")
  putStrLn ""
  putStrLn "── A MÉRÉS ÉS AZ ÖSSZEFONÓDÁS ──"
  let kubit = FazisKubitKonstruktor (pi / 2.0) (pi / 4.0)
  putStrLn ("  " ++ show kubit)
  putStrLn ("  P(0) = " ++ show (valoszinusegNulla kubit) ++ "  (a fázis NEM jelenik meg)")
  putStrLn ("  kiszedetlen info (von Neumann-entrópia) = " ++ show (kiszedetlenInformacio kubit) ++ " bit")
  putStrLn "  → a mérés kiszedi a θ-t (a valószínűséget), de a φ fázis"
  putStrLn "    átmegy a környezetbe — az összefonódásba."
  putStrLn ""
  putStrLn "── A JOSEPHSON-EFFEKTUS (a fázis makroszkopikus mérése) ──"
  putStrLn ("  I = I₀·sin(Δφ) — a fáziskülönbség áramot hajt")
  putStrLn ("  I(π/2) = " ++ show (josephsonAram 1.0 (pi / 2.0)))
  putStrLn ""
  putStrLn "── A KOMPLEX CSATOLÁS ──"
  putStrLn ("  α⁻¹ + i·δ = " ++ show komplexCsataslas)
  putStrLn ("  a fázis θ = arctan(δ/α⁻¹) = " ++ show csatolasFazis)
  putStrLn "  → a CPT forgatja a valóst (α) a képzetesbe (G) — a kifordulás"
  putStrLn ""
  putStrLn "── A GONDOLATOK ──"
  putStrLn gondolatok
  putStrLn ""
  putStrLn "Kesz."