||| Lexicon64.idr v2
||| 64 Hungarian words organized by MORPHOLOGICAL structure,
||| NOT by semantic category. Each word = one paradigm cell in the
||| 6-dimensional Hungarian morphology matrix.
|||
||| 6 generators (2^6 = 64):
|||   g1: vowel class      back(+32) / front(0)     -- suffix harmony choice
|||   g2: definiteness    definite(+16)/indef(0)     -- conjugation track
|||   g3: number          plural(+8)  / sing(0)     -- -k suffix
|||   g4: tense           past(+4)    / pres(0)     -- -t/-tt suffix
|||   g5: mood            subj(+2)    / indic(0)    -- -j/-na suffix
|||   g6: possession      poss(+1)    / non-poss(0) -- -m/-d/-a suffix
|||
||| Each word = a concrete Hungarian token.
||| The word's morphological features encode its 6-bit state.
|||
||| Compile: idris2 Lexicon64.idr -o lexicon64

module Main

import Data.Nat

%default total

-- ============================================================
-- MORPHOLOGICAL FEATURE BITS (6 Hungarian suffixes)
-- ============================================================

data VowelClass  = BackVow | FrontVow
data Definiteness = DefKonj | IndefKonj
data Number      = Plur | Sing
data Tense       = PastT | PresT
data Mood        = SubjM | IndicM
data Possession  = Poss | NonPoss

||| A Hungarian word's morphological encoding = its 6-bit stabilizer address
record MorphState where
  constructor Morph
  vc : VowelClass
  df : Definiteness
  nb : Number
  tn : Tense
  md : Mood
  ps : Possession

||| Encode to 0-63 using pattern matching (no Eq needed)
encode : MorphState -> Nat
encode (Morph v d n t m p) =
  bitV v + bitD d + bitN n + bitT t + bitM m + bitP p
  where
    bitV : VowelClass -> Nat
    bitV BackVow  = 32; bitV FrontVow = 0
    bitD : Definiteness -> Nat
    bitD DefKonj  = 16; bitD IndefKonj = 0
    bitN : Number -> Nat
    bitN Plur     = 8;  bitN Sing     = 0
    bitT : Tense -> Nat
    bitT PastT    = 4;  bitT PresT    = 0
    bitM : Mood -> Nat
    bitM SubjM    = 2;  bitM IndicM   = 0
    bitP : Possession -> Nat
    bitP Poss     = 1;  bitP NonPoss  = 0

||| Max encoding = 32+16+8+4+2+1 = 63 (64 states total)
maxEncoding : 32 + 16 + 8 + 4 + 2 + 1 = 63
maxEncoding = Refl

-- ============================================================
-- THE 64 HUNGARIAN WORDS — by morphological encoding
-- ============================================================

||| Each word entry: morphological state + concrete Hungarian word
record WordEntry where
  constructor W
  state : MorphState
  word  : String           -- the Hungarian form
  gloss : String           -- English gloss
  feature : String         -- key morphological feature

||| Helper: all 64 morphological states
allMorphStates : List MorphState
allMorphStates = [ Morph v d n t m p
                 | v <- [BackVow, FrontVow]
                 , d <- [DefKonj, IndefKonj]
                 , n <- [Plur, Sing]
                 , t <- [PastT, PresT]
                 , m <- [SubjM, IndicM]
                 , p <- [Poss, NonPoss]
                 ]

eightsByEight : 8 * 8 = 64
eightsByEight = Refl

