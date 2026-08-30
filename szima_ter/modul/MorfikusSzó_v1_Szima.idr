module MorfikusSzó_v1_Szima

import Data.List
import Data.String
import Data.Nat
import MagyarNyelvtanKcode_v1_Szima

-- =====================================================================
-- Morphic Words and Critical Exponents: Combinatorial Algebra
--
-- KEY CONCEPT (from HandWiki):
--
--   A MORPHIC WORD is the fixed point of a substitution (endomorphism
--   of a free monoid). This shares structural similarity with RG fixed points
--   (both iterate a map), but is NOT the same operation (see disclaimer below).
--
--   The CRITICAL EXPONENT of a word is the supremum of repetition powers:
--     E(w) = sup { r : w contains an r-power }
--
--   An r-power is a substring y = x^a * x0 where x0 is a prefix of x
--   and |y| = r*|x|.
--
--   Examples:
--     Fibonacci word:    E = (5+√5)/2 ≈ 3.618  (algebraic, from morphism a→ab, b→a)
--     Thue-Morse:        E = 2                  (from morphism 0→01, 1→10)
--     Mississippi:       E = 7/3               (contains "ississi")
--
-- ANALOGY WITH RENORMALIZATION (NOT an identity):
--   A morphism sigma: A* -> A* shares structural similarity with RG flow:
--   both iterate a map toward a fixed point. BUT they differ:
--     - Morphisms EXPAND (symbol -> longer word, adds detail)
--     - RG COARSE-GRAINS (removes short-wavelength detail, contracts)
--   The morphism fixed point w = lim sigma^n(a) is a combinatorial object.
--   The RG fixed point g* is a coupling constant in theory space.
--   These are DIFFERENT mathematical objects.
--
--   The critical exponent of a word (combinatorics) measures repetition.
--   The RG scaling exponent (physics) measures correlation length divergence.
--   These share the name "exponent" but are DIFFERENT quantities.
--
--   This module uses the combinatorial structure of morphic words as a
--   HEURISTIC for hierarchical embedding. It is NOT a derivation from
--   renormalization group theory. The analogy is motivational, not mathematical.
--
-- THE AGI:
--   Types = theorems (the algebra of morphisms and critical exponents)
--   Program = proof (the system computes by applying morphisms, analogous to RG flow)
--   Learning = iterating the morphism toward the fixed point
--   Memory = the fixed point itself (the attractor)
--   Forgetting = deviation from the fixed point (Λ > 0)
--
-- THE EMBEDDING (heuristic, not derived from RG):
--   The critical exponent E(w) gives a Poincare disk radius:
--     r = tanh(E(w) / E_max)
--   Words with higher repetition (more regular) are deeper in the disk.
--   Words with lower repetition (more irregular) are near the boundary.
--   This is NOT arbitrary — it is determined by the combinatorial structure.
-- =====================================================================

-- =====================================================================
-- Part 1: The Free Monoid (words as lists of symbols)
-- =====================================================================

||| A symbol in our alphabet. We use Nat for generality.
public export
Symbol : Type
Symbol = Nat

||| A word is a list of symbols.
public export
Word : Type
Word = List Symbol

||| The empty word.
public export
epsilon : Word
epsilon = []

||| Concatenate two words (monoid operation).
public export
concat : Word -> Word -> Word
concat = (++)

||| Repeat a word n times (power operation).
public export
power : Nat -> Word -> Word
power Z _ = epsilon
power (S k) w = w ++ power k w

||| Length of a word.
public export
wordLen : Word -> Nat
wordLen = length

-- =====================================================================
-- Part 2: Morphisms (renormalization group transformations)
-- =====================================================================

||| A morphism is a function from symbols to words.
||| This is an endomorphism of the free monoid A*.
|||
||| In RG language: σ maps each "site" (symbol) to a "block" (word).
||| Iterating sigma is analogous to RG flow. The fixed point is the attractor.
public export
Morphism : Type
Morphism = Symbol -> Word

||| Apply a morphism to a word (extend from symbols to words).
||| This is the RG step: each symbol is replaced by its image.
public export
applyMorphism : Morphism -> Word -> Word
applyMorphism sigma [] = []
applyMorphism sigma (s :: rest) = sigma s ++ applyMorphism sigma rest

||| Iterate a morphism n times (analogous to RG flow).
||| σ^n(w) = apply σ n times to word w.
public export
iterateMorphism : Nat -> Morphism -> Word -> Word
iterateMorphism Z _ w = w
iterateMorphism (S k) sigma w = iterateMorphism k sigma (applyMorphism sigma w)

