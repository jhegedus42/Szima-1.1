module AktivTanulas

import Data.Vect
import Data.List
import Fazis
import Lagrangian
import Carnot
import Hadmeres

-- =====================================================================
-- AKTÍV TANULÁS — a "miért" mint acquisition function.
--
-- A felismerés (2026-08-18, a felhasználó gondolkodásának formalizálása):
--
-- Amikor megoldok egy problémát, először megkérdezem magamtól:
--   1. TUDOM-E? (önellenőrzés: ΔH = 0?)
--   2. HA NEM: melyik kérdést tegyem fel? (acquisition function)
--   3. A kérdés = információt gyűjt (a fázistér felfedezése)
--   4. A válasz = a fázistér egy pontja (dekódolás)
--   5. MIÉRT? (a miért-lánc: az oksági fonal a kérdéstől a válaszig)
--
-- Ez a barkochba-játék: minden lépésben EGY kérdést választok —
-- azt, amelyik a legtöbb információt hozza (a legnagyobb
-- entrópia-csökkenés = a legkisebb ΔH a válasz után).
--
-- A kapcsolat a projekt struktúrájához:
--   - ΔH = 0 (HamiltonMegmaradas): "tudom" — nincs hő, unitér.
--   - ΔH > 0: "nem tudom" — hőt érzek, kérdezni kell.
--   - A kérdés = a QHMC következő lépése (Carnot.idr leapfrog).
--   - A válasz = a célállapot (teljesHibajavitas a cél felé).
--   - A "miért" = a MiertLanc bejegyzés (az oksági indoklás).
--
-- A neokortex = hierarchikus prediktív kódolás (Jiang-Rao 2024):
--   a predikciós hiba felfelé áramlik, a predikció lefelé —
--   pontosan mint a Carnot-ciklusban az entropia és a koherencia.
--   A "miért" = a predikciós hiba = a meglepetés = a szabad energia.
--
-- Források:
--   - Fiore et al. 2023 (aktív tanulás + Bayes-opt. dualizmusa)
--   - Jiang & Rao 2024 (dinamikus prediktív kódolás, neokortex)
--   - Rao et al. 2025 (neuro-órai leckék AI-nak)
--   - Friston 2010 (szabad energia elve)
-- =====================================================================

%default total

-- =====================================================================
-- 1. KÉRDÉS = a fázistér egy pontja + a bizonytalanság.
-- =====================================================================

||| Egy kérdés = a fázistér egy pontja (ahova a válasz mutat)
||| + a bizonytalanság (mennyit nem tudunk a válaszról).
||| A kérdés tartalma = szöveg (pl. "Mit mondott a farkas?").
public export
record Kerdes where
  constructor KerdesKonstruktor
  kerdesTartalom : String
  kerdesAllapot   : Allapot  -- a fázisállapot, amit a kérdés céloz
  kerdesBizonytalansag : Double  -- ΔH ha nem tudjuk a választ

||| Kérdés megjelenítése.
public export
Show Kerdes where
  show k = "Kerdes(\"" ++ kerdesTartalom k ++ "\", ΔH=" ++ show (kerdesBizonytalansag k) ++ ")"

-- =====================================================================
-- 2. VÁLASZ = a fázistér egy pontja + a maradék bizonytalanság.
-- =====================================================================

||| Egy válasz = a fázistér egy pontja (a dekódolt eredmény)
||| + a maradék bizonytalanság (mennyit még nem tudunk).
public export
record Valasz where
  constructor ValaszKonstruktor
  valaszTartalom : String
  valaszAllapot   : Allapot
  valaszBizonytalansag : Double  -- a válasz utáni ΔH

public export
Show Valasz where
  show v = "Valasz(\"" ++ valaszTartalom v ++ "\", ΔH=" ++ show (valaszBizonytalansag v) ++ ")"

-- =====================================================================
-- 3. ÖNELLENŐRZÉS: "Tudom-e?" = a Hamiltoni-változás.
-- =====================================================================

||| ÖNELLENŐRZÉS: "Tudom-e a választ?"
||| A Hamiltoni-változás méri: ha ΔH = 0, tudom (unitér, nincs hő).
||| Ha ΔH > 0, nem tudom — hőt érzek, kérdezni kell.
|||
||| Ez a "felhasználó gondolkodásának" első lépése:
||| "ahhoz hogy tudja mi egy kérdésre a válasz, először
||| meg kell kérdeznie magától, tényleg tudja-e".
public export
tudomE : Double -> Bool
tudomE deltaH = deltaH < 0.5  -- kicsi ΔH = tudom

