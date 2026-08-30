module NyelvtaniFa

import Steane713
import E8E8Algebra
import MagyarNyelvtan

-- ─── 1. SZÓOSZTÁLYOK ───────────────────────────────────────

public export
data Sofaj = FonSof | IgeSof | MelleknevSof | HatarozoSzoSof
          | NemoszoSof | KotoszoSof | IsmeretlenSof

public export
Eq Sofaj where
  FonSof == FonSof = True
  IgeSof == IgeSof = True
  MelleknevSof == MelleknevSof = True
  HatarozoSzoSof == HatarozoSzoSof = True
  NemoszoSof == NemoszoSof = True
  KotoszoSof == KotoszoSof = True
  IsmeretlenSof == IsmeretlenSof = True
  _ == _ = False

public export
sofajKod : Sofaj -> E8Pont
sofajKod FonSof        = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla
sofajKod IgeSof         = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla
sofajKod MelleknevSof   = E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla
sofajKod HatarozoSzoSof = E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla
sofajKod NemoszoSof     = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla
sofajKod KotoszoSof     = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla
sofajKod IsmeretlenSof  = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla

-- ─── 2. SEGÉDFÜGGVÉNYEK (lokális, hogy elkerüljük a ciklikus importot) ──

public export
splitOnCharFa : Char -> String -> List String
splitOnCharFa c s = go (unpack s)
  where
    go : List Char -> List String
    go [] = [""]
    go (x :: xs) =
      if x == c
        then "" :: go xs
        else case go xs of
               (elso :: tobbi) => (strCons x elso) :: tobbi
               [] => [strCons x ""]

public export
kisbetusitFa : Char -> Char
kisbetusitFa 'A' = 'a'; kisbetusitFa 'B' = 'b'; kisbetusitFa 'C' = 'c'
kisbetusitFa 'D' = 'd'; kisbetusitFa 'E' = 'e'; kisbetusitFa 'F' = 'f'
kisbetusitFa 'G' = 'g'; kisbetusitFa 'H' = 'h'; kisbetusitFa 'I' = 'i'
kisbetusitFa 'J' = 'j'; kisbetusitFa 'K' = 'k'; kisbetusitFa 'L' = 'l'
kisbetusitFa 'M' = 'm'; kisbetusitFa 'N' = 'n'; kisbetusitFa 'O' = 'o'
kisbetusitFa 'P' = 'p'; kisbetusitFa 'Q' = 'q'; kisbetusitFa 'R' = 'r'
kisbetusitFa 'S' = 's'; kisbetusitFa 'T' = 't'; kisbetusitFa 'U' = 'u'
kisbetusitFa 'V' = 'v'; kisbetusitFa 'W' = 'w'; kisbetusitFa 'X' = 'x'
kisbetusitFa 'Y' = 'y'; kisbetusitFa 'Z' = 'z'
kisbetusitFa c = c

public export
irasjelLevagasFa : String -> String
irasjelLevagasFa s = pack (go (map kisbetusitFa (unpack s)))
  where
    go : List Char -> List Char
    go [] = []
    go (x :: xs) =
      if x == '?' || x == '!' || x == '.' || x == ',' || x == ';' || x == ':'
        then go xs
        else x :: go xs

-- ─── 3. SZÓOSZTÁLYOZÁS (top-level, nincs where) ────────────

public export
nemoszoLista : List String
nemoszoLista = ["mi", "miert", "hogyan", "hol", "hova", "honnan",
                "mivel", "mive", "mikent", "ki", "mit",
                "kinek", "kivel", "kihez", "kinal", "melyik",
                "meddig", "mint", "micsoda"]

public export
kotoszoLista : List String
kotoszoLista = ["es", "vagy", "de", "hogy", "mert", "pedig",
                "viszont", "azonban", "tehat", "am", "ha",
                "bar", "habar", "jollehet"]

public export
vanE : String -> List String -> Bool
vanE _ [] = False
vanE x (y :: ys) = if x == y then True else vanE x ys

public export
sofajMagyar : String -> Sofaj
sofajMagyar szo =
  let s = irasjelLevagasFa szo
  in if vanE s nemoszoLista then NemoszoSof
     else if vanE s kotoszoLista then KotoszoSof
     else if endsWith "-ni" s then IgeSof
     else if endsWith "-ik" s then IgeSof
     else if endsWith "-bb" s then MelleknevSof
     else if endsWith "-an" s then HatarozoSzoSof
     else if endsWith "-en" s then HatarozoSzoSof
     else FonSof

-- ─── 3. ELEMZETT SZÓ ───────────────────────────────────────