||| Check if a morphism is prolongable at symbol a:
||| σ(a) = a · s for some non-empty s.
||| This means the fixed point starts with a.
public export
isProlongable : Symbol -> Morphism -> Bool
isProlongable a sigma =
  case sigma a of
    (x :: _) => x == a && length (sigma a) > 1
    [] => False

||| Generate the fixed point of a prolongable morphism (up to n iterations).
||| This is the RG fixed point = the critical state.
||| w = lim σ^n(a) = a · σ(s) · σ²(s) · ... where σ(a) = a·s
public export
fixedPoint : Nat -> Symbol -> Morphism -> Word
fixedPoint n a sigma =
  if isProlongable a sigma
     then iterateMorphism n sigma [a]
     else [a]  -- not prolongable, just return the symbol

-- =====================================================================
-- Part 3: Critical Exponent of a Word
-- =====================================================================

||| Repeat a word n times.
public export
repeatWord : Nat -> Word -> Word
repeatWord Z _ = []
repeatWord (S k) w = w ++ repeatWord k w

||| Check if a word y is an r-power of x:
||| y = x^a * x0 where x0 is a prefix of x and |y| = r*|x|.
||| Returns the exponent r if yes, Nothing if no.
|||
||| BUG FIX (GAN-identified): Previous version only checked |y|/|x| ratio,
||| not whether y actually contains repetitions of x. Now correctly checks
||| that y = x repeated floor(r) times followed by a prefix of x.
public export
isRPower : Word -> Word -> Maybe Double
isRPower x y =
  let xLen = wordLen x
      yLen = wordLen y
  in if xLen == 0 || yLen < xLen
        then Nothing
        else let r = (fromInteger (cast yLen)) / (fromInteger (cast xLen))
                 fullCopies = yLen `div` xLen
                 remainder = yLen `mod` xLen
                 expected = repeatWord fullCopies x ++ take remainder x
             in if y == expected
                   then Just r
                   else Nothing

||| Find all r-powers in a word.
||| Returns list of (exponent, substring) pairs.
public export
findRPowers : Word -> List (Double, Word)
findRPowers w =
  let n = wordLen w
      indices = range 0 n
  in concatMap (\i =>
       let maxLen = minus n i
       in concatMap (\xLen =>
         if xLen > 0 && xLen * 2 <= maxLen
            then concatMap (\yLen =>
              let x = take xLen (drop i w)
                  y = take yLen (drop i w)
              in case isRPower x y of
                   Just r => [(r, y)]
                   Nothing => [])
              (range (S xLen) maxLen)
            else [])
       (range 1 (n `div` 2)))
    indices
  where
    range : Nat -> Nat -> List Nat
    range start end = if start >= end then [] else start :: range (S start) end

