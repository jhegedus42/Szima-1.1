module MagyarNyelvtanKcode_v1_Szima

import Data.String
import Data.List

-- =====================================================================
-- Hungarian morphological analyser in Idris
-- Built for the baby-AI / Stabilizer framework.
--
-- Hungarian is agglutinative: root + suffix1 + suffix2 + ...
-- Each suffix encodes features mapped to the 6 generators:
--   g1 = vowel harmony / space   (bit 0)
--   g2 = definiteness            (bit 1)
--   g3 = number                  (bit 2)
--   g4 = tense / time            (bit 3)
--   g5 = mood                    (bit 4)
--   g6 = possession              (bit 5)
--
-- The CPT mask = g1 `xor` g4 `xor` g6 = bits 0,3,5 = 37.
-- =====================================================================

||| Vowel-harmony class of a word.
public export
data Harmony = Back | Front | Mixed

public export
Show Harmony where
  show Back  = "Back"
  show Front = "Front"
  show Mixed = "Mixed"

||| Is a character a vowel? Returns the vowel or Nothing.
isVowel : Char -> Maybe Char
isVowel c =
  if elem c (unpack "aáeéiíoóöőuúüű")
     then Just c
     else Nothing

||| Classify a single vowel as Back or Front.
vowelHarmony : Char -> Harmony
vowelHarmony c =
  if elem c (unpack "aáoóuú")      then Back
  else if elem c (unpack "eéiíöőüű") then Front
  else Mixed

||| Last element of a list, safe version.
lastSafe : List a -> Maybe a
lastSafe [] = Nothing
lastSafe [x] = Just x
lastSafe (x :: xs) = lastSafe xs

||| Compute the harmony of a whole word (last vowel wins in Hungarian).
public export
wordHarmony : String -> Harmony
wordHarmony w =
  let vs = mapMaybe isVowel (unpack w)
  in case lastSafe vs of
       Nothing => Mixed
       Just v  => vowelHarmony v

-- =====================================================================
-- Suffix table: (suffix_string, feature_bits)
-- Feature bits encode which generators are active.
-- =====================================================================

||| A suffix entry: the string form and its feature mask.
public export
record Suffix where
  constructor MkSuffix
  sfx    : String
  feat   : Nat       -- bit pattern: g1=1, g2=2, g3=4, g4=8, g5=16, g6=32
  name   : String    -- grammatical label, e.g. "Pl", "Acc", "Iness"

