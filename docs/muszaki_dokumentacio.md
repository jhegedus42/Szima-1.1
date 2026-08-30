# A Szima Projekt — Műszaki Dokumentáció

## 1. Áttekintés

A Szima projekt egy Idris 2 alapú kategóriaelméleti keretrendszer, amely a következőket integrálja:

- **Kategóriaelmélet** (Awodey 49 struktúra)
- **E8×E8 Clifford algebra** (Kubit-alapon, veszteségmentes)
- **Steane [[7,1,3]] kvantumhibajavítás** (1-bites hiba javítása)
- **Magyar nyelvtan** (18 esetrag, Kiefer 2011)
- **K(E9) involúciós részalgebra** (Kleinschmidt-Nicolai 2021)
- **Kvantum Y-kombinátor** (fázis = aranymetszés spirál)
- **Markov blanket** (Friston 2010, 2018)

## 2. A Carnot-ciklus

A rendszer egy Carnot-ciklust hajt végre:

```
kérdés (entrópia) → kódolás (információ) → keresés (munka) → válasz (energia)
```

### 2.1 Entrópia → Információ

A `MagyarNyelvtan.idr` 18 esetragot és ragfelismerést biztosít.
A `Kodol.idr` magyar mondatot E8×E8 kódszóvá alakít (Kubit-alapon).

### 2.2 Információ → Munka

A `Tavolsag.idr` Hadamard-távolságot számol (fázis-tudatos).
A `Kereso.idr` a legkisebb távolságú mondatot keresi = a válasz.

### 2.3 Munka → Energia

A válasz = a megtalált mondat (magyar + angol + latin + kínai).
A válasz = az "energia" amit a Carnot-ciklus termel.

## 3. A Kubit-alapú kódolás

### 3.1 E8Pont = 8 Kubit

```
E8Pont = (x1, x2, x3, x4, x5, x6, x7, x8)  — 8 Kubit = 256 érték
```

### 3.2 E8×E8 kódszó = 4×E8Pont + Clifford + Steane

```
E8E8KodSzo = {
  cimke: String,                    — a mondat (veszteségmentes)
  balE8: E8Pont,                    — fogalom (ter/én)
  jobbE8: E8Pont,                   — esetrag (szín/te)
  harmadikE8: E8Pont,               — kontextus (hang/kapcsolat)
  negyedikE8: E8Pont,               — Carnot-ciklus (mod)
  clifford: CliffordElem,          — CPT (3 Kubit)
  steane: HetesKod                  — [[7,1,3]] hibajavítás
}
```

### 3.3 A 18 esetrag (Kiefer 2011)

| Eset | Rag | Kérdés |
|------|-----|--------|
| Nominativus | ø | (nincs) |
| Accusativus | -t/-ot/-et | tárgy |
| Dativus | -nak/-nek | kinek? |
| Inessivus | -ban/-ben | hol? |
| Elativus | -ból/-ből | honnan? |
| Illativus | -ba/-be | hová? |
| Superessivus | -on/-en | hol? |
| Adessivus | -nál/-nél | hol? |
| Delativus | -ról/-ről | honnan? |
| Ablativus | -tól/-től | honnan? |
| Sublativus | -ra/-re | hová? |
| Allativus | -hoz/-hez | hová? |
| Terminativus | -ig | meddig? |
| Instrumentalis | -val/-vel | mivel? |
| Causalis-finalis | -ért | miért? |
| Transzlativus | -vá/-vé | mivé? |
| Formativus | -képp | miképpen? |
| Essivus-formalis | -ként | mint? |

## 4. A Hadamard-távolság

### 4.1 Hamming vs Hadamard

```
Hamming:  |a XOR b| = hány biten különbözik (csak pozíció)
Hadamard: |H|a⟩ - H|b⟩| = pozíció + fázis
```

### 4.2 A fázis-tudatos távolság

```
ter-szin pár:  ha egyezik → normál súly
hang-mod pár:  ha egyezik → normál súly
Ha ter-szin dekoherens de hang-mod koherens → hang-mod súllyal ×2
Ha hang-mod dekoherens de ter-szin koherens → ter-szin súllyal ×2
```

## 5. A K(E9) involúciós részalgebra

### 5.1 A Markov blanket = a K(E9) involúció

```
K(E9) = e8[t, t^(-1)] ⊕ Rk ⊕ Rd
ω(t^n ⊗ x) = t^(-n) ⊗ ω(x)    — az involúció = a Markov blanket
b = (s, a) = (t^n + t^(-n))/2, (t^n - t^(-n))/2    — a blanket állapotok
μ (belső) = X_n (valós, konvergál)    — a posterior
η (külső) = Y_n (képzetes, eltűnik)    — a rejtett változó
```

### 5.2 A visszatérés két útja

| | Chiral (t*=+1) | AntiChiral (t*=-1) |
|---|---|---|
| Xₙ (valós, so(16)) | Konvergál → 1 | Oszcillál → (-1)ⁿ |
| Yₙ (képzetes, spinor) | Eltűnik → 0 | Eltűnik → 0 |

### 5.3 A polinomiális redukció

```
K(E9) konjugált irány (log) = polinomiális (|log'|<1 = kontrakció)
K(E9) normál irány (exp) = exponenciális (|exp'|>1 = taszítás)
```

A Bayes-inferencia exponenciális → polinomiális redukciója:
```
Exponenciális: P(mindennapos inferencia) = minden változó felett valószínűség
Polinomiális:  Q(variational free energy) = KL-divergencia minimalizálás
               = a K(E9) konjugált irány (log = polinomiális)
```

