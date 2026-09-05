module DeltaAnalizis_v1

import Komplex
import ModulRegisztracio

%default total

-- ═══════════════════════════════════════════════════════════════
-- Δ HÉZAG-ANALÍZIS_v1 — a delta_analizis.py numerikus magja Idrisben
-- ─────────────────────────────────────────────────────────────
-- A δ-hézag = 1 − Re(ϱ)·π ≈ 5,604×10⁻⁴ (Bickford, arXiv:2606.01668,
-- Theorem 9: a hézag KÉNYSZERÍTETT / túldeterminált — nem zárható
-- φ/π/e/Bach-alakkal, l. a zárási táblát alant).
--
-- Forrásfájl: delta_analizis.py (mpmath, 40 tizedes). Ez a modul a
-- §17/§3-minta szerinti Idris-átirat: Double-pontosság (~15–16
-- tizedes, a Komplex.idr szankcionált pereme). Az újdonság a
-- Komplex.idr-hez képest: a ϱ itt NEM rögzített érték, hanem
-- Newton-iterációval SZÁMÍTOTT (két független út, egy híd — a
-- futtatás |ϱ_számított − ϱ_rögzített| kulcsot mutatja).
--
-- KIMENET: Show-sorok (a rajzoló majd csak rajzol — Idris számol).
--
-- | 中文：δ-缝隙分析——delta_analizis.py 的数值核心移植到 Idris；
--   ϱ 由牛顿迭代算出（Komplex.idr 中是硬编码），δ = 1 − Re(ϱ)·π，
--   并给出 δ 的全部“闭合尝试”相对误差表（§17 格式）。
-- | DE: Δ-Lückenanalyse — der numerische Kern von delta_analizis.py
--   in Idris; ϱ per Newton-Iteration berechnet (in Komplex.idr nur
--   hartkodiert), δ = 1 − Re(ϱ)·π, samt Tabelle der „Schließversuche“.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. KONSTANSOK ────────────────────────────────────────────────

public export
piKonstans : Double
piKonstans = 3.141592653589793

public export
aranyMetszés : Double
aranyMetszés = 1.618033988749895

public export
eulerSzám : Double
eulerSzám = 2.718281828459045

public export
alfaInverzCodata : Double
alfaInverzCodata = 137.035999177  -- σ = 1,1×10⁻⁸ (CODATA: 137.035999177(11))

public export
newtonLépésszám : Nat
newtonLépésszám = 40

-- ─── 2. A ϱ FIXPONT EGYENLETE ÉS NEWTON-LÉPTETŐ ──────────────────
-- exp(ϱ) = ϱ, ahol ϱ = a + bi, a = b/tan(b) ⇔ b/tan(b) = ln(b/sin(b))
-- A .py-ban: f = lambda b: b/mp.tan(b) - mp.log(b/mp.sin(b)), findroot 1.337-ből.

public export
fixpontFüggvény : Double -> Double
fixpontFüggvény b = b / tan b - log (b / sin b)

||| A fixpontFüggvény kézi levezetettje:
||| d/db [b/tan b]  = 1/tan b − b·(1+tan²b)/tan²b
||| d/db [ln(b/sin b)] = 1/b − cos b/sin b
||| f' = első − második = 1/tan b − b(1+tan²b)/tan²b − 1/b + cos b/sin b
public export
fixpontFüggvényLevezetett : Double -> Double
fixpontFüggvényLevezetett b =
  1.0 / tan b - b * (1.0 + tan b * tan b) / (tan b * tan b)
  - 1.0 / b + cos b / sin b

||| Általános Newton-léptető: n lépés, x_{n+1} = x_n − f(x_n)/f'(x_n).
public export
newtonLéptető : (Double -> Double) -> (Double -> Double) -> Nat -> Double -> Double
newtonLéptető _ _ 0 kiindulás = kiindulás
newtonLéptető függvény levezetett (S k) kiindulás =
  newtonLéptető függvény levezetett k (kiindulás - függvény kiindulás / levezetett kiindulás)

