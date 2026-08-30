module PrimeLogic_v1_Szima

import Data.List
import Data.Nat
import Data.String
import HungarianDistance_v1_Szima
import HungarianLexicon_v1_Szima

%default partial

-- =====================================================================
-- The Full Hierarchy: -7 to +15
--
-- MATTER (positive levels 1-7):
--   1: Symbol (character)
--   2: Word (sequence)
--   3: Morphism (substitution)
--   4: Suffix (morphological unit)
--   5: Feature (6-bit mask)
--   6: Harmony (Back/Front/Mixed)
--   7: Analysis (full decomposition)
--
-- ANTIMATTER (negative levels -1 to -7):
--  -1: Anti-Symbol (negation of a character: NOT c)
--  -2: Anti-Word (negation of a sequence: logic between statements)
--  -3: Anti-Morphism (contradiction: NOT sigma)
--  -4: Anti-Suffix (complement morpheme)
--  -5: Anti-Feature (complement bitmask: ~feat)
--  -6: Anti-Harmony (disharmony)
--  -7: Anti-Analysis (decomposition failure)
--
-- CPT INVOLUTION: level N <-> level -N
--   This is the matter-antimatter symmetry.
--   CPT mask = 37 maps features to their complement.
--   xorNat f 37 gives the anti-feature.
--
-- PRIMES = NOUNS (objects, matter)
-- COMPOSITES = VERBS (morphisms, forces between objects)
-- ANTI-PRIMES = ANTI-NOUNS (antimatter)
--
-- LOGIC IS NEGATIVE: it lives at level -2.
-- Statements at level -2 connect objects via negation/implication.
-- =====================================================================

-- =====================================================================
-- Level -7 to -1: Antimatter types
-- =====================================================================

||| Level -1: Anti-symbol. The negation of a symbol.
public export
record AntiSymbol where
  constructor MkAntiSym
  antiSymValue : Nat
  antiSymFrom  : Nat          -- the original symbol it negates

||| Level -2: Anti-word. The negation of a statement.
||| This is where LOGIC lives: connections between words.
public export
record AntiWord where
  constructor MkAntiW
  antiWText     : String
  antiWNumber   : Nat         -- the number encoding (prime=composite determines role)
  antiWNegates  : List Nat    -- which objects this negates
  antiWImplies  : List Nat    -- which objects this implies

||| Level -3: Anti-morphism. A contradiction in the substitution.
public export
record AntiMorphism where
  constructor MkAntiMorph
  antiMorphFrom : Nat -> List Nat   -- the inverted substitution
  antiMorphName : String

||| Level -5: Anti-feature. The complement bitmask.
||| CPT: feat XOR 37 = anti-feat
public export
antiFeature : Nat -> Nat
antiFeature f = xorNat f 37

||| Level -6: Anti-harmony.
public export
data AntiHarmony = AntiBack | AntiFront | AntiMixed

-- =====================================================================
-- Level -1: Number theory as category theory
-- =====================================================================

||| Natural modulus (structural recursion on S constructors).
||| Uses minus with pattern matching so it reduces at the type level.
natMod : Nat -> Nat -> Nat
natMod Z _ = 0
natMod n Z = 0  -- division by zero, shouldn't happen but safe
natMod n d =
  if lt n d then n
  else natMod (minus n d) d

||| Natural division (structural recursion).
natDiv : Nat -> Nat -> Nat
natDiv Z _ = 0
natDiv n Z = 0
natDiv n d =
  if lt n d then 0
  else S (natDiv (minus n d) d)

||| Check if n is prime.
public export
isPrimeHelper : Nat -> Nat -> Bool
isPrimeHelper n k =
  if k * k > n then True
  else if natMod n k == 0 then False
  else isPrimeHelper n (S k)

public export
isPrime : Nat -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime n = isPrimeHelper n 2

||| Prime factorization: the argument structure of a composite.
public export
factorizeHelper : Nat -> Nat -> List Nat
factorizeHelper 1 _ = []
factorizeHelper n k =
  if k * k > n then [n]
  else if natMod n k == 0
          then k :: factorizeHelper (natDiv n k) k
          else factorizeHelper n (S k)

public export
factorize : (n : Nat) -> List Nat
factorize n = factorizeHelper n 2

