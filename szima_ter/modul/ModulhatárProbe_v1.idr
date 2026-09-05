module ModulhatárProbe_v1

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ MODULHATÁR-PROBE · v1 — két modulhatár-jelenség mérése            ║
-- ║ 模块边界探针 · v1 — 测量两类模块边界现象                           ║
-- ║ MODULE-BOUNDARY PROBE · v1 — two boundary phenomena measured      ║
-- ║ MODULGRENZEN-PROBE · v1 — zwei Grenzphänomene gemessen            ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- KÉRDÉS 1 / 问题 1 / QUESTION 1 / FRAGE 1:
--   A HungarianLexicon_v1_Szima 3460 szó-konstansa (n_abakusz, …)
--   NÉLKÜL láthatóság-jelölés él. Ha a default `private`, akkor
--   külső modulból NEM hivatkozhatók → a lexikon-tanú lista nem
--   építhető az EREDETI konstansokból.
--   匈牙利词典的 3460 个词常量若无可见性标记（默认 private），
--   外部模块便无法引用——词典见证列表无法由原始常量构成。
--   The 3460 word constants of the lexicon carry no visibility
--   marker; if the default is `private`, an external module cannot
--   reference them, so the lexicon witness list cannot be built
--   from the ORIGINAL constants.
--   Die 3460 Wortkonstanten tragen keine Sichtbarkeitsmarkierung;
--   ist die Voreinstellung `private`, sind sie außerhalb nicht
--   referenzierbar.
--
-- KÉRDÉS 2 / 问题 2 / QUESTION 2 / FRAGE 2:
--   A PrimeLogic_v1_Szima `natMod`/`isPrimeHelper` privát segédei
--   mögött `isPrime 4` fordítási időben OPAK-e külső modulból?
--   (Futásidőben isPrime 4 = False — ezt a NatModTanu_v1 mutatja.)
--   在 PrimeLogic 中 natMod/isPrimeHelper 为私有——isPrime 4 在
--   编译期跨模块是否不透明？
--   With natMod/isPrimeHelper private inside PrimeLogic, is
--   `isPrime 4` opaque at COMPILE time from an outside module?
--   Sind die privaten Helfer über Modulgrenzen intransparent?
--
-- A probe MINDKÉT hibát ELŐSZÖR ELKÖVETI (a hibaüzenetek a tanulság);
-- a rossz sorokat a mérés után KOMMENTBE zárjuk (semmi törlés, §20).
-- 探针先故意犯两个错误（错误信息即教训），测量后仅注释，不删除。
-- The probe commits BOTH errors first (the messages ARE the lesson);
-- afterwards the failing lines are commented out — nothing deleted.

import HungarianLexicon_v1_Szima
import PrimeLogic_v1_Szima

%default total

-- ─── KÍSÉRLET 1: privát szó-konstans hivatkozása ───
-- MÉRÉS (2026-09-04): a hiba szó szerint —
--   «Error: While processing right hand side of elsőSzó. Name
--    HungarianLexicon_v1_Szima.n_abakusz is private.»
--   «Suggestion: add an explicit export or public export modifier.
--    By default, all names are private in namespace blocks.»
-- TANULSÁG: a 3460 szó-konstans PRIVÁT → külső lexikon-tanú-lista
-- az eredeti konstansokból NEM építhető; a tanú független cenzus
-- lista-literálból él (HungarianLexiconTanu_v1).
-- コメント化：词常量为私有，外部无法引用；见证改用独立普查列表。
-- Commented out: the constants are private; the witness uses an
-- independent census list instead.
-- -- elsőSzó : HuWord
-- -- elsőSzó = n_abakusz

-- ─── KÍSÉRLET 2: friss Refl a privát natMod mögött ───
-- MÉRÉS (2026-09-04): a hiba szó szerint —
--   «Error: While processing right hand side of frissNégyÖsszetett.
--    Can't solve constraint between: False and if natMod 4 2 == 0
--    then False else isPrimeHelper 4 3.»
-- TANULSÁG: az `isPrime`- törzs látszik (public export), DE a privát
-- `natMod`/`isPrimeHelper` nem nyitható fel modulhatáron át → a
-- normálalak OPAK marad → friss Refl külső modulban NEM zár.
-- Gyógyír: (a) a PrimeLogic BELSEJÉBEN elaborált tanúk importálása
-- (fourIsComposite, sixFactors — l. NatModTanu_v1), (b) futásidejű
-- Show-teszt. ÉS: az exit 0 itt is hazudott (GAUGE #23) — a --check
-- hibákkal létezett, exit kódja 0 volt!
-- 注释化：跨模块无法展开私有 natMod，新 Refl 不闭合；用导入的证明
-- 与运行时 Show 测试；且 exit 0 再次说谎（须读输出！）。
-- Commented out: a fresh Refl cannot unfold the private natMod
-- across the module boundary; import the elaborated proofs and run
-- the runtime Show-test. Also: exit 0 lied again (GAUGE #23).
-- -- frissNégyÖsszetett : PrimeLogic_v1_Szima.isPrime 4 = False
-- -- frissNégyÖsszetett = Refl
