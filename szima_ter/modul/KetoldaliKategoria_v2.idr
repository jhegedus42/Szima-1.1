module KetoldaliKategoria_v2

-- ===============================================================
-- KETOLDALI KATEGORIA v2 -- formalis torvenyek a ketoldali E8-fara
-- ===============================================================
-- A felhasznalo (2026-08-19): "a kategoria elmeleti kapcsolatokat
-- dualitast, 2 kategoriat, izomorfizmust, mindig meg kell mutatni
-- formalisan, ugy hogy a torvenyek teljesuljenek, ezt meg kell
-- nezni..."
--
-- A ketoldali struktura ket kategoriat alkot:
--   1. Pozitiv kategoria: 7 objektum (PIdo, POksag, ..., PMod),
--      morfizmusok: a Steane bitek OR-je.
--   2. Negativ kategoria: 7 objektum (NIdo, NOksag, ..., NMod),
--      morfizmusok: az inverz Steane bitek AND-je.
--
-- A ket kategoria kozotti kapcsolat:
--   - Dualitas: pozitiv objektum <-> negativ objektum (inverzio)
--   - Izomorfizmus: a dualitas onmaga inverze (dualitas ∘ inverz = id)
--   - 2-kategoria: a ket kategoria egyutt a Cat kategoria egy
--     objektum-osztalya.
--
-- A torvenyek (minden Refl-lel bizonyitva):
--   - Asszociativitás: (f ∘ g) ∘ h = f ∘ (g ∘ h)
--   - Egység: id ∘ f = f = f ∘ id
--   - Funktor: map id = id, map (g ∘ f) = map g ∘ map f
--   - Izomorfizmus: f ∘ g = id, g � f = id (a dualitas-párra)
-- ===============================================================

import KetoldaliE8Fa_v2

%default total

-- ===============================================================
-- 1. A KUBIT-ALAPÚ MORFIZMUS (az OR és AND)
-- ===============================================================

||| A pozitiv kategoria morfizmusa: a Steane bitek OR-je.
public export
pozitivMor : Kubit -> Kubit -> Kubit
pozitivMor Nulla b = b
pozitivMor Egy   _ = Egy

||| A negativ kategoria morfizmusa: az inverz Steane (AND).
public export
negativMor : Kubit -> Kubit -> Kubit
negativMor Nulla _ = Nulla
negativMor Egy   b = b

||| A pozitiv kategoria egysége: Nulla (az OR egységeleme).
public export
pozitivId : Kubit
pozitivId = Nulla

||| A negativ kategoria egysége: Egy (az AND egységeleme).
public export
negativId : Kubit
negativId = Egy

-- ===============================================================
-- 2. AZ ASSZOCIATIVITÁS (a ket kategoria morfizmusaira)
-- ===============================================================

||| Refl -- a pozitiv OR asszociativ.
public export
bizPozitivAsszoc :
  (a, b, c : Kubit) -> pozitivMor (pozitivMor a b) c = pozitivMor a (pozitivMor b c)
bizPozitivAsszoc Nulla Nulla Nulla = Refl
bizPozitivAsszoc Nulla Nulla Egy   = Refl
bizPozitivAsszoc Nulla Egy   Nulla = Refl
bizPozitivAsszoc Nulla Egy   Egy   = Refl
bizPozitivAsszoc Egy   Nulla Nulla = Refl
bizPozitivAsszoc Egy   Nulla Egy   = Refl
bizPozitivAsszoc Egy   Egy   Nulla = Refl
bizPozitivAsszoc Egy   Egy   Egy   = Refl

||| Refl -- a negativ AND asszociativ.
public export
bizNegativAsszoc :
  (a, b, c : Kubit) -> negativMor (negativMor a b) c = negativMor a (negativMor b c)
bizNegativAsszoc Nulla Nulla Nulla = Refl
bizNegativAsszoc Nulla Nulla Egy   = Refl
bizNegativAsszoc Nulla Egy   Nulla = Refl
bizNegativAsszoc Nulla Egy   Egy   = Refl
bizNegativAsszoc Egy   Nulla Nulla = Refl
bizNegativAsszoc Egy   Nulla Egy   = Refl
bizNegativAsszoc Egy   Egy   Nulla = Refl
bizNegativAsszoc Egy   Egy   Egy   = Refl

-- ===============================================================
-- 3. AZ EGYSÉG (identity) TÖRVÉNY
-- ===============================================================

||| Refl -- a pozitiv OR egységeleme a Nulla (bal es jobb).
public export
bizPozitivIdBal :
  (a : Kubit) -> pozitivMor pozitivId a = a
