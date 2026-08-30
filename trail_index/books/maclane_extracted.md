# Mac Lane "Categories for the Working Mathematician" — Kinyerés

Forrás: `maclane_categories.txt` (18642 sor). Csak azokat a részeket tartalmazza,
amelyeket Awodey KIHAG. Minden azonosító magyar (AGENTS.md §0). Idris kulcsszavak
angolul maradnak. Rövidítés nincs.

A kinyerés formátuma megegyezik az Awodey-kinyerésével:
- **Fogalom**: a struktúra neve
- **Forras**: fejezet/paragrafus a könyvben
- **Adat**: a struktúra mezői (record fields)
- **Torveny**: az egyenletek, amelyeknek teljesülniük kell
- **Fugg**: milyen szülő-struktúrákra épül
- **Pelda**: tipikus példák a könyvből
- **Idris**: javasolt Idris 2 típus/aláírás a meglévő konvenciók szerint

---

## 1. MonoidalisKategoria (Monoidal Category)

- **Fogalom**: Monoidalis kategoria — kategória tenzorszorzattal + egységelemmel, ahol az asszociativitás és az egység csak izomorfizmusig teljesül.
- **Forras**: Ch VII §1 "Monoidal Categories" (161–164. o.), `maclane_categories.txt:9329`

### Adat (mezők)

A monoidalis kategoria `<B, ◦, e, α, λ, ρ>` mezői:

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `B` | az alap kategória | `Kategoria objektum hom` |
| `◦` | tenzor bifunktor | `Bifunktor` / `objektum -> objektum -> objektum` |
| `e` | egység objektum | `objektum` |
| `α` | asszociátor (természetes izomorfizmus) | `hom (a ◦ (b ◦ c)) ((a ◦ b) ◦ c)` |
| `λ` | bal-egység izomorfizmus | `hom (e ◦ a) a` |
| `ρ` | jobb-egység izomorfizmus | `hom (a ◦ e) a` |

A `◦` bifunktor: `(f : a→a', g : b→b') ↦ f◦g : a◦b → a'◦b'`, és teljesíti az
interchange-law-t: `(f'∘f)◦(g'∘g) = (f'◦g')∘(f◦g)`.

### Torveny (egyenletek)

**(Pentagon)** — `maclane_categories.txt:9380` (egyenlet V.1.5):
Minden `a, b, c, d`-re a következő ötszög kommutatív:
```
a◦(b◦(c◦d)) --α--> (a◦b)◦(c◦d) --α--> ((a◦b)◦c)◦d
     | α                                        ↑
     v                                          |
a◦((b◦c)◦d) --α--> (a◦(b◦c))◦d --(ρ vagy α)----+
```
Azaz: `α ◦ (α ◦ 1) = α ◦ (1 ◦ α)` mint természetes transzformáció.

**(Háromszög / Triangle)** — `maclane_categories.txt:9400` (egyenlet V.1.7):
Minden `a, c`-re:
```
a◦(e◦c) --(1◦λ)--> a◦c
   | α                 ↑
   v                   |
(a◦e)◦c --(ρ◦1)-------+
```
Azaz: `α ∘ (1◦λ) = ρ◦1`.

### Fugg (szülő-struktúrák)

- `Kategoria` (objektum + morfizmus + kompozíció + azonos)
- `Bifunktor` (◦-hoz)

### Pelda

- `<Ab, ⊗, Z, α, λ, ρ>` — abel csoportok tenzorszorzattal
- `<K-Mod, ⊗_K, K, ...>` — modulok gyűrű felett
- Bármely véges szorzattal rendelkező kategória: `◦ = ×`, `e = 1` (terminális)
- Bármely véges koproduktummal rendelkező kategória: `◦ = ⊔`, `e = 0` (initiális)

### Idris

```idris
public export
record MonoidalisKategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor MonoidalisKategoriaKonstruktor
  kategoria    : Kategoria objektum hom
  tenzor       : objektum -> objektum -> objektum
  egyseg       : objektum
  asszociator  : {a, b, c : objektum} -> hom (tenzor a (tenzor b c)) (tenzor (tenzor a b) c)
  balEgyseg    : {a : objektum} -> hom (tenzor egyseg a) a
  jobbEgyseg   : {a : objektum} -> hom (tenzor a egyseg) a
```

A típusosztály-változat (törvényekkel, lásd `KategoriaElmelet.idr:27` minta):
```idris
public export
interface KategoriaT objektum hom => MonoidalisT objektum hom where
  tenzor  : objektum -> objektum -> objektum
  egyseg  : objektum
  asszociator : {a, b, c : objektum}
              -> hom (tenzor a (tenzor b c)) (tenzor (tenzor a b) c)
  balEgyseg  : {a : objektum} -> hom (tenzor egyseg a) a
  jobbEgyseg : {a : objektum} -> hom (tenzor a egyseg) a
  -- Pentagon: α ◦ (α◦1) = α ◦ (1◦α)
  pentagonTorveny : {a, b, c, d : objektum} -> ...
  -- Háromszög: α ∘ (1◦λ) = ρ◦1
  haromszogTorveny : {a, c : objektum} -> ...
```

---

## 2. BraidedMonoidalisKategoria (Braided Monoidal Category)

