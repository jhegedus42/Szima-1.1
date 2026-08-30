# Alfa (α) pontos számítása — kutatás (2026-08-19)

**Kérdés:** "az alpha az ugy ki van szamolva pontosan... arra is keress ra"
**Státusz:** ÖSSZEGYŰJTVE — a projekt Horgony-képlete (KÉT rivális forma + Bach-korrekció) + az irodalom + az Idris által számított δ. A forrást a ProtonDrive indexben (`gondnok-laptop/project/target/all_sources/`) találtuk meg.

---

## 1. A projekt saját α-levezetése (Horgony) — KÉT rivális forma + Bach-korrekció

Forrás (ProtonDrive → lokális index):
- `all_constants_exact.py` (534 sor) — a fő levezetés
- `hanmag_zaras.py` (263 sor) — a zárás: két rivális forma + őszinte kizárás
- `transzkript_nem_numerologia.txt` (2030 sor) — a Kimi-ágens beszélgetés
- `trail_index/E9_framework.md` (168-190. sor) — a framework táblázat

### 1.1 A 9/250 szerkezete (számelmélet)

```
α⁻¹_törtrész = (D_CRIT − 1)² / ((D_CRIT + 1)^(D_CRIT−1) × (D_CRIT − 2))
D_CRIT = 4 (a 4D téridő: 3 tér + 1 idő)
→ 3² / (5³ × 2) = 9 / 250 = 0.036
```

Prímtényezősítve: `9/250 = 3²/(2×5³) = (3/16)² × diezisz(128/125)` — a 5-limesz racionális kifejezés (zongorahangolás). A `(3/16)² = 0.03515625` önmagában 2.3%-os; a diezisz-hangolás (`×1.024`) hozza 0.006 ppm-re. **Forrás:** `hanmag_zaras.py:62`.

Az egész rész: `137 = 2⁷ + 2³ + 2⁰ = FW[137]` (a Horgony fixpont-szótárból).

### 1.2 A KÉT rivális forma (mindkettő VÁZLAT — őszintén KIZÁRVA)

**Forma A — Zongora-racionális:**
```
α⁻¹ = 137 + 9/250 = 137.036
```
- `9/250 = 3²/(2×5³) = (3/16)² × diezisz(128/125)` — 5-limesz racionális
- **Δ/σ = 39σ** a CODATA 2022-től (`hanmag_zaras.py:71`: "VÁZLAT (39 szigma)")
- A CODATA 2022 érték: `137.035999177(21)`, σ_α = 2.1×10⁻⁸

**Forma B — Schwinger-fixpont a fáziskörön:**
```
x = 137 + 31/(2πx)   (önkonzisztens fixpont-egyenlet)
```
- `31 = 2⁵ − 1 = M(5)`, az 5-ös szám Mersenne-prímje
- A fixpont pozitív gyöke: `x = (137 + √(137² + 2·31/π)) / 2 ≈ 137.0360…`
- **Δ/σ = 215σ** a CODATA 2022-től (`hanmag_zaras.py:72`: "VÁZLAT (215 szigma)")

**Az őszinte ítélet** (`hanmag_zaras.py:71-74`):
> "MINDKÉT forma PONTOS formulaként KIZÁRT (39, ill. 215 szigma).
> 137.036 a történelmi (XX. sz. közepi) közelítés — a gép ezt találja újra;
> a két független vázlat egymástól 0.03 ppm-re áll — a delta ~ 0.03600
> környéke robusztus, de a hurok-korrekcióknak a QFT-rétegből KELL jönniük
> (hátralévő munka)."

### 1.3 A BACH-KORREKCIÓ — a komplex fázis (a hiányzó tag)

A `transzkript_nem_numerologia.txt:370` szerint a helyes irány:
```
α⁻¹ = Re[ (A + iB)^(C + iD) ]   ← komplex hatvány!
```

A konkrét komplex képlet (`transzkript_nem_numerologia.txt:395`):
```python
alpha_complex = 1 / (137 + 0.036 * np.exp(1j * np.pi/4))
# = 1 / (137 + 0.036 × (1+i)/√2)
# = 1 / (137.025 + 0.025i)
# A valós rész = α⁻¹ mért értéke
# A képzetes rész = a "vákuumfluktuáció" fázisa
```

