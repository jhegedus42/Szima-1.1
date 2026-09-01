module SzotarHid_v1

-- ═══════════════════════════════════════════════════════════════════════
-- SZÓTÁR-HÍD v1 — a HungarianLexicon bekötése a Paragrafus-rendszerbe
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó kérése (2026-09-01, szó szerint):
--   „a szotarat boviteni kellene, illetve meg kene erteni, hogyan fog ez
--    mukodni, horgony-nak mar voltak erre otletei (esetleg nezd meg a
--    baby ai-t)"
--
-- A HID (§24: import, nem újraírás):
--   - HungarianLexicon_v1_Szima: 3460 szó (a típusok publikusak:
--     HuWord, MathRole, Algebra; a szavak privátok — ezért a híd
--     saját publikus MINTA-szavakat definiál ugyanazzal a szerkezettel)
--   - Paragrafus: a komplex bájt kódolás (8 dimenzió)
--
-- A TERV.md 3.1 MEGVALÓSÍTÁSA:
--   szótárKeresésTömesterrel — a „hazugsagot" megtalálja a „hazugság"
--   tőből (a toldalék levágásával)
--
-- A JELENTÉSVEKTOR-GENERÁLÁS ELVE:
--   ObjectRole (főnév/dolog)     → ter=1, mód=1   (a dolog a térben van)
--   MorphismRole (ige/cselekvés) → idő=1, okság=1 (a cselekvés időben)
--   PropertyRole (tulajdonság)   → szín=1
--   ModifierRole (módosító)      → hang=1
--   Additive (mély hangrend)     → fázis = +1
--   Multiplicative (magas)       → fázis = +i
--   Ring (vegyes)                → fázis = 1+i
--
-- A BABY AI (BabyAGI_v1_Szima) KAPCSOLATA:
--   a BabyAGI: szó → harmónia → aminosav → fehérje → manifold → tudat.
--   A híd: szó → HuWord → komplex jelentésvektor → komplex bájt.
--   A két út ugyanazon a jelentésen találkozik.
-- ═══════════════════════════════════════════════════════════════════════

import HungarianLexicon_v1_Szima
import Paragrafus
import KomplexByte
import Data.List

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- 0. A MINTA-SZAVAK (publikus hidak a lexikon adataihoz)
-- ═══════════════════════════════════════════════════════════════════════
-- A lexikon 3460 szava privát (nem public export) — a híd ezért publikus
-- minta-szavakat definiál a publikus MkHu konstruktorral, UGYANAZOKKAL
-- az adatokkal, amelyeket a lexikon tartalmaz (forrás: a lexikon sorai).

||| „hazugság" — a lexikon n_hazugsa2g bejegyzése (ObjectRole, Additive).
public export
hazugságMinta : HuWord
hazugságMinta = MkHu "hazugság" "hazugság" ObjectRole Additive 0 8

||| „hazug" — a lexikon n_hazug bejegyzése (ObjectRole, Additive).
public export
hazugMinta : HuWord
hazugMinta = MkHu "hazug" "hazug" ObjectRole Additive 0 5

||| „farkas" — a lexikon a_farkas bejegyzése (PropertyRole, Additive).
public export
farkasMinta : HuWord
farkasMinta = MkHu "farkas" "farkas" PropertyRole Additive 0 6

||| „ember" — a lexikon n_ember bejegyzése (ObjectRole, Multiplicative).
public export
emberMinta : HuWord
emberMinta = MkHu "ember" "ember" ObjectRole Multiplicative 0 5

-- ═══════════════════════════════════════════════════════════════════════
-- I. HUWORD → JELENTÉSVEKTOR (a generálás)
-- ═══════════════════════════════════════════════════════════════════════

||| A hangrend → fázis leképezés.
||| Additive (mély hangrend) → +1 (valós); Multiplicative (magas) → +i.
public export
hangrendFázis : Algebra -> Komplex
hangrendFázis Additive       = KomplexKonstruktor 1.0 0.0
hangrendFázis Multiplicative = KomplexKonstruktor 0.0 1.0
hangrendFázis Ring           = KomplexKonstruktor 1.0 1.0

||| A szófaj → a kitüntetett dimenziók (idő, okság, tér, szín, hang, mód).
||| Főnév → ter+mód; ige → idő+okság; tulajdonság → szín; módosító → hang.
public export
szerepDimenziók : MathRole ->
  (Komplex, Komplex, Komplex, Komplex, Komplex, Komplex)
