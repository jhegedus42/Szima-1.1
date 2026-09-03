module Fazis

import Data.Vect

-- =====================================================================
-- FÁZIS modul: 8 osztatú kör = komplex bináris fázis.
-- 相位模块：八等分的圆 = 复二进制相位。
--
-- A kulcs felismerés: a BIT nem csak 0/1, hanem FÁZIS.
-- 关键洞见：比特不只是 0/1，而是相位。
-- A fázis = a bizonytalanság mértékegysége.
-- 相位 = 不确定性的度量单位。
--
-- A kör 8 osztása: e^{ikπ/4}, k = 0..7
--   0:   0°    = 1          (azonos)
--   1:  45°    = (1+i)/√2   (balra forgatás)
--   2:  90°    = i          (kvadratúra)
--   3: 135°    = (-1+i)/√2
--   4: 180°    = -1         (inverzió = NOT)
--   5: 225°    = (-1-i)/√2
--   6: 270°    = -i         (kvadratúra inverz)
--   7: 315°    = (1-i)/√2
--
-- Ez a Z₈ csoport (8 elemű ciklikus csoport).
-- 这是 Z₈ 群（8 阶循环群）。圆的 8 等分：e^{ikπ/4}，k = 0..7（180° = -1 反演 = NOT）。
-- Kapcsolat az E8-hoz: E8 8 dimenziós, minden dimenzió hordoz egy fázist.
-- 与 E8 的联系：E8 是 8 维的，每个维度承载一个相位。
-- =====================================================================

%default total

-- =====================================================================
-- 1. A 8 fázis: Z₈ ciklikus csoport.
-- 一、8 个相位：Z₈ 循环群。
-- =====================================================================

public export
data Fazis = F0 | F1 | F2 | F3 | F4 | F5 | F6 | F7

public export
Show Fazis where
  show F0 = "0"
  show F1 = "1"
  show F2 = "2"
  show F3 = "3"
  show F4 = "4"
  show F5 = "5"
  show F6 = "6"
  show F7 = "7"

public export
Eq Fazis where
  F0 == F0 = True
  F1 == F1 = True
  F2 == F2 = True
  F3 == F3 = True
  F4 == F4 = True
  F5 == F5 = True
  F6 == F6 = True
  F7 == F7 = True
  _ == _ = False

||| Fázis → Nat index (0–7).
||| 相位 → Nat 索引（0–7）。
public export
fazisIndex : Fazis -> Nat
fazisIndex F0 = 0
fazisIndex F1 = 1
fazisIndex F2 = 2
fazisIndex F3 = 3
fazisIndex F4 = 4
fazisIndex F5 = 5
fazisIndex F6 = 6
fazisIndex F7 = 7

||| Nat → Fázis (mod 8, kézi pattern matching).
||| Nat → 相位（模 8，手写模式匹配——模=modulo）。
public export
indexFazis : Nat -> Fazis
indexFazis 0 = F0
indexFazis 1 = F1
indexFazis 2 = F2
indexFazis 3 = F3
indexFazis 4 = F4
indexFazis 5 = F5
indexFazis 6 = F6
indexFazis 7 = F7
indexFazis 8 = F0
indexFazis 9 = F1
indexFazis 10 = F2
indexFazis 11 = F3
indexFazis 12 = F4
indexFazis 13 = F5
indexFazis 14 = F6
indexFazis 15 = F7
indexFazis _ = F0

-- =====================================================================
-- 2. Fázis összeadás: Z₈ csoportművelet.
-- 二、相位加法：Z₈ 群运算。
-- =====================================================================

public export
fazisOsszead : Fazis -> Fazis -> Fazis
fazisOsszead a b = indexFazis (fazisIndex a + fazisIndex b)

public export
fazisInverz : Fazis -> Fazis
fazisInverz F0 = F0
fazisInverz F1 = F7
fazisInverz F2 = F6
fazisInverz F3 = F5
fazisInverz F4 = F4
fazisInverz F5 = F3
fazisInverz F6 = F2
fazisInverz F7 = F1

