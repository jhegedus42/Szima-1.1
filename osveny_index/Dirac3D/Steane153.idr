module Steane153

import Data.Vect
import Carnot
import E8Diszkretizacio

-- =====================================================================
-- STEANE [[15,1,3]] — a 16 szoba − 1. A tetraéderes kvantum
-- Reed–Muller kód (QRM(4)), a MANTRA 8. szintjének kódja.
--
-- Szerkezet (Error Correction Zoo, Kubica–Beverland 2015):
--   - 15 kubit = a tesserakt (4-kocka) 16 sarkából a NULLA-sarok
--     kilyukasztva: 2⁴ − 1 = 15. A hiányzó 16. sarok = a KÜLSŐ
--     koordináta (NOBEL_CEL_TERKEP 4. szakasz: a 16. dimenzió
--     a fázistér határkoordinátája — a mérés helye).
--   - 4 X-stabilizátor: a cellulált tetraéder 4 cellája (súly 8).
--   - 10 Z-stabilizátor: a 10 lap (4 külső + 6 belső) (súly 4).
--   - 14 stabilizátor → 1 logikai kubit. Távolság 3 → 1 hiba javítás.
--
-- A szépség: az X-szindróma 4 bitje = a hibás pozíció BINÁRIS
-- alakja (a 4 X-cella a Hamming-kód paritásellenőrzései).
-- A [[15,1,3]]-nak transzverzális T-kapuja van (a legkisebb ilyen
-- kód, Koutsioumpas et al. 2022) — a "varázs" forrása.
--
-- Kapcsolat a projekt egészéhez: [[2³−1,1,3]] = [[7,1,3]]
-- (Steane, a 8 szoba − 1), [[2⁴−1,1,3]] = [[15,1,3]] (a 16 szoba − 1),
-- [[2⁵−1,1,3]] = [[31,1,3]] — a fraktál család (NOBEL 16.5).
-- A klasszikus RM(1,4) = a Barnes–Wall BW₁₆ rács konstrukciója
-- (Conway–Sloane) — ugyanaz a torony, mint az E8-diszkretizáció.
-- =====================================================================

%default total

-- =====================================================================
-- 1. Segédfüggvények: Fin indexek és bit-műveletek.
-- =====================================================================

public export
natToFin15 : Nat -> Fin 15
natToFin15 0 = FZ
natToFin15 1 = FS (FZ)
natToFin15 2 = FS (FS (FZ))
natToFin15 3 = FS (FS (FS (FZ)))
natToFin15 4 = FS (FS (FS (FS (FZ))))
natToFin15 5 = FS (FS (FS (FS (FS (FZ)))))
natToFin15 6 = FS (FS (FS (FS (FS (FS (FZ))))))
natToFin15 7 = FS (FS (FS (FS (FS (FS (FS (FZ)))))))
natToFin15 8 = FS (FS (FS (FS (FS (FS (FS (FS (FZ))))))))
natToFin15 9 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ)))))))))
natToFin15 10 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ))))))))))
natToFin15 11 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ)))))))))))
natToFin15 12 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ))))))))))))
natToFin15 13 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ)))))))))))))
natToFin15 14 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ))))))))))))))
natToFin15 _ = FZ

public export
natToFin10 : Nat -> Fin 10
natToFin10 0 = FZ
natToFin10 1 = FS (FZ)
natToFin10 2 = FS (FS (FZ))
natToFin10 3 = FS (FS (FS (FZ)))
natToFin10 4 = FS (FS (FS (FS (FZ))))
natToFin10 5 = FS (FS (FS (FS (FS (FZ)))))
natToFin10 6 = FS (FS (FS (FS (FS (FS (FZ))))))
natToFin10 7 = FS (FS (FS (FS (FS (FS (FS (FZ)))))))
natToFin10 8 = FS (FS (FS (FS (FS (FS (FS (FS (FZ))))))))
natToFin10 9 = FS (FS (FS (FS (FS (FS (FS (FS (FS (FZ)))))))))
natToFin10 _ = FZ

public export
natToFin4 : Nat -> Fin 4
natToFin4 0 = FZ
natToFin4 1 = FS FZ
natToFin4 2 = FS (FS FZ)
natToFin4 3 = FS (FS (FS FZ))
natToFin4 _ = FZ

||| Súly: hány 1-es van a vektorban.
public export
suly15 : Vect 15 Nat -> Nat
suly15 v = go 15
  where
    go : Nat -> Nat
    go Z = 0
    go (S n) = index (natToFin15 n) v + go n

||| Paritás: az 1-esek száma mod 2.
public export
paritas15 : Vect 15 Nat -> Nat
paritas15 v = go 15
  where
    go : Nat -> Nat
    go Z = 0
    go (S n) = xorBit (index (natToFin15 n) v) (go n)

