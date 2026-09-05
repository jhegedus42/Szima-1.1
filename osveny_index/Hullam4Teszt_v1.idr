module Hullam4Teszt_v1

-- ═══════════════════════════════════════════════════════════════
-- HULLÁM-4 TESZT · 第四波检验 · WAVE-4 TEST · WELL-4-TEST
-- ─────────────────────────────────────────────────────────────
-- A 2026-09-04/05 két napjának NÉGY hulláma ÚJ modulokat hozott;
-- ez a modul a zászlóshajókat EGY HELYEN, gépileg ellenőrzi.
-- 本模块把四波的新旗舰模块放在一处做机器检验。
-- This module machine-checks the wave flagships in one place.
--
-- ─── A TIZENKÉT IMPORTÁLT MODUL ÁLLAPOTA (GAUGE, 2026-09-05) ───
-- Mind a 12 modul `idris2 --check` TISZTA (exit 0 ÉS üres kimenet):
--   osveny_index világ (a saját útvonaláról):
--     TudásGráf_v1 (0,48 s) · Irányító_v1 (0,51 s) ·
--     NégynyelvűEllenőrző_v1 (0,52 s) · KategoriaStruktura/
--     PrimekAnalizis_v2 (0,38 s) · Kategoriak/ZeneKategoria_v2
--     (0,38 s) · Alap/DependensSzamT_v2 (0,39 s) ·
--     DeltaAnalizis_v1 (0,42 s) · Rendszer_v2 (nehéz fa, tiszta)
--   szima_ter/modul világ (saját --check-el mérve, abban a
--     könyvtárban futtatva): HungarianLexiconTanu_v1 ·
--     FazisAlgebra_v3 · EpisodicMemory_v2_Szima · BabyAGI_v2_Szima
--     — mind exit 0, üres kimenet.
--
-- ─── A KÉT VILÁG HÍDA (új felfedezés, ImportProbe_v1.idr) ──────
-- AZ osveny_index világból A szima_ter/modul világ moduljai
-- IMPORTÁLHATÓK — de CSAK az előre lefordított .ttc állományokon
-- át, IDRIS2_PATH környezeti változóval:
--   cd /Users/joco/opencode/osveny_index && \
--   IDRIS2_PATH=/Users/joco/opencode/szima_ter/modul/build/ttc \
--   idris2 --check Hullam4Teszt_v1.idr
-- (és ugyanígy az -o fordítás; a futtatható már önhordó).
-- IDRIS2_PATH NÉLKÜL: «Error: Module HungarianLexiconTanu_v1 not
-- found» — és figyelem: ilyenkor az exit kód 0 volt, de a KIMENET
-- hibát mutatott (a 23. csapda: exit 0 hazudik, a kimenetet OLVASNI
-- kell). Forrás: ImportProbe_v1.idr (megmarad, §20).
-- FUTTATÁSI BIZONYÍTÉK: az ImportProbe_v1 build/exec futtathatója
-- kiírta: «lexikonCenzusHossza = 3460» — a kereszt-világ érték-
-- számítás működik, nem csak a fejléc-beolvasás.
--
-- ─── A TesztEredmeny MINTA — miért helyben definiálva? ────────
-- A feladat szövere engedi: «importálhatod vagy helyben
-- definiálhatod». A helyben-definíció mellett döntöttünk, mert
-- (a) a Teszt.idr 16 nehéz modult húzna be (Steane713, E8E8Algebra,
--     MagyarNyelvtan, LawvereGodel, Szotar, Fonetika, …);
-- (b) a két világ UGYANAZOKON a neveken is tartalmaz modult
--     (Steane713, E8E8Algebra mindkettőben) — a Teszt.idr fájának
--     import-fája a kettős IDRIS2_PATH-világban név-kettősséget
--     kockáztat (a 4/b és 5. csapda).
-- A minta SZÓ SZERINT a Teszt.idr 231–246. sorairól másolt
-- (mezőnevek, Show, teszt függvény — információveszteség nélkül).
-- | 模板逐字取自 Teszt.idr，仅因双世界命名冲突风险而本地定义。
-- | Pattern copied verbatim from Teszt.idr; local only due to
-- | two-world name-clash risk.
-- ═══════════════════════════════════════════════════════════════

import DeltaAnalizis_v1
import KategoriaStruktura.PrimekAnalizis_v2
import Kategoriak.ZeneKategoria_v2
import Rendszer_v2
import Irányító_v1
import TudásGráf_v1
import NégynyelvűEllenőrző_v1
import Alap.DependensSzamT_v2
import HungarianLexiconTanu_v1
import FazisAlgebra_v3
import EpisodicMemory_v2_Szima
import BabyAGI_v2_Szima
import MagyarNyelvtanKcode_v1_Szima  -- a Harmony/Front konstruktorokért
import System.File                   -- a readFile peremhez (Kereso-minta)

-- ─── 0. A TESZT-KERET (a Teszt.idr mintája, l. a fejléc-jegyzetet) ──

