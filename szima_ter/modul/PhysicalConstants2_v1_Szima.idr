module PhysicalConstants2_v1_Szima

import Data.String

-- =====================================================================
-- Physical Constants as Scaling Exponents / Input Parameters
--
-- In the quantum-gravity theory of learning:
--   Each physical constant is a SCALING EXPONENT that determines
--   how the memory manifold evolves under learning.
--
--   G  → gravitational coupling = learning rate (how fast associations form)
--   c  → speed of light = max association propagation speed
--   ℏ  → Planck's constant = quantum of information (Bekenstein: I=E=m)
--   k_B → Boltzmann's constant = thermal noise in memory surface QFT
--   Λ  → cosmological constant = forgetting rate
--   ℓ_P → Planck length = minimum memory resolution
--   t_P → Planck time = minimum learning step
--   S  → entropy = Bekenstein-Hawking bound (S = A/4G)
--
-- All values in natural units where convenient, with SI values for reference.
-- Each constant is an INPUT PARAMETER that scales the system.
-- =====================================================================

||| A physical constant with its value, units, and role in the theory.
public export
record PhysConst where
  constructor MkPC
  pcName   : String
  pcSymbol : String
  pcValue  : Double       -- SI value (or natural units where noted)
  pcUnits  : String
  pcRole   : String       -- role in the quantum-gravity theory of memory
  pcNatural : Double      -- value in natural units (G=c=ℏ=k_B=1)

public export
Show PhysConst where
  show c =
    pcSymbol c ++ " = " ++ show (pcValue c) ++ " " ++ pcUnits c ++ "\n" ++
    "  (natural units: " ++ show (pcNatural c) ++ ")\n" ++
    "  role: " ++ pcRole c

-- =====================================================================
-- Fundamental Constants
-- =====================================================================

||| Newton's gravitational constant.
||| G = learning rate: how strongly a memory (protein) curves the manifold.
||| Higher G = faster learning (stronger gravitational pull = faster association).
public export
G : PhysConst
G = MkPC "Newton" "G" 6.674e-11 "m³/(kg·s²)"
  "learning rate: gravitational coupling of memories"
  1.0

||| Speed of light.
||| c = maximum association propagation speed through spacetime.
||| Wormholes (ER bridges) bypass this limit — non-local association.
public export
c : PhysConst
c = MkPC "speed of light" "c" 2.998e8 "m/s"
  "max association speed (spacetime propagation limit)"
  1.0

||| Reduced Planck's constant.
||| ℏ = quantum of information/action.
||| Bekenstein bound: I = E/m = 2πER/(ℏc·ln2) → in natural units I=m.
||| The smallest unit of memory = one quantum of information.
public export
hbar : PhysConst
hbar = MkPC "Planck" "ℏ" 1.055e-34 "J·s"
  "quantum of information (Bekenstein: I=E=m)"
  1.0

||| Boltzmann's constant.
||| k_B = thermal noise scale in the boundary QFT (protein surface).
||| Higher temperature = more thermal fluctuation = more volatile memory.
||| T_c = critical temperature where consciousness emerges (phase transition).
public export
kB : PhysConst
kB = MkPC "Boltzmann" "k_B" 1.381e-23 "J/K"
  "thermal noise in boundary QFT (protein surface fluctuations)"
  1.0

||| Cosmological constant.
||| Λ = forgetting rate. Drives expansion of the memory manifold.
||| Λ > 0: memories drift apart (forgetting)
||| Λ = 0: static universe (perfect memory)
||| Λ < 0: contraction (over-association, memories collapse together)
public export
lambdaCosm : PhysConst
lambdaCosm = MkPC "cosmological" "Λ" 1.089e-52 "m⁻²"
  "forgetting rate: cosmological expansion of memory manifold"
  1.0

-- =====================================================================
-- Derived Constants (Planck scale)
-- =====================================================================

||| Planck length.
||| ℓ_P = sqrt(ℏG/c³) = minimum spatial resolution of the manifold.
||| Below this scale, spacetime is quantum foam (no well-defined metric).
||| In memory: the smallest distinguishable feature in a protein fold.
public export
planckLength : PhysConst
planckLength = MkPC "Planck length" "ℓ_P" 1.616e-35 "m"
  "minimum memory resolution (quantum foam scale)"
  1.0

