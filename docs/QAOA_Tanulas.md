# QAOA — tanulási dokumentum v1
## 量子近似优化算法学习文档 v1 · Lern-Dokument: QAOA v1 · מסמך למידה: QAOA v1

**Készült:** 2026-08-24 · **Készítette:** general ügynök (Szima-projekt)
**Feladat:** a Quantum Approximate Optimization Algorithm kutatása; CSAK EZ AZ
EGY ÚJ FÁJL íródott — nem készült Idris-modul, nem volt commit, nem volt push.

---

## 0. Olvasott alapanyag és módszer · 已读材料与方法 · Gelesene Grundlage und Methode · חומר הבסיס שנקרא

A dokumentum írása ELŐTT elolvastuk (§N11):

- `AGENTS.md` (gyökér) — §17 (mérési hiba / Δσ-őszinteség), §18 (tautológia
  tilos; „bizonyított vs. javaslat" külön jelölése), §22 (négy nyelv),
  §24 (kód duplikáció tilos — import!), §25 (ékezetes magyar);
- `docs/EvoluciosAlgoritmusos…` pontosabban **`docs/EvoluciosAlgoritmusok_Tanulas.md`**
  teljes egészében — különösen a **§3** (kvantum evolúció: Han–Kim 2000,
  QEA/QIGA, a unitér kapuk reverzibilitása) és a **§4** (termodinamikai
  költség: Landauer-elv, Kolchinsky-kötés, Carnot-négylépés ütemező) —
  valamint az ottani `EvolutivKereso_v1` vázlat (§5.8);
- `szima_ter/modul/E8BelsoSzorzat.idr` — a `weylReflexio : E8Gyok ->
  E8Gyok -> E8Gyok` definíció (99. sor körül: σ_α(β) = β − (⟨α,β⟩/4)·α),
  a zártsági mérés (`zarasHibakSzama`, 57 600 reflexió);
- `szima_ter/modul/GyokSzo_v1.idr` — `jelentésTávolság`,
  `HasonlóságÖtSzint`, `alapszókincs` (240 szó) — a fitness második része;
- `szima_ter/modul/FazisAlgebra_v2.idr` — `ToltesParitasIdo`,
  `fazisFaktorialis` — a fitness első része;
- `szima_ter/modul/CarnotCiklus_v1.idr` — `landauerKüszöb`
  (300.0 K-en 2,87×10⁻²¹ J/bit — a §4-es szakaszban IMPORTÁLT értékként
  hivatkozunk rá, §24 szerint NEM újraszámolva).

A kutatás módszere (§N12): előre megtervezett MCP-keresések —

1. **alphaxiv_answer_pdf_queries** a Farhi–Goldstone–Gutmann eredeti
   cikkére (arXiv:1411.4028) — négy kérdéssel: állapot-definíció,
   p-mélység és p→∞ határ, MaxCut-eredmények, paraméter-optimalizálás;
   a cikk TELJES PDF-szövegét visszakaptuk (16 oldal);
2. **scite_search_literature** — (a) „quantum approximate optimization
   algorithm traveling salesman problem QAOA" (2 214 589 találati korpuszból
   10 releváns cikk), (b) „Ising formulations of many NP problems traveling
   salesman QUBO penalty terms Lucas";
3. **alphaxiv_discover_papers** — „comparison of QAOA, variational quantum
   eigensolver VQE and adiabatic quantum computation";
4. **brave-search_brave_web_search** — Landauer-elv + reversibilitas +
   dekoherencia + mérés költsége.

Minden állítás forrását az 5. szakasz jegyzéke sorolja. Ahol a bizonyítás
szintje nem egyértelmű, ott **[BIZONYÍTOTT]** / **[IRODALMI KÖZLÉS]** /
**[JAVASLAT]** jelölést használunk (§18 őszinteség, §17-kompatibilis).

---

## 1. A QAOA anatómia · QAOA 的解剖 · Die Anatomie des QAOA · אנטומיית ה-QAOA

### 1.1 A probléma beírása egy diagonális operátorba

A kombinatorikus optimalizálási feladat n biten él: a **cél-függvény**
(költség-függvény)

    C(z) = Σ_{α=1}^{m} C_α(z),        z = z₁z₂…zₙ ∈ {0,1}ⁿ,

ahol C_α(z) = 1, ha az α klauzula teljesül, és 0, ha nem (MaxSat/MaxCut-
alakú feladatok; Farhi–Goldstone–Gutmann 2014, I. szakasz, (1) egyenlet).
A 2ⁿ-dimenziós Hilbert-térben a számítási alapállapotokat |z⟩ jelöli, és
C-et **diagonális operátorként** tekintjük: C|z⟩ = C(z)|z⟩. Ez a lépés a
kulcs: a diszkrét költség-függvényből így lesz kvantum-Hamiltonian.

A **fázis-szétválasztó** (phase separator) operátor γ szöggel:

    U(C, γ) = e^{−iγC} = Π_{α=1}^{m} e^{−iγC_α},

ahol a szorzat tagjai KOMMUTÁLNAK (mind diagonális), és minden tag
lokalitása legfeljebb az adott klauzula lokalitása [BIZONYÍTOTT —
Farhi 2014, (2) egyenlet]. Mivel C egész sajátértékű, γ ∈ [0, 2π].

### 1.2 A keverő-Hamiltonian

A **keverő** (mixer):

    B = Σ_{j=1}^{n} σ^x_j ,      U(B, β) = Π_{j=1}^{n} e^{−iβ σ^x_j},   β ∈ [0, π],

az összes egy-qubites X-Pauli összege [Farhi 2014, (3)–(4) egyenlet].
Szerepe: a számítási alapállapotok KÖZÖTT mozgat amplitúdót (a σ^x
bit-flip), tehát a keverő a keresőtér felfedezésének motorja — míg a
fázis-szétválasztó a jó megoldások amplitúdóját erősíti.

### 1.3 A kezdeti állapot

    |s⟩ = (1/√2ⁿ) Σ_z |z⟩ = |+⟩^{⊗n},

az EGYSÉGES SZUPERPOZÍCIÓ — minden 2ⁿ bites megoldás egyenlő
amplitúdóval szerepel benne [Farhi 2014, (5) egyenlet].

