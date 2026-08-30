module Provenance

import Ontology

||| Exact location in a source file.
public export
record SourceLoc where
  constructor MkLoc
  file      : String
  lineStart : Nat
  lineEnd   : Nat

||| Which agent extracted this association.
public export
data AgentId = PreReader Nat | Merger | Verifier | Indexer | Compactor

public export
Show AgentId where
  show (PreReader n) = "PreReader-" ++ show n
  show Merger        = "Merger"
  show Verifier      = "Verifier"
  show Indexer       = "Indexer"
  show Compactor     = "Compactor"

||| Provenance path: source -> agent -> why-chain link.
||| Every association traces back to exactly where it came from.
public export
record Provenance where
  constructor MkProv
  source   : SourceLoc
  agent    : AgentId
  chainRef : Maybe String
  stamp    : String

||| An extracted association between concepts.
||| Indexed by `t : OType` to tag what kind of concept.
public export
record Association (t : OType) where
  constructor MkAssoc
  id         : String
  concept    : String
  provenance : Provenance
  confidence : Double
  signature  : Maybe String
  code       : Maybe String
  triggers   : List String
  resolves   : List String
  tags       : List String

||| A reader output: source chunk and all associations extracted.
public export
record ReaderOutput where
  constructor MkOutput
  agent       : AgentId
  sourceLoc   : SourceLoc
  associations : List (s : OType ** Association s)

||| Contradiction between two associations from different readers.
public export
record Contradiction where
  constructor MkContra
  assocA : (s : OType ** Association s)
  assocB : (t : OType ** Association t)
  reason : String

||| GAN triple verdict.
public export
data Verdict = Pass | Fail

||| GAN triple verification result.
public export
record GanReport where
  constructor MkGan
  generator      : Verdict
  adversary      : Verdict
  normalizer     : Verdict
  contradictions : List Contradiction