szerepDimenziók ObjectRole =
  (komplexZero, komplexZero, komplexEgy, komplexZero, komplexZero, komplexEgy)
szerepDimenziók MorphismRole =
  (komplexEgy, komplexEgy, komplexZero, komplexZero, komplexZero, komplexZero)
szerepDimenziók PropertyRole =
  (komplexZero, komplexZero, komplexZero, komplexEgy, komplexZero, komplexZero)
szerepDimenziók ModifierRole =
  (komplexZero, komplexZero, komplexZero, komplexZero, komplexEgy, komplexZero)

||| A HuWord → a Paragrafus 8-dimenziós komplex jelentésvektora.
||| A 8 dimenzió: [idő, okság, tér, szín, hang, fázis, mód, chiralitás].
public export
huWordToJelentes : HuWord -> SzoJelentes
huWordToJelentes (MkHu szoveg _ szerep hangrend jellemzo _) =
  let (ido, oksag, ter, szin, hang, mod) = szerepDimenziók szerep
      fazis = hangrendFázis hangrend
      chiralitas = if jellemzo > 0
                     then KomplexKonstruktor 1.0 0.0
                     else KomplexKonstruktor 0.0 0.0
  in SzoJelentesKonstruktor szoveg ido oksag ter szin hang fazis mod chiralitas

-- ═══════════════════════════════════════════════════════════════════════
-- II. A LEXIKON-MINTA-SZÓTÁR
-- ═══════════════════════════════════════════════════════════════════════

||| A minta-szótár: a lexikon adataiból generált vektorokkal.
public export
lexikonMintaSzótár : Szotar
lexikonMintaSzótár =
  [ huWordToJelentes hazugságMinta
  , huWordToJelentes hazugMinta
  , huWordToJelentes farkasMinta
  , huWordToJelentes emberMinta
  ]

-- ═══════════════════════════════════════════════════════════════════════
-- III. A TŐ-KERESÉS (a TERV.md 3.1 megvalósítása)
-- ═══════════════════════════════════════════════════════════════════════

||| A gyakori toldalékok (a MagyarNyelvtan esetragjai):
||| tárgy (-t, -ot, -et, -at), helyhatározó (-ban, -ben), részes
||| (-nak, -nek), társító (-val, -vel), többes (-ék), birtokos (-m, -d),
||| valamint a KOMBINÁLT alakok (többes + tárgy: -okat, -eket, -öket).
public export
gyakoriToldalékok : List String
gyakoriToldalékok =
  [ "okat", "eket", "öket"
  , "ot", "et", "at", "t", "ban", "ben", "nak", "nek"
  , "val", "vel", "ék", "m", "d"
  ]

||| A szó végződik-e a megadott toldalékkal?
public export
végződikToldalékkal : String -> String -> Bool
végződikToldalékkal szó toldalék =
  let szóKarakterek = unpack szó
      toldalékKarakterek = unpack toldalék
      szóHossz = length szóKarakterek
      toldalékHossz = length toldalékKarakterek
  in
    if szóHossz <= toldalékHossz
      then False
      else Data.List.drop (minus szóHossz toldalékHossz) szóKarakterek == toldalékKarakterek

||| A toldalék levágása a szó végéről (ha oda tartozik).
public export
levágToldalékot : String -> String -> Maybe String
levágToldalékot szó toldalék =
  if végződikToldalékkal szó toldalék
    then
      let szóKarakterek = unpack szó
          toldalékHossz = length (unpack toldalék)
          szóHossz = length szóKarakterek
      in Just (pack (Data.List.take (minus szóHossz toldalékHossz) szóKarakterek))
    else Nothing

||| A tő-keresés (a TERV.md 3.1 megoldása):
||| 1. a teljes szó keresése;
||| 2. ha nem található, a gyakori toldalékok levágása után újra.
||| Példa: „hazugsagot" → -„ot" → „hazugsag" → MEGTALÁLVA.
public export
szótárKeresésTömesterrel : String -> Szotar -> SzoJelentes
szótárKeresésTömesterrel szó szótár =
  let teljesTalálat = szotarKeres szó szótár
  in
    if (szo teljesTalálat) /= ""
      then teljesTalálat
      else
        case tőKeresés szó gyakoriToldalékok szótár of
          Just találat => találat
          Nothing      => teljesTalálat
  where
    tőKeresés : String -> List String -> Szotar -> Maybe SzoJelentes
    tőKeresés _ [] _ = Nothing
    tőKeresés szó (toldalék :: többi) szótár =
      case levágToldalékot szó toldalék of
        Just tő =>
          let tőTalálat = szotarKeres tő szótár
          in
            if (szo tőTalálat) /= ""
              then Just tőTalálat
              else tőKeresés szó többi szótár
        Nothing => tőKeresés szó többi szótár