### 1.4 A rétegzett állapot — a QAOA maga

Tetszőleges p ≥ 1 egészhez és 2p szöghez (γ₁,…,γₚ) és (β₁,…,βₚ):

    |ψ(γ, β)⟩ = U(B, βₚ) U(C, γₚ) ⋯ U(B, β₁) U(C, γ₁) |s⟩,

vagy a feladatban kért alakban:

    |ψ(γ,β)⟩ = e^{−iβₚH_B} ⋯ e^{−iγ₁H_C} |+⟩^{⊗n} .

A rétegek sorrendje FONTOS: belülről kifelé haladva mindig előbb a
költség-, aztán a keverő-operátor alkalmazódik; a külső réteg β-ja
zárja a láncot [Farhi 2014, (6) egyenlet]. A p a **mélység-paraméter**:

- a kvantum-áramkör mélysége legfeljebb **mp + p**, ahol m a
  klauzulák száma — lineáris p-ben [BIZONYÍTOTT — Farhi 2014];
- a várható érték F_p(γ,β) = ⟨ψ(γ,β)| C |ψ(γ,β)⟩, és
  **M_p = max_{γ,β} F_p(γ,β)**;
- **monotonitás:** M_p ≥ M_{p−1}, mert a p−1-es maximum a p-s
  maximalizálásnak speciális esete (βₚ := 0) [Farhi 2014, (9)];
- **p→∞ határ:** lim_{p→∞} M_p = max_z C(z) — a bizonyítás a kvantum-
  adiabatikus algoritmus Trotterizált közelítésén nyugszik (l. §1.6)
  [BIZONYÍTOTT — Farhi 2014, (10)].

### 1.5 A hibrid hurok — két szint

1. **Kvantum-réteg:** adott (γ, β) mellett az áramkör elkészíti
   |ψ(γ,β)⟩-t, majd a számítási bázisban MÉRÜNK: kapunk egy z stringet,
   és klasszikusan kiszámoljuk C(z)-t. Ismétléssel F_p(γ,β) becsülhető;
   a koncentráció miatt (σ ≤ O(√m)) O(m²) minta elég, hogy a mintaátlag
   1-en belül legyen F_p-hez [Farhi 2014, III. szakasz].
2. **Klasszikus-réteg:** a (γ, β) paramétereken futtatott optimalizáló
   keresi F_p maximumát. Farhi eredeti javaslatai: (a) rögzített p +
   korlátozott fokszámú gráf esetén **klasszikus előfeldolgozás** —
   F_p felbontható részhalmaz-gráf-típusok súlyozott összegére,
   F_p(γ,β) = Σ_g w_g·f_g(γ,β), ahol f_g legfeljebb q_tree = 2[(v−1)^{p+1} −
   1]/((v−1) − 1) qubit kis Hilbert-terében számolandó, n-től ÉS m-től
   FÜGGETLEN erőforrással [BIZONYÍTOTT — Farhi 2014, II. szakasz,
   (25)–(26)]; (b) finom rácskeresés a kompakt [0,2π]^p × [0,π]^p
   halmazon; (c) a kvantumgépet F_p-kiértékelő szubrutinként hívó
   klasszikus kereső. A modern gyakorlatban (a) helyett gradiens-
   mentes/gradiens-alapú variációs optimalizálókat használnak — l. §2.2.

### 1.6 Viszony a kvantum-adiabatikus algoritmushoz (p→∞)

Az adiabatikus út H(t) = (1 − t/T)·B + (t/T)·C; |s⟩ B LEGFELSŐ energia-
sajátállapota, és a cél C legfelső sajátállapota. A Perron–Frobenius
tétel szerint a felső két sajátérték különbsége pozitív minden t < T-nél,
tehát elég nagy T-re az adiabatikus evolúció sikerül [Farhi 2014, VI.
szakasz]. Ennek **Trotterizált közelítése** éppen U(C,γ) és U(B,β)
VÁLTAkozása, ahol a szögek összege a teljes futásidő; jó approximációhoz
kicsi γ, β kell, sikerhez nagy futásidő — együtt ez p-t naggyá kényszeríti.
Innen következik a §1.4-es határérték [BIZONYÍTOTT].

**Őszinte ellenpont (§18):** a p→∞ határ NEM jelenti azt, hogy a végső
állapot átfedése az optimális megoldással nőne: a „ring of disagrees"
gráfcsaládon a p = 1-es állapot ¾-es approximációs arányt ad, miközben
az optimális stringekkel való átfedése EXPONENCIÁLISAN kicsi [Farhi 2014,
VI. szakasz vége]. Az approximáció-arány és az alapállapot-átfedés két
külön metrika — a projekt számára is tanulság: mit mérünk, azt pontosan
kell nevezni.

---

## 2. MaxCut-példa lépésről lépésre (n = 4) · MaxCut 示例（n = 4）·
## MaxCut-Beispiel Schritt für Schritt (n = 4) · דוגמת MaxCut שלב אחר שלב

### 2.1 A gráf és a cél-függvény

Vesszük a 4 csúcsú gráfot, amelyben az élek:

    E = {(1,2), (2,3), (3,4), (4,1), (1,3)}

(a négyzet + egy átló). A MaxCut célja: a csúcsokat két oldalra osztva
MAXIMALIZÁLNI a kétoldalra eső élek számát. A költség-Hamiltonian:

    H_C = Σ_{⟨jk⟩∈E} C_{⟨jk⟩},      C_{⟨jk⟩} = ½ (1 − σ^z_j σ^z_k) ,

ami a számítási bázison pontosan |z_j − z_k|-t adja: az él akkor számít,
ha a két végpont különböző oldalon van [Farhi 2014, (11)–(12)]. Ez a
projekt nyelvén: a H_C DIAGONÁLIS — a „fitness" a bázisállapotok
címkéje, pontosan úgy, ahogy a `Fitneszpont` a `CímkézettMondat` címkéje.

### 2.2 A 16 string kiértékelése

z = z₁z₂z₃z₄, C(z) = [z₁≠z₂] + [z₂≠z₃] + [z₃≠z₄] + [z₄≠z₁] + [z₁≠z₃].
A fontos sorok (teljes felsorolás helyett a maximumot és a szerkezetet
mutatjuk; a 16 érték mindegyike 0 és 4 közötti egész):

