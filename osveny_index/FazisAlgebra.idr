module FazisAlgebra

import HaromKubit
import E8E8Algebra

||| Fazis algebra — a redundancia detektalasanak alapja.
|||
||| Gondolat: a vilag tele van redundancial.
||| Ugyanazt a gondolatot tobbszor is elmondjuk.
||| Ugyanazt a hibat tobbszor is elkovetjuk.
||| Ugyanaz a fogalom tobb helyen is megjelenik.
|||
||| A redundancia detektalasahoz a fazist hasznaljuk.
||| A fazis a [[7,1,3]] kod 5. bitje — a "fazis" pozicio.
|||
||| Ket fogalom azonos fazisban van → redundans → eldobhato.
|||   Ez tartja fenn a koherenciat.
||| Ket fogalom ellentetes fazisban van → informacio atvitel.
|||   Ez teremti az uj informaciot.
||| Ket fogalom kvantalt fazisban van → kvantum osszefonodes.
|||   Ez a nyelvi metaforak, asszociaciok alapja.

||| Fazis ertek a Cliﬀord algebraben.
||| Azonos: a ket kodoszo ugyanabban a fazisban rezeg.
|||   → redundans, eldobhato.
||| Ellentetes: a ket kodoszo ellentetes fazisban rezeg.
|||   → informacio atvitel, megtartando.
||| Kvantalt: a ket kodoszo osszefonodott allapotban van.
|||   → kvantum kapcsolat (metafora, asszociacio).
||| Ismeretlen: a fazis nem allapithato meg egyertelmuen.
|||   → tovabbi vizsgalat szukseges.
public export
data Fazis = Azonos | Ellentetes | Kvantalt | Ismeretlen

public export
Eq Fazis where
  (==) Azonos Azonos = True
  (==) Ellentetes Ellentetes = True
  (==) Kvantalt Kvantalt = True
  (==) Ismeretlen Ismeretlen = True
  (==) _ _ = False
  (/=) a b = not (a == b)

||| Ket kodoszo fazis osszehasonlitasa.
||| A Cliﬀord atfedes alapjan dontunk:
||| >0.9 → Azonos (szinte ugyanaz)
||| <0.1 → Ellentetes (teljesen kulonbozo)
||| >0.5 → Kvantalt (reszben atfed)
||| egyebkent → Ismeretlen
public export
fazisOsszehasonlit : E8E8KodSzo -> E8E8KodSzo -> Fazis
fazisOsszehasonlit a b =
  let balAtfedes = atfedes (CliﬀordKonstruktor a.balE8.x1 a.balE8.x2 0)
                           (CliﬀordKonstruktor b.balE8.x1 b.balE8.x2 0)
      jobbAtfedes = atfedes (CliﬀordKonstruktor a.jobbE8.x1 a.jobbE8.x2 0)
                            (CliﬀordKonstruktor b.jobbE8.x1 b.jobbE8.x2 0)
  in if balAtfedes > 0.9 && jobbAtfedes > 0.9 then Azonos
  else if balAtfedes < 0.1 && jobbAtfedes < 0.1 then Ellentetes
  else if balAtfedes > 0.5 || jobbAtfedes > 0.5 then Kvantalt
  else Ismeretlen

||| Redundancia ellenorzes: ha egy kodoszo azonos fazisban van
||| barmelyik meglévovel, akkor redundans — eldobhato.
||| Ez a koherencia megörzes alapja.
public export
redundans : E8E8KodSzo -> List E8E8KodSzo -> Bool
redundans kod kodok = any (\k => fazisOsszehasonlit kod k == Azonos) kodok

||| Szures: megtartja azokat a kodoszavakat, amelyek fazisa
||| elter a tobbitol. Az azonos fazisuak eldobasa utan
||| a kapott halmaz koherens — nincs redundancia.
|||
||| A szures algoritmusa:
|||   lista elejetol haladunk
|||   ha az aktualis elem redundans a maradekhoz kepest → eldob
|||   ha nem → megtartjuk es folytatjuk
public export
szurd : List E8E8KodSzo -> List E8E8KodSzo
szurd [] = []
szurd (x :: xs) =
  if redundans x xs
    then szurd xs
    else x :: szurd xs

