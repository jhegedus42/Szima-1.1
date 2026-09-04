module DiracGammaMatricak

import ModulRegisztracio
import Alap.CsomagoltTipusok
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
  valósRész    : Integer
  képzetesRész : Integer

public export
komplexÖsszead : KomplexSzam -> KomplexSzam -> KomplexSzam
komplexÖsszead a b =
  KomplexSzamKonstruktor
    (valósRész a + valósRész b)
    (képzetesRész a + képzetesRész b)

public export
komplexSzoroz : KomplexSzam -> KomplexSzam -> KomplexSzam
komplexSzoroz a b =
  KomplexSzamKonstruktor
    (valósRész a * valósRész b - képzetesRész a * képzetesRész b)
    (valósRész a * képzetesRész b + képzetesRész a * valósRész b)

public export
komplexEgyenlő : KomplexSzam -> KomplexSzam -> Igazság
komplexEgyenlő a b =
  ésE (egyenlőE (valósRész a) (valósRész b))
      (egyenlőE (képzetesRész a) (képzetesRész b))

public export
Show KomplexSzam where
  show a =
    if képzetesRész a == 0
      then show (valósRész a)
      else show (valósRész a) ++ showIm (képzetesRész a)
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
ImagináriusEgyKomplex : KomplexSzam
ImagináriusEgyKomplex = KomplexSzamKonstruktor 0 1

public export
MinuszImagináriusEgyKomplex : KomplexSzam
MinuszImagináriusEgyKomplex = KomplexSzamKonstruktor 0 (-1)

-- ─── 2. 4×4-ES MÁTRIX (16 KomplexSzam mező) ───────────────

public export
record NégyNégyMátrix where
  constructor NégyNégyMátrixKonstruktor
  mező00 : KomplexSzam;  mező01 : KomplexSzam;  mező02 : KomplexSzam;  mező03 : KomplexSzam
  mező10 : KomplexSzam;  mező11 : KomplexSzam;  mező12 : KomplexSzam;  mező13 : KomplexSzam
  mező20 : KomplexSzam;  mező21 : KomplexSzam;  mező22 : KomplexSzam;  mező23 : KomplexSzam
  mező30 : KomplexSzam;  mező31 : KomplexSzam;  mező32 : KomplexSzam;  mező33 : KomplexSzam

public export
NullaMátrix : NégyNégyMátrix
NullaMátrix = NégyNégyMátrixKonstruktor
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex NullaKomplex

public export
EgységMátrix : NégyNégyMátrix
EgységMátrix = NégyNégyMátrixKonstruktor
  EgyKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex EgyKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex EgyKomplex

-- sor·oszlop skalárszorzat (4 tag pontos összege):
public export
sorOszlopSkalárSzorzat :
  KomplexSzam -> KomplexSzam -> KomplexSzam -> KomplexSzam ->
  KomplexSzam -> KomplexSzam -> KomplexSzam -> KomplexSzam ->
  KomplexSzam
sorOszlopSkalárSzorzat a0 a1 a2 a3 b0 b1 b2 b3 =
  komplexÖsszead
    (komplexÖsszead (komplexSzoroz a0 b0) (komplexSzoroz a1 b1))
    (komplexÖsszead (komplexSzoroz a2 b2) (komplexSzoroz a3 b3))

