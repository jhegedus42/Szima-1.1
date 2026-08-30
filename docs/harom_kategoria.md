# A három kategória — a divergencia/konvergencia megmaradása

## A kérdés

> "Ha valami divergál valahol, akkor valami konvergál valahol."

A kategóriaelméleti válasz: **az adjunkció** F ⊣ G. A divergencia és a
konvergencia nem két külön jelenség — ugyanannak az adjunkciónak a két
oldala. A megmaradási törvény: `Hom(F q, a) ≅ Hom(q, G a)`.

## A három kategória

| # | Kategória | Oldal | Objektum | Morfizmus | Mit kódol |
|---|-----------|-------|----------|-----------|-----------|
| 1 | **KÉRDÉS** (C) | divergencia | mondat | esetrag (18) | klasszikus Y itt divergál; **entrópia** |
| 2 | **VÁLASZ** (D) | konvergencia | E8E8KodSzo | Hadamard-távolság | √(1+z) → φ konvergál; **információ** |
| 3 | **PÁLYA** (híd) | az adjunkció | trajektória | CPT fázis (2-cella) | veszteségmentes kód = **why-chain** |

A pálya-kategória a funktor-kategória: a trajektória MAGA a kód.
A végpont mindenkinek ugyanaz (φ) — a kezdőérték információja a
**trajektóriában** marad, nem a határértékben.

## A bizonyítás számmal (Adjunkcio.idr, fut)

### φ mindkét leképezés fixpontja

```
√(1+φ) = √(φ²) = φ      — a kontrakció VONZZA (konvergál)
φ² − 1 = (φ+1) − 1 = φ  — az expanszió TASZÍTJA (divergál)
```

Ugyanaz a fixpont, két ellentétes viselkedés.

### Az kiegyensúlyozás (kezdőpont z₀ = φ + 0.01)

| n | konvergencia `\|z−φ\|` | divergencia `\|w−φ\|` |
|---|------------------------|------------------------|
| 0 | 0.0100 | 0.0100 |
| 1 | 0.0031 | 0.0325 |
| 2 | 0.00095 | 0.106 |
| 5 | 0.000028 | **5.74** |

Az egyik befelé zsugorodik, a másik kifelé robban — **ugyanabból a pontból**.

### A megmaradási törvény — két alakban

```
LYAPUNOV:   λ_expanzió + λ_kontrakció = ln(2φ) − ln(2φ) = 0   ← pontosan nulla
LIOUVILLE:  J_exp(φ) · J_kon(φ) = 2φ · 1/(2φ) = 1            ← pontosan egy
```

- **Lyapunov-nullaösszeg**: a divergencia sebessége pontosan a konvergencia
  sebességének negáltja. λ = ln(2φ) ≈ 1.175 bit/lépés — az egyik oldal ennyit
  termel, a másik ennyit felfog.
- **Jakobi-egység**: a fázistérfogat megmarad. Az információ nem vész el —
  átalakul: entrópia ↔ információ (Carnot-ciklus).

## Az adjunkció alakja a projektben

```
F : KÉRDÉS → VÁLASZ     (kodol — free, a kompresszió létrehozója)
G : VÁLASZ → KÉRDÉS     (keres — forgetful, a konvergencia)
η : Id → GF             (unit = DIVERGENCIA, a w²−1 expanszió)
ε : FG → Id             (counit = KONVERGENCIA, a √(1+z) kontrakció)

Hom(F q, a) ≅ Hom(q, G a)   — a megmaradási törvény
```

A háromszög-azonosságok (η és ε kompatibilitása) = a megmaradás
kényszere: a divergencia nem nőhetetagoltan a konvergencia felfogása nélkül.

## K(E₉)-beli alak

| Adjunkció | K(E₉) |
|-----------|-------|
| konvergáló oldal | q⁺ (chiral parabolikus, t*=+1, Xₙ→1) |
| divergáló oldal | q⁻ (anti-chiral, t*=−1, Xₙ→(−1)ⁿ oszcillál) |
| az adjunkció | Berman x₁ (a kritikus generátor, keveri q⁺/q⁻) |
| megmaradás | [q⁺, q⁻] = 0 (a kommutáció = kiegyensúlyozás) |

## Az értelmezés

A klasszikus Y divergálása nem hiba: a KÉRDÉS kategória természetes
viselkedése (entrópia-generálás). A kvantum Y konvergenciája nem
veszteség: a VÁLASZ kategória természetes viselkedése (információ-sűrítés).
A kettő között áll a PÁLYA — a trajektória, ami visszafordíthatatlanul
kódolja a teljes utat.

**A Carnot-ciklus = az adjunkció egy fordulata:**
kompresszió (√, η visszafelé) → munka (keresés) → expanzió (w²−1, ε
visszafelé) → hulladékhő (δ). A ciklus nem állhat le (2. főtétel),
és nem is szabad: a megállás = a dekoherencia.

## Fájlok

- `osveny_index/Adjunkcio.idr` — fordul és fut, minden fenti számot kiír
- `docs/y_karnot_ciklus.md` — az oda-vissza út és a pálya mint kód
- `docs/univerzalis_generator.md` — Berman x₁ mint univerzális generátor