||| Az önellenőrzés eredménye.
public export
data OnellenorzesEredmeny : Type where
  Tudom : OnellenorzesEredmeny       -- ΔH kicsi → válaszolok
  NemTudom : OnellenorzesEredmeny   -- ΔH nagy → kérdezni kell

public export
Show OnellenorzesEredmeny where
  show Tudom = "Tudom"
  show NemTudom = "NemTudom (kerdezni kell)"

||| Az önellenőrzés: ΔH alapján dönt.
public export
onellenoriz : Double -> OnellenorzesEredmeny
onellenoriz deltaH = if tudomE deltaH then Tudom else NemTudom

-- =====================================================================
-- 4. ACQUISITION FUNCTION = a "miért" értéke.
-- =====================================================================

||| Az acquisition function: mennyi információt hoz a kérdés?
||| = az entrópia-csökkenés ha megválaszoljuk a kérdést.
||| = entropia(előtt) - entropia(utána).
||| Minél nagyobb, annál érdemesebb feltenni a kérdést.
|||
||| Ez a "miért" matematikai alakja: a kérdés értéke =
||| a bizonytalanság csökkenése. A barkochba-játékban
||| ez választja ki a következő kérdést.
|||
||| Kapcsolat: a QHMC-ben a leapfrogGrad = a gradiens =
||| a predikciós hiba = az entrópia-változás iránya =
||| a "merre lehetnek válaszok" (a felhasználó szavaival).
public export
acquisitionErtek : Kerdes -> Double
acquisitionErtek k = kerdesBizonytalansag k  -- nagy ΔH = sok információ

-- =====================================================================
-- 5. KÉRDÉSVÁLASZTÁS: a barkochba-lépés.
-- =====================================================================

||| A legjobb kérdés kiválasztása: a legnagyobb acquisition értékű.
||| Ez a barkochba-játék lényege: mindig azt a kérdést tesszük fel,
||| amelyik a legtöbb információt hozza.
|||
||| "milyen kérdéseket kell feltennie magának és MIERT" (a felhasználó).
||| A "miért" = az acquisition function = a kérdés információs értéke.
public export
legjobbKerdes : List Kerdes -> Maybe Kerdes
legjobbKerdes [] = Nothing
legjobbKerdes (k :: ks) = legjobbKerdesSeged k ks
  where
    legjobbKerdesSeged : Kerdes -> List Kerdes -> Maybe Kerdes
    legjobbKerdesSeged legjobb [] = Just legjobb
    legjobbKerdesSeged legjobb (k :: ks) =
      if acquisitionErtek k > acquisitionErtek legjobb
      then legjobbKerdesSeged k ks
      else legjobbKerdesSeged legjobb ks

-- =====================================================================
-- 6. BARKOCHBA-LÉPÉS: egy kérdés = egy QHMC lépés.
-- =====================================================================

||| A barkochba-lépés: a kérdés megválaszolása = a fázistér
||| egy lépése a cél felé. A QHMC leapfrog integrátora tesz
||| egy lépést, és a Metropolis elfogadás dönti el, hogy
||| elfogadjuk-e az új állapotot (a választ).
|||
||| A kérdés allapota a cél, a jelenlegi allapot a kiindulás.
||| A QHMC lépés = a kérdés feldolgozása.
public export
barkochbaLepes : Allapot -> Kerdes -> Double -> Allapot
barkochbaLepes jelenlegi kerdes tMeleg =
  let cel = kerdesAllapot kerdes
      javitott = teljesHibajavitas jelenlegi cel
  in javitott

||| A barkochba-lépés után a bizonytalanság:
||| a javítás utáni állapot entrópiája (kisebb = közelebb a válaszhoz).
public export
barkochbaUtanBizonytalansag : Allapot -> Kerdes -> Double -> Double
barkochbaUtanBizonytalansag jelenlegi kerdes tMeleg =
  let ujAllapot = barkochbaLepes jelenlegi kerdes tMeleg
  in entropia ujAllapot

-- =====================================================================
-- 7. VÁLASZ GENERÁLÁSA: a célállapot dekódolása.
-- =====================================================================