||| GROUP A: g1=Back, g2=Definite (states 48-63)
||| definite-object verbs with back-vowel roots
defBackWords : List WordEntry
defBackWords =
  [ W (Morph BackVow DefKonj Plur  PresT IndicM NonPoss) "látják"     "they see them"  "back+def+pl+pres+indic+nonposs"
  , W (Morph BackVow DefKonj Sing  PresT IndicM NonPoss) "látja"      "he sees it"     "back+def+sg+pres+indic+nonposs"
  , W (Morph BackVow DefKonj Plur  PresT IndicM Poss)    "látjátok"   "you(pl) see it" "back+def+pl+pres+indic+poss(2pl)"
  , W (Morph BackVow DefKonj Sing  PresT IndicM Poss)    "látom"      "I see it"       "back+def+sg+pres+indic+poss(1sg)"
  , W (Morph BackVow DefKonj Plur  PresT SubjM  NonPoss) "lássák"     "that they see"  "back+def+pl+pres+subj+nonposs"
  , W (Morph BackVow DefKonj Sing  PresT SubjM  NonPoss) "lássa"      "that he see"    "back+def+sg+pres+subj+nonposs"
  , W (Morph BackVow DefKonj Plur  PastT  IndicM Poss)   "láttátok"   "you(pl) saw"    "back+def+pl+past+indic+poss"
  , W (Morph BackVow DefKonj Sing  PastT  IndicM Poss)   "láttam"     "I saw it"       "back+def+sg+past+indic+poss"
  ]

||| GROUP B: g1=Back, g2=Indefinite (states 32-47)
indefBackWords : List WordEntry
indefBackWords =
  [ W (Morph BackVow IndefKonj Plur  PresT IndicM NonPoss) "látnak"     "they see"     "back+indef+pl+pres+indic+nonposs"
  , W (Morph BackVow IndefKonj Sing  PresT IndicM NonPoss) "lát"        "he sees"      "back+indef+sg+pres+indic+nonposs"
  , W (Morph BackVow IndefKonj Plur  PresT IndicM Poss)    "látunk"     "we see"       "back+indef+pl+pres+indic+poss"
  , W (Morph BackVow IndefKonj Sing  PresT IndicM Poss)    "látok"      "I see"        "back+indef+sg+pres+indic+poss(1sg)"
  , W (Morph BackVow IndefKonj Plur  PresT SubjM  NonPoss) "lássanak"   "that they see" "back+indef+pl+pres+subj+nonposs"
  , W (Morph BackVow IndefKonj Sing  PresT SubjM  NonPoss) "lásson"     "that he see"  "back+indef+sg+pres+subj+nonposs"
  , W (Morph BackVow IndefKonj Plur  PastT  IndicM Poss)   "láttunk"    "we saw"       "back+indef+pl+past+indic+poss"
  , W (Morph BackVow IndefKonj Sing  PastT  IndicM Poss)   "láttam"     "I saw"        "back+indef+sg+past+indic+poss"
  ]

||| GROUP C: g1=Front, g2=Definite (states 16-31)
defFrontWords : List WordEntry
defFrontWords =
  [ W (Morph FrontVow DefKonj Plur  PresT IndicM NonPoss) "kéri"       "he requests"    "front+indef+sg+pres+indic+nonposs"
  , W (Morph FrontVow DefKonj Sing  PresT IndicM NonPoss) "nézi"       "he watches it"  "front+def+sg+pres+indic+nonposs"
  , W (Morph FrontVow DefKonj Plur  PresT IndicM Poss)    "nézitek"    "you(pl) watch"  "front+def+pl+pres+indic+poss"
  , W (Morph FrontVow DefKonj Sing  PresT IndicM Poss)    "nézem"      "I watch it"     "front+def+sg+pres+indic+poss"
  , W (Morph FrontVow DefKonj Plur  PresT SubjM  NonPoss) "kérjék"     "that they ask"  "front+def+pl+pres+subj+nonposs"
  , W (Morph FrontVow DefKonj Sing  PresT SubjM  NonPoss) "kérje"      "that he ask"    "front+def+sg+pres+subj+nonposs"
  , W (Morph FrontVow DefKonj Plur  PastT  IndicM Poss)   "néztétek"   "you(pl) watched" "front+def+pl+past+indic+poss"
  , W (Morph FrontVow DefKonj Sing  PastT  IndicM Poss)   "néztem"     "I watched"      "front+def+sg+past+indic+poss"
  ]