||| ToltesParitasIdo: a CPT szimmetria magyarul.
||| CPT:
|||   C (toltes) = sajat tudat — a rendszer onreferenciaja
|||   P (paritas) = masik fel — a kulso bemenet
|||   T (ido) = kapcsolat fazisa — a ketto dinamikaja
|||
||| A ToltesParitasIdo harom HaromKubit-ot tartalmaz,
||| minden iranyhoz egyet. Ez a teljes CPT szimmetria
||| a harom kubit vilagaban.
|||
||| Miert nem "CPT" a rekord neve?
||| Mert a roviditesek tiltva vannak.
||| A "CPT" kivétel (standard fizikai terminus),
||| de itt a teljes magyar nevet hasznaljuk a tipusra.
public export
record ToltesParitasIdo where
  constructor ToltesParitasIdoKonstruktor
  toltes  : HaromKubit  -- C: sajat tudat (ki vagyok en)
  paritas : HaromKubit  -- P: masik fel (ki vagy te)
  ido     : HaromKubit  -- T: kapcsolat fazisa (hogyan kapcsolodunk)

||| ToltesParitasIdo boole ertek: ha a toltes es a paritas
||| fazisa megegyezik, akkor a rendszer sajat tudata
||| rezonanciaban van a kulsovel — nincs informaciovesztes.
public export
toltesParitasIdoKoherens : ToltesParitasIdo -> Bool
toltesParitasIdoKoherens tpi =
  azonosFazis tpi.toltes tpi.paritas

||| ToltesParitasIdo irany: a toltes es paritas kozott.
||| Ha a toltes iranyul a paritas fele, akkor
||| a rendszer aktiv (informaciot kuld).
||| Ha a paritas iranyul a toltes fele, akkor
||| a rendszer passziv (informaciot fogad).
public export
toltesParitasIdoIrany : ToltesParitasIdo -> Irany
toltesParitasIdoIrany tpi = irany tpi.toltes tpi.paritas

||| Fazis faktorialis: egy ToltesParitasIdo fazismerteket
||| szamol a HaromKubit-ok osszefedesebol.
||| Ez az "altalanos koherencia" merteke.
public export
fazisFaktorialis : ToltesParitasIdo -> Double
fazisFaktorialis tpi =
  let ct = azonosFazis tpi.toltes tpi.ido
      pt = azonosFazis tpi.paritas tpi.ido
  in if ct && pt then 1.0
  else if ct || pt then 0.5
  else 0.0

-- ─── FÁZISHATÁR = LEGENDRE-PEREM ──────────────────────────
-- A fazishatar az a felulet ahol ket fazis talalkozik.
-- A fizikaban: szilard/folyekony, folyekony/gaz, kvantum/klasszikus.
-- A mi keretrendszerunkben: a fazishatar = a Legendre-perem.
--   A peremen atlepve a rendszer egyik fazisbol a masikba megy at:
--     komplex (kvantum) → fazishatar (perem, p·q̇) → valos (klasszikus)
--     folytonos (∫) → fazishatar (perem) → diszkret (Σ)
--     emberi (L) → fazishatar (perem) → szamitasi (H)
--     gondolat → fazishatar (szaj) → beszed
--
-- A fazishatar a [[7,1,3]] kodban a 6. bit (fazis pozicio).
-- A fazis bit donti el, hogy a kod melyik fazisban van.
-- A fazishatar atlepese = a Legendre-transzformacio = a meres aktusa.