public export
record TesztEredmeny where
  constructor TesztEredmenyK
  tesztNev : String
  kapott   : String
  sikeres  : Bool

public export
Show TesztEredmeny where
  show t = (if sikeres t then "✓" else "✗")
        ++ " " ++ tesztNev t
        ++ " → " ++ kapott t

public export
teszt : String -> Bool -> TesztEredmeny
teszt nev siker = TesztEredmenyK nev (if siker then "OK" else "HIBA") siker

-- ─── 1. SAJÁT TANÚK — a konkrét nyilak / értékek hídjai ─────────
-- (§18: mindkét oldal KÜLÖNBÖZŐ konstrukció — a bal COMPUTÁL,
--  a jobb a kiírt alak; a kettő egyezését a kernel kényszeríti.)

-- Kimenet: fordul — a zeneAsszociativ (ZeneTiszta, ZeneTiszta,
-- ZeneTiszta) klauzulája zárja; KONKRÉT nyilakon, KONKRÉT
-- objektum-láncon (KvintO → TercO → OktavO → SzeptimO).
zeneKonkrétHíd :
  zeneKompozicio {a = KvintO} {b = TercO} {c = SzeptimO} ZeneTiszta
    (zeneKompozicio {a = TercO} {b = OktavO} {c = SzeptimO}
       ZeneTiszta ZeneTiszta) =
  zeneKompozicio {a = KvintO} {b = OktavO} {c = SzeptimO}
    (zeneKompozicio {a = KvintO} {b = TercO} {c = OktavO}
       ZeneTiszta ZeneTiszta) ZeneTiszta
zeneKonkrétHíd =
  zeneAsszociativ {a = KvintO} {b = TercO} {c = OktavO} {d = SzeptimO}
    ZeneTiszta ZeneTiszta ZeneTiszta

||| A konkrét zene-asszociativitás futásidejű tanúja.
zeneKonkrétSiker : Bool
zeneKonkrétSiker = case zeneKonkrétHíd of Refl => True

-- Kimenet: fordul — a lépésKép {n = 0} klauzula NullaD-t ÉPÍT
-- (a v1 believe_me HAMIS tanújának valódi válasza, most KÍVÜLRŐL,
-- egy másik modulból újravezetve).
lépésKépPeremTanú : lépésKép {n = 0} UresDimenzio = NullaD
lépésKépPeremTanú = Refl

-- Kimenet: fordul — a lépésKép {n = 1} klauzula: elé-tesz egy
-- NullaD-t az EgyKubit-ra (Kombinalt NullaD (Kombinalt … UresVektor)).
lépésKépEgyKubitTanú :
  lépésKép {n = 1} EgyKubit = Kombinalt NullaD (Kombinalt EgyKubit UresVektor)
lépésKépEgyKubitTanú = Refl

||| A két lépésKép-tanú futásidejű tanúja.
lépésKépSiker : Bool
lépésKépSiker = case (lépésKépPeremTanú, lépésKépEgyKubitTanú) of
  (Refl, Refl) => True

||| A FazisAlgebra_v3 tükör-koherencia futásidejű tanúja.
fazisTükörSiker : Bool
fazisTükörSiker = case bizKoherenciaTükör of Refl => True

||| A FazisAlgebra_v3 teljes fázis-faktoriális futásidejű tanúja.
fazisFaktoriálisSiker : Bool
fazisFaktoriálisSiker = case bizFázisFaktoriálisTeljes of Refl => True

-- ─── 2. A STATIKUS TESZT-LISTA — a tizenkét zászlóshajó ──────────

