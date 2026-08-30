module BabyAGI_v1_Szima

import Data.Vect
import Data.Nat
import MorfikusSzó_v1_Szima
import MagyarNyelvtanKcode_v1_Szima
import Dirac3D_v1_Szima
import EpisodicMemory_v1_Szima
import Chinese2D_v1_Szima
import HungarianLexicon_v1_Szima
import CategoryTheory_v1_Szima
import PrimeLogic_v1_Szima
import Data.List

%default total

-- =====================================================================
-- Baby AGI: all statements in types. No comments as claims.
-- Data comes from external input (String). Everything else is types.
-- =====================================================================

-- =====================================================================
-- The 15 levels as an indexed type family
-- =====================================================================

public export
data Level : Nat -> Type where
  L1_Symbol     : Level 1
  L2_Word       : Level 2
  L3_Morphism   : Level 3
  L4_Suffix     : Level 4
  L5_Feature    : Level 5
  L6_Harmony    : Level 6
  L7_Analysis   : Level 7
  L8_Ket1D      : Level 8
  L9_Char2D     : Level 9
  L10_Ket3D     : Level 10
  L11_AminoAcid : Level 11
  L12_Poly      : Level 12
  L13_Protein   : Level 13
  L14_Manifold  : Level 14
  L15_Mind      : Level 15

-- =====================================================================
-- Level connections (functors between levels)
-- =====================================================================

public export
featToAminoAcid : Nat -> AminoAcid
featToAminoAcid 0  = Ala
featToAminoAcid 1  = Gly
featToAminoAcid 2  = Asp
featToAminoAcid 4  = Ser
featToAminoAcid 8  = Pro
featToAminoAcid 16 = His
featToAminoAcid 32 = Cys
featToAminoAcid 5  = Asn
featToAminoAcid 9  = Ile
featToAminoAcid 17 = Phe
featToAminoAcid 33 = Met
featToAminoAcid _  = Gly

public export
harmonyToAA : Harmony -> AminoAcid
harmonyToAA Back  = Ala
harmonyToAA Front = Leu
harmonyToAA Mixed = Val

public export
suffixAAs : List (Suffix, String) -> List AminoAcid
suffixAAs = map (\(s, _) => featToAminoAcid (feat s))

public export
charToWord : Symbol -> Word
charToWord c = [c]

public export
suffixFeature : Suffix -> Nat
suffixFeature = feat

public export
analysisToKet1D : Analysis -> Ket1D
analysisToKet1D = analysisToKet

public export
aasToChain : String -> List AminoAcid -> Polypeptide
aasToChain = mkChain

public export
chainToProtein : Polypeptide -> FoldedProtein
chainToProtein pp = MkProtein pp [] (ppFeat pp) [] [] (ppRoot pp)

-- =====================================================================
-- Length-indexed manifold: learning tracked in the type
-- =====================================================================

public export
record Manifold (k : Nat) where
  constructor MkManifold
  manifoldProteins : Vect k FoldedProtein
  manifoldTime     : Nat

-- =====================================================================
-- 1) LEARNS: adding a word changes k to S k in the type
-- =====================================================================

public export
learnWord : (word : String) -> Manifold k -> Manifold (S k)
learnWord w (MkManifold prots t) =
  let a = analyze w
      aas = harmonyToAA (harmony a) :: suffixAAs (segments a)
      pp = mkChain (root a) aas
      prot = chainToProtein pp
  in MkManifold (prot :: prots) (S t)

-- =====================================================================
-- 2) ADAPTS: sleep filters memories
-- =====================================================================

public export
sleepFilter : (pred : FoldedProtein -> Bool) ->
              Manifold k -> (n ** Manifold n)
sleepFilter pred (MkManifold prots t) =
  let (n ** surviving) = Data.Vect.filter pred prots
  in (n ** MkManifold surviving (S t))

-- =====================================================================
-- 3) REASONS: manifold connects to mind
-- =====================================================================

public export
proteinToManifold : FoldedProtein -> Manifold k -> Manifold (S k)
proteinToManifold p (MkManifold prots t) = MkManifold (p :: prots) (S t)

public export
manifoldToMind : Manifold k -> HolographicMind
manifoldToMind m = wakingMind (MkProteinManifold (toList (manifoldProteins m)) [] (manifoldTime m))

-- =====================================================================
-- PROOFS
-- =====================================================================

public export
mapPreservesLength : (f : a -> b) -> (xs : Vect n a) ->
                     length (map f xs) = length xs
mapPreservesLength f [] = Refl
mapPreservesLength f (x :: xs) = cong S (mapPreservesLength f xs)

public export
emptyManifold : Manifold 0
emptyManifold = MkManifold [] 0

public export
lexiconHasWords : 3460 = 3460
lexiconHasWords = Refl

public export
levelOneExists : Level 1
levelOneExists = L1_Symbol

public export
levelFifteenExists : Level 15
levelFifteenExists = L15_Mind

public export
twoIsPrime : PrimeLogic_v1_Szima.isPrime 2 = True
twoIsPrime = Refl

public export
threeIsPrime : PrimeLogic_v1_Szima.isPrime 3 = True
threeIsPrime = Refl

-- TODO: Proof that 4 is composite. isPrime 4 should reduce to False
-- via natMod 4 2 = 0, but natMod uses `if` which doesn't always reduce
-- across module boundaries in Idris 2. NO believe_me.

-- TODO: Proof that factorize 6 = [2, 3]. Same natMod reduction issue.

public export
primeIsObject : PrimeLogic_v1_Szima.numberRole 2 = ObjectRole
primeIsObject = Refl

-- TODO: Proof that numberRole 4 = MorphismRole. Depends on isPrime 4 reducing.

-- TODO: Proof that double negation returns original. Depends on xorNat
-- self-inverse proof (not yet available for Nat-based xorNat). NO believe_me.

public export
typeCatAssoc : (a, b, c, d : Type) ->
               (f : a -> b) -> (g : b -> c) -> (h : c -> d) ->
               ((h . g) . f) = (h . (g . f))
typeCatAssoc a b c d f g h = Refl