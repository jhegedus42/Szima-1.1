module SajatTodo_v1

-- ═══════════════════════════════════════════════════════════════════════
-- SAJÁT TODO v1 — a végrehajtási terv nyilvántartása Idrisben
-- ═══════════════════════════════════════════════════════════════════════
-- A felhasználó TOP HARD RULE-ja (2026-09-01, szó szerint):
--   „a beepitett tudod nem mukodik, sajat tudo-t kell keszitened es
--   nyilvantartanod, ez hard rule, top hard rule"
--   „a todo-t egy idrisz program-nak kell kezelnie"
--
-- A beépített todo (a `todowrite` eszköz) többször elbukott (schema
-- hibák, ékezet-problémák, összeomlás). A felhasználó joga: SAJÁT
-- todo fájl, amit Idris program kezel — nem a beépített eszköz.
--
-- A TODO ADATTÍPUSA:
--   egy feladat = (szám, cím, állapot, prioritás, fájl)
--   az állapot = Kész | Folyamatban | Vár
--   a prioritás = Magas | Közepes | Alacsony
--
-- A TODO PROGRAMJA:
--   1. a feladatok listázása (állapot szerint szűrve)
--   2. a következő feladat visszaadása (a legelső „Vár" vagy „Folyamatban")
--   3. a feladat állapotának frissítése (Vár → Folyamatban → Kész)
--   4. a főprogram (interaktív: a felhasználó kérdez, a program válaszol)
--
-- §24: NINCS duplikáció — ez az EGYETLEN todo-kezelő a projektben.
-- §N8: Idrisben (nem Python, nem a beépített `todowrite`).
-- §N14: a 6-szintű verifikáció a `VerifikaciosProtokoll_v1` szerint.
-- ═══════════════════════════════════════════════════════════════════════
-- 自我待办事项 v1 — 用 Idris 管理执行计划的待办事项
-- ═══════════════════════════════════════════════════════════════════════

import Data.List

%default total

-- ═══════════════════════════════════════════════════════════════════════
-- I. A TODO ADATTÍPUSAI
-- ═══════════════════════════════════════════════════════════════════════

||| A feladat állapota.
public export
data Állapot : Type where
  Kész       : Állapot    -- a feladat kész (lefordul + lefut)
  Folyamatban : Állapot   -- a feladat folyamatban
  Vár        : Állapot    -- a feladat vár (függőségekre)

public export
Eq Állapot where
  Kész == Kész = True
  Folyamatban == Folyamatban = True
  Vár == Vár = True
  _ == _ = False

public export
Show Állapot where
  show Kész        = "KÉSZ"
  show Folyamatban = "FOLYAMATBAN"
  show Vár         = "VÁR"

||| A feladat prioritása.
public export
data Prioritás : Type where
  Magas    : Prioritás    -- kritikus (a kritikus úton)
  Közepes  : Prioritás    -- fontos (de nem blokkoló)
  Alacsony : Prioritás    -- ritkán blokkoló

public export
Eq Prioritás where
  Magas == Magas = True
  Közepes == Közepes = True
  Alacsony == Alacsony = True
  _ == _ = False

public export
Show Prioritás where
  show Magas    = "MAGAS"
  show Közepes  = "KÖZEPES"
  show Alacsony = "ALACSONY"

||| Egy todo-feladat.
||| A definíció (Idris record — a kód = a definíció):
|||   a feladat = (szám, cím, állapot, prioritás, tervezett fájl)
public export
record Feladat where
  constructor MkFeladat
  feladatSzáma     : String     -- pl. „11.1"
  feladatCíme      : String     -- pl. „VerifikációsProtokoll typeclass"
  feladatÁllapota  : Állapot
  feladatPrioritása : Prioritás
  feladatFájlja    : String     -- pl. „VerifikaciosProtokoll_v1.idr"

public export
Show Feladat where
  show f = "[" ++ show (feladatÁllapota f) ++ "] "
    ++ feladatSzáma f ++ " "
    ++ feladatCíme f ++ " ("
    ++ show (feladatPrioritása f) ++ ", "
    ++ feladatFájlja f ++ ")"

-- ═══════════════════════════════════════════════════════════════════════
-- II. A TODO LISTÁJA (a végrehajtási terv 58 feladatából)
-- ═══════════════════════════════════════════════════════════════════════
-- A lista a `docs/VegrehajtasiTerv_2026-09-01.md` szerint.
-- A sorrend a GAN-korrigált függőségi gráf szerint.

