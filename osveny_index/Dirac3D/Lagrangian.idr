module Lagrangian

import Data.Vect
import Fazis

-- =====================================================================
-- LAGRANGIAN modul: az út a geometriában.
--
-- A Lagrangian L = T - V → legkisebb akció elve: δS = 0.
-- A geodézia = az optimális út a fázistérben.
-- A Berry-fázis = geometriai fázis a geodézia mentén.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Állapot: 8 fázis + idő.
-- =====================================================================

public export
record Allapot where
  constructor MkAllapot
  fazisok : Vect 8 Fazis
  ido     : Double

public export
Show Allapot where
  show a = "Allapot(t=" ++ show (ido a) ++ ")"

-- =====================================================================
-- 2. Sebesség.
-- =====================================================================

public export
record Sebesseg where
  constructor MkSebesseg
  fazisSebesseg : Vect 8 Fazis
  idoSebesseg   : Double

-- =====================================================================
-- 3. Lagrangian: L = T - V.
-- =====================================================================

public export
tinetikusEnergia : Sebesseg -> Double
tinetikusEnergia v = 0.5 * cast (foldr (\f, acc => fazisIndex f + acc) 0 (fazisSebesseg v))

public export
potencialisEnergia : Allapot -> Double
potencialisEnergia a = cast (foldr (\f, acc => fazisIndex f + acc) 0 (fazisok a))

public export
lagrangian : Allapot -> Sebesseg -> Double
lagrangian a v = tinetikusEnergia v - potencialisEnergia a

-- =====================================================================
-- 4. Akció: S = Σ L · Δt.
-- =====================================================================

public export
akcio : List (Allapot, Sebesseg) -> Double -> Double
akcio allapotok dt =
  foldr (\x, acc => lagrangian (fst x) (snd x) * dt + acc) 0.0 allapotok

-- =====================================================================
-- 5. Geodézia: legrövidebb út két állapot között.
-- =====================================================================

public export
geodezia : Allapot -> Allapot -> Double -> List Allapot
geodezia a1 a2 dt =
  let diff = zipWith (\f2, f1 => indexFazis (8 + fazisIndex f2 `minus` fazisIndex f1))
                     (fazisok a2) (fazisok a1)
  in [ MkAllapot (fazisok a1) (ido a1)
     , MkAllapot diff (ido a1 + dt)
     , MkAllapot (fazisok a2) (ido a2)
     ]
  where
    minus : Nat -> Nat -> Nat
    minus Z m = m
    minus n Z = n
    minus (S n) (S m) = minus n m

-- =====================================================================
-- 6. Geometriai hiba és javítás (3. kategória).
-- =====================================================================

public export
geometriaiHiba : Allapot -> Allapot -> Double
geometriaiHiba tenyleges geodeziaAllapot =
  let kulonbsegek = zipWith (\f, g => fazisIndex f `minus` fazisIndex g)
                            (fazisok tenyleges) (fazisok geodeziaAllapot)
  in cast (foldr (\d, acc => d * d + acc) 0 kulonbsegek)
  where
    minus : Nat -> Nat -> Nat
    minus Z m = m
    minus n Z = n
    minus (S n) (S m) = minus n m

public export
geometriaiJavitas : Allapot -> Allapot -> Allapot
geometriaiJavitas tenyleges geodeziaAllapot =
  let ujFazisok = zipWith korrigalFazis (fazisok tenyleges) (fazisok geodeziaAllapot)
  in MkAllapot ujFazisok (ido tenyleges)
  where
    minus : Nat -> Nat -> Nat
    minus Z m = m
    minus n Z = n
    minus (S n) (S m) = minus n m

    korrigalFazis : Fazis -> Fazis -> Fazis
    korrigalFazis t g =
      let tavolsag = fazisIndex t `minus` fazisIndex g
          fele = tavolsag `div` 2
      in indexFazis (fazisIndex g + fele)

-- =====================================================================
-- 7. Berry-fázis.
-- =====================================================================

public export
berryFazis : Double -> Double
berryFazis gorbulatTerulet = gorbulatTerulet