- **Fogalom**: Monoidalis kategoria + "braiding" — természetes izomorfizmus `γ_{a,b}: a◦b → b◦a`, amely NEM feltétlenül involutív. A felcserélés két irányú (mint fonatok).
- **Forras**: Ch XI §1 "Symmetric Monoidal Categories" (bevezetés a braiding-hez), `maclane_categories.txt:14361`, `maclane_categories.txt:14420`

### Adat (mezők)

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `monoidalis` | az alap monoidalis kategoria | `MonoidalisKategoria objektum hom` |
| `γ` (braiding) | felcserélő izomorfizmus | `hom (a ◦ b) (b ◦ a)` |

`γ` természetes `a`-ban és `b`-ben.

### Torveny (egyenletek)

**(Egység-kommutativitás)** — `maclane_categories.txt:14426` (egyenlet V.11.6):
`γ_{e,a}` kommutál az egység izomorfizmusaival.

**(Két hatszög / Hexagon)** — `maclane_categories.txt:14433` (egyenlet V.11.7):
```
           1◦γ
a◦(b◦c) --------> b◦(a◦c)
   | α                | α
   v                  v
(a◦b)◦c --γ◦1--> (b◦a)◦c --α--> b◦(a◦c) ...  (első hatszög)
```
Második hatszög (a termék mint MÁSODIK index):
```
(a◦b)◦c --1◦γ--> (a◦c)◦b --α--> a◦(c◦b) ...  (második hatszög)
```
Azaz a hatszög felbontja `γ_{a,bc}`-t két egyindexű `γ`-re.

**Megjegyzés**: Ha `γ` braiding, akkor `γ⁻¹` is braiding (az első hatszög a
második `γ⁻¹`-re, és viszont).

### Yang–Baxter egyenlet

A fonatcsoport generátorai `σ_i` (i. fonat az (i+1). alatt) kielégítik
(`maclane_categories.txt:14988`, egyenlet V.11.2):
```
σ_i σ_{i+1} σ_i = σ_{i+1} σ_i σ_{i+1}     (Yang–Baxter / fonat-reláció)
σ_i σ_j = σ_j σ_i     ha |i − j| > 1      (távoli fonatok közlekednek)
```
Ez a Yang–Baxter egyenlet. A hatszög-axióma PONTOSAN a `σ_i σ_{i+1} σ_i` relációt
kódolja le a braiding `γ` segítségével.

### Fugg

- `MonoidalisKategoria` (tenzor + egység + α + λ + ρ)

### Pelda

- A fonatkategória `B` (Braid category): objektumok `n ∈ ℕ`, nyilak = fonatok,
  `◦ = +` (szigorúan asszociatív), `γ_{m,n}` = m fonát keresztez n fonáttal.
  Ez NEM szimmetrikus (`γ² ≠ 1`).
- Kvantumcsoport reprezentációk kategóriája (típusos példa).

### Idris

```idris
public export
record BraidedMonoidalisKategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor BraidedKonstruktor
  monoidalis : MonoidalisKategoria objektum hom
  braiding   : {a, b : objektum}
             -> hom (monoidalis.tenzor a b) (monoidalis.tenzor b a)
```

---

## 3. SzimmetrikusMonoidalisKategoria (Symmetric Monoidal Category)

- **Fogalom**: Braided monoidalis kategoria, ahol a braiding INVOLUTÍV: `γ² = id`.
- **Forras**: Ch XI §1, `maclane_categories.txt:14498`

### Adat (mezők)

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `braided` | az alap braided kategoria | `BraidedMonoidalisKategoria objektum hom` |

### Torveny (egyenletek)

**(Involúció)** — `maclane_categories.txt:14500` (egyenlet V.11.8):
Minden `a, b`-re:
```
γ_{a,b} ∘ γ_{b,a} = id_{a◦b}
```
Azaz `γ² = 1`. Ekkor a két hatszög közül bármelyik implikálja a másikat.

### Fugg

- `BraidedMonoidalisKategoria` (braiding + hatszög)
- közvetve: `MonoidalisKategoria`

### Pelda

- `<Set, ×, 1>` — `γ` = kanonikus szorzat-felcserélő izomorfizmus
- `<Ab, ⊗, Z>` — tenzorszorzat szimmetrikus
- Bármely véges szorzattal/koproduktummal rendelkező kategória automatikusan szimmetrikus

### Idris

```idris
public export
interface BraidedMonoidalisT objektum hom => SzimmetrikusMonoidalisT objektum hom where
  braidingInvolucio : {a, b : objektum}
                    -> kompozicio (braiding {a} {b}) (braiding {b} {a}) = identitas (tenzor a b)
```

---

## 4. ZartKategoria (Closed Category / Monoidal Closed)

- **Fogalom**: Szimmetrikus monoidalis kategoria `V`, ahol minden `- ◦ b : V → V`
  funktornak van megadott jobb adjungáltja `( )^b : V → V` — a "belső hom".
- **Forras**: Ch VII §7 "Closed Categories", `maclane_categories.txt:10671`

### Adat (mezők)

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `szimmetrikus` | az alap szimmetrikus monoidalis kategoria | `SzimmetrikusMonoidalisKategoria objektum hom` |
| `belsőHom` | belső hom funktor `( )^b` | `objektum -> objektum -> objektum` |
| `adjunkcio` | a `-◦b ⊣ ( )^b` adjunkció | `Adjunkcio ...` |

### Torveny (egyenletek)

