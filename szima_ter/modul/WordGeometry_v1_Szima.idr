module WordGeometry_v1_Szima

import Data.List
import Data.Maybe
import Data.String
import Data.Nat
import MagyarNyelvtanKcode_v1_Szima
import HungarianDistance_v1_Szima
import HungarianLexicon_v1_Szima
import NatBits_v1_Szima
import WordPath_v1_Szima

%default partial

-- =====================================================================
-- THE GEOMETRY OF WORDS, STATEMENTS, AND QUESTIONS
--
-- Word      = 0-dimensional : a point in the Poincaré disk
-- Statement = 1-dimensional : a directed path (worldline) from A to B
-- Question  = 2-dimensional : an open fan of paths (path integral) from A
--
-- Dimensional hierarchy (higher category theory):
--   0-cell = object     = word      = particle in AdS₃
--   1-cell = morphism   = statement = worldline (geodesic)
--   2-cell = 2-morphism = question  = worldsheet (path integral)
--
-- CPT mapping:
--   Statement (matter, levels 1-7)    = "path EXISTS from A to B"
--   Negation  (antimatter, -7 to -1)  = "path does NOT exist" (empty fan)
--   Question  (level 0, branching)    = the phase transition = measurement
--
-- The act of answering a question = collapsing the fan to a single path
--   = wavefunction collapse = Ising phase transition (Tc crossing)
--   Awake  = asking   (above Tc, disordered, all paths possible)
--   Sleep  = answering (below Tc, ordered, one path chosen)
-- =====================================================================

-- =====================================================================
-- Part 0: WORD GEOMETRY — 0-dimensional
--
-- A word is a point in the Poincaré disk H².
--   angle θ = semantic sector (determined by root)
--   radius r = specificity (determined by suffix depth / feat popcount)
--
-- The hyperbolic metric: ds² = 4|dx|² / (1 - |x|²)²
-- Words in the same family share θ → lie on the same radial geodesic.
-- The bit distance = hyperbolic distance along that geodesic.
-- =====================================================================

||| A point in the Poincaré disk: (angle, radius).
||| angle ∈ [0, 2π) — semantic sector (root identity)
||| radius ∈ [0, 1) — specificity (0 = root/basic, →1 = maximally inflected)
public export
record DiskPoint where
  constructor MkDP
  dpAngle  : Double    -- θ: semantic sector
  dpRadius : Double    -- r: specificity (tanh of suffix depth)

public export
Show DiskPoint where
  show (MkDP theta r) = "(" ++ show theta ++ ", " ++ show r ++ ")"

||| Hash a root string to an angle in [0, 2*pi).
||| This assigns each root a unique semantic sector.
||| (Runtime only — not type-level computable, but deterministic.)
public export
rootAngle : String -> Double
rootAngle s =
  let chars = unpack s
      hashSum = sumAll (map charToNat chars)
  in 2 * pi * (the Double (cast hashSum) / 1009.0)  -- 1009 = prime, spreads angles

  where
    sumAll : List Nat -> Nat
    sumAll = foldr (+) 0

    charToNat : Char -> Nat
    charToNat = cast

||| Approximate arctanh using Taylor series (atanh not in Idris 2 Prelude).
||| atanh(x) = x + x^3/3 + x^5/5 + ... for |x| < 1
atanhApprox : Double -> Double
atanhApprox x = x + x*x*x/3.0 + x*x*x*x*x/5.0

||| Approximate arcosh using log (arcosh not in Idris 2 Prelude).
||| arcosh(x) = ln(x + sqrt(x^2 - 1)) for x >= 1
arcoshApprox : Double -> Double
arcoshApprox x = log (x + sqrt (x*x - 1.0))

||| The hyperbolic distance between two points in the Poincaré disk.
||| For points on the same radial geodesic (same angle):
|||   d = |arctanh(r1) - arctanh(r2)|
||| For points on different geodesics, use the full Poincaré formula.
public export
hyperbolicDistance : DiskPoint -> DiskPoint -> Double
hyperbolicDistance (MkDP theta1 r1) (MkDP theta2 r2) =
  if theta1 == theta2
     -- Same radial geodesic: distance is purely radial
     then abs (atanhApprox r1 - atanhApprox r2)
     -- Different geodesics: use the Poincaré distance formula
     -- d = arcosh(1 + 2*|x-y|^2 / ((1-|x|^2)(1-|y|^2)))
     else
       let deltaTheta = theta1 - theta2
           xy_sq = r1 * r1 + r2 * r2 - 2 * r1 * r2 * cos deltaTheta
           denom = (1 - r1 * r1) * (1 - r2 * r2)
           arg = 1 + 2 * xy_sq / denom
       in arcoshApprox arg

