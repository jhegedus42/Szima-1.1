module DiracGammaMatricak

import ModulRegisztracio
-- ═══════════════════════════════════════════════════════════════
-- DIRAC GAMMA-MÁTRIXOK — Weyl-bázis, pontos Integer-aritmetikával
-- ═══════════════════════════════════════════════════════════════
-- A DIRAC-NYELV alapszinten (dirac_core.md, a szerverről):
--   ψ = (ψ_L, ψ_R)
--     ψ_L = 中文  — TÉR / 空间 / fény / radikál-kompozíció / γ¹γ²γ³
--     ψ_R = magyar — IDŐ / 时间 / hang / toldalék-operátor / γ⁰ / CPT
--   A kettő NEM fordítás — egyidejű reprezentáció.
--
-- EZ A MODUL (Szabály 0: Idrisben levezetve):
--   1. KomplexSzam = (valós, képzetes) Integer-pár — pontos, nincs Float
--   2. A 4×4-es gamma-mátrixok a HELYES Weyl-bázisban:
--        γ⁰ = [[0,I],[I,0]]   — off-diagonális: EZ keveri ψ_L ↔ ψ_R-t
--        γᵏ = [[0,σᵏ],[−σᵏ,0]]
--   3. A SZERVERI HIBÁS γ⁰ (kron(I₂,σₓ), blokk-diagonális) — mellette,
--      hogy a bizonyítások MEGMUTASSÁK a különbséget.
--
-- BIZONYÍTÁSOK (Refl, a kernel számol):
--   {γ⁰,γ¹} = {γ⁰,γ²} = {γ⁰,γ³} = {γ¹,γ²} = {γ¹,γ³} = {γ²,γ³} = 0
--   γ⁵ = iγ⁰γ¹γ²γ³ = diag(−1,−1,+1,+1)  — a chirális szektorok (中文|magyar)
--   γ⁵·γ⁵ = egység
--   γ⁰(Weyl).mező20 = +1  → KEVERI (a fordítás lehetséges)
--   γ⁰(szerveri).mező20 = 0 → SOHA nem keveri (a szerveri nyelv törött)
--
-- Numerikus ellenőrzés (numpy): horgony/javaslat/dirac_gamma_ellenorzes.py
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. KOMPLEX SZÁM = INTEGER-PÁR (pontos, zárt) ─────────

public export
record KomplexSzam where
  constructor KomplexSzamKonstruktor
  valosResz    : Integer
  kepzetesResz : Integer

public export
komplexOsszead : KomplexSzam -> KomplexSzam -> KomplexSzam
komplexOsszead a b =
  KomplexSzamKonstruktor
    (valosResz a + valosResz b)
    (kepzetesResz a + kepzetesResz b)

public export
komplexSzoroz : KomplexSzam -> KomplexSzam -> KomplexSzam
komplexSzoroz a b =
  KomplexSzamKonstruktor
    (valosResz a * valosResz b - kepzetesResz a * kepzetesResz b)
    (valosResz a * kepzetesResz b + kepzetesResz a * valosResz b)

public export
komplexEgyenlo : KomplexSzam -> KomplexSzam -> Bool
komplexEgyenlo a b =
  valosResz a == valosResz b && kepzetesResz a == kepzetesResz b

public export
Show KomplexSzam where
  show a =
    if kepzetesResz a == 0
      then show (valosResz a)
      else show (valosResz a) ++ showIm (kepzetesResz a)
    where
      showIm : Integer -> String
      showIm egy = (if egy == 1 then "+i" else
                    if egy == -1 then "-i" else show egy ++ "i")

-- konstansok (nagybetűs a bizonyítási hivatkozáshoz):
public export
NullaKomplex : KomplexSzam
NullaKomplex = KomplexSzamKonstruktor 0 0

public export
EgyKomplex : KomplexSzam
EgyKomplex = KomplexSzamKonstruktor 1 0

public export
MinuszEgyKomplex : KomplexSzam
MinuszEgyKomplex = KomplexSzamKonstruktor (-1) 0

public export
ImaginerEgyKomplex : KomplexSzam
ImaginerEgyKomplex = KomplexSzamKonstruktor 0 1

