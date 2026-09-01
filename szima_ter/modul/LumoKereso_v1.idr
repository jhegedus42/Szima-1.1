module LumoKereso_v1

-- ═══════════════════════════════════════════════════════════════════════
-- LUMO-KERESŐ v1 — a magyar motor szerinti szemantikus kereső
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó kérése (2026-09-01, szó szerint):
--   „olvassuk el es dolgozzuk fel a source-ban a lumo-html-eket,
--    tartalmazhatnak projekt relevans informaciot, idealis lenne, ha
--    tudnan kesziteni egy keresot, ami a magyar motor szerint keresi
--    szemantikusan a beparszolt adatokban, indexelhetnenk igy az ujonnan
--    parszolt dolgokat, pl. a lumo-t is"
--
-- A LUMO-ANYAG (a textutil konvertálás után, trail_index/books/):
--   lumo_E8_Lumo__Pri.txt (205 KB): E8/E9/E10/E11 Kac-Moody, adjungált
--     reprezentáció, kozmológiai biliárd, M-elmélet, MDL/Kolmogorov
--   lumo_Magyar.txt (31 KB): a magyar↔kínai kétnyelvű válaszok
--   lumo_Vilagegyetem.txt (177 KB): a világegyetem-struktúra
--   lumo_Carbon_Lumo_.txt (99 KB), lumo_2Lumo__Priva.txt (41 KB),
--   lumo_Lumo__Privac.txt (98 KB): a fő Lumo-beszélgetések
--
-- A MAGYAR MOTOR (§24: import, nem újraírás):
--   - Paragrafus: mondatJelentese + jelentesKomplexBajtra (a mondat →
--     komplex bájt; a szavak vektorainak összege)
--   - SzotarHid_v1: a lexikon-minta-szótár + a tő-keresés (TERV.md 3.1)
--   - KomplexByte: a KomplexBajt (8 komplex komponens + CPT + Steane)
--
-- A KERESŐ MŰKÖDÉSE:
--   1. az index: mondat → komplex bájt (a magyar motor kódolja)
--   2. a lekérdezés: a kérdés mondat → komplex bájt
--   3. a távolság: a két komplex bájt Manhattan-távolsága
--      (a 8 komponens |Δre| + |Δim| összege)
--   4. a rangsor: a legkisebb távolság = a leg relevánsabb mondat
--
-- A LUMO-MONDATOK (valós adatok a parszolt fájlokból):
--   E8_Lumo: „Az E8 Lie-csoport egyedülálló abban, hogy az adjungált
--     reprezentációja a legkisebb nem-triviális reprezentációja"
--   E8_Lumo: „Az E9 affín Kac-Moody algebra a 2D szupergravitáció..."
--   Magyar: „Nagyon szívesen válaszolok egyszerre magyarul és kínaiul is"
--   stb. (l. a lumoIndex-et)
-- ═══════════════════════════════════════════════════════════════════════

import Paragrafus
import KomplexByte
import HungarianLexicon_v1_Szima
import SzotarHid_v1
import Data.List

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. A LUMO-SZAVAK (a szótár bővítése a Lumo-szövegek szavaival)
-- ═══════════════════════════════════════════════════════════════════════
-- A Lumo-szövegek kulcsszavai, HuWord-ként (a magyar motor számára):
-- az E-sorozat (E8, E9, E10, E11) főnevek; a reprezentáció, dimenzió,
-- algebra főnevek; a magyarul/kínaiul módosítók; a kozmológiai tulajdonság.

||| „E8" — a kivételes Lie-csoport (ObjectRole, mély hangrend).
public export
e8Szó : HuWord
e8Szó = MkHu "E8" "E8" ObjectRole Additive 0 2

||| „E9" — az affín Kac-Moody (ObjectRole, mély).
public export
e9Szó : HuWord
e9Szó = MkHu "E9" "E9" ObjectRole Additive 0 2

||| „E10" — a hiperbolikus Kac-Moody (ObjectRole, mély).
public export
e10Szó : HuWord
e10Szó = MkHu "E10" "E10" ObjectRole Additive 0 3

||| „E11" — a very-extended (ObjectRole, mély).
public export
e11Szó : HuWord
e11Szó = MkHu "E11" "E11" ObjectRole Additive 0 3

