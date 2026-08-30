# MŰVELETI KÓDOLÁS — Bijektív bit-kód

Minden matematikai műveletnek 6 bites egyedi kódja. 2^6 = 64 művelet fér el.
A 6 bit = 6 generátor: g1..g6.

## Generátorok jelentése a műveleteknél

| Bit | Gen. | X (=1) | Z (=0) |
|-----|------|--------|--------|
| g1 (5. bit) | Kategória | Analitikus (deriválás, integrálás) | Algebrai (+,-,*,/,^) |
| g2 (4. bit) | Irány | Inverz művelet (-, /, gyök, log) | Direkt művelet (+, *, ^) |
| g3 (3. bit) | Arítás | Bináris (két operandus) | Unáris (egy operandus) |
| g4 (2. bit) | Fázis | Szerkezet-megtartó (+ gyűrűben) | Szerkezet-váltó (* → ^) |
| g5 (1. bit) | Mód | Determinisztikus | Valószínűségi / határérték |
| g6 (0. bit) | Konstrukció | Konstruál (növel) | Destruál (csökkent) |

## Teljes kódolás

### Algebrai kategória (g1=Z=0)

**Direkt (g2=Z=0)**
```
000000 (0):  +  (összeadás)       - direkt, bináris, megtartó, det, konstruál
000001 (1):  -  (kivonás)         - direkt, bináris, megtartó, det, destruál
000010 (2):  ×  (szorzás)         - direkt, bináris, váltó, det, konstruál
000011 (3):  ÷  (osztás)          - direkt, bináris, váltó, det, destruál
000100 (4):  ^  (hatványozás)     - direkt, bináris, váltó, det, konstruál
000101 (5):  mod (maradék)        - direkt, bináris, váltó, det, destruál
000110 (6):  ⊕  (XOR)             - direkt, bináris, váltó, det, konstruál
000111 (7):  &  (AND)             - direkt, bináris, váltó, det, destruál
```

**Inverz (g2=X=1)**
```
010000 (16): -x (negálás/unáris -) - inverz, unáris, megtartó, det, destruál
010001 (17): 1/x (reciprok)        - inverz, unáris, megtartó, det, destruál
010010 (18): √  (gyök)             - inverz, unáris, váltó, det, destruál
010011 (19): log (logaritmus)      - inverz, unáris, váltó, det, destruál
010100 (20): GCD                   - inverz, bináris, váltó, det, konstruál
010101 (21): LCM                   - inverz, bináris, váltó, det, destruál
010110 (22): |  (OR)               - inverz(AND), bináris, váltó, det, destruál
010111 (23): ~  (NOT)              - inverz, unáris, váltó, det, destruál
```

### Analitikus kategória (g1=X=1)

**Direkt**
```
100000 (32): d/dx  (deriválás)    - direkt, unáris, váltó, det, destruál
100001 (33): ∫     (integrálás)   - direkt, unáris, váltó, det, konstruál
100010 (34): ∇     (gradiens)     - direkt, unáris, váltó, det, konstruál
100011 (35): ∇·    (divergencia)  - direkt, unáris, váltó, det, destruál
100100 (36): ∇×    (rotáció)      - direkt, unáris, váltó, det, konstruál
100101 (37): Δ     (Laplace)      - CPT MASZK! direkt, unáris, váltó, det, destruál
100110 (38): ∂     (parciális)    - direkt, unáris, váltó, det, destruál
100111 (39): lim   (határérték)   - direkt, bináris, váltó, valószínűségi, destruál
```

**Inverz**
```
110000 (48): ∫⁻¹/FT (Fourier)    - inverz(integrál), unáris, váltó, det, konstruál
110001 (49): Laplace-transzform   - inverz, unáris, váltó, det, konstruál
110010 (50): exp (exponenciális)  - inverz(log), unáris, váltó, det, konstruál
110011 (51): sin,cos,tan          - inverz(?), unáris, váltó, det, ...
```

## Bijekció bizonyítása

Minden műveletnek egyedi 6 bites kódja van (injektív).
2^6 = 64 lehetséges kód, mind kiosztható művelethez (szürjektív).
Tehát a leképezés BIJEKTÍV.

## MDL alkalmazás

Példa: 7^3 = 343
- ^ kódja: 000100 (6 bit)
- 7 kódja: 000111 (6 bit)
- 3 kódja: 000011 (6 bit)
- Teljes: 6 + 3 + 3 = 12 bit (ha a számokat minimális bitszélességgel kódoljuk)

vs "343" mint decimális: log2(343) ≈ 9 bit.

A hatványozás mint ALGORITMUS + a két operandus tömörebb lehet mint a nyers eredmény.
Ez az MDL lényege: ^(7,3) mint algoritmus+adat vs 343 mint adat.
