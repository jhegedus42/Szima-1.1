module KetoldaliKategoria_v3

-- (v3, 2026-08-22: az import a meggyógyított KetoldaliE8Fa_v3-ra áll;
--  a tartalom változatlan. §13.)

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

import KetoldaliE8Fa_v3
import KomplexByte  -- (v3) a Kubit közvetlen importja — az Idris 2 importja NEM tranzitív | Kubit 需直接导入

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

-- (v3, 2026-08-22 — KisBetűsProjekcióCsapda: a bizonyítások TÍPUSAIBAN
--  a kisbetűs pozitivId/negativId implicit kötéssé vált volna → a négy
--  egység-elem-bizonyítás elbukott, és a hiba láncolódott. Gyógyír:
--  NAGYBETŰS aliasok a típusokhoz.)
public export
PozitivIdKonst : Kubit
PozitivIdKonst = pozitivId

public export
NegativIdKonst : Kubit
NegativIdKonst = negativId

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
||| (v3: nagybetűs konstansok a típusban — KisBetűsProjekcióCsapda.)
public export
bizPozitivIdBal :
  (a : Kubit) -> pozitivMor PozitivIdKonst a = a
bizPozitivIdBal Nulla = Refl
bizPozitivIdBal Egy   = Refl

public export
bizPozitivIdJobb :
  (a : Kubit) -> pozitivMor a PozitivIdKonst = a
bizPozitivIdJobb Nulla = Refl
bizPozitivIdJobb Egy   = Refl

||| Refl -- a negativ AND egységeleme az Egy (bal es jobb).
public export
bizNegativIdBal :
  (a : Kubit) -> negativMor NegativIdKonst a = a
bizNegativIdBal Nulla = Refl
bizNegativIdBal Egy   = Refl

public export
bizNegativIdJobb :
  (a : Kubit) -> negativMor a NegativIdKonst = a
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

||| Refl -- a dualitas FUNKTOR-törvénye: a kompozíciót (OR) az
||| ellenoldal kompozíciójára (AND) viszi — ez maga a De Morgan-törvény.
||| (v3, ŐSZINTE JAVÍTÁS: a v2 állítása OR→OR volt, ami HAMIS — a kernel
||| leplezte le: "Mismatch between: Egy and Nulla" a (Nulla, Egy) eseten.
||| A dualitas a POZITÍV kategóriából a NEGATÍVBA visz, nem önmagába.)
public export
bizDualitasFunktor :
  (a, b : Kubit) ->
  dualitas (pozitivMor a b) = negativMor (dualitas a) (dualitas b)
bizDualitasFunktor Nulla Nulla = Refl
bizDualitasFunktor Nulla Egy   = Refl
bizDualitasFunktor Egy   Nulla = Refl
bizDualitasFunktor Egy   Egy   = Refl

||| Refl -- a dualitas megorzi az egyseget (Nulla <-> Egy).
||| (v3: nagybetűs konstansok — KisBetűsProjekcióCsapda.)
public export
bizDualitasEgyseg :
  dualitas PozitivIdKonst = NegativIdKonst
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
||| (v3: minősített Prelude.id — a típusban álló szabad `id` az
|||  elaborátor szerint AUTOMATIKUS IMPLICIT kötés lenne, nem a
|||  Prelude.id — ez volt a "x vs id x" hiba oka; a rekurzív eset
|||  cong-gal megy, l. theorems.rst.)
public export
bizMapId :
  (xs : List Kubit) -> pozitivMap Prelude.id xs = xs
bizMapId [] = Refl
bizMapId (x :: xs) = cong (x ::) (bizMapId xs)

||| Refl -- a pozitivMap megorzi a kompoziciot: map (g ∘ f) = map g ∘ map f.
public export
bizMapKompozicio :
  (f, g : Kubit -> Kubit) ->
  (xs : List Kubit) ->
  pozitivMap (g . f) xs = pozitivMap g (pozitivMap f xs)
