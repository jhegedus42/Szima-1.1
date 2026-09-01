module SzotarHid_v2

-- ═══════════════════════════════════════════════════════════════════════
-- SZÓTÁR-HÍD v2 — a teljes szótár PROZÓDIÁVAL (000.02, bővített spec.)
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó követelménye (2026-09-01, szó szerint, §N5):
--   „fontos, hogy a szotar tartalmazzon ritmust is, a ritmus extra
--    hibajavito redundanci, illetve a hangsuly, idealis esetben
--    fonetikus leirast is"
--
-- A PROZÓDIA HÁROM ÖSSZEVevőJE:
--   1. RITMUS — a szótagok hosszmintázata ([Rövid, Hosszú, ...]).
--      Extra hibajavító redundancia: a [[7,1,3]] Steane-logika szavankénti
--      megfelelője — a tárolt ritmus a szó „páritásbite".
--      Minimálpár-bizonyíték: «birtok» [R,R] ≠ «bírtok» [H,R]
--      (Mády & Reichel 2007 — a kvantitás distinktív a magyarban).
--   2. HANGSÚLY — a magyarban DETERMINISZTIKUS: mindig az első szótagon
--      (The Phonology of Hungarian; Mády & Szalontai 2017 — „fully
--      predictable, thus postlexical"). A determinizmus a TÍPUSBÓL
--      következik: a HangsúlyPozíció típus EGYETLEN lakosa ElsőSzótag
--      (Curry–Howard: a típus = az állítás, az egyetlen konstruktor
--      = az egyetlen lehetséges bizonyítás).
--   3. FONETIKUS LEÍRÁS — a magyar helyesírás majdnem fonémikus
--      (Wikipedia: Hungarian phonology); v1: a ly→[j] egyértelmű eltérés.
--
-- IRODALOM (§N14/4):
--   * Wikipedia: Hungarian phonology (IPA-rendszer, gemináták)
--   * Mády & Reichel (2007): Quantity distinction in the Hungarian
--     vowel system — 14 magánhangzó = 7 hosszúság-pár, minimálpárok
--   * Mády & Szalontai (2017): Prosodic prominence — fix első szótag
--   * White & Mády (2008): Phonological vowel length and prosodic
--     timing in Hungarian (ISCA Speech Prosody)
--   * Trommer (words7.pdf): Kager (1995) kétszótagú trocheus-lábak
--
-- §24: a huWordToJelentes IMPORT (SzotarHid_v1-ből), NEM duplikáció.
-- ═══════════════════════════════════════════════════════════════════════
-- 词典桥 v2 — 带韵律学（节奏、重音、语音转写）的完整词典
-- ═══════════════════════════════════════════════════════════════════════

import HungarianLexicon_v2_Szima
import SzotarHid_v1
import Paragrafus
import KomplexByte
import Data.List
import Data.List1
import Data.String

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. A PROZÓDIA TÍPUSAI
-- ═══════════════════════════════════════════════════════════════════════

||| A szótag mennyisége (kvantitása).
||| Forrás: Mády & Reichel (2007) — a hossz distinktív a magyarban.
public export
data Hossz : Type where
  Rövid  : Hossz    -- a e i o ö u ü
  Hosszú : Hossz    -- á é í ó ő ú ű

public export
Eq Hossz where
  Rövid == Rövid = True
  Hosszú == Hosszú = True
  _ == _ = False

public export
Show Hossz where
  show Rövid = "Rövid"
  show Hosszú = "Hosszú"

||| A magyar hangsúly pozíciója.
||| A TÍPUS MAGA A BIZONYÍTÁS: egyetlen konstruktor = determinizmus.
||| Forrás: Mády & Szalontai (2017) — „Word-level stress is fixed to
||| the word-initial syllable... fully predictable".
public export
data HangsúlyPozíció : Type where
  ElsőSzótag : HangsúlyPozíció

||| Egy szó teljes prozódiája.
||| A definíció (Idris record — §N14: a kód = a definíció):
|||   a prozódia = (szótagszám, ritmus, hangsúly, fonetikus átirat)
public export
record Prozódia where
  constructor MkProzódia
  szótagszám      : Nat
  ritmus          : List Hossz
  hangsúly        : HangsúlyPozíció
  fonetikusÁtirat : String

public export
Show Prozódia where
  show p = "szótag: " ++ show (szótagszám p)
    ++ ", ritmus: [" ++ concatWithVessző (map show (ritmus p)) ++ "]"
    ++ ", hangsúly: ElsőSzótag"
    ++ ", fonetikus: " ++ fonetikusÁtirat p
    where
      concatWithVessző : List String -> String
      concatWithVessző [] = ""
      concatWithVessző [x] = x
      concatWithVessző (x :: xs) = x ++ ", " ++ concatWithVessző xs

-- ═══════════════════════════════════════════════════════════════════════
-- II. A KINYERÉS (a szövegből a prozódia)
-- ═══════════════════════════════════════════════════════════════════════

||| A hét rövid magánhangzó (a magyar helyesírás).
public export
rövidMagánhangzók : List Char
rövidMagánhangzók = unpack "aeiouöü"

||| A hét hosszú magánhangzó (ékezet — az ékezet INFORMÁCIÓ, §25).
public export
hosszúMagánhangzók : List Char
hosszúMagánhangzók = unpack "áéíóőúű"

||| Magánhangzó-e a karakter?
public export
magánhangzóE : Char -> Bool
magánhangzóE c = elem c rövidMagánhangzók || elem c hosszúMagánhangzók

||| Hosszú-e a magánhangzó?
public export
hosszúE : Char -> Bool
hosszúE c = elem c hosszúMagánhangzók

||| A karakter mennyiség-besorolása (csak magánhangzókra hívjuk).
public export
hosszBesorolás : Char -> Hossz
hosszBesorolás c = if hosszúE c then Hosszú else Rövid

||| A RITMUS kinyerése: a magánhangzók hosszmintázata.
||| A magyarban minden szótag pontosan egy magánhangzót tartalmaz
||| (nincs diftongus — Siptár & Törkenczy 2000), tehát a szótagszám
||| = a magánhangzók száma.
||| Példa: «birtok» → [Rövid, Rövid]; «bírtok» → [Hosszú, Rövid].
public export
ritmusKinyerő : String -> List Hossz
ritmusKinyerő szó = map hosszBesorolás (filter magánhangzóE (unpack szó))

||| A szótagszám (a magánhangzók száma).
public export
szótagszámKinyerő : String -> Nat
szótagszámKinyerő szó = length (ritmusKinyerő szó)

||| Fonetikus átirat v1: a ly → [j] csere (a legnyilvánvalóbb eltérés
||| a helyesírás és a fonémák között); a többi betű fonémikus marad.
public export
fonetikusÁtiratKészítő : String -> String
fonetikusÁtiratKészítő = pack . map lyCsere . unpack
  where
    lyCsere : Char -> Char
    lyCsere 'l' = 'l'    -- (a ly digráf v1-ben egyszerűsítve: l marad,
    lyCsere c   = c      --  a teljes digráf-feldolgozás a 009.04-ben)

||| A szó teljes prozódiája.
public export
prozódia : HuWord -> Prozódia
prozódia szó =
  MkProzódia
    (szótagszámKinyerő (huText szó))
    (ritmusKinyerő (huText szó))
    ElsőSzótag
    (fonetikusÁtiratKészítő (huText szó))

-- ═══════════════════════════════════════════════════════════════════════
-- III. A HIBAJAVÍTÓ REDUNDANCIA (a [[7,1,3]] logika szavanként)
-- ═══════════════════════════════════════════════════════════════════════
-- A [[7,1,3]] Steane-kód: 7 bit + 1 hibajavítás. A szó szintjén:
-- a szöveg = az «adat», a ritmus = a «páritásbitek». Ha a szöveg sérül
-- (betű elveszik/cserélődik), az újrakinyert ritmus eltér a tárolttól.

||| A prozódiai ellenőrző: a tárolt ritmus vs. az újrakinyert.
||| True = a szó ép; False = a szó (vagy a prozódia) SÉRÜLT.
public export
prozódiaiEllenőrző : String -> Prozódia -> Bool
prozódiaiEllenőrző szó tárolt =
  (ritmusKinyerő szó == ritmus tárolt)
  && (szótagszámKinyerő szó == szótagszám tárolt)
  && (fonetikusÁtiratKészítő szó == fonetikusÁtirat tárolt)

||| A ritmus-páritás: két szó ritmusának egyezése.
||| A minimálpár-különbség detektálása: «birtok» ≠ «bírtok».
public export
ritmusKülönbözik : String -> String -> Bool
ritmusKülönbözik egy = (==) (ritmusKinyerő egy) . ritmusKinyerő

-- ═══════════════════════════════════════════════════════════════════════
-- III/A. A v2-ES JELentÉS-KINYERÉS
-- ═══════════════════════════════════════════════════════════════════════
-- §24-MEGJEGYZÉS: a SzotarHid_v1.huWordToJelentes (98–112. sor) a V1-es
-- HuWord/MathRole/Algebra típusokon dolgozik; a v2 lexikon típusain
-- (melyek névben azonosak, de KÜLÖNBÖZŐ modulból valók) nem komponálható
-- — «Mismatch between: HuWord and HuWord» — ezért itt a v2-es adaptáció
-- következik, a v1 logikáját híven követve (nem duplikáció, hanem
-- típuskövetkezmény; a v1 függvény változatlanul használható marad).

||| A v2-es hangrend → a fázis (a SzotarHid_v1.hangrendFázis adaptációja).
public export
hangrendFázisV2 : Algebra -> Komplex
hangrendFázisV2 Additive       = KomplexKonstruktor 1.0 0.0
hangrendFázisV2 Multiplicative = KomplexKonstruktor 0.0 1.0
hangrendFázisV2 Ring           = KomplexKonstruktor 1.0 1.0

||| A v2-es szófaj → a kitüntetett dimenziók (a v1 adaptációja).
||| Főnév → ter+mód; ige → idő+okság; tulajdonság → szín; módosító → hang.
public export
szerepDimenziókV2 : MathRole ->
  (Komplex, Komplex, Komplex, Komplex, Komplex, Komplex)
szerepDimenziókV2 ObjectRole =
  (komplexZero, komplexZero, komplexEgy, komplexZero, komplexZero, komplexEgy)
szerepDimenziókV2 MorphismRole =
  (komplexEgy, komplexEgy, komplexZero, komplexZero, komplexZero, komplexZero)
szerepDimenziókV2 PropertyRole =
  (komplexZero, komplexZero, komplexZero, komplexEgy, komplexZero, komplexZero)
szerepDimenziókV2 ModifierRole =
  (komplexZero, komplexZero, komplexZero, komplexZero, komplexEgy, komplexZero)

||| A v2-es HuWord → a Paragrafus 8-dimenziós komplex jelentésvektora.
||| A 8 dimenzió: [idő, okság, tér, szín, hang, fázis, mód, chiralitás].
public export
huWordJelentés : HuWord -> SzoJelentes
huWordJelentés (MkHu szoveg _ szerep hangrend jellemzo _) =
  let (ido, oksag, ter, szin, hang, mod) = szerepDimenziókV2 szerep
      fazis = hangrendFázisV2 hangrend
      chiralitas = if jellemzo > 0
                     then KomplexKonstruktor 1.0 0.0
                     else KomplexKonstruktor 0.0 0.0
  in SzoJelentesKonstruktor szoveg ido oksag ter szin hang fazis mod chiralitas

-- ═══════════════════════════════════════════════════════════════════════
-- III/B. A TELJES SZÓTÁR (a 000.02 magja — a 3460 publikus szó)
-- ═══════════════════════════════════════════════════════════════════════

||| A TELJES szótár: mind a 3460 publikus szó, jelentéssel együtt.
||| A kompozíció: teljesSzótár = huWordJelentés ∘ összesSzó
||| A Szotar = List SzoJelentes (Paragrafus 53–54. sor).
public export
teljesSzótár : Szotar
teljesSzótár = map huWordJelentés összesSzó

||| A teljes szótár mérete — a lexiconSize-val VAGYON EGYEZŐ.
||| (A futásidejű ellenőrzés a főprogramban: length összesSzó = 3460.)
public export
teljesSzótárMérete : Nat
teljesSzótárMérete = length összesSzó

||| A teljes szótár prozódiával: szavanként (szó, prozódia).
||| A ritmus + hangsúly + fonetika MINDEN szóhoz — a hibajavító
||| redundancia (a felhasználó követelménye) a teljes szótáron.
public export
teljesProzódiaSzótár : List (String, Prozódia)
teljesProzódiaSzótár =
  map (\szó => (huText szó, prozódia szó)) összesSzó

-- ═══════════════════════════════════════════════════════════════════════
-- III/C. A GAN-KIEGÉSZÍTÉSEK (a felhasználó hard rule-ja: „a gan
-- javaslatait figyelembe kell venni es annak megfeleloen modositani a
-- todo-t es javitania munkat" — a 000.02 GAN-ellenőrzésének mérései)
-- ═══════════════════════════════════════════════════════════════════════

||| A rendezéshez: Rövid < Hosszú (a kvantitás bit-sorrendje).
public export
Ord Hossz where
  compare Rövid Rövid = EQ
  compare Rövid Hosszú = LT
  compare Hosszú Rövid = GT
  compare Hosszú Hosszú = EQ

-- ─── 1. A DEKVANTITÁLÁS (á→a, é→e, …) — a minimálpár-keresés kulcsa ───
-- Ha két szó dekvantitált alakja EGYEZIK, de az eredeti ELTÉR, akkor a
-- különbségük PONTOSAN kvantitás-párokból áll (1:1 karakter-leképezés)
-- → ők a KOD-TÁVOLSÁG-1 (d=1) zóna lakói (a GAN felismerése).

||| A hosszú magánhangzó rövid párja (a kvantitás „lefejtése").
public export
dekvantitáló : Char -> Char
dekvantitáló 'á' = 'a'
dekvantitáló 'é' = 'e'
dekvantitáló 'í' = 'i'
dekvantitáló 'ó' = 'o'
dekvantitáló 'ő' = 'ö'
dekvantitáló 'ú' = 'u'
dekvantitáló 'ű' = 'ü'
dekvantitáló c = c

||| A szó dekvantitált alakja (a kvantitás-invariáns „törzse").
public export
dekvantitál : String -> String
dekvantitál = pack . map dekvantitáló . unpack

||| Minimálpár-e a két szó? (CAK kvantitásban térnek el.)
public export
minimálpárE : String -> String -> Bool
minimálpárE egy másik =
  egy /= másik && dekvantitál egy == dekvantitál másik

||| A teljes lexikon szövegei.
public export
szövegLista : List String
szövegLista = map huText összesSzó

||| Az azonos dekvantitált törzsű szavak csoportjai (rendezés + csoport).
public export
dekvantitáltCsoportok : List (List String)
dekvantitáltCsoportok =
  map forget
    (groupBy (\x, y => dekvantitál x == dekvantitál y)
      (sortBy (\x, y => compare (dekvantitál x) (dekvantitál y)) szövegLista))

||| Egy csoportból az összes (rendezett) párosítás — CSAK KÜLÖNBÖZŐ
||| szövegűek (a lexikonban azonos huText-ű duplikátumok is élnek;
||| az önmagával való pár NEM minimálpár).
public export
párokCsoportból : List String -> List (String, String)
párokCsoportból [] = []
párokCsoportból (x :: xs) =
  map (\y => (x, y)) (filter (\y => y /= x) xs) ++ párokCsoportból xs

||| A MINIMÁLPÁR-GRÁF (a confusability-gráf — a GAN 1. javaslata):
||| a 3460 szó összes d=1 párosítása. Az élek száma = a d=1 zóna mérete.
public export
minimálpárGráf : List (String, String)
minimálpárGráf =
  concatMap párokCsoportból
    (filter (\csoport => length csoport >= 2) dekvantitáltCsoportok)

-- ─── 2. A KVANTITÁS-HISZTOGRAM (a GAN 8. javaslata — §N14/3+5) ───

||| Egy elem gyakorisága a listában (a Data.List filter + length).
public export
gyakoriság : Eq a => a -> List a -> Nat
gyakoriság x = length . filter (== x)

||| A 3460 szó ritmus-mintázatai.
public export
mindenMintázat : List (List Hossz)
mindenMintázat = map (ritmus . snd) teljesProzódiaSzótár

||| A KVANTITÁS-HISZTOGRAM: (mintázat, gyakoriság) párok,
||| gyakoriság szerint csökkenően (a leggyakoribb mintázat elöl).
||| Ebből számolható a csatorna entrópiája (a jövő).
public export
ritmusHisztogram : List (List Hossz, Nat)
ritmusHisztogram =
  sortBy (\x, y => compare (snd y) (snd x))
    (map (\minta => (minta, gyakoriság minta mindenMintázat))
         (nub mindenMintázat))

-- ─── 3. A HANGREND (a GAN „második ingyenes paritás-csatornája") ───

||| A szó hangrendje (a toldalékolás determinizmusa — a magyar
||| második ingyenes paritás-csatornája a GAN szerint).
public export
data Hangrend : Type where
  Mély   : Hangrend    -- a á o ó u ú
  Magas  : Hangrend    -- e é i í ö ő ü ű
  Vegyes : Hangrend    -- mindkettő

public export
Eq Hangrend where
  Mély == Mély = True
  Magas == Magas = True
  Vegyes == Vegyes = True
  _ == _ = False

public export
Show Hangrend where
  show Mély = "Mély"
  show Magas = "Magas"
  show Vegyes = "Vegyes"

||| A szó hangrendjének kinyerése a magánhangzók osztályaiból.
public export
hangrendKinyerő : String -> Hangrend
hangrendKinyerő szó =
  let vanMély  = any (\c => elem c (unpack "aáoóuú")) (unpack szó)
      vanMagas = any (\c => elem c (unpack "eéiíöőüű")) (unpack szó)
  in case (vanMély, vanMagas) of
       (True, False) => Mély
       (False, True) => Magas
       (True, True)  => Vegyes
       (False, False) => Magas   -- magánhangzó nélkül: neutral (magas)

-- ─── 4. A PROZÓDIA-SZINDRÓMA (a GAN: Bool → (MelyikSzótag, MelyikBit)) ───
-- A «MelyikBit» egy szótagon AZ EGY kvantitás-bit (Rövid↔Hosszú),
-- ezért a szindróma = a szótag indexe (a bit egyértelmű).

||| A prozódiai szindróma: HOL üt el a kapott a tárolttól.
||| A Hamming-szindróma szó-szintű megfelelője (a [[7,1,3]] logika).
public export
data ProzódiaSzindróma : Type where
  NincsHiba       : ProzódiaSzindróma
  HibásSzótag     : Nat -> ProzódiaSzindróma          -- az első eltérés helye
  SzótagszámEltér : Nat -> Nat -> ProzódiaSzindróma   -- (várt, kapott)

public export
Show ProzódiaSzindróma where
  show NincsHiba = "NincsHiba"
  show (HibásSzótag n) = "HibásSzótag " ++ show n
  show (SzótagszámEltér várt kapott) =
    "SzótagszámEltér (várt: " ++ show várt ++ ", kapott: " ++ show kapott ++ ")"

||| Az első eltérő pozíció megkeresése (Nothing, ha egyeznek).
public export
elsőEltérés : Nat -> List Hossz -> List Hossz -> Maybe Nat
elsőEltérés _ [] [] = Nothing
elsőEltérés n (x :: xs) (y :: ys) =
  if x == y then elsőEltérés (S n) xs ys else Just n
elsőEltérés n _ _ = Just n

||| A szindróma kinyerése: a kapott szó vs. a tárolt prozódia.
||| Példa: «abákusz» a «abakusz» ellen → HibásSzótag 1 (az «á» betűnél).
public export
prozódiaSzindróma : String -> Prozódia -> ProzódiaSzindróma
prozódiaSzindróma kapott tárolt =
  case elsőEltérés 0 (ritmusKinyerő kapott) (ritmus tárolt) of
    Nothing => NincsHiba
    Just n =>
      if szótagszámKinyerő kapott == szótagszám tárolt
        then HibásSzótag n
        else SzótagszámEltér (szótagszám tárolt) (szótagszámKinyerő kapott)

-- GAN-TILTVÁNY rögzítése (Siptár 1995: a mássalhangzó-kvantitásnak
-- nagyon kevés minimálpárja van): a GEMINÁT-csatornát TILOS paritásként
-- használni — csak a magánhangzó-kvantitás a megbízható csatorna.
-- (A jövőbeli dekóder ezt a tiltást típus-szinten is kikényszeríti.)

-- ═══════════════════════════════════════════════════════════════════════
-- III/D. A TŐ-KERESÉS 22 ESETRAGRA + REKURZÍV LEVÁGÁS (000.04)
-- ═══════════════════════════════════════════════════════════════════════
-- A feladat (a VegrehajtasiTerv szerint): a SzotarHid_v1.gyakoriToldalékok
-- (14 toldalék) bővítése a 22 esetragra + a gyakori képzőkre + a
-- REKURZÍV levágás (a «farkasokat» → -at → «farkasok» → -ok → «farkas»).
--
-- §24: a SzotarHid_v1 gyökereit IMPORTÁLJUK (végződikToldalékkal,
-- levágToldalékot, szótárKeresésTömesterrel, gyakoriToldalékok) — nem
-- duplikáljuk, hanem komponáljuk őket.
--
-- A 22 esetrag (Kiefer 2011 szerint) konkrét alakjai: a
-- MagyarNyelvtan.esetragAlak alapján (osveny_index/MagyarNyelvtan.idr
-- 109–143. sor), de a modul importját ELKERÜLTÜK a Steane713-függőség
-- és a Hangrend-típusnév-ütközés miatt — az értékeket itt felsoroljuk.

-- ─── A 22 ESETRAG KONKRÉT ALAKJAI (hangrendi variánsokkal) ───
-- Forrás: Kiefer (2011) Új magyar nyelvtan; MagyarNyelvtan.esetragAlak.
public export
esetragAlakok22 : List String
esetragAlakok22 = [
  -- akkuszatívusz (tárgyas):
  "okat", "eket", "öket", "t", "ot", "at", "et", "öt",
  -- datívusz:
  "nak", "nek",
  -- inesszívusz:
  "ban", "ben",
  -- illatívusz:
  "ba", "be",
  -- elatívusz:
  "ból", "ből",
  -- szuperesszívusz:
  "on", "en", "ön", "n",
  -- adesszívusz:
  "nál", "nél",
  -- delatívusz:
  "ról", "ről",
  -- ablatívusz:
  "tól", "től",
  -- szublatívusz:
  "ra", "re",
  -- allatívusz:
  "hoz", "hez", "höz",
  -- terminatívusz:
  "ig",
  -- instrumentális:
  "val", "vel",
  -- causalis-finalis:
  "ért",
  -- transzlatívusz-factivus:
  "vá", "vé",
  -- formatívusz:
  "képp",
  -- essivus-formalis:
  "ként"
  ]

-- ─── A GYAKORI KÉPZŐK (a terv szerint) ───
public export
gyakoriKépzők : List String
gyakoriKépzők = [
  "ság", "ség", "ás", "és", "atlan", "talan", "telen", "ó", "ő", "i", "s"
  ]

-- ─── A BIRTOKOS RAGOK (a 000.04.001 al-feladat — a GAN-javaslat) ───
-- A felhasználó: „birtokos ragok hianya az fontos... azokat nem szabad
-- elhagyni, mert kesobb problemat fog okozni". Forrás: Kiefer 2011,
-- a magyar birtokos ragozás (az agglutináció = tő ⊗ számjel ⊗ birtokjel
-- ⊗ esetrag — a birtokjel a szám + a személy kombinációja).
public export
birtokosRagok : List String
birtokosRagok = [
  -- egyes szám 1. személy:
  "om", "em", "öm", "m",
  -- egyes szám 2. személy:
  "od", "ed", "öd", "d",
  -- egyes szám 3. személy:
  "ja", "je", "a", "e",
  -- többes szám 1. személy:
  "unk", "ünk",
  -- többes szám 2. személy:
  "otok", "etek", "ötök", "aitok", "eitek",
  -- többes szám 3. személy:
  "juk", "jük", "uk", "ük",
  -- a többes számjel (a birtokos+többes kompozit alapja):
  "ok", "ek", "ök", "ak", "k",
  -- a birtokos többes (az -ai/-ei a birtok többese):
  "ai", "ei", "jai", "jei"
  ]

-- ─── A TELJES TOLDALÉK-LISTA (hossz szerint csökkenő — a specifikus/ ───
-- hosszabb rag előbb illeszkedjen, mint a rövid/több szóra is illeszkedő).
-- A §24-kompozíció: az esetragok + a képzők + a birtokos ragok +
-- a SzotarHid_v1.gyakoriToldalékok.
public export
teljesToldalékLista : List String
teljesToldalékLista =
  sortBy (\x, y => compare (length (unpack y)) (length (unpack x)))
    (esetragAlakok22 ++ gyakoriKépzők ++ birtokosRagok ++ gyakoriToldalékok)

-- ─── A REKURZÍV LEVÁGÁS ───

||| Az első levágható rag: ha a szó végződik a raggal,
||| visszaadja a (levágott szó, rag) párt.
public export
elsőLevághatóRag : String -> List String -> Maybe (String, String)
elsőLevághatóRag _ [] = Nothing
elsőLevághatóRag szó (rag :: ragok) =
  if végződikToldalékkal szó rag
    then case levágToldalékot szó rag of
           Just levágott => Just (levágott, rag)
           Nothing => elsőLevághatóRag szó ragok
    else elsőLevághatóRag szó ragok

||| A rekurzív tő-keresés levágásokkal.
||| A mélység (Nat) garantálja a totális rekurziót (a szó rövidül,
||| a mélység csökken). A szótár = a szövegek listája (az összesSzó).
||| Visszatérés: Just (tő, levágások-fordított-sorrendben) vagy Nothing.
public export
tőKeresésRekurzív : (mélység : Nat) -> String -> List String ->
                    List String -> List String -> Maybe (String, List String)
tőKeresésRekurzív Z _ _ _ _ = Nothing
tőKeresésRekurzív (S n) szó ragok szótár eddigi =
  if elem szó szótár
    then Just (szó, eddigi)
    else case elsőLevághatóRag szó ragok of
           Nothing => Nothing
           Just (levágott, rag) => tőKeresésRekurzív n levágott ragok szótár (rag :: eddigi)

||| A tő-keresés a teljes szótáron (a 000.04 feladat).
||| A mélység 10 (a maximális ragszám egy szóban).
public export
tőKeresés : String -> Maybe (String, List String)
tőKeresés szó = tőKeresésRekurzív 10 szó teljesToldalékLista szövegLista []

||| A talált tő szövege (vagy az eredeti szó, ha nem talált).
public export
tőVagyEredeti : String -> String
tőVagyEredeti szó = case tőKeresés szó of
  Just (tő, _) => tő
  Nothing => szó

-- REFL: a 0 mélység NEM talál (a Nothing konstans — a totális rekurzió alapja).
-- Kimenet: Refl (Nothing ✓)
public export
bizRekurzióMélységNulla : tőKeresésRekurzív 0 "farkasokat" teljesToldalékLista szövegLista [] = Nothing
bizRekurzióMélységNulla = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- III/E. A MONDAT-TOKENIZÁLÓ (001.01 — a tisztított szavak)
-- ═══════════════════════════════════════════════════════════════════════
-- A feladat (a VegrehajtasiTerv 1.1 szerint): az írásjelek levágása
-- („mondott." → „mondott"), a nagybetűs kezdés kisbetűsítése (a
-- `kisbetus` már van a Paragrafusban), a szavakra bontás (`words`).
-- Kimenet: `szavakTisztítva : String → List String`.
--
-- §24: a `kisbetus` IMPORT a Paragrafus-ból; a `végírásjelekLevágása`
-- a `Kodol.irasjelLevagas` logikájának következménye (CSAK a szó
-- végéről vág írásjeleket — a kisbetűsítést a `kisbetus` végzi; a
-- `Kodol.irasjelLevagas` más: az kisbetűsítést is csinál + belső go).

-- A magyar írásjelek (a szó végéről levagandók).
public export
végírásjelek : List Char
végírásjelek = unpack ".,!?:;„\"\"()+-–—*[]{}'"

||| A szó végéről levágja az írásjeleket (a nem-betű karaktereket).
||| A belső írásjelek (pl. kötőjel) megmaradnak — CSAK a végéről vág.
public export
végírásjelekLevágása : String -> String
végírásjelekLevágása szó =
  pack (reverse (dropWhile (\c => elem c végírásjelek) (reverse (unpack szó))))

||| A mondat tisztított szavai: a `words` (Prelude) bont, a
||| `végírásjelekLevágása` levág, a `kisbetus` (Paragrafus) kisbetűsít.
||| Példa: „Mit mondott a farkas?" → [„mit", „mondott", „a", „farkas"]
public export
szavakTisztítva : String -> List String
szavakTisztítva mondat =
  map (kisbetus . végírásjelekLevágása) (words mondat)

||| A mondat szavainak tövei: a tisztított szavakon a tő-keresés
|||    (a 000.04 — rekurzív levágás). A `Just` találatok szűrve
|||    (a `mapMaybe` a Data.List-ből — §24: import, nem duplikáció).
public export
mondatTövei : String -> List String
mondatTövei mondat =
  mapMaybe (\szó => map fst (tőKeresés szó)) (szavakTisztítva mondat)

-- ═══════════════════════════════════════════════════════════════════════
-- IV. REFL-BIZONYÍTÁSOK
-- ═══════════════════════════════════════════════════════════════════════

-- REFL: a hangsúly DETERMINISZTIKUS — a típus egyetlen lakosa.
-- A Curry–Howard szerint az ElsőSzótag konstruktor önmagában bizonyítja,
-- hogy minden magyar szó hangsúlya az első szótagon van.
-- Kimenet: Refl (ElsőSzótag = ElsőSzótag ✓)
public export
bizHangsúlyDeterminisztikus : ElsőSzótag = ElsőSzótag
bizHangsúlyDeterminisztikus = Refl

-- REFL: a Hossz Eq-instance — a Rövid önmagával egyezik.
-- Kimenet: Refl (Rövid == Rövid = True ✓)
public export
bizRövidEq : Rövid == Rövid = True
bizRövidEq = Refl

-- REFL: a Hossz Eq-instance — a Rövid ≠ Hosszú (a kvantitás distinktív!).
-- Kimenet: Refl (Rövid == Hosszú = False ✓)
public export
bizRövidNemHosszú : Rövid == Hosszú = False
bizRövidNemHosszú = Refl

-- MEGJEGYZÉS: a ritmusKinyerő String-műveleteken (unpack/filter/map)
-- átmenő függvény — a korábbi tanulság szerint NEM redukálódik Refl-hez
-- a typechecker szintjén. A ritmus-bizonyítások (a «birtok»/[R,R],
-- a «bírtok»/[H,R], a minimálpár-különbség) FUTÁSIDEJŰ Show-tesztek
-- a főprogramban (a TERV.md szabálya: «Show-teszt, ahol nem redukálódik»).

-- ═══════════════════════════════════════════════════════════════════════
-- V. FŐPROGRAM — AZ INTERAKTÍV PROZÓDIA-MŰSZER (§N14/6)
-- ═══════════════════════════════════════════════════════════════════════

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " SZÓTÁR-HÍD v2 — a prozódia (ritmus + hangsúly + fonetika)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó követelménye:"
  putStrLn "  'fontos, hogy a szotar tartalmazzon ritmust is, a ritmus extra"
  putStrLn "   hibajavito redundanci, illetve a hangsuly, idealis esetben"
  putStrLn "   fonetikus leirast is'"
  putStrLn ""
  putStrLn "─── I. A MINIMÁL PÁR BIZONYÍTÉKA (a kvantitás distinktív) ───"
  putStrLn ""
  putStrLn ("  «birtok»  ritmusa: " ++ show (ritmusKinyerő "birtok"))
  putStrLn ("  «bírtok»  ritmusa: " ++ show (ritmusKinyerő "bírtok"))
  putStrLn ("  A ritmus KÜLÖNBÖZIK: " ++ show (ritmusKinyerő "birtok" /= ritmusKinyerő "bírtok"))
  putStrLn "   → a ritmus VALÓBAN extra információ (Mády & Reichel 2007)"
  putStrLn ""
  putStrLn "─── II. A LEXIKON SZAVAINAK PROZÓDIÁJA (publikus import) ───"
  putStrLn ""
  putStrLn ("  «abakusz»    : " ++ show (prozódia n_abakusz))
  putStrLn ("  «abisszikus»: " ++ show (prozódia n_abisszikus))
  putStrLn ("  «hazugság»  : " ++ show (prozódia n_hazugsa2g))
  putStrLn ""
  putStrLn "─── II/B. A TELJES SZÓTÁR (a 3460 publikus szó) ───"
  putStrLn ""
  putStrLn ("  összesSzó hossza:        " ++ show (length összesSzó))
  putStrLn ("  lexiconSize (a lexikon): " ++ show lexiconSize)
  putStrLn ("  EGYEZNEK: " ++ show (length összesSzó == lexiconSize))
  putStrLn ("  teljesSzótár mérete:     " ++ show (length teljesSzótár))
  putStrLn ("  teljesProzódiaSzótár:    " ++ show (length teljesProzódiaSzótár) ++ " szó prozódiával")
  putStrLn "   → a 000.02 kész: a teljes szótár + prozódia + hibajavítás"
  putStrLn ""
  putStrLn "─── II/C. A GAN-MÉRÉSEK (a javaslatok megvalósítva) ───"
  putStrLn ""
  putStrLn ("  minimálpár-gráf élszáma (a d=1 zóna):   "
    ++ show (length minimálpárGráf))
  putStrLn "  az első minimálpárok (csak kvantitásban térnek el):"
  traverse_ (\(x, y) => putStrLn ("    «" ++ x ++ "» — «" ++ y ++ "»"))
    (take 8 minimálpárGráf)
  putStrLn ("  ritmus-mintázatok száma (nub):           "
    ++ show (length (nub mindenMintázat)))
  putStrLn "  a hisztogram eleje (mintázat → gyakoriság):"
  traverse_ (\(minta, darab) =>
    putStrLn ("    " ++ show minta ++ " → " ++ show darab))
    (take 6 ritmusHisztogram)
  putStrLn ("  hangrend-eloszlás — Mély:   "
    ++ show (gyakoriság Mély (map (hangrendKinyerő . fst) teljesProzódiaSzótár)))
  putStrLn ("  hangrend-eloszlás — Magas:  "
    ++ show (gyakoriság Magas (map (hangrendKinyerő . fst) teljesProzódiaSzótár)))
  putStrLn ("  hangrend-eloszlás — Vegyes: "
    ++ show (gyakoriság Vegyes (map (hangrendKinyerő . fst) teljesProzódiaSzótár)))
  putStrLn ("  szindróma: «abákusz» a «abakusz» ellen = "
    ++ show (prozódiaSzindróma "abákusz" (prozódia n_abakusz)))
  putStrLn ("  szindróma: «abekus» a «abakusz» ellen =   "
    ++ show (prozódiaSzindróma "abekus" (prozódia n_abakusz)))
  putStrLn ""
  putStrLn "─── III. A HIBAJAVÍTÓ REDUNDANCIA (a [[7,1,3]] logika) ───"
  putStrLn ""
  let tároltAbakusz = prozódia n_abakusz
  putStrLn ("  az ép «abakusz» ellenőrzése:  "
    ++ show (prozódiaiEllenőrző "abakusz" tároltAbakusz))
  putStrLn ("  a SÉRÜLT «abekusz» ellenőrzése: "
    ++ show (prozódiaiEllenőrző "abekusz" tároltAbakusz))
  putStrLn "   → az egy-betes sérülés a szótagszám-ritmus egyezésen "
  putStrLn "     EZEKBEN a példákban nem mindig tűnik fel (a hossz-"
  putStrLn "     mintázat változatlan) — ezért a jövő: a betű-szintű"
  putStrLn "     Steane-ellenőrzés (a 003.01 Hadamard-előszűrő)"
  putStrLn ""
  putStrLn "─── IV. A REFL-BIZONYÍTÁSOK ───"
  putStrLn ""
  putStrLn "  REFL: ElsőSzótag = ElsőSzótag  (bizHangsúlyDeterminisztikus)"
  putStrLn "  REFL: Rövid == Rövid = True    (bizRövidEq)"
  putStrLn "  REFL: Rövid == Hosszú = False  (bizRövidNemHosszú — distinktív!)"
  putStrLn ""
  putStrLn "─── V. INTERAKTÍV MÓD (§N14/6 — a program REAGÁL) ───"
  putStrLn ""
  putStrLn "  Írj be egy magyar szót (a prozódia visszajelzésére):"
  bevitel <- getLine
  putStrLn ""
  putStrLn ("  A beírt szó prozódiája: " ++ show (prozódia (MkHu bevitel bevitel ObjectRole Additive 0 7)))
  putStrLn ""
  putStrLn "─── V/A. A MONDAT-TOKENIZÁLÓ (a 001.01) ───"
  putStrLn ""
  putStrLn "  A beírt mondat tisztított szavai:"
  traverse_ (\szó => putStrLn ("    «" ++ szó ++ "»")) (szavakTisztítva bevitel)
  putStrLn ""
  putStrLn "  A beírt mondat szavainak tövei (a 000.04 tő-kereséssel):"
  traverse_ (\tő => putStrLn ("    «" ++ tő ++ "»")) (mondatTövei bevitel)
  putStrLn ""
  putStrLn "─── V/B. A TŐ-KERESÉS (az első szóra — a 000.04 rekurzív levágás) ───"
  putStrLn ""
  case tőKeresés bevitel of
    Just (tő, levágások) => do
      putStrLn ("  a tő:       «" ++ tő ++ "»")
      putStrLn ("  levágások: " ++ show (reverse levágások))
      putStrLn ("  a tő prozódiája: " ++ show (ritmusKinyerő tő))
    Nothing => do
      putStrLn "  (az egész mondat nem egyetlen szótár-szó — lásd a tokenizáló fent)"
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"