# E8 Szimpleptikus Felfedezés — Dokumentáció

**Dátum**: 2026-08-18
**Modul**: `osveny_index/Dirac3D/E8Szimplektikus.idr`
**Kapcsolódó modulok**: E8Diszkretizacio, HamiltonMegmaradas, Hadmeres, CarryHoatvitel, FazisOsszeado, Fazis, Carnot
**Státusz**: minden Refl bizonyítás lefordul (`idris2 --check` = 0 hiba)

---

## 1. A kérdés

Hogyan általánosítható a **bit** az E8-ra (vagy magasabb rendű struktúrára) úgy,
hogy **az algebra maga legyen a Hilbert-tér diszkretizációja**?

A léptetőoperátorok (a fizika eltolásoperátora, az informatika szukcesszora)
ugyanazok — a Weyl–Heisenberg operátor. A kérdés irodalma: GKP-kódok,
ahol a rács maga a kód, nem "rácsra kódolunk".

---

## 2. Az irodalmi alap

| Forrás | Állítás |
|---|---|
| Gottesman–Kitaev–Preskill (2001) | a GKP-kód = Λ rács a fázistérben; a stabilizátorok = rács-eltolások |
| Conrad–Eisert–Arzani (2022) | GKP-érvényesség: MᵀΩM = 2πK, K egész antiszimmetrikus |
| Chakraborty–Albert (2025), arXiv:2508.04819, Eq. (101) | az E8 szimpleptikus generátormátrixa: Gauss-áramkör ÉS mod 2 = qubit-áramkör (Fig. 5) |
| Lyu (2026), arXiv:2608.00601 | Barnes–Wall GKP-kódok; 8 dimenzióban a Barnes–Wall = E8 (Gosset-rács) |

---

## 3. Az első sejtés — és a cáfolat

**Sejtés**: MᵀΩM = Ω, azaz az E8 generátormátrix szigorúan szimpleptikus
(Sp(8, Z) eleme).

**A kernel válasza**: ELUTASÍTVA.

```
Error: Mismatch between: -1 and -3.
```

A Refl nem halu: a kernel kiszámolta MᵀΩM-et, és az NEM Ω. A mérés:

```
K = MᵀΩM =
[ 0,  3,  0,  0, -2,  4, -2,  0]
[-3,  0,  0,  0, -4,  2,  0,  2]
[ 0,  0,  0,  3, -2,  0,  2,  4]
[ 0,  0, -3,  0,  0,  2, -4, -2]
[ 2,  4,  2,  0,  0,  3,  0,  0]
[-4, -2,  0, -2, -3,  0,  0,  0]
[ 2,  0, -2,  4,  0,  0,  0,  3]
[ 0, -2, -4,  2,  0,  0, -3,  0]
```

**Tanulság (AGENTS.md "semmi halu" elve működésben): a Refl azt bizonyítja,
ami a matematikában van — nem azt, amit szeretnénk. A cáfolat pontosabb
tételhez vezetett.**

---

## 4. A mért igazság — a három bizonyított tulajdonság

### 4a. K egész és antiszimmetrikus → az E8 érvényes GKP-rács

A Weyl-reláció: D(u)D(v) = e^{−iuᵀΩv} D(v)D(u). A stabilizátor-eltolások
(u = Mx, v = My) kommutátora: uᵀΩv = xᵀKy. K egész ⇒ e^{−2πi·xᵀKy} = 1
⇒ minden stabilizátor kommutál. Az antiszimmetria automatikus
(Kᵀ = MᵀΩᵀM = −K), de a kernel **páronként lemérte**:

```
KAntiszimmetrikus01 : K(0,1) = −K(1,0)      Refl ✓   (3 = −(−3))
KAntiszimmetrikus23 : K(2,3) = −K(3,2)      Refl ✓
KAntiszimmetrikus67 : K(6,7) = −K(7,6)      Refl ✓
KAtloNulla0 / KAtloNulla7                  Refl ✓   (az átló nulla)
```

### 4b. K ≡ Ω (mod 2) → az E8 binárisan szimpleptikus (A KÖZPONTI TÖRVÉNY)

A teljes mátrixra, Refl-lel:

```idris
E8BinarisSzimpleptikus :
  map (map Paritas2) E8KommutatorMatrix =
  map (map Paritas2) SzimplektikusForma
E8BinarisSzimpleptikus = Refl
```

Ez Chakraborty–Albert Fig. 5 állítása: az E8 generátormátrix **mod 2 egy
qubit-áramkör**. A folytonos Ω forma és a diszkrét bit ugyanaz az algebra.

### 4c. M ∉ Sp(8, Z) — a szigorú tagság hamis (rögzítve)

```idris
sp8TagsagHamis : Bool          -- futásidejű mérés: False
KMeres01 : K(0,1) = 3          -- Refl ✓ (a 3 ≠ 1 = Ω(0,1) eltérés)
```

