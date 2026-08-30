module KisBetűsProjekcióCsapda

import Data.Vect

-- A KisAI.idr (2026-08-19) tanulsága: a csapda NEM csak a bizonyítás
-- közvetlen konstansára él, hanem MINDEN kisbetűs konstansra, ami a
-- bizonyítás TÍPUSÁBAN szerepel — függvény-argumentumként is.
--
-- A tünet: "Can't solve constraint between: [] and kezdoKisAI .tudastar"
-- Még a legegyszerűbb projekció sem redukálódott, miközben a szerkezetileg
-- azonos önálló probe (minden konstansa nagybetűs) átment. A vak
-- probe-ok ezért NEM találták meg: a probe maga volt a nagybetűs kivétel.

-- A KisAI-idrőbeli rekord lebutítva:
record KisAIProbe where
  constructor KisAIKonstruktorProbe
  tudastarProbe : List Nat
  szotarProbe : List Nat
  miertLancProbe : List Nat

public export
AlapSzotarProbe : List Nat
AlapSzotarProbe = [1, 2, 3]

-- ROssz: kisbetűs konstans, függvény-argumentumként a bizonyítás típusában:
public export
kezdoKisAI : KisAIProbe
kezdoKisAI = KisAIKonstruktorProbe [] AlapSzotarProbe []

-- a "kezdoKisAI" a típusban ÚJ IMPLICIT argumentumként kötődik
-- → a projekció nem redukálódik → ELBUKIK:
RosszProjekcio : tudastarProbe kezdoKisAI = []
RosszProjekcio = Refl

-- Jó: nagybetűs alias, ugyanaz az érték:
public export
KezdoKisAI : KisAIProbe
KezdoKisAI = kezdoKisAI

-- a nagybetűs név nem köthető implicitnek → a definícióra utal
-- → kifejtés → a projekció redukálódik → ÁTMEGY:
JoProjekcio : tudastarProbe KezdoKisAI = []
JoProjekcio = Refl

-- A módszer (a hibakeresésben bevált): MANTRA-konform gyógyítás —
-- a kisbetűs definíció marad (a futásidejű kód használja), és
-- mellé nagybetűs alias kerül a bizonyítások számára.