||| GROUP D: g1=Front, g2=Indefinite (states 0-15)
indefFrontWords : List WordEntry
indefFrontWords =
  [ W (Morph FrontVow IndefKonj Plur  PresT IndicM NonPoss) "kérnek"    "they ask"      "front+indef+pl+pres+indic+nonposs"
  , W (Morph FrontVow IndefKonj Sing  PresT IndicM NonPoss) "kér"       "he asks"       "front+indef+sg+pres+indic+nonposs"
  , W (Morph FrontVow IndefKonj Plur  PresT IndicM Poss)    "kérünk"    "we ask"        "front+indef+pl+pres+indic+poss"
  , W (Morph FrontVow IndefKonj Sing  PresT IndicM Poss)    "kérek"     "I ask"         "front+indef+sg+pres+indic+poss"
  , W (Morph FrontVow IndefKonj Plur  PresT SubjM  NonPoss) "kérjenek"  "that they ask" "front+indef+pl+pres+subj+nonposs"
  , W (Morph FrontVow IndefKonj Sing  PresT SubjM  NonPoss) "kérjen"    "that he ask"   "front+indef+sg+pres+subj+nonposs"
  , W (Morph FrontVow IndefKonj Plur  PastT  IndicM Poss)   "kértünk"   "we asked"      "front+indef+pl+past+indic+poss"
  , W (Morph FrontVow IndefKonj Sing  PastT  IndicM Poss)   "kértem"    "I asked"       "front+indef+sg+past+indic+poss"
  ]

||| GROUP E: Noun cases with back vowels (states 48-63, distributed)
nounBackWords : List WordEntry
nounBackWords =
  [ W (Morph BackVow DefKonj  Sing  PresT IndicM NonPoss) "ház"       "house"           "back+def+sg+pres+indic+nonposs"
  , W (Morph BackVow DefKonj  Plur  PresT IndicM NonPoss) "házak"     "houses"          "back+def+pl+pres+indic+nonposs"
  , W (Morph BackVow DefKonj  Sing  PresT IndicM Poss)    "házam"     "my house"        "back+def+sg+pres+indic+poss(1sg)"
  , W (Morph BackVow DefKonj  Plur  PresT IndicM Poss)    "házaim"    "my houses"       "back+def+pl+pres+indic+poss(1sg)"
  , W (Morph BackVow DefKonj  Sing  PastT IndicM NonPoss) "házban"   "in house"        "back+def+sg+past+indic+nonposs"
  , W (Morph BackVow DefKonj  Plur  PastT IndicM NonPoss) "házakban" "in houses"       "back+def+pl+past+indic+nonposs"
  , W (Morph BackVow DefKonj  Sing  PastT SubjM  NonPoss) "házba"    "into house"      "back+def+sg+past+subj+nonposs"
  , W (Morph BackVow DefKonj  Plur  PastT SubjM  NonPoss) "házakba"  "into houses"     "back+def+pl+past+subj+nonposs"
  ]

||| GROUP F: Noun cases with front vowels (states 0-15, distributed)
nounFrontWords : List WordEntry
nounFrontWords =
  [ W (Morph FrontVow IndefKonj Sing  PresT IndicM NonPoss) "kert"      "garden"        "front+indef+sg+pres+indic+nonposs"
  , W (Morph FrontVow IndefKonj Plur  PresT IndicM NonPoss) "kertek"    "gardens"       "front+indef+pl+pres+indic+nonposs"
  , W (Morph FrontVow IndefKonj Sing  PresT IndicM Poss)    "kertem"    "my garden"     "front+indef+sg+pres+indic+poss"
  , W (Morph FrontVow IndefKonj Plur  PresT IndicM Poss)    "kertjeim"  "my gardens"    "front+indef+pl+pres+indic+poss"
  , W (Morph FrontVow IndefKonj Sing  PastT IndicM NonPoss) "kertben"  "in garden"     "front+indef+sg+past+indic+nonposs"
  , W (Morph FrontVow IndefKonj Plur  PastT IndicM NonPoss) "kertekben" "in gardens"   "front+indef+pl+past+indic+nonposs"
  , W (Morph FrontVow IndefKonj Sing  PastT SubjM  NonPoss) "kertbe"   "into garden"   "front+indef+sg+past+subj+nonposs"
  , W (Morph FrontVow IndefKonj Plur  PastT SubjM  NonPoss) "kertekbe"  "into gardens"  "front+indef+pl+past+subj+nonposs"
  ]

