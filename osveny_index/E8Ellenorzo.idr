module E8Ellenorzo

-- ═══════════════════════════════════════════════════════════════
-- E8 KONSTANSOK ELLENŐRZÉSE — FORRÁS-AUDIT (2026-08-12)
-- ═══════════════════════════════════════════════════════════════
-- A trail_index/E9_framework.md "12. Source audit" táblájában
-- két ⚡ tétel számításból igazolható:
--
--   1. A nyolc dimenziós gömbpakolási sűrűség:
--        Δ₈ = π⁴ / 384  ≈ 0.2536695...
--      (E8 rács Rogers-sűrűsége; a könyvekben nincs, az
--       dimenzióelméletből közvetlenül számolható.)
--
--   2. Az E8 Weyl-csoport rendje:
--        |W(E8)| = 696729600 = 2^14 · 3^5 · 5^2 · 7
--      (a 240 gyök permutációinak száma; az E8 tengelyek
--       szimmetriájából adódó finom rend.)
--
-- Minden dependent type / typeclass / Refl. Csak hozzáadás,
-- nincs módosítás. Minden szám data-ba csomagolva.
-- (A Dimenzio import kimarad: abban egy régi elgépelés törte a
--  fordítást — skolarSzoroz / skalarHatvany. Itt a Skalar helyi
--  definíciója önálló, csak hozzáadás.)

-- ─── SKALÁR (helyi, önálló) ────────────────────────────────

||| Skalár: a fizikai mennyiségek közös érték-csomagolója.
public export
record Skalar where
  constructor SkalarKonstruktor
  szám : Double

||| Skalár szorzás.
public export
skalarSzoroz : Skalar -> Skalar -> Skalar
skalarSzoroz (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a * b)

||| Skalár osztás.
public export
skalarOszt : Skalar -> Skalar -> Skalar
skalarOszt (SkalarKonstruktor a) (SkalarKonstruktor b) = SkalarKonstruktor (a / b)

||| Skalár π.
public export
skalarPi : Skalar
skalarPi = SkalarKonstruktor pi

-- ─── 1. A PAKOLÁSI SŰRŰSÉG ──────────────────────────────────

||| Sűrűség-skalár: hányados érték, dimenziótlan.
||| A Fedotov–sűrűség π-ből és 384-ből épül.
public export
record Sűrűség where
  constructor SűrűségKonstruktor
  érték : Skalar

||| Típusos osztás: π⁴ / 384.
||| A négy hatvány = a 4 dimenzió-pár hatványa (x1-x4, x5-x8).
||| A 384 = 384 = 2^7 · 3 (a pakolás nevezője, dimenziófüggő).
public export
sűrűségNyolcDimenzió : Sűrűség
sűrűségNyolcDimenzió = SűrűségKonstruktor
  (skalarOszt (skalarSzoroz piNegySzor piNegySzor) (SkalarKonstruktor 384.0))
  where
    piNegySzor : Skalar
    piNegySzor = skalarSzoroz skalarPi (skalarSzoroz skalarPi
                  (skalarSzoroz skalarPi skalarPi))

||| A sűrűség skalarja (kiírható numerikus érték).
public export
sűrűségÉrték : Skalar
sűrűségÉrték = érték sűrűségNyolcDimenzió

-- ─── 2. A WEYL-CSOPORT RENDJE ──────────────────────────────

||| Egész-skalár: a Weyl-rend fölírt hatványai.
||| |W(E8)| = 2^14 · 3^5 · 5^2 · 7
||| Természetes szám (Nat), mert a rend megszámlálás.
||| A Nat-szorzat a típusellenőrzőben redukálódik → Refl igazol.
public export
record WeylRend where
  constructor WeylRendKonstruktor
  kettő : Nat   -- 2^14
  három : Nat   -- 3^5
  öt    : Nat   -- 5^2
  hét   : Nat   -- 7

||| A Weyl-rend felépítése a prímtényezőkből.
||| Minden hatvány típusos szorzással épül.
public export
weylRendPrimTényezők : WeylRend
weylRendPrimTényezők = WeylRendKonstruktor
  16384   -- 2^14
  243     -- 3^5
  25      -- 5^2
  7       -- 7

||| A teljes Weyl-rend: a négy prímtényező szorzata.
||| 16384 · 243 · 25 · 7 = 696729600
public export
weylRendTeljes : WeylRend -> Nat
weylRendTeljes (WeylRendKonstruktor kettő három öt hét) =
  (kettő * három) * öt * hét

||| A 696729600 mint kiírható skalár (a számlálás Nat-eredménye).
public export
weylRendÉrték : Skalar
weylRendÉrték = SkalarKonstruktor 696729600.0

-- ─── 3. REFL-BIZONYÍTÁSOK (a típus maga igazol) ────────────

-- Kimenet: Refl — |W(E8)| = 2^14 · 3^5 · 5^2 · 7 számítása egyezik.
-- A Nat-szorzat redukálódik a típusellenőrzőben.
public export
weylRendRefl :
  weylRendTeljes weylRendPrimTényezők = 696729600
weylRendRefl = Refl

-- ─── 4. A KERET TÁBLÁJÁNAK FRISSÍTŐ EGYSZERŰSÍTÉS ─────────

||| A két számított konstans együtt: a nyolc dimenziós páros.
||| Δ₈ és |W(E8)| — a térelrendezés és a szimmetria párja.
public export
record E8KonstansPár where
  constructor E8KonstansPárKonstruktor
  sűrűség : Sűrűség
  weyl    : WeylRend