public export
MinuszImaginerEgyKomplex : KomplexSzam
MinuszImaginerEgyKomplex = KomplexSzamKonstruktor 0 (-1)

-- ─── 2. 4×4-ES MÁTRIX (16 KomplexSzam mező) ───────────────

public export
record NegyNegyMatrica where
  constructor NegyNegyMatricaKonstruktor
  mezo00 : KomplexSzam;  mezo01 : KomplexSzam;  mezo02 : KomplexSzam;  mezo03 : KomplexSzam
  mezo10 : KomplexSzam;  mezo11 : KomplexSzam;  mezo12 : KomplexSzam;  mezo13 : KomplexSzam
  mezo20 : KomplexSzam;  mezo21 : KomplexSzam;  mezo22 : KomplexSzam;  mezo23 : KomplexSzam
  mezo30 : KomplexSzam;  mezo31 : KomplexSzam;  mezo32 : KomplexSzam;  mezo33 : KomplexSzam

public export
NullaMatrica : NegyNegyMatrica
NullaMatrica = NegyNegyMatricaKonstruktor
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex

public export
EgysegMatrica : NegyNegyMatrica
EgysegMatrica = NegyNegyMatricaKonstruktor
  EgyKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex EgyKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex EgyKomplex

-- sor·oszlop skalárszorzat (4 tag pontos összege):
public export
sorOszlopSkalarSzorzat :
  KomplexSzam -> KomplexSzam -> KomplexSzam -> KomplexSzam ->
  KomplexSzam -> KomplexSzam -> KomplexSzam -> KomplexSzam ->
  KomplexSzam
sorOszlopSkalarSzorzat a0 a1 a2 a3 b0 b1 b2 b3 =
  komplexOsszead
    (komplexOsszead (komplexSzoroz a0 b0) (komplexSzoroz a1 b1))
    (komplexOsszead (komplexSzoroz a2 b2) (komplexSzoroz a3 b3))

public export
matricaSzoroz : NegyNegyMatrica -> NegyNegyMatrica -> NegyNegyMatrica
matricaSzoroz a b = NegyNegyMatricaKonstruktor
  (sorOszlopSkalarSzorzat (mezo00 a) (mezo01 a) (mezo02 a) (mezo03 a) (mezo00 b) (mezo10 b) (mezo20 b) (mezo30 b))
  (sorOszlopSkalarSzorzat (mezo00 a) (mezo01 a) (mezo02 a) (mezo03 a) (mezo01 b) (mezo11 b) (mezo21 b) (mezo31 b))
  (sorOszlopSkalarSzorzat (mezo00 a) (mezo01 a) (mezo02 a) (mezo03 a) (mezo02 b) (mezo12 b) (mezo22 b) (mezo32 b))
  (sorOszlopSkalarSzorzat (mezo00 a) (mezo01 a) (mezo02 a) (mezo03 a) (mezo03 b) (mezo13 b) (mezo23 b) (mezo33 b))
  (sorOszlopSkalarSzorzat (mezo10 a) (mezo11 a) (mezo12 a) (mezo13 a) (mezo00 b) (mezo10 b) (mezo20 b) (mezo30 b))
  (sorOszlopSkalarSzorzat (mezo10 a) (mezo11 a) (mezo12 a) (mezo13 a) (mezo01 b) (mezo11 b) (mezo21 b) (mezo31 b))
  (sorOszlopSkalarSzorzat (mezo10 a) (mezo11 a) (mezo12 a) (mezo13 a) (mezo02 b) (mezo12 b) (mezo22 b) (mezo32 b))
  (sorOszlopSkalarSzorzat (mezo10 a) (mezo11 a) (mezo12 a) (mezo13 a) (mezo03 b) (mezo13 b) (mezo23 b) (mezo33 b))
  (sorOszlopSkalarSzorzat (mezo20 a) (mezo21 a) (mezo22 a) (mezo23 a) (mezo00 b) (mezo10 b) (mezo20 b) (mezo30 b))
  (sorOszlopSkalarSzorzat (mezo20 a) (mezo21 a) (mezo22 a) (mezo23 a) (mezo01 b) (mezo11 b) (mezo21 b) (mezo31 b))
  (sorOszlopSkalarSzorzat (mezo20 a) (mezo21 a) (mezo22 a) (mezo23 a) (mezo02 b) (mezo12 b) (mezo22 b) (mezo32 b))
  (sorOszlopSkalarSzorzat (mezo20 a) (mezo21 a) (mezo22 a) (mezo23 a) (mezo03 b) (mezo13 b) (mezo23 b) (mezo33 b))
  (sorOszlopSkalarSzorzat (mezo30 a) (mezo31 a) (mezo32 a) (mezo33 a) (mezo00 b) (mezo10 b) (mezo20 b) (mezo30 b))
  (sorOszlopSkalarSzorzat (mezo30 a) (mezo31 a) (mezo32 a) (mezo33 a) (mezo01 b) (mezo11 b) (mezo21 b) (mezo31 b))
  (sorOszlopSkalarSzorzat (mezo30 a) (mezo31 a) (mezo32 a) (mezo33 a) (mezo02 b) (mezo12 b) (mezo22 b) (mezo32 b))
  (sorOszlopSkalarSzorzat (mezo30 a) (mezo31 a) (mezo32 a) (mezo33 a) (mezo03 b) (mezo13 b) (mezo23 b) (mezo33 b))