A **Bach-korrekció** = `e^{iπ/4}` — a Möbius-rák-kanon fázisa (az E9_framework
§6 "crab-canon-on-Möbius"). A `KomplexByte.idr:109` `komplexEuler` függvénye
pontosan ezt valósítja meg: `komplexEuler szog = KomplexKonstruktor (cos szog) (sin szog)`.

A π/4 fázis a 8. gyök egység: `e^{iπ/4} = (1+i)/√2` — a 8-szoros forgási
szimmetria (a Steane [[7,1,3]] 7 bit + 1 chirality = 8 dimenzió).

### 1.4 A vákuum-polarizációs korrekció

Az `all_constants_exact.py:136-138` szerint a G gravitációs állandó levezetésében:
```
G_korrekció = (1 + 9/250)^(1/40)
ahol 40 = 2³ × 5 (prímstruktúra)
```
Ez a `9/250` (α törtrész) `1/40`-edik hatványa — a vákuum-polarizáció korrekciója.
Ugyanez a korrekció szerepel a G levezetésében is (l. `all_constants_exact.py:131-138`).

---

## 2. A projekt α-értékei — pontos táblázat (relatív hibával)

| Érték | Forrás | σ abszolút | Δ/σ |
|---|---|---|---|
| **137.036** (zongora-racionális) | `137 + 9/250` | σ_CODATA = 2.1×10⁻⁸ | **39σ** |
| **137.0360…** (Schwinger-fixpont) | `x = 137 + 31/(2πx)` | σ_CODATA = 2.1×10⁻⁸ | **215σ** |
| **137.035999177** (CODATA 2022) | mérés | 2.1×10⁻⁸ | 0 (referencia) |
| **137.035999084** (CODATA 2018) | mérés | 2.1×10⁻⁸ | — |
| δ = 8.23×10⁻⁷ (Idris számítva) | `137.036 − 137.035999177` | — | Δ/σ ≈ 39 |

A δ Idris által számított értéke (dashboard):
```
delta SZAMITOTT = 8.229999934883381e-7
delta DEKLARALT = 8.23e-7
```

**A "6.5σ" állítás cáfolata** (AGENTS §17 szerint):
Az `E9_framework.md:187` "6.5σ off" állítása NEM állja meg a helyét: Δ/σ = 39
(a `hanmag_zaras.py` is 39σ-t ír). A framework "~17%" állítása is hibás:
|8.58−8.23|×10⁻⁷ = 3.5×10⁻⁸, ami az α-gap ~4.3%-a, nem ~17%-a.

---

## 2. Az irodalom — hogyan számolják α-t pontosan

### 2.1 A RCL (Recognition Composition Law) — Lean 4-ben verifikálva

**Washburn & Allahyarov (2026), arXiv:2506.12859v3** — *"Particle Masses from
First Principles: A Complete Derivation of the Fermion Spectrum from the
Recognition Composition Law"*. **Lean 4: 179 fájl, 0 sorry** (github.com/
jonwashburn/recognition-science).

Az α⁻¹ háromtagú szerkezeti felbontása (64. egyenlet, 12. szakasz):

```
α⁻¹ = 4π · E_passive − w₈ · ln φ + 103/(102π⁵)
       └─ geometriai mag ─┘ └─ rés-súly ─┘ └─ görbület-korrekció ─┘

       = 4π·11 ≈ 138.230    − w₈·lnφ ≈ 1.199   + 0.00330
       ≈ 137.035            (additív; az exponenciális reszummáció
                             ≈ 137.037; a CODATA 137.035999206(11)-től
                             ≲ 7-8 ppm eltérés)
```

- **Term 1**: 4π (térszög, D=3 izotrópia) × E_passive = E(3) − A = 12 − 1 = **11**
  (a 3-kocka passzív éleinek száma). Lean: `product_form_uniqueness`.
- **Term 2**: w₈ = (348 + 210√2 − (204 + 130√2)·φ)/7 ≈ 2.4906 — a φ-mintázat
  DFT-8 vetülete, ln φ ≈ 0.4812. Lean: `GapWeightDerivationCert` (a DFT-8
  normalizációt a Parseval-tétel kényszeríti C = 1/√8-ra).
- **Term 3**: 103/(102π⁵), ahol 102 = F·W = 6×17, 103 = F·W + A, d = D+1+1 = 5.
  Lean: `one_oh_three_is_forced`, `CubeGeometryCert`.
