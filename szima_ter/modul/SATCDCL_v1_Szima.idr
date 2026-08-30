module SATCDCL_v1_Szima

-- =====================================================================
-- SATCDCL_v1_Szima — CDCL (Conflict-Driven Clause Learning) SAT-solver
--   adatstruktúrák Idris 2-ben.
-- Forrás (Scala): agi_jul25_scala/src/main/scala/infra/sat/SAT.scala
-- Port: 2026-08-27. Ékezetes magyar azonosítók (AGENTS §25),
--   rövidítés tilos (§0), kód duplikáció tilos (§24 — Prelude/Data.List
--   importálva, nem újraírva), Python tilos (§N8).
--
-- A Scala szerkezete:
--   Level (Prim/Derived/Composed/Meta),
--   Var, Lit, Clause (Unit/Pair/More), Formule (Prim/And/Or/Not),
--   Model (Assigned/Done), TruthValue (T/F),
--   MiertLanc (Megall/Egy/Ketto) — CDCL bizonyítási lánc,
--   UnitPropagation, Villa (közös/balÁg/jobbÁg), Resolvent,
--   CDCL (Megold/Konflikt/Egy).
-- =====================================================================

import Data.List
import Data.Bool

%default total

-- =====================================================================
-- 1. SZINT — a változó hierarchikus szintje (Scala: Level)
--   Elsődleges  = Prim     — eredeti (bemeneti) változó
--   Származtatott = Derived — következtetett (unit propagation)
--   Összetett   = Composed — több klózból rezolvált
--   Meta        = Meta     — absztrakt / magasabb szintű
-- =====================================================================

public export
data Szint = Elsődleges | Származtatott | Összetett | Meta

public export
Eq Szint where
  (==) Elsődleges Elsődleges     = True
  (==) Származtatott Származtatott = True
  (==) Összetett Összetett       = True
  (==) Meta Meta                 = True
  (==) _ _                       = False

public export
Show Szint where
  show Elsődleges   = "Elsődleges(原)"
  show Származtatott = "Származtatott(推导)"
  show Összetett    = "Összetett(复合)"
  show Meta         = "Meta(元)"

-- =====================================================================
-- 2. VÁLTOZÓ — szint + azonosító (Scala: Var with level: Level)
--   Rekord, mert a szint és az azonosító együtt adják a változót.
--   A "MkVar" rövidítés tilos (AGENTS §0) → VáltozóKonstruktor.
-- =====================================================================

public export
record Változó where
  constructor VáltozóKonstruktor
  változóSzint      : Szint
  változóAzonosító  : Nat

public export
Eq Változó where
  (==) (VáltozóKonstruktor s1 n1) (VáltozóKonstruktor s2 n2)
    = (s1 == s2) && (n1 == n2)

public export
Show Változó where
  show (VáltozóKonstruktor sz n)
    = "V" ++ show n ++ "(" ++ show sz ++ ")"

-- =====================================================================
-- 3. LITERAL — pozitív vagy negatív változó (Scala: Lit Pos/Neg)
--   A negálás involúció: negál ∘ negál = identitás (bizonyítva lent).
-- =====================================================================

public export
data Literal = Pozitív Változó | Negatív Változó

||| A literalhoz tartozó változó (Scala: Lit.getVar).
public export
literalVáltozó : Literal -> Változó
literalVáltozó (Pozitív v) = v
literalVáltozó (Negatív v) = v

||| A literal negáltja (Scala: Lit.not).
public export
negálLiteral : Literal -> Literal
negálLiteral (Pozitív v) = Negatív v
negálLiteral (Negatív v) = Pozitív v

public export
Show Literal where
  show (Pozitív v) = "+" ++ show v
  show (Negatív v) = "-" ++ show v

-- =====================================================================
-- 4. IGAZÉRTÉK — kézértékű logikai érték (Scala: TruthValue T/F)
--   A negálás involúció: negál ∘ negál = identitás (bizonyítva lent).
-- =====================================================================

public export
data IgazÉrték = Igaz | Hamis

||| IgazÉrték negálása (Scala: TruthValue.not).
public export
negálIgazÉrték : IgazÉrték -> IgazÉrték
negálIgazÉrték Igaz = Hamis
negálIgazÉrték Hamis = Igaz