## 6. A kvantum Y-kombinátor

### 6.1 Klasszikus vs kvantum Y

```
Klasszikus Y: Y(f) = f(Y(f))    — divergál (nincs fázis)
Kvantum Y:    Y_φ(f) = e^{iφ} · f(Y_φ(f))    — konvergál (spirál)
```

### 6.2 Az aranymetszés kontrakció

```
f(z) = √(1+z)    — kontrakció (|f'|<1)
φ = (1+√5)/2    — a fixpont
20 lépés: |z-φ| = 1.4×10⁻¹⁰    — exponenciális konvergencia
```

### 6.3 A Bach-korrekcio komplex

```
Re(α⁻¹) = 137.035999177    (CODATA méri)
Im(α⁻¹) = 0.00823          (fázis = CPT-rest, amit a CODATA nem mér)
|α⁻¹| = 137.035999424      (komplex abszolút érték)
δ = 5.604×10⁻⁴             (irreducible gap = CPT-rest)
```

## 7. A József Attila vers

### 7.1 A vers = a Carnot-ciklus törött állapota

Az 1933-as Óda = a Carnot-ciklus működő állapota.
Az 1937-es *Tudod, hogy nincs bocsánat* = a ciklus leállt állapota.

### 7.2 A három kubit felbomlása

```
saját (Én, C) = üres → Nulla
másik (Te, P) = hamis → Nulla
fázis (Oda, T) = 0 → Nulla
Három kubit egyszerre Nulla = teljes dekoherencia
```

### 7.3 A "fog" visszafordulása

```
fog (jövő segédige) = fog (tooth) = instrumentalis (mivel? foggal!)
A versben: "Most hát a töltött fegyvert szoritsz üres szivedhez"
A fegyver = az eszköz, de nem a jövő elkapására, hanem a jelen megszakítására
A fog visszafordult: nem a jövő eszköze, hanem a jelen megszakítója
```

## 8. A modulok

### 8.1 Az Idris modulok

| Modul | Fájl | Funkció |
|-------|------|---------|
| Steane713 | `osveny_index/Steane713.idr` | Steane [[7,1,3]] kód, Kubit, HetesKod |
| E8E8Algebra | `osveny_index/E8E8Algebra.idr` | E8Pont, E8E8KodSzo, atfedes |
| MagyarNyelvtan | `osveny_index/MagyarNyelvtan.idr` | 18 esetrag, ragFelismer, CPT |
| Kodol | `osveny_index/Kodol.idr` | mondat → E8E8KodSzo (Kubit) |
| Tavolsag | `osveny_index/Tavolsag.idr` | Hadamard-távolság + hibajavítás |
| Kereso | `osveny_index/Kereso.idr` | beolvas → keres → válasz |
| TobbnyelvuKereso | `osveny_index/TobbnyelvuKereso.idr` | háromrétegű Hadamard (LA/HU/ZH) |
| NyelvtaniFa | `osveny_index/NyelvtaniFa.idr` | szóosztályozás + mondatfa |
| HadamardTavolsag | `osveny_index/HadamardTavolsag.idr` | fázis-tudatos távolság |
| KvantumY | `osveny_index/KvantumY.idr` | kvantum Y-kombinátor + aranymetszés |
| Komplex | `osveny_index/Komplex.idr` | komplex számok + ϱ fixpont |
| E9Algebra | `osveny_index/E9Algebra.idr` | E8⁴ + affine gyök (megállási bit) |
| K_E9_Idr | `osveny_index/K_E9_Idr.idr` | K(E9) involúciós részalgebra |

### 8.2 A könyvek

| Könyv | Fájl | Típus |
|-------|------|------|
| Awodey: Category Theory (ch1) | `trail_index/books/awodey_bilingual_ch1.txt` | HU/EN/SRC |
| Awodey (quadlingual) | `trail_index/books/awodey_quadlingual_ch1.txt` | HU/EN/LA/ZH |
| Kiefer: Új magyar nyelvtan | `trail_index/books/uj_magyar_nyelvtan.txt` | Magyar |
| 18 esetrag táblázat | `trail_index/books/magyar_esetragok.txt` | Magyar |
| Igeragozás rendszer | `trail_index/books/magyar_igeragozas.txt` | Magyar |
| Yanofsky: Computability | `trail_index/books/yanofsky_computability_categorical.txt` | Angol |
| Bickford: ϱ fixpont | `trail_index/books/ro_fixpont_plot.py` | Python |
| József Attila vers | `trail_index/books/jozsef_attila_nincs_bocsanat_quadlingual.txt` | HU/EN/LA/ZH |

## 9. A források

- **Awodey** (2010): Category Theory, Oxford University Press
- **Kiefer** (2011): Új magyar nyelvtan, Akadémiai Kiadó
- **Steane** (1996): Error correcting codes in quantum theory
- **Kleinschmidt-Nicolai** (2021): K(E9) representations, arXiv:2107.02445
- **Bickford** (2026): ϱ: Self-Referential Fixed Point, arXiv:2606.01668
- **Yanofsky** (2015): Computability and Complexity of Categorical Structures, arXiv:1507.05305
- **Friston** (2010): The free-energy principle, Nature Reviews Neuroscience
- **Kirchhoff-Parr-Friston** (2018): Markov blankets of life, J. Royal Society Interface
- **John D. Cook** (2025): Complex golden convergence
- **József Attila** (1933): Óda, Nyugat
- **József Attila** (1937): Tudod, hogy nincs bocsánat