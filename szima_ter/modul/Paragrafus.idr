module Paragrafus

-- ═══════════════════════════════════════════════════════════════
-- PARAGRAFUS — a paragrafus-szintű kódolás
-- ═══════════════════════════════════════════════════════════════
-- A felhasználó (2026-08-19): a baby AI-t (KisAI) ki kellene
-- terjeszteni paragrafusokra, finomítva a kódolását.
--
-- A KisAI mintája (Dirac3D/KisAI.idr):
--   kodolSzoveg : String -> List (String, BitKod) -> BitKod
--   szavakra bont, szótári bitet keres, bit-OR.
--
-- Ez a modul a mintát PARAGRAFUS-szintre emeli:
--   a szavak → bitek helyett a mondatok → komplex bájtok.
--   A paragrafus = List KomplexBajt, és minden mondat egy komplex
--   bájtba kódolódik (az összetevő szavak súlyozott összege).
--
-- A kódolás lépései:
--   1. a paragrafust mondatokra bontjuk (írásjelek szerint),
--   2. minden mondat szavaira bontjuk,
--   3. minden szóhoz a szótárból veszünk egy 8-komponensű komplex
--      vektort (a szó "jelentésfázisa"),
--   4. a mondat komplex bájtja = a szóvektorok összege,
--   5. a paragrafus = a mondat-komplex bájtok listája.
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import Data.String
import Data.List1

%default total

-- ─── 1. ALAPTÍPUSOK ─────────────────────────────────────────

||| Egy szó komplex jelentésvektora: 8 komplex komponens.
||| Ugyanaz a 8 dimenzió, mint a KomplexBajt-nál: [idő, okság, tér,
||| szín, hang, fázis, mód, chiralitás].
public export
record SzoJelentes where
  constructor SzoJelentesKonstruktor
  szo            : String
  idoJel        : Komplex
  oksagJel      : Komplex
  terJel        : Komplex
  szinJel       : Komplex
  hangJel       : Komplex
  fazisJel      : Komplex
  modJel        : Komplex
  chiralitasJel : Komplex

||| A szótár: szó → jelentésvektor.
public export
Szotar : Type
Szotar = List SzoJelentes

||| A paragrafus: mondatok listája, minden mondat egy komplex bájt.
public export
Paragrafus : Type
Paragrafus = List KomplexBajt

-- ─── 2. MONDATRA BONTÁS ─────────────────────────────────────

||| Mondatvégző írásjel-e a karakter?
public export
mondatvege : Char -> Bool
mondatvege c = c == '.' || c == '!' || c == '?'

||| A paragrafus szövegét mondatokra bontjuk a Data.String.split-tel
||| (List1 String-t ad, forget-tel List String lesz).
||| Az üres darabokat kiszűrjük (pl. a záró pont utáni üres).
public export
szovegMondatokra : String -> List String
szovegMondatokra szoveg =
  filter (\s => s /= "") (forget (split mondatvege szoveg))

-- ─── 3. SZÓ → JELENTÉSVEKTOR ────────────────────────────────

szoMezo : SzoJelentes -> String
szoMezo = szo

kisbetusKarakter : Char -> Char
kisbetusKarakter c =
  if c >= 'A' && c <= 'Z'
  then cast (cast {to = Int} c + 32)
  else c

||| Kisbetűsítés: a mondatkezdő nagybetű ne tévessze meg a szótárat.
||| A magyar ékezetes betűk helyben maradnak (a szótár is ékezetes).
||| A String nem Functor, ezért unpack/map/pack kell.
public export
kisbetus : String -> String
kisbetus szoveg = pack (map kisbetusKarakter (unpack szoveg))

||| Szó keresése a szótárban, kisbetűsítés után.
||| Ha nincs, az üres (nulla) vektor.
public export
szotarKeres : String -> Szotar -> SzoJelentes
szotarKeres _ [] =
  SzoJelentesKonstruktor "" komplexZero komplexZero komplexZero
    komplexZero komplexZero komplexZero komplexZero komplexZero
szotarKeres szo (x :: xs) =
  if (kisbetus szo) == (kisbetus (szoMezo x)) then x else szotarKeres szo xs

-- ─── 4. SZAVAK ÖSSZEGE → MONDAT KOMPLEX BÁJTJA ──────────────

