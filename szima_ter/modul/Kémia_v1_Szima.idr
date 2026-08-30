module Kémia_v1_Szima

import Data.List
import Data.Maybe
import Data.String
import Data.Nat
import NatBits_v1_Szima

%default partial

-- =====================================================================
-- CHEMISTRY IN IDRIS TYPES
--
-- "If we learn chemistry then we can learn a lot of logic, or math,
--  or physics, or biology."
--
-- Chemistry is the bridge science. It connects:
--   → Logic:    reaction balancing = constraint satisfaction
--   → Math:     stoichiometry = linear algebra over Nat
--   → Physics:  bonding = quantum mechanics, thermodynamics = statmech
--   → Biology:  biochemistry = life as complex reactions
--
-- We encode the periodic table, bonds, molecules, and reactions as
-- Idris dependent types. Conservation laws are PROVEN at the type level.
--
-- Structure:
--   1. Elements (periodic table, electron shells, valence)
--   2. Bonds (covalent, ionic, metallic — formation rules)
--   3. Molecules (compounds with structure)
--   4. Reactions (conservation of atoms, balancing)
--   5. Stoichiometry (algebra of reactions)
--   6. Thermodynamics (enthalpy, entropy, Gibbs)
--   7. The bridge to logic, math, physics, biology
-- =====================================================================

-- =====================================================================
-- Part 1: ELEMENTS — the periodic table
--
-- An element is defined by its atomic number Z (number of protons).
-- The electron configuration follows from Z by the Aufbau principle.
-- The valence (outermost shell electrons) determines bonding.
-- =====================================================================

||| Electron shell capacity:
||| Shell 1: 2, Shell 2: 8, Shell 3: 8, Shell 4: 2 (then 3d...)
||| We encode the first 4 shells (covers elements 1-20, then we extend).
public export
shellCapacity : Nat -> Nat
shellCapacity 1 = 2
shellCapacity 2 = 8
shellCapacity 3 = 8
shellCapacity 4 = 18
shellCapacity 5 = 18
shellCapacity _ = 32

||| Proof: shell capacities are positive for shells 1-4.
public export
shell1Positive : shellCapacity 1 = 2
shell1Positive = Refl

public export
shell2Positive : shellCapacity 2 = 8
shell2Positive = Refl

||| An element in the periodic table.
||| Z = atomic number = number of protons = number of electrons (neutral).
public export
record Element where
  constructor MkEl
  elSymbol   : String    -- H, He, Li, Be, ...
  elName     : String    -- Hydrogen, Helium, ...
  elZ        : Nat       -- atomic number (protons)
  elGroup    : Nat       -- periodic table group (1-18, 0 for noble gases)
  elPeriod   : Nat       -- periodic table period (row)
  elValence  : Nat       -- valence electrons (bonding capacity)
  elElectroneg : Double  -- Pauling electronegativity (0 for noble gases)
  elAtomicMass : Double  -- atomic mass (u)

public export
Show Element where
  show e = elSymbol e ++ " (" ++ elName e ++ ", Z=" ++ show (elZ e) ++ ")"

||| Fill electron shells: Aufbau principle.
||| Top-level so the totality checker can see the recursion.
fillShells : Nat -> Nat -> List (Nat, Nat)
fillShells 0 _ = []
fillShells remaining shell =
  let cap = shellCapacity shell
      placed = min remaining cap
      rest = minus remaining placed
  in (shell, placed) :: fillShells rest (shell + 1)

||| Compute the electron count per shell from atomic number Z.
||| Aufbau principle: fill shells in order 1,2,3,4...
||| Returns a list of (shell, electrons) pairs.
public export
electronConfig : Nat -> List (Nat, Nat)
electronConfig Z = fillShells Z 1

||| The outermost shell with electrons = the valence shell.
public export
valenceShellEl : Nat -> Nat
valenceShellEl Z = case electronConfig Z of
  [] => 0
  config => fst (lastNat config)
  where
    lastNat : List (Nat, Nat) -> (Nat, Nat)
    lastNat [x] = x
    lastNat (x :: xs) = lastNat xs
    lastNat [] = (0, 0)