**(Belső hom adjunkció)** — `maclane_categories.txt:10672`:
Minden `a, b, c`-re természetes bijekció:
```
V(a ◦ b, c) ≅ V(a, c^b)
```
Ez megegyezik a Descartes-zárt kategóriák adjunkciójával (`Set(X×Y, Z) ≅ Set(X, Z^Y)`).

### Fugg

- `SzimmetrikusMonoidalisKategoria` (tenzor + egység + braiding)
- `Adjunkcio` (a `-◦b ⊣ ( )^b` pár)

### Pelda

- `<Ab, ⊗, ...>` zárt: `A^B = hom(B, A)` (abel csoportok morfizmusainak csoportja)
- `<K-Mod, ⊗_K, ...>` zárt minden kommutatív gyűrű `K` felett
- `<Set, ×, 1>` Descartes-zárt: `Z^Y = Set(Y, Z)`
- `<Cat, ×, 1>` zárt (functor-kategóriák)

### Bővítés (enrichment)

Egy `V`-kategória (vagy `B`-kategória): "hom-objektumok" `R(r,s) ∈ V` (nem hom-
halmazok!), kompozíció `R(s,t) ◦ R(r,s) → R(r,t)` V-ben, egység `e → R(r,r)`.
A megszokott kategória csak egy `U: V → Set` funktorral nyerhető vissza
(`U = V(e, -)`). Lásd `maclane_categories.txt:10679`.

### Idris

```idris
public export
record ZartKategoria (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor ZartKategoriaKonstruktor
  szimmetrikus : SzimmetrikusMonoidalisKategoria objektum hom
  belsoHom     : objektum -> objektum -> objektum
  -- adjunkcio: -◦b  ⊣  ( )^b
  zartAdjunkcio : (b : objektum) -> Adjunkcio objektum hom objektum hom
```

---

## 5. KettoKategoria (2-Category)

- **Fogalom**: Kategória 0-sejtekkel (objektumok), 1-sejtekkel (nyilak), és
  2-sejtekkel (2-morfizmusok), ahol a 2-sejtek KÉTFÉleképpen komponálhatók:
  függőlegesen és vízszintesen, és a kettő kommutál (interchange-law).
- **Forras**: Ch XII §3 "2-Categories", `maclane_categories.txt:15614`

### Adat (mezők)

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `objektum` | 0-sejtek halmaza | `Type` |
| `hom` | 1-sejtek `a → b` | `objektum -> objektum -> Type` |
| `ketHom` | 2-sejtek `f ⇒ g` (parhuzamos 1-sejtek közt) | `(a,b) -> hom a b -> hom a b -> Type` |
| `alapKategoria` | az 1-sejtek kategóriája | `Kategoria objektum hom` |
| `fuggolegesOsszetetel` | függőleges kompozíció `•` | `α:f⇒g, β:g⇒h ↦ β•α:f⇒h` |
| `vizszintesOsszetetel` | vízszintes kompozíció `◦` | `α:f⇒g, α':f'⇒g' ↦ α'◦α:f'∘f⇒g'∘g` |
| `1_f` | függőleges identitás 2-sejt | `ketHom a b f f` |

### Torveny (egyenletek)

**(Interchange-law / Middle-four-exchange)** — `maclane_categories.txt:15792`
(egyenlet V.12.9):
Adott 2-sejtek:
```
α: f ⇒ g : a→b,   α': f' ⇒ g' : b→c
β: g ⇒ h : a→b,   β': g' ⇒ h' : b→c
```
akkor:
```
(β' • β) ◦ (α' ◦ α) = (β' ◦ α') • (β ◦ α) : f'∘f ⇒ h'∘h : a→c
```
Azaz a függőleges és vízszintes kompozíció "kicserélhető" — a középső két
argumentum felcserélődik.

**(Vízszintes identitás)** — `maclane_categories.txt:15763` (egyenlet V.12.6):
```
1_{f'} ◦ 1_f = 1_{f'∘f}
```

**(Asszociativitás mindkét irányban)**: mind a `•`, mind a `◦` asszociatív,
és mindegyiknek van egységeleme.

### Hom-kategóriák leírás

Egy 2-kategória ekvivalensen megadható (`maclane_categories.txt:15858`):
- (i) objektumok halmaza;
- (ii) minden `(a,b)` párhoz egy `T(a,b)` kategória (a "hom-kategória");
- (iii) minden `(a,b,c)`-hez egy `K_{a,b,c}: T(b,c) × T(a,b) → T(a,c)` funktor;
- (iv) minden `a`-hoz `V_a: 1 → T(a,a)` funktor.

Ez pontosan a "CAT-ben dúsított kategória" (`maclane_categories.txt:15883`).

### Fugg

- `Kategoria` (az 1-sejtek szintjén)

### Pelda

- `CAT`: 0-sejtek = kis kategóriák, 1-sejtek = funktorok, 2-sejtek = természetes transzformációk
- Topológia: 0-sejtek = terek, 1-sejtek = folytonos leképezések, 2-sejtek = homotópia-osztályok

### Idris