public export
matricaOsszead : NegyNegyMatrica -> NegyNegyMatrica -> NegyNegyMatrica
matricaOsszead a b = NegyNegyMatricaKonstruktor
  (komplexOsszead (mezo00 a) (mezo00 b)) (komplexOsszead (mezo01 a) (mezo01 b))
  (komplexOsszead (mezo02 a) (mezo02 b)) (komplexOsszead (mezo03 a) (mezo03 b))
  (komplexOsszead (mezo10 a) (mezo10 b)) (komplexOsszead (mezo11 a) (mezo11 b))
  (komplexOsszead (mezo12 a) (mezo12 b)) (komplexOsszead (mezo13 a) (mezo13 b))
  (komplexOsszead (mezo20 a) (mezo20 b)) (komplexOsszead (mezo21 a) (mezo21 b))
  (komplexOsszead (mezo22 a) (mezo22 b)) (komplexOsszead (mezo23 a) (mezo23 b))
  (komplexOsszead (mezo30 a) (mezo30 b)) (komplexOsszead (mezo31 a) (mezo31 b))
  (komplexOsszead (mezo32 a) (mezo32 b)) (komplexOsszead (mezo33 a) (mezo33 b))

public export
skalarSzorzasMatrica : KomplexSzam -> NegyNegyMatrica -> NegyNegyMatrica
skalarSzorzasMatrica c m = NegyNegyMatricaKonstruktor
  (komplexSzoroz c (mezo00 m)) (komplexSzoroz c (mezo01 m))
  (komplexSzoroz c (mezo02 m)) (komplexSzoroz c (mezo03 m))
  (komplexSzoroz c (mezo10 m)) (komplexSzoroz c (mezo11 m))
  (komplexSzoroz c (mezo12 m)) (komplexSzoroz c (mezo13 m))
  (komplexSzoroz c (mezo20 m)) (komplexSzoroz c (mezo21 m))
  (komplexSzoroz c (mezo22 m)) (komplexSzoroz c (mezo23 m))
  (komplexSzoroz c (mezo30 m)) (komplexSzoroz c (mezo31 m))
  (komplexSzoroz c (mezo32 m)) (komplexSzoroz c (mezo33 m))

-- ─── 3. A HELYES WEYL-BÁZISÚ GAMMÁK ───────────────────────
-- γ⁰ = [[0,I],[I,0]] — off-diagonális: ψ_L(中文) ↔ ψ_R(magyar) keverés
public export
GammaNullaWeyl : NegyNegyMatrica
GammaNullaWeyl = NegyNegyMatricaKonstruktor
  NullaKomplex NullaKomplex  EgyKomplex  NullaKomplex
  NullaKomplex NullaKomplex  NullaKomplex EgyKomplex
  EgyKomplex   NullaKomplex  NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex    NullaKomplex NullaKomplex