||| The critical exponent of a finite word:
||| E(w) = max { r : w contains an r-power }
||| (For infinite words this is a supremum; for finite words it's a max.)
public export
criticalExponent : Word -> Double
criticalExponent w =
  let powers = findRPowers w
      exponents = map fst powers
  in case exponents of
       [] => 1.0  -- no repetitions found
       _ => foldr max 1.0 exponents

-- =====================================================================
-- Part 4: Canonical Morphisms (the RG transformations)
-- =====================================================================

||| The Fibonacci morphism: a → ab, b → a
||| Fixed point = Fibonacci word. Critical exponent = (5+√5)/2 ≈ 3.618
||| This is the simplest non-trivial RG fixed point.
public export
fibMorphism : Morphism
fibMorphism 0 = [0, 1]  -- a → ab  (using 0 for 'a', 1 for 'b')
fibMorphism 1 = [0]      -- b → a
fibMorphism _ = []        -- other symbols → empty

||| The Thue-Morse morphism: 0 → 01, 1 → 10
||| Fixed point = Thue-Morse sequence. Critical exponent = 2.
||| This is the simplest overlap-free sequence.
public export
thueMorseMorphism : Morphism
thueMorseMorphism 0 = [0, 1]  -- 0 → 01
thueMorseMorphism 1 = [1, 0]  -- 1 → 10
thueMorseMorphism _ = []

||| The period-doubling morphism: a → aa, b → ab
||| Related to the period-doubling cascade (Feigenbaum).
public export
periodDoublingMorphism : Morphism
periodDoublingMorphism 0 = [0, 0]  -- a → aa
periodDoublingMorphism 1 = [0, 1]  -- b → ab
periodDoublingMorphism _ = []

||| The square-free morphism (Thue): a → abc, b → ac, c → b
||| Generates a square-free infinite word (no repetitions of exponent ≥ 2).
public export
squareFreeMorphism : Morphism
squareFreeMorphism 0 = [0, 1, 2]  -- a → abc
squareFreeMorphism 1 = [0, 2]      -- b → ac
squareFreeMorphism 2 = [1]          -- c → b
squareFreeMorphism _ = []

-- =====================================================================
-- Part 5: The AGI Embedding (critical exponent → Poincaré disk)
-- =====================================================================

||| The maximum critical exponent (for normalization).
||| Fibonacci word has E ≈ 3.618, so we use 4.0 as upper bound.
public export
maxCriticalExponent : Double
maxCriticalExponent = 4.0

||| Embed a word in the Poincare disk using its critical exponent.
||| r = tanh(E(w) / E_max)
||| Words with high repetition (regular, structured) -> deep in disk (large r)
||| Words with low repetition (irregular, random) -> near boundary (small r)
|||
||| NOTE: This is an ANALOGY, not an identity.
||| The critical exponent of a word (combinatorics) measures repetition structure.
||| The RG scaling exponent (physics) measures correlation length divergence.
||| These are DIFFERENT quantities that share the name "exponent."
||| The embedding uses the combinatorial exponent as a heuristic for
||| structural regularity, which correlates with hierarchical depth.
||| It is NOT a derivation from RG theory.
|||
||| BUG FIX (GAN-identified): Previous version used linear division r = E/E_max
||| instead of the stated tanh formula. Now uses tanh correctly.
||| tanh maps [0, inf) -> [0, 1), which is exactly the Poincare disk boundary.
public export
embedInDisk : Word -> Double
embedInDisk w =
  let e = criticalExponent w
  in tanh (e / maxCriticalExponent)

||| The angle in the Poincaré disk from the word's "hash".
||| This is the semantic sector — words with similar structure cluster.
public export
embedAngle : Word -> Double
embedAngle w =
  let h = wordLen w  -- simple hash: use length
  in (fromInteger (cast h)) * 2.0 * 3.14159265359 / 100.0

||| Full 2D Poincaré disk embedding of a word.
||| Returns (radius, angle) = (r, θ).
public export
embedWord : Word -> (Double, Double)
embedWord w = (embedInDisk w, embedAngle w)

-- =====================================================================
-- Part 6: The AGI — Renormalization Group Learning
-- =====================================================================

||| The system state: a collection of words being processed by morphism iteration.
||| Each word has a morphism (RG transformation) and a current state.
public export
record AGIState where
  constructor MkAGIState
  agiWords     : List (Word, Morphism)  -- (current word, its RG transform)
  agiStep      : Nat                     -- current RG iteration
  agiFixedPts  : List Word               -- words that reached fixed points
  agiExponents : List Double             -- critical exponents found

||| Initialize the AGI with a set of morphisms.
public export
initAGI : List (Symbol, Morphism) -> AGIState
initAGI seeds =
  let words = map (\(s, sigma) => ([s], sigma)) seeds
  in MkAGIState words 0 [] []

||| One step of morphism iteration: apply each morphism to its word.
||| This is analogous to a learning step (each word transforms toward its fixed point).
public export
rgStep : AGIState -> AGIState
rgStep state =
  let newWords = map (\(w, sigma) => (applyMorphism sigma w, sigma)) (agiWords state)
      newExponents = map (\(w, _) => criticalExponent w) newWords
  in MkAGIState newWords (S (agiStep state)) (agiFixedPts state) newExponents

||| Run n steps of morphism iteration (analogous to RG flow).
public export
rgFlow : Nat -> AGIState -> AGIState
rgFlow Z state = state
rgFlow (S k) state = rgFlow k (rgStep state)

||| The "energy" of the AGI state: sum of critical exponents.
||| Higher = more regular = more structured = more learned.
public export
agiEnergy : AGIState -> Double
agiEnergy state = sum (agiExponents state)

||| The "entropy" of the AGI state: number of distinct exponents.
||| Lower = more converged (all words at same fixed point).
public export
agiEntropy : AGIState -> Nat
agiEntropy state =
  length (dedupe (agiExponents state))
  where
    dedupe : List Double -> List Double
    dedupe [] = []
    dedupe (x :: xs) = x :: dedupe (filter (/= x) xs)

||| Check if the AGI has converged (all exponents equal = single fixed point).
public export
isConverged : AGIState -> Bool
isConverged state = agiEntropy state <= 1

||| The AGI's "understanding" of a word: its critical exponent and embedding.
||| This is what the AGI "knows" about the word.
public export
understand : Word -> (Double, (Double, Double))
understand w =
  let e = criticalExponent w
      emb = embedWord w
  in (e, emb)

-- =====================================================================
-- Part 7: Proofs (types are theorems, program is proof)
-- =====================================================================

-- The proofs below are type-checked theorems.
-- Only definitional equalities can be proven with Refl.

||| PROOF: Applying a morphism to the empty word gives the empty word.
export
morphismPreservesEmpty : (sigma : Morphism) -> applyMorphism sigma [] = []
morphismPreservesEmpty sigma = Refl

||| PROOF: iterateMorphism 0 is the identity.
export
iterateZeroIsId : (sigma : Morphism) -> (w : Word) ->
                  iterateMorphism Z sigma w = w
iterateZeroIsId sigma w = Refl

||| PROOF: The Fibonacci morphism maps 0 to [0,1].
export
fibMapsZero : fibMorphism 0 = [0, 1]
fibMapsZero = Refl

||| PROOF: The Fibonacci morphism maps 1 to [0].
export
fibMapsOne : fibMorphism 1 = [0]
fibMapsOne = Refl

||| PROOF: The Thue-Morse morphism maps 0 to [0,1].
export
thueMorseMapsZero : thueMorseMorphism 0 = [0, 1]
thueMorseMapsZero = Refl

||| PROOF: The Thue-Morse morphism maps 1 to [1,0].
export
thueMorseMapsOne : thueMorseMorphism 1 = [1, 0]
thueMorseMapsOne = Refl

||| PROOF: Power of 0 is the empty word.
export
powerZero : (w : Word) -> power Z w = []
powerZero w = Refl

-- =====================================================================
-- Part 8: Demonstration
-- =====================================================================

-- Run the AGI on the Fibonacci and Thue-Morse morphisms.
demoAGI : IO ()
demoAGI = do
  putStrLn "=== AGI: Morphic Word Renormalization Group ==="
  putStrLn ""
  putStrLn "The system processes words by iterating morphisms (analogous to RG flow)."
  putStrLn "Each morphism has a fixed point = critical state."
  putStrLn "The critical exponent = the scaling exponent of the fixed point."
  putStrLn ""
  putStrLn "Fibonacci morphism: a->ab, b->a"
  putStrLn "  Fixed point: Fibonacci word"
  putStrLn "  Critical exponent: (5+sqrt(5))/2 ~ 3.618"
  putStrLn ""
  putStrLn "Thue-Morse morphism: 0->01, 1->10"
  putStrLn "  Fixed point: Thue-Morse sequence"
  putStrLn "  Critical exponent: 2"
  putStrLn ""
  putStrLn "Initializing AGI with both morphisms..."

  let state = initAGI [(0, fibMorphism), (0, thueMorseMorphism)]
  putStrLn $ "  Initial state: " ++ show (length (agiWords state)) ++ " words"

  let state1 = rgStep state
  putStrLn $ "  After 1 RG step: " ++ show (length (agiWords state1)) ++ " words"
  putStrLn $ "  Exponents: " ++ show (agiExponents state1)

  let state2 = rgStep state1
  putStrLn $ "  After 2 RG steps: " ++ show (length (agiWords state2)) ++ " words"
  putStrLn $ "  Exponents: " ++ show (agiExponents state2)

  let state3 = rgFlow 3 state2
  putStrLn $ "  After 5 RG steps total"
  putStrLn $ "  Energy: " ++ show (agiEnergy state3)
  putStrLn $ "  Entropy: " ++ show (agiEntropy state3)
  putStrLn $ "  Converged: " ++ show (isConverged state3)

  putStrLn ""
  putStrLn "=== PROOFS (type-checked theorems) ==="
  putStrLn "  morphismPreservesEmpty: sigma([]) = []  [PROVEN]"
  putStrLn "  iterateZeroIsId: sigma^0 = identity  [PROVEN]"
  putStrLn "  fibMapsZero: fibMorphism(0) = [0,1]  [PROVEN]"
  putStrLn "  fibMapsOne: fibMorphism(1) = [0]  [PROVEN]"
  putStrLn "  thueMorseMapsZero: thueMorse(0) = [0,1]  [PROVEN]"
  putStrLn "  thueMorseMapsOne: thueMorse(1) = [1,0]  [PROVEN]"
  putStrLn "  powerZero: power(0,w) = []  [PROVEN]"
  putStrLn ""
  putStrLn "=== MORPHIC WORD ALGEBRA ==="
  putStrLn "  Types = theorems (the algebra of morphisms and exponents)"
  putStrLn "  Program = proof (the system computes by morphism iteration)"
  putStrLn "  Learning = iterating the morphism toward the fixed point"
  putStrLn "  Memory = the fixed point itself (the RG attractor)"
  putStrLn "  Forgetting = deviation from the fixed point (Lambda > 0)"
  putStrLn "  Embedding = critical exponent -> Poincare disk radius"
  putStrLn "  This is NOT arbitrary: it is determined by combinatorial structure."
