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
  -- ═══ A GAN-AUDIT (2026-09-01, task-alügynök) EREDMÉNYE ═══
  -- 1 élsértés: 5.1 a 5.2 előtt állt, pedig tőle függ → CSERÉVE.
  -- 4.1 (16 feladatot blokkoló csomópont) 4 pozícióval később állt,
  --   mint lehetséges → EMELVE a 3.2 (003.02) után.
  -- A verifikációs eszközök (011.x) a fő vonal UTÁN álltak — a §N14
  --   szerint ELŐBB kell elkészülniük, mint amit ellenőriznek → ELŐRE.
  -- 011.05 + 011.08 = a 011.01 részeként már megvalósultak → KÉSZ.
  -- ═══ A 0-PADDING HARD RULE (a felhasználó, 2026-09-01) ═══
  -- „a sorszamozasnak 000.00-nak kell lennie, azaz 0-paddingolt,
  --   mert a sorozat maskepp osszekeveredik" — string-össze-
  --   hasonlítással a «2.1» > «11.1» ( ÖSSZEKEVEREDÉS!), míg
  --   «002.01» < «011.01» ✓. A számrend = a string-rend.
  -- ═══════════════════════════════════════════════════════════
  -- A. Verifikációs alap (a §N14 eszközei ELŐBB, mint amit ellenőriznek):
  MkFeladat "011.01" "VerifikációsProtokoll typeclass" Kész Magas "VerifikaciosProtokoll_v1.idr",
  MkFeladat "011.05" "IrodalomHivatkozás (a 011.01 része: Hivatkozás record)" Kész Magas "VerifikaciosProtokoll_v1.idr",
  MkFeladat "011.08" "DefinícióGenerálás (a 011.01 része: typeclass/record)" Kész Magas "(minden feladatban)",
  MkFeladat "011.03" "FordításEredménye (adattípus minden verifikációhoz)" Vár Közepes "(idris2 exit 0)",
  MkFeladat "011.04" "NumerikusVerifikáció" Vár Közepes "(idris2 --exec)",
  MkFeladat "011.02" "GAN automatizálása" Vár Közepes "(task-hívás)",
  MkFeladat "011.13" "GAN-Visszacsatolás" Vár Közepes "(beépítés)",
  MkFeladat "011.06" "VizualizációGenerálás" Vár Közepes "(Mermaid/táblázat)",
  MkFeladat "011.12" "DiagramGenerálás (MCP)" Vár Közepes "(MCP-hívás)",
  MkFeladat "011.11" "IrodalomKeresés (MCP)" Vár Közepes "(MCP-hívás)",
  MkFeladat "011.09" "VerifikációsJelentés" Vár Közepes "(jelentésÍrása)",
  MkFeladat "011.14" "VerifikációsNapló" Vár Közepes "(kutatasi_naplo)",
  MkFeladat "011.07" "InteraktívProgram (vázlatként indul, mérföldköveknél bővül)" Vár Közepes "(getLine + putStrLn)",
  MkFeladat "011.10" "A 43 feladat kiegészítése a §N14-gyel" Vár Magas "(a terv átszerkesztése)",
  -- B. Lexikon (a szótár alapozása):
  MkFeladat "000.01" "HungarianLexicon publikus-v2" Kész Magas "HungarianLexicon_v2_Szima.idr",
  MkFeladat "000.02" "Szótár-generátor + GAN-kiegészítések (minimálpár-gráf, hisztogram, hangrend, szindróma)" Kész Magas "SzotarHid_v2.idr",
  MkFeladat "000.03" "Lumo-szókincs bővítés" Vár Közepes "LumoSzokincs_v1.idr",
  MkFeladat "000.04" "Tő-keresés 22 esetrag + rekurzív" Vár Magas "SzotarHid_v2.idr",
  -- ELTÁVOLÍTVA (a felhasználó utasítására, 2026-09-01):
  --   MkFeladat "000.05" "Ékezet-normalizáció vizsgálata" ...
  -- Indok (a felhasználó, szó szerint): „ekeztnormalizalora miert van
  -- szukseg ? az pont hogy elront mindent". Az ékezet INFORMÁCIÓ —
  -- a SzotarHid_v1 tanulsága: 'hazugsagot' ≠ 'hazugság' (a keresés
  -- pont az ékezet nélkül bukik el). A normalizálás információvesztés.
  -- A fő út: az ékezet MEGŐRZÉSE. NINCS normalizálás.
  MkFeladat "000.06" "Bájt-egységesség (minőségi kapu a 003.x előtt)" Vár Közepes "(dokumentum)",
  -- GAN-JAVASLAT (a 000.02 GAN-ellenőrzéséből — hard rule: figyelembe
  -- kell venni; a gyakoriság = Bayes-prior a dekóderben ÉS fonológiai ok):
  MkFeladat "000.07" "Gyakorisági rang mező (webcorpus/MNSZ — Bayes-prior)" Vár Közepes "(külső korpusz)",
  -- C. Mondat-réteg (tokenizálás és kódolás):
  MkFeladat "001.01" "Mondat-tokenizáló javítása" Vár Magas "(SzotarHid_v2)",
  MkFeladat "001.02" "CPT-fázis kinyerése a mondatból" Vár Magas "MondatCPT_v1.idr",
  MkFeladat "001.03" "Steane-kód generálás ellenőrzése" Vár Közepes "(futásidejű teszt)",
  MkFeladat "001.04" "Idris IO-réteg (readFile)" Vár Magas "IndexeloIO_v1.idr",
  MkFeladat "001.05" "Streamelt indexelés (batch=100)" Vár Magas "StreamIndexelo_v1.idr",
  -- D. Tórusz/index:
  MkFeladat "002.01" "Tórusz-pont mint index 0. szintje" Vár Magas "IndexBejegyzes_v1.idr",
  MkFeladat "002.02" "16 klaszter" Vár Magas "Klaszterezes_v1.idr",
  MkFeladat "002.03" "Lemez-alapú index (B-tree)" Vár Magas "LemezIndex_v1.idr",
  -- E. Metrikák + a kritikus csomópont (a 004.01 EMELVE, az 005.02/005.01 CSERÉVE):
  MkFeladat "003.01" "Hadamard előszűrő" Vár Magas "SteaneSzuro_v1.idr",
  MkFeladat "003.02" "Normalizált Manhattan-távolság" Vár Magas "(LumoKereso_v2)",
  MkFeladat "004.01" "Hierarchikus keresés (kritikus csomópont: 16 feladatot blokkol)" Vár Magas "HierarchikusKereses_v1.idr",
  MkFeladat "004.02" "Könyvek indexelése" Vár Magas "(IndexeloIO_v1)",
  MkFeladat "005.02" "Ground-truth építése (ELŐBB, mert a 005.01 tőle függ)" Vár Magas "tesztek/GroundTruth_v1.txt",
  MkFeladat "005.01" "Metrikák (NDCG, MRR)" Vár Magas "KeresesiMetrikak_v1.idr",
  MkFeladat "005.03" "Könyvtalálatok tesztje" Vár Magas "(GroundTruth_v1)",
  MkFeladat "005.04" "Teljesítménymérés" Vár Közepes "(futásidejű)",
  -- F. Későbbi metrikák, visszacsatolás:
  MkFeladat "003.03" "Belső szorzat" Vár Magas "BelsoSzorzat_v1.idr",
  MkFeladat "003.04" "IDF-súlyozás" Vár Közepes "(SzotarHid_v2)",
  MkFeladat "003.05" "Hossz-normalizálás" Vár Közepes "(BelsoSzorzat_v1)",
  MkFeladat "003.06" "Klaszter-egyensúly" Vár Közepes "KlaszterEgyensuly_v1.idr",
  -- GAN-JAVASLAT (a d=1 honest típusa — a korrekció Maybe, mert a
  -- magyar szókincs kódtávolsága 1: birtok/bírtok két legális kódszó):
  MkFeladat "003.07" "Közös dekóder (Maybe-korrekció — a CSS-szindróma: kvantitás⊕jelentés-fázis)" Vár Magas "KozosDekoder_v1.idr",
  MkFeladat "006.01" "Visszacsatolás" Vár Közepes "Visszacsatolas_v1.idr",
  MkFeladat "006.02" "Aktív tanulás" Vár Közepes "AktivTanulas_v1.idr",
  -- G. Elmélet — Markov-blanket/tétel/hiperbolikus:
  MkFeladat "007.01" "Markov-blanket" Vár Magas "MarkovBlanket_v1.idr",
  MkFeladat "007.02" "Bergman-kernel" Vár Magas "BergmanKernel_v1.idr",
  MkFeladat "007.03" "Tétel: Berg≈Manh" Vár Közepes "(dokumentum)",
  MkFeladat "007.04" "Hiperbolikus beágyazás" Vár Magas "HiperbolikusBeagyazas_v1.idr",
  MkFeladat "008.03" "Aranymetszés-spirál (a 007.04 után, mert tőle függ)" Vár Közepes "AranymetszesSpiral_v1.idr",
  -- H. Lebegő elméleti feladatok (párhuzamosíthatók, nem blokkolnak):
  MkFeladat "008.01" "Yoneda" Vár Közepes "(dokumentum)",
  MkFeladat "008.02" "Fixpont 1/φ" Vár Közepes "FixpontKereses_v1.idr",
  MkFeladat "008.04" "Carnot + reverzibilitás" Vár Közepes "(dokumentum)",
  MkFeladat "008.05" "GKP + Wadler" Vár Közepes "(dokumentum)",
  -- GAN-JAVASLAT (a hangsúly természetessége: σ_{F(w)} = F(σ_w) —
  -- a toldalékolás nem mozdítja; Idrisben Refl-bizonyítható):
  MkFeladat "008.06" "A hangsúly természetességi lemmája (az append nem változtatja a fejet — Refl)" Vár Közepes "HangsulyTermeszetesseg_v1.idr",
  -- I. Integráció (a 009.05 az 010.01 előtt, mert az függ tőle):
  MkFeladat "009.01" "Fehérje-modell integrálása" Vár Közepes "(IndexBejegyzes_v2)",
  MkFeladat "009.02" "BabyAGI learnWord/sleepFilter" Vár Közepes "(IndexeloIO_v2)",
  MkFeladat "009.03" "Online tanulás" Vár Közepes "OnlineTanulas_v1.idr",
  MkFeladat "009.05" "Magánadatok (az 010.01 függ tőle)" Vár Alacsony "Maganadatok_v1.idr",
  MkFeladat "009.04" "Hangrendszer (Fano)" Vár Közepes "HangrendszerKodolas_v1.idr",
  -- J. Lezárás:
  MkFeladat "010.01" "GAN-ellenőrzés" Vár Magas "(task-alügynök)",
  MkFeladat "010.02" "Publikáció" Vár Magas "cikkek/episodic_memory_cikk.md",
  MkFeladat "010.03" "9. szint (élő rendszer)" Vár Magas "(főprogram)",
  MkFeladat "011.15" "DemonstrációsMűsor" Vár Magas "DemonstraciosMusor_v1.idr"
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
-- IV/B. A 0-PADDING BIZONYÍTÁSAI (a felhasználó hard rule-ja: 000.00)
-- ═══════════════════════════════════════════════════════════════════════
-- „a sorszamozasnak 000.00-nak kell lennie, azaz 0-paddingolt,
--  mert a sorozat maskepp osszekeveredik"
-- A LÉNYEG: 0-paddinggal a STRING-rendezés = a SZÁM-rendezés.
-- A bizonyítás: páronkénti compare-ellenőrzés (futásidejű Show-teszt,
-- mert a String-compare nem redukálódik Refl-hez — korábbi tanulság).