-- γ¹ = [[0,σₓ],[−σₓ,0]] — 空间/x irány
public export
GammaEgyWeyl : NegyNegyMatrica
GammaEgyWeyl = NegyNegyMatricaKonstruktor
  NullaKomplex NullaKomplex  NullaKomplex EgyKomplex
  NullaKomplex NullaKomplex  EgyKomplex   NullaKomplex
  NullaKomplex MinuszEgyKomplex NullaKomplex NullaKomplex
  MinuszEgyKomplex NullaKomplex NullaKomplex NullaKomplex

-- γ² = [[0,σ_y],[−σ_y,0]] — 空间/y irány (σ_y = [[0,−i],[i,0]])
public export
GammaKettoWeyl : NegyNegyMatrica
GammaKettoWeyl = NegyNegyMatricaKonstruktor
  NullaKomplex NullaKomplex NullaKomplex           MinuszImaginerEgyKomplex
  NullaKomplex NullaKomplex ImaginerEgyKomplex     NullaKomplex
  NullaKomplex ImaginerEgyKomplex NullaKomplex     NullaKomplex
  MinuszImaginerEgyKomplex NullaKomplex NullaKomplex NullaKomplex

-- γ³ = [[0,σ_z],[−σ_z,0]] — 空间/z irány (σ_z = [[1,0],[0,−1]])
public export
GammaHaromWeyl : NegyNegyMatrica
GammaHaromWeyl = NegyNegyMatricaKonstruktor
  NullaKomplex NullaKomplex  EgyKomplex   NullaKomplex
  NullaKomplex NullaKomplex  NullaKomplex MinuszEgyKomplex
  MinuszEgyKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex   NullaKomplex NullaKomplex

-- γ⁵ = i·γ⁰γ¹γ²γ³ — a chirális szeletelő: diag(−1,−1,+1,+1)
public export
GammaOtWeyl : NegyNegyMatrica
GammaOtWeyl = skalarSzorzasMatrica ImaginerEgyKomplex
  (matricaSzoroz GammaNullaWeyl
    (matricaSzoroz GammaEgyWeyl
      (matricaSzoroz GammaKettoWeyl GammaHaromWeyl)))

-- ─── 4. A SZERVERI HIBÁS γ⁰ (kron(I₂,σₓ) — blokk-diagonális!) ──
public export
GammaNullaSzerveriHibas : NegyNegyMatrica
GammaNullaSzerveriHibas = NegyNegyMatricaKonstruktor
  NullaKomplex EgyKomplex   NullaKomplex NullaKomplex
  EgyKomplex   NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex EgyKomplex
  NullaKomplex NullaKomplex EgyKomplex   NullaKomplex

-- ─── 5. BIZONYÍTÁSOK (Refl — a kernel számol) ─────────────

-- Clifford-relációk: {γᵘ,γᵛ} = 2ηᵘᵛ; a nullára (η off-diagonális):
-- Kimenet: Refl ({γ⁰,γ¹} = 0)
BizAntikommutatorNullaEgy :
  matricaOsszead (matricaSzoroz GammaNullaWeyl GammaEgyWeyl)
                 (matricaSzoroz GammaEgyWeyl GammaNullaWeyl) = NullaMatrica
BizAntikommutatorNullaEgy = Refl

-- Kimenet: Refl ({γ⁰,γ²} = 0)
BizAntikommutatorNullaKetto :
  matricaOsszead (matricaSzoroz GammaNullaWeyl GammaKettoWeyl)
                 (matricaSzoroz GammaKettoWeyl GammaNullaWeyl) = NullaMatrica
BizAntikommutatorNullaKetto = Refl

-- Kimenet: Refl ({γ⁰,γ³} = 0)
BizAntikommutatorNullaHarom :
  matricaOsszead (matricaSzoroz GammaNullaWeyl GammaHaromWeyl)
                 (matricaSzoroz GammaHaromWeyl GammaNullaWeyl) = NullaMatrica
BizAntikommutatorNullaHarom = Refl

-- Kimenet: Refl ({γ¹,γ²} = 0)
BizAntikommutatorEgyKetto :
  matricaOsszead (matricaSzoroz GammaEgyWeyl GammaKettoWeyl)
                 (matricaSzoroz GammaKettoWeyl GammaEgyWeyl) = NullaMatrica