Már létezik a `KategoriaElmelet.idr:129`-ben:
```idris
public export
record KettoKategoria (obj : Type) (hom : obj -> obj -> Type)
                      (ketHom : (a, b : obj) -> hom a b -> hom a b -> Type) where
  constructor KettoKategoriaKonstruktor
  alapKategoria : Kategoria obj hom
  fuggolegesOsszetetel : {a, b : obj} -> {f, g, h : hom a b}
                      -> ketHom a b f g -> ketHom a b g h -> ketHom a b f h
  vizszintesOsszetetel : {a, b, c : obj} -> {f1, f2 : hom a b} -> {g1, g2 : hom b c}
                      -> ketHom a b f1 f2 -> ketHom b c g1 g2
                      -> ketHom a c (alapKategoria.osszetetel f1 g1)
                                    (alapKategoria.osszetetel f2 g2)
```
Kiegészítendő az `interchangeTorveny` mezővel.

### Adjunkció 2-kategóriában (§XII.4)

`maclane_categories.txt:15893`: két 1-sejt `f: a→b`, `g: b→a` adjungált, ha
vannak 2-sejtek `η: 1_a ⇒ g∘f` (egység) és `ε: f∘g ⇒ 1_b` (co-egység), amelyek
kielégítik a **háromszög-törvényeket**:
```
(ε ∘ 1_f) • (1_f ∘ η) = 1_f       (egyenlet V.12.2)
(1_g ∘ ε) • (η ∘ 1_g) = 1_g       (egyenlet V.12.3)
```
Ez általánosítja a szokásos adjunkció háromszög-azonosságait.

---

## 6. Bikategoria (Bicategory)

- **Fogalom**: "Gyenge 2-kategória" — a vízszintes kompozíció csak izomorfizmusig
  asszociatív, és az egység is csak izomorfizmusig teljesül. A 2-kategória szigorú
  esete, ahol az asszociátor és egység-izomorfizmusok identitások.
- **Forras**: Ch XII §6 "Bicategories", `maclane_categories.txt:16253`

### Adat (mezők)

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `0-sejt` | objektumok `a, b, ...` | `Type` |
| `1-sejt` | `f: a → b` | `objektum -> objektum -> Type` |
| `2-sejt` | `ρ: f ⇒ g` (parhuzamos 1-sejtek közt) | `(a,b) -> hom a b -> hom a b -> Type` |
| `B(a,b)` | hom-KATEGÓRIA (1-sejtek = objektumok, 2-sejtek = nyilak) | `Kategoria` |
| `*` | vízszintes kompozíció bifunktor | `B(b,c) × B(a,b) → B(a,c)` |
| `1_a` | egység 1-sejt (csak izomorfizmusig egység!) | `hom a a` |
| `α` | asszociátor (természetes izomorfizmus) | `(h*g)*f ⇒ h*(g*f)` |
| `λ` | bal-egység izomorfizmus | `1_b * f ⇒ f` |
| `ρ` | jobb-egység izomorfizmus | `f * 1_a ⇒ f` |

### Torveny (egyenletek)

**(Asszociátor természetessége)** — `maclane_categories.txt:16342` (egyenlet V.12.5):
Minden 2-sejtekre a következő kommutál:
```
(h*g)*f --α--> h*(g*f)
   |               |
   | (2-sejtek)    | (2-sejtek)
   v               v
(h'*g')*f' --α--> h'*(g'*f')
```

**(Pentagon)** — `maclane_categories.txt:16372` (egyenlet V.12.7):
Minden `f, g, h, k: d→e` 1-sejtekre:
```
k*(h*(g*f)) --1*α--> k*((h*g)*f) --α--> (k*(h*g))*f
                                              |
                                     α        |
                                              v
((k*h)*g)*f <--α-- (k*(h*g))*f <--α-- (k*h)*(g*f)
```
Ugyanaz a pentagon, mint a monoidalis kategoriáé (§VII.1.5).

**(Háromszög / egység)** — `maclane_categories.txt:16386` (egyenlet V.12.8):
```
(g * 1_b) * f --α--> g * (1_b * f)
        \               /
         ρ*1           1*λ
          \           /
           v       v
            g * f
```

### Fugg

- `Kategoria` (minden `B(a,b)` hom-kategória)
- `Bifunktor` (a `*` vízszintes kompozíció)

### Kulcs-összefüggés

`maclane_categories.txt:16410`: **Egy monoidalis kategoria = egy egy-0-sejtes bikategoria.**
Az objektumok az 1-sejtek, a tenzor a `*`, és `α, λ, ρ` pontosan a bikategoria
struktúrájai. A koherencia-tétel monoidalis kategoriákra átvihető bikategoriákra is.

### Pelda

- **Monoidalis kategoria** (egy 0-sejtként)
- **Gyűrűk bikategoriája**: 0-sejtek = gyűrűk `R, S, T`; 1-sejtek = bimodulusok
  `_S A_R: R → S`; 2-sejtek = bimodulus-homomorfizmusok; `*` = `⊗_S` (tenzor
  bimodulusok felett, ami csak asszociatív izomorfizmusig).
- **Spans bikategoriája `Span(C)`**: 0-sejtek = `C` objektumai; 1-sejtek = spanok;
  vízszintes kompozíció = pullback (ami csak izomorfizmusig asszociatív).

### Idris

