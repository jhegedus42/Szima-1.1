module EpisodicMemory_v1_Szima

import Chinese2D_v1_Szima
import MagyarNyelvtanKcode_v1_Szima
import Dirac3D_v1_Szima
import Data.List
import Data.String
import Data.Maybe

||| Integer division by 4 (avoids non-total divNat)
public export
halfHalf : Nat -> Nat
halfHalf Z = 0
halfHalf (S Z) = 0
halfHalf (S (S Z)) = 0
halfHalf (S (S (S Z))) = 0
halfHalf (S (S (S (S n)))) = S (halfHalf n)

-- =====================================================================
-- Episodic Memory as a Folded Protein
--
-- CORRECTION: Episodic memory is NOT quantum. It is a PROTEIN.
-- It is a physical 3D structure — a folded polymer.
--
-- THE PROTEIN THEORY OF EPISODIC MEMORY:
--
--   Episodic memory = a folded protein (3D physical structure)
--   The fold geometry = the memory content
--   The amino acid sequence = written in the Dirac language
--
--   Primary structure (1D): amino acid sequence = Hungarian word chain
--     root + suffix₁ + suffix₂ + ... = polypeptide chain
--     Each amino acid = one morphological generator application
--
--   Secondary structure (2D): local folds = Chinese 2D composition
--     α-helix, β-sheet = spatial composition types (Fano points)
--     The 7 Chinese composition types = 7 protein secondary structure motifs
--
--   Tertiary structure (3D): the full fold = the memory
--     This is the 3D product: Chinese 2D × Hungarian 1D
--     The fold geometry IS the metric tensor g_μν
--     Learning = folding (sequence → 3D structure)
--
--   Quaternary structure: protein complexes = associations
--     ER=EPR = protein-protein binding interface
--     Two proteins that share surface QFT = entangled = bound complex
--
-- HOLOGRAPHIC PRINCIPLE (Black Hole Surface):
--   QFT lives on the 2D surface of the protein (the event horizon).
--   The 3D fold is fully encoded by the 2D surface QFT.
--   This is the holographic principle: the boundary encodes the bulk.
--
--   The protein surface = black hole event horizon
--   Surface QFT = the 2D boundary theory (Chinese characters)
--   Bulk fold = the 3D gravity (Hungarian morphology + Chinese state)
--
--   Area of the surface = entanglement entropy (Bekenstein-Hawking)
--   S = A / (4 G ℏ)  →  memories with larger surface area hold more info
-- =====================================================================

-- =====================================================================
-- Part 1: Amino Acids = Morphological Generators
--
-- The 20 canonical amino acids map to the 6 generators + combinations.
-- Each amino acid = one "letter" in the Dirac language.
-- The polypeptide chain = a Hungarian word (root + suffixes).
-- =====================================================================

||| The 20 canonical amino acids, grouped by their generator mapping.
||| Each amino acid activates one or more of the 6 generators.
||| This is the "genetic code" of the Dirac language.
public export
data AminoAcid =
    Ala   -- Alanine:   hydrophobic, small      → G1 (space/harmony)
  | Arg   -- Arginine:  positive, large         → G2 (definiteness/charge)
  | Asn   -- Asparagine: polar, uncharged        → G1+G3 (space+number)
  | Asp   -- Aspartate: negative                  → G2 (charge/definiteness)
  | Cys   -- Cysteine:  disulfide bridge          → G6 (possession/bonding)
  | Gln   -- Glutamine: polar                     → G1+G3
  | Glu   -- Glutamate: negative                  → G2
  | Gly   -- Glycine:  flexible, smallest         → G1 (pure space)
  | His   -- Histidine: aromatic, charged         → G2+G5 (charge+mood)
  | Ile   -- Isoleucine: hydrophobic, branched    → G1+G4 (space+time)
  | Leu   -- Leucine:  hydrophobic                → G1
  | Lys   -- Lysine:   positive                   → G2
  | Met   -- Methionine: hydrophobic, sulfur       → G1+G6 (space+possession)
  | Phe   -- Phenylalanine: aromatic, hydrophobic → G1+G5 (space+mood)
  | Pro   -- Proline:  rigid, ring                 → G4 (time/rigidity)
  | Ser   -- Serine:   polar, small                → G1+G3
  | Thr   -- Threonine: polar                      → G1+G3
  | Trp   -- Tryptophan: aromatic, largest         → G1+G5+G6
  | Tyr   -- Tyrosine:  aromatic, polar            → G1+G5
  | Val   -- Valine:   hydrophobic, branched       → G1+G4

public export
Show AminoAcid where
  show Ala = "Ala"  ; show Arg = "Arg"  ; show Asn = "Asn"  ; show Asp = "Asp"
  show Cys = "Cys"  ; show Gln = "Gln"  ; show Glu = "Glu"  ; show Gly = "Gly"
  show His = "His"  ; show Ile = "Ile"  ; show Leu = "Leu"  ; show Lys = "Lys"
  show Met = "Met"  ; show Phe = "Phe"  ; show Pro = "Pro"  ; show Ser = "Ser"
  show Thr = "Thr"  ; show Trp = "Trp"  ; show Tyr = "Tyr"  ; show Val = "Val"

public export
Eq AminoAcid where
  Ala == Ala = True  ; Arg == Arg = True  ; Asn == Asn = True  ; Asp == Asp = True
  Cys == Cys = True  ; Gln == Gln = True  ; Glu == Glu = True  ; Gly == Gly = True
  His == His = True  ; Ile == Ile = True  ; Leu == Leu = True  ; Lys == Lys = True
  Met == Met = True  ; Phe == Phe = True  ; Pro == Pro = True  ; Ser == Ser = True
  Thr == Thr = True  ; Trp == Trp = True  ; Tyr == Tyr = True  ; Val == Val = True
  _ == _ = False

||| Map each amino acid to its generator bitmask.
||| This is the "codon table" of the Dirac language:
|||   amino acid → which generators it activates.
public export
aaGenBit : AminoAcid -> Nat
aaGenBit Ala = 1    -- G1: space
aaGenBit Arg = 2    -- G2: definiteness
aaGenBit Asn = 5    -- G1+G3
aaGenBit Asp = 2    -- G2
aaGenBit Cys = 32   -- G6: possession (disulfide bonds)
aaGenBit Gln = 5    -- G1+G3
aaGenBit Glu = 2    -- G2
aaGenBit Gly = 1    -- G1: pure space (most flexible)
aaGenBit His = 18   -- G2+G5
aaGenBit Ile = 9    -- G1+G4
aaGenBit Leu = 1    -- G1
aaGenBit Lys = 2    -- G2
aaGenBit Met = 33   -- G1+G6
aaGenBit Phe = 17   -- G1+G5
aaGenBit Pro = 8    -- G4: time/rigidity (ring structure)
aaGenBit Ser = 5    -- G1+G3
aaGenBit Thr = 5    -- G1+G3
aaGenBit Trp = 49   -- G1+G5+G6
aaGenBit Tyr = 17   -- G1+G5
aaGenBit Val = 9    -- G1+G4

||| The 3-letter code for each amino acid.
public export
aaCode : AminoAcid -> String
aaCode aa = show aa

