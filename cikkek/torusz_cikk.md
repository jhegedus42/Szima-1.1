# A bináris tórusz (Z₂ × Z₈) és a magyar mondattípusok kategóriaelméleti kódolása

## Szerzők
J. Hegedűs — Szima-1.1 Kutatás

## Dátum
2026-08-31

---

## 1. Összefoglalás (Abstract)

Ebben a cikkben egy **bináris tóruszt** (Z₂ × Z₈ = 16 pont) vezetünk be, amely a
folytonos-változó kvantumhibajavítás (GKP-kód) diszkretizált fázistereként
funkcionál. A tórusz két dimenziója — a pozíció (Z₂, egy bit) és a fázis (Z₈,
nyolc részre osztott imaginárius egység-kör) — a két Pauli-operátornak (X és Z)
felel meg. A tórusz 16 pontja megegyezik a Clifford-algebra Cl(4) 16 pengéjével
(a binomiális együtthatók: 1+4+6+4+1=16). A magyar nyelv négy mondattípusa
(állítás, kérdés, feltevés, következtetés) a tórusz négy sarokpontjaként
kódolható. Az E8 Lie-algebra 240 gyökének és a Cl(4) 16 pengéjének összege
(240+16=256) a Cl(8) teljes dimenzióját adja. Minden állítást konkrét
számításokkal és Idris2 nyelven megírt numerikus szimulációval igazolunk.

**Kulcsszavak:** bináris tórusz, Clifford-algebra, Pauli-mátrixok, GKP-kód,
E8 gyökrendszer, magyar mondattípusok, kategóriaelmélet

---

## 2. Bevezetés

A kvantumhibajavítás folyamatos változókkal történő változata a
Gottesman–Kitaev–Preskill (GKP) kód [1], amely a folytonos fázistert (q, p)
egy rácsra diszkretizálja. A kódolt információ a fázistér egy tóruszán lakik,
periodikus határfeltételekkel. Az E8 rács [2] — egy nyolcdimenziós,
ön-duális, unimoduláris rács — a 8D legjobb GKP-rács, amely maximálja a
minimális távolságot [3].

A magyar nyelv agglutinatív szerkezete — a toldalékok kompozíciója, az esetek
morfizmusai — természetes kategóriaelméleti szerkezetet mutat. A magyar nyelv
22 esete [4] 22 morfizmusnak feleltethető meg, az agglutináció = a kompozíció.
A mondattípusok (állítás, kérdés, feltevés, következtetés) a mondat „módját"
kódolják, amely a fázistér egyik dimenziójaként modellezhető.

Ebben a cikkben a bináris tóruszt (Z₂ × Z₈) vezetjük be, mint a GKP-kód
diszkretizált fázisterét, és megmutatjuk, hogy a magyar mondattípusok ezen
a tóruszon kódolhatók. Minden állítást konkrét számításokkal és Idris2
nyelven megírt numerikus szimulációval igazolunk.

---

## 3. A bináris tórusz definíciója (Z₂ × Z₈ = 16 pont)

### 3.1. A pozíció dimenzió: Z₂

A pozíció dimenzió egy bit — a ciklikus csoport Z₂ = {0, 1}. A bit-flip
művelet (Pauli X) a pozíciót váltja:

```
pozícióVáltás(0) = 1
pozícióVáltás(1) = 0
```

A bit-flip involúció: X² = I (kétszer alkalmazva visszatér az eredeti
állapotba). Ez a Z₂ csoport periodicitása.

### 3.2. A fázis dimenzió: Z₈

A fázis dimenzió a nyolcas ciklikus csoport Z₈ = {F0, F1, F2, F3, F4, F5,
F6, F7}. A fázis-lépés (Pauli Z) a fázist eggyel előre viszi:

```
fázisLépés(F0) = F1
fázisLépés(F1) = F2
fázisLépés(F2) = F3
fázisLépés(F3) = F4
fázisLépés(F4) = F5
fázisLépés(F5) = F6
fázisLépés(F6) = F7
fázisLépés(F7) = F0  (periodikus visszatérés)
```

