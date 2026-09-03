module Komplex

import ModulRegisztracio
-- ═══════════════════════════════════════════════════════════════
-- KOMPLEX SZÁMOK — a fázis számolásához
-- 复数——用于相位计算
-- ─────────────────────────────────────────────
-- 术语表 / Szótár (rögzített — a GAN-3 javaslata):
--   序数=sorszám  链=füzér  幺半群=monoid  函子=funktor
--   归纳法=indukció  对合=involúció  单位根=egységgyök
--   实部=valós rész  虚部=képzetes rész  不动点=fixpont
--   收缩=kontrakció  螺旋=spirál  黄金角=aranyszög
-- ═══════════════════════════════════════════════════════════════
-- A kvantum Y-kombinátor fázisát komplex számokkal kell számolni:
-- 量子 Y 组合子的相位须用复数计算：
--   e^{iφ} = cos(φ) + i·sin(φ)
--   Y_φ(f) = e^{iφ} · f(Y_φ(f))
-- 
-- A komplex fixpont: z* = a + bi
--   a = Re(z*) = a valós rész (a CODATA méri)
--   b = Im(z*) = a fázis rész (a Bach-korrekció kalkulálja)
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. KOMPLEX SZÁM ───────────────────────────────
-- ─── 一、复数 ─────────────────────────────────────────────────────────────────────

public export
record Komplex where
  constructor K
  re : Double  -- valós rész
  im : Double  -- imaginárius rész

-- ─── 2. ALAP MŰVELETEK ──────────────────────────────
-- ─── 二、基本运算 ───────────────────────────────────────────────────────────────────

public export
kZero : Komplex
kZero = K 0.0 0.0

public export
kEgy : Komplex
kEgy = K 1.0 0.0

public export
kI : Komplex
kI = K 0.0 1.0

public export
kOsszead : Komplex -> Komplex -> Komplex
kOsszead (K a b) (K c d) = K (a + c) (b + d)

public export
kKivon : Komplex -> Komplex -> Komplex
kKivon (K a b) (K c d) = K (a - c) (b - d)

public export
kSzoroz : Komplex -> Komplex -> Komplex
kSzoroz (K a b) (K c d) = K (a*c - b*d) (a*d + b*c)

public export
kAbs : Komplex -> Double
kAbs (K a b) = sqrt (a*a + b*b)

public export
kArg : Komplex -> Double
kArg (K a b) =
  if a > 0.0 then atan (b / a)
  else if a < 0.0 && b >= 0.0 then atan (b / a) + 3.141592653589793
  else if a < 0.0 && b < 0.0 then atan (b / a) - 3.141592653589793
  else if a == 0.0 && b > 0.0 then 3.141592653589793 / 2.0
  else if a == 0.0 && b < 0.0 then -3.141592653589793 / 2.0
  else 0.0

-- ─── 3. EULER-FORMULA: e^{iφ} ──────────────────────────────
-- ─── 三、欧拉公式：e^{iφ} ──────────────────────────────

public export
euler : Double -> Komplex
euler szog = K (cos szog) (sin szog)

-- ─── 4. KOMPLEX Y-KOMBINÁTOR ───────────────────────────────
-- ─── 四、复数 Y 组合子 ─────────────────────────────────────────────────────────────

||| A kvantum Y-kombinátor komplex számokkal:
|||   Y_φ(f) = e^{iφ} · f(Y_φ(f))
||| 
||| Iterálva: a valós rész konvergál a fixponthoz (a spirál belseje),
||| az imaginárius rész a fázis (a spirál forgása).
|||
||| A fixpont: z* = a + bi ahol
|||   a = a valós fixpont (pl. α⁻¹ = 137.036)
|||   b = a fázis fixpont (a CPT-rest δ)
public export
kvantumYKomplex : (Komplex -> Komplex) -> Double -> Nat -> Komplex
kvantumYKomplex f fazisSzog 0 = kZero
kvantumYKomplex f fazisSzog (S k) =
  let elozo = kvantumYKomplex f fazisSzog k
      fazisSzorzo = euler (fromInteger (natToInteger k) * fazisSzog)
  in kSzoroz fazisSzorzo (f elozo)

