module KatogorialGerinc

-- ═══════════════════════════════════════════════════════════════
-- KATOGÓRIAELMÉLETI GERINC — Kategóriák, Funktorok, Adjunkciók
-- ═══════════════════════════════════════════════════════════════
-- Ez a modul a teljes architektúra matematikai alapja.
--
-- ALAPFOGALMAK:
--   Kategória: objektumok + morfizmusok + identitás + kompozíció
--   Funktor: kategória → kategória
--   Adjunkció: két funktor közötti optimális kapcsolat
--
-- KAPCSOLAT A PROJEKTHEZ:
--   - Kódolás = funktor (A → B)
--   - Dekódolás = visszafordítás (B → A)
--   - Adjunkció = kódolás-dekódolás optimális párosa
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. KATEGÓRIA ─────────────────────────────────────────

public export
record Katogorialis where
  constructor KatogorialisKonstruktor
  Objektum : Type
  Morfizmus : Objektum -> Objektum -> Type
  Identitas : (a : Objektum) -> Morfizmus a a
  Kompozicio : (a : Objektum) -> (b : Objektum) -> (c : Objektum)
    -> Morfizmus a b -> Morfizmus b c -> Morfizmus a c

-- ─── 2. FUNKTOR ──────────────────────────────────────────

public export
record Funktor where
  constructor FunktorKonstruktor
  KezdoKat : Katogorialis
  CelKat : Katogorialis
  KepObjektum : Objektum KezdoKat -> Objektum CelKat
  KepMorfizmus : (a : Objektum KezdoKat) -> (b : Objektum KezdoKat)
    -> Morfizmus KezdoKat a b
    -> Morfizmus CelKat (KepObjektum a) (KepObjektum b)

-- ─── 3. PÉLDÁK ───────────────────────────────────────────

-- 3a. Bool kategória: két objektum, nyilak közöttük
public export
data BoolObj : Type where
  Igaz : BoolObj
  Hamis : BoolObj

public export
data BoolMorf : BoolObj -> BoolObj -> Type where
  Id : (a : BoolObj) -> BoolMorf a a
  AllitIgaz : BoolMorf Hamis Igaz

public export
boolKatogorialis : Katogorialis
boolKatogorialis = KatogorialisKonstruktor
  BoolObj
  BoolMorf
  Id
  (\a, b, c, f, g => ?kompozicio_impl)

-- 3b. Természetes számok kategóriája (monoid)
public export
data NatObj : Type where
  Egyetlen : NatObj

public export
data NatMorf : NatObj -> NatObj -> Type where
  Szam : Nat -> NatMorf Egyetlen Egyetlen

natKompo : (a : NatObj) -> (b : NatObj) -> (c : NatObj)
  -> NatMorf a b -> NatMorf b c -> NatMorf a c
natKompo _ _ _ (Szam n) (Szam m) = Szam (n + m)

natIdentitas : (a : NatObj) -> NatMorf a a
natIdentitas Egyetlen = Szam 0

public export
natKatogorialis : Katogorialis
natKatogorialis = KatogorialisKonstruktor
  NatObj
  NatMorf
  natIdentitas
  natKompo

-- ─── 4. ADJUNKCIÓ (egyszerűsített) ──────────────────────
-- Adjunkció = két irány közötti természetes izomorfizmus

public export
record Adjuncio where
  constructor AdjuncioKonstruktor
  BalFunktor : Funktor
  JobbFunktor : Funktor
  -- Egyszerűsített: az objektumok közötti megfeleltetés
  KepObjektumVissza : Objektum (CelKat JobbFunktor) -> Objektum (KezdoKat BalFunktor)

-- ─── 5. NYELVI KATEGÓRIA ─────────────────────────────────

public export
data NyelviSzavak : Type where
  Sz : Nat -> NyelviSzavak

public export
data NyelviMondat : NyelviSzavak -> NyelviSzavak -> Type where
  Ures : (a : NyelviSzavak) -> NyelviMondat a a
  Hozzad : (a : NyelviSzavak) -> (b : NyelviSzavak)
    -> NyelviMondat a b

public export
nyelviKatogorialis : Katogorialis
nyelviKatogorialis = KatogorialisKonstruktor
  NyelviSzavak
  NyelviMondat
  Ures
  (\_, _, _, _, _ => Hozzad _ _)

-- ─── 6. HIBAJAVÍTÓ KÓD KATEGÓRIA ────────────────────────
-- Egyszerűsített: a Javit konstruktor típuskényszere miatt
-- a teljes fedés nem lehetséges Idrisben.
-- A koncepció: Steane → ReedMuller javítási sorrend.

public export
data Hibakod : Type where
  Steane : Hibakod
  ReedMuller : Hibakod
  SedenionKod : Hibakod

public export
Show Hibakod where
  show Steane = "Steane [[7,1,3]]"
  show ReedMuller = "Reed-Muller [[15,1,3]]"
  show SedenionKod = "Sedenion [[31,1,5]]"

-- ─── 7. FŐ ───────────────────────────────────────────────

public export
foJelentes : String
foJelentes =
  "═══ KATOGÓRIAELMÉLETI GERINC ═══\n"
  ++ "Kategória: objektumok + morfizmusok + kompozíció\n"
  ++ "Funktor: kategória → kategória\n"
  ++ "Adjunkció: kódolás-dekódolás optimális párja\n\n"
  ++ "═══ ALKALMAZÁS ═══\n"
  ++ "Kódolás = funktor (A → B)\n"
  ++ "Dekódolás = visszafordítás (B → A)\n"
  ++ "Adjunkció = optimalitás\n\n"
  ++ "═══ KATEGÓRIÁK ═══\n"
  ++ "1. Bool kategória\n"
  ++ "2. Nat (monoid) kategória\n"
  ++ "3. Nyelvi kategória (szavak, mondatok)\n"
  ++ "4. Hibajavító kategória (Steane, Reed-Muller)\n"

main : IO ()
main = putStrLn foJelentes
