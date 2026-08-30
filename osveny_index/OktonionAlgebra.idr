module OktonionAlgebra

import ModulRegisztracio
-- ═══════════════════════════════════════════════════════════════
-- OKTONION SZORZATTÁBLA — a Cayley-féle Fano-irányból, Refl-lel
-- ═══════════════════════════════════════════════════════════════
-- TANULSÁG (AGENTS.md 3): ezt Pythonban háromszor elrontottam
-- (előjel, szorzási sorrend, törvény-átírás). Itt a KERREL számol,
-- és a három alternativitási törvényt MIND a 49 egységpárra
-- EGYETLEN Refl bizonyítja — nem lehet elrontani.
--
-- A SZABÁLYOS (Cayley) IRÁNYOK:
--   (e1,e2,e4), (e2,e3,e5), (e3,e4,e6), (e4,e5,e7),
--   (e5,e6,e1), (e6,e7,e2), (e7,e1,e3)
-- Egy (a,b,c) hármas jelentése: a·b = c, b·c = a, c·a = b
-- (ciklikusan); a fordított sorrend előjelet vált.
--
-- BIZONYÍTÁSOK:
--   BizCayleyFanoSik        : minden pár PONTOSAN EGY vonalon
--   BizCayleyTablaAlternativ: mind a 49 párra mindhárom törvény
--     (bal: eₐ(eₐe_b) = −e_b; jobb: (e_b eₐ)eₐ = −e_b;
--      hajlékonyság: e_b(eₐe_b) = (e_b eₐ)e_b)
--   BizNemAsszociativ       : (e₁e₂)e₃ = −e₆  de  e₁(e₂e₃) = +e₆
--
-- KAPCSOLAT: a ±(1, e₁..e₇) a 16 csúcs az oktonion egységek közül
-- (E8Gyokrendszer.idr: 16+224 = 240 = az E8 gyökök);
-- a Fano-sík geometriáját a FanoParitás.idr bizonyítja a saját
-- vonalainkra (XOR-nulla) — két út, egy sík.
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. A HÉT KÉPZETES EGYSÉG ──────────────────────────────
-- e₁..e₇ standard matematikai jelölés (az E8 kivétel-szabályhoz
-- hasonlóan), grafikusan: e₁ = „i" a nyolcas első képzetes eleme.

public export
data HetesGyok = E1 | E2 | E3 | E4 | E5 | E6 | E7

public export
Eq HetesGyok where
  E1 == E1 = True
  E2 == E2 = True
  E3 == E3 = True
  E4 == E4 = True
  E5 == E5 = True
  E6 == E6 = True
  E7 == E7 = True
  _  == _  = False

public export
Show HetesGyok where
  show E1 = "e1"; show E2 = "e2"; show E3 = "e3"; show E4 = "e4"
  show E5 = "e5"; show E6 = "e6"; show E7 = "e7"

-- ─── 2. ELŐJELES EREDMÉNY (±1, ±eₖ) ───────────────────────

public export
data ElojelesGyok =
    ValosPluszEgy
  | ValosMinuszEgy
  | PozitivGyok HetesGyok
  | NegativGyok HetesGyok

public export
Eq ElojelesGyok where
  ValosPluszEgy  == ValosPluszEgy  = True
  ValosMinuszEgy == ValosMinuszEgy = True
  PozitivGyok a  == PozitivGyok b  = a == b
  NegativGyok a  == NegativGyok b  = a == b
  _              == _              = False

public export
Show ElojelesGyok where
  show ValosPluszEgy    = "+1"
  show ValosMinuszEgy   = "-1"
  show (PozitivGyok g)  = "+" ++ show g
  show (NegativGyok g)  = "-" ++ show g

public export
elojelesFordit : ElojelesGyok -> ElojelesGyok
elojelesFordit ValosPluszEgy    = ValosMinuszEgy
elojelesFordit ValosMinuszEgy   = ValosPluszEgy
elojelesFordit (PozitivGyok g)  = NegativGyok g
elojelesFordit (NegativGyok g)  = PozitivGyok g

-- ─── 3. A CAYLEY-IRÁNYOK (Fano-vonalak ciklikus tájolással) ──

public export
cayleyHarmasok : List (HetesGyok, HetesGyok, HetesGyok)
cayleyHarmasok =
  [ (E1, E2, E4), (E2, E3, E5), (E3, E4, E6), (E4, E5, E7)
  , (E5, E6, E1), (E6, E7, E2), (E7, E1, E3) ]

