module E8BelsoSzorzat

-- ═══════════════════════════════════════════════════════════════
-- E8 BELSŐ SZORZAT-TÁBLA ÉS WEYL-REFLEXIÓK — az E8 anatómiája, 1. lépés
-- E8 INNER PRODUCT TABLE AND WEYL REFLECTIONS — anatomy step 1
-- E8 内积表与外尔反射 — 解剖第一步
-- E8-INNERPRODUKT-TABELLE UND WEYL-REFLEXIONEN — Anatomie, Schritt 1
-- טבלת המכפלות הפנימיות של E8 והשתקפויות וייל — שלב 1 באנטומיה
-- ═══════════════════════════════════════════════════════════════
--
-- A TERV (kutatási napló 14. bejegyzés, 1. fázis):
--   | A 240×240 SZORZAT-TÁBLA + A WEYL-REFLEXIÓK ZÁRTSÁGA |
--   | 240×240 内积表 + 外尔反射的封闭性                     |
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
--   A pár-rekordok száma (rendezett párok):
--     −8: 240, −4: 13 440, 0: 30 240, +4: 13 440, +8: 240
--     ÖSSZESEN: 240+13440+30240+13440+240 = 57 600 = 240² ✓
--
-- A WEYL-REFLEXIÓ (a 2-szeres skálán):
--   σ_α(β) = β − (⟨α,β⟩ / 4) · α
--   (az eredeti skálán σ_α(β) = β − ⟨α,β⟩·α, mert ⟨α,α⟩ = 2)
--   Mivel ⟨α,β⟩ ∈ {−8,−4,0,+4,+8}, az ⟨α,β⟩/4 ∈ {−2,−1,0,+1,+2}
--   — EGÉSZ osztás, nincs törtszám. σ_α(α) = α − (8/4)·α = −α.
--
-- A ZÁRTSÁG (a "minden szimmetria" lényege):
--   minden α, gyök-párra σ_α(β) IS a 240 gyök egyike.
--   A Weyl-csoport = a reflexiók által generált csoport;
--   rendje 696 729 600 (E8Gyokok_v2-ben bizonyítva).
--
-- A KETTŐS FEDEZÉS (AGENTS §18):
--   (a) kernel-Refl bizonyítások konkrét esetekre (lenn),
--   (b) futásidejű KIMERÍTŐ ellenőrzés mind az 57 600 párra (main),
--   (c) irodalom: Conway–Sloane, Sphere Packings (SPLAG), 8. fejezet.
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2

%default covering

-- ─── 1. EGYENLŐSÉG / EQUALITY / 相等 ───────────────────────