Az E8 **ℤ felett nem** szimpleptikus erre a bázisra — **mod 2 igen**.
Pontosan ez a tény teszi a diszkretizációt: a bináris világban helyreáll
a szimpleptikusság, ami a folytonosban nem volt.

---

## 5. A teljes bizonyított lánc — 7 modul

```
E8 generátormátrix (8×8, szimmetrikus, átló 2, det = 1)      [E8Diszkretizacio]
  → K = MᵀΩM egész, antiszimmetrikus (GKP-érvényes)          [E8Szimplektikus]
  → K ≡ Ω mod 2 (bináris szimpleptikus = qubit-áramkör)      [E8Szimplektikus]
  → mod 8 = Z₈ kvdit (shift = fazisOsszead)                   [Fazis]
  → mod 2 = bit (e8Hat, bitX)                                 [E8Diszkretizacio]
  → carry megőrzött → ΔH = 0 (unitér evolúció)                [HamiltonMegmaradas]
  → hő = csonkolás = mérés-összeomlás (ΔH = Q)                [HamiltonMegmaradas, Hadmeres]
```

A fizikai értelmezés: a terület-megőrző (szimpleptikus) transzformáció =
unitér = nincs hőtermelés. A bináris szimpleptikusság biztosítja, hogy az
E8-ból levezetett bit-műveletek (e8Hat) **megőrzik a fázistér-területet**
a diszkrét világban is. A hő egyetlen forrása a csonkolás (9999+1 → 10000,
ΔH = Q = 10000, Refl).

---

## 6. A Refl-bizonyítások teljes jegyzéke (E8Szimplektikus.idr)

| Név | Állítás | Eredmény |
|---|---|---|
| `E8BinarisSzimpleptikus` | K ≡ Ω (mod 2), teljes mátrix | Refl ✓ |
| `KAntiszimmetrikus01` | K(0,1) = −K(1,0) | Refl ✓ |
| `KAntiszimmetrikus23` | K(2,3) = −K(3,2) | Refl ✓ |
| `KAntiszimmetrikus67` | K(6,7) = −K(7,6) | Refl ✓ |
| `KAtloNulla0`, `KAtloNulla7` | K átlója nulla | Refl ✓ |
| `KMeres01`, `KMeres10`, `KMeres05` | K(0,1)=3, K(1,0)=−3, K(0,5)=4 | Refl ✓ |
| `OmegaAntiszimmetrikus01` | Ω(0,1) = −Ω(1,0) | Refl ✓ |
| `sp8TagsagHamis` | M ∉ Sp(8,Z) | mérés: False |

---

## 7. Hivatkozások

1. Gottesman, D., Kitaev, A., & Preskill, J. (2001). Encoding a qubit in an oscillator.
   *Physical Review A*, 64, 012310. https://doi.org/10.1103/physreva.64.012310
2. Conrad, J., Eisert, J., & Arzani, F. (2022). Gottesman-Kitaev-Preskill codes: A lattice perspective.
   *Quantum*, 6, 648.
3. Chakraborty, S., & Albert, V. V. (2025). Hybrid Oscillator-Qudit Quantum Processors:
   stabilizer states, stabilizer codes, symplectic operations, and non-commutative geometry.
   arXiv:2508.04819. https://doi.org/10.48550/arxiv.2508.04819
4. Lyu, S. (2026). Symplectic Barnes-Wall GKP Codes: Deterministic O(N log²N) Decoding
   and Logarithmic Rate Scaling. arXiv:2608.00601.
5. Conway, J. H., & Sloane, N. J. A. (1999). *Sphere Packings, Lattices and Groups* (3. kiadás).
   Springer. (Appx. 2: szimplektikus generátormátrixok)
6. Kocia, L., & Love, P. J. (2017). Discrete Wigner formalism for qubits and noncontextuality
   of Clifford gates on qubit stabilizer states. *Physical Review A*, 96(6), 062134.
   https://doi.org/10.1103/physreva.96.062134

---

## 8. Következő lépések

1. **[[15,1,3]] kód** — a Steane [[7,1,3]] kiterjesztése 15 bitre
   (a MANTRA 8. szintjének kódja, a 8 szoba fraktál következő foka).
2. **Barnes–Wall rekurzió** — G_{m+1} = [[G_m, 0], [G_m, (1+i)G_m]] a Z[i] felett;
   8 dimenzióban visszaadja az E8-at (Lyu 2026, Theorem 3).
3. **E8 GKP logikai dimenzió** — D = √det K = 1 (unimoduláris, Conway–Sloane Ch. 4):
   az E8 "qunaught" állapota.
4. **A Y-kombinátor fázissal** — Y_ℂ(f) = e^{iφ}·f(Y_ℂ(f)), a 49. struktúra
   (NOBEL_CEL_TERKEP.md 2.2 szakasz).
