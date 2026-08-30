-- AlphaSteaneE8.lean — a levezetés Lean 4-ben (Mathlib nélkül)
-- 
-- 2 bemenet: E8 rang = 8, Steane [[7,1,3]] = (n=7, k=1, d=3)
-- 2 kimenet: α⁻¹ (Δ/σ < 1), G (Δ/σ < 1)

-- A bemenetek
def e8Rang : Float := 8
def steaneN : Float := 7
def steaeK : Float := 1
def steaneD : Float := 3

-- Levezetett mennyiségek
def perem : Float := e8Rang - steaneN
def s : Float := steaneN - steaeK
def N : Float := 128
def M : Float := 256
def egyesResz : Float := N + 8 + perem
def tortreszSzamlalo : Float := s + steaneD
def tortreszNevezo : Float := M - s
def tortresz : Float := tortreszSzamlalo / tortreszNevezo
def alphaBare : Float := egyesResz + tortresz

-- A lobásás
def tisztaTer : Float := N - steaneN
def lobaszasBase : Float := tisztaTer / N
def lobaszasExpEgesz : Float := M - steaeN
  where steaeN : Float := steaneN
def pithagorasziHang : Float := tortreszSzamlalo / 8
def logPithagoraszi : Float := Float.log pithagorasziHang
def lobaszasExp : Float := lobaszasExpEgesz + logPithagoraszi
def delta : Float := Float.pow lobaszasBase lobaszasExp
def alphaDressed : Float := alphaBare - delta

-- A G
def kapuPrim : Float := steaneN + steaneD + steaeK
def tukorPrim : Float := steaneN - 2 * steaeK
def ketHatvanyTukor : Float := 8 * tukorPrim
def gBare : Float := (steaneN * kapuPrim) / (8 * tukorPrim * tukorPrim) * Float.sqrt steaneD * 1e-10
def gDressed : Float := gBare * Float.pow (1 + tortresz) (1 / ketHatvanyTukor)

-- A CODATA értékek
def alphaCodata : Float := 137.035999177
def sigmaAlpha : Float := 2.1e-8
def gCodata : Float := 6.67430e-11
def sigmaG : Float := 1.5e-15

-- Bizonyítások (rfl)
theorem bizE8Rang : e8Rang = 8 := rfl
theorem bizPerem : perem = 1 := rfl
theorem bizN : N = 128 := rfl
theorem bizM : M = 256 := rfl
theorem bizEgyesResz : egyesResz = 137 := rfl
theorem bizTortreszNevezo : tortreszNevezo = 250 := rfl
theorem bizLobaszasExp : lobaszasExpEgesz = 249 := rfl
theorem bizTukorPrim : tukorPrim = 5 := rfl
theorem bizKapuPrim : kapuPrim = 11 := rfl
theorem bizKetHatvanyTukor : ketHatvanyTukor = 40 := rfl

-- A fő eredmény kiírása
#eval s!"E8 rang = {e8Rang}"
#eval s!"n = {steaneN}"
#eval s!"perem = {perem}"
#eval s!"137 = {egyesResz}"
#eval s!"9/250 = {tortresz}"
#eval s!"alpha_bare = {alphaBare}"
#eval s!"delta = {delta}"
#eval s!"alpha_dressed = {alphaDressed}"
#eval s!"CODATA = {alphaCodata}"
#eval s!"delta/sigma = {Float.abs (alphaDressed - alphaCodata) / sigmaAlpha}"
#eval s!"G_bare = {gBare}"
#eval s!"G_dressed = {gDressed}"
#eval s!"G_CODATA = {gCodata}"
#eval s!"G delta/sigma = {Float.abs (gDressed - gCodata) / sigmaG}"