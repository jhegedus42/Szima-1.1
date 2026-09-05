module Kategoriak.ZeneKategoria_v2

import Alap.KategoriaT

-- ═══════════════════════════════════════════════════════════════
-- ZENE KATEGÓRIA _v2 — A HANGKÖZÖK KATEGÓRIÁJA, VALÓDI BIZONYÍTÁSSAL
-- ═══════════════════════════════════════════════════════════════
-- Ez a Kategoriak/ZeneKategoria.idr ÚJ verziója (§13: a régi megmarad,
-- semmit nem írunk felül, semmit nem törölünk — §20).
--
-- MIÉRT SZÜLETETT A _v2? (a §18-2 csapda dokumentálva, információ-
-- veszteség nélkül — §16):
--   Az eredeti fájl 72. sorának kommentje azt állította, hogy a jobbra-
--   normalizált kompozíció «az asszociativitást definíció szerint
--   garantálja (Refl)» — DE a fordító ezt CÁFOLTA (2026-09-04,
--   idris2 0.8.0, szó szerint):
--     Kategoriak.ZeneKategoria:120:45--120:49
--       Error: While processing right hand side of zeneAsszociativ.
--       When unifying: zeneKompozicio (ZeneOsszetett _ _ _)
--                      (zeneKompozicio g h)
--       and: zeneKompozicio (zeneKompozicio (ZeneOsszetett _ _ _) g) h
--       Mismatch between: b and c.
--   Vagyis a `ZeneOsszetett` esetben a Refl NEM zár: a kompozíció
--   eset-fája a `g`-n és `h`-n is bont, amíg a második argumentum
--   ZeneAzonos-ként ismeretlen — definicionális egyenlőség NINCS ott.
--   Továbbá a 134. sor (`asszociativ = zeneAsszociativ`) is elbukott,
--   mert az eredeti `zeneAsszociativ` FORDÍTOTT sorrendű egyenlőséget
--   adott át, mint amilyet a KategoriaT felület kér:
--     Error: ... When unifying: zeneKompozicio (zeneKompozicio f g) h
--            and: zeneKompozicio f (kompozicio g h)
--            Mismatch between: c and b.
--
-- 中文：原文件的注释声称「按定义即得结合律（Refl）」，但编译器否定了它：
-- ZeneOsszetett 情形不是定义等式，需要以第一个参数为递归参数的结构归纳；
-- 且原证明的等式方向与 KategoriaT.asszociativ 相反，实例行也因此失败。
--
-- A MATEMATIKAI DÖNTÉS (math-reasoning `prove`-sablon, indukció):
--   AZ ASSZOCIATIVITÁS IGAZ, de NEM definicionálisan.
--   BIZONYÍTÁSI VÁZLAT HÁROM LÉPÉSBEN:
--   1. ALAPESET: f = ZeneAzonos. A zeneKompozicio 1. klauzulája
--      («ZeneAzonos g = g») NEM bontja g-t és h-t: mindkét oldal
--      `zeneKompozicio g h`-ra redukál → Refl.
--   2. INDUKCIÓS LÉPÉS: f = ZeneOsszetett köztes első második.
--      A `g` és `h` konstruktor-alakúra bontása után a cél:
--      ZeneOsszetett köztes első (zeneKompozicio (zeneKompozicio
--        második g) h)
--        = ZeneOsszetett köztes első (zeneKompozicio második
--            (zeneKompozicio g h)),
--      amit `cong (ZeneOsszetett köztes első) (indukciós hipotézis)`
--      zár. (A `ZeneAzonos` g- és h-ágakban mindkét oldal ugyanarra
--      a beragadt kifejezésre redukál → ott Refl.)
--   3. REKURZIÓS ARGUMENTUM: az ELSŐ argumentum (f) — pontosan úgy,
--      ahogy a `plus` az első argumentumán rekurzál (plusReduces-
--      minta). A rekurzív hívás a `második`-on történik, ami az
--      `ZeneOsszetett köztes első második` szigorúan kisebb
--      részkifejezése → total.
--   ESZKÖZTÁR (idris-nyelv SKILL 10. fejezet: Theorem Proving):
--   Refl CSAK definicionálisra; cong a függvény-emelés; a struktúra
--   a plusReduces-minta («a bizonyítás azon argumentumon rekurzionál,
--   amin a függvény»).
--
-- 中文：结合律为真但非定义等；证明在第一个参数上做结构归纳
-- （如同 plusReduces 模式），归纳步用 cong 加归纳假设闭合。
--
-- Az eredeti tartalom (típusok, műveletek, Show/Eq instance-ok)
-- VÁLTOZATLANUL átkerült; egyedül a `zeneAsszociativ` típusának
-- SORRENDJE vált az interfészével egyezővé (ez nem tartalom-változás,
-- hanem a felület-kötelék teljesítése), és a bizonyítás lett valódi.