-- a (3-elemű) vonal tartalmazza-e mindkét gyököt:
public export
vonalTartalmazza : HetesGyok -> HetesGyok ->
                   (HetesGyok, HetesGyok, HetesGyok) -> Bool
vonalTartalmazza elso masodik (a, b, c) =
  ((a == elso)    || (b == elso)    || (c == elso)) &&
  ((a == masodik) || (b == masodik) || (c == masodik))

-- a harmadik elem: amelyik a pártól különbözik:
public export
harmadikTag : HetesGyok -> HetesGyok ->
              (HetesGyok, HetesGyok, HetesGyok) -> HetesGyok
harmadikTag elso masodik (a, b, c) =
  if (a /= elso) && (a /= masodik) then a else
  if (b /= elso) && (b /= masodik) then b else c

-- a (i,j) sorrend egyezik-e a vonal ciklikus irányával:
public export
iranyEgyezik : HetesGyok -> HetesGyok ->
               (HetesGyok, HetesGyok, HetesGyok) -> Bool
iranyEgyezik elso masodik (a, b, c) =
  ((elso == a) && (masodik == b)) ||
  ((elso == b) && (masodik == c)) ||
  ((elso == c) && (masodik == a))

-- ─── 4. A SZORZATTÁBLA ─────────────────────────────────────
-- eᵢ·eᵢ = −1; eᵢ·eⱼ = ±eₖ aszerint, hogy a vonalon ciklikusan
-- vagy ellentétesen követik egymást. Minden különböző pár
-- pontosan egy vonalon van (BizCayleyFanoSik!), így a keresés
-- sosem üres.

public export
egysegSzorzatTabla : HetesGyok -> HetesGyok -> ElojelesGyok
egysegSzorzatTabla elso masodik =
  if elso == masodik then ValosMinuszEgy else
  case [ vonal | vonal <- cayleyHarmasok, vonalTartalmazza elso masodik vonal ] of
    (vonal :: _) =>
      if iranyEgyezik elso masodik vonal
        then PozitivGyok (harmadikTag elso masodik vonal)
        else NegativGyok (harmadikTag elso masodik vonal)
    [] => ValosPluszEgy

-- ─── 5. BAL/JOBB SZORZÁS ELŐJELES EREDMÉNNYEL ──────────────

public export
gyokSzorozElojeles : HetesGyok -> ElojelesGyok -> ElojelesGyok
gyokSzorozElojeles gyok ValosPluszEgy    = PozitivGyok gyok
gyokSzorozElojeles gyok ValosMinuszEgy   = NegativGyok gyok
gyokSzorozElojeles gyok (PozitivGyok g)  = egysegSzorzatTabla gyok g
gyokSzorozElojeles gyok (NegativGyok g)  =
  elojelesFordit (egysegSzorzatTabla gyok g)

public export
elojelesSzorozGyok : ElojelesGyok -> HetesGyok -> ElojelesGyok
elojelesSzorozGyok ValosPluszEgy    gyok = PozitivGyok gyok
elojelesSzorozGyok ValosMinuszEgy   gyok = NegativGyok gyok
elojelesSzorozGyok (PozitivGyok g)  gyok = egysegSzorzatTabla g gyok
elojelesSzorozGyok (NegativGyok g)  gyok =
  elojelesFordit (egysegSzorzatTabla g gyok)

-- ─── 6. A HÁROM ALTERNATIVITÁSI TÖRVÉNY ────────────────────
-- bal alternativitás:  eₐ·(eₐ·e_b)  = (eₐ·eₐ)·e_b  = −e_b
-- jobb alternativitás: (e_b·eₐ)·eₐ  = e_b·(eₐ·eₐ)  = −e_b
-- hajlékonyság:        e_b·(eₐ·e_b) = (e_b·eₐ)·e_b
-- (a hajlékonyság mindkét oldalán e_b-vel szorzunk — a ma délutáni
--  pythonos hiba éppen ez a sorrend volt!)

public export
mindGyokLista : List HetesGyok
mindGyokLista = [E1, E2, E3, E4, E5, E6, E7]

public export
parTorvenyei : HetesGyok -> HetesGyok -> Bool
parTorvenyei balParna jobbParna =
  (gyokSzorozElojeles balParna (egysegSzorzatTabla balParna jobbParna)
     == NegativGyok jobbParna)
  && (elojelesSzorozGyok (egysegSzorzatTabla jobbParna balParna) balParna
     == NegativGyok jobbParna)
  && (gyokSzorozElojeles jobbParna (egysegSzorzatTabla balParna jobbParna)
     == elojelesSzorozGyok (egysegSzorzatTabla jobbParna balParna) jobbParna)

