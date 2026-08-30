module E8BelsőSzorzat

-- ═══════════════════════════════════════════════════════════════
-- E8 BELSŐ SZORZAT-TÁBLA ÉS WEYL-REFLEXIÓK (ékezetes nemzedék)
-- E8 INNER PRODUCT TABLE AND WEYL REFLECTIONS (accented generation)
-- E8 内积表与外尔反射（带变音符世代）
-- ═══════════════════════════════════════════════════════════════
--
-- ÉKEZETES NEMZEDÉK (2026-08-22, §25 hullám 2/5): minden azonosító
-- ékezetes (belsőSzorzat, gyökKülönbség, weylReflexió, eloszlás,
-- zárásHibákSzáma...). §13: az E8BelsoSzorzat megmarad. §24: a
-- benVan a standard Prelude `elem`-re cserélve (ProbePrelude).
--
-- A MATEMATIKA (2-szeres skálán, ahol norma² = 8):
--   Belső szorzat értékek CSAK: {−8, −4, 0, +4, +8}
--     (az eredeti skálán {−2, −1, 0, +1, +2} — simply-laced!)
--   Minden gyök eloszlása a TÖBBI gyökkel:
--     ⟨α,β⟩ = −8 (β = −α):        1 gyök
--     ⟨α,β⟩ = −4 (120°-os szög):  56 gyök  — a SZOMSZÉDOK
--     ⟨α,β⟩ =  0 (merőleges):    126 gyök
--     ⟨α,β⟩ = +4 (60°-os szög):   56 gyök
--     ⟨α,β⟩ = +8 (β = +α):        1 gyök
--     ÖSSZESEN: 1+56+126+56+1 = 240 ✓ (Conway–Sloane, SPLAG)
--   A pár-rekordok száma (rendezett párok): 57 600 = 240² ✓
--
-- A WEYL-REFLEXIÓ (a 2-szeres skálán):
--   σ_α(β) = β − (⟨α,β⟩ / 4) · α — EGÉSZ osztás, nincs törtszám.
--   σ_α(α) = α − (8/4)·α = −α.
--
-- A ZÁRTSÁG (a "minden szimmetria" lényege):
--   minden α, gyök-párra σ_α(β) IS a 240 gyök egyike.
--
-- A KETTŐS FEDEZÉS (AGENTS §18):
--   (a) kernel-Refl bizonyítások konkrét esetekre (lenn),
--   (b) futásidejű KIMERÍTŐ ellenőrzés mind az 57 600 párra (main),
--   (c) irodalom: Conway–Sloane, Sphere Packings (SPLAG), 8. fejezet.
-- ═══════════════════════════════════════════════════════════════

import E8Gyökök

%default covering

-- ─── 1. EGYENLŐSÉG / EQUALITY / 相等 ───────────────────────

