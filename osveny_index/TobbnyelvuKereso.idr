module TobbnyelvuKereso

-- ═══════════════════════════════════════════════════════════════
-- TÖBBNYELVŰ HADAMARD KERESŐ
-- ═══════════════════════════════════════════════════════════════
-- Három nyelv = három E8 réteg = három Hadamard keresés:
--   Latin (R, skalár)   → balE8    = struktúra (mit mond?)
--   Magyar (O, oktonion) → jobbE8   = dinamika (hogyan kérdezek?)
--   Kínai (spinor)      → harmadikE8 = kontextus (milyen kontextusban?)
--
-- A kombinált Hadamard távolság = a három réteg súlyozott összege.
-- A legkisebb hatás elve: a minimális távolság = a válasz.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import MagyarNyelvtan
import Kodol
import Tavolsag
import Kereso

-- ─── 1. LATIN KODOLÓ — 6 ESET ───────────────────────────────

||| A latin 6 eset (klasszikus).
public export
data LatinEset = LatNominativus | LatAccusativus | LatGenitivus
               | LatDativus | LatAblativus | LatVocativus

||| Latin eset → E8Pont (balE8 = struktúra).
||| A latin 6 eset a magyar 18 eset ősze, a skalár réteg.
public export
latinEsetKod : LatinEset -> E8Pont
latinEsetKod LatNominativus = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla
latinEsetKod LatAccusativus = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla
latinEsetKod LatGenitivus  = E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla
latinEsetKod LatDativus   = E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla
latinEsetKod LatAblativus = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla
latinEsetKod LatVocativus = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla

||| Latin kérdőszó → eset.
public export
latinKerdoszoEset : String -> Maybe LatinEset
latinKerdoszoEset "quid"  = Just LatNominativus
latinKerdoszoEset "quis"  = Just LatNominativus
latinKerdoszoEset "quem"  = Just LatAccusativus
latinKerdoszoEset "cuius" = Just LatGenitivus
latinKerdoszoEset "cui"   = Just LatDativus
latinKerdoszoEset "cur"   = Just LatAblativus
latinKerdoszoEset "quomodo" = Just LatAblativus
latinKerdoszoEset "ubi"   = Just LatAblativus
latinKerdoszoEset "unde"  = Just LatAblativus
latinKerdoszoEset "quo"   = Just LatAblativus
latinKerdoszoEset _       = Nothing