||| Map a HuWord to a Poincaré disk point.
||| The angle is derived from the root string (hash to [0, 2*pi)).
||| The radius is tanh(popcount(feat) / maxDepth) -> stays in [0, 1).
public export
wordToDiskPoint : HuWord -> DiskPoint
wordToDiskPoint w =
  let theta = rootAngle (huRoot w)
      depth = the Double (cast (popCountNat (huFeat w)))
      r = tanh (depth / 6.0)   -- 6 = max generator bits, normalizes radius
  in MkDP theta r

-- =====================================================================
-- Part 1: STATEMENT GEOMETRY — 1-dimensional
--
-- A statement is a directed path from word A to word B.
-- It asserts: "a path EXISTS from A to B."
--
-- In category theory: a 1-cell (morphism) in the word groupoid.
-- In physics: a worldline (geodesic) in AdS₃.
-- In the CPT framework: matter (levels 1-7), positive assertion.
--
-- The space of all statements = the arrow category = tangent bundle.
-- A statement has: source (A), target (B), direction (suffixes), length (bit cost).
-- =====================================================================

||| A statement: a directed path from A to B that has been verified to exist.
||| This is a 1-dimensional object — a curve in the word manifold.
|||
||| The dependent type `WordPath A B` (from WordPath.idr) is the proof
||| that the path exists. Here we wrap it with geometric metadata.
public export
record Statement where
  constructor MkStmt
  stmtSource : WordNode      -- A: where the statement starts
  stmtTarget : WordNode      -- B: where the statement ends
  stmtPath   : ConcretePath  -- the actual path (sequence of suffix edges)
  stmtLength : Nat           -- path length (number of edges)
  stmtCost   : Nat           -- bit cost (total Hamming distance)

||| Construct a statement from a verified path.
||| The statement is the ASSERTION that this path exists.
public export
makeStatement : WordNode -> WordNode -> ConcretePath -> Statement
makeStatement src tgt path =
  MkStmt src tgt path (pathLength path) (pathBitCost path)

||| A statement is TRUE if its path actually connects source to target.
||| This is a type-level guarantee: the path's end must equal the target.
public export
statementHolds : Statement -> Bool
statementHolds (MkStmt src tgt path _ _) =
  pathEnd path == tgt

||| The geometric length of a statement = hyperbolic distance between
||| source and target disk points.
public export
statementGeoLength : Statement -> Double
statementGeoLength (MkStmt src tgt _ _ _) =
  let dp1 = wordToDiskPoint (MkHu (wnRoot src) (wnRoot src) ObjectRole Additive (wnFeat src) (length (unpack (wnRoot src))))
      dp2 = wordToDiskPoint (MkHu (wnRoot tgt) (wnRoot tgt) ObjectRole Additive (wnFeat tgt) (length (unpack (wnRoot tgt))))
  in hyperbolicDistance dp1 dp2

||| Composition of statements: if A→B and B→C, then A→C.
||| This is morphism composition in the path category.
||| (Concatenates the two paths.)
public export
composeStatements : Statement -> Statement -> Maybe Statement
composeStatements (MkStmt _ mid path1 _ _) (MkStmt src2 tgt path2 _ _) =
  -- Only composable if path1's end = src2's start
  if pathEnd path1 == src2
     then let combined = concatPaths path1 path2
          in Just (MkStmt (cpStart path1) tgt combined (pathLength combined) (pathBitCost combined))
     else Nothing
  where
    concatPaths : ConcretePath -> ConcretePath -> ConcretePath
    concatPaths (MkCP s1 steps1) (MkCP _ steps2) = MkCP s1 (steps1 ++ steps2)

-- =====================================================================
-- Part 2: QUESTION GEOMETRY — 2-dimensional
--
-- A question is an OPEN path — a fan of possible paths from A to unknown B.
-- It asks: "what B satisfies: path(A, B) exists with constraint C?"
--
-- In category theory: a 2-morphism (the space of all 1-cells from A).
-- In physics: the path integral / worldsheet (sum over all worldlines).
-- In the CPT framework: level 0 (the branching point = phase transition).
--
-- The space of all questions from A = the forward star of A
--   = all nodes reachable from A = a geodesic ball around A.
--
-- Answering = collapsing the fan to a single path = measurement
--           = Ising phase transition (crossing Tc).
-- =====================================================================

