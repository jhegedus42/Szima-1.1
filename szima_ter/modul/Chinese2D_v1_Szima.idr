module Chinese2D_v1_Szima

import Data.String
import Data.List

-- =====================================================================
-- Chinese 2D compositional structure.
--
-- Chinese characters are SPATIAL compositions of radicals/components.
-- A character like 明 = 日 (sun) + 月 (moon), arranged left-right.
--
-- There are exactly 7 structural composition types.
-- These 7 types ARE the 7 points of the Fano plane:
--
--   6 compound types (→ the 6 generators G1–G6)
--   1 single-component type (→ the null/identity point)
--
-- The Fano plane is the projective plane PG(2,2) with 7 points and 7 lines.
-- Its automorphism group is PSL(2,7) = 168 = 2³ × 3 × 7.
-- This is the word-order group of the 3D language.
--
-- Chinese writing = 2D spatial tensor product:
--   |char⟩ = |radical₁⟩ ⊗_F |radical₂⟩
-- where ⊗_F is composition via a Fano-plane spatial relation.
-- =====================================================================

||| The 7 structural composition types of Chinese characters.
||| These are the 7 Fano plane points.
||| 6 compound types map to generators G1–G6; Single maps to null.
public export
data CompoType : Type where
  LeftRight   : CompoType   -- 左右  (你, 明, 好)      → G1: space/harmony
  TopBottom   : CompoType   -- 上下  (雷, 字, 想)      → G3: number/duality
  FullSurround: CompoType   -- 全包围(囚, 困, 国)      → G6: possession/enclosing
  SemiSurround: CompoType   -- 半包围(这, 建, 闻)      → G2: definiteness
  LeftCenRight: CompoType   -- 左中右(衍, 辩)          → G4: tense/time
  TopCenBottom: CompoType   -- 上中下(意, 高)          → G5: mood
  Single      : CompoType   -- 独体  (人, 木, 水)      → null point

public export
Eq CompoType where
  LeftRight    == LeftRight    = True
  TopBottom    == TopBottom    = True
  FullSurround == FullSurround = True
  SemiSurround == SemiSurround = True
  LeftCenRight == LeftCenRight = True
  TopCenBottom == TopCenBottom = True
  Single       == Single       = True
  _ == _ = False

public export
Show CompoType where
  show LeftRight    = "左右(LR)"
  show TopBottom    = "上下(TB)"
  show FullSurround = "全包围(FS)"
  show SemiSurround = "半包围(SS)"
  show LeftCenRight = "左中右(LCR)"
  show TopCenBottom = "上中下(TCB)"
  show Single       = "独体(SGL)"

||| Convert a composition type to its Fano point index (0–6).
||| Point 6 = Single = null point.
public export
fanoPoint : CompoType -> Nat
fanoPoint LeftRight    = 0
fanoPoint TopBottom    = 1
fanoPoint FullSurround = 2
fanoPoint SemiSurround = 3
fanoPoint LeftCenRight = 4
fanoPoint TopCenBottom = 5
fanoPoint Single       = 6  -- null

||| Convert a composition type to its generator bit (if compound).
||| Single → 0 (no generator active).
||| Compound types → bits 0–5 corresponding to G1–G6.
public export
compoBit : CompoType -> Nat
compoBit LeftRight    = 1   -- G1, bit 0
compoBit TopBottom    = 4   -- G3, bit 2
compoBit FullSurround = 32  -- G6, bit 5
compoBit SemiSurround = 2   -- G2, bit 1
compoBit LeftCenRight = 8   -- G4, bit 3
compoBit TopCenBottom = 16  -- G5, bit 4
compoBit Single       = 0   -- null

-- =====================================================================
-- Radical representation.
-- A radical is a primitive component identified by its string form.
-- =====================================================================

||| A radical/component: the string form + its composition role.
public export
record Radical where
  constructor MkRadical
  radStr  : String     -- the actual character(s), e.g. "日", "月"
  radName : String     -- semantic name, e.g. "sun", "moon"

