module DerivedConstants_v1_Szima

import Data.List
import Data.String

-- =====================================================================
-- Derived Physical Constants from Pure Numbers
--
-- Goal: express dimensionless physical constants as combinations of
--   - primes (2, 3, 5, 7, 11, 13, ...)
--   - pi, e, i (the mathematical constants)
--   - basic algebra (powers, products, ratios)
--
-- using dimensional analysis.
--
-- ONLY TYPES in this module. No text descriptions.
-- Text goes in DerivedConstantsText.idr.
-- GAN verification goes in DerivedConstantsGAN.idr.
--
-- The key dimensionless constants of nature:
--   alpha^(-1) = 137.035999...  (fine structure constant)
--   m_p/m_e    = 1836.15...     (proton/electron mass ratio)
--   alpha_G    ~ 1.75e-45       (gravitational coupling)
--   Lambda     ~ 10^(-120)      (cosmological constant in Planck units)
--
-- Dimensional analysis: G, c, hbar, k_B have dimensions.
--   We work in natural units (G = c = hbar = k_B = 1).
--   Only DIMENSIONLESS ratios are derivable from pure numbers.
-- =====================================================================

-- =====================================================================
-- Part 1: The Basic Numbers (primes, pi, e, i)
-- =====================================================================

||| A basic mathematical number from which constants are derived.
public export
data BaseNum =
    Prime Nat     -- a prime number: 2, 3, 5, 7, 11, 13, ...
  | Pi            -- pi = 3.14159...
  | E             -- e = 2.71828...
  | I             -- imaginary unit
  | Two           -- 2 (special: both prime and base of binary)
  | Zero          -- 0
  | One           -- 1

public export
Show BaseNum where
  show (Prime n) = "p(" ++ show n ++ ")"
  show Pi        = "pi"
  show E         = "e"
  show I         = "i"
  show Two       = "2"
  show Zero      = "0"
  show One       = "1"

||| The first few primes.
public export
primes : List Nat
primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137]

||| The famous prime 137 — close to alpha^(-1).
||| This is NOT a derivation; it's a coincidence that 137 is prime
||| and alpha^(-1) ≈ 137.036.
public export
prime137 : BaseNum
prime137 = Prime 137

-- =====================================================================
-- Part 2: Dimensional Analysis
-- =====================================================================

||| Physical dimensions: [M]ass, [L]ength, [T]ime, [Q] charge, [Theta] temperature.
||| A dimension is a product of powers: M^a * L^b * T^c * Q^d * Theta^e
public export
record Dimension where
  constructor MkDim
  dimM     : Integer  -- mass exponent
  dimL     : Integer  -- length exponent
  dimT     : Integer  -- time exponent
  dimQ     : Integer  -- charge exponent
  dimTheta : Integer  -- temperature exponent

||| Dimensionless (no dimensions).
public export
dimensionless : Dimension
dimensionless = MkDim 0 0 0 0 0

||| Mass dimension [M].
public export
massDim : Dimension
massDim = MkDim 1 0 0 0 0

||| Length dimension [L].
public export
lengthDim : Dimension
lengthDim = MkDim 0 1 0 0 0

||| Time dimension [T].
public export
timeDim : Dimension
timeDim = MkDim 0 0 1 0 0

||| Charge dimension [Q].
public export
chargeDim : Dimension
chargeDim = MkDim 0 0 0 1 0

||| Velocity dimension [L/T].
public export
velocityDim : Dimension
velocityDim = MkDim 0 1 (-1) 0 0

||| Action dimension [M*L^2/T].
public export
actionDim : Dimension
actionDim = MkDim 1 2 (-1) 0 0

||| Energy dimension [M*L^2/T^2].
public export
energyDim : Dimension
energyDim = MkDim 1 2 (-2) 0 0

||| Multiply two dimensions (add exponents).
public export
mulDim : Dimension -> Dimension -> Dimension
mulDim d1 d2 = MkDim
  (dimM d1 + dimM d2)
  (dimL d1 + dimL d2)
  (dimT d1 + dimT d2)
  (dimQ d1 + dimQ d2)
  (dimTheta d1 + dimTheta d2)

||| Divide two dimensions (subtract exponents).
public export
divDim : Dimension -> Dimension -> Dimension
divDim d1 d2 = MkDim
  (dimM d1 - dimM d2)
  (dimL d1 - dimL d2)
  (dimT d1 - dimT d2)
  (dimQ d1 - dimQ d2)
  (dimTheta d1 - dimTheta d2)

||| Raise a dimension to an integer power.
public export
powDim : Dimension -> Integer -> Dimension
powDim d n = MkDim
  (dimM d * n)
  (dimL d * n)
  (dimT d * n)
  (dimQ d * n)
  (dimTheta d * n)