```idris
public export
record Bikategoria (objektum : Type) (hom : objektum -> objektum -> Type)
                   (ketHom : (a, b : objektum) -> hom a b -> hom a b -> Type) where
  constructor BikategoriaKonstruktor
  -- Minden (a,b) parhoz egy hom-kategoria (1-sejtek = obj, 2-sejtek = nyilak)
  homKategoria : (a, b : objektum) -> Kategoria (hom a b) (ketHom a b)
  -- Vizszintes kompozicio (gyenge: csak izomorfizmusig asszociativ)
  vizszintes : {a, b, c : objektum} -> hom b c -> hom a b -> hom a c
  egysegSejt : (a : objektum) -> hom a a
  -- Asszociator (2-sejt)
  asszociator : {a, b, c, d : objektum} -> {f : hom a b} -> {g : hom b c} -> {h : hom c d}
              -> ketHom a d (vizszintes (vizszintes h g) f) (vizszintes h (vizszintes g f))
  balEgysegSejt : {a, b : objektum} -> {f : hom a b}
                -> ketHom a b (vizszintes (egysegSejt b) f) f
  jobbEgysegSejt : {a, b : objektum} -> {f : hom a b}
                 -> ketHom a b (vizszintes f (egysegSejt a)) f
```

---

## 7. KoherenciaTetelek (Coherence Theorems)

Három koherencia-tétel, növekvő erővel.

### 7a. Monoidalis koherencia (Mac Lane)

- **Fogalom**: Minden "formális" diagram, amely `α, λ, ρ`-ból épül fel, kommutatív.
- **Forras**: Ch VII §2 "Coherence", `maclane_categories.txt:9527`

**Tétel 1** (`maclane_categories.txt:9560`): Minden `B` monoidalis kategoriához
és minden `b ∈ B` objektumhoz létezik egyetlen `W → B` monoidalis funktor, amely
`(-) ↦ b`-t küld. Itt `W` a "bináris szavak" ingyenes monoidalis kategoriája
(egy generátorral).

**Következmény** (`maclane_categories.txt:9721`): Minden `v, w` azonos hosszú szó-
párhoz egy (egyedi) kanonikus természetes izomorfizmus `can_B(v,w): v_B ⇒ w_B`
rendelődik, úgy hogy `id, α, α⁻¹, λ, λ⁻¹, ρ, ρ⁻¹` kanonikusak, és a kompozíció +
`◦`-szorzat kanonikusokat megőrzi.

**Bizonyítás-vázlat** (`maclane_categories.txt:9568`): A "bináris szavak" kategória
`W` úgy épül, hogy minden `v → w` nyíl egyedi (preorder + izomorfizmus). A bizonyítás
a `G_n` gráf kommutativitását mutatja meg indukcióval a "rank" szerint: minden
irányított út a kanonikus `w(n)` szóhoz (minden zárójel elöl) redukálható, és a
pentagon biztosítja a "gyémánt"-kommutativitást a kritikus esetben (`maclane_categories.txt:9673`).

### 7b. Szimmetrikus koherencia

- **Fogalom**: Minden formális diagram `α, λ, ρ, γ`-ból kommutatív, MERT `γ² = 1`.
- **Forras**: Ch XI §1, `maclane_categories.txt:14519`

**Tétel 1** (`maclane_categories.txt:14519`): Minden `M` szimmetrikus monoidalis
kategóriában egyedi kanonikus izomorfizmus rendelődik minden `(v_σ, w_τ)` permutált
szópárhoz, úgy hogy `id, α, γ` kanonikusak, és a kompozíció + `◦`-szorzat megőrzi.

**Bizonyítás-vázlat** (`maclane_categories.txt:14527`): A szimmetrikus csoport `S_n`
generátorai az `τ_i = (i, i+1)` transzpozíciók. A defináló relációk:
```
τ_i² = 1                              (megfelel γ² = 1, egyenlet V.11.8)
τ_i τ_{i+1} τ_i = τ_{i+1} τ_i τ_{i+1}  ((τ_i τ_{i+1})³ = 1)
τ_i τ_j = τ_j τ_i  ha |i-j| > 1       (természetesség)
```
Az első a `γ²=1` axióma, a második a hatszög, a harmadik a `γ` természetessége.
A szigorúan asszociatív esetre a két hatszög két háromszöggé redukálódik
(`maclane_categories.txt:14544`, egyenlet V.11.7a).

### 7c. Braided koherencia (Joyal–Street)

- **Fogalom**: A braided esetben NEM minden diagram kommutatív (a `γ` végtelen
  sok automorfizmust generálhat). Helyette: két kompozit egyenlő PONTOSAN akkor,
  ha ugyanazt a fonatot indukálják.
- **Forras**: Ch XI §5 "Braided Coherence", `maclane_categories.txt:15059`

**Tétel 1** (`maclane_categories.txt:15070`): Ha `B` a fonatkategória és `M` braided
monoidalis kategoria (alap kategóriája `M_0`), akkor:
```
hom_BMc(B, M) ≃ M_0
```
ahol `hom_BMc` az erős braided monoidalis funktorok kategóriája. Az ekvivalencia
az `1 ∈ B` objektumnál való kiértékeléssel adott.

**Tétel 2** (`maclane_categories.txt:15195`): Minden `n`-szorzatú kanonikus térkép
egy fonatot indukál (elem a `B_n` fonatcsoportban). Két kompozit minden `M`-ben
egyenlő PONTOSAN akkor, ha ugyanazt az elemet adják `B_n`-ben.