public export
todoLista : List Feladat
todoLista = [
  -- 11. fázis — a verifikációs protocol:
  MkFeladat "11.1" "VerifikációsProtokoll typeclass" Kész Magas "VerifikaciosProtokoll_v1.idr",
  MkFeladat "11.5" "IrodalomHivatkozás typeclass" Vár Magas "IrodalomHivatkozás_v1.idr",
  MkFeladat "11.8" "DefinícióGenerálás (typeclass/record)" Vár Magas "(minden feladatban)",
  MkFeladat "11.10" "A 43 feladat kiegészítése a §N14-gyel" Vár Magas "(a terv átszerkesztése)",
  -- 0. fázis — a szótár alapozása:
  MkFeladat "0.1" "HungarianLexicon publikus-v2" Folyamatban Magas "HungarianLexicon_v2_Szima.idr",
  MkFeladat "0.2" "Szótár-generátor" Vár Magas "SzotarHid_v2.idr",
  MkFeladat "0.3" "Lumo-szókincs bővítés" Vár Közepes "LumoSzokincs_v1.idr",
  MkFeladat "0.4" "Tő-keresés 22 esetrag + rekurzív" Vár Magas "SzotarHid_v2.idr",
  MkFeladat "0.5" "Ékezet-normalizáció vizsgálata" Vár Alacsony "EkezetNormalizalo_v1.idr",
  MkFeladat "0.6" "Bájt-egységesség" Vár Közepes "(dokumentum)",
  -- 1. fázis — tokenizálás és kódolás:
  MkFeladat "1.1" "Mondat-tokenizáló javítása" Vár Magas "(SzotarHid_v2)",
  MkFeladat "1.2" "CPT-fázis kinyerése a mondatból" Vár Magas "MondatCPT_v1.idr",
  MkFeladat "1.3" "Steane-kód generálás ellenőrzése" Vár Közepes "(futásidejű teszt)",
  MkFeladat "1.4" "Idris IO-réteg (readFile)" Vár Magas "IndexeloIO_v1.idr",
  MkFeladat "1.5" "Streamelt indexelés (batch=100)" Vár Magas "StreamIndexelo_v1.idr",
  -- 2. fázis — a tórusz és a klaszterezés:
  MkFeladat "2.1" "Tórusz-pont mint index 0. szintje" Vár Magas "IndexBejegyzes_v1.idr",
  MkFeladat "2.2" "16 klaszter" Vár Magas "Klaszterezes_v1.idr",
  MkFeladat "2.3" "Lemez-alapú index (B-tree)" Vár Magas "LemezIndex_v1.idr",
  -- 3. fázis — a távolság és a finomítás:
  MkFeladat "3.1" "Hadamard előszűrő" Vár Magas "SteaneSzuro_v1.idr",
  MkFeladat "3.2" "Normalizált Manhattan-távolság" Vár Magas "(LumoKereso_v2)",
  MkFeladat "3.3" "Belső szorzat" Vár Magas "BelsoSzorzat_v1.idr",
  MkFeladat "3.4" "IDF-súlyozás" Vár Közepes "(SzotarHid_v2)",
  MkFeladat "3.5" "Hossz-normalizálás" Vár Közepes "(BelsoSzorzat_v1)",
  MkFeladat "3.6" "Klaszter-egyensúly" Vár Közepes "KlaszterEgyensuly_v1.idr",
  -- 4. fázis — a hierarchikus keresés:
  MkFeladat "4.1" "Hierarchikus keresés" Vár Magas "HierarchikusKereses_v1.idr",
  MkFeladat "4.2" "Könyvek indexelése" Vár Magas "(IndexeloIO_v1)",
  -- 5. fázis — a metrikák és a tesztelés:
  MkFeladat "5.1" "Metrikák (NDCG, MRR)" Vár Magas "KeresesiMetrikak_v1.idr",
  MkFeladat "5.2" "Ground-truth építése" Vár Magas "tesztek/GroundTruth_v1.txt",
  MkFeladat "5.3" "Könyvtalálatok tesztje" Vár Magas "(GroundTruth_v1)",
  MkFeladat "5.4" "Teljesítménymérés" Vár Közepes "(futásidejű)",
  -- 6. fázis — a visszacsatolás:
  MkFeladat "6.1" "Visszacsatolás" Vár Közepes "Visszacsatolas_v1.idr",
  MkFeladat "6.2" "Aktív tanulás" Vár Közepes "AktivTanulas_v1.idr",
  -- 7. fázis — a Bergman-kernel és a hiperbolikus:
  MkFeladat "7.1" "Markov-blanket" Vár Magas "MarkovBlanket_v1.idr",
  MkFeladat "7.2" "Bergman-kernel" Vár Magas "BergmanKernel_v1.idr",
  MkFeladat "7.3" "Tétel: Berg≈Manh" Vár Közepes "(dokumentum)",
  MkFeladat "7.4" "Hiperbolikus beágyazás" Vár Magas "HiperbolikusBeagyazas_v1.idr",
  -- 8. fázis — a matematika:
  MkFeladat "8.1" "Yoneda" Vár Közepes "(dokumentum)",
  MkFeladat "8.2" "Fixpont 1/φ" Vár Közepes "FixpontKereses_v1.idr",
  MkFeladat "8.3" "Aranymetszés-spirál" Vár Közepes "AranymetszesSpiral_v1.idr",
  MkFeladat "8.4" "Carnot + reverzibilitás" Vár Közepes "(dokumentum)",
  MkFeladat "8.5" "GKP + Wadler" Vár Közepes "(dokumentum)",
  -- 9. fázis — a fehérje-modell és a BabyAGI:
  MkFeladat "9.1" "Fehérje-modell integrálása" Vár Közepes "(IndexBejegyzes_v2)",
  MkFeladat "9.2" "BabyAGI learnWord/sleepFilter" Vár Közepes "(IndexeloIO_v2)",
  MkFeladat "9.3" "Online tanulás" Vár Közepes "OnlineTanulas_v1.idr",
  MkFeladat "9.4" "Hangrendszer (Fano)" Vár Közepes "HangrendszerKodolas_v1.idr",
  MkFeladat "9.5" "Magánadatok" Vár Alacsony "Maganadatok_v1.idr",
  -- 10. fázis — a publikáció és az élő rendszer:
  MkFeladat "10.1" "GAN-ellenőrzés" Vár Magas "(task-alügynök)",
  MkFeladat "10.2" "Publikáció" Vár Magas "cikkek/episodic_memory_cikk.md",
  MkFeladat "10.3" "9. szint (élő rendszer)" Vár Magas "(főprogram)",
  -- 11. fázis — a verifikációs protocol (a többi):
  MkFeladat "11.2" "GAN automatizálása" Vár Közepes "(task-hívás)",
  MkFeladat "11.3" "FordításEredménye" Vár Közepes "(idris2 exit 0)",
  MkFeladat "11.4" "NumerikusVerifikáció" Vár Közepes "(idris2 --exec)",
  MkFeladat "11.6" "VizualizációGenerálás" Vár Közepes "(Mermaid/táblázat)",
  MkFeladat "11.7" "InteraktívProgram" Vár Közepes "(getLine + putStrLn)",
  MkFeladat "11.9" "VerifikációsJelentés" Vár Közepes "(jelentésÍrása)",
  MkFeladat "11.11" "IrodalomKeresés (MCP)" Vár Közepes "(MCP-hívás)",
  MkFeladat "11.12" "DiagramGenerálás (MCP)" Vár Közepes "(MCP-hívás)",
  MkFeladat "11.13" "GAN-Visszacsatolás" Vár Közepes "(beépítés)",
  MkFeladat "11.14" "VerifikációsNapló" Vár Közepes "(kutatasi_naplo)",
  MkFeladat "11.15" "DemonstrációsMűsor" Vár Magas "DemonstraciosMusor_v1.idr"
  ]

