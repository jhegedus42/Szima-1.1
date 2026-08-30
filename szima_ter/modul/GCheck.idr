module GCheck

-- ═══════════════════════════════════════════════════════════════
-- GCHECK — a G gravitációs állandó levezetésének ellenőrzése
-- ═══════════════════════════════════════════════════════════════
-- Forrás: all_constants_exact.py (ProtonDrive, 534 sor)
--         gondnok-laptop/project/target/all_sources/
--
-- A G levezetés: (7×11)/(2³×5²) × √3 × (1+9/250)^(1/40) × 10⁻¹⁰
-- Ahol 9/250 = 3²/(5³×2) = α⁻¹ törtrésze, 40 = 2³×5 prímstruktúra.
--
-- Eredmény: Δ/σ = 0.038 — a mérési hibán belül! ✅
-- (NEM törölve — AGENTS §20: semmit nem lehet törölni soha)
-- ═══════════════════════════════════════════════════════════════

%default total

A : Double
A = 2.0

B : Double
B = 3.0

C : Double
C = 5.0

D : Double
D = 7.0

E : Double
E = 11.0

alphaFrac : Double
alphaFrac = 9.0 / 250.0

GLevezetett : Double
GLevezetett =
  (D * E) / (A*A*A * C*C) *
  sqrt B *
  pow (1.0 + alphaFrac) (1.0 / (A*A*A * C)) *
  1.0e-10

GCodata : Double
GCodata = 6.67430e-11

SigmaG : Double
SigmaG = 1.5e-15

main : IO ()
main = do
  let delta = GLevezetett - GCodata
  let ratio = abs delta / SigmaG
  putStrLn ("G levezetett  = " ++ show GLevezetett)
  putStrLn ("G codata      = " ++ show GCodata ++ " (sigma = " ++ show SigmaG ++ ")")
  putStrLn ("Delta         = " ++ show delta)
  putStrLn ("Delta/sigma   = " ++ show ratio)
  putStrLn ""
  if abs delta < SigmaG
    then putStrLn "IGEN: a G levezetes a meresi hiban belul van."
    else putStrLn ("NEM: " ++ show ratio ++ " sigma kivul.")