**Megjegyzés** (`maclane_categories.txt:15169`): Ez NEM a szokásos "minden diagram
kommutatív" koherencia — a fonatcsoport `B_n` végtelen, így végtelen sok különböző
kanonikus automorfizmus létezik.

---

## 8. KanKiterjesztes (Kan Extension)

- **Fogalom**: Egy `T: M → A` funktor kiterjesztése `K: M → C` mentén egy másik
  kategóriába. A kategóriaelmélet "minden fogalma Kan-kiterjesztés" (§X.7).
- **Forras**: Ch X §3 "The Kan Extension", `maclane_categories.txt:13543`

### Adat (mezők)

Adott `K: M → C` és `T: M → A`.

**Jobb Kan-kiterjesztés** `R = Ran_K T` (`maclane_categories.txt:13553`):

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `R` | a kiterjesztés funktora | `C → A` |
| `ε` | univerzális természetes transzformáció | `R ∘ K ⇒ T` |

**Bal Kan-kiterjesztés** `L = Lan_K T` (`maclane_categories.txt:13724`):

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `L` | a kiterjesztés funktora | `C → A` |
| `η` | univerzális természetes transzformáció | `T ⇒ L ∘ K` |

### Torveny (univerzális tulajdonság)

**Jobb Kan** (`maclane_categories.txt:13574`, egyenlet V.10.2):
```
Nat(S, Ran_K T) ≅ Nat(S ∘ K, T)     (természetes S-ben)
```
Azaz minden `α: S∘K ⇒ T` egyedi `σ: S ⇒ R` alakban faktorizál: `α = ε ∘ (σK)`.

**Bal Kan** (`maclane_categories.txt:13726`, egyenlet V.10.9):
```
Nat(Lan_K T, S) ≅ Nat(T, S ∘ K)     (természetes S-ben)
```

### Képletek

**Pontos bal oldali határ (jobb Kan)** — Tétel 1 (`maclane_categories.txt:13609`):
Ha minden `c ∈ C`-hez a kompozit `(c↓K) → M →^T A` határra megy `A`-ban:
```
(Ran_K T)(c) = Lim_{(f:c→Km) ∈ (c↓K)} T(m)
```
ahol `(c↓K)` a comma-kategória (objektumok: `(f, m)` ahol `f: c → Km`).

**Pontos kolimát (bal Kan)** (`maclane_categories.txt:13736`, egyenlet V.10.10):
```
(Lan_K T)(c) = Colim_{(Km→c) ∈ (K↓c)} T(m)
```

**Coend-képlet (bal Kan)** — Tétel 1, §X.4 (`maclane_categories.txt:13774`,
egyenlet V.10.4.1):
Ha a copower `C(Km', c) · Tm` létezik `A`-ban minden `m, m', c`-re:
```
(Lan_K T)(c) = ∫^m C(Km, c) · Tm
```
**End-képlet (jobb Kan)** (`maclane_categories.txt:13876`, egyenlet V.10.4.3):
```
(Ran_K T)(c) = ∫_m Tm^{C(c, Km)}
```
(power = iterált szorzat `A`-ban).

### Következmények

- **Következmény 2** (`maclane_categories.txt:13697`): Ha `M` kicsi és `A` teljes,
  minden `T`-nek van jobb Kan-kiterjesztése, és `A^K`-nak jobb adjungáltja van.
- **Következmény 3** (`maclane_categories.txt:13702`): Ha `K` teljes és hűséges,
  akkor `ε: RK ⇒ T` természetes IZOMORFIZMUS (a Kan-kiterjesztés valódi kiterjesztés).
- **Következmény 4** (`maclane_categories.txt:13713`): Ha `M` teljes alkategória és
  `K: M → C` a beillesztés, akkor létezik `R: C → A` `RK = T`-vel.

### Fugg

- `Kategoria`, `Funktor`, `TermeszetesTranszformacio`
- `Adjunkcio` (a `A^K` funktornak adjungáltja lesz)
- `Határ`/`Kolimát` (a pontos képletekhez)
- `End`/`Coend` (a coend/end képletekhez)

### Idris

```idris
public export
record KanKiterjesztes (o1 : Type) (m1 : o1 -> o1 -> Type)
                       (o2 : Type) (m2 : o2 -> o2 -> Type)
                       (o3 : Type) (m3 : o3 -> o3 -> Type) where
  constructor KanKiterjesztesKonstruktor
  k    : Funktor o1 m1 o2 m2    -- K : M -> C
  t    : Funktor o1 m1 o3 m3    -- T : M -> A
  r    : Funktor o2 m2 o3 m3    -- R : C -> A  (a kiterjesztes)
  epszilon : (m : o1) -> m3 (r.objektumKep (k.objektumKep m)) (t.objektumKep m)
  -- univerzalis: Nat(S, R) ~= Nat(S∘K, T)
```

---

## 9. EndekEsCoendek (Ends and Coends)

- **Fogalom**: Különleges határok/kolimátok, "ékekkkel" (dinaturális
  transzformációkkal) a kúpok helyett. Integrál-jelölés, mint a kalkulusban.
- **Forras**: Ch IX §5 "Ends" (`maclane_categories.txt:12682`) és §6 "Coends"
  (`maclane_categories.txt:12908`)

### 9a. End

#### Adat (mezők)

