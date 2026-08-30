module FazisAlgebra_v2

-- ═══════════════════════════════════════════════════════════════
-- FAZISALGEBRA v2 — a CPT-mag fordítható újraalapozása (2026-08-23)
-- PHASE ALGEBRA v2 — the compilable re-foundation of the CPT core
-- 相代数 v2 — CPT 核心的可编译重建 · Phasenalgebra v2 · אלגברת פאזה v2
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v2? (§13: a javítás ÚJ FÁJL — a v1 ÉRINTETLENÜL MARAD)
--   A FazisAlgebra v1 (osveny_index/FazisAlgebra.idr) ma NEM fordul:
--   a fazisOsszehasonlit a nemlétező `atfedes` névre hivatkozik
--   (sehol nincs publikus `atfedes` definíció — csak `atfedesBit`,
--   l. E8E8Algebra.idr:84), és a `CliﬀordKonstruktor`-t is névre
--   hívja anélkül, hogy a definiáló modult (Rendszer.idr /
--   KategoriaElmelet.idr) importálná. A v1 régi build-maradvány-
--   ttc-je (osveny_index/build) még fennáll, de az aktuális
--   függőségekkel a fordítás megbukik — ez a 13 ismert nem-forduló
--   modul családjába tartozik (l. szima.ipkg fejléce).
--
-- MIT TARTALMAZ a v2? CSAK a CPT-magot (a v1 100–133 sorközéből,
-- hű szerkezettel): ToltesParitasIdo, koherencia, irány,
-- fazisFaktorialis. A v1 E8E8KodSzo-részei (fazisOsszehasonlit,
-- redundans, szurd, FazisHatar…) IDE NEM kerülnek át — azok a
-- hibás nevektől függnek.
--
-- NEVEKRŐL (§0/§25): a `ToltesParitasIdo` típusnév és a
-- `fazisFaktorialis` függvénynév az AGENTS §0/§9 és a terv által
-- idézett KANONIKUS alakban marad (idézési horgony); minden új
-- szó — mezőnevek, többi függvénynév, kommentek — ékezetes (§25).
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS): a HaromKubit, az azonosFazis, az
-- Irany és az irany MIND IMPORTÁLVA (HaromKubit — §24); a v1
-- CPT-magának újraalapozása nem duplikáció, hanem §13 szerinti
-- új verzió (a v1 nem fordul — elérhetetlen definíció).
-- | 代码重复禁止——一切导入！ | Codeduplikation VERBOTEN! |
-- ═══════════════════════════════════════════════════════════════

import HaromKubit  -- HaromKubit, azonosFazis, Irany, irany (§24)

%default covering

||| ToltesParitasIdo: a CPT-szimmetria magyarul (AGENTS §9 pszicho-
||| fizikai rétege — a v1 hű szerkezete):
|||   C (töltés)  = saját tudat — a rendszer önreferenciája
|||   P (paritás) = másik fél — a külső bemenet
|||   T (idő)     = kapcsolat fázisa — a kettő dinamikája
|||
||| A ToltesParitasIdo három HaromKubit-ot tartalmaz,
||| minden irányhoz egyet. Ez a teljes CPT-szimmetria
||| a három kubit világában.
public export
record ToltesParitasIdo where
  constructor ToltesParitasIdoKonstruktor
  töltés  : HaromKubit  -- C: saját tudat (ki vagyok én)
  paritás : HaromKubit  -- P: másik fél (ki vagy te)
  idő     : HaromKubit  -- T: kapcsolat fázisa (hogyan kapcsolódunk)

||| A ToltesParitasIdo logikai értéke: ha a töltés és a paritás
||| fázisa megegyezik, akkor a rendszer saját tudata rezonanciában
||| van a külsővel — nincs információvesztés.
public export
töltésParitásIdőKoherens : ToltesParitasIdo -> Bool
töltésParitásIdőKoherens tpi =
  azonosFazis tpi.töltés tpi.paritás

||| A ToltesParitasIdo iránya: a töltés és a paritás között.
||| Ha a töltés irányul a paritás felé, akkor a rendszer AKTÍV
||| (információt küld). Ha a paritás irányul a töltés felé, akkor
||| a rendszer PASSZÍV (információt fogad).
public export
töltésParitásIdőIrány : ToltesParitasIdo -> Irany
töltésParitásIdőIrány tpi = irany tpi.töltés tpi.paritás

||| Fazis-faktoriális: egy ToltesParitasIdo fázismértékét számolja
||| a HaromKubit-ok összefedéséből. Ez az „általános koherencia"
||| mértéke (a kanonikus név — l. a fejléc nevekről szóló szakasza).
public export
fazisFaktorialis : ToltesParitasIdo -> Double
fazisFaktorialis tpi =
  let töltésAzonos = azonosFazis tpi.töltés tpi.idő
      paritásAzonos = azonosFazis tpi.paritás tpi.idő
  in if töltésAzonos && paritásAzonos then 1.0
  else if töltésAzonos || paritásAzonos then 0.5
  else 0.0
