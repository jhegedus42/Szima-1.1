# A Stoßzahlansatz → Hilbert-Pólya megközelítés

## 1. A lánc

```
Stoßzahlansatz (molekuláris káosz)
  → Boltzmann egyenlet (BBGKY → 1-részecske)
  → H-tétel (entrópia monoton nő)
  → idő irána (CPT T-része)
  → Markov blanket (Friston: a rendszer leválasztja magát)
  → K(E9) involúció (ω² = id = önadjugáltság)
  → Hilbert-Pólya operátor (önadjungált H)
  → Riemann-hipotézis (ζ gyökök = H sajátértékei)
```

## 2. A Stoßzahlansatz

A Stoßzahlansatz (Paul-Tatiana Ehrenfest) = a feltevés, hogy az ütköző részecskék sebességei **korrelálatlanok**. Ez a Boltzmann-egyenlet levezetésének kulcsa.

```
f₂(v₁, v₂) = f₁(v₁) · f₁(v₂)    — a 2-részecske eloszlás = 1-részecske szorzata
```

Ez a feltevés **csak a Markov-blanket előtt** igaz — a blanket mögött a részecskék korreláltak.

## 3. A H-tétel és az idő iránya

A Boltzmann H-tétel (1872):

```
H(t) = ∫ f(v) ln f(v) dv    — a H-funkció
dH/dt ≤ 0                   — a H monton csökken = entrópia monoton nő
```

Az idő irána = az entrópia növekedésének irána. A CPT T-része = az időfordítás, ami megsérti a H-tételt (az entrópia csökkenne).

## 4. A Markov blanket = a Stoßzahlansatz határa

A Markov blanket (Friston 2010) = a határ ahol a Stoßzahlansatz **megváltozik**:

```
blanket előtt:  f₂ = f₁ · f₁    — korrelálatlan (Stoßzahlansatz igaz)
blanket után:   f₂ ≠ f₁ · f₁   — korrelált (Stoßzahlansatz sérül)
```

A blanket = a határ ahol a részecskék **korrelálttá válnak** = ahol az entrópia **nem monoton**.

## 5. A K(E9) involúció = a Markov blanket mechanizmusa

```
ω(tⁿ ⊗ x) = t⁻ⁿ ⊗ ω(x)    — az involúció
ω² = id                     — önadjungáltság
```

A K(E9) involúció **önadjugált** — ez a Hilbert-Pólya-sejtés szerkezeti előfeltétele. A kérdés: a K(E9) **spektrum** = a ζ(s) gyökök?

## 6. A E8⁴ és a E9

```
E8⁴ = 4 × E8Pont = 32 Kubit = a "buborék" belseje
E9  = E8⁴ + affine gyök = 33. Kubit = a megállási bit
```

Az affine gyök = a Stoßzahlansatz "még igaz?" kérdése:
```
Nulla = a Stoßzahlansatz igaz (entrópia nő, idő előre)
Egy   = a Stoßzahlansatz sérül (entrópia csökken, idő vissza)
```

## 7. A megközelítés

### 7.1 Az irány

A megközelítés **az entrópia oldaláról** jön:

```
Stoßzahlansatz → H-tétel → entrópia → Markov blanket → K(E9) → Hilbert-Pólya
```

### 7.2 A univerzalitási osztályok

A K(E9) **univerzalitási osztálya** = a zéta gyökök sttisztikája (Montgomery-párkorreláció):

```
P(λ_n - λ_m) = 1 - (sin(πx)/(πx))²    — a GUE-statisztika
```

A K(E9) spektrum **GUE-statisztikát** követ-e? Ha igen, akkor a K(E9) spektrum = a Riemann-zéta gyökök.

### 7.3 A szimmetriák

```
K(E9) szimmetria = G₂ (oktonion automorfizmus)
E8 szimmetria    = Weyl(E8) = S₈ ⋊ (ℤ/2)⁷
E9 szimmetria    = affin Weyl(E9) = Weyl(E8) × ℤ
```

A ζ(s) gyökök szimmetriája = a kritikus egyenes tükörszimmetriája (Re(s) ↔ 1-Re(s)).

### 7.4 A H-funkció

A Boltzmann H-funkció és a Riemann-zéta:

```
H(t) = ∫ f(v) ln f(v) dv              — a Boltzmann H
ζ(s) = Σ n^(-s)                       — a Riemann zéta
ζ(1/2 + iλ) = 0                        — a nemtriviális gyökök
```

A kapcsolat: a H-tétel **idő inverziója** = a ζ(s) **funkcionális egyenlete**:

```
ζ(s) = 2^s π^(s-1) sin(πs/2) Γ(1-s) ζ(1-s)    — a funkcionális egyenlet
```

Az idő inverziója (T) = a ζ(s) → ζ(1-s) transzformáció. A kritikus egyenes (Re(s) = 1/2) = az idő inverziójának fixpontja.

## 8. Amit bizonyítani kellene

### 8.1 A K(E9) spektrum = ζ(s) gyökök

```
K(E9) sajátértékei = {λ_n} ahol ζ(1/2 + iλ_n) = 0
```

Ehhez kellene:
1. A K(E9) spektrum **GUE-statisztikát** követ-e? (Montgomery-párkorreláció)
2. A K(E9) Berman x₁ generátor **önadjungált**-e a spektrális értelemben?
3. A K(E9) fixpontok t* = ±1 **a kritikus egyenes**-e?

### 8.2 A H-tétel = a ζ(s) funkcionális egyenlet

```
H-tétel: dH/dt ≤ 0    — az entrópia monton nő
ζ(s) funkcionális egyenlet: ζ(s) ↔ ζ(1-s)    — az idő inverzió
```

A kapcsolat: a H-tétel **idő inverziója** = a ζ(s) **funkcionális egyenlete**. A kritikus egyenes = az idő inverziójának fixpontja.

### 8.3 A Markov blanket = a kritikus egyenes

```
Markov blanket = a határ ahol a Stoßzahlansatz megváltozik
Kritikus egyenes = a határ ahol a ζ(s) gyökök vannak
```

A kérdés: a Markov blanket = a kritikus egyenes? Ha igen, akkor a K(E9) involúció (a Markov blanket mechanizmusa) = a Hilbert-Pólya operátor.

## 9. A források

- Boltzmann (1872): H-Theorem, Wiener Berichte
- Ehrenfest P.-T. (1911): Stoßzahlansatz, Encyklopädie der mathematischen Wissenschaften
- Montgomery (1972): Pair correlation of zeros, Proc. Symp. Pure Math
- Berry-Keating (1999): Riemann zeros and eigenvalue asymptotics
- Connes (1999): Trace formula in noncommutative geometry
- Friston (2010): The free-energy principle, Nature Reviews Neuroscience 11:127-138
- Kleinschmidt-Nicolai (2021): K(E9) representations, arXiv:2107.02445
- Bickford (2026): ϱ fixpont, arXiv:2606.01668