module HadMerger

import Data.Vect
import Fazis
import Lagrangian
import Hadmeres

-- =====================================================================
-- HADMÉRGER modul: mérés utáni állapotátmenet.
--
-- A mérés után az állapot "összeomlik" a mért értékre.
-- Itt: minden fázis komponenst +1 Z₈-ban léptetünk.
-- Ez a "mérés = mozgás" elve: a mérés maga az idő léptetése.
--
-- A mérés NEM pusztít — a harmadik fázis megmarad,
-- mert a Z₈ csoportművelet megőrzi a koherenciát.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Egyszeri mérés átmenet: +1 Z₈-ban.
-- =====================================================================

||| Egyetlen fázis léptetése: +1 mod 8.
||| F0→F1, F1→F2, ..., F7→F0.
||| Ez a "mérés = idő előrelépés" alapja.
public export
meresAtmenetEgy : Fazis -> Fazis
meresAtmenetEgy f = fazisOsszead f F1

-- =====================================================================
-- 2. Teljes mérés: minden komponens léptetése.
-- =====================================================================

||| Teljes mérés átmenet: minden fázis komponenst +1 Z₈-ban.
||| Allapot → Allapot.
public export
meresAtmenet : Allapot -> Allapot
meresAtmenet a = MkAllapot (map meresAtmenetEgy (fazisok a)) (ido a + 1.0)

-- =====================================================================
-- 3. Mérés utáni állapot: újbóli mérés.
-- =====================================================================

||| Mérés utáni állapot: meresAtmenet, majd teljesMeres.
||| A mérés után a mérték nő (az idő lép).
public export
meresUtan : Allapot -> Double
meresUtan a = teljesMeres (meresAtmenet a)

-- =====================================================================
-- 4. Mérési lánc: n-ször mérés.
-- =====================================================================

||| n-szörös mérés: n lépés Z₈-ban.
public export
meresLanc : Nat -> Allapot -> Allapot
meresLanc Z a = a
meresLanc (S k) a = meresAtmenet (meresLanc k a)

||| n-szörös mérés utáni állapot.
public export
meresLancUtan : Nat -> Allapot -> Double
meresLancUtan n a = teljesMeres (meresLanc n a)

-- =====================================================================
-- 5. Fordított mérés: -1 Z₈-ban.
-- =====================================================================

||| Fordított mérés: -1 Z₈-ban (visszalépés).
||| F1→F0, F2→F1, ..., F0→F7.
public export
forditottMeresEgy : Fazis -> Fazis
forditottMeresEgy f = fazisOsszead f (fazisInverz F1)

||| Fordított mérés: minden komponens -1.
public export
forditottMeres : Allapot -> Allapot
forditottMeres a = MkAllapot (map forditottMeresEgy (fazisok a)) (ido a - 1.0)

-- =====================================================================
-- 6. Mérés megőrzés: a koherencia fenntartása.
-- =====================================================================

||| Mérés megőrzés: a mérés után a teljes mérés értéke
||| a korábbi mérés + 8 × sin(π/4) (minden komponens +1).
||| Ez a termodinamikai korlát.
public export
meresMegorzes : Allapot -> Double
meresMegorzes a =
  let regi = teljesMeres a
      uj = teljesMeres (meresAtmenet a)
      elvartDiff = 8.0 * sin (pi / 4.0)
  in uj - regi
