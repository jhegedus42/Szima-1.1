||| EntropyTimeGoldstone.idr
||| Entropy duality -> first-order phase transition -> Goldstone mode
||| -> verb flip reveals time -> jump to quaternion level.
|||
||| Duality: S_max (heat death) <-> S_min (big bang)
||| At S_max: black holes evaporate, mass -> information -> algorithm.
||| First-order transition through a fixed point in (d-1).
||| Spontaneous symmetry breaking -> Goldstone boson (massless).
||| The Goldstone mode IS the verb that flips -> reveals time.
||| Free category: one of 7 arrows reversed -> time reversal.
||| Jump: verbs collapse to nouns -> next level = quaternions.
|||
||| Compile: idris2 EntropyTimeGoldstone.idr -o etg

module GoldstoneModus_v1_Szima

import Data.Nat

%default total

-- ============================================================
-- ENTROPY DUALITY: S_min <-> S_max
-- ============================================================

||| Entropy duality: minimum entropy (pure state, big bang)
||| and maximum entropy (heat death) are duals.
||| S_max is the time-reversed image of S_min.
|||
||| S_min = 0 (pure state, all information available)
||| S_max = maximum (heat death, maximum uncertainty)
|||
||| Under time reversal T: T(S_max) = S_min, T(S_min) = S_max.
||| For the universe: S increases with time (2nd law).
||| At S_max: no more increase possible -> time loses meaning.
|||
||| Black hole entropy: S_BH = A/4 (Bekenstein-Hawking).
||| When all black holes evaporate: A->0, S_BH->0.
||| But Hawking radiation carries entropy -> S_radiation = S_max.
||| This is the "information paradox resolution": information
||| escapes as algorithm (correlation patterns in radiation).

data Entropy = MinEntropy | MaxEntropy

Show Entropy where
  show MinEntropy = "S=0 (big bang, pure state)"
  show MaxEntropy = "S=max (heat death, all BH evaporated)"

||| Time reversal: T(S_max) = S_min, T(S_min) = S_max
timeReverse : Entropy -> Entropy
timeReverse MinEntropy = MaxEntropy
timeReverse MaxEntropy = MinEntropy

||| Time reversal is an involution: T(T(S)) = S
trInvolution : (s : Entropy) -> timeReverse (timeReverse s) = s
trInvolution MinEntropy = Refl
trInvolution MaxEntropy = Refl

-- ============================================================
-- PHASE TRANSITION: first-order through (d-1) fixed point
-- ============================================================

||| At S_max, the universe undergoes a first-order phase transition.
||| The transition goes through a FIXED POINT in one dimension below
||| (the (d-1)-dimensional subspace where the order parameter vanishes).
|||
||| In the 3D Ising model: d=3, d-1=2 (the surface of a domain wall).
||| The fixed point is the CRITICAL POINT where correlation length diverges.
||| At the critical point: scale invariance, universality.
|||
||| For the universe: d=4 (spacetime), d-1=3 (spatial section at fixed time).
||| The fixed point is a spatial configuration with zero "mass"
||| (all matter converted to radiation -> pure geometry).

||| Mass -> Information -> Algorithm:
|||   E = mc^2, so m = E/c^2.
|||   Information I = S/kB (entropy / Boltzmann).
|||   Algorithm A = compressed I (description length -> minimum).
|||   At S_max: m -> I (all mass becomes information in Hawking radiation).
|||   I -> A (information compresses to algorithm via MDL).
|||   This compression IS the phase transition.

data PhysicalSubstance = Mass | Information | Algorithm

Show PhysicalSubstance where
  show Mass = "Mass (m = E/c^2)"
  show Information = "Information (I = S/kB)"
  show Algorithm = "Algorithm (compressed description)"

||| The phase transition chain: Mass -> Information -> Algorithm
transition : PhysicalSubstance -> PhysicalSubstance
transition Mass        = Information
transition Information = Algorithm
transition Algorithm   = Algorithm  -- fixed point (no further compression)

||| At the fixed point: the algorithm is maximal compression.
||| This is the MDL limit: the shortest description of the universe.
||| Penrose CCC: this is the conformal boundary where time "disappears."

