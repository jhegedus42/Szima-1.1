module ProbeEV2

-- ═══════════════════════════════════════════════════════════════
-- PROBE EV2 — bisect: MI nem redukál a bizMéretMegmarad-láncban?
-- 二分探针：bizMéretMegmarad 链条中哪一步不归约？
-- Bisect probe: which step of the size-preservation chain does
-- NOT reduce at compile time?
-- ═══════════════════════════════════════════════════════════════
-- A lépcső (mind-egyik önálló Refl — ami elbukik, az a bűnös):
--   p1: map a 4 tengelyre         → 4
--   p2: concatMap (6 út × 4)      → 24
--   p3: sortBy Nat-compare        → rendezett (Double-NÉLKÜL)
--   p4: sortBy Double-compare     → rendezett (a Double-compare próba)
--   p5: take + length             → csonkolás
--   p6: Double-literál csökkentés → (1.0 − 0.5) = 0.5
--   p7: cast Nat Double × 0.5     → 1.0
--   p8: pont-stílusú foldl (max . f) → a legjobbFitnesz-alak
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2
import E8BelsoSzorzat
import GyokSzo_v1
import Data.List

%default covering

K : E8Gyok
K = jel PéldaEgészSzó

T : List E8Gyok
T = [ jel PéldaFélEgészSzó
    , jel PéldaEgészSzó
    , jel PéldaMerőlegesSzó
    , jel PéldaEllentétesRokonSzó
    ]

HatféleÚt : List (List E8Gyok)
HatféleÚt = replicate 6 [K]

kiterjeszt' : List (List E8Gyok) -> List (List E8Gyok)
kiterjeszt' utak@_ =
  concatMap (\útvonal@_ =>
    map (\tengely => útvonal ++ [weylReflexio tengely (útvégé' útvonal)]) T)
    utak

útvégé' : List E8Gyok -> E8Gyok
útvégé' útvonal@_ = foldl (\_, gyök => gyök) K útvonal

-- Kimenet: Refl — a map a 4 tengelyen.
p1 : length (map (\tengely => [weylReflexio tengely K]) T) = 4
p1 = Refl

-- Kimenet: Refl — a concatMap 6 út × 4 tengely = 24 jelölt.
p2 : length (kiterjeszt' HatféleÚt) = 24
p2 = Refl

-- Kimenet: Refl — sortBy NAT-compare-ral (Double NÉLKÜL) rendez-e?
p3 : sortBy (\a, b => compare b a) [1, 3, 2] = [3, 2, 1]
p3 = Refl

-- Kimenet: Refl — take + length csonkolás.
p5 : length (take 2 (sortBy (\a, b => compare b a) [1, 3, 2, 4])) = 2
p5 = Refl

-- Kimenet: Refl — Double-literál csökkenés (pontosan ábrázolható felezők).
p6 : (1.0 - 0.5) = 0.5
p6 = Refl

-- Kimenet: Refl — cast Nat → Double, pontos felezőkkel.
p7 : cast (length [K, K]) * 0.5 = 1.0
p7 = Refl

-- Kimenet: Refl — a legjobbFitnesz PONT-STÍLUSÚ foldl-alakja Nat-on.
p8 : foldl (\eddig => max eddig . (\x => length x)) 0 [[1], [1, 2]] = 2
p8 = Refl

-- Kimenet: Refl — sortBy DOUBLE-compare-ral (a fitneszSorrend alakja,
-- de egyszerű Double-okon): a Double Ord-instance redukál-e?
p4 : sortBy (\a, b => compare b a) [1.0, 3.0, 2.0] = [3.0, 2.0, 1.0]
p4 = Refl