osszeadKomplex : Komplex -> Komplex -> Komplex
osszeadKomplex (KomplexKonstruktor a b) (KomplexKonstruktor c d) =
  KomplexKonstruktor (a + c) (b + d)

||| Két jelentésvektor összege (komponensenként).
public export
osszeadJelentes : SzoJelentes -> SzoJelentes -> SzoJelentes
osszeadJelentes (SzoJelentesKonstruktor s1 a1 b1 c1 d1 e1 f1 g1 h1)
                (SzoJelentesKonstruktor s2 a2 b2 c2 d2 e2 f2 g2 h2) =
  SzoJelentesKonstruktor
    (s1 ++ " " ++ s2)
    (osszeadKomplex a1 a2) (osszeadKomplex b1 b2) (osszeadKomplex c1 c2)
    (osszeadKomplex d1 d2) (osszeadKomplex e1 e2) (osszeadKomplex f1 f2)
    (osszeadKomplex g1 g2) (osszeadKomplex h1 h2)

||| Egy mondat szavainak összevont jelentésvektora.
||| Az üres mondat → üres vektor.
public export
mondatJelentese : String -> Szotar -> SzoJelentes
mondatJelentese mondat szotar =
  let szavak = words mondat
  in foldr (osszeadJelentes) (SzoJelentesKonstruktor "" komplexZero komplexZero
       komplexZero komplexZero komplexZero komplexZero komplexZero komplexZero)
       (map (\w => szotarKeres w szotar) szavak)

||| Küszöbfüggvény: re > 0.5 → Egy, különben Nulla.
||| A Steane [[7,1,3]] bemenete: 7 bit a 8 komponensből (a 8. a chiralitás,
||| ami a paritás).
erossKubit : Komplex -> Kubit
erossKubit (KomplexKonstruktor re _) = if re > 0.5 then Egy else Nulla

||| Jelentésvektor → komplex bájt.
||| A cimke a mondat szövege; a Steane bitjei a 8 komponens
||| "erősségéből" (re > 0.5?) — egyszerű küszöb, hibajavításra.
public export
jelentesKomplexBajtra : String -> SzoJelentes -> KomplexBajt
jelentesKomplexBajtra mondat (SzoJelentesKonstruktor _ a b c d e f g h) =
  KomplexBajtKonstruktor a b c d e f g h
    (CptFazisKonstruktor JelenI FolyamatosSz KozvetlenF)
    (HetesKodKonstruktor
      (erossKubit a) (erossKubit b) (erossKubit c) (erossKubit d)
      (erossKubit e) (erossKubit f) (erossKubit g))
    mondat

-- ─── 5. A PARAGRAFUS-KÓDOLÁS ────────────────────────────────

||| Paragrafus → komplex bájtok listája.
||| A paragrafust mondatokra bontjuk, minden mondatot egy komplex
||| bájtba kódolunk (a szótárból összeadott szóvektorok).
public export
paragrafusKodol : String -> Szotar -> Paragrafus
paragrafusKodol szoveg szotar =
  map (\m => jelentesKomplexBajtra m (mondatJelentese m szotar))
      (szovegMondatokra szoveg)

-- ─── 6. PÉLDA SZÓTÁR — a Piroska-mondatok ───────────────────

||| Példa szótár: az alap szavak és jelentésvektoraik.
||| A vektorok a 8 dimenzióba mutatnak (a re részek a dimenziókban,
||| az im részek a fázis).
public export
Peldaszotar : Szotar
Peldaszotar =
  [ SzoJelentesKonstruktor "farkas"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
  , SzoJelentesKonstruktor "piroska"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "hazugsag"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
  , SzoJelentesKonstruktor "vadasz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  ]

-- ─── 7. REFL-BIZONYÍTÁSOK ───────────────────────────────────

||| Refl — a kisbetűsítés a "FARKAS" szót "farkas"-szá alakítja.
||| (az ASCII nagybetű → kisbetű eltolás determinisztikus)
public export
bizKisbetusFarkas :
  kisbetus "FARKAS" = "farkas"
bizKisbetusFarkas = Refl

||| Refl — a paragrafus "Piroska." egyetlen mondatot tartalmaz.
public export
bizEgyMondat :
  length (szovegMondatokra "Piroska.") = 1
bizEgyMondat = Refl

||| Refl — az üres szöveg nem tartalmaz mondatot.
public export
bizUresSzoveg :
  length (szovegMondatokra "") = 0
bizUresSzoveg = Refl
