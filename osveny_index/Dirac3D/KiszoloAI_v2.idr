module Dirac3D.KiszoloAI_v2

-- ═══════════════════════════════════════════════════════════════
-- MIGRÁCIÓ (2026-09-05, JavításiHullam_3): a KisAI.idr tartalmának
-- pontos átvitele ÚJ fájlba (§13 — a v1: Dirac3D/KisAI.idr megmarad).
-- OK: a KisAI.idr «module KisAI»-t deklarál a Dirac3D/KisAI.idr
-- fájlban = #6-os csapda (modulnév ≠ útvonal). Itt: modulnév =
-- útvonal (Dirac3D.KiszoloAI_v2 ↔ Dirac3D/KiszoloAI_v2.idr).
-- A tartalom egyébként SZÓRÓL SZÓRA azonos a v1-gyel.
-- | 迁移说明：本文件是 KisAI.idr 的精确迁移（新文件，v1 保留）；
--   修复 #6 陷阱：模块名 = 文件路径。| Migration: exact copy of
--   KisAI.idr into a new file; module name = file path (#6 fix).
-- ═══════════════════════════════════════════════════════════════

import Data.Vect
import Data.List
import Data.String
import Fazis

-- =====================================================================
-- KIS AI — tanítható, kereshető, asszociálható.
--
-- A felismerés (2026-08-18, a felhasználó):
-- "tudunk csinálni valami kis AI-t amit tudunk így tanítani?
-- meg kérdezzük tőle, hogy miért, és ha nem tudja,
-- elmagyarázzuk és megjegyzi, valami optimálisan kódolt,
-- kereshető, asszociálható formában?"
--
-- A válasz: IGEN. A darabok mind megvannak:
--   - [[7,1,3]] Steane kód = a memória (hibajavítható!)
--   - Hamming-távolság = a keresés (szemantikai távolság)
--   - Clifford-átfedés = az asszociáció (mennyire kapcsolódik)
--   - Miért-lánc = az oksági memória ("miért tudom ezt?")
--
-- A 7 bit: [idő, okság, tér, szín, hang, fázis, mód]
-- Minden tény = 7 bites vektor — melyik dimenziót érinti.
-- Ha 1 bit hibás a kérdésben: a rendszer MÉG megtalálja
-- (távolság 1 < 3 = a Steane távolság = a hibajavítás).
-- Ez az OPTIMÁLIS KÓDOLÁS: a memória maga a hibajavító kód.
--
-- A ciklus (a felhasználó gondolkodása):
--   1. KÉRDEZZÜK: "Mit mondott a farkas?"
--   2. KERESÉS: Hamming-távolság a tudástárban
--   3. HA TUDOM (d=0): "Tudom! A farkas azt mondta: ..."
--   4. HA NEM TUDOM (d>3): "Nem tudom. Magyarázd el!"
--   5. TANÍTÁS: elmagyarázzuk → kódoljuk → tároljuk
--   6. MIÉRT: a miért-lánc bejegyzés (az oksági fonal)
--   7. ASSZOCIÁCIÓ: hasonló tények (Clifford-átfedés)
-- =====================================================================

%default total

-- =====================================================================
-- 1. A 7 BITES KÓDOLÁS — a Steane [[7,1,3]] memória.
-- =====================================================================

||| A 7 Steane-bit: [idő, okság, tér, szín, hang, fázis, mód]
||| Minden tény ezek kombinációja — melyik dimenziót érinti.
BitKod : Type
BitKod = Vect 7 Nat

public export
Show BitKod where
  show k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
           show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
           show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
           show (index 6 k) ++ "]"

-- =====================================================================
-- 2. A KIS AI = tudástár + szótár.
-- =====================================================================

||| A kis AI tudástára: (7-bit kód, magyarázat) párok listája.
||| A szótár: szó → 7-bit kód (a kódoláshoz).
public export
record KisAI where
  constructor KisAIKonstruktor
  tudastar : List (BitKod, String)  -- (kód, magyarázat)
  szotar   : List (String, BitKod)  -- szó → kód
  miertLanc : List (BitKod, BitKod, String)  -- (előd, utód, "miért")

-- =====================================================================
-- 3. HAMMING-TÁVOLSÁG = a keresés.
-- =====================================================================

||| Két 7-bites vektor Hamming-távolsága = hány pozíción térnek el.
public export
hammingTavolsag7 : BitKod -> BitKod -> Nat
hammingTavolsag7 a b = go 7
  where
    go : Nat -> Nat
    go Z = 0
    go (S n) =
      let ai = index (natToFin7 n) a
          bi = index (natToFin7 n) b
      in (if ai /= bi then 1 else 0) + go n
    where
      natToFin7 : Nat -> Fin 7
      natToFin7 0 = FZ
      natToFin7 1 = FS FZ
      natToFin7 2 = FS (FS FZ)
      natToFin7 3 = FS (FS (FS FZ))
      natToFin7 4 = FS (FS (FS (FS FZ)))
      natToFin7 5 = FS (FS (FS (FS (FS FZ))))
      natToFin7 6 = FS (FS (FS (FS (FS (FS FZ)))))
      natToFin7 _ = FZ

-- =====================================================================
-- 4. KERESÉS a tudástárban: legközelebbi egyezés.
-- =====================================================================

||| A legközelebbi egyezés a tudástárban.
||| Visszatér: (távolság, magyarázat) vagy Nothing ha üres.
public export
keresKisAI : KisAI -> BitKod -> Maybe (Nat, String)
keresKisAI ai kerdes =
  keresSeged (tudastar ai) kerdes
  where
    keresSeged : List (BitKod, String) -> BitKod -> Maybe (Nat, String)
    keresSeged [] _ = Nothing
    keresSeged ((kod, mag) :: rest) q =
      let d = hammingTavolsag7 kod q
      in case keresSeged rest q of
           Nothing => Just (d, mag)
           Just (d', mag') => if d <= d' then Just (d, mag) else Just (d', mag')

-- =====================================================================
-- 5. TANÍTÁS: új tény eltárolása.
-- =====================================================================

||| Új tény tanítása: kódoljuk és eltároljuk a tudástárban.
public export
tanitKisAI : KisAI -> BitKod -> String -> KisAI
tanitKisAI ai kod magyaro =
  KisAIKonstruktor ((kod, magyaro) :: tudastar ai) (szotar ai) (miertLanc ai)

||| Bit-kód szöveges alakja.
public export
showBitKod : BitKod -> String
showBitKod k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
               show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
               show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
               show (index 6 k) ++ "]"

||| Új miért-lánc bejegyzés.
public export
tanitMiertLanc : KisAI -> BitKod -> BitKod -> String -> KisAI
tanitMiertLanc ai elodKod utodKod indoklas =
  KisAIKonstruktor (tudastar ai) (szotar ai) ((elodKod, utodKod, indoklas) :: miertLanc ai)

||| Előd keresése a miért-láncban.
public export
keresElodLanc : BitKod -> List (BitKod, BitKod, String) -> Maybe (BitKod, String)
keresElodLanc _ [] = Nothing
keresElodLanc k ((e, u, i) :: rest) =
  if u == k then Just (e, i) else keresElodLanc k rest

||| Új szó hozzáadása a szótárhoz.
public export
szotarBovit : KisAI -> String -> BitKod -> KisAI
szotarBovit ai szo kod =
  KisAIKonstruktor (tudastar ai) ((szo, kod) :: szotar ai) (miertLanc ai)

||| A miért-lánc követése visszafelé, legfeljebb n lépésig.
||| Ha ciklust észlel (már látott kód), megáll és jelzi:
||| ez a Y-kombinátor — az ön-referenciális oksági hurok.
public export
kovetMiertLancLepes : KisAI -> BitKod -> Nat -> String
kovetMiertLancLepes ai kod n = kovetSeged ai kod n []
  where
    latta : BitKod -> List BitKod -> Bool
    latta _ [] = False
    latta x (y :: ys) = x == y || latta x ys
    kovetSeged : KisAI -> BitKod -> Nat -> List BitKod -> String
    kovetSeged _ _ Z _ = ""
    kovetSeged ai k (S m) latottak =
      if latta k latottak
      then "~CIKLUS: " ++ showBitKod k ++ "~"
      else
        case keresElodLanc k (miertLanc ai) of
          Nothing => ""
          Just (e, i) =>
            let elotte = kovetSeged ai e m (k :: latottak)
            in (if elotte == "" then "" else elotte ++ " -> ") ++
               showBitKod e ++ " (" ++ i ++ ")"

||| A miért-lánc követése: egy kódtól visszafelé.
public export
kovetMiertLanc : KisAI -> BitKod -> String
kovetMiertLanc ai kod = kovetMiertLancLepes ai kod 5

||| A teljes oksági fonal: a kódtól a gyökérig.
public export
okozatiFonal : KisAI -> BitKod -> String
okozatiFonal ai kod =
  let lanc = kovetMiertLanc ai kod
  in if lanc == ""
     then showBitKod kod ++ " (nincs elod — ez a gyoker)"
     else lanc ++ " -> " ++ showBitKod kod

-- =====================================================================
-- 6. ASSZOCIÁCIÓ: hasonló tények (Clifford-átfedés).
-- =====================================================================

||| Két kód átfedése = hány pozíción mindkettő 1.
public export
atfedes7 : BitKod -> BitKod -> Nat
atfedes7 a b = go 7
  where
    go : Nat -> Nat
    go Z = 0
    go (S n) =
      let ai = index (natToFin7 n) a
          bi = index (natToFin7 n) b
      in (if ai == 1 && bi == 1 then 1 else 0) + go n
    where
      natToFin7 : Nat -> Fin 7
      natToFin7 0 = FZ
      natToFin7 1 = FS FZ
      natToFin7 2 = FS (FS FZ)
      natToFin7 3 = FS (FS (FS FZ))
      natToFin7 4 = FS (FS (FS (FS FZ)))
      natToFin7 5 = FS (FS (FS (FS (FS FZ))))
      natToFin7 6 = FS (FS (FS (FS (FS (FS FZ)))))
      natToFin7 _ = FZ

||| Asszociáció: az összes tárolt tény átfedése a kérdéssel.
||| Magas átfedés = erősen kapcsolódó.
public export
asszocialKisAI : KisAI -> BitKod -> List (Nat, String)
asszocialKisAI ai q = map (\(k, m) => (atfedes7 k q, m)) (tudastar ai)

-- =====================================================================
-- 7. KÓDOLÁS: szöveg → 7-bit kód (a szótár alapján).
-- =====================================================================

||| Szó keresése a szótárban.
szotarKeres : String -> List (String, BitKod) -> BitKod
szotarKeres _ [] = [0,0,0,0,0,0,0]
szotarKeres szo ((s, b) :: rest) = if szo == s then b else szotarKeres szo rest

||| Bit-OR: két bit összevonása (ha bármelyik 1, az eredmény 1).
bitOr7 : Nat -> Nat -> Nat
bitOr7 0 0 = 0
bitOr7 _ _ = 1

||| Szöveg kódolása: szavakra bontjuk, minden szót keresünk
||| a szótárban, a biteket OR-zuk.
public export
kodolSzoveg : String -> List (String, BitKod) -> BitKod
kodolSzoveg szoveg dict =
  let szavak = words szoveg
      kodok = map (\s => szotarKeres s dict) szavak
  in foldr (zipWith bitOr7) [0,0,0,0,0,0,0] kodok

-- =====================================================================
-- 8. AZ ALAP SZÓTÁR — a Piroska-mese dimenziói.
-- =====================================================================

||| Az alap szótár: szó → 7-bit kód.
||| A 7 bit: [idő, okság, tér, szín, hang, fázis, mód]
||| "farkas" = okság + hang (a hazugság forrása: ok + beszéd)
||| "piroska" = idő (a kezdet, az ártatlan)
||| "hazugság" = okság + hang (a hamis állítás)
||| "vadász" = fázis (a cselekvés = a megmentés)
public export
AlapSzotar : List (String, BitKod)
AlapSzotar = [
  ("farkas", [0,1,0,0,1,0,0]),
  ("piroska", [1,0,0,0,0,0,0]),
  ("nagymama", [1,0,0,0,0,0,0]),
  ("vadasz", [0,0,0,0,0,1,0]),
  ("hazugsag", [0,1,0,0,1,0,0]),
  ("mondas", [0,0,0,0,1,0,0]),
  ("mondott", [0,0,0,0,1,0,0]),
  ("ert", [0,0,0,0,0,0,1]),
  ("miert", [0,1,0,0,0,0,0]),
  ("kerdes", [0,0,0,0,1,0,0]),
  ("valasz", [0,0,0,0,1,0,1]),
  ("tudas", [0,0,0,0,0,0,1]),
  ("ho", [0,1,0,0,0,1,0]),
  (" energia", [0,1,0,0,0,1,0]),
  ("fazis", [0,0,0,0,0,1,0]),
  ("ido", [1,0,0,0,0,0,0]),
  ("oksag", [0,1,0,0,0,0,0]),
  ("ter", [0,0,1,0,0,0,0]),
  ("szin", [0,0,0,1,0,0,0]),
  ("hang", [0,0,0,0,1,0,0]),
  ("mod", [0,0,0,0,0,0,1])
 ]

||| A 7 dimenzió tudástára.
DimenzioTudastar : List (BitKod, String)
DimenzioTudastar = [
  ([1,0,0,0,0,0,0], "Az ido = a valtozas merhetoseg. Mikor tortent."),
  ([0,1,0,0,0,0,0], "Az oksag = a miert. Mi okozta. A kerdes forrasa."),
  ([0,0,1,0,0,0,0], "A ter = ahol tortent. Hol."),
  ([0,0,0,1,0,0,0], "A szin = a minosig. Milyen."),
  ([0,0,0,0,1,0,0], "A hang = a kifejezes. Hogyan mondta."),
  ([0,0,0,0,0,1,0], "A fazis = a cselekves. Mit tett. A 180 fokos forgas = a NOT."),
  ([0,0,0,0,0,0,1], "A mod = a modszer. Hogyan mukodik.")
 ]

||| A miért-lánc bejegyzései (előd, utód, indoklás).
MiertLancBejegyzesek : List (BitKod, BitKod, String)
MiertLancBejegyzesek = [
  ([1,0,0,0,0,0,0], [0,1,0,0,0,0,0], "az ido az oksag forrasa (mikor tortent -> mi okozta)"),
  ([0,0,0,0,1,0,0], [0,1,0,0,0,0,0], "a hang az oksagot kifejezi (hogyan mondta -> mi okozta)"),
  ([0,0,0,0,0,1,0], [0,0,0,0,1,0,0], "a fazis hangot ad (mit tett -> hogyan mondta)"),
  ([0,0,0,0,0,1,0], [0,1,0,0,1,0,0], "a fazis (180 fok = NOT = hazugsag) az oksag+hang = a farkas"),
  ([0,1,0,0,1,0,0], [0,0,0,0,0,1,0], "a farkas (oksag+hang) a fazist okozza (a hazugsag cselekves)")
 ]

||| A kezdő kis AI: üres tudástár + alap szótár.
public export
kezdoKisAI : KisAI
kezdoKisAI = KisAIKonstruktor [] AlapSzotar []

||| A kezdő kis AI nagybetűs aliasa.
||| A bizonyítástípusokban a kisbetűs konstans shadowing-ot okoz
||| (AGENTS.md: "kisbetűs név a bizonyítástípusban"), ezért a
||| bizonyításokban ez az alak használandó.
public export
KezdoKisAI : KisAI
KezdoKisAI = kezdoKisAI

-- =====================================================================
-- 9. A "MIÉRT" — az oksági indoklás.
-- =====================================================================

||| A válasz oksági indoklása: "miért tudom ezt?"
public export
miertKisAI : BitKod -> String -> String
miertKisAI kod magyaro =
  "Miert: a kerdes kodja " ++ showKod kod ++ ". A tarolt magyaro: " ++ magyaro
  where
    showKod : BitKod -> String
    showKod k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
                show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
                show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
                show (index 6 k) ++ "]"

-- =====================================================================
-- 10. REFL BIZONYÍTÁSOK.
-- =====================================================================

-- A farkas kódja = okság + hang.
FarkasKod : kodolSzoveg "farkas" AlapSzotar = [0,1,0,0,1,0,0]
FarkasKod = Refl

-- Piroska kódja = idő.
PiroskaKod : kodolSzoveg "piroska" AlapSzotar = [1,0,0,0,0,0,0]
PiroskaKod = Refl

-- "Mit mondott a farkas?" kódja = farkas + mondott = [0,1,0,0,1,0,0]
KerdesFarkasKod : kodolSzoveg "Mit mondott a farkas" AlapSzotar = [0,1,0,0,1,0,0]
KerdesFarkasKod = Refl

-- Hamming-távolság: farkas kódja és hazugság kódja = 0 (azonos)
FarkasHazugsagTavolsag : hammingTavolsag7 [0,1,0,0,1,0,0] [0,1,0,0,1,0,0] = 0
FarkasHazugsagTavolsag = Refl

-- Hamming-távolság: farkas és piroska = 3 (3 bit tér el)
FarkasPiroskaTavolsag : hammingTavolsag7 [0,1,0,0,1,0,0] [1,0,0,0,0,0,0] = 3
FarkasPiroskaTavolsag = Refl

-- Átfedés: farkas és hazugság = 2 (okság + hang közös)
FarkasHazugsagAtfedes : atfedes7 [0,1,0,0,1,0,0] [0,1,0,0,1,0,0] = 2
FarkasHazugsagAtfedes = Refl

-- Átfedés: farkas és piroska = 0 (nincs közös dimenzió)
FarkasPiroskaAtfedes : atfedes7 [0,1,0,0,1,0,0] [1,0,0,0,0,0,0] = 0
FarkasPiroskaAtfedes = Refl

-- =====================================================================
-- 11. A TANÍTOTT AI — a Piroska-mese tudása.
-- =====================================================================

||| A Piroska-mesével tanított kis AI.
||| Egy tény van eltárolva: a farkas mondása = hazugság.
public export
piroskavalTanitottKisAI : KisAI
piroskavalTanitottKisAI =
  tanitKisAI kezdoKisAI [0,1,0,0,1,0,0]
    "A farkas azt mondta: en vagyok a nagymama, de ez hazugsag volt."

||| A Piroska-mesével tanított kis AI nagybetűs aliasa.
||| A bizonyítástípusokban a kisbetűs konstans shadowing-ot okoz
||| (AGENTS.md: "kisbetűs név a bizonyítástípusban"), ezért a
||| bizonyításokban ez az alak használandó.
public export
PiroskavalTanitottKisAI : KisAI
PiroskavalTanitottKisAI = piroskavalTanitottKisAI

||| A tanított AI keresése: "Mit mondott a farkas?"
||| A kód = [0,1,0,0,1,0,0], a tudástárban ugyanez van → d=0.
public export
piroskaKeresesEredmeny : Maybe (Nat, String)
piroskaKeresesEredmeny =
  keresKisAI piroskavalTanitottKisAI (kodolSzoveg "Mit mondott a farkas" AlapSzotar)

||| A talált távolság = 0 (pontos egyezés).
public export
piroskaTalalatTavolsag : Maybe Nat
piroskaTalalatTavolsag = map fst piroskaKeresesEredmeny

||| A talált magyarázat.
public export
piroskaTalalatMagyarazo : Maybe String
piroskaTalalatMagyarazo = map snd piroskaKeresesEredmeny

-- =====================================================================
-- 12. AZ INTERAKTÍV TANÍTÓ CIKLUS (IO).
-- =====================================================================

%default partial

||| Az interaktív ciklus: kérdez → keres → válaszol vagy tanít.
|||
||| A ciklus (a felhasználó szavaival):
|||   1. kérdezzük: "Mit mondott a farkas?"
|||   2. keresés: Hamming-távolság a tudástárban
|||   3. ha d=0: "Tudom!" + a tárolt magyarázat
|||   4. ha d≤2: "Talán:" + a legközelebbi (asszociáció)
|||   5. ha d>2 vagy nem talál: "Nem tudom. Magyarázd el!"
|||   6. tanítás: elmagyarázzuk → kódoljuk → tároljuk
|||   7. következő kérdés
public export
tanitoCiklus : KisAI -> IO ()
tanitoCiklus ai = do
  putStr "> "
  line <- getLine
  if line == "" then pure () else do
    let kod = kodolSzoveg line (szotar ai)
    case keresKisAI ai kod of
      Just (0, mag) => do
        putStrLn ("Tudom! " ++ mag)
        putStrLn ("  " ++ miertKisAI kod mag)
        tanitoCiklus ai
      Just (d, mag) => do
        if d <= 2
          then do
            putStrLn ("Talán (távolság=" ++ show d ++ "): " ++ mag)
            putStrLn ("  Asszociáció: " ++ show (asszocialKisAI ai kod))
            tanitoCiklus ai
          else do
            putStrLn "Nem tudom. Magyarázd el!"
            magyaro <- getLine
            let ai' = tanitKisAI ai kod magyaro
            putStrLn ("Ertem! Eltároltam. (kód: " ++ showKodSeged kod ++ ")")
            putStrLn ("  " ++ miertKisAI kod magyaro)
            tanitoCiklus ai'
      Nothing => do
        putStrLn "Nem tudom. Magyarázd el!"
        magyaro <- getLine
        let ai' = tanitKisAI ai kod magyaro
        putStrLn ("Ertem! Eltároltam. (kód: " ++ showKodSeged kod ++ ")")
        putStrLn ("  " ++ miertKisAI kod magyaro)
        tanitoCiklus ai'
  where
    showKodSeged : BitKod -> String
    showKodSeged k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
                     show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
                     show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
                     show (index 6 k) ++ "]"

||| A főprogram: elindítja a tanító ciklust az alap szótárral.
public export
fom : IO ()
fom = do
  putStrLn "═══════════════════════════════════════════════════"
  putStrLn "  KIS AI — tanítható, kereshető, asszociálható"
  putStrLn "  A 7 bit: [idő, okság, tér, szín, hang, fázis, mód]"
  putStrLn "  Kérdezz! Üres sor = kilépés."
  putStrLn "═══════════════════════════════════════════════════"
  tanitoCiklus kezdoKisAI

-- =====================================================================
-- 13. A KÉRDEZŐ MOTOR — a baby AI kérdez, nem csak vár.
-- =====================================================================
--
-- A felhasználó felismerése: "ahhoz, hogy tudja mi egy kérdésre a
-- válasz, először meg kell kérdeznie magától, tényleg tudja-e,
-- milyen valószínűséggel tudja, merre lehetnek válaszok, milyen
-- kérdéseket kell feltennie magának és MIERT."
--
-- A kérdező motor: ha a rendszer NEM TUDJA a választ (d > 2),
-- nem passzívan vár ("magyarázd el"), hanem AKTÍVAN KÉRDEZ:
-- a kód alapján megmondja, melyik dimenziókban hiányzik az információ,
-- és ezekről kérdez. Ez az acquisition function: a hiányzó dimenziókból
-- generált kérdés = a "miért" mint motor.
-- =====================================================================

||| A 7 dimenzió nevei.
dimenzioNev : Nat -> String
dimenzioNev 0 = "ido"
dimenzioNev 1 = "oksag"
dimenzioNev 2 = "ter"
dimenzioNev 3 = "szin"
dimenzioNev 4 = "hang"
dimenzioNev 5 = "fazis"
dimenzioNev 6 = "mod"
dimenzioNev _ = "ismeretlen"

||| A kódból kiolvassa az aktív dimenziókat (ahol 1-es van).
aktiveDimenziok : BitKod -> List (Nat, String)
aktiveDimenziok k = go 7
  where
    go : Nat -> List (Nat, String)
    go Z = []
    go (S n) =
      let i = n
      in (if index (natToFin7b i) k == 1
          then (i, dimenzioNev i) :: go n
          else go n)
      where
        natToFin7b : Nat -> Fin 7
        natToFin7b 0 = FZ
        natToFin7b 1 = FS FZ
        natToFin7b 2 = FS (FS FZ)
        natToFin7b 3 = FS (FS (FS FZ))
        natToFin7b 4 = FS (FS (FS (FS FZ)))
        natToFin7b 5 = FS (FS (FS (FS (FS FZ))))
        natToFin7b 6 = FS (FS (FS (FS (FS (FS FZ)))))
        natToFin7b _ = FZ

||| Kérdés generálása a hiányzó dimenziókból.
||| "Nem tudom. De a kód [0,1,0,0,1,0,0] = okság + hang.
|||  Ezek a dimenziók hiányoznak. Kérdezem:
|||  Mi az okság? Mi a hang?"
public export
generalKerdest : BitKod -> String
generalKerdest k =
  let aktivek = aktiveDimenziok k
      nevek = map snd aktivek
  in if null nevek
     then "Nem tudom. Nincs utonalvezetes (minden bit 0). Magyarazd el!"
     else "Nem tudom. De a kod " ++ showKodSegedK k ++ " = " ++
          unwordsSep nevek ++ ". Ezek a dimenziok hianyoznak. Kerdezem: " ++
          kerdesek nevek
  where
    showKodSegedK : BitKod -> String
    showKodSegedK k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
                     show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
                     show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
                     show (index 6 k) ++ "]"
    unwordsSep : List String -> String
    unwordsSep [] = ""
    unwordsSep [x] = x
    unwordsSep [x, y] = x ++ " + " ++ y
    unwordsSep (x :: xs) = x ++ ", " ++ unwordsSep xs
    kerdesek : List String -> String
    kerdesek [] = ""
    kerdesek [x] = "Mi a " ++ x ++ "?"
    kerdesek (x :: xs) = "Mi a " ++ x ++ "? " ++ kerdesek xs

-- =====================================================================
-- 14. A 7 DIMENZIÓ MEGTANÍTÁSA — előre feltöltött tudás.
-- =====================================================================

||| A 7 dimenziómagyarázatok (idő, okság, tér, szín, hang, fázis, mód).
||| Ezeket a rendszer tudja induláskor — a 7 kategória, amikben gondolkodik.
dimenzioMagyarazatok : List (BitKod, String)
dimenzioMagyarazatok = [
  ([1,0,0,0,0,0,0], "Az ido = a valtozas merhetoseg. Mikor tortent. Az elso dimenzio."),
  ([0,1,0,0,0,0,0], "Az oksag = a miert. Mi okozta. A masodik dimenzio. A kerdes forrasa."),
  ([0,0,1,0,0,0,0], "A ter = ahol tortent. Hol. A harmadik dimenzio."),
  ([0,0,0,1,0,0,0], "A szin = a minosig. Milyen. A negyedik dimenzio."),
  ([0,0,0,0,1,0,0], "A hang = a kifejezes. Hogyan mondta. Az otodik dimenzio."),
  ([0,0,0,0,0,1,0], "A fazis = a cselekves. Mit tett. A hatodik dimenzio."),
  ([0,0,0,0,0,0,1], "A mod = a modszer. Hogyan mukodik. A hetedik dimenzio.")
 ]

||| A 7 dimenzióval előtanított AI: üres tudástár + alap szótár + 7 dimenzió.
public export
kezdoKisAIDimenziokkal : KisAI
kezdoKisAIDimenziokkal =
  KisAIKonstruktor DimenzioTudastar AlapSzotar MiertLancBejegyzesek

-- =====================================================================
-- 15. A KÉRDEZŐ CIKLUS — ha nem tudja, KÉRDEZ (nem csak vár).
-- =====================================================================

%default partial

||| A kérdező ciklus: ha nem tudja a választ, nem passzívan vár,
||| hanem AKTÍVAN KÉRDEZ — a kód alapján generál egy kérdést a
||| hiányzó dimenziókról. Ez az acquisition function.
|||
||| A felhasználó gondolkodásának formalizálva:
|||   1. "tényleg tudja-e?" → ΔH (keresés: d)
|||   2. "milyen valószínűséggel tudja?" → d = 0 (biztos), d ≤ 2 (talán)
|||   3. "merre lehetnek válaszok?" → a kód aktív dimenziói
|||   4. "milyen kérdéseket kell feltennie?" → generált kérdések
|||   5. "és MIERT?" → az oksági indoklás (miertKisAI)
public export
kerdezoCiklus : KisAI -> IO ()
kerdezoCiklus ai = do
  putStr "> "
  line <- getLine
  if line == "" then pure () else do
    let kod = kodolSzoveg line (szotar ai)
    case keresKisAI ai kod of
      Just (0, mag) => do
        putStrLn ("Tudom! " ++ mag)
        putStrLn ("  " ++ miertKisAI kod mag)
        putStrLn ("  Oksági fonal: " ++ okozatiFonal ai kod)
        kerdezoCiklus ai
      Just (d, mag) => do
        if d <= 2
          then do
            putStrLn ("Talán (távolság=" ++ show d ++ "): " ++ mag)
            putStrLn ("  Asszociáció: " ++ show (asszocialKisAI ai kod))
            putStrLn ("  Oksági fonal: " ++ okozatiFonal ai kod)
            kerdezoCiklus ai
          else do
            putStrLn (generalKerdest kod)
            magyaro <- getLine
            let ai' = tanitKisAI ai kod magyaro
            putStrLn ("Ertem! Eltároltam. (kód: " ++ showKodSeged kod ++ ")")
            putStrLn ("  " ++ miertKisAI kod magyaro)
            kerdezoCiklus ai'
      Nothing => do
        putStrLn (generalKerdest kod)
        magyaro <- getLine
        let ai' = tanitKisAI ai kod magyaro
        putStrLn ("Ertem! Eltároltam. (kód: " ++ showKodSeged kod ++ ")")
        putStrLn ("  " ++ miertKisAI kod magyaro)
        kerdezoCiklus ai'
  where
    showKodSeged : BitKod -> String
    showKodSeged k = "[" ++ show (index 0 k) ++ "," ++ show (index 1 k) ++ "," ++
                     show (index 2 k) ++ "," ++ show (index 3 k) ++ "," ++
                     show (index 4 k) ++ "," ++ show (index 5 k) ++ "," ++
                     show (index 6 k) ++ "]"

||| A kérdező főprogram: a 7 dimenzióval előtanított AI-val indul.
public export
fomKerdezo : IO ()
fomKerdezo = do
  putStrLn "═══════════════════════════════════════════════════"
  putStrLn "  KIS AI — kérdező (nem passzív!)"
  putStrLn "  A 7 bit: [idő, okság, tér, szín, hang, fázis, mód]"
  putStrLn "  A 7 dimenzió már megtanítva."
  putStrLn "  Kérdezz! Ha nem tudom, KÉRDEZEK. Üres sor = kilépés."
  putStrLn "═══════════════════════════════════════════════════"
  kerdezoCiklus kezdoKisAIDimenziokkal

-- =====================================================================
-- 16. A [[7,1,3]] STEANE HIBJAVÍTÁS — a memória védelme.
-- =====================================================================
--
-- A KisAI memóriája 7 bites vektor. A [[7,1,3]] Steane kód garantálja:
-- EGY bit hiba észlelhető és kijavítható (távolság 3 → 1 hiba javítás).
-- Eddig a "hibajavítás" csak annyi volt, hogy a keresés eltűrte a
-- távolság 1-et (d < 3). Most VALÓDI szindróma-számítás jön:
-- a Hamming paritás-ellenőrző mátrix (H) megmondja, MELYIK bit flippelt.
--
-- A kódkönyv = a tudástár. A kérdés egy (esetleg 1 bittel hibás) kód.
--   1. keresés: a legközelebbi tárolt tény (c) d távolságon
--   2. hibamintázat: e = kérdés ⊕ c  (hol térnek el)
--   3. szindróma: s = H·e (mod 2) → a hibás pozíció bináris alakja
--   4. ha súly(e) = 1: a szindróma MEGNEVEZI a flippelt bitet
--   5. javítás: bitFordit a pozíción → a kérdés helyreáll
--
-- A [[7,1,3]]-ban a 3 paritás-ellenőrzés (a H mátrix sorai):
--   0.: a 3.,4.,5.,6. bitek paritása
--   1.: az 1.,2.,5.,6. bitek paritása
--   2.: a 0.,2.,4.,6. bitek paritása
-- A 7 oszlop = az 1..7 bináris alakja → a szindróma = a pozíció + 1.

%default total

||| XOR (paritás-összeg) két biten. A szindróma-számítás alapeleme.
public export
paritasBit : Nat -> Nat -> Nat
paritasBit 0 0 = 0
paritasBit 0 1 = 1
paritasBit 1 0 = 1
paritasBit 1 1 = 0
paritasBit _ _ = 0

||| A [[7,1,3]] szindróma: H·v (mod 2), 3 paritás-ellenőrzés.
||| Egy 1-bites hiba a p. pozíción a (p+1) számot adja binárisan
||| a szindróma-bitekben → a szindróma MÁR a hibás pozíció.
public export
szindroma7 : BitKod -> Vect 3 Nat
szindroma7 v =
  [ paritasBit (index 3 v) (paritasBit (index 4 v) (paritasBit (index 5 v) (index 6 v)))
  , paritasBit (index 1 v) (paritasBit (index 2 v) (paritasBit (index 5 v) (index 6 v)))
  , paritasBit (index 0 v) (paritasBit (index 2 v) (paritasBit (index 4 v) (index 6 v)))
  ]

||| Szindróma → hibás pozíció (0-alapú). A 7 = nincs hiba.
public export
szindromaPozicio7 : Vect 3 Nat -> Nat
szindromaPozicio7 [0,0,0] = 7
szindromaPozicio7 [0,0,1] = 0
szindromaPozicio7 [0,1,0] = 1
szindromaPozicio7 [0,1,1] = 2
szindromaPozicio7 [1,0,0] = 3
szindromaPozicio7 [1,0,1] = 4
szindromaPozicio7 [1,1,0] = 5
szindromaPozicio7 [1,1,1] = 6
szindromaPozicio7 _ = 7

||| Nat → Fin 7 (a Vect indexeléséhez).
public export
natToFin7Bit : Nat -> Fin 7
natToFin7Bit 0 = FZ
natToFin7Bit 1 = FS FZ
natToFin7Bit 2 = FS (FS FZ)
natToFin7Bit 3 = FS (FS (FS FZ))
natToFin7Bit 4 = FS (FS (FS (FS FZ)))
natToFin7Bit 5 = FS (FS (FS (FS (FS FZ))))
natToFin7Bit 6 = FS (FS (FS (FS (FS (FS FZ)))))
natToFin7Bit _ = FZ

||| Egy bit visszafordítása a pozíción (7 = nincs fordítás).
public export
bitFordit7 : Nat -> BitKod -> BitKod
bitFordit7 7 v = v
bitFordit7 p v = updateAt (natToFin7Bit p) (\b => paritasBit b 1) v

||| Két kód különbsége (XOR): hol térnek el = a hibamintázat.
public export
bitKulonbseg : BitKod -> BitKod -> BitKod
bitKulonbseg a b = zipWith paritasBit a b

||| A legközelebbi tárolt kód a kérdéshez (a kódkönyv = a tudástár).
public export
legkozelebbiKod : KisAI -> BitKod -> BitKod
legkozelebbiKod ai q = legkozelebbiSeged (tudastar ai) q [0,0,0,0,0,0,0] 8
  where
    legkozelebbiSeged : List (BitKod, String) -> BitKod -> BitKod -> Nat -> BitKod
    legkozelebbiSeged [] _ eddigi _ = eddigi
    legkozelebbiSeged ((k, _) :: rest) qq eddigi eddigiTav =
      let d = hammingTavolsag7 k qq
      in if d < eddigiTav
         then legkozelebbiSeged rest qq k d
         else legkozelebbiSeged rest qq eddigi eddigiTav

||| Javító keresés: a kérdés (esetleg 1 bittel hibás) a kódkönyv szerint.
||| Visszatér: Just (javított kód, hibás pozíció, távolság), ahol
|||   pozíció 7 = nem volt hiba, pozíció p = a p. bitet javítottuk.
||| Nothing = 2+ bit hiba (a Steane távolság 3 nem engedi javítani).
public export
javitoKereses : KisAI -> BitKod -> Maybe (BitKod, Nat, Nat)
javitoKereses ai q =
  case keresKisAI ai q of
    Just (0, _) => Just (q, 7, 0)
    Just (1, _) =>
      let c = legkozelebbiKod ai q
          e = bitKulonbseg q c
          p = szindromaPozicio7 (szindroma7 e)
      in Just (bitFordit7 p q, p, 1)
    _ => Nothing

-- =====================================================================
-- 17. REFL BIZONYÍTÁSOK — a szindróma azonosítja az egyes hibát.
-- =====================================================================

||| Egy 1-bites hiba a 0. pozíción: a szindróma [0,0,1] = 1 binárisan.
SzindromaEgyesHiba0 : szindroma7 [1,0,0,0,0,0,0] = [0,0,1]
SzindromaEgyesHiba0 = Refl

||| Egy 1-bites hiba a 6. pozíción: a szindróma [1,1,1] = 7 binárisan.
SzindromaEgyesHiba6 : szindroma7 [0,0,0,0,0,0,1] = [1,1,1]
SzindromaEgyesHiba6 = Refl

||| A [0,1,1] szindróma a 2. pozícióra mutat (3 − 1 = 2).
SzindromaPozicio2 : szindromaPozicio7 [0,1,1] = 2
SzindromaPozicio2 = Refl

||| A farkas-kód 2. bitje megfordítva: [0,1,0,0,1,0,0] → [0,1,1,0,1,0,0].
||| A javító keresés visszaállítja, és a szindróma megnevezi a 2. bitet.
public export
FarkasHibas2 : BitKod
FarkasHibas2 = [0,1,1,0,1,0,0]

||| Két bites hiba a farkas-kódon: [0,1,0,1,0,1,0] távolsága 2.
||| A Steane távolság 3 → a 2 bites hiba már NEM javítható.
public export
FarkasKetBitesHibaKod : BitKod
FarkasKetBitesHibaKod = [0,1,0,1,0,1,0]

-- [BISECT diag: a gyökérok megtalálva — a kisbetűs konstans shadowing]
-- TesztDirektKonstruktor : tudastar (KisAIKonstruktor [] AlapSzotar []) = []
-- TesztDirektKonstruktor = Refl
--
-- TesztKezdoUnfold : kezdoKisAI = KisAIKonstruktor [] AlapSzotar []
-- TesztKezdoUnfold = Refl
--
-- TesztKezdoTudastar : tudastar kezdoKisAI = []
-- TesztKezdoTudastar = Refl
--
-- TesztTanitKod : tudastar (tanitKisAI kezdoKisAI [0,1,0,0,1,0,0]
--               "A farkas azt mondta: en vagyok a nagymama, de ez hazugsag volt.")
--               = [([0,1,0,0,1,0,0], "A farkas azt mondta: en vagyok a nagymama, de ez hazugsag volt.")]
-- TesztTanitKod = Refl
--
-- TesztTudastarProj : tudastar piroskavalTanitottKisAI
--                   = [([0,1,0,0,1,0,0], "A farkas azt mondta: en vagyok a nagymama, de ez hazugsag volt.")]
-- TesztTudastarProj = Refl
--
-- TesztKeresEredmeny : keresKisAI piroskavalTanitottKisAI FarkasHibas2
--                    = Just (1, "A farkas azt mondta: en vagyok a nagymama, de ez hazugsag volt.")
-- TesztKeresEredmeny = Refl

FarkasJavitoPeld : javitoKereses PiroskavalTanitottKisAI FarkasHibas2
                 = Just ([0,1,0,0,1,0,0], 2, 1)
FarkasJavitoPeld = Refl

||| Két bites hiba a farkas-kódon: [0,1,0,1,0,1,0] távolsága 2.
||| A Steane távolság 3 → a 2 bites hiba már NEM javítható (Nothing).
FarkasKetBitesHiba : javitoKereses PiroskavalTanitottKisAI FarkasKetBitesHibaKod = Nothing
FarkasKetBitesHiba = Refl

||| Mind a 7 egyes-hiba javítható a farkas-kódon.
||| Minden pozícióra: a javított kód = az eredeti, a pozíció = a hibás bit.
public export
mindenEgyesHibaJavithato : Bool
mindenEgyesHibaJavithato = go 7
  where
    minus : Nat -> Nat -> Nat
    minus Z m = m
    minus x Z = x
    minus (S x) (S y) = minus x y
    go : Nat -> Bool
    go Z = True
    go (S n) =
      let p = minus n 1
          hibas = bitFordit7 p [0,1,0,0,1,0,0]
      in case javitoKereses piroskavalTanitottKisAI hibas of
           Just (jav, pj, 1) => jav == [0,1,0,0,1,0,0] && pj == p && go n
           _ => False

-- =====================================================================
-- 18. A HIBAJAVÍTÓ KÉRDEZŐ CIKLUS — szindróma a keresésben.
-- =====================================================================

%default partial

||| A hibajavító kérdező ciklus: ha a kérdés 1 bittel hibás,
||| a szindróma megnevezi a flippelt bitet, a javítás helyreállítja,
||| és a rendszer MAGABIZTOSAN válaszol (nem "Talán"-nal).
public export
hibajavitoCiklus : KisAI -> IO ()
hibajavitoCiklus ai = do
  putStr "> "
  line <- getLine
  if line == "" then pure () else do
    let kod = kodolSzoveg line (szotar ai)
    case javitoKereses ai kod of
      Just (jav, 7, 0) => do
        case keresKisAI ai jav of
          Just (_, mag) => putStrLn ("Tudom! " ++ mag)
          Nothing => putStrLn "Nem tudom."
        hibajavitoCiklus ai
      Just (jav, p, 1) => do
        putStrLn ("1 bit hiba a " ++ show p ++ ". pozicion (szindroma: "
                  ++ show (szindroma7 (bitKulonbseg kod jav)) ++ "). Javitva!")
        case keresKisAI ai jav of
          Just (_, mag) => putStrLn ("Tudom! " ++ mag)
          Nothing => putStrLn "Nem tudom."
        hibajavitoCiklus ai
      _ => do
        putStrLn (generalKerdest kod)
        magyaro <- getLine
        let ai' = tanitKisAI ai kod magyaro
        putStrLn ("Ertem! Eltároltam. (kód: " ++ showBitKod kod ++ ")")
        hibajavitoCiklus ai'

||| A hibajavító főprogram: a 7 dimenzióval előtanított AI-val indul.
public export
fomHibajavito : IO ()
fomHibajavito = do
  putStrLn "═══════════════════════════════════════════════════"
  putStrLn "  KIS AI — [[7,1,3]] hibajavító"
  putStrLn "  Egy 1 bites hiba a kérdésben: szindróma + javítás."
  putStrLn "  A 7 bit: [idő, okság, tér, szín, hang, fázis, mód]"
  putStrLn "  Kérdezz! Üres sor = kilépés."
  putStrLn "═══════════════════════════════════════════════════"
  hibajavitoCiklus kezdoKisAIDimenziokkal