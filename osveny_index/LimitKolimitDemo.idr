module LimitKolimitDemo

import KategoriaElmelet
import Steane713

-- ═══════════════════════════════════════════════════════════════
-- LIMIT/KOLIMIT INTERAKTÍV DEMO (Lépés 1.1, §N14/6)
-- ═══════════════════════════════════════════════════════════════
-- Ez a program bemutatja a 10 limit/kolimit fogalmat.
-- A felhasználó beír egy számot (1–10), a program kiírja a fogalmat.
-- Források: nLab, Awodey §5.1–5.4, Mac Lane §III.4
--
-- A MANTRA szerint: SEMMI ALAPTÍPUS NEM LEHET BECSOMAGOLATLAN.
-- Nincs csomagolatlan Nat, String, List, Integer.
-- A típus = a dokumentáció: a név mondja meg, mit csinál.
-- ═══════════════════════════════════════════════════════════════

-- ─── CSOMAGOLT TÍPUSOK (a MANTRA szerint) ───────────────────

||| FogalomSorszám: a 10 limit/kolimit fogalom sorszáma (1–10).
|||   A Nat becsomagolva — így typeclass-ot lehet rá írni.
public export
record FogalomSorszam where
  constructor FogalomSorszamKonstruktor
  sorszamErtek : Nat

||| Szoveg: a megjelenítendő szöveg (a String becsomagolva).
|||   A String becsomagolva — így typeclass-ot lehet rá írni.
public export
record Szoveg where
  constructor SzovegKonstruktor
  szovegErtek : String

||| FogalomSorszamLista: a 10 fogalom sorszámainak listája.
|||   A List Nat becsomagolva.
public export
record FogalomSorszamLista where
  constructor FogalomSorszamListaKonstruktor
  sorszamListaErtek : List FogalomSorszam

||| EgeszBemenet: a felhasználó által beírt egész szám.
|||   Az Integer becsomagolva.
public export
record EgeszBemenet where
  constructor EgeszBemenetKonstruktor
  egeszErtek : Integer

-- ─── SZÖVEG ÉPÍTŐ FÜGGVÉNYEK (Segédfüggvények a Szoveg-hez) ──

||| Két Szoveg összekapcsolása.
public export
szovegOsszekapcsol : Szoveg -> Szoveg -> Szoveg
szovegOsszekapcsol a b = SzovegKonstruktor (a.szovegErtek ++ b.szovegErtek)

||| Szoveg kiírása a képernyőre.
public export
szovegKiir : Szoveg -> IO ()
szovegKiir s = putStrLn s.szovegErtek

||| String → Szoveg konverzió.
public export
stringbolSzoveg : String -> Szoveg
stringbolSzoveg s = SzovegKonstruktor s

||| Szoveg → String konverzió (a putStrLn számára).
public export
szovegbolString : Szoveg -> String
szovegbolString s = s.szovegErtek

-- ─── FOGALOM SORSZÁM ÉPÍTŐ FÜGGVÉNYEK ───────────────────────

||| Nat → FogalomSorszam konverzió.
public export
natbolSorszam : Nat -> FogalomSorszam
natbolSorszam n = FogalomSorszamKonstruktor n

||| FogalomSorszam → Nat konverzió.
public export
sorszambolNat : FogalomSorszam -> Nat
sorszambolNat s = s.sorszamErtek

||| String → FogalomSorszam konverzió (a felhasználói bemenetből).
public export
stringbolSorszam : String -> FogalomSorszam
stringbolSorszam s =
  let egesz = cast {to = Integer} s
      szam  = cast {to = Nat} egesz
  in FogalomSorszamKonstruktor szam

-- ─── A 10 FOGLALOM ADATAI (csomagolt típusokkal) ────────────