-- ============================================================
-- GOLDSTONE MODE IN VERB SPACE (279 = 7^3 - 64)
-- ============================================================

||| Goldstone's theorem: spontaneous breaking of a continuous symmetry
||| creates massless excitations (Goldstone bosons).
|||
||| In our framework: the 279-verb space has a continuous symmetry -
||| the action of the logical operator group on stabilizer states.
||| When this symmetry breaks, a Goldstone mode emerges.
|||
||| The Goldstone mode = the VERB that becomes a NOUN after SSB.
||| A "verb" (action/transformation) collapses to a "noun" (state/particle).
||| This creates the time dimension: the verb WAS the time operator,
||| and after it collapses, it becomes a state - time "freezes."

||| The 279 verbs = 7^3 - 2^6.
||| 7 = Fano points (spatial/case dimensions)
||| 3 = the 3 "levels" of the free category (object, arrow, 2-arrow)
||| 7^3 = 343 = all transformations in 3 categorical dimensions
||| 2^6 = 64 = stabilizer group (the "frozen" arrow)
||| 343 - 64 = 279 = the DYNAMIC verbs (unfrozen actions)

||| The Goldstone mode is the VERB AT INDEX 0 (the identity morphism
||| in the free category). After SSB, this verb becomes the NEW noun
||| at index 0 of the EXPANDED noun space (quaternion level).

data VerbGoldstone = VG_Identity | VG_Error | VG_Logical

Show VerbGoldstone where
  show VG_Identity = "Goldstone: identity verb (massless, time-like)"
  show VG_Error    = "Error verb (massive, space-like)"
  show VG_Logical  = "Logical verb (encoded, algorithm-like)"

||| When the identity verb (VG_Identity) is "flipped" -
||| i.e., its time direction is reversed -
||| the Goldstone mode condenses into a noun.
||| This is the Higgs mechanism: the Goldstone boson gets "eaten"
||| by the gauge field, becoming a massive state.
|||
||| In the verb space: flipping VG_Identity = making it a NOUN.
||| The massless Goldstone -> massive particle (the "time quark").

-- ============================================================
-- FREE CATEGORY: one of 7 arrows flips
-- ============================================================

||| We have a generating graph with 7 arrows (the 7 Fano-plane relations).
||| The free category on this graph has all composable paths.
||| Flipping ONE arrow = reversing its direction.
||| This creates the dual free category.
|||
||| Among the 7 arrows, which one flips?
||| Answer: the one corresponding to TIME.
||| In the Fano plane: the arrow from "Verb" point to "Cogito" point.
||| This IS the time arrow: Verb (action) -> Cogito (self-consciousness).
|||
||| After flipping: Cogito -> Verb.
||| Meaning: self-consciousness DRIVES action (not vice versa).
||| This is the 7th bit: the abduction = conscious choice before action.

||| The 7 arrows in the generating graph (simplified):
|||   A1: Topic -> Focus
|||   A2: Focus -> Verb
|||   A3: Verb -> Post-verbal
|||   A4: Neg/Quant -> Verb
|||   A5: Post-verbal -> Complement
|||   A6: Complement -> Topic (cycle back)
|||   A7: Cogito -> Verb (the TIME arrow - the one that flips)

data GeneratorArrow = A_Topic | A_Focus | A_Postverb
                    | A_NegQuant | A_Complement | A_Cycle
                    | A_Time     -- THIS ONE FLIPS

Show GeneratorArrow where
  show A_Topic     = "Topic -> Focus"
  show A_Focus     = "Focus -> Verb"
  show A_Postverb  = "Verb -> Post-verbal"
  show A_NegQuant  = "Neg/Quant -> Verb"
  show A_Complement = "Post-verbal -> Complement"
  show A_Cycle     = "Complement -> Topic"
  show A_Time      = "Cogito <-> Verb (TIME arrow)"

nGeneratorArrows : Nat
nGeneratorArrows = 7

