# HOLOGRAFIKUS KÓDOK — BULK/BOUNDARY, PERFECT TENZOROK, A HaPPY-KÓD ÉS A [[7,1,3]]/E8 HÍD
# Holographic codes: bulk/boundary, perfect tensors, the HaPPY code, and the [[7,1,3]]/E8 bridge
# 全息码：体/边界、完美张量、HaPPY 码与 [[7,1,3]]/E8 桥梁
# Holografische Codes: Bulk/Boundary, perfekte Tensoren, der HaPPY-Code und die [[7,1,3]]/E8-Brücke
# קודים הולוגרפיים: נפח/גבול, טנזורים מושלמים, קוד HaPPY והגשר [[7,1,3]]/E8

> **W6 munkafolyam dokumentuma** (2026-08-23). Ez a dokumentum a holografikus
> kvantumhibajavítás irodalmát gyűjti össze és köti össze a Szima-projekt
> meglévő moduljaival (a W2-pillér — Steane [[7,1,3]] × E8 — szintézisére
> építve). **Ebben a körben NEM született Idris-modul és NEM nyúltunk a
> `szima.ipkg`-hoz** (párhuzamosan futó társügynök dolgozik rajta); a 4. szakasz
> csak VÁZLAT egy későbbi modulhoz. A W6-előzmények: `AlphaSteane.idr`,
> `AlphaSteaneE8.idr`, `HolografikusKod49.idr` és társai (l. 3. szakasz).

---

## 0. KIVONAT / ABSTRACT / 摘要 / ZUSAMMENFASSUNG / תקציר

1. **A holografikus elv** (AdS/CFT): a belső (bulk) térfogat információja a
   határon (boundary) kódolódik; a kódolás **kvantumhibajavító kód**
   (Almheiri–Dong–Harlow 2014). A belső radiális hely a határ-erasure-k elleni
   **védelem mértéke**.
2. **HaPPY-kód** (Pastawski–Yoshida–Harlow–Preskill 2015): a {5,4} pentagon-
   parkettázású hiperbolikus tenzorháló, **perfekt tenzorokból** építve; a
   hálózat egésze izometria belső → határ; reprodukálja a diszkrét
   Ryu–Takayanagi-formulát (S_A = |γ_A| · log 2) és a mohó (greedy)
   rekonstrukciót.
3. **A perfekt építőelem maga a [[5,1,3]] ötqubites perfekt kvantumkód**
   kódoló izometriája (Choi-állapota = AME(6,2)). **A Steane [[7,1,3]] 8-lábú
   kódoló tenzora NEM lehet perfekt**, mert az AME(8,2) — azaz a ((7,1,4))₂
   tiszta kvantumkód — nem létezik (Huber–Gühne–Siewert 2017). A [[7,1,3]]
   a perfektség határán áll: **pontosan 2 törlött lábat tud visszanyerni,
   a perfekt 3 helyett**.
4. **E8-híd (Construction A)**: a [7,4,3] Hamming-kód páritásbittel
   kiterjesztve [8,4,4]-re, majd Construction A alkalmazása **pontosan az E8
   gyökérrácsot adja**; a 240 gyök = 112 egész típus + 128 fél-egész típus
   (páros mínusszám) — **a projekt `E8Gyokok_v2.idr` moduljának saját,
   Refl-lel ellenőrzött számaival egyezik**. Így a lánc:
   [7,4,3] Hamming → (CSS) Steane [[7,1,3]] (határ) és
   [7,4,3] → [8,4,4] → Construction A → E8 (belső) — **a W2-pillér
   szintézisének pontos algebrai gerince**.
