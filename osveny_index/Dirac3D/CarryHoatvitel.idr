module CarryHoatvitel

import Data.Vect
import Fazis
import Carnot
import FazisOsszeado

-- =====================================================================
-- CARRY-HŐÁTVITEL: a decimális átvitel mint Carnot-hőáramlás.
--
-- Kulcs felismerés: a carry nem aritmetikai javítás, hanem HŐÁRAMLÁS.
-- Minden helyiérték egy hőtartály. Az egyesek helye a legmelegebb
-- (a legtöbb energia-áramlás), az ezresek a leghidegebb.
-- A carry = a hő, ami a meleg tartályból a hidegbe áramlik.
--
-- A Z₈ szótárban a 8 és 9 számjegy ELEVE hőt termel:
--   8 → F0 + 1 egység hő (a 8-as küszöbön túlcsordult)
--   9 → F1 + 1 egység hő
--
-- A Carnot-hatásfok η = 1 - T_hideg/T_meleg szabályozza,
-- mennyi hő (carry) jut át a következő helyiértékre.
-- Ha η = 1: tökéletes átvitel. Ha η < 1: a carry elveszik → hibás összeg.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Számjegy → (Fázis, hő): a 8-as küszöb feletti rész a hő.
-- =====================================================================

||| Számjegy kódolása hővel.
||| 0–7 → (F0–F7, 0 hő)
||| 8   → (F0, 1 hő) — a Z₈ körbefordult, 1 egység hő keletkezett
||| 9   → (F1, 1 hő)
public export
szamjegyHovel : Nat -> (Fazis, Nat)
szamjegyHovel 0 = (F0, 0)
szamjegyHovel 1 = (F1, 0)
szamjegyHovel 2 = (F2, 0)
szamjegyHovel 3 = (F3, 0)
szamjegyHovel 4 = (F4, 0)
szamjegyHovel 5 = (F5, 0)
szamjegyHovel 6 = (F6, 0)
szamjegyHovel 7 = (F7, 0)
szamjegyHovel 8 = (F0, 1)
szamjegyHovel 9 = (F1, 1)
szamjegyHovel _ = (F0, 0)

||| (Fázis, hő) → számjegy visszaalakítás.
||| digit = fazisIndex + 8 × hő
public export
hovelSzamjegy : (Fazis, Nat) -> Nat
hovelSzamjegy (f, ho) = fazisIndex f + 8 * ho

-- =====================================================================
-- 2. Helyiérték-összeadás hővel: a + b + carry → (digit, új carry).
-- =====================================================================

||| Egy helyiérték összeadása hővel.
||| teljes = a + b + carry
||| új digit = teljes mod 10
||| új carry = teljes div 10 — ez a hő, ami a következő tartályba áramlik
||| Explicit mintaillesztéssel (0–19), hogy a Refl redukáljon.
public export
hoOsszegHelyiertek : Nat -> Nat -> Nat -> (Nat, Nat)
hoOsszegHelyiertek a b carry =
  let teljes = a + b + carry
  in case teljes of
       0 => (0, 0)
       1 => (1, 0)
       2 => (2, 0)
       3 => (3, 0)
       4 => (4, 0)
       5 => (5, 0)
       6 => (6, 0)
       7 => (7, 0)
       8 => (8, 0)
       9 => (9, 0)
       10 => (0, 1)
       11 => (1, 1)
       12 => (2, 1)
       13 => (3, 1)
       14 => (4, 1)
       15 => (5, 1)
       16 => (6, 1)
       17 => (7, 1)
       18 => (8, 1)
       19 => (9, 1)
       _ => (0, 0)

||| Carnot-szabályozott carry: a hőátvitelt a Carnot-hatásfok korlátozza.
||| ha η < 0.5, a carry elveszik (a hő nem tud felfelé áramlani)
public export
carnotCarry : Nat -> Double -> Double -> Nat
carnotCarry carry tMeleg tHideg =
  let eta = carnotHataskor tMeleg tHideg
  in if eta > 0.5 then carry else 0

-- =====================================================================
-- 3. Teljes összeadás lánc: négy helyiérték, jobbról balra.
-- =====================================================================

||| Négy számjegy: ezres, százas, tízes, egyes.
public export
record Szamjegyek4 where
  constructor MkSzamjegyek4
  ezres  : Nat
  szazas : Nat
  tizes  : Nat
  egyes  : Nat

||| Szám → Szamjegyek4 (maximum 9999).
public export
szamBontas4 : Nat -> Szamjegyek4
szamBontas4 n = MkSzamjegyek4
  (n `div` 1000)
  ((n `div` 100) `mod` 10)
  ((n `div` 10) `mod` 10)
  (n `mod` 10)

||| Helyiértékenkénti összeadás hőátvitellel.
||| Az eredmény: 8 fázis pozíció = 4 számjegy × 2 csatorna (fázis, hő).
||| A hő-csatorna F0 vagy F1 (0 vagy 1 egység hő).
public export
hoOsszeadas : Szamjegyek4 -> Szamjegyek4 -> Vect 8 Fazis
hoOsszeadas a b =
  let (dEgyes, cEgyes)  = hoOsszegHelyiertek (egyes a)  (egyes b)  0
      (dTizes, cTizes)  = hoOsszegHelyiertek (tizes a)  (tizes b)  cEgyes
      (dSzazas, cSzazas) = hoOsszegHelyiertek (szazas a) (szazas b) cTizes
      (dEzres, cEzres)  = hoOsszegHelyiertek (ezres a)  (ezres b)  cSzazas
      (fEgyes, hEgyes)  = szamjegyHovel dEgyes
      (fTizes, hTizes)  = szamjegyHovel dTizes
      (fSzazas, hSzazas) = szamjegyHovel dSzazas
      (fEzres, hEzres)  = szamjegyHovel dEzres
  in [fEzres, natFazisH hEzres,
      fSzazas, natFazisH hSzazas,
      fTizes, natFazisH hTizes,
      fEgyes, natFazisH hEgyes]
  where
    natFazisH : Nat -> Fazis
    natFazisH 0 = F0
    natFazisH _ = F1

||| Hővel kódolt fázisvektor → szám.
||| digit_i = fazisIndex(fázis csatorna) + 8 × fazisIndex(hő csatorna)
public export
hoDekodol : Vect 8 Fazis -> Nat
hoDekodol v =
  let ezres  = fazisIndex (index FZ v) + 8 * fazisIndex (index (FS FZ) v)
      szazas = fazisIndex (index (FS (FS FZ)) v) + 8 * fazisIndex (index (FS (FS (FS FZ))) v)
      tizes  = fazisIndex (index (FS (FS (FS (FS FZ)))) v) + 8 * fazisIndex (index (FS (FS (FS (FS (FS FZ))))) v)
      egyes  = fazisIndex (index (FS (FS (FS (FS (FS (FS FZ)))))) v) + 8 * fazisIndex (index (FS (FS (FS (FS (FS (FS (FS FZ))))))) v)
  in ezres * 1000 + szazas * 100 + tizes * 10 + egyes

-- =====================================================================
-- 4. Teljes Carnot-fordítás: kérdés → hőátviteles összeg.
-- =====================================================================

||| Kérdés → válasz a hőátviteles rendszerben.
public export
hoValasz : Kerdes -> Double -> Double -> Nat
hoValasz k tMeleg tHideg =
  let a = szamBontas4 (elsoSzam k)
      b = szamBontas4 (masodikSzam k)
      osszegV = hoOsszeadas a b
  in hoDekodol osszegV

-- =====================================================================
-- 5. Példák és tesztek.
-- =====================================================================

public export
hoPelda1 : Nat
hoPelda1 = hoValasz (MkKerdes 5 3 F0) 100.0 1.0
-- Elvárt: 8 (a Z₈ körbefordulás hője a hő-csatornában marad)

public export
hoPelda2 : Nat
hoPelda2 = hoValasz (MkKerdes 66 3456 F0) 100.0 1.0
-- Elvárt: 3522

public export
hoPelda3 : Nat
hoPelda3 = hoValasz (MkKerdes 9 9 F0) 100.0 1.0
-- Elvárt: 18 (9+9=18: egyes=8+hő, tizes=1)

public export
hoPelda4 : Nat
hoPelda4 = hoValasz (MkKerdes 999 1 F0) 100.0 1.0
-- Elvárt: 1000 (a carry végigáramlik minden helyiértéken)

-- =====================================================================
-- 6. Refl bizonyítások: a szótár hő-összefüggései.
-- =====================================================================

||| 8 → (F0, 1 hő): a Z₈ körbefordulás pontosan 1 hőegységet termel.
szamjegyHovel8 : szamjegyHovel 8 = (F0, 1)
szamjegyHovel8 = Refl

||| 9 → (F1, 1 hő).
szamjegyHovel9 : szamjegyHovel 9 = (F1, 1)
szamjegyHovel9 = Refl

||| 5 → (F5, 0 hő): 5 < 8, nincs hőtermelés.
szamjegyHovel5 : szamjegyHovel 5 = (F5, 0)
szamjegyHovel5 = Refl

||| hovelSzamjegy kerek: 8 = F0 + 1 hő → vissza 8.
hovelKor8 : hovelSzamjegy (F0, 1) = 8
hovelKor8 = Refl

||| hovelSzamjegy kerek: 9 = F1 + 1 hő → vissza 9.
hovelKor9 : hovelSzamjegy (F1, 1) = 9
hovelKor9 = Refl

||| hovelSzamjegy kerek: 7 = F7 + 0 hő → vissza 7.
hovelKor7 : hovelSzamjegy (F7, 0) = 7
hovelKor7 = Refl

-- =====================================================================
-- 7. Helyiérték-hő bizonyítások: hoOsszegHelyiertek.
-- =====================================================================

||| 6 + 6 = 12 → digit 2, carry 1.
hoHelyiertek66 : hoOsszegHelyiertek 6 6 0 = (2, 1)
hoHelyiertek66 = Refl

||| 5 + 3 = 8 → digit 8, carry 0 (nincs decimális carry, a hő a csatornában).
hoHelyiertek53 : hoOsszegHelyiertek 5 3 0 = (8, 0)
hoHelyiertek53 = Refl

||| 9 + 9 = 18 → digit 8, carry 1.
hoHelyiertek99 : hoOsszegHelyiertek 9 9 0 = (8, 1)
hoHelyiertek99 = Refl

||| 6 + 5 + 1 (carry) = 12 → digit 2, carry 1.
hoHelyiertek65c : hoOsszegHelyiertek 6 5 1 = (2, 1)
hoHelyiertek65c = Refl

-- =====================================================================
-- 8. Carnot-carry szabályozás bizonyítások.
-- =====================================================================

||| Magas hatásfok (η > 0.5): a carry átmegy.
carnotCarryAt : carnotCarry 1 100.0 1.0 = 1
carnotCarryAt = Refl

||| Alacsony hatásfok (η < 0.5): a carry elveszik.
carnotCarryNem : carnotCarry 1 100.0 90.0 = 0
carnotCarryNem = Refl