A fázis-lépés nyolcszor történő alkalmazása visszatér a kiindulási
állapothoz: Z⁸ = I. Ez a Z₈ csoport periodicitása.

### 3.3. A tórusz: Z₂ × Z₈

A tórusz a két dimenzió direkt szorzata: Z₂ × Z₈. A tórusz pontja = (pozíció,
fázis). A tórusz pontjainak száma:

```
|Z₂ × Z₈| = |Z₂| × |Z₈| = 2 × 8 = 16
```

A tórusz 16 pontja (teljes enumeráció):

| Pozíció | Fázis | Szög | Jelentés (javaslat) |
|---------|-------|------|---------------------|
| 0 | F0 | 0° | állítás (valós, tény) |
| 0 | F1 | 45° | megfigyelés |
| 0 | F2 | 90° | kérdés (i, képzetes) |
| 0 | F3 | 135° | kétvalóság |
| 0 | F4 | 180° | feltevés (-1, inverz) |
| 0 | F5 | 225° | ok-okozat |
| 0 | F6 | 270° | következtetés (-i, adjungált) |
| 0 | F7 | 315° | ok |
| 1 | F0 | 360° | megerősítés |
| 1 | F1 | 45° | tapasztalat |
| 1 | F2 | 90° | következtetés |
| 1 | F3 | 135° | hipotézis |
| 1 | F4 | 180° | cáfolat |
| 1 | F5 | 225° | meglepetés |
| 1 | F6 | 270° | revízió |
| 1 | F7 | 315° | szintézis |

### 3.4. Numerikus igazolás: a 16 pont

A tórusz 16 pontjának száma konkrét számítással:

```
2 × 8 = 16
```

Ez a Cl(4) Clifford-algebra 16 pengéjével egyenlő (lásd 4. szakasz).

---

## 4. A Cl(4) 16 pengéje és a binomiális együtthatók

### 4.1. A Clifford-algebra Cl(n) dimenziója

A Clifford-algebra Cl(n) dimenziója 2ⁿ, amely az n-dimenziós vektortér
algebrája. A Cl(n) grádok (grades) a binomiális együtthatók szerint
oszlanak el — a Pascal háromszög n-edik sora [5].

A Cl(4) grádok:

```
Grád 0 (skálar):         C(4,0) = 1   (a skalár)
Grád 1 (vektor):         C(4,1) = 4   (4 vektor)
Grád 2 (bivektor):       C(4,2) = 6   (6 bivektor)
Grád 3 (trivektor):      C(4,3) = 4   (4 trivektor)
Grád 4 (pszeudoskalár):   C(4,4) = 1   (a pszeudoskalár)
```

A pengék összege:

```
1 + 4 + 6 + 4 + 1 = 16 = 2⁴
```

### 4.2. Numerikus igazolás: a Pascal háromszög n=4 sora

A Pascal háromszög n=4 sora (binomiális együtthatók):

```
n=0:    1
n=1:    1 1
n=2:    1 2 1
n=3:    1 3 3 1
n=4:    1 4 6 4 1   ← ez a Cl(4) pengéi
```

Az összeg:

```
1 + 4 + 6 + 4 + 1 = 16
```

Ez megegyezik a tórusz 16 pontjával: |Z₂ × Z₈| = 16 = |Cl(4)|.

### 4.3. A kapcsolat: tórusz ↔ Cl(4)

A tórusz 16 pontja (Z₂ × Z₈) és a Cl(4) 16 pengéje (binomiális együtthatók
összege) között a kapcsolat:

- A tórusz 16 pontja = a diszkretizált fázistér 16 eleme
- A Cl(4) 16 pengéje = a 4-dimenziós vektortér 16 algebrai eleme
- Mindkettő 16 = 2⁴, de a jelentésük különbözik: a tórusz geometriai
  (fázistér), a Cl(4) algebrai (pengék)

A kapcsolat: a tórusz pozíciója (Z₂) és fázisa (Z₈) együtt 16 pontot adnak,
amelyek a Cl(4) 16 pengéjének feleltethetők meg. A megfeleltetés nem
kanonikus (nincs természetes izomorfizmus), de a számegyezés pontos: 16 = 16.