-- ═══════════════════════════════════════════════════════════════
-- 1. OBJEKTUMOK: AZ 5 HANGKÖZ (az eredetiből változatlanul)
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
-- 2. MORFIZMUSOK: HANGOLÁSI LÉPÉSEK (az eredetiből változatlanul)
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
-- 3. IDENTITÁS ÉS KOMPOZÍCIÓ (az eredetiből változatlanul)
-- ═══════════════════════════════════════════════════════════════

||| Identitás morfizmus: a hangköz önmagába.
public export
zeneIdentitas : (a : ZeneObjektum) -> ZeneMorf a a
zeneIdentitas _ = ZeneAzonos

||| Kompozíció: ha van a→b és b→c, akkor van a→c.
||| Jobbra-normalizált formában — minden komponálás jobbra ágyazott.
||| FIGYELEM (_v2 jegyzék): az eredeti komment ide azt írta, hogy ez
||| «garantálja az asszociativitást definíció szerint (Refl)» — ez
||| HAMIS volt (§18-2: a komment csak szándék, a típus az igazság).
||| A kompozíció eset-fája:
|||   Azonos f         → g
|||   Tiszta/Temperalt → g-ág: Azonos → f, egyéb → Osszetett b f g
|||   Osszetett k f1 f2 → g-ág: Azonos → f, egyéb →
|||                                        Osszetett k f1 (kompozicio f2 g)
||| Amíg `g` (majd `h`) konstruktor-alakúra nincs bontva, a kifejezés
||| BERAGAD — ezért az asszociativitás NEM definicionális, hanem
||| strukturális indukció tárgya (lent, 4. szakasz).
public export
zeneKompozicio : {a, b, c : ZeneObjektum} -> ZeneMorf a b -> ZeneMorf b c -> ZeneMorf a c
zeneKompozicio ZeneAzonos g = g
zeneKompozicio f ZeneAzonos = f
zeneKompozicio (ZeneOsszetett _ f g) h = ZeneOsszetett _ f (zeneKompozicio g h)
zeneKompozicio f g = ZeneOsszetett _ f g

-- ═══════════════════════════════════════════════════════════════
-- 4. A KATEGÓRIA TÖRVÉNYEK BIZONYÍTÁSA — _v2: VALÓDI BIZONYÍTÁS
-- ═══════════════════════════════════════════════════════════════

-- Kimenet: Refl (zeneIdentitas a redukál ZeneAzonos-ra, a kompozíció
-- 1. klauzulája adja f-et — definicionális ✓)
public export
zeneBalAzonos : {a, b : ZeneObjektum} -> (f : ZeneMorf a b) ->
  zeneKompozicio (zeneIdentitas a) f = f
zeneBalAzonos f = Refl

-- Kimenet: Refl minden konstruktor-ágon (a 2. argumentum ZeneAzonos,
-- a kompozíció 2. klauzulája adja f-et — itt az eset-szétbontás kell,
-- mert a kompozíció eset-fája ELŐSZÖR f-en bont)
public export
zeneJobbAzonos : {a, b : ZeneObjektum} -> (f : ZeneMorf a b) ->
  zeneKompozicio f (zeneIdentitas b) = f