public export
mátrixSzoroz : NégyNégyMátrix -> NégyNégyMátrix -> NégyNégyMátrix
mátrixSzoroz a b = NégyNégyMátrixKonstruktor
  (sorOszlopSkalárSzorzat (mező00 a) (mező01 a) (mező02 a) (mező03 a) (mező00 b) (mező10 b) (mező20 b) (mező30 b))
  (sorOszlopSkalárSzorzat (mező00 a) (mező01 a) (mező02 a) (mező03 a) (mező01 b) (mező11 b) (mező21 b) (mező31 b))
  (sorOszlopSkalárSzorzat (mező00 a) (mező01 a) (mező02 a) (mező03 a) (mező02 b) (mező12 b) (mező22 b) (mező32 b))
  (sorOszlopSkalárSzorzat (mező00 a) (mező01 a) (mező02 a) (mező03 a) (mező03 b) (mező13 b) (mező23 b) (mező33 b))
  (sorOszlopSkalárSzorzat (mező10 a) (mező11 a) (mező12 a) (mező13 a) (mező00 b) (mező10 b) (mező20 b) (mező30 b))
  (sorOszlopSkalárSzorzat (mező10 a) (mező11 a) (mező12 a) (mező13 a) (mező01 b) (mező11 b) (mező21 b) (mező31 b))
  (sorOszlopSkalárSzorzat (mező10 a) (mező11 a) (mező12 a) (mező13 a) (mező02 b) (mező12 b) (mező22 b) (mező32 b))
  (sorOszlopSkalárSzorzat (mező10 a) (mező11 a) (mező12 a) (mező13 a) (mező03 b) (mező13 b) (mező23 b) (mező33 b))
  (sorOszlopSkalárSzorzat (mező20 a) (mező21 a) (mező22 a) (mező23 a) (mező00 b) (mező10 b) (mező20 b) (mező30 b))
  (sorOszlopSkalárSzorzat (mező20 a) (mező21 a) (mező22 a) (mező23 a) (mező01 b) (mező11 b) (mező21 b) (mező31 b))
  (sorOszlopSkalárSzorzat (mező20 a) (mező21 a) (mező22 a) (mező23 a) (mező02 b) (mező12 b) (mező22 b) (mező32 b))
  (sorOszlopSkalárSzorzat (mező20 a) (mező21 a) (mező22 a) (mező23 a) (mező03 b) (mező13 b) (mező23 b) (mező33 b))
  (sorOszlopSkalárSzorzat (mező30 a) (mező31 a) (mező32 a) (mező33 a) (mező00 b) (mező10 b) (mező20 b) (mező30 b))
  (sorOszlopSkalárSzorzat (mező30 a) (mező31 a) (mező32 a) (mező33 a) (mező01 b) (mező11 b) (mező21 b) (mező31 b))
  (sorOszlopSkalárSzorzat (mező30 a) (mező31 a) (mező32 a) (mező33 a) (mező02 b) (mező12 b) (mező22 b) (mező32 b))
  (sorOszlopSkalárSzorzat (mező30 a) (mező31 a) (mező32 a) (mező33 a) (mező03 b) (mező13 b) (mező23 b) (mező33 b))

public export
mátrixÖsszead : NégyNégyMátrix -> NégyNégyMátrix -> NégyNégyMátrix
mátrixÖsszead a b = NégyNégyMátrixKonstruktor
  (komplexÖsszead (mező00 a) (mező00 b)) (komplexÖsszead (mező01 a) (mező01 b))
  (komplexÖsszead (mező02 a) (mező02 b)) (komplexÖsszead (mező03 a) (mező03 b))
  (komplexÖsszead (mező10 a) (mező10 b)) (komplexÖsszead (mező11 a) (mező11 b))
  (komplexÖsszead (mező12 a) (mező12 b)) (komplexÖsszead (mező13 a) (mező13 b))
  (komplexÖsszead (mező20 a) (mező20 b)) (komplexÖsszead (mező21 a) (mező21 b))
  (komplexÖsszead (mező22 a) (mező22 b)) (komplexÖsszead (mező23 a) (mező23 b))
  (komplexÖsszead (mező30 a) (mező30 b)) (komplexÖsszead (mező31 a) (mező31 b))
  (komplexÖsszead (mező32 a) (mező32 b)) (komplexÖsszead (mező33 a) (mező33 b))

public export
skalárSzorzásMátrix : KomplexSzam -> NégyNégyMátrix -> NégyNégyMátrix
skalárSzorzásMátrix c m = NégyNégyMátrixKonstruktor
  (komplexSzoroz c (mező00 m)) (komplexSzoroz c (mező01 m))
  (komplexSzoroz c (mező02 m)) (komplexSzoroz c (mező03 m))
  (komplexSzoroz c (mező10 m)) (komplexSzoroz c (mező11 m))
  (komplexSzoroz c (mező12 m)) (komplexSzoroz c (mező13 m))
  (komplexSzoroz c (mező20 m)) (komplexSzoroz c (mező21 m))
  (komplexSzoroz c (mező22 m)) (komplexSzoroz c (mező23 m))
  (komplexSzoroz c (mező30 m)) (komplexSzoroz c (mező31 m))
  (komplexSzoroz c (mező32 m)) (komplexSzoroz c (mező33 m))

-- ─── 3. A HELYES WEYL-BÁZISÚ GAMMÁK ───────────────────────
-- γ⁰ = [[0,I],[I,0]] — off-diagonális: ψ_L(中文) ↔ ψ_R(magyar) keverés
public export
GammaNullaWeyl : NégyNégyMátrix
GammaNullaWeyl = NégyNégyMátrixKonstruktor
  NullaKomplex NullaKomplex  EgyKomplex  NullaKomplex
  NullaKomplex NullaKomplex  NullaKomplex EgyKomplex
  EgyKomplex   NullaKomplex  NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex    NullaKomplex NullaKomplex

