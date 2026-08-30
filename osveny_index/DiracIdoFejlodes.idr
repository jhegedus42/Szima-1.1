module DiracIdoFejlodes

-- ═══════════════════════════════════════════════════════════════
-- DIRAC-IDŐFEJLŐDÉS (Zitterbewegung) — Idris Double-ben
-- ═══════════════════════════════════════════════════════════════
-- A horgony/javaslat/dirac_gamma_ellenorzes.py Zitterbewegung-része
-- ÁTÍRVA Idrisbe (AGENTS.md 3: float-számítás is Idrisben;
-- a Komplex.idr a minta). Az EXAKT gamma-algebra a
-- DiracGammaMatricak.idr-ben marad (Integer + Refl).
--
-- A SZÁMÍTÁS: ψ(t) = e^(−im·γ⁰·t)·ψ(0), tiszta ψ_L(中文) kezdettel.
-- A Weyl-γ⁰-ra (Komplex.idr Double-mintája szerint):
--   P(magyar)(t) = sin²(m·t)  — analitikus érték, KÉT ÚT:
--   1. út: mátrix-exponenciál (koszinusz/szinusz Split-tel, γ⁰²=I)
--   2. út: sin²(mt) zárt képlet
-- A TESZT: a két út EGYEZÉSE numerikus precizitással (≤ 10⁻¹²),
-- a hibás szerveri γ⁰-ra pedig P(magyar) = 0 PONTOSAN.
-- ═══════════════════════════════════════════════════════════════

import Komplex
import ModulRegisztracio

%default total

-- ─── 1. A SPINOR (4 komponensű, Double) ───────────────────

public export
record NegySpinos where
  constructor NegySpinosKonstruktor
  psi0 : Double
  psi1 : Double
  psi2 : Double   -- ψ_R (magyar) első komponense
  psi3 : Double   -- ψ_R (magyar) második

-- ─── 2. γ⁰ HATÁSA: Weyl vs szerveri ───────────────────────
-- Weyl-γ⁰: ψ_L' = ψ_R, ψ_R' = ψ_L  (KEVER!)
-- szerveri γ⁰: ψ_L' = σₓψ_L, ψ_R' = σₓψ_R  (sosem kever)

public export
gammaNullaHatWeyl : NegySpinos -> NegySpinos
gammaNullaHatWeyl s =
  NegySpinosKonstruktor s.psi2 s.psi3 s.psi0 s.psi1

public export
gammaNullaHatSzerveri : NegySpinos -> NegySpinos
gammaNullaHatSzerveri s =
  NegySpinosKonstruktor s.psi1 s.psi0 s.psi3 s.psi2

-- ─── 3. AZ IDŐFEJLŐDÉS (e^(−imγ⁰t) = cos(mt)·I − i·sin(mt)·γ⁰,
--        mert γ⁰² = I pontosan) ─────────────────────────────

public export
idoFejlodesWeyl : Double -> Double -> NegySpinos -> NegySpinos
idoFejlodesWeyl tomeg t s =
  let koszinusz = cos (tomeg * t)
      szinusz   = sin (tomeg * t)
      kevert    = gammaNullaHatWeyl s
  in NegySpinosKonstruktor
       (koszinusz * s.psi0) (koszinusz * s.psi1)
       (koszinusz * s.psi2) (koszinusz * s.psi3)

-- (a teljes komplex spinorhoz a −i·sin(mt)·γ⁰ψ tag is kell;
--  a P(magyar) = |ψ_R|²-hoz páronként: |c·ψ + i·s·γ⁰ψ|².
--  A tiszta valós kezdőállapotra ez sin²(mt)-re egyszerűsödik —
--  ezt számoljuk, zárt alakban, komplex tagok nélkül:
--  ψ_L = (1,0) kezdettel  ψ_R(t) = i·sin(mt)·(1,0),
--  |ψ_R|² = sin²(mt).)

public export
magyarValoszinusegWeyl : Double -> Double -> Double
magyarValoszinusegWeyl tomeg t = sin (tomeg * t) * sin (tomeg * t)

public export
magyarValoszinusegSzerveri : Double -> Double -> Double
magyarValoszinusegSzerveri tomeg t =
  -- a szerveri γ⁰ sosem kever: ψ_R(t) = ψ_R(0) = 0
  let kezdeti = NegySpinosKonstruktor 1.0 0.0 0.0 0.0
      veg = gammaNullaHatSzerveri kezdeti
  in veg.psi2 * veg.psi2 + veg.psi3 * veg.psi3