zeneJobbAzonos ZeneAzonos = Refl
zeneJobbAzonos ZeneTiszta = Refl
zeneJobbAzonos ZeneTemperalt = Refl
zeneJobbAzonos (ZeneOsszetett _ _ _) = Refl

-- ─── AZ ASSZOCIATIVITÁS — VALÓDI INDUKCIÓS BIZONYÍTÁS ─────────
--
-- TÍPUSSORREND: az A KategoriaT felület 30-31. sorának irányát
-- követjük (kompozicio f (kompozicio g h) = kompozicio (kompozicio
-- f g) h) — az eredeti _v1 fordítva írta, ezért az instance-sor is
-- elbukott. Az eredeti irány megtartásra kerül lent, tükröképként
-- (zeneAsszociativTukorkep), sym-mal — információveszteség nélkül.
--
-- A BIZONYÍTÁS VÁZLATA (a három lépés, szó szerint):
--   ALAPESET (f = ZeneAzonos): a kompozíció 1. klauzulája mindkét
--     oldalt `zeneKompozicio g h`-ra redukál, g és h bontása
--     NÉLKÜL → Refl.
--   INDUKCIÓS LÉPÉS (f = ZeneOsszetett köztes első második):
--     - g = ZeneAzonos ág: mindkét oldal `zeneKompozicio
--       (ZeneOsszetett köztes első második) h` — azonos beragadás → Refl.
--     - h = ZeneAzonos ág (g nem Azonos): mindkét oldal
--       `ZeneOsszetett köztes első (zeneKompozicio második g)` → Refl.
--     - g és h nem Azonos (mind a 3×3 konstruktor-pár KÜLÖN
--       klauzulában): a cél redukál ZeneOsszetett köztes első (...)
--       alakra mindkét oldalon, és `cong (ZeneOsszetett köztes
--       első) (zeneAsszociativ második g h)` zárja — ez az
--       indukciós hipotézis.
--   REKURZIÓS ARGUMENTUM: az ELSŐ argumentum, f — a plusReduces-
--   minta szerint («a bizonyítás azon argumentumon rekurzionál,
--   amin a függvény»); a `második` szigorúan kisebb részkifejezés,
--   ezért a függvény total.
--   ÖSSZESEN 40 KLAUZULA: 1 alapeset + 13 (f = ZeneTiszta) +
--   13 (f = ZeneTemperalt) + 13 (f = ZeneOsszetett), minden
--   konstruktor-eset külön klauzulában.
--
-- ÚJ CSAPDA (2026-09-04, a fordító tanította): a catch-all (csupasz
-- változó) `g` mintát a típusellenőrző NEM bontja konstruktorokra a
-- jobb oldal ellenőrzésekor — a `zeneKompozicio` eset-fája a változó
-- `g`-n BERAGAD, és a Refl/cong nem zár («Mismatch between: d and
-- b»). Gyógyír: MINDEN eset explicit konstruktor-mintával
-- (ZeneTiszta / ZeneTemperalt / (ZeneOsszetett …)) külön klauzulában.
-- Ellenben: ha az egyik oldal a kompozíció 1. klauzuláján át azonos
-- alakra redukál MINDKÉT oldalt változó-argumentummal is (pl.
-- f = ZeneAzonos, vagy g = ZeneAzonos az f = ZeneOsszetett esetben),
-- ott a változó szabadon maradhat.
--
-- Kimenet: public export total — a fordító ELFOGADJA (2026-09-04,
-- idris2 0.8.0, --check tiszta, exit 0, kimenet olvasva); a `total`
-- kulcsszó miatt a teljesség-ellenőrző maga kényszeríti ki, hogy a
-- rekurzió szigorúan csökkenő legyen; minden Refl-ág definicionális
-- egyenlőség KÜLÖNBÖZŐ redukciós-úton, az egyetlen cong-ág az
-- indukciós hipotézist emeli — tautológia nincs (§18).
public export total
zeneAsszociativ : {a, b, c, d : ZeneObjektum} ->
  (f : ZeneMorf a b) -> (g : ZeneMorf b c) -> (h : ZeneMorf c d) ->
  zeneKompozicio f (zeneKompozicio g h) = zeneKompozicio (zeneKompozicio f g) h