Egy `S: C^op × C → X` funktor **end**-je egy `(e, ω)` pár (`maclane_categories.txt:12686`):

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `e` | az end objektuma `X`-ben | `objektum` (X-ben) |
| `ω` | univerzális ék (dinaturális transzformáció) | `e ⇒ S` |

**Jelölés**: `e = ∫_c S(c, c)`.

#### Dinaturális feltétel (ék)

Minden `f: b → c` nyílra a következő KÉT négyszög kommutál
(`maclane_categories.txt:12693`, egyenlet V.9.1):
```
     S(b,b)                S(c,c)
      /  \                  /  \
ω_b  /    \ ω_c   ↔  ω_b  /    \ ω_c
    /      \              /      \
   e        e            e        e
    \      /              \      /
     \    /                \    /
      S(b,c)              S(b,c)
```
Formálisan: `S(1, f) ∘ ω_b = S(f, 1) ∘ ω_c` (dinaturális feltétel).

#### Univerzális tulajdonság

Minden `β: x ⇒ S` ékhez egyedi `h: x → e` `X`-beli nyíl létezik, hogy
`β_c = ω_c ∘ h` minden `c`-re.

#### Torveny / tulajdonságok

- **Egyediség**: két end izomorf (`maclane_categories.txt:12720`).
- **End = határ** — Propozíció 1 (`maclane_categories.txt:12812`):
  `∫_c S(c,c) ≅ Lim[S§: C§ → X]`, ahol `C§` a "subdivision kategória".
- **Minden határ = end** — Propozíció 3 (`maclane_categories.txt:12843`):
  `∫_c T(c) ≅ Lim T` (a "dummy" első változóval).
- **Nat = end** (`maclane_categories.txt:12770`, egyenlet V.9.2):
  ```
  Nat(U, V) = ∫_c hom_X(Uc, Vc)
  ```
  minden `U, V: C → X` funktorra.
- **Hom-funktorok megőrzik az end-et** (`maclane_categories.txt:12890`):
  ```
  X(x, ∫_c S(c,c)) = ∫_c X(x, S(c,c))
  ```

### 9b. Coend

#### Adat (mezők)

A coend a duál: `(d, ξ: S ⇒ d)` (`maclane_categories.txt:12910`):

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `d` | a coend objektuma `X`-ben | `objektum` (X-ben) |
| `ξ` | univerzális co-ék (dinaturális transzformáció) | `S ⇒ d` |

**Jelölés**: `d = ∫^c S(c, c)` (a kötött változó `c` FELÜLRE írt指数).

#### Torveny / tulajdonságok

- Minden tulajdonság duál az end-éhez.
- **Tenzer szorzat = coend** (`maclane_categories.txt:12920`):
  ```
  A ⊗_R B = ∫^r A ⊗ B     (r ∈ R)
  ```
  Egy `R`-bimodulus `A` és bal-modulus `B` tenzer szorzata gyűrű felett.
- **Geometriai realizáció = coend** (`maclane_categories.txt:12972`):
  ```
  |S| = ∫^n S_n × Δ_n
  ```
  egy simpliciális halmaz `S` realizációja a simpliciális kategória `Δ` felett.
- **Fubini (iterált end)** — §IX.8 (`maclane_categories.txt:13149`):
  ```
  ∫_{(p,q)} S(p,q,p,q) = ∫_p ∫_q S(p,q,p,q) = ∫_q ∫_p S(p,q,p,q)
  ```
  (kettős integrál iterálható, ha a belső end létezik).

### Fugg

- `Kategoria`, `Funktor`, `Határ`/`Kolimát` (az end határként)
- `TermeszetesTranszformacio` (a dinaturális transzformáció általánosítása)

### Idris

```idris
||| Dinaturalis transzformacio (ek): e => S, ahol S : C^op x C -> X.
public export
record Ek (oC : Type) (mC : oC -> oC -> Type) (oX : Type) (mX : oX -> oX -> Type)
          (s : oC -> oC -> oX) (e : oX) where
  constructor EkKonstruktor
  komponens : (c : oC) -> mX e (s c c)
  dinaturalis : {b, c : oC} -> (f : mC b c)
              -> kompozicio (komponens b) (sMorBefogo f) = kompozicio (komponens c) (sMorKetto f)

||| End: univerzalis ek.
public export
record End (oC : Type) (mC : oC -> oC -> Type) (oX : Type) (mX : oX -> oX -> Type)
           (s : oC -> oC -> oX) where
  constructor EndKonstruktor
  endObjektum : oX
  univerzalisEk : Ek oC mC oX mX s endObjektum
  -- univerzalis: minden ek-hez egyedi h : x -> endObjektum
```

---

## 10. Monad (Monad / Triple)

- **Fogalom**: Egy monoid az endofunktorok kategóriájában. Minden adjunkció
  monadot indukál; minden monad adjunkcióból származik (Eilenberg–Moore).
- **Forras**: Ch VI §1 "Monads in a Category", `maclane_categories.txt:8043`

### Adat (mezők)

Egy monad `T = <T, η, μ>` `X`-ben (`maclane_categories.txt:8051`):

| Mező | Jelentés | Aláírás |
|------|----------|---------|
| `T` | endofunktor | `X → X` |
| `η` | egység (természetes transzformáció) | `I_X ⇒ T` |
| `μ` | szorzás (természetes transzformáció) | `T² ⇒ T` |

### Torveny (egyenletek)