-- ─── 3. ϱ SZÁMÍTOTT ÉRTÉKE ÉS A HÉZAG ────────────────────────────

||| Im(ϱ): a fixpont-egyenlet Newton-megoldása 1,337-ből indítva.
public export
roKépzetesRész : Double
roKépzetesRész = newtonLéptető fixpontFüggvény fixpontFüggvényLevezetett newtonLépésszám 1.337

||| ϱ = a + bi, a = b/tan(b) — a .py ro = a + b*1j sora.
public export
roSzámított : Komplex
roSzámított = K (roKépzetesRész / tan roKépzetesRész) roKépzetesRész

||| A δ-hézag: 1 − Re(ϱ)·π.
public export
hézag : Double
hézag = 1.0 - roSzámított.re * piKonstans

||| Az identitás: 1/π − Re(ϱ) = δ/π.
public export
hézagOszvaPi : Double
hézagOszvaPi = 1.0 / piKonstans - roSzámított.re

||| Komplex exponenciális: e^(a+bi) = e^a·(cos b + i·sin b).
public export
komplexExponenciális : Komplex -> Komplex
komplexExponenciális (K valós képzetes) =
  kSzoroz (K (exp valós) 0.0) (euler képzetes)

||| Az exp(ϱ) = ϱ egyenlet maradéka: |exp(ϱ) − ϱ|.
public export
roMaradék : Double
roMaradék = kAbs (kKivon (komplexExponenciális roSzámított) roSzámított)

||| Két független út, egy híd: a SZÁMÍTOTT ϱ (Newton) és a Komplex.idr
||| RÖGZÍTETT roFixpont távolsága. Futásidejű Show-tanú — Double-re
||| Refl NEM zárható (nem definicionális egyenlőség; §18 őszinteség).
public export
roEgyezésTanú : Double
roEgyezésTanú = kAbs (kKivon roSzámított roFixpont)

-- ─── 4. BICKFORD Thm 9: A HÉZAG KÉNYSZERÍTETT ────────────────────
-- Ha Re(z) = 1/π kényszerítve: két egyenlet két különböző b-t ad,
-- a kettő közti héj éppen a δ nagyságrendje → a rés STRUKTURÁLIS.

public export
kényszerítettValós : Double
kényszerítettValós = 1.0 / piKonstans

||| b₁ a cos-egyenletből: b₁ = acos((1/π)·e^(−1/π)).
public export
bEgy : Double
bEgy = acos (kényszerítettValós * exp (negate kényszerítettValós))

||| A sin-egyenlet: e^(1/π)·sin(b) − b = 0.
public export
sinEgyenlet : Double -> Double
sinEgyenlet szög = exp kényszerítettValós * sin szög - szög

public export
sinEgyenletLevezetett : Double -> Double
sinEgyenletLevezetett szög = exp kényszerítettValós * cos szög - 1.0

||| b₂ a sin-egyenlet Newton-megoldása.
public export
bKettő : Double
bKettő = newtonLéptető sinEgyenlet sinEgyenletLevezetett newtonLépésszám 1.337

||| A b₂ − b₁ héj (a kényszer hézagja — δ nagyságrendű).
public export
beKettőBeEgyHéj : Double
beKettőBeEgyHéj = bKettő - bEgy

-- ─── 5. δ ZÁRÁSI KÍSÉRLETEK (a .py rep() táblája) ────────────────

public export
record ZárásiJelölt where
  constructor ZárásiJelöltKonstruktor
  jelöltNeve   : String
  jelöltÉrtéke : Double

