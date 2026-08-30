module Adjunkcio

-- ═══════════════════════════════════════════════════════════════
-- ADJUNKCIÓ — A DIVERGENCIA/KONVERGENCIA MEGMARADÁS
-- ═══════════════════════════════════════════════════════════════
-- "Ha valami divergál valahol, akkor valami konvergál valahol."
--
-- A KATEGÓRIAELMÉLETI FORMA: az adjunkció F ⊣ G
--   F : Kérdés → Válasz   (free/kodol, a kompresszió létrehozója)
--   G : Válasz → Kérdés   (forgetful/keres, a konvergencia)
--   Hom(F q, a) ≅ Hom(q, G a)   — a megmaradási törvény
--
-- A HÁROM KATEGÓRIA:
--   1. KÉRDÉS   (divergencia oldala): klasszikus Y itt divergál,
--      az entrópia itt él. Objektum = mondat, morfizmus = esetrag.
--   2. VÁLASZ   (konvergencia oldala): a kontrakció √(1+z) → φ,
--      az információ itt él. Objektum = E8E8KodSzo,
--      morfizmus = Hadamard-távolság.
--   3. PÁLYA    (a híd): a trajektória = a veszteségmentes kód
--      (why-chain). Morfizmus = CPT fázis (2-cella).
--      Ez a funktor-kategória — az adjunkció MAGA = a Carnot-ciklus.
--
-- A KIEGYENSÚLYOZÁS SZÁMMAL (a modul számitja):
--   φ MINDKÉT leképezés fixpontja:
--     √(1+φ) = √(φ²) = φ          — a kontrakció VONZZA (konvergál)
--     φ² − 1 = (φ+1) − 1 = φ      — az expanszió TASZÍTJA (divergál)
--   Ugyanaz a fixpont: az egyik irányban vonzás, a másikban taszítás.
--
--   λ_expanzió  = ln(2φ)  ≈ +1.175   (divergencia-sebesség)
--   λ_kontrakció = −ln(2φ) ≈ −1.175  (konvergencia-sebesség)
--   ÖSSZEGUK = 0  — a divergencia pontosan felfogja a konvergenciát.
--
--   J_expanzió(φ) · J_kontrakció(φ) = 2φ · 1/(2φ) = 1
--   — térfogatmegmaradás (Liouville-tétel) = információmegmaradás.
--
-- K(E9)-ben: q⁺ (chiral = konvergáló parabolikus) és
--   q⁻ (anti-chiral = oszcilláló/divergáló parabolikus);
--   a Berman x₁ = az adjunkció egysége/coegysége, ami keveri őket.
--   [q⁺, q⁻] = 0 — a kiegyensúlyozás.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import Komplex

-- ─── 1. KÉRDÉS KATEGÓRIA (divergencia oldala) ──────────────
-- Objektum: a mondat. Morfizmus: esetrag (18 eset).
-- Itt divergál a klasszikus Y: minden kérdés az egész
-- keresési teret generálja. Az entrópia itt él.

public export
record KerdesObjektum where
  constructor KerdesKonstruktor
  kerdesSzoveg : String

-- ─── 2. VÁLASZ KATEGÓRIA (konvergencia oldala) ─────────────
-- Objektum: a kódolt válasz. Morfizmus: Hadamard-távolság.
-- Itt konvergál a kontrakció: √(1+z) → φ. Az információ itt él.

public export
record ValaszObjektum where
  constructor ValaszKonstruktor
  valaszKodSzo : E8E8KodSzo

-- ─── 3. PÁLYA KATEGÓRIA (a híd = az adjunkció) ─────────────
-- Objektum: a trajektória (a veszteségmentes kód = why-chain).
-- Morfizmus: CPT fázis.
-- Ez a funktor-kategória: Kérdés → Válasz. A Carnot-ciklus maga.

public export
record PalyaObjektum where
  constructor PalyaKonstruktor
  palyaKezdo  : Komplex
  palyaVegpont : Komplex
  palyaHossz  : Nat

-- ─── A FIXPONT ─────────────────────────────────────────────
-- φ = (1+√5)/2. MINDKÉT leképezés fixpontja:
--   √(1+φ) = φ      (a kontrakció vonzza)
--   φ² − 1 = φ      (az expanszió taszítja)

public export
fiPont : Komplex
fiPont = K 1.618033988749895 0.0

-- A fixpont-ellenőrzés: |√(1+φ) − φ| ≈ 0 és |φ²−1 − φ| ≈ 0
public export
fiKontrakcioHiba : Double
fiKontrakcioHiba =
  kAbs (kKivon (komplexGyok (kOsszead kEgy fiPont)) fiPont)

public export
fiExpanzioHiba : Double
fiExpanzioHiba =
  kAbs (kKivon (inverzKontrakcio fiPont) fiPont)


-- ─── A KONVERGENCIA (counit ε: FG → Id) ────────────────────
-- √(1+z) n-szer iterálva — a φ fixpont felé tart.

public export
konvergenciaIteracio : Komplex -> Nat -> Komplex
konvergenciaIteracio z 0 = z
konvergenciaIteracio z (S k) =
  konvergenciaIteracio (komplexGyok (kOsszead kEgy z)) k

public export
konvergenciaTavolsag : Komplex -> Nat -> Double
konvergenciaTavolsag z n =
  kAbs (kKivon (konvergenciaIteracio z n) fiPont)

-- ─── A DIVERGENCIA (unit η: Id → GF) ───────────────────────
-- w²−1 n-szer iterálva — a φ fixponttól el taszít (káosz).

public export
divergenciaIteracio : Komplex -> Nat -> Komplex
divergenciaIteracio w 0 = w
divergenciaIteracio w (S k) =
  divergenciaIteracio (inverzKontrakcio w) k