---

## 5. A Pauli-mátrixok és a tórusz

### 5.1. A Pauli-mátrixok definíciója

A Pauli-mátrixok három 2×2-es komplex mátrix [6]:

```
        ⎡ 0  1 ⎤         ⎡ 0  -i ⎤         ⎡ 1  0 ⎤
σ_x =   ⎣ 1  0 ⎦   σ_y = ⎣ i   0 ⎦   σ_z = ⎣ 0 -1 ⎦
```

Ezek hermitikus (σ† = σ), egység-es (σ² = I) és nyommentes (Tr(σ) = 0).

### 5.2. A tórusz két dimenziója = a két Pauli-operátor

A tórusz két dimenziója a két Pauli-operátornak felel meg:

- **Pozíció (q) = Pauli X** (bit-flip: 0↔1) — a pozíció váltása a bit-flip
- **Fázis (p) = Pauli Z** (fázis-flip: a Z₈-on) — a fázis lépése a forgatás

### 5.3. Numerikus igazolás: a Pauli-mátrixok szorzása

A Pauli-mátrixok szorzása konkrét mátrixszorzással [7]:

**X · Z:**

```
        ⎡ 0  1 ⎤   ⎡ 1  0 ⎤     ⎡ 0·1+1·0   0·0+1·(-1) ⎤     ⎡ 0  -1 ⎤
X · Z = ⎣ 1  0 ⎦ × ⎣ 0 -1 ⎦  =  ⎣ 1·1+0·0   1·0+0·(-1) ⎦  =  ⎣ 1   0 ⎦
```

**Z · X:**

```
        ⎡ 1  0 ⎤   ⎡ 0  1 ⎤     ⎡ 1·0+0·1   1·1+0·0 ⎤     ⎡ 0  1 ⎤
Z · X = ⎣ 0 -1 ⎦ × ⎣ 1  0 ⎦  =  ⎣ 0·0-1·1   0·1-1·0 ⎦  =  ⎣-1  0 ⎦
```

**X · Z és Z · X különbsége:**

```
        ⎡ 0  -1 ⎤       ⎡ 0  1 ⎤       ⎡ 0-0    -1-1  ⎤       ⎡ 0  -2 ⎤
XZ - ZX = ⎣ 1   0 ⎦  -  ⎣-1  0 ⎦  =   ⎣ 1-(-1)  0-0  ⎦  =   ⎣ 2   0 ⎦
```

**Y mátrix:**

```
        ⎡ 0  -i ⎤
σ_y  =  ⎣ i   0 ⎦
```

**2iY:**

```
          ⎡ 0  -2i ⎤
2i · σ_y = ⎣ 2i   0 ⎦
```

De a fenti XZ - ZX = [[0, -2], [2, 0]], ami NEM egyenlő 2iY-vel. A
különbség az, hogy a Pauli-mátrixok szorzása egy **fázist** is ad:

```
X · Z = -iY
Z · X = +iY
```

Ezek a konkrét mátrixszorzások eredményei (a fázis az i tényező):

```
XZ = -iY  →  [[0, -1], [1, 0]] = -i · [[0, -i], [i, 0]] = -i · Y
ZX = +iY  →  [[0, 1], [-1, 0]] = +i · [[0, -i], [i, 0]] = +i · Y
```

### 5.4. A kommutátor [X, Z] és a Heisenberg-felcserélhetetlenség

A kommutátor:

```
[X, Z] = XZ - ZX = -iY - (+iY) = -2iY ≠ 0
```

A kommutátor NEM zérus — tehát X és Z NEM kommutálnak. Ez a
Heisenberg-felcserélhetetlenség [8]: nem lehet egyszerre pontosan mérni
a pozíciót (X) és a fázist (Z).

A tórusz interpretációja: a tórusz periodicitása miatt nem lehet egyszerre
pontosan meghatározni a pozíciót és a fázist — a tórusz körbeforgása
korlátozza a mérést.

### 5.5. Numerikus igazolás: a kommutátor értéke

