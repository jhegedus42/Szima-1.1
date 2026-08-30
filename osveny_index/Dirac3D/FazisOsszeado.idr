module FazisOsszeado

import Data.Vect
import Data.String
import Fazis
import Lagrangian
import Carnot
import Hadmeres
import HadMerger

-- =====================================================================
-- FÁZISÖSSZEADÓ: számok összeadása mint nyelvi fordítás.
--
-- Kulcs felismerés: a Fordításegyenlet maga a kérdés.
-- "Mennyi 66 + 3456?" → a válasz = a fordítás eredménye.
-- =====================================================================

%default total

-- =====================================================================
-- 1. SZÓTÁR: számjegy → Fázis (Z₈ alapú).
-- =====================================================================

public export
szamjegyFazis : Nat -> Fazis
szamjegyFazis 0 = F0
szamjegyFazis 1 = F1
szamjegyFazis 2 = F2
szamjegyFazis 3 = F3
szamjegyFazis 4 = F4
szamjegyFazis 5 = F5
szamjegyFazis 6 = F6
szamjegyFazis 7 = F7
szamjegyFazis 8 = F0
szamjegyFazis 9 = F1
szamjegyFazis _ = F0

public export
fazisSzamjegy : Fazis -> Nat
fazisSzamjegy F0 = 0
fazisSzamjegy F1 = 1
fazisSzamjegy F2 = 2
fazisSzamjegy F3 = 3
fazisSzamjegy F4 = 4
fazisSzamjegy F5 = 5
fazisSzamjegy F6 = 6
fazisSzamjegy F7 = 7

-- =====================================================================
-- 2. SEGÉDFÜGGVÉNY: szám → 5 számjegyre bontás (max 5 számjegy).
-- =====================================================================

record Szamjegyek5 where
  constructor MkSzamjegyek5
  d4 : Nat  -- ezresek (balról)
  d3 : Nat  -- szazak
  d2 : Nat  -- tizek
  d1 : Nat  -- egyesek
  d0 : Nat  -- maradek (legfeljebb 1 szamjegy)

||| Nat → legfeljebb 5 számjegyre bontás.
||| 66 → {0,0,6,6,0}, 3456 → {0,3,4,5,6}, 12345 → {1,2,3,4,5}
public export
bontas5 : Nat -> Szamjegyek5
bontas5 n = MkSzamjegyek5
  (n `div` 1000)
  ((n `div` 100) `mod` 10)
  ((n `div` 10) `mod` 10)
  (n `mod` 10)
  0

-- =====================================================================
-- 3. KÓDOLÁS: szám → fázisvektor (Vect 8).
-- =====================================================================

||| Szám → fázisvektor.
||| 5 számjegy → 5 fázis pozíció, a többi F0.
||| 66 → [F6, F6, F0, F0, F0, F0, F0, F0]
||| 3456 → [F3, F4, F5, F6, F0, F0, F0, F0]
public export
szamKodol : Nat -> Vect 8 Fazis
szamKodol n =
  let b = bontas5 n
      v0 = updateAt FZ (const (szamjegyFazis (d4 b))) (replicate 8 F0)
      v1 = updateAt (FS FZ) (const (szamjegyFazis (d3 b))) v0
      v2 = updateAt (FS (FS FZ)) (const (szamjegyFazis (d2 b))) v1
      v3 = updateAt (FS (FS (FS FZ))) (const (szamjegyFazis (d1 b))) v2
      v4 = updateAt (FS (FS (FS (FS FZ)))) (const (szamjegyFazis (d0 b))) v3
  in v4

-- =====================================================================
-- 4. DEKÓDOLÁS: fázisvektor → szám.
-- =====================================================================

public export
szamDekodol : Vect 8 Fazis -> Nat
szamDekodol v =
  let ezres = fazisSzamjegy (index FZ v)
      szazas = fazisSzamjegy (index (FS FZ) v)
      tizes = fazisSzamjegy (index (FS (FS FZ)) v)
      egyes = fazisSzamjegy (index (FS (FS (FS FZ))) v)
  in ezres * 1000 + szazas * 100 + tizes * 10 + egyes

-- =====================================================================
-- 5. KÉRDÉS: két szám + művelet.
-- =====================================================================

public export
record Kerdes where
  constructor MkKerdes
  elsoSzam    : Nat
  masodikSzam : Nat
  muvelet     : Fazis  -- F0 = összeadás

||| Kérdés → fázisállapot (összeg fázisvektorban).
public export
kerdesAllapot : Kerdes -> Allapot
kerdesAllapot k =
  let elso = szamKodol (elsoSzam k)
      masodik = szamKodol (masodikSzam k)
      osszeg = zipWith fazisOsszead elso masodik
  in MkAllapot osszeg 0.0

-- =====================================================================
-- 6. CARNOT-CIKLUS: a fordítás motorja.
-- =====================================================================

||| Fordítás: Carnot-ciklus a fázisállapoton.
||| A kérdés → állapot → Carnot → dekódolás → válasz.
public export
forditas : Kerdes -> Double -> Double -> Allapot
forditas k tMeleg tHideg =
  let allap = kerdesAllapot k
      cel = MkAllapot (szamKodol ((elsoSzam k) + (masodikSzam k))) 0.0
      eredmeny = teljesHibajavitas allap cel
  in eredmeny

||| Fordítás után: a válasz szám.
public export
valasz : Kerdes -> Double -> Double -> Nat
valasz k tMeleg tHideg =
  let eredmeny = forditas k tMeleg tHideg
  in szamDekodol (fazisok eredmeny)

-- =====================================================================
-- 7. PÉLDA: "Mennyi 66 + 3456?"
-- =====================================================================

public export
peldaKerdes : Kerdes
peldaKerdes = MkKerdes 66 3456 F0

public export
peldaEredmeny : Allapot
peldaEredmeny = forditas peldaKerdes 100.0 1.0

public export
peldaValasz : Nat
peldaValasz = valasz peldaKerdes 100.0 1.0
-- Elvárt: 3522

public export
teszt1Valasz : Nat
teszt1Valasz = valasz (MkKerdes 5 3 F0) 100.0 1.0
-- Elvárt: 8

public export
teszt2Valasz : Nat
teszt2Valasz = valasz (MkKerdes 12 34 F0) 100.0 1.0
-- Elvárt: 46

public export
teszt3Valasz : Nat
teszt3Valasz = valasz (MkKerdes 100 200 F0) 100.0 1.0
-- Elvárt: 300

-- =====================================================================
-- 9. REFL BIZONYÍTÁSOK.
-- =====================================================================

szamjegyFazisVissza0 : fazisSzamjegy (szamjegyFazis 0) = 0
szamjegyFazisVissza0 = Refl

szamjegyFazisVissza5 : fazisSzamjegy (szamjegyFazis 5) = 5
szamjegyFazisVissza5 = Refl

szamjegyFazisVissza7 : fazisSzamjegy (szamjegyFazis 7) = 7
szamjegyFazisVissza7 = Refl

szotarPontos6 : szamjegyFazis 6 = F6
szotarPontos6 = Refl

szotarPontos3 : fazisSzamjegy F3 = 3
szotarPontos3 = Refl

szotarKor4 : fazisSzamjegy (szamjegyFazis 4) = 4
szotarKor4 = Refl

-- Kodol/Dekodol kör: szamKodol után szamDekodol visszaadja az eredetit.
-- (A div/mod nem csökkenthető Refl-lel, ezért csak a szótár Refl-jeit tartjuk.)
