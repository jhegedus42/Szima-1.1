# A kör osztása és a bájt = 8 bit

## A kérdés

> A kört hány részre tudjuk felosztani? Mi köze van ennek ahhoz, hogy 1 bájt az 8 bit?

## 1. A kör osztása — Gauss–Wantzel-tétel

A kört **bármennyi** részre oszthatjuk numerikusan, de **szerkeszthető**
osztás (körző + egyenesvonal) csak akkor létezik, ha

```
N = 2^k × p₁·p₂·…·pₘ    (pᵢ KÜLÖNBÖZŐ Fermat-prímek: 3, 5, 17, 257, 65537)
```

A `KorOsztas.idr` kiszámolta (N = 1..24):

```
✓  1  2  3  4  5  6     8     10     12     15  16  17     20     24
✗                 7     9     11 13 14     18 19     21 22 23
```

- **7, 9, 11, 13, 14, 18, 19, 21, 22, 23 NEM szerkeszthető** (hétszög, kilencszög…)
- **12 = 2²·3 szerkeszthető** — ez **Bach 12-hangolása**!
- **17 szerkeszthető** — Gauss híres 17-szöge (1796, ekkor választotta a matematikát)
- **360° = 2³·3²·5** — a 3² miatt a teljes 360-asztás **NEM** szerkeszthető:
  a babilóniai 360 fok csupán közelítés, nem szerkeszthető egység.

## 2. Miért pont 8? — Hurwitz + Bott + Clifford

### Hurwitz-tétel

Normált **osztóalgebra** (ahol osztás mindig megvan → nincs információvesztés)
csak dimenzió **1, 2, 4, 8**-ban létezik:

```
R(1) → C(2) → H(4) → O(8)   — ÉS ITT VÉGE.
```

16-nál (sedenion) **zero-divisor** jelenik meg: x·y = 0 nem-nullákra
→ információ **elvész**. A Cayley–Dickson-lépcső 8-nál "fagy be".

### Bott-periodicitás

A szimmetriák **8-as periódussal** ismétlődnek:

```
π_k = π_{k+8}        (homotópiacsoportok)
Cl(n+8) ≅ Cl(n) ⊗ R(16)   (Clifford-algebra)
```

### Clifford

```
|Cl(8)| = 2⁸ = 256   — pontosan EGY BÁJT értéktere.
E8 = 240 gyök + 8 Cartan = 248 = 256 − 8  (a bájt "lyuka").
```

## 3. A bájt = 8 bit, mert…

**Az információmegmaradás algebrája 8-periodikus.**

- 8 bit = az **E8Pont** = a projekt alapegysége: 8 Kubit.
- **E8Pont = 1 bájt.** E8⁴ (ter/szín/hang/mod) = 4 bájt = 32 bit.
- A Kereső minden mondatot bájtokba — azaz **E8-rácspontokba** — kódol.
- 16 bites (2 bájtos) egység = sedenion = zero-divisor = információvesztés.
  Ezért NEM 16 az alapegység: a 16-nál az információ már elveszhet.

A 8 az **utolsó dimenzió**, ahol a kör (a fáziskör S¹ → S⁷) még
veszteségmentesen osztható.

## 4. Bach: a kör, ami nem záródik

Az ötödkör (12 tiszta kvint ≈ 7 oktáv):

```
(3/2)¹² / 2⁷ = 3¹²/2¹⁹ = 531441/524288 ≈ 1.013643
= a PITAGORESZI KOMMA = 23.46 cent
```

**A kör NEM záródik** — pontosan úgy, mint ϱ-nál:

```
zenei δ:  1 − (3/2)¹²/2⁷ fordítottja ≈ 1.36%    (komma, 23.46 cent)
ϱ-δ:      1 − Re(ϱ)·π           = 5.604×10⁻⁴
```

Mindkettő **irreducibilis rés**: nem hozzáadható korrekcióval zárható
(a `delta_analizis.py` bizonyította ϱ-ra). **Bach korrekciója** =
a komma elosztása 12 egyenlő részre (wohltemperiert) =
**a δ elosztása** — nem eltüntetése! Ugyanaz a stratégia, mint a
projekt Bach-tagja az α⁻¹-nél.

## 5. Összefoglaló

| Fogalom | Érték | Miért |
|---|---|---|
| Kör osztásai | N = 2ᵏ×Fermat-prímek | Gauss–Wantzel |
| 12 | szerkeszthető | 2²·3 — **Bach** |
| 17 | szerkeszthető | Gauss 17-szöge |
| 360 | NEM szerkeszthető | 3² osztja — közelítés |
| **8** | **2³, szerkeszthető** | **az utolsó veszteségmentes dimenzió** |
| Cl(8) | 256 elem | **1 bájt** |
| E8 | 248 = 256−8 | 240 gyök + 8 Cartan |
| E8Pont | 8 Kubit | **= 1 bájt** (a projekt alapegysége) |
| komma | 23.46 cent | a zenei δ — Bach elosztja |

**Tétel: 1 bájt = 8 bit, mert a 8 az utolsó dimenzió, ahol az információ
még nem vész el (Hurwitz), a szimmetria 8-periodikus (Bott), és a teljes
Cl(8)-algebra pontosan 256 elemű. A projekt E8Pontja = 1 bájt — a kereső
ezért bájt-alapú, és ezért nem 16-alapú.**

## Fájl

- `osveny_index/KorOsztas.idr` — fordul és fut; Gauss–Wantzel N=1..24,
  Cl(8)=256, E8=248, komma=23.46 cent, ϱ-δ=5.6×10⁻⁴