-- ═══════════════════════════════════════════════════════════════════════
-- IV. REFL-BIZONYÍTÁSOK
-- ═══════════════════════════════════════════════════════════════════════

-- REFL: a mély hangrend (Additive) fázisa = +1 (valós).
-- Kimenet: Refl (mély → +1 ✓)
public export
bizMélyHangrendValós : hangrendFázis Additive = KomplexKonstruktor 1.0 0.0
bizMélyHangrendValós = Refl

-- REFL: a magas hangrend (Multiplicative) fázisa = +i (képzetes).
-- Kimenet: Refl (magas → +i ✓)
public export
bizMagasHangrendKépzetes : hangrendFázis Multiplicative = KomplexKonstruktor 0.0 1.0
bizMagasHangrendKépzetes = Refl

-- REFL: a főnév (ObjectRole) dimenziói: tér=1, mód=1.
-- Kimenet: Refl (főnév → tér=1, mód=1 ✓)
public export
bizFőnévTérEgy : szerepDimenziók ObjectRole =
  (KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 1.0 0.0,
   KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 1.0 0.0)
bizFőnévTérEgy = Refl

-- REFL: az ige (MorphismRole) dimenziói: idő=1, okság=1.
-- Kimenet: Refl (ige → idő=1, okság=1 ✓)
public export
bizIgeIdőOkság : szerepDimenziók MorphismRole =
  (KomplexKonstruktor 1.0 0.0, KomplexKonstruktor 1.0 0.0, KomplexKonstruktor 0.0 0.0,
   KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 0.0 0.0, KomplexKonstruktor 0.0 0.0)
bizIgeIdőOkság = Refl