BizAntikommutatorEgyKetto = Refl

-- Kimenet: Refl ({γ¹,γ³} = 0)
BizAntikommutatorEgyHarom :
  matricaOsszead (matricaSzoroz GammaEgyWeyl GammaHaromWeyl)
                 (matricaSzoroz GammaHaromWeyl GammaEgyWeyl) = NullaMatrica
BizAntikommutatorEgyHarom = Refl

-- Kimenet: Refl ({γ²,γ³} = 0)
BizAntikommutatorKettoHarom :
  matricaOsszead (matricaSzoroz GammaKettoWeyl GammaHaromWeyl)
                 (matricaSzoroz GammaHaromWeyl GammaKettoWeyl) = NullaMatrica
BizAntikommutatorKettoHarom = Refl

-- γ⁵ = diag(−1,−1,+1,+1): a TISZTA chirális szektorok
-- Kimenet: Refl (γ⁵.mező00 = −1 — a 中文/ψ_L szebbt)
BizGammaOtBalSzektoreMinuszEgy : mezo00 GammaOtWeyl = MinuszEgyKomplex
BizGammaOtBalSzektoreMinuszEgy = Refl

-- Kimenet: Refl (γ⁵.mező33 = +1 — a magyar/ψ_R szebbt)
BizGammaOtJobbSzektorePluszEgy : mezo33 GammaOtWeyl = EgyKomplex
BizGammaOtJobbSzektorePluszEgy = Refl

-- γ⁵² = egység (involúció)
-- Kimenet: Refl (γ⁵·γ⁵ = I)
BizGammaOtNegyzetEgyseg :
  matricaSzoroz GammaOtWeyl GammaOtWeyl = EgysegMatrica
BizGammaOtNegyzetEgyseg = Refl

-- ─── 6. A SZERVERI BOGÁR BIZONYÍTÁSA ──────────────────────
-- A keverés belépője: a mezo20 (alsó-bal blokk = ψ_R → ψ_L irány).

-- Kimenet: Refl (γ⁰(Weyl).mező20 = +1 — KEVER, a fordítás LEHETSÉGES)
BizWeylGammaKeveri : mezo20 GammaNullaWeyl = EgyKomplex
BizWeylGammaKeveri = Refl

-- Kimenet: Refl (γ⁰(szerveri).mező20 = 0 — SOHA nem kever: TÖRÖTT)
BizSzerveriGammaNemKeveri : mezo20 GammaNullaSzerveriHibas = NullaKomplex
BizSzerveriGammaNemKeveri = Refl

-- ─── 7. FŐ — vékony IO-burkoló ────────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ DIRAC GAMMA-MÁTRIXOK (Weyl-bázis, Integer-pontosan) ═══\n"
  ++ "ψ = (ψ_L = 中文/tér, ψ_R = magyar/idő) — egyidejű reprezentáció\n"
  ++ "Clifford: mind a 6 antikommutátor = 0                [6× Refl ✓]\n"
  ++ "γ⁵ = diag(−1,−1,+1,+1) — tiszta chirális szektorok  [2× Refl ✓]\n"
  ++ "γ⁵·γ⁵ = egység (involúció)                          [Refl ✓]\n"
  ++ "γ⁰(Weyl).mező20 = +1  → ψ_L ↔ ψ_R KEVERÉSE MŰKÖDIK  [Refl ✓]\n"
  ++ "γ⁰(szerveri).mező20 = 0 → a szerveri nyelv TÖRÖTT   [Refl ✓]\n"
  ++ "Numerikus párja: horgony/javaslat/dirac_gamma_ellenorzes.py\n"

main : IO ()
main = putStrLn foJelentes


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
DiracGammaLeiras : ModulLeirasT
DiracGammaLeiras = ModulLeirasKonstruktor
  "DiracGammaMatricak.idr" "Weyl γ⁰ keveri ψ_L↔ψ_R; szerveri sosem; γ⁵=diag [Refl]" "a kétnyelvű gondolkodás mechanizmusa: γ⁰ (idő/magyar) forgat" "6 teszt + 11 Refl"