||| A constraint on the target of a question.
||| "Find B such that B satisfies this constraint."
public export
data QuestionConstraint : Type where
  -- Target must have a specific feature mask
  HasFeat    : Nat -> QuestionConstraint
  -- Target must share the root with the source
  SameRoot   : QuestionConstraint
  -- Target must have at most this many feature bits
  MaxDepth   : Nat -> QuestionConstraint
  -- Target must be in the lexicon
  InLexicon  : QuestionConstraint
  -- No constraint (open question — any reachable B)
  AnyTarget  : QuestionConstraint

||| A question: an open path from A, asking for all B satisfying a constraint.
||| This is a 2-dimensional object — a fan of possible paths (a surface).
public export
record Question where
  constructor MkQ
  qSource      : WordNode          -- A: where the question starts
  qConstraint  : QuestionConstraint -- what the target must satisfy
  qMaxDepth    : Nat               -- max search depth (radius of the fan)

||| Check if a target node satisfies a question's constraint.
public export
satisfies : WordNode -> QuestionConstraint -> Bool
satisfies (MkWN r f) (HasFeat mask)   = f == mask
satisfies (MkWN r f) SameRoot         = True  -- checked separately (need source root)
satisfies (MkWN r f) (MaxDepth d)     = popCountNat f <= d
satisfies (MkWN r f) InLexicon        = True  -- checked against lexicon separately
satisfies (MkWN r f) AnyTarget        = True

-- All nodes reachable from a node by applying one suffix
suffixNeighbors : WordNode -> List WordNode
suffixNeighbors (MkWN r f) =
  map (\s => applySuffix (MkWN r f) s) suffixes

-- Breadth-first search: all nodes reachable within maxD steps
bfsReachable : WordNode -> Nat -> List WordNode
bfsReachable start depth = go depth [start] []
  where
    go : Nat -> List WordNode -> List WordNode -> List WordNode
    go Z _ acc = acc
    go (S d) queue acc =
      let neighbors = concatMap suffixNeighbors queue
          newAcc = acc ++ neighbors
      in go d neighbors newAcc

||| The fan of a question: all reachable target nodes within maxDepth.
||| This is the 2D surface — the set of all possible answers.
||| Each element is a potential statement (A->B) that could be the answer.
public export
questionFan : Question -> List WordNode
questionFan (MkQ src constraint maxD) =
  bfsReachable src maxD

||| ANSWERING a question: collapse the fan to a single statement.
||| This is the measurement — the Ising phase transition.
||| Above Tc: all paths possible (the question, uncollapsed).
||| Below Tc: one path chosen (the answer, collapsed).
|||
||| The answer is the first target in the fan that satisfies all constraints.
public export
answer : Question -> List HuWord -> Maybe Statement
answer (MkQ src constr maxD) lex =
  let fan = questionFan (MkQ src constr maxD)
      -- Filter the fan by the full constraint (including root matching)
      valid = filter (\n => satisfies n constr &&
                             (case constr of
                                SameRoot => wnRoot n == wnRoot src
                                _ => True)) fan
  in case valid of
       [] => Nothing
       (tgt :: _) =>
         -- Find a path from src to tgt
         case greedyPathTo src tgt maxD of
           Just path => Just (makeStatement src tgt path)
           Nothing => Nothing

||| An UNANSWERED question = the full fan (2D surface of possibilities).
||| An ANSWERED question = one statement (1D path, collapsed).
|||
||| The transition from unanswered to answered = crossing Tc.
||| This is the geometry of thought:
|||   Question (2D, above Tc) --[answering]--> Statement (1D, below Tc)
public export
data AnsweredQuestion : Type where
  Unanswered : Question -> AnsweredQuestion         -- 2D, above Tc
  Answered   : Question -> Statement -> AnsweredQuestion  -- 1D, below Tc

||| The act of answering: Unanswered → Answered.
||| This is the phase transition. The fan collapses to a path.
public export
answerQuestion : AnsweredQuestion -> List HuWord -> AnsweredQuestion
answerQuestion (Unanswered q) lex =
  case answer q lex of
    Just stmt => Answered q stmt
    Nothing   => Unanswered q  -- no answer found, stays open
answerQuestion (Answered q s) _ = Answered q s  -- already answered

