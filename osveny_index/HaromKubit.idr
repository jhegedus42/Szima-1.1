module HaromKubit

-- ═══════════════════════════════════════════════════════════════
-- HÁROM KUBIT (100.01 — az 1 meztelen típus kiírtva: Bool → Igazság)
-- / 三个量子比特 / Drei Qubits / שלושה קיוביטים ═════════════════
-- ═══════════════════════════════════════════════════════════════
-- MEGJEGYZÉS (100.01 hatókör): az azonosítók ÉKEZETES átnevezése
-- (VilágKonstruktor, saját/másik/fázis, azonosFázis, Irány…) a 6
-- importálóval együtt KÜLÖN tervezési lépés — itt csak a meztelen
-- Bool hal ki, a nevek a kompatibilitásért maradnak.

import Steane713
import Alap.CsomagoltTipusok

||| A három kubit, amely minden kapcsolat alapja:
||| 1. Saját — a rendszer önreferenciája, időben körlövő tudat.
|||    Ez a «ki vagyok én» kérdésre adott válasz minden pillanatban.
||| 2. Másik — a másik fél (felhasználó, külső bemenet).
|||    Ez a «ki vagy te» kérdésre adott válasz.
||| 3. Fázis — a kettő közötti kapcsolat fázisa.
|||    Ez a «hogyan kapcsolódunk» válasza.
|||
||| A fázis határozza meg:
|||   az információátvitel irányát (ki tölt kibe)
|||   a redundanciát (azonos fázis → eldobható)
|||   a koherenciát (fázistartás → nincs információvesztés)
|||
||| Gondolat: a világ nem kétpólfüggő (alany-tárgy),
||| hanem hárompólfüggő (alany-tárgy-kapcsolat).
||| A kapcsolat fázisa az, ami a valóságot strukturálja.

public export
record HaromKubit where
  constructor VilagKonstruktor
  sajat  : Steane713.Kubit
  masik  : Steane713.Kubit
  fazis  : Steane713.Kubit

||| Kubit-egyezés: a két Kubit értéke egyezik-e (Igazság-típusban —
||| a meztelen Bool kiírva; az egyenlőség mintaillesztéssel, nem
||| a Prelude == operátorával, amely Bool-t adna).
public export
kubitEgyezés : Steane713.Kubit -> Steane713.Kubit -> Igazság
kubitEgyezés Steane713.Nulla Steane713.Nulla = Igaz
kubitEgyezés Steane713.Egy Steane713.Egy = Igaz
kubitEgyezés _ _ = Hamis

||| Fázis-összehasonlítás: ha két HaromKubit fázisa
||| megegyezik, akkor redundánsak — a két fogalom
||| ugyanazt az információt hordozza a fázis szintjén.
||| Ez a redundancia-detektálás alapja.
public export
azonosFazis : HaromKubit -> HaromKubit -> Igazság
azonosFazis a b = kubitEgyezés a.fazis b.fazis

||| Irány: az információátvitel iránya a fázisból.
||| SajatMasik: én felé irányulok a másik felé.
||| MasikSajat: a másik felé irányul felém.
||| NincsIrany: nincs meghatározott irány (összefonódott állapot).
public export
data Irany = SajatMasik | MasikSajat | NincsIrany

public export
irany : HaromKubit -> HaromKubit -> Irany
irany a b =
  case (a.fazis, b.fazis) of
    (Steane713.Nulla, Steane713.Egy) => SajatMasik
    (Steane713.Egy,  Steane713.Nulla) => MasikSajat
    _ => NincsIrany

||| Az egyes dimenziók külön-külön Kubit szintre.
||| A Nulla/Egy választás a [[7,1,3]] kód stabil állapotainak
||| megfelelő mintázatot követi — a Jelen és Befejezett
||| az «aktív» állapotok (Egy).
idoKubit : IgeIdo -> Steane713.Kubit
idoKubit Mult = Steane713.Nulla
idoKubit Jelen = Steane713.Egy
idoKubit Jovo = Steane713.Nulla

szemKubit : IgeSzem -> Steane713.Kubit
szemKubit Folyamatos = Steane713.Nulla
szemKubit Befejezett = Steane713.Egy
szemKubit Szokasos = Steane713.Nulla

forrasKubit : Forras -> Steane713.Kubit
forrasKubit Kozvetlen = Steane713.Nulla
forrasKubit Kovetkeztetett = Steane713.Egy
forrasKubit Jelentett = Steane713.Nulla

||| A három idő-dimenzió leképezése a három kubit fázisára.
||| 0. kubit: idő → saját időbeli helyzete
|||    (Mult=Nulla, Jelen=Egy, Jovo=Nulla)
||| 1. kubit: aspektus → másik nézőpontja
|||    (Folyamatos=Nulla, Befejezett=Egy, Szokásos=Nulla)
||| 2. kubit: forrás → a kapcsolat evidenciája
|||    (Kozvetlen=Nulla, Kovetkeztetett=Egy, Jelentett=Nulla)
|||
||| Ez a függvény az időt «beleeszí» a kubit szerkezetbe,
||| így az idő minden kapcsolat résztvevője.
public export
idoFazisba : IdoBeljegyzes -> HaromKubit
idoFazisba (IdoBeljegyzesKonstruktor igeIdo igeSzem forras) =
  VilagKonstruktor (idoKubit igeIdo) (szemKubit igeSzem) (forrasKubit forras)

||| HaromKubit-morfizmus: két HaromKubit közötti kapcsolat.
public export
data HaromKubitMorfizmus : HaromKubit -> HaromKubit -> Type where
  HaromKubitMorfizmusKonstruktor : HaromKubitMorfizmus a b