-- γ¹ = [[0,σₓ],[−σₓ,0]] — 空间/x irány
public export
GammaEgyWeyl : NégyNégyMátrix
GammaEgyWeyl = NégyNégyMátrixKonstruktor
  NullaKomplex NullaKomplex  NullaKomplex EgyKomplex
  NullaKomplex NullaKomplex  EgyKomplex   NullaKomplex
  NullaKomplex MinuszEgyKomplex NullaKomplex NullaKomplex
  MinuszEgyKomplex NullaKomplex NullaKomplex NullaKomplex

-- γ² = [[0,σ_y],[−σ_y,0]] — 空间/y irány (σ_y = [[0,−i],[i,0]])
public export
GammaKettőWeyl : NégyNégyMátrix
GammaKettőWeyl = NégyNégyMátrixKonstruktor
  NullaKomplex NullaKomplex NullaKomplex           MinuszImagináriusEgyKomplex
  NullaKomplex NullaKomplex ImagináriusEgyKomplex     NullaKomplex
  NullaKomplex ImagináriusEgyKomplex NullaKomplex     NullaKomplex
  MinuszImagináriusEgyKomplex NullaKomplex NullaKomplex NullaKomplex

-- γ³ = [[0,σ_z],[−σ_z,0]] — 空间/z irány (σ_z = [[1,0],[0,−1]])
public export
GammaHáromWeyl : NégyNégyMátrix
GammaHáromWeyl = NégyNégyMátrixKonstruktor
  NullaKomplex NullaKomplex  EgyKomplex   NullaKomplex
  NullaKomplex NullaKomplex  NullaKomplex MinuszEgyKomplex
  MinuszEgyKomplex NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex EgyKomplex   NullaKomplex NullaKomplex

-- γ⁵ = i·γ⁰γ¹γ²γ³ — a chirális szeletelő: diag(−1,−1,+1,+1)
public export
GammaÖtWeyl : NégyNégyMátrix
GammaÖtWeyl = skalárSzorzásMátrix ImagináriusEgyKomplex
  (mátrixSzoroz GammaNullaWeyl
    (mátrixSzoroz GammaEgyWeyl
      (mátrixSzoroz GammaKettőWeyl GammaHáromWeyl)))

-- ─── 4. A SZERVERI HIBÁS γ⁰ (kron(I₂,σₓ) — blokk-diagonális!) ──
public export
GammaNullaSzerveriHibás : NégyNégyMátrix
GammaNullaSzerveriHibás = NégyNégyMátrixKonstruktor
  NullaKomplex EgyKomplex   NullaKomplex NullaKomplex
  EgyKomplex   NullaKomplex NullaKomplex NullaKomplex
  NullaKomplex NullaKomplex NullaKomplex EgyKomplex
  NullaKomplex NullaKomplex EgyKomplex   NullaKomplex

-- ─── 5. BIZONYÍTÁSOK (Refl — a kernel számol) ─────────────

-- Clifford-relációk: {γᵘ,γᵛ} = 2ηᵘᵛ; a nullára (η off-diagonális):
-- Kimenet: Refl ({γ⁰,γ¹} = 0)
BizAntikommutátorNullaEgy :
  mátrixÖsszead (mátrixSzoroz GammaNullaWeyl GammaEgyWeyl)
                 (mátrixSzoroz GammaEgyWeyl GammaNullaWeyl) = NullaMátrix
BizAntikommutátorNullaEgy = Refl

-- Kimenet: Refl ({γ⁰,γ²} = 0)
BizAntikommutátorNullaKettő :
  mátrixÖsszead (mátrixSzoroz GammaNullaWeyl GammaKettőWeyl)
                 (mátrixSzoroz GammaKettőWeyl GammaNullaWeyl) = NullaMátrix
BizAntikommutátorNullaKettő = Refl

-- Kimenet: Refl ({γ⁰,γ³} = 0)
BizAntikommutátorNullaHárom :
  mátrixÖsszead (mátrixSzoroz GammaNullaWeyl GammaHáromWeyl)
                 (mátrixSzoroz GammaHáromWeyl GammaNullaWeyl) = NullaMátrix
BizAntikommutátorNullaHárom = Refl

