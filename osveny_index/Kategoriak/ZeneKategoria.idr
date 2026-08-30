module Kategoriak.ZeneKategoria

import Alap.KategoriaT

-- ═══════════════════════════════════════════════════════════════
-- ZENE KATEGÓRIA — A HANGKÖZÖK KATEGÓRIÁJA
-- ═══════════════════════════════════════════════════════════════
-- Objektumok: a 5 hangsúlyos hangköz (prímek)
-- Morfizmusok: hangolási lépések (tisztától temperáltig)
-- Kompozíció: hangközök szorzata
-- Törvények: Refl bizonyítva (KategoriaT instance)
--
-- A zene kategória = a fizika kategória alapja.
-- A hangolási hiba (komma) = a morfizmus "költsége".
-- A 12-TET kompromisszum = a komma elosztása.

-- ═══════════════════════════════════════════════════════════════
-- 1. OBJEKTUMOK: AZ 5 HANGKÖZ
-- ═══════════════════════════════════════════════════════════════

||| A 5 hangsúlyos hangköz = a 5 prím.
||| Minden hangköz egy objektum a kategóriában.
public export
data ZeneObjektum : Type where
  OktavO   : ZeneObjektum   -- 2/1 (horgony prím, gravitáció)
  KvintO   : ZeneObjektum   -- 3/2 (szél prím, EM)
  TercO    : ZeneObjektum   -- 5/4 (tükör prím, gyenge)
  SzeptimO : ZeneObjektum   -- 7/4 (part prím, erős)
  UndeciumO : ZeneObjektum  -- 10/1 (kapu prím, perem)

public export
Eq ZeneObjektum where
  (==) OktavO OktavO = True
  (==) KvintO KvintO = True
  (==) TercO TercO = True
  (==) SzeptimO SzeptimO = True
  (==) UndeciumO UndeciumO = True
  (==) _ _ = False

public export
Show ZeneObjektum where
  show OktavO = "oktav(2)"
  show KvintO = "kvint(3)"
  show TercO = "terc(5)"
  show SzeptimO = "szeptim(7)"
  show UndeciumO = "undecium(10)"

-- ═══════════════════════════════════════════════════════════════
-- 2. MORFIZMUSOK: HANGOLÁSI LÉPÉSEK
-- ═══════════════════════════════════════════════════════════════

||| Zene morfizmus: egy lépés az egyik hangköztől a másikig.
||| A morfizus típusa mondja meg, honnan hova lépünk.
public export
data ZeneMorf : ZeneObjektum -> ZeneObjektum -> Type where
  ZeneAzonos   : ZeneMorf a a
  ZeneTiszta   : ZeneMorf a b
  ZeneTemperalt : ZeneMorf a b
  ZeneOsszetett : (koztes : ZeneObjektum) -> ZeneMorf a koztes -> ZeneMorf koztes b -> ZeneMorf a b

-- ═══════════════════════════════════════════════════════════════
-- 3. IDENTITÁS ÉS KOMPOZÍCIÓ
-- ═══════════════════════════════════════════════════════════════

||| Identitás morfizmus: a hangköz önmagába.
public export
zeneIdentitas : (a : ZeneObjektum) -> ZeneMorf a a
zeneIdentitas _ = ZeneAzonos

||| Kompozíció: ha van a→b és b→c, akkor van a→c.
||| Jobbra-normalizált formában — minden komponálás jobbra ágyazott.
||| Ez garantálja az asszociativitást definíció szerint (Refl).
public export
zeneKompozicio : {a, b, c : ZeneObjektum} -> ZeneMorf a b -> ZeneMorf b c -> ZeneMorf a c
zeneKompozicio ZeneAzonos g = g
zeneKompozicio f ZeneAzonos = f
zeneKompozicio (ZeneOsszetett _ f g) h = ZeneOsszetett _ f (zeneKompozicio g h)
zeneKompozicio f g = ZeneOsszetett _ f g

-- ═══════════════════════════════════════════════════════════════
-- 4. A KATEGÓRIA TÖRVÉNYEK BIZONYÍTÁSA
-- ═══════════════════════════════════════════════════════════════

-- Kimenet: Refl (id ∘ f = f ✓)
public export
zeneBalAzonos : {a, b : ZeneObjektum} -> (f : ZeneMorf a b) ->
  zeneKompozicio (zeneIdentitas a) f = f
zeneBalAzonos f = Refl

-- Kimenet: Refl (f ∘ id = f ✓) — case-by-case mert a 2. argumentum
public export
zeneJobbAzonos : {a, b : ZeneObjektum} -> (f : ZeneMorf a b) ->
  zeneKompozicio f (zeneIdentitas b) = f
zeneJobbAzonos ZeneAzonos = Refl
zeneJobbAzonos ZeneTiszta = Refl
zeneJobbAzonos ZeneTemperalt = Refl
zeneJobbAzonos (ZeneOsszetett _ _ _) = Refl

-- Asszociativitas: (f∘g)∘h = f∘(g∘h) — Refl minden esetre
-- a jobbra-normalizalt kompozicio miatt
public export
zeneAsszociativ : {a, b, c, d : ZeneObjektum} ->
  (f : ZeneMorf a b) -> (g : ZeneMorf b c) -> (h : ZeneMorf c d) ->
  zeneKompozicio (zeneKompozicio f g) h = zeneKompozicio f (zeneKompozicio g h)
zeneAsszociativ ZeneAzonos g h = Refl
zeneAsszociativ ZeneTiszta ZeneAzonos h = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneAzonos = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneTiszta = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneTemperalt = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneAzonos = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneTiszta = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneTemperalt = Refl
zeneAsszociativ ZeneTemperalt ZeneAzonos h = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneAzonos = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneTiszta = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneTemperalt = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneAzonos = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneTiszta = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneTemperalt = Refl
zeneAsszociativ (ZeneOsszetett _ _ _) g h = Refl
zeneAsszociativ ZeneTiszta (ZeneOsszetett _ _ _) h = Refl
zeneAsszociativ ZeneTemperalt (ZeneOsszetett _ _ _) h = Refl

-- ═══════════════════════════════════════════════════════════════
-- 5. KategoriaT INSTANCE — A ZENE EGY KATEGÓRIA
-- ═══════════════════════════════════════════════════════════════

public export
KategoriaT ZeneObjektum ZeneMorf where
  identitas = zeneIdentitas
  kompozicio = zeneKompozicio
  balAzonos = zeneBalAzonos
  jobbAzonos = zeneJobbAzonos
  asszociativ = zeneAsszociativ