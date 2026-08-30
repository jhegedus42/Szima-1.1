module CategoryTheory_v1_Szima

import Data.Nat

%default partial

-- =====================================================================
-- Category Theory in Idris Types
-- Based on: Steve Awodey, "Category Theory" (Oxford, 2006)
-- and Lean 4 Theorem Proving: Propositions and Proofs
-- No believe_me. Reductio ad absurdum only.
-- =====================================================================

-- =====================================================================
-- Chapter 1: CATEGORIES
-- =====================================================================

public export
record Category where
  constructor MkCat
  catObj  : Type
  catHom  : (a, b : catObj) -> Type
  catId   : (a : catObj) -> catHom a a
  catComp : {a, b, c : catObj} -> catHom a b -> catHom b c -> catHom a c

-- =====================================================================
-- Chapter 2: PRODUCTS
-- =====================================================================

public export
record ProductC (cat : Category) (a, b : catObj cat) where
  constructor MkProdC
  prodObj : catObj cat
  prodPi1 : catHom cat prodObj a
  prodPi2 : catHom cat prodObj b

-- =====================================================================
-- Chapter 3: COPRODUCTS (duality)
-- =====================================================================

public export
record CoproductC (cat : Category) (a, b : catObj cat) where
  constructor MkCoprodC
  coprodObj : catObj cat
  coprodI1  : catHom cat a coprodObj
  coprodI2  : catHom cat b coprodObj

-- =====================================================================
-- Chapter 7: FUNCTORS
-- =====================================================================

public export
record FunctorC (cat1, cat2 : Category) where
  constructor MkFuncC
  funcObj : catObj cat1 -> catObj cat2
  funcHom : (a, b : catObj cat1) -> catHom cat1 a b -> catHom cat2 (funcObj a) (funcObj b)

-- =====================================================================
-- Chapter 7: NATURAL TRANSFORMATIONS
-- =====================================================================

public export
record NatTransC (cat1, cat2 : Category) (F, G : FunctorC cat1 cat2) where
  constructor MkNTC
  ntComp : (a : catObj cat1) -> catHom cat2 (funcObj F a) (funcObj G a)

-- =====================================================================
-- Chapter 9: ADJOINTS
-- =====================================================================

public export
record AdjunctionC (cat1, cat2 : Category) where
  constructor MkAdjC
  leftAdj  : FunctorC cat1 cat2
  rightAdj : FunctorC cat2 cat1
  unit     : (a : catObj cat1) -> catHom cat1 a (funcObj rightAdj (funcObj leftAdj a))
  counit   : (b : catObj cat2) -> catHom cat2 (funcObj leftAdj (funcObj rightAdj b)) b

-- =====================================================================
-- Chapter 9.5: QUANTIFIERS AS ADJOINTS
--
-- Existential = dependent pair (Sigma type): (a ** P a)
-- Universal  = dependent function (Pi type): (a : A) -> P a
--
-- These are not aliases — they ARE the quantifiers, directly.
-- =====================================================================

-- Existential quantifier = Sigma type (witness + proof)
-- ExistsQ A P = (a : A ** P a)  — written inline where needed.

-- Universal quantifier = Pi type (function from all a to proof)
-- ForallQ A P = (a : A) -> P a  — written inline where needed.

-- =====================================================================
-- Chapter 10: MONADS
-- =====================================================================

public export
record MonadC (cat : Category) where
  constructor MkMonadC
  monadFunctor : FunctorC cat cat
  monadUnit    : (a : catObj cat) -> catHom cat a (funcObj monadFunctor a)
  monadMult    : (a : catObj cat) -> catHom cat (funcObj monadFunctor (funcObj monadFunctor a)) (funcObj monadFunctor a)

-- =====================================================================
-- THE CATEGORY OF TYPES
-- =====================================================================

public export
TypeCategory : Category
TypeCategory = MkCat
  Type
  (\a, b => a -> b)
  (\a => id)
  (\f, g => g . f)

-- =====================================================================
-- PROOFS (Lean 4 style: propositions as types)
-- =====================================================================

-- Function composition is associative
public export
typeAssoc : (a, b, c, d : Type) ->
            (f : a -> b) -> (g : b -> c) -> (h : c -> d) ->
            ((h . g) . f) = (h . (g . f))
typeAssoc a b c d f g h = Refl

-- n + 0 = n  (use Prelude's plusZeroRightNeutral directly)

-- S(n + m) = n + S m  (helper lemma, same as tutorial's psuccRightSucc)
public export
addSuccRight : (n, m : Nat) -> S (n + m) = n + S m
addSuccRight 0 m = Refl
addSuccRight (S n) m = cong S (addSuccRight n m)

-- 0 + n = n
public export
addZeroLeft : (n : Nat) -> 0 + n = n
addZeroLeft n = Refl

-- Commutativity of addition (by induction, no believe_me)
-- Pattern from idris2-tutorial/src/Solutions/Eq.idr
public export
addComm : (n, m : Nat) -> n + m = m + n
addComm 0 m = rewrite plusZeroRightNeutral m in Refl
addComm (S n) m =
  rewrite sym (addSuccRight m n) in
  cong S (addComm n m)

-- Modus ponens: (p -> q) -> p -> q
public export
modusP : (0 p : Type) -> (0 q : Type) -> (p -> q) -> p -> q
modusP p q impl val = impl val

-- Hypothetical syllogism: (p -> q) -> (q -> r) -> (p -> r)
public export
hypSyl : (0 p, q, r : Type) -> (p -> q) -> (q -> r) -> (p -> r)
hypSyl p q r impl1 impl2 x = impl2 (impl1 x)

-- Reductio ad absurdum: if assuming Not p leads to Void, then p holds
-- This is constructive reductio: (Not p -> Void) -> p is NOT constructive.
-- But (p -> Void) -> Not p IS constructive (definition of negation).
public export
negIntro : (0 p : Type) -> (p -> Void) -> Not p
negIntro p f x = f x

-- Contrapositive: (p -> q) -> (Not q -> Not p)
public export
contrapositive : (0 p, q : Type) -> (p -> q) -> (Not q -> Not p)
contrapositive p q impl nq x = nq (impl x)