||| Relatív hiba: |(δ − érték)/δ| — a .py rep() sora.
||| (Mező-projekcióval — az ékezetes é mintaposícióban csapda #27!)
public export
relatívHiba : ZárásiJelölt -> Double
relatívHiba jelölt = abs ((hézag - jelölt.jelöltÉrtéke) / hézag)

||| Egy hatvány-jelölt gyártó: név, alap, n → „alap^-n" jelölt.
public export
hatványJelölt : String -> Double -> Nat -> ZárásiJelölt
hatványJelölt név alap n =
  ZárásiJelöltKonstruktor (név ++ "^-" ++ show n)
                          (pow alap (negate (fromInteger (natToInteger n))))

||| Hatvány-sorozat egy alapra.
public export
hatványSor : String -> Double -> List Nat -> List ZárásiJelölt
hatványSor név alap nszámok = map (hatványJelölt név alap) nszámok

||| A δ-szörzatok és a speciális tagok (a .py végződő rep() sorai).
public export
különlegesJelöltek : List ZárásiJelölt
különlegesJelöltek =
  [ ZárásiJelöltKonstruktor "δ/φ"                  (hézag / aranyMetszés)
  , ZárásiJelöltKonstruktor "δ·φ"                  (hézag * aranyMetszés)
  , ZárásiJelöltKonstruktor "δ·π"                  (hézag * piKonstans)
  , ZárásiJelöltKonstruktor "δ/π"                  (hézag / piKonstans)
  , ZárásiJelöltKonstruktor "(1/φ)^8 / π"          (pow aranyMetszés (negate 8.0) / piKonstans)
  , ZárásiJelöltKonstruktor "α⁻¹ − 137 (Bach tört)" (alfaInverzCodata - 137.0)
  , ZárásiJelöltKonstruktor "A4·(3/4)²/c (Bach tag)" (440.0 * 0.5625 / 299792458.0)
  ]

||| A teljes zárási tábla — a .py mind a 44 sora.
public export
mindenJelölt : List ZárásiJelölt
mindenJelölt =
  hatványSor "φ" aranyMetszés [5..19]
  ++ hatványSor "π" piKonstans [4..11]
  ++ hatványSor "e" eulerSzám [5..11]
  ++ hatványSor "2" 2.0 [8..14]
  ++ különlegesJelöltek

||| Egy tábla-sor Show-szövege. (@-minta — csapda #9 gyógyír.)
public export
jelöltSor : ZárásiJelölt -> String
jelöltSor jelölt@_ =
  "  " ++ jelölt.jelöltNeve ++ "  = " ++ show jelölt.jelöltÉrtéke
  ++ "   rel.hiba = " ++ show (relatívHiba jelölt)

||| A teljes tábla Show-szövege (tiszta függvény — IO-perem csak a main).
public export
jelöltSorok : List ZárásiJelölt -> String
jelöltSorok [] = ""
jelöltSorok (jelölt :: többi) = jelöltSor jelölt ++ "\n" ++ jelöltSorok többi

-- ─── 6. §17-MÉRÉS-ÖSSZEVETÉS: α⁻¹ BACH-HORGONY vs CODATA ────────

public export
record MérésÖsszevetés where
  constructor MérésÖsszevetésKonstruktor
  levezetett     : Double
  mért           : Double
  bizonytalanság : Double  -- σ

||| A racionális Bach-horgony: α⁻¹ = 137 + 9/250 = 137,028.
public export
alfaBachHorgony : Double
alfaBachHorgony = 137.0 + 9.0 / 250.0

public export
alfaÖsszevetés : MérésÖsszevetés
alfaÖsszevetés = MérésÖsszevetésKonstruktor alfaBachHorgony alfaInverzCodata 0.000000011

||| Δ = érték_levezetett − érték_mért.
public export
különbség : MérésÖsszevetés -> Double
különbség (MérésÖsszevetésKonstruktor levett mértV _) = levett - mértV

||| Δ/σ — a relatív eltérés a mérési bizonytalansághoz képest (§17).
public export
szigmaArány : MérésÖsszevetés -> Double
szigmaArány (MérésÖsszevetésKonstruktor levett mértV szigma) =
  abs (levett - mértV) / szigma

-- ─── 7. A FŐPROGRAM — Show-kimenet (GAUGE: olvasd!) ──────────────

main : IO ()
main = do
  putStrLn "=== Δ HÉZAG-ANALÍZIS — Idrisben (delta_analizis.py átirata) ==="
  putStrLn ""
  putStrLn "=== ϱ FIXPONT (Newton, 40 lépés, 1,337-ből) ==="
  putStrLn ("  ϱ = " ++ showKomplex roSzámított)
  putStrLn ("  exp(ϱ) = ϱ ellenőrzés: |exp(ϱ)−ϱ| = " ++ show roMaradék)
  putStrLn ("  Re(ϱ)·π = " ++ show (roSzámított.re * piKonstans))
  putStrLn ("  δ = 1 − Re(ϱ)·π = " ++ show hézag)
  putStrLn ("  1/π − Re(ϱ)     = " ++ show hézagOszvaPi ++ "   (= δ/π, identitás)")
  putStrLn ("  Két út, egy híd: |ϱ_számított − ϱ_rögzített(Komplex.idr)| = " ++ show roEgyezésTanú)
  putStrLn ("  Összevetés: Komplex.idr iroGap (rögzített ϱ-ból) = " ++ show iroGap)
  putStrLn ""
  putStrLn "=== BICKFORD Thm 9: a hézag KÉNYSZERÍTETT (túldeterminált) ==="
  putStrLn ("  Re(z) = 1/π kényszerrel:")
  putStrLn ("    b₁ (cos-egyenletből)  = " ++ show bEgy)
  putStrLn ("    b₂ (sin-egyenletből)  = " ++ show bKettő)
  putStrLn ("    b₂ − b₁               = " ++ show beKettőBeEgyHéj)
  putStrLn ("    ϱ kompromisszuma      = b = " ++ show roKépzetesRész)
  putStrLn "  → a hézag STRUKTURÁLIS: Bach-típusú trükk NEM zárja."
  putStrLn ""
  putStrLn "=== δ ZÁRÁSI KÍSÉRLETEK (relatív hiba) ==="
  putStr (jelöltSorok mindenJelölt)
  putStrLn ""
  putStrLn "=== §17: α⁻¹ BACH-HORGONY vs CODATA (Δ/σ kötelező) ==="
  putStrLn ("  érték_levezetett = 137 + 9/250 = " ++ show alfaBachHorgony)
  putStrLn ("  érték_mért       = " ++ show alfaInverzCodata
            ++ "  (σ = 1,1×10⁻⁸, forrás: CODATA 2022, 137.035999177(11))")
  putStrLn ("  Δ                = " ++ show (különbség alfaÖsszevetés))
  putStrLn ("  Δ/σ              = " ++ show (szigmaArány alfaÖsszevetés))
  putStrLn ""
  putStrLn "=== MIT JELENT (projekt-nyelven) ==="
  putStrLn ("  1/δ   = " ++ show (1.0 / hézag))
  putStrLn ("  δ·α⁻¹ = " ++ show (hézag * alfaInverzCodata))
  putStrLn "  ϱ nem zárja: δ túldeterminált → IRREDUCIBILIS"
  putStrLn "  δ = a buborék = a CPT-rest = ami életben tartja a Carnot-ciklust"
  putStrLn "Kész."

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ────────────────────────────
public export
DeltaAnalizisLeiras : ModulLeirasT
DeltaAnalizisLeiras = ModulLeirasKonstruktor
  "DeltaAnalizis_v1.idr"
  "ϱ Newton-számítással; δ = 1 − Re(ϱ)·π = 5,604×10⁻⁴; zárási tábla; §17 Δ/σ"
  "a delta_analizis.py numerikus magja Idrisben (AGENTS §3); a ϱ itt számolt, nem rögzített"
  "Show-teszt"