||| Hungarian nominal suffixes, back-vowel forms first.
||| The feat encodes the 6 generators as bits 0–5.
public export
suffixes : List Suffix
suffixes =
  -- 5-letter suffixes
  [ MkSuffix "jatok" 16 "Imp2Pl"
  , MkSuffix "ötök"  32 "Poss2Pl(front)"
  -- 4-letter suffixes
  , MkSuffix "otok" 32 "Poss2Pl(back)"
  , MkSuffix "etek" 32 "Poss2Pl(front)"
  -- 3-letter suffixes
  , MkSuffix "ban" 1  "Iness(back)"
  , MkSuffix "ben" 1  "Iness(front)"
  , MkSuffix "ból" 1  "Ela(back)"
  , MkSuffix "ből" 1  "Ela(front)"
  , MkSuffix "ból" 1  "Ela(back)"
  , MkSuffix "ról" 1  "Del(back)"
  , MkSuffix "ről" 1  "Del(front)"
  , MkSuffix "hoz" 1  "All(back)"
  , MkSuffix "hez" 1  "All(front)"
  , MkSuffix "höz" 1  "All(front)"
  , MkSuffix "nál" 1  "Ade(back)"
  , MkSuffix "nél" 1  "Ade(front)"
  , MkSuffix "tól" 1  "Abl(back)"
  , MkSuffix "től" 1  "Abl(front)"
  , MkSuffix "nak" 1  "Dat(back)"
  , MkSuffix "nek" 1  "Dat(front)"
  , MkSuffix "val" 1  "Instr(back)"
  , MkSuffix "vel" 1  "Instr(front)"
  , MkSuffix "ért" 1  "Causal"
  , MkSuffix "nák" 24 "CondPl(back)"
  , MkSuffix "nék" 24 "CondPl(front)"
  , MkSuffix "junk" 16 "Imp1Pl"
  -- 2-letter suffixes
  , MkSuffix "ok"  4  "Pl(back)"
  , MkSuffix "ök"  4  "Pl(front)"
  , MkSuffix "ek"  4  "Pl(front)"
  , MkSuffix "ak"  4  "Pl(back)"
  , MkSuffix "ot"  2  "Acc(back)"
  , MkSuffix "et"  2  "Acc(front)"
  , MkSuffix "öt"  2  "Acc(front)"
  , MkSuffix "at"  2  "Acc(back)"
  , MkSuffix "ba"  1  "Ill(back)"
  , MkSuffix "be"  1  "Ill(front)"
  , MkSuffix "on"  1  "Sup(back)"
  , MkSuffix "en"  1  "Sup(front)"
  , MkSuffix "ön"  1  "Sup(front)"
  , MkSuffix "ra"  1  "Subl(back)"
  , MkSuffix "re"  1  "Subl(front)"
  , MkSuffix "vá"  1  "Trans(back)"
  , MkSuffix "vé"  1  "Trans(front)"
  , MkSuffix "om"  32 "Poss1Sg(back)"
  , MkSuffix "em"  32 "Poss1Sg(front)"
  , MkSuffix "od"  32 "Poss2Sg(back)"
  , MkSuffix "ed"  32 "Poss2Sg(front)"
  , MkSuffix "ja"  32 "Poss3Sg(back)"
  , MkSuffix "je"  32 "Poss3Sg(front)"
  , MkSuffix "unk" 32 "Poss1Pl(back)"
  , MkSuffix "ünk" 32 "Poss1Pl(front)"
  , MkSuffix "juk" 32 "Poss3Pl(back)"
  , MkSuffix "jük" 32 "Poss3Pl(front)"
  , MkSuffix "ni"   8  "Inf"
  , MkSuffix "tt"   8  "Past"
  , MkSuffix "ná"   24 "Cond(back)"
  , MkSuffix "né"   24 "Cond(front)"
  , MkSuffix "ig"   1  "Term"
  , MkSuffix "tok"  8  "Pres2Pl"
  -- 1-letter suffixes (shortest, last attempt)
  , MkSuffix "k"   4  "Pl"
  , MkSuffix "t"   2  "Acc"
  , MkSuffix "n"   1  "Sup"
  , MkSuffix "j"   16 "Imp"
  ]

-- =====================================================================
-- Stripping algorithm: try to peel off suffixes from the end.
-- =====================================================================

||| Natural subtraction clamped to 0.
natMinus : Nat -> Nat -> Nat
natMinus Z _ = 0
natMinus n Z = n
natMinus (S n) (S m) = natMinus n m

||| Try to strip a known suffix from the end of a word.
||| Returns (root, suffix) on success, Nothing on failure.
tryStrip : String -> List Suffix -> Maybe (String, Suffix)
tryStrip word [] = Nothing
tryStrip word (s :: ss) =
  if isSuffixOf (sfx s) word
     then let rlen = length word `natMinus` length (sfx s)
          in Just (substr 0 rlen word, s)
     else tryStrip word ss

||| Result of a morphological analysis: list of (root, suffix, label).
public export
record Analysis where
  constructor MkAnalysis
  root      : String
  segments  : List (Suffix, String)   -- suffix + the substring it covered
  totalFeat : Nat
  harmony   : Harmony

||| Minimum root length: if root is shorter, don't strip more.
minRoot : Nat
minRoot = 3

||| Analyse a word by peeling off up to 3 suffixes.
||| Stops if root would become shorter than minRoot or no suffix matches.
public export
analyze : String -> Analysis
analyze word = analyzeN 3 word [] 0
  where
    analyzeN : Nat -> String -> List (Suffix, String) -> Nat -> Analysis
    analyzeN Z r segs f = MkAnalysis r (reverse segs) f (wordHarmony r)
    analyzeN (S k) w segs f =
      if length w <= minRoot
         then MkAnalysis w (reverse segs) f (wordHarmony w)
         else case tryStrip w suffixes of
                Nothing => MkAnalysis w (reverse segs) f (wordHarmony w)
                Just (rest, s) =>
                  if length rest < minRoot
                     then MkAnalysis w (reverse segs) f (wordHarmony w)
                     else analyzeN k rest ((s, sfx s) :: segs) (f + feat s)

||| Pretty-print an analysis.
public export
showAnalysis : Analysis -> String
showAnalysis a =
  let segStrs = map (\(s, str) => name s ++ "(" ++ str ++ ")") (segments a)
  in "root=" ++ root a
      ++ "  harmony=" ++ show (harmony a)
      ++ "  feat=" ++ show (totalFeat a)
      ++ "  segs=" ++ show segStrs