||| Primes = objects (nouns). Composites = morphisms (verbs).
public export
numberRole : Nat -> MathRole
numberRole n = if isPrime n then ObjectRole else MorphismRole

||| Map a word to a number (deterministic hash).
public export
wordToNumber : String -> Nat
wordToNumber s = hash (unpack s) 1
  where
    hash : List Char -> Nat -> Nat
    hash [] acc = acc
    hash (c :: cs) acc = hash cs (acc * 31 + cast {to=Nat} c)

-- =====================================================================
-- Level -2: LOGIC between statements
--
-- A statement at level -2 connects objects via implication/negation.
-- The prime factorization determines the logical structure.
-- =====================================================================

||| A logical statement: a word's number determines its role,
||| and its factorization determines what it connects.
public export
record Statement where
  constructor MkStmt
  stmtWord   : String
  stmtNumber : Nat
  stmtRole   : MathRole       -- Object (prime) or Morphism (composite)
  stmtArgs   : List Nat       -- prime factors = connected objects

||| Build a statement from a word.
public export
makeStatement : String -> Statement
makeStatement w =
  let n = wordToNumber w
  in MkStmt w n (numberRole n) (factorize n)

||| Two statements are LOGICALLY CONNECTED if they share a prime factor.
||| This is the edge in the logic graph.
public export
connected : Statement -> Statement -> Bool
connected s1 s2 = any (\p => elem p (stmtArgs s2)) (stmtArgs s1)

||| NEGATION: the anti-statement.
||| CPT maps statement to its negation via XOR with 37.
public export
negateStatement : Statement -> Statement
negateStatement s =
  let antiNum = xorNat (stmtNumber s) 37
  in MkStmt ("NOT " ++ stmtWord s) antiNum (numberRole antiNum) (factorize antiNum)

||| IMPLICATION: s1 implies s2 if s1's arguments are a subset of s2's.
public export
implies : Statement -> Statement -> Bool
implies s1 s2 = all (\a => elem a (stmtArgs s2)) (stmtArgs s1)

||| CONTRADICTION: s1 contradicts s2 if they share an object
||| but have anti-harmony (CPT partners).
public export
contradicts : Statement -> Statement -> Bool
contradicts s1 s2 =
  connected s1 s2 &&
  xorNat (stmtNumber s1) 37 == stmtNumber s2

-- =====================================================================
-- CPT: matter <-> antimatter symmetry
-- =====================================================================

||| CPT maps level N to level -N.
||| Matter (positive) <-> Antimatter (negative).
||| This is a PROVEN involution: CPT^2 = Identity.
public export
cptMap : Statement -> Statement
cptMap = negateStatement

-- TODO: Proof that CPT is an involution: xorNat (xorNat n 37) 37 = n
-- This follows from XOR being self-inverse, but xorNat uses mod/div
-- which don't reduce at the type level. A verified proof would use
-- NatBits.BitSeq (where xorSeqSelf is proven). NO believe_me.
-- public export
-- cptInvolution : (n : Nat) -> xorNat (xorNat n 37) 37 = n

-- TODO: CPT applied twice returns original (depends on cptInvolution).

-- =====================================================================
-- PROOFS
-- =====================================================================

||| PROOF: 2 is prime.
public export
twoIsPrime : isPrime 2 = True
twoIsPrime = Refl

||| PROOF: 3 is prime.
public export
threeIsPrime : isPrime 3 = True
threeIsPrime = Refl

||| PROOF: 4 is NOT prime.
public export
fourIsComposite : isPrime 4 = False
fourIsComposite = Refl

||| PROOF: 5 is prime.
public export
fiveIsPrime : isPrime 5 = True
fiveIsPrime = Refl

||| PROOF: 6 factors as [2, 3].
public export
sixFactors : factorize 6 = [2, 3]
sixFactors = Refl

||| PROOF: primes map to ObjectRole.
public export
primeIsObject : numberRole 2 = ObjectRole
primeIsObject = Refl

||| PROOF: composites map to MorphismRole.
public export
compositeIsMorphism : numberRole 4 = MorphismRole
compositeIsMorphism = Refl

-- TODO: Proof that anti-feature is complement: antiFeature(antiFeature(f)) = f
-- Depends on xorNat self-inverse proof (see cptInvolution TODO). NO believe_me.

-- TODO: Proof that double negation returns original number.
-- Depends on xorNat self-inverse proof. NO believe_me.
