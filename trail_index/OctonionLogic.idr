module OctonionLogic

||| The 8 truth values of octonion logic.
||| 1 = definite truth (scalar)
||| e1..e7 = qualified modes: causal, hypothetical, modal, temporal, etc.
public export
data OctVal = R | I1 | I2 | I3 | I4 | I5 | I6 | I7

public export
Show OctVal where
  show R  = "1"
  show I1 = "e1"; show I2 = "e2"; show I3 = "e3"; show I4 = "e4"
  show I5 = "e5"; show I6 = "e6"; show I7 = "e7"

||| Truth modes assigned to each octonion dimension.
public export
data Mode : OctVal -> Type where
  Definite   : Mode R     -- scalar truth
  Causal     : Mode I1    -- why / because
  Deductive  : Mode I2    -- therefore
  Hypothetical : Mode I3  -- if / then
  Temporal   : Mode I4    -- before / after / during
  Modal      : Mode I5    -- possible / necessary
  Deontic    : Mode I6    -- ought / permitted
  Epistemic  : Mode I7    -- known / believed

||| Octonion multiplication (Fano plane).
||| Truth values combine according to octonion structure.
public export
octMul : OctVal -> OctVal -> OctVal
-- Scalar
octMul R  x = x
octMul x  R = x
-- Fano plane lines: (I1,I2,I4), (I2,I3,I5), (I3,I4,I6),
--                   (I4,I5,I7), (I5,I6,I1), (I6,I7,I2), (I7,I1,I3)
octMul I1 I2 = I4; octMul I2 I1 = I4
octMul I2 I4 = I1; octMul I4 I2 = I1
octMul I4 I1 = I2; octMul I1 I4 = I2
octMul I2 I3 = I5; octMul I3 I2 = I5
octMul I3 I5 = I2; octMul I5 I3 = I2
octMul I5 I2 = I3; octMul I2 I5 = I3
octMul I3 I4 = I6; octMul I4 I3 = I6
octMul I4 I6 = I3; octMul I6 I4 = I3
octMul I6 I3 = I4; octMul I3 I6 = I4
octMul I4 I5 = I7; octMul I5 I4 = I7
octMul I5 I7 = I4; octMul I7 I5 = I4
octMul I7 I4 = I5; octMul I4 I7 = I5
octMul I5 I6 = I1; octMul I6 I5 = I1
octMul I6 I1 = I5; octMul I1 I6 = I5
octMul I1 I5 = I6; octMul I5 I1 = I6
octMul I6 I7 = I2; octMul I7 I6 = I2
octMul I7 I2 = I6; octMul I2 I7 = I6
octMul I2 I6 = I7; octMul I6 I2 = I7
octMul I7 I1 = I3; octMul I1 I7 = I3
octMul I1 I3 = I7; octMul I3 I1 = I7
octMul I3 I7 = I1; octMul I7 I3 = I1
-- Diagonal: non-associative, non-commutative
octMul I1 I1 = R; octMul I2 I2 = R; octMul I3 I3 = R
octMul I4 I4 = R; octMul I5 I5 = R; octMul I6 I6 = R; octMul I7 I7 = R

||| Octonion negation (conjugation flips all imaginary signs).
public export
octNeg : OctVal -> OctVal
octNeg R  = R
octNeg x  = x  -- in characteristic 2, negation is identity for imaginaries