||| Két gyök egyenlő-e (8 koordináta-páronként).
||| 两个根是否相等（逐坐标比较）。
public export
Eq E8Gyok where
  (==) (E8GyokKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
       (E8GyokKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
    a1 == b1 && a2 == b2 && a3 == b3 && a4 == b4 &&
    a5 == b5 && a6 == b6 && a7 == b7 && a8 == b8

-- ─── 2. BELSŐ SZORZAT / INNER PRODUCT / 内积 ───────────────

||| A belső szorzat a 2-szeres skálán: értékei {−8,−4,0,+4,+8}.
||| 内积（双倍尺度）：取值仅为 {−8,−4,0,+4,+8}。
public export
belsoszorzat : E8Gyok -> E8Gyok -> Integer
belsoszorzat (E8GyokKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
             (E8GyokKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
  a1*b1 + a2*b2 + a3*b3 + a4*b4 + a5*b5 + a6*b6 + a7*b7 + a8*b8

-- ─── 3. VEKTOR-MŰVELETEK / VECTOR OPS / 向量运算 ───────────

||| Két gyök különbsége (koordinánként).
public export
gyokKulonbseg : E8Gyok -> E8Gyok -> E8Gyok
gyokKulonbseg (E8GyokKonstruktor a1 a2 a3 a4 a5 a6 a7 a8)
              (E8GyokKonstruktor b1 b2 b3 b4 b5 b6 b7 b8) =
  E8GyokKonstruktor (a1-b1) (a2-b2) (a3-b3) (a4-b4)
                    (a5-b5) (a6-b6) (a7-b7) (a8-b8)

||| Skalárral szorzás (koordinánként).
public export
gyokSkalar : Integer -> E8Gyok -> E8Gyok
gyokSkalar s (E8GyokKonstruktor a1 a2 a3 a4 a5 a6 a7 a8) =
  E8GyokKonstruktor (s*a1) (s*a2) (s*a3) (s*a4)
                    (s*a5) (s*a6) (s*a7) (s*a8)

||| A gyök ellentettje (−α).
public export
gyokEllentett : E8Gyok -> E8Gyok
gyokEllentett = gyokSkalar (-1)

-- ─── 4. A WEYL-REFLEXIÓ / THE WEYL REFLECTION / 外尔反射 ───

||| σ_α(β) = β − (⟨α,β⟩/4)·α — a 2-szeres skálán EGÉSZ osztással,
||| mert ⟨α,β⟩ ∈ {−8,−4,0,+4,+8} mindig osztható 4-gyel.
||| σ_α(β) = β − (⟨α,β⟩/4)·α — 双倍尺度下必为整数除法。
public export
weylReflexio : E8Gyok -> E8Gyok -> E8Gyok
weylReflexio alfa beta =
  gyokKulonbseg beta (gyokSkalar (div (belsoszorzat alfa beta) 4) alfa)

-- ─── 5. KERNEL-BIZONYÍTÁSOK (Refl, konkrét esetek) ─────────
--    | KÉT FÜGGETLEN ÚT, EGY HÍD (AGENTS §18):           |
--    | a típus BAL oldala recept, a JOBB oldala eredmény  |

||| BIZ — típus-1 ∩ típus-2 szorzat: (2,2,0⁶)·(1⁸) = 4.
public export
BizSzorzatT1T2 :
  belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 4
BizSzorzatT1T2 = Refl

||| BIZ — az ellentett szorzata: α·(−α) = −8 (norma² = 8 ellentettel).
public export
BizSzorzatEllentett :
  belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor (-2) (-2) 0 0 0 0 0 0) = -8
BizSzorzatEllentett = Refl

||| BIZ — merőleges típus-1 pár: (2,2,0⁶)·(2,−2,0⁶) = 0.
public export
BizSzorzatMeroleges :
  belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0) = 0
BizSzorzatMeroleges = Refl

||| BIZ — σ_α(α) = −α (a reflexió saját gyökét negálja).
||| 证明：σ_α(α) = −α（反射把自己的根变号）。
public export
BizReflexioOnmagara :
  weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
  = E8GyokKonstruktor (-2) (-2) 0 0 0 0 0 0
BizReflexioOnmagara = Refl

||| BIZ — merőleges gyök reflexiója ÖNMAGA (σ_α(β) = β, ha ⟨α,β⟩=0).
public export
BizReflexioMeroleges :
  weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)
  = E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0
BizReflexioMeroleges = Refl

||| BIZ — szomszéd reflexiója: σ_α(β) ahol ⟨α,β⟩=−4:
||| σ = β + α (a szomszéd a tükörrel szembe kerül — gyök marad!).
||| Példa: α=(2,2,0⁶), β=(2,0,2,0⁶): ⟨α,β⟩=4 → σ = β − α = (0,−2,2,0⁵).
public export
BizReflexioSzomszed :
  weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
               (E8GyokKonstruktor 2 0 2 0 0 0 0 0)
  = E8GyokKonstruktor 0 (-2) 2 0 0 0 0 0
BizReflexioSzomszed = Refl

-- ─── 6. FUTÁSIDEJŰ SZÁMLÁLÓK (a kimerítő ellenőrzéshez) ────

||| Tagolság-ellenőrzés: a szorzat a megengedett 5 érték egyike-e.
public export
megengedettSzorzat : Integer -> Bool
megengedettSzorzat sz =
  sz == -8 || sz == -4 || sz == 0 || sz == 4 || sz == 8

||| Adott gyök eloszlása: (−8, −4, 0, +4, +8) darabszámok.
||| 每个根的分布：(−8, −4, 0, +4, +8) 的计数。
public export
eloszlas : E8Gyok -> (Nat, Nat, Nat, Nat, Nat)
eloszlas alfa =
  ( darab (-8), darab (-4), darab 0, darab 4, darab 8 )
  where
    darab : Integer -> Nat
    darab sz = length (filter (\b => belsoszorzat alfa b == sz) e8Gyokok)

||| Benne van-e a gyök a 240-es listában.
public export
benVan : E8Gyok -> List E8Gyok -> Bool
benVan _ [] = False
benVan x (y :: ys) = if x == y then True else benVan x ys

||| Zártság egy gyök párján: σ_α(β) gyök-e.
public export
zar : E8Gyok -> E8Gyok -> Bool
zar alfa beta = benVan (weylReflexio alfa beta) e8Gyokok

||| A kimerítő zártság: minden α-ra megszámolja a NEM-gyök reflexiókat.
public export
zarasHibakSzama : Nat
zarasHibakSzama =
  length (filter not
    [ zar alfa beta | alfa <- e8Gyokok, beta <- e8Gyokok ])

||| Minden gyök eloszlása helyes-e: (1, 56, 126, 56, 1).
public export
eloszlasHibakSzama : Nat
eloszlasHibakSzama =
  length (filter (\a => eloszlas a /= (1, 56, 126, 56, 1)) e8Gyokok)

-- ─── 7. A FUTTATHATÓ KIMERÍTŐ ELLENŐRZÉS ───────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 BELSŐ SZORZAT-TÁBLA + WEYL-REFLEXIÓK · 内积表+外尔反射"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── PÉLDA SZORZATOK (kernel-Refl-lel is bizonyítva) ──"
  putStrLn ("  (2,2,0⁶)·(1⁸)   = " ++ show (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 1 1 1 1 1 1 1 1)) ++ "  (típus-1 ∩ típus-2)")
  putStrLn ("  α·(−α)          = " ++ show (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (gyokEllentett (E8GyokKonstruktor 2 2 0 0 0 0 0 0))) ++ "  (ellentett)")
  putStrLn ("  (2,2,0⁶)·(2,−2,0⁶) = " ++ show (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)) ++ "  (merőleges)")
  putStrLn ""
  putStrLn "── WEYL-REFLEXIÓ PÉLDÁK (kernel-Refl-lel bizonyítva) ──"
  putStrLn ("  σ_α(α)   = " ++ show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 2 0 0 0 0 0 0)) ++ "   (= −α ✓)")
  putStrLn ("  σ_α(β⊥)  = " ++ show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)) ++ " (= β ✓ merőleges)")
  putStrLn ("  σ_α(β+4) = " ++ show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 0 2 0 0 0 0 0)) ++ "  (60°-os szomszéd)")
  putStrLn ""
  putStrLn "── ELOSZLÁS: minden gyöknek (1, 56, 126, 56, 1) kell ──"
  putStrLn ("  hibás eloszlású gyökök száma: " ++ show eloszlasHibakSzama ++ " (várható: 0)")
  putStrLn ("  példa eloszlás (2,2,0⁶):  " ++ show (eloszlas (E8GyokKonstruktor 2 2 0 0 0 0 0 0)))
  putStrLn ("  példa eloszlás (1⁸):      " ++ show (eloszlas (E8GyokKonstruktor 1 1 1 1 1 1 1 1)))
  putStrLn ""
  putStrLn "── ZÁRTSÁG: mind az 57 600 reflexió gyök-e? ──"
  putStrLn ("  nem-gyök reflexiók száma: " ++ show zarasHibakSzama ++ " (várható: 0)")
  putStrLn ""
  putStrLn "── A SZIMBÓLUM-ÍRÁSJELEK (a reflexió mint írásjel-csere) ──"
  putStrLn ("  σ_(++000000)(+0+00000) szimbóluma: " ++
    gyokSzimbolum (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 0 2 0 0 0 0 0)))
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
