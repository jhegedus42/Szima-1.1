module Kereso

-- ═══════════════════════════════════════════════════════════════
-- KERESO — Magyar kerdes → valasz (bilingual szovegbol)
-- ═══════════════════════════════════════════════════════════════
-- A Carnot-ciklus harmadik lepese: kereses (munka) → valasz (energia).
-- A kerdest kodoljuk (Kodol.kodol), a szoveg minden mondatjat is,
-- es a legkisebb tavolsagu mondat a valasz.
-- Vesztesegmentes: a valasz = a megtalalt mondat szovege.
-- Determinisztikus: ugyanaz a kerdes → ugyanaz a valasz.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import MagyarNyelvtan
import Kodol
import Tavolsag

import System.File

-- ─── 1. QUADLINGUAL MONDAT ──────────────────────────────────

||| Egy quadlingual mondat: magyar + angol + latin + kinai + forras.
||| A három nyelv = három reprezentáció:
|||   latin (R, skalár)   = struktúra (mit mond?)
|||   magyar (O, oktonion) = dinamika (hogyan kérdezek?)
|||   kinai (spinor)      = kontextus (milyen kontextusban?)
||| A magyar mondatbol kodoljuk az E8E8KodSzo-t.
public export
record QuadlingualMondat where
  constructor QuadlingualKonstruktor
  magyar  : String
  angol   : String
  latin   : String
  kinai   : String
  forras  : String
  kodSzo  : E8E8KodSzo

-- ─── 2. SZOVEG PARSZOLASA ───────────────────────────────────

||| Egy sorbol a cimke kinyerese: "HU: valami" → "valami"
public export
cimkeKinyer : String -> String
cimkeKinyer s =
  let cs = unpack s
  in  case cs of
        (_ :: _ :: _ :: ' ' :: marad) => pack marad
        _ => s

||| HU:/EN:/LA:/ZH:/SRC: formatum parszolasa List QuadlingualMondat-ta.
||| A bemenet a awodey_quadlingual_ch1.txt fajl tartalma.
public export
data ParseAllapot = VarHU | VarEN | VarLA | VarZH | VarSRC | Keszen

||| Sor tipusanak felismerese.
public export
sorTipus : String -> ParseAllapot
sorTipus s =
  let cs = unpack s
  in  case cs of
        ('H' :: 'U' :: ':' :: _) => VarHU
        ('E' :: 'N' :: ':' :: _) => VarEN
        ('L' :: 'A' :: ':' :: _) => VarLA
        ('Z' :: 'H' :: ':' :: _) => VarZH
        ('S' :: 'R' :: 'C' :: ':' :: _) => VarSRC
        _ => Keszen

||| Sorok parszolasa QuadlingualMondat listava.
public export
parszol : List String -> List QuadlingualMondat
parszol sorok = go sorok "" "" "" "" ""
  where
    go : List String -> String -> String -> String -> String -> String -> List QuadlingualMondat
    go [] hu en la zh src =
      if hu /= "" && en /= ""
        then [QuadlingualKonstruktor hu en la zh src (kodol hu)]
        else []
    go (s :: ss) hu en la zh src =
      case sorTipus s of
        VarHU =>
          (if hu /= "" && en /= ""
             then [QuadlingualKonstruktor hu en la zh src (kodol hu)]
             else []) ++
          go ss (cimkeKinyer s) "" "" "" ""
        VarEN => go ss hu (cimkeKinyer s) la zh src
        VarLA => go ss hu en (cimkeKinyer s) zh src
        VarZH => go ss hu en la (cimkeKinyer s) src
        VarSRC => go ss hu en la zh (cimkeKinyer s)
        Keszen => go ss hu en la zh src

-- ─── 3. KERESÉS ─────────────────────────────────────────────

||| Egy kerdes kodoszojanak tavolsaga minden quadlingual mondathoz.
public export
keresTavolsag : E8E8KodSzo -> List QuadlingualMondat -> List (Nat, QuadlingualMondat)
keresTavolsag kerdes mondatok =
  map (\m => (teljesTavolsag kerdes m.kodSzo, m)) mondatok

||| A legkisebb tavolsagu mondat = a valasz.
public export
legkozelebbi : List (Nat, QuadlingualMondat) -> Maybe (Nat, QuadlingualMondat)
legkozelebbi [] = Nothing
legkozelebbi (x :: xs) = Just (legkisebb x xs)
  where
    legkisebb : (Nat, QuadlingualMondat) -> List (Nat, QuadlingualMondat) -> (Nat, QuadlingualMondat)
    legkisebb acc [] = acc
    legkisebb (d1, m1) ((d2, m2) :: rest) =
      if d2 < d1
        then legkisebb (d2, m2) rest
        else legkisebb (d1, m1) rest