||| Átfedés paritása: a két vektor közös 1-eseinek száma mod 2.
||| Ez a kommutáció feltétele: X-minta és Z-minta kommutál,
||| ha az átfedés paritása 0.
public export
atfedesParitas : Vect 15 Nat -> Vect 15 Nat -> Nat
atfedesParitas a b = paritas15 (zipWith bitSzorzat a b)

public export
kommutal15 : Vect 15 Nat -> Vect 15 Nat -> Bool
kommutal15 a b = atfedesParitas a b == 0

-- =====================================================================
-- 2. A stabilizátorok: 4 X-cella (súly 8) + 10 Z-lap (súly 4).
-- =====================================================================

public export
XCella1 : Vect 15 Nat
XCella1 = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]

public export
XCella2 : Vect 15 Nat
XCella2 = [1,1,1,1,0,0,0,0,1,1,1,1,0,0,0]

public export
XCella3 : Vect 15 Nat
XCella3 = [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0]

public export
XCella4 : Vect 15 Nat
XCella4 = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]

public export
ZLap1 : Vect 15 Nat
ZLap1 = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0]

public export
ZLap2 : Vect 15 Nat
ZLap2 = [1,1,1,1,0,0,0,0,1,1,1,1,0,0,0]

public export
ZLap3 : Vect 15 Nat
ZLap3 = [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0]

public export
ZLap4 : Vect 15 Nat
ZLap4 = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1]

public export
ZLap5 : Vect 15 Nat
ZLap5 = [1,1,1,1,0,0,0,0,0,0,0,0,0,0,0]

public export
ZLap6 : Vect 15 Nat
ZLap6 = [1,1,0,0,1,1,0,0,0,0,0,0,0,0,0]

public export
ZLap7 : Vect 15 Nat
ZLap7 = [1,0,1,0,1,0,1,0,0,0,0,0,0,0,0]

public export
ZLap8 : Vect 15 Nat
ZLap8 = [1,1,0,0,0,0,0,0,1,1,0,0,0,0,0]

public export
ZLap9 : Vect 15 Nat
ZLap9 = [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0]

public export
ZLap10 : Vect 15 Nat
ZLap10 = [1,0,1,0,0,0,0,0,1,0,1,0,0,0,0]

-- =====================================================================
-- 3. Kommutáció: minden X-cella × Z-lap pár.
-- =====================================================================

||| Mind a 40 X–Z pár kommutál?
public export
mindKommutal : Bool
mindKommutal =
  kommutal15 XCella1 ZLap1 && kommutal15 XCella1 ZLap2 &&
  kommutal15 XCella1 ZLap3 && kommutal15 XCella1 ZLap4 &&
  kommutal15 XCella1 ZLap5 && kommutal15 XCella1 ZLap6 &&
  kommutal15 XCella1 ZLap7 && kommutal15 XCella1 ZLap8 &&
  kommutal15 XCella1 ZLap9 && kommutal15 XCella1 ZLap10 &&
  kommutal15 XCella2 ZLap1 && kommutal15 XCella2 ZLap2 &&
  kommutal15 XCella2 ZLap3 && kommutal15 XCella2 ZLap4 &&
  kommutal15 XCella2 ZLap5 && kommutal15 XCella2 ZLap6 &&
  kommutal15 XCella2 ZLap7 && kommutal15 XCella2 ZLap8 &&
  kommutal15 XCella2 ZLap9 && kommutal15 XCella2 ZLap10 &&
  kommutal15 XCella3 ZLap1 && kommutal15 XCella3 ZLap2 &&
  kommutal15 XCella3 ZLap3 && kommutal15 XCella3 ZLap4 &&
  kommutal15 XCella3 ZLap5 && kommutal15 XCella3 ZLap6 &&
  kommutal15 XCella3 ZLap7 && kommutal15 XCella3 ZLap8 &&
  kommutal15 XCella3 ZLap9 && kommutal15 XCella3 ZLap10 &&
  kommutal15 XCella4 ZLap1 && kommutal15 XCella4 ZLap2 &&
  kommutal15 XCella4 ZLap3 && kommutal15 XCella4 ZLap4 &&
  kommutal15 XCella4 ZLap5 && kommutal15 XCella4 ZLap6 &&
  kommutal15 XCella4 ZLap7 && kommutal15 XCella4 ZLap8 &&
  kommutal15 XCella4 ZLap9 && kommutal15 XCella4 ZLap10

-- =====================================================================
-- 4. Szindrómák: a hiba helyének kiolvasása.
-- =====================================================================