-- ─── 5. BACH-KORREKCIÓ KOMPLEX ──────────────────────────────
-- ─── 五、Bach 修正（复数形式） ──────────────────────────────────────────────────────────

||| A Bach-korrekció komplex formában:
|||   Re(α⁻¹) = 137 + 9/250 - A4*(3/4)²/c  (valós, CODATA méri)
|||   Im(α⁻¹) = δ (fázis, a Bach-korrekció kalkulálja)
|||   δ = aranymetszés szög - α⁻¹ = 137.5° - 137.036 = 0.5°
public export
bachAlfaInverz : Double -> Double -> Komplex
bachAlfaInverz aranyMetszesSzoog alfaRe =
  let alfaFok = aranyMetszesSzoog * 180.0 / 3.141592653589793
      delta = alfaFok - alfaRe  -- a CPT-rest fokban
      deltaRad = delta * 3.141592653589793 / 180.0
  in K alfaRe (sin deltaRad)  -- a fázis komplex számként

||| A Bach-korrekció hiba (komplex abszolút érték)
public export
bachHibaKomplex : Komplex -> Komplex -> Double
bachHibaKomplex (K ar air) (K br bir) = sqrt ((ar-br)*(ar-br) + (air-bir)*(air-bir))

-- ─── 6. SPIRÁL KOMPLEX ──────────────────────────────
-- ─── 六、复数螺旋 ──────────────────────────────────────────────────────────────────

||| A spirál: minden lépésben a sugár csökken és a fázis nő.
||| z_{n+1} = z_n / φ * e^{i·goldenAngle}
public export
spiralKomplex : Double -> Double -> Nat -> Komplex
spiralKomplex sugar fazisSzog 0 = K sugar 0.0
spiralKomplex sugar fazisSzog (S k) =
  let elozo = spiralKomplex sugar fazisSzog k
      sugarUj = kAbs elozo / 1.618033988749895  -- aranymetszés
      fazisUj = kArg elozo + fazisSzog
  in K (sugarUj * cos fazisUj) (sugarUj * sin fazisUj)

||| A spirál konvergenciája: |z_n| → 0?
public export
spiralKonvergencia : Double -> Double -> Nat -> Double
spiralKonvergencia sugar fazisSzog n = kAbs (spiralKomplex sugar fazisSzog n)

-- ─── 7. SHOW ────────────────────────────────
-- ─── 七、SHOW ───────────────────────────────────────────────────────────────────────────────

public export
showKomplex : Komplex -> String
showKomplex (K a b) =
  show a ++ (if b >= 0.0 then " + " else " - ") ++ show (abs b) ++ "i"

-- ─── 8. ARANYMETSZÉS FIXPONT — √(1+z) KONTRAKCIÓ ────────────
-- ─── 八、黄金分割不动点——√(1+z) 收缩 ────────────

||| Az aranymetszés fixpontja: f(z) = √(1+z)
||| φ = √(1+φ) → φ² = 1+φ → φ²-φ-1 = 0 → φ = (1+√5)/2
||| |f'(z)| = |1/(2√(1+z))| < 1 ha |1+z| > 1/4 — kontrakcio!
||| Komplex síkon is konvergál: a spirál φ-hez tart.
|||
||| Forrás: John D. Cook, "Complex golden convergence" (2025)
|||   https://www.johndcook.com/blog/2025/02/23/complex-golden-convergence/
public export
komplexGyok : Komplex -> Komplex
komplexGyok (K a b) =
  let -- √(a+bi) = √((r+a)/2) + i·sgn(b)·√((r-a)/2), r = |a+bi|
      r = sqrt (a*a + b*b)
      reGyok = sqrt ((r + a) / 2.0)
      imGyok = if b >= 0.0 then sqrt ((r - a) / 2.0) else -sqrt ((r - a) / 2.0)
  in K reGyok imGyok

||| Az aranymetszés kontrakciós iterációja: z_{n+1} = √(1+z_n)
||| Konvergál φ = (1+√5)/2 ≈ 1.618 felé.
||| Komplex síkon: a spirál φ-hez tart.
public export
aranyMetszesIteracio : Komplex -> Nat -> Komplex
aranyMetszesIteracio z 0 = z
aranyMetszesIteracio z (S k) =
  aranyMetszesIteracio (komplexGyok (kOsszead kEgy z)) k