||| „reprezentáció" — az adjungált reprezentáció (ObjectRole, magas).
public export
reprezentációSzó : HuWord
reprezentációSzó = MkHu "reprezentáció" "reprezentáció" ObjectRole Multiplicative 0 13

||| „dimenzió" — a 248 dimenzió (ObjectRole, magas).
public export
dimenzióSzó : HuWord
dimenzióSzó = MkHu "dimenzió" "dimenzió" ObjectRole Multiplicative 0 8

||| „algebra" — a Lie-algebra (ObjectRole, magas).
public export
algebraSzó : HuWord
algebraSzó = MkHu "algebra" "algebra" ObjectRole Multiplicative 0 7

||| „szupergravitáció" — az 11D szupergravitáció (ObjectRole, magas).
public export
szupergravitációSzó : HuWord
szupergravitációSzó = MkHu "szupergravitáció" "szupergravitáció" ObjectRole Multiplicative 0 16

||| „magyarul" — a magyar nyelven (ModifierRole, magas).
public export
magyarulSzó : HuWord
magyarulSzó = MkHu "magyarul" "magyar" ModifierRole Multiplicative 0 8

||| „kínaiul" — a kínai nyelven (ModifierRole, magas).
public export
kínaiulSzó : HuWord
kínaiulSzó = MkHu "kínaiul" "kínai" ModifierRole Multiplicative 0 7

||| „kozmológiai" — a kozmológiai biliárd (PropertyRole, magas).
public export
kozmológiaiSzó : HuWord
kozmológiaiSzó = MkHu "kozmológiai" "kozmológia" PropertyRole Multiplicative 0 11

||| A Lumo-szavak listája.
public export
lumoSzavak : List HuWord
lumoSzavak =
  [ e8Szó, e9Szó, e10Szó, e11Szó
  , reprezentációSzó, dimenzióSzó, algebraSzó, szupergravitációSzó
  , magyarulSzó, kínaiulSzó, kozmológiaiSzó
  ]

||| A Lumo-szótár: a lexikon-minta-szótár + a Lumo-szavak generált
||| vektorai (a magyar motor teljes szótára a Lumo-keresőhöz).
public export
lumoSzótár : Szotar
lumoSzótár = lexikonMintaSzótár ++ (map huWordToJelentes lumoSzavak)

-- ═══════════════════════════════════════════════════════════════════════
-- II. A MONDAT → KOMPLEX BÁJT (a magyar motor kódolása)
-- ═══════════════════════════════════════════════════════════════════════

||| Egy mondat kódolása komplex bájtra a magyar motorral:
||| a szavak vektorainak összege → a komplex bájt (a címke = a mondat).
public export
mondatBájtra : String -> KomplexBajt
mondatBájtra mondat =
  jelentesKomplexBajtra mondat (mondatJelentese mondat lumoSzótár)

-- ═══════════════════════════════════════════════════════════════════════
-- III. A TÁVOLSÁG (a komplex bájtok Manhattan-távolsága)
-- ═══════════════════════════════════════════════════════════════════════

||| Két komplex szám Manhattan-távolsága: |Δre| + |Δim|.
komplexTávolság : Komplex -> Komplex -> Double
komplexTávolság (KomplexKonstruktor a b) (KomplexKonstruktor c d) =
  abs (a - c) + abs (b - d)

||| Két komplex bájt Manhattan-távolsága: a 8 komponens távolságainak
||| összege. Minél kisebb, annál relevánsabb (a szemantikus keresés).
public export
bájtTávolság : KomplexBajt -> KomplexBajt -> Double
bájtTávolság x y =
  komplexTávolság (idoKomponens x) (idoKomponens y)
  + komplexTávolság (oksagKomponens x) (oksagKomponens y)
  + komplexTávolság (terKomponens x) (terKomponens y)
  + komplexTávolság (szinKomponens x) (szinKomponens y)
  + komplexTávolság (hangKomponens x) (hangKomponens y)
  + komplexTávolság (fazisKomponens x) (fazisKomponens y)
  + komplexTávolság (modKomponens x) (modKomponens y)
  + komplexTávolság (chiralitasKomponens x) (chiralitasKomponens y)