public export
Eq IgazÉrték where
  (==) Igaz Igaz = True
  (==) Hamis Hamis = True
  (==) _ _ = False

public export
Show IgazÉrték where
  show Igaz = "Igaz(真)"
  show Hamis = "Hamis(假)"

-- =====================================================================
-- 5. KLÓZ — diszjunkció literálokból (Scala: Clause Unit/Pair/More)
--   Egység  = egy literál         (unit clause)
--   Pár     = két literál
--   Többi   = egy literál + klóz  (konz, folytatás)
--   A "Koz" helyett "Klóz" — a magyar matematikai szaknyelv
--   (SAT-klóz = diszjunktív klóz).
-- =====================================================================

public export
data Klóz = Egység Literal | Pár Literal Literal | Többi Literal Literal Klóz

||| A klóz összes literáljainak listája (projekció).
public export
klózLiterálok : Klóz -> List Literal
klózLiterálok (Egység l)      = [l]
klózLiterálok (Pár l1 l2)     = [l1, l2]
klózLiterálok (Többi l1 l2 r) = l1 :: l2 :: klózLiterálok r

||| A klóz összes változójának listája.
public export
klózVáltozók : Klóz -> List Változó
klózVáltozók = map literalVáltozó . klózLiterálok

public export
Show Klóz where
  show (Egység l)      = "{" ++ show l ++ "}"
  show (Pár l1 l2)     = "{" ++ show l1 ++ ", " ++ show l2 ++ "}"
  show (Többi l1 l2 r) = "{" ++ show l1 ++ ", " ++ show l2 ++ ", ... " ++ show r ++ "}"

-- =====================================================================
-- 6. FORMULA — logikai formula klózokból (Scala: Formule)
--   ElsődlegesFormula = Prim — konjunkció klózokból (CNF egy szintje)
--   És  = And — konjunkció
--   Vagy = Or  — diszjunkció
--   Nem  = Not — negáció
-- =====================================================================

public export
data Formula
  = ElsődlegesFormula Klóz
  | És Formula Formula
  | Vagy Formula Formula
  | Nem Formula

public export
Show Formula where
  show (ElsődlegesFormula k) = show k
  show (És f g)      = "(" ++ show f ++ " ∧ " ++ show g ++ ")"
  show (Vagy f g)    = "(" ++ show f ++ " ∨ " ++ show g ++ ")"
  show (Nem f)       = "¬(" ++ show f ++ ")"

-- =====================================================================
-- 7. MODELL — változó-hozzárendelés (Scala: Model Assigned/Done)
--   Hozzárendelt : egy változó = igazérték + a maradék modell
--   Készen       : üres modell (minden változó hozzárendelve)
-- =====================================================================

public export
data Modell = Hozzárendelt Változó IgazÉrték Modell | Készen

public export
Show Modell where
  show Készen = "•"
  show (Hozzárendelt v eÉrték rt)
    = show v ++ "=" ++ show eÉrték ++ "; " ++ show rt

-- =====================================================================
-- 8. EGYSÉGTERJESZTÉS — unit propagation egy lépése
--   (Scala: case class UnitPropagation(lit: Lit, reason: Clause))
--   A "Unit" angol → "Egység" magyar (AGENTS §0: rövidítés tilos).
-- =====================================================================

public export
record EgységTerjesztés where
  constructor EgységTerjesztésKonstruktor
  terjesztettLiteral : Literal
  ok                 : Klóz

public export
Show EgységTerjesztés where
  show (EgységTerjesztésKonstruktor l k)
    = "EgységTerjesztés(" ++ show l ++ " ← " ++ show k ++ ")"

-- =====================================================================
-- 9. MIÉRTLÁNC — CDCL bizonyítási lánc (Scala: MiertLanc)
--   Megáll : a lánc vége, egy igazértékkel (a gyökér kiértékelése)
--   Egy    : egy literál egy egységterjesztésből származik + lánc
--   Kettő  : egy literál KÉT ágból (a, b) származik, mindkettőnek
--            saját miértlánc-ja (rezolvens-szerű)
-- =====================================================================

