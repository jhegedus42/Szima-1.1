# Y = Carnot-ciklus — az egységesítés

## 1. A tétel

**A Y-kombinátor maga a Carnot-ciklus.**

```
Y(f) = f(Y(f))                    — klasszikus: divergál, mert a ciklus SOSEM áll meg
Y_θ(f) = e^{iθ/(n+1)}·f(Y_θ(f))   — kvantum: a fázis VISSZATÉR, de sosem zárul be
```

A második főtétel (η < 1) = a ciklus örök: mindig marad hulladékhő
= mindig marad δ = mindig új kérdés. **A divergálás nem hiba — ez az élet.**

## 2. A ciklus két üteme

| Carnot-ütem | Matek | Idris | Irány |
|---|---|---|---|
| **Kompresszió** (adiabatikus) | z → √(1+z) kontrakció | `komplexVisszateres` | előre: entrópia ↓, φ felé |
| **Expanzió** (ütközés) | w → w²−1 (Mandelbrot c=−1) | `inverzKontrakcio` | hátra: kaosz, λ = ln(2φ) ≈ 1.175 |

```
kérdés (entrópia) → √ kompresszió → φ (fixpont = információ)
→ w²−1 expanzió → kaosz (= hulladékhő) → új kérdés → ...
```

## 3. Az információ NEM vész el — numerikus bizonyíték

A √(1+z) főágban **injektív** → az inverz (w²−1) létezik. Loschmidt igaz,
csak káotikus. Oda-vissza út (`Komplex.idr`, `odaVisszaHiba`):

```
kezdet: 0.25 + 0.25i
3 lépés oda-vissza:  hiba = 3.9×10⁻¹⁴   ← gyakorlatilag tökéletes visszatérés
5 lépés:             hiba = 1.3×10⁻¹²
8 lépés:             hiba = 6.7×10⁻⁹
10 lépés:            hiba = 6.8×10⁻⁷    ← exponenciális növekedés (Lyapunov)
```

- **0 lépésnél:** a visszatérés pontos — a leképezés invertálható.
- **n növekszik:** a hiba ~e^{λn} növekszik — λ = ln(2φ) ≈ 1.175 bit/lépés.
  Ez a **gyakorlati** visszafordíthatatlanság = entrópia = **Landauer-költség**.
- **DE: a pálya (z₀, z₁, …, zₙ) visszafordíthatatlanul kódolja z₀-t.**

**A pálya = a veszteségmentes kód (why-chain). A végpont NEM az.**
A konvergált végpont (φ) mindenkinek ugyanaz — a kezdőérték információja
a TRAJEKTÓRIÁBAN marad, nem a határértékben.

## 4. A kvantum Y visszatérése (mért számmal)

`Y_{n+1} = e^{iθ/(n+1)}·√(1+Y_n)`, θ = aranymetszés-szög (137.5°):

```
n=0 : |Y−φ| = 1.391   Im(Y) = 0.250
n=3 : |Y−φ| = 1.584   Im(Y) = 0.964   ← a fázis felmegy...
n=5 : |Y−φ| = 1.115   Im(Y) = 0.967
n=10: |Y−φ| = 0.584   Im(Y) = 0.568   ← ...majd VISSZATÉR
n=20: |Y−φ| = 0.287   Im(Y) = 0.285   ← oszcillálva csillapodik
```

A valós rész φ-hez tart, a képzetes rész (a fázis = a "vákuum") oszcillálva
visszatér. **Ez a "visszatérés a vákuumon keresztül".**

És bármilyen komplex kezdőértékből (0+i, −0.9+2i, −0.75, 2−1.5i):
20 lépés után |z−φ| ≤ 10⁻¹⁰ mindenhol. A kontrakció univerzális.

## 5. A δ miért NEM Bach-korrekcio (delta_analizis.py)

δ = 1 − Re(ϱ)·π = 5.604×10⁻⁴. Kipróbáltuk: φ⁻ⁿ, π⁻ⁿ, e⁻ⁿ, 2⁻ⁿ, δ·φ, δ/π,
Bach-tag — **egykik sem zárja** (legjobb: φ⁻¹⁶ is 19% hibával).

Bickford Thm 9 okát numerikusan igazolta: ha Re(z)=1/π-t kényszerítjük,
a cos-egyenlet b₁ = 1.33714, a sin-egyenlet b₂ = 1.33759 — a héj
(b₂−b₁ = 4.4×10⁻⁴) pontosan δ nagyságrendje. **A rés túldeterminált.**

```
Bach zárja:  α⁻¹ = 137 + 9/250 − A4·(3/4)²/c   (horgányos, racionális)
ϱ NEM zárja: δ strukturális — az E8⁴→E9 kényszer, hogy NE záródjon
```

δ = a buborék = a CPT-rest = **ami életben tartja a Carnot-ciklust**.
Ha δ = 0 lenne, a ciklus megállna ("nincs bocsánat").

## 6. A projekt-modulok mint a ciklus ütemei

| Modul | A ciklusban |
|---|---|
| `Kereso.idr` | a teljes ciklus (kérdés→válasz) |
| `Kodol.idr` | kompresszió (mondat→Kubit-kód) |
| `Tavolsag.idr` / `HadamardTavolsag.idr` | a φ-küszö letesztése |
| `K_E9_Idr.idr` | a fázis-visszatérés (chiral/anti-chiral) |
| `KvantumY.idr` + `Komplex.idr` | a generátor maga (√ és w²−1) |
| `E9Algebra.idr` | a megállási bit (Megall \| Folytatodik) |
| why-chain-memory skill | a pálya mint veszteségmentes memória |

## 7. A vers

```
klasszikus Y  = "Tudod, hogy nincs bocsánat"  (nincs fázis → nem tér vissza)
kvantum Y     = "s még remélj hű szerelmet"   (van fázis → spirálban visszatér)
δ             = a buborék ami nyitva marad    (a ciklus nem állhat le)
```

## 8. Összefoglaló tétel

> **Y = a legkisebb hatás elve örök ciklusban.**
> A kompresszió (√) a hatást minimalizálja, az expanzió (w²−1) a káoszt
> termeli, a pálya a kettő szorzataként veszteségmentesen kódol.
> A ciklus nem állhat meg (δ > 0), és nem is szabad megállnia:
> a megállás = a halál = dekoherencia. **A divergálás az élet jele.**