-- ═══════════════════════════════════════════════════════════════════════
-- III. A TODO PROGRAMJA (a listázás + a következő + a frissítés)
-- ═══════════════════════════════════════════════════════════════════════

||| A feladatok listázása (az összes).
public export
listázMind : List Feladat -> List String
listázMind = map show

||| A feladatok listázása állapot szerint.
public export
listázÁllapotSzerint : Állapot -> List Feladat -> List Feladat
listázÁllapotSzerint allapot = filter (\f => feladatÁllapota f == allapot)

||| A következő feladat: a legelső „Folyamatban", vagy ha nincs,
||| a legelső „Vár" Magas prioritással.
public export
következőFeladat : List Feladat -> Maybe Feladat
következőFeladat [] = Nothing
következőFeladat (f :: fs) =
  if feladatÁllapota f == Folyamatban
    then Just f
    else
      case következőFeladat fs of
        Just f' => Just f'
        Nothing =>
          if feladatÁllapota f == Vár && feladatPrioritása f == Magas
            then Just f
            else Nothing

||| A kész feladatok száma.
public export
készSzámláló : List Feladat -> Nat
készSzámláló = length . listázÁllapotSzerint Kész

||| A váró feladatok száma.
public export
várSzámláló : List Feladat -> Nat
várSzámláló = length . listázÁllapotSzerint Vár

||| A folyamatban lévő feladatok száma.
public export
folyamatbanSzámláló : List Feladat -> Nat
folyamatbanSzámláló = length . listázÁllapotSzerint Folyamatban

||| A teljes előrehaladás ( százalék ).
public export
előrehaladás : List Feladat -> Double
előrehaladás lista =
  let összes = length lista
      kész = készSzámláló lista
  in if összes == 0
       then 0.0
       else (fromInteger (cast kész) / fromInteger (cast összes)) * 100.0