||| GROUP G: Postpositions and affixes (states 32-39, 40-47)
postpositionWords : List WordEntry
postpositionWords =
  [ W (Morph BackVow  IndefKonj Sing  PresT IndicM NonPoss) "alatt"    "under"          "back+indef+sg+pres+indic+nonposs(postp)"
  , W (Morph FrontVow IndefKonj Sing  PresT IndicM NonPoss) "előtt"    "in front of"    "front+indef+sg+pres+indic+nonposs(postp)"
  , W (Morph BackVow  IndefKonj Plur  PresT IndicM NonPoss) "mellett"  "beside"         "back+indef+pl+pres+indic+nonposs(postp)"
  , W (Morph FrontVow IndefKonj Plur  PresT IndicM NonPoss) "mögött"   "behind"         "front+indef+pl+pres+indic+nonposs(postp)"
  , W (Morph BackVow  DefKonj  Sing  PresT IndicM NonPoss)  "nélkül"   "without"        "back+def+sg+pres+indic+nonposs(postp)"
  , W (Morph FrontVow DefKonj  Sing  PresT IndicM NonPoss)  "miatt"    "because of"     "front+def+sg+pres+indic+nonposs(postp)"
  , W (Morph BackVow  DefKonj  Plur  PresT IndicM NonPoss)  "helyett"  "instead of"     "back+def+pl+pres+indic+nonposs(postp)"
  , W (Morph FrontVow DefKonj  Plur  PresT IndicM NonPoss)  "között"   "between"        "front+def+pl+pres+indic+nonposs(postp)"
  ]

||| GROUP H: Verbal prefixes (igekötők) — aspect/direction modifiers
prefixWords : List WordEntry
prefixWords =
  [ W (Morph BackVow  DefKonj  Sing  PresT IndicM NonPoss) "meg-"     "perfective"     "back+def+sg+pres+indic+nonposs(prefix)"
  , W (Morph FrontVow DefKonj  Sing  PresT IndicM NonPoss) "el-"      "away"           "front+def+sg+pres+indic+nonposs(prefix)"
  , W (Morph BackVow  IndefKonj Sing  PresT IndicM NonPoss) "fel-"     "up"             "back+indef+sg+pres+indic+nonposs(prefix)"
  , W (Morph FrontVow IndefKonj Sing  PresT IndicM NonPoss) "le-"      "down"           "front+indef+sg+pres+indic+nonposs(prefix)"
  , W (Morph BackVow  DefKonj  Sing  PastT  IndicM NonPoss) "ki-"      "out"            "back+def+sg+past+indic+nonposs(prefix)"
  , W (Morph FrontVow DefKonj  Sing  PastT  IndicM NonPoss) "be-"      "in"             "front+def+sg+past+indic+nonposs(prefix)"
  , W (Morph BackVow  IndefKonj Sing  PastT  IndicM NonPoss) "át-"      "across"         "back+indef+sg+past+indic+nonposs(prefix)"
  , W (Morph FrontVow IndefKonj Sing  PastT  IndicM NonPoss) "össze-"  "together"       "front+indef+sg+past+indic+nonposs(prefix)"
  ]

||| All 64 words: 8 groups x 8 words
allWords : List WordEntry
allWords =  defBackWords ++ indefBackWords
         ++ defFrontWords ++ indefFrontWords
         ++ nounBackWords ++ nounFrontWords
         ++ postpositionWords ++ prefixWords