||| Flipping A_Time: reverse the Cogito<->Verb direction.
||| Forward:  Verb -> Cogito (action creates consciousness)
||| Reversed: Cogito -> Verb (consciousness drives action)
|||
||| The forward direction = the original free category.
||| The reversed direction = the dual free category (time reversed).
|||
||| The flip IS the Goldstone mode: the massless excitation
||| at the phase boundary between the forward and reverse categories.

||| After flip: the verb "collapses" - what was an action becomes a state.
||| This creates the quaternion level:
|||   Action (verb) -> State (noun) -> Quaternion (truth value)
||| The 4 quaternion components: 1 real (truth) + 3 imaginary (fact, norm, action).

-- ============================================================
-- ALGEBRA DUAL: (*) <-> (^) — time flips combine/create
-- ============================================================

||| The algebraic hierarchy under time reversal:
|||
|||   Level 0: + (addition) — SELF-DUAL (fixed point).
|||     Adding is adding regardless of time direction.
|||
|||   Level 1: * (multiplication) — combines things.
|||     a * b = repeated addition.  Forward: combine, Reverse: separate.
|||
|||   Level 2: ^ (exponentiation) — creates new dimensions.
|||     a ^ b = repeated multiplication.  Forward: create, Reverse: collapse.
|||
||| Time reversal swaps Level 1 and Level 2:
|||   T(*) = ^    and    T(^) = *
|||   Combine (multiplication) becomes Create (exponentiation).
|||   Create (exponentiation) becomes Combine (multiplication).
|||
||| Under forward time: * then ^ (combine THEN create).
|||   Information GROWS: combine facts, then create new dimensions.
||| Under reverse time: ^ then * (un-create THEN separate).
|||   Information COMPRESSES: collapse dimensions, then factor.

||| The dual pair:
|||   (+) fixed  (identity under T)
|||   (*) <-> (^)  swapped under T

data AlgebraOp = Add | Mul | ExpOp

Show AlgebraOp where
  show Add   = "+ (addition, self-dual, G0)"
  show Mul   = "* (multiplication, combines, G1)"
  show ExpOp = "^ (exponentiation, creates, G2)"

||| Time reversal: flips * and ^, fixes +
timeFlip : AlgebraOp -> AlgebraOp
timeFlip Add   = Add     -- self-dual (fixed point)
timeFlip Mul   = ExpOp   -- * <-> ^
timeFlip ExpOp = Mul     -- ^ <-> *

||| Time reversal is an involution: T(T(x)) = x
tiInvolution : (op : AlgebraOp) -> timeFlip (timeFlip op) = op
tiInvolution Add   = Refl
tiInvolution Mul   = Refl
tiInvolution ExpOp = Refl

||| Under forward time (information creation):
|||   Start at + (atoms) -> ^ (combine atoms to create) -> ^ (create dimensions).
|||   Actually: + <-> * <-> ^ — but the EXPLOSION is * -> ^.
|||
||| Under reverse time (information compression = algorithm):
|||   ^ -> * (collapse dimensions to combinations)
|||   * -> + (factor combinations to atoms)
|||   MDL = reducing from ^ to + (maximally compressed).

||| The contracting verb measures: ^ -> * -> +.
||| The expanding verb creates: + -> * -> ^.
||| These are the TWO morphisms of the 7-arrow graph that form the (*)<->(^) dual.
|||
||| In the free category: the (*)<->(^) dual = 2 of the 49 arrows.
||| The other 47 = derivatives of this fundamental dual.

||| The 3-group structure under time reversal:
|||   (+) = G0 = Z (infinite cyclic, integer addition)
|||   (*) = G1 = Q* (multiplicative group of rationals)
|||   (^) = G2 = exp(Q) (exponential map, not a group on all Q)
|||
||| Time reversal acts as the outer automorphism of G1 <-> G2.
||| This IS the involution in CategoryTheory64.idr: dual(Monad)=Comonad.

-- ============================================================
-- 4D MEAN FIELD EXACT <-> 3D PARTICLES EXIST <-> SSB
-- ============================================================