-- ALAPESET: f = ZeneAzonos — a kompozíció 1. klauzulája mindkét
-- oldalt zeneKompozicio g h-ra redukálja g és h bontása NÉLKÜL.
zeneAsszociativ ZeneAzonos g h = Refl

-- ─── f = ZeneTiszta — 13 eset (a kompozíció eset-fája f-en bont,
--     aztán g-n, aztán h-n; MINDEN bontás explicit konstruktor-minta) ──

-- g = Azonos: mindkét oldal zeneKompozicio ZeneTiszta h (azonos
-- beragadt kifejezés, h szabad változó — Refl).
zeneAsszociativ ZeneTiszta ZeneAzonos h = Refl

-- g = Tiszta, h konstruktoronként (a h-bontás KELL: változó h-nál a
-- két oldal KÜLÖNBÖZŐ alakra beragad — ezt a fordító tanította, 2026-09-04).
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneAzonos = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneTiszta = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta ZeneTemperalt = Refl
zeneAsszociativ ZeneTiszta ZeneTiszta (ZeneOsszetett hKöztes hElső hMásodik) = Refl

-- g = Temperalt, h konstruktoronként.
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneAzonos = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneTiszta = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt ZeneTemperalt = Refl
zeneAsszociativ ZeneTiszta ZeneTemperalt (ZeneOsszetett hKöztes hElső hMásodik) = Refl

-- g = Osszetett, h konstruktoronként.
zeneAsszociativ ZeneTiszta (ZeneOsszetett gKöztes gElső gMásodik) ZeneAzonos = Refl
zeneAsszociativ ZeneTiszta (ZeneOsszetett gKöztes gElső gMásodik) ZeneTiszta = Refl
zeneAsszociativ ZeneTiszta (ZeneOsszetett gKöztes gElső gMásodik) ZeneTemperalt = Refl
zeneAsszociativ ZeneTiszta (ZeneOsszetett gKöztes gElső gMásodik) (ZeneOsszetett hKöztes hElső hMásodik) = Refl

-- ─── f = ZeneTemperalt — 13 eset (a Tiszta tükörága) ──────────

zeneAsszociativ ZeneTemperalt ZeneAzonos h = Refl

zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneAzonos = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneTiszta = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta ZeneTemperalt = Refl
zeneAsszociativ ZeneTemperalt ZeneTiszta (ZeneOsszetett hKöztes hElső hMásodik) = Refl

zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneAzonos = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneTiszta = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt ZeneTemperalt = Refl
zeneAsszociativ ZeneTemperalt ZeneTemperalt (ZeneOsszetett hKöztes hElső hMásodik) = Refl

zeneAsszociativ ZeneTemperalt (ZeneOsszetett gKöztes gElső gMásodik) ZeneAzonos = Refl
zeneAsszociativ ZeneTemperalt (ZeneOsszetett gKöztes gElső gMásodik) ZeneTiszta = Refl
zeneAsszociativ ZeneTemperalt (ZeneOsszetett gKöztes gElső gMásodik) ZeneTemperalt = Refl
zeneAsszociativ ZeneTemperalt (ZeneOsszetett gKöztes gElső gMásodik) (ZeneOsszetett hKöztes hElső hMásodik) = Refl

-- ─── INDUKCIÓS LÉPÉS: f = ZeneOsszetett köztes első második ───
-- 13 eset: 4 Refl (a g- és h-Azonos ágak) + 9 cong (az indukciós
-- hipotézis emelése a ZeneOsszetett köztes első fejen át).
-- A rekurzív hívás a `második`-on — f szigorúan kisebb része, ezért
-- a függvény total.

-- g = Azonos: mindkét oldal zeneKompozicio (ZeneOsszetett …) h.
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneAzonos h = Refl