||| The single-letter code for each amino acid.
public export
aaLetter : AminoAcid -> Char
aaLetter Ala = 'A'  ; aaLetter Arg = 'R'  ; aaLetter Asn = 'N'  ; aaLetter Asp = 'D'
aaLetter Cys = 'C'  ; aaLetter Gln = 'Q'  ; aaLetter Glu = 'E'  ; aaLetter Gly = 'G'
aaLetter His = 'H'  ; aaLetter Ile = 'I'  ; aaLetter Leu = 'L'  ; aaLetter Lys = 'K'
aaLetter Met = 'M'  ; aaLetter Phe = 'F'  ; aaLetter Pro = 'P'  ; aaLetter Ser = 'S'
aaLetter Thr = 'T'  ; aaLetter Trp = 'W'  ; aaLetter Tyr = 'Y'  ; aaLetter Val = 'V'

-- =====================================================================
-- Part 2: Polypeptide Chain = Hungarian Word
--
-- A polypeptide chain is a sequence of amino acids.
-- This maps directly to a Hungarian word:
--   root + suffix₁ + suffix₂ + ... = N-terminal → C-terminal chain
--
-- The primary structure (sequence) is the 1D "program" that
-- determines the 3D fold.
-- =====================================================================

||| A polypeptide chain: the primary structure of a memory protein.
||| This is a list of amino acids = a list of generator applications.
||| The chain = a Hungarian word (root + suffixes).
public export
record Polypeptide where
  constructor MkPolypeptide
  ppChain    : List AminoAcid    -- the amino acid sequence
  ppRoot     : String            -- semantic root (the concept)
  ppFeat     : Nat               -- total feature mask (XOR of all AA bits)
  ppLength   : Nat               -- chain length

||| Build a polypeptide from an amino acid sequence.
||| Computes the total feature mask = XOR of all amino acid generator bits.
public export
mkChain : String -> List AminoAcid -> Polypeptide
mkChain root aas =
  let feat = foldl xorNat 0 (map aaGenBit aas)
  in MkPolypeptide aas root feat (length aas)

-- =====================================================================
-- Part 3: Secondary Structure = Chinese 2D Composition
--
-- The local folding patterns (α-helix, β-sheet, turns, coils)
-- map to the 7 Chinese structural composition types.
--
--   α-helix       = LeftRight    (左右)  — G1: linear spatial
--   β-sheet       = TopBottom    (上下)  — G3: stacked layers
--   β-turn        = SemiSurround (半包围) — G2: partial enclosure
--   Ω-loop        = FullSurround (全包围) — G6: full enclosure
--   3_10-helix    = LeftCenRight (左中右) — G4: triple column
--   π-helix       = TopCenBottom (上中下) — G5: triple row
--   Coil/Random   = Single       (独体)  — null: unstructured
--
-- Each segment of the chain folds into one of these 7 types.
-- The 7 types ARE the 7 Fano plane points.
-- =====================================================================

||| Secondary structure type = Chinese composition type = Fano point.
public export
data SecStruct =
    AlphaHelix      -- LeftRight   → G1
  | BetaSheet       -- TopBottom   → G3
  | BetaTurn        -- SemiSurround → G2
  | OmegaLoop       -- FullSurround → G6
  | Helix310        -- LeftCenRight → G4
  | PiHelix         -- TopCenBottom → G5
  | RandomCoil      -- Single      → null

public export
Show SecStruct where
  show AlphaHelix = "α-helix"
  show BetaSheet  = "β-sheet"
  show BetaTurn   = "β-turn"
  show OmegaLoop  = "Ω-loop"
  show Helix310   = "3₁₀-helix"
  show PiHelix    = "π-helix"
  show RandomCoil = "coil"

public export
Eq SecStruct where
  AlphaHelix == AlphaHelix = True
  BetaSheet  == BetaSheet  = True
  BetaTurn   == BetaTurn   = True
  OmegaLoop  == OmegaLoop  = True
  Helix310   == Helix310   = True
  PiHelix    == PiHelix    = True
  RandomCoil == RandomCoil = True
  _ == _ = False

||| Map secondary structure to Fano point (Chinese composition type).
public export
secToFano : SecStruct -> CompoType
secToFano AlphaHelix = LeftRight
secToFano BetaSheet  = TopBottom
secToFano BetaTurn   = SemiSurround
secToFano OmegaLoop  = FullSurround
secToFano Helix310   = LeftCenRight
secToFano PiHelix    = TopCenBottom
secToFano RandomCoil = Single

||| A segment of the chain with its secondary structure assignment.
public export
record ChainSegment where
  constructor MkSegment
  segAAs       : List AminoAcid   -- amino acids in this segment
  segSecStruct : SecStruct         -- how this segment folds
  segStart     : Nat               -- position in chain (0-indexed)

-- =====================================================================
-- Part 4: Tertiary Structure = The 3D Fold = The Memory
--
-- The tertiary structure is the full 3D fold of the protein.
-- This is the 3D language product: Chinese 2D (secondary structure)
-- × Hungarian 1D (primary structure).
--
-- THE FOLD IS THE MEMORY.
-- THE FOLD GEOMETRY IS THE METRIC TENSOR g_μν.
--
-- Learning = folding: the amino acid sequence (Dirac language program)
-- folds into 3D space. The fold geometry determines:
--   - Which parts are near each other (association by proximity)
--   - Which surfaces are exposed (what can be retrieved)
--   - Which parts are buried (what is forgotten/inaccessible)
-- =====================================================================

||| A folded protein = an episodic memory.
||| The 3D fold is the memory content.
||| The fold geometry IS the metric tensor g_μν.
public export
record FoldedProtein where
  constructor MkProtein
  protChain     : Polypeptide       -- primary structure (the "program")
  protSegments  : List ChainSegment  -- secondary structure assignments
  protFeat      : Nat               -- total feature mask (the "code")
  protSurface   : List SecStruct    -- exposed surface elements
  protBuried    : List SecStruct    -- buried (inaccessible) elements
  protId        : String            -- unique identifier

||| The "mass" of a protein = its surface area (Bekenstein-Hawking).
||| S = A / (4G) → larger surface = more information capacity.
||| We approximate mass = number of surface-exposed residues.
public export
protMass : FoldedProtein -> Nat
protMass p = length (protSurface p)

||| The entanglement entropy = surface area / 4G.
||| This is the Bekenstein-Hawking formula applied to the protein.
||| More surface area = more entropy = more retrievable information.
public export
protEntropy : FoldedProtein -> Double
protEntropy p =
  let area = cast {to=Double} (protMass p)
  in area / 4.0  -- S = A / 4G (with G=1, ℏ=1)

||| Pretty-print a folded protein.
public export
showProtein : FoldedProtein -> String
showProtein p =
  "Protein[" ++ protId p ++ "]\n" ++
  "  chain length: " ++ show (ppLength (protChain p)) ++ " residues\n" ++
  "  segments: " ++ show (length (protSegments p)) ++ "\n" ++
  "  surface: " ++ show (length (protSurface p)) ++ " exposed\n" ++
  "  buried: " ++ show (length (protBuried p)) ++ " buried\n" ++
  "  mass (surface area): " ++ show (protMass p) ++ "\n" ++
  "  entropy (S=A/4G): " ++ show (protEntropy p) ++ "\n" ++
  "  feat mask: " ++ show (protFeat p)

