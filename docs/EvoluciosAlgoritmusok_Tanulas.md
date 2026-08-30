# Evolúciós algoritmusok — tanulási dokumentum v1
## 演化算法学习文档 v1 · Lern-Dokument: Evolutionäre Algorithmen v1 · מסמך למידה: אלגוריתמים אבולוציוניים v1

**Készült:** 2026-08-24 · **Készítette:** general ügynök (Szima-projekt)
**Feladat:** evolúciós algoritmusok kutatása + tanulási dokumentum; a kereső
alapja a meglévő Szima-modulok lesz (`Mondat_v1`, `SzintaxisMorfizmus_v1`,
`GyokSzo_v1`, `CarnotCiklus_v1`, `FazisAlgebra_v2`, `E8BelsoSzorzat`).

---

## 0. Olvasott alapanyag és módszer · 已读材料与方法 · Gelesene Grundlage und Methode · חומר הבסיס שנקרא

A dokumentum írása ELŐTT elolvastuk (§N11):

- `AGENTS.md` (gyökér) — §1.0 (minden számítás Idrisben), §17 (mérési
  hiba-kötelezettség: Δ/σ), §18 (őszinte verifikáció: tautológia tilos,
  két független út egy híddal), §24 (kód duplikáció tilos — import!);
- `HOROG.md` — a 7+ szindróma, a bírák listája, a csomagolási szabály;
- `szima_ter/modul/Mondat_v1.idr` — `CímkézettMondat`, `CPTBélyeg`,
  `fázistényező`, `végpontCPTMutató`, a 27 bélyeg enumerációja;
- `szima_ter/modul/SzintaxisMorfizmus_v1.idr` — a `SzintaxisMorfizmus`
  typeclass (`komponál`, `ellenpont`), a `Mondat` láncolt rekord,
  a `mondatVégpont` foldl-számítás, az involúció- és zártság-bizonyítások;
- `szima_ter/modul/GyokSzo_v1.idr` — `GyökSzó`, `jelentésTávolság`,
  a `HasonlóságÖtSzint` ötszintű skála, az `alapszókincs` (240 szó);
- `szima_ter/modul/CarnotCiklus_v1.idr` — `CarnotLépés`, `CarnotÁllapot`,
  `következőÁllapot`, `teljesCiklus`, `hatásfokTört`, `landauerKüszöb`;
- `szima_ter/modul/FazisAlgebra_v2.idr` — `ToltesParitasIdo`,
  `fazisFaktorialis`;
- `szima_ter/modul/E8BelsoSzorzat.idr` — `belsoszorzat`, `weylReflexio`,
  `zarasHibakSzama` (a 57 600 reflexió zártságának kimerítő mérése);
- `docs/ZeneElemzes_Sziami_v1.md` — a ritmus mint időkvantálás; a mért
  eseményráta-megmaradás (~3,6 esemény/s); az órajel mint a dekoherencia
  ellenszere.

A kutatás módszere (§N12): MCP-eszközökkel (brave-search, exa, firecrawl,
alphaxiv) előre megtervezett keresések — (1) evolúciós algoritmusok
alapjai, (2) kvantum-inspirált/kvantum evolúciós algoritmusok, (3) a
szelekció termodinamikai költsége (Landauer), (4) evolúciós keresés
rácson. Minden állítás forrását a 7. szakasz jegyzéke sorolja.

---

## 1. Az evolúciós hurok anatómia · 演化循环的解剖 · Die Anatomie der
## Evolutionsschleife · אנטומיה של לולאת האבולוציה

### 1.1 Az öt fázis

Az evolúciós algoritmus (EA) egy populáció-alapú metaheurisztika: a
megoldások egy N elemű halmazát (a **populáció**) tartja karban, és
ismételt, fitnesz-vezérelt variációval keresi a jobb megoldást
(forrás: Wikipedia Genetic algorithm; Mitchell 1999).

1. **Inicializálás.** Az első generáció N egyede: véletlen, vagy a
   probléma konstansaiból épített kezdőegyedek.