||| Planck time.
||| t_P = sqrt(ℏG/c⁵) = minimum time step for learning dynamics.
||| The fastest possible learning rate = 1/t_P.
public export
planckTime : PhysConst
planckTime = MkPC "Planck time" "t_P" 5.391e-44 "s"
  "minimum learning time step (fastest possible learning)"
  1.0

||| Planck mass.
||| m_P = sqrt(ℏc/G) = mass scale for a 1-bit memory (Bekenstein bound).
||| A memory with mass m_P holds exactly 1 bit of information.
||| I = E = m → m_P = 1 (natural unit of information).
public export
planckMass : PhysConst
planckMass = MkPC "Planck mass" "m_P" 2.176e-8 "kg"
  "mass of a 1-bit memory (Bekenstein: I=E=m, one bit = m_P)"
  1.0

||| Planck temperature.
||| T_P = sqrt(ℏc⁵/Gk_B²) = maximum temperature of the boundary QFT.
||| Above this: the manifold is pure quantum foam (no structure).
||| In memory: maximum volatility — everything evaporates instantly.
public export
planckTemp : PhysConst
planckTemp = MkPC "Planck temp" "T_P" 1.417e32 "K"
  "max boundary QFT temperature (total memory evaporation)"
  1.0

||| Planck entropy.
||| S_P = A/(4Gℏ) = Bekenstein-Hawking entropy of the protein surface.
||| S = area / 4 = number of retrievable bits (in natural units).
||| Larger protein surface = more entropy = more retrievable information.
public export
planckEntropy : PhysConst
planckEntropy = MkPC "Bekenstein-Hawking" "S_BH" 1.0 "k_B"
  "entropy bound: S = A/(4G) — retrievable information in protein surface"
  1.0

-- =====================================================================
-- AdS/CFT Constants (Holographic Duality)
-- =====================================================================

||| AdS radius (curvature radius of the bulk).
||| l = the scale of the holographic duality.
||| Brown-Henneaux: c = 3l/(2G) — the central charge of the boundary CFT
||| is determined by the bulk geometry.
||| Larger l = stronger holographic encoding = better memory.
public export
adsRadius : PhysConst
adsRadius = MkPC "AdS radius" "l" 1.0 "ℓ_P"
  "holographic scale: Brown-Henneaux c=3l/(2G)"
  1.0

||| Central charge of the boundary CFT.
||| c = 3l/(2G) — the number of degrees of freedom on the boundary.
||| This is the number of independent QFT modes on the protein surface.
||| More modes = more information capacity.
public export
centralCharge : PhysConst
centralCharge = MkPC "central charge" "c_CFT" 1.5 "—"
  "boundary CFT degrees of freedom: c=3l/(2G) (Brown-Henneaux)"
  1.5

||| Hawking temperature.
||| T_H = ℏc³/(8πGMk_B) = temperature of the protein surface.
||| T ∝ 1/M: heavier proteins are colder (more stable, long-term memory).
||| Lighter proteins are hotter (volatile, short-term memory).
public export
hawkingTemp : PhysConst
hawkingTemp = MkPC "Hawking temp" "T_H" 1.0 "K"
  "protein surface temperature: T∝1/M (heavy=cold=stable, light=hot=volatile)"
  1.0

-- =====================================================================
-- Critical Phenomena Constants
-- =====================================================================

||| Critical temperature of the mind.
||| T_c ≈ body temperature during waking/sleep transition.
||| At T_c: phase transition, maximum susceptibility, consciousness emerges.
||| Body T drops during sleep → crosses T_c → consolidation.
public export
criticalTempMind : PhysConst
criticalTempMind = MkPC "critical temp" "T_c" 0.3 "—"
  "phase transition temperature: sleep cycle crosses T_c for consolidation"
  0.3

||| Upper critical dimension.
||| d_uc = 4: above this, mean field theory is exact.
||| For the mind: the boundary is 2D (Chinese), bulk is 3D (Hungarian×Chinese).
||| 2D boundary → 2D Ising universality class applies.
public export
upperCritDim : PhysConst
upperCritDim = MkPC "upper crit dim" "d_uc" 4.0 "—"
  "upper critical dimension (above: mean field exact)"
  4.0