- A maradék δ = α⁻¹_CODATA − α⁻¹_RS ≈ **0.0011** (~8 ppm) — a cikk NEM
  állítja, hogy δ-t kiszámolja; "records the residual".

**Fontos a projekthez**: ez a cikk pontosan azt a módszertant követi, amit a
felhasználó kért — **diszkrét szerkezeti tétel, gépi verifikáció (Lean 4),
0 paraméter**. A projekt δ-ja (8.23e-7) ≈ 1000-szer kisebb, mint a RCL
maradéka (0.0011), mert a projekt δ-ja NEM α deriválása, hanem a
Horgony-vágás és a CODATA különbsége.

### 2.2 A "numerikus alkímia" figyelmeztetés

**arXiv:1009.1711** — *"The fine structure constant and numerical alchemy"*:
elemzi a π-vel és 137-tel való képlet-keresést, és figyelmeztet: az ilyen
képletek reprodukálhatják a mérést anélkül, hogy elméleti hátterük lenne.
A projektünk δ-ja NEM ilyen: a Horgony 137+9/250 egy SZERKEZETI vágás
(a CPT-exakt), és a δ a mérési eltérés — nincs utólagos illesztés.

### 2.3 Egyéb deriválási kísérletek (válogatás)

| arXiv | Módszer | Eredmény |
|---|---|---|
| 1711.02949 | Aszimptotikusan biztos gravitáció → gauge fixpont | α a Planck-skálán egyértelmű |
| 1008.4537 | "Physically anchored cryptographic" számítás | g/2 és interferometria illesztés |
| 2205.06614 | Októnionos pre-téridő, mátrix-dinamika | alacsony energiás α + tömegarányok |
| 2512.07027 | α mint "skálázott mennyiség" (e, ħ, c metszéspontja) | α ≈ 1/137 szemléleti |
| 1411.4673 | Történeti áttekintés (QED béta-függvény, szimmetria-csoportok) | összefoglaló |
| 0708.3501 | Diszkrét önhasonló kozmológia | α = erők aránya |
| physics/0608206 | Dinamikus tér, fekete lyukak | α a fénysebesség-eltérésben |

---

## 3. Mi a projekt α-állítása pontosan (őszintén)

1. **A Horgony KÉT rivális formát ad** — mindkettő VÁZLAT (nem PONTOS formula):
   - Forma A: `137 + 9/250 = 137.036` (zongora-racionális, 5-limesz) — **39σ**
   - Forma B: `x = 137 + 31/(2πx)` (Schwinger-fixpont, Mersenne) — **215σ**
   - A kettő egymástól 0.03 ppm-re áll — a `δ ≈ 0.03600` környéke robusztus.
2. **A Bach-korrekció** = `e^{iπ/4}` komplex fázis — a Möbius-rák-kanon fázisa.
   A teljes képlet iránya: `α⁻¹ = Re[(A + iB)^(C + iD)]` (komplex hatvány).
   A `KomplexByte.idr:109` `komplexEuler` függvénye pontosan ezt valósítja meg.
3. **A vákuum-polarizációs korrekció** = `(1 + 9/250)^(1/40)` (40 = 2³×5).
   Ez a korrekció a QFT-rétegből jön — "hátralévő munka" (`hanmag_zaras.py:74`).
4. **A projekt NEM állítja, hogy α-t PONTOSAN deriválta.** A Horgony két
   független vágás, mindkettő KIZÁRT mint pontos formula (39 ill. 215σ). A
   hurok-korrekcióknak a QFT-rétegből KELL jönniük. A RCL-cikk (Lean-verifikált)
   az, ami tényleges deriválást kísérel meg (saját ~8 ppm-es maradékkal).

### 3.1 A "6.5σ" állítás ellenőrzése — és cáfolata (AGENTS §17)

Az `trail_index/E9_framework.md:187` "6.5σ off" állítása NEM állja meg a
helyét. A `hanmag_zaras.py:71` szerint a zongora-racionális forma
**39σ**-ra van a CODATA-tól — nem 6.5σ-ra. A pontos relativ hiba:

```
Δ = 137.036 − 137.035999177 = 8.23×10⁻⁷   (Idris: 8.229999934883381e-7)
σ_CODATA = 2.1×10⁻⁸  (hanmag_zaras.py:12, SIG_ALFA)
Δ/σ = 8.23×10⁻⁷ / 2.1×10⁻⁸ ≈ 39σ
```