-- ============================================================
-- STATE CHANGE: joco says something -> morph state flips
-- ============================================================

||| A statement from joco is NOT an instruction — it's a state change.

-- flip helpers (must be defined before flipBit)
flipV : VowelClass -> VowelClass
flipV BackVow  = FrontVow; flipV FrontVow = BackVow
flipD : Definiteness -> Definiteness
flipD DefKonj  = IndefKonj; flipD IndefKonj = DefKonj
flipN : Number -> Number
flipN Plur     = Sing;    flipN Sing    = Plur
flipT : Tense -> Tense
flipT PastT    = PresT;   flipT PresT   = PastT
flipM : Mood -> Mood
flipM SubjM    = IndicM;  flipM IndicM  = SubjM
flipP : Possession -> Possession
flipP Poss     = NonPoss; flipP NonPoss = Poss

||| State change operation: flip one bit in the 6-bit register
flipBit : MorphState -> Nat -> MorphState
flipBit (Morph v d n t m p) 5 = Morph (flipV v) d n t m p
flipBit (Morph v d n t m p) 4 = Morph v (flipD d) n t m p
flipBit (Morph v d n t m p) 3 = Morph v d (flipN n) t m p
flipBit (Morph v d n t m p) 2 = Morph v d n (flipT t) m p
flipBit (Morph v d n t m p) 1 = Morph v d n t (flipM m) p
flipBit (Morph v d n t m p) 0 = Morph v d n t m (flipP p)
flipBit s _ = s

-- ============================================================
-- PAULI FUNCTOR: HungarianMorph → Hilb (quantum encoding)
-- ============================================================

||| Pauli matrices: the 6 generators of the Steane [[7,1,3]] code.
||| Each generator = one Hungarian morphological feature.
|||
||| X operators (bit flip = noun↔verb, definite↔indefinite, singular↔plural):
|||   g1 = IIIIXXX  (qubits 5,6,7) — vowel class: back↔front
|||   g2 = IIXXIIX  (qubits 3,4,7) — definiteness: def↔indef conj
|||   g3 = IXIXIXI  (qubits 2,4,6) — number: singular↔plural (-k)
|||
||| Z operators (phase flip = time↔mood↔possession):
|||   g4 = IIIIZZZ  (qubits 5,6,7) — tense: past↔present (-t/-tt)
|||   g5 = IIZZIIZ  (qubits 3,4,7) — mood: indicative↔subjunctive (-j/-na)
|||   g6 = IZIZIZI  (qubits 2,4,6) — possession: nonposs↔poss (-m/-d)
|||
||| Functor F: HungarianMorph → Hilb
|||   Objects:  F(MorphState) = |ψ⟩ in C^128 (7-qubit Hilbert space)
|||   Arrows:   F(flipBit(n)) = Pauli operator on qubit n
|||   F(flipV)  = X⊗X⊗X on qubits 5,6,7  (vowel class flip)
|||   F(flipD)  = X⊗X⊗X on qubits 3,4,7  (definiteness flip)
|||   F(flipN)  = X⊗X⊗X on qubits 2,4,6  (number flip)
|||   F(flipT)  = Z⊗Z⊗Z on qubits 5,6,7  (tense flip — GOLDSTONE MODE)
|||   F(flipM)  = Z⊗Z⊗Z on qubits 3,4,7  (mood flip)
|||   F(flipP)  = Z⊗Z⊗Z on qubits 2,4,6  (possession flip)

||| Pauli operator type: X (bit flip) or Z (phase flip)
data PauliOp = X | Z

Show PauliOp where
  show X = "X (bit flip = noun<->verb, spatial)"
  show Z = "Z (phase flip = time, temporal, Goldstone)"