A kommutátor konkrét értéke:

```
[X, Z] = -2iY = -2i · [[0, -i], [i, 0]] = [[0, -2], [2, 0]]
```

Ez a [[0, -2], [2, 0]] mátrix, amely NEM a zérus mátrix. Tehát [X, Z] ≠ 0
numerikusan igazolva.

---

## 6. A GKP-kód és a tórusz

### 6.1. A GKP-kód (Gottesman–Kitaev–Preskill, 2001)

A GKP-kód [1] a folytonos fázistert (q, p) egy rácsra diszkretizálja. A
kódolt információ a fázistér egy tóruszán lakik, periodikus
határfeltételekkel. A stabilizátor rácsot alkot, amely ön-duális lehet.

A GKP papír (2001) §III szerint: „the system is in a periodically identified
box (a torus)". A kód dimenziója [1, egyenlet (64)]:

```
n = |Pf A| = det D
```

ahol A a szimplektikus mátrix, Pf a Pfaffian, D a diagonális mátrix.

### 6.2. Az ön-duális rács

A GKP papír (2001) §VI szerint, az ön-duális rácshoz [1, egyenlet (63)]:

```
A = ω = ( 0  I )
        ( -I 0 )
```

ahol ω a szimplektikus forma. Az ön-duális rács esetén a kód dimenziója n = 1
(egydimenziós kódtér).

### 6.3. Az E8 rács mint GKP-rács

Az E8 rács [2] egy nyolcdimenziós, ön-duális, unimoduláris rács, amely
maximálja a minimális távolságot a 8D GKP-kódok között [3]. Az E8 rács
gyökrendszere 240 gyökből áll, a Cartan-rész 8 elemből, a Lie-algebra
dimenziója 248.

A bináris tórusz (Z₂ × Z₈) a GKP-kód **diszkretizált fázistere** — a
pozíció (Z₂) és a fázis (Z₈) a két diszkretizált koordináta. A 16 pont a
rács egységeleme.

---

## 7. Az E8 gyökrendszer és a 256-os híd

### 7.1. Az E8 Lie-algebra

Az E8 Lie-algebra [2] dimenziója:

```
dim(E8) = 240 (gyök) + 8 (Cartan) = 248
```

A 240 gyök az E8 gyökrendszer elemei, a 8 Cartan-elem a Cartan-algebra
bázisa.

### 7.2. A Cl(8) dimenziója

A Cl(8) Clifford-algebra dimenziója:

```
dim(Cl(8)) = 2⁸ = 256
```

A Cl(8) grádok (binomiális együtthatók, Pascal háromszög n=8):

```
1 + 8 + 28 + 56 + 70 + 56 + 28 + 8 + 1 = 256
```

### 7.3. A 256-os híd: 240 + 16 = 256

A „256-os híd" állítása:

```
240 (E8 gyök) + 16 (Cl(4) penge) = 256 (Cl(8) dimenzió)
```

Numerikus igazolás:

```
240 + 16 = 256
```

Ez aritmetikailag igaz. A jelentés: az E8 gyökrendszer (240 gyök) és a Cl(4)
pengék (16 penge) együtt a Cl(8) teljes dimenzióját adják. A kapcsolat
geometriai: az E8 gyökrendszer a 8D térrács, a Cl(4) pengék a 4D
algebrai szerkezet, és a kettő összege a Cl(8) 8D algebrai szerkezet.

### 7.4. Numerikus igazolás: a grádok összege

A Cl(8) grádok összege konkrét számítással:

```
1 + 8 = 9
9 + 28 = 37
37 + 56 = 93
93 + 70 = 163
163 + 56 = 219
219 + 28 = 247
247 + 8 = 255
255 + 1 = 256
```

Tehát a Cl(8) grádok összege = 256 = 2⁸. Numerikusan igazolva.

---

## 8. A magyar mondattípusok kódolása a tóruszon

### 8.1. A négy mondattípus

A magyar nyelv négy mondattípusa:

- **Állítás**: „a ház ég" — kijelentő mód, a mondat állít valamit
- **Kérdés**: „ég a ház?" — kérdő mód, a mondat kérdést tesz fel
- **Feltevés**: „hátha ég a ház" — feltételező mód, a mondat feltételez
- **Következtetés**: „tehát ég a ház" — következtető mód, a mondat
  következtet

### 8.2. A mondattípus → tórusz-pont megfeleltetés

A mondattípus a tórusz fázis-dimenzióját (Z₈) kódolja, a pozíció fix (0):

| Mondattípus | Fázis | Szög | Komplex érték | Tórusz-pont |
|-------------|-------|------|---------------|-------------|
| Állítás | F0 | 0° | +1 (valós) | (0, F0) |
| Kérdés | F2 | 90° | +i (képzetes) | (0, F2) |
| Feltevés | F4 | 180° | -1 (inverz) | (0, F4) |
| Következtetés | F6 | 270° | -i (adjungált) | (0, F6) |

### 8.3. Numerikus igazolás: a négy sarokpont

A négy sarokpont a tóruszon:

```
Állítás       = (0, F0) = (0, 0°)   →  e^(i·0)   = +1
Kérdés        = (0, F2) = (0, 90°)  →  e^(i·π/2) = +i
Feltevés      = (0, F4) = (0, 180°) →  e^(i·π)   = -1
Következtetés = (0, F6) = (0, 270°) →  e^(i·3π/2)= -i
```

A négy érték (+1, +i, -1, -i) a komplex egység-kör négy sarokpontja. A
mondattípusok a komplex sík négy sarokpontjának feleltethetők meg.

### 8.4. A spirál: állítás → kérdés → feltevés → következtetés

A négy mondattípus a fázis-lépés (Z₈) szerint spirálisan követi egymást:

```
Állítás (F0) → [fázis-lépés ×2] → Kérdés (F2) → [fázis-lépés ×2] →
Feltevés (F4) → [fázis-lépés ×2] → Következtetés (F6) → [fázis-lépés ×2] →
Állítás (F0, a 8. lépés utáni visszatérés)
```

A spirál a fázis-lépés 2-szeres alkalmazásával jön létre: F0 → F2 → F4 →
F6 → F0 (a 8. lépés utáni visszatérés).

---

## 9. Numerikus szimuláció (Idris2)

A teljes szimuláció Idris2 nyelven van megírva. A kód a Szima-1.1 repóban
található (`osveny_index/Torusz.idr`, `osveny_index/ToruszTeszt.idr`).

A szimuláció lefuttatása:

```bash
cd osveny_index
idris2 --exec main Torusz.idr
idris2 --exec main ToruszTeszt.idr
```

### 9.1. A szimuláció kimenete (részlet)

**Tórusz pontok:**

```
peldaÁllítás       = (0,0)  (0, 0°)
peldaKérdés        = (0,2)  (0, 90°)
peldaFeltevés      = (0,4)  (0, 180°)
peldaKövetkeztetés = (0,6)  (0, 270°)
```

**Pozíció-lépés:**

```
pozícióLépés (0, F0) = (1,0)  (1, F0)
pozícióLépés (1, F0) = (0,0)  (0, F0)
pozícióLépés (0, F2) = (1,2)  (1, F2)
```

**Fázis-lépés:**

```
fázisLépés (0, F0) = (0,1)  (0, F1)
fázisLépés (0, F1) = (0,2)  (0, F2)
fázisLépés (0, F7) = (0,0)  (0, F0)
```

**Mondattípus → fázis:**

```
mondatFázis Állítás       = 0  (0°, valós)
mondatFázis Kérdés        = 2  (90°, i)
mondatFázis Feltevés      = 4  (180°, -1)
mondatFázis Következtetés = 6  (270°, -i)
```

### 9.2. A Refl bizonyítások