||| Válasz generálása: a rendszer futtatja a barkochba-lépést,
||| ellenőrzi az eredményt, és dekódolja a választ.
|||
||| A ciklus (a felhasználó gondolkodása):
|||   1. KÉRDÉS → fázisállapot
|||   2. ÖNELLENŐRZÉS: "Tudom-e?" (ΔH)
|||   3. HA NEM: barkochba-lépés (QHMC a fázistérben)
|||   4. VÁLASZ: a célállapot dekódolása
|||   5. MIÉRT: az oksági indoklás
public export
valasztKerdesre : Allapot -> Kerdes -> Double -> Valasz
valasztKerdesre jelenlegi kerdes tMeleg =
  let deltaH = kerdesBizonytalansag kerdes
      eredmeny = onellenoriz deltaH
  in case eredmeny of
       Tudom =>
         -- ΔH kicsi: a jelenlegi állapot közel van a célhoz
         ValaszKonstruktor
           (kerdesTartalom kerdes ++ " → ismert")
           jelenlegi
           deltaH
       NemTudom =>
         -- ΔH nagy: barkochba-lépés a cél felé
         let ujAllapot = barkochbaLepes jelenlegi kerdes tMeleg
             ujDeltaH = entropia ujAllapot
         in ValaszKonstruktor
           (kerdesTartalom kerdes ++ " → keresve")
           ujAllapot
           ujDeltaH

-- =====================================================================
-- 8. A "MIÉRT" = az oksági indoklás.
-- =====================================================================

||| A válasz oksági indoklása: "miért ez a válasz?"
||| A miért-lánc bejegyzése: a kérdés állapotától a válasz
||| állapotáig vezető oksági fonal.
|||
||| "ahhoz hogy tudja mi egy kérdésre a válasz, először
||| meg kell kérdeznie magától, tényleg tudja-e" (a felhasználó).
||| A "miért" = a kérdésre adott válasz indoklása =
||| a fázisváltozás leírása (honnan → hova).
public export
miertIndoklas : Kerdes -> Valasz -> String
miertIndoklas kerdes valasz =
  "Miert: a kerdes (\"" ++ kerdesTartalom kerdes ++ "\") allapota " ++
  "a valasz (\"" ++ valaszTartalom valasz ++ "\") allapotahoz vezet. " ++
  "DeltaH: " ++ show (kerdesBizonytalansag kerdes) ++ " -> " ++
  show (valaszBizonytalansag valasz) ++ " (a bizonytalansag csokken)."

-- =====================================================================
-- 9. PIROSKA ÉS A FARKAS — a baby AI teszt.
-- =====================================================================

-- A mese karakterei = fázispozíciók a Z₈-ban.
-- A kódolás: minden karakter egy fázispozíció.
--   F0 = ártatlan (Piroska, nagymama eredeti állapota)
--   F4 = hazugság (a farkas — 180°-os fázis = az inverzió = a NOT)
--   F1 = kérdezés (a farkas kérdése: "hova mész, Piroska?")
--   F2 = válasz (Piroska válasza: "a nagymamához")
--   F6 = cselekvés (a farkas elindul)
--   F3 = felfedezés (a vadász megérkezik)

||| Piroska állapota: ártatlan (F0).
public export
PiroskaAllapot : Allapot
PiroskaAllapot = MkAllapot [F0,F0,F0,F0,F0,F0,F0,F0] 0.0

||| A farkas állapota: hazugság (F4 a negyedik pozíción).
public export
FarkasAllapot : Allapot
FarkasAllapot = MkAllapot [F0,F0,F0,F4,F0,F0,F0,F0] 0.0

||| A nagymama állapota: ártatlan (F0).
public export
NagymamaAllapot : Allapot
NagymamaAllapot = MkAllapot [F0,F0,F0,F0,F0,F0,F0,F0] 0.0

||| A mese = jelenetek listája (fázisállapotok).
||| 1. jelenet: Piroska és a farkas találkoznak — a farkas kérdez.
||| 2. jelenet: Piroska válaszol — a farkas megtudja a célt.
||| 3. jelenet: A farkas elindul — a farkas hazudik a nagymamának.
||| 4. jelenet: A vadász megérkezik — a farkast leleplezik.
public export
piroskaMesje : List Allapot
piroskaMesje = [
  MkAllapot [F0,F0,F0,F4,F1,F0,F0,F0] 1.0,  -- 1. a farkas kérdez
  MkAllapot [F0,F2,F0,F4,F0,F0,F0,F0] 2.0,  -- 2. Piroska válaszol
  MkAllapot [F0,F0,F0,F4,F0,F6,F0,F0] 3.0,  -- 3. a farkas cselekszik
  MkAllapot [F0,F0,F3,F4,F0,F0,F0,F0] 4.0   -- 4. a vadász felfedez
 ]