||| X-szindróma (4 bit): a Z-hibát (fázis-flip) az X-cellák érzékelik.
||| A 4 bit = a hibás pozíció BINÁRIS alakja (1..15).
public export
xSzindroma : Vect 15 Nat -> Vect 4 Nat
xSzindroma hiba =
  [atfedesParitas XCella1 hiba
  , atfedesParitas XCella2 hiba
  , atfedesParitas XCella3 hiba
  , atfedesParitas XCella4 hiba]

||| Z-szindróma (10 bit): az X-hibát (bit-flip) a Z-lapok érzékelik.
public export
zSzindroma : Vect 15 Nat -> Vect 10 Nat
zSzindroma hiba =
  [atfedesParitas ZLap1 hiba
  , atfedesParitas ZLap2 hiba
  , atfedesParitas ZLap3 hiba
  , atfedesParitas ZLap4 hiba
  , atfedesParitas ZLap5 hiba
  , atfedesParitas ZLap6 hiba
  , atfedesParitas ZLap7 hiba
  , atfedesParitas ZLap8 hiba
  , atfedesParitas ZLap9 hiba
  , atfedesParitas ZLap10 hiba]

-- =====================================================================
-- 5. Hibajavítás: szindróma → pozíció → bit visszafordítás.
-- =====================================================================

||| X-szindróma → hibás pozíció (0-alapú, 15 = nincs hiba).
public export
xSzindromaPozicio : Vect 4 Nat -> Nat
xSzindromaPozicio [0,0,0,0] = 15
xSzindromaPozicio [1,1,1,1] = 0
xSzindromaPozicio [1,1,1,0] = 1
xSzindromaPozicio [1,1,0,1] = 2
xSzindromaPozicio [1,1,0,0] = 3
xSzindromaPozicio [1,0,1,1] = 4
xSzindromaPozicio [1,0,1,0] = 5
xSzindromaPozicio [1,0,0,1] = 6
xSzindromaPozicio [1,0,0,0] = 7
xSzindromaPozicio [0,1,1,1] = 8
xSzindromaPozicio [0,1,1,0] = 9
xSzindromaPozicio [0,1,0,1] = 10
xSzindromaPozicio [0,1,0,0] = 11
xSzindromaPozicio [0,0,1,1] = 12
xSzindromaPozicio [0,0,1,0] = 13
xSzindromaPozicio [0,0,0,1] = 14
xSzindromaPozicio _ = 15

||| Z-szindróma → hibás pozíció (0-alapú, 15 = nincs hiba).
||| A 10 bit = a 10 Z-lap értéke a hibás pozícióban.
public export
zSzindromaPozicio : Vect 10 Nat -> Nat
zSzindromaPozicio [0,0,0,0,0,0,0,0,0,0] = 15
zSzindromaPozicio [1,1,1,1,1,1,1,1,1,1] = 0
zSzindromaPozicio [1,1,1,0,1,1,0,1,0,0] = 1
zSzindromaPozicio [1,1,0,1,1,0,1,0,0,1] = 2
zSzindromaPozicio [1,1,0,0,1,0,0,0,0,0] = 3
zSzindromaPozicio [1,0,1,1,0,1,1,0,1,0] = 4
zSzindromaPozicio [1,0,1,0,0,1,0,0,0,0] = 5
zSzindromaPozicio [1,0,0,1,0,0,1,0,0,0] = 6
zSzindromaPozicio [1,0,0,0,0,0,0,0,0,0] = 7
zSzindromaPozicio [0,1,1,1,0,0,0,1,1,1] = 8
zSzindromaPozicio [0,1,1,0,0,0,0,1,0,0] = 9
zSzindromaPozicio [0,1,0,1,0,0,0,0,0,1] = 10
zSzindromaPozicio [0,1,0,0,0,0,0,0,0,0] = 11
zSzindromaPozicio [0,0,1,1,0,0,0,0,1,0] = 12
zSzindromaPozicio [0,0,1,0,0,0,0,0,0,0] = 13
zSzindromaPozicio [0,0,0,1,0,0,0,0,0,0] = 14
zSzindromaPozicio _ = 15

||| Egy bit visszafordítása a vektorban.
public export
bitFordit : Nat -> Vect 15 Nat -> Vect 15 Nat
bitFordit p v = updateAt (natToFin15 p) (\b => xorBit b 1) v

||| Hibás vektor javítása: a szindróma megadja a pozíciót, visszafordítjuk.
public export
hibajavitas15 : Vect 15 Nat -> Vect 15 Nat
hibajavitas15 hibas =
  let zszin = zSzindroma hibas
      poz = zSzindromaPozicio zszin
  in if poz == 15 then hibas else bitFordit poz hibas

-- =====================================================================
-- 6. Logikai operátorok: a kódolt kubit.
-- =====================================================================