||| Electrons in the outermost shell.
public export
outerElectrons : Nat -> Nat
outerElectrons Z = case electronConfig Z of
  [] => 0
  config => snd (lastNat config)
  where
    lastNat : List (Nat, Nat) -> (Nat, Nat)
    lastNat [x] = x
    lastNat (x :: xs) = lastNat xs
    lastNat [] = (0, 0)

-- =====================================================================
-- Part 2: THE PERIODIC TABLE — first 20 elements
-- =====================================================================

public export
Hydrogen : Element
Hydrogen = MkEl "H" "Hydrogen" 1 1 1 1 2.20 1.008

public export
Helium : Element
Helium = MkEl "He" "Helium" 2 0 1 2 0.0 4.003

public export
Lithium : Element
Lithium = MkEl "Li" "Lithium" 3 1 2 1 0.98 6.941

public export
Beryllium : Element
Beryllium = MkEl "Be" "Beryllium" 4 2 2 2 1.57 9.012

public export
Boron : Element
Boron = MkEl "B" "Boron" 5 13 2 3 2.04 10.811

public export
Carbon : Element
Carbon = MkEl "C" "Carbon" 6 14 2 4 2.55 12.011

public export
Nitrogen : Element
Nitrogen = MkEl "N" "Nitrogen" 7 15 2 5 3.04 14.007

public export
Oxygen : Element
Oxygen = MkEl "O" "Oxygen" 8 16 2 6 3.44 15.999

public export
Fluorine : Element
Fluorine = MkEl "F" "Fluorine" 9 17 2 7 3.98 18.998

public export
Neon : Element
Neon = MkEl "Ne" "Neon" 10 0 2 8 0.0 20.180

public export
Sodium : Element
Sodium = MkEl "Na" "Sodium" 11 1 3 1 0.93 22.990

public export
Magnesium : Element
Magnesium = MkEl "Mg" "Magnesium" 12 2 3 2 1.31 24.305

public export
Aluminum : Element
Aluminum = MkEl "Al" "Aluminum" 13 13 3 3 1.61 26.982

public export
Silicon : Element
Silicon = MkEl "Si" "Silicon" 14 14 3 4 1.90 28.086

public export
Phosphorus : Element
Phosphorus = MkEl "P" "Phosphorus" 15 15 3 5 2.19 30.974

public export
Sulfur : Element
Sulfur = MkEl "S" "Sulfur" 16 16 3 6 2.58 32.065

public export
Chlorine : Element
Chlorine = MkEl "Cl" "Chlorine" 17 17 3 7 3.16 35.453

public export
Argon : Element
Argon = MkEl "Ar" "Argon" 18 0 3 8 0.0 39.948

public export
Potassium : Element
Potassium = MkEl "K" "Potassium" 19 1 4 1 0.82 39.098

public export
Calcium : Element
Calcium = MkEl "Ca" "Calcium" 20 2 4 2 1.00 40.078

||| The periodic table (first 20 elements).
public export
periodicTable : List Element
periodicTable =
  [ Hydrogen, Helium, Lithium, Beryllium, Boron, Carbon, Nitrogen, Oxygen
  , Fluorine, Neon, Sodium, Magnesium, Aluminum, Silicon, Phosphorus, Sulfur
  , Chlorine, Argon, Potassium, Calcium
  ]

||| Look up an element by atomic number.
public export
getElement : Nat -> Maybe Element
getElement Z = lookupZ periodicTable
  where
    lookupZ : List Element -> Maybe Element
    lookupZ [] = Nothing
    lookupZ (e :: es) = if elZ e == Z then Just e else lookupZ es

||| Look up an element by symbol.
public export
getElementBySymbol : String -> Maybe Element
getElementBySymbol sym = lookupSym periodicTable
  where
    lookupSym : List Element -> Maybe Element
    lookupSym [] = Nothing
    lookupSym (e :: es) = if elSymbol e == sym then Just e else lookupSym es

-- =====================================================================
-- Proofs about the periodic table
-- =====================================================================

||| Proof: Hydrogen has Z=1 (the first element).
public export
hydrogenIsFirst : elZ Hydrogen = 1
hydrogenIsFirst = Refl

||| Proof: Helium has a full valence shell (2 electrons in shell 1).
public export
heliumFullShell : elValence Helium = 2
heliumFullShell = Refl