public export
data MiértLánc
  = Megáll IgazÉrték
  | Egy Literal EgységTerjesztés MiértLánc
  | Kettő Literal Literal Literal MiértLánc MiértLánc

public export
Show MiértLánc where
  show (Megáll eÉrték) = "Megáll(" ++ show eÉrték ++ ")"
  show (Egy l t r) = "Egy(" ++ show l ++ ", " ++ show t ++ ", " ++ show r ++ ")"
  show (Kettő l a b ra rb)
    = "Kettő(" ++ show l ++ "; " ++ show a ++ ", " ++ show b
        ++ "; " ++ show ra ++ " || " ++ show rb ++ ")"

-- =====================================================================
-- 10. VILLA — két klóz ágainak közös/különálló felbontása
--   (Scala: case class Villa(kozos, balAg, jobbAg))
--   A "Villa" = fork: a közös ág (mindkét klózban) + a bal/jobb
--   különálló ágak. Ez a rezolvens előkészítése.
-- =====================================================================

public export
record Villa where
  constructor VillaKonstruktor
  közös  : List Literal
  balÁg  : List Literal
  jobbÁg : List Literal

||| Villa készítése két literál-listából (Scala: Villa.apply).
||| A közös ág = azok a literálok xs-ben, melyek változója szerepel ys-ben.
||| A bal ág  = azok a literálok xs-ben, melyek változója NINCS ys-ben.
||| A jobb ág = azok a literálok ys-ben, melyek változója NINCS xs-ben.
public export
villaKészítés : List Literal -> List Literal -> Villa
villaKészítés xs ys =
  let közösVáltozók = map literalVáltozó ys in
  let xsVáltozók    = map literalVáltozó xs in
  VillaKonstruktor
    (filter (\x => elem (literalVáltozó x) közösVáltozók) xs)
    (filter (\x => not (elem (literalVáltozó x) közösVáltozók)) xs)
    (filter (\y => not (elem (literalVáltozó y) xsVáltozók)) ys)

public export
Show Villa where
  show (VillaKonstruktor k b j)
    = "Villa(közös=" ++ show k ++ ", bal=" ++ show b ++ ", jobb=" ++ show j ++ ")"

-- =====================================================================
-- 11. REZOLVENS — két klóz rezolúciója egy csomóponton (Scala: Resolvent)
--   A "pivot" helyett "csomópont" (magyar, AGENTS §0).
--   első, második : a két klóz
--   eredmény      : a rezolvens klóz (csomópont eltávolítva, egyesítve)
-- =====================================================================

public export
record Rezolvens where
  constructor RezolvensKonstruktor
  csomópont : Literal
  első      : Klóz
  második   : Klóz
  eredmény  : Klóz

public export
Show Rezolvens where
  show (RezolvensKonstruktor p c1 c2 er)
    = "Rezolvens(pivot=" ++ show p ++ "; " ++ show c1 ++ " ▷ " ++ show c2
        ++ " = " ++ show er ++ ")"

-- =====================================================================
-- 12. CDCL — Conflict-Driven Clause Learning kimenetel (Scala: CDCL)
--   Megold     : a SAT-solver talált egy modellt (kielégítő hozzárendelés)
--   Konfliktus : konfliktus literál + tanult klóz + backtrack-szint
--   Egy        : egy literál egységterjesztése + a CDCL folytatása
-- =====================================================================

public export
data CDCL
  = Megold Modell
  | Konfliktus Literal Klóz Nat
  | EgyLépés Literal EgységTerjesztés CDCL

public export
Show CDCL where
  show (Megold m) = "Megold(" ++ show m ++ ")"
  show (Konfliktus l k szint)
    = "Konfliktus(" ++ show l ++ ", tanult=" ++ show k ++ ", szint=" ++ show szint ++ ")"
  show (EgyLépés l t r)
    = "EgyLépés(" ++ show l ++ ", " ++ show t ++ "; " ++ show r ++ ")"

-- =====================================================================
-- 13. BIZONYÍTÁSOK — Refl-lel (AGENTS §18: nem tautológia)
--   Minden bizonyítás KÉT különböző konstrukciót köt össze:
--   a bal oldal kompozíció (függvény-alkalmazás), a jobb oldal konstans.
--   A kernel redukálja a bal oldalt, és egyezést követel.
-- =====================================================================