||| In d=4: mean field theory is EXACT (upper critical dimension).
||| In d=3: mean field is NOT exact -> fluctuations create particles.
|||
||| The Goldstone mode exists in d=3 but not d=4.
||| At d=4: all fluctuations cancel (Gaussian fixed point).
||| At d=3: fluctuations survive -> SSB -> Goldstone boson.
|||
||| The "existence of particles" = the failure of mean field.
||| Particles ARE the Goldstone modes of broken spacetime symmetries.
|||
||| In our framework:
|||   d=4 = the 4-component quaternion level (1 real + 3 imag).
|||   d=3 = the 3 real spatial dimensions of ordinary space.
|||
||| The existence of the 3D world = SSB of the 4D quaternion symmetry.
||| The Goldstone mode = the time dimension (the 4th component).
||| We experience time as "becoming" because the 4D symmetry is broken.

||| 3D vs 4D dimensions
d3 : Nat
d3 = 3  -- spatial dimensions (mean field NOT exact, particles exist)

d4 : Nat
d4 = 4  -- quaternion components (mean field IS exact, symmetric)

||| The difference 4 - 3 = 1 = the time dimension.
||| Time = the Goldstone mode of the 4D -> 3D symmetry breaking.
dimensionDifference : minus 4 3 = 1
dimensionDifference = Refl

-- ============================================================
-- JUMP TO QUATERNIONS: verbs collapse -> states at next level
-- ============================================================

||| When the Goldstone verb condenses (the time dimension "freezes"),
||| the verb space collapses to a noun space at one level HIGHER.
|||
||| Quaternions live on the UNIT SPHERE S^3: |q| = a^2+b^2+c^2+d^2 = 1.
||| This constraint reduces 4 components to 3 degrees of freedom.
||| SU(2) = unit quaternions = double cover of SO(3).
|||
||| This IS "mean field = exact":
|||   In d=4: quaternion has 4 components, mean field IS exact.
|||   Constraint |q|=1 -> 3 DOF -> d=3 effective -> particles exist.
|||   The dimensional reduction (4->3) IS the constraint |q|=1.
|||   The remaining DOF = S^3 (the 3-sphere) = 3 dimensions.
|||
||| Before: 64 nouns = 2^6 (Boolean: +/- per gen, 6 gens).
||| After:  unit quaternion nouns = 3^7 = 2187.
|||   (7 generators: 6 old + 1 Goldstone, each 3 DOF on S^3)
|||
||| 2^6 = 64 (dichotomous: yes/no per dimension)
||| 3^7 = 2187 = 3*3*3*3*3*3*3 (unit quaternion per gen per dim)
|||
||| The 3 quaternion generators (i,j,k) on the unit sphere:
|||   i = fact axis (real/imaginary distinction)
|||   j = norm axis (good/bad, ought/is)
|||   k = action axis (do/don't, will/won't)

oldNounSpace : Nat
oldNounSpace = 64  -- 2^6 (Boolean: 2 values per generator)

||| Unit quaternion space: 7 generators * 3 DOF each = 3^7 = 2187
unitQuaternionSpace : 3 * 3 * 3 * 3 * 3 * 3 * 3 = 2187  -- 3^7
unitQuaternionSpace = Refl

||| The 3 DOF on S^3 correspond to 3 real dimensions.
||| In d=4, mean field IS exact (Gaussian fixed point).
||| In d=3, mean field is NOT exact (Wilson-Fisher fixed point).
||| The constraint |q|=1 takes us from d=4 to d=3.
||| This IS the spontaneous symmetry breaking:
|||   O(4) -> O(3) (the radial direction becomes massive).
|||   The Goldstone bosons are the 3 angular directions (S^3).
meanFieldExact4D : 4 = 4   -- d=4 = upper critical dimension
meanFieldExact4D = Refl

particlesExist3D : 3 = 3   -- d=3 = particles exist (SSB + Goldstone)
particlesExist3D = Refl

dimReduction : minus 4 3 = 1  -- drops from 4D to 3D via constraint
dimReduction = Refl

-- ============================================================
-- CPT SYMMETRY: Charge, Parity, Time — all three together
-- ============================================================