2. **Kiértékelés.** Minden egyedre kiszámolódik a **fitness** (alkalmasság)
   érték: egy valós szám, amely azt méri, mennyire oldja meg az egyed a
   feladatot. A fitness-függvény az egyetlen pont, ahol a feladat
   definíciója belép a hurokba („black-box" kiértékelés).
3. **Szelekció.** Szülők kiválasztása a fitnesz szerint. A fő módszerek:
   - **rulettkerék** (fitness-arányos): az i-edik egyed kiválasztási
     valószínűsége f_i / Σf_j (Holland eredeti GA-ja így választott);
   - **verseny** (tournament): k darab véletlen egyed közül a legjobb
     nyer; a gyakorlatban ez a legelterjedtebb alapbeállítás;
   - **csonkolás** (truncation): a fitnesz szerint rendezett populáció
     felső 10–50%-a megy tovább;
   - **élitmásolás** (elitism): a legjobb e darab egyed operátorok
     NÉLKÜL, változatlanul átmegy a következő generációba — ez
     megakadályozza a legjobb megoldás elvesztését
     (forrás: Wikipedia Selection (evolutionary algorithm);
      Algorithm Afternoon; Martin Pilát EA-intro).
4. **Variáció.** Új egyedek (utódok) gyártása:
   - **keresztezés** (crossover): két szülő genetikai információjának
     cseréje (egy-, két- vagy egységes pontvágással);
   - **mutáció**: egy egyed kis, véletlen módosítása — ez a
     feltárás (exploration) motorja, a lokális optimumokból való
     kiszabadulás eszköze.
5. **Új generáció.** Az utódok (és az élitek) kitöltik az N helyet;
   a hurok visszatér a 2. fázishoz. Megállás: adott generációszám
   után, vagy ha a legjobb fitnesz platóra ér.

### 1.2 Szöveg-ábra

```
┌────────────────────────────────────────────────────────────┐
│  g. generáció                                              │
│                                                            │
│  [KIÉRTÉKELÉS]  fitness minden egyedre                     │
│        ↓                                                   │
│  [SZELEKCIÓ]    szülők (rulett / verseny / csonkolás)      │
│                 + élitek (változatlanul tovább)            │
│        ↓                                                   │
│  [VARIÁCIÓ]     keresztezés (két szülő → utód)             │
│                 mutáció    (egy egyed kis módosítása)      │
│        ↓                                                   │
│  [ÚJ GENERÁCIÓ] utódok + élitek = N egyed ─────────────────┼──→ g+1
│                                                            │
│  (a hurok üteme: a Carnot-négylépés — l. §4 és §5.6)       │
└────────────────────────────────────────────────────────────┘
```

### 1.3 A két erő

- **Feltárás (exploration):** nagy mutációs lépések, magas diverzitás —
  széles keresés, lassú konvergencia.
- **Kiaknázás (exploitation):** erős szelekció, keresztezés — gyors
  konvergencia, lokális optimumba ragadás veszélye.
- Az élitmásolás erős kiaknázás: gyorsabb konvergenciát ad, de
  csökkenti a diverzitást — a gyakorlati tanács: élitmásolás + verseny-
  szelekció kombinációja, kis élitaránnyal (forrás: cstheory.stackexchange
  11381; woodruff.dev Day 6).

---

## 2. A fő fajták · 主要类型 · Die Hauptarten · הזנים העיקריים

| Fajta | Mit változtat (kromoszóma + operátorok) | Mire jó | Forrás |
|---|---|---|---|
| **GA** — genetikus algoritmus (Holland 1975) | Diszkrét kromoszóma (bit- vagy szimbólumsor); keresztezés az ELSŐDLEGES operátor, mutáció másodlagos; fitness-arányos szelekció | Kombinatorikus optimalizálás, ütemezés, jellemző-kiválasztás | https://en.wikipedia.org/wiki/Genetic_algorithm ; Mitchell (1999) *An Introduction to Genetic Algorithms*, MIT Press |
| **ES** — evolúciós stratégiák (Rechenberg, Schwefel, 1960-as évek) | Valós vektorkromoszóma; a mutáció többváltozós normális mintavétel N(0, σ²C); a lépéshossz σ ÖNADAPTÍV ((μ,λ) ill. (μ+λ) szelekció; Rechenberg 1/5-szabály) | Folytonos feketeláda-optimalizálás | Hansen (2015): http://www.cmap.polytechnique.fr/~nikolaus.hansen/es-overview-2015.pdf |
| **CMA-ES** — kovarianciamátrix-adaptáció (Hansen–Ostermeier 1996/2001) | Az ES általánosítása: a teljes KOVARIANCIAMÁTRIX adaptálása (korrelált mutációk) + kumulativ lépéshossz-adaptáció (CSA); természetes-gradiens interpretáció | Ill-kondicionált, nem szeparálható folytonos problémák — a folytonos evolúciós számítás de facto standardja | https://dl.acm.org/doi/10.1145/2001858.2002123 ; Hansen & Ostermeier (2001), *Evolutionary Computation* 9(2):159–195 |
| **GP** — genetikus programozás (Koza 1992) | Maga a PROGRAM a kromoszóma (kifejezési fa); keresztezés = részfa-csere, mutáció = csomópont-csere | Szimbolikus regresszió, automatikus program-szintézis, szabály-felfedezés | https://en.wikipedia.org/wiki/Genetic_programming ; Koza (1992), *Genetic Programming*, MIT Press |
| **DE** — differenciális evolúció (Storn–Price 1995) | Valós vektor; SPECIÁLIS mutáció: v = x_r1 + F·(x_r2 − x_r3) — két véletlen populációtagnak a különbsége skálázva hozzáadódik egy harmadikhoz; bináris keresztezés (Cr) | Egyszerű, robusztus globális optimalizáló valós terekben | Das et al. (2018), DE-survey: https://www.mdpi.com/2076-3417/8/10/1945 |

Megjegyzés (a táblázat mögötti közös szerkezet): mind az öt fajta UGYANAZT
a hurkot futtatja (§1), csak a KROMOSZÓMA-TÍPUS és a VARIÁCIÓS OPERÁTOR
különbözik. Ez azért fontos a Szima-tervnek, mert a mi esetünkben a
kromoszóma a `CímkézettMondat`, a variációs operátorok pedig a meglévő
algebrai műveletekből (`weylReflexio`, `komponál`) épülnek — l. §5.

---

## 3. Kvantum evolúció · 量子演化 · Quantenevolution · אבולוציה קוונטית

### 3.1 A mechanizmus (Han–Kim 2000, QEA/QIGA)

A kvantum-inspirált evolúciós algoritmus (Quantum-inspired Evolutionary
Algorithm, QEA; Han & Kim 2000) a kromoszómát qubitekként kódolja:

1. **Qubit-kromoszóma.** Minden gén egy szuperpozíció:
   |Ψ⟩ = α·|0⟩ + β·|1⟩, ahol |α|² + |β|² = 1. A megoldás tehát
   VALÓSZÍNŰSÉG-AMPLITÚDÓKKAL él — egy m-qubites kromoszóma a
   2^m lehetséges bites megoldás eloszlását hordozza.
2. **Megfigyelés (observation).** A qubit |α|² (illetve |β|²)
   valószínűséggel omlászik össze 0-ra (illetve 1-re) → konkrét bináris
   megoldások, amelyek fitness-e klasszikusan számolódik.
3. **Rotációs kapu frissítés (QRG).** A legfontosabb frissítő operátor:
   U(θ) = [[cos θ, −sin θ], [sin θ, cos θ]] elforgatja az amplitúdókat a
   pillanatnyilag legjobb megoldás irányába; θ előjelét és nagyságát
   keresőtábla (lookup table) adja — a QRG egyetlen paramétere a
   forgatási szög (forrás: Zhang et al., QRG-review,
   https://www.sciencedirect.com/science/article/abs/pii/S2210650216303807 ;
   Malhotra et al., arXiv:cs/0403003).
4. **Pauli-X kapu = a klasszikus mutáció kvantum megfelelője** (az α és β
   amplitúdók cseréje; forrás: CRAN QGA-package vignette;
   Lahoz-Beltra 2016).
5. **Kis populáció, nagy tér:** a szuperpozíciós reprezentáció miatt a
   QEA kis populációval is nagy megoldásteret fed le (a ScienceDirect-
   review szó szerint: „obtain a large search solution space even under
   a small population size").

### 3.2 Miért lenne kevesebb a hődisszipáció?

**Bizonyított fizikai tények (irodalom):**

- A kvantumkapuk UNITÉR operátorok — minden unitér transzformáció
  REVERZIBILIS: egyetlen bit információt sem törölnek (Lahoz-Beltra 2016:
  „Q-gates are reversible gates"; szemben a klasszikus Boole-logikával,
  ami irreverzibilis).
- A Landauer-határ (§4) CSAK az irreverzibilis, információt TÖRLŐ
  lépésekre vonatkozik. Egy teljesen reverzibilis számítási lépés
  elméleti minimumon, nulla kötelező hőkibocsátással tartható
  (forrás: arXiv:2506.10876, Landauer-review; Bennett reverzibilis
  számítás-elmélete).
- **Szuperpozíció = párhuzamos kiértékelés:** egy n-qubites regiszteren
  a Hadamard-előkészítés után egy függvény-alkalmazás az összes 2^n
  bemenetre „egyszerre" írja be az értékeket (kvantumpárhuzamosság;
  forrás: arXiv:cs/0403003, 2. szakasz). A kiértékelési fázis tehát
  NEM N darab klasszikus fitness-számítást igényel, hanem egyetlen
  egységes evolúciót a teljes szuperpozíción.

**Őszinte jelölés (§18) — mit lehet és mit NEM állítani:**

- **Bizonyított (irodalomban):** a fenti fizikai tények; a QEA/QIGA
  klasszikus gépen is működik és jól konvergál (sok alkalmazás).
- **Bizonyított (ellenpélda!):** a klasszikus gépen futtatott QiGA-nál a
  hőelőny NEM érvényesül — ott a qubitság csak algoritmikus reprezentáció.
  Sőt, a Lahoz-Belta-féle összehasonlító mérésben a klasszikus SGA
  JOBBAN teljesített, mint a QGA/HGA változatok: az amplitúdó-rotáció
  generációnkénti ismétlése gyors konvergenciát és LOKÁLIS optimumba
  ragadást okoz (MDPI 2016, 11–12. ábra és Kruskal–Wallis teszt).
- **Javaslat / spekulatív szint:** a „kevesebb hődisszipáció" állítás
  VALÓDI kvantum-hardveren futtatott evolúciós algoritmusra vonatkozóan
  értelmes előrejelzés, de: (a) a MÉRÉS (collapse) költsége marad — a
  kiértékeléshez mérni kell; (b) a keresztezés valódi kvantum-implantálása
  máig nyílt kérdés (MDPI: „it is unclear how to carry out crossover");
  (c) a mai NISQ-eszközök zajos kapuin a disszipációt nem a Landauer-
  határ, hanem a hibaarány korlátozza (forrás: arXiv:2504.17923, EAQGA —
  IBM Eagle processzoron mért, 33,6% fitness-javulás a klasszikus GA-hoz
  képest, de zajkorlátozott mélységgel).
- A projekt számára a következtetés: a KVANTUM-ÚT (§5.7) a szuperpozíciós
  populáció felé a weylReflexio UNITÉRSSÉGÉN át vezethető volna (a Weyl-
  reflexió ortogonális, tehát unitér transzformáció) — ez azonban javaslat,
  nem vállalás.

---

## 4. Termodinamikai költség · 热力学成本 · Thermodynamische Kosten ·
## העלות התרמודינמית

### 4.1 A szelekció Landauer-ára

- **Landauer-elv (1961):** egy bit információ T hőmérsékleten történő
  TÖRLÉSÉNEK minimális energiája E_min = k_B·T·ln 2. A törölt bit hőként
  távozik a környezetbe (Landauer 1961; review: arXiv:2506.10876;
  Bormashenko 2025, PMC12026021).
- **Szám-példa 300 K-en:** E = 1,380649×10⁻²³ J/K × 300 K × ln 2
  = **2,87×10⁻²¹ J/bit**.
  - Ez pontosan a projekt `CarnotCiklus_v1.landauerKüszöb` függvényének
    értéke a 300.0 K argumentumon — IMPORT-OLHATÓ SZÁM, nem újraszámolandó
    (§24)! A `boltzmannÁllandó` (= 1,380649×10⁻²³ J/K) SI-EXAKT defináló
    állandó a 2019-es revízió óta — §17 szerint NINCS mérési σ, ezért
    Δ/σ elemzés ide nem alkalmazható; az egyetlen pontatlanság az
    IEEE-754 kerekítés.
- **A szelekció mint információ-törlés:** a szelekció döntése „az N
  egyed közül melyik menjen tovább" log₂ N bit információt hordoz; ha
  generációnként k egyed esik ki (törölhető a róluk szóló információ),
  a törölt információ mennyisége legalább k·log₂ N bit, és a kötelező
  minimum-költség:
  
  E_ciklus ≥ k · log₂ N · k_B·T·ln 2.
  
  - **Példaszámítás (a §5.2-es terveinkhez illesztve):** N = 27 egyed
    (a 27 CPT-bélyeg tisztelete), k = 13 kieső: 13 × log₂ 27
    ≈ 13 × 4,755 ≈ 61,8 bit → E ≥ 61,8 × 2,87×10⁻²¹ ≈ **1,77×10⁻¹⁹ J**
    / generáció 300 K-en.
  - **Honest framing:** ez ALSÓ KORLÁT és könyvelési egység — a tényleges
    Idris-kernel futtatása ennél sok nagyságrenddel többet dissipál; a
    mai digitális gépek logikai műveletenként a Landauer-határ SOK
    nagyságrenddel felül vannak (arXiv:2506.10876). A küszöb értéke a
    TERVEZÉSBEN van: megmondja, melyik lépés irreverzibilis (fizetendő)
    és melyik tehető reverzibilissé (ingyen).

### 4.2 A biológiai kötés — „evolution as thermodynamic computation"

- **Kolchinsky (2021, Santa Fe Institute), arXiv:2112.02809** —
  molekuláris replikátorokra két általános kötés:
  - affinitás–sebesség–fitness: σ ≥ −ln(1 − ρ/f), ahol σ a replikáció
    affinitása (k_B·T egységekben dissipált Gibbs-energia másolatonként),
    ρ a replikációs ráta, f a fitness (maximális elérhető replikációs
    ráta);
  - **a szelekció erejének kötése:** a kritikus szelekciós együttható
    s ≥ e^(−σ*) — azaz egy s relatív fitness-különbség szelektálásához
    másolatonként LEGALÁBB −ln(s)·k_B·T szabadenergia dissipálódik;
    s → 0 esetén a költség DIVERGENCIA. Példa: egy önreplikáló RNS
    σ* ≈ 5 mellett csak s ≥ e⁻⁵ ≈ 0,6% fitness-különbséget tud
    „látni".
  - Ez matematikailag pontos formája annak, hogy a DARWINI SZELEKCIÓ
    hőgép-ciklus: szelektálni csak disszipáció ellenében lehet.
- **Smith (2008)**, *Journal of Theoretical Biology*: „Thermodynamics of
  natural selection III: Landauer's principle in computation and
  chemistry" — a kémia ↔ számítás explicit Landauer-dekompozíciója.
- **England irány** (dissipation-driven adaptation; Kolchinsky vitatja
  az alkalmazhatóságát replikátorokra — l. a 2112.02809 DISCUSSION
  szakaszát): a disszipáció önmagában nem garantál adaptációt; a kötés
  a szelekció EREJÉT korlátozza felülről a dissipált energián keresztül.

### 4.3 A generációs hurok mint hőgép-ciklus — a Carnot-ütemező

A `CarnotCiklus_v1.CarnotÁllapot` négy állapota négy fázist ütemez
(SZERKEZETI megfeleltetés — javaslat szint, l. §5.6):

| Carnot-lépés | A hurok fázisa | Termodinamikai olvasat |
|---|---|---|
| 1. izoterma tágulás (Th) | KIÉRTÉKELÉS — minden egyed fitnesze kiszámolódik | munkavétel a meleg tartályból: a fitness-információ beáramlik |
| 2. adiabata lehűlés (Th → Tc) | VARIÁCIÓ — mutáció + keresztezés | hőcsere nélküli átrendeződés: az állapot változik, a könyvelt hő nem |
| 3. izoterma sűrítés (Tc) | SZELEKCIÓ — élitmásolás + kiesők | a törölt információ hője a hideg tartályba megy: ITT fizetjük a Landauer-árat |
| 4. adiabata melegítés (Tc → Th) | ÚJ GENERÁCIÓ felállítása | a rendszer visszaáll a kezdeti (Th) állapotba; a ciklus zárul |

- A ciklus hatásfoka η = 1 − Tc/Th (`CarnotCiklus_v1.hatásfokTört`,
  Nat-tört alakban, Refl-bizonyított keresztszorzatokkal) adja a FELSŐ
  korlátot: a bevitt energia ennyi része fordulhat strukturált munkává
  (a populáció rendezettségének — a fitness-maximum növelésének) az
  emelésére.
- **Órajel-kapcsolat** (`docs/ZeneElemzes_Sziami_v1.md`): a ritmus =
  időkvantálás; a hat dal mért eseményrátája közel állandó (~3,6
  esemény/s) akkor is, ha a BPM széles — a KVANTÁLÁSI RÁTA a rögzített,
  a hierarchiaszint a szabad paraméter. A generációs hurokra átvive: a
  Carnot-negyedfordulat adja a rögzített kvantálási egységet (egy
  generáció = egy fordulat), a benne dolgozó operátorok szabadon
  variálhatnak. A driftmentes órajel a dekoherencia ellenszere — ez a
  dokumentum akusztikus méréssel alátámasztott elve.

---

## 5. A SZIMA-TERV · SZIMA 计划 · Der SZIMA-Plan · תוכנית סימה

A legfontosabb szakasz: hogyan épül az evolúciós kereső a MEGLÉVŐ,
forduló modulokra — SEMMI NEM ÍRÓDOK ÚJRA, minden IMPORT (§24).

### 5.1 A populáció

- **Típus:** `List CímkézettMondat` (`Mondat_v1`).
- Minden egyed = az importált láncolt kompozíció (`Mondat`: kezdőFogalom +
  tükrözésSor) + CPT-bélyeg (a 27 időréteg egyike).
- A kereső tehát MONDATOKAT keres: a nyelv jelei zárt halmazon mozognak
  (240 gyökszó, 27 bélyeg — mind enumerálva és Refl-lel számba véve).

### 5.2 A mutáció — `weylReflexio` a mondat végpontján

- **Operátor:** egy tengely (egy `GyökSzó` az importált `alapszókincs`-
  ből) HOZZÁFŰZÉSE a mondat `tükrözésSor`-ához. A `mondatVégpont` foldl-
  je (`SzintaxisMorfizmus_v1`) automatikusan `komponál`-t — azaz a
  `weylReflexio`-t — alkalmazza az új végpontra (`E8BelsoSzorzat`:
  σ_α(β) = β − (⟨α,β⟩/4)·α).
- **Miért jó mutáció?** A tükrözés:
  - ZÁRT a 240 gyökre (`zarasHibakSzama` kimerítő mérése: várható 0);
  - ÁTLÉPHET a két D8-pálya között (`bizPályaváltás` — a pálya a fogalom
    ÁLLAPOTA): a mutáció tehát állapotot (pályát) változtat, a KATEGÓRIÁT
    megtartja — pontosan az a variáció, amit egy evolúciós kereső akar;
  - INVOLÚCIÓ (`bizInvolúcióSzón/Fogalmon`): a mutáció visszavonható —
    a kereső nem veszíthet információt egyetlen mutációs lépésben sem.
- A mutáció a 240 lehetséges tengely közül választ — a mutációs „rácson"
  a W(E8) szimmetriacsoport (rendje 696 729 600, `E8Gyokok_v2`) mozgat.

### 5.3 A keresztezés — `komponál`

- **Elsődleges forma (egy-pontos keresztezés analógja):** két szülő
  láncának összefűzése:
  gyermek = MondatKonstruktor (kezdőFogalom szülőA)
                                (tükrözésSor szülőA ++ tükrözésSor szülőB)
  — a `++` a Data.List standard operátora (§24: nem újraírva); a gyermek
  végpontját a `mondatVégpont` újraszámolja.
- **Alternatíva:** a két szülő VÉGPONTJÁNAK `komponál`-a (fogalom-szintű
  keresztezés) — rövidebb láncokat ad, de elveszti az utat (a terv §2.2
  szerint a mondat értelme a végpont ÉS az út — ezért az elsődleges forma
  a lánc-fűzés).
- Az involúció törvénye biztosítja, hogy a fűzött lánc visszabontható:
  a keresztezés nem zár el utakat.

### 5.4 A fitness — fázistényező + jelentés-távolság

A fitness KÉT része, mindkettő IMPORTÁLT függvény:

1. **Koherencia-rész:** `fázistényező` (`Mondat_v1`; hátterében a
   `FazisAlgebra_v2.fazisFaktorialis`): az egyed bélyegének diagonális
   koherenciája, értéke 1,0 / 0,5 / 0,0. Ez a CPT-réteg belső minősége —
   a koherensebb időréteg magasabb pontot kap.
2. **Jelentés-rész:** a végpont távolsága a CÉL-FOGALOMTÓL:
   `jelentésTávolság` (`GyokSzo_v1`) az ötszintű `HasonlóságÖtSzint`
   skálán — a skála SAJÁT értékei a pontok: AzonosJel = +1,
   SzorosanHasonló = +½, Semleges = 0, EllentétesRokon = −½,
   Ellentett = −1 (a Show instance-ok pontosan ezt írják ki). A
   végpontszó: `gyökSzó (végpontFogalom (végpontCPTMutató m))` — pontosan
   az a projekciólánc, amit a `Mondat_v1` main már futtat.
- Összeg: fitnesz m = w₁ · koherencia + w₂ · jelentéspont — a w₁/w₂
  súlyok NYITOTT KÉRDÉS (§6).
- **Verifikációs megjegyzés (§18):** a fitness-összeg Double — annak
  ellenőrzése FUTÁSIDEJŰ Show/GAUGE (mint a `Komplex.idr` oda-vissza
  tesztje); a Double-egyenlőség NEM Refl-tárgy. A Refl-célok a
  STRUKTÚRÁRA mennek (méret, zártság, élit) — l. §5.8.

### 5.5 A szelekció — élitmásolás + Landauer-árazás

- **Élitmásolás:** a legjobb e darab egyed változatlanul átmegy (§1.1/3).
- **Landauer-árazás:** a kieső k = N − e − utódok darab egyedről szóló
  információ törölhető; a generáció szelekciós ára (alsó korlát, 300 K):
  E_szelekció ≥ k · log₂ N · `landauerKüszöb 300.0` — a
  `CarnotCiklus_v1` IMPORTÁLT küszöbfüggvényével, nem újraszámolva (§24).
- A költség kétféleképpen élhet: (a) a fitness BÜNTETÉSTAGJA (a drága
  szelekciókat kerülő hurokat jutalmazzuk), vagy (b) a ciklus
  KÖLTSÉGVETÉSE (generációnként könyveljük, a dashboardra írjuk) — ez
  nyitott kérdés (§6); a (b) verzió tisztább, mert a fizika alsó korlát,
  nem preferencia.

### 5.6 A hurok — Carnot-négylépés ütemében

- **A generáció = egy Carnot-fordulat:** a négy fázist (kiértékelés →
  variáció → szelekció → új generáció) a `CarnotÁllapot` négy állapota
  ütemezi a §4.3 táblázat szerint; a `teljesCiklus` kompozíciója adja a
  generációváltást, záródása Refl-lel már bizonyított
  (`bizCiklusZáródikElsőről/Másodikról`).
- Az `állapotLépése` híd az importált `CarnotLepes` típushoz megvan —
  az ütemező így a hajtás-modullal közös nyelven beszél.
- Az órajel-drift elleni védelem: a generációhatárok a `ciklusÁllomások`
  mintájára LISTA-KONSTANS-ként épülnek (NEM let-lánc — LetLáncProbe!).

### 5.7 A kvantum-út (későbbi — javaslat szint)

- A populáció szuperpozícióként: az egyed-állapottér (D8-pálya × CPT-
  bélyeg: 2·27 = 54 alapállapot) amplitúdóvektora; a kiértékelés = mérés;
  a mutáció = a Weyl-reflexió unitér (ortogonális!) megfelelője a
  gyöktérben — a §3.2-ben őszintén jelölt előnyökkel és korlátokkal.
- **EZ A SZAKASZ MOST NEM IMPLEMENTÁLÓDIK** — csak a típus-jelölés és a
  kutatási irány rögzítése (§18/4: speculatív jelölés).

### 5.8 Idris-vázlat — `EvolutivKereso_v1` (CSAK VÁZLAT!)

```idris
-- ═══════════════════════════════════════════════════════════════
-- EVOLUTÍVKERESŐ v1 — MODUL-VÁZLAT (NEM implementáció!)
-- 演化搜索器 v1 —— 模块草案 · Modulentwurf · שלד מודול
-- §24: MINDEN művelet IMPORT — weylReflexio (E8BelsoSzorzat),
--      komponál (SzintaxisMorfizmus_v1), jelentésTávolság
--      (GyokSzo_v1), fázistényező (Mondat_v1), landauerKüszöb
--      (CarnotCiklus_v1). Semmi nincs újraírva.
-- Írás ELŐTT betöltendő (AGENTS §13): MANTRA.md, HOROG.md,
--      skills/idris-stilus/SKILL.md, OLVASD.md, context7.
-- ═══════════════════════════════════════════════════════════════

module EvolutivKereso_v1

import Mondat_v1              -- CímkézettMondat, fázistényező, végpontCPTMutató
import SzintaxisMorfizmus_v1  -- Mondat, kezdőFogalom, tükrözésSor, komponál
import GyokSzo_v1             -- jelentésTávolság, HasonlóságÖtSzint, alapszókincs
import CarnotCiklus_v1        -- CarnotÁllapot, következőÁllapot, landauerKüszöb
import Data.List              -- length, take, ++ (standard — §24)

-- 1. A POPULÁCIÓ — a feladat szerint List CímkézettMondat.
--    (A végleges modulban a HOROG csomagolási szabálya szerint
--    rárekord jöhet: PopulációKonstruktor — ez a vázlat jelöli.)
public export
Populáció : Type
Populáció = List CímkézettMondat

-- 2. A FITNESS-PONT — két IMPORTÁLT rész összege (Double;
--    ellenőrzése futásidejű GAUGE, NEM Refl — l. §5.4).
public export
record Fitneszpont where
  constructor FitneszpontKonstruktor
  koherenciaÉrték  : Double   -- Mondat_v1.fázistényező a bélyegen
  jelentésÉrték    : Double   -- az ötszintű skála ±1/±½/0 pontértéke

-- 3. A VARIÁCIÓ TYPECLASS — mindkét operátor ZÁRT: a szignatúra
--    maga garantálja, hogy CímkézettMondat -> CímkézettMondat.
public export
interface Variáció (egyedTípus : Type) where
  mutál     : egyedTípus -> egyedTípus                    -- tengely hozzáfűzése
  keresztez : egyedTípus -> egyedTípus -> egyedTípus      -- lánc-fűzés (++)

-- 4. A GENERÁCIÓ NÉGY FÁZISA — a Carnot-négylépéshez rendelve
--    (§4.3 táblázat; a négy állapot: ElsőIzotermaTágulás … )
public export
kiértékelés         : Populáció -> List Fitneszpont          -- 1. izoterma tágulás
variációFázis       : Populáció -> Populáció                 -- 2. adiabata lehűlés
szelekció           : Populáció -> List Fitneszpont -> Populáció  -- 3. izoterma sűrítés
következőGeneráció  : Populáció -> Populáció                 -- 4. adiabata melegítés
                                                              -- (a négy kompozíciója)

-- 5. A LANDAUER-KÖNYVELÉS — IMPORTÁLT küszöb, NEM újraszámolva:
--    E_szelekció ≥ kiesőkSzáma * log2 populációMéret * landauerKüszöb 300.0
--    (a log₂ Nat-oldali kifejtése külön feladat — a vázlat jelöli.)

-- 6. REFL-CÉLPONTOK (két független út, egy híd — §18; NEM tautológia):
--  a) POPULÁCIÓ-MÉRET MEGMARADÁSA:
--     bizMéretMegmarad : length (következőGeneráció p) = length p
--     (bal: a négyfázis-lánc kifejtése; jobb: a bemenő hossz konstansa.)
--  b) A MUTÁCIÓ ZÁRTSÁGA A MONDAT-TÉRRE — TÍPUSSZINTŰ (a Variáció
--     szignatúrája); a futásidejű kimerítő MÁR MEGVAN:
--       zarasHibakSzama = 0            (E8BelsoSzorzat, 57 600 reflexió)
--       komponálásZártságiHibákSzáma = 0 (SzintaxisMorfizmus_v1, 57 600 pár)
--  c) AZ ÉLIT MEGMARADÁSA:
--     bizElitMegmarad : a maximális fitness nem csökken generációnként
--     (Nat-rendezéssel formalizálandó a Fitneszpont pontértékein.)
--  d) A GENERÁCIÓ-CIKLUS ZÁRÓDÁSA — a CarnotCiklus_v1
--     bizCiklusZáródik* mintájára: a négyfázis-kompozíció a populáció
--     FORMÁJÁT (méret + élit-halmaz) identitásra viszi negyedfordulaton.
--
--  FIGYELEM (KisBetűsProjekcióCsapda): minden bizonyítás-típusban
--  hivatkozott konstans NEVE NAGYBETŰVEL induljon!
-- ═══════════════════════════════════════════════════════════════
```

---

## 6. Nyitott kérdések a felhasználónak · 向用户的开放问题 · Offene Fragen ·
## שאלות פתוחות

1. **Fitness-súlyozás:** mekkora legyen w₁ (koherencia) és w₂
   (jelentés-távolság) aránya? Javaslatunk: w₁ = 0,3, w₂ = 0,7 — de ez
   jelöletlen döntés, a felhasználó erősítheti meg (mint a terv §6.5).
2. **Populáció-méret:** N = 27 (a CPT-bélyegek száma — szimbolikus és
   kicsi), vagy nagyobb (pl. 240, a gyökszavak száma)?
3. **Élit-arány:** hány egyed menjen változatlanul tovább (e = 1? e = N/10?)?
4. **Hány generáció / mikor álljon le a hurok:** fix generációszám, vagy
   fitness-plató (pl. G generáció without improvement)?
5. **Kvantum-út MOST vagy KÉSŐBB:** a §5.7 szuperpozíciós populáció
   maradjon-e javaslat-szinten (javaslatunk: igen, később)?
6. **Keresztezés alakja:** lánc-fűzés (elsődleges javaslatunk) vagy
   végpont-komponálás?
7. **Bélyeg-öröklődés:** mutálódhat-e a CPTBélyeg is (a gyermek új
   véletlen bélyeget kap), vagy öröklődik (szülőA bélyege)?
8. **A cél-fogalom:** rögzített konstans (pl. `PéldaFélEgészSzó` körüli
   fogalom), vagy a cél maga is fejlődjön a futás során?
9. **Landauer-könyvelés:** fitness-büntetéstag (5.5/a) vagy költségvetési
   könyvelés a dashboardra (5.5/b — javaslatunk)?

---

## 7. Forrásjegyzék · 参考文献列表 · Quellenverzeichnis · רשימת מקורות

**Alapok (klasszikus EA):**

1. Wikipedia: *Genetic algorithm* — https://en.wikipedia.org/wiki/Genetic_algorithm
2. Wikipedia: *Selection (evolutionary algorithm)* — https://en.wikipedia.org/wiki/Selection_(evolutionary_algorithm)
3. Mitchell, M. (1999). *An Introduction to Genetic Algorithms*. MIT Press.
4. Hansen, N. (2015). *Evolution Strategies* (overview) — http://www.cmap.polytechnique.fr/~nikolaus.hansen/es-overview-2015.pdf
5. Hansen, N. & Ostermeier, A. (2001). Completely derandomized self-adaptation in evolution strategies. *Evolutionary Computation* 9(2), 159–195.
6. ACM tutorial: *CMA-ES: evolution strategies and covariance matrix adaptation* — https://dl.acm.org/doi/10.1145/2001858.2002123
7. Das, S. et al. (2018). Differential Evolution: A Survey and Analysis. *Applied Sciences* 8(10):1945 — https://www.mdpi.com/2076-3417/8/10/1945
8. Wikipedia: *Genetic programming* — https://en.wikipedia.org/wiki/Genetic_programming ; Koza, J. (1992). *Genetic Programming*. MIT Press.

**Kvantum evolúció:**

9. Zhang et al. (2017). Quantum rotation gate in quantum-inspired evolutionary algorithm: a review, analysis and comparison study. *Swarm and Evolutionary Computation* — https://www.sciencedirect.com/science/article/abs/pii/S2210650216303807
10. Lahoz-Beltra, R. (2016). Quantum Genetic Algorithms for Computer Scientists. *Computers* 5(4):24 — https://www.mdpi.com/2073-431X/5/4/24
11. Malhotra et al. *Genetic Algorithms and Quantum Computation* (survey) — https://arxiv.org/abs/cs/0403003
12. Han, K.-H. & Kim, J.-H. (2000). Genetic quantum algorithm and its application to combinatorial optimization problem.
13. EAQGA (2025). A Quantum-Enhanced Genetic Algorithm with Novel Entanglement-Aware Crossovers — https://arxiv.org/abs/2504.17923
14. CRAN QGA package vignette — https://cran.r-project.org/web/packages/QGA/vignettes/QGA.html

**Termodinamika:**

15. Chattopadhyay et al. (2025). *Landauer Principle and Thermodynamics of Computation* (review) — https://arxiv.org/abs/2506.10876
16. Bormashenko, E. (2025). Landauer's Principle: Past, Present and Future. *Entropy* 27(5):437 — https://pmc.ncbi.nlm.nih.gov/articles/PMC12026021/
17. Kolchinsky, A. (2021/2025). Thermodynamics of Darwinian selection in molecular replicators — https://arxiv.org/abs/2112.02809 (Santa Fe Institute)
18. Smith, E. (2008). Thermodynamics of natural selection III: Landauer's principle in computation and chemistry. *J. Theor. Biol.* — https://www.sciencedirect.com/science/article/abs/pii/S0022519308000623
19. Wikipedia: *Carnot cycle*; *Landauer's principle* (a `CarnotCiklus_v1` fejlécében már idézve).

**Rács-keresés:**

20. Bahmann, S. et al. (2013). EVO — an evolution strategy for crystal structure prediction. *Computer Physics Communications* 184, 1618 — https://ui.adsabs.harvard.edu/abs/2013CoPhC.184.1618B/abstract (evolúciós keresés KRISTÁLYRÁCSOKON — a legközelebbi irodalmi párhuzam).
21. Megjegyzés (őszinte): „combinatorial evolution on Lie groups/root
    systems" témában KÖZVETLEN irodalmat nem találtunk a keresésekben —
    a §5-beli konstrukció (Weyl-tükrözés mint mutációs operátor a gyök-
    rácson) a projekt saját javaslata; a legközelebbi külső pont az EVO
    (rácson futtatott ES) és a Weyl-csoport kombinatorikája.

**Projekt-beloli források (import-bázis, §24):** `Mondat_v1`,
`SzintaxisMorfizmus_v1`, `GyokSzo_v1`, `CarnotCiklus_v1`,
`FazisAlgebra_v2`, `E8BelsoSzorzat`, `E8Gyokok_v2`, `HaromKubit`,
`docs/ZeneElemzes_Sziami_v1.md`.

---

## 8. Négy nyelvű összefoglaló · 四语总结 · Vierprachige Zusammenfassung ·
## תקציר ארבע־לשוני

**中文：** 本文档研究了进化算法并给出 Szima 集成方案。要点：（1）进化环为
五相：初始化→评估（fitness）→选择（轮盘/锦标赛/截断/精英保留）→变异与交
叉→新代；GA、ES、CMA-ES、GP、DE 只在染色体类型与变异算子上不同。（2）量子
启发式进化算法（Han–Kim 2000）：qubit 幅值编码、旋转门更新；量子门是幺正的
（可逆），故理论上不受 Landauer 极限约束——但经典机上运行时此热优势不成立，
测量成本仍在，交叉的真正量子实现仍是开放问题。（3）选择的热力学代价：每擦除
一比特至少 k_B·T·ln2 = 2.87×10⁻²¹ J（300 K，即项目 CarnotCiklus_v1 的
landauerKüszöb 值）；Kolchinsky 给出 s ≥ e^(−σ*)：选择越精细耗散越大。四步
卡诺循环作为代的节拍器。（4）Szima 方案全部导入现有模块：种群 =
List CímkézettMondat；变异 = 在句末点做 weylReflexio（封闭性已被穷举证明）；
交叉 = komponál 链拼接；fitness = 相位因子 + 五级意义距离；选择 = 精英保留 +
Landauer 定价；一代 = 卡诺四步。附 EvolutivKereso_v1 类型骨架与四个 Refl 目标。

**Deutsch:** Dieses Dokument untersucht evolutionäre Algorithmen und plant
ihre Integration in Szima. (1) Die Evolutionsschleife hat fünf Phasen:
Initialisierung → Bewertung (Fitness) → Selektion (Roulette/Turnier/
Trunkierung/Elitismus) → Variation (Mutation + Crossover) → neue
Generation; GA, ES, CMA-ES, GP und DE unterscheiden sich nur in
Chromosomentyp und Variationsoperator. (2) Quanteninspirierte EA (Han–Kim
2000): Qubit-Amplitudencodierung, Rotationsgate; Quantengatter sind unitär
(reversibel) und unterliegen daher theoretisch nicht der Landauer-Grenze —
auf klassischen Maschinen gilt dieser Wärmevorteil jedoch nicht, die
Messkosten bleiben, ein echter quantenmechanischer Crossover ist offen.
(3) Thermodynamische Selektionskosten: mindestens k_B·T·ln2 =
2,87×10⁻²¹ J pro gelöschtem Bit bei 300 K — genau der Wert des
Projektmoduls CarnotCiklus_v1.landauerKüszöb; Kolchinsky: s ≥ e^(−σ*).
Der vierstufige Carnot-Kreislauf ist der Taktgeber der Generation. (4) Der
Szima-Plan importiert alles Bestehende: Population = List
CímkézettMondat; Mutation = weylReflexio am Satzende (Abschluss bereits
exhaustiv bewiesen); Crossover = komponál-Kettenverknüpfung; Fitness =
Phasenfaktor + fünfstufige Bedeutungsdistanz; Selektion = Elitismus +
Landauer-Preis; eine Generation = vier Carnot-Schritte. Mit dem
Typgerüst EvolutivKereso_v1 und vier Refl-Zielen.

**עברית:** מסמך זה חוקר אלגוריתמים אבולוציוניים ומתכנן את שילובם בסימה.
(1) לולאת האבולוציה בת חמישה שלבים: אתחול → הערכה (fitness) → ברירה
(רולטה/טורניר/קיצוץ/אליטיזם) → שונות (מוטציה + שחלוף) → דור חדש;
GA, ES, CMA-ES, GP ו-DE נבדלים רק בטיפוס הכרומוזום ובאופרטור השונות.
(2) אלגוריתם אבולוציוני מושרה-קוונטית (Han–Kim 2000): קידוד amplitudות
קיוביט, שער סיבוב; שערים קוונטיים הם אוניטריים (הפיכים) ולכן אינם
כפופים תיאורטית לגבול לנדאואר — אך על מכונות קלאסיות יתרון החום אינו
תקף, עלות המדידה נשארת, ושחלוף קוונטי אמיתי עודנה בעיה פתוחה.
(3) העלות התרמודינמית של הברירה: לפחות k_B·T·ln2 = 2.87×10⁻²¹ ג׳ לכל
ביט נמחק ב־300 K — בדיוק ערך landauerKüszöb של המודול CarnotCiklus_v1
בפרויקט; Kolchinsky: s ≥ e^(−σ*). מחזור קרנו בן ארבעת הצעדים הוא המטרונום
של הדור. (4) תוכנית סימה מייבאת הכול מהמודולים הקיימים: אוכלוסייה =
List CímkézettMondat; מוטציה = weylReflexio בנקודת הסיום של המשפט
(סגירות כבר הוכחה במיצוי); שחלוף = חיבור שרשראות komponál; כושר =
גורם הפאזה + מרחק משמעות חמש־דרגתי; ברירה = אליטיזם + תמחור לנדאואר;
דור אחד = ארבעת צעדי קרנו. עם שלד הטיפוסים EvolutivKereso_v1 וארבעה
יעדי Refl.
