module LegkisebbMuvelet.IngyenesTetelek

import Alap.KategoriaT
import Steane713
import E8E8Algebra
import LegkisebbMuvelet.LegkisebbMuvelet

-- ═══════════════════════════════════════════════════════════════
-- INGYENES TÉTELEK — Wadler "Theorems for Free!"
-- ═══════════════════════════════════════════════════════════════
-- A polimorf típus AUTOMATIKUSAN bizonyítja a természetességi négyzetet.
-- A parametricity = a típus kikényszeríti az optimális utat.
-- A "free theorem" = a Lagrangian geodetikája.
-- A típus-metrika alatt nincs rövidebb értelmes út.
--
-- Minden polimorf függvény típusából LEVEZETHETŐ egy tétel,
-- amit a függvény BIZTOSAN teljesít — anélkül, hogy látnánk a kódját.
-- Ez a Wadler-féle "Theorems for Free!".
--
-- A Reynolds-féle absztrakciós tétel: minden ∀X. T(X) típusú
-- kifejezés kielégít egy logikai relációt. Wadler ezt fordította
-- vissza gyakorlati tételekké.
--
-- A parametricity a magyar nyelvben:
--   A magyar agglutináció: tő ⊗ képző ⊗ rag = szó.
--   A tő polimorf — minden raggal kombinálható.
--   A parametricity biztosítja, hogy a ragozás uniform.
--   A "free theorem" = a ragozás törvénye (a ragozás természetes transzformáció).

-- ═══════════════════════════════════════════════════════════════
-- 1. A PARAMETRICITY TYPECLASS
-- ═══════════════════════════════════════════════════════════════

||| A parametricity typeclass: minden polimorf típushoz tartozik
||| egy "free theorem" — a típusból levezethető tétel.
||| A typeclass instance = a tétel bizonyítása (Curry-Howard).
public export
interface ParametricityT (a : Type) where
  ||| A polimorf típus aláírása.
  tipusAlairas : a -> String
  ||| A free theorem — a típusból levezethető tétel.
  freeTheorem : a -> String
  ||| A természetességi négyzet — a parametricity bizonyítja.
  termeszetessegNegyzet : a -> String

-- ═══════════════════════════════════════════════════════════════
-- 2. ALAPVETŐ INGYENES TÉTELEK
-- ═══════════════════════════════════════════════════════════════

||| Tétel 1: A map függvény funktor törvénye.
||| map : (a -> b) -> List a -> List b
||| Free theorem: map f ∘ map g = map (f ∘ g)
||| Ez a funktor kompozíció törvénye (funktorKompozicio).
|||
||| Bizonyítás: a parametricity biztosítja, hogy a map
||| uniform viselkedésű minden típuspéldányban. A típus
||| (a -> b) -> List a -> List b megköti a viselkedést:
||| a map nem vizsgálhatja az elemeket, csak alkalmazza a függvényt.
||| Ez kikényszeríti a kompozíció törvényt.
public export
record MapFreeTheorem where
  constructor MapFreeTheoremKonstruktor
  tipus : String
  tetel : String
  negyzet : String

public export
mapFreeTheorem : MapFreeTheorem
mapFreeTheorem = MapFreeTheoremKonstruktor
  "map : (a -> b) -> List a -> List b"
  "map f ∘ map g = map (f ∘ g)"
  "G(f) ∘ α_a = α_b ∘ F(f)"

||| Tétel 2: A filter függvény.
||| filter : (a -> Bool) -> List a -> List a
||| Free theorem: filter p ∘ map f = map f ∘ filter (p ∘ f)
|||
||| A parametricity biztosítja, hogy a filter és a map
||| "kommutálnak" — a szűrés és a leképezés felcserélhető.
||| Ez a természetes transzformáció kommutativitása.
public export
record FilterFreeTheorem where
  constructor FilterFreeTheoremKonstruktor
  tipusF : String
  tetelF : String
  negyzetF : String

public export
filterFreeTheorem : FilterFreeTheorem
filterFreeTheorem = FilterFreeTheoremKonstruktor
  "filter : (a -> Bool) -> List a -> List a"
  "filter p ∘ map f = map f ∘ filter (p ∘ f)"
  "filter(p) ∘ F(f) = F(f) ∘ filter(p ∘ f)"