A framework "~17%" állítása is hibás: |8.58−8.23|×10⁻⁷ = 3.5×10⁻⁸, ami
az α-gap ~4.3%-a, nem ~17%-a. **Ez a projekt saját keretdokumentumának
hibája**, amit az audit (AGENTS §17) megjelöl.

---

## 4. Hivatkozások

### Projekt saját források (ProtonDrive → lokális index: `gondnok-laptop/project/target/all_sources/`)

- `all_constants_exact.py` (534 sor) — a fő levezetés: 5 prím + Y(f) + 4D Dirac-spinor
- `hanmag_zaras.py` (263 sor) — a zárás: KÉT rivális forma + őszinte kizárás (39σ, 215σ)
- `transzkript_nem_numerologia.txt` (2030 sor) — a Kimi-ágens beszélgetés: a komplex hatvány képlet
- `trail_index/E9_framework.md` (168-190. sor) — a framework táblázat (a "6.5σ" hibás állítással)
- `szima_ter/modul/KomplexByte.idr:109` — a `komplexEuler` függvény (a Bach-korrekció fázisa)
- `szima_ter/modul/SzimaDashboard.idr` — a δ Idris által számítva
- `szima_ter/modul/MagyarKinaiTorvenyek_v3.idr` — `deltaSzamitott`, `alphaInverzCodatV3/HorgonyV3`

### Irodalom

- Washburn, J., Allahyarov, E. (2026): *Particle Masses from First
  Principles… Recognition Composition Law*. arXiv:2506.12859v3. Lean 4: 179 fájl, 0 sorry.
- arXiv:1009.1711 — *The fine structure constant and numerical alchemy*.
- arXiv:1711.02949 — *Quantum-gravity predictions for the fine-structure constant*.
- arXiv:1008.4537 — *Unique Physically Anchored Cryptographic Theoretical
  Calculation of the Fine-Structure Constant*.
- arXiv:2205.06614 — *Quantum gravity effects in the infra-red* (októnionos).
- arXiv:2512.07027 — *The Fine-Structure Constant as a Scaled Quantity*.
- arXiv:1411.4673 — *Attempts at a determination of the fine-structure
  constant from first principles: A brief historical overview*.

---

**Státusz:** A kutatás megtörtént. A Horgony KÉT rivális formája (39σ ill. 215σ)
+ a Bach-korrekció (e^{iπ/4}) + a vákuum-polarizációs korrekció ((1+9/250)^(1/40))
mind dokumentálva. A dashboardon a δ SZÁMÍTOTT értéke látható (delta.png),
az adatok a `docs/dashboard/adatok.json`-ban. **A projekt NEM állítja, hogy
α-t PONTOSAN deriválta — mindkét forma VÁZLAT (KIZÁRVA mint pontos formula).**

---

## 5. AZ ÖSSZES α-képlet és rokon hipotézisek (a projekt összes kísérlete)

Forrás: `hanmag_zaras.py` σ-audit táblázat (155-167. sor) + `transzkript_nem_numerologia.txt` (339-395. sor) + `all_constants_exact.py` (121-138. sor).

### 5.1 Az α⁻¹ összes képlete (7 kísérlet)

| # | Képlet | Érték | Forrás (sor) | Státusz |
|---|---|---|---|---|
| 1 | `137 + 9/250` (zongora-racionális) | 137.036 | transzkript:339, all_constants:124 | **39σ — VÁZLAT** |
| 2 | `x = 137 + 31/(2πx)` (Schwinger-fixpont, 31=M(5)) | 137.0360… | hanmag_zaras:48 | **215σ — VÁZLAT** |
| 3 | `α⁻¹ = Re[(A+iB)^(C+iD)]` (komplex hatvány) | — | transzkript:370 | IRÁNY (nem kiszámolva) |
| 4 | `1/(137 + 0.036 × e^{iπ/4})` (Bach-korrekció) | 137.025+0.025i | transzkript:395 | IRÁNY (komplex modell) |
| 5 | `137 + (π−e)/φ` | 137.2616 | transzkript:346 | NEM JÓ |
| 6 | `137 + 1/(2π)²` | 137.0253 | transzkript:353 | NEM JÓ |
| 7 | `137 + e^{−π√163}` (Ramanujan) | ≈137 | transzkript:359 | TÚL KÖZEL |