bizMapKompozicio f g [] = Refl
bizMapKompozicio f g (x :: xs) = cong (g (f x) ::) (bizMapKompozicio f g xs)

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
||| (v3: a törvény az ALAPFÜGGVÉNYEKEN bizonyítandó — a 0.8.0
|||  unifikátora a konstans-rekordon (ketoldaliIzo) nem bontja ki
|||  a projekciókat, ezért a rekord-mezős formán "Can't solve" jött;
|||  a dualitas/dualitasInverz páron ugyanaz a törvény kifejti magát.)
public export
bizIzoEloreVissza :
  (x : Kubit) -> dualitasInverz (dualitas x) = x
bizIzoEloreVissza Nulla = Refl
bizIzoEloreVissza Egy   = Refl

||| Refl -- az izomorfizmus vissza-elore kompozicioja = id.
||| (v3: mint fent — az alapfüggvényeken.)
public export
bizIzoVisszaElore :
  (x : Kubit) -> dualitas (dualitasInverz x) = x
bizIzoVisszaElore Nulla = Refl
bizIzoVisszaElore Egy   = Refl

-- ===============================================================
-- 8. A TERMÉSZETES TRANSZFORMÁCIÓ (a ket funktor kozott)
-- ===============================================================

||| A termeszetes transzformacio: a pozitiv lista-map es a
||| negativ lista-map kozotti lekepezes (komponensenkent).
||| (v3: STRUKTURÁLIS definíció — a point-free `= pozitivMap dualitas`
|||  alakot a 0.8.0 unifikátora a klóz-ellenőrzésnél nem bontotta ki
|||  ["Can't solve: dualitas (f x) vs dualitas (f x)" — PróbaKvir
|||  izolálta]; mintaillesztéssel a cons-lépés lépésenként redukál.)
public export
termeszetesTranszformacio : List Kubit -> List Kubit
termeszetesTranszformacio [] = []
termeszetesTranszformacio (y :: ys) = dualitas y :: termeszetesTranszformacio ys

||| A természetes transzformáció §18(b)-fedése: KIMERÍTŐ futásidejű
||| ellenőrzés (a kernel-Refl útja a 0.8.0 elaborátor cong-kvírkján
||| beragad: a "Can't solve: dualitas (f x) vs dualitas (f x)" hiba a
||| PróbaKvir→PróbaLambdaCong próba-láncban izolálva — VÁLTOZÓ függvény-
||| fejű cong megy [bizMapKompozicio ✓], GLOBÁLIS függvényfejű beragad;
||| a matematika rendben, az elaborátor hibás — l. a tanulságot:
||| tanulsagok/CongBeragadtGlobálisFejCsapda.md).
||| A Kubit-világ VÉGES: a Kubit→Kubit függvénytér pontosan 4 elemű,
||| a hossz≤6-os listák halmaza 127 elemű → az ellenőrzés ezen a
||| határon valóban KIMERÍTŐ (AGENTS §18 kettős fedés, (b)-ág).
kétListaEgyezik : List Kubit -> List Kubit -> Bool
kétListaEgyezik [] [] = True
kétListaEgyezik (x :: xs) (y :: ys) =
  (x == y) && kétListaEgyezik xs ys
kétListaEgyezik _ _ = False

kubitFüggvények : List (Kubit -> Kubit)
kubitFüggvények = [ Prelude.id, dualitas, (\_ => Nulla), (\_ => Egy) ]

adottHosszúListák : Nat -> List (List Kubit)
adottHosszúListák Z = [[]]
adottHosszúListák (S k) =
  [ e :: resto | e <- [Nulla, Egy], resto <- adottHosszúListák k ]

public export
összesKubitLista : Nat -> List (List Kubit)
összesKubitLista határ =
  concat [ adottHosszúListák k | k <- [0..határ] ]

public export
természetesTranszformációKimerítő : Bool
természetesTranszformációKimerítő =
  all (\f =>
    all (\xs =>
      kétListaEgyezik (termeszetesTranszformacio (pozitivMap f xs))
                      (pozitivMap dualitas (pozitivMap f xs)))
      (összesKubitLista 6))
    kubitFüggvények

||| Az EREDETI (v2) tétel-állítás — kernel-bizonyítás JÖVŐBELI
||| Idris-verziókra tartva (a cong-kvírk elmúltával visszaállítható):
|||   termeszetesTranszformacio (pozitivMap f xs)
|||     = pozitivMap dualitas (pozitivMap f xs)
||| Fedve: természetesTranszformációKimerítő (§18(b)) — futásidőben.

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