-- =====================================================================
-- 3. Fázis komponens: magnitúdó + fázis.
-- 三、相位分量：幅值 + 相位。
-- =====================================================================

public export
record FazisKomponens where
  constructor MkFazisKomponens
  magnitudo : Double
  fazis     : Fazis

public export
Show FazisKomponens where
  show fk = show (magnitudo fk) ++ "*e^(i" ++ show (fazis fk) ++ ")"

public export
fazisSzorzat : FazisKomponens -> FazisKomponens -> FazisKomponens
fazisSzorzat a b = MkFazisKomponens
  (magnitudo a * magnitudo b)
  (fazisOsszead (fazis a) (fazis b))

-- =====================================================================
-- 4. E8 fázispont: 8 dimenziós fázisvektor.
-- 四、E8 相位点：8 维相位向量。
-- =====================================================================

public export
record E8FazisPont where
  constructor MkE8FazisPont
  fazeek : Vect 8 Fazis

public export
Show E8FazisPont where
  show p = "E8" ++ showVect (fazeek p)
  where
    showVect : Vect 8 Fazis -> String
    showVect v = "[" ++ go v 8 ++ "]"
      where
        go : Vect 8 Fazis -> Nat -> String
        go _ Z = ""
        go v (S Z) = show (index 7 v)
        go v (S (S Z)) = show (index 6 v) ++ "," ++ go v (S Z)
        go v (S (S (S Z))) = show (index 5 v) ++ "," ++ go v (S (S Z))
        go v (S (S (S (S Z)))) = show (index 4 v) ++ "," ++ go v (S (S (S Z)))
        go v (S (S (S (S (S Z))))) = show (index 3 v) ++ "," ++ go v (S (S (S (S Z))))
        go v (S (S (S (S (S (S Z)))))) = show (index 2 v) ++ "," ++ go v (S (S (S (S (S Z)))))
        go v (S (S (S (S (S (S (S Z))))))) = show (index 1 v) ++ "," ++ go v (S (S (S (S (S (S Z))))))
        go v (S (S (S (S (S (S (S (S Z)))))))) = show (index 0 v)
        go v _ = ""

-- =====================================================================
-- 5. Fázis hiba és javítás.
-- 五、相位错误与纠正。
-- =====================================================================

public export
fazisHiba : Fazis -> E8FazisPont -> E8FazisPont
fazisHiba hiba p = MkE8FazisPont (map (fazisOsszead hiba) (fazeek p))

public export
fazisJavitas : Fazis -> E8FazisPont -> E8FazisPont
fazisJavitas javitas = fazisHiba (fazisInverz javitas)

-- =====================================================================
-- 6. "Lehetséges mód": fázisszuperpozíció.
-- 六、「可能模式」：相位叠加。
-- =====================================================================

public export
record LehetsegesMod where
  constructor MkLehetsegesMod
  komponensek : List FazisKomponens

public export
Show LehetsegesMod where
  show m = "LehetsegesMod(" ++ show (length (komponensek m)) ++ " komponens)"

-- =====================================================================
-- 7. Bizonyítások.
-- 七、证明。（fazisNullaBal：左单位；fazisInverzJobb：右逆——皆 8 个 Refl）
-- =====================================================================

public export
fazisNullaBal : (x : Fazis) -> fazisOsszead F0 x = x
fazisNullaBal F0 = Refl
fazisNullaBal F1 = Refl
fazisNullaBal F2 = Refl
fazisNullaBal F3 = Refl
fazisNullaBal F4 = Refl
fazisNullaBal F5 = Refl
fazisNullaBal F6 = Refl
fazisNullaBal F7 = Refl

public export
fazisInverzJobb : (x : Fazis) -> fazisOsszead x (fazisInverz x) = F0
fazisInverzJobb F0 = Refl
fazisInverzJobb F1 = Refl
fazisInverzJobb F2 = Refl
fazisInverzJobb F3 = Refl
fazisInverzJobb F4 = Refl
fazisInverzJobb F5 = Refl
fazisInverzJobb F6 = Refl
fazisInverzJobb F7 = Refl