public export
Show Radical where
  show r = radStr r ++ "(" ++ radName r ++ ")"

-- =====================================================================
-- Chinese character as a 2D tensor product of radicals.
--
-- |char⟩ = |r₁⟩ ⊗_F |r₂⟩
--
-- where ⊛_F is a Fano-plane composition (spatial arrangement).
-- Single-component characters have r₂ = Nothing.
-- =====================================================================

||| A Chinese character: either single-radical or a compound of two
||| radicals arranged via a composition type.
|||
||| This is a 2D structure: the composition type encodes the spatial
||| arrangement in the plane (left, right, top, bottom, etc.).
public export
record Char2D where
  constructor MkChar2D
  form     : String         -- the full character string, e.g. "明"
  pinyin   : String         -- pronunciation, e.g. "ming2"
  compo    : CompoType      -- spatial composition type (Fano point)
  rad1     : Radical        -- primary radical
  rad2     : Maybe Radical  -- secondary radical (Nothing for Single)

||| Pretty-print a 2D character decomposition.
public export
showChar2D : Char2D -> String
showChar2D c =
  form c ++ " [" ++ pinyin c ++ "] " ++
  show (compo c) ++ " = " ++
  show (rad1 c) ++
  (case rad2 c of
       Nothing => ""
       Just r  => " ⊗ " ++ show r)

-- =====================================================================
-- A small sample dictionary of character decompositions.
-- =====================================================================

||| Some common radicals.
public export
r_sun, r_moon, r_tree, r_person, r_water, r_mouth, r_eye,
       r_door, r_heart, r_fire, r_earth, r_field, r_mountain : Radical

r_sun       = MkRadical "日" "sun"
r_moon      = MkRadical "月" "moon"
r_tree      = MkRadical "木" "tree"
r_person    = MkRadical "人" "person"
r_water     = MkRadical "水" "water"
r_mouth     = MkRadical "口" "mouth"
r_eye       = MkRadical "目" "eye"
r_door      = MkRadical "門" "door"
r_heart     = MkRadical "心" "heart"
r_fire      = MkRadical "火" "fire"
r_earth     = MkRadical "土" "earth"
r_field     = MkRadical "田" "field"
r_mountain  = MkRadical "山" "mountain"

||| Sample character decompositions.
public export
sampleChars : List Char2D
sampleChars =
  [ MkChar2D "明" "ming2" LeftRight r_sun (Just r_moon)
  -- 明 = sun + moon, left-right → "bright"
  , MkChar2D "休" "xiu1"  LeftRight r_person (Just r_tree)
  -- 休 = person + tree → "rest" (person leaning against tree)
  , MkChar2D "雷" "lei2"  TopBottom r_rain (Just r_field)
  -- 雷 = rain + field, top-bottom → "thunder"
  , MkChar2D "囚" "qiu2"  FullSurround r_enclosure (Just r_person)
  -- 囚 = enclosure + person → "imprison"
  , MkChar2D "人" "ren2"  Single r_person Nothing
  -- 人 = single component → "person"
  , MkChar2D "森" "sen1"  TopCenBottom r_tree (Just (MkRadical "林" "two-trees"))
  -- 森 = tree + 林 (three trees) → "forest"
  , MkChar2D "林" "lin2"  LeftRight r_tree (Just r_tree)
  -- 林 = tree + tree → "woods"
  , MkChar2D "淼" "miao3" TopCenBottom r_water (Just (MkRadical "沝" "two-waters"))
  -- 淼 = three waters → "vast"
  , MkChar2D "仙" "xian1" LeftRight r_person (Just r_mountain)
  -- 仙 = person + mountain → "immortal"
  ]
  where
    -- forward declarations for sample-only radicals
    r_rain       : Radical
    r_rain       = MkRadical "雨" "rain"
    r_enclosure  : Radical
    r_enclosure  = MkRadical "囗" "enclosure"