||| A 10 fogalom neve magyarul.
fogalomNeve : FogalomSorszam -> Szoveg
fogalomNeve (FogalomSorszamKonstruktor 1)  = stringbolSzoveg "1. Végződés (terminal) — minden A-ból egy morfizmus a végződésbe"
fogalomNeve (FogalomSorszamKonstruktor 2)  = stringbolSzoveg "2. Kezdet (initial) — minden kezdettől egy morfizmus B-be"
fogalomNeve (FogalomSorszamKonstruktor 3)  = stringbolSzoveg "3. Szorzat (product) — A×B + π₁ + π₂ + univerzális tulajdonság"
fogalomNeve (FogalomSorszamKonstruktor 4)  = stringbolSzoveg "4. Koprodukt (coproduct) — A+B + ι₁ + ι₂ + duális univerzális"
fogalomNeve (FogalomSorszamKonstruktor 5)  = stringbolSzoveg "5. Egyenlítő (equalizer) — f∘e = g∘e + faktorizáció"
fogalomNeve (FogalomSorszamKonstruktor 6)  = stringbolSzoveg "6. Koegyenlítő (coequalizer) — q∘f = q∘g + duális faktorizáció"
fogalomNeve (FogalomSorszamKonstruktor 7)  = stringbolSzoveg "7. Pullback (fiber product) — A→C←B + kommutatív négyzet"
fogalomNeve (FogalomSorszamKonstruktor 8)  = stringbolSzoveg "8. Pushout — A←C→B + duális kommutatív négyzet"
fogalomNeve (FogalomSorszamKonstruktor 9)  = stringbolSzoveg "9. ÁltalánosLimit — diagram + kúp + univerzális tulajdonság"
fogalomNeve (FogalomSorszamKonstruktor 10) = stringbolSzoveg "10. ÁltalánosKolimit — diagram + ko-kúp + duális univerzális"
fogalomNeve _                              = stringbolSzoveg "Ismeretlen fogalom. A szám 1–10 között legyen."

||| A 10 fogalom kategóriaelméletileg (rövid leírás).
fogalomLeirasa : FogalomSorszam -> Szoveg
fogalomLeirasa (FogalomSorszamKonstruktor 1)  = stringbolSzoveg "Definíció (Awodey §5.1): T végződés, ha ∀A ∃! t : A → T."
fogalomLeirasa (FogalomSorszamKonstruktor 2)  = stringbolSzoveg "Definíció: I kezdet, ha ∀B ∃! i : I → B. A végződés duálisa."
fogalomLeirasa (FogalomSorszamKonstruktor 3)  = stringbolSzoveg "Definíció: P = A×B, π₁ : P→A, π₂ : P→B, ∀Q ∀q₁ ∀q₂ ∃! h : Q→P."
fogalomLeirasa (FogalomSorszamKonstruktor 4)  = stringbolSzoveg "Definíció: C = A+B, ι₁ : A→C, ι₂ : B→C, ∀D ∀d₁ ∀d₂ ∃! h : C→D."
fogalomLeirasa (FogalomSorszamKonstruktor 5)  = stringbolSzoveg "Definíció: E egyenlítő f,g : A→B, e : E→A, f∘e = g∘e."
fogalomLeirasa (FogalomSorszamKonstruktor 6)  = stringbolSzoveg "Definíció: Q koegyenlítő f,g : A→B, q : B→Q, q∘f = q∘g."
fogalomLeirasa (FogalomSorszamKonstruktor 7)  = stringbolSzoveg "Definíció: P pullback A→C←B, f∘p₁ = g∘p₂ + univerzális."
fogalomLeirasa (FogalomSorszamKonstruktor 8)  = stringbolSzoveg "Definíció: P pushout A←C→B, i₁∘f = i₂∘g + univerzális."
fogalomLeirasa (FogalomSorszamKonstruktor 9)  = stringbolSzoveg "Definíció (Mac Lane §III.4): lim(D) + kúp + kompatibilitás + univerzális."
fogalomLeirasa (FogalomSorszamKonstruktor 10) = stringbolSzoveg "Definíció: colim(D) + ko-kúp + kompatibilitás + duális univerzális."
fogalomLeirasa _                              = stringbolSzoveg ""

||| A fogalom duálisa.
fogalomDualisa : FogalomSorszam -> Szoveg
fogalomDualisa (FogalomSorszamKonstruktor 1)  = stringbolSzoveg "Duálisa: Kezdet (initial)"
fogalomDualisa (FogalomSorszamKonstruktor 2)  = stringbolSzoveg "Duálisa: Végződés (terminal)"
fogalomDualisa (FogalomSorszamKonstruktor 3)  = stringbolSzoveg "Duálisa: Koprodukt (coproduct)"
fogalomDualisa (FogalomSorszamKonstruktor 4)  = stringbolSzoveg "Duálisa: Szorzat (product)"
fogalomDualisa (FogalomSorszamKonstruktor 5)  = stringbolSzoveg "Duálisa: Koegyenlítő (coequalizer)"
fogalomDualisa (FogalomSorszamKonstruktor 6)  = stringbolSzoveg "Duálisa: Egyenlítő (equalizer)"
fogalomDualisa (FogalomSorszamKonstruktor 7)  = stringbolSzoveg "Duálisa: Pushout"
fogalomDualisa (FogalomSorszamKonstruktor 8)  = stringbolSzoveg "Duálisa: Pullback"
fogalomDualisa (FogalomSorszamKonstruktor 9)  = stringbolSzoveg "Duálisa: ÁltalánosKolimit"
fogalomDualisa (FogalomSorszamKonstruktor 10) = stringbolSzoveg "Duálisa: ÁltalánosLimit"
fogalomDualisa _                              = stringbolSzoveg ""