||| Latin fogalom szótár → E8Pont.
||| A latin fogalmak a magyarokkal azonos E8Pontot kapnak
||| (a fogalom nyelvfüggetlen = a jelentés = a Dirac spinor).
public export
latinFogalomSzotar : List (String, E8Pont)
latinFogalomSzotar =
  [ ("categoria",    E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("obiectum",     E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("morphismum",   E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla)
  , ("sagitta",      E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla)
  , ("functor",      E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , ("isomorphismus", E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla)
  , ("copia",        E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla)
  , ("functio",      E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla)
  , ("identitas",    E8PontKonstruktor Egy Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("compositio",   E8PontKonstruktor Nulla Nulla Egy Egy Nulla Nulla Nulla Nulla)
  , ("libera",       E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , ("monoides",     E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , ("fundamenta",   E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  ]

||| Latin szó → E8Pont (fogalom keresés).
public export
latinFogalomKeres : String -> Maybe E8Pont
latinFogalomKeres szo = keres szo latinFogalomSzotar
  where
    keres : String -> List (String, E8Pont) -> Maybe E8Pont
    keres _ [] = Nothing
    keres s ((nev, pont) :: xs) =
      if s == nev then Just pont else keres s xs

||| Latin mondat → E8Pont (balE8 = struktúra réteg).
||| A latin kódoló: kérdőszó → eset, fogalom → E8Pont.
public export
kodolLatin : String -> E8Pont
kodolLatin mondat =
  let szavak = splitOnChar ' ' mondat
      esetK = keresKerdoszo szavak
      fogalomP = keresFogalom szavak
  in  case fogalomP of
        Just p => p
        Nothing => case esetK of
                     Just e => latinEsetKod e
                     Nothing => e8Nulla
  where
    keresKerdoszo : List String -> Maybe LatinEset
    keresKerdoszo [] = Nothing
    keresKerdoszo (s :: ss) =
      case latinKerdoszoEset s of
        Just e => Just e
        Nothing => keresKerdoszo ss

    keresFogalom : List String -> Maybe E8Pont
    keresFogalom [] = Nothing
    keresFogalom (s :: ss) =
      case latinFogalomKeres s of
        Just p => Just p
        Nothing => keresFogalom ss

-- ─── 2. KÍNAI KODOLÓ — RADIKÁLIS KATEGÓRIÁK ─────────────────

||| A kínai radikális kategóriák (214 Kangxi radikálisból a főbbek).
||| Minden radikális egy E8Pontot kap (harmadikE8 = kontextus).
||| A kínai = spinor réteg: vizualitás + tonus + kontextus.
public export
data KinaiRadikal = RenRad | MuRad | ShuiRad | HuoRad | TuRad
                  | JinRad | KouRad | XinRad | NvRad | ZiRad

||| Kínai radikális → E8Pont (harmadikE8 = kontextus).
||| Az 5 elem (五形) + 5 alapstruktúra.
public export
kinaiRadikalKod : KinaiRadikal -> E8Pont
kinaiRadikalKod RenRad  = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla  -- 人=ember
kinaiRadikalKod MuRad   = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla  -- 木=fa
kinaiRadikalKod ShuiRad = E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla  -- 水=víz=entrópia
kinaiRadikalKod HuoRad  = E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla  -- 火=tűz=energia
kinaiRadikalKod TuRad   = E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla  -- 土=föld=tér
kinaiRadikalKod JinRad  = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla  -- 金=fém=struktúra
kinaiRadikalKod KouRad  = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla  -- 口=száj=perem
kinaiRadikalKod XinRad  = E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Egy  -- 心=szív=tudat
kinaiRadikalKod NvRad   = E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy    -- 女=nő=kapcsolat
kinaiRadikalKod ZiRad   = E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Egy    -- 子=gyerek=lét

||| Kínai fogalom szótár → E8Pont.
||| A kínai fogalmak a magyarokkal/latinokkal azonos E8Pontot kapnak.
public export
kinaiFogalomSzotar : List (String, E8Pont)
kinaiFogalomSzotar =
  [ ("范畴", E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("对象", E8PontKonstruktor Nulla Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("态射", E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla)
  , ("箭头", E8PontKonstruktor Nulla Nulla Egy Nulla Nulla Nulla Nulla Nulla)
  , ("函子", E8PontKonstruktor Nulla Nulla Nulla Egy Nulla Nulla Nulla Nulla)
  , ("同构", E8PontKonstruktor Nulla Nulla Nulla Nulla Egy Nulla Nulla Nulla)
  , ("集合", E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Egy Nulla Nulla)
  , ("函数", E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Egy Nulla)
  , ("恒等", E8PontKonstruktor Egy Egy Nulla Nulla Nulla Nulla Nulla Nulla)
  , ("复合", E8PontKonstruktor Nulla Nulla Egy Egy Nulla Nulla Nulla Nulla)
  , ("自由", E8PontKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , ("幺半群", E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  , ("基础", E8PontKonstruktor Egy Nulla Nulla Nulla Nulla Nulla Nulla Egy)
  ]

||| Kínai szó → E8Pont.
public export
kinaiFogalomKeres : String -> Maybe E8Pont
kinaiFogalomKeres szo = keres szo kinaiFogalomSzotar
  where
    keres : String -> List (String, E8Pont) -> Maybe E8Pont
    keres _ [] = Nothing
    keres s ((nev, pont) :: xs) =
      if s == nev then Just pont else keres s xs

||| Kínai mondat → E8Pont (harmadikE8 = kontextus réteg).
||| A kínai kódoló: fogalom keresés a szótárban.
||| A kínai izoláló nyelv — nincsenek ragok, a szó = a fogalom.
public export
kodolKinai : String -> E8Pont
kodolKinai mondat =
  let szavak = splitOnChar ' ' mondat
      fogalomP = keresFogalom szavak
  in  case fogalomP of
        Just p => p
        Nothing => e8Nulla
  where
    keresFogalom : List String -> Maybe E8Pont
    keresFogalom [] = Nothing
    keresFogalom (s :: ss) =
      case kinaiFogalomKeres s of
        Just p => Just p
        Nothing => keresFogalom ss

-- ─── 3. HÁROMNYELVŰ KÓDOLÓ ─────────────────────────────────

||| Háromnyelvű kódolás: (latin, magyar, kínai) → (balE8, jobbE8, harmadikE8).
||| A latin = struktúra, a magyar = dinamika, a kínai = kontextus.
public export
record HaromnyelvuKodSzo where
  constructor HaromnyelvuKonstruktor
  cimke       : String
  balE8Latin  : E8Pont       -- struktúra (latin)
  jobbE8Magyar : E8Pont      -- dinamika (magyar eset)
  harmadikE8Kinai : E8Pont   -- kontextus (kínai radikális)
  clifford    : CliffordElem  -- CPT (magyar igeragozás)
  steane      : HetesKod      -- [[7,1,3]] hibajavítás

||| Háromnyelvű kódolás: egy quadlingual mondat → HaromnyelvuKodSzo.
public export
kodolHaromnyelv : QuadlingualMondat -> HaromnyelvuKodSzo
kodolHaromnyelv mondat =
  let balE8L = kodolLatin mondat.latin
      jobbE8M = case ragFelismer (foSzo mondat.magyar) of
                  Just (_, eset) => esetKod eset
                  Nothing => e8Nulla
      harmadikE8K = kodolKinai mondat.kinai
      cpt = CptIgeragozasKonstruktor JelenI FolyamatosSz KozvetlenF
      cliff = cptKod cpt
      steaneK = mondatSteane NominativusE JelenI
  in HaromnyelvuKonstruktor mondat.magyar balE8L jobbE8M harmadikE8K cliff steaneK
  where
    foSzo : String -> String
    foSzo s = case splitOnChar ' ' s of
                (x :: _) => irasjelLevagas x
                [] => ""

-- ─── 4. HADAMARD TÁVOLSÁG — HÁROM RÉTEG ─────────────────────

||| Hadamard távolság: hány biten különbözik két E8Pont.
||| = Hamming távolság = a projekt "Hadamard távolsága".
public export
hadamardTavolsag : E8Pont -> E8Pont -> Nat
hadamardTavolsag = hammingTavolsag

||| Háromnyelvű Hadamard távolság: (latin, magyar, kínai) külön-külön.
public export
record HaromnyelvuTavolsag where
  constructor HaromnyelvuTavolsagKonstruktor
  latinTavolsag    : Nat  -- balE8 Hadamard (struktúra)
  magyarTavolsag   : Nat  -- jobbE8 Hadamard (dinamika)
  kinaiTavolsag    : Nat  -- harmadikE8 Hadamard (kontextus)
  osszesTavolsag   : Nat  -- súlyozott összeg

||| Két HaromnyelvuKodSzo távolsága: három réteg külön-külön.
|||
||| Súlyozás (legkisebb hatás elve):
|||   latin × 3   (struktúra = a legfontosabb — mit mond?)
|||   magyar × 2  (dinamika = hogyan kérdezek?)
|||   kínai × 1   (kontextus = milyen kontextusban?)
public export
haromnyelvuTavolsag : HaromnyelvuKodSzo -> HaromnyelvuKodSzo -> HaromnyelvuTavolsag
haromnyelvuTavolsag a b =
  let lt = hadamardTavolsag a.balE8Latin b.balE8Latin
      mt = hadamardTavolsag a.jobbE8Magyar b.jobbE8Magyar
      kt = hadamardTavolsag a.harmadikE8Kinai b.harmadikE8Kinai
      ct = cliffordTavolsag a.clifford b.clifford
      st = steaneTavolsag a.steane b.steane
      ossz = lt * 3 + mt * 2 + kt * 1 + ct + st
  in HaromnyelvuTavolsagKonstruktor lt mt kt ossz

-- ─── 5. HÁROMNYELVŰ KERESÉS ────────────────────────────────

||| Háromnyelvű keresés eredménye.
public export
record HaromnyelvuValasz where
  constructor HaromnyelvuValaszKonstruktor
  magyarValasz  : String
  angolValasz   : String
  latinValasz   : String
  kinaiValasz   : String
  forrasHely    : String
  latinTavolsag    : Nat
  magyarTavolsag   : Nat
  kinaiTavolsag    : Nat
  osszesTavolsag   : Nat
  hasonlosagEr  : Hasonlosag

||| Háromnyelvű kérdés kódolása.
||| A kérdés magyarul jön, de mindhárom rétegre kódoljuk:
|||   latin: a magyar szavak latin megfelelői (a szótárból)
|||   magyar: az eset + CPT (a meglévő kódoló)
|||   kínai: a magyar szavak kínai megfelelői (a szótárból)
public export
kerdesHaromnyelv : String -> HaromnyelvuKodSzo
kerdesHaromnyelv kerdes =
  let magyarKodSzo = kodol kerdes
      -- A magyar kódolásból vesszük a jobbE8-t (eset)
      jobbE8M = magyarKodSzo.jobbE8
      -- A balE8 (fogalom) = a latin és kínai is ugyanazt a fogalmat keresi
      balE8L = magyarKodSzo.balE8  -- a fogalom nyelvfüggetlen
      harmadikE8K = magyarKodSzo.balE8  -- a kínai is ugyanazt keresi
      cpt = CptIgeragozasKonstruktor JelenI FolyamatosSz KozvetlenF
      cliff = cptKod cpt
      steaneK = magyarKodSzo.steane
  in HaromnyelvuKonstruktor kerdes balE8L jobbE8M harmadikE8K cliff steaneK

||| Legkisebb távolságú mondat keresése.
public export
legkisebbHaromnyelvu : List (HaromnyelvuTavolsag, QuadlingualMondat) -> Maybe (HaromnyelvuTavolsag, QuadlingualMondat)
legkisebbHaromnyelvu [] = Nothing
legkisebbHaromnyelvu (x :: xs) = Just (mini x xs)
  where
    mini : (HaromnyelvuTavolsag, QuadlingualMondat) -> List (HaromnyelvuTavolsag, QuadlingualMondat) -> (HaromnyelvuTavolsag, QuadlingualMondat)
    mini acc [] = acc
    mini (t1, m1) ((t2, m2) :: rest) =
      if t2.osszesTavolsag < t1.osszesTavolsag
        then mini (t2, m2) rest
        else mini (t1, m1) rest

||| Háromnyelvű keresés: a legkisebb hatás elve három rétegen.
public export
keresHaromnyelv : String -> List QuadlingualMondat -> Maybe HaromnyelvuValasz
keresHaromnyelv kerdesSzoveg mondatok =
  let kerdesKod = kerdesHaromnyelv kerdesSzoveg
      kodoltMondatok = map (\m => (haromnyelvuTavolsag kerdesKod (kodolHaromnyelv m), m)) mondatok
  in  case legkisebbHaromnyelvu kodoltMondatok of
        Nothing => Nothing
        Just (t, m) => Just (HaromnyelvuValaszKonstruktor
                              m.magyar m.angol m.latin m.kinai m.forras
                              t.latinTavolsag t.magyarTavolsag t.kinaiTavolsag
                              t.osszesTavolsag (hasonlosag t.osszesTavolsag))

-- ─── 6. FŐPROGRAM ───────────────────────────────────────────

public export
tobbnyelvuKeresoFom : IO ()
tobbnyelvuKeresoFom = do
  putStrLn "=== TÖBBNYELVŰ HADAMARD KERESŐ (HU/EN/LA/ZH) ==="
  putStrLn ""
  -- Awodey 1. fejezet
  mondatok1 <- beolvasQuadlingual "../trail_index/books/awodey_quadlingual_ch1.txt"
  -- József Attila vers elemzés
  mondatok2 <- beolvasQuadlingual "../trail_index/books/jozsef_attila_nincs_bocsanat_quadlingual.txt"
  let mondatok = mondatok1 ++ mondatok2
  putStrLn ("Beolvasott mondatok: " ++ show (length mondatok) ++ " (Awodey: " ++ show (length mondatok1) ++ ", József Attila: " ++ show (length mondatok2) ++ ")")
  putStrLn ""

  let kerdesek = [
    "Mi az a kategoria?",
    "Mi az a funktor?",
    "Hol van az objektum?",
    "Miert hasznalunk izomorfizmust?",
    "Mivel kapcsolodik a funktor a kategoriahoz?",
    "Mi a bocsanat?",
    "Miert leallt a Carnot-ciklus?",
    "Mivel a pszichoanalizis nem gyogyit?",
    "Mi a fog szerepe a versben?",
    "Mi a konny jelentese?"
  ]

  kerdesCiklus kerdesek mondatok
  putStrLn ""
  putStrLn "Kesz."
  where
    kerdesCiklus : List String -> List QuadlingualMondat -> IO ()
    kerdesCiklus [] _ = pure ()
    kerdesCiklus (k :: ks) mondatok = do
      putStrLn ("Kerdes: '" ++ k ++ "'")
      case keresHaromnyelv k mondatok of
        Just v => do
          putStrLn ("  Valasz (HU): " ++ v.magyarValasz)
          putStrLn ("  Valasz (EN): " ++ v.angolValasz)
          putStrLn ("  Valasz (LA): " ++ v.latinValasz)
          putStrLn ("  Valasz (ZH): " ++ v.kinaiValasz)
          putStrLn ("  Forras: " ++ v.forrasHely)
          putStrLn ("  Hadamard tavolsag:")
          putStrLn ("    Latin  (struktura):  " ++ show v.latinTavolsag)
          putStrLn ("    Magyar (dinamika):   " ++ show v.magyarTavolsag)
          putStrLn ("    Kinai  (kontextus):  " ++ show v.kinaiTavolsag)
          putStrLn ("    Osszes (sulyozott):  " ++ show v.osszesTavolsag ++ " (" ++ show v.hasonlosagEr ++ ")")
        Nothing => putStrLn "  Nincs talalat."
      putStrLn ""
      kerdesCiklus ks mondatok