module ImportProbe_v1

-- ═══════════════════════════════════════════════════════════════
-- IMPORT-PROBE v1 — hullám 4 (2026-09-05, az Idrisz-Integrátor)
-- ─────────────────────────────────────────────────────────────
-- KÉRDÉS: az osveny_index világából importálhatók-e a szima_ter/modul
-- világának moduljai? (a hullám-4 integrációs feladat elővizsgálata)
-- KÉT PRÓBA: (a) IDRIS2_PATH nélkül, (b) IDRIS2_PATH =
--   /Users/joco/opencode/szima_ter/modul/build/ttc
-- A válasz a futtatás kimenetében; az eredmény a Hullam4Teszt_v1
-- fejléc-kommentjébe kerül. A fájl megmarad (§20: törlés tilos).
-- | 问题：osveny_index 世界能否导入 szima_ter/modul 世界的模块？
-- | Question: can the szima_ter/modul world be imported from osveny_index?
-- ═══════════════════════════════════════════════════════════════

import HungarianLexiconTanu_v1
import FazisAlgebra_v3
import EpisodicMemory_v2_Szima
import BabyAGI_v2_Szima

-- A probe hasznos terhe: a lexikon-cenzus hosszát futásidőben megmutatja
-- (ha az import megvan, ez a main kiírja).
main : IO ()
main = putStrLn ("lexikonCenzusHossza = " ++ show (length LexikonSzóCenzus))
