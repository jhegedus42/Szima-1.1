module Hadmeres

import Data.Vect
import Fazis
import Lagrangian

-- =====================================================================
-- HADMÉRÉS modul: fázis → skálár projekció.
--
-- A mérés a kvantummechanikában: |Ψ⟩ → szám.
-- Itt: a 8-dimenziós fázisvektor → egyetlen Double.
--
-- Kulcs: a mérés NEM veszít információt — a harmadik fázis
-- kiszámítható az első kettőből (Z₈ csoportművelet).
-- Ez a koherencia alapja.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Fázis → szög: a Z₈ kör geometriája.
-- =====================================================================

||| Fázis → szög radiánban: k × π/4.
|||   F0 → 0.0, F1 → π/4, F2 → π/2, ..., F7 → 7π/4
public export
fazisSzog : Fazis -> Double
fazisSzog f = the Double (cast (fazisIndex f)) * pi / 4.0

-- =====================================================================
-- 2. Kivetítés: két fázis → skalár.
-- =====================================================================

||| Két fázis kivetítése: sin(Δk × π/4).
||| Ha a két fázis megegyezik → 0 (nincs eltérés).
||| Ha ellentétesek (F0 és F4) → 0 (sin(π) = 0).
||| Maximális: F0 és F2 → 1.0 (sin(π/2) = 1).
public export
kozvetites : Fazis -> Fazis -> Double
kozvetites f1 f2 =
  let k1 = the Double (cast (fazisIndex f1))
      k2 = the Double (cast (fazisIndex f2))
      deltak = k1 - k2
  in sin (deltak * pi / 4.0)

-- =====================================================================
-- 3. Harmadik fázis: Z₈ csoportművelet.
-- =====================================================================

||| Harmadik fázis kiszámítása két fázisból.
||| f3 = (k1 + k2) mod 8.
||| Ez a koherencia kulcsa: ha két csatorna fázisa ismert,
||| a harmadik automatikusan adódik.
public export
harmadikFazis : Fazis -> Fazis -> Fazis
harmadikFazis f1 f2 = fazisOsszead f1 f2

-- =====================================================================
-- 4. Teljes mérés: Allapot → Double.
-- =====================================================================

||| Teljes mérés: minden fázis komponens kivetítése.
||| teljesMeres(Ψ) = Σ sin(fazisIndex(fᵢ) × π/4)
|||
||| Ez a "mérték": egyetlen szám, ami jellemzi az állapotot.
||| Értéktartomány: [-8, 8] (8 komponens, mindegyik [-1, 1]).
public export
teljesMeres : Allapot -> Double
teljesMeres a =
  foldr (\f, acc => fazisSzog f + acc) 0.0 (fazisok a)

-- =====================================================================
-- 5. Részletes mérés: komponensenként.
-- =====================================================================

||| Egyetlen fázis komponens mérése.
public export
meresEgy : Fin 8 -> Allapot -> Double
meresEgy i a = fazisSzog (index i (fazisok a))

||| Minden komponens mérése külön-külön.
public export
meresRészletes : Allapot -> Vect 8 Double
meresRészletes a = map fazisSzog (fazisok a)

-- =====================================================================
-- 6. Mérési skála.
-- =====================================================================

||| Mérési skála: az eredmény nagysága szerint.
public export
data Mertek = Alacsony | Kozepes | Magas

public export
Show Mertek where
  show Alacsony = "Alacsony"
  show Kozepes  = "Közepes"
  show Magas    = "Magas"

||| Mérési skála meghatározása.
public export
mertekMeghatarozas : Double -> Mertek
mertekMeghatarozas ertek =
  let absErtek = if ertek < 0.0 then -ertek else ertek
  in if absErtek < 2.0 then Alacsony
     else if absErtek < 5.0 then Kozepes
     else Magas
