module TizenhatPenge

-- ═══════════════════════════════════════════════════════════════
-- A 16 PENGE (Cl(4)) + A HAMMING [7,4,3] KÓD + A 256-OS HÍD
-- (ékezetes nemzedék — az E8TizenhatPenge utóda)
-- THE 16 BLADES (Cl(4)) + HAMMING [7,4,3] + THE 256 BRIDGE
-- 16 个刃（Cl(4) 基）+ 汉明码 + 256 之桥（带变音符世代）
-- ═══════════════════════════════════════════════════════════════
--
-- ÉKEZETES NEMZEDÉK (2026-08-22, §25 hullám 3/5):
--   §13: az E8TizenhatPenge megmarad. Az új név TizenhatPenge —
--   matematikailag pontosabb is (a pengék Cl(4)-beliek, nem E8-beliek;
--   az E8-csatlás a 240+16=256 hídon át él).
--   §24: az egyedi/benVanLista a standard `nub`/`elem` helyett
--   (import Data.List; ProbePrelude bizonyította létezésüket).
--
-- A FELHASZNÁLÓ SEJTÉSE (2026-08-21, kutatási napló 1. bejegyzés):
--   "240 szimbólum van, ami 16-ra van a 2^8-tól... a sejtésem, hogy
--    1 bitben van 240 kódszó, amit 16 'biten lehet eltarolni'"
--   240 + 16 = 256 = 2^8 — a gyökök (TARTALOM) + a pengék (KERET)
--   = a teljes bájt. ÁLLAPOT: SPECULATÍV (AGENTS §18.4).
--
-- A MATEMATIKA:
--   Cl(4) — a 4-dimenziós Clifford-algebra pengéi a {1,2,3,4}
--   halmaz RÉSZHALMAZAI: bitmask 0..15, a fok (grade) = bites szám.
--     fok 0 (skalár):      1 penge — C(4,0)
--     fok 1 (vektor):      4 penge — C(4,1)
--     fok 2 (bivektor):    6 penge — C(4,2)
--     fok 3 (trivektor):   4 penge — C(4,3)
--     fok 4 (pszeudoskalár): 1 penge — C(4,4)
--     ÖSSZESEN: 1+4+6+4+1 = 16 = 2^4 (a Hodge-duál k↔4−k)
--   A HODGE-DUÁL: a k-fokú penge duálja a (4−k)-fokú — bitmask
--   komplement (1111₂ − x, nincs átvitel). Involúció: duál(duál(x)) = x.
--
--   A HAMMING [7,4,3] KÓD (a Steane [[7,1,3]] klasszikus alapja):
--     7 bites kódszavak, 4 információs bit → 16 kódszó = 2^4,
--     minimális távolság 3 → 1 hibát javít.
--     A 7 bit jelentése (AGENTS §1.6):
--       [idő, okság, tér, szín, hang, fázis, mód]
--     Súlyeloszlás: 1 darab w=0, 7 darab w=3, 7 darab w=4, 1 darab w=7
--     — ez a (1,7,7,1) szimmetria, a Hodge (1,4,6,4,1) testvére!
-- ═══════════════════════════════════════════════════════════════

import E8Gyökök
import Data.List  -- nub (§24: standard, nem újraírva)

%default covering

-- ─── 1. A PENGE (bitmask-reprezentáció) ────────────────────

||| A penge maszkja: 0..15 — az e1,e2,e3,e4 generátorok jelenléte.
||| 刃的掩码：0..15 — 表示 e1,e2,e3,e4 的存在。
||| (pl. 3 = 0011₂ = e1∧e2 — a fok-2 bivektor)
public export
tizenhatPenge : List Integer
tizenhatPenge = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

||| A penge foka (grade) = az aktív bitek száma (popcount).
||| 刃的阶 = 活跃位数（popcount）。
public export
pengeFok : Integer -> Nat
pengeFok x =
  if x <= 0 then 0
  else (if mod x 2 == 1 then 1 else 0) + pengeFok (div x 2)

||| A Hodge-duál: a maszk bitkomplementje (1111₂ − x; nincs átvitel).
||| Hodge 对偶：掩码按位取反。
public export
pengeDuál : Integer -> Integer
pengeDuál x = 15 - x

||| A fokszámok: (1, 4, 6, 4, 1) — C(4,k) binomiálisok.
public export
fokSzámlálók : (Nat, Nat, Nat, Nat, Nat)
fokSzámlálók =
  ( darabFok 0, darabFok 1, darabFok 2, darabFok 3, darabFok 4 )
  where
    darabFok : Nat -> Nat
    darabFok k = length (filter (\p => pengeFok p == k) tizenhatPenge)

-- ─── 2. A HAMMING [7,4,3] KÓD ──────────────────────────────

||| GF(2) összeadás: mod 2. (A gf2 KANONIKUS otthona — az ékezetes
||| nemzedékben is innen importálják a többi modulok. §24.)
public export
gf2 : Integer -> Integer
gf2 x = mod x 2