| z | oldalak | C(z) |
|---|---|---|
| 0000 | {} \| {1,2,3,4} | 0 |
| 0010 | {3} \| {1,2,4} | 3 |
| 0101 | {2,4} \| {1,3} | **4** |
| 1010 | {1,3} \| {2,4} | **4** |
| 1111 | {1,2,3,4} \| {} | 0 |

Maximum: C* = 4, két optimális stringgel (0101 és annak komplemensa,
1010) — a szimmetria oka: a MaxCut-invariáns a globális bit-flip alatt.

### 2.3 A QAOA futása a példán

1. **Kezdet:** |+⟩^{⊗4} = (1/4)·Σ_z |z⟩ — mind a 16 string ¼ amplitúdóval.
2. **U(C,γ₁):** minden z amplitúdójába e^{−iγ₁·C(z)} fázis kerül — a jó
   vágások (C=4) másképp forgannak, mint a rosszak (C=0). A fázis még
   nem látszik, DE a következő réteg láthatóvá teszi.
3. **U(B,β₁):** az X-keverő szomszédos biteket kever; a fáziskülönbségek
   INTERFERENCIÁBA lépnek — a magas C(z)-jű stringek amplitúdója
   konstruktívan, az alacsonyé destruktívan épül.
4. **p réteg után mérés:** a minta C(z) értékeinek átlaga → F_p(γ,β).
5. **Optimalizálás:** a klasszikus réteg új (γ,β)-t ad; a hurkot addig
   ismételjük, amíg F_p platóra ér; végül a legjobb mért stringet
   adjuk vissza.

Referencia-eredmények ugyanezen algoritmuscsaládra [BIZONYÍTOTT —
Farhi 2014]: a 2-reguláris „ring of disagrees" gráfokon M_p/n =
(2p+1)/(2p+2) minden p-re — tehát p → ∞-ben az arány → 1, és a
p = 1-es áramkör mélysége 3, n-től FÜGGETLENEN; 3-reguláris gráfokon
p = 1-re a legrosszabb eset approximációs aránya **0.6924**, p = 2-re
részleges analízissel 0.7559 (pentagon/square/triangle-mentes gráfokra).

---

## 3. QAOA utazóügynök-problémára (TSP) · QAOA 求解旅行商问题 · QAOA für das
## Problem des Handlungsreisenden · QAOA לבעיית הסוכן הנוסע

### 3.1 A bináris kódolás

n város, d_ij távolság-mátrix. Bevezetjük a bináris változót

    x_{i,t} ∈ {0,1} : x_{i,t} = 1 ⟺ az i-edik város a turné t-edik
                        pozíciójában áll,

összesen n² bit — ez a Lucas-féle kanonikus QUBO/Ising-kódolás (Lucas
2014, Frontiers in Physics 2:5; a QUBO és az Ising modell ekvivalensek).

### 3.2 A költség-Hamiltonian felírása

    H_TSP(x) = A · Σ_{i=1}^{n} (1 − Σ_{t=1}^{n} x_{i,t})²          (P1)
             + A · Σ_{t=1}^{n} (1 − Σ_{i=1}^{n} x_{i,t})²          (P2)
             + A · Σ_{(i,j)∉E} Σ_{t=1}^{n} x_{i,t} x_{j,(t mod n)+1} (P3)
             + B · Σ_{(i,j)∈E} d_{ij} Σ_{t=1}^{n} x_{i,t} x_{j,(t mod n)+1} (K)

- **P1:** minden VÁROS pontosan egyszer szerepeljen (oszlop-feltétel);
- **P2:** minden POZÍCIÓban pontosan egy város álljon (sor-feltétel);
- **P3:** hiányos gráf esetén büntetés, ha a turné nem-elemben járó
  lépést tartalmaz (komplett gráfnál ez a tag üres);
- **K:** a tényleges KÖLTSÉG: a turné éleinek súlyozott távolság-összege;
  (t mod n)+1 a ciklikus index (az n-edik után vissza az 1-edikbe);
- A, B > 0 büntetési súlyok; a szabály: B·max d « A, hogy az infeasibilis
  megoldások energiája a feasibilisek fölé kerüljön [IRODALMI KÖZLÉS —
  Lucas 2014; Ayodele 2022: a statikus büntetősúly-választás nem triviális,
  túl kicsi → infeasibilis válasz, túl nagy → lassú konvergencia].

### 3.3 Diagonális operátorrá emelés és a mixer kérdése