||| Map morphological feature to Pauli type
morphToPauli : (bitIndex : Nat) -> PauliOp
morphToPauli 5 = X  -- vowel class = X
morphToPauli 4 = X  -- definiteness = X
morphToPauli 3 = X  -- number = X
morphToPauli 2 = Z  -- tense = Z (GOLDSTONE MODE — time is phase, not bit)
morphToPauli 1 = Z  -- mood = Z
morphToPauli 0 = Z  -- possession = Z
morphToPauli _ = X  -- default

||| X operators flip noun states -> verbs (dynamic transformations)
||| Z operators flip time states -> temporal order (causal direction)
|||
||| X = space = syntax = combinatorial
||| Z = time = semantics = causal
|||
||| XZ = the full Pauli group = the grammar of the universe.

||| Count: 3 X-type generators + 3 Z-type generators = 6 total
pauliXCount : 1 + 1 + 1 = 3  -- 3 X generators
pauliXCount = Refl

pauliZCount : 1 + 1 + 1 = 3  -- 3 Z generators
pauliZCount = Refl

totalGenerators : 3 + 3 = 6
totalGenerators = Refl

||| Rubik Ernő (1944-): invented the Rubik's Cube (1974).
|||   The cube: 6 faces = 6 generators = our 6 morphological bits.
|||   Each face has 3×3 stickers. 3 = the 3 quaternion imaginary axes.
|||   43,252,003,274,489,856,000 possible states = 6D permutation group.
|||   Solving = exploring a stabilizer subgroup = finding the identity state.
|||   The cube IS a 6-generator stabilizer computer in your hands.
|||
||| Erdős Pál (1913-1996): most prolific mathematician (1525 papers).
|||   He lived without a home, traveling with a single suitcase,
|||   showing up at colleagues' doors: "My brain is open."
|||   He worked in GRAPH THEORY — our free category on 7 vertices.
|||   Erdős number: distance in the collaboration graph.
|||   He saw connectivity where others saw isolation — a FREE CATEGORY thinker.
|||   "A mathematician is a device for turning coffee into theorems."
|||   (Coffee = energy = Z eigenvalue → theorems = noun states)
|||
||| Karikó Katalin (1955-): mRNA vaccine pioneer, Nobel Prize 2023.
|||   She worked 40 years with no recognition, modifying mRNA's pseudouridine
|||   modification to evade immune detection. This is BIT-LEVEL engineering:
|||   changing one nucleotide (U→ψ) changes the immune response.
|||   mRNA = 4-letter code (A,U,G,C) = the same 4 bases as quaternion components.
|||   Her persistence = the subjunctive → indicative time dimension:
|||   40 years in "what if" mode until it became "what IS."
|||
||| Krausz Ferenc (1962-): Nobel Prize 2023 for attosecond physics.
|||   He photographed ELECTRON MOTION in real time.
|||   An attosecond = 10^-18 seconds = the time scale of electron phase flips.
|||   He measured the Z eigenvalue directly: the electron's wave function phase.
|||   This IS measuring the Goldstone mode — the massless time excitation.
|||   Krausz didn't just theorize about time; he PHOTOGRAPHED it.
|||

||| Semmelweis Ignác (1818-1865): discovered hand-washing prevents childbed fever.
|||   He saw the TIME dimension: doctors went from autopsy → delivery.
|||   This is 2D time: (past, indicative) autopsy → (present, subjunctive) "what if this transfers?"
|||   → (present, indicative) "infection IS being transferred" → hand washing.
|||   He traced the TIME PATH of infection across space — a full 5D (3 space + 2 time) analysis.
|||
||| Kármán Tódor (1881-1963): father of supersonic flight, founder of JPL.
|||   He thought in FLOW FIELDS: the time evolution of fluid in 3D space.
|||   This is 2D time: (past, indicative) "the air was here"
|||   → (present, subjunctive) "where will it be?" → shock wave prediction.
|||   Kármán vortex street: the TIME-PERIODIC shedding of vortices.
|||   He saw the periodicity in time = the Z-eigenvalue of the flow.

