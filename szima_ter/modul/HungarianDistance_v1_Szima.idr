module HungarianDistance_v1_Szima

import Data.List
import Data.Maybe
import Data.Nat
import Data.String
import MagyarNyelvtanKcode_v1_Szima

-- =====================================================================
-- Hungarian word distance metrics based on morphological features
-- Implements bitwise operations on Nat manually (no Bits instance needed)
-- =====================================================================

||| Distance metric type: different metrics for different word types
public export
data DistanceMetric = 
    NounDistance    -- Nouns use case/number/possession features
  | VerbDistance    -- Verbs use tense/mood/definiteness features  
  | AdjDistance     -- Adjectives use comparison/degree features
  | OtherDistance   -- Other words use simpler string/phonetic metrics

||| Test if the n-th bit (0-indexed) is set in a Nat
public export
bitSet : Nat -> Nat -> Bool
bitSet n bits =
  if n == 0
     then (mod bits 2) /= 0
     else bitSet (minus n 1) (div bits 2)

||| Bitwise XOR on Nat (treats them as non-negative integers)
public export
xorNat : Nat -> Nat -> Nat
xorNat 0 m = m
xorNat n 0 = n
xorNat n m =
  let lb1 = mod n 2
      lb2 = mod m 2
      rest = xorNat (div n 2) (div m 2)
      thisBit = if lb1 == lb2 then 0 else 1
  in rest * 2 + thisBit

||| Bitwise AND on Nat
public export
andNat : Nat -> Nat -> Nat
andNat 0 _ = 0
andNat _ 0 = 0
andNat n m =
  let lb1 = mod n 2
      lb2 = mod m 2
      rest = andNat (div n 2) (div m 2)
      thisBit = if lb1 /= 0 && lb2 /= 0 then 1 else 0
  in rest * 2 + thisBit

||| Count the number of set bits in a Nat
public export
popCountNat : Nat -> Nat
popCountNat 0 = 0
popCountNat n = (mod n 2) + popCountNat (div n 2)

||| Equality for Harmony (since the base module only has Show)
eqHarmony : Harmony -> Harmony -> Bool
eqHarmony Back  Back  = True
eqHarmony Front Front = True
eqHarmony Mixed Mixed = True
eqHarmony _     _     = False

||| Get the appropriate distance metric for a word based on morphological analysis
public export
getDistanceMetric : String -> DistanceMetric
getDistanceMetric word = 
  case analyze word of
    MkAnalysis _ _ _ _ => NounDistance  -- Default to noun for now

||| Hamming distance between two bit patterns (feature vectors)
public export
hammingDistance : Nat -> Nat -> Nat
hammingDistance a b = popCountNat (xorNat a b)

||| Weighted feature distance based on grammatical importance
||| Different features have different weights for different word types
public export
weightedFeatureDistance : DistanceMetric -> Nat -> Nat -> Nat
weightedFeatureDistance NounDistance feats1 feats2 = 
  let diff = xorNat feats1 feats2
      -- Weight number difference heavily (bit 2 = value 4)
      numberDiff = if bitSet 2 diff then 10 else 0
      -- Weight case differences (bits 0,1,3,4,5)
      caseDiff = popCountNat (andNat diff 59) * 2
  in numberDiff + caseDiff

weightedFeatureDistance VerbDistance feats1 feats2 = 
  let diff = xorNat feats1 feats2
      tenseDiff = if bitSet 3 diff then 12 else 0
      defDiff = if bitSet 1 diff then 8 else 0
      otherDiff = popCountNat (andNat diff 53)
  in tenseDiff + defDiff + otherDiff

weightedFeatureDistance AdjDistance feats1 feats2 = 
  hammingDistance feats1 feats2 * 3

weightedFeatureDistance OtherDistance feats1 feats2 = 
  if feats1 == feats2 then 0 else 5

||| Natural subtraction clamped to 0 (avoids needing Neg Nat)
minusNat : Nat -> Nat -> Nat
minusNat Z _ = 0
minusNat n Z = n
minusNat (S n) (S m) = minusNat n m

||| String similarity using edit distance (Levenshtein)
public export
editDistance : String -> String -> Nat
editDistance s1 s2 = editDist (unpack s1) (unpack s2)
  where
    editDist : List Char -> List Char -> Nat
    editDist [] ys = length ys
    editDist xs [] = length xs
    editDist (x :: xs) (y :: ys) =
      if x == y
         then editDist xs ys
         else 1 + minimum [editDist xs (y :: ys), editDist (x :: xs) ys, editDist xs ys]

||| Phonological distance based on vowel harmony and consonant changes
public export
phonologicalDistance : String -> String -> Nat
phonologicalDistance w1 w2 = 
  let h1 = wordHarmony w1
      h2 = wordHarmony w2
      harmonyDiff = if eqHarmony h1 h2 then 0 else 3
      stringDiff = div (editDistance w1 w2) 2
  in harmonyDiff + stringDiff

||| Comprehensive Hungarian word distance
||| Combines morphological, phonological, and string-based metrics
public export
hungarianWordDistance : String -> String -> Nat
hungarianWordDistance w1 w2 =
  let metric = getDistanceMetric w1
      analysis1 = analyze w1
      analysis2 = analyze w2
      featDist = weightedFeatureDistance metric (totalFeat analysis1) (totalFeat analysis2)
      phoneDist = phonologicalDistance w1 w2
      rootDist = editDistance (root analysis1) (root analysis2) * 2
  in featDist + phoneDist + rootDist

||| Test the distance function with examples
public export
testDistances : List (String, String, Nat)
testDistances = 
  [ ("ház", "házak", 4)
  , ("ház", "házban", 2)
  , ("ház", "fut", 20)
  , ("fut", "futott", 8)
  , ("szó", "szavak", 5)
  ]

||| Validate distance calculations (no subtraction — use clamped comparison)
public export
validateDistances : IO ()
validateDistances = do
  putStrLn "Validating Hungarian word distances:"
  traverse_ (\(w1, w2, expected) => 
    let actual = hungarianWordDistance w1 w2
        lowerBound = expected
        upperBound = expected + 5
        ok = actual >= lowerBound && actual <= upperBound
        status = if ok then "PASS" else "FAIL"
    in putStrLn $ status ++ " " ++ w1 ++ " vs " ++ w2 ++ " = " ++ show actual ++ " (expected " ++ show lowerBound ++ "-" ++ show upperBound ++ ")")
    testDistances