||| A legkisebb N talalat (nem csak egy).
public export
legkozelebbiN : Nat -> List (Nat, QuadlingualMondat) -> List (Nat, QuadlingualMondat)
legkozelebbiN n xs = rendez xs
  where
    rendez : List (Nat, QuadlingualMondat) -> List (Nat, QuadlingualMondat)
    rendez [] = []
    rendez (y :: ys) =
      let kisebbek = filter (\z => fst z < fst y) ys
          nagyobbak = filter (\z => fst z >= fst y) ys
      in rendez kisebbek ++ [y] ++ rendez nagyobbak

-- ─── 4. VALASZ ──────────────────────────────────────────────

||| A valasz: a megtalalt mondat + a tavolsag + a hasonlosag.
||| Quadlingual: magyar + angol + latin + kinai.
public export
record Valasz where
  constructor ValaszKonstruktor
  magyarValasz  : String
  angolValasz   : String
  latinValasz   : String
  kinaiValasz   : String
  forrasHely    : String
  tavolsag      : Nat
  hasonlosagEr  : Hasonlosag

||| Egy kerdes → valasz a quadlingual mondatok kozott.
||| Ez a teljes Carnot-ciklus:
|||   kerdes (entrópia) → kodol (információ) → keres (munka) → valasz (energia)
public export
keres : String -> List QuadlingualMondat -> Maybe Valasz
keres kerdesSzoveg mondatok =
  let kerdesKodSzo = kodol kerdesSzoveg
      tavolsagok = keresTavolsag kerdesKodSzo mondatok
  in  case legkozelebbi tavolsagok of
        Nothing => Nothing
        Just (d, m) => Just (ValaszKonstruktor m.magyar m.angol m.latin m.kinai m.forras d (hasonlosag d))

-- ─── 5. FÁJL BEOLVASÁS (IO) ─────────────────────────────────

||| String felosztasa sorokra (newlines szerint).
public export
sorokra : String -> List String
sorokra s = splitOnChar '\n' s

||| Quadlingual fajl beolvasasa: utvonal → List QuadlingualMondat.
public export
beolvasQuadlingual : String -> IO (List QuadlingualMondat)
beolvasQuadlingual utvonal = do
  tartalom <- readFile utvonal
  case tartalom of
    Left hiba => do
      putStrLn ("Hiba a fajl beolvasasakor: " ++ show hiba)
      pure []
    Right szoveg => do
      let sorok = sorokra szoveg
      let mondatok = parszol sorok
      pure mondatok

-- ─── 6. FŐPROGRAM (quadlingual fajl beolvasassal) ──────────

public export
keresoFomFajl : IO ()
keresoFomFajl = do
  putStrLn "=== KERESO — Awodey quadlingual ch1 (HU/EN/LA/ZH) ==="
  putStrLn ""
  mondatok <- beolvasQuadlingual "../trail_index/books/awodey_quadlingual_ch1.txt"
  putStrLn ("Beolvasott mondatok: " ++ show (length mondatok))
  putStrLn ""

  let kerdesek = [
    "Mi az a kategoria?",
    "Mi az a funktor?",
    "Hol van az objektum?",
    "Miert hasznalunk izomorfizmust?",
    "Mivel kapcsolodik a funktor a kategoriahoz?"
  ]

  kerdesCiklus kerdesek mondatok
  putStrLn ""
  putStrLn "Kesz."
  where
    kerdesCiklus : List String -> List QuadlingualMondat -> IO ()
    kerdesCiklus [] _ = pure ()
    kerdesCiklus (k :: ks) mondatok = do
      putStrLn ("Kerdes: '" ++ k ++ "'")
      case keres k mondatok of
        Just v => do
          putStrLn ("  Valasz (HU): " ++ v.magyarValasz)
          putStrLn ("  Valasz (EN): " ++ v.angolValasz)
          putStrLn ("  Valasz (LA): " ++ v.latinValasz)
          putStrLn ("  Valasz (ZH): " ++ v.kinaiValasz)
          putStrLn ("  Forras: " ++ v.forrasHely)
          putStrLn ("  Tavolsag: " ++ show v.tavolsag ++ " (" ++ show v.hasonlosagEr ++ ")")
        Nothing => putStrLn "  Nincs talalat."
      putStrLn ""
      kerdesCiklus ks mondatok