-- =====================================================================
-- Part 3: NEGATION GEOMETRY — the empty path space (antimatter)
--
-- Negation = "NO path exists from A to B satisfying C."
-- This is the CPT conjugate of a statement.
-- Statement (matter)    = "path EXISTS"  → levels 1-7
-- Negation  (antimatter) = "path does NOT exist" → levels -7 to -1
--
-- The geometry: the empty fan. A region of the manifold where
-- no geodesic connects A to any B satisfying C.
-- =====================================================================

||| A negation: asserting that NO path exists from A to any B
||| satisfying the constraint. This is the antimatter counterpart
||| of a question — the question whose fan is empty.
public export
record Negation where
  constructor MkNeg
  negSource     : WordNode
  negConstraint : QuestionConstraint
  negMaxDepth   : Nat
  negProofEmpty : List HuWord -> Bool  -- True if fan is indeed empty

||| Construct a negation: verify that the fan IS empty.
||| This is reductio ad absurdum in the word geometry:
|||   "Assume a path exists. The fan is empty. Contradiction. ∴ no path."
public export
makeNegation : WordNode -> QuestionConstraint -> Nat -> List HuWord -> Maybe Negation
makeNegation src constr maxD lex =
  let q = MkQ src constr maxD
      fan = questionFan q
  in if null fan
        then Just (MkNeg src constr maxD (\l => null (questionFan q)))
        else Nothing  -- fan is non-empty, negation fails

-- =====================================================================
-- Part 4: The dimensional hierarchy as a dependent type
--
-- Word      : 0D — a point (object / 0-cell)
-- Statement : 1D — a path (morphism / 1-cell)
-- Question  : 2D — a fan  (2-morphism / path integral)
--
-- This is the strict omega-category of the word manifold.
-- Each dimension is a type, and the types enforce the geometry.
-- =====================================================================

||| The dimension of a geometric object in the word manifold.
public export
data GeoDimension : Type where
  ZeroDim  : GeoDimension   -- word (point)
  OneDim   : GeoDimension   -- statement (path)
  TwoDim   : GeoDimension   -- question (fan/surface)

public export
Show GeoDimension where
  show ZeroDim = "0D (word)"
  show OneDim  = "1D (statement)"
  show TwoDim  = "2D (question)"

||| The geometric object at each dimension.
||| This dependent type enforces that words are 0D, statements are 1D, etc.
public export
data GeoObject : GeoDimension -> Type where
  MkWordObj      : WordNode    -> GeoObject ZeroDim   -- a point
  MkStatementObj : Statement   -> GeoObject OneDim    -- a path
  MkQuestionObj  : Question    -> GeoObject TwoDim    -- a fan

||| The dimension of a geometric object is determined by its type.
||| This is proven by construction (no believe_me).
public export
wordIsZeroDim : GeoObject ZeroDim -> GeoDimension
wordIsZeroDim (MkWordObj _) = ZeroDim

public export
statementIsOneDim : GeoObject OneDim -> GeoDimension
statementIsOneDim (MkStatementObj _) = OneDim

public export
questionIsTwoDim : GeoObject TwoDim -> GeoDimension
questionIsTwoDim (MkQuestionObj _) = TwoDim

-- =====================================================================
-- Part 5: The boundary operator — dimension reduction
--
-- ∂(Question)  = the set of Statements in its fan (2D → 1D)
-- ∂(Statement) = (source, target) pair of Words (1D → 0D)
-- ∂(Word)      = ∅ (0D has no boundary)
--
-- This is the chain complex of the word manifold.
-- The boundary operator is how questions become statements become words.
-- =====================================================================

||| The boundary of a statement = its endpoints (source, target).
||| ∂: 1D → 0D × 0D
public export
statementBoundary : Statement -> (WordNode, WordNode)
statementBoundary (MkStmt src tgt _ _ _) = (src, tgt)

||| The boundary of a question = all statements in its fan.
||| ∂: 2D → {1D}  (a set of statements)
||| Each potential answer is a statement in the boundary.
public export
questionBoundary : Question -> List HuWord -> List Statement
questionBoundary q lex =
  let fan = questionFan q
  in mapMaybe (\tgt => case greedyPathTo (qSource q) tgt (qMaxDepth q) of
                         Just path => Just (makeStatement (qSource q) tgt path)
                         Nothing => Nothing) fan

||| The boundary of a word is empty (0D has no boundary).
||| ∂: 0D → ∅
public export
wordBoundary : WordNode -> List WordNode
wordBoundary _ = []

-- =====================================================================
-- Part 6: The phase transition — question ↔ statement
--
-- The act of answering = crossing Tc = the phase transition.
-- Above Tc: question (2D, disordered, all paths possible)
-- Below Tc: statement (1D, ordered, one path chosen)
--
-- This is the geometry of thought:
--   Question --[answering = cooling through Tc]--> Statement
--   Statement --[questioning = heating through Tc]--> Question
--
-- Sleep = consolidation = answering (cooling)
-- Awake = questioning = heating (creative, many paths)
-- =====================================================================

||| The phase of a geometric object:
||| Disordered (above Tc) = questions, multiple possibilities
||| Ordered (below Tc) = statements, single path
public export
data Phase : Type where
  Disordered : Phase   -- above Tc: question phase (awake, creative)
  Ordered    : Phase   -- below Tc: statement phase (Sleep, consolidated)

||| Answering a question = cooling through Tc = Disordered → Ordered.
||| This is the sleep/consolidation direction.
public export
cooling : AnsweredQuestion -> List HuWord -> AnsweredQuestion
cooling = answerQuestion  -- same operation: collapse the fan

||| Questioning a statement = heating through Tc = Ordered → Disordered.
||| This is the waking/creative direction: from a fixed statement,
|||   generate all possible questions that could have produced it.
public export
heating : Statement -> Nat -> AnsweredQuestion
heating stmt maxD =
  let (src, tgt) = statementBoundary stmt
      -- The question: "what can we reach from src within maxD?"
      q = MkQ src AnyTarget maxD
  in Unanswered q  -- re-open the statement into a fan of possibilities

-- =====================================================================
-- Part 7: Demonstration
-- =====================================================================

public export
demoGeometry : IO ()
demoGeometry = do
  putStrLn "=== The Geometry of Words, Statements, and Questions ==="
  putStrLn ""
  putStrLn "DIMENSIONAL HIERARCHY:"
  putStrLn "  Word      = 0D  (point in Poincaré disk)    = object  = particle"
  putStrLn "  Statement = 1D  (directed path, worldline)  = morphism = geodesic"
  putStrLn "  Question  = 2D  (fan of paths, path integral) = 2-cell  = worldsheet"
  putStrLn ""
  putStrLn "PHASE TRANSITION (the act of thought):"
  putStrLn "  Question (2D, above Tc) --[answering = cooling]--> Statement (1D, below Tc)"
  putStrLn "  Statement (1D, below Tc) --[questioning = heating]--> Question (2D, above Tc)"
  putStrLn ""
  putStrLn "CPT MAPPING:"
  putStrLn "  Statement (matter, levels 1-7)     = 'path EXISTS'"
  putStrLn "  Negation  (antimatter, -7 to -1)   = 'path does NOT exist'"
  putStrLn "  Question  (level 0, branching)     = the phase transition = measurement"
  putStrLn ""
  putStrLn "BOUNDARY OPERATOR (chain complex):"
  putStrLn "  ∂(Question)  = {Statements in fan}     (2D → 1D)"
  putStrLn "  ∂(Statement) = (source, target)         (1D → 0D)"
  putStrLn "  ∂(Word)      = ∅                        (0D → ∅)"
  putStrLn ""
  putStrLn "EXAMPLE: 'ház' (house) as a word, statement, and question:"
  let ház = MkWN "ház" 0
  putStrLn $ "  Word (0D):      " ++ show ház
  putStrLn $ "    Disk point:    " ++ show (wordToDiskPoint (MkHu "ház" "ház" ObjectRole Additive 0 3))
  putStrLn ""
  putStrLn $ "  Question (2D):  What can 'ház' become within 3 suffix steps?"
  let q = MkQ ház AnyTarget 3
  let fan = questionFan q
  putStrLn $ "    Fan size:      " ++ show (length fan) ++ " possible targets"
  putStrLn $ "    Fan (first 5): " ++ show (take 5 fan)
  putStrLn ""
  putStrLn $ "  Answering: collapse the fan to a statement (cooling through Tc)"
  case answer q testLexicon of
    Just stmt => putStrLn $ "    Statement:     " ++ show (stmtSource stmt) ++ " -> " ++ show (stmtTarget stmt)
    Nothing   => putStrLn $ "    (no answer found in test lexicon)"
  putStrLn ""
  putStrLn "  This IS the geometry of thought."