||| Két gyök egyenlő-e (8 koordináta-páronként).
||| 两个根是否相等（逐坐标比较）。
public export
Eq E8Gyök where
  (==) (E8GyökKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
       (E8GyökKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
    a1 == b1 && a2 == b2 && a3 == b3 && a4 == b4 &&
    a5 == b5 && a6 == b6 && a7 == b7 && a8 == b8

-- ─── 2. BELSŐ SZORZAT / INNER PRODUCT / 内积 ───────────────

||| A belső szorzat a 2-szeres skálán: értékei {−8,−4,0,+4,+8}.
||| 内积（双倍尺度）：取值仅为 {−8,−4,0,+4,+8}。
public export
belsőSzorzat : E8Gyök -> E8Gyök -> Integer
belsőSzorzat (E8GyökKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
             (E8GyökKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
  a1*b1 + a2*b2 + a3*b3 + a4*b4 + a5*b5 + a6*b6 + a7*b7 + a8*b8

-- ─── 3. VEKTOR-MŰVELETEK / VECTOR OPS / 向量运算 ───────────

||| Két gyök különbsége (koordinátánként).
public export
gyökKülönbség : E8Gyök -> E8Gyök -> E8Gyök
gyökKülönbség (E8GyökKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
              (E8GyökKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
  E8GyökKonstruktor (a1-b1) (a2-b2) (a3-b3) (a4-b4)
                    (a5-b5) (a6-b6) (a7-b7) (a8-b8)

||| Skalárral szorzás (koordinátánként).
public export
gyökSkalár : Integer -> E8Gyök -> E8Gyök
gyökSkalár s (E8GyökKonstruktor a1 a2 a3 a4 a5 a6 a7 a8) =
  E8GyökKonstruktor (s*a1) (s*a2) (s*a3) (s*a4)
                    (s*a5) (s*a6) (s*a7) (s*a8)

||| A gyök ellentettje (−α).
public export
gyökEllentett : E8Gyök -> E8Gyök
gyökEllentett = gyökSkalár (-1)

-- ─── 4. A WEYL-REFLEXIÓ / THE WEYL REFLECTION / 外尔反射 ───

||| σ_α(β) = β − (⟨α,β⟩/4)·α — a 2-szeres skálán EGÉSZ osztással,
||| mert ⟨α,β⟩ ∈ {−8,−4,0,+4,+8} mindig osztható 4-gyel.
||| σ_α(β) = β − (⟨α,β⟩/4)·α — 双倍尺度下必为整数除法。
public export
weylReflexió : E8Gyök -> E8Gyök -> E8Gyök
weylReflexió alfa béta =
  gyökKülönbség béta (gyökSkalár (div (belsőSzorzat alfa béta) 4) alfa)

-- ─── 5. KERNEL-BIZONYÍTÁSOK (Refl, konkrét esetek) ─────────
--    | KÉT FÜGGETLEN ÚT, EGY HÍD (AGENTS §18):           |
--    | a típus BAL oldala recept, a JOBB oldala eredmény  |

||| BIZ — típus-1 ∩ típus-2 szorzat: (2,2,0⁶)·(1⁸) = 4.
public export
BizSzorzatT1T2 :
  belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor 1 1 1 1 1 1 1 1) = 4
BizSzorzatT1T2 = Refl

||| BIZ — az ellentett szorzata: α·(−α) = −8 (norma² = 8 ellentettel).
public export
BizSzorzatEllentett :
  belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor (-2) (-2) 0 0 0 0 0 0) = -8
BizSzorzatEllentett = Refl

||| BIZ — merőleges típus-1 pár: (2,2,0⁶)·(2,−2,0⁶) = 0.
public export
BizSzorzatMerőleges :
  belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0) = 0
BizSzorzatMerőleges = Refl

||| BIZ — σ_α(α) = −α (a reflexió saját gyökét negálja).
||| 证明：σ_α(α) = −α（反射把自己的根变号）。
public export
BizReflexióÖnmagára :
  weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
  = E8GyökKonstruktor (-2) (-2) 0 0 0 0 0 0
BizReflexióÖnmagára = Refl

||| BIZ — merőleges gyök reflexiója ÖNMAGA (σ_α(β) = β, ha ⟨α,β⟩=0).
public export
BizReflexióMerőleges :
  weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)
  = E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0
BizReflexióMerőleges = Refl

||| BIZ — szomszéd reflexiója: σ_α(β) ahol ⟨α,β⟩=−4:
||| σ = β + α (a szomszéd a tükörrel szembe kerül — gyök marad!).
||| Példa: α=(2,2,0⁶), β=(2,0,2,0⁶): ⟨α,β⟩=4 → σ = β − α = (0,−2,2,0⁵).
public export
BizReflexióSzomszéd :
  weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyökKonstruktor 2 0 2 0 0 0 0 0)
  = E8GyökKonstruktor 0 (-2) 2 0 0 0 0 0
BizReflexióSzomszéd = Refl

-- ─── 6. FUTÁSIDEJŰ SZÁMLÁLÓK (a kimerítő ellenőrzéshez) ────

||| Tagoltság-ellenőrzés: a szorzat a megengedett 5 érték egyike-e.
public export
megengedettSzorzat : Integer -> Bool
megengedettSzorzat sz =
  sz == -8 || sz == -4 || sz == 0 || sz == 4 || sz == 8

||| Adott gyök eloszlása: (−8, −4, 0, +4, +8) darabszámok.
||| 每个根的分布：(−8, −4, 0, +4, +8) 的计数。
public export
eloszlás : E8Gyök -> (Nat, Nat, Nat, Nat, Nat)
eloszlás alfa =
  ( darab (-8), darab (-4), darab 0, darab 4, darab 8 )
  where
    darab : Integer -> Nat
    darab sz = length (filter (\b => belsőSzorzat alfa b == sz) e8Gyökök)

||| Zártság egy gyök párján: σ_α(β) gyök-e.
||| (§24: a korábbi helyi benVan helyett a standard Prelude `elem` —
|||  az Eq E8Gyök instance miatt közvetlenül használható.)
public export
zár : E8Gyök -> E8Gyök -> Bool
zár alfa béta = elem (weylReflexió alfa béta) e8Gyökök

||| A kimerítő zártság: minden α-ra megszámolja a NEM-gyök reflexiókat.
public export
zárásHibákSzáma : Nat
zárásHibákSzáma =
  length (filter not
    [ zár alfa béta | alfa <- e8Gyökök, béta <- e8Gyökök ])

||| Minden gyök eloszlása helyes-e: (1, 56, 126, 56, 1).
public export
eloszlásHibákSzáma : Nat
eloszlásHibákSzáma =
  length (filter (\a => eloszlás a /= (1, 56, 126, 56, 1)) e8Gyökök)

-- ─── 7. A FUTTATHATÓ KIMERÍTŐ ELLENŐRZÉS ───────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 BELSŐ SZORZAT-TÁBLA + WEYL-REFLEXIÓK (ékezetes nemzedék)"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── PÉLDA SZORZATOK (kernel-Refl-lel is bizonyítva) ──"
  putStrLn ("  (2,2,0⁶)·(1⁸)   = " ++ show (belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 1 1 1 1 1 1 1 1)) ++ "  (típus-1 ∩ típus-2)")
  putStrLn ("  α·(−α)          = " ++ show (belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (gyökEllentett (E8GyökKonstruktor 2 2 0 0 0 0 0 0))) ++ "  (ellentett)")
  putStrLn ("  (2,2,0⁶)·(2,−2,0⁶) = " ++ show (belsőSzorzat (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)) ++ "  (merőleges)")
  putStrLn ""
  putStrLn "── WEYL-REFLEXIÓ PÉLDÁK (kernel-Refl-lel bizonyítva) ──"
  putStrLn ("  σ_α(α)   = " ++ show (weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 2 2 0 0 0 0 0 0)) ++ "   (= −α ✓)")
  putStrLn ("  σ_α(β⊥)  = " ++ show (weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)) ++ " (= β ✓ merőleges)")
  putStrLn ("  σ_α(β+4) = " ++ show (weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 2 0 2 0 0 0 0 0)) ++ "  (60°-os szomszéd)")
  putStrLn ""
  putStrLn "── ELOSZLÁS: minden gyöknek (1, 56, 126, 56, 1) kell ──"
  putStrLn ("  hibás eloszlású gyökök száma: " ++ show eloszlásHibákSzáma ++ " (várható: 0)")
  putStrLn ("  példa eloszlás (2,2,0⁶):  " ++ show (eloszlás (E8GyökKonstruktor 2 2 0 0 0 0 0 0)))
  putStrLn ("  példa eloszlás (1⁸):      " ++ show (eloszlás (E8GyökKonstruktor 1 1 1 1 1 1 1 1)))
  putStrLn ""
  putStrLn "── ZÁRTSÁG: mind az 57 600 reflexió gyök-e? ──"
  putStrLn ("  nem-gyök reflexiók száma: " ++ show zárásHibákSzáma ++ " (várható: 0)")
  putStrLn ""
  putStrLn "── A SZIMBÓLUM-ÍRÁSJELEK (a reflexió mint írásjel-csere) ──"
  putStrLn ("  σ_(++000000)(+0+00000) szimbóluma: " ++
    gyökSzimbólum (weylReflexió (E8GyökKonstruktor 2 2 0 0 0 0 0 0) (E8GyökKonstruktor 2 0 2 0 0 0 0 0)))
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