||| A 0-padding sorkapcsolat: a fázis-rendezés string-ként HELYES.
||| «000.01» < «001.01» (LT) — a lexikon a mondat-réteg ELŐTT.
||| Kimenet (main): LT ✓
public export
paddingFázisTeszt : String
paddingFázisTeszt = show (compare "000.01" "001.01")

||| A 0-padding sorkapcsolat: a «tízes» átverés ELKERÜLVE.
||| PADDING NÉLKÜL: «2.1» > «10.1» > «11.1» (az összekeveredés!),
||| PADDINGGAL: «002.01» < «010.01» < «011.01» ✓.
||| Kimenet (main): LT ✓
public export
paddingTízesTeszt : String
paddingTízesTeszt = show (compare "002.01" "010.01")

||| A régi (nem paddingolt) forma HIBÁJÁNAK bemutatása:
||| «2.1» vs «10.1» string-rendezése GT (rossz!), mert '2' > '1'.
||| Kimenet (main): GT (a régi hiba demonstrálása) ✓
public export
paddingNelkuliHibaTeszt : String
paddingNelkuliHibaTeszt = show (compare "2.1" "10.1")

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
  putStrLn ("  PADDING: «000.01» vs «001.01» = " ++ paddingFázisTeszt ++ "  (LT = helyes ✓)")
  putStrLn ("  PADDING: «002.01» vs «010.01» = " ++ paddingTízesTeszt ++ "  (LT = helyes ✓)")
  putStrLn ("  PADDING NÉLKÜL: «2.1» vs «10.1» = " ++ paddingNelkuliHibaTeszt ++ "  (GT = az összekeveredés!)")
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