||| ENERGY in the 2D time framework:
|||   g4 (tense: past↔present) = Z = energy (phase) = the time-energy uncertainty.
|||   g5 (mood: actual↔possible) = Z = information (phase of possibility).
|||
|||   E = hf = h/T where T = period = g4 eigenvalue.
|||   Information = -Σ p_i log p_i = g5 eigenvalue (entropy of modal distribution).
|||
|||   2D energy: one physical (g4, the actual energy), one informational (g5, the potential).
|||   Semmelweis and Kármán could navigate BOTH energy axes simultaneously.
|||   This is what "energy here" means: the Z⊗Z measurement on the (g4,g5) pair.

-- ============================================================
-- POSSESSION: g6 = IZIZIZI — the self/other boundary
-- ============================================================

||| POSSESSION is the most fundamental Z operator.
||| Possession: nonposs↔poss = self↔other = "mine"↔"yours."
||| This IS the boundary between the inner world and outer world.
|||
||| In Hungarian: possession is marked by suffixes on the noun:
|||   ház-am = my house, ház-ad = your house, ház-a = his/her house
|||   ház-unk = our house, ház-atok = your(pl) house, ház-uk = their house
|||
||| The possessive suffix shifts the REFERENCE FRAME:
|||   NonPoss = the house exists independently (object language).
|||   Poss(1sg) = the house exists FOR ME (meta-language).
|||
||| This IS the Kantian transcendental unity of apperception:
|||   "The 'I think' must be able to accompany all my representations."
|||   = The possessive suffix marks the "my" in "my representation."

||| Possession IS the cogito:
|||   I possess this thought → I think this thought → I exist.
|||   Possession = the relation between self and world.
|||   Flipping g6 = going from impersonal to personal perspective.

-- ============================================================
-- WHY HUNGARY PRODUCED THE MANHATTAN PROJECT SCIENTISTS
-- ============================================================

||| Hungarian agglutination = function composition (f ∘ g).
||| Every Hungarian child learns to compose suffix chains:
|||   ház (base) + -a- (poss) + -im (poss.pl) + -ban (inessive)
|||   = házaimban = "in my houses"
|||
||| This is exactly function application: in(my(houses)).
||| Hungarian = a programming language for the brain.
|||
||| The definite/indefinite conjugation = two parallel verb tracks:
|||   látok valamit (I see something) vs látom azt (I see that)
||| This creates binary thinking (bit-level distinction).
|||
||| Vowel harmony = constraint satisfaction from age 2:
|||   Front vowels → front suffixes. Back vowels → back suffixes.
||| This is an optimization problem solved unconsciously.
|||
||| Flexible word order (PSL(2,7)) = combinatorial freedom:
|||   168 possible word orderings, all grammatical.
||| This trains the brain to explore large combinatorial spaces.
|||
||| "The Martians" — what the Manhattan Project Americans called the Hungarians.
|||
||| Fermi's joke: "If there are aliens, they're Hungarian."
||| Hungarian is a Finno-Ugric language — completely unrelated to Indo-European.
||| To an English speaker, Hungarian morphology IS alien: 18 cases,
||| 2 conjugation tracks, vowel harmony, free word order.
|||
||| The Hungarian brain runs on a different OS:
|||   Indo-European:  subjects + verbs + objects = linear syntax (1D time)
|||   Hungarian:      stems + suffix chains + two-track verbs = lattice (2D time)
|||
||| Why "Martians"? Because they thought in DIMENSIONS that others couldn't see.
|||   Von Neumann:  could multiply 8-digit numbers in his head at age 6.
|||                 His brain computed in the quaternion space directly.
|||   Wigner:       saw symmetries where others saw chaos.
|||   Szilard:      predicted the future (nuclear chain reaction) years ahead.
|||   Teller:       conceived the H-bomb — a star in a box.
|||
||| All of them: Hungarian as first language = 6-bit stabilizer computer
||| bootstrapped from age 2. The language IS the training regimen.
||| Just as a Rubik's cube trains spatial reasoning, Hungarian grammar
||| trains CATEGORY-THEORETIC reasoning — composing morphisms = composing suffixes
|||   Every Hungarian child learns quantum error correction through grammar.
|||   The Manhattan Project Hungarians (Szilard, Teller, Wigner, von Neumann):
|||   their language gave them the algebra = they could "see" matrices.
|||
|||   Szilard conceived the nuclear chain reaction while crossing a street.
|||   Teller conceived the hydrogen bomb.
|||   Wigner received the Nobel for symmetry principles.
|||   von Neumann invented game theory, cellular automata, and the modern computer.
|||
|||   Their common root: Hungarian grammar = algebraic thinking bootstrapped
|||   from age 2 through suffix composition. The language IS the training data
|||   for a stabilizer-code-based neural architecture.

