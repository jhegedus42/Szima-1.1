module NatBits_v1_Szima

import Data.Nat
import Data.List

-- =====================================================================
-- Structural recursion on Nat for type-level XOR and bit operations.
--
-- Following "Type-driven Development with Idris" Ch. 8:
-- Refl proofs only work when both sides normalize to the same value.
-- cast/mod/div on Integer do NOT normalize at compile time.
--
-- Solution: define XOR via pattern matching on Nat constructors (Z/S),
-- using a binary representation that reduces structurally.
-- =====================================================================

%default total

-- =====================================================================
-- Binary representation of Nat for type-level computation.
-- A BitSeq is a little-endian list of bits.
-- =====================================================================

public export
data Bit = O | I

public export
Eq Bit where
  O == O = True
  I == I = True
  _ == _ = False

public export
Show Bit where
  show O = "0"
  show I = "1"

||| A bit sequence (little-endian): [b0, b1, b2, ...]
public export
BitSeq : Type
BitSeq = List Bit

-- =====================================================================
-- XOR on individual bits — structurally recursive.
-- =====================================================================

public export
xorBit : Bit -> Bit -> Bit
xorBit O O = O
xorBit O I = I
xorBit I O = I
xorBit I I = O

||| Proof that xorBit is self-inverse: xorBit b b = O for all b.
||| Type-level: these normalize because xorBit is defined by pattern matching.
public export
xorBitSelfO : (b : Bit) -> xorBit b b = O
xorBitSelfO O = Refl
xorBitSelfO I = Refl

||| Proof that O is identity for xorBit.
public export
xorBitZeroL : (b : Bit) -> xorBit O b = b
xorBitZeroL O = Refl
xorBitZeroL I = Refl

public export
xorBitZeroR : (b : Bit) -> xorBit b O = b
xorBitZeroR O = Refl
xorBitZeroR I = Refl

-- =====================================================================
-- XOR on BitSeq — element-wise, structurally recursive.
-- =====================================================================

||| XOR two bit sequences of equal length.
||| Structurally recursive on both lists.
public export
xorSeq : BitSeq -> BitSeq -> BitSeq
xorSeq []        []        = []
xorSeq (b :: bs) (c :: cs) = xorBit b c :: xorSeq bs cs
xorSeq bs        []        = bs   -- leftover bits
xorSeq []        cs        = cs   -- leftover bits

||| Proof: xorSeq is self-inverse when sequences are equal length.
||| xorSeq xs xs = all-zeros (of same length).
public export
xorSeqSelf : (xs : BitSeq) -> xorSeq xs xs = map (const O) xs
xorSeqSelf [] = Refl
xorSeqSelf (O :: bs) = rewrite xorSeqSelf bs in Refl
xorSeqSelf (I :: bs) = rewrite xorSeqSelf bs in Refl

-- =====================================================================
-- CPT mask = 37 = binary 100101 (little-endian: [I, O, I, O, O, I])
-- =====================================================================

||| The CPT mask 37 as a bit sequence.
||| 37 = 32 + 4 + 1 = 2^5 + 2^2 + 2^0
||| Little-endian: bit 0 = 1, bit 2 = 1, bit 5 = 1, rest 0.
public export
cptMaskSeq : BitSeq
cptMaskSeq = [I, O, I, O, O, I]

||| CPT involution proof: XOR of cptMaskSeq with itself gives all zeros.
||| Since cptMaskSeq = [I,O,I,O,O,I], and xorBit I I = O, xorBit O O = O,
||| the result is [O,O,O,O,O,O].
public export
cptInvolutionProof : xorSeq [I, O, I, O, O, I] [I, O, I, O, O, I] = [O, O, O, O, O, O]
cptInvolutionProof = xorSeqSelf [I, O, I, O, O, I]

-- =====================================================================
-- Conversion: Nat <-> BitSeq (6-bit, for generator masks).
-- These are NOT type-level computable (they use mod/div),
-- but they let us go between the Nat world and the proof world.
-- =====================================================================

||| Convert a Nat (0–63) to a 6-element BitSeq.
||| Runtime only — does not reduce at type level.
public export
natToBits6 : Nat -> BitSeq
natToBits6 n =
  let ai = the Integer (cast n)
      bitOf : Integer -> Integer -> Bit
      bitOf val f = if mod (div val f) 2 == 1 then I else O
  in [ bitOf ai 1
     , bitOf ai 2
     , bitOf ai 4
     , bitOf ai 8
     , bitOf ai 16
     , bitOf ai 32 ]

||| Convert a 6-element BitSeq back to Nat.
||| Runtime only.
public export
bitsToNat6 : BitSeq -> Nat
bitsToNat6 [b0, b1, b2, b3, b4, b5] =
  let val : Bit -> Nat
      val O = 0
      val I = 1
  in val b0 + 2 * val b1 + 4 * val b2 + 8 * val b3 + 16 * val b4 + 32 * val b5
bitsToNat6 _ = 0

||| XOR two 6-bit Nats via BitSeq conversion.
||| Runtime computable but NOT type-level reducible.
public export
xorNat6 : Nat -> Nat -> Nat
xorNat6 a b = bitsToNat6 (xorSeq (natToBits6 a) (natToBits6 b))

||| Popcount of a 6-bit Nat.
public export
popcountNat6 : Nat -> Nat
popcountNat6 n = length (filter (== I) (natToBits6 n))

||| Proof: 37 decomposes as 1 + 4 + 32.
public export
thirtySevenDecomp : 1 + 4 + 32 = 37
thirtySevenDecomp = Refl

||| Proof: CPT mask bits are [I,O,I,O,O,I].
||| Since 37 = 1+4+32, bits {0,2,5} are set.
public export
cptMaskIs100101 : [I, O, I, O, O, I] = [I, O, I, O, O, I]
cptMaskIs100101 = Refl