A QAOA-ban x_{i,t} ↦ (1 − σ^z_{it})/2 behelyettesítéssel H_TSP
σ^z-diagonális operátor lesz: minden x_{i,t}x_{j,t'} szorzat
σ^z_{it} σ^z_{jt'} két-qubites interakciót ad — a fázis-szétválasztó
kapuinak száma O(n²)-eskén skálázódik n városra, az áramkör mélysége a
QPack-benchmark közlése szerint 2n (páros n) ill. 2(n−1) (páratlan n)
sorrendű [IRODALMI KÖZLÉS — Mesman et al. 2021, QPack].

**A mixer problémája (fontos, gyakran elhallgatott részlet):** a standard
transzverzális mező B = Σ σ^x a feltétel-térből KIVISZI az állapotot
(P1/P2 sérül). Ezért TSP-re és más permutációs feladatokra **probléma-
specifikus mixereket** használnak: XY-mixer (a Hamming-súlyt tartja),
W-mixer stb.; a Qian–Basili–Eshaghian-Wilner 2023-as tanulmány három
keverő-konstrukciót hasonlított 3–5 városi példányokon kapuzott
szimulátoron, és a kiegyensúlyozott keverő-design bizonyult a legígéretesebbnek
 zajmodell alatt is; a Zorn–Braun–Ertl 2026-os GTSP-munka szintén
XY-mixeres, megszorítás-tudatos QAOA-változatot épített [IRODALMI KÖZLÉS].

**Őszinte jelölés:** a TSP-QAOA mai gyakorlati eredménye kicsi példányokon
(≤ néhány tíz qubit) versenyképes, nagyobb méreten élesen romlik a
feasibilitás és a skálázhatóság (Zorn et al. 2026 konklúziója) — a kvantum-
előny a TSP-re MA NEM bizonyított, csak aktívan kutatott irány.

### 3.4 Egyéb alkalmazások (a keresések alapján)

MaxSat, domináló halmaz, háti zsák (Knapsack), feladat-hozzárendelés
(Assignment), jármű-útvonaltervezés, DNS-szekvenálás, fehérjehajtogatás —
mindegyikre ugyanaz a recept: (1) QUBO/Ising-kódolás, (2) diagonális
H_C, (3) megfelelő keverő, (4) variációs hurok (Qian et al. 2023
bevezetőjének felsorolása; QPack).

---

## 4. Hő- és reverzibilitási megfontolások · 热与可逆性考量 · Wärme- und
## Reversibilitätsbetrachtungen · שיקולי חום והפיכוּת

### 4.1 Miért „kevesebb a hődisszipáció"? — a bizonyítható rész

- **A Landauer-elv (1961):** egy bit információ T hőmérsékleten történő
  TÖRLÉSE legalább k_B·T·ln 2 energiát disszipál. 300 K-en:
  k_B·T·ln 2 = 1,380649×10⁻²³ × 300 × ln 2 ≈ **2,87×10⁻²¹ J/bit** —
  ez pontosan a projekt `CarnotCiklus_v1.landauerKüszöb 300.0` értéke
  (IMPORT, §24 — nem újraszámolva). A boltzmann-állandó SI-exakt defináló
  állandó (2019 óta), tehát itt NINCS mérési σ — §17 szerint a Δ/σ elemzés
  IDE NEM ALKALMAZHATÓ; az egyetlen pontatlanság az IEEE-754 kerekítés
  (ugyanaz a könyvelés, amit az `EvoluciosAlgoritmusok_Tanulas.md` §4.1
  már rögzített).
- **A QAOA kvantum-rétege UNITÉR:** e^{−iγH_C} és e^{−iβH_B} unitér
  operátorok; minden unitér transzformáció REVERZIBILIS — egyetlen bit
  információt sem töröl, tehát a Landauer-határ NEM vonatkozik rá
  [BIZONYÍTOTT fizika; forrás: Landauer 1961; Bennett reverzibilis
  számítás; Lahoz-Beltra 2016 („Q-gates are reversible gates");
  arXiv:2506.10876 review].
- **Következés:** a QAOA belső, unitér lépései elméleti minimumon,
  nulla KÖTELEZŐ hőkibocsátással futtathatók — a hődisszipáció nem a
  logika, hanem a TÖRLÉS számlájára írandó.

### 4.2 Amit őszintén hozzá kell tenni (§17/§18) — a nem ingyenes részek

1. **A MÉRÉS költsége marad:** a kiértékeléshez a szuperpozíciót
   számítási bázisban kell mérni — a collapse IRREVERZIBILIS lépés;
   F_p becsléséhez O(m²) ismételt mérés kell (koncentráció miatt),
   mindegyik fizikai művelet a hardveren. A „kvantum-réteg ingyen
   kiértékel" állítás tehát CSAK a unitér előkészítő szakaszra igaz,
   a mérésre nem [BIZONYÍTOTT — a collapse irreverzibilitása a kvantum-
   mechanika standard tananyaga; a mérés termodinamikai árának
   formalizálásai (pl. Landauer + dekoherencia integrációk) kutatási
   téma, l. arXiv:2506.10876].
2. **A valós hardveren a dekoherencia dominál:** a mai NISQ-eszközökön
   a disszipációt nem a Landauer-határ, hanem a zajos kapuk hibaaránya,
   a T1/T2 relaxáció és a mélység-korlát szabja meg — a QAOA teljesítménye
   zajon romlik (Qian et al. 2023 zajmodell-szimulációi; „noisy interme-
   diate-scale quantum era" kifejezés). Tehát: **az elméleti Landauer-
   mentesség és a mérnöki valóság KÜLÖN dolgok** — a projekt dokumentumaiban
   ezt a kettőt soha nem szabad összevonni.
3. **A klasszikus optimalizáló-réteg irreverzibilis:** a (γ,β) frissítése,
   a szelekció, a minták rendezése — ezek hagyományos digitális lépések,
   rajtuk a Landauer-könyvelés érvényes (alsó korlát, könyvelési egység —
   az `EvolutivKereso_v1` §5.5-beli megoldás: a szelekció árát a
   `landauerKüszöb`-bel importált küszöbbel könyveljük).
4. **A p→∞ adiabatikus határ lassú:** a sikeres adiabatikus futásidő
   NP-nehezen skálázódhat (spektrum-rés eksponenciálisan szűkülhet);
   a QAOA éppen ettől akar elszakadni a fix p + variációs hurokkal
   (Farhi 2014 VI.; Zorn et al. 2026: „the duration required for
   executing this time evolution in an adiabatic manner is typically
   exponentially large for NP-hard problems").

### 4.3 Összegző táblázat — hol van hő, hol nincs

| Lépés | Reverzibilis? | Kötelező hő (elméleti minimum) |
|---|---|---|
| U(C,γ), U(B,β) rétegek | igen (unitér) | nulla |
| Mérés (collapse) | NEM | nem-nulla; formálása kutatási téma |
| Klasszikus optimalizáló-lépés | NEM | ≥ Landauer-küszöb / törölt bit |
| NISQ-hardver zajai | — | a hibaarány uralja, nem a Landauer-határ |

---

## 5. QAOA vs. adiabatikus vs. VQE — röviden · QAOA、绝热计算与 VQE 简比 ·
## QAOA vs. adiabatisch vs. VQE kurz · QAOA מול חישוב אדיאבטי מול VQE

| | **QAOA** | **Kvantum-adiabatikus (QAA)** | **VQE** |
|---|---|---|---|
| Cél | kombinatorikus C(z) MAXIMUMÁNAK approximációja | H alapállapotának (itt: legfelső sajátállapot) EXAKT megtalálása | egy ADOTT Hamiltonian ALAPÁLLAPOT-ENERGIÁJA (kémia) |
| Állapot-előkészítés | p db alternáló, PROBLÉMA-INSPIRÁLT unitér réteg | folyamatos H(t) evolúció | variációs áramkör (hardware-efficient vagy UCC anzsác) |
| Paraméterek | 2p szög: (γ,β) | futásidő T (+ ütemezésfüggvény) | anzsác-paraméterek (θ) |
| Klasszikus rész | F_p-maximalizálás a (γ,β)-n | nincs (vagy ütemezés-tervezés) | energiaminimum keresése θ-n |
| Biztosított határ | lim_{p→∞} M_p = max_z C(z) | T→∞: siker (ha a rés nyitott marad) | variációs felső korlát az energiára |
| Gyengeség | jó (γ,β) megtalálása nehéz; kis p-n korlátos approximáció | NP-nehezen lassú lehet; siker-valószínűség nem monoton T-ben | lokális minimumok; barren plateaus |

Források: Farhi 2014 (VI.: a QAA-reláció és az eltérések — a QAA siker-
valószínűsége NEM monoton T-ben, Crosson et al. példája); a QAOA-VQE
párhuzam: mindkettő hibrid variációs algoritmus, a QAOA a kombinatorikus
célra specializált, kevesebb paraméterrel és sekélyebb anzsáccal (Qian
et al. 2023 bevezető; Ajlouni 2024: „similar to QAOA, VQE is designed to
find the ground state energy of a Hamiltonian by variationally optimizing
parameters"); a három család áttekintése: Variational and Annealing-Based
Approaches to Quantum Combinatorial Optimization (arXiv:2603.19117) és a
LMU Quantum Optimization Algorithms áttekintés (arXiv:2511.12379).

---

## 6. Kulcscikkek · 关键文献 · Schlüsselliteratur · ספרות מפתח

1. **Farhi, E., Goldstone, J., Gutmann, S. (2014).** *A Quantum Approximate
   Optimization Algorithm.* MIT-CTP/4610.
   - arXiv: https://arxiv.org/abs/1411.4028 · DOI: 10.48550/arxiv.1411.4028
   - alphaXiv: https://www.alphaxiv.org/abs/1411.4028 (ID=1411.4028)
   - **AZ EREDETI CIKK** — teljes PDF-szövegét elolvastuk; minden
     (1)–(49) egyenlethivatkozás erre megy.
2. **Farhi, E., Goldstone, J., Gutmann, S., Sipser, M. (2000).** *Quantum
   computation by adiabatic evolution.* arXiv:quant-ph/0001106 —
   https://arxiv.org/abs/quant-ph/0001106 (a QAA-alap; Farhi 2014 [2] hivatkozása).
3. **Crosson, E., Farhi, E., Lin, C. Y.-Y., Lin, H.-H., Shor, P. (2014).**
   *Different strategies for optimization using the quantum adiabatic
   algorithm.* arXiv:1401.7320 — https://arxiv.org/abs/1401.7320
   (a QAA siker-valószínűségének nem-monotonitására vonatkozó példa).
4. **Lucas, A. (2014).** *Ising formulations of many NP problems.*
   Frontiers in Physics 2:5. DOI: 10.3389/fphy.2014.00005 —
   https://www.frontiersin.org/articles/10.3389/fphy.2014.00005/full
   (a TSP/HCP QUBO-Hamiltonian kanonikus forrása — §3.2).
5. **Ayodele, M. (2022).** *Penalty Weights in QUBO Formulations:
   Permutation Problems.* Springer. DOI: 10.1007/978-3-031-04148-8_11 —
   https://doi.org/10.1007/978-3-031-04148-8_11 (büntetősúly-választás).
6. **Qian, W., Basili, R., Eshaghian-Wilner, M. M. (2023).** *Comparative
   Study of Variations in Quantum Approximate Optimization Algorithms for
   the Traveling Salesman Problem.* Entropy 25(8):1238.
   DOI: 10.3390/e25081238 — https://doi.org/10.3390/e25081238
   (három keverő-design összehasonlítása 3–5 városra; zajmodell).
7. **Mesman, K., Al-Ars, Z., Möller, M. (2021).** *QPack: Quantum Approximate
   Optimization Algorithms as universal benchmark for quantum computers.*
   arXiv:2103.17193 · DOI: 10.48550/arxiv.2103.17193 —
   https://arxiv.org/abs/2103.17193 (MaxCut/domináló halmaz/TSP benchmark;
   klasszikus optimalizáló-választás: globál/lokál hibrid).
8. **Zorn, M., Braun, M., Ertl, M. (2026).** *Quantum Optimization Methods
   for the Generalized Traveling Salesman Problem.* arXiv:2604.25531 ·
   DOI: 10.48550/arxiv.2604.25531 — https://arxiv.org/abs/2604.25531
   (XY-mixeres, megszorítás-tudatos QAOA; skálázhatósági határok).
9. **Duan, F.-G. et al. (2021).** *A loop Quantum Approximate Optimization
   Algorithm with Hamiltonian updating.* arXiv:2109.11350 ·
   DOI: 10.48550/arxiv.2109.11350 — https://arxiv.org/abs/2109.11350
   (sekély áramkör + visszacsatolt Hamiltonian-frissítés).
10. **Ha, H., Ta, A. S. (2023).** *Hybrid QAOA and Genetic Algorithm for
    Solving Max-Cut Problem.* Research Square. DOI:
    10.21203/rs.3.rs-2800852/v1 — https://doi.org/10.21203/rs.3.rs-2800852/v1
    (**a QAOA-kimenet mint GA-KEZDŐPOPULÁCIÓ** — közvetlen párhuzam a
    projekt két-szintű tervével, l. §7.2).
11. **Roch, C., Impertro, A., Phan, T. (2020).** *Cross Entropy Hyperparameter
    Optimization for Constrained Problem Hamiltonians Applied to QAOA.*
    IEEE ICRC 2020. DOI: 10.1109/icrc2020.2020.00009 —
    https://doi.org/10.1109/icrc2020.2020.00009 (evolúciós-rokon klasszikus
    optimalizáló a (γ,β)-n).
12. **Xu, Z., Cai, P., Shen, K. et al. (2024).** *Hybrid GRU-CNN bilinear
    parameters initialization for QAOA.* Physica Scripta 99:085105.
    DOI: 10.1088/1402-4896/ad5a50 — https://doi.org/10.1088/1402-4896/ad5a50
    (mély QAOA paraméter-init: GRU+CNN, 12 mélységen 0.998 approximáció).
13. **Chen, L., Zou, P., Yu, Y.-F. (2026).** *Enhanced multiscale QAOA in
    multibody combinatorial optimization problems.* Chinese Physics B
    35:070305. DOI: 10.1088/1674-1056/ae29f7 — https://doi.org/10.1088/1674-1056/ae29f7
    (MQAOA: renormálócsoport + QAOA; Max-2-SAT 97% siker).
14. **Variational and Annealing-Based Approaches to Quantum Combinatorial
    Optimization (2026).** alphaXiv ID=2603.19117 —
    https://www.alphaxiv.org/abs/2603.19117 (áttekintés: variációs vs.
    annealing családok).
15. **Quantum Optimization Algorithms (2025).** alphaXiv ID=2511.12379 —
    https://www.alphaxiv.org/abs/2511.12379 (LMU-áttekintés).
16. **Landauer, R. (1961).** Irreversibility and heat generation in the
    computing process. IBM J. Res. Dev. 5(3), 183–191; áttekintés:
    Chattopadhyay et al. (2025), *Landauer Principle and Thermodynamics of
    Computation* — https://arxiv.org/abs/2506.10876 ; Wikipedia:
    https://en.wikipedia.org/wiki/Landauer%27s_principle .
17. **Han, K.-H., Kim, J.-H. (2000)** és a kvantum-inspirált EA-irodalom —
    áthivatkozva az `EvoluciosAlgoritmusok_Tanulas.md` §3.1-ből (a
    kvantum-evolúciós út előzménye).

Megjegyzés (őszinte, §18): a 14–15. tételt csak absztrakt/alaphivatkozás
szintjén olvastuk a discover-keresésekben — tartalmi állítást NEM veszünk
belőlük, csak a család-átekintés létezését rögzítjük.

---

## 7. A SZIMA-KAPCSOLAT · SZIMA 联系 · Die SZIMA-Verbindung · הקשר לסימה

### 7.1 A két szint — a QAOA mint a kvantum-evolúciós út KONKRÉT formája

Az `EvoluciosAlgoritmusok_Tanulas.md` §3–4 és §5.7 a kvantum-evolúciós
utat JAVASLAT-szinten rögzítette („EZ A SZAKASZ MOST NEM IMPLEMENTÁLÓDIK").
A QAOA erre a vázlatra adja meg a KONKRÉT, irodalmilag bizonyított
formát — két szinten:

1. **Kvantum-réteg (a §5.7 szuperpozíciós populáció konkretizálása):**
   - a populáció-állapottér (D8-pálya × CPT-bélyeg, 54 alapállapot
     egyedenként) helyett a QAOA az EGYEDEK TÉRÉN dolgozó alternáló
     unitér rétegekkel: |ψ(γ,β)⟩ = e^{−iβₚH_B}⋯e^{−iγ₁H_C}|+⟩^{⊗n};
   - a mutáció-unitér megfelelője a projektben a **Weyl-tükrözés
     kompozíciója**: az `E8BelsoSzorzat.weylReflexio` (σ_α(β) =
     β − (⟨α,β⟩/4)·α, `E8BelsoSzorzat.idr` 99. sor) ORTOGONÁLIS, tehát
     unitér transzformáció a gyöktérben — ez adhatja a keverő-Hamiltonian
     H_B gyök-rácsos megfelelőjét: a keverő szerepe (amplitúdó-átmozgatás
     a megoldástérben) és a tükrözésé (állapotváltás a D8-pályák közt,
     involúció = ön-invertálható) STRUKTURÁLISAN azonos;
   - a keverő zártsága a 240 gyökön MÁR KIMERÍTŐEN MÉRT: `zarasHibakSzama`
     = 0 (57 600 reflexió) — ez a QAOA-mixer „feasibility-preserving"
     tulajdonságának gyök-rácsos analógja.
2. **Klasszikus evolúciós réteg (a (γ,β)-optimalizálás = evolúció):**
   a (γ,β)-vektorok POPULÁCIÓJA evolválódik a kvantum-réteg által mért
   F_p fitnesz felett — ez pontosan a „Carnot-hajtású klasszikus
   evolúciós réteg": a kiértékelés = mérés (fizetődik, §4.2), a szelekció/
   variáció a (γ,β)-téren fut. Az irodalom ebben az irányban MOZOG:
   kereszt-entrópia-optimalizáló (Roch et al. 2020), neurális init
   (Xu et al. 2024), sőt **explicit QAOA+GA-hibrid** — a QAOA mért
   kimenete adja a genetikus algoritmus KEZDŐPOPULÁCIÓJÁT (Ha & Ta 2023).
   A projekt két-szintű terve (kvantum-réteg + evolúciós réteg) tehát
   nem izolált ötlet, hanem aktív kutatási irány.

### 7.2 A H_C megfelelője — a projekt költség-függvénye

A QAOA-ban H_C DIAGONÁLIS: a bázisállapotok (megoldások) címkéje. A
projekt fitness-e pontosan ilyen diagonális címke a `CímkézettMondat`
állapotokon (IMPORTÁLT részek, §24):

    fitness(m) = w₁ · fázistényező(m) + w₂ · jelentéspont(m),

ahol `fázistényező` (Mondat_v1; hátterében FazisAlgebra_v2.fazisFaktorialis)
a koherencia-rész, `jelentéspont` a `GyokSzo_v1.jelentésTávolság`
öttszintű skálájából (±1/±½/0) jön — a QAOA nyelvén ez lenne a
„klauzulák összege", a MaxCut C(z)-jének mondat-térbeli párja. A
w₁/w₂ súlykérdés az `EvoluciosAlgoritmusok_Tanulas.md` §6-ban nyitott.

### 7.3 Illeszkedés az `EvolutivKereso_v1`-hez

Az ottani négy fázis a QAOA-ciklusba így ül bele:

| EvolutivKereso_v1 fázis | QAOA-analóg |
|---|---|
| kiértékelés (fitnesz) | F_p(γ,β) mérése a kvantum-rétegen (collapse — fizetődik) |
| variáció (mutáció+keresztezés) | a (γ,β)-populáció evolúciós operátorai; a kvantum-oldalon a rétegek U(B,β)U(C,γ) kompozíciója |
| szelekció (élit + Landauer-árazás) | a legjobb (γ,β) párosok továbbvitele; az eldobott minták információjának Landauer-könyvelése |
| új generáció | új (γ,β) köteg a kvantum-rétegnek; M_p-monotonitás (Farhi 2014 (9)) = az élit-megmaradás kvantum-analógja |

### 7.4 Jövőbeli Idris-vázlat — `QaoaVazlat_v1` (CSAK VÁZLAT, most NEM íródik!)

Az `EvolutivKereso_v1` mintájára (§5.8), a HOROG csomagolási szabályával:

```idris
-- ═══════════════════════════════════════════════════════════════
-- QAOAVÁZLAT v1 — MODUL-VÁZLAT (NEM implementáció!)
-- §24: minden művelet IMPORT — weylReflexio (E8BelsoSzorzat),
--      jelentéspont/jelentésTávolság (GyokSzo_v1), fázistényező
--      (Mondat_v1 / FazisAlgebra_v2), landauerKüszöb (CarnotCiklus_v1).
-- ═══════════════════════════════════════════════════════════════

module QaoaVazlat_v1

-- 1. A RÉTEG-ADATTÍPUS — egy QAOA-lépés = (γ, β) szögpar:
public export
record Réteg where
  constructor RétegKonstruktor
  költségSzög  : Double   -- γ ∈ [0, 2π]
  keverőSzög   : Double   -- β ∈ [0, π]

-- 2. AZ ÁLLAPOT — amplitúdóvektor a mondat-tér fölött (javaslat:
--    List (Amplitúdó, CímkézettMondat) vagy rekord; a végleges
--    döntést a típus-pontosság eldönti, AGENTS §13 főszabály).
public export
QaoaÁllapot : Type   -- (a vázlat jelöli; a kitöltés külön feladat)

-- 3. A KÉT OPERÁTOR — mindkettő IMPORT-ALAPÚ:
--    fázisLépés  : Double -> QaoaÁllapot -> QaoaÁllapot   -- e^{-iγH_C}
--      (a fitness diagonális címke: fázistényező + jelentéspont)
--    keverőLépés : Double -> QaoaÁllapot -> QaoaÁllapot   -- e^{-iβH_B}
--      (a Weyl-tükrözés unitér megfelelője a gyöktérben)
-- 4. A CIKLUS — réteglista kompozíciója (LISTA-KONSTANS, NEM
--    let-lánc! LetLáncProbe-tanulság):
--    qaoaFuttatás : List Réteg -> QaoaÁllapot -> QaoaÁllapot
--
-- 5. REFL-CÉLPONTOK (két független út, egy híd — §18; NEM tautológia):
--  a) ÜRES-FUTAT AZONOSSÁG: qaoaFuttatás [] = azonos — bal: a lista
--     fold-ja; jobb: az identitás konstrukciója.
--  b) RÉTEGSZÁM-MEGMARADÁS: a futtatás a réteglistát nem változtatja
--     (length-tulajdonság Nat-szinten).
--  c) A KEVERŐ ZÁRTSÁGA A GYÖKTÉRBEN — már KIMERÍTŐEN MÉRT
--     (zarasHibakSzama = 0 / 57 600, E8BelsoSzorzat) — a Refl-forma
--     a típus-szintű zártságot vinné át.
--  d) INVOLÚCIÓ-JELLEG: a tükrözés-kompozíció önmagának inverze
--     (bizInvolúció* minta) — a keverő visszafordíthatósága.
--
--  ŐSZINTE JELELÉS (§18): az M_p ≥ M_{p−1} MONOTONITÁS és a
--  p→∞ határérték VALÓDI ANALÍZIS — Idris-formalizálásuk Nat-szinten
--  NEM lehetséges közvetlenül (Double-rendezettség + határérték);
--  ezeket FUTÁSIDEJŰ Show/GAUGE-ellenőrzés jelölné, nem Refl.
-- ═══════════════════════════════════════════════════════════════
```

**Miért érdemes ez az út a projektnek:** a QAOA megmutatja, hogy az
`EvolutivKereso_v1` két-szintű architektúrája (unitér kvantum-réteg +
klasszikus evolúciós hajtás) VAN IRODALOMI PÉLDÁNYA — a (γ,β)-evolúció
pedig a projekt fitness-fogalmát (fázistényező + jelentés-távolság)
közvetlenül használhatná kvantum-fitneszként. UGYANAKKOR őszintén (§18):
a projekt mai kódja klasszikus gépen fut; a kvantum-réteg ma csak
SZIMULÁCIÓ lehet — a hőelőny (§4) csak valódi unitér hardveren érne
érvényt, és a mérés költsége ott is megmarad.

---

## 8. Nyitott kérdések · 开放问题 · Offene Fragen · שאלות פתוחות

1. A (γ,β)-evolúcióhoz melyik klasszikus optimalizáló illik a
   projekthez: egyszerű GA (mint a Ha & Ta 2023), CMA-ES-szerű ES, vagy
   kereszt-entrópia (Roch et al. 2020)?
2. A fitness-súlyok (w₁, w₂) — az `EvoluciosAlgoritmusok_Tanulas.md` §6/1
   nyitott kérdése — a QAOA-olvasatban a H_C „klauzulasúlyai": ugyanaz a
   döntés két nevezéktanban?
3. A `QaoaVazlat_v1` állapot-reprezentációja: sűrű amplitúdó-lista
   (exponenciális!) vagy ritka mintavétel (minta-alapú F_p becslés)?
4. Érdemes-e a p = 1 esetet (egyetlen (γ₁,β₁)) először kimerítő
   rácskereséssel vizsgálni (a Farhi-féle finom rács módszere) — ez
   Idrisben Nat-rácsosan, Refl-barát módon formalizálható?
5. A Weyl-keverő „feasibility" fogalmának pontosítása: mi a
   mondat-térben a „feasibilis" halmaz, amit a keverő nem hagy el?

---

## 9. Négy nyelvű összefoglaló · 四语总结 · Vierprachige Zusammenfassung ·
## תקציר ארבע־לשוני

**中文：** 本文档研究了量子近似优化算法（QAOA；Farhi–Goldstone–Gutmann 2014，
arXiv:1411.4028，已读全文）。要点：（1）解剖：对角成本哈密顿量 H_C 与横向场
混合哈密顿量 H_B = Σσˣ 交替作用：|ψ(γ,β)⟩ = e^{−iβₚH_B}⋯e^{−iγ₁H_C}|+⟩^⊗n；
深度 p 单调改进（Mₚ ≥ Mₚ₋₁），且 lim_{p→∞} Mₚ = max C(z)——由绝热演化的
Trotter 化证明；电路深度 ≤ mp+p。（2）MaxCut n=4 示例：H_C = Σ½(1−σᶻⱼσᶻₖ)，
最优割为 4。（3）TSP：Lucas 二次编码 x_{i,t}（n² 位），H_TSP 含行/列惩罚、
非边惩罚与距离项；需要保约束混合器（XY 等）。（4）热学：unitary 门可逆，
不受 Landauer 极限约束（300 K 下 k_BT ln2 = 2.87×10⁻²¹ J/比特，即项目
CarnotCiklus_v1.landauerKüszöb 值）；但测量（坍缩）不可逆、NISQ 噪声主导、
经典优化层仍按 Landauer 记账。（5）Szima 连接：QAOA 是项目量子演化路线的
具体形式——两层结构：量子层（weylReflexio 作为正交/酉混合器）+ 经典演化层
（(γ,β) 种群进化）；H_C 对应 fitness = 相位因子 + 五级意义距离；附
QaoaVazlat_v1 类型草案与四个 Refl 目标。

**Deutsch:** Dieses Dokument untersucht den Quantum Approximate Optimization
Algorithm (QAOA; Farhi–Goldstone–Gutmann 2014, arXiv:1411.4028, Volltext
gelesen). (1) Anatomie: der diagonale Kosten-Hamiltonoperator H_C und der
Transversalfeld-Mischer H_B = Σσˣ wirken abwechselnd: |ψ(γ,β)⟩ =
e^{−iβₚH_B}⋯e^{−iγ₁H_C}|+⟩^⊗n; die Tiefe p verbessert monoton
(Mₚ ≥ Mₚ₋₁), und lim_{p→∞} Mₚ = max C(z) — bewiesen über Trotterisierung
der adiabatischen Entwicklung; die Schaltkreistiefe ist ≤ mp+p. (2)
MaxCut-Beispiel n=4: H_C = Σ½(1−σᶻⱼσᶻₖ), optimaler Schnitt = 4. (3) TSP:
Lucas-Binärkodierung x_{i,t} (n² Bits), H_TSP mit Zeilen-/Spaltenstrafen,
Nicht-Kanten-Strafe und Distanzterm; einschränkungserhaltende Mischer
(XY usw.) sind nötig. (4) Wärme: unitäre Gatter sind reversibel und
unterliegen nicht der Landauer-Grenze (bei 300 K: k_B·T·ln2 =
2,87×10⁻²¹ J/Bit — genau der Wert von landauerKüszöb in CarnotCiklus_v1);
doch die Messung (Kollaps) bleibt irreversibel, NISQ-Rauschen dominiert,
und die klassische Optimierungsschicht wird weiterhin nach Landauer
verbucht. (5) Szima-Anbindung: QAOA ist die konkrete Form des geplanten
Quantum-Evolutionswegs — zwei Schichten: Quantenschicht (weylReflexio als
orthogonaler/unitärer Mischer) + klassische Evolutionsschicht ((γ,β)-
Population); H_C entspricht der Fitness = Phasenfaktor + fünfstufige
Bedeutungsdistanz; mit dem Typgerüst QaoaVazlat_v1 und vier Refl-Zielen.

**עברית:** מסמך זה חוקר את אלגוריתם האופטימיזציה הקוונטית המקורבת (QAOA;
Farhi–Goldstone–Gutmann 2014, arXiv:1411.4028, נקרא במלואו). (1) אנטומיה:
המילטוניאן העלות הדיאגונלי H_C ומילטוניאן המיקסר H_B = Σσˣ פועלים בחלופה:
|ψ(γ,β)⟩ = e^{−iβₚH_B}⋯e^{−iγ₁H_C}|+⟩^⊗n; העומק p משתפר מונוטונית
(Mₚ ≥ Mₚ₋₁), ו־lim_{p→∞} Mₚ = max C(z) — מוכח באמצעות טרוטריזציה של
אבולוציה אדיאבטית; עומק המעגל ≤ mp+p. (2) דוגמת MaxCut n=4: H_C =
Σ½(1−σᶻⱼσᶻₖ), החיתוך האופטימלי = 4. (3) TSP: קידוד בינארי של Lucas
x_{i,t} (n² ביטים), H_TSP כולל קנסות שורה/עמודה, קנס לאי-קשת ואיבר מרחק;
דרושים מיקסרים שומרי-אילוץ (XY וכו'). (4) חום: שערים אוניטריים הפיכים
ואינם כפופים לגבול לנדאואר (ב־300 K: k_B·T·ln2 = 2.87×10⁻²¹ J לביט —
בדיוק ערך landauerKüszöb במודול CarnotCiklus_v1); אך המדידה (קריסה)
נותרת בלתי-הפיכה, רעש NISQ שולט, ושכבת האופטימיזציה הקלאסית עדיין
נמדדת לפי לנדאואר. (5) קשר לסימה: QAOA הוא הצורה המוחשית של מסלול
האבולוציה הקוונטית בפרויקט — שתי שכבות: שכבה קוונטית (weylReflexio כמיקסר
אורתוגונלי/אוניטרי) + שכבה אבולוציונית קלאסית (אוכלוסיית (γ,β)); H_C
מקביל לכושר = גורם הפאזה + מרחק משמעות חמש־דרגתי; עם שלד הטיפוסים
QaoaVazlat_v1 וארבעה יעדי Refl.