public export
record ElemzettSzo where
  constructor ElemzettSzoKonstruktor
  szoSofaj   : Sofaj
  szoTo      : String
  szoEsetrag : Esetrag
  szoEredeti : String

public export
elemezMagyar : String -> ElemzettSzo
elemezMagyar szo =
  let sf = sofajMagyar szo
      rg = ragFelismer (irasjelLevagasFa szo)
  in case rg of
       Just (to, eset) => ElemzettSzoKonstruktor sf to eset szo
       Nothing => ElemzettSzoKonstruktor sf szo NominativusE szo

-- ─── 4. SZINTAKTIKAI FA ────────────────────────────────────

public export
data FaCsucs = Level ElemzettSzo
            | Csop (List FaCsucs)

public export
record MondatFa where
  constructor MondatFaKonstruktor
  mondatSzoveg : String
  topikFa    : FaCsucs
  predikatumFa : FaCsucs
  szavakSzama : Nat

-- ─── 5. MAGYAR MONDAT PARSZOLÁSA (top-level) ────────────────

public export
bontasTopikPredikatum : List ElemzettSzo -> (List ElemzettSzo, List ElemzettSzo)
bontasTopikPredikatum [] = ([], [])
bontasTopikPredikatum (s :: ss) =
  if s.szoSofaj == IgeSof
    then ([s], ss)
    else case bontasTopikPredikatum ss of
           (ts, ps) => (s :: ts, ps)

public export
faCsucsE8 : FaCsucs -> E8Pont
faCsucsE8 (Level szo) = e8Osszead (sofajKod szo.szoSofaj) (esetKod szo.szoEsetrag)
faCsucsE8 (Csop []) = e8Nulla
faCsucsE8 (Csop (c :: cs)) = e8Osszead (faCsucsE8 c) (faCsucsE8 (Csop cs))

public export
mondatFaE8 : MondatFa -> E8Pont
mondatFaE8 fa = e8Osszead (faCsucsE8 fa.topikFa) (faCsucsE8 fa.predikatumFa)

public export
parszolMagyarMondat : String -> MondatFa
parszolMagyarMondat mondat =
  let szavak = map irasjelLevagasFa (splitOnCharFa ' ' mondat)
      elemzett = map elemezMagyar szavak
      (ts, ps) = bontasTopikPredikatum elemzett
      topik = Csop (map Level ts)
      pred = Csop (map Level ps)
  in MondatFaKonstruktor mondat topik pred (length szavak)

-- ─── 6. FŐPROGRAM ───────────────────────────────────────────

public export
showE8 : E8Pont -> String
showE8 p =
  showK p.x1 ++ showK p.x2 ++ showK p.x3 ++ showK p.x4 ++
  showK p.x5 ++ showK p.x6 ++ showK p.x7 ++ showK p.x8
  where
    showK : Kubit -> String
    showK Nulla = "0"
    showK Egy = "1"

public export
showSofaj : Sofaj -> String
showSofaj FonSof = "fon"
showSofaj IgeSof = "ige"
showSofaj MelleknevSof = "melleknev"
showSofaj HatarozoSzoSof = "hatarozo"
showSofaj NemoszoSof = "nemos"
showSofaj KotoszoSof = "kotoszo"
showSofaj IsmeretlenSof = "?"

public export
osztalyozCiklus : List String -> IO ()
osztalyozCiklus [] = pure ()
osztalyozCiklus (s :: ss) = do
  let sf = sofajMagyar s
  putStrLn ("  " ++ s ++ " -> " ++ showSofaj sf)
  osztalyozCiklus ss

public export
nyelvtaniFaFom : IO ()
nyelvtaniFaFom = do
  putStrLn "=== NYELVTANI FA ==="
  putStrLn ""
  let mondatok = [
    "Mi az a kategoria?",
    "A funktor ket kategoria kozotti lekepezes.",
    "Egy kategoria objektumokbol es nyilakbol all.",
    "Miert hasznalunk izomorfizmust?",
    "A konny az entropia hordozo."
  ]
  tesztCiklus mondatok
  putStrLn ""
  putStrLn "Kesz."
  where
    tesztCiklus : List String -> IO ()
    tesztCiklus [] = pure ()
    tesztCiklus (m :: ms) = do
      putStrLn ("Mondat: '" ++ m ++ "'")
      let fa = parszolMagyarMondat m
      let e8 = mondatFaE8 fa
      putStrLn ("  Szavak: " ++ show fa.szavakSzama)
      putStrLn ("  Fa E8:  " ++ NyelvtaniFa.showE8 e8)
      let szavak = map irasjelLevagasFa (splitOnCharFa ' ' m)
      osztalyozCiklus szavak
      putStrLn ""
      tesztCiklus ms