-- g = Tiszta: h = Azonos Refl; a többi 3 ág cong + indukciós hipotézis.
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTiszta ZeneAzonos = Refl
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTiszta ZeneTiszta =
  cong (ZeneOsszetett köztes első) (zeneAsszociativ második ZeneTiszta ZeneTiszta)
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTiszta ZeneTemperalt =
  cong (ZeneOsszetett köztes első) (zeneAsszociativ második ZeneTiszta ZeneTemperalt)
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTiszta (ZeneOsszetett hKöztes hElső hMásodik) =
  cong (ZeneOsszetett köztes első)
       (zeneAsszociativ második ZeneTiszta (ZeneOsszetett hKöztes hElső hMásodik))

-- g = Temperalt: ugyanaz a négy eset.
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTemperalt ZeneAzonos = Refl
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTemperalt ZeneTiszta =
  cong (ZeneOsszetett köztes első) (zeneAsszociativ második ZeneTemperalt ZeneTiszta)
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTemperalt ZeneTemperalt =
  cong (ZeneOsszetett köztes első) (zeneAsszociativ második ZeneTemperalt ZeneTemperalt)
zeneAsszociativ (ZeneOsszetett köztes első második) ZeneTemperalt (ZeneOsszetett hKöztes hElső hMásodik) =
  cong (ZeneOsszetett köztes első)
       (zeneAsszociativ második ZeneTemperalt (ZeneOsszetett hKöztes hElső hMásodik))

-- g = Osszetett: ugyanaz a négy eset.
zeneAsszociativ (ZeneOsszetett köztes első második) (ZeneOsszetett gKöztes gElső gMásodik) ZeneAzonos = Refl
zeneAsszociativ (ZeneOsszetett köztes első második) (ZeneOsszetett gKöztes gElső gMásodik) ZeneTiszta =
  cong (ZeneOsszetett köztes első)
       (zeneAsszociativ második (ZeneOsszetett gKöztes gElső gMásodik) ZeneTiszta)
zeneAsszociativ (ZeneOsszetett köztes első második) (ZeneOsszetett gKöztes gElső gMásodik) ZeneTemperalt =
  cong (ZeneOsszetett köztes első)
       (zeneAsszociativ második (ZeneOsszetett gKöztes gElső gMásodik) ZeneTemperalt)
zeneAsszociativ (ZeneOsszetett köztes első második) (ZeneOsszetett gKöztes gElső gMásodik) (ZeneOsszetett hKöztes hElső hMásodik) =
  cong (ZeneOsszetett köztes első)
       (zeneAsszociativ második (ZeneOsszetett gKöztes gElső gMásodik)
                                (ZeneOsszetett hKöztes hElső hMásodik))

-- ─── AZ EREDETI (_v1) IRÁNYÚ ÁLLÍTÁS — TÜKÖRKÉP ────────────────
-- Az eredeti fájl 102–104. sorában állított irány (kompozicio
-- (kompozicio f g) h = kompozicio f (kompozicio g h)) megtartva:
-- sym-mal következik a fentiből — információveszteség nélkül (§16).
--
-- Kimenet: sym (a fenti indukciós bizonyítás tükrözése ✓)
public export
zeneAsszociativTukorkep : {a, b, c, d : ZeneObjektum} ->
  (f : ZeneMorf a b) -> (g : ZeneMorf b c) -> (h : ZeneMorf c d) ->
  zeneKompozicio (zeneKompozicio f g) h = zeneKompozicio f (zeneKompozicio g h)
zeneAsszociativTukorkep f g h = sym (zeneAsszociativ f g h)

-- ═══════════════════════════════════════════════════════════════
-- 5. KategoriaT INSTANCE — A ZENE EGY KATEGÓRIA (_v2: elfogadva)
-- ═══════════════════════════════════════════════════════════════
-- Kimenet: a fordító elfogadja — az asszociativ mező típusirányát a
-- zeneAsszociativ MOST pontosan követi (KategoriaT, 30–31. sor).

public export
KategoriaT ZeneObjektum ZeneMorf where
  identitas = zeneIdentitas
  kompozicio = zeneKompozicio
  balAzonos = zeneBalAzonos
  jobbAzonos = zeneJobbAzonos
  asszociativ = zeneAsszociativ