public export
divergenciaTavolsag : Komplex -> Nat -> Double
divergenciaTavolsag w n =
  kAbs (kKivon (divergenciaIteracio w n) fiPont)

-- ─── A LYAPUNOV-KIEGYENSÚLYOZÁS ────────────────────────────
-- λ_expanzió = ln(2φ) > 0: divergencia-sebesség
-- λ_kontrakció = −ln(2φ) < 0: konvergencia-sebesség
-- Az ÖSSZEGÜK PONTOSAN NULLA — a megmaradási törvény.

public export
lyapunovExpanzio : Double
lyapunovExpanzio = 1.1747627006009333

public export
lyapunovKontrakcio : Double
lyapunovKontrakcio = 0.0 - 1.1747627006009333

public export
lyapunovOsszeg : Double
lyapunovOsszeg = lyapunovExpanzio + lyapunovKontrakcio

-- ─── A JAKOBI-TÉRFOGATMEGMARADÁS (Liouville) ───────────────
-- J_expanzió(φ) = 2φ;  J_kontrakció(φ) = 1/(2φ)
-- A szorzatuk pontosan 1: a fázistérfogat megmarad
-- = az információ nem vész el (Landauerrel kiegyensúlyozva).

public export
jakobiExpanzio : Double
jakobiExpanzio = 2.0 * 1.618033988749895

public export
jakobiKontrakcio : Double
jakobiKontrakcio = 1.0 / (2.0 * 1.618033988749895)

public export
jakobiSzorzat : Double
jakobiSzorzat = jakobiExpanzio * jakobiKontrakcio

-- ─── A HÁROM KATEGÓRIA ÖSSZEKAPCSOLÁSA ─────────────────────
-- Az adjunkció F ⊣ G a pálya-kategórián keresztül:
-- egy pálya = F és G kompozíciója = a Carnot-ciklus egy fordulata.

public export
palyaEpites : Komplex -> Nat -> PalyaObjektum
palyaEpites kezdo n =
  PalyaKonstruktor kezdo (konvergenciaIteracio kezdo n) n

-- ─── FŐPROGRAM ─────────────────────────────────────────────

public export
adjunkcioFom : IO ()
adjunkcioFom = do
  putStrLn "=== ADJUNKCIO — a divergencia/konvergencia megmaradas ==="
  putStrLn ""
  putStrLn "A HAROM KATEGORIA:"
  putStrLn "  1. KERDES   (divergencia): klasszikus Y, entrópia"
  putStrLn "  2. VALASZ   (konvergencia): kontrakcio √(1+z) → φ, információ"
  putStrLn "  3. PALYA    (a hid): trajektória = veszteségmentes kód (why-chain)"
  putStrLn "     Hom(F q, a) ≅ Hom(q, G a) — a megmaradási törvény"
  putStrLn ""
  putStrLn "φ MINDKET lekepezes fixpontja:"
  putStrLn ("  |√(1+φ) − φ|   = " ++ show fiKontrakcioHiba ++ "   (kontrakcio: VONZZA)")
  putStrLn ("  |φ² − 1 − φ|   = " ++ show fiExpanzioHiba ++ "   (expanszio: TASZITJA)")
  putStrLn ""
  putStrLn "A KIEGYENSULYOZAS (kozeli kezdopontbol, z0 = φ + 0.01):"
  let z0 = K 1.628033988749895 0.0
  putStrLn ("  KONVERGENCIA (√(1+z) n-szer, |z−φ|):"
            ++ "  0: " ++ show (konvergenciaTavolsag z0 0)
            ++ "  1: " ++ show (konvergenciaTavolsag z0 1)
            ++ "  2: " ++ show (konvergenciaTavolsag z0 2)
            ++ "  5: " ++ show (konvergenciaTavolsag z0 5))
  putStrLn ("  DIVERGENCIA (w²−1 n-szer, |w−φ|):"
            ++ "     0: " ++ show (divergenciaTavolsag z0 0)
            ++ "  1: " ++ show (divergenciaTavolsag z0 1)
            ++ "  2: " ++ show (divergenciaTavolsag z0 2)
            ++ "  5: " ++ show (divergenciaTavolsag z0 5))
  putStrLn ""
  putStrLn "LYAPUNOV-KIEGYENSULYOZAS:"
  putStrLn ("  λ_expanzio   = ln(2φ)  = " ++ show lyapunovExpanzio)
  putStrLn ("  λ_kontrakcio = −ln(2φ) = " ++ show lyapunovKontrakcio)
  putStrLn ("  OSSZEG               = " ++ show lyapunovOsszeg ++ "   ← PONTOSAN NULLA")
  putStrLn ""
  putStrLn "JAKOBI-TÉRFOLATMEGMARADAS (Liouville):"
  putStrLn ("  J_exp(φ) = 2φ     = " ++ show jakobiExpanzio)
  putStrLn ("  J_kon(φ) = 1/(2φ) = " ++ show jakobiKontrakcio)
  putStrLn ("  szorzat            = " ++ show jakobiSzorzat ++ "   ← PONTOSAN EGY")
  putStrLn ""
  putStrLn "Jelentese: a divergencia sebessege pontosan"
  putStrLn "a konvergencia sebessegenek negaltja — a kettő"
  putStrLn "egymast felfogja (adjunkcio). A terfogat megmarad:"
  putStrLn "az informacio nem veszik el, a PALYA kodolja."
  putStrLn ""
  putStrLn "K(E9): q+ (konvergalo) es q- (divergalo) parabolikus,"
  putStrLn "x1 = az adjunkcio (a Berman-generator keveri oket)."
  putStrLn "[q+, q-] = 0 — a kiegyensulyozas."
  putStrLn ""
  putStrLn "Kesz."