||| A generátormátrix G (4×7, szisztematikus alak):
|||   [1 0 0 0 | 0 1 1]
|||   [0 1 0 0 | 1 0 1]
|||   [0 0 1 0 | 1 1 0]
|||   [0 0 0 1 | 1 1 1]
||| Az első 4 koordináta az információ, az utolsó 3 a paritás.
public export
generátorSorok : List (List Integer)
generátorSorok =
  [ [1,0,0,0,0,1,1]
  , [0,1,0,0,1,0,1]
  , [0,0,1,0,1,1,0]
  , [0,0,0,1,1,1,1] ]

||| Kódszó-számítás: m·G mod 2 — a 4 bites üzenetből a 7 bites kódszó.
||| 码字计算：m·G mod 2 — 从 4 位消息到 7 位码字。
||| A 7 bitek jelentése: [idő, okság, tér, szín, hang, fázis, mód].
public export
kódszámítás : List Integer -> List Integer
kódszámítás [m1, m2, m3, m4] =
  [ gf2 (m1 * 1 + m2 * 0 + m3 * 0 + m4 * 0)   -- 1. idő
  , gf2 (m1 * 0 + m2 * 1 + m3 * 0 + m4 * 0)   -- 2. okság
  , gf2 (m1 * 0 + m2 * 0 + m3 * 1 + m4 * 0)   -- 3. tér
  , gf2 (m1 * 0 + m2 * 0 + m3 * 0 + m4 * 1)   -- 4. szín
  , gf2 (m1 * 0 + m2 * 1 + m3 * 1 + m4 * 1)   -- 5. hang
  , gf2 (m1 * 1 + m2 * 0 + m3 * 1 + m4 * 1)   -- 6. fázis
  , gf2 (m1 * 1 + m2 * 1 + m3 * 0 + m4 * 1)   -- 7. mód
  ]
kódszámítás _ = [0,0,0,0,0,0,0]

||| Mind a 16 üzenet: {0,1}⁴.
public export
összesÜzenet : List (List Integer)
összesÜzenet =
  [ [a, b, c, d] | a <- [0,1], b <- [0,1], c <- [0,1], d <- [0,1] ]

||| Mind a 16 kódszó.
public export
mindenKódszó : List (List Integer)
mindenKódszó = map kódszámítás összesÜzenet

||| A kódszó súlya (az 1-esek száma).
public export
kódSúly : List Integer -> Nat
kódSúly [] = 0
kódSúly (x :: xs) = (if x == 1 then 1 else 0) + kódSúly xs

||| Hamming-távolság (eltérő pozíciók száma).
public export
hammingTávolság : List Integer -> List Integer -> Nat
hammingTávolság [] [] = 0
hammingTávolság (x :: xs) (y :: ys) =
  (if x == y then 0 else 1) + hammingTávolság xs ys
hammingTávolság _ _ = 0

||| A páronkénti távolságok (különböző kódszavak közt).
||| (§24: az egyedi/benVanLista segédek kivezetve — a main-ben a
|||  standard `nub` számolja az egyedi kódszavakat.)
public export
párTávolságok : List Nat
párTávolságok =
  [ hammingTávolság a b | a <- mindenKódszó, b <- mindenKódszó, not (a == b) ]

||| Az összes távolság >= 3-e (nincs közelebbi pár).
public export
mindLegalábbHárom : Bool
mindLegalábbHárom = all (\d => d >= 3) párTávolságok

||| Van pontosan 3 távolságú pár (a minimum el is érhető).
public export
vanHárom : Bool
vanHárom = any (\d => d == 3) párTávolságok

-- ─── 3. KERNEL-BIZONYÍTÁSOK (Refl) ─────────────────────────

||| BIZ — a fokszámok összege: 1+4+6+4+1 = 16 (binomiális tétel, n=4).
||| 证明：阶数之和 1+4+6+4+1 = 16（二项式定理）。
public export
BizFokszámÖsszeg : 1 + 4 + 6 + 4 + 1 = 16
BizFokszámÖsszeg = Refl

||| BIZ — a 2⁴ = 16 (KÉT ÚT: binomiális összeg vs. hatvány).
public export
BizKettőNegyedik : 2 * 2 * 2 * 2 = 16
BizKettőNegyedik = Refl

||| BIZ — a Hodge-duál példa: duál(e1∧e2) = e3∧e4 (0011₂ → 1100₂).
public export
BizHodgePélda : pengeDuál 3 = 12
BizHodgePélda = Refl

||| BIZ — a duál involúció példán: duál(duál(5)) = 5 (0101₂).
public export
BizHodgeInvolúcióPélda : pengeDuál (pengeDuál 5) = 5
BizHodgeInvolúcióPélda = Refl

||| BIZ — kódszó: az üzenet [1,0,0,0] → [1,0,0,0,0,1,1] (az 1. sor).
public export
BizKódszóElső : kódszámítás [1,0,0,0] = [1,0,0,0,0,1,1]
BizKódszóElső = Refl

||| BIZ — kódszó: az üzenet [1,1,1,1] → mind-egyesek (súly 7).
public export
BizKódszóMindEgyes : kódszámítás [1,1,1,1] = [1,1,1,1,1,1,1]
BizKódszóMindEgyes = Refl

