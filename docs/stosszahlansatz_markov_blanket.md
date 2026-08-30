# A Stoßzahlansatz és a Markov Blanket

## 1. A Stoßzahlansatz (német: "ütközésszám-feltevés")

A **Stoßzahlansatz** = Boltzmann feltevése (1872), hogy az ütköző részecskék sebességei **korrelálatlanok**:

```
Stoß = ütközés
Zahl = szám
Ansatz = feltevés
```

### 1.1 A feltevés

```
f₂(v₁, v₂) = f₁(v₁) · f₁(v₂)    — a 2-részecske eloszlás = 1-részecske szorzata
```

ahol:
- `f₁(v)` = az 1-részecske sebesség-eloszlás
- `f₂(v₁, v₂)` = a 2-részecsse sebesség-eloszlás
- A feltevés: a két részecsse **független** = korrelálatlan

### 1.2 Az ütközések száma

```
az ütközések száma = f₁(v₁) · f₁(v₂) · σ · |v₁ - v₂|
```

ahol:
- `σ` = a hatáskeresztmetszet (ütközési valószínűség)
- `|v₁ - v₂|` = a relatív sebesség
- `f₁(v₁) · f₁(v₂)` = a koncentráció szorzata (Stoßzahlansatz)

### 1.3 A Boltzmann-egyenlet

A Stoßzahlansatz a BBGKY-hierarchiát redukálja a Boltzmann-egyenletre:

```
∂f/∂t + v · ∇f = Q(f, f)    — a Boltzmann-egyenlet
```

ahol `Q(f, f)` = az ütközési tag, ami a Stoßzahlansatz-ból jön.

## 2. A H-tétel

### 2.1 A Boltzmann H-funkció

```
H(t) = ∫ f(v) ln f(v) dv    — a H-funkció
```

A H-funkció = a negatív entrópia (Shannon-entrópia).

### 2.2 A H-tétel

```
dH/dt ≤ 0    — a H monoton csökken = az entrópia monoton nő
```

A H-tétel a Stoßzahlansatz-ból jön: ha az ütköző részecskék korrelálatlanok, akkor az entrópia monoton nő.

### 2.3 Az idő iránya

```
H-tétel: dH/dt ≤ 0    — az entrópia nő = az idő előre tart
CPT T-része: időfordítás    — az entrópia csökken = az idő visszafele
```

Az idő irána = az entrópia növekedésének irána.

## 3. A Stoßzahlansatz sérülése = a Markov blanket

### 3.1 A Markov blanket (Friston 2010)

A Markov blanket = a határ ami elválasztja a belső állapotokat (μ = posterior) a külsőktől (η = rejtett):

```
blanket előtt:  f₂(v₁, v₂) = f₁(v₁) · f₁(v₂)    — korrelálatlan (Stoßzahlansatz igaz)
blanket után:   f₂(v₁, v₂) ≠ f₁(v₁) · f₁(v₂)    — korrelált (Stoßzahlansatz sérül)
```

A blanket = a határ ahol a részecskék **korrelálttá válnak**.

### 3.2 A Markov blanket = a K(E₉) involúció

```
ω(tⁿ ⊗ x) = t⁻ⁿ ⊗ ω(x)    — az involúció = a Markov blanket
ω² = id                     — a blanket zárt volta
```

A K(E₉) involúció = a Markov blanket mechanizmusa:
- `tⁿ` = a belső állapot (korrelálatlan, Stoßzahlansatz igaz)
- `t⁻ⁿ` = a külső állapot (korrelált, Stoßzahlansatz sérül)
- `ω` = a határ (a blanket)

### 3.3 A blanket állapotok

```
s = sensory (a szenzoros állapot)    — a blanket kívülről befelé
a = active (az aktív állapot)        — a blanket belülről kifelé
b = (s, a)                            — a blanket = (s, a)
```

## 4. A projektben

### 4.1 A Stoßzahlansatz a K(E₉)-ben

```
K(E₉) bazis:
  X_n = (1/2)(tⁿ + t⁻ⁿ) ⊗ X    — a valós rész (belső, μ = posterior)
  Y_n = (1/2)(tⁿ - t⁻ⁿ) ⊗ Y    — a képzetes rész (külső, η = rejtett)
```

A Stoßzahlansatz:
- `tⁿ` = a korrelálatlan rész (belső, független)
- `t⁻ⁿ` = a korrelált rész (külső, függő)
- `ω` = a határ (a blanket)

### 4.2 A H-tétel a K(E₉)-ben

```
H-tétel: dH/dt ≤ 0    — az entrópia monoton nő
K(E₉):   X_n konvergál (belső, stabil)
         Y_n eltűnik (külső, marginálódik)
```

A H-tétel = a `X_n` konvergenciája = a belső állapotok stabilizálódnak.

### 4.3 A CPT-törés

```
Stoßzahlansatz: f₂ = f₁ · f₁    — korrelálatlan (entrópia nő, idő előre)
CPT T-része: időfordítás        — korrelált (entrópia csökken, idő vissza)
```

A CPT-törés = a Stoßzahlansatz sérülése = a Markov blanket.

## 5. A források

- Boltzmann (1872): Weitere Studien über das Wärmegleichgewicht, Wiener Berichte
- Ehrenfest P.-T. (1911): Begriffliche Grundlagen der statistischen Auffassung, Encyklopädie
- Friston K. (2010): The free-energy principle, Nature Reviews Neuroscience 11:127-138
- Kirchhoff M., Parr T., Palacios E., Friston K., Kiverstein J. (2018): Markov blankets of life, J. Royal Society Interface 15:20170792
- Kleinschmidt A., Nicolai H. (2021): K(E₉) representations, arXiv:2107.02445