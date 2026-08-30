module Dirac3D_v1_Szima

import Chinese2D_v1_Szima
import MagyarNyelvtanKcode_v1_Szima
import Data.List
import Data.String

-- =====================================================================
-- 3D Language: direct product of Chinese (2D) × Hungarian (1D).
--
-- The language is 3-dimensional because it is the direct product of
-- two fundamentally different writing systems:
--
--   Chinese (2D): spatial composition of radicals
--     |char⟩ = |r₁⟩ ⊗_F |r₂⟩     (Fano-plane tensor product)
--
--   Hungarian (1D): linear chain of suffix operators
--     |word⟩ = Ĝₙ ... Ĝ₂ Ĝ₁ |root⟩   (generator composition)
--
--   3D Language:
--     |Ψ⟩ = |char⟩ ⊗ Ô_chain |root⟩
--         = (|r₁⟩ ⊗_F |r₂⟩) ⊗ (Ĝₙ ... Ĝ₁ |root⟩)
--
-- Dimension count:
--   Chinese 2D: 7 Fano points × ∞ radicals ≈ infinite, but bounded
--     by the 214 Kangxi radicals → 214² × 7 ≈ 320k compound forms
--   Hungarian 1D: 6 generators → 2⁶ = 64 feature combinations,
--     with up to 3 suffixes chained → 64³ ≈ 262k, but constrained
--     by valid Hungarian morphology to ~432 = 2⁴ × 3³
--   3D product: 320k × 432 ≈ 1.4 × 10⁸ — enough expressive power.
--
-- In the Stabilizer/Dirac language:
--   - Nouns (Chinese characters) = stabilizer states (2D kets)
--   - Suffixes (Hungarian) = Clifford-like generators Ĝ₁..Ĝ₆
--   - The CPT involution acts on both: CPT|Ψ⟩ = Θ|char⟩ ⊗ Θ̂|word⟩
--   - CPT mask = 37 = G1 ⊕ G3 ⊕ G6 (bits 0,2,5)
-- =====================================================================

-- =====================================================================
-- Part 1: Hungarian 1D — suffix operators as Dirac generators.
-- =====================================================================

||| A morphological generator: one of G1–G6 with its bitmask.
public export
record GenOp where
  constructor MkGenOp
  genName  : String    -- "G1:harmony", "G3:number", etc.
  genBit   : Nat       -- 1, 2, 4, 8, 16, 32

public export
Show GenOp where
  show g = genName g ++ "(bit=" ++ show (genBit g) ++ ")"

||| The 6 canonical generators.
public export
g1, g2, g3, g4, g5, g6 : GenOp
g1 = MkGenOp "G1:harmony/space"    1
g2 = MkGenOp "G2:definiteness"     2
g3 = MkGenOp "G3:number"           4
g4 = MkGenOp "G4:tense/time"       8
g5 = MkGenOp "G5:mood"             16
g6 = MkGenOp "G6:possession"       32

||| All 6 generators.
public export
allGens : List GenOp
allGens = [g1, g2, g3, g4, g5, g6]

||| Extract bit f of an Integer (0 or 1).
bitOf6 : Integer -> Integer -> Integer
bitOf6 n f = if mod (div n f) 2 == 1 then 1 else 0

||| XOR two Nat bitmasks (bounded to 6 bits = 0–63).
public export
xorNat : Nat -> Nat -> Nat
xorNat a b =
  let ai = the Integer (cast a)
      bi = the Integer (cast b)
      z1 = mod (bitOf6 ai 1 + bitOf6 bi 1) 2
      z2 = mod (bitOf6 ai 2 + bitOf6 bi 2) 2
      z3 = mod (bitOf6 ai 4 + bitOf6 bi 4) 2
      z4 = mod (bitOf6 ai 8 + bitOf6 bi 8) 2
      z5 = mod (bitOf6 ai 16 + bitOf6 bi 16) 2
      z6 = mod (bitOf6 ai 32 + bitOf6 bi 32) 2
  in cast (z1 + 2*z2 + 4*z3 + 8*z4 + 16*z5 + 32*z6)

||| Popcount of a 6-bit mask: number of active generators.
public export
popcount6 : Nat -> Nat
popcount6 n =
  let ni = the Integer (cast n)
      b1 = the Nat (cast (bitOf6 ni 1))
      b2 = the Nat (cast (bitOf6 ni 2))
      b4 = the Nat (cast (bitOf6 ni 4))
      b8 = the Nat (cast (bitOf6 ni 8))
      b16 = the Nat (cast (bitOf6 ni 16))
      b32 = the Nat (cast (bitOf6 ni 32))
  in b1 + b2 + b4 + b8 + b16 + b32