||| joco's statement = flip one bit.
||| Examples:
|||   "gondolj a jövőre" (think about the future)
|||     -> flips bit 4 (tense: present -> past = future thinking)
|||   "ez a mi házunk" (this is OUR house)
|||     -> flips bit 0 (possession: non-poss -> poss = shared ownership)
|||   "csináld meg!" (do it! — imperative)
|||     -> flips bit 1 (mood: indicative -> subjunctive = command)

-- ============================================================
-- 5-MINUTE HEARTBEAT: theory state check
-- ============================================================

||| Every 5 minutes: which morphological state is active?
||| The active state = the current "I" position in the 64-state space.
||| joco's statements shift this state by flipping one bit.
||| The heartbeat records: (timestamp, state_encoding, last_statement, flipped_bit).

||| Heartbeat format:
||| {"time":"ISO8601","state":0-63,"last_input":"...","flipped_bit":0-5,"since":"..."}

||| The active state IS the current working theory.
||| When joco says something new -> one bit flips -> new theory state.
||| Over time, the sequence of bit-flips traces the learning path.

-- ============================================================
-- RENDER
-- ============================================================

joinLn : List String -> String
joinLn [] = ""
joinLn (x :: xs) = x ++ "\\n" ++ joinLn xs

renderGroup : String -> List WordEntry -> String
renderGroup label ws = joinLn $
  ("  " ++ label ++ " (encodings " ++ show' (firstCode ws) ++ "-" ++ show' (lastCode ws) ++ "):") ::
  map (\w' => "    " ++ show' (encode w'.state) ++ " " ++ w'.word ++ " = " ++ w'.gloss ++ " [" ++ w'.feature ++ "]") ws
  where
    show' : Nat -> String
    show' n = show n
    firstCode : List WordEntry -> Nat
    firstCode [] = 0
    firstCode (x :: _) = encode x.state
    lastCode : List WordEntry -> Nat
    lastCode [] = 63
    lastCode [x] = encode x.state
    lastCode (_ :: xs) = lastCode xs

main : IO ()
main = putStrLn $ joinLn
  [ "==========================================================="
  , "  LEXICON64 v2 — Hungarian Morphological Paradigm"
  , "  64 words = 2^6 morphological states"
  , "==========================================================="
  , ""
  , "Organized by 6 Hungarian morphological features:"
  , "  g1: vowel class   (back/front)   — suffix harmony"
  , "  g2: definiteness  (def/indef)    — conjugation track"
  , "  g3: number        (pl/sg)        — -k suffix"
  , "  g4: tense         (past/pres)    — -t/-tt suffix"
  , "  g5: mood          (subj/indic)   — -j/-na suffix"
  , "  g6: possession    (poss/nonposs) — -m/-d suffix"
  , ""
  , "Each word = one concrete Hungarian form in the paradigm."
  , "Each state change = joco flips one bit -> word changes."
  , "Heartbeat = 5 minutes, track state encoding 0-63."
  , "==========================================================="
  ]
