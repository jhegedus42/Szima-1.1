# Az Utazó Ügynök Tanulása — TSP (Traveling Salesman Problem)

> Utazó ügynök problémája —— 旅行商问题 · Das Problem des reisenden
> Agenten · בעיית הסוכן הנוסע

Dátum: 2026-08-24 · Kutatási dokumentum (NEM Idris-modul — csak tanulás)
Kapcsolódó: `docs/EvoluciosAlgoritmusok_Tanulas.md` (§5 Gondolkodó),
`szima_ter/modul/GyokSzo_v1.idr` (`jelentésTávolság`),
`szima_ter/modul/CarnotCiklus_v1.idr` (`CarnotÁllapot`, `landauerKüszöb`)

---

## Tartalomjegyzék

1. [Definíció és NP-nehézség](#1-definíció-és-np-nehézség)
2. [Egzakt módszerek](#2-egzakt-módszerek)
3. [Heurisztikák és metaheurisztikák](#3-heurisztikák-és-metaheurisztikák)
4. [Kvantum-megközelítések](#4-kvantum-megközelítések)
5. [Kulcscikkek és források](#5-kulcscikkek-es-forrasok)
6. [A Szima-kapcsolat — az utazó ügynök a gyökrácson](#6-a-szima-kapcsolat)
7. [Négy nyelvű összefoglaló](#7-négy-nyelvű-összefoglaló)

---

## 1. Definíció és NP-nehézség

### 1. Definíció és NP-nehézség / Definition and NP-hardness

定义与 NP 困难性 · Definition und NP-Schwere · הגדרה וקושי-NP

### 1.1 A definíció

**Utazó ügynök problémája (TSP):** adott n város és a párok közti távolság;
keressük azt a **Hamilton-kört** — azt a zárt utat, amely MINDEN várost
pontosan egyszer érint —, amelynek teljes hossza minimális.

- **Szimmetrikus TSP:** d(i,j) = d(j,i) (a klasszikus eset).
- **Aszimmetrikus TSP (ATSP):** d(i,j) ≠ d(j,i) megengedett (egyirányú
  utcák).
- **Metrikus TSP:** ha d háromszög-egyenlőtlenséget teljesít
  (d(i,k) ≤ d(i,j) + d(j,k)) — ekkor élnek a közelítési garanciák
  (pl. Christofides 1,5-ös tényezője).
- **Kombinatorikus méret:** az n város körök száma (n−1)!/2 (a kiinduló
  pont és az irány nem számít). n = 240-re (a gyökrács!) ez
  **239!/2 ≈ 8×10⁴65 kör** (Stirling-közelítés — őszintén jelölve,
  §17: közelítés, nem pontos számítás). A nyers felsorolás lehetetlen.

### 1.2 Az NP-nehézség bizonyításának útja (röviden)

1. **Döntési változat:** „Van-e legfeljebb B hosszú Hamilton-kör?"
   — ez NP-teljes.
2. **Visszavezetés (redukció):** a Hamilton-kör-problémából (adott gráfban
   van-e minden csúcsot egyszer érintő kör?) polynomial időben átalakítható
   TSP-példánnyá: minden él súlya 1, minden hiányzó él súlya nagy
   (pl. n·2); a gráf pontosan akkor van Hamilton-köre, ha a TSP-példánynak
   van B-nél rövidebb köre.
   - Kanonikus forrás: **Karp 1972**, „Reducibility among Combinatorial
     Problems" — itt szerepel a TSP a 21 klasszikus NP-teljes probléma
     között (a Hamilton-kör-problémából vezetve vissza).
   - Az optimalizációs változat NP-nehéz: ha lenne rá gyors (polinomiális)
     algoritmus, a döntési változat is gyorsan eldönthető lenne
     (optimális kör hosszát összevetjük B-vel) — ellentmondás P ≠ NP-re.
3. **Még rosszabb:** a TSP **metrikus esetben is** NP-nehéz (sőt a
   szimmetrikus, metrikus esetre is — l. arXiv:2401.16149 bevezetője);
   az euklideszi síkeset NP-nehézsége: Papadimitriou 1977.
4. **Kontraszt (fontos őszinteség):** NP-nehézség = NINCS ismert
   polinomiális algoritmus ÉS NINCS bizonyítva, hogy nincs. A gyakorlatban
   több ezer városig egzakt megoldások születtek (Concorde), és a
   heurisztikák százezres nagyságrendű példányokon adnak ~1%-os hibájú
   köröket.

---

## 2. Egzakt módszerek / Exact methods

精确方法 · Exakte Methoden · שיטות מדויקות

| Módszer | Szerző(k), év | Komplexitás | Megjegyzés |
|---|---|---|---|
| Teljes felsorolás | — | O(n!) | (n−1)!/2 kör; csak kis n |
| Dinamikus programozás (Held–Karp) | Bellman 1962; Held–Karp 1962 | Θ(n²·2ⁿ) idő, Θ(n·2ⁿ) tár | n=240-re ~10⁷⁴ művelet nagyságrend (becslés) — elméleti határ |
| Branch-and-bound (B&B) | Little et al. 1963 | legrosszabb eset exponenciális, gyakorlatban jó alsó korlátokkal | alsó korlát: pl. minimális feszítőfa + 1-fokú illeszkedés |
| Vágósíkok + LP-relaxáció | Dantzig–Fulkerson–Johnson 1954 | — | a subtour-eliminációs egyenlőtlenségek; 49 város optimálisan |
| Egészlineáris programozás (ILP) | Miller–Tucker–Zemlin 1960 | — | MTZ-formuláció; gyengébb LP-relaxáció, mint a DFJ |
| Concorde szoftver | Applegate–Bixby–Chvátal–Cook (1990-es évektől) | — | eddigi legnagyobb egzakt példány: pla85900 (85 900 város, 2006); branch-and-cut |

**Megjegyzés (§18-őszinteség):** a táblázat komplexitásai a szakirodalom
általános állításai; a n=240-es konkrét műveletszám (~10⁷⁴) SAJÁT
Stirling-becslés, nem irodalmi idézet — jelölve: becslés.

---

## 3. Heurisztikák és metaheurisztikák / Heuristics and metaheuristics

启发式与元启发式算法 · Heuristiken und Metaheuristiken ·
היוריסטיקות ומטא-היוריסטיקות

### 3.1 Konstrukciós heurisztikák

- **Legközelebbi szomszéd (nearest neighbor):** mindig a még fel nem
  látott legközelebbi város. Gyors O(n²), de lokális csapdákba fut;
  tipikusan ~25%-kal rosszabb az optimumnál.
- **Legkisebb illeszkedés / beszúrás (insertion):** a kört növekményesen
  bővítjük a legkevésbé drága beszúrással.
- **Christofides-algoritmus (metrikus eset):** garancia ≤ 1,5×optimum —
  a legjobb ismert garantált közelítés a metrikus TSP-re.

### 3.2 Lokális keresés (k-opt család)

- **2-opt:** két él cseréje (két szakasz megfordítása); a kör ÉRVÉNYES
  marad (ez a Szima-váz Refl-célja! l. §6.4). Croes 1958.
- **3-opt:** három él cseréje; Lin 1965.
- **Lin–Kernighan (1973):** „változó k-opt" — egy élcsere-sorozatot
  épít additív nyereség-kritériummal, a mélység futásidőben dől el.
  A leghatékonyabb klasszikus heurisztika; futásideje kb. n²-re nő;
  100 városra <25 s GE635-ön (az eredeti cikk mérése).
  Forrás: Lin & Kernighan 1973, *Operations Research* 21(2):498–516.
- **Lin–Kernighan–Helsgaun (LKH):** α-érték (minimum-feszítőfa alapú)
  a nyers távolság helyett; modern változatai neurális hálóval
  kombinálva (NeuroLKH, arXiv:2110.07983; VSR-LKH, arXiv:2012.04461).
- **Chained Lin-Kernighan:** a megtalált kör „berúgása"
  (double-bridge 4-opt perturbáció) és újrafuttatás — Martin–Otto–Felten
  1991; ez már SZIMULÁLT HŰTÉS-szerű perturbáció (l. §3.4!).

### 3.3 Metaheurisztikák — áttekintés

| Metaheurisztika | Ötlet | TSP-re |
|---|---|---|
| Szimulált hűtés (annealing) | termikus fluktuáció + fokozatos hűtés | elfogadja a romló lépést exp(Δ/T)-vel; l. §3.4 |
| Tabukeresés | tiloslista a visszalépések ellen | memória-vezérelt lokális keresés |
| Hangyakolónia (ACO) | feromon-nyomvonal + valószínűségi útépítés | Dorigo; párhuzamos konstrukció + erősítés |
| **Genetikus algoritmus (GA)** | populáció + szelekció + keresztezés + mutáció | l. §3.5 — AZ EVOLÚCIÓS VONAL! |

### 3.4 A SZIMULÁLT HŰTÉS ÉS A CARNOT-KAPCSOLAT

**Az eredet:** Kirkpatrick–Gelatt–Vecchi 1983 (*Science* 220:671–680)
„Optimization by Simulated Annealing"; függetlenül Černý 1985. A módszer a
fémkihűlés (annealing) analógiája: magas hőmérsékleten az anyag atomjai
kilépnek a lokális minimumokból; lassú hűtéssel éri el a globális
minimumot (kristályt).

**A mechanizmus:** Metropolis-féle elfogadás — egy ΔE romlás
valószínűsége p = exp(−ΔE/T); a hőmérséklet T ütemterv szerint csökken
(pl. Tₖ₊₁ = γ·Tₖ, γ ≈ 0,95). Logaritmikus hűtés (T ∝ 1/ln k) esetén a
módszer **aszimptotikusan konvergál a globális minimumhoz**
(Geman–German-féle tétel) — de a gyakorlatban alkalmazhatatlanul lassú;
a gyors ütemtervek elvesztik a garanciát (forrás: Cornell Optimization
Wiki + ScienceDirect-tanulmány, l. §5).

**A CARNOT-KAPCSOLAT (őszintén jelölve: ANALÓGIA, §17/§18):**

- A szimulált hűtés **hőmérséklete** a termodinamikai hőmérséklet
  FORMÁLISÁTVATA: a p = exp(−ΔE/T) Boltzmann-tényező valódi statisztikus
  fizika. Ez NEM pusztán metafora — a Markov-lánc egyensúlyi
  eloszlása a Boltzmann-eloszlás.
- DE: a számítás **nem Carnot-ciklusban zajlik** — nincs valódi
  munkavégzés, nincs hideg-meleg tartály, a hatásfok fogalma NEM
  definiálható rá szigorúan. A projekt `CarnotCiklus_v1.idr` modulja
  (CarnotLépés, hatásfok, landauerKüszöb) a FIZIKAI költséget modellezi
  (Landauer-elsév a szelekció törlésére — EvolutivKereso-terv §5.5);
  a szimulált hűtés viszont a KERESÉSI folyamat hőmérséklet-paramétere.
- A két gondolat rokona, mert mindkettő a **hőmérséklet mint irányítás**
  elvén nyugszik: a hűtés üteme ↔ a generációváltás energiaköltsége.
  A kapcsolat tehát STRUKTURÁLIS (ugyanaz a matematikai forma:
  exponenciális súlyozás hőmérsékleti paraméterrel), de NEM azonos
  fizikai tartalommal. Ezt így jegyezzük — nem többet, nem kevesebbet.

### 3.5 GENETIKUS ALGORITMUSOK TSP-RE — AZ EVOLÚCIÓS VONAL

**Miért kulcsfontosságú a Szima-projektnek:** a projekt célja az
`EvolutivKereso_v1` (docs/EvoluciosAlgoritmusok_Tanulas.md §5) — egy
evolúciós kereső, amely a Gondolkodót a célfogalom felé viszi. A TSP-GA
irodalom ennek a KÖZVETLEN előzménye:

1. **A kromoszóma = permutáció.** Egy egyed a városok sorrendje —
   a Gondolkodónál: fogalmak (gyökszavak) sorrendje egy útvonalon.
2. **Keresztezés (crossover) — a permutáció-zárt operátorok:**
   - **OX (order crossover)** — Davis; szülői részsorrend megőrzése
     relatív sorrenddel (Hussain et al. 2017 áttekintés szerint a
     legelterjedtebb);
   - PMX (partially mapped), ERX (edge recombination) stb.
   - A kulcs-feltétel: az utód ÉRVÉNYES permutáció maradjon
     (semmi város se duplázódjon) — ugyanez a feltétel a gyökrács-út
     esetén: a fogalom-lista maradjon érvényes lánc.
3. **Mutáció:** swap / inversion / insertion — a gyökrácson a Weyl-
   tükrözés lépéseinek megfelelője (EvolutivKereso-terv §5.7 kvantum-út).
4. **Fitness:** a kör hossza (minél rövidebb, annál jobb) — a
   Gondolkodónál: koherencia (fázistényező) + jelentés-távolság a
   célfogalomtól (GyokSzo_v1.jelentésTávolság) — terv §5.4.
5. **Elitizmus + Landauer-árazás:** a legjobbak változatlanul átmennek;
   a kiesők törlésének fizikai alsó korlátja a `landauerKüszöb`
   (CarnotCiklus_v1) — EZ a projekt saját hozzájárulása ehhez a vonalhoz.

**Irodalom:** Goldberg & Lingle 1985 („Alleles, loci, and the traveling
salesman problem"); Hussain, Muhammad et al. 2017, „Genetic Algorithm for
Traveling Salesman Problem with Modified Cycle Crossover Operator"
(*Computational Intelligence and Neuroscience*, PMC5676484, ~255 hivatkozás
— áttekintés a keresztező operátorokról).

---

## 4. Kvantum-megközelítések / Quantum approaches

量子方法 · Quantenansätze · גישות קוונטיות

### 4.1 Az Ising/QUBO-formuláció

A TSP átalakítható **Ising-hamiltoniánussá**: bináris változók x_{v,t}
(város v a t. pozíción — „one-hot" kódolás), költségfüggvény =
élsúly-tagok + büntetőtagok (minden város pontosan egyszer, minden
pozíció pontosan egy város). Kanonikus referencia: **Lucas 2014, „Ising
formulations of many NP problems"** (*Frontiers in Physics* 2:5) — a TSP
esete ott szerepel. Modern alkalmazás: arXiv:2512.24308 („Quantum
Computing, Ising Formulation, and the Traveling Salesman Problem").

**Erőforrás-kritika (fontos):** a one-hot kódolás **O(n²) qubitet igényel**
— n=240 gyökre 57 600 qubit (plusz büntetőtagok) — a mai gépeken messze
megvalósíthatatlan. Errefelé dolgoznak a tömörített kódolások:
arXiv:2605.00739 (resource-efficient variational keret), arXiv:2512.17291
(él-alapú kódolás, csökkentett altér).

### 4.2 QAOA — kvantum-közelítő optimalizációs algoritmus

- A QAOA (Farhi–Goldstone–Gutmann 2014) alternáló unitérek: a
  költség-hamiltoniánus evolúciója + mixer, p rétegben; a mérés
  valószínűségi köröket ad.
- TSP-re: a constraint-preserving mixerek kutatása él (Grover-mixer
  QAOA — arXiv:2606.11530); variációs keretek TSP-re: arXiv:2605.00739,
  arXiv:2509.22752 (variációs kvantum Kolmogorov–Arnold háló).
- **Őszinte állapot (§18):** a mai NISQ-eszközökön a QAOA-TSP kísérleti
  demonstrációi néhány csúcsos példányokra szorítkoznak; a kvantum-előny
  (speedup) TSP-re NEM bizonyított — ez SPECULATÍV jelölést kap.

### 4.3 Kvantum-annealing (D-Wave)

- A szimulált hűtés KVANTUM-MEGFELELŐJE: a hőmérséklet-fluktuáció helyett
  **kvantum-fluktuáció** (transzverzális mező) olvasztja át a barriereket;
  a végső állapot a probléma Ising-hamiltoniánusának alapállapota
  felé hajlik.
- TSP-TANULMÁNYOK D-Wave-en: Steiner-TSP annealinggel (arXiv:2504.02388,
  13 szavazattal az alphaxiv-on); fotons/kapucsíraprogramok
  összehasonlítása TSP-re (arXiv:2502.17725); kvantum-iteratív megközelítés
  (arXiv:2606.11843); kvantum oszd-meg-és-uralkodj a Held–Karp
  exponensének javítására (arXiv:2606.07322 — a báziscsökkentés
  elméleti eredménye).
- Klasszikus–kvantum összehasonlító keret: arXiv:2607.24581 (négy módszer
  kvantitatív vetítése).

**Kapcsolat a §3.4-gyel:** a kvantum-annealing a szimulált hűtés testvére —
mindkettő „lassan csillapított fluktuációval keresi az alapállapotot".
A projekt Carnot-analógiája (hőmérséklet mint irányítás) ITT válik
legközelebbi a valós fizikához: az annealer valódi fizikai berendezés,
amelynek olvasztási üteme energia-költségvetés alatt áll.

---

## 5. Kulcscikkek és források / Key papers and sources

关键文献与来源 · Schlüsselliteratur und Quellen · מקורות ומאמרי מפתח

### 5.1 Klasszikusok

1. **Karp, R. M. (1972).** Reducibility among Combinatorial Problems.
   Complexity of Computer Computations, 85–103.
   https://cgi.di.uoa.gr/~sgk/teaching/grad/handouts/karp.pdf
2. **Bellman, R. (1962).** Dynamic Programming Treatment of the Travelling
   Salesman Problem. *Journal of the ACM* 9(1):61–63.
   https://doi.org/10.1145/321105.321111
3. **Held, M., Karp, R. M. (1962).** A Dynamic Programming Approach to
   Sequencing Problems. *Journal of the Society for Industrial and Applied
   Mathematics* 10(1):196–210. https://doi.org/10.1145/800029.808532
4. **Miller, C. E., Tucker, A. W., Zemlin, R. A. (1960).** Integer
   Programming Formulation of Traveling Salesman Problems. *Journal of the
   ACM* 7(4):326–329.
5. **Dantzig, G., Fulkerson, R., Johnson, S. (1954).** Solution of a
   Large-Scale Traveling-Salesman Problem. *Operations Research*
   2(4):393–410.
6. **Croes, G. A. (1958).** A Method for Solving Traveling-Salesman
   Problems. *Operations Research* 5(6):791–812.
7. **Lin, S. (1965).** Computer Solutions of the Traveling-Salesman
   Problem. *Bell System Technical Journal* 44:2245–2269.
8. **Lin, S., Kernighan, B. W. (1973).** An Effective Heuristic Algorithm
   for the Traveling-Salesman Problem. *Operations Research*
   21(2):498–516. PDF: https://www.cs.princeton.edu/~bwk/btl.mirror/tsp.pdf
9. **Kirkpatrick, S., Gelatt Jr., C. D., Vecchi, M. P. (1983).**
   Optimization by Simulated Annealing. *Science* 220(4598):671–680.
   PDF: https://www2.stat.duke.edu/~scs/Courses/Stat376/Papers/TemperAnneal/KirkpatrickAnnealScience1983.pdf
10. **Černý, V. (1985).** Thermodynamical approach to the traveling
    salesman problem. *Journal of Optimization Theory and Applications*
    45:41–51.
11. **Goldberg, D. E., Lingle, R. (1985).** Alleles, loci, and the
    traveling salesman problem. *Proceedings of ICGA '85*, 154–159.
12. **Applegate, D., Bixby, R., Chvátal, V., Cook, W.** — Concorde TSP
    Solver: https://www.math.uwaterloo.ca/tsp/concorde.html
13. **Helsgaun, K. (2000).** An effective implementation of the
    Lin-Kernighan traveling salesmen heuristic. *European Journal of
    Operational Research* 126(1):106–130. LKH:
    http://webhotel4.ruc.dk/~keld/research/LKH-3/
14. **Lucas, A. (2014).** Ising formulations of many NP problems.
    *Frontiers in Physics* 2:5. https://doi.org/10.3389/fphy.2014.00005
15. **Farhi, E., Goldstone, J., Gutmann, S. (2014).** A Quantum Approximate
    Optimization Algorithm. arXiv:1411.4028.
16. **Hussain, A., Muhammad, Y. S., Nauman Sajid, M., Hussain, I.,
    Shoukry, A. M., Gani, S. (2017).** Genetic Algorithm for Traveling
    Salesman Problem with Modified Cycle Crossover Operator.
    *Computational Intelligence and Neuroscience* 2017:7430125.
    https://pmc.ncbi.nlm.nih.gov/articles/PMC5676484/

### 5.2 Friss kutatások (arXiv — alphaxiv-on indexelve)

17. **NeuroLKH** (2021): mélytanulás + LKH. https://www.alphaxiv.org/abs/2110.07983
18. **VSR-LKH** (2021): megerősítéses tanulás + LKH. https://www.alphaxiv.org/abs/2012.04461
19. **Párhuzamos egzakt/heurisztikus/metaheurisztikus áttekintés** (2025):
    https://www.alphaxiv.org/abs/2505.18278
20. **Ising-formuláció és TSP** (2025): https://www.alphaxiv.org/abs/2512.24308
21. **Steiner-TSP kvantum-annealinggel** (2025): https://www.alphaxiv.org/abs/2504.02388
22. **Erőforrás-hatékony variációs kvantumkeret** (2026): https://www.alphaxiv.org/abs/2605.00739
23. **Kvantum oszd-meg-és-uralkodj vs. Held–Karp** (2026): https://www.alphaxiv.org/abs/2606.07322
24. **Klasszikus–kvantum összehasonlító keret** (2026): https://www.alphaxiv.org/abs/2607.24581
25. **Grover-mixeres constraint-preserving QAOA** (2026): https://www.alphaxiv.org/abs/2606.11530
26. **Szimulált hűtés — Cornell Optimalizációs Tankönyv (wiki):**
    https://optimization.cbe.cornell.edu/index.php?title=Simulated_annealing
27. **Szimulált hűtés TSP-re, térbeli korrelációkkal** (ScienceDirect):
    https://www.sciencedirect.com/science/article/abs/pii/S037843712100340X

---

## 6. A Szima-kapcsolat / The Szima connection

与西玛项目的联系 · Die Szima-Verbindung · הקשר לפרויקט Szima

### 6.1 A Gondolkodó cél-elérése = kombinatorikus útkeresés

A `docs/EvoluciosAlgoritmusok_Tanulas.md` §5 szerint a Gondolkodó feladata:
„juttass el A fogalomból B fogalomig". A gyökrácson (a 240 E8-gyök =
fogalom-csúcs) ez a **legrövidebb út / legrövidebb kör** problémája:

- **Csúcs:** a 240 gyök (112 típus-1 EGÉSZ szó + 128 típus-2 FÉL-EGÉSZ
  szó — `bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst`,
  GyokSzo_v1).
- **Élsúly:** a `jelentésTávolság : GyökSzó -> GyökSzó -> HasonlóságÖtSzint`
  (IMPORTÁLT `belsoszorzat`-ból, GyokSzo_v1:181–190) — ötszintű skála:
  ⟨α,β⟩/8 ∈ {+1, +½, 0, −½, −1} (AzonosJel, SzorosanHasonló, Semleges,
  EllentétesRokon, Ellentett).
- **A Gondolkodó útja:** fogalom-lánc a gyökrácson — az utazó ügynök
  útvonala, ahol a „városok" fogalmak, a „távolság" a jelentés-távolság.

### 6.2 Az „ügynök" kettős jelentése

- **utazó ügynök (salesman):** a TSP klasszikus hőse;
- **AI-ügynök:** a projekt célja — az önvezérelt gondolkodó.
- A TSP tehát a Gondolkodó ÚTKERESŐ RÉTEGEINEK MATEMATIKAI VÁZA: a
  „hogyan jutok A-ból B-be a lehető legkoherensebb fogalom-láncon"
  kérdés formális szerkezete megegyezik a „hogyan járjam be minden
  fogalmat a legrövidebb körön" kérdéssel.

### 6.3 Példa-számolás: 3–4 gyök közötti kör (SZIMBOLIKUS — §18)

A számokat a projektből vesszük — mind Refl-bizonyított érték a
`GyokSzo_v1.idr`-ből (§4c bizonyítások):

**A példa-szavak** (GyokSzo_v1:192–219):

| Jelölés | Gyök | Osztály |
|---|---|---|
| E = PéldaEgészSzó | (2,2,0⁶) | EGÉSZ (állandó fogalom) |
| É = PéldaEllentettSzó | (−2,−2,0⁶) | EGÉSZ |
| M = PéldaMerőlegesSzó | (2,−2,0⁶) | EGÉSZ |
| F = PéldaFélEgészSzó | (1⁸) | FÉL-EGÉSZ (kapcsolati fogalom) |

**A távolság-mátrix** (Refl-bizonyított párok + belsoszorzatból számolt
értékek):

| Pár | ⟨α,β⟩ | jelentésTávolság | Hasonlóság |
|---|---|---|---|
| E↔E | +8 | AzonosJel | +1 |
| E↔F | +4 | SzorosanHasonló | +½ |
| E↔M | 0 | Semleges | 0 |
| E↔É | −8 | Ellentett | −1 |
| M↔F | 2−2=0 | Semleges | 0 |
| É↔M | −4+4=0 | Semleges | 0 |

(Az E↔F, E↔M, E↔É sorok Refl-lel bizonyítottak a GyokSzo_v1 §4c-ben;
az M↔F és É↔M sorok az IMPORTÁLT `belsoszorzat` képletéből következnek —
itt most kézzel számoljuk őket, NEM Refl-lel. Őszintén jelölve.)

**A költség-konvenció (VÁLASZTÁS — jelezve):** a hasonlóság magas értéke
ROKONSÁGot jelent, nem költséget; az út „hosszaként" a
k = 1 − hasonlóság konvenciót választjuk (k∈{0, ½, 1, 1½, 2}).

**Kör A:** E → M → F → E

```
k(E,M) + k(M,F) + k(F,E) = (1−0) + (1−0) + (1−½) = 1 + 1 + ½ = 5/2
```

**Kör B:** E → É → M → E

```
k(E,É) + k(É,M) + k(M,E) = (1−(−1)) + (1−0) + (1−0) = 2 + 1 + 1 = 4
```

**Eredmény:** a Kör A (5/2 = 2,5) RÖVIDEBB, mint a Kör B (4) — az
ügynök számára az út, amely a merőleges és a fél-egész kapcsolati
fogalmakon átível, kedvezőbb, mint amelyik az ellentett fogalomon
átugrik. (Megjegyzés: A fordított iránya ugyanolyan hosszú — szimmetrikus
eset; az aszimmetrikus ATSP-változat a CPT-irányú morfizmusokkal jönne.)

**Őszinte kritika (§18 — fontos):**

1. A `jelentésTávolság` ötszintű skálája **ORDINÁLIS, NEM METRIKA**:
   nem garantált rajta a háromszög-egyenlőtlenség (pl. k(E,F)+k(F,M) = ½+1
   < k(E,M) = 1 — ITT még teljesül, DE általában nem ellenőriztük a
   teljes 240×240 mátrixon). Tehát ez **nem-metrikus TSP** — a
   Christofides-garancia NEM él rá. (A teljes ellenőrzés egy jövendő
   Idris-feladat.)
2. A k = 1 − hasonlóság konvenció egy VÁLASZTÁS; más konvenció
   (pl. k' = 2 − 2·hasonlóság) ugyanazokat a sorrendeket adja, de a
   táblázat értékeit megváltoztatná.
3. A fenti számolás SZIMBOLIKUS (kézi, a Refl-bizonyított értékekből) —
   a numerikus verifikáció (AGENTS §1.0: minden számítás Idrisben!)
   a jövendő `UtozoUgynok_v1` modul feladata lesz.

### 6.4 Jövőbeli Idris-vázlat — `UtozoUgynok_v1` (CSAK VÁZLAT!)

```idris
-- ═══════════════════════════════════════════════════════════════
-- UTAZÓ ÜGYNÖK v1 — MODUL-VÁZLAT (NEM implementáció!)
-- 旅行商 v1 —— 模块草案 · Modulentwurf · שלד מודול
-- §24: IMPORTÁLANDÓ — jelentésTávolság (GyokSzo_v1), a gyöklista
--      (AlapszókincsKonst), semmi nincs újraírva.
-- Írás ELŐTT betöltendő (AGENTS §13): MANTRA.md, HOROG.md,
--      skills/idris-stilus/SKILL.md, OLVASD.md, context7.
-- ═══════════════════════════════════════════════════════════════

module UtozoUgynok_v1

import GyokSzo_v1        -- jelentésTávolság, HasonlóságÖtSzint, AlapszókincsKonst (§24)
import Data.List         -- length, ++ (standard — §24)

-- 1. A GRÁF: a gyökrács csúcsai = a 240 gyök; él = bármely pár
--    (teljes gráf — a jelentésTávolság minden párra definiált).
public export
record Utvonal where        -- a kör: csúcsok sorrendje + záró él
  constructor UtvonalKonstruktor
  csúcsok : List GyökSzó    -- a sorrend maga a kromoszóma (GA!)

-- 2. A HOSSZ-FÜGGVÉNY: a k = 1 − hasonlóság konvencióval (§6.3).
--    (Double vagy Racionális — a döntés a végleges modulé.)

-- 3. A 2-OPT LÉPÉS: két él cseréje — REFL-CÉL:
--    bizonyítandó, hogy a lépés UTÁN a struktúra ÉRVÉNYES KÖR marad
--    (minden csúcs pontosan egyszer) — ez a §3.2 „kör érvényessége".

-- 4. REFLEFL-CÉLOK (példák):
--    - bizKétOptÉrvényesKör : a 2-opt zártságot őriz;
--    - bizUtvonalHosszSzimetria : az irány megfordítása nem változtatja
--      a hosszat (szimmetrikus eset).
-- ═══════════════════════════════════════════════════════════════
```

(Ez a vázlat a `docs/EvoluciosAlgoritmusok_Tanulas.md` §5.8
`EvolutivKereso_v1` vázlattal együtt él: az evolúciós kereső POPULÁCIÓJA
utvonalakból állhat, a fitness pedig a kör hosszának megfordítása.)

---

## 7. Négy nyelvű összefoglaló / Four-language summary

四语总结 · Vierprachige Zusammenfassung · סיכום ארבע-שפתי

**Magyar:** Az utazó ügynök problémája (TSP) a legrövidebb Hamilton-kör
keresése — NP-nehéz (Karp 1972, Hamilton-körre visszavezetve), a
körök száma (n−1)!/2. Egzakt módszerek: Held–Karp dinamikus programozás
Θ(n²2ⁿ), branch-and-bound, ILP (Concorde: 85 900 város). Heurisztikák:
2-opt, Lin–Kernighan (változó k-opt); metaheurisztikák: szimulált hűtés
(Kirkpatrick 1983 — a hőmérséklet mint irányítás, a Carnot-gondolat
STRUKTURÁLIS rokona, nem azonos fizika), hangyakolónia, és GENETIKUS
ALGORITMUSOK (permutáció-kromoszóma, OX-keresztezés) — az evolúciós vonal
közvetlen előzményei. Kvantum: Ising-formuláció (Lucas 2014, O(n²) qubit),
QAOA, D-Wave-annealing. A Szima-kapcsolat: a gyökrács 240 csúcsa =
város, a jelentésTávolság = élsúly; a példa-számolásban az
E→M→F→E kör (5/2) rövidebb, mint az E→É→M→E (4) — az ügynök a
kapcsolati fogalmakon átívelő utat részesíti előnyben az ellentetten
átugrónál.

**中文：** 旅行商问题（TSP）寻找最短哈密顿回路——NP困难（Karp 1972，
归约自哈密顿回路），回路数为 (n−1)!/2。精确方法：Held–Karp 动态规划
Θ(n²2ⁿ)、分支限界、整数线性规划（Concorde 解出 85 900 城）。
启发式：2-opt、Lin–Kernighan；元启发式：模拟退火（1983，温度作为
控制——与卡诺思想结构同源但非同一物理）、蚁群、遗传算法（排列染色体、
OX 交叉）——即本项目进化搜索线的直接前身。量子方法：Ising 形式化
（Lucas 2014，需 O(n²) 比特）、QAOA、D-Wave 退火。Szima 联系：
根格 240 顶点＝城市，意义距离＝边权；例算中环 E→M→F→E（5/2）
短于 E→É→M→E（4）——智能体偏爱经由关系型概念的路径。

**Deutsch:** Das Problem des Handlungsreisenden (TSP) sucht den
kürzesten Hamilton-Kreis — NP-schwer (Karp 1972, Reduktion vom
Hamilton-Kreis), die Anzahl der Kreise beträgt (n−1)!/2. Exakte
Methoden: Held–Karp-Dynamische Programmierung Θ(n²2ⁿ),
Branch-and-Bound, ganzzahlige lineare Programmierung (Concorde: 85 900
Städte). Heuristiken: 2-opt, Lin–Kernighan; Metaheuristiken: Simulated
Annealing (1983 — Temperatur als Steuergröße, strukturell verwandt mit
dem Carnot-Gedanken, aber nicht dieselbe Physik), Ameisenkolonie und
GENETISCHE ALGORITHMEN (Permutations-Chromosomen, OX-Crossover) — die
direkten Vorläufer der evolutionären Linie dieses Projekts. Quanten:
Ising-Formulierung (Lucas 2014, O(n²) Qubits), QAOA, D-Wave-Annealing.
Szima-Verbindung: das Wurzelgitter mit 240 Knoten = Städte, die
Bedeutungsdistanz = Kantengewicht; im Beispiel ist der Kreis
E→M→F→E (5/2) kürzer als E→É→M→E (4).

**עברית:** בעיית הסוכן הנוסע (TSP) מחפשת את מעגל המילטון הקצר ביותר —
קשה-NP (Karp 1972, הפחתה ממעגל המילטון), מספר המעגלים (n−1)!/2.
שיטות מדויקות: תכנות דינמי Held–Karp‏ Θ(n²2ⁿ), branch-and-bound,
תכנות ליניארי שלם (Concorde: 85,900 ערים). היוריסטיקות: 2-opt,
Lin–Kernighan; מטא-היוריסטיקות: חימום מדומה (1983 — הטמפרטורה כבקרה,
קרובה מבחינה מבנית לרעיון קרנו אך לא אותה פיזיקה), מושבת נמלים
ואלגוריתמים גנטיים (כרומוזום-פרמוטציה, שחלוף OX) — הקדמה ישירה
לקו האבולוציוני של הפרויקט. קוונטום: ניסוח Ising‏ (Lucas 2014,
‏O(n²) קיוביטים), QAOA, חימום D-Wave. הקשר ל-Szima: סריג השורשים
240 קודקודים = ערים, מרחק-המשמעות = משקל קשת; בדוגמה המעגל
E→M→F→E ‏(5/2) קצר מ-E→É→M→E ‏(4).

---

*Dokumentum vége — információveszteség nélkül (AGENTS §16):
minden felfedezett forrás, érték és óvatossági megjegyzés rögzítve.*