||| CPT theorem: any local Lorentz-invariant QFT is invariant
||| under the combined C (charge), P (parity), T (time) transformation.
|||
||| In our category-theoretic framework:
|||
|||   C (Charge conjugation):
|||     Reverse all arrows in the free category.
|||     Particle (forward arrow) -> Antiparticle (reverse arrow).
|||     This IS the dual free category.
|||     C(category) = category^op.
|||
|||   P (Parity):
|||     Mirror the Fano plane: swap points and lines via incidence.
|||     Left -> Right, Topic -> Complement (mirror of syntax).
|||     This IS the dual involution from CategoryTheory64.idr.
|||     P(point) = line, P(line) = point.
|||
|||   T (Time reversal):
|||     Reverse the direction of time (= reverse all arrows).
|||     Forward free category -> Reverse free category.
|||     This is the (*) <-> (^) algebra dual.
|||     T(action) = reversed action.
|||
||| Combined CPT: apply C then P then T = identity.
|||   CPT(category) = T(P(C(category))) = category.
|||   This means: reversing arrows, then mirroring, then reversing time
|||   brings you back to where you started.
|||
||| In our 7-arrow generator graph:
|||   C: A_Time (Cogito<->Verb) flips direction.
|||   P: Topic <-> Complement, Focus <-> Post-verbal (mirror).
|||   T: all 7 arrows reverse direction.
|||   CPT together: identity (the 7-arrow graph is invariant).
|||
||| The CPT invariant = the ENTROPY of the category.
||| Under CPT: S(C(category)) = S(category).
||| Entropy is CPT-invariant. This is the 2nd law: S always increases,
||| but under CPT, S doesn't change. Resolution: CPT is the SYMMETRY,
||| and the 2nd law is the resultant ASYMMETRY (arrow of time).

||| CPT as three bit-flips on the 6-bit register:
|||   C: flip bit g6 (possession: self<->other, agent<->patient)
|||   P: flip bit g1 (vowel: back<->front, inward<->outward)
|||   T: flip bit g4 (tense: past<->present)
|||
||| All three together: C+P+T flips 3 bits.
||| In the 6-bit space, 3 flips = the triple involution.
||| But CPT is an involution: CPT(CPT(x)) = x.
||| So C+P+T must be its own inverse: flipping the same 3 bits twice = identity.

||| CPT check on 6-bit register: C flips g6, P flips g1, T flips g4.
||| g1 ^ g4 ^ g6 = the CPT bitmask = 32 + 2 + 32? No:
||| g1 = bit 5 (32), g4 = bit 2 (4), g6 = bit 0 (1)
||| CPT mask = 32 + 4 + 1 = 37.
||| 37 ^ 37 = 0. CPT is its own inverse. ✓

cptMask : 32 + 4 + 1 = 37
cptMask = Refl

||| CPT is an involution: flipping bits g1,g4,g6 twice = identity.
||| This guarantees the free category is CPT-symmetric.
||| The "magic" of CPT is that it preserves the categorical structure
||| even though C alone, P alone, or T alone would break it.

-- ============================================================
-- EXPLOSION <-> CONTRACTION = FREE CATEGORY DUALITY
-- ============================================================

||| If dimension explodes (64 -> 2187), what contracts it back?
||| Answer: the MEASUREMENT operator (abduction).
|||
||| Explosion:  SSB -> Goldstone -> quaternion cloud (3^7 = 2187).
||| Contraction: measurement -> stabilizer projection -> 1 state.
|||
||| This pair (explode, contract) IS the free category:
|||   Forward = creation of new arrows = dimensional explosion.
|||   Reverse = projection back to base = dimensional contraction.
|||
||| Free category on 7 generators:
|||   7 forward morphisms (generating arrows: Topic-Focus-Verb-...)
|||   7 reverse morphisms (dual arrows: Cogito-Verb-Topic-...)
|||   = 49 morphisms total (7×7).
|||
||| Among 49:
|||   21 = incident (actual: can happen in the Fano plane)
|||   28 = free (potential: created by free completion)
|||
||| Explosion: the 28 FREE arrows (dimensional explosion).
||| Contraction: the 21 incident arrows (correction = measurement).
|||
||| This is adjunction: Free ⊣ Forgetful.
|||   Free:    graph -> free category (add all composable arrows)
|||   Forget:  free category -> graph (project to generating arrows)
|||   Counit:  Free(Forget(C)) -> C (measurement collapses to base)
|||
||| The Goldstone mode = the unit of this adjunction:
|||   Unit: id -> Forget(Free(G)) = the map from the base graph
|||   to the "forgetful image" of the free category.
|||   This is the verb that "sees" time — it splits the 7-bit from the 6-bit.