||| Fazishatar: ket fazis kozti atmenet.
|||   A fazishatar a perem — ahol a rendszer egyik allapotbol
|||   a masikba valt. A Legendre-transzformacio = a fazishatar atlepese.
public export
record FazisHatar where
  constructor FazisHatarKonstruktor
  balFazis  : Fazis   -- a fazishatar elotti allapot
  jobbFazis : Fazis   -- a fazishatar utani allapot
  peremErtek : Double  -- a fazishatar erteke (p·q̇ = Legendre-perem)

||| Fazisatalakulas a fazishataron keresztul.
|||   Azonos → Ellentetes: a redundans informacio atadodik.
|||   Kvantalt → Azonos: az osszefonodas feloldodik.
|||   Ismeretlen → Kvantalt: az ismeretlenbol tudas lesz.
public export
fazisAtlepes : FazisHatar -> Fazis
fazisAtlepes (FazisHatarKonstruktor _ jobb _) = jobb

||| A fazishatar mint a Clifford-szorzat.
|||   a·b (atfedes) → fazishatar (ha magas, redundans) → eldobas
|||   a∧b (ujdonsag) → fazishatar (ha magas, informacio) → megtartas
|||   A fazishatar = az atfedes es az ujdonsag kozti valasztas.
public export
fazisHatarClifford : Double -> Double -> Fazis
fazisHatarClifford atfedes ujdonsag =
  if atfedes > ujdonsag then Azonos else Kvantalt

-- ─── ELSŐRENDŰ FÁZISÁTMENET ───────────────────────────────
-- https://en.wikipedia.org/wiki/Phase_transition
-- Elsorendu fazisatmenet: a szabadenergia ELSŐ derivaltja
-- (entropia vagy terfogat) ugrik a fazishataron.
-- Masodrendu: a MÁSODIK derivalt ugrik (pl. fajho).
--
-- A Legendre-transzformacio mint elsorendu fazisatmenet:
--   U(S,V) → F(T,V): S → T csere. Az entropia S = -∂F/∂T
--   ugrik a fazishataron (a latens ho).
--   A perem p·q̇ = az ugras merteke.
--
-- Pelda: viz fagyasa 0°C-on.
--   F_folyadek(T) ≠ F_jeg(T) a fazishataron.
--   A kulonbseg = a latens ho = a perem.

||| Elsorendu fazisatmenet: a potencial elso derivaltja ugrik.
|||   A Legendre-perem a ket fazis kozotti kulonbseg.
|||   dF = -S·dT - p·dV → az entropia (S) az elso derivalt.
public export
elsoRenduFazisAtmenet : Double -> Double -> Double
elsoRenduFazisAtmenet f1 f2 = f2 - f1  -- a kulonbseg = a perem

-- ─── ELSŐRENDŰ LOGIKA (CURRY-HOWARD) ─────────────────────
-- Elsorendu logika: ∀ (minden) es ∃ (letezik) kvantorok.
-- Curry-Howard: ∀ = Pi-tipus (fuggo szorzat), ∃ = Szigma-tipus (fuggo osszeg).
-- Idris-ben: (x : A) -> B x a ∀, es (x : A ** B x) a ∃.
-- A [[7,1,3]] Steane kod: ∀ k : Kubit. steaneDekodol(javitas(alapKod k, hiba)) = k.
-- Ez a Noether-tetel mint elsorendu logikai allitas.

||| Univerzalis kvantor (∀) mint Pi-tipus.
|||   Curry-Howard: ∀x.P(x) = (x : A) -> P(x).
|||   A tipus a bizonyitas: minden x-re P(x) teljesul.
|||   A Steane kodban: ∀ k, ∀ hiba. dekodol(javit(kodol(k), hiba)) = k.
public export
minden : (a : Type) -> (p : a -> Type) -> Type
minden a p = (x : a) -> p x

||| Egzisztencialis kvantor (∃) mint Szigma-tipus.
|||   Curry-Howard: ∃x.P(x) = (x : a ** P(x)).
|||   A tanu (witness) x es a bizonyitas P(x).
public export
letezik : (a : Type) -> (p : a -> Type) -> Type
letezik a p = (x : a ** p x)