public export
hullámNégyTesztek : List TesztEredmeny
hullámNégyTesztek =
  [ -- ── DeltaAnalizis_v1: a ϱ két-út-híd (Double → NEM Refl-zárható,
    --   §18 őszinteség: futásidejű küszöb-tanú + a main kiírja a
    --   pontos értéket) ──
    teszt "DeltaAnalizis_v1: ϱ két-út-híd |Newton-ϱ − rögzített-ϱ| < 10⁻⁹"
      (roEgyezésTanú < 0.000000001)
  , teszt "DeltaAnalizis_v1: exp(ϱ) = ϱ maradék < 10⁻⁹"
      (roMaradék < 0.000000001)
  , teszt "DeltaAnalizis_v1: δ-hézag a (0,0005 · 0,0006) sávban"
      (0.0005 < hézag && hézag < 0.0006)
    -- ── HungarianLexiconTanu_v1: a tanú KÜLSŐ modulból elérhető ──
  , teszt "HungarianLexiconTanu_v1: LexikonSzóCenzus hossza = 3460"
      (length LexikonSzóCenzus == 3460)
    -- ── PrimekAnalizis_v2: a 47 prím-tanú futásidejű megismétlése ──
  , teszt "PrimekAnalizis_v2: egyetlenOsztóSem 47 46 = True"
      (egyetlenOsztóSem 47 46 == True)
    -- ── ZeneKategoria_v2: asszociativitás KONKRÉT nyilakra ──
  , teszt "ZeneKategoria_v2: zeneAsszociativ konkrét nyilakon (Kvint→Terc→Oktav→Szeptim)"
      (zeneKonkrétSiker == True)
    -- ── Rendszer_v2: az Euler nulla-szög egyenlet ──
  , teszt "Rendszer_v2: eulerValosResz 0.0 = 2.0"
      (eulerValosResz 0.0 == 2.0)
    -- ── Irányító_v1: a kezdeti BFS-sor hat lépése ──
  , teszt "Irányító_v1: kezdetiSor hossza = 6"
      (length kezdetiSor == 6)
    -- ── TudásGráf_v1: a gráf 0. rétege = gyökér + 8 család + 8 hely ──
  , teszt "TudásGráf_v1: gráfRétegNulla hossza = 17"
      (length gráfRétegNulla == 17)
    -- ── DependensSzamT_v2: a lépésKép KONKRÉT értékei ──
  , teszt "DependensSzamT_v2: lépésKép peremről (n=0) és 1 kubitról (n=1)"
      (lépésKépSiker == True)
    -- ── FazisAlgebra_v3: a tükör-koherencia + fázis-faktoriális ──
  , teszt "FazisAlgebra_v3: bizKoherenciaTükör (Tükör,Tükör,Tükör)"
      (fazisTükörSiker == True)
  , teszt "FazisAlgebra_v3: fazisFaktorialis (Tükör,Tükör,Tükör) = 1.0"
      (fazisFaktoriálisSiker == True
       && fazisFaktorialis (ToltesParitasIdoKonstruktor Tükör Tükör Tükör) == 1.0)
    -- ── EpisodicMemory_v2_Szima: aminosav-kódok (IUPAC standard) ──
  , teszt "EpisodicMemory_v2_Szima: aminosavKód Triptofán = \"Trp\""
      (aminosavKód Triptofán == "Trp")
  , teszt "EpisodicMemory_v2_Szima: aminosavGenerátorBit Triptofán = 49 (G1+G5+G6)"
      (aminosavGenerátorBit Triptofán == 49)
    -- ── BabyAGI_v2_Szima: a jellemző→aminosav funktor ──
  , teszt "BabyAGI_v2_Szima: jellemzőbőlAminosav 33 = Metionin (G1+G6)"
      (jellemzőbőlAminosav 33 == Metionin)
  , teszt "BabyAGI_v2_Szima: hangrendbőlAminosav Front = Leucin"
      (hangrendbőlAminosav Front == Leucin)
  ]

-- ─── 3. A NÉGYNYELVŰ-ELLENŐRZŐ FÁJL-TESZTJE (IO-perem) ───────────
-- A hibátlan próba-fájl (4 mondat: magyar. 中文. EN. DE.) — a
-- NégynyelvűEllenőrző_v1 hibátlanPróbaÚt KONSTANSA PRIVATE (a
-- §13 örökölt-kód-tilalom miatt NEM nyúlunk hozzá, hogy publikussá
-- tegyük), ezért az útvonal-literál itt, DOKUMENTÁLTAN megismételve;
-- maga a hibákSzáma-függvény public export, azt importáljuk.
-- | 原模块路径常量为私有——按 §13 不改原码，路径字面量在此记录。
covering
negyednyelvűFájlTeszt : IO TesztEredmeny
negyednyelvűFájlTeszt = do
  tartalom <- readFile
    "/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode/negynyelvű_próba_hibátlan.txt"
  case tartalom of
    Right szöveg =>
      pure (teszt "NégynyelvűEllenőrző_v1: hibákSzáma a hibátlan próbaszövegre = 0"
              (hibákSzáma szöveg == 0))
    Left hiba =>
      pure (teszt ("NégynyelvűEllenőrző_v1: OLVASÁSI HIBA: " ++ show hiba) False)

-- ─── 4. A FŐPROGRAM — minden tanú kíírása + összesítés ───────────

covering
main : IO ()
main = do
  putStrLn "═══ HULLÁM-4 TESZT · 第四波检验 · a négy hullám zászlóshajói egy helyen ═══"
  putStrLn "-- DeltaAnalizis_v1 pontos értékek (a küszöb-tanúk mellé):"
  putStrLn ("   ϱ két-út-híd  |roSzámított − roFixpont| = " ++ show roEgyezésTanú)
  putStrLn ("   exp(ϱ) − ϱ maradék                     = " ++ show roMaradék)
  putStrLn ("   δ-hézag  (1 − Re(ϱ)·π)                 = " ++ show hézag)
  putStrLn "-- A tizenhat statikus teszt:"
  traverse_ (putStrLn . show) hullámNégyTesztek
  putStrLn "-- A negynyelvű fájl-teszt (readFile-perem):"
  fájlTeszt <- negyednyelvűFájlTeszt
  putStrLn (show fájlTeszt)
  let minden = hullámNégyTesztek ++ [fájlTeszt]
  putStrLn ("ÖSSZESÍTÉS / 总结: "
    ++ show (length (filter sikeres minden)) ++ " / " ++ show (length minden)
    ++ " teszt OK")