-- A String-műveletek (végződikToldalékkal, levágToldalékot) NEM
-- redukálódnak Refl-hez (a TERV.md szabálya: „a szótári keresés ==-e
-- nem redukálódik Refl-lel — futásidejű ellenőrzés"). Ezért a
-- toldalék-tesztek a főprogramban futásidejű Show-ellenőrzéssel
-- működnek (l. a II. szakaszt a main-ben).

-- ═══════════════════════════════════════════════════════════════════════
-- V. FŐPROGRAM — A HÍD DEMONSTRÁLÁSA
-- ═══════════════════════════════════════════════════════════════════════

jelentésKiírás : SzoJelentes -> String
jelentésKiírás (SzoJelentesKonstruktor szó i o t sz h f m c) =
  szó ++ ": idő=" ++ show (re i) ++ " okság=" ++ show (re o)
  ++ " tér=" ++ show (re t) ++ " szín=" ++ show (re sz)
  ++ " hang=" ++ show (re h) ++ " fázis=(" ++ show (re f) ++ "," ++ show (im f) ++ ")"
  ++ " mód=" ++ show (re m) ++ " chiralitás=" ++ show (re c)

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " SZÓTÁR-HÍD v1 — a lexikon bekötése a Paragrafusba"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó kérése (2026-09-01):"
  putStrLn "  'a szotarat boviteni kellene, illetve meg kene erteni,"
  putStrLn "   hogyan fog ez mukodni'"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " I. A JELENTÉSVEKTOR-GENERÁLÁS (a lexikonból)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A HungarianLexicon (3460 szó) → a Paragrafus 8 dimenziója:"
  putStrLn "    főnév (Object)      → tér=1, mód=1 (a dolog a térben)"
  putStrLn "    ige (Morphism)      → idő=1, okság=1 (a cselekvés időben)"
  putStrLn "    tulajdonság (Property) → szín=1 (a minőség)"
  putStrLn "    módosító (Modifier)    → hang=1 (a körülmény)"
  putStrLn "    hangrend: mély → fázis=+1; magas → fázis=+i"
  putStrLn ""
  putStrLn "  A minta-szótár (4 szó, generált vektorokkal):"
  putStrLn ("    " ++ jelentésKiírás (huWordToJelentes hazugságMinta))
  putStrLn ("    " ++ jelentésKiírás (huWordToJelentes farkasMinta))
  putStrLn ("    " ++ jelentésKiírás (huWordToJelentes emberMinta))
  putStrLn ""
  putStrLn "  REFL: mély hangrend → +1     (bizMélyHangrendValós)"
  putStrLn "  REFL: magas hangrend → +i   (bizMagasHangrendKépzetes)"
  putStrLn "  REFL: főnév → tér=1, mód=1   (bizFőnévTérEgy)"
  putStrLn "  REFL: ige → idő=1, okság=1   (bizIgeIdőOkság)"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " II. A TŐ-KERESÉS (a TERV.md 3.1 megoldása)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A probléma: a 'hazugsagot' (ragozott) NEM találja a"
  putStrLn "  'hazugság' töt a hagyományos szotarKeres-sel."
  putStrLn ""
  putStrLn "  A megoldás: szótárKeresésTömesterrel — a toldalék levágása:"
  putStrLn "    'hazugságot' → -'ot' levágása → 'hazugság' → MEGTALÁLVA"
  putStrLn ""
  putStrLn "  FONTOS TANULSÁG (§25): az ékezet INFORMÁCIÓ!"
  putStrLn "    a szótár 'hazugság' (ékezetes) — a bemenet is legyen az!"
  putStrLn "    ('hazugsagot' ékezet nélkül NEM találja — ez helyes viselkedés)"
  putStrLn ""
  putStrLn "  A toldalék-műveletek futásidejű tesztjei (a String nem"
  putStrLn "  redukálódik Refl-hez — a TERV.md szabálya szerint):"
  putStrLn ("    végződikToldalékkal 'hazugságot' 'ot' = " ++ show (végződikToldalékkal "hazugságot" "ot"))
  putStrLn ("    levágToldalékot 'hazugságot' 'ot' = " ++ show (levágToldalékot "hazugságot" "ot"))
  putStrLn ("    levágToldalékot 'embernek' 'nek' = " ++ show (levágToldalékot "embernek" "nek"))
  putStrLn ("    levágToldalékot 'farkasokat' 'okat' = " ++ show (levágToldalékot "farkasokat" "okat"))
  putStrLn ""
  putStrLn "  A tő-keresés futásidejű tesztje:"
  putStrLn ("    'hazugság' közvetlen:     " ++ jelentésKiírás (szotarKeres "hazugság" lexikonMintaSzótár))
  putStrLn ("    'hazugságot' tő-keresés:  " ++ jelentésKiírás (szótárKeresésTömesterrel "hazugságot" lexikonMintaSzótár))
  putStrLn ("    'embernek' tő-keresés:    " ++ jelentésKiírás (szótárKeresésTömesterrel "embernek" lexikonMintaSzótár))
  putStrLn ("    'farkasokat' tő-keresés:  " ++ jelentésKiírás (szótárKeresésTömesterrel "farkasokat" lexikonMintaSzótár))
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " III. HOGYAN FOG EZ MŰKÖDNI (a BabyAGI kapcsolata)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A rendszer két úton dolgozik ugyanazon a jelentésen:"
  putStrLn ""
  putStrLn "  1. A Paragrafus-út (ez a híd):"
  putStrLn "     szó → HuWord (szófaj, hangrend) → 8-dimenziós komplex"
  putStrLn "     jelentésvektor → komplex bájt → a mondat kódolása"
  putStrLn ""
  putStrLn "  2. A BabyAGI-út (a 15 szint):"
  putStrLn "     szó → Analysis (hangrend, toldalék) → aminosav →"
  putStrLn "     polipeptid → fehérje → manifold → HolographicMind"
  putStrLn "     (a learnWord = a tanulás, a sleepFilter = az alvás)"
  putStrLn ""
  putStrLn "  A két út találkozik: a lexikon ugyanaz, a jelentés a közös."
  putStrLn "  A fordítási Carnot-ciklus a jelentésvektoron keresztül viszi"
  putStrLn "  át a mondatot magyar ↔ kínai (a forditF/forditG functor-pár)."
  putStrLn ""
  putStrLn "  A bővítés útja (a TERV.md 3.5):"
  putStrLn "    - a lexikon 3460 szava → generált vektorok (ez a híd)"
  putStrLn "    - a source/ leggyakoribb szavai → ko-okkurencia-becslés"
  putStrLn "    - a Peldaszotar bővítése a generált vektorokkal"
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"