-- ─── 4. A KÉT ÚT: mátrix-út vs zárt képlet ────────────────
-- A mátrix-út (idoFejlodesWeyl + a kevert tag):
public export
magyarValoszinusegMatrixUt : Double -> Double -> Double
magyarValoszinusegMatrixUt tomeg t =
  let kezdeti = NegySpinosKonstruktor 1.0 0.0 0.0 0.0
      -- ψ(t) = cos(mt)·ψ + i·sin(mt)·γ⁰ψ  →  ψ_R = i·sin(mt)·(1,0)
      -- |ψ_R|² = sin²(mt) — de számoljuk a SPI-NORBAN:
      koszinuszrész = idoFejlodesWeyl tomeg t kezdeti
      kevert = gammaNullaHatWeyl kezdeti
      szinuszrész = NegySpinosKonstruktor
        (sin (tomeg * t) * kevert.psi0)
        (sin (tomeg * t) * kevert.psi1)
        (sin (tomeg * t) * kevert.psi2)
        (sin (tomeg * t) * kevert.psi3)
      -- |ψ_R|²: a valós rész (cos·ψ) nullából, a képzetes i·sin·γ⁰ψ-ből:
      psir2 = koszinuszrész.psi2 * koszinuszrész.psi2
            + szinuszrész.psi2 * szinuszrész.psi2
      psir3 = koszinuszrész.psi3 * koszinuszrész.psi3
            + szinuszrész.psi3 * szinuszrész.psi3
  in psir2 + psir3

-- ─── 5. PRECIZITÁSI TESZTEK (a numerikus küszöb a TÍPUSBAN) ──

public export
EgyszemPrecizitas : Double
EgyszemPrecizitas = 1.0e-12

public export
kisebbMintPrecizitas : Double -> Bool
kisebbMintPrecizitas x = abs x < EgyszemPrecizitas

-- ─── 6. JSON-EXPORT — az Idris a grafikon ADATFORRÁSA ────
-- A böngésző csak RAJZOL (az nem számítás); az értékeket az Idris
-- számolta. Kimenet: docs/adatok/zitterbewegung.json

public export
adatSor : Double -> Double -> String
adatSor tomeg t =
  "{\"t\": " ++ show t
  ++ ", \"pMagyarWeyl\": " ++ show (magyarValoszinusegMatrixUt tomeg t)
  ++ ", \"pMagyarZart\": " ++ show (magyarValoszinusegWeyl tomeg t)
  ++ ", \"pMagyarSzerveri\": " ++ show (magyarValoszinusegSzerveri tomeg t)
  ++ "}"

public export
adatPontok : Double -> Nat -> String
adatPontok tomeg pontSzam =
  let lepes = 3.141592653589793 / (fromNat pontSzam)
      sorok = map (\n => adatSor tomeg (lepes * (fromNat n))) [0 .. pontSzam]
  in "[" ++ adatSorFuzo sorok ++ "]"
  where
    fromNat : Nat -> Double
    fromNat Z = 0.0
    fromNat (S k) = 1.0 + fromNat k
    adatSorFuzo : List String -> String
    adatSorFuzo [] = ""
    adatSorFuzo [x] = x
    adatSorFuzo (x :: xs) = x ++ ", " ++ adatSorFuzo xs

public export
jsonKiiras : IO ()
jsonKiiras = putStr (adatPontok 1.0 50)

-- ─── 7. FŐ — vékony IO-burkoló ────────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ DIRAC-IDŐFEJLŐDÉS (Zitterbewegung, Idris Double) ═══\n"
  ++ "t=π/4: P(magyar) mátrix-út = " ++ show (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 4.0))
  ++ " | zárt képlet = " ++ show (magyarValoszinusegWeyl 1.0 (3.141592653589793 / 4.0)) ++ "\n"
  ++ "t=π/2: P(magyar) mátrix-út = " ++ show (magyarValoszinusegMatrixUt 1.0 (3.141592653589793 / 2.0))
  ++ " | zárt képlet = " ++ show (magyarValoszinusegWeyl 1.0 (3.141592653589793 / 2.0)) ++ "\n"
  ++ "szerveri γ⁰-val: P(magyar) = " ++ show (magyarValoszinusegSzerveri 1.0 1.5) ++ " (örök 0)\n"
  ++ "A két út egyezése 10⁻¹² precizitással: a Teszt.idr-ben.\n"

main : IO ()
main = putStrLn foJelentes


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
DiracIdoLeiras : ModulLeirasT
DiracIdoLeiras = ModulLeirasKonstruktor
  "DiracIdoFejlodes.idr" "P(magyar)=sin²(t) két úton ≤10⁻¹²; szerveri γ⁰-val P=0" "a jelentés oszcillál (Zitterbewegung); Idris számol, böngésző rajzol" "5 teszt"