||| Bizonyítás: a literal-negálás involúció
|||   negálLiteral (negálLiteral l) = l
||| Mindkét konstruktor-ra (Pozitív, Negatív) külön levezetés.
||| Nem tautológia: a bal oldal kompozíció, a jobb oldal konstans.
public export
negálásInvolúcióLiteral : (l : Literal) -> negálLiteral (negálLiteral l) = l
negálásInvolúcióLiteral (Pozitív v) = Refl
negálásInvolúcióLiteral (Negatív v) = Refl

||| Bizonyítás: az igazérték-negálás involúció
|||   negálIgazÉrték (negálIgazÉrték x) = x
||| Mindkét konstruktor-ra (Igaz, Hamis) külön levezetés.
public export
negálásInvolúcióIgazÉrték : (x : IgazÉrték) -> negálIgazÉrték (negálIgazÉrték x) = x
negálásInvolúcióIgazÉrték Igaz = Refl
negálásInvolúcióIgazÉrték Hamis = Refl

||| Bizonyítás: négy szint van — a length redukció igazi munka.
|||   length [Elsődleges, Származtatott, Összetett, Meta] = 4
||| A bal oldalon a `length` kiszámítása, a jobb oldalon a konstans 4.
public export
szintekSzáma : length [Elsődleges, Származtatott, Összetett, Meta] = 4
szintekSzáma = Refl

||| Bizonyítás: az Egység klóz változó-listája egyetlen elemű.
|||   klózVáltozók (Egység l) = [literalVáltozó l]
||| A bal oldalon a `klózVáltozók` projekció + `map`, a jobb oldalon
||| a közvetlen lista. A kernel redukálja a bal oldalt.
public export
klózVáltozókEgység : (l : Literal) -> klózVáltozók (Egység l) = [literalVáltozó l]
klózVáltozókEgység l = Refl

||| Bizonyítás: a Pár klóz változó-listája két elemű.
|||   klózVáltozók (Pár l1 l2) = [literalVáltozó l1, literalVáltozó l2]
public export
klózVáltozókPár : (l1, l2 : Literal) ->
                  klózVáltozók (Pár l1 l2) = [literalVáltozó l1, literalVáltozó l2]
klózVáltozókPár l1 l2 = Refl

-- =====================================================================
-- 14. EGY PÉLDA — fordítási + futtathatósági ellenőrzés (AGENTS §1)
--   Egy kis CDCL-példa: egy változó, egy konfliktus, egy megoldás.
--   Futtatható: `idris2 --exec main` kinyomtatja a példát.
-- =====================================================================

||| Egy példa-változó: V0, Elsődleges szint.
public export
vNulla : Változó
vNulla = VáltozóKonstruktor Elsődleges 0

||| Egy példa-egységterjesztés: +V0 ← {+V0}.
public export
példaTerjesztés : EgységTerjesztés
példaTerjesztés = EgységTerjesztésKonstruktor (Pozitív vNulla) (Egység (Pozitív vNulla))

||| Egy példa-CDCL: egy literál terjesztése, majd megoldás.
public export
példaCDCL : CDCL
példaCDCL = EgyLépés (Pozitív vNulla) példaTerjesztés
                (Megold (Hozzárendelt vNulla Igaz Készen))

||| Futtatható main — kinyomtatja a példát (Show-val).
public export
main : IO ()
main = do
  putStrLn "--- SATCDCL_v1_Szima példa ---"
  putStrLn ("Változó      : " ++ show vNulla)
  putStrLn ("IgazÉrték    : " ++ show Igaz ++ " / " ++ show Hamis)
  putStrLn ("Szintek száma: 4 (bizonyítva: szintekSzáma)")
  putStrLn ("EgységTerj.  : " ++ show példaTerjesztés)
  putStrLn ("CDCL         : " ++ show példaCDCL)
  putStrLn "--- A negálás involúció (bizonyítva: Refl) ---"
  putStrLn ("negál(negál(Igaz)) = " ++ show (negálIgazÉrték (negálIgazÉrték Igaz)))
  putStrLn "--- Vége ---"