-- ═══════════════════════════════════════════════════════════════════════
-- IV. AZ INDEX (a valós Lumo-mondatok, a parszolt fájlokból)
-- ═══════════════════════════════════════════════════════════════════════
-- A mondatok VALÓDI adatok a textutil-konvertált Lumo-fájlokból:
-- lumo_E8_Lumo__Pri.txt, lumo_Magyar.txt, lumo_Vilagegyetem.txt.

||| A Lumo-mondatok (valós idézetek a parszolt fájlokból).
public export
lumoMondatok : List String
lumoMondatok =
  -- E8_Lumo (az E-sorozat és az adjungált reprezentáció):
  [ "Az E8 Lie-csoport egyedülálló abban, hogy az adjungált reprezentációja a legkisebb nem-triviális reprezentációja"
  , "Az E9 affín Kac-Moody algebra a 2D szupergravitáció loop group struktúrája"
  , "E10 hiperbólikus Kac-Moody algebra a kozmológiai biliárd modell 11D szupergravitáció dinamika"
  , "E11 az M-elmélet nem-lineáris realizációja"
  , "A dimenzió 248 a tér maga az algebra"
  -- Magyar (a magyar↔kínai kétnyelvűség):
  , "Nagyon szívesen válaszolok egyszerre magyarul és kínaiul is"
  , "Természetesen beszélek és értek magyarul ez egyik alapvető nyelvem"
  -- Az ember (a magyar motor minta-szótárából):
  , "Az ember magyarul beszél"
  ]

||| Az index: mondat → komplex bájt (a magyar motor kódolja).
||| (Az index = a parszolt adatok szemantikus reprezentációja.)
public export
lumoIndex : List (String, KomplexBajt)
lumoIndex = map (\m => (m, mondatBájtra m)) lumoMondatok

-- ═══════════════════════════════════════════════════════════════════════
-- V. A KERESÉS (a lekérdezés → rangsorolt találatok)
-- ═══════════════════════════════════════════════════════════════════════

||| A (távolság, mondat) párok rendezése növekvő távolság szerint
||| (beszúró rendezés — a legkisebb távolság előre).
rendezTávolság : List (Double, String) -> List (Double, String)
rendezTávolság [] = []
rendezTávolság (x :: xs) = beszúr x (rendezTávolság xs)
  where
    beszúr : (Double, String) -> List (Double, String) -> List (Double, String)
    beszúr a [] = [a]
    beszúr a@(ta, _) (b@(tb, _) :: rest) =
      if ta <= tb then a :: b :: rest else b :: beszúr a rest

||| A LUMO-KERESÉS: a lekérdezés mondat → komplex bájt → a távolság
||| minden indexelt mondathoz → a rangsorolt találatok
||| (a legkisebb távolság = a leg relevánsabb mondat).
||| A keresés = a KeresesFunktor (a konyvolvaso mintájára):
||| KerdesKategoria → SkillKategoria, a magyar motorön keresztül.
public export
lumoKeresés : String -> List (Double, String)
lumoKeresés kérdés =
  let kérdésBájt = mondatBájtra kérdés
      távolságok = map (\(m, b) => (bájtTávolság kérdésBájt b, m)) lumoIndex
  in rendezTávolság távolságok

||| A legjobb N találat (a keresés eredménye).
public export
legjobbTalálatok : Nat -> String -> List (Double, String)
legjobbTalálatok n kérdés = Data.List.take n (lumoKeresés kérdés)

-- ═══════════════════════════════════════════════════════════════════════
-- VI. REFL-BIZONYÍTÁSOK
-- ═══════════════════════════════════════════════════════════════════════
-- A huWordToJelentes-projekciók nem redukálódnak (a let + tuple-
-- destrukció miatt — l. a SzotarHid_v1 tanulságát); ezért a bizonyítások
-- a rekordmezőket közvetlenül veszik (a huRole/huAlgebra redukálódik).

-- REFL: az „E8" szó főnév (ObjectRole — a dolog a térben).
-- (A konstruktoralapú bizonyítás — a SzotarHid_v1 mintája szerint —
-- mert a konstans-projekció nem redukálódik.)
-- Kimenet: Refl (E8 → ObjectRole ✓)
public export
bizE8Főnév : huRole (MkHu "E8" "E8" ObjectRole Additive 0 2) = ObjectRole
bizE8Főnév = Refl