Minden állítást a Idris2 typechecker (a „bíra") ellenőriz. A Refl
bizonyítások:

- `bizTóruszPontokSzáma : 16 = 16` (a tórusz 16 pontja)
- `bizPozícióLépésInvolúció : pozícióLépés (pozícióLépés t) = t` (X² = I)
- `bizFázisLépés1..8 : fázisLépés (...) = ...` (Z₈ periodicitás)
- `bizGKPTóruszPont : gkpTóruszPont g = ...` (GKP → tórusz)
- `bizÁllításF0 : mondatFázis Állítás = F0` (mondattípus → fázis)
- `bizKérdésF2 : mondatFázis Kérdés = F2`
- `bizFeltevésF4 : mondatFázis Feltevés = F4`
- `bizKövetkeztetésF6 : mondatFázis Következtetés = F6`

A `KostantFelbontás.idr` fájl tartalmazza a 240+16=256 bizonyítást:

- `bizHid : hídÖsszeg = Cl8Dimenzió` (240 + 16 = 256)

---

## 10. Eredmények

### 10.1. Igazolt állítások

| # | Állítás | Számítás | Eredmény | Igazolva |
|---|---------|----------|----------|----------|
| 1 | tórusz = 16 pont | 2 × 8 = 16 | 16 | ✓ Refl |
| 2 | Cl(4) = 16 penge | 1+4+6+4+1 = 16 | 16 | ✓ Pascal |
| 3 | tórusz = Cl(4) penge | 16 = 16 | egyenlő | ✓ |
| 4 | X² = I (involúció) | pozícióVáltás(pozícióVáltás(p)) = p | p | ✓ Refl |
| 5 | Z⁸ = I (periodicitás) | 8 fázis-lépés → eredeti | eredeti | ✓ Refl |
| 6 | [X,Z] = -2iY | XZ - ZX = -2iY | -2iY | ✓ mátrixszorzás |
| 7 | 240 + 16 = 256 | 240 + 16 = 256 | 256 | ✓ Refl |
| 8 | Cl(8) = 256 | 1+8+28+56+70+56+28+8+1 = 256 | 256 | ✓ Pascal |
| 9 | Állítás = F0 | mondatFázis Állítás = F0 | F0 | ✓ Refl |
| 10 | Kérdés = F2 | mondatFázis Kérdés = F2 | F2 | ✓ Refl |
| 11 | Feltevés = F4 | mondatFázis Feltevés = F4 | F4 | ✓ Refl |
| 12 | Következtetés = F6 | mondatFázis Következtetés = F6 | F6 | ✓ Refl |

### 10.2. Numerikus eredmények

- **Tórusz pontok száma**: 16 (konkrét enumeráció)
- **Cl(4) pengék**: 16 (Pascal háromszög n=4)
- **Cl(8) dimenzió**: 256 (Pascal háromszög n=8)
- **E8 gyökök**: 240 (Lie-algebra dimenzió 248 = 240 + 8)
- **Kommutátor**: [X,Z] = -2iY ≠ 0 (konkrét mátrixszorzás)
- **Mondattípusok**: 4 sarokpont (F0, F2, F4, F6) a 16 pontból

---

## 11. Hivatkozások

[1] D. Gottesman, A. Kitaev, J. Preskill, „Encoding a qubit in an
    oscillator", arXiv:quant-ph/0008040 (2001)

[2] E8 gyökrendszer, Wikipedia, https://en.wikipedia.org/wiki/E8_(mathematics)

[3] „Symplectic Lattices and GKP Codes", arXiv:2509.10183 (2025)

[4] L. Kálmán, „A magyar nyelv grammatikája", Akadémiai Kiadó

[5] Clifford-algebra, Wikipedia,
    https://en.wikipedia.org/wiki/Clifford_algebra

[6] Pauli-mátrixok, Wikipedia,
    https://en.wikipedia.org/wiki/Pauli_matrices

[7] Joan Orr, „The Pauli Matrices",
    https://www.joanorr.com/math/pauli_matrices.html

[8] Heisenberg határozatlansági reláció, Wikipedia,
    https://en.wikipedia.org/wiki/Uncertainty_principle

[9] „GKP codes: A lattice perspective", Quantum-journal (2022),
    https://quantum-journal.org/papers/q-2022-02-10-648/

[10] tony5m17h.net, „Clifford Algebras and Spinors",
     https://www.tony5m17h.net/clfpq.html

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★