public export
MindParErvenyes : Bool
MindParErvenyes =
  all (\balParna => all (\jobbParna => parTorvenyei balParna jobbParna)
                        mindGyokLista)
      mindGyokLista

-- A NAGY BIZONYÍTÁS: a kernel mind a 49 párra kiszámolja mindhárom
-- törvényt — és egyetlen Refl-lel kényszerül az True-ra.
-- Kimenet: Refl (True = True ✓) — A TÁBLA ALTERNATÍV OKTONION-ALGEBRA
BizCayleyTablaAlternativ : MindParErvenyes = True
BizCayleyTablaAlternativ = Refl

-- ─── 7. A FANO-SÍK TULAJDONSÁG ─────────────────────────────
-- minden különböző pár PONTOSAN EGY vonalon van:
public export
hanyVonalonVan : HetesGyok -> HetesGyok -> Nat
hanyVonalonVan elso masodik =
  length [ () | vonal <- cayleyHarmasok, vonalTartalmazza elso masodik vonal ]

public export
MindParPontosanEgyVonalon : Bool
MindParPontosanEgyVonalon =
  all (\i => all (\j => if i == j then True else hanyVonalonVan i j == 1)
                 mindGyokLista)
      mindGyokLista

-- Kimenet: Refl (True = True ✓) — a Cayley-vonalak Fano-síkot alkotnak
BizCayleyFanoSik : MindParPontosanEgyVonalon = True
BizCayleyFanoSik = Refl

-- ─── 8. NEM-ASSZOCIATIVITÁS (konkrét cáfolat) ──────────────
-- (e₁·e₂)·e₃ = e₄·e₃ = −e₆   de   e₁·(e₂·e₃) = e₁·e₅ = +e₆

-- Kimenet: Refl (−e₆ = −e₆ ✓)
BizNemAsszociativBal :
  elojelesSzorozGyok (egysegSzorzatTabla E1 E2) E3 = NegativGyok E6
BizNemAsszociativBal = Refl

-- Kimenet: Refl (+e₆ = +e₆ ✓)
BizNemAsszociativJobb :
  gyokSzorozElojeles E1 (egysegSzorzatTabla E2 E3) = PozitivGyok E6
BizNemAsszociativJobb = Refl

public export
NemAsszociativEgyeznek : Bool
NemAsszociativEgyeznek =
  elojelesSzorozGyok (egysegSzorzatTabla E1 E2) E3
  == gyokSzorozElojeles E1 (egysegSzorzatTabla E2 E3)

-- Kimenet: Refl (False = False ✓) — a kettő NEM egyezik: nem-asszociatív
BizNemAsszociativ : NemAsszociativEgyeznek = False
BizNemAsszociativ = Refl

-- ─── 9. KIS TÁBLA-KIMUTATÁS (a fő-jelentéshez) ─────────────

public export
tablapeldak : String
tablapeldak =
  concatMap (\(i, j) =>
    "  e" ++ dropOne (show i) ++ "·e" ++ dropOne (show j) ++ " = "
    ++ show (egysegSzorzatTabla i j) ++ "\n")
    [ (E1, E2), (E2, E1), (E2, E3), (E3, E2), (E1, E5), (E5, E1) ]
  where
    dropOne : String -> String
    dropOne s = if length s > 1 then substr 1 (length s) s else s

-- ─── 10. FŐ — vékony IO-burkoló ────────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ OKTONION SZORZATTÁBLA (Cayley-irányok, kernel-ellenőrizve) ═══\n"
  ++ tablapeldak
  ++ "eᵢ·eᵢ = −1; a 49 pár × 3 törvény: ALTERNATÍV [Refl ✓]\n"
  ++ "Fano-sík: minden pár pontosan egy vonalon        [Refl ✓]\n"
  ++ "NEM asszociatív: (e₁e₂)e₃ = −e₆ ≠ e₁(e₂e₃) = +e₆ [Refl ✓]\n"
  ++ "Kapcsolat: ±(1,e₁..e₇) = 16 csúcs → 16+224 = 240 E8-gyök\n"

main : IO ()
main = putStrLn foJelentes


-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
OktonionLeiras : ModulLeirasT
OktonionLeiras = ModulLeirasKonstruktor
  "OktonionAlgebra.idr" "49 pár × 3 törvény EGY Refl-lel; Fano-sík [Refl]; nem-asszoc. [Refl]" "a mondat = nem assz. szorzat (a csoportosítás változtatja a jelentést)" "8 teszt + 3 Refl"