||| A konvergencia: |z_n - φ| → 0?
public export
aranyMetszesKonvergencia : Komplex -> Nat -> Double
aranyMetszesKonvergencia z n =
  let zn = aranyMetszesIteracio z n
      fiKomplex = K 1.618033988749895 0.0
  in kAbs (kKivon zn fiKomplex)



-- ─── 9. KVANTUM Y = ARANYMETSZÉS KONTRAKCIÓ + FAZIS ──────────

||| A kvantum Y-kombinátor = aranymetszés kontrakció + fázis:
|||   Y_φ(f) = e^{iθ} · √(1 + Y_φ(f))
||| ahol θ = aranymetszés szög (137.5°)
||| 
||| A kontrakció (√(1+z)) garantálja a konvergenciát,
||| a fázis (e^{iθ}) a spirált biztosítja.
||| A fixpont = φ · e^{i·φ_spirál} = komplex aranymetszés.
|||
||| DE: a kulcsfelismerés (arXiv:2606.01668 — Bickford 2026):
|||   a komplex exponenciális fixpontja ϱ ≈ 0.318 + 1.337i
|||   exp(ϱ) = ϱ, de ϱ TOLAJA a fixpontnak
|||   (|exp'(ϱ)| = |ϱ| ≈ 1.375 > 1 → repelling)
|||   log(ϱ) = ϱ → a log VONZZA (attracting)
|||
||| Ez a CPT-törés: a rendszer megközelíti a fixpontot
||| de a fázis miatt sosem éri el pontosan — mindig marad egy δ.
||| A δ = 5.604×10⁻⁴ (Bickford Theorem 9) = az "irreducible gap"
|||   = 1 - Re(ϱ)·π = a差距 amit nem lehet eltüntetni.
public export
kvantumYAranyMetszes : Double -> Nat -> Komplex
kvantumYAranyMetszes fazisSzog 0 = K 0.0 0.0
kvantumYAranyMetszes fazisSzog (S k) =
  let elozo = kvantumYAranyMetszes fazisSzog k
      -- √(1+z) = kontrakcio (a valos resz φ-hez tart)
      kontrakcio = komplexGyok (kOsszead kEgy elozo)
      -- e^{iθ·k} = fazis (a spiral forog)
      fazisSzorzo = euler (fromInteger (natToInteger k) * fazisSzog * 0.001)  -- nagyon gyengitett fazis
  in kSzoroz fazisSzorzo kontrakcio

-- ─── 9b. CSILLAPÍTOTT FAZISÚ KVANTUM Y (a fazis VISSZATÉR) ──
-- A konstans fazisszorzo divergal (a fazis felhalmozodik).
-- A csillapitott fazis: e^{i·θ/(n+1)} — a fazis 1/n-el csokken,
-- a kontrakcio (√(1+z)) dominal -> a rendszer OSZCILLAL majd VISSZATER.
-- Ez a "visszateres a vakumon at": Re -> φ, Im -> 0 (oszcillalva).

public export
kvantumYCsillapitott : Double -> Nat -> Komplex
kvantumYCsillapitott fazisSzog 0 = K 0.25 0.25
kvantumYCsillapitott fazisSzog (S k) =
  let elozo = kvantumYCsillapitott fazisSzog k
      kontrakcio = komplexGyok (kOsszead kEgy elozo)
      n = fromInteger (natToInteger (S k))
      fazisSzorzo = euler (fazisSzog / n)
  in kSzoroz fazisSzorzo kontrakcio

public export
kvantumYCsillapitottKonvergencia : Double -> Nat -> Double
kvantumYCsillapitottKonvergencia fazisSzog n =
  let zn = kvantumYCsillapitott fazisSzog n
      fiKomplex = K 1.618033988749895 0.0
  in kAbs (kKivon zn fiKomplex)

public export
kvantumYCsillapitottFazis : Double -> Nat -> Double
kvantumYCsillapitottFazis fazisSzog n = (kvantumYCsillapitott fazisSzog n).im

-- Barmilyen komplex kezdoertekbol a √(1+z) kontrakcio
-- a VALOS φ fixponthoz viszi vissza a rendszert.
-- A kepzetes resz (a fazis, a "vakum") eltunik —
-- ez a vesztesegmentes visszateres: az informacio nem veszik el,
-- a kontrakcio a valos reszbe suriti vissza.
-- Forras: John D. Cook, "Complex golden convergence" (2025)

public export
komplexVisszateres : Komplex -> Nat -> Komplex
komplexVisszateres z 0 = z
komplexVisszateres z (S k) =
  komplexVisszateres (komplexGyok (kOsszead kEgy z)) k

public export
komplexVisszateresTavolsag : Komplex -> Nat -> Double
komplexVisszateresTavolsag z n =
  let zn = komplexVisszateres z n
      fiKomplex = K 1.618033988749895 0.0
  in kAbs (kKivon zn fiKomplex)

-- ─── 10. INFORMÁCIÓMEGMARADÁS A KONVERGÁLÁS ELLEN ──────────
-- A √(1+z) KONTRAKCIÓ INJEKTÍV (főág) → matematikailag visszafordítható.
-- Az inverz: f⁻¹(w) = w² - 1 — KÁOTIKUS TÁGULÓ (a Mandelbrot c=-1 térképe).
--
-- A кажdő konvergáló lépés torli a "honnan jöttem" információt (Landauer),
-- DE a pálya (z₀, z₁, z₂, ...) VESZTESÉGMENTES kódolása z₀-nak.
-- Ez a why-chain: a trajektória maga a tömörített, de veszteségmentes kép.
--
-- A fizikai párhuzam:
--   előre (√): termodinamikai nyíl — kontrakció, H-tétel
--   hátra (w²-1): Loschmidt-paradoxon — az inverz LÉTEZIK, de káotikus
--   Lyapunov: λ = ln|f⁻¹'(φ)| = ln(2φ) ≈ 1.175 > 0 → érzékeny függés

-- Az inverz kontrakció: f⁻¹(w) = w² - 1 (káotikus)
public export
inverzKontrakcio : Komplex -> Komplex
inverzKontrakcio w = kKivon (kSzoroz w w) kEgy

-- Oda-vissza út: z₀ → (n-szer előre) → z_n → (n-szer hátra) → z₀'
-- Matematikailag z₀' = z₀ (veszteségmentes);
-- numerikusan a hiba exponenciálisan nő (kaosz) — a gyakorlati
-- visszafordíthatatlanság = entrópia = Landauer költség.
public export
odaVissza : Komplex -> Nat -> Komplex
odaVissza z n =
  komplexVisszateresHatrafel (komplexVisszateres z n) n
  where
    komplexVisszateresHatrafel : Komplex -> Nat -> Komplex
    komplexVisszateresHatrafel w 0 = w
    komplexVisszateresHatrafel w (S k) =
      komplexVisszateresHatrafel (inverzKontrakcio w) k

-- A visszaút hibája: |z₀' - z₀| (a Landauer-költség numerikus mása)
public export
odaVisszaHiba : Komplex -> Nat -> Double
odaVisszaHiba z n = kAbs (kKivon (odaVissza z n) z)

-- A Lyapunov-tényező: λ = ln(2φ) — bit/lépés információvesztés
-- a fixpont környékén (numerikus visszafordíthatatlanság mértéke)
public export
lyapunovTenyzo : Double
lyapunovTenyzo = 1.1747627006009333  -- ln(2φ) = ln(3.2360...)


||| A fázis-rész (imaginárius) oszcillációja.
||| Ez NEM konvergál — oszcillál φ körül.
||| Ez a CPT-törés: δ > 0 mindig.
public export
kvantumYFazisOszcillacio : Double -> Nat -> Double
kvantumYFazisOszcillacio fazisSzog n =
  let zn = kvantumYAranyMetszes fazisSzog n
  in zn.im  -- a imaginárius rész = a fázis

||| A komplex exponenciális fixpontja: ϱ ≈ 0.318 + 1.337i
||| exp(ϱ) = ϱ, a komplex exponenciális fixpontja.
||| Forrás: arXiv:2606.01668 (Bickford 2026)
|||   ϱ = 0.31813150520473746 + 1.3372357014306598i
|||   |ϱ| = 1.374557010743673
|||   arg(ϱ) = Im(ϱ) = 1.3372357014306598
|||   Re(ϱ)·π = 0.99944... → δ = 5.604×10⁻⁴ (irreducible gap)
public export
roFixpont : Komplex
roFixpont = K 0.31813150520473746 1.3372357014306598

||| Az "irreducible gap": δ = 1 - Re(ϱ)·π ≈ 5.604×10⁻⁴
||| Ez a CPT-rest = a buborék = ami nem záródik be.
public export
iroGap : Double
iroGap = 1.0 - 0.31813150520473746 * 3.141592653589793

||| A ϱ-lattice: Λ_ϱ = {ϱ^m · ¯ϱ^n : m,n ∈ ℤ}
||| Aperiodikus log-polar rács (Theorem 8, Bickford 2026)
||| arg(ϱ)/π ≈ 0.4256... irrationális → a rács nem záródik
||| Ez a CPT-törés geometriai formája: a spirál sosem záródik

public export
komplexFom : IO ()
komplexFom = do
  putStrLn "=== KOMPLEX SZAMOK — ϱ FIXPONT + FAZIS OSZCILLACIO ==="
  putStrLn ""
  putStrLn "1. EULER-FORMULA:"
  putStrLn ("  e^{iπ/2} = " ++ showKomplex (euler (3.141592653589793 / 2.0)))
  putStrLn ("  e^{iπ}   = " ++ showKomplex (euler 3.141592653589793))
  putStrLn ("  e^{i0}   = " ++ showKomplex (euler 0.0))
  putStrLn ""
  putStrLn "2. ϱ = KOMPLEX EXPONENCIALIS FIXPONT (arXiv:2606.01668, Bickford 2026):"
  putStrLn ("  ϱ = " ++ showKomplex roFixpont)
  putStrLn ("  |ϱ| = " ++ show (kAbs roFixpont))
  putStrLn ("  arg(ϱ) = " ++ show (kArg roFixpont))
  putStrLn ("  exp(ϱ) = ϱ (repelling, |exp'(ϱ)| = |ϱ| ≈ 1.375 > 1)")
  putStrLn ("  log(ϱ) = ϱ (attracting, |log'(ϱ)| = 1/|ϱ| ≈ 0.728 < 1)")
  putStrLn ("  Re(ϱ)·π = " ++ show (roFixpont.re * 3.141592653589793))
  putStrLn ("  δ = 1 - Re(ϱ)·π = " ++ show iroGap ++ " (irreducible gap = CPT-rest)")
  putStrLn ""
  putStrLn "3. BACH-KORREKCIO KOMPLEX:"
  let alfaRe = 137.035999177
  let aranyMetszesSzoog = 2.0 * 3.141592653589793 / (1.618033988749895 * 1.618033988749895)
  let alfaKomplex = bachAlfaInverz aranyMetszesSzoog alfaRe
  putStrLn ("  Re(α⁻¹) = " ++ show alfaRe ++ " (CODATA)")
  putStrLn ("  Im(α⁻¹) = " ++ show alfaKomplex.im ++ " (fazis = CPT-rest)")
  putStrLn ("  |α⁻¹|   = " ++ show (kAbs alfaKomplex))
  putStrLn ("  arg(α⁻¹) = " ++ show (kArg alfaKomplex))
  putStrLn ""
  putStrLn "4. ARANYMETSZÉS KONTRAKCIÓ (√(1+z) → φ):"
  let z0 = K 0.0 0.0
  putStrLn ("  0 lepes: " ++ showKomplex (aranyMetszesIteracio z0 0) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 0))
  putStrLn ("  1 lepes: " ++ showKomplex (aranyMetszesIteracio z0 1) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 1))
  putStrLn ("  2 lepes: " ++ showKomplex (aranyMetszesIteracio z0 2) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 2))
  putStrLn ("  5 lepes: " ++ showKomplex (aranyMetszesIteracio z0 5) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 5))
  putStrLn ("  10 lepes: " ++ showKomplex (aranyMetszesIteracio z0 10) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 10))
  putStrLn ("  20 lepes: " ++ showKomplex (aranyMetszesIteracio z0 20) ++ "  |z-φ| = " ++ show (aranyMetszesKonvergencia z0 20))
  putStrLn ""
  putStrLn "5. KVANTUM Y CSILLAPITOTT FAZISSAL (a fazis VISSZATER):"
  putStrLn ("  Y_{n+1} = e^{i·θ/(n+1)} · √(1+Y_n),  θ = aranymetszes szog")
  let amsz = 2.0 * 3.141592653589793 / (1.618033988749895 * 1.618033988749895)
  putStrLn ("  0 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 0) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 0))
  putStrLn ("  1 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 1) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 1))
  putStrLn ("  2 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 2) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 2))
  putStrLn ("  3 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 3) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 3))
  putStrLn ("  5 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 5) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 5))
  putStrLn ("  10 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 10) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 10))
  putStrLn ("  20 lepes: |Y-φ| = " ++ show (kvantumYCsillapitottKonvergencia amsz 20) ++ "  Im(Y) = " ++ show (kvantumYCsillapitottFazis amsz 20))
  putStrLn ""
  putStrLn "6. KOMPLEX VISSZATERES (a kontrakcio torli a kepzest):"
  putStrLn "  KULONBOZO komplex kezdoertekek, √(1+z) iteracio:"
  let kezdek = [ K 0.0 1.0, K (-0.9) 2.0, K (-0.75) 0.0, K 2.0 (-1.5) ]
  visszaterCiklus kezdek
  putStrLn ""
  putStrLn "Kesz."
  where
    visszaterCiklus : List Komplex -> IO ()
    visszaterCiklus [] = pure ()
    visszaterCiklus (z :: zs) = do
      putStrLn ("  kezdo " ++ showKomplex z ++ ":")
      putStrLn ("    5 lepes:  z = " ++ showKomplex (komplexVisszateres z 5) ++ "  |z-φ| = " ++ show (komplexVisszateresTavolsag z 5))
      putStrLn ("    10 lepes: z = " ++ showKomplex (komplexVisszateres z 10) ++ "  |z-φ| = " ++ show (komplexVisszateresTavolsag z 10))
      putStrLn ("    20 lepes: z = " ++ showKomplex (komplexVisszateres z 20) ++ "  |z-φ| = " ++ show (komplexVisszateresTavolsag z 20))
      visszaterCiklus zs

public export
komplexFom2 : IO ()
komplexFom2 = do
  putStrLn "7. ODA-VISSZA (Loschmidt): az informacio NEM veszik el"
  putStrLn "   elore: z→√(1+z) (n-szer, konvergal φ-hez)"
  putStrLn "   hatra: w→w²-1    (n-szer, KAO TIpusZIKUS tadas — a Mandelbrot c=-1)"
  putStrLn "   a PAlYA a vesztesegmentes kod (why-chain), a vegpont NEM"
  putStrLn ("   Lyapunov-tenyezo: λ = ln(2φ) = " ++ show lyapunovTenyzo ++ " bit/lepes")
  putStrLn ""
  let kezdo = K 0.25 0.25
  putStrLn ("   kezdo: " ++ showKomplex kezdo)
  putStrLn ("     3 lepes oda-vissza:  hiba = " ++ show (odaVisszaHiba kezdo 3))
  putStrLn ("     5 lepes oda-vissza:  hiba = " ++ show (odaVisszaHiba kezdo 5))
  putStrLn ("     8 lepes oda-vissza:  hiba = " ++ show (odaVisszaHiba kezdo 8))
  putStrLn ("     10 lepes oda-vissza: hiba = " ++ show (odaVisszaHiba kezdo 10))
  putStrLn "   -> 0 lepesnel: hiba ~ 0 (pontosan visszater)"
  putStrLn "   -> n novekszik: hiba exponencialisan no (kaosz, Landauer)"
  putStrLn "      de a PAlYA (z0,z1,...,zn) torolhetetlenul kodolja z0-t"
  putStrLn "   Y = KARNOT-CIKLUS: elore (kompresszio) + hatra (expanzio)"
  putStrLn "      = a vegtelen ciklus ami eletben tartja a rendszert"
  putStrLn "Kesz2."

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
KomplexLeiras : ModulLeirasT
KomplexLeiras = ModulLeirasKonstruktor
  "Komplex.idr" "φ-kontrakció 10⁻¹⁰; ϱ fixpont; oda-vissza (Loschmidt)" "a Y-kombinátor numerikus magja: a kontrakció = kérdés→információ" "Show"