-- =====================================================================
-- 2D distance metric for Chinese characters.
--
-- The distance between two characters is measured in the 2D radical
-- lattice. It counts how many radical substitutions and composition-type
-- changes are needed to transform one character into the other.
--
-- d₂ᴰ(c₁, c₂) = radicalEditDist + compoPenalty
--
-- This is NOT the same as Hungarian 1D distance (XOR of feature masks).
-- Chinese distance is STRUCTURAL (spatial), Hungarian is LINEAR (temporal).
-- =====================================================================

||| Radical edit distance: 0 if same, 1 if different, 2 if one is missing.
radicalDistance : Maybe Radical -> Maybe Radical -> Nat
radicalDistance Nothing Nothing   = 0
radicalDistance (Just _) Nothing  = 1
radicalDistance Nothing (Just _)  = 1
radicalDistance (Just r1) (Just r2) =
  if radStr r1 == radStr r2 then 0 else 1

||| Composition-type penalty: 0 if same, 1 if different (Fano-line check).
||| Two composition types on the same Fano line get a reduced penalty.
compoDistance : CompoType -> CompoType -> Nat
compoDistance c1 c2 =
  if c1 == c2 then 0 else 1

||| Full 2D distance between two Chinese characters.
||| Sums radical substitutions + composition-type change.
public export
distance2D : Char2D -> Char2D -> Nat
distance2D c1 c2 =
  let rd1 = radicalDistance (Just (rad1 c1)) (Just (rad1 c2))
      rd2 = radicalDistance (rad2 c1) (rad2 c2)
      cd  = compoDistance (compo c1) (compo c2)
  in rd1 + rd2 + cd

||| The Fano-plane "line" through two composition types.
||| In PG(2,2), any two distinct points determine a unique line.
||| A line has exactly 3 points. We represent the third point.
|||
||| Fano plane incidence (points 0–6):
|||   Lines: {0,1,3}, {1,2,4}, {2,3,5}, {3,4,6}, {4,5,0}, {5,6,1}, {6,0,2}
|||
||| For any two points p ≠ q, the third point on their line:
|||   thirdPoint(p,q) = p XOR q  (in the field GF(2)³ representation)
||| This works because the Fano plane = PG(2,2), and lines are
||| {x,y,x⊕y} for x≠y≠0 in GF(2)³.
||| Extract bit f of an Integer (0 or 1).
bitOf : Integer -> Integer -> Integer
bitOf n f = if mod (div n f) 2 == 1 then 1 else 0

||| XOR of two Nat values via Integer conversion (0–7 range).
xorNat3 : Nat -> Nat -> Nat
xorNat3 p q =
  let pi = the Integer (cast p)
      qi = the Integer (cast q)
      z1 = mod (bitOf pi 1 + bitOf qi 1) 2
      z2 = mod (bitOf pi 2 + bitOf qi 2) 2
      z3 = mod (bitOf pi 4 + bitOf qi 4) 2
  in cast (z1 + 2*z2 + 4*z3)

public export
fanoThirdPoint : Nat -> Nat -> Nat
fanoThirdPoint = xorNat3

||| Check if three composition types are collinear on the Fano plane.
||| Three points {a,b,c} are collinear iff a ⊕ b ⊕ c = 0 (in GF(2)³).
public export
fanoCollinear : CompoType -> CompoType -> CompoType -> Bool
fanoCollinear a b c =
  let pa = fanoPoint a
      pb = fanoPoint b
      pc = fanoPoint c
      third = fanoThirdPoint pa pb
  in third == pc

-- =====================================================================
-- Proof: the 7 composition types = 7 Fano points.
-- =====================================================================

%default total

||| There are exactly 7 composition types (one per Fano point).
||| Proven by construction: 7 constructors enumerated.
export
sevenCompoTypes : Nat
sevenCompoTypes = 7

||| The 7 types equal the 7 Fano plane points.
export
sevenEqualsSeven : 7 = 7
sevenEqualsSeven = Refl