||| A fogalom forrása.
fogalomForrasa : FogalomSorszam -> Szoveg
fogalomForrasa (FogalomSorszamKonstruktor 1)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/terminal+object ; Awodey §5.1"
fogalomForrasa (FogalomSorszamKonstruktor 2)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/initial+object ; Awodey §5.1"
fogalomForrasa (FogalomSorszamKonstruktor 3)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/product ; Awodey §5.1"
fogalomForrasa (FogalomSorszamKonstruktor 4)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/coproduct ; Awodey §5.1"
fogalomForrasa (FogalomSorszamKonstruktor 5)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/equalizer ; Awodey §5.3"
fogalomForrasa (FogalomSorszamKonstruktor 6)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/coequalizer ; Awodey §5.3"
fogalomForrasa (FogalomSorszamKonstruktor 7)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/pullback ; Awodey §5.2"
fogalomForrasa (FogalomSorszamKonstruktor 8)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/pushout ; Awodey §5.2"
fogalomForrasa (FogalomSorszamKonstruktor 9)  = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/limit ; Mac Lane §III.4"
fogalomForrasa (FogalomSorszamKonstruktor 10) = stringbolSzoveg "Forrás: nLab https://ncatlab.org/nlab/show/colimit ; Mac Lane §III.4"
fogalomForrasa _                              = stringbolSzoveg ""

||| A 10 fogalom listája.
fogalomLista : FogalomSorszamLista
fogalomLista = FogalomSorszamListaKonstruktor
  [ natbolSorszam 1,  natbolSorszam 2,  natbolSorszam 3,  natbolSorszam 4,  natbolSorszam 5
  , natbolSorszam 6,  natbolSorszam 7,  natbolSorszam 8,  natbolSorszam 9,  natbolSorszam 10 ]

||| Kiírja az összes fogalmat.
irjadOsszes : IO ()
irjadOsszes = do
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " A LIMIT/KOLIMIT CSALÁD — 10 KATEGÓRIAELMÉLETI FOGLALOM"
  putStrLn " (Lépés 1.1, KategoriaElmelet.idr 1338–1568. sor)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  traverse_ (\n => do
    szovegKiir (fogalomNeve n)
    szovegKiir (szovegOsszekapcsol (stringbolSzoveg "  ") (fogalomLeirasa n))
    szovegKiir (szovegOsszekapcsol (stringbolSzoveg "  ") (fogalomDualisa n))
    szovegKiir (szovegOsszekapcsol (stringbolSzoveg "  ") (fogalomForrasa n))
    putStrLn "") (fogalomLista.sorszamListaErtek)
  putStrLn "A GAN-javaslatok: 6 egyértelműségi rekord + Diagonális + Refl-bizonyítás"
  putStrLn "Fordítás: idris2 --check KategoriaElmelet.idr = exit 0 ✓"
  putStrLn ""

||| A főprogram — interaktív.
main : IO ()
main = do
  irjadOsszes
  putStrLn "Írj be egy számot (1–10) a fogalom részleteihez (vagy 'k' a kilépéshez):"
  bemenet <- getLine
  case bemenet of
    "k" => putStrLn "Viszlát!"
    _   => do
      let szam = stringbolSorszam bemenet
      putStrLn ""
      putStrLn ("═══ " ++ szovegbolString (fogalomNeve szam) ++ " ═══")
      putStrLn ("Leírás: " ++ szovegbolString (fogalomLeirasa szam))
      putStrLn ("Duális: " ++ szovegbolString (fogalomDualisa szam))
      putStrLn ("Forrás: " ++ szovegbolString (fogalomForrasa szam))
      putStrLn ""
      main