# A Stoszahl-ansatz és a Hilbert-Pólya-sejtés

## 1. A Stoszahl-ansatz

A Stoszahl-ansatz (német: "állítószám-ansatz") = a feltevés, hogy a Riemann-zéta nemtriviális gyökei egy **önadjungált operátor** sajátértékei. Ez a Hilbert-Pólya-sejtés:

```
ζ(s) = 0    ha és csak ha    s = 1/2 + iλ    ahol λ a H önadjungált operátor sajátértéke
```

## 2. A Hilbert-Pólya-sejtés

A Hilbert-Pólya-sejtés azt állítja, hogy létezik egy önadjungált operátor H, amelynek sajátértékei a Riemann-zéta nemtriviális gyökeinek imaginárius részei:

```
ζ(1/2 + iλ_n) = 0    ahol λ_n = H sajátértéke
```

Ha ez igaz, akkor minden nemtriviális gyök a kritikus egyenesen van (Re(s) = 1/2), ami a Riemann-hipotézis.

### 2.1 A Berry-Keating-sejtés

A Berry-Keating-sejtés (1999) a Hilbert-Pólya operátor konkrét alakját javasolja:

```
H = xp + px = -iℏ(x∂_x + 1/2)
```

ahol x a pozíció és p = -iℏ∂_x a momentum.

### 2.2 A Connes-sejtés

Alain Connes (1999) javasolta, hogy a Riemann-zéta gyökei egy adele-sík geometriai operátor sajátértékei.

## 3. A K(E₉) involúció mint Hilbert-Pólya operátor

### 3.1 A K(E₉) önadjungáltsága

A K(E₉) involúció önadjungált:

```
ω(t^n ⊗ x) = t^(-n) ⊗ ω(x)    — az involúció
ω² = id                          — önadjungáltság
```

### 3.2 A fixpontok

```
t* = +1    — a Chiral fixpont (konvergál, stabil)
t* = -1    — az AntiChiral fixpont (oszcillál, periodikus)
```

### 3.3 A Berman x₁ kritikus generátor

```
x₁ = a kritikus Berman generátor
   = összeköti a q⁺ és q⁻ parabolikusokat
   = a Hilbert-Pólya operátor
```

### 3.4 A spektrum

```
K(E₉) spektrum: t^n ⊗ x    ahol n ∈ ℤ
Az involúció fixpontjai: t = ±1
A kritikus egyenes: Re(s) = 1/2
```

### 3.5 A kapcsolat

```
Chiral (t* = +1) = a kritikus egyenes jobb fele (Re(s) > 1/2)
AntiChiral (t* = -1) = a kritikus egyenes bal fele (Re(s) < 1/2)
A két fél kommutál: [q⁺, q⁻] = 0
```

## 4. A projekt helyzete

### 4.1 Amit tudunk

- A K(E₉) involúció önadjungált (ω² = id)
- A Berman x₁ kritikus generátor összeköti a két chirális felet
- A fixpontok t* = ±1
- A ϱ fixpont komplex (0.318 + 1.337i)

### 4.2 Amit nem tudunk

- A K(E₉) spektrum sajátértékei = a ζ(s) gyökei-e?
- A Berman x₁ = a Berry-Keating H operátor-e?
- A fixpontok t* = ±1 = a kritikus egyenes Re(s) = 1/2-e?

### 4.3 A Stoszahl-ansatz helyzete a projektben

A Stoszahl-ansatz = a "állítószám" ami a K(E₉) fixpontjában jelenik meg. A projektben:

```
φ = (1+√5)/2 = az aranymetszés = a Stoszahl
```

Az aranymetszés a kontrakció fixpontja:

```
f(z) = √(1+z)    — a kontrakció
φ = √(1+φ)       — a fixpont
φ² = 1 + φ       — a fixpont egyenlete
φ² - φ - 1 = 0   — az aranymetszés másodfokú egyenlete
```

## 5. A ϱ fixpont

### 5.1 A komplex exponenciális fixpontja

```
exp(ϱ) = ϱ
ϱ = 0.3181315052047648 + 1.3372357014306894i
|ϱ| = 1.3745570107436724
arg(ϱ) = 1.3372357014307032
```

### 5.2 A Stoszahl-ansatz és a ϱ fixpont

```
Re(ϱ) = 0.318    — a valós rész
Im(ϱ) = 1.337    — az imaginárius rész (a ζ(s) gyökének imaginárius része?)
```

### 5.3 A kritikus egyenes

```
Re(s) = 1/2 = a kritikus egyenes
ϱ Re része = 0.318 ≈ 1/π = 0.318...
```

## 6. A források

- Hilbert-Pólya-sejtés: Wikipedia, "Hilbert-Pólya conjecture"
- Berry-Keating-sejtés: Berry & Keating (1999), "The Riemann zeros and eigenvalue asymptotics"
- Connes-sejtés: Connes (1999), "Trace formula in noncommutative geometry"
- K(E₉): Kleinschmidt & Nicolai (2021), arXiv:2107.02445
- ϱ fixpont: Bickford (2026), arXiv:2606.01668
- Stoszahl-ansatz: a projekt saját fogalma (az "állítószám" = a fixpont)
- Riemann-hipotézis: Riemann (1859), "Über die Anzahl der Primzahlen unter einer gegebenen Grösse"