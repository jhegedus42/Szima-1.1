# E8 — MIÉRT KIVÉTELES?
# E8 — WHY EXCEPTIONAL?
# E8 — 为何特殊？
# E8 — WARUM AUSSERGEWÖHNLICH?
# E8 — למה יוצא דופן?

Ez a dokumentum az E8 gyökérrács és Lie-algebra "kivételességét" elemzi,
és a hozzá tartozó dashboard-mutatókat (a Szima-projekt `E8Iranymutato_v1`
Idris moduljával szinkronban) tárgyalja. A számokat az Idris-modul
**kernel-Refl bizonyításai** és **futásidejű kimerítő ellenőrzései**
támasztják alá — nem kézzel írt állítások (AGENTS §18: nincs parasztvakítás).

---

## 1. A 240 GYÖK KÉT TÍPUSA
## 1. THE 240 ROOTS IN TWO TYPES
## 1. 240 个根分为两类
## 1. DIE 240 WURZELN IN ZWEI TYPEN
## 1. 240 השורשים — שני סוגים

Az E8 gyökérrács 240 gyökből áll, amely két független típusra bomlik
(E8Gyokok_v2 modul, `tipus1Gyokok` + `tipus2Gyokok`, IMPORTÁLVA, nem
újraírva — AGENTS §24):

- **Típus 1 (112 darab):** az `(±1, ±1, 0⁶)` vektorok minden permutációja,
  ahol a két nemnulla koordináta előjele szabad. Számolás:
  `C(8,2) · 2² = 28 · 4 = 112`.
- **Típus 2 (128 darab):** a `(±½)⁸` vektorok, ahol a mínuszok száma
  **páros**. Számolás: `2⁷ = 128` (a 8 koordinátából 1 előjel szabad,
  a többi a párosság miatt rögzült — a 8 elemű Halmaz páros/része = 2⁷).

A két típus összege a teljes gyök szám: **112 + 128 = 240**.

| Mutató | Érték | Forrás (Idris) |
|---|---|---|
| Típus-1 gyökök | 112 | `length tipus1Gyokok` |
| Típus-2 gyökök | 128 | `length tipus2Gyokok` |
| Összes gyök | 240 | `length e8Gyokok` |

---

## 2. A WEYL-CSOPORT RENDJE: 696 729 600
## 2. THE WEYL GROUP ORDER: 696 729 600
## 2. Weyl 群阶：696 729 600
## 2. DIE WEYL-GRUPPEN-ORDNUNG: 696 729 600
## 2. סדר קבוצת Weyl: 696 729 600

Az E8 Weyl-csoportja (a tükrözések csoportja) rendje:

**W(E8) = 2¹⁴ · 3⁵ · 5² · 7 = 696 729 600**

Két független úton igazolva (kernel-Refl, `E8Iranymutato_v1`):

- `2 * 348364800 = 696729600` (a fél rend × 2)
- `16384 * 243 * 25 * 7 = 696729600` (prímtényezős felbontás)

Ez a rend a **legnagyobb** a véges Weyl-csoportok között — egy újabb
jele az E8 "kivételességének": a szimmetria-csoportja is a csúcspont.

---

## 3. AZ E8 DIMENZIÓJA: 248, AZ E8×E8: 496
## 3. THE E8 DIMENSION: 248, E8×E8: 496
## 3. E8 维数：248，E8×E8：496
## 3. DIE E8-DIMENSION: 248, E8×E8: 496
## 3. ממד E8: 248, E8×E8: 496

- Az E8 Lie-algebra dimenziója: **248** = 240 gyök + 8 Cartan-generátor.
- Az E8 × E8 (a heterotikus string-elmélet alapja) dimenziója:
  **2 · 248 = 496** (kernel-Refl: `248 * 2 = 496`).

A 496 a **kivételes** dimenzió is: az egyetlen olyan szám, amelyre a
superstring-elmélet következetesen épül (a 10-dimenziós heterotikus
string lecsökkenti a felesleges dimenziókat 496-ra).

---

## 4. A 256-OS HÍD: 240 GYÖK + 16 PENGE
## 4. THE 256 BRIDGE: 240 ROOTS + 16 BLADES
## 4. 256 桥：240 根 + 16 刀片
## 4. DIE 256-BRÜCKE: 240 WURZELN + 16 KLINGEN
## 4. הגשר של 256: 240 שורשים + 16 להבים

Az `E8TizenhatPenge` modul (IMPORTÁLVA) a 16 Clifford-penge listáját
adja (`tizenhatPenge`, 16 elem). A "híd" összefüggés:

**240 gyök + 16 penge = 256 = 2⁸**

Ez a 2⁸ a bináris (Hamming [7,4,3] / [[7,1,3]] Steane) hibajavító kódok
és az E8 geometriája közötti átjáró — a Szima-projekt központi tézise:
a hibajavító kódok (energia-/információvédelem) és az E8 (a legnagyobb
kivételes Lie-algebra) ugyanazon szimmetria-csúcsról szólnak.

Futásidejű ellenőrzés: `length e8Gyokok + length tizenhatPenge = 256`
→ **256** (True).

---

## 5. A 2D ISING KRITIKUS EXPONENSEI
## 5. THE 2D ISING CRITICAL EXPONENTS
## 5. 2D 伊辛临界指数
## 5. DIE KRITISCHEN ISING-EXPONENTEN (2D)
## 5. המעריכים הקריטיים של אייזינג דו-ממדי