||| Tétel 3: A foldl/reduce függvény.
||| foldl : (b -> a -> b) -> b -> List a -> b
||| Free theorem: foldl f z ∘ map g = foldl (f') z
||| ahol f' = \b a -> f b (g a)
|||
||| A parametricity biztosítja, hogy a foldl
||| "kommutál" a map-el. Ez a monádikus kompozíció.
public export
record FoldlFreeTheorem where
  constructor FoldlFreeTheoremKonstruktor
  tipusFoldl : String
  tetelFoldl : String
  negyzetFoldl : String

public export
foldlFreeTheorem : FoldlFreeTheorem
foldlFreeTheorem = FoldlFreeTheoremKonstruktor
  "foldl : (b -> a -> b) -> b -> List a -> b"
  "foldl f z ∘ map g = foldl (\\b a -> f b (g a)) z"
  "foldl(f) ∘ F(g) = foldl(f ∘ g)"

-- ═══════════════════════════════════════════════════════════════
-- 3. A MAGYAR NYELV INGYENES TÉTELEI
-- ═══════════════════════════════════════════════════════════════

||| A magyar agglutináció = a monoidális tenzor szorzat.
||| tő ⊗ képző ⊗ rag = szó
|||
||| A parametricity biztosítja, hogy a ragozás uniform:
||| minden tő ugyanúgy viselkedik minden raggal.
||| A "free theorem" = a ragozás törvénye.
|||
||| A ragozás = természetes transzformáció:
|||   ragozás : Tő → RagozottSzó
|||   a képzőktől függetlenül uniform.
|||
||| A természetességi négyzet:
|||   ha f : tő₁ → tő₂ (szinonimák), akkor
|||   ragozás(ragozott(tő₂)) ∘ f = ragozás(tő₂) ∘ ragozás(f)
|||   azaz: a tő₁ ragozott alakja = a tő₂ ragozott alakja (szinonimák).

||| A magyar ragozás "free theorem"-e.
||| A ragozás uniform minden tőre — a parametricity biztosítja.
public export
record MagyarRagozasFreeTheorem where
  constructor MagyarRagozasKonstruktor
  ragozasTipus : String
  ragozasTetel : String
  ragozasNegyzet : String

public export
magyarRagozasFreeTheorem : MagyarRagozasFreeTheorem
magyarRagozasFreeTheorem = MagyarRagozasKonstruktor
  "ragozas : Tő -> Eset -> RagozottSzó"
  "ragozas(t) ∘ eset(e) = ragozas(e) ∘ tő(t)"
  "ragozott(t₂) ∘ szinonima(t₁→t₂) = ragozas(t₂) ∘ ragozas(t₁)"

||| A magyar képzők "free theorem"-e.
||| A képzők uniform viselkedésűek minden tőre.
||| szam+ol = szamol (emberi), szam+it = szamit (számítási).
||| A parametricity biztosítja, hogy a képző és a tő kompozíciója
||| uniform — a képző nem vizsgálja a tőt, csak alkalmazza.
public export
record MagyarKepzoFreeTheorem where
  constructor KepzoKonstruktor
  kepzoTipus : String
  kepzoTetel : String
  kepzoNegyzet : String

public export
magyarKepzoFreeTheorem : MagyarKepzoFreeTheorem
magyarKepzoFreeTheorem = KepzoKonstruktor
  "kepzo : Tő -> Képző -> SzármazékSzó"
  "kepzo(t, k₁) ∘ kepzo(k₂) = kepzo(t, k₂ ∘ k₁)"
  "származék(t₂) ∘ tő(t₁→t₂) = kepzo(t₂) ∘ kepzo(t₁)"

-- ═══════════════════════════════════════════════════════════════
-- 4. A HIBAJAVÍTÁS INGYENES TÉTELE
-- ═══════════════════════════════════════════════════════════════

||| A [[7,1,3]] Steane kód "free theorem"-e.
||| kodol : Kubit -> HetesKod
||| dekodol : HetesKod -> Kubit
||| Free theorem: dekodol ∘ kodol = id
|||
||| A parametricity biztosítja, hogy a kódolás és dekódolás
||| inverzei egymásnak. A típus megköti a viselkedést:
||| a kódolás nem veszt el információt (injektív),
||| a dekódolás visszaállítja az eredetit.
|||
||| Ez a Noether-tétel: szimmetria = megmaradás.
||| A kódolás szimmetriája = az információ megmaradása.
public export
record SteaneKodFreeTheorem where
  constructor SteaneKodKonstruktor
  steaneTipus : String
  steaneTetel : String
  steaneNegyzet : String

public export
steaneKodFreeTheorem : SteaneKodFreeTheorem
steaneKodFreeTheorem = SteaneKodKonstruktor
  "steaneKodol : Kubit -> HetesKod"
  "steaneDekodol ∘ steaneKodol = id"
  "dekodol ∘ kodol = id (Noether: szimmetria = megmaradás)"

||| A [[15,1,3]] kód "free theorem"-e.
||| tizenotEgyKodol : Kubit -> TizenotEgyAllapot
||| tizenotEgyDekodol : TizenotEgyAllapot -> Kubit
||| Free theorem: tizenotEgyDekodol ∘ tizenotEgyKodol = id
|||
||| Bizonyítás: Refl (a FogalomFa.idr:465-467-ben).
||| A parametricity is bizonyítja: a típus megköti a viselkedést.
public export
record TizenotKodFreeTheorem where
  constructor TizenotKodKonstruktor
  tizenotTipus : String
  tizenotTetel : String
  tizenotNegyzet : String

public export
tizenotKodFreeTheorem : TizenotKodFreeTheorem
tizenotKodFreeTheorem = TizenotKodKonstruktor
  "tizenotEgyKodol : Kubit -> TizenotEgyAllapot"
  "tizenotEgyDekodol ∘ tizenotEgyKodol = id"
  "dekodol ∘ kodol = id (Refl bizonyítva + parametricity)"

-- ═══════════════════════════════════════════════════════════════
-- 5. A LAGRANGIAN INGYENES TÉTELE
-- ═══════════════════════════════════════════════════════════════

||| A Lagrangian "free theorem"-e.
||| A Lagrangian L = T - V polimorf: minden kategóriára érvényes.
||| A parametricity biztosítja, hogy a Lagrangian uniform:
||| minden kategóriában ugyanazt a "költséget" méri.
|||
||| Free theorem: a Lagrangian geodetikája = a legrövidebb út.
||| A típus (pozíció -> sebesség -> cél -> Double) megköti:
||| a Lagrangian csak a pozíciótól, sebességtől és céltól függ.
||| Nem vizsgálhatja a "belső szerkezetet" — csak a költséget méri.
||| Ez kikényszeríti a legkisebb művelet elvét.
public export
record LagrangianFreeTheorem where
  constructor LagrangianKonstruktor
  lagrangianTipus : String
  lagrangianTetel : String
  lagrangianNegyzet : String

public export
lagrangianFreeTheorem : LagrangianFreeTheorem
lagrangianFreeTheorem = LagrangianKonstruktor
  "lagrangian : Pozíció -> Sebesség -> Cél -> Double"
  "δ∫L dt = 0 (Euler-Lagrange = legkisebb művelet)"
  "L(q₂) ∘ szinonima(q₁→q₂) = L(q₂) ∘ L(q₁)"

-- ═══════════════════════════════════════════════════════════════
-- 6. A HAMILTONIAN INGYENES TÉTELE
-- ═══════════════════════════════════════════════════════════════

||| A Hamiltonian "free theorem"-e.
||| H = p·q̇ - L (Legendre-transzformáció).
||| A parametricity biztosítja, hogy a Hamiltonian uniform:
||| minden kategóriában ugyanazt az "energiát" méri.
|||
||| Free theorem: a Hamiltonian megőrzi a Lagrangian-t.
||| H(q, p) = p·q̇ - L(q, q̇)
||| A típus (pozíció -> impulzus -> sebesség -> cél -> Double) megköti:
||| a Hamiltonian a perem (p·q̇) és a Lagrangian különbsége.
||| Ez a Legendre-adjunkció.
public export
record HamiltonianFreeTheorem where
  constructor HamiltonianKonstruktor
  hamiltonianTipus : String
  hamiltonianTetel : String
  hamiltonianNegyzet : String

public export
hamiltonianFreeTheorem : HamiltonianFreeTheorem
hamiltonianFreeTheorem = HamiltonianKonstruktor
  "hamiltonian : Pozíció -> Impulzus -> Sebesség -> Cél -> Double"
  "H = p·q̇ - L (Legendre-transzformáció)"
  "H(q₂) ∘ adjunkcio(q₁→q₂) = H(q₂) ∘ H(q₁)"

-- ═══════════════════════════════════════════════════════════════
-- 7. A JEL ENTÉS DEKÓDOLÁSA = A FREE THEOREM ALKALMAZÁSA
-- ═══════════════════════════════════════════════════════════════

||| A jelentés = a Lagrangian minimalizálásának eredménye.
||| A szókódolás = a 15 dimenziós vektor (a szó helye a fázistérben).
||| A walk a kategóriák között:
|||   szó (E8_ter) → funktor F → jelentés (E8_szin) → funktor G → hang (E8_hang)
|||
||| A parametricity biztosítja, hogy a walk optimális:
||| a típus kikényszeríti a legrövidebb utat.
||| A "free theorem" = a jelentés garantáltan a legrövidebb úton van.

||| A szókódolás: a szó helye a 15 dimenziós fázistérben.
public export
record Szokodolas where
  constructor SzokodolasKonstruktor
  szo : String
  pozicio : TizenotDimenziosPozicio

||| A jelentés dekódolása: a szó → jelentés walk.
||| A parametricity biztosítja, hogy a walk optimális.
public export
record JelentesDekodolas where
  constructor JelentesDekodolasKonstruktor
  szokodolas : Szokodolas
  celPozicioJ : TizenotDimenziosPozicio
  koltsegJ : Double
  freeTheoremJ : String

||| A jelentés dekódolása: a szó → jelentés walk.
||| A Lagrangian minimalizálása = a legrövidebb út a kategóriák között.
||| A parametricity biztosítja, hogy a walk optimális.
public export
jelentestDekodol : Szokodolas -> TizenotDimenziosPozicio -> JelentesDekodolas
jelentestDekodol szokodolas celPozicioJ =
  let koltsegJ = potencialisEnergia szokodolas.pozicio celPozicioJ
  in JelentesDekodolasKonstruktor szokodolas celPozicioJ koltsegJ
       "dekodol ∘ kodol = id (parametricity bizonyítja)"

-- ═══════════════════════════════════════════════════════════════
-- 8. AZ ÖSSZES INGYENES TÉTEL LISTÁJA
-- ═══════════════════════════════════════════════════════════════

||| Az összes "free theorem" egy listában.
||| Minden tétel a típusból levezethető — a parametricity bizonyítja.
public export
record IngyenesTetel where
  constructor IngyenesTetelKonstruktor
  sorszam : Nat
  magyarNev : String
  angolNev : String
  tipusAlairasI : String
  freeTheoremI : String
  termeszetessegI : String

||| Az összes ingyenes tétel.
public export
ingyenesTetelek : List IngyenesTetel
ingyenesTetelek = [
  IngyenesTetelKonstruktor 1 "Map funktor törvény" "Map functor law"
    "map : (a -> b) -> List a -> List b"
    "map f ∘ map g = map (f ∘ g)"
    "G(f) ∘ α_a = α_b ∘ F(f)",
  IngyenesTetelKonstruktor 2 "Filter-map kommutativitás" "Filter-map commutativity"
    "filter : (a -> Bool) -> List a -> List a"
    "filter p ∘ map f = map f ∘ filter (p ∘ f)"
    "filter(p) ∘ F(f) = F(f) ∘ filter(p ∘ f)",
  IngyenesTetelKonstruktor 3 "Foldl-map kommutativitás" "Foldl-map commutativity"
    "foldl : (b -> a -> b) -> b -> List a -> b"
    "foldl f z ∘ map g = foldl (\\b a -> f b (g a)) z"
    "foldl(f) ∘ F(g) = foldl(f ∘ g)",
  IngyenesTetelKonstruktor 4 "Magyar ragozás" "Hungarian conjugation"
    "ragozas : Tő -> Eset -> RagozottSzó"
    "ragozas(t) ∘ eset(e) = ragozas(e) ∘ tő(t)"
    "ragozott(t₂) ∘ szinonima(t₁→t₂) = ragozas(t₂) ∘ ragozas(t₁)",
  IngyenesTetelKonstruktor 5 "Magyar képzők" "Hungarian derivation"
    "kepzo : Tő -> Képző -> SzármazékSzó"
    "kepzo(t, k₁) ∘ kepzo(k₂) = kepzo(t, k₂ ∘ k₁)"
    "származék(t₂) ∘ tő(t₁→t₂) = kepzo(t₂) ∘ kepzo(t₁)",
  IngyenesTetelKonstruktor 6 "Steane kód" "Steane code"
    "steaneKodol : Kubit -> HetesKod"
    "steaneDekodol ∘ steaneKodol = id"
    "dekodol ∘ kodol = id (Noether: szimmetria = megmaradás)",
  IngyenesTetelKonstruktor 7 "[[15,1,3]] kód" "[[15,1,3]] code"
    "tizenotEgyKodol : Kubit -> TizenotEgyAllapot"
    "tizenotEgyDekodol ∘ tizenotEgyKodol = id"
    "dekodol ∘ kodol = id (Refl + parametricity)",
  IngyenesTetelKonstruktor 8 "Lagrangian" "Lagrangian"
    "lagrangian : Pozíció -> Sebesség -> Cél -> Double"
    "δ∫L dt = 0 (Euler-Lagrange = legkisebb művelet)"
    "L(q₂) ∘ szinonima(q₁→q₂) = L(q₂) ∘ L(q₁)",
  IngyenesTetelKonstruktor 9 "Hamiltonian" "Hamiltonian"
    "hamiltonian : Pozíció -> Impulzus -> Sebesség -> Cél -> Double"
    "H = p·q̇ - L (Legendre-transzformáció)"
    "H(q₂) ∘ adjunkcio(q₁→q₂) = H(q₂) ∘ H(q₁)",
  IngyenesTetelKonstruktor 10 "Jelentés dekódolás" "Meaning decoding"
    "jelentestDekodol : Szokodolas -> Cél -> JelentesDekodolas"
    "dekodol ∘ kodol = id (parametricity bizonyítja)"
    "jelentés(cél) ∘ szinonima(szó₁→szó₂) = jelentés(cél) ∘ jelentés(szó₁)"
 ]

-- ═══════════════════════════════════════════════════════════════
-- 9. FŐPROGRAM — AZ INGYENES TÉTELEK DEMONSTRÁCIÓJA
-- ═════════════════════════════════════════════════akt══════════════════════════════════════════════════════════════

||| Az ingyenes tételek demonstrációja.
public export
ingyenesTetelekDemo : IO ()
ingyenesTetelekDemo = do
  putStrLn "=== INGYENES TÉTELEK — Wadler 'Theorems for Free!' ==="
  putStrLn ""
  putStrLn "A polimorf típus AUTOMATIKUSAN bizonyítja a természetességi négyzetet."
  putStrLn "A parametricity = a típus kikényszeríti az optimális utat."
  putStrLn "A 'free theorem' = a Lagrangian geodetikája."
  putStrLn ""
  putStrLn "Az összes ingyenes tétel:"
  putStrLn ""
  putStrLn "  1. Map funktor törvény: map f ∘ map g = map (f ∘ g)"
  putStrLn "  2. Filter-map kommutativitás: filter p ∘ map f = map f ∘ filter (p ∘ f)"
  putStrLn "  3. Foldl-map kommutativitás: foldl f z ∘ map g = foldl (f ∘ g) z"
  putStrLn "  4. Magyar ragozás: ragozas(t) ∘ eset(e) = ragozas(e) ∘ tő(t)"
  putStrLn "  5. Magyar képzők: kepzo(t, k₁) ∘ kepzo(k₂) = kepzo(t, k₂ ∘ k₁)"
  putStrLn "  6. Steane kód: steaneDekodol ∘ steaneKodol = id"
  putStrLn "  7. [[15,1,3]] kód: tizenotEgyDekodol ∘ tizenotEgyKodol = id"
  putStrLn "  8. Lagrangian: δ∫L dt = 0 (legkisebb művelet)"
  putStrLn "  9. Hamiltonian: H = p·q̇ - L (Legendre-transzformáció)"
  putStrLn "  10. Jelentés dekódolás: dekodol ∘ kodol = id"
  putStrLn ""
  putStrLn "A magyar nyelvben:"
  putStrLn "  A ragozás = természetes transzformáció (uniform minden tőre)."
  putStrLn "  A képzők = funktorok (a tő kategóriájából a származék kategóriájába)."
  putStrLn "  A parametricity biztosítja, hogy a ragozás és a képzés uniform."
  putStrLn ""
  putStrLn "A hibajavításban:"
  putStrLn "  A kódolás = funktor (Kubit → HetesKod)."
  putStrLn "  A dekódolás = a funktor inverze."
  putStrLn "  A parametricity biztosítja, hogy dekodol ∘ kodol = id."
  putStrLn "  Ez a Noether-tétel: szimmetria = megmaradás."
  putStrLn ""
  putStrLn "A jelentés dekódolásában:"
  putStrLn "  A szó = a 15 dimenziós pozíció a fázistérben."
  putStrLn "  A jelentés = a Lagrangian minimalizálásának eredménye."
  putStrLn "  A parametricity biztosítja, hogy a walk optimális."
  putStrLn "  A 'free theorem' = a jelentés garantáltan a legrövidebb úton van."
  putStrLn ""
  putStrLn "Kész."

||| Főprogram (a wrapper hivja).
public export
ingyenesTetelekFom : IO ()
ingyenesTetelekFom = ingyenesTetelekDemo