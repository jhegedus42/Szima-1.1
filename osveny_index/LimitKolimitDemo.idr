module LimitKolimitDemo

import KategoriaElmelet
import Steane713

-- ═══════════════════════════════════════════════════════════════
-- LIMIT/KOLIMIT INTERAKTÍV DEMO (Lépés 1.1, §N14/6)
-- ═══════════════════════════════════════════════════════════════
-- Ez a program bemutatja a 10 limit/kolimit fogalmat.
-- A felhasználó beír egy számot (1–10), a program kiírja a fogalmat.
-- Források: nLab, Awodey §5.1–5.4, Mac Lane §III.4

||| A 10 fogalom neve magyarul.
fogalomNeve : Nat -> String
fogalomNeve 1  = "1. Végződés (terminal) — minden A-ból egy morfizmus a végződésbe"
fogalomNeve 2  = "2. Kezdet (initial) — minden kezdettől egy morfizmus B-be"
fogalomNeve 3  = "3. Szorzat (product) — A×B + π₁ + π₂ + univerzális tulajdonság"
fogalomNeve 4  = "4. Koprodukt (coproduct) — A+B + ι₁ + ι₂ + duális univerzális"
fogalomNeve 5  = "5. Egyenlítő (equalizer) — f∘e = g∘e + faktorizáció"
fogalomNeve 6  = "6. Koegyenlítő (coequalizer) — q∘f = q∘g + duális faktorizáció"
fogalomNeve 7  = "7. Pullback (fiber product) — A→C←B + kommutatív négyzet"
fogalomNeve 8  = "8. Pushout — A←C→B + duális kommutatív négyzet"
fogalomNeve 9  = "9. ÁltalánosLimit — diagram + kúp + univerzális tulajdonság"
fogalomNeve 10 = "10. ÁltalánosKolimit — diagram + ko-kúp + duális univerzális"
fogalomNeve _  = "Ismeretlen fogalom. A szám 1–10 között legyen."

||| A 10 fogalom kategóriaelméletileg (rövid leírás).
fogalomLeirasa : Nat -> String
fogalomLeirasa 1  = "Definíció (Awodey §5.1): T végződés, ha ∀A ∃! t : A → T."
fogalomLeirasa 2  = "Definíció: I kezdet, ha ∀B ∃! i : I → B. A végződés duálisa."
fogalomLeirasa 3  = "Definíció: P = A×B, π₁ : P→A, π₂ : P→B, ∀Q ∀q₁ ∀q₂ ∃! h : Q→P."
fogalomLeirasa 4  = "Definíció: C = A+B, ι₁ : A→C, ι₂ : B→C, ∀D ∀d₁ ∀d₂ ∃! h : C→D."
fogalomLeirasa 5  = "Definíció: E egyenlítő f,g : A→B, e : E→A, f∘e = g∘e."
fogalomLeirasa 6  = "Definíció: Q koegyenlítő f,g : A→B, q : B→Q, q∘f = q∘g."
fogalomLeirasa 7  = "Definíció: P pullback A→C←B, f∘p₁ = g∘p₂ + univerzális."
fogalomLeirasa 8  = "Definíció: P pushout A←C→B, i₁∘f = i₂∘g + univerzális."
fogalomLeirasa 9  = "Definíció (Mac Lane §III.4): lim(D) + kúp + kompatibilitás + univerzális."
fogalomLeirasa 10 = "Definíció: colim(D) + ko-kúp + kompatibilitás + duális univerzális."
fogalomLeirasa _  = ""

||| A fogalom duálisa.
fogalomDualisa : Nat -> String
fogalomDualisa 1  = "Duálisa: Kezdet (initial)"
fogalomDualisa 2  = "Duálisa: Végződés (terminal)"
fogalomDualisa 3  = "Duálisa: Koprodukt (coproduct)"
fogalomDualisa 4  = "Duálisa: Szorzat (product)"
fogalomDualisa 5  = "Duálisa: Koegyenlítő (coequalizer)"
fogalomDualisa 6  = "Duálisa: Egyenlítő (equalizer)"
fogalomDualisa 7  = "Duálisa: Pushout"
fogalomDualisa 8  = "Duálisa: Pullback"
fogalomDualisa 9  = "Duálisa: ÁltalánosKolimit"
fogalomDualisa 10 = "Duálisa: ÁltalánosLimit"
fogalomDualisa _  = ""

||| A fogalom forrása.
fogalomForrasa : Nat -> String
fogalomForrasa 1  = "Forrás: nLab https://ncatlab.org/nlab/show/terminal+object ; Awodey §5.1"
fogalomForrasa 2  = "Forrás: nLab https://ncatlab.org/nlab/show/initial+object ; Awodey §5.1"
fogalomForrasa 3  = "Forrás: nLab https://ncatlab.org/nlab/show/product ; Awodey §5.1"
fogalomForrasa 4  = "Forrás: nLab https://ncatlab.org/nlab/show/coproduct ; Awodey §5.1"
fogalomForrasa 5  = "Forrás: nLab https://ncatlab.org/nlab/show/equalizer ; Awodey §5.3"
fogalomForrasa 6  = "Forrás: nLab https://ncatlab.org/nlab/show/coequalizer ; Awodey §5.3"
fogalomForrasa 7  = "Forrás: nLab https://ncatlab.org/nlab/show/pullback ; Awodey §5.2"
fogalomForrasa 8  = "Forrás: nLab https://ncatlab.org/nlab/show/pushout ; Awodey §5.2"
fogalomForrasa 9  = "Forrás: nLab https://ncatlab.org/nlab/show/limit ; Mac Lane §III.4"
fogalomForrasa 10 = "Forrás: nLab https://ncatlab.org/nlab/show/colimit ; Mac Lane §III.4"
fogalomForrasa _  = ""

||| A 10 fogalom listája.
fogalomLista : List Nat
fogalomLista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

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
    putStrLn (fogalomNeve n)
    putStrLn ("  " ++ fogalomLeirasa n)
    putStrLn ("  " ++ fogalomDualisa n)
    putStrLn ("  " ++ fogalomForrasa n)
    putStrLn "") fogalomLista
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
      let szam = cast {to = Nat} (cast {to = Integer} bemenet)
      putStrLn ""
      putStrLn ("═══ " ++ fogalomNeve szam ++ " ═══")
      putStrLn ("Leírás: " ++ fogalomLeirasa szam)
      putStrLn ("Duális: " ++ fogalomDualisa szam)
      putStrLn ("Forrás: " ++ fogalomForrasa szam)
      putStrLn ""
      main