-- =====================================================================
-- Part 2: The 1D Hungarian word as a ket with operator chain.
--
-- |word⟩ = Ĝₙ ... Ĝ₂ Ĝ₁ |root⟩
--
-- The Analysis record from Hungarian.idr already gives us the root
-- and the feature bitmask. We wrap it in Dirac notation.
-- =====================================================================

||| A Hungarian 1D ket: root + total feature mask + suffix chain.
||| This is the Dirac representation of a morphologically analyzed word.
public export
record Ket1D where
  constructor MkKet1D
  ketRoot   : String     -- |root⟩
  ketFeat   : Nat        -- total feature mask (XOR of all suffix bits)
  ketChain  : List String  -- suffix names applied, left to right
  ketHarm   : Harmony    -- vowel harmony of the root

||| Convert a Hungarian Analysis to a Dirac ket.
public export
analysisToKet : Analysis -> Ket1D
analysisToKet a =
  let suffixNames = map (\(s, _) => name s) (segments a)
  in MkKet1D (root a) (totalFeat a) suffixNames (harmony a)

||| Join a list of strings with ", ".
joinStrs : List String -> String
joinStrs [] = ""
joinStrs [x] = x
joinStrs (x :: xs) = x ++ ", " ++ joinStrs xs

||| Pretty-print a 1D ket in Dirac notation.
||| Example: "|ház⟩ · Ĝ(Pl,Iness)  feat=5"
public export
showKet1D : Ket1D -> String
showKet1D k =
  "|" ++ ketRoot k ++ "⟩ · Ĝ(" ++ joinStrs (ketChain k) ++ ")  " ++
  "feat=" ++ show (ketFeat k) ++ "  harm=" ++ show (ketHarm k)

-- =====================================================================
-- Part 3: The 3D product ket = Chinese 2D ⊗ Hungarian 1D.
-- =====================================================================

||| A 3D language element: a Chinese character paired with a Hungarian word.
|||
||| |Ψ⟩ = |char⟩ ⊗ |word⟩
|||
||| The Chinese part encodes the STATE (what — a noun/concept in 2D space).
||| The Hungarian part encodes the MORPHISM (how — inflection/relation in 1D).
public export
record Ket3D where
  constructor MkKet3D
  char2D   : Char2D       -- |char⟩ ∈ H²ᴰ (Chinese 2D state)
  word1D   : Ket1D        -- |word⟩ ∈ H¹ᴰ (Hungarian 1D operator-chain state)
  -- The two are linked by a "semantic anchor" string
  anchor   : String       -- shared semantic gloss, e.g. "house/dwelling"

||| Pretty-print a 3D ket.
public export
showKet3D : Ket3D -> String
showKet3D k =
  "Ψ = |" ++ form (char2D k) ++ "⟩ ⊗ |" ++ ketRoot (word1D k) ++ "⟩\n" ++
  "  char: " ++ showChar2D (char2D k) ++ "\n" ++
  "  word: " ++ showKet1D (word1D k) ++ "\n" ++
  "  anchor: " ++ anchor k

-- =====================================================================
-- Part 4: Word-type-dependent distance metric.
--
-- THE KEY INSIGHT: distance is NOT uniform across word types.
-- Different word types use different metrics on different channels.
--
-- For NOUN/STATE words (Chinese characters):
--   d = structural edit distance in 2D radical lattice
--   d = radicalSubstitutions + compositionTypeChange
--
-- For MORPHISM/ACTION words (Hungarian suffix chains):
--   d = XOR of feature bitmasks (structural distance in generator space)
--   d = popcount(feat₁ ⊕ feat₂)
--
-- For the 3D product:
--   d₃ᴰ = α · d₂ᴰ + β · d₁ᴰ
--   where α, β are type-dependent weights.
--
-- The learnable novelty paper (2607.18433) says:
--   distance = program length of optimal bounded model
--   = spectral description length C_spec
--   Different word types have different spectral structure.
-- =====================================================================

||| Word type classification — determines which distance metric applies.
public export
data WordType = NounState | MorphAction | Relation | StateModifier

public export
Show WordType where
  show NounState     = "NounState(2D)"
  show MorphAction   = "MorphAction(1D)"
  show Relation      = "Relation(graph)"
  show StateModifier = "StateModifier(feat)"