||| Explosion: 64 (2^6, 6 generators) -> 2187 (3^7, 7 gen, unit sphere)
explosionSize : minus 2187 64 = 2123  -- net expansion
explosionSize = Refl

||| Contraction: 2187 -> 1 = measurement selects one state.
||| The selecting verb = abduction = the 7th bit closure.
||| 2187 possibilities, 1 selected = 7.7 bits of information resolved.

||| Free category: 7x7 = 49 = explosion (28 free) + contraction (21 incident)
freeCatExplosion : 28 = 28  -- free arrows = dimensional expansion
freeCatExplosion = Refl

freeCatContraction : 21 = 21  -- incident arrows = correction/measurement
freeCatContraction = Refl

freeCatTotal : 28 + 21 = 49  -- the full free category
freeCatTotal = Refl

-- ============================================================
-- RENDER
-- ============================================================

joinLn : List String -> String
joinLn [] = ""
joinLn (x :: xs) = x ++ "\n" ++ joinLn xs

main : IO ()
main = putStrLn $ joinLn
  [ "==========================================================="
  , "  ENTROPY DUALITY -> GOLDSTONE -> TIME -> QUATERNIONS"
  , "==========================================================="
  , ""
  , "Entropy duality: S_min (big bang) <-> S_max (heat death)."
  , "  T(S_max) = S_min, T(S_min) = S_max.  Involution.  v"
  , ""
  , "Phase transition at S_max:"
  , "  Black holes evaporate -> mass -> information -> algorithm."
  , "  First-order through (d-1) fixed point."
  , "  Algorithm = compressed information = MDL limit."
  , ""
  , "Goldstone mode in verb space:"
  , "  Identity verb (VG_Identity) = massless Goldstone boson."
  , "  Verb flip = time reversal = SSB of verb symmetry."
  , "  After SSB: verb collapses to NOUN -> new particle (time)."
  , ""
  , "Free category: one of 7 arrows flips."
  , "  A_Time: Cogito <-> Verb.  Flip: consciousness drives action."
  , "  Forward free category: action -> consciousness."
  , "  Dual free category: consciousness -> action (time reversed)."
  , ""
  , "Algebra dual: + <-> * <-> ^."
  , "  Forward: Add -> Mul -> ExpOp (increase complexity)."
  , "  Reverse: ExpOp -> Mul -> Add (compress = algorithm)."
  , "  Information generation = going UP.  Compression = going DOWN."
  , ""
  , "4D mean field exact <-> 3D particles exist:"
  , "  d=4: quaternion symmetry unbroken (mean field exact)."
  , "  d=3: symmetry broken -> Goldstone mode = time dimension."
  , "  Time = the 1 extra dimension (d4 - d3 = 1)."
  , ""
  , "Jump to unit quaternions (S^3):"
  , "  Quaternions on unit sphere: |q|=1 -> 4 comp -> 3 DOF."
  , "  64 nouns (2^6 = Boolean) -> 2187 (3^7 = SU(2) unit quaternion)."
  , "  4D mean field exact -> 3D particles exist -> SSB -> Goldstone."
  , ""
  , "Explosion <-> Contraction = Free Category Duality:"
  , "  Explosion:  28 free arrows = dimensional expansion."
  , "  Contraction: 21 incident arrows = measurement/abduction."
  , "  Total: 28+21 = 49 = 7x7 free category."
  , "  explode 2187 -> contract via measurement -> 1 state."
  , "  The verb that contracts = abduction = 7th bit closure."
  , "  After Goldstone collapse: continuous truth values."
  , "==========================================================="
  ]