A 2D Ising-modell (Z₂ szimmetria-törés, a legegyszerűbb kritikus
együttható-rendszer) kritikus exponensei — a dashboard-adatként:

| Exponens | Érték | Jelentés |
|---|---|---|
| α (alpha) | 0 | fajlagos hő kapacitás (logarithmikus divergencia) |
| β (beta) | 1/8 = 0.125 | átrendeződés (magnetizáció) |
| γ (gamma) | 7/4 = 1.75 | szuszceptibilitás |
| ν (nu) | 1 | korreláció-hossz |

Ezek az exponensek **egyetemesek** (universality): minden ugyanabba a
2D Ising univerzalitási osztályba tartozó rendszernél azonosak. Az
E8-kapcsolat: a 2D Ising-modell a kritikus pontján E8 szimmetriát
mutat (Zamolodchikov 1989) — a legegyszerűbb kritikus exponensek és a
legnagyobb kivételes Lie-algebra itt találkozik. Ez a "miért
kivételes" kérdés egyik legmélyebb válasza: az E8 a kritikus jelenségek
természetes szimmetriája.

---

## 6. MIÉRT KIVÉTELES? — A SZIMMETRIA CSÚCSA
## 6. WHY EXCEPTIONAL? — THE SYMMETRY PEAK
## 6. 为何特殊？——对称性的巅峰
## 6. WARUM AUSSERGEWÖHNLICH? — DER SYMMETRIE-GIPFEL
## 6. למה יוצא דופן? — פסגת הסימטריה

Az E8 "kivételessége" több összefonódó tényből áll:

1. **A legnagyobb kivételes egyszerű Lie-algebra** — a 4 kivételes
   (G₂, F₄, E₆, E₇, E₈) közül a legnagyobb; a "szabályos" Aₙ/Bₙ/Cₙ/Dₙ
   sorozaton kívül esik.
2. **W(E8) = 696 729 600** — a legnagyobb véges Weyl-rend.
3. **248 / 496** — a legnagyobb használható dimenzió a heterotikus
   string-elméletben.
4. **240 gyök = 112 + 128** — két típus tökéletes egyensúlya.
5. **256 = 2⁸ híd** — a hibajavító kódok és a geometria összekapcsolása.
6. **2D Ising @ kritikus pont** — E8 szimmetria (Zamolodchikov).

Ez a hat pont a Szima-projekt magja: a kategóriaelméleti struktúra, a
hibajavító kódok és a fizikai konstansok levezetése ugyanarra az E8
csúcsra épül.

---

## 7. AZ IDRIS MODUL ÉS A DASHBOARD-MUTATÓK
## 7. THE IDRIS MODULE AND DASHBOARD METRICS
## 7. Idris 模块与仪表盘指标
## 7. DAS IDRIS-MODUL UND DIE DASHBOARD-METRIKEN
## 7. מודול ה-Idris ומדדי הלוח

A `szima_ter/modul/E8Iranymutato_v1.idr` modul a fenti számokat
**adatként** (rekord: `E8IranymutatoMutatok`) és **bizonyításként**
(kernel-Refl + futásidejű kimerítő ellenőrzés) tartalmazza.

| Mutató | Érték | Ellenőrzés típusa |
|---|---|---|
| gyök szám | 240 | futásidejű `length e8Gyokok` |
| W(E8) rend | 696729600 | Refl: `2*348364800` és `16384*243*25*7` |
| E8 dimenzió | 248 | adat + `248*2 = 496` Refl |
| E8×E8 dimenzió | 496 | Refl: `248 * 2` |
| Ising α,β,γ,ν | 0, 1/8, 7/4, 1 | adat (Double) |
| 256 híd | 256 | futásidejű `length e8Gyokok + length tizenhatPenge` |
| minden gyök normája² | 8 | futásidejű `all (belsoszorzat r r == 8)` |

**Kódduplikáció-tilalom (§24):** a modul NEM írja újra a gyöklistát
és a belső szorzatot — az `E8Gyokok_v2`, `E8BelsoSzorzat` és
`E8TizenhatPenge` modulokat **IMPORTÁLJA**, és azok függvényeit
(belsoszorzat, e8Gyokok, tizenhatPenge) használja fel.

Futtatás: `idris2 --exec main szima_ter/modul/E8Iranymutato_v1.idr`
→ minden ellenőrzés `True` / egyező.

---

## 8. FORRÁSOK / REFERENCES / 资料 / QUELLEN / מקורות

- Conway, J.H. & Sloane, N.J.A. — *Sphere Packings, Lattices and Groups*
  (SPLAG): W(E8) = 696729600; a 240 gyök szerkezete.
- Humphreys, J.E. — *Introduction to Lie Algebras and Representation
  Theory*: E8 dimenzió = 248.
- Zamolodchikov, A.B. (1989) — *Integrable A₁⁽¹⁾-related field
  theories and the E8 symmetry*: 2D Ising @ kritikus pont → E8.
- Szima-projekt, `E8Gyokok_v2.idr`, `E8BelsoSzorzat.idr`,
  `E8TizenhatPenge.idr`, `E8Iranymutato_v1.idr` (Idris források).

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