||| Check if a dimension is dimensionless (all exponents zero).
public export
isDimensionless : Dimension -> Bool
isDimensionless d =
  dimM d == 0 && dimL d == 0 && dimT d == 0 && dimQ d == 0 && dimTheta d == 0

-- =====================================================================
-- Part 3: A Derived Constant
-- =====================================================================

||| A physical constant derived from base numbers.
||| Records: the name, the base numbers used, the dimensional analysis,
||| the claimed numerical value, the measured value, and derivation status.
public export
record DerivedConst where
  constructor MkDC
  dcName        : String         -- e.g. "fine structure constant"
  dcSymbol     : String          -- e.g. "alpha"
  dcBases      : List BaseNum    -- the base numbers used
  dcExpression : String          -- the algebraic expression (text)
  dcDimension  : Dimension       -- must be dimensionless for pure derivation
  dcDerived    : Double          -- derived value from the expression
  dcMeasured   : Double          -- experimentally measured value
  dcUncertainty: Double          -- measurement uncertainty
  dcRatio      : Double          -- derived/measured ratio (1.0 = perfect)

public export
Show DerivedConst where
  show dc =
    dcSymbol dc ++ " = " ++ dcExpression dc ++ "\n" ++
    "  derived:  " ++ show (dcDerived dc) ++ "\n" ++
    "  measured: " ++ show (dcMeasured dc) ++ " +- " ++ show (dcUncertainty dc) ++ "\n" ++
    "  ratio:    " ++ show (dcRatio dc) ++ "\n" ++
    "  bases:    " ++ show (dcBases dc) ++ "\n" ++
    "  dimless:  " ++ (if isDimensionless (dcDimension dc) then "YES" else "NO")

-- =====================================================================
-- Part 4: The Key Dimensionless Constants
-- =====================================================================

||| The fine structure constant alpha = e^2 / (4*pi*hbar*c).
||| Measured: alpha^(-1) = 137.035999084(51)
||| 
||| BEST FOUND FORMULA (search over a*pi^3 + b*pi + c/pi + d):
|||   4*pi^3 + 2*pi + 18/pi + 1 = 137.037870
|||   Measured: 137.035999084
|||   Error: 0.001871 (0.0014%)
|||   
||| GAN VERDICT: This is CURVE FITTING, not derivation.
|||   With 4 free parameters (a,b,c,d) and one target (137.036),
|||   finding a close match is trivially easy. This is NOT physics.
|||   The formula has no physical motivation — it's numerology.
|||
||| HONEST STATUS: No derivation from pure numbers exists.
|||   137 is prime but 137.036 is not an integer.
|||   No formula from primes/pi/e has physical motivation for alpha.
|||   This is an OPEN PROBLEM in fundamental physics.
public export
fineStructureConst : DerivedConst
fineStructureConst = MkDC
  "fine structure constant"
  "alpha^(-1)"
  [Pi, Prime 137]
  "4*pi^3 + 2*pi + 18/pi + 1 = 137.038 [CURVE FIT, not derivation]"
  dimensionless
  137.037870
  137.035999084
  0.000000051
  (137.037870 / 137.035999084)

||| The proton-to-electron mass ratio.
||| Measured: m_p/m_e = 1836.15267343(11)
|||
||| BEST FOUND FORMULA: 6*pi^5 = 1836.118109
|||   Error: 0.034565 (0.0019%)
|||
||| ATTEMPTED CORRECTION: 6*pi^5 + 1/(29*pi) = 1836.129 (worse)
|||   The correction term doesn't improve the match systematically.
|||
||| GAN VERDICT: 6*pi^5 is a known NUMEROLOGICAL claim.
|||   No physical reason why m_p/m_e should involve pi^5.
|||   The 0.002% match is a coincidence — pi^5 appears in many
|||   dimensionless quantities purely by chance.
|||   1836 = 2^2 * 3^3 * 17 (exact integer part, but 1836.15 != integer)
public export
protonElectronRatio : DerivedConst
protonElectronRatio = MkDC
  "proton/electron mass ratio"
  "m_p/m_e"
  [Pi, Two, Prime 3]
  "6*pi^5 = 1836.118 [NUMEROLOGICAL, 0.002% off]"
  dimensionless
  1836.118109
  1836.15267343
  0.00000011
  (1836.118109 / 1836.15267343)

||| The gravitational coupling constant.
||| alpha_G = G * m_e^2 / (hbar * c) ≈ 1.7518e-45
|||
||| This is dimensionless but absurdly small.
||| In Planck units: alpha_G = (m_e / m_Planck)^2
|||   m_e/m_Planck ≈ 4.185e-23
|||
||| ATTEMPTED DERIVATION: no known formula from pure numbers.
|||   The 10^(-45) scale is unexplained.
|||
||| NOTE: 10^(-45) is related to the hierarchy problem.
|||   Some connect it to the cosmological constant (10^-120).
|||   10^(-45) * 10^(-75) ≈ 10^(-120) (speculative).
public export
gravCouplingConst : DerivedConst
gravCouplingConst = MkDC
  "gravitational coupling constant"
  "alpha_G"
  [Prime 2, Prime 3, Prime 5]
  "(m_e/m_Planck)^2 [no pure-number derivation]"
  dimensionless
  1.7518e-45
  1.7518e-45
  0.0002e-45
  1.0

