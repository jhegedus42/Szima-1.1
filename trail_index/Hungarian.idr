module Hungarian

import OctonionLogic

||| Opaque concept reference — not a string.
public export
data ConceptRef : Type where
  MkRef : Nat -> ConceptRef

public export
Eq ConceptRef where
  (==) (MkRef a) (MkRef b) = a == b

||| Hungarian case suffixes.
public export
data Case = Nom | Acc | Dat | Ins | Com | Cau | Tra | Ter
          | Ill | Ine | Ela | All | Ade | Abl | Sup | Del | Sub
          | Tem | Soc | Dist | Ess | For | Mod | Cas

public export
Show Case where
  show Nom  = "∅";    show Acc  = "-t";    show Dat  = "-nak/-nek"
  show Ins  = "-val/-vel"; show Com = "-stul/-stül"; show Cau = "-ért"
  show Tra  = "-vá/-vé";  show Ter  = "-ig"
  show Ill  = "-ba/-be";  show Ine  = "-ban/-ben"
  show Ela  = "-ból/-ből"; show All  = "-hoz/-hez/-höz"
  show Ade  = "-nál/-nél"; show Abl  = "-tól/-től"
  show Sup  = "-n/-on/-en/-ön"; show Del = "-ról/-ről"
  show Sub  = "-ra/-re";  show Tem  = "-kor"
  show Soc  = "-ként";    show Dist = "-nként"
  show Ess  = "-ul/-ül";  show For  = "-ért"
  show Mod  = "-lag/-leg"; show Cas = "-képp/-képpen"

||| Number (plural suffix is a morpheme between stem and case).
public export
data Number = Singular | Plural

||| Possessive suffix (between number and case in agglutination order).
public export
data Possession = NoPoss | P1Sg | P2Sg | P3Sg | P1Pl | P2Pl | P3Pl

||| A fully agglutinated word: stem + number + possessive + case.
||| No strings — ConceptRef replaces the stem.
public export
record Agglutinated where
  constructor MkAgg
  concept  : ConceptRef
  number   : Number
  possess  : Possession
  case_    : Case

||| A verb with its conjugation type (definite → R, indefinite → I1).
public export
data Conjugation = Definite | Indefinite

||| A grammatical relation extracted from case marking.
||| No strings — all roles are ConceptRefs.
public export
record CaseRelation where
  constructor MkCaseRel
  agent   : ConceptRef      -- NOM (subject)
  verb    : ConceptRef      -- the action
  patient : ConceptRef      -- ACC (object)
  oblique : List (Case, ConceptRef)  -- all other cases
  mode    : OctVal          -- truth mode from definiteness
  conj    : Conjugation

||| Each Hungarian case maps to a logical relation type.
||| This IS the grammar → logic bridge, encoded in types.
public export
data CaseLogic : Case -> Type where
  NomLogic  : CaseLogic Nom     -- agent / subject-of
  AccLogic  : CaseLogic Acc     -- patient / object-of
  CauLogic  : CaseLogic Cau     -- because-of / reason-for
  TraLogic  : CaseLogic Tra     -- results-in / transforms-to
  DatLogic  : CaseLogic Dat     -- recipient / caused-by
  IllLogic  : CaseLogic Ill     -- becomes / specializes-to
  IneLogic  : CaseLogic Ine     -- context-of / within
  ElaLogic  : CaseLogic Ela     -- derived-from / source
  AllLogic  : CaseLogic All     -- targets / implies
  SubLogic  : CaseLogic Sub     -- applies-to / purpose
  InsLogic  : CaseLogic Ins     -- via / using
  ComLogic  : CaseLogic Com     -- conjoined-with
  AdeLogic  : CaseLogic Ade     -- relative-to / compared-to
  AblLogic  : CaseLogic Abl     -- originates-in / source-of
  DelLogic  : CaseLogic Del     -- topic-of / references
  SupLogic  : CaseLogic Sup     -- on / about
  TemLogic  : CaseLogic Tem     -- at-time / when
  TerLogic  : CaseLogic Ter     -- up-to / bounded-by
  EssLogic  : CaseLogic Ess     -- in-role-of / as

||| Case → Octonion truth mode.
||| Causative → I1 (causal), Transformative → I2 (deductive),
||| Spatial/directional → I3-I7 (modal/hypothetical),
||| Core cases (NOM, ACC) → R (definite truth).
public export
caseToMode : Case -> OctVal
caseToMode Nom = R; caseToMode Acc = R
caseToMode Cau = I1; caseToMode Tra = I2
caseToMode Dat = I3; caseToMode Sub = I4
caseToMode Ela = I5; caseToMode Ill = I6
caseToMode Ine = I7; caseToMode All = I1
caseToMode Ins = I2; caseToMode Com = I3
caseToMode Ade = I4; caseToMode Abl = I5
caseToMode Del = I6; caseToMode Sup = I7
caseToMode Tem = R;  caseToMode Ter = I1
caseToMode Ess = R;  caseToMode Soc = R
caseToMode Dist = I2; caseToMode For = I1
caseToMode Mod = I3;  caseToMode Cas = I4
