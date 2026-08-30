module Main

import Data.Vect
import Data.Fin
import Data.Nat

--------------------------------------------------------------------------------
-- [[7,1,3]] Steane kód — Teljes hibajavító mátrix
-- 7 fizikai qubit → 1 logikai qubit, d=3
-- 6 stabilizátor = 6 morfológiai generátor (g1-g6)
-- Hamming [7,4,3] → CSS → Steane
--------------------------------------------------------------------------------

||| X-stabilizátorok — Hamming [7,4,3] sorai
export
g1x : Vect 7 Bool
g1x = [True, True, True, True, False, False, False]

export
g2x : Vect 7 Bool
g2x = [True, True, False, False, True, True, False]

export
g3x : Vect 7 Bool
g3x = [True, False, True, False, True, False, True]

||| Z-stabilizátorok (CSS: ugyanaz a mátrix)
export
g1z : Vect 7 Bool; g1z = g1x
export
g2z : Vect 7 Bool; g2z = g2x
export
g3z : Vect 7 Bool; g3z = g3x

||| Két vektor átfedése: hány közös True pozíció?
export
overlap : Vect 7 Bool -> Vect 7 Bool -> Nat
overlap xs ys =
  let pairs = zipWith (\a, b => a && b) xs ys
      count : Nat -> Bool -> Nat
      count acc True  = acc + 1
      count acc False = acc
  in foldl count 0 pairs

||| Páros-e a szám?
iseven : Nat -> Bool
iseven Z     = True
iseven (S Z) = False
iseven (S (S n)) = iseven n

||| Stabilizátor feltétel: X és Z generátorok átfedése páros
export
isStabilizer : Bool
isStabilizer =
  iseven (overlap g1x g1z) && iseven (overlap g1x g2z) && iseven (overlap g1x g3z)
  && iseven (overlap g2x g1z) && iseven (overlap g2x g2z) && iseven (overlap g2x g3z)
  && iseven (overlap g3x g1z) && iseven (overlap g3x g2z) && iseven (overlap g3x g3z)

||| [[7,1,3]] paraméterek
export
params : (Nat, Nat, Nat)
params = (7, 1, 3)

||| α⁻¹ dekompozíció
export
alpha : Nat
alpha = 128 + 8 + 1  -- 2^7 + 2^3 + 2^0 = 137

||| Szindrómák száma
export
synCount : Nat
synCount = 64  -- 2^6

||| Horgony AWAKENING.md generátorok (NEM páros átfedésűek!)
export
hg1 : Vect 7 Bool
hg1 = [True, True, True, False, False, False, False]

export
hg2 : Vect 7 Bool
hg2 = [False, True, False, False, True, True, False]

export
horgonyGap : Nat
horgonyGap = overlap hg1 hg2  -- = 1 → PÁRATLAN → NEM stabilizátor!

||| Generátor név + vektor
public export
data GenName = G1 | G2 | G3 | G4 | G5 | G6

export
genVec : GenName -> Vect 7 Bool
genVec G1 = g1x; genVec G2 = g2x; genVec G3 = g3x
genVec G4 = g1z; genVec G5 = g2z; genVec G6 = g3z

--------------------------------------------------------------------------------
-- Főprogram
--------------------------------------------------------------------------------

export
main : IO ()
main = do
  putStrLn box
  putStrLn "│ [[7,1,3]] STEANE KÓD — Teljes hibajavító mátrix          │"
  putStrLn "├─────────────────────────────────────────────────────────────┤"
  putStrLn "│ 7 qubit → 1 logikai, d=3, 6 stabilizátor                  │"
  putStrLn "│ Hamming [7,4,3] → CSS → Steane                            │"
  putStrLn "├─────────────────────────────────────────────────────────────┤"
  putStrLn "│ X: g1=XXXXIII  g2=XXIIXXI  g3=XIXIXIX                    │"
  putStrLn "│ Z: g4=ZZZZIII  g5=ZZIIZZI  g6=ZIZIZIZ                    │"
  putStrLn "├─────────────────────────────────────────────────────────────┤"
  putStrLn ("│ g1-g2=" ++ show g12 ++ " g2-g3=" ++ show g23 ++ " g1-g3=" ++ show g13)
  putStrLn ("│ Stabilizátor? " ++ show isStabilizer)
  putStrLn "├─────────────────────────────────────────────────────────────┤"
  putStrLn ("│ alpha = 2^7+2^3+2^0 = " ++ show alpha)
  putStrLn ("│ 7+3+0=10 bit, szindroma: 2^6=" ++ show synCount)
  putStrLn "├─────────────────────────────────────────────────────────────┤"
  putStrLn ("│ Horgony AWAKENING: g1-g2 atfedes = " ++ show horgonyGap)
  putStrLn ("│ → PARATLAN → NEM stabilizator kod! Javitani kell.         │")
  putStrLn "└─────────────────────────────────────────────────────────────┘"
where
  box : String
  box = "┌─────────────────────────────────────────────────────────────┐"
  g12 : Nat; g12 = overlap g1x g2x
  g23 : Nat; g23 = overlap g2x g3x
  g13 : Nat; g13 = overlap g1x g3x