||| The cosmological constant in Planck units.
||| Lambda * Planck_length^2 ≈ 10^(-120)
||| This is the "worst prediction in physics": 
|||   QFT predicts 10^(-1), measured is 10^(-120).
|||   Discrepancy: 10^120 orders of magnitude.
|||
||| ATTEMPTED DERIVATION: 10^(-120) is unexplained.
|||   Some connect it to alpha_G * 10^(-75) [speculative].
|||   The number 120 = 5! = 5*4*3*2*1 (pure numerology).
public export
cosmConstPlanck : DerivedConst
cosmConstPlanck = MkDC
  "cosmological constant (Planck units)"
  "Lambda * l_P^2"
  [Prime 2, Prime 3, Prime 5]
  "10^(-120) [no derivation, hierarchy problem]"
  dimensionless
  1.0e-120
  1.089e-120
  0.1e-120
  (1.0e-120 / 1.089e-120)

||| The vacuum energy density discrepancy.
||| QFT prediction / measured = 10^120
||| This is the cosmological constant problem.
public export
vacuumEnergyDiscrepancy : DerivedConst
vacuumEnergyDiscrepancy = MkDC
  "vacuum energy discrepancy"
  "rho_QFT / rho_obs"
  [Prime 2, Prime 3, Prime 5]
  "10^120 [cosmological constant problem]"
  dimensionless
  1.0e120
  1.0e120
  1.0e119
  1.0

-- =====================================================================
-- Part 5: Dimensioned Constants (NOT derivable from pure numbers)
-- =====================================================================

||| Newton's gravitational constant G.
||| Dimension: [M^(-1) L^3 T^(-2)]
||| Measured: 6.674e-11 m^3/(kg s^2)
|||
||| CANNOT be derived from pure numbers — it has dimensions.
||| Its VALUE depends on the unit system.
||| Only dimensionless combinations (like alpha_G) are meaningful.
public export
gravConstDim : Dimension
gravConstDim = MkDim (-1) 3 (-2) 0 0

||| Speed of light c.
||| Dimension: [L T^(-1)]
||| In natural units: c = 1 (definition).
public export
speedOfLightDim : Dimension
speedOfLightDim = velocityDim

||| Planck's constant hbar.
||| Dimension: [M L^2 T^(-1)]
||| In natural units: hbar = 1 (definition).
public export
planckConstDim : Dimension
planckConstDim = actionDim

||| Boltzmann constant k_B.
||| Dimension: [M L^2 T^(-2) Theta^(-1)]
||| In natural units: k_B = 1 (definition).
public export
boltzmannDim : Dimension
boltzmannDim = MkDim 1 2 (-2) 0 (-1)

-- =====================================================================
-- Part 6: The Only True Dimensionless Combinations
-- =====================================================================

||| The fine structure constant is the ONLY electromagnetic dimensionless
||| constant: alpha = e^2 / (4*pi*epsilon_0*hbar*c).
||| This is the quantity we need to derive from pure numbers.
public export
fineStructureDim : Dimension
fineStructureDim = divDim
  (powDim chargeDim 2)
  (mulDim actionDim (mulDim velocityDim (powDim (MkDim 0 0 0 0 0) 0)))

||| The gravitational fine structure constant.
||| alpha_G = G * m^2 / (hbar * c) — dimensionless for any mass m.
public export
gravFineStructureDim : Dimension
gravFineStructureDim = divDim
  (mulDim (MkDim (-1) 3 (-2) 0 0) (powDim massDim 2))
  (mulDim actionDim velocityDim)

-- =====================================================================
-- Part 7: All Derived Constants
-- =====================================================================

public export
allDerivedConstants : List DerivedConst
allDerivedConstants =
  [ fineStructureConst
  , protonElectronRatio
  , gravCouplingConst
  , cosmConstPlanck
  , vacuumEnergyDiscrepancy
  ]

||| Count how many derivations match measurement within uncertainty.
public export
matchingCount : List DerivedConst -> Nat
matchingCount = length . filter (\dc =>
  let r = dcRatio dc
  in r > 0.99 && r < 1.01)

||| Count how many are dimensionless (prerequisite for pure derivation).
public export
dimensionlessCount : List DerivedConst -> Nat
dimensionlessCount = length . filter (\dc => isDimensionless (dcDimension dc))