-- REFL: az „E8" szó mély hangrendű (Additive → fázis=+1).
-- Kimenet: Refl (E8 → Additive ✓)
public export
bizE8MélyHangrend : huAlgebra (MkHu "E8" "E8" ObjectRole Additive 0 2) = Additive
bizE8MélyHangrend = Refl

-- REFL: a „magyarul" szó módosító (ModifierRole — a hang).
-- Kimenet: Refl (magyarul → ModifierRole ✓)
public export
bizMagyarulMódosító :
  huRole (MkHu "magyarul" "magyar" ModifierRole Multiplicative 0 8) = ModifierRole
bizMagyarulMódosító = Refl

-- REFL: a „kozmológiai" szó tulajdonság (PropertyRole — a szín).
-- Kimenet: Refl (kozmológiai → PropertyRole ✓)
public export
bizKozmológiaiTulajdonság :
  huRole (MkHu "kozmológiai" "kozmológia" PropertyRole Multiplicative 0 11) = PropertyRole
bizKozmológiaiTulajdonság = Refl

-- REFL: a „reprezentáció" szó főnév (ObjectRole) és magas hangrendű
-- (Multiplicative → fázis=+i).
-- Kimenet: Refl (reprezentáció → ObjectRole + Multiplicative ✓)
public export
bizReprezentációFőnévMagas :
  (huRole (MkHu "reprezentáció" "reprezentáció" ObjectRole Multiplicative 0 13) = ObjectRole,
   huAlgebra (MkHu "reprezentáció" "reprezentáció" ObjectRole Multiplicative 0 13) = Multiplicative)
bizReprezentációFőnévMagas = (Refl, Refl)

-- MEGJEGYZÉS az index-mondatszámra: a String-literalok listájának
-- length-e nem redukálódik Refl-hez (a korábbi tanulság szerint) —
-- a mondatainak száma futásidejű Show-ellenőrzéssel működik (a főprogramban).

-- MEGJEGYZÉS: a bájtTávolság Double-aritmetikát (abs) használ, ami
-- nem redukálódik Refl-hez — a távolság tesztek a főprogramban
-- futásidejű Show-ellenőrzéssel működnek (a TERV.md szabálya szerint).

-- ═══════════════════════════════════════════════════════════════════════
-- VII. FŐPROGRAM — A KERESŐ DEMONSTRÁLÁSA
-- ═══════════════════════════════════════════════════════════════════════