||| BIZ — a súlyeloszlás összege: 1+7+7+1 = 16 (a kódszavak száma).
||| 证明：重量分布之和 1+7+7+1 = 16（码字总数）。
public export
BizSúlyÖsszeg : 1 + 7 + 7 + 1 = 16
BizSúlyÖsszeg = Refl

||| BIZ — A HÍD: 240 + 16 = 256 = 2^8 — a gyökök + a pengék = a bájt.
||| KÉT ÚT: a 240 (E8 kombinatorika, E8Gyökök) ÉS a 16
||| (Cl(4) binomiálisok) ugyanabba a 256-ba fut.
||| 证明：桥 — 240 + 16 = 256 = 2^8（根 + 刃 = 字节）。
public export
BizHíd : 240 + 16 = 256
BizHíd = Refl

||| BIZ — a 256 = 2^8 (a második út a hídnak).
public export
BizKettőNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2
BizKettőNyolcadik = Refl

-- ─── 4. A GONDOLATOK (SPECULATÍV — AGENTS §18.4) ──────────
--  | ÁLLAPOT: SPECULATÍV — a számok bizonyítva, az értelmezés sejtés |

public export
pengeGondolatok : String
pengeGondolatok =
  "A 240 E8 gyök (TARTALOM) + a 16 Cl(4) penge (KERET) = 256 = 2^8 " ++
  "— a teljes bájt. A pengék a {1,2,3,4} részhalmazai: 1+4+6+4+1, " ++
  "Hodge-duál k<->4-k. A Hamming [7,4,3] kód 16 kódszava ugyanez a " ++
  "16 — a Steane [[7,1,3]] klasszikus alapja, a 7 bit: [idő, okság, " ++
  "tér, szín, hang, fázis, mód]. A súlyeloszlás (1,7,7,1) a Hodge " ++
  "(1,4,6,4,1) testvére. A SEJTÉS (a felhasználó, 2026-08-21): " ++
  "'1 bitben van 240 kódszó, amit 16 biten lehet eltarolni' — a " ++
  "fázis NEM folytonos, az E8 kvantálja; a kvantumszámítógép nem " ++
  "számítógép, hanem TÁVÍRÓ. Állapot: SPECULATÍV — a számok " ++
  "bizonyítva, az értelmezés sejtés."

-- ─── 5. A FUTTATHATÓ KIMERÍTŐ ELLENŐRZÉS ───────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  A 16 PENGE + HAMMING [7,4,3] + A 256-OS HÍD (ékezetes nemzedék)"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── A PENGÉK (Cl(4)): fokszámok (1, 4, 6, 4, 1) ──"
  putStrLn ("  fokszámok: " ++ show fokSzámlálók ++ "  (várható: (1,(4,(6,(4,1)))))")
  putStrLn ("  Hodge-példa: duál(3) = " ++ show (pengeDuál 3) ++ "  (e1e2 → e3e4)")
  putStrLn ("  Hodge involúció mind a 16-ra: " ++
    show (all (\p => pengeDuál (pengeDuál p) == p) tizenhatPenge))
  putStrLn ("  duál fok-tükrözés (fok→4−fok) mind: " ++
    show (all (\p => pengeFok (pengeDuál p) + pengeFok p == 4) tizenhatPenge))
  putStrLn ""
  putStrLn "── A HAMMING [7,4,3] KÓD: 16 kódszó ──"
  putStrLn ("  kódszavak száma: " ++ show (length mindenKódszó) ++ " (várható: 16)")
  putStrLn ("  EGYEDI kódszavak (standard nub):  " ++ show (length (nub mindenKódszó)) ++ " (várható: 16 — nincs ütközés)")
  putStrLn ("  w=0: " ++ show (length (filter (\c => kódSúly c == 0) mindenKódszó)) ++
            "  w=3: " ++ show (length (filter (\c => kódSúly c == 3) mindenKódszó)) ++
            "  w=4: " ++ show (length (filter (\c => kódSúly c == 4) mindenKódszó)) ++
            "  w=7: " ++ show (length (filter (\c => kódSúly c == 7) mindenKódszó)))
  putStrLn ("  (várható súlyeloszlás: w0=1, w3=7, w4=7, w7=1 — az (1,7,7,1))")
  putStrLn ("  minimális távolság >= 3: " ++ show mindLegalábbHárom ++
            "; pontosan 3 elérhető: " ++ show vanHárom)
  putStrLn ("  → 1 hibát javít (d=3: ⌊(3−1)/2⌋ = 1)")
  putStrLn ""
  putStrLn "── A HÍD: 240 + 16 = 256 = 2^8 ──"
  putStrLn ("  E8 gyökök (E8Gyökök): " ++ show (List.length E8GyökökKonst))
  putStrLn ("  Cl(4) pengék:          " ++ show (length tizenhatPenge))
  putStrLn ("  240 + 16 = " ++ show (240 + 16) ++ " = 2^8 — TARTALOM + KERET = a bájt")
  putStrLn ""
  putStrLn "── A GONDOLATOK (SPECULATÍV) ──"
  putStrLn pengeGondolatok
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