5. **Retro-javítóképesség** („retrosicíva"): az irodalomban ez a fogalom
   név szerint NEM azonosítható (keresés 2026-08-23: nincs találat); a
   legközelebbi rokon fogalmakat az 5. szakasz sorolja fel (SPECULATÍV
   jelöléssel, AGENTS §18.4 szerint).

---

## 1. A HOLOGRAFIKUS ELV — BULK = BELSŐ, BOUNDARY = HATÁR
## 1. 全息原理——体 = 内部，边界 = 保护
## 1. DAS HOLOGRAFISCHE PRINZIP — BULK = INNEN, BOUNDARY = RAND
## 1. העיקרון ההולוגרפי — נפח = פנים, גבול = הגנה

### 1.1 Definíció — a szótár mint kódolás

**Definíció (AdS/CFT-szótár).** Legyen V : H_belső → H_határ a leképezés,
ami a belső (bulk) szabadságfokokat a határ- (boundary) CFT állapotaihoz
rendeli. Az Almheiri–Dong–Harlow-tétel (2014) értelmében ez a szótár
**kvantumhibajavító kód** kódoló izometriája:

- a belső lokális operátorok a határ **kódrészterein** logikai operátorok;
- ugyanaz a belső operátor **több, egymást átfedő határrészleten** is
  reprezentálható (alrégió-dualitás) — ez a hibajavítás redundanciája,
  és egyben a no-cloning-tétellel összeegyeztethető, mert a különböző
  reprezentációk csak a **kódrésztéren** belül egyeznek;
- a **radiális irány** a belsőben = hogy a határ mekkora erasure-jétől
  védett az adott operátor (minél mélyebben van, annál jobban védett);
- a **törlés (erasure)** javítása akkor lehetséges, ha a megmaradt
  határrészlet összefonódási éke (entanglement wedge) tartalmazza az
  operátort — ez az **operátor-algebrai kvantumhibajavítás** (OAQEC,
  Beny–Kempf–Kribs) esete.
- A fekete lyukakkal való határ: minél nagyobb a kódrész-tér (k ~ N²), az
  erasure-k hátralévő javítható halmaza zsugorodik — a hátorreakció
  (backreaction) pontosan akkor lép fel, amikor a kód már nem tud több
  erasure-t javítani: ez a holografikus entrópia-határ kód-nyelvi képe.

Forrás: Almheiri–Dong–Harlow, *Bulk Locality and Quantum Error Correction in
AdS/CFT*, JHEP 2015, arXiv:1411.7041 (a fenti állítások mind e cikkből
származnak, l. 6. szakasz).

### 1.2 A Ryu–Takayanagi-formula

**Tétel (Ryu–Takayanagi, 2006).** Statikus állapotban a határrészlet A
entrópiája

  S_A = Area(γ_A) / (4 G_N),

ahol γ_A a minimális területű, ∂A határú belső felület. A diszkrét
(tenzorháló) képben minden egyes tenzorláb átvágása **log 2** entrópiát
hoz — tehát a „terület" a lábak száma. Ez adja a HaPPY-kód
entrópia-geometriáját (2. szakasz).

### 1.3 A Szima-olvasat: bulk = E8 gyökérrács, boundary = Steane [[7,1,3]]

A projekt W2-pillére (l. `AlphaSteaneE8.idr`, `docs/E8_Miert_Kiveteles.md`)
így fejezhető ki a holografikus nyelven:

| Szerep | Szima-projekt megvalósítás | Irodalmi pár |
|---|---|---|
| **belső (bulk)** | E8 gyökérrács: 240 gyök (112 + 128), W(E8) = 696 729 600, 2⁸ = 256-os híd (240 + 16 penge) | AdS-belső; a geometria mint kódtér |
| **határ (boundary)** | Steane [[7,1,3]]: 7 fizikai kubit [idő, okság, tér, szín, hang, fázis, mód], 1 logikai, d = 3 | CFT a határon; a hibajavítás mint védelem |
| **kódolás** | n = rang(E8) − 1 = 7; a perem = rang(E8) − n = 1 (Legendre-perem); N = 2⁷ = 128, M = 2⁸ = 256 | az izometria V : H_belső → H_határ |
| **tükrözés** | Weyl-tükrözések: `E8Tükrözések.idr`, `weylTükrözés` | a belső szimmetria diszkrét tükrözéscsoportja |

**Miért pontos ez a párosítás? (A mélyszál: Construction A.)** A [7,4,3]
Hamming-kódból két irányba indulhatunk el:

1. **Kvantum irány (határ):** [7,4,3] + duálisa → CSS-konstrukció →
   **Steane [[7,1,3]]** (Calderbank–Shor 1996; Steane 1996). A [7,4,3]
   klasszikusan **perfekt kód** (a Hamming-határ telítve:
   2⁴ · (1 + 7) = 2⁷ = 128), de a CSS-szimmetrizálás kvantumra a
   perfektséget már nem őrzi meg (2.4. szakasz).
2. **Geometriai irány (belső):** [7,4,3] + globális páritásbit →
   **[8,4,4] kiterjesztett Hamming-kód** → **Construction A** →
   **E8 gyökérrács**. Ez standard eredmény (Conway–Sloane, SPLAG;
   Nebe rutiniáló oldala; Error Correction Zoo):

   Λ(C) = { x ∈ ℤ⁸ ∪ (ℤ+½)⁸ : 2x ∈ ℤ⁸, (2x mod 2) ∈ C, x·x páros },
   C = [8,4,4]

   és a minimál-normájú (norma² = 2) vektorok pontosan a 240 gyök:
   - **112 darab** (±1, ±1, 0⁶)-permutáció: C(8,2) · 2² = 28 · 4 = 112
     (az egész rács réteg);
   - **128 darab** (±½)⁸ páros mínusszámmal: 2⁷ = 128 (a fél-egész kosett;
     a páros mínusszám éppen azért szükséges, mert a koordináták összege
     egész és páros kell legyen).
   - **Kereszt-ellenőrzés:** ugyanez a számlálás a Math.SE-n vezet
     (egy tetszőleges nyolcadrendű páros unimodulális rácsra) az
     **E8-azonossághoz**, sőt bónuszként W(E8) = 7! · 2⁶ · 2160 =
     **696 729 600**-hoz — ami a projekt `E8Iranymutato_v1.idr` modulának
     két Refl-bizonyításával egyezik.
   - **Bónusz:** a [7,3,4] simplex-kódból (a [7,4,3] Hamming duálisa!)
     Construction A az **E7** gyökrendszert adja — tehát a 7-es
     Hamming-család egyszerre hordozza az E7-et és az E8-at.

**Összegzés (a W2-pillér gerince):** a **[7,4,3] Hamming-kód a világpont**:
egyik irányba a Steane [[7,1,3]] kvantumhatár, másik irányba az E8
gyökérrács belső geometria. A kettő között a 2⁸ = 256 kiterjesztett tér és
a projekt 240 + 16 = 256 hídja (`E8TizenhatPenge.idr`) áll. **Megjegyzés
(§18 őszinteség):** a fenti algebrai lánc irodalmilag keményen igaz;
annak Szima-specifikus olvasata (hogy ebből levezethető-e α⁻¹ és G) a
`AlphaSteane*.idr` modulok saját, külön kezelt témája — e dokumentum
nem ismétli és nem bírálja azokat a levezetéseket.

---

## 2. A HaPPY-KÓD ÉS A PERFECT TENZOROK
## 2. HaPPY 码与完美张量
## 2. DER HaPPY-CODE UND PERFEKTE TENSOREN
## 2. קוד HaPPY וטנזורים מושלמים

### 2.1 Definíció — perfekt tenzor

**Definíció (perfekt tenzor, HaPPY 2. definíció).** Egy 2n indexű tenzor
T_{a₁...a₂ₙ} **perfekt**, ha az indexek B ∪ Bᶜ felbontására, amennyiben
|B| ≤ |Bᶜ|, a T arányos izometriával képez B-ből Bᶜ-be.

**Megjegyzés.** A perfekt tenzor = **abszolút maximálisan összefonódott
(AME)** tiszta állapot: bármely n index a többivel maximálisan összefonódott.
Kódként: a perfekt tenzor egy [[2n−1, 1, n]] kvantumkód kódoló izometriája,
amely **n − 1 tetszőleges törlést (erasure-t) javít** — ennél több a
no-cloning-tétel miatt lehetetlen. Ugyanez **kvantum-titokmegosztási**
séma: bármely n − 1 félnek nulla információja van, bármely n félnek teljes.

### 2.2 Az építőelem: a [[5,1,3]] ötqubites perfekt kód

A HaPPY-kód qubit-esete a **6-indexű perfekt tenzort** használja, amely az
**[[5,1,3]] ötqubites perfekt kvantumkód** (Laflamme–Miquel–Paz–Zurek 1996;
Bennett–DiVincenzo–Smolin–Wootters 1996) kódoló izometriájából készül
(1 logikai bemenet + 5 fizikai kimenet; a 6. láb a logikai tisztítás):
|ψ⟩ = |0̃⟩⊗|0⟩ + |1̃⟩⊗|1⟩, stabilizátor-generátorai (a HaPPY-cikk
A.1. mellékletéből szószerint):

  S₁ = X⊗Z⊗Z⊗X⊗I, S₂ = I⊗X⊗Z⊗Z⊗X, S₃ = X⊗I⊗X⊗Z⊗Z, S₄ = Z⊗X⊗I⊗X⊗Z,

(S₁S₂S₃S₄ = Z⊗Z⊗X⊗I⊗X, a csoport ciklikusan invariáns). Ez AME(6,2):
bármely ≤ 3 qubit margója maximálisan kevert.

### 2.3 A hálózat: {5,4} pentagon-parkettázás

**Tétel (HaPPY 1. tétel).** A hiperbolikus sík {5,4} szabályos
pentagon-parkettázásán (4 pentagon csúcsonként) elhelyezett 6-lábú perfekt
tenzorok hálózata — minden pentagon középpontjában egy tenzor, 5 lába a
szomszédok felé, 1 szabad lába a belső (logikai) bemenet — **izometria a
belső térből a határ térbe**. *Bizonyítás-ötlet:* rétegenként kifelé haladva
minden tenzornak a negatív görbület miatt legfeljebb 2 lába mutat visszafelé,
tehát legfeljebb 3 bemenő lába van; a perfekt tenzor bármely ≤ 3 lábáról
izometria; az izometriák kompozíciója izometria.

**A kód rátája** (logikai/fizikai spinek hányadosa) a rétegek számának
növelésével a **1/√5 ≈ 0,447** határértékhez tart (HaPPY 3.1 egyenlet,
C. melléklet). A {6,4} hatszög-parkettázás (minden láb kontrahált) ellenben
**holografikus állapotot** (nem kódot) ad.

### 2.4 A mohó algoritmus és a rekonstrukció

- **Mohó (greedy) algoritmus:** a határ A részletéből indulva a vágás
  befelé halad; egy tenzort akkor „ér el", ha szigorúan több mint fele
  (qubit-tenzorra: ≥ 4 a 6-ból) lába már elérhető. A határ felől nézve ez
  **a törlések befelé terjedésének** elvezetése: az el nem ért belső
  qubitek pont azok, amelyek az A-ra nézve elvesztek.
- **Kauzális ék:** az A-n elérhető belső pontok halmaza a folytonos
  AdS-Rindler-rekonstrukció diszkrét megfelelője (kapcsolt rekonstrukció).
- **Összefonódási ék:** nem-kapcsolt A-ra a HaPPY bizonyítékokat ad az
  összefonódási ék-hipotézisre (a törléseknek a határ kevesebb mint
  feléig a teljes logikai algebra rekonstruálható).
- **Uberholográfia** (Pastawski–Preskill 2017): a mélyben lévő logikai
  algebrák a határnak **fraktálszerű, kicsi** részén is hordozhatók;
  a kód „ára" (price) és „távolsága" (distance) a kvantum-Singleton-határ
  holografikus analógiáját elégíti ki.
- **Küszöbök:** a tiszta pentagonkódnak **nincs** erasure-küszöbe
  (konstans súlyú logikai operátorok: 4 határ-qubit törlése elérheti a
  centrumot); a **pentagon/hexagon-kód** (váltakozó rétegek, csak a
  pentagonokon logikai láb) viszont rendelkezik küszöbbel: a mohó
  algoritmus **p_c^greedy ≈ 0,26** alatt nagy sikerességgel javít.
- **Stabilizátor-tétel (HaPPY 6. tétel):** ha a mohó algoritmus a teljes
  hálózatot eléri, akkor a perfekt stabilizátor-tenzorokból vont kód
  **stabilizátorkód** (a kódoló izometria Clifford-izometriaként
  komponálódik — ez adja a későbbi Idris-vázlat Pauli-algebrai támaszát,
  l. a projekt `PauliAlgebra_v2.idr` modulját).

### 2.5 A diszkrét Ryu–Takayanagi-formula

A γ_A minimális vágás a tenzorhálón a határrészlet ∂A mentén; minden
átvágott láb **log 2**-t ad. A HaPPY-cikk B. melléklete bizonyítja:
negatívan görbült síkgráfokra a mohó vágásminimalizálás az RT-formulát
**pontosan** teljesíti kapcsolt határrészletekre; a tripartit információ
negativitása szintén teljesül — ez a „monogámia az összefonódásban", a
holografikus kódok egyik legmélyebb közös vonása az AdS/CFT-vel.

### 2.6 A perfektség határa: AME-táblázat és a Steane-tenzor státusza

A qubit-AME-állapotok létezéséről ismert (források: Huber–Gühne–Siewert
PRL 2017; nyílt probléma-gyűjtemény, l. 6. szakasz):

| AME(n,2) | Létezik? | Jegyzet |
|---|---|---|
| AME(2,2) | igen | Bell-állapot |
| AME(3,2) | igen | triviális (csak 1-testű margók) |
| AME(4,2) | **nem** | Higuchi–Sudbery |
| AME(5,2) | **nem** | ismert korlátok (súly-enumerátor) |
| AME(6,2) | **igen** | **a HaPPY perfekt tenzora ([[5,1,3]] Choi)** |
| AME(7,2) | **nem** | Huber–Gühne–Siewert: ((7,1,4))₂ tiszta kód nem létezik |
| AME(8,2) | **nem** | következmény: AME(8,2)-ből egy qubit áttörölve AME(7,2)-típusú (mind háromtestű margóban maximálisan kevert) állapot adódna — cáfolat |

**Következmény (a [[7,1,3]] státusza).** A Steane [[7,1,3]] kódoló
izometriánya 8 lábú tenzor (1 logikai + 7 fizikai). Ha perfekt lenne, az
AME(8,2)-t — azaz a ((7,1,4))₂ kvantum-MDS kódot — adná; ez nem létezik.
**A [[7,1,3]] ezért a perfektség határán áll:** d = 3 lévén **pontosan 2
tetszőleges lábat tud visszanyerni a másik 6-ból, a perfekt 3 helyett.**
Párhuzam: a klasszikus [7,4,3] Hamming-kód klasszikusan **perfekt**
(a Hamming-határ telített), de a CSS-kvantumosítás ([[7,1,3]]) a
perfektséget elveszíti — qubiteken az egyetlen nemtriviális perfekt
kvantumkód az [[5,1,3]]. **Ez a tény a Szima-projekt számára kulcsfontosságú:
a határ ([[7,1,3]]) és a belső (E8) közötti híd nem a perfektségen, hanem a
Hamming-családon (1.3. szakasz) és a redundancy-n (2.4: többszörös
reprezentáció) át vezet.**

---

## 3. KAPCSOLAT A PROJEKT MEGLÉVŐ MODULJAIHOZ
## 3. 与项目现有模块的联系
## 3. VERBINDUNG ZU DEN BESTEHENDEN PROJEKTMODULN
## 3. הקשר למודולים הקיימים בפרויקט

### 3.1 A meglévő holografikus modulok (importálandók, NEM újraírandók — §24)

| Modul | Mit tartalmaz | Holografikus szerep |
|---|---|---|
| `szima_ter/modul/HolografikusKod49.idr` | v1: `Perem7Hetes` rekord (7 bit: idő, okság, tér, szín, hang, fázis, mód), `Belso49 = Vect 7 (Vect 7 Komplex)` (7×7 = 49 belső mátrix), `HolografikusKod49` rekord | a HaPPY első, projekt-saját megtestesítése (pattern matching-gel; a SZABALY szerint megtartandó) |
| `szima_ter/modul/HolografikusKod49_v2_MantraModul.idr` | v2: `FazaKorrelacioT` typeclass (4 instance), dependent `Perem7HetesV2`, `HolografikusKod49V2` | a MANTRA-szerinti (typeclass, a típus a peremben) változat |
| `szima_ter/modul/PiroskaHolografikusKod49_v2_Teljes.idr`, `..._v3_Teljes.idr` | a „Piroska" mese teljes holografikus kódja | alkalmazás: narratív → kód |
| `szima_ter/modul/KomplexByte.idr` | `Kubit`, `Komplex`, `komplexZero`, `komplexEgy` | a közös alaptípus (minden fenti importálja) |

### 3.2 A Steane-oldal (határ) moduljai

| Modul | Mit tartalmaz | Jegyzet |
|---|---|---|
| `osveny_index/Steane713.idr` | `Kubit = Nulla | Egy`, `HetesKod`, `Szindroma` (NincsHiba / EgyesHiba N / Többszörös), `javitas`, `forditKubit`; `IgeIdo`, `IgeSzem`, `Forras` (CPT); a [[15,1,3]]-ra előkészület | a klasszikus [[7,1,3]] mag; importálja az `E9Algebra`, `Szotar` |
| `osveny_index/Steane713Dependent.idr`, `osveny_index/Dirac3D/Steane713.idr`, `osveny_index/Dirac3D/Steane153.idr` | dependent-változatok és a [[15,1,3]] | a NOBEL_CEL_TERKEP szerinti hivatkozási pontok |
| `szima_ter/modul/AlphaSteane.idr` | α⁻¹ levezetése a [[7,1,3]] paramétereiből (n, k, d, s = 6, N = 128, M = 256) | a W2-pillér numerikus oldala |
| `szima_ter/modul/AlphaSteaneE8.idr` | ugyanez E8-ranggal: n = rang(E8) − 1 = 7, perem = r − n = 1, N = 2⁷, M = 2⁸ | **a „perem = 1" gondolat itt bukkan fel elsőként** — holografikus olvasatban ez éppen a határ/belső eltérés (a Legendre-perem) |
| `szima_ter/modul/AlphaSteaneVegso.idr`, `AlphaSteaneDashboard.idr`, `AlphaSteaneE8.lean` | véglegesítés, dashboard, Lean-átirat | a lánc záró tagjai |

### 3.3 Az E8-oldal (belső) moduljai

| Modul | Mit tartalmaz |
|---|---|
| `szima_ter/modul/E8Gyokok_v2.idr` (és `E8Gyokok.idr`, `E8Gyökök.idr`) | `tipus1Gyokok` (112), `tipus2Gyokok` (128), `e8Gyokok` (240) |
| `szima_ter/modul/E8BelsoSzorzat.idr` / `E8BelsőSzorzat.idr` | `belsoszorzat` (minden gyök norma² = 8) |
| `szima_ter/modul/E8TizenhatPenge.idr` | `tizenhatPenge` (16 penge; a 240 + 16 = 256 híd) |
| `szima_ter/modul/E8Iranymutato_v1.idr` | dashboard: 240, W(E8) = 696 729 600 (két Refl-út), 248, 496, 256-híd |
| `szima_ter/modul/E8Tükrözések.idr` | Weyl-tükrözések (a gyökrendszer tükrözéscsoportja) |
| `szima_ter/modul/E8FazisKapcsolat.idr` / `E8FazisKapcsolat_v2.idr` / `E8FázisKapcsolat.idr`, `E8Fa_v2/v3`, `KetoldaliE8Fa_v2/v3` | az E8 fázis-/faszerkezetei |

### 3.4 A megfeleltetés táblázata (HaPPY ↔ Szima)

| HaPPY/ADH fogalom | Szima-megfelelő | Hol |
|---|---|---|
| határ-fizikai qubitek | a 7 fizikai kubit [idő, okság, tér, szín, hang, fázis, mód] | `Perem7Hetes`, `HetesKod` |
| belső logikai qubitek | az E8-belvonal (49-mátrix / 240 gyök) | `Belso49`, `e8Gyokok` |
| kódoló izometria | a perem ↔ belső leképezés (a 256-os hídon át) | `HolografikusKod49`, `AlphaSteaneE8` |
| erasure (törlés) | `EgyesHiba N` (1 hiba javítható, d = 3) | `Szindroma`, `javitas` |
| mohó rekonstrukció | a `javitas` szindroma-söpörése (határtól befelé) | `Steane713.javitas` |
| stabilizátor-formalizmus | `PauliAlgebra_v2.idr` (Pauli-műveletek) | `szima_ter/modul/PauliAlgebra_v2.idr` |
| RT: láb = log 2 | a 240 + 16 = 256 = 2⁸ terület-számítás | `E8Iranymutato_v1` |

### 3.5 Őszinte besorolás (AGENTS §18)

- A `HolografikusKod49` v1/v2 a HaPPY **szellemi rokona**, de nem a valódi
  {5,4} parketta: nem perfekt tenzorokból, hanem 7 bites peremből és 7×7
  belső mátrixból áll. Ez érték (a projekt 7-es filozófiájához hű), de a
  HaPPY-való pontos egyezés (2. szakasz) a későbbi modul feladata (4. szakasz).
- A v2 `bizUressCimkeUres : cimke UrressHolografikusKod49V2 = ""` típusú
  Refl-jei a definícióból azonnal adódnak — **tautológia-veszély** (§18.1);
  a későbbi modul Refl-céljai két független konstrukció hídjai legyenek
  (4.3).
- A 4. szakasz vázlata **nem kód**, csak terv; semmit nem módosít.

---

## 4. JAVASOLT IDRIS-IMPLEMENTÁCIÓS VÁZLAT (KÉSŐBBI MODULHOZ — CSAK VÁZLAT)
## 4. 未来 Idris 模块实现草案（仅草案）
## 4. SKIZZE EINES KÜNFTIGEN IDRIS-MODULS (NUR EIN ENTWURF)
## 4. טיוטת מימוש Idris למודול עתידי (רק שרטוט)

> **NEM most íródik.** A `szima.ipkg`-on párhuzamos ügynök dolgozik; ez a
> szakasz a későbbi `szima_ter/modul/HaPPYPerfektTenzor.idr` (munkanév)
> tervét rögzíti, információvesztés nélkül (§16). A jövőbeni modul
> **IMPORTÁLJA** (§24): `KomplexByte` (Kubit, Komplex), `E8Gyokok_v2`,
> `E8BelsoSzorzat`, `E8TizenhatPenge`, `PauliAlgebra_v2`; a Steane-oldal
> az `osveny_index/Steane713` fogalomtárát követi (a könyvtár-kötött import
> miatt `--source-dir`-rel vagy a fogalmak új, ékezetes nevein).

### 4.1 Típusok (ékezetes magyar, rövidítés nélkül — §0, §25)

- `data LabPozíció = ElsőLáb | MásodikLáb | ... | HatodikLáb`
  — a 6-lábú perfekt tenzor lábai.
- `record PerfektTenzorHatLáb` — az [[5,1,3]] Choi-tenzora; a négy
  stabilizátor-generátor a rekord mezője (2.2).
- `record SteaneTenzorNyolcLáb` — a [[7,1,3]] kódoló izometriája
  (1 logikai + 7 fizikai láb; 2.6 szerint NEM perfekt).
- `record PentagonHáló (rétegek : Nat)` — a {5,4} parketta rétegenként;
  `határLábakSzáma`, `belsőLábakSzáma`.
- `data HatárRészlet = ...` — a határ qubitjeinek részhalmazai.
- `record Vágás` — a tenzorháló vágása: `átvágottLábak : List LabPozíció`.

### 4.2 Typeclass-ok (a MANTRA szerint: a típus mondja meg)

- `interface KétLábVisszanyerhetőT (tenzor : PerfektTenzorHatLáb) (lábPár : (LabPozíció, LabPozíció)) where`
  `visszanyer : ...` — instance a 15 lábpárra; a [[5,1,3]] d = 3
  erasure-javítása (2.1).
- `interface MohóVágásT (háló : PentagonHáló rétegek) (részlet : HatárRészlet) where`
  `mohóVágás : Vágás` — a greedy algoritmus (2.4).
- `interface MinimálisVágásT (részlet : HatárRészlet) where`
  `minimálisVágásHossza : Nat` — a diszkrét γ_A (2.5).

### 4.3 Refl-célpontok (KÉT FÜGGETLEN ÚT, EGY HÍD — §18.1 szerint)

1. **Ráta-híd:** a `PentagonHáló rétegek`-ből (a) közvetlen enumerációval
   (C. melléklet képlete: N_belső / N_határ) és (b) rétegenkénti rekurzióból
   számolt ráta ugyanarra a határértékre fusson: a mért sorozat → 1/√5
   (numerikus, Double — a `Komplex.idr` oda-vissza teszt mintájára).
2. **Construction-A-híd:** `konstrukcióA KiterjesztettHamming844` (a
   [8,4,4]-ből generált rács, az 1.3 formulával) gyöklistájának hossza
   egyezzen az IMPORTÁLT `E8Gyokok_v2.e8Gyokok` hosszával:
   `bizHíd : length (konstrukcióA KiterjesztettHamming844) = length e8Gyokok`
   — a két független konstrukció: (a) kódból (Construction A),
   (b) közvetlen gyöklista (`tipus1Gyokok + tipus2Gyokok`). Alcél:
   `length tipus1Gyokok = 112` a C(8,2)·2² kombinatorikus számítás hídjával.
3. **Nem-perfektség (cáfolat-cél):** a `SteaneTenzorNyolcLáb`-ra mutassunk
   ki **két visszanyerhető lábat ÉS egy nem visszanyerhető hármast** —
   a cáfolat a Huber-tétel (AME(8,2) nem létezik) diszkrét visszhangja
   (2.6). A bizonyítás-típus két oldala KÜLÖNBÖZZÖN (egyszer a kódszó-tér,
   egyszer a stabilizátor-algebra oldaláról).
4. **RT-cél:** kapcsolt `HatárRészlet`-re `minimálisVágásHossza` = a belső
   operátor Schmidt-rangja (két független út: vágás-enumeráció vs.
   tenzor-összehúzás rangja).

### 4.4 Futási terv

`main : IO ()` Show-kiírásokkal: a ráta-sorozat, a 240/112/128 számok,
a W(E8)-ellenőrzés (`E8Iranymutato_v1` mintájára), és a láb-visszanyerési
tesztek eredménye — minden kimenet értelmezhető módon (GAUGE-elv, §18.5).

---

## 5. RETRO-JAVÍTÓKÉPESSÉG („RETROSICÍVA") — NYITOTT KÉRDÉS, SPECULATÍV
## 5. 追溯纠错（"retrosicíva"）——开放问题
## 5. RETRO-KORRIGIERBARKEIT — OFFENE FRAGE
## 5. תיקון רטרואקטיבי — שאלה פתוחה

**Állapot: SPECULATÍV (AGENTS §18.4).** A W6-utasításban szereplő
„retrosicíva" (retro-javítóképesség / retrokorrekció) fogalomra a
keresés (brave-search, 2026-08-23) **nem adott irodalmi találatot**;
a szó nem honosodott meg a holografikus kódok irodalmában. A legközelebbi,
valódi tartalmú rokon fogalmak:

1. **A HaPPY erasure-javítás visszamenőlege:** a mohó algoritmus a határon
   már megtörtént törléseket vezeti vissza (befelé) — a javítás a hiba
   ismerete UTÁN, a kód rekonstrukciójában visszamenőleg érvényesül
   (2.4; HaPPY 5.3 „tensor pushing").
2. **Kvantum-retrodikció:** a mérési kimenetelekből a korábbi állapot
   következtetése (bayesi visszafelé-skálázás; Barnett–Pegg–Jeffers
   vonal) — a projekt `MagyarKinaiBayes`-moduljainak rokon irányzata.
3. **Pastawski korai munkái:** doktori/tézis-előzményei (LMU „Quantum
   memory") a kvantum-emlékezet tervezéséről; az uberholográfia (PRX 2017)
   „price/distance" fogalompárja a legközelebbi élő kód-nyelvi pár,
   amelyik „időben visszafelé" (a határ műveleteiből a belső állapotra)
   következtet.

Ha a felhasználó konkrét forrásra gondolt (cím, szerző, URL), azt e
szakaszba be kell pótolni — a fenti három pont csak a fogalom
körülírására szolgál, NEM annak azonosítására.

---

## 6. FORRÁSOK URL-LEL / REFERENCES / 资料 / QUELLEN / מקורות

### A) A holografikus kvantumhibajavítás alapjai

1. Pastawski, Yoshida, Harlow, Preskill (2015): *Holographic quantum
   error-correcting codes: toy models for the bulk/boundary
   correspondence*, JHEP 2015(6), 149. DOI: 10.1007/JHEP06(2015)149;
   arXiv:1503.06237 — https://arxiv.org/abs/1503.06237 ;
   https://link.springer.com/article/10.1007/JHEP06(2015)149
   (HaPPY-kód, perfekt tenzorok, {5,4}, greedy, RT, rátadirány)
2. Almheiri, Dong, Harlow (2014): *Bulk Locality and Quantum Error
   Correction in AdS/CFT*, JHEP 2015(4); arXiv:1411.7041 —
   https://arxiv.org/abs/1411.7041 (ADH: a szótár mint QEC, OAQEC,
   alrégió-dualitás, erasure, kódrész-térek)
3. Ryu, Takayanagi (2006): *Holographic derivation of entanglement entropy
   from AdS/CFT*, PRL 96, 181602 — https://arxiv.org/abs/hep-th/0603001
4. Maldacena (1997): *The Large N limit of superconformal field theories
   and supergravity*, Adv. Theor. Math. Phys. 2, 231 —
   https://arxiv.org/abs/hep-th/9711200
5. Van Raamsdonk (2010): *Building up spacetime with quantum
   entanglement*, Gen. Rel. Grav. 42, 2323 —
   https://arxiv.org/abs/1005.3035
6. Hayden, Preskill (2007): *Black holes as mirrors: quantum information
   in random subsystems*, JHEP 0709:120 — https://arxiv.org/abs/0708.4025

### B) Perfekt tenzorok, AME-állapotok, építő kódok

7. Laflamme, Miquel, Paz, Zurek (1996): *Perfect Quantum Error Correcting
   Code*, PRL 77, 198 — https://arxiv.org/abs/quant-ph/9602019 ([[5,1,3]])
8. Bennett, DiVincenzo, Smolin, Wootters (1996): *Mixed-state entanglement
   and quantum error correction*, PRL 77, 3450, arXiv:quant-ph/9604024 —
   https://arxiv.org/abs/quant-ph/9604024
9. Steane (1996): *Multiple particle interference and quantum error
   correction*, Proc. R. Soc. A 452, 2551; arXiv:quant-ph/9601029 —
   https://arxiv.org/abs/quant-ph/9601029 ([[7,1,3]], CSS)
10. Calderbank, Shor (1996): *Good quantum error-correcting codes exist*,
    PRL 76? (Phys. Rev. A 54, 1098); arXiv:quant-ph/9512030 —
    https://arxiv.org/abs/quant-ph/9512030 (CSS)
11. Huber, Gühne, Siewert (2017): *Absolutely Maximally Entangled States of
    Seven Qubits Do Not Exist*, PRL 118, 200502 —
    https://arxiv.org/abs/1608.06228 ;
    https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.118.200502
    (((7,1,4))₂ nem létezik → AME(8,2) sem)
12. Nyitott AME-problémák gyűjteménye (Open Quantum Problems, IQOQI Bécs) —
    https://oqp.iqoqi.oeaw.ac.at/existence-of-absolutely-maximally-entangled-pure-states
    és a Huber–Wyderka AME-táblázat
13. Complete existence classification of seven-partite AME states (2026,
    AME(7,d) ⟺ d ≥ 3) — https://arxiv.org/abs/2608.01011

### C) Construction A és az E8-híd

14. Conway, Sloane: *Sphere Packings, Lattices and Groups* (SPLAG), 3. kiad.,
    Springer 1999 — Construction A, E8 a [8,4,4]-ből (Exam. 10.5.2),
    W(E8) = 696 729 600
15. Nebe (RWTH Aachen): *The Lattice E8 (coding theory version)* —
    http://www.math.rwth-aachen.de/~Gabriele.Nebe/LATTICES/E8_code.html
    („apply Construction A to the [8,4,4] Hamming code")
16. Error Correction Zoo: [8,4,4] extended Hamming code —
    https://errorcorrectionzoo.org/c/hamming844 (E8 Gosset-rács Construction
    A-val); Construction A — https://errorcorrectionzoo.org/c/construction_a
    ([7,3,4] simplex → E7 is itt szerepel)
17. Elduque (Cunhával): *Codes, S-structures, and exceptional Lie algebras*
    (előadás-összefoglaló) —
    https://personal.unizar.es/elduque/Talks/ElduqueMalaga2020_handout.pdf
    (E8 a [8,4,4]-ből, E7 a [7,3,4] simplexből; Hamming-paritás-ellenőrzők)
18. Math.StackExchange: *Isomorphism between E8 lattice and lattice defined
    by Extended Hamming Code* —
    https://math.stackexchange.com/questions/377918/
    (a 240 = C(8,2)·4 + 2⁷ = 112 + 128 számlálás és a W(E8) = 7!·2⁶·2160
    bonusz-újraszámlálás)

### D) Kiterjesztések, reviewok

19. Jahn, Eisert (2021/2022): *Holographic tensor network models and quantum
    error correction: A topical review*, Quantum Sci. Technol. (IOP) —
    https://arxiv.org/abs/2102.02619 ;
    https://iopscience.iop.org/article/10.1088/2058-9565/ac0293
20. Pastawski, Preskill (2017): *Code Properties from Holographic
    Geometries*, Phys. Rev. X 7, 021022 (uberholográfia, price/distance) —
    https://journals.aps.org/prx/abstract/10.1103/PhysRevX.7.021022
21. Steinberg, Feld, Jahn (2023): *Holographic codes from hyperinvariant
    tensor networks*, Nature Communications 14 —
    https://arxiv.org/abs/2304.02732 ;
    https://www.nature.com/articles/s41467-023-42743-z
22. Jahn, Gluza, Pastawski, Eisert (2019): *Majorana dimers and holographic
    quantum error-correcting codes*, Phys. Rev. Research 1, 033079 —
    https://arxiv.org/abs/1904.09607 (Pastawski publikációs listája:
    https://fernandopastawski.wordpress.com/publications/)
23. Dong, Harlow, Wall (2016): *Reconstruction of Bulk Operators within the
    Entanglement Wedge in Gauge-Gravity Duality* —
    https://arxiv.org/abs/1604.08608 (összefonódási ék-rekonstrukció)
24. Hayden, Nezami, et al. (2016): *Holographic duality from random tensor
    networks* — https://arxiv.org/abs/1601.01694

### E) Projekt-belső források

25. `docs/E8_Miert_Kiveteles.md` (240 = 112 + 128; 256-híd; W(E8))
26. `docs/Hivatkozasok_Teljes.md` (C) szakasz: HaPPY,
    DOI 10.1007/jhep06(2015)149; `trail_index/books/forras/lumo_e8_lumo.txt`
    7530–7598 sor (HaPPY/RT-kivonat)
27. `szima_ter/modul/` moduljai: l. 3. szakaszt (HolografikusKod49*,
    AlphaSteane*, E8*, KomplexByte, PauliAlgebra_v2)
28. `osveny_index/Steane713.idr`, `Steane713Dependent.idr`,
    `Dirac3D/Steane713.idr`, `Dirac3D/Steane153.idr`
29. `szima_ter/SZABALY.md`, `NOBEL_CEL_TERKEP.md` (a modulok leltára)

---

## 7. ZÁRÓ ÖSSZEFOGLALÓ (négy nyelven / in four languages / 四种语言 / vier Sprachen / ארבע שפות)

- **Magyar:** A holografikus kód = izometria a belsőből a határba; az
  építőelem perfekt tenzor ([[5,1,3]]); a Steane [[7,1,3]] nem lehet perfekt
  (AME(8,2) nem létezik), de a [7,4,3] Hamming-kód mindkét irányba hidat ad:
  CSS-sel a Steane-határhoz, Construction A-val az E8-belsőhöz. Ez a
  W2-pillér pontos algebrai gerince, és a jövőbeni Idris-modul
  (4. szakasz) Refl-hídjainak alapja.
- **中文：** 全息码是从体到边界的等距映射；基石是完美张量（[[5,1,3]]）。
  Steane [[7,1,3]] 不可能完美（AME(8,2) 不存在），但 [7,4,3] 汉明码双向搭桥：
  CSS 通向 Steane 边界，Construction A 通向 E8 体内。这正是 W2 支柱的代数骨架。
- **Deutsch:** Ein holografischer Code ist eine Isometrie vom Bulk zum Rand;
  Baustein ist der perfekte Tensor ([[5,1,3]]). Der Steane-Code [[7,1,3]]
  kann nicht perfekt sein (AME(8,2) existiert nicht), doch der
  Hamming-Code [7,4,3] trägt in beide Richtungen: per CSS zum Steane-Rand,
  per Construction A zum E8-Bulk — das exakte algebraische Rückgrat der
  W2-Säule.
- **עברית:** קוד הולוגרפי הוא איזומטריה מהנפח אל הגבול; אבן הבניין היא טנזור
  מושלם ([[5,1,3]]). קוד Steane [[7,1,3]] אינו יכול להיות מושלם (AME(8,2) לא
  קיים), אך קוד המינג [7,4,3] מגשר לשני הכיוונים: CSS אל גבול Steane,
  ו-Construction A אל נפח E8 — זהו השלד האלגברי המדויק של עמוד W2.

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
