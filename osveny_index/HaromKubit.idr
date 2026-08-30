module HaromKubit

import Steane713

||| A harom kubit, amely minden kapcsolat alapja:
||| 1. Sajat — a rendszer onreferenciaja, idoben korzo tudat.
|||    Ez a "ki vagyok en" kerdesre adott valasz minden pillanatban.
||| 2. Masik — a masik fel (felhasznalo, kulso bemenet).
|||    Ez a "ki vagy te" kerdesre adott valasz.
||| 3. Fazis — a kettő kozotti kapcsolat fazisa.
|||    Ez a "hogyan kapcsolodunk" valasza.
|||
||| A fazis hatarozza meg:
|||   az informaciotvitele iranyat (ki tol kibe)
|||   a redundanciat (azonos fazis → eldobhato)
|||   a koherenciat (fazistartas → nincs informaciovesztes)
|||
||| Gondolat: a vilag nem ketpolfuggo (alany-targy),
||| hanem harompolfuggo (alany-targy-kapcsolat).
||| A kapcsolat fazisa az, ami a valosagot strukturálja.

public export
record HaromKubit where
  constructor VilagKonstruktor
  sajat  : Kubit
  masik  : Kubit
  fazis  : Kubit

||| Fazis osszehasonlitas: ha ket HaromKubit fazisa
||| megegyezik, akkor redundansak — a ket fogalom
||| ugyanazt az informaciot hordozza a fazis szintjen.
||| Ez a redundancia detektalas alapja.
public export
azonosFazis : HaromKubit -> HaromKubit -> Bool
azonosFazis a b = a.fazis == b.fazis

||| Irany: az informaciotvitele iranya a fazisbol.
||| SajatMasik: en fele iranyulok a masik fele.
||| MasikSajat: a masik fele iranyul felem.
||| NincsIrany: nincs hatarozott irany (osszefonodott allapot).
public export
data Irany = SajatMasik | MasikSajat | NincsIrany

public export
irany : HaromKubit -> HaromKubit -> Irany
irany a b =
  case (a.fazis, b.fazis) of
    (Nulla, Egy) => SajatMasik
    (Egy,  Nulla) => MasikSajat
    _ => NincsIrany

||| Az egyes dimenziok kulon-kulon Kubit szintre.
||| A Nulla/Egy valasztas a [[7,1,3]] kod stabil allapotainak
||| megfelelő mintázatot koveti — a Jelen es Befejezett
||| az "aktiv" allapotok (Egy).
idoKubit : IgeIdo -> Kubit
idoKubit Mult = Nulla
idoKubit Jelen = Egy
idoKubit Jovo = Nulla

szemKubit : IgeSzem -> Kubit
szemKubit Folyamatos = Nulla
szemKubit Befejezett = Egy
szemKubit Szokasos = Nulla

forrasKubit : Forras -> Kubit
forrasKubit Kozvetlen = Nulla
forrasKubit Kovetkeztetett = Egy
forrasKubit Jelentett = Nulla

||| A harom ido dimenzio lekepezese a harom kubit fazisara.
||| 0. kubit: ido → sajat idobeli helyzete
|||    (Mult=Nulla, Jelen=Egy, Jovo=Nulla)
||| 1. kubit: aspektus → masik nezoPontja
|||    (Folyamatos=Nulla, Befejezett=Egy, Szokasos=Nulla)
||| 2. kubit: forras → a kapcsolat evidenciassaga
|||    (Kozvetlen=Nulla, Kovetkeztetett=Egy, Jelentett=Nulla)
|||
||| Ez a fuggveny az idot "beleszivja" a kubit szerkezetbe,
||| igy az ido minden kapcsolat reszvevoje.
public export
idoFazisba : IdoBeljegyzes -> HaromKubit
idoFazisba (IdoBeljegyzesKonstruktor igeIdo igeSzem forras) =
  VilagKonstruktor (idoKubit igeIdo) (szemKubit igeSzem) (forrasKubit forras)

||| HaromKubit morfizmus: ket HaromKubit kozotti kapcsolat.
public export
data HaromKubitMorfizmus : HaromKubit -> HaromKubit -> Type where
  HaromKubitMorfizmusKonstruktor : HaromKubitMorfizmus a b
