module WordPath_v1_Szima

import Data.List
import Data.Maybe
import Data.String
import Data.Nat
import MagyarNyelvtanKcode_v1_Szima
import HungarianDistance_v1_Szima
import HungarianLexicon_v1_Szima
import NatBits_v1_Szima

%default partial

-- =====================================================================
-- Word Association by Bit Distance — and the PATH between words.
--
-- Insight: a basic word (root, feat=0) INDUCES complex words through
-- suffix application. Each suffix adds feature bits (an edge in the
-- graph). The path from word A to word B is the sequence of suffix
-- additions/removals that transforms A's bit pattern into B's.
--
-- The bit distance (Hamming on feature masks) tells you HOW FAR.
-- The path tells you HOW TO GET THERE.
--
-- Graph structure:
--   Nodes  = Hungarian words (HuWord), identified by (root, feat)
--   Edges  = suffixes (string + feature mask)
--   Edge A --s--> B  means  B = A + s   (B.root = A.root, B.feat = A.feat | feat s)
--
-- A path is a List of directed edges. Association = short path.
-- =====================================================================

-- =====================================================================
-- Part 1: The Word Graph — nodes and edges
-- =====================================================================

||| A node in the word graph: identified by root string + feature mask.
||| Two words with the same root but different feat are connected by suffix edges.
public export
record WordNode where
  constructor MkWN
  wnRoot : String
  wnFeat : Nat

public export
Eq WordNode where
  (MkWN r1 f1) == (MkWN r2 f2) = r1 == r2 && f1 == f2

public export
Show WordNode where
  show (MkWN r f) = r ++ "[" ++ show f ++ "]"

||| Convert a HuWord to a graph node.
public export
wordToNode : HuWord -> WordNode
wordToNode w = MkWN (huRoot w) (huFeat w)