||| Distance weight pair: (alpha_2D, beta_1D).
||| These are type-dependent: nouns weigh 2D more, verbs weigh 1D more.
public export
distanceWeights : WordType -> (Nat, Nat)
distanceWeights NounState     = (3, 1)  -- nouns: 2D structure dominates
distanceWeights MorphAction   = (1, 3)  -- verbs: 1D morphology dominates
distanceWeights Relation      = (1, 2)  -- relations: morphology moderate
distanceWeights StateModifier = (2, 2)  -- adjectives: balanced

||| 1D distance: XOR of feature bitmasks + root edit cost.
public export
distance1D : Ket1D -> Ket1D -> Nat
distance1D k1 k2 =
  let featDist = popcount6 (xorNat (ketFeat k1) (ketFeat k2))
      rootDist = if ketRoot k1 == ketRoot k2 then 0 else 1
  in featDist + rootDist

||| Full 3D distance: type-dependent weighted sum.
|||
||| d₃ᴰ(Ψ₁, Ψ₂, τ) = α(τ) · d₂ᴰ(char₁, char₂) + β(τ) · d₁ᴰ(word₁, word₂)
|||
||| where τ is the word type and (α,β) = distanceWeights(τ).
public export
distance3D : WordType -> Ket3D -> Ket3D -> Nat
distance3D wt k1 k2 =
  let (alpha, beta) = distanceWeights wt
      d2 = distance2D (char2D k1) (char2D k2)
      d1 = distance1D (word1D k1) (word1D k2)
  in alpha * d2 + beta * d1

-- =====================================================================
-- Part 5: CPT involution on the 3D language.
--
-- CPT acts as: CPT|Ψ⟩ = Θ|char⟩ ⊗ Θ̂|word⟩
--
-- On the Chinese side, CPT = composition-type reversal
--   (left-right ↔ right-left, top-bottom ↔ bottom-top).
--   This is the spatial parity operation P.
--
-- On the Hungarian side, CPT = feature-mask inversion via XOR with 37:
--   Θ̂|word, feat⟩ = |word, feat ⊕ 37⟩
--   This is charge conjugation C combined with time reversal T.
--
-- CPT² = I (involution) because 37 ⊕ 37 = 0.
-- =====================================================================

||| CPT mask = G1 ⊕ G3 ⊕ G6 = bits 0,2,5 = 37.
public export
cptMask : Nat
cptMask = 37

||| CPT acts on a 1D ket by XOR-ing the feature mask with 37.
||| CPT² = identity because xor 37 37 = 0.
public export
cpt1D : Ket1D -> Ket1D
cpt1D k = { ketFeat := xorNat (ketFeat k) cptMask } k

||| CPT acts on a 2D character by reversing the spatial composition.
||| Left-Right ↔ Right-Left, Top-Bottom ↔ Bottom-Top.
||| (For now, we model this as identity on the composition type,
|||  since Chinese composition types don't have a natural parity
|||  reversal in our simplified model.)
public export
cpt2D : Char2D -> Char2D
cpt2D c = c  -- spatial parity is trivial in this model

||| Full CPT on a 3D ket.
public export
cpt3D : Ket3D -> Ket3D
cpt3D k = { char2D := cpt2D (char2D k), word1D := cpt1D (word1D k) } k

-- =====================================================================
-- Part 6: Proof-carrying structure.
-- =====================================================================

%default total

||| CPT is an involution on feature masks: CPT²(f) = f.
||| Proof: xor (xor f 37) 37 = xor f (xor 37 37) = xor f 0 = f.
||| We prove the key lemma: xor 37 37 = 0.
export
cptSquareMask : xorNat 37 37 = 0
cptSquareMask = Refl

||| The state space dimension: 432 = 2⁴ × 3³.
||| This is the number of valid Hungarian morphological states.
export
stateSpaceDim : Nat
stateSpaceDim = 432

||| Proof: 16 × 27 = 432.
export
stateSpaceProof : 16 * 27 = 432
stateSpaceProof = Refl

||| PSL(2,7) order = 168 = 8 × 3 × 7.
||| This acts on the 7 Fano points (Chinese composition types).
export
pslOrder : Nat
pslOrder = 168

export
pslOrderProof : 8 * 3 * 7 = 168
pslOrderProof = Refl

||| Full 3D state space: 432 (Hungarian) × 7 (Chinese Fano points)
||| = 3024 top-level orbits. (Not counting radical diversity.)
export
fullDim3D : Nat
fullDim3D = 432 * 7

||| Proof: 432 × 7 = 3024.
export
fullDim3DProof : 432 * 7 = 3024
fullDim3DProof = Refl