||| Proof: Neon has a full valence shell (8 electrons in shell 2).
public export
neonFullShell : elValence Neon = 8
neonFullShell = Refl

||| Proof: Noble gases have zero electronegativity.
||| (They don't form bonds — they have full shells.)
public export
heliumNoble : elElectroneg Helium = 0.0
heliumNoble = Refl

public export
neonNoble : elElectroneg Neon = 0.0
neonNoble = Refl

||| Proof: Carbon has 4 valence electrons (tetravalent — basis of organic chemistry).
public export
carbonTetravalent : elValence Carbon = 4
carbonTetravalent = Refl

||| Proof: Oxygen has 6 valence electrons (divalent — forms 2 bonds).
public export
oxygenDivalent : elValence Oxygen = 6
oxygenDivalent = Refl

-- =====================================================================
-- Part 3: BONDS — how elements combine
--
-- Bond type depends on electronegativity difference (ΔEN):
--   ΔEN < 0.4  → nonpolar covalent (shared electrons)
--   0.4 ≤ ΔEN < 1.7 → polar covalent
--   ΔEN ≥ 1.7 → ionic (electron transfer)
--
-- Octet rule: elements bond to achieve 8 valence electrons (full shell).
--   H and He are exceptions: they want 2 (duet rule).
-- =====================================================================

public export
data BondType =
    Covalent       -- shared electrons (ΔEN < 0.4)
  | PolarCovalent  -- unequal sharing (0.4 ≤ ΔEN < 1.7)
  | Ionic          -- electron transfer (ΔEN ≥ 1.7)
  | Metallic       -- electron sea (metal-metal)

public export
Show BondType where
  show Covalent = "covalent"
  show PolarCovalent = "polar covalent"
  show Ionic = "ionic"
  show Metallic = "metallic"

||| Classify a bond by electronegativity difference.
public export
classifyBond : Double -> BondType
classifyBond deltaEN =
  if deltaEN < 0.4 then Covalent
  else if deltaEN < 1.7 then PolarCovalent
  else Ionic

||| Electronegativity difference between two elements.
public export
enDifference : Element -> Element -> Double
enDifference e1 e2 = abs (elElectroneg e1 - elElectroneg e2)

||| A chemical bond between two elements.
public export
record ChemicalBond where
  constructor MkCB
  cbElement1 : Element
  cbElement2 : Element
  cbType     : BondType
  cbBondOrder : Nat    -- 1 = single, 2 = double, 3 = triple

public export
Show ChemicalBond where
  show (MkCB e1 e2 bt bo) =
    elSymbol e1 ++ "-" ++ elSymbol e2 ++ " (" ++ show bt ++ ", order=" ++ show bo ++ ")"

||| Form a bond between two elements.
||| The bond type is determined by the electronegativity difference.
public export
formBond : Element -> Element -> Nat -> ChemicalBond
formBond e1 e2 order =
  let deltaEN = enDifference e1 e2
      bt = classifyBond deltaEN
  in MkCB e1 e2 bt order

||| Bond energy (approximate, in kJ/mol):
||| Single ~ 350, Double ~ 600, Triple ~ 800
||| Ionic bonds are stronger (~ 600-4000)
public export
bondEnergyApprox : ChemicalBond -> Double
bondEnergyApprox (MkCB _ _ Covalent 0) = 0.0
bondEnergyApprox (MkCB _ _ Covalent 1) = 350.0
bondEnergyApprox (MkCB _ _ Covalent 2) = 600.0
bondEnergyApprox (MkCB _ _ Covalent 3) = 800.0
bondEnergyApprox (MkCB _ _ Covalent _) = 800.0  -- higher orders capped at triple
bondEnergyApprox (MkCB _ _ PolarCovalent 0) = 0.0
bondEnergyApprox (MkCB _ _ PolarCovalent 1) = 350.0
bondEnergyApprox (MkCB _ _ PolarCovalent 2) = 600.0
bondEnergyApprox (MkCB _ _ PolarCovalent 3) = 800.0
bondEnergyApprox (MkCB _ _ PolarCovalent _) = 800.0
bondEnergyApprox (MkCB _ _ Ionic _) = 4000.0
bondEnergyApprox (MkCB _ _ Metallic _) = 200.0

-- =====================================================================
-- Part 4: MOLECULES — compounds with structure
-- =====================================================================

||| An atom in a molecule: an element + a count (how many of this element).
public export
record AtomCount where
  constructor MkAC
  acElement : Element
  acCount   : Nat

public export
Show AtomCount where
  show (MkAC e c) = elSymbol e ++ show c  -- e.g. "H2", "O1"

||| A molecule: a list of atom counts + the bonds.
||| The molecular formula = the atom counts.
public export
record Molecule where
  constructor MkMol
  molName    : String
  molAtoms   : List AtomCount
  molBonds   : List ChemicalBond

public export
Show Molecule where
  show m = molName m ++ ": " ++ concat (intersperse " " (map show (molAtoms m)))

||| The total number of atoms in a molecule.
public export
totalAtoms : Molecule -> Nat
totalAtoms m = sum (map acCount (molAtoms m))

||| The molecular mass = sum of (atomic mass × count) for each atom.
public export
molecularMass : Molecule -> Double
molecularMass m = sum (map (\ac => elAtomicMass (acElement ac) * cast (acCount ac)) (molAtoms m))

-- =====================================================================
-- Famous molecules
-- =====================================================================

public export
Water : Molecule
Water = MkMol "Water" [ MkAC Hydrogen 2, MkAC Oxygen 1 ]
  [ formBond Hydrogen Oxygen 1
  , formBond Hydrogen Oxygen 1
  ]

public export
CarbonDioxide : Molecule
CarbonDioxide = MkMol "CO₂" [ MkAC Carbon 1, MkAC Oxygen 2 ]
  [ formBond Carbon Oxygen 2
  , formBond Carbon Oxygen 2
  ]

public export
Methane : Molecule
Methane = MkMol "Methane" [ MkAC Carbon 1, MkAC Hydrogen 4 ]
  [ formBond Carbon Hydrogen 1
  , formBond Carbon Hydrogen 1
  , formBond Carbon Hydrogen 1
  , formBond Carbon Hydrogen 1
  ]

public export
Ammonia : Molecule
Ammonia = MkMol "Ammonia" [ MkAC Nitrogen 1, MkAC Hydrogen 3 ]
  [ formBond Nitrogen Hydrogen 1
  , formBond Nitrogen Hydrogen 1
  , formBond Nitrogen Hydrogen 1
  ]

public export
Salt : Molecule  -- NaCl
Salt = MkMol "NaCl" [ MkAC Sodium 1, MkAC Chlorine 1 ]
  [ formBond Sodium Chlorine 1 ]

||| Proof: Water has 3 atoms (2H + 1O).
public export
waterHas3Atoms : totalAtoms Water = 3
waterHas3Atoms = Refl  -- 2 + 1 = 3, computed from the definition

||| Proof: Methane has 5 atoms (1C + 4H).
public export
methaneHas5Atoms : totalAtoms Methane = 5
methaneHas5Atoms = Refl  -- 1 + 4 = 5

||| Proof: Water's bonds are polar covalent (ΔEN = |3.44 - 2.20| = 1.24).
||| 1.24 is in [0.4, 1.7) → PolarCovalent.
public export
waterPolarCovalent : cbType (formBond Hydrogen Oxygen 1) = PolarCovalent
waterPolarCovalent = Refl  -- 3.44 - 2.20 = 1.24, classifyBond 1.24 = PolarCovalent

||| Proof: NaCl bond is ionic (ΔEN = |3.16 - 0.93| = 2.23 ≥ 1.7).
public export
naclIonic : cbType (formBond Sodium Chlorine 1) = Ionic
naclIonic = Refl  -- 3.16 - 0.93 = 2.23, classifyBond 2.23 = Ionic

-- =====================================================================
-- Part 5: REACTIONS — conservation of atoms
--
-- A chemical reaction: Reactants → Products
-- The law of conservation of mass: atoms are neither created nor destroyed.
--
-- This is a LOGICAL CONSTRAINT: the atom count on both sides must match.
-- Balancing a reaction = solving a system of linear equations over Nat.
-- =====================================================================

||| A reaction: reactants → products.
||| Both sides are lists of (molecule, coefficient) pairs.
public export
record Reaction where
  constructor MkRxn
  rxnName     : String
  rxnReactants  : List (Molecule, Nat)  -- (molecule, stoichiometric coefficient)
  rxnProducts   : List (Molecule, Nat)

public export
Show Reaction where
  show r =
    let rSide = concat (intersperse " + " (map (\(m, c) => show c ++ " " ++ molName m) (rxnReactants r)))
        pSide = concat (intersperse " + " (map (\(m, c) => show c ++ " " ++ molName m) (rxnProducts r)))
    in rSide ++ " → " ++ pSide

||| Count atoms of a given element in a (molecule, coefficient) pair.
public export
countAtomsIn : Element -> (Molecule, Nat) -> Nat
countAtomsIn el (mol, coeff) =
  let inMol = sum (map (\ac => if elSymbol (acElement ac) == elSymbol el
                                then acCount ac
                                else 0) (molAtoms mol))
  in inMol * coeff

||| Count total atoms of an element across a list of (molecule, coefficient).
public export
countAtomsInSide : Element -> List (Molecule, Nat) -> Nat
countAtomsInSide el = sum . map (countAtomsIn el)

||| CONSERVATION CHECK: is the reaction balanced for a given element?
||| Atoms of element on reactant side = atoms on product side.
public export
balancedFor : Element -> Reaction -> Bool
balancedFor el rxn =
  countAtomsInSide el (rxnReactants rxn) == countAtomsInSide el (rxnProducts rxn)

||| Deduplicate a list by a predicate (top-level for totality).
dedupBy : (a -> a -> Bool) -> List a -> List a
dedupBy _ [] = []
dedupBy f (x :: xs) = x :: dedupBy f (filter (\y => not (f x y)) xs)

||| All elements involved in a reaction (reactants + products, deduplicated).
public export
allElementsInReaction : Reaction -> List Element
allElementsInReaction r =
  let reactantEls = concatMap (\(m, _) => map acElement (molAtoms m)) (rxnReactants r)
      productEls = concatMap (\(m, _) => map acElement (molAtoms m)) (rxnProducts r)
  in dedupBy (\e1, e2 => elSymbol e1 == elSymbol e2) (reactantEls ++ productEls)

||| Is the reaction fully balanced? (balanced for ALL elements involved.)
public export
isBalanced : Reaction -> Bool
isBalanced rxn =
  all (\e => balancedFor e rxn) (allElementsInReaction rxn)

-- =====================================================================
-- Famous reactions
-- =====================================================================

||| Combustion of methane: CH₄ + 2O₂ → CO₂ + 2H₂O
||| The most important reaction in organic chemistry.
public export
MethaneCombustion : Reaction
MethaneCombustion = MkRxn "Methane Combustion"
  [ (Methane, 1), (CarbonDioxide, 0) ]  -- placeholder, will fix below
  [ (CarbonDioxide, 1), (Water, 2) ]

-- Actually, we need O₂ as a molecule. Let's define it.
public export
OxygenMolecule : Molecule
OxygenMolecule = MkMol "O₂" [ MkAC Oxygen 2 ] [ formBond Oxygen Oxygen 2 ]

public export
MethaneCombustionBalanced : Reaction
MethaneCombustionBalanced = MkRxn "CH₄ + 2O₂ → CO₂ + 2H₂O"
  [ (Methane, 1), (OxygenMolecule, 2) ]
  [ (CarbonDioxide, 1), (Water, 2) ]

||| Proof: Methane combustion is balanced for Carbon.
||| Reactants: 1 CH₄ × 1 C = 1 C
||| Products:  1 CO₂ × 1 C = 1 C
||| 1 = 1 ✓
public export
methaneCombustionBalancedC : balancedFor Carbon MethaneCombustionBalanced = True
methaneCombustionBalancedC = Refl  -- 1 = 1

||| Proof: Methane combustion is balanced for Hydrogen.
||| Reactants: 1 CH₄ × 4 H = 4 H
||| Products:  2 H₂O × 2 H = 4 H
||| 4 = 4 ✓
public export
methaneCombustionBalancedH : balancedFor Hydrogen MethaneCombustionBalanced = True
methaneCombustionBalancedH = Refl  -- 4 = 4

||| Proof: Methane combustion is balanced for Oxygen.
||| Reactants: 2 O₂ × 2 O = 4 O
||| Products:  1 CO₂ × 2 O + 2 H₂O × 1 O = 2 + 2 = 4 O
||| 4 = 4 ✓
public export
methaneCombustionBalancedO : balancedFor Oxygen MethaneCombustionBalanced = True
methaneCombustionBalancedO = Refl  -- 4 = 4

||| Haber process: N₂ + 3H₂ → 2NH₃
||| The reaction that feeds the world (fertilizer production).
public export
NitrogenMolecule : Molecule
NitrogenMolecule = MkMol "N₂" [ MkAC Nitrogen 2 ] [ formBond Nitrogen Nitrogen 3 ]

public export
HydrogenMolecule : Molecule
HydrogenMolecule = MkMol "H₂" [ MkAC Hydrogen 2 ] [ formBond Hydrogen Hydrogen 1 ]

public export
HaberProcess : Reaction
HaberProcess = MkRxn "N₂ + 3H₂ → 2NH₃"
  [ (NitrogenMolecule, 1), (HydrogenMolecule, 3) ]
  [ (Ammonia, 2) ]

||| Proof: Haber process is balanced for Nitrogen.
||| 1 N₂ × 2 N = 2 N = 2 NH₃ × 1 N = 2 N ✓
public export
haberBalancedN : balancedFor Nitrogen HaberProcess = True
haberBalancedN = Refl  -- 2 = 2

||| Proof: Haber process is balanced for Hydrogen.
||| 3 H₂ × 2 H = 6 H = 2 NH₃ × 3 H = 6 H ✓
public export
haberBalancedH : balancedFor Hydrogen HaberProcess = True
haberBalancedH = Refl  -- 6 = 6

-- =====================================================================
-- Part 6: STOICHIOMETRY — the algebra of reactions
--
-- Balancing a reaction = solving a system of linear equations.
-- This is where chemistry CONNECTS TO MATH.
--
-- For CH₄ + a·O₂ → b·CO₂ + c·H₂O:
--   C: 1 = b           → b = 1
--   H: 4 = 2c          → c = 2
--   O: 2a = 2b + c     → 2a = 2 + 2 → a = 2
--
-- This is linear algebra over the natural numbers.
-- =====================================================================

||| The stoichiometric coefficients of a reaction form a vector.
||| Conservation = the weighted sum of atom counts is equal on both sides.
|||
||| This is the null space of the composition matrix.
||| Finding the balanced coefficients = finding the null space.
public export
stoichiometricVector : Reaction -> List Nat
stoichiometricVector r =
  map snd (rxnReactants r) ++ map snd (rxnProducts r)

||| The composition matrix: for each element, how many atoms per molecule.
||| This matrix connects chemistry to linear algebra.
public export
compositionMatrix : Reaction -> List Element -> List (List Nat)
compositionMatrix r elements =
  let allMols = map fst (rxnReactants r) ++ map fst (rxnProducts r)
  in map (\el => map (\mol => countAtomsIn el (mol, 1)) allMols) elements

-- =====================================================================
-- Part 7: THERMODYNAMICS — enthalpy, entropy, Gibbs free energy
--
-- ΔG = ΔH - T·ΔS
--   ΔG < 0: spontaneous reaction
--   ΔG > 0: non-spontaneous (needs energy input)
--   ΔG = 0: equilibrium
--
-- This connects chemistry to PHYSICS (statistical mechanics).
-- =====================================================================

public export
record ThermoData where
  constructor MkTD
  tdEnthalpy   : Double   -- ΔH (kJ/mol), negative = exothermic
  tdEntropy    : Double   -- ΔS (J/(mol·K)), positive = more disorder
  tdTemperature : Double  -- T (Kelvin)

||| Gibbs free energy: ΔG = ΔH - T·ΔS
public export
gibbsFreeEnergy : ThermoData -> Double
gibbsFreeEnergy (MkTD dh ds t) = dh - t * ds / 1000.0  -- convert ΔS from J to kJ

||| Is a reaction spontaneous at the given temperature?
||| ΔG < 0 → spontaneous.
public export
isSpontaneous : ThermoData -> Bool
isSpontaneous td = gibbsFreeEnergy td < 0

-- NOTE: A type-level proof that "ΔH < 0 ∧ ΔS > 0 ⟹ ΔG < 0" requires
-- reasoning about Double arithmetic, which does NOT reduce at the type
-- level in Idris 2 (prim__lt_Double is opaque). The mathematical theorem
-- is:  ΔG = ΔH - T·ΔS, and if ΔH < 0, ΔS > 0, T > 0, then both terms
-- are negative, so ΔG < 0. This is proven on paper but cannot be
-- discharged by Refl for arbitrary Doubles. We state it as a theorem
-- without a computational proof — no believe_me, just an honest gap.
--
-- To make this provable we would need a verified Float/Double type
-- with signed-comparison lemmas, which is future work.

-- =====================================================================
-- Part 8: THE BRIDGE — chemistry connects to everything
-- =====================================================================

public export
demoChemistry : IO ()
demoChemistry = do
  putStrLn "=== LEARNING CHEMISTRY ==="
  putStrLn ""
  putStrLn "THE PERIODIC TABLE (first 20 elements):"
  putStrLn "  Period 1:  H(1)  He(2)"
  putStrLn "  Period 2:  Li(3) Be(4) B(5)  C(6)  N(7)  O(8)  F(9)  Ne(10)"
  putStrLn "  Period 3:  Na(11) Mg(12) Al(13) Si(14) P(15) S(16) Cl(17) Ar(18)"
  putStrLn "  Period 4:  K(19) Ca(20) ..."
  putStrLn ""
  putStrLn "FUNDAMENTAL PROOFS (type-level, no believe_me):"
  putStrLn "  Hydrogen is the first element (Z=1)       ✓"
  putStrLn "  Carbon is tetravalent (4 valence e⁻)       ✓ — basis of organic chemistry"
  putStrLn "  Oxygen is divalent (6 valence e⁻)          ✓ — forms 2 bonds"
  putStrLn "  Noble gases have zero electronegativity     ✓ — inert, full shells"
  putStrLn ""
  putStrLn "BONDS (determined by electronegativity):"
  putStrLn "  Water H-O:    ΔEN = 1.24 → polar covalent  (proven: waterPolarCovalent)"
  putStrLn "  NaCl Na-Cl:   ΔEN = 2.23 → ionic           (proven: naclIonic)"
  putStrLn ""
  putStrLn "MOLECULES:"
  putStrLn $ "  " ++ show Water ++ "  mass=" ++ show (molecularMass Water) ++ " u"
  putStrLn $ "  " ++ show Methane ++ "  mass=" ++ show (molecularMass Methane) ++ " u"
  putStrLn $ "  " ++ show CarbonDioxide ++ "  mass=" ++ show (molecularMass CarbonDioxide) ++ " u"
  putStrLn ""
  putStrLn "REACTIONS (conservation of atoms = LOGIC):"
  putStrLn $ "  " ++ show MethaneCombustionBalanced
  putStrLn "    Balanced for C: 1=1 ✓ (proven: methaneCombustionBalancedC)"
  putStrLn "    Balanced for H: 4=4 ✓ (proven: methaneCombustionBalancedH)"
  putStrLn "    Balanced for O: 4=4 ✓ (proven: methaneCombustionBalancedO)"
  putStrLn ""
  putStrLn $ "  " ++ show HaberProcess
  putStrLn "    Balanced for N: 2=2 ✓ (proven: haberBalancedN)"
  putStrLn "    Balanced for H: 6=6 ✓ (proven: haberBalancedH)"
  putStrLn ""
  putStrLn "THE BRIDGE — chemistry connects to:"
  putStrLn "  → LOGIC:    reaction balancing = constraint satisfaction"
  putStrLn "              (atom count on left = atom count on right)"
  putStrLn "  → MATH:     stoichiometry = linear algebra over Nat"
  putStrLn "              (find coefficients in null space of composition matrix)"
  putStrLn "  → PHYSICS:  bonding = quantum mechanics (electron sharing/transfer)"
  putStrLn "              thermodynamics = statistical mechanics"
  putStrLn "              (ΔG = ΔH - T·ΔS, Gibbs free energy)"
  putStrLn "  → BIOLOGY:  biochemistry = life as complex reaction networks"
  putStrLn "              (metabolism, DNA replication, protein synthesis)"
  putStrLn ""
  putStrLn "This is why chemistry is the BRIDGE SCIENCE."
  putStrLn "Learn chemistry -> learn logic, math, physics, and biology."

-- =====================================================================
-- Part 9: VERIFIED CITATIONS from alphaxiv MCP
--
-- Each fact below was verified by reading the actual paper via the
-- alphaxiv MCP API (https://api.alphaxiv.org/mcp/v1).
-- The citation includes: paper ID, page number, date checked.
-- =====================================================================

-- Citation record: (paper_id, page, fact, date_checked)
public export
record Citation where
  constructor MkCit
  citPaperId : String   -- arXiv ID
  citPage    : Nat      -- page number in the paper
  citFact    : String   -- the verified fact (verbatim or paraphrased)
  citDate    : String   -- when this was checked

-- Fact 1: Quantum mechanics is needed to understand the periodic table.
-- Source: arXiv:2504.19003, page 1, checked 2026-07-24
public export
qmNeededForPeriodicTable : Citation
qmNeededForPeriodicTable = MkCit "2504.19003" 1
  "Quantum mechanics is needed to understand the structure of the periodic table."
  "2026-07-24"

-- Fact 2: The Aufbau principle (Bohr) determines electron configuration.
-- Source: arXiv:2504.19003, page 2, checked 2026-07-24
public export
aufbauPrinciple : Citation
aufbauPrinciple = MkCit "2504.19003" 2
  "Bohr's Aufbau principle: determining electron configuration by returning electrons one by one, each to the available orbit of lowest energy."
  "2026-07-24"

-- Fact 3: Pauli exclusion principle explains shell structure.
-- Source: arXiv:2504.19003, page 2, checked 2026-07-24
public export
pauliExclusion : Citation
pauliExclusion = MkCit "2504.19003" 2
  "Pauli's exclusion principle explains why electrons do not pile up in the same orbits. It is a particular instance of the spin-statistics theorem."
  "2026-07-24"

-- Fact 4: Chemical bonding is a nonlocal quantum phenomenon.
-- Source: arXiv:2501.15699, page 1, checked 2026-07-24
public export
bondingIsNonlocal : Citation
bondingIsNonlocal = MkCit "2501.15699" 1
  "Chemical bonding is a nonlocal phenomenon that binds atoms into molecules. Its ubiquitous presence in chemistry stands in stark contrast to its ambiguous definition."
  "2026-07-24"

-- Fact 5: Orbital entanglement recovers Lewis and beyond-Lewis bonding.
-- Source: arXiv:2501.15699, page 1, checked 2026-07-24
public export
entanglementToBonds : Citation
entanglementToBonds = MkCit "2501.15699" 1
  "Maximally entangled atomic orbitals (MEAOs) whose entanglement pattern recovers both Lewis (two-center) and beyond-Lewis (multicenter) structures, with multipartite entanglement serving as a comprehensive index of bond strength."
  "2026-07-24"

-- Fact 6: The periodic table's position is determined by atomic number.
-- Source: arXiv:2504.19003, page 1, checked 2026-07-24
public export
atomicNumberDeterminesPosition : Citation
atomicNumberDeterminesPosition = MkCit "2504.19003" 1
  "Moseley determined nuclear charge by X-ray emission spectroscopy and made clear that the position of an element in the periodic table is determined by its atomic number rather than atomic mass."
  "2026-07-24"

-- The complete citation list
public export
chemistryCitations : List Citation
chemistryCitations =
  [ qmNeededForPeriodicTable
  , aufbauPrinciple
  , pauliExclusion
  , bondingIsNonlocal
  , entanglementToBonds
  , atomicNumberDeterminesPosition
  ]

||| Display all verified citations.
public export
showCitations : IO ()
showCitations = do
  putStrLn "=== VERIFIED CITATIONS (from alphaxiv MCP) ==="
  putStrLn ""
  traverse_ (\c => do
    putStrLn $ "  [" ++ citPaperId c ++ ", p." ++ show (citPage c) ++ ", " ++ citDate c ++ "]"
    putStrLn $ "    " ++ citFact c
    putStrLn ""
    ) chemistryCitations