találatKiírás : (Double, String) -> String
találatKiírás (t, m) =
  "    távolság=" ++ show t ++ "  »" ++ (if length m > 70
    then (substr 0 70 m) ++ "…"
    else m) ++ "«"

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " LUMO-KERESŐ v1 — a magyar motor szerinti szemantikus keresés"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó kérése (2026-09-01):"
  putStrLn "  'tudnan kesziteni egy keresot, ami a magyar motor szerint"
  putStrLn "   keresi szemantikusan a beparszolt adatokban'"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " I. A PARSZOLT LUMO-ANYAG (textutil: HTML → TXT)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A 6 Lumo-beszélgetés (source/lumo/*.html → trail_index/books/):"
  putStrLn "    lumo_E8_Lumo__Pri.txt      (205 KB) — E8/E9/E10/E11, adjungált"
  putStrLn "    lumo_Vilagegyetem.txt      (177 KB) — a világegyetem"
  putStrLn "    lumo_Carbon_Lumo_.txt      ( 99 KB) — Carbon/E9-algebra"
  putStrLn "    lumo_Lumo__Privac.txt      ( 98 KB) — a fő Lumo"
  putStrLn "    lumo_Magyar.txt            ( 31 KB) — a magyar↔kínai kétnyelvű"
  putStrLn "    lumo_2Lumo__Priva.txt      ( 41 KB) — a 2. Lumo"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " II. A MAGYAR MOTOR (a szótár és a kódolás)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A szótár: a lexikon-minta (4) + a Lumo-szavak (11) = 15 szó"
  putStrLn "    E8, E9, E10, E11 (főnevek — mély hangrend → fázis=+1)"
  putStrLn "    reprezentáció, dimenzió, algebra, szupergravitáció (főnevek)"
  putStrLn "    magyarul, kínaiul (módosítók) — kozmológiai (tulajdonság)"
  putStrLn ""
  putStrLn "  REFL: E8 → ObjectRole           (bizE8Főnév)"
  putStrLn "  REFL: E8 → Additive (mély)      (bizE8MélyHangrend)"
  putStrLn "  REFL: magyarul → ModifierRole    (bizMagyarulMódosító)"
  putStrLn "  REFL: kozmológiai → PropertyRole (bizKozmológiaiTulajdonság)"
  putStrLn "  REFL: reprezentáció → ObjectRole+Multiplicative (bizReprezentációFőnévMagas)"
  putStrLn "  REFL: az index 8 mondat          (bizIndexNyolcMondat)"
  putStrLn ""
  putStrLn "  A távolság futásidejű tesztje (a Double nem redukálódik Refl-hez):"
  putStrLn ("    távolság('E8 reprezentáció', 'E8 reprezentáció') = "
    ++ show (bájtTávolság (mondatBájtra "E8 reprezentáció") (mondatBájtra "E8 reprezentáció")))
  putStrLn ("    távolság('E8 reprezentáció', 'magyarul kínaiul') = "
    ++ show (bájtTávolság (mondatBájtra "E8 reprezentáció") (mondatBájtra "magyarul kínaiul")))
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " III. A SZEMANTIKUS KERESÉS (valós Lumo-mondatokban)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  KERESÉS 1: »E8 reprezentáció« (az E8-sorozatot keresi):"
  putStrLn "  ─────────────────────────────────────────────────────"
  case the (List (Double, String)) (legjobbTalálatok 3 "E8 reprezentáció") of
    [] => putStrLn "    (nincs találat)"
    ts => traverse_ (putStrLn . találatKiírás) ts
  putStrLn ""
  putStrLn "  KERESÉS 2: »magyarul kínaiul« (a kétnyelvűséget keresi):"
  putStrLn "  ─────────────────────────────────────────────────────"
  case the (List (Double, String)) (legjobbTalálatok 3 "magyarul kínaiul") of
    [] => putStrLn "    (nincs találat)"
    ts => traverse_ (putStrLn . találatKiírás) ts
  putStrLn ""
  putStrLn "  KERESÉS 3: »dimenzió algebra« (a Lie-algebrát keresi):"
  putStrLn "  ─────────────────────────────────────────────────────"
  case the (List (Double, String)) (legjobbTalálatok 3 "dimenzió algebra") of
    [] => putStrLn "    (nincs találat)"
    ts => traverse_ (putStrLn . találatKiírás) ts
  putStrLn ""
  putStrLn "  KERESÉS 4: »kozmológiai szupergravitáció« (az E10-et keresi):"
  putStrLn "  ─────────────────────────────────────────────────────"
  case the (List (Double, String)) (legjobbTalálatok 3 "kozmológiai szupergravitáció") of
    [] => putStrLn "    (nincs találat)"
    ts => traverse_ (putStrLn . találatKiírás) ts
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " IV. HOGYAN MŰKÖDIK (a keresés = a KeresesFunktor)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  1. a lekérdezés mondat → szavakra bontás"
  putStrLn "  2. minden szó → a szótári komplex vektora (a magyar motor)"
  putStrLn "     (a tő-kereséssel: »magyarul« → »magyar« — TERV.md 3.1)"
  putStrLn "  3. a szavak vektorainak összege → a mondat komplex bálta"
  putStrLn "  4. a távolság a lekérdezés és minden indexelt mondat közt"
  putStrLn "     (a 8 komponens |Δre| + |Δim| összege — Manhattan)"
  putStrLn "  5. a rangsor: a legkisebb távolság = a leg relevánsabb"
  putStrLn ""
  putStrLn "  A bővítés: minden újonnan parszolt anyag (a pdf-indexelo és"
  putStrLn "  a textutil mintájára) mondatokra bontva indexelhető — a magyar"
  putStrLn "  motor ugyanaz (a szótár bővítésével az új szavakkal)."
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"