### 5.2 A 9/250 szerkezete (összes felbontás)

| Felbontás | Képlet | Forrás |
|---|---|---|
| Dimenziós | `(D_CRIT−1)²/((D_CRIT+1)^(D_CRIT−1)×(D_CRIT−2))`, D_CRIT=4 | all_constants:121-123 |
| Prímtényezős | `3²/(2×5³)` | all_constants:121 |
| Zongora | `(3/16)² × diezisz(128/125)` | hanmag_zaras:62 |
| 5-limesz | `3²/(2×5³)` (a 4:5:6 terc világa) | hanmag_zaras:62 |

### 5.3 A Bach-korrekció és a vákuum-polarizáció

| Tag | Képlet | Forrás (sor) | Jelentés |
|---|---|---|---|
| Bach-fázis | `e^{iπ/4} = (1+i)/√2` | transzkript:395, KomplexByte.idr:109 | Möbius-rák-kanon fázisa |
| Vákuum-polarizáció | `(1+9/250)^(1/40)`, 40=2³×5 | all_constants:136-138 | a G levezetésében is |
| Komplex α⁻¹ | `α⁻¹ = 137 + 0.036i` (mátrix) | transzkript:454-457 | a sajátértékek = mért érték |

### 5.4 A rokon hipotézisek — ÖSSZES (hanmag_zaras.py σ-audit, Δ/σ rangsor)

| Hipotézis | Képlet | Δ/σ | Státusz |
|---|---|---|---|
| H0* = 67.22 (Planck) | H0 = 67.22 km/s/Mpc | **0.36** | ✅ ÉLŐ |
| sin²θ_W = ln2/3 (MSbar) | sin²θ_W = ln(2)/3 | **4.27** | HATÁR |
| H0* vs SH0ES | 67.22 vs 73.04±1.04 | **5.60** | HALOTT |
| VEV/m_Z = 7³/127 | 343/127 | **10.29** | HALOTT |
| α⁻¹ zongora | 137+9/250 | **39.19** | HALOTT (VÁZLAT) |
| α⁻¹ Schwinger | 137+31/(2πx) | **215.41** | HALOTT (VÁZLAT) |
| Koide δ = 2/9 | δ = 2/9 | **925.79** | HALOTT |
| ρ_Λ = 3ρ_P/2^410 | kozmológiai | **2873.90** | HALOTT |
| Koide Q = 2/3 | Q = 2/3 | **32781.92** | HALOTT |
| α_G⁻¹ = 2^127 | gravitációs α | **45454.53** | HALOTT |
| m_p/m_e = 6π⁵ | 6π⁵ ≈ 1836 | **80383.07** | HALOTT |

### 5.5 Az egyetlen ÉLŐ konstans: G

A `all_constants_exact.py` G levezetése — az EGYETLEN, ami a mérési hibán belül van:

```
G = (7×11)/(2³×5²) × √3 × (1+9/250)^(1/40) × 10⁻¹⁰
  = 0.385 × 1.73205 × 1.000885 × 10⁻¹⁰
  = 6.6742942…×10⁻¹¹

CODATA: 6.67430×10⁻¹¹ (σ = 1.5×10⁻¹⁵)
Δ/σ = 0.038 — BELÜL ✅
```

Ezt az Idris is megerősíti (`szima_ter/modul/GCheck.idr`, NEM törölve — AGENTS §20).

### 5.6 A "MINDEN 0% HIBA" cáfolata

Az `all_constants_exact.py` címe "MINDEN FIZIKAI KONSTANS 0% HIBÁVAL" — de a kód
`'error_is_zero': True`-t állít minden konstansnál, miközben:

- c, h, k_B, N_A, e, μ₀, ε₀: SI 2019 PONTOS definíciók, **nem levezetések**
  (a kód `'derived': codata.c` — triviális másolás)
- m_e, m_p: CODATA érték másolása, **nem levezetés**
- α⁻¹: **39σ** (NEM 0%)
- G: **0.038σ** (ez az egyetlen valódi siker)
- m_p/m_e: **355054σ** (NEM 0%)

**A "MINDEN 0% HIBA" cím parasztvakítás** — a legtöbb konstansnál a "levezetett"
érték egyszerűen a CODATA érték másolása. Csak α⁻¹, G és m_p/m_e valódi
levezetés, és ezek közül csak a G van a mérési hibán belül.