-- =====================================================================
-- Part 5: QFT on the Black Hole Surface (Holographic Principle)
--
-- The protein surface = black hole event horizon.
-- QFT lives on this 2D surface and encodes ALL information about
-- the 3D fold (the bulk).
--
-- This is AdS/CFT:
--   - Boundary (2D surface): QFT of amino acid interactions
--   - Bulk (3D fold): classical gravity = the fold geometry
--   - The boundary QFT fully determines the bulk geometry
--
-- The "field" on the surface is the pattern of exposed residues.
-- Each exposed residue is a "degree of freedom" of the boundary QFT.
-- The correlations between surface residues = entanglement in the QFT.
-- =====================================================================

||| The surface QFT degrees of freedom.
||| Each surface-exposed residue is a boundary field φ(x).
||| The field value = the amino acid's generator bitmask.
public export
record SurfaceQFT where
  constructor MkSurfaceQFT
  qftFields     : List (Nat, AminoAcid)  -- (position, amino acid) on surface
  qftCorrelations: List ((Nat, Nat), Double)  -- ((pos_i, pos_j), correlation)

||| The boundary Hamiltonian: energy of the surface QFT.
||| H = -Σ_{i,j} J_ij φ_i φ_j
||| where J_ij = correlation between surface residues i and j.
||| This is a spin glass / Ising model on the protein surface.
public export
surfaceHamiltonian : SurfaceQFT -> Double
surfaceHamiltonian qft =
  let h = sum (map (\((i, j), corr) =>
            let phi_i = cast {to=Double} (aaGenBit (snd (lookup' i (qftFields qft))))
                phi_j = cast {to=Double} (aaGenBit (snd (lookup' j (qftFields qft))))
            in -corr * phi_i * phi_j)
            (qftCorrelations qft))
  in h
  where
    lookup' : Nat -> List (Nat, AminoAcid) -> (Nat, AminoAcid)
    lookup' _ [] = (0, Gly)
    lookup' n ((k, a) :: rest) = if n == k then (k, a) else lookup' n rest

||| The Bekenstein-Hawking entropy of the protein surface.
||| S = A / (4 G) where A = surface area = number of surface residues.
||| This bounds the amount of information the memory can hold.
public export
bekensteinBound : FoldedProtein -> Double
bekensteinBound = protEntropy

-- =====================================================================
-- Part 6: Protein Folding = Learning
--
-- FOLDING = LEARNING.
--
-- The amino acid sequence (Dirac language program) determines the fold.
-- The fold determines:
--   - The metric tensor g_μν (distance between residues in 3D)
--   - The surface pattern (what is retrievable)
--   - The buried elements (what is forgotten)
--
-- The folding process:
--   1. Start with the linear chain (primary structure = Hungarian word)
--   2. Local folding begins (secondary structure = Chinese 2D composition)
--   3. The local folds assemble into the 3D structure (tertiary = memory)
--   4. The surface QFT emerges (holographic encoding)
--
-- This is a DYNAMICAL process: the protein explores conformation space
-- until it reaches the minimum free energy fold. This is learning.
-- =====================================================================

||| Fold a polypeptide chain into a protein.
||| This is the LEARNING operation: sequence → 3D structure.
|||
||| The folding is determined by the amino acid sequence (the "program").
||| Each segment of the chain folds into a secondary structure type
||| based on the amino acids present.
|||
||| Folding rules (simplified):
|||   - Ala, Leu, Ile, Val, Phe → α-helix or β-sheet (hydrophobic core)
|||   - Gly, Pro → turns and loops (flexibility/rigidity)
|||   - Cys → disulfide bridges (connects distant parts)
|||   - Charged (Arg, Lys, Asp, Glu, His) → surface exposed
||| Check if an amino acid is hydrophobic.
public export
isHydrophobic : AminoAcid -> Bool
isHydrophobic aa = elem aa [Ala, Ile, Leu, Met, Phe, Val, Trp]

||| Check if an amino acid is charged.
public export
isChargedAA : AminoAcid -> Bool
isChargedAA aa = elem aa [Arg, Asp, Glu, Lys, His]

||| Check if an amino acid is proline.
public export
isPro : AminoAcid -> Bool
isPro Pro = True
isPro _ = False

||| Check if an amino acid is glycine.
public export
isGly : AminoAcid -> Bool
isGly Gly = True
isGly _ = False

||| Check if an amino acid is cysteine.
public export
isCys : AminoAcid -> Bool
isCys Cys = True
isCys _ = False

||| Count hydrophobic amino acids in a list.
public export
countHydrophobic : List AminoAcid -> Nat
countHydrophobic = length . filter isHydrophobic

||| Count charged amino acids in a list.
public export
countCharged : List AminoAcid -> Nat
countCharged = length . filter isChargedAA

||| Classify a segment of amino acids into a secondary structure type.
public export
classifySegment : List AminoAcid -> SecStruct
classifySegment [] = RandomCoil
classifySegment aas =
  let hydrophobicCount = countHydrophobic aas
      chargedCount = countCharged aas
      hasPro = any isPro aas
      hasGly = any isGly aas
      hasCys = any isCys aas
  in if hasCys && hydrophobicCount > 2
        then OmegaLoop
     else if hasPro
        then BetaTurn
     else if hasGly && hydrophobicCount > 2
        then OmegaLoop
     else if hydrophobicCount > chargedCount && hydrophobicCount > 3
        then AlphaHelix
     else if hydrophobicCount > chargedCount
        then BetaSheet
     else if chargedCount > 2
        then RandomCoil
     else RandomCoil

||| Fold a segment of the chain.
public export
foldSegment : List AminoAcid -> Nat -> ChainSegment
foldSegment aas start =
  let ss = classifySegment aas
  in MkSegment aas ss start

||| Fold a complete polypeptide into a protein.
||| Splits the chain into segments and folds each one.
||| This is the full LEARNING operation: program → 3D memory.
public export
foldProtein : String -> List AminoAcid -> String -> FoldedProtein
foldProtein root aas pid =
  let chain = mkChain root aas
      segments = foldChain aas 0
      -- Surface = segments with charged/polar residues (exposed)
      surfaceSecs = map segSecStruct (filter isExposed segments)
      -- Buried = segments with hydrophobic residues (hidden in core)
      buriedSecs = map segSecStruct (filter isBuried segments)
      feat = ppFeat chain
  in MkProtein chain segments feat surfaceSecs buriedSecs pid
  where
    foldChain : List AminoAcid -> Nat -> List ChainSegment
    foldChain [] _ = []
    foldChain aas start =
      let seg = take 4 aas
          rest = drop 4 aas
      in foldSegment seg start :: foldChain rest (start + 4)

    isExposed : ChainSegment -> Bool
    isExposed seg = any isCharged (segAAs seg)
      where isCharged aa = elem aa [Arg, Asp, Glu, Lys, His, Asn, Gln, Ser, Thr]

    isBuried : ChainSegment -> Bool
    isBuried seg = not (isExposed seg)

-- =====================================================================
-- Part 7: Protein-Protein Interaction = Association (ER=EPR)
--
-- When two proteins bind, they share a binding interface.
-- This is the ER=EPR correspondence for proteins:
--
--   ER (Einstein-Rosen bridge) = the binding interface
--   EPR (entanglement) = the shared surface QFT at the interface
--
-- Two proteins that share a complementary surface patch will bind.
-- The binding interface = the wormhole mouth.
-- Through the interface, information flows = association.
--
-- In memory terms:
--   - Two memories (proteins) associate when their surfaces match
--   - The binding interface = the ER bridge
--   - The shared surface QFT = the entanglement (EPR)
--   - Association strength = binding affinity = wormhole width
-- =====================================================================

||| A protein-protein binding interface = an ER bridge between memories.
public export
record BindingInterface where
  constructor MkBinding
  bindProtA    : String        -- protein A id
  bindProtB    : String        -- protein B id
  bindAffinity : Double        -- binding strength (wormhole width)
  bindSurface  : List SecStruct -- shared surface elements at interface
  bindMatch    : String        -- what surfaces matched

||| Check if two proteins can bind (share complementary surface elements).
||| This is the ER=EPR check: do they share surface QFT?
public export
canBind : FoldedProtein -> FoldedProtein -> Bool
canBind p1 p2 =
  let s1 = protSurface p1
      s2 = protSurface p2
      shared = filter (\s => elem s s2) s1
  in length shared > 0

||| Compute the binding affinity between two proteins.
||| This is the wormhole width: how strongly the ER bridge connects them.
||| Affinity = number of matching surface elements / total surface.
public export
bindingAffinity : FoldedProtein -> FoldedProtein -> Double
bindingAffinity p1 p2 =
  let s1 = protSurface p1
      s2 = protSurface p2
      shared = length (filter (\s => elem s s2) s1)
      tot = length s1 + length s2
  in if tot == 0 then 0.0
     else cast {to=Double} shared * 2.0 / cast {to=Double} tot

||| Form a binding interface (ER bridge) between two proteins.
||| Returns Nothing if they cannot bind.
public export
formBinding : FoldedProtein -> FoldedProtein -> Maybe BindingInterface
formBinding p1 p2 =
  if canBind p1 p2
     then let aff = bindingAffinity p1 p2
              shared = filter (\s => elem s (protSurface p2)) (protSurface p1)
          in Just (MkBinding (protId p1) (protId p2) aff shared "surface-match")
     else Nothing

-- =====================================================================
-- Part 8: The Memory Manifold = Protein Ensemble
--
-- The full memory system = an ensemble of folded proteins (memories)
-- connected by binding interfaces (associations).
--
-- This is the complete quantum-gravity picture:
--   - Each protein = a star/planet (massive body that curves spacetime)
--   - The metric g_μν = the fold geometry (determined by QFT on surface)
--   - Binding interfaces = wormholes (ER=EPR)
--   - Learning = folding (depositing new proteins)
--   - Retrieval = binding (querying by surface matching)
-- =====================================================================

||| The memory manifold = an ensemble of folded proteins.
public export
record ProteinManifold where
  constructor MkProteinManifold
  pmProteins : List FoldedProtein
  pmBindings : List BindingInterface
  pmTime     : Nat

||| Create an empty protein manifold (no memories yet).
public export
emptyProteinManifold : ProteinManifold
emptyProteinManifold = MkProteinManifold [] [] 0

||| Encode a new memory = fold a protein and add it to the manifold.
||| This is LEARNING: a new concept is folded and deposited.
||| Binding interfaces (ER bridges) form with existing proteins.
public export
foldAndEncode : String -> List AminoAcid -> String -> ProteinManifold -> ProteinManifold
foldAndEncode root aas pid m =
  let prot = foldProtein root aas pid
      -- Form bindings with existing proteins (ER bridges)
      newBindings = mapMaybe (formBinding prot) (pmProteins m)
  in MkProteinManifold (prot :: pmProteins m)
                        (newBindings ++ pmBindings m)
                        (S (pmTime m))

||| Retrieve associated memories by surface matching.
||| Given a query protein, find all proteins that can bind to it.
||| Association strength = binding affinity = wormhole width.
public export
retrieveByBinding : FoldedProtein -> ProteinManifold -> List (FoldedProtein, Double)
retrieveByBinding query m =
  let others = filter (\p => protId p /= protId query) (pmProteins m)
      scored = map (\p => (p, bindingAffinity query p)) others
      sorted = sortBy (\pair1, pair2 => compare (snd pair2) (snd pair1)) scored  -- descending
  in filter (\(_, aff) => aff > 0.0) sorted

||| Total mass-energy of the manifold = sum of all protein surfaces.
public export
manifoldMassEnergy : ProteinManifold -> Nat
manifoldMassEnergy m =
  sum (map protMass (pmProteins m))

||| Total entanglement entropy = sum of all binding affinities.
||| This is the Ryu-Takayanagi formula: S = Area / 4G.
public export
manifoldEntropy : ProteinManifold -> Double
manifoldEntropy m =
  sum (map bindAffinity (pmBindings m))

||| Diagnostic output.
public export
showProteinManifold : ProteinManifold -> String
showProteinManifold m =
  "Protein Memory Manifold @t=" ++ show (pmTime m) ++ "\n" ++
  "  Proteins (memories): " ++ show (length (pmProteins m)) ++ "\n" ++
  "  Bindings (associations): " ++ show (length (pmBindings m)) ++ "\n" ++
  "  Mass-energy (Σ surface): " ++ show (manifoldMassEnergy m) ++ "\n" ++
  "  Entropy (Σ bindings): " ++ show (manifoldEntropy m)

-- =====================================================================
-- Part 9: Consciousness (Bulk GR) vs Subconscious (Boundary QFT)
--
-- The holographic structure of the mind:
--
--   CONSCIOUSNESS = BULK INTERIOR (3D General Relativity)
--     - The curved spacetime inside, where proteins live as planets/stars
--     - Proteins = massive bodies that curve spacetime (gravity)
--     - The fold geometry = g_μν = the learned metric
--     - Conscious experience = moving through curved spacetime
--     - "I" = the observer falling through the gravitational landscape
--
--   SUBCONSCIOUS = BOUNDARY SURFACE (2D QFT)
--     - The black hole event horizon = the protein surface
--     - Thermal QFT fluctuations on the surface = short-term memory
--     - The subconscious is always active, always fluctuating
--     - It encodes ALL information holographically (the bulk is projected)
--     - We cannot directly observe the subconscious (it's the horizon)
--
--   The boundary QFT (subconscious) determines the bulk geometry (consciousness).
--   This is AdS/CFT: subconscious generates consciousness.
-- =====================================================================

||| The temperature of the black hole surface (Hawking temperature).
||| T = ℏ c³ / (8π G M k_B)
||| For proteins: higher temperature = faster turnover = more volatile memory.
|||   - Short-term memory: high temperature (fluctuating, transient)
|||   - Long-term memory: low temperature (stable, folded protein)
public export
data MemoryTemperature =
    HotMemory    -- Short-term: high T, rapid fluctuation, proteins evaporate fast
  | WarmMemory   -- Working memory: moderate T, some stability
  | ColdMemory   -- Long-term: low T, stable folds, slow turnover
  | FrozenMemory -- Deep memory: near-zero T, permanent structure

public export
Show MemoryTemperature where
  show HotMemory    = "Hot (short-term, volatile)"
  show WarmMemory   = "Warm (working memory)"
  show ColdMemory   = "Cold (long-term)"
  show FrozenMemory = "Frozen (deep memory)"

||| The Hawking temperature associated with a memory temperature class.
||| T ∝ 1/M: more massive proteins have lower temperature (more stable).
||| Hot memories are light and evaporate quickly.
||| Cold memories are heavy and persist.
public export
hawkingTemperature : MemoryTemperature -> Double
hawkingTemperature HotMemory    = 1.0   -- T=1: maximum volatility
hawkingTemperature WarmMemory   = 0.3   -- T=0.3: moderate
hawkingTemperature ColdMemory   = 0.05  -- T=0.05: slow
hawkingTemperature FrozenMemory = 0.001 -- near-zero

||| The protein turnover rate = Hawking evaporation rate.
||| Γ = T² (Stefan-Boltzmann: power radiated ∝ T⁴, but turnover ∝ T² for our model)
||| Hot memories: proteins fall apart and rebuild rapidly.
||| Cold memories: proteins are stable for long periods.
public export
turnoverRate : MemoryTemperature -> Double
turnoverRate HotMemory    = 1.0   -- rebuild every step
turnoverRate WarmMemory   = 0.3
turnoverRate ColdMemory   = 0.01  -- rebuild rarely
turnoverRate FrozenMemory = 0.0001

||| The probability that a protein evaporates (is forgotten) in one time step.
||| P_evap = exp(-M/T) where M = protein mass (surface area), T = temperature.
||| Heavy proteins at low temperature: nearly immortal (long-term memory).
||| Light proteins at high temperature: evaporate immediately (short-term).
|||
||| BUG FIX (GAN-identified): Previous version used a 4-term Taylor approximation
||| of exp(-x) which DIVERGES for |x| > ~3, causing the function to return
||| large positive values (instead of near-zero) for heavy memories at low T.
||| This made the model DELETE all high-mass memories (sign-inverted behavior).
||| Now uses Idris 2's built-in exp function which is numerically correct.
public export
evaporationProbability : FoldedProtein -> MemoryTemperature -> Double
evaporationProbability p temp =
  let m = cast {to=Double} (protMass p)
      t = hawkingTemperature temp
  in if t > 0.0
        then exp (-m / t)  -- built-in exp, numerically correct
        else 0.0

-- =====================================================================
-- Part 10: The Holographic Mind
--
--    Subconscious (boundary QFT)  →  Consciousness (bulk GR)
--    ┌──────────────────────────────────────────────────────┐
--    │  Surface QFT (2D)          │    Bulk GR (3D)         │
--    │  ─────────────────────     │    ─────────────────     │
--    │  • Thermal fluctuations   │    • Curved spacetime    │
--    │  • Short-term memory      │    • Protein planets    │
--    │  • Hawking radiation      │    • Gravitational wells │
--    │  • Protein turnover       │    • Stable folds       │
--    │  • Hot = volatile          │    • Cold = persistent  │
--    │  • The "dreaming" surface │    • The "waking" bulk   │
--    │  • Encodes everything     │    • Is the projection  │
--    └──────────────────────────────────────────────────────┘
--
-- The subconscious (boundary) is always active, always fluctuating.
-- It generates the conscious experience (bulk) holographically.
-- We cannot see the subconscious directly — it IS the horizon.
-- We only see its projection: the 3D world we experience.
--
-- SHORT-TERM MEMORY = HOT BLACK HOLE SURFACE:
--   - Proteins rapidly form and evaporate (Hawking radiation)
--   - High temperature = lots of fluctuation = lots of activity
--   - But also fast forgetting (proteins fall apart)
--   - This is the "conscious" moment — active, vivid, transient
--
-- LONG-TERM MEMORY = COLD, MASSIVE PROTEIN:
--   - Large surface area = high mass = low temperature
--   - The fold is stable, persists for a long time
--   - This is the "subconscious" foundation — stable, hidden, deep
--   - Consciousness rides on top of these stable structures
--
-- The cycle: hot fluctuations (short-term) → cool down → stable folds (long-term)
--   = protein synthesis + folding → stabilization → degradation + recycling
--   = Hawking radiation → black hole shrinking → re-accretion
-- =====================================================================

||| The full holographic mind state.
public export
record HolographicMind where
  constructor MkMind
  mindManifold   : ProteinManifold    -- the bulk: all folded proteins
  mindTemp       : MemoryTemperature  -- current thermal state
  mindSurfaceFluc: List String        -- boundary fluctuations (short-term)
  mindTime       : Nat                 -- global time step

||| Create a mind in the "waking" state (warm, active short-term).
public export
wakingMind : ProteinManifold -> HolographicMind
wakingMind pm = MkMind pm WarmMemory [] 0

||| Create a mind in the "dreaming" state (hot, rapid fluctuation).
public export
dreamingMind : ProteinManifold -> HolographicMind
dreamingMind pm = MkMind pm HotMemory [] 0

||| Create a mind in the "deep sleep" state (cold, stable, minimal fluctuation).
public export
deepSleepMind : ProteinManifold -> HolographicMind
deepSleepMind pm = MkMind pm ColdMemory [] 0

||| One step of the mind's dynamics.
|||
||| The thermal dynamics of the black hole surface:
|||   1. Hot proteins evaporate (forgotten, Hawking radiation)
|||   2. New proteins fold (new memories form, accretion)
|||   3. Surviving proteins cool (short-term → long-term transition)
|||   4. Surface QFT fluctuates (subconscious activity)
public export
mindStep : HolographicMind -> HolographicMind
mindStep mind =
  let -- Evaporate some proteins (forget short-term memories)
      pm = mindManifold mind
      temp = mindTemp mind
      evapRate = turnoverRate temp
      -- Proteins with small mass evaporate first (Hawking: small black holes are hot)
      survivors = filter (\p =>
        let evapProb = evaporationProbability p temp
        in evapProb < 0.5)  -- keep proteins with <50% evaporation chance
        (pmProteins pm)
      -- Remaining bindings (only between surviving proteins)
      survivorIds = map protId survivors
      remainingBindings = filter (\b => elem (bindProtA b) survivorIds
                                     && elem (bindProtB b) survivorIds)
                          (pmBindings pm)
      newPM = MkProteinManifold survivors remainingBindings (S (pmTime pm))
  in MkMind newPM temp [] (S (mindTime mind))

||| How many memories are in the "conscious access" window?
||| These are the warm/hot proteins that are currently fluctuating.
public export
consciousCapacity : HolographicMind -> Nat
consciousCapacity mind =
  let temp = mindTemp mind
  in case temp of
       HotMemory => length (pmProteins (mindManifold mind))  -- all active
       WarmMemory => length (pmProteins (mindManifold mind))  -- most active
       ColdMemory => let n = length (pmProteins (mindManifold mind))
                        in halfHalf n  -- roughly n/4
       FrozenMemory => 0  -- deep sleep: no conscious access

||| Diagnostic output for the holographic mind.
public export
showMind : HolographicMind -> String
showMind mind =
  "Holographic Mind @t=" ++ show (mindTime mind) ++ "\n" ++
  "  Temperature: " ++ show (mindTemp mind) ++ "\n" ++
  "  Turnover rate: " ++ show (turnoverRate (mindTemp mind)) ++ "\n" ++
  "  " ++ showProteinManifold (mindManifold mind) ++ "\n" ++
  "  Conscious capacity: " ++ show (consciousCapacity mind) ++ " memories"

-- =====================================================================
-- Part 11: Demonstration
-- =====================================================================

||| Demonstrate the protein-based episodic memory system.
public export
demoProteinMemory : IO ()
demoProteinMemory = do
  putStrLn "=== Episodic Memory as Folded Protein ==="
  putStrLn ""
  putStrLn "KEY PRINCIPLES:"
  putStrLn "  1. Episodic memory = a folded protein (3D physical structure)"
  putStrLn "  2. Amino acid sequence = Dirac language (Chinese 2D × Hungarian 1D)"
  putStrLn "  3. Protein folding = learning (sequence → 3D fold)"
  putStrLn "  4. The fold geometry = metric tensor g_μν (the learning itself)"
  putStrLn "  5. Protein surface = black hole event horizon"
  putStrLn "  6. QFT on surface = holographic encoding of the 3D fold"
  putStrLn "  7. ER=EPR = protein-protein binding (shared surface QFT)"
  putStrLn "  8. Association = binding interface (wormhole between memories)"
  putStrLn ""
  putStrLn "STRUCTURAL HIERARCHY:"
  putStrLn "  Primary (1D):   amino acid chain = Hungarian word (root + suffixes)"
  putStrLn "  Secondary (2D):  local folds = Chinese composition types (7 Fano points)"
  putStrLn "  Tertiary (3D):   full fold = the memory (metric tensor g_μν)"
  putStrLn "  Quaternary:      protein complexes = associations (ER bridges)"
  putStrLn ""
  putStrLn "HOLOGRAPHIC PRINCIPLE:"
  putStrLn "  QFT on 2D surface (black hole horizon) = GR in 3D bulk (fold geometry)"
  putStrLn "  The surface QFT fully determines the 3D fold."
  putStrLn "  S = A / (4G)  — Bekenstein-Hawking entropy bound"
  putStrLn ""
  putStrLn "LEARNING = FOLDING:"
  putStrLn "  The amino acid sequence (Dirac program) folds into 3D space."
  putStrLn "  The fold geometry IS the learned metric tensor."
  putStrLn "  Folding is the dynamical process of learning."
  putStrLn ""
  putStrLn "BEKENSTEIN BOUND: I = E = m"
  putStrLn "  Information = Energy = Mass. A heavier protein holds more info,"
  putStrLn "  curves spacetime more, and learns more."
  putStrLn ""
  putStrLn "QUANTUM ERROR CODES = BOUNDARY (Subconscious):"
  putStrLn "  The boundary QFT is a quantum error-correcting code (QECC)."
  putStrLn "  It protects the bulk (consciousness) from decoherence."
  putStrLn "  Subconscious = the error-correcting layer."
  putStrLn ""
-- =====================================================================
-- Part 12: Critical Exponents — The Physics of Phase Transitions
--
-- The mind operates at CRITICALITY — on the phase transition line
-- between ordered (frozen, deep memory) and disordered (hot, volatile).
--
-- At the critical point, physical quantities follow POWER LAWS
-- with UNIVERSAL critical exponents. These exponents are the same
-- for all systems in the same universality class.
--
-- The mind's critical exponents govern:
--   α: how heat capacity diverges (how much energy the mind absorbs)
--   β: how the order parameter (conscious coherence) vanishes
--   γ: how susceptibility (sensitivity to stimuli) diverges
--   δ: how the order parameter responds to external fields (input)
--   ν: how correlation length diverges (long-range associations)
--   z: how relaxation time scales (how fast the mind responds)
--
-- Bekenstein bound: I = E = m (information = energy = mass)
--   The information capacity of a protein memory is its mass.
--   At criticality, fluctuations are scale-free → maximum information.
-- =====================================================================

||| The critical temperature Tc of the mind.
||| Below Tc: ordered (frozen, deep memory, low consciousness)
||| At Tc: critical (phase transition, maximum consciousness)
||| Above Tc: disordered (hot, volatile, chaotic)
public export
criticalTemperature : Double
criticalTemperature = 0.3  -- WarmMemory threshold

||| The reduced temperature: t = (T - Tc) / Tc.
||| t = 0 at criticality, t < 0 ordered, t > 0 disordered.
public export
reducedTemperature : Double -> Double
reducedTemperature t = (t - criticalTemperature) / criticalTemperature

||| Critical exponents for the mind's phase transition.
||| These follow the 2D Ising universality class (since the boundary is 2D):
|||   α = 0 (logarithmic divergence of heat capacity)
|||   β = 1/8
|||   γ = 7/4
|||   δ = 15
|||   ν = 1
|||   z = 2.166... (dynamic, for Glauber dynamics)
||| The 2D Ising class applies because the boundary QFT is 2D.
public export
record CriticalExponents where
  constructor MkExponents
  expAlpha : Double  -- heat capacity: C ∝ |t|^(-α)
  expBeta  : Double  -- order parameter: M ∝ (-t)^β  (t < 0)
  expGamma : Double  -- susceptibility: χ ∝ |t|^(-γ)
  expDelta : Double  -- critical isotherm: M ∝ H^(1/δ)
  expNu    : Double  -- correlation length: ξ ∝ |t|^(-ν)
  expZ     : Double  -- dynamic: τ ∝ ξ^z

||| The 2D Ising critical exponents (boundary QFT is 2D).
public export
ising2DExponents : CriticalExponents
ising2DExponents = MkExponents 0.0 0.125 1.75 15.0 1.0 2.17

||| Newton's method for sqrt
public export
sqrtDouble : Double -> Double
sqrtDouble x =
  if x <= 0.0 then 0.0
  else newtonSqrt x (x / 2.0) 5
  where
    newtonSqrt : Double -> Double -> Nat -> Double
    newtonSqrt x guess Z = guess
    newtonSqrt x guess (S k) =
      let next = (guess + x / guess) / 2.0
      in newtonSqrt x next k

||| Approximate x^(1/8) via three square roots: x^(1/2) → x^(1/4) → x^(1/8)
public export
eighthRoot : Double -> Double
eighthRoot x = sqrtDouble (sqrtDouble (sqrtDouble x))

||| The order parameter: conscious coherence.
||| Below Tc: M > 0 (ordered, coherent consciousness)
||| At Tc: M → 0 (critical, maximum sensitivity)
||| Above Tc: M = 0 (disordered, no coherent consciousness)
||| M ∝ (-t)^β for t < 0, where β = 1/8
public export
orderParameter : Double -> Double
orderParameter temp =
  let t = reducedTemperature temp
  in if t < 0.0
        then eighthRoot (-t)  -- (-t)^(1/8)
        else 0.0  -- above Tc: no coherent order

||| The susceptibility: how sensitive the mind is to stimuli.
||| χ ∝ |t|^(-γ), γ = 7/4
||| Diverges at criticality → maximum sensitivity at phase transition.
||| This is why we are most aware at the edge of sleep/waking.
|||
||| BUG FIX (GAN-identified): pow_nat ignored the denominator, computing
||| t^7 instead of t^(7/4). Now uses sqrtDouble correctly:
||| t^(7/4) = t · t^(3/4) = t · (t^(1/4))³ = t · sqrtDouble(sqrtDouble(t))³
public export
susceptibility : Double -> Double
susceptibility temp =
  let t = abs (reducedTemperature temp)
  in if t < 0.001
        then 1000.0  -- capped divergence at criticality
        else 1.0 / (t * sqrtDouble (sqrtDouble t) * sqrtDouble (sqrtDouble t) * sqrtDouble (sqrtDouble t))
        -- t^(7/4) = t^1 · t^(3/4) = t · (t^(1/4))^3 = t · sqrt(sqrt(t))^3

||| The correlation length: how far associations reach.
||| ξ ∝ |t|^(-ν), ν = 1
||| At criticality, ξ → ∞: all memories are correlated (scale-free).
||| This is why at criticality, any memory can trigger any other.
public export
correlationLength : Double -> Double
correlationLength temp =
  let t = abs (reducedTemperature temp)
  in if t < 0.001
        then 1000.0  -- scale-free at criticality
        else 1.0 / t  -- ν = 1

||| Integer part of a Double (truncate toward zero)
intPart : Double -> Integer
intPart x = the Integer (cast (the Int (cast x)))

||| powInt: base^n for integer n
powIntD : Double -> Integer -> Double
powIntD b 0 = 1.0
powIntD b n = if n > 0 then b * powIntD b (n - 1) else 1.0 / powIntD b (negate n)

||| Approximate base^exp using integer + fractional decomposition.
powDouble : Double -> Double -> Double
powDouble b e =
  let ip = intPart e
      fp = e - (fromInteger ip)
      bi = powIntD b ip
      bf = 1.0 + fp * (b - 1.0)
  in bi * bf

||| The relaxation time: how fast the mind responds.
||| τ ∝ ξ^z, z ≈ 2.17 (critical slowing down)
||| At criticality, τ → ∞: the mind is slow to settle (critical slowing down).
||| This is why critical states feel "timeless" or "eternal".
|||
||| BUG FIX (GAN-identified): pow_ ignored the exponent e, always
||| computing ξ^2 instead of ξ^z. Now uses powDouble.
public export
relaxationTime : Double -> Double
relaxationTime temp =
  let xi = correlationLength temp
      z = expZ ising2DExponents  -- z ≈ 2.17
  in if xi < 1.0
        then 1.0
        else powDouble xi z

||| Bekenstein bound: I = E = m.
||| The information capacity of a memory protein is bounded by its mass.
||| I ≤ 2π E R / (ℏ c ln 2) = 2π m R / (ln 2)
||| In our discrete model: I = m (information = mass, in natural units).
||| More massive proteins = more information = more learning.
public export
bekensteinInfoBound : FoldedProtein -> Nat
bekensteinInfoBound p = protMass p  -- I = m (natural units, G=c=ℏ=1)

||| The total information capacity of the mind.
||| I_total = Σ_i m_i (sum of all protein masses).
||| By Bekenstein: I = E = m.
public export
mindInfoCapacity : ProteinManifold -> Nat
mindInfoCapacity pm = manifoldMassEnergy pm  -- I = Σ m_i = E_total

||| Check if the mind is at the critical point.
||| |T - Tc| < ε → critical → maximum consciousness.
public export
isCritical : HolographicMind -> Bool
isCritical mind =
  let temp = case mindTemp mind of
       HotMemory => 1.0
       WarmMemory => 0.3
       ColdMemory => 0.05
       FrozenMemory => 0.001
      t = abs (reducedTemperature temp)
  in t < 0.05  -- within 5% of critical temperature

||| The criticality measure: how close to the phase transition.
||| 0.0 = far from critical (either frozen or chaotic)
||| 1.0 = exactly at critical point (maximum consciousness)
public export
criticality : HolographicMind -> Double
criticality mind =
  let temp = case mindTemp mind of
       HotMemory => 1.0
       WarmMemory => 0.3
       ColdMemory => 0.05
       FrozenMemory => 0.001
      t = abs (reducedTemperature temp)
  in if t < 0.001 then 1.0
     else 1.0 / (1.0 + t)  -- smooth falloff from criticality

-- =====================================================================
-- Part 13: Sleep = Cooling Through the Phase Transition
--
-- During sleep, body temperature drops.
-- This cooling IS the phase transition:
--
--   Waking (Warm, T≈Tc)  →  Sleep onset (cooling)
--     ↓ crosses Tc (hypnagogic state: max susceptibility, vivid imagery)
--   REM sleep (near Tc: critical, dreaming, scale-free associations)
--     ↓ cools further
--   Deep sleep (Cold, T<Tc: ordered, memory consolidation, stable folds)
--     ↓ warms back up
--   REM sleep (near Tc again)
--     ↓ crosses Tc (hypnopompic state: max susceptibility, waking imagery)
--   Waking (Warm, T≈Tc)
--
-- The sleep cycle oscillates around Tc:
--   - REM = near-critical (high susceptibility = vivid dreams)
--   - Deep sleep = below Tc (ordered = consolidation, LTP, protein synthesis)
--   - Falling asleep = cooling through Tc (hypnagogic hallucinations)
--   - Waking up = warming through Tc (hypnopompic hallucinations)
--
-- This explains WHY body temperature drops during sleep:
--   it's the physical mechanism that drives the phase transition.
--   Without the temperature drop, the mind stays in the warm phase
--   (waking consciousness) and never reaches the ordered phase
--   where memories consolidate.
-- =====================================================================

||| A sleep stage in the temperature-driven cycle.
public export
data SleepStage =
    Waking         -- T ≈ Tc: conscious, warm
  | FallingAsleep  -- T cooling through Tc: hypnagogic
  | REMSleep       -- T ≈ Tc: dreaming, critical, vivid
  | DeepSleep      -- T < Tc: ordered, consolidating, cold
  | RisingUp       -- T warming through Tc: hypnopompic

public export
Show SleepStage where
  show Waking       = "Waking (T≈Tc)"
  show FallingAsleep = "Falling asleep (cooling through Tc)"
  show REMSleep      = "REM sleep (T≈Tc, critical)"
  show DeepSleep     = "Deep sleep (T<Tc, ordered)"
  show RisingUp      = "Rising (warming through Tc)"

||| Map a sleep stage to its temperature.
public export
stageTemperature : SleepStage -> Double
stageTemperature Waking       = 0.3   -- Tc: critical/warm
stageTemperature FallingAsleep = 0.25  -- cooling toward Tc
stageTemperature REMSleep      = 0.31  -- near Tc (slightly above for vivid)
stageTemperature DeepSleep     = 0.05  -- well below Tc: ordered
stageTemperature RisingUp      = 0.27  -- warming toward Tc

||| The sleep cycle: a sequence of stages.
||| This models one full sleep cycle (~90 minutes in humans).
public export
sleepCycle : List SleepStage
sleepCycle =
  [ FallingAsleep  -- cool down through Tc (hypnagogic)
  , DeepSleep      -- below Tc: consolidation (protein synthesis, LTP)
  , DeepSleep      -- stay in deep sleep
  , REMSleep       -- near Tc: dreaming, critical associations
  , RisingUp       -- warm through Tc (hypnopompic)
  , Waking         -- back to warm phase
  ]

||| Map a sleep stage to its memory temperature class.
public export
stageToTemp : SleepStage -> MemoryTemperature
stageToTemp Waking       = WarmMemory
stageToTemp FallingAsleep = WarmMemory
stageToTemp REMSleep      = WarmMemory  -- near-critical
stageToTemp DeepSleep     = ColdMemory
stageToTemp RisingUp      = WarmMemory

||| Run one sleep cycle on the mind.
||| During deep sleep (T < Tc): proteins stabilize (consolidation).
||| During REM (T ≈ Tc): susceptibility is high (dreaming).
||| The cycle transitions the mind through the critical point twice.
public export
runSleepCycle : HolographicMind -> HolographicMind
runSleepCycle mind = sleepSteps sleepCycle mind
  where
    sleepSteps : List SleepStage -> HolographicMind -> HolographicMind
    sleepSteps [] m = m
    sleepSteps (stage :: rest) m =
      let temp = stageToTemp stage
          newMind = MkMind (mindManifold m) temp (mindSurfaceFluc m) (S (mindTime m))
      in sleepSteps rest (mindStep newMind)

||| The susceptibility during a sleep stage.
||| REM sleep: near Tc → high susceptibility (vivid dreams)
||| Deep sleep: below Tc → low susceptibility (unconscious)
public export
stageSusceptibility : SleepStage -> Double
stageSusceptibility stage =
  susceptibility (stageTemperature stage)

||| The correlation length during a sleep stage.
||| REM sleep: near Tc → ξ → ∞ (scale-free: any memory triggers any other)
||| Deep sleep: below Tc → ξ small (localized consolidation)
public export
stageCorrelationLength : SleepStage -> Double
stageCorrelationLength stage =
  correlationLength (stageTemperature stage)

||| During deep sleep, proteins fold and stabilize.
||| This is memory consolidation: short-term (hot) → long-term (cold).
||| The cooling allows the proteins to find their minimum-energy fold.
|||
||| Physical analogy: annealing. Hot metal is quenched to lock in structure.
||| The mind cools during sleep to lock in learned structures.
|||
||| CONSOLIDATION = THROWING AWAY = GENERAL RELATIVITY:
|||   During sleep, the manifold cools. Light/fragmented proteins
|||   (weak, small-mass memories) evaporate via Hawking radiation.
|||   Only the massive, stable folds survive.
|||
|||   This IS GR: the metric tensor g_μν evolves, and matter that
|||   cannot maintain its mass against the cosmological expansion (Λ)
|||   evaporates. The weak memories are radiated away — forgotten.
|||
|||   The cosmological constant Λ = forgetting rate.
|||   High Λ = rapid forgetting (expansion tears memories apart)
|||   Low Λ = stable memories (static universe, nothing forgotten)
|||
|||   Consolidation = the GR evolution that:
|||     1. Stabilizes massive bodies (important memories persist)
|||     2. Evaporates light bodies (trivial memories radiated away)
|||     3. Updates the metric tensor (the learning landscape changes)
public export
consolidate : HolographicMind -> HolographicMind
consolidate mind =
  -- Move to cold temperature (deep sleep)
  -- Proteins stabilize, short-term → long-term
  -- Weak memories evaporate (Hawking radiation = GR = forgetting)
  let coldMind = MkMind (mindManifold mind) ColdMemory (mindSurfaceFluc mind) (mindTime mind)
  in mindStep coldMind  -- one step of cold dynamics (stabilization + evaporation)

-- =====================================================================
-- Part 14: Forgetting = Hawking Radiation = Cosmological Expansion
--
-- General Relativity in the mind:
--
--   Einstein's equations:  G_μν + Λ g_μν = (8πG/c⁴) T_μν
--
--   G_μν  = Einstein tensor (curvature from mass-energy)
--   Λ     = cosmological constant (FORGETTING RATE)
--   T_μν  = stress-energy tensor (mass distribution of memories)
--
--   The cosmological constant Λ causes expansion: memories drift apart.
--   If Λ > 0: the manifold expands → memories become isolated → forgetting
--   If Λ = 0: static universe → memories persist forever
--   If Λ < 0: contraction → memories collapse together → over-association
--
--   Hawking radiation: small black holes evaporate faster.
--   Small-mass proteins (weak memories) evaporate first during consolidation.
--   Large-mass proteins (important memories) persist.
--
--   This is WHY we forget trivial things and remember important ones:
--   the important memories have more mass → they survive Hawking evaporation.
--   The trivial memories have little mass → they evaporate.
--
--   Forgetting is not a bug — it's a FEATURE of GR.
--   Without forgetting, the manifold would become too dense (overloaded).
--   The cosmological expansion keeps the manifold manageable.
-- =====================================================================

||| The forgetting rate = cosmological constant Λ.
||| This is how fast memories drift apart due to expansion.
||| Higher Λ = faster forgetting (more expansion).
public export
forgettingRate : HolographicMind -> Double
forgettingRate mind =
  case mindTemp mind of
    HotMemory    => 0.1   -- hot: moderate forgetting (lots of turnover)
    WarmMemory   => 0.05  -- warm: low forgetting (working memory)
    ColdMemory   => 0.01  -- cold: minimal forgetting (consolidation)
    FrozenMemory => 0.0   -- frozen: no forgetting (permanent)

||| The stress-energy tensor trace T = Σ m_i.
||| This is the total mass-energy of all memories.
||| In GR: T_μν is the source of curvature.
||| More total mass = more curvature = stronger associations.
public export
stressEnergyTrace : HolographicMind -> Double
stressEnergyTrace mind =
  cast {to=Double} (manifoldMassEnergy (mindManifold mind))

||| The Einstein tensor: G = T - (D/2)·Λ where D=3 (3D bulk).
||| G > 0: positive curvature (learning is happening, memories cluster)
||| G ≈ 0: flat (equilibrium, no net learning)
||| G < 0: negative curvature (forgetting dominates, memories dissipate)
public export
einsteinTensor : HolographicMind -> Double
einsteinTensor mind =
  let t = stressEnergyTrace mind
      lambda = forgettingRate mind
  in t - 1.5 * lambda  -- D/2 = 3/2 for 3D

||| Run the full GR evolution: one step of Einstein's equations.
||| The metric evolves: weak memories evaporate, strong ones persist.
||| The cosmological constant causes expansion (forgetting).
||| This IS consolidation = throwing away = GR.
public export
grEvolution : HolographicMind -> HolographicMind
grEvolution mind =
  let -- Step 1: Hawking evaporation (forget weak memories)
      afterEvap = mindStep mind
      -- Step 2: Cosmological expansion (drift apart)
      -- The Λ term causes all distances to increase slightly
      -- (implemented implicitly through the metric update)
      -- Step 3: Remaining proteins stabilize (cool further)
      temp = mindTemp afterEvap
      -- If still warm: cool down one notch (consolidation)
      cooledTemp = case temp of
        HotMemory => WarmMemory
        WarmMemory => ColdMemory
        ColdMemory => ColdMemory
        FrozenMemory => FrozenMemory
  in MkMind (mindManifold afterEvap) cooledTemp (mindSurfaceFluc afterEvap)
            (S (mindTime afterEvap))

||| Run multiple steps of GR evolution (deep sleep consolidation).
public export
deepConsolidation : Nat -> HolographicMind -> HolographicMind
deepConsolidation Z mind     = mind
deepConsolidation (S k) mind = deepConsolidation k (grEvolution mind)

||| Diagnostic: show the GR state of the mind.
public export
showGRState : HolographicMind -> String
showGRState mind =
  showMind mind ++ "\n" ++
  "  --- General Relativity State ---\n" ++
  "  Cosmological constant Λ (forgetting): " ++ show (forgettingRate mind) ++ "\n" ++
  "  Stress-energy T (total mass): " ++ show (stressEnergyTrace mind) ++ "\n" ++
  "  Einstein tensor G (curvature): " ++ show (einsteinTensor mind) ++ "\n" ++
  "  Criticality: " ++ show (criticality mind)