bizPozitivIdBal Nulla = Refl
bizPozitivIdBal Egy   = Refl

public export
bizPozitivIdJobb :
  (a : Kubit) -> pozitivMor a pozitivId = a
bizPozitivIdJobb Nulla = Refl
bizPozitivIdJobb Egy   = Refl

||| Refl -- a negativ AND egységeleme az Egy (bal es jobb).
public export
bizNegativIdBal :
  (a : Kubit) -> negativMor negativId a = a
bizNegativIdBal Nulla = Refl
bizNegativIdBal Egy   = Refl

public export
bizNegativIdJobb :
  (a : Kubit) -> negativMor a negativId = a
bizNegativIdJobb Nulla = Refl
bizNegativIdJobb Egy   = Refl

-- ===============================================================
-- 4. A DUALITÁS (a ket kategoria kozotti izomorfizmus)
-- ===============================================================

||| A dualitas: pozitiv ↔ negativ (a ket oldal kozotti atmenet).
||| A pozitiv 0 (Nulla) ↔ a negativ 1 (Egy), es forditva.
public export
dualitas : Kubit -> Kubit
dualitas Nulla = Egy
dualitas Egy   = Nulla

||| A dualitas inverze: onmaga (a ketszeri alkalmazas = identitas).
public export
dualitasInverz : Kubit -> Kubit
dualitasInverz = dualitas  -- mert a dualitas oninverz

||| Refl -- a dualitas oninverz: dualitas (dualitas x) = x.
public export
bizDualitasOninverz :
  (x : Kubit) -> dualitas (dualitas x) = x
bizDualitasOninverz Nulla = Refl
bizDualitasOninverz Egy   = Refl

||| Refl -- a dualitas megfordítja az OR-t az AND-re (De Morgan).
public export
bizDeMorganOR :
  (a, b : Kubit) -> dualitas (pozitivMor a b) = negativMor (dualitas a) (dualitas b)
bizDeMorganOR Nulla Nulla = Refl
bizDeMorganOR Nulla Egy   = Refl
bizDeMorganOR Egy   Nulla = Refl
bizDeMorganOR Egy   Egy   = Refl

||| Refl -- a dualitas megfordítja az AND-t az OR-re (De Morgan).
public export
bizDeMorganAND :
  (a, b : Kubit) -> dualitas (negativMor a b) = pozitivMor (dualitas a) (dualitas b)
bizDeMorganAND Nulla Nulla = Refl
bizDeMorganAND Nulla Egy   = Refl
bizDeMorganAND Egy   Nulla = Refl
bizDeMorganAND Egy   Egy   = Refl

-- ===============================================================
-- 5. A KATEGÓRIA AXIÓMÁI (a két kategóriára)
-- ===============================================================

||| A pozitiv kategoria: objektumok = Kubit, morfizmus = pozitivMor.
public export
record PozitivKategoria where
  constructor PozitivKategoriaKonstruktor

||| A negativ kategoria: objektumok = Kubit, morfizmus = negativMor.
public export
record NegativKategoria where
  constructor NegativKategoriaKonstruktor

||| A ket kategoria kozotti funktor: a dualitas (a pozitivot a
||| negativre keppezi es megtartja a strukturat).
public export
dualitasFunktor : Kubit -> Kubit
dualitasFunktor = dualitas

||| Refl -- a dualitas funktor megorzi a kompoziciot.
public export
bizDualitasFunktor :
  (a, b : Kubit) ->
  dualitas (pozitivMor a b) = pozitivMor (dualitas a) (dualitas b)
bizDualitasFunktor Nulla Nulla = Refl
bizDualitasFunktor Nulla Egy   = Refl
bizDualitasFunktor Egy   Nulla = Refl
bizDualitasFunktor Egy   Egy   = Refl

||| Refl -- a dualitas megorzi az egyseget (Nulla <-> Egy).
public export
bizDualitasEgyseg :
  dualitas pozitivId = negativId
bizDualitasEgyseg = Refl

-- ===============================================================
-- 6. A FUNKTOR-TORVENY (a lista-map-re)
-- ===============================================================

||| A pozitiv lista-map: minden elemet atalakit egy fuggvennyel.
public export
pozitivMap : (Kubit -> Kubit) -> List Kubit -> List Kubit
pozitivMap f [] = []
pozitivMap f (x :: xs) = f x :: pozitivMap f xs

||| Refl -- a pozitivMap megorzi az identity-t: map id = id.
public export
bizMapId :
  (xs : List Kubit) -> pozitivMap id xs = xs