||| Octonion addition (Z2 XOR for truth values).
public export
octAdd : OctVal -> OctVal -> OctVal
octAdd R  R  = R
octAdd R  x  = x
octAdd x  R  = x
octAdd I1 I1 = R; octAdd I2 I2 = R; octAdd I3 I3 = R
octAdd I4 I4 = R; octAdd I5 I5 = R; octAdd I6 I6 = R; octAdd I7 I7 = R
octAdd I1 I2 = I3; octAdd I2 I1 = I3
octAdd I1 I3 = I2; octAdd I3 I1 = I2
octAdd I2 I3 = I1; octAdd I3 I2 = I1
octAdd I4 I5 = I6; octAdd I5 I4 = I6
octAdd I4 I6 = I5; octAdd I6 I4 = I5
octAdd I5 I6 = I4; octAdd I6 I5 = I4
octAdd I1 I4 = I5; octAdd I4 I1 = I5
octAdd I1 I5 = I4; octAdd I5 I1 = I4
octAdd I1 I6 = I7; octAdd I6 I1 = I7
octAdd I1 I7 = I6; octAdd I7 I1 = I6
octAdd I2 I4 = I6; octAdd I4 I2 = I6
octAdd I2 I5 = I7; octAdd I5 I2 = I7
octAdd I2 I6 = I4; octAdd I6 I2 = I4
octAdd I2 I7 = I5; octAdd I7 I2 = I5
octAdd I3 I4 = I7; octAdd I4 I3 = I7
octAdd I3 I5 = I6; octAdd I5 I3 = I6
octAdd I3 I6 = I5; octAdd I6 I3 = I5
octAdd I3 I7 = I4; octAdd I7 I3 = I4
octAdd I4 I7 = I3; octAdd I7 I4 = I3
octAdd I5 I7 = I2; octAdd I7 I5 = I2
octAdd I6 I7 = I1; octAdd I7 I6 = I1

||| Octonion implication: a -> b = ¬a + (a × b)
public export
octImp : OctVal -> OctVal -> OctVal
octImp a b = octAdd (octNeg a) (octMul a b)

||| A proposition tagged by its octonion truth mode.
public export
data Prop : OctVal -> Type where
  MkProp : String -> Prop v

  And      : Prop a -> Prop b -> Prop (octMul a b)
  Or       : Prop a -> Prop b -> Prop (octAdd a b)
  Not      : Prop a -> Prop (octNeg a)
  Implies  : Prop a -> Prop b -> Prop (octImp a b)
  Because  : Prop a -> Prop b -> Prop (octMul a b)    -- causal: a because b
  Therefore : Prop a -> Prop b -> Prop (octMul a b)    -- deductive: a therefore b
  Why      : Prop a -> Prop (octMul a I1)              -- why a? → causal mode
  How      : Prop a -> Prop (octMul a I2)              -- how a? → deductive mode
  Iff      : Prop a -> Prop b -> Prop (octAdd a b)     -- iff = equivalence

||| A judgement: a proposition with a proof and confidence.
public export
record Judgement (v : OctVal) where
  constructor MkJudgement
  prop       : Prop v
  confidence : Double
  source     : String    -- provenance: reader id, book, line

||| Inference rule: given antecedents, derive consequent.
||| The truth value propagates via octonion multiplication.
public export
data Inference : (antecedents : List OctVal) -> (consequent : OctVal) -> Type where
  ModusPonens    : Inference [a, octImp a b] b
  CausalChain    : Inference [octMul a I1, octMul b I1] (octMul a I1)   -- causal chain
  DeductiveChain : Inference [octMul a I2, octMul b I2] (octMul a I2)   -- deductive chain
  AndIntro       : Inference [a, b] (octMul a b)
  OrIntro        : Inference [a, b] (octAdd a b)

||| Proof that a value is in a list.
public export
data InList : a -> List a -> Type where
  Here  : InList x (x :: xs)
  There : InList x xs -> InList x (y :: xs)

||| Searchable index: forward chain from known judgements.
public export
data ForwardChain : (start : List OctVal) -> (target : OctVal) -> Type where
  FStop : InList v vs -> ForwardChain vs v
  FStep : Inference as b 
       -> ForwardChain (as ++ vs) b 
       -> ForwardChain vs b

||| Backward chain: from goal, find what antecedents would prove it.
public export
data BackwardChain : (goal : OctVal) -> (needed : List OctVal) -> Type where
  BStop  : BackwardChain g [g]
  BStep  : Inference as g -> BackwardChain g as
  BAnd   : BackwardChain g as -> BackwardChain g bs -> BackwardChain g (as ++ bs)