||| A directed edge: applying suffix s to node A produces node B.
||| B.root = A.root (suffix doesn't change root)
||| B.feat = A.feat + feat(s)  (bitwise OR, but since suffixes add distinct
|||                              bits, this is just addition for non-overlapping)
public export
record WordEdge where
  constructor MkWE
  weSuffix : Suffix
  weFrom   : WordNode
  weTo     : WordNode

||| Applying a suffix to a node: adds the suffix's feature bits.
||| The root stays the same (suffixes attach to the root).
public export
applySuffix : WordNode -> Suffix -> WordNode
applySuffix (MkWN r f) s = MkWN r (f + feat s)

||| The bit distance added by an edge = popcount of the suffix's feature mask.
||| This is how much the edge "costs" in bit space.
public export
edgeBitCost : WordEdge -> Nat
edgeBitCost (MkWE s _ _) = popCountNat (feat s)

-- =====================================================================
-- Part 2: Paths — sequences of edges
-- =====================================================================

||| A path is a list of edges where each edge's target = next edge's source.
||| This is a dependent type: the connectivity is enforced at compile time.
public export
data WordPath : WordNode -> WordNode -> Type where
  EmptyPath : WordPath n n
  StepPath  : (s : Suffix) ->
              {auto 0 prf : True = isSuffixOf (sfx s) (wnRoot next ++ sfx s)} ->
              (rest : WordPath next end) ->
              WordPath (applySuffix current s) end ->
              WordPath current end

-- The above dependent encoding is powerful but hard to construct at runtime
-- because the proof depends on string concatenation which Idris can't reduce.
-- For practical path-finding we use an erased-path representation:

||| A concrete path step: which suffix was applied.
public export
record PathStep where
  constructor MkPS
  psSuffix  : Suffix
  psNode    : WordNode   -- the node AFTER applying this suffix

public export
Show PathStep where
  show (MkPS s n) = "+" ++ sfx s ++ " -> " ++ show n

||| A concrete path: starting node + list of steps.
public export
record ConcretePath where
  constructor MkCP
  cpStart : WordNode
  cpSteps : List PathStep

public export
Show ConcretePath where
  show (MkCP start steps) =
    show start ++ " " ++ concat (intersperse " " (map show steps))

||| The end node of a concrete path.
public export
pathEnd : ConcretePath -> WordNode
pathEnd (MkCP start []) = start
pathEnd (MkCP start (step :: rest)) = pathEnd (MkCP (psNode step) rest)

||| Total bit cost of a path = sum of each step's suffix feature popcount.
public export
pathBitCost : ConcretePath -> Nat
pathBitCost (MkCP _ []) = 0
pathBitCost (MkCP _ (MkPS s _ :: rest)) =
  popCountNat (feat s) + pathBitCost (MkCP (wordToNode (MkHu "" "" ObjectRole Additive 0 0)) rest)

||| The number of steps (edges) in a path.
public export
pathLength : ConcretePath -> Nat
pathLength (MkCP _ steps) = length steps

-- =====================================================================
-- Part 3: Feature bit difference — which bits need to change
-- =====================================================================

||| The feature difference between two nodes: XOR of their feat masks.
||| This tells us which bits must be added/removed to go from A to B.
public export
featDifference : WordNode -> WordNode -> Nat
featDifference (MkWN _ f1) (MkWN _ f2) = xorNat f1 f2

||| The bit distance between two nodes = popcount of feature difference.
||| This is the Hamming distance in feature-bit space.
public export
bitDistance : WordNode -> WordNode -> Nat
bitDistance a b = popCountNat (featDifference a b)

-- TODO: Proof that bitDistance a b = 0  ⟹  wnFeat a = wnFeat b
-- This requires structural induction on xorNat (via NatBits.BitSeq).
-- Removed until a proper proof is written. NO believe_me.

-- =====================================================================
-- Part 4: Finding paths via suffix application
-- =====================================================================

||| All suffixes whose feature bits are a subset of the target difference.
||| These are the suffixes that could be part of a path from src to dst.
||| (A suffix is useful if its feat bits are all in the XOR difference.)
public export
candidateSuffixes : Nat -> List Suffix
candidateSuffixes diff = filter (\s => andNat (feat s) diff == feat s) suffixes

||| Greedy path: at each step, pick the suffix that reduces bit distance most.
||| This is a best-first search in the suffix graph.
public export
greedyPathTo : (current, target : WordNode) -> (maxDepth : Nat) -> Maybe ConcretePath
greedyPathTo current target Z =
  if wnFeat current == wnFeat target && wnRoot current == wnRoot target
     then Just (MkCP current [])
     else Nothing
greedyPathTo current target (S depth) =
  if wnFeat current == wnFeat target && wnRoot current == wnRoot target
     then Just (MkCP current [])
     else
       let diff = featDifference current target
           cands = candidateSuffixes diff
           -- Try each candidate suffix, recurse
           attempts = mapMaybe (\s =>
             let next = applySuffix current s
                 -- Only proceed if we're getting closer (bit distance decreases)
                 closer = bitDistance next target < bitDistance current target
             in if closer
                   then case greedyPathTo next target depth of
                          Just (MkCP _ steps) =>
                            Just (MkCP current (MkPS s next :: steps))
                          Nothing => Nothing
                   else Nothing) cands
       in case attempts of
            [] => Nothing
            (p :: _) => Just p

-- =====================================================================
-- Part 5: Association — basic words induce complex words
-- =====================================================================

||| All words in the lexicon that share the same root as the given word.
||| These form a "family" — the basic word induces its inflected forms.
public export
wordFamily : String -> List HuWord -> List HuWord
wordFamily rootR = filter (\w => huRoot w == rootR)

||| The induction graph: for a given root, all (feat, word) pairs sorted
||| by feature complexity. The basic word (feat=0) is the root of induction.
public export
inductionChain : String -> List HuWord -> List HuWord
inductionChain rootR lex =
  let fam = wordFamily rootR lex
  in sortBy (\w1, w2 => compare (huFeat w1) (huFeat w2)) fam

||| The basic form: the word in the family with feat=0 (root only, no suffixes).
public export
basicForm : String -> List HuWord -> Maybe HuWord
basicForm rootR lex =
  find (\w => huRoot w == rootR && huFeat w == 0) lex

||| All induced forms: words with the same root but feat > 0.
||| The basic word INDUCES these through suffix application.
public export
inducedForms : String -> List HuWord -> List HuWord
inducedForms rootR lex =
  filter (\w => huRoot w == rootR && huFeat w > 0) lex

||| The induction paths: for each induced form, the path from the basic form.
||| This shows HOW the basic word induces each complex word.
public export
inductionPaths : String -> List HuWord -> List (HuWord, Maybe ConcretePath)
inductionPaths rootR lex =
  let basic = basicForm rootR lex
      induced = inducedForms rootR lex
  in case basic of
       Nothing => []
       Just b  => map (\w => (w, greedyPathTo (wordToNode b) (wordToNode w) 6)) induced

-- =====================================================================
-- Part 6: Association by bit distance + path
-- =====================================================================

||| Association between two words: (bitDistance, path).
||| Close bit distance + short path = strong association.
||| Far bit distance or no path = weak/no association.
public export
record WordAssociation where
  constructor MkWA
  waWord1   : HuWord
  waWord2   : HuWord
  waBitDist : Nat      -- Hamming distance in feature space
  waPath    : Maybe ConcretePath  -- the suffix chain between them

||| Compute the association between two words.
||| If they share a root, the path is the suffix chain.
||| If they don't share a root, there's no suffix path (different families).
public export
associateWords : HuWord -> HuWord -> WordAssociation
associateWords w1 w2 =
  let n1 = wordToNode w1
      n2 = wordToNode w2
      dist = bitDistance n1 n2
      path = if huRoot w1 == huRoot w2
                then greedyPathTo n1 n2 6
                else Nothing  -- different roots = no suffix path
  in MkWA w1 w2 dist path

||| Association strength: closer = stronger.
||| 0 = same word, 1-2 = very close (differ by 1 suffix), 3-5 = moderate,
||| 6+ = distant, no-path = unrelated.
public export
associationStrength : WordAssociation -> String
associationStrength wa =
  case (waBitDist wa, waPath wa) of
    (0, _) => "identical"
    (d, Just _)  => if d <= 2 then "very close (same family)"
                              else if d <= 5 then "moderate (same family)"
                              else "distant (same family)"
    (_, Nothing) => "unrelated (different families)"

-- =====================================================================
-- Part 7: Examples and demonstration
-- =====================================================================

||| A small test lexicon for demonstration.
public export
testLexicon : List HuWord
testLexicon =
  [ MkHu "ház" "ház" ObjectRole Additive 0 3        -- house (basic)
  , MkHu "házak" "ház" ObjectRole Additive 4 5      -- houses (Pl: feat=4)
  , MkHu "házat" "ház" ObjectRole Additive 2 5      -- house-Acc (Acc: feat=2)
  , MkHu "házban" "ház" ObjectRole Additive 1 6     -- in house (Iness: feat=1)
  , MkHu "házakban" "ház" ObjectRole Additive 5 8   -- in houses (Pl+Iness: 4+1=5)
  , MkHu "fut" "fut" MorphismRole Additive 0 3      -- runs (basic verb)
  , MkHu "futott" "fut" MorphismRole Additive 8 6   -- ran (Past: feat=8)
  ]

||| Demonstrate induction: how "ház" induces its inflected forms.
public export
demoInduction : IO ()
demoInduction = do
  putStrLn "=== Word Induction: basic word -> complex forms ==="
  putStrLn ""
  let paths = inductionPaths "ház" testLexicon
  putStrLn "Basic form: ház [feat=0]"
  putStrLn ""
  traverse_ (\(w, path) => do
    putStr $ "  " ++ huText w ++ " [feat=" ++ show (huFeat w) ++ "]"
    case path of
      Nothing => putStrLn "  (no path found)"
      Just p  => putStrLn $ "  path: " ++ show p
    ) paths

||| Demonstrate association between word pairs.
public export
demoAssociation : IO ()
demoAssociation = do
  putStrLn "=== Word Association by Bit Distance + Path ==="
  putStrLn ""
  let pairs = [ ("ház", "házak")
              , ("ház", "házban")
              , ("ház", "házakban")
              , ("ház", "fut")
              , ("fut", "futott")
              ]
  traverse_ (\(w1, w2) => do
    let h1 = MkHu w1 w1 ObjectRole Additive 0 (length (unpack w1))
        h2 = MkHu w2 w2 ObjectRole Additive 0 (length (unpack w2))
        -- Use the lexicon to get real feature values
        real1 = findWord w1
        real2 = findWord w2
        a = associateWords (fromMaybe h1 real1) (fromMaybe h2 real2)
    putStr $ "  " ++ w1 ++ " <-> " ++ w2
    putStr $ "  bitDist=" ++ show (waBitDist a)
    putStr $ "  strength=" ++ associationStrength a
    case waPath a of
      Just p  => putStrLn $ "  path=" ++ show p
      Nothing => putStrLn "  (no suffix path)"
    ) pairs

  where
    findWord : String -> Maybe HuWord
    findWord w = find (\hw => huText hw == w) testLexicon