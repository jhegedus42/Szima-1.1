module Reader

import Ontology
import OctonionLogic
import E8Code

-- ═══════════════════════════════════════════════════════════
-- Three-Agent Reader Protocol
-- ═══════════════════════════════════════════════════════════

||| Agent 1: extracts concept nouns with definitions.
||| These become the OBJECTS of the knowledge category.
public export
record Concept where
  constructor MkConcept
  name       : String
  definition : String
  sourceBook : String
  sourceLine : Nat

||| Agent 2: extracts logical/causal connectives.
||| Non-verb, non-noun: why, therefore, because, and, or, not.
||| These become the MORPHISMS of the knowledge category.
public export
data Connective
  = Why | Therefore | Because | And | Or | Not
  | Iff | Before | After | If | Unless

public export
record Relation where
  constructor MkRel
  source  : String
  target  : String
  link    : Connective
  truth   : OctVal
  verb    : Maybe String
  book    : String
  line    : Nat

||| Agent 3 output: full categorical knowledge base.
||| Combines concepts + relations with octonion logic and E8 correction.
public export
record KnowledgeBase where
  constructor MkKB
  concepts    : List Concept
  relations   : List Relation
  verbs       : List String
  codeWords   : List CodeWord    -- E8-coded concepts
  comparisons : List Comparison -- redundancy analysis

||| A morphism in the knowledge category.
public export
data KMorphism : Type where
  MkMorph : String -> Connective -> Maybe String -> KMorphism

||| Forward search: given a target concept, find paths to it.
public export
data FPath : Type where
  FDirect : String -> String -> Connective -> FPath
  FChain  : FPath -> FPath -> FPath

||| Backward search: given a goal, what antecedents imply it.
public export
data BPath : Type where
  BFound : String -> Connective -> String -> BPath
  BChain : BPath -> BPath -> BPath

||| The full reader output for one book.
public export
record BookAnalysis where
  constructor MkAnalysis
  title    : String
  concepts : List Concept
  relations : List Relation
  paths    : List FPath
  backward : List BPath
  e8base   : List CodeWord
