module KategoriaStruktura.PrimekAnalizis

import Alap.SzamT

-- ═══════════════════════════════════════════════════════════════
-- A HTML SZÁMAINAK PRÍMFELBONTÁSA
-- ═══════════════════════════════════════════════════════════════
-- A prímfelbontás a számok DNS-e. Minden összetett szám
-- prímek szorzataként írható fel — ez a Számelmélet Alaptétele.
--
-- A projekt 5 prímje (SzamT.idr):
--   2 = horgony (oktáv, tér)
--   3 = szél (kvint, szín)
--   5 = tükör (terc, gyenge)
--   7 = part (szeptim, idő, Steane)
--   10 = kapu (max, perem felett)
--
-- A HTML-ben szereplő számok felbontása ezekre és további
-- prímekre mutatja a struktúra mélyebb összefüggéseit.

-- ═══════════════════════════════════════════════════════════════
-- 1. E8 DIMENZIÓ: 248 = 2³ × 31
-- ═══════════════════════════════════════════════════════════════

||| 248 = 8 × 31. A 8 = 2³ (három horgony/három térdimenzió).
||| A 31 prím — a 31. prímszám a 127 (Mersenne-prím).
||| De 31 önmagában prím: a 11. prímszám.
public export
E8DimenzioPrimek : 248 = 8 * 31
E8DimenzioPrimek = Refl

||| 248 = 2 × 2 × 2 × 31. A három 2 = a három kubit (saját, másik, fázis).
public export
E8DimenzioKettoHatvany : 248 = 2 * 2 * 2 * 31
E8DimenzioKettoHatvany = Refl

-- ═══════════════════════════════════════════════════════════════
-- 2. GYÖKEREK SZÁMA: 240 = 16 × 15 = 2⁴ × 3 × 5
-- ═══════════════════════════════════════════════════════════════

||| 240 = 16 × 15. A 16 = 2⁴ (négy horgony), a 15 = 3 × 5 (szél × tükör).
||| Ez a Clifford algebra Cl(4) dimenziója (16) és a 3×5 kapcsolata.
public export
GyokerekPrimek : 240 = 16 * 15
GyokerekPrimek = Refl

||| 240 = 2⁴ × 3 × 5. Négy horgony, egy szél, egy tükör.
public export
GyokerekReszletes : 240 = 2 * 2 * 2 * 2 * 3 * 5
GyokerekReszletes = Refl

-- ═══════════════════════════════════════════════════════════════
-- 3. E8 CSALÁD DIMENZIÓI
-- ═══════════════════════════════════════════════════════════════

||| G2 = 14 = 2 × 7. Egy horgony × egy part (oktáv × szeptim).
public export
G2Primek : 14 = 2 * 7
G2Primek = Refl

||| F4 = 52 = 4 × 13 = 2² × 13. A 13 prím = az Albert algebra dimenziója
||| (3×3 hermitian mátrixok az oktávok felett = 27, de F4 derivációi = 52).
public export
F4Primek : 52 = 4 * 13
F4Primek = Refl

||| E6 = 78 = 2 × 3 × 13. Horgony × szél × Albert-prím.
public export
E6Primek : 78 = 2 * 3 * 13
E6Primek = Refl

||| E7 = 133 = 7 × 19. Part × 19 (ahol 19 a 8. prímszám).
public export
E7Primek : 133 = 7 * 19
E7Primek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 4. WEYL-CSOPORT RENDJE: 696729600 = 2¹⁴ × 3⁵ × 5² × 7
-- ═══════════════════════════════════════════════════════════════

||| A Weyl-csoport rendje a projekt 5 prímjével felírva:
||| 2¹⁴ (horgony a 14-ediken), 3⁵ (szél az 5-ön), 5² (tükör a 2-ön), 7 (part).
||| Ez a legnagyobb véges Coxeter-csoport.
public export
WeylPrimek : 696729600 = 16384 * 243 * 25 * 7
WeylPrimek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 5. A HTML STRUKTÚRA SZÁMAI
-- ═══════════════════════════════════════════════════════════════

||| 54 node = 2 × 3³. Egy horgony, három szél.
public export
NodeokPrimek : 54 = 2 * 3 * 3 * 3
NodeokPrimek = Refl

||| 47 függőség = 47. PRÍM! A 47. prím önmaga.
||| Ez a 15. prímszám (2,3,5,7,11,13,17,19,23,29,31,37,41,43,47).
public export
FuggesekPrimek : 47 = 47
FuggesekPrimek = Refl

||| 29 E8-kapcsolat = 29. PRÍM! A 10. prímszám.
public export
E8KapcsolatokPrimek : 29 = 29
E8KapcsolatokPrimek = Refl

||| 76 összes él = 47 + 29 = 4 × 19 = 2² × 19.
||| A két prím (47, 29) összege egy újabb felbontást ad.
public export
OsszesElPrimek : 76 = 4 * 19
OsszesElPrimek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 6. STEANE KÓD: 7, 1, 3
-- ═══════════════════════════════════════════════════════════════

||| 7 = PART. A Steane kód fizikai kubitje = a projekt 4. prímje.
public export
SteaneFizikaiPrimek : 7 = 7
SteaneFizikaiPrimek = Refl

||| 3 = SZÉL. A távolság = a projekt 2. prímje.
public export
SteaneTavolsagPrimek : 3 = 3
SteaneTavolsagPrimek = Refl

||| 49 = 7². A struktúrák száma = part × part.
public export
NegvenkilencPrimek : 49 = 7 * 7
NegvenkilencPrimek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 7. E8×E8: 496 = 16 × 31 = 2⁴ × 31
-- ═══════════════════════════════════════════════════════════════

||| 496 = 248 + 248 = 16 × 31. A heterotikus string torzsi dimenziója.
||| 16 = Cl(4) dimenziója, 31 = az E8 dimenzió prímje.
public export
E8EszorE8Primek : 496 = 16 * 31
E8EszorE8Primek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 8. A 10 (KAPU) NEM PRÍM — DE MIÉRT?
-- ═══════════════════════════════════════════════════════════════

||| 10 = 2 × 5. A kapu = horgony × tükör.
||| A projektben a "max" érték = 10, de ez NEM prím.
||| Ez azt jelenti: a "kapu" nem alapelem, hanem szorzat.
||| A valódi prímek: 2, 3, 5, 7. A 10 = ezek kombinációja.
public export
KapuNemPrim : 10 = 2 * 5
KapuNemPrim = Refl

-- ═══════════════════════════════════════════════════════════════
-- 9. A HTML DUPLIKÁLT ID-K ÉS A 2, 3 PRÍMEK
-- ═══════════════════════════════════════════════════════════════

||| 2 duplikált ID. A 2 = horgony prím.
public export
DuplikaltIdPrimek : 2 = 2
DuplikaltIdPrimek = Refl

||| 52 tényleges node = 54 - 2 = 4 × 13 = 2² × 13.
||| A 13 prím újra megjelenik (mint az F4-nél és E6-nál).
public export
TenylegesNodeokPrimek : 52 = 4 * 13
TenylegesNodeokPrimek = Refl

-- ═══════════════════════════════════════════════════════════════
-- 10. ÖSSZEFOGLALÓ TÁBLÁZAT (KOMMENTBEN)
-- ═══════════════════════════════════════════════════════════════
--
-- Szám         | Prímfelbontás        | Jelentés
-- -------------|----------------------|------------------------
-- 248          | 2³ × 31              | E8 dimenzió
-- 240          | 2⁴ × 3 × 5           | Gyökerek száma
-- 133          | 7 × 19               | E7 dimenzió
-- 78           | 2 × 3 × 13           | E6 dimenzió
-- 52           | 2² × 13              | F4 dimenzió
-- 14           | 2 × 7                | G2 dimenzió
-- 696729600    | 2¹⁴ × 3⁵ × 5² × 7    | W(E8) rendje
-- 54           | 2 × 3³               | Node-ok száma
-- 47           | 47 (prím)            | Függőségek
-- 29           | 29 (prím)            | E8-kapcsolatok
-- 76           | 2² × 19              | Összes él
-- 49           | 7²                   | Struktúrák (7×7)
-- 496          | 2⁴ × 31              | E8×E8 dimenzió
-- 7            | 7 (prím)             | Steane fizikai kubit
-- 3            | 3 (prím)             | Steane távolság
--
-- KULCSFELISMERÉS:
--   A 47 és 29 prímek — ezek a HTML "szerkesztőjének" tudatos
--   vagy tudattalan választásai. A prím = oszthatatlan, építőelem.
--   A 47 függőség és 29 E8-kapcsolat NEM bontható tovább —
--   ezek az alapvető építőkövek a struktúra gráfjában.
--
--   A projekt 5 prímje (2,3,5,7,10-ként definiálva SzamT.idr-ben)
--   mindegyike megjelenik a felbontásokban:
--     2 = horgony (tér, oktáv)
--     3 = szél (kvint, szín)
--     5 = tükör (terc, gyenge)
--     7 = part (idő, szeptim, Steane)
--     13 = Albert-prím (F4, E6, node-ok)
--     19 = E7-prím
--     31 = E8-prím (az igazi kulcs: 31 = 2⁵-1, Mersenne-prím!)
--
--   31 = 2⁵ - 1. Ez egy MERSENNE-PRÍM!
--   A Mersenne-prímek = 2^p - 1 alakú prímek.
--   31 = 2⁵ - 1, ahol 5 maga is prím.
--   Ez az E8 dimenziójának prímje — a kvantum és a klasszikus
--   találkozásának matematikai alapja.

||| 31 = 2⁵ - 1. Mersenne-prím. Az E8 dimenziójának prímje.
public export
HarmincEgyMersenne : 31 = 32 - 1
HarmincEgyMersenne = Refl

||| 127 = 2⁷ - 1. A következő Mersenne-prím. A 7 = part prím!
public export
SzazHuszonHetMersenne : 127 = 128 - 1
SzazHuszonHetMersenne = Refl