||| Dynamic critical exponent.
||| z: relates correlation length to relaxation time: τ ∝ ξ^z.
||| At criticality: critical slowing down (z > 0).
||| Higher z = slower response = more "timeless" feeling at criticality.
public export
dynCritExp : PhysConst
dynCritExp = MkPC "dynamic exponent" "z" 2.17 "—"
  "critical slowing down: τ ∝ ξ^z (Glauber dynamics)"
  2.17

-- =====================================================================
-- Protein-Specific Constants
-- =====================================================================

||| Number of canonical amino acids.
||| 20 amino acids = the alphabet of the Dirac language.
||| Each maps to one or more of the 6 morphological generators.
public export
numAminoAcids : PhysConst
numAminoAcids = MkPC "amino acids" "N_AA" 20.0 "—"
  "alphabet size of the Dirac language (20 amino acids → 6 generators)"
  20.0

||| Number of morphological generators.
||| 6 generators (G1-G6): harmony, definiteness, number, tense, mood, possession.
||| These are the "color charges" of the Dirac language.
||| 2^6 = 64 possible states = the 64 nouns of the framework.
public export
numGenerators : PhysConst
numGenerators = MkPC "generators" "N_gen" 6.0 "—"
  "morphological generators (2^6=64 states = the 64 nouns)"
  6.0

||| Number of Chinese composition types (Fano plane points).
||| 7 types: 6 compound (→6 generators) + 1 single (→null).
||| These are the 7 points of the Fano plane PG(2,2).
||| Automorphism group: PSL(2,7) = 168.
public export
numFanoPoints : PhysConst
numFanoPoints = MkPC "Fano points" "N_Fano" 7.0 "—"
  "Chinese composition types = Fano plane PG(2,2) points (PSL(2,7)=168)"
  7.0

||| PSL(2,7) group order.
||| 168 = 8 × 3 × 7 = automorphism group of the Fano plane.
||| This is the word-order group of the 3D language.
public export
pslOrder : PhysConst
pslOrder = MkPC "PSL(2,7)" "|PSL|" 168.0 "—"
  "word-order group of the 3D language (Fano automorphisms)"
  168.0

||| State space dimension (Hungarian morphology).
||| 432 = 2^4 × 3^3 = number of valid Hungarian morphological states.
||| Each state = one combination of suffix generators.
public export
stateSpaceDim : PhysConst
stateSpaceDim = MkPC "state space" "N_state" 432.0 "—"
  "valid Hungarian morphological states (2^4 × 3^3 = 432)"
  432.0

||| Full 3D state space.
||| 3024 = 432 × 7 = Hungarian states × Chinese Fano points.
||| This is the dimension of the full 3D language manifold.
public export
fullDim3D : PhysConst
fullDim3D = MkPC "3D dim" "N_3D" 3024.0 "—"
  "full 3D language manifold dimension (432 × 7 = 3024)"
  3024.0

||| CPT mask.
||| 37 = G1 ⊕ G3 ⊕ G6 = bits 0,2,5.
||| The CPT involution acts by XOR with this mask.
||| CPT² = I because 37 ⊕ 37 = 0.
public export
cptMask : PhysConst
cptMask = MkPC "CPT mask" "CPT" 37.0 "—"
  "CPT involution mask (G1⊕G3⊕G6 = bits 0,2,5 = 37; CPT²=I)"
  37.0

-- =====================================================================
-- All constants
-- =====================================================================

public export
allConstants : List PhysConst
allConstants =
  [ G, c, hbar, kB, lambdaCosm
  , planckLength, planckTime, planckMass, planckTemp, planckEntropy
  , adsRadius, centralCharge, hawkingTemp
  , criticalTempMind, upperCritDim, dynCritExp
  , numAminoAcids, numGenerators, numFanoPoints, pslOrder
  , stateSpaceDim, fullDim3D, cptMask
  ]

||| Print all physical constants.
public export
showAllConstants : IO ()
showAllConstants = do
  putStrLn "=== Physical Constants as Scaling Exponents ==="
  putStrLn "  (in the quantum-gravity theory of learning)\n"
  traverse_ (\pc => putStrLn (show pc ++ "\n")) allConstants