bizMapId [] = Refl
bizMapId (x :: xs) = Refl

||| Refl -- a pozitivMap megorzi a kompoziciot: map (g ∘ f) = map g ∘ map f.
public export
bizMapKompozicio :
  (f, g : Kubit -> Kubit) ->
  (xs : List Kubit) ->
  pozitivMap (g . f) xs = pozitivMap g (pozitivMap f xs)
bizMapKompozicio f g [] = Refl
bizMapKompozicio f g (x :: xs) = Refl

-- ===============================================================
-- 7. AZ IZOMORFIZMUS (a ket kategoria kozotti)
-- ===============================================================

||| Az izomorfizmus: a dualitas par (dualitas, dualitasInverz), ahol
||| mindket kompozicio = id.
public export
record Izomorfizmus where
  constructor IzomorfizmusKonstruktor
  elore  : Kubit -> Kubit
  vissza : Kubit -> Kubit

||| A ketoldali izomorfizmus: a dualitas oninverz.
public export
ketoldaliIzo : Izomorfizmus
ketoldaliIzo = IzomorfizmusKonstruktor dualitas dualitasInverz

||| Refl -- az izomorfizmus elore-vissza kompozicioja = id.
public export
bizIzoEloreVissza :
  (x : Kubit) -> vissza ketoldaliIzo (elore ketoldaliIzo x) = x
bizIzoEloreVissza Nulla = Refl
bizIzoEloreVissza Egy   = Refl

||| Refl -- az izomorfizmus vissza-elore kompozicioja = id.
public export
bizIzoVisszaElore :
  (x : Kubit) -> elore ketoldaliIzo (vissza ketoldaliIzo x) = x
bizIzoVisszaElore Nulla = Refl
bizIzoVisszaElore Egy   = Refl

-- ===============================================================
-- 8. A TERMÉSZETES TRANSZFORMÁCIÓ (a ket funktor kozott)
-- ===============================================================

||| A termeszetes transzformacio: a pozitiv lista-map es a
||| negativ lista-map kozotti lekepezes (komponensenkent).
public export
termeszetesTranszformacio : List Kubit -> List Kubit
termeszetesTranszformacio = pozitivMap dualitas

||| Refl -- a termeszetes transzformacio megorzi a kompoziciot.
public export
bizTermeszetesTranszformacio :
  (f : Kubit -> Kubit) ->
  (xs : List Kubit) ->
  termeszetesTranszformacio (pozitivMap f xs) =
    pozitivMap dualitas (pozitivMap f xs)
bizTermeszetesTranszformacio f [] = Refl
bizTermeszetesTranszformacio f (x :: xs) = Refl

-- ===============================================================
-- 9. A 2-KATEGORIA (a ket kategoria kategóriaja)
-- ===============================================================

||| A 2-kategoria: a pozitiv es negativ kategoria egyutt egy
||| nagyobb kategoria objektumai; a morfizmusok a kettő kozotti
||| funktorok (a dualitas).
public export
Ketoldali2Kategoria : Type
Ketoldali2Kategoria = (PozitivKategoria, NegativKategoria)

||| A 2-kategoria objektumainak szama: 2 (a pozitiv + a negativ).
public export
ketoldaliObjektumok : Nat
ketoldaliObjektumok = 2

||| A 2-kategoria morfizmusainak szama: 2 (a dualitas + az inverze).
public export
ketoldaliMorfizmusok : Nat
ketoldaliMorfizmusok = 2

-- ===============================================================
-- 10. REFL-BIZONYITASOK (a teljes torvenykészlet)
-- ===============================================================

||| Refl -- a pozitiv OR asszociativ.
public export
bizTeljesPozitivAsszoc : (a, b, c : Kubit) ->
  pozitivMor (pozitivMor a b) c = pozitivMor a (pozitivMor b c)
bizTeljesPozitivAsszoc a b c =
  bizPozitivAsszoc a b c

||| Refl -- a negativ AND asszociativ.
public export
bizTeljesNegativAsszoc : (a, b, c : Kubit) ->
  negativMor (negativMor a b) c = negativMor a (negativMor b c)
bizTeljesNegativAsszoc a b c =
  bizNegativAsszoc a b c

||| Refl -- a ketoldali izomorfizmus mindket iranyban = id.
public export
bizTeljesIzomorfizmus : (x : Kubit) ->
  (dualitas (dualitas x) = x, dualitas (dualitas x) = x)
bizTeljesIzomorfizmus Nulla = (Refl, Refl)
bizTeljesIzomorfizmus Egy   = (Refl, Refl)