`maclane_categories.txt:8056` (egyenlet V.6.2):

**(Asszociativitás)**:
```
μ ∘ Tμ = μ ∘ μT       (két módon T³ → T)
```

**(Bal egység)**:
```
μ ∘ Tη = id_T          (T → T² → T = id)
```

**(Jobb egység)**:
```
μ ∘ ηT = id_T          (T → T² → T = id)
```

Ez PONTOSAN a monoid axiómája, a `×` helyett funktor-kompozícióval.

### Mondat ↔ Adjunkció

`maclane_categories.txt:8091`: Minden `<F, G, η, ε>: X → A` adjunkció monadot
definiál `X`-ben:
```
T = G ∘ F,   η = az adjunkció egysége,   μ = G ∘ ε ∘ F
```
Az asszociativitás az "interchange-law"-ból következik.

**Tétel 1** (`maclane_categories.txt:8241`): Minden monad definiálható egy
adjunkcióval. Az Eilenberg–Moore kategória `X^T` a `T`-algebrákkal:
- `T`-algebra `<x, h>`: `h: Tx → x` olyan, hogy `h ∘ Th = h ∘ μ_x` (asszoc.) és
  `h ∘ η_x = id_x` (egység).
- Adjunkció `F^T ⊣ G^T: X ↔ X^T`, ahol `G^T` felejtő, `F^T(x) = <Tx, μ_x>`.

### Fugg

- `Kategoria`, `Funktor`, `TermeszetesTranszformacio`
- `Adjunkcio` (minden monad adjunkcióból; minden adjunkció monadot ad)

### Pelda

- **Zárásoperáció**: monad egy preorderen (`maclane_categories.txt:8155`):
  `x ≤ Tx`, `T(Tx) = Tx`.
- **Szabad csoport monad**: `T(X) = szabad csoport X`-en, a `Set ⊣ Grp` adjunkcióból.
- **Csoport-akció**: `T(X) = G × X`, `η(x) = (e, x)`, `μ(g₁, (g₂, x)) = (g₁g₂, x)`.

### Idris

```idris
public export
record Monad (objektum : Type) (hom : objektum -> objektum -> Type) where
  constructor MonadKonstruktor
  kategoria : Kategoria objektum hom
  endofunktor : objektum -> objektum          -- T : X -> X (objektum-lekepezes)
  egyseg     : (a : objektum) -> hom a (endofunktor a)        -- eta : I => T
  szorzas    : (a : objektum) -> hom (endofunktor (endofunktor a)) (endofunktor a)  -- mu : T^2 => T
```

A típusosztály-változat (törvényekkel):
```idris
public export
interface MonadT (objektum : Type) (hom : objektum -> objektum -> Type) where
  endofunktor : objektum -> objektum
  egyseg     : (a : objektum) -> hom a (endofunktor a)
  szorzas    : (a : objektum) -> hom (endofunktor (endofunktor a)) (endofunktor a)
  -- Asszociativitas: mu ∘ Tmu = mu ∘ muT
  monadAsszociativ : (a : objektum) -> ...
  -- Bal es jobb egyseg: mu ∘ Teta = id, mu ∘ etaT = id
  monadBalEgyseg  : (a : objektum) -> ...
  monadJobbEgyseg : (a : objektum) -> ...
```

---

## Összefoglaló: a struktúra-hierarchia

```
Kategoria
  └── MonoidalisKategoria          (+ tenzor, egyseg, α, λ, ρ + pentagon + haromszog)
        └── BraidedMonoidalisKategoria   (+ γ + ket hatszog / Yang-Baxter)
              └── SzimmetrikusMonoidalisKategoria  (+ γ² = 1)
                    └── ZartKategoria    (+ belso hom ( )^b ⊣ -◦b)

Kategoria
  └── KettoKategoria               (+ 2-sejtek, fuggoleges •, vizszintes ◦, interchange)
        └── Bikategoria             (gyenge: α, λ, ρ izomorfizmusok, nem identitasok)
              └── (egy 0-sejtes Bikategoria = MonoidalisKategoria)

Funktor + TermeszetesTranszformacio
  └── Adjunkcio                    (F ⊣ G, eta, epszilon, haromszog)
        └── Monad                  (T = GF, eta, mu = G epszilon F)
  └── KanKiterjesztes              (R = Ran_K T, epszilon; L = Lan_K T, eta)
        └── (coend/end kepletekkel)

Kategoria + Határ/Kolimát
  └── End / Coend                  (dinaturalis ek, ∫_c S(c,c), ∫^c S(c,c))
```

### Megjegyzések a kinyeréshez

- Az Awodey-kinyerés már tartalmazza: `Kategoria`, `Funktor`,
  `TermeszetesTranszformacio`, `Adjunkcio`, `Yoneda`, `Határ`/`Kolimát`,
  `DescartesZart`. Ezeket NEM ismételtük meg.
- A fenti 10 struktúra (1–10) az, amit Mac Lane KÍNÁL és Awodey HAGY.
- A koherencia-tételek (§7) nem önálló struktúrák, hanem tételek a 1–3.
  struktúrákról — külön szekcióban, mert a bizonyítás-vázlatok fontosak.
- Minden Idris-aláírás követi a `KategoriaElmelet.idr` konvencióit:
  magyar nevek, `Konstruktor` utótag, `T` típusosztály-változat törvényekkel.