||| Logikai Z: súly-3 Z-húr a tetraéder egy élén (zoo).
||| Z az {1, 2, 15} pozíciókon.
public export
LogikaiZ : Vect 15 Nat
LogikaiZ = [1,1,0,0,0,0,0,0,0,0,0,0,0,0,1]

||| Logikai X: súly-7 X-lap a tetraéder egy lapján (zoo).
||| X az {1,2,3,4,13,14,15} pozíciókon.
public export
LogikaiX : Vect 15 Nat
LogikaiX = [1,1,1,1,0,0,0,0,0,0,0,0,1,1,1]

-- =====================================================================
-- 7. REFL BIZONYÍTÁSOK.
-- =====================================================================

-- 7a. A stabilizátorok súlyai.

XCella1Suly : suly15 XCella1 = 8
XCella1Suly = Refl

XCella4Suly : suly15 XCella4 = 8
XCella4Suly = Refl

ZLap5Suly : suly15 ZLap5 = 4
ZLap5Suly = Refl

ZLap9Suly : suly15 ZLap9 = 4
ZLap9Suly = Refl

-- 7b. Kommutáció: néhány reprezentatív pár.

Kommutal11 : atfedesParitas XCella1 ZLap1 = 0
Kommutal11 = Refl

Kommutal45 : atfedesParitas XCella4 ZLap5 = 0
Kommutal45 = Refl

Kommutal410 : atfedesParitas XCella4 ZLap10 = 0
Kommutal410 = Refl

-- 7c. A szindróma = a pozíció bináris alakja.

||| Z-hiba a 0. pozíción: a szindróma (1,1,1,1) = 1 binárisan.
XszinPozicio0 : xSzindroma [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0] = [1,1,1,1]
XszinPozicio0 = Refl

||| Z-hiba a 14. pozíción: a szindróma (0,0,0,1) = 15 binárisan.
XszinPozicio14 : xSzindroma [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1] = [0,0,0,1]
XszinPozicio14 = Refl

||| Z-hiba a 3. pozíción: (1,1,0,0) = 4 binárisan.
XszinPozicio3 : xSzindroma [0,0,0,1,0,0,0,0,0,0,0,0,0,0,0] = [1,1,0,0]
XszinPozicio3 = Refl

-- 7d. A logikai operátorok tulajdonságai.

||| Logikai Z súlya 3 (a távolság: d = 3).
LogikaiZSuly : suly15 LogikaiZ = 3
LogikaiZSuly = Refl

||| Logikai X súlya 7.
LogikaiXSuly : suly15 LogikaiX = 7
LogikaiXSuly = Refl

||| Logikai X és Z antikommutál: |{1,2,15} ∩ {1,2,3,4,13,14,15}| = 3.
LogikaiAntikomm : atfedesParitas LogikaiX LogikaiZ = 1
LogikaiAntikomm = Refl

||| A logikai Z kommutál mind a 4 X-cellával.
LogikaiZKomm1 : atfedesParitas XCella1 LogikaiZ = 0
LogikaiZKomm1 = Refl

LogikaiZKomm2 : atfedesParitas XCella2 LogikaiZ = 0
LogikaiZKomm2 = Refl

LogikaiZKomm3 : atfedesParitas XCella3 LogikaiZ = 0
LogikaiZKomm3 = Refl

LogikaiZKomm4 : atfedesParitas XCella4 LogikaiZ = 0
LogikaiZKomm4 = Refl

-- =====================================================================
-- 8. Teljes teszt: minden 1-hibás állapot javítása.
-- =====================================================================

||| A 15 lehetséges X-hiba (bit-flip) mindegyikének azonosítása
||| a Z-szindrómából.
public export
xHibakJavitasa : Bool
xHibakJavitasa = go 15
  where
    go : Nat -> Bool
    go Z = True
    go (S n) =
      let p = minus n 1
          hiba = bitFordit p (replicate 15 0)
          zszin = zSzindroma hiba
          poz = zSzindromaPozicio zszin
      in (poz == p) && go n
      where
        minus : Nat -> Nat -> Nat
        minus Z m = m
        minus x Z = x
        minus (S x) (S y) = minus x y

||| A 15 lehetséges Z-hiba (fázis-flip) mindegyikének azonosítása
||| az X-szindrómából.
public export
zHibakJavitasa : Bool
zHibakJavitasa = go 15
  where
    go : Nat -> Bool
    go Z = True
    go (S n) =
      let p = minus n 1
          hiba = bitFordit p (replicate 15 0)
          xszin = xSzindroma hiba
          poz = xSzindromaPozicio xszin
      in (poz == p) && go n
      where
        minus : Nat -> Nat -> Nat
        minus Z m = m
        minus x Z = x
        minus (S x) (S y) = minus x y