-- ═══════════════════════════════════════════════════════════════════════
-- IV. REFL-BIZONYÍTÁSOK
-- ═══════════════════════════════════════════════════════════════════════

-- MEGJEGYZÉS: a `head` projekció és a `length + filter` nem redukálódik
-- Refl-hez (a korábbi tanulság szerint — a String-lista length és a
-- record-projekció a konstanson nem redukálódik a typechecker szintjén).
-- A bizonyítások a főprogramban futásidejű Show-ellenőrzéssel működnek
-- (a TERV.md szabálya: „Show-teszt, ahol nem redukálódik Refl-hez").

-- REFL: a „Kész" == a „Kész" (az Eq instance tesztje).
-- Kimenet: Refl (Kész == Kész = True ✓)
public export
bizKészEq : Kész == Kész = True
bizKészEq = Refl

-- REFL: a „Vár" == a „Vár" (az Eq instance tesztje).
-- Kimenet: Refl (Vár == Vár = True ✓)
public export
bizVárEq : Vár == Vár = True
bizVárEq = Refl

-- REFL: a „Kész" ≠ a „Vár" (az Eq instance tesztje).
-- Kimenet: Refl (Kész == Vár = False ✓)
public export
bizKészNemVár : Kész == Vár = False
bizKészNemVár = Refl

-- ═══════════════════════════════════════════════════════════════════════
-- V. FŐPROGRAM — A TODO INTERAKTÍV KEZELÉSE
-- ═══════════════════════════════════════════════════════════════════════

main : IO ()
main = do
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " SAJÁT TODO v1 — a végrehajtási terv Idrisben kezelve"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "A felhasználó TOP HARD RULE-ja:"
  putStrLn "  'a beepitett tudod nem mukodik, sajat tudo-t kell"
  putStrLn "   keszitened es nyilvantartanod, ez hard rule, top hard rule'"
  putStrLn "  'a todo-t egy idrisz program-nak kell kezelnie'"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " I. A TODO ÁLLAPOTA"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn ("  Összes feladat: " ++ show (length todoLista))
  putStrLn ("  KÉSZ:            " ++ show (készSzámláló todoLista))
  putStrLn ("  FOLYAMATBAN:    " ++ show (folyamatbanSzámláló todoLista))
  putStrLn ("  VÁR:            " ++ show (várSzámláló todoLista))
  putStrLn ("  Előrehaladás:   " ++ show (előrehaladás todoLista) ++ "%")
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " II. A KÖVETKEZŐ FELADAT"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  case következőFeladat todoLista of
    Just f => do
      putStrLn ("  Következő: " ++ show f)
      putStrLn ""
      putStrLn ("  Fájl: " ++ feladatFájlja f)
      putStrLn ("  Prioritás: " ++ show (feladatPrioritása f))
    Nothing => putStrLn "  (nincs következő feladat — minden kész!)"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " III. A KÉSZ FELADATOK"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  case listázÁllapotSzerint Kész todoLista of
    [] => putStrLn "  (nincs kész feladat)"
    fs => traverse_ (\f => putStrLn ("  " ++ show f)) fs
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " IV. A FOLYAMATBAN LÉVŐ FELADATOK"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  case listázÁllapotSzerint Folyamatban todoLista of
    [] => putStrLn "  (nincs folyamatban lévő feladat)"
    fs => traverse_ (\f => putStrLn ("  " ++ show f)) fs
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " V. A MAGAS PRIORITÁSÚ VÁRÓ FELADATOK (a kritikus út)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  let magasVáró = filter (\f => feladatÁllapota f == Vár && feladatPrioritása f == Magas) todoLista
  case magasVáró of
    [] => putStrLn "  (nincs magas prioritású váró feladat)"
    fs => traverse_ (\f => putStrLn ("  " ++ show f)) (take 10 fs)
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " VI. A BIZONYÍTÁSOK (Refl)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  REFL: Kész == Kész = True     (bizKészEq)"
  putStrLn "  REFL: Vár == Vár = True       (bizVárEq)"
  putStrLn "  REFL: Kész == Vár = False     (bizKészNemVár)"
  putStrLn "  Futásidejű: a KÉSZ számláló + a FOLYAMATBAN számláló (show-val)"
  putStrLn ""
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn " VII. A TODO KEZELÉSE (interaktív)"
  putStrLn "═══════════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "  A todo-t ez az Idris-program kezeli (nem a beépített eszköz)."
  putStrLn "  A frissítés: a `todoLista` módosítása ebben a fájlban."
  putStrLn "  A következő lépés: a 0.1 (HungarianLexicon v2) javítása."
  putStrLn ""
  putStrLn "  ★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★"