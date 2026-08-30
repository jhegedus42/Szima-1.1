module E8Code

import Data.Vect

||| E8 lattice coordinates as an 8-tuple of integers.
public export
record E8Vec where
  constructor MKE8
  c1 : Int; c2 : Int; c3 : Int; c4 : Int
  c5 : Int; c6 : Int; c7 : Int; c8 : Int

||| Clifford algebra Cl(8) blade indexed by 8-bit mask.
||| ab = a·b + a∧b → inner = overlap (redundant), outer = novelty.
public export
data Blade : Int -> Type where
  S  : Blade 0
  E1 : Blade 1;  E2 : Blade 2;  E3 : Blade 4;  E4 : Blade 8
  E5 : Blade 16; E6 : Blade 32; E7 : Blade 64; E8 : Blade 128

||| A code word in the E8 lattice with Cl(8) decomposition.
public export
record CodeWord where
  constructor MkCW
  label : String
  embed : E8Vec
  inner : Int
  outer : Int

||| Overlap threshold for redundancy detection.
public export
overlapThreshold : Double
overlapThreshold = 0.8

public export
data DropOrKeep = DropB | KeepBoth

public export
decide : Double -> DropOrKeep
decide o = if o > overlapThreshold then DropB else KeepBoth

public export
overlap : CodeWord -> CodeWord -> Double
overlap a b =
  let dot = a.inner * b.inner + a.outer * b.outer
      na  = a.inner * a.inner + a.outer * a.outer
      nb  = b.inner * b.inner + b.outer * b.outer
  in cast dot / cast (na + nb + 1)

||| Convolutional code state: evolves at each step (not static).
||| The case at step t depends on case at step t-1.
public export
record ConvState where
  constructor MkState
  prevInner : Int
  prevOuter : Int
  step      : Nat

public export
initState : ConvState
initState = MkState 0 0 0

||| E8 parity syndrome: 8-bit vector from parity-check.
||| Classical code constraint: syndrome must be zero for valid code words.
public export
record Syndrome where
  constructor MkSyn
  bits : Vect 8 Int

||| Convolutional step: encode (input, state) → (output, newState).
||| The code is NOT static — output depends on accumulation of all prior inputs.
public export
record ConvStep where
  constructor MkConv
  input     : Int     -- case code (5 bits → sub-code of E8)
  prevState : ConvState
  output    : CodeWord
  syndrome  : Syndrome
  nextState : ConvState

||| Validate that syndrome is zero (valid E8 code word).
public export
data ValidCode : CodeWord -> Type where
  IsValid : Syndrome -> ValidCode cw
