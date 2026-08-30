||| HARNESS.idr — Verified Idris 2 pattern reference.
||| Compile: idris2 --check HARNESS.idr
||| Every pattern below compiles. Read before writing any .idr file.
module HARNESS

-- ═══════════════════════════════════════════════════════════════
-- RULE 1: Module name must match filename (no dots, no underscores)
-- ═══════════════════════════════════════════════════════════════
--  ✗ module trail_index.Ontology  → "Expected a capitalised identifier"
--  ✗ module Foo.Bar in Foo/Bar.idr → OK if you make the directory
--  ✓ module HARNESS               → filename HARNESS.idr

-- ═══════════════════════════════════════════════════════════════
-- RULE 2: public export or nothing
-- ═══════════════════════════════════════════════════════════════
--  ✗ data Foo = A | B       → private (can't be used from other modules)
--  ✓ public export data Foo = A | B

public export data Visibility = Public | Private

-- ═══════════════════════════════════════════════════════════════
-- RULE 3: data type constructors each on their own line (style)
-- ═══════════════════════════════════════════════════════════════
public export
data Color = Red | Green | Blue

-- ═══════════════════════════════════════════════════════════════
-- RULE 4: Records with explicit constructor
-- ═══════════════════════════════════════════════════════════════
public export
record Person where
  constructor MkPerson
  name : String
  age  : Int

-- Access: p.name  (dot notation on record)

-- ═══════════════════════════════════════════════════════════════
-- RULE 5: Type-level proofs (dependent types)
-- ═══════════════════════════════════════════════════════════════
-- Each constructor IS the proof.
public export
data Even : Nat -> Type where
  ZeroEven : Even Z
  StepEven : Even n -> Even (S (S n))

-- ═══════════════════════════════════════════════════════════════
-- RULE 6: DPair (dependent pair) syntax
-- ═══════════════════════════════════════════════════════════════
--  ✗ There is no \case in Idris (that's Haskell)
--  ✓ Use explicit lambda or a helper function

public export
data Tagged : Type where
  MkTagged : (t : Type) -> t -> Tagged

-- Construction: (t ** value)
exDPair : (Nat ** String)
exDPair = (42 ** "hello")

-- Destructuring: use a helper
exUseDPair : (n : Nat ** String) -> String
exUseDPair (n ** s) = s  -- OK: pattern match in args

-- Destructuring in lambda:
--   map (\(n ** s) => s) [(10 ** "a"), (20 ** "b")]
--   ✓ This compiles. Note: parentheses around the pattern.

-- ═══════════════════════════════════════════════════════════════
-- RULE 7: Implicit arguments
-- ═══════════════════════════════════════════════════════════════
-- Top-level free variables become implicit arguments.
-- renderAt : Nat -> Tree t -> String
--   means renderAt : {t : OType} -> Nat -> Tree t -> String

-- To be explicit:
public export
demoImplicit : {t : Type} -> t -> t
demoImplicit x = x

-- Call: demoImplicit 42  → t := Integer, returns 42
-- Call: demoImplicit "x" → t := String, returns "x"

-- ═══════════════════════════════════════════════════════════════
-- RULE 8: auto- search for proofs
-- ═══════════════════════════════════════════════════════════════
public export
data IsRed : Color -> Type where
  ItIsRed : IsRed Red

public export
needsRed : {auto p : IsRed c} -> String
needsRed = "got red"

-- Call: needsRed {c=Red}  → auto finds ItIsRed : IsRed Red

-- ═══════════════════════════════════════════════════════════════
-- RULE 9: Maybe is available, pattern match with Nothing/Just
-- ═══════════════════════════════════════════════════════════════
public export
safeDiv : Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv n m = Just (n `div` m)

-- ═══════════════════════════════════════════════════════════════
-- RULE 10: So for Bool proofs (prelude)
-- ═══════════════════════════════════════════════════════════════
public export
isPositive : Int -> Bool
isPositive x = x > 0

-- So (isPositive 5)  →  Oh  (type-checks because isPositive 5 = True)
-- So (isPositive 0)  →  type error (isPositive 0 = False, So False has no constructors)

public export
needPositive : (x : Int) -> So (isPositive x) -> String
needPositive x _ = show x ++ " is positive"

-- ═══════════════════════════════════════════════════════════════
-- RULE 11: Recursive functions on indexed types need explicit
--          polymorphic helpers (common pitfall!)
-- ═══════════════════════════════════════════════════════════════

public export
data MyTree : Type -> Type where
  MyLeaf   : a -> MyTree a
  MyBranch : a -> List (MyTree a) -> MyTree a

-- ✅ This WORKS because MyTree is parameterized (not indexed):
public export
mySize : MyTree a -> Nat
mySize (MyLeaf _) = 1
mySize (MyBranch _ cs) = 1 + sum (map mySize cs)

-- For indexed types (Tree : OType -> Type), the OType changes
-- in children. You need to make the recurse function polymorphic:

public export
data ITree : OType -> Type where
  ILeaf   : NodeData -> ITree t
  IBranch : NodeData -> List (s : OType ** (ITree s, Valid t s)) -> ITree t
  -- Note: Valid t s comes from Ontology

-- ✅ Helper to extract tree from DPair:
public export
ichildTree : (s : OType ** (ITree s, Valid t s)) -> ITree s
ichildTree (s ** (tr, _)) = tr

-- ✅ size works because it's polymorphic:
public export
isize : ITree t -> Nat
isize (ILeaf _) = 1
isize (IBranch _ cs) = 1 + sum (map (isize . ichildTree) cs)

-- ═══════════════════════════════════════════════════════════════
-- RULE 12: DO NOT use \case or lambda-case
-- ═══════════════════════════════════════════════════════════════
--  ✗ map (\case (s ** (tr, _)) => size tr) cs
--  ✓ map (\(s ** (tr, _)) => size tr) cs
--  ✓ map (size . childTree) cs           (cleanest)

-- ═══════════════════════════════════════════════════════════════
-- RULE 13: Show instances by defining show
-- ═══════════════════════════════════════════════════════════════
public export
Show Color where
  show Red = "Red"
  show Green = "Green"
  show Blue = "Blue"

-- ═══════════════════════════════════════════════════════════════
-- RULE 14: Eq and Ord instances need explicit implementations
-- ═══════════════════════════════════════════════════════════════
public export
Eq Color where
  (==) Red Red = True
  (==) Green Green = True
  (==) Blue Blue = True
  (==) _ _ = False

public export
Ord Color where
  compare Red Red = EQ
  compare Red _ = LT
  compare _ Red = GT
  compare Green Green = EQ
  compare Green _ = LT
  compare _ Green = GT
  compare Blue Blue = EQ

-- ═══════════════════════════════════════════════════════════════
-- RULE 15: Import only what you use
-- ═══════════════════════════════════════════════════════════════
-- import Ontology
-- import Tree
-- import Data.Vect      -- if you need Vect
-- import Data.SortedSet -- if you need SortedSet