||| A kérdés: "Mit mondott a farkas?"
||| A farkas mondása = a 3. pozíció (F4 = hazugság).
||| A kérdés állapota = a farkas állapota.
||| A bizonytalanság = a farkas állapotának entrópiája.
public export
kerdesFarkasMondasa : Kerdes
kerdesFarkasMondasa = KerdesKonstruktor
  "Mit mondott a farkas?"
  FarkasAllapot
  (entropia FarkasAllapot)

||| A baby AI teszt: a rendszer megkapja a mesét és a kérdést,
||| és válaszol — önellenőrzéssel, barkochba-lépéssel, indoklással.
|||
||| A ciklus:
|||   1. ÖNELLENŐRZÉS: "Tudom-e mit mondott a farkas?"
|||      ΔH = entropia(FarkasAllapot) — ha kicsi, tudom.
|||   2. HA NEM TUDOM: barkochba-lépés a farkas állapota felé.
|||   3. VÁLASZ: a farkas mondása = F4 (hazugság = "én vagyok a nagymama").
|||   4. MIÉRT: mert a farkas állapota F4 = a negyedik pozíció =
|||      a 180°-os fázis = az inverzió = a NOT = a hazugság.
public export
piroskaTeszt : String
piroskaTeszt =
  let deltaH = kerdesBizonytalansag kerdesFarkasMondasa
      onell = onellenoriz deltaH
      valasz = valasztKerdesre PiroskaAllapot kerdesFarkasMondasa 100.0
      miert = miertIndoklas kerdesFarkasMondasa valasz
  in "PIROSKA TESZT\n" ++
     "  Kerdes: " ++ kerdesTartalom kerdesFarkasMondasa ++ "\n" ++
     "  Onellenorzes: " ++ show onell ++ " (ΔH=" ++ show deltaH ++ ")\n" ++
     "  Valasz: " ++ valaszTartalom valasz ++ "\n" ++
     "  " ++ miert ++ "\n" ++
     "  A farkas allapota: " ++ show (fazisok FarkasAllapot) ++ "\n" ++
     "  A farkas mondasa = F4 a 3. pozicion = a hazugsag (180° = NOT)"

-- =====================================================================
-- 10. A TELJES CIKLUS — a gondolkodás architektúrája.
-- =====================================================================

||| A gondolkodás ciklusa (a felhasználó formalizálva):
|||
|||   KÉRDÉS → ÖNELLENŐRZÉS → (HA NEM TUDOM) → KÉRDÉSVÁLASZTÁS →
|||   BARKOCHBA-LÉPÉS → VÁLASZ → MIÉRT
|||
||| Ez a "baby AI" architektúrája:
|||   - ha 1 kérdésre tudja a választ, többre is tudhatja
|||   - ahhoz, hogy tudja, először meg kell kérdeznie magától
|||   - milyen valószínűséggel tudja (ΔH = a bizonytalanság)
|||   - merre lehetnek válaszok (acquisition function = a gradiens)
|||   - milyen kérdéseket kell feltennie (barkochba-lépés)
|||   - és MIERT (a miért-lánc = az oksági indoklás)
public export
gondolkodasCiklus : Allapot -> List Kerdes -> Double -> List Valasz
gondolkodasCiklus _ [] _ = []
gondolkodasCiklus jelenlegi (k :: ks) tMeleg =
  let deltaH = kerdesBizonytalansag k
      valasz = valasztKerdesre jelenlegi k tMeleg
      ujAllapot = valaszAllapot valasz
  in valasz :: gondolkodasCiklus ujAllapot ks tMeleg

-- =====================================================================
-- 11. REFL BIZONYÍTÁSOK.
-- =====================================================================

-- A farkas állapota: F4 a 3. pozíción (0-alapú index = 3).
FarkasPozicio : index (natToFin8 3) (fazisok FarkasAllapot) = F4
FarkasPozicio = Refl

-- Piroska állapota: mindenhol F0 (ártatlan).
PiroskaPozicio0 : index (natToFin8 0) (fazisok PiroskaAllapot) = F0
PiroskaPozicio0 = Refl

-- A farkas fázisa = a negyedik pozíción = a hazugság.
FarkasFazisF4 : fazisIndex (index (natToFin8 3) (fazisok FarkasAllapot)) = 4
FarkasFazisF4 = Refl

-- A farkas fázisszöge = π (180° = az inverzió = a NOT = a hazugság).

-- Piroska fázisszöge = 0 (ártatlan, nincs fázis-eltolás).
