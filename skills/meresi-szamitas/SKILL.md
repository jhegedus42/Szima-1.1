---
name: meresi-szamitas
description: >
  Mérési eredmények számítása tisztán typeclass instance-okból, hierarchikusan.
  Minden számítás typeclass kompozíció: az instance resolution = a számítás.
  A típusok meghatározzák az értékeket — nincs pattern matching, nincs runtime.
  A hierarchia = optimalizált kódolás (Huffman-szerű).
  A fizikai konstansok = typeclass kompozíció egyedi lakói.
  Forrás: type-driven development (Brady), typeclass hierarchy computation.
---

# Mérési Számítás — Typeclass Hierarchia Alapú

## Alapelv

**Az instance resolution = a számítás.**

Minden `instance Kondicio => Osztaly Fej` egy Horn-klóz.
A fordító Prolog-stílusú rezolválást végez típusellenőrzéskor.
Az értékek a típusokból származnak — nulla runtime pattern matching.

```
-- Nem így:
alphaInverz : Double
alphaInverz = 2**7 + 2**3 + 1 + 9/250

-- Hanem így:
interface AlphaInverzT (n : Nat) where
  alphaInverzTipusbol : Nat

AlphaInverzT 137 where
  alphaInverzTipusbol = 2*2*2*2*2*2*2 + 2*2*2 + 1

-- A típus meghatározza az értéket. Csak egy implementáció lehetséges.
```

## A Hierarchia = Optimalizált Kódolás

A typeclass hierarchia egy finomítási háló:
```
FelcsoportT (általános, legtöbb instance)
  ↓
MonoidT (specifikusabb, kevesebb instance)
  ↓
CsoportT (még specifikusabb)
  ↓
AbelCsoportT (legspecifikusabb, legkevesebb)
```

Minél specifikusabb → annál kevesebb instance → annál rövidebb leírás.
Ez **Huffman-szerű kódolás**: a leggyakoribb struktúra (általános)
rövid láncot kap, a ritka (specifikus) hosszabbat.

## Fizikai Konstansok = Typeclass Kompozíció

Minden fizikai állandó = egy typeclass kompozíció egyedi lakója:

```
-- A 5 prím hierarchiája:
interface PrimT (p : Nat) | p where
  primErtek : Nat

PrimT 2 where primErtek = 2   -- horgony
PrimT 3 where primErtek = 3   -- szél
PrimT 5 where primErtek = 5   -- tükör
PrimT 7 where primErtek = 7   -- part
PrimT 10 where primErtek = 10  -- kapu

-- α⁻¹ = 137 + 9/250, kifejezve typeclass-okkal:
interface AlphaInverzKomponensT (a : Type) where
  egeszResz : a -> Nat
  tortResz : a -> Nat

-- Az instance = a bizonyítás (Curry-Howard)
```

## Ellenőrzés

A számított értéket a CODATA referenciával hasonlítjuk össze:
- Ha hiba < mérési bizonytalanság → MÉRÉSI HIBÁN BELÜL ✓
- Ha hiba > mérési bizonytalanság → NEM ✓

Lásd: `skill codata` a referenciákért.

## Recept (Brady: Type-Driven Development)

1. Minden komponenst típus-szintű számként/ konstrukorként ábrázolj
2. Minden numerikus törvényt egy instance-ként, aminek a kontextusa láncolja
3. A funkcionális dependenciák (`| a -> b`) vigyék az eredményt
4. Az "optimális kódolás" a legrövidebb instance láncolatból adódik

## Források

- Edwin Brady: "Type-Driven Development with Idris" (Manning)
- Haskell Typeclassopedia
- GHC instance resolution dokumentáció
- Wadler: "Theorems for Free!" (parametricity = free proof)