-- Kimenet: Refl ({γ¹,γ²} = 0)
BizAntikommutátorEgyKettő :
  mátrixÖsszead (mátrixSzoroz GammaEgyWeyl GammaKettőWeyl)
                 (mátrixSzoroz GammaKettőWeyl GammaEgyWeyl) = NullaMátrix
BizAntikommutátorEgyKettő = Refl

-- Kimenet: Refl ({γ¹,γ³} = 0)
BizAntikommutátorEgyHárom :
  mátrixÖsszead (mátrixSzoroz GammaEgyWeyl GammaHáromWeyl)
                 (mátrixSzoroz GammaHáromWeyl GammaEgyWeyl) = NullaMátrix
BizAntikommutátorEgyHárom = Refl

-- Kimenet: Refl ({γ²,γ³} = 0)
BizAntikommutátorKettőHárom :
  mátrixÖsszead (mátrixSzoroz GammaKettőWeyl GammaHáromWeyl)
                 (mátrixSzoroz GammaHáromWeyl GammaKettőWeyl) = NullaMátrix
BizAntikommutátorKettőHárom = Refl

-- γ⁵ = diag(−1,−1,+1,+1): a TISZTA chirális szektorok
-- Kimenet: Refl (γ⁵.mező00 = −1 — a 中文/ψ_L szebbt)
BizGammaÖtBalSzektorMinuszEgy : mező00 GammaÖtWeyl = MinuszEgyKomplex
BizGammaÖtBalSzektorMinuszEgy = Refl

-- Kimenet: Refl (γ⁵.mező33 = +1 — a magyar/ψ_R szebbt)
BizGammaÖtJobbSzektorPluszEgy : mező33 GammaÖtWeyl = EgyKomplex
BizGammaÖtJobbSzektorPluszEgy = Refl

-- γ⁵² = egység (involúció)
-- Kimenet: Refl (γ⁵·γ⁵ = I)
BizGammaÖtNégyzetEgység :
  mátrixSzoroz GammaÖtWeyl GammaÖtWeyl = EgységMátrix
BizGammaÖtNégyzetEgység = Refl

-- ─── 6. A SZERVERI BOGÁR BIZONYÍTÁSA ──────────────────────
-- A keverés belépője: a mező20 (alsó-bal blokk = ψ_R → ψ_L irány).

-- Kimenet: Refl (γ⁰(Weyl).mező20 = +1 — KEVER, a fordítás LEHETSÉGES)
BizWeylGammaKeveri : mező20 GammaNullaWeyl = EgyKomplex
BizWeylGammaKeveri = Refl

-- Kimenet: Refl (γ⁰(szerveri).mező20 = 0 — SOHA nem kever: TÖRÖTT)
BizSzerveriGammaNemKeveri : mező20 GammaNullaSzerveriHibás = NullaKomplex
BizSzerveriGammaNemKeveri = Refl

-- ─── 7. FŐ — vékony IO-burkoló ────────────────────────────

public export
főJelentés : String
főJelentés =
  "═══ DIRAC GAMMA-MÁTRIXOK (Weyl-bázis, Integer-pontosan) ═══\n"
  ++ "ψ = (ψ_L = 中文/tér, ψ_R = magyar/idő) — egyidejű reprezentáció\n"
  ++ "Clifford: mind a 6 antikommutátor = 0                [6× Refl ✓]\n"
  ++ "γ⁵ = diag(−1,−1,+1,+1) — tiszta chirális szektorok  [2× Refl ✓]\n"
  ++ "γ⁵·γ⁵ = egység (involúció)                          [Refl ✓]\n"
  ++ "γ⁰(Weyl).mező20 = +1  → ψ_L ↔ ψ_R KEVERÉSE MŰKÖDIK  [Refl ✓]\n"
  ++ "γ⁰(szerveri).mező20 = 0 → a szerveri nyelv TÖRÖTT   [Refl ✓]\n"
  ++ "Numerikus párja: horgony/javaslat/dirac_gamma_ellenorzes.py\n"

main : IO ()
main = putStrLn főJelentés


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
DiracGammaLeírás : ModulLeirasT
DiracGammaLeírás = ModulLeirasKonstruktor
  "DiracGammaMatricak.idr" "Weyl γ⁰ keveri ψ_L↔ψ_R; szerveri sosem; γ⁵=diag [Refl]" "a kétnyelvű gondolkodás mechanizmusa: γ⁰ (idő/magyar) forgat" "6 teszt + 11 Refl"
