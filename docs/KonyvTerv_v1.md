# KÖNYV-TERV v1 — a W11 „Kristálytiszta Könyv" munkaterve

> **Dokumentum:** `docs/KonyvTerv_v1.md` (P2 főterv — CSAK ez az egy dokumentum)
> **Dátum:** 2026-08-23
> **Elolvasva (§N11):** gyökér `AGENTS.md` (§1.0 Idris-generált Python-minta,
> §13, §16, §17, §18, §24), `HOROG.md`, `docs/KonyvLeltar_v1_A.md`,
> `docs/KonyvLeltar_v1_B.md`, `docs/muszerefal_v2.html` (1–120. sor: a
> renderer-minta — sötét műszerfal, CSS-változók, csoport-fejlécek négy
> nyelven, vezérlősáv szűrésre), `szima_ter/modul/E8Gyokok_v2.idr`
> (1–80. sor: négynyelvű fejléc-komment, Integer-kernel-tanulság).
> **Státusz:** terv — nincs commit, nincs push, nincs Idris/Python írva.
> **Következő lépés (P3):** a renderer + a pilot-fejezet ügynök-futtatása.

---

## 1. CÉL ÉS MÉRET

### 1.1. A cél

A Szima-projekt teljes bizonyítási állományának **egyszerre leíró,
bizonyító, tesztelő és vizuális** megjelenítése egyetlen, négynyelvű,
ön-ellenőrző „élő könyvben":

- minden levezetés **kártya** (a leltárak bizonyítás-egysége);
- minden kártyán **minden szám futásból** származik (GAUGE-elv: a kimenetet
  soha nem jelentjük ki ellenőrizetlenül — AGENTS „Tanulság" 6. pont);
- minden kártyán **két független út**: az Idris-kernel Refl-je ⟷ a
  szimuláció (Idris által írt Python/NumPy) maradéka (§18);
- a könyv a repóban él: `docs/konyv/` alatt, a már működő Pages-workflow
  automatikusan publikálja (docs/** → online).

### 1.2. A méret (leltár-összesítésből)

| Mutató | Érték | Forrás |
|---|---|---|
| Modulok | **63** (34 A–K + 29 L–Z) | KonyvLeltar_v1_A/B |
| Bizonyítás-nevek (Refl / biz* / teszt* / törvények) | **~336** (218 + ~118) | leltár-összesítések |
| Ebből §18 szerint tautológia (őszintén jelölendő) | **5** | B-leltár |
| Negatív tételek (Not … impossible + fordító-elutasítás) | **3** | B-leltár |
| „Két független út, egy híd" bizonyítások | **8+** | B-leltár |
| Bizonyítás-kártyák | **~336** | 1 kártya = 1 bizonyítás |
| Szerkezeti/módszertani/történeti kártyák | **~30** | fejezet-fejlécek, sablonok |
| **Összes kártya** | **~366** | |
| Oldal kártyánként | **3–5** | |
| **Teljes oldalbecslés** | **~1000–1700 oldal** (336×3=1008 … 336×5=1680; a 30 szerkezeti kártya a fejezet-lapolásokon elfér) | |

### 1.3. Négynyelvűség (§22/§22a)

- A válasz-törzs **magyar** (ékezetesen, §N9/§N10 szaknyelv: tükrözés,
  krisztalografikus, gyökrendszer, levezetés, cáfolat).
- Minden kártya és minden szakasz-záró blokk **kristálytiszta rövid
  összefoglalóval** rendelkezik: **中文** (KRITIKUS — soha nem maradhat el),
  **Deutsch**, **עברית** (a muszerefal HTML-mintájában a héber
  `direction: rtl; unicode-bidi: isolate` — ezt a renderer örökli).
- A szakszótár a `magyar-matematika` skill szerint (§N10): a magyar szó az
  elsődleges, a fordítás követi, nem fordítva.

---

## 2. ARCHITEKTÚRA (a szentesített minta)

### 2.1. Az alapelv (§1.0 szó szerint)

„Minden állítás Idrisben levezetve + numerikusan verifikálva… ÉS egy
**Idris-generált Python/NumPy szkript** numerikusan ellenőrizze."
Az ügynök **SOHA nem ír Pythont kézzel** (§N8): a Python-szkript maga is a
fejezet-Idris-modul main-je által kibocsátott string, amelynek minden
számát Refl-ellenőrzött konstansokból építi. Korábbi minták a projektben:
`AlphaSteaneDashboard` (17 lépés → JSON + Python-plotter + HTML),
`SzimaDashboard` (adatokJson + rajzoloPython) — ezek a kanonikus
előképek; az új `KonyvAdat_*` modulok ezt a mintát **importálva, nem
újraírva** követik (§24).

### 2.2. Fejezetenként EGY Idris-modul

```
szima_ter/modul/KonyvAdat_<Fejezet>_v1.idr     (ékezetes név, §25)
```

A modul main-je (a `SzimaDashboard`/`AlphaSteaneDashboard` GAUGE-mintája
szerint, futtathatóan: `idris2 --find-ipkg --exec main`):

1. **KIÍRJA a Python-szkriptet** (`grafikon_rajzolo.py`) a
   `docs/konyv/<fejezet>/` könyvtárba — a szkript stringként, a
   Refl-ellenőrzött konstansokból interpolálva; tartalma:
   - `matplotlib.use("Agg")` (headless);
   - **számol** (NumPy; ugyanazokkal a konstansokkal);
   - **kártyánként 5 grafikont rajzol** (`grafikonok/<kártya>_1..5.png`);
   - **numerikusan VISSZAELLENŐRIZI** a két utat: kernel-érték (az adat.js-ből)
     ⟷ szimulációs érték, és **kiírja a maradékokat** (stdout + CSV);
   - a szkript NEM tartalmaz kézzel írt számot.
2. **Kigyűjti a fejezet adatait** egy `adat.js` blokkba (a muszerefal
   „beágyazott JS-adat + csoportok" mintája):
   `window.KONYV_ADAT.<fejezet> = { kártyák: [ … ] }` — kártyánként:
   cím (4 nyelven), forrás-modul, bizonyítás-típus szó szerint, a
   levezetés lépései (képlet + érték + MIÉRT), a futtatási kimenet
   idézete, a maradékok (Δ, Δ/σ ahol fizikai mérés — §17 négysoros!), a
   5 grafikon fájlneve, tautológia-jelölő (§18), forrás-hivatkozások.
3. **Kiírja a futtatási összefoglalót** (GAUGE): kártyaszám, PNG-szám,
   maradék-maximum, „0 hiba" csak akkor, ha tényleg az.

### 2.3. EGY közös quadro-lingvális renderer

`docs/konyv/index.html` — single-page shell, a `muszerefal_v2.html`
mintájára (sötét műszerfal-téma, CSS-változók, csoport-fejléc négy
nyelven, szűrő/vezérlősáv), kiegészítve:

- fejezet-navigáció (bal sáv) + kártya-rács;
- kártyánként: a 2.2-beli adatmezők renderelése, a 5 PNG beágyazva,
  a levezetés lépései számozott listában, a bizonyítás-típus
  monospace-blokkban, a négynyelvű összefoglaló collapsible blokkban
  (中文 / Deutsch / עברית);
- szűrés: fejezet / bizonyítás-típus (Refl, két-út, negatív, tautológia,
  futásidejű kimerítés) / forrás-modul;
- **a renderer nem tartalmaz számot** — minden érték adat.js-ből jön.

Könyvtárszerkezet:

```
docs/konyv/
  index.html                      ← közös renderer (EGY db)
  <fejezet-slug>/
    adat.js                       ← a fejezet adatai (Idris main írja)
    grafikon_rajzolo.py           ← Idris main írja (§N8: nem kézzel!)
    grafikonok/*.png              ← a .py futása készíti
    fejezet.html                  ← opcionális önálló nyomtatható változat
```

A fejezet-slug ASCII (URL-biztos, pl. `f02-e8-gyokrendszer`), a CÍMEK
ékezetesek (§25 a tartalomra, az URL a Pages-re hallgat).

### 2.4. A négyszeres szerep (a projekt lényege, AGENTS §00)

A kártya egyszerre: **leírás** (típus = fogalom), **bizonyítás** (Refl),
**teszt** (futási kimenet), **vizualizáció** (5 ábra) — a „semmi halu"
elv teljesül: matematikailag körvonalazott levezetés + numerika, a
docs/** publikus, más AI/ember ellenőrizheti.

---

## 3. FEJEZET-BEOSZTÁS (WBS) — 11 fejezet (0–10)

A beosztás a leltárak természetes fejezet-sorolatát követi (A-leltár
záró összesítése + B-rész anyaga), a felhasználó által adott 8–14-es
sávban. **Fejezetenként 1 ügynök-futás = 1 prompt.**

| F | Cím | Forrás-modulok (leltár) | Refl | Kártya | Oldal |
|---|---|---|---|---|---|
| 0 | Bevezetés és módszertan | AGENTS, HOROG, leltárak, KonyvTerv_v1, muszerefal_v2.html | 0 | ~10 | 30–50 |
| 1 | α és a fizikai állandók | Alap.AlphaKözös, Alap.AlphaKozos, AlphaE8Szigor, AlphaGCheck, AlphaLobaszas, AlphaSteane, AlphaSteaneDashboard, AlphaSteaneE8, AlphaSteaneVegso, GCheck, TetrapodaTest | 56 | ~35 | 105–175 |
| 2 | E8 gyökrendszer és W(E8) | E8Gyokok_v2, E8Gyökök, E8BelsoSzorzat, E8BelsőSzorzat, E8FazisKapcsolat, E8FazisKapcsolat_v2, E8FázisKapcsolat, E8TizenhatPenge, TizenhatPenge, E8Iranymutato_v1 | 82 | ~45 | 135–225 |
| 3 | A [[7,1,3]] híd: Steane, Pauli, kubit-algebra | Steane713 (osveny_index!), KomplexByte, PauliAlgebra_v2, Main_PauliAlgebra_v2, Kvaternion, FazisKubit, FazisAlgebra_v2, HaromKubit | ~53 | ~28 | 85–140 |
| 4 | A 3D nyelv négy emelete: szó → fogalom → szintaxis → mondat | GyokSzo_v1, Fogalom_v1, SzintaxisMorfizmus_v1, Mondat_v1, Paragrafus, Main, PiroskaSztar, PiroskaSztarTeljes, PiroskaHolografikusKod49_v3_Teljes, Kategoriak.MagyarOntologia, MagyarNyelvtan_v4 | 32 | ~48 | 145–240 |
| 5 | Carnot-hajtás, Landauer és a fizikai mérések (§17) | MagyarCarnotE9_v3_CodatAlpha, CarnotCiklus_v1 (ellenőrizendő — nincs a leltárban!), Muszerefal_v1, Muszerefal_v2 | ~16 | ~15 | 45–75 |
| 6 | Magyar↔kínai fordító-funktorok és a genetikai kód | MagyarKinaiPar_v2, MagyarKinaiInverz_v2, MagyarKinaiAltInverz_v2, MagyarKinaiFazisBayes_v2, MagyarKinaiParkettazas_v2, MagyarKinaiFolding_v2, MagyarKinaiGenKod_v2, MagyarKinaiTorvenyek_v3, Main_MagyarKinaiPar_v2, Main_MagyarKinaiInverz_v2, Main_MagyarKinaiGenKod_v2 | 60 | ~30 | 90–150 |
| 7 | Univerzalitási osztályok | E8Univerzalitas_v1 | 10 | ~7 | 20–35 |
| 8 | Hierarchia: fa, kétoldal, három kategória, holográfia | E8Fa_v3, KetoldaliE8Fa_v3, KetoldaliKategoria_v3, HaromKategoria_v3, HolografikusKod49_v2_MantraModul, Main_v2 | 44 | ~25 | 75–125 |
| 9 | A formális gerinc: 49 typeclass | Alap.KategoriaT | 0 (definíciók) | ~22 | 65–110 |
| 10 | Műszerfal, dashboard, kronológia és történeti leltár | Muszerefal_v1, Muszerefal_v2, SzimaDashboard, AlphaSteaneDashboard (adatblokk), a két leltár, kronológia | ~2 | ~12 | 35–60 |
| | **ÖSSZESEN** | **63 modul + dokumentumok** | **~336** | **~336+30** | **~1000–1700** |

Megjegyzések a táblához:

- Az iker-modulok (E8Gyokok_v2/E8Gyökök stb.) kártyái **közösek**, de a
  könyv külön „iker-modul kártyán" mutatja be, miért él két nemzedék
  (§13: a régi megmarad; §25: az ékezetes az új kanonikus).
- Az F4 nagy kártyaszáma (48) a 0-Refl-es, de kártya-gazdag
  MagyarOntologia (~10) és MagyarNyelvtan_v4 (~6) definíciós anyagból
  jön — ezek „definíció-kártyák", a bizonyítás-pénznem nélkül.
- Az F9 Refl-száma 0 — tudatosan: itt maguk a 49 interface-törvény a
  „bizonyítandók"; a kártyák a törvények curry–howard-i szerződését
  írják le (a leltár szavaival: „a definíció-gyűjtemény fejezet").

### 3.1. A kanonikus 5-grafikon-séma (MINDEN kártyára)

Kártyánként pontosan 5 PNG, rögzített szerepkörökkel (a Python-szkript
ezeket a sávokat generálja):

1. **SZERKEZET** — az objektum felépítése (ábra, rács, fa, diagram).
2. **SZÁMOLÁS** — a levezetés kibontása lépésről lépésre (értékek,
   konvergencia, görbe).
3. **ELLENŐRZÉS** — a maradék: kimerítési hibaszámláló, Δ, Δ/σ
   (fizikai mérésnél §17 négysoros), hiba-hisztogram.
4. **SPEKTRUM** — eloszlás, fázis-spektrum, súlyeloszlás, prímfelbontás.
5. **HÍD** — a két független út egy ábrán: kernel-Refl-érték ⟷
   szimulációs pont (és a köztük lévő maradék).

### 3.2. Grafikon-tervek fejezetenként (konkrét címekkel)

**F1 — α és a fizikai állandók** (kiemelt kártyák):
- kártya „137.036 felépítése": (1) „2⁷+2³+1 oszlopdiagram a 137
  összetevőiről"; (2) „a 9/250 törtrész lépcsője a számegyenesen";
  (3) „α_bare − α_CDATA maradék Δ/σ sávban (σ=1.1e-8 és 2.1e-8)";
  (4) „α⁻¹ történeti konvergencia-sávja (Horgony ⟷ CODATA)";
  (5) „híd: 137.036 Refl-konstans ⟷ NumPy-összeadás pontja".
- kártya „a lobásás-lánc": (1) „(121/128)ⁿ exponenciális görbe
  n=0…250"; (2) „hibajavítási költség γ=7/128 lépésenként";
  (3) „ln(9/8) püthagoraszi törtrész a teljes exponensen";
  (4) „δ nagyságrendje log-skálán a lépésszám függvényében";
  (5) „δ = 8.23e-7 két út: lobásás ⟷ CODATA-különbség maradéka".
- kártya „G prím-szerkezete": (1) „(7×11)/(2³×5²)·√3 számtani fája";
  (2) „(1+9/250)^(1/40) 40. gyök közelítése, iterációs maradék";
  (3) „G Δ/σ = 0.038 négysoros sáv"; (4) „prímek 2,3,5,7,11 mint
  hangok (oktáv…kapu) körön"; (5) „híd: G_levezetett ⟷ G_CODATA".
- kártya „a test-lánc (TetrapodaTest)": (1) „2×5×4 test-algebra ábra";
  (2) „base-10 = oktáv×tükör"; (3) „137 = [k,d,n] számjegy-bontás";
  (4) „Hox-lánc Shh→Hoxa11→Hoxa13"; (5) „a teljes lánc
  test→base10→137→Steane→α⁻¹→CODATA vízszintes folyamatkép".

**F2 — E8 gyökrendszer és W(E8)** (a leglátványosabb fejezet):
- kártya „a 240 gyök": (1) „240 gyök 2D-petri-vetülete (kiválasztott
  koordináta-sík)"; (2) „112 (±1,±1,0⁶) + 128 (±½)⁸ két halmazban";
  (3) „norma²≡8 ellenőrzés hisztogramja mind a 240 gyökön (0 hiba)";
  (4) „(1,56,126,56,1) belsőszorzat-eloszlás oszlopdiagramja";
  (5) „híd: 112+128=240 enumeráció ⟷ C(8,2)·2²+2⁷ kombinatorika".
- kártya „Weyl-tükrözés": (1) „σ_α(β)=β−(⟨α,β⟩/4)·α vektor-ábra";
  (2) „tükrözés 5 krisztalografikus szögen (0/60/90/120/180°)";
  (3) „57 600 reflexió-pár zártsági hibaszámlálója (várt 0)";
  (4) „5 szög ↔ 5 rend {1,2,3,4,6} pontdiagram"; (5) „híd:
  involúció σ²=id Refl ⟷ szimulációs visszatérési frekvencia".
- kártya „W(E8)": (1) „W(E8)=696 729 600 prímfelbontás-torta";
  (2) „2⁷·8!·135 szorzási lánc"; (3) „Integer-vs-Nat kernel-idők
  (a v1 fagyásának históriája)"; (4) „2¹⁴·3⁵·5²·7 prím-torony";
  (5) „híd: struktúra-út ⟷ prím-út Refl-pár egy ábrán".
- kártya „a 256-os híd": (1) „240 gyök + 16 penge egy rácsban";
  (2) „Cl(4) fokszámok (1,4,6,4,1)"; (3) „Hodge-duál k↔4−k involúció
  mind a 16 pengén"; (4) „(1,7,7,1) súly- ↔ (1,4,6,4,1) fok-tükrözés";
  (5) „híd: 240+16=256 ⟷ 2⁸".

**F3 — a [[7,1,3]] híd**:
- kártya „a 7 bit": (1) „[idő,okság,tér,szín,hang,fázis,mód]
  helyérték-ábra"; (2) „szindróma-tér 16+1 ág döntési fa";
  (3) „noetherTetel 16 ág: hiba-előtti/utáni kódszó-párok mátrixa";
  (4) „kódszó-súly eloszlás"; (5) „híd: javítás-visszaadás
  Refl-ágak ⟷ szimulált 1-bit-es hibainjekciók".
- kártya „Pauli-algebra": (1) „6 Pauli-permutáció = 6 forgás táblája";
  (2) „6 stabilizátor-generátor (3X+3Z)"; (3) „Cl(0,7)→Cl(0,14)
  dimenzió-létra 128→16384 log-skálán"; (4) „tenzor=XOR törvényei";
  (5) „γ⁵-invariancia spektrum".
- kártya „ℝ→ℂ→ℍ létra" (Kvaternion): (1) „Hamilton-szorzattábla i,j,k";
  (2) „nem-kommutativitás: j·i = −k kontra i·j = k"; (3) „S³=SU(2)→SO(3)
  kettős fedés vázlat"; (4) „létra [1,2,4]"; (5) „híd: i²=−1 Refl ⟷
  komplex szorzás szimulációja".
- kártya „Bloch-gömb" (FazisKubit): (1) „2→3 átmenet: bit + fázis";
  (2) „Born-szabály P(0) görbéje"; (3) „von Neumann-entrópia";
  (4) „Josephson I₀·sin(Δφ)"; (5) „a négy makroszkopikus
  fázismérés (interferencia, AB, Josephson, Berry) négy-panel".

**F4 — a 3D nyelv négy emelete**:
- kártya „alapszókincs": (1) „240 szó két osztályban (112/128)";
  (2) „szimbólum-írásrendszer (+,·,0,−,–) első 12 példánya";
  (3) „osztály-hibaszámláló (0)"; (4) „jelentés-távolság öt szintje
  ⟨α,β⟩/8 → szög-táblázat"; (5) „híd: 112+128=240 enumeráció ⟷ szorzat".
- kártya „szintaxis-morfizmus": (1) „tükrözés-lánc a mondatban";
  (2) „involúció σ∘σ=id rajza pályával oda-vissza"; (3) „240×240
  zártsági kimerítés hőmérséklete (mind 0)"; (4) „pályaváltás:
  W(E8) átlép a D8-pályákon"; (5) „híd: mondatVégpont Refl ⟷
  foldl-szimuláció".
- kártya „a 27-bélyeg": (1) „CPT 3×3×3 kocka"; (2) „bélyeg-híd
  enumeráció=szorzat"; (3) „réteg-homomorfizmus a diagonálisra";
  (4) „végpont-mutató láncrajza"; (5) „távolság-ellenőrzések
  (−8/−4/+8)".
- kártya „MagyarOntológia": (1) „képző-funktorok a szám-szócsaládon";
  (2) „22 eset → 22 kategóriaelméleti szerep táblázata"; (3) „MEO-négyes
  (MetaMeta→Instancia)"; (4) „kínai megfelelők 5 szóra"; (5) „a hiányzó
  3×3×3=27 bizonyítás kártyája (nyitott lyuk, őszintén)".
- kártya „Piroska": (1) „22 mondat → 154 bit folyamatábra"; (2)
  „128 < 154 < 240 sáv"; (3) „mondat→parketta→komplex bájt"; (4) „a
  ~30 szós szótár vektorai"; (5) „hüd: PiroskaBitek Refl ⟷ szimulált
  kódolás bit-száma".

**F5 — Carnot-hajtás és a mérések (§17)**:
- kártya „Carnot-ciklus": (1) „P–V kör 4 lépéssel"; (2) „Carnot-hatásfok
  η(T₁,T₂) hőmérséklet-függvénye"; (3) „η(300,600)=0.5 kernel-számítás";
  (4) „4 Carnot-lépés ↔ 4 magyar szimmetria táblázat"; (5) „híd:
  η Refl ⟷ szimulált körmunka".
- kártya „§17-mérések" (Muszerefal_v2): (1) „α dressed/bare két σ-val
  négysoros-sávok"; (2) „σ-ellentmondás 1.1e-8 vs 2.1e-8"; (3) „a δ
  két útja: |δ₁−δ₂| futásból"; (4) „α_G = 2⁻¹²⁷ Mersenne-torony";
  (5) „G-mérés Δ/σ = 0.038 sáv".

**F6 — magyar↔kínai funktorok**:
- kártya „F/G funktorok": (1) „magyar CPT 27 ⟷ kínai 64 diagram";
  (2) „F: 3→4 aspektus-leképezés nyilakkal"; (3) „G: 4→3 összecsukás
  (Zai→Imperfectum)"; (4) „partikula-táblázat 了过着在 / 的了吗吧";
  (5) „híd: forditF-példa Refl ⟷ táblázat-lookup".
- kártya „inverz és veszteség": (1) „10 teszt ✅/❌ táblázata";
  (2) „a fordító-elutasítás mint bizonyíték (teszt2)"; (3) „4
  veszteség-típus térképe (igeidő, Zai, tonalitás, LeM/Ma)"; (4)
  „retrakció-diamond ∀m (projekcio∘bovit=id)"; (5) „túlélő
  alkategória {Le,Guo,Zhe}×De×(0,0) + 2 negatív tétel".
- kártya „genetikai kód": (1) „4 bázis ↔ DNS bázis"; (2) „64 kodon
  enumeráció vs 4³ (két út)"; (3) „degeneráltság 64/20=3.2"; (4)
  „kodon→aminosav index-képlet bázis-16/4/1"; (5) „riboszóma mint
  Carnot + 3 stop-kodon = δ".

**F7 — univerzalitási osztályok**: (1) „kritikus exponensek frakciói
három osztályon (nyolcadok/72-edek/64-edek)"; (2) „skálacímkék
Rushbrooke α+2β+γ=2 maradékai (0 vonal)"; (3) „hiperskála 2−α=dν és
Fisher γ=ν(2−η) maradékai"; (4) „3D Ising bootstrap értékek
10⁻⁶ tűrésű maradékai (Chang et al. 2025, arXiv:2411.15300)";
(5) „híd: törvény-Refl ⟷ tizedes-ellenőrzés".

**F8 — hierarchia és holográfia**: (1) „5 szintű fa δ·2^szint
(δ,2δ,4δ,8δ,16δ)"; (2) „7+7+1=14 réteg (Dirac-spec stem)"; (3)
  „1+2+4+8+16=31 és 62=2×31 javítás"; (4) „OR/AND duális monoidok De
  Morgan-funktorral"; (5) „HaPPY 7+49 perfect-tensor (Pastawski et al.
  2015, DOI 10.1007/jhep06(2015)149)"; + „Cat-létra 0→∞" és „a 10
  szintű boot-up" kártyák.

**F9 — 49 typeclass**: (1) „49 typeclass 10 szintű piramison";
(2) „tükör-párok limit⟷kolimit"; (3) „monoidális kategória mint
agglutináció (tő⊗képző⊗rag=szó)"; (4) „adjunkció mint perem";
(5) „Kan/End/Coend hármas".

**F10 — műszerfal és kronológia**: (1) „38+46 mutató egy oldalon";
(2) „GAUGE-állapotszámlálók mind 0"; (3) „bizonyítás-statisztika
valódi/tautológia/gyenge oszlopdiagram"; (4) „két-hetes mérföldkövek
idővonala 2026-08-18-tól"; (5) „a 17 lépés lánc".

---

## 4. KÁRTYA-SABLON (pontosan)

Minden kártya a következő nyolc részből áll (a renderer és az adat.js
mező-nevei is ezek):

**(a) Cím négy nyelven** — magyar cím (ékezetes), majd zárójelben:
中文 / Deutsch / עברית. + kártya-azonosító: `F<fejezet>.<sorszám>`.

**(b) Definíciók** — az Idris-típusok **szó szerint** (monospace):
a rekord/interface/konstruktor-deklarációk a forrás-modulból, a
grafikus alakjuk kommentben (a „minden szó adattípus" elv, AGENTS §00).

**(c) A levezetés lépésről lépésre** — számozott lépések; **minden
egyenlet kiszámolva**, és **minden szám NYOMON KÖVETHETŐEN lép be és
ki**: a lépés input-száma mindig az előző lépés outputja vagy egy
hivatkozott konstans (forrás-modul + Refl-név); nincs „varázsszám".
A leltár MIÉRT-os fejlécei itt élnek tovább.

**(d) A bizonyítás-típus szó szerint + a kernel szerepe** — a teljes
Refl-típust monospace-ben, mellette: mit számolt ki a kernel a két
oldalon (a „Tanulság: mit bizonyít a Refl" szerint); besorolás:
VALÓDI / KÉT ÚT-HÍD / NEGATÍV / FUTÁSIDŐŰ KIMERÍTÉS / **TAUTOLÓGIA
(§18 — őszintén jelölve)**. Az 5 ismert tautológia (B-leltár)
külön-külön kártyát kap „TAUTOLÓGIA" jelöléssel — nem tüntetjük fel
bizonyításként, hanem metódus-kártyaként: mit tanít a jelölés.

**(e) Szimuláció** — mit számolt az Idris-írta Python, milyen
maradékkal: a kimenet stdout-idézete + a maradékok táblázata; fizikai
mérésnél a §17 négysoros (érték_levezetett / érték_mért σ-val /
Δ / Δ/σ), forrás: CODATA-év.

**(f) 5 grafikon** — a 3.1 öt-sávú sémája (SZERKEZET/SZÁMOLÁS/
ELLENŐRZÉS/SPEKTRUM/HÍD), a 3.2 konkrét címeivel.

**(g) Forrás-modul + futtatási parancs (GAUGE)** — a modul elérési
útja, a fordítási/futtatási parancs, és a futás TENYÉLEGES kimenete
(rövidítetlen ID-blokk); „0 hiba" csak valós futás után.

**(h) Négynyelvű kristály-összefoglaló** — 3–6 mondat magyarul, majd
**中文：** / **Deutsch:** / **עברית:** blokkok (§22a sablon).

---

## 5. FEJEZET-ÜGYNÖK PROTOKOLL (átadandó szöveg — szó szerint)

> Az alábbi blokkot a későbbi fejezet-ügynökök promptjába VÁGÓLAPON
> kell átadni (fejezet-specifikus paraméterekkel kiegészítve).

```
═══ FEJEZET-ÜGYNÖK PROTOKOLL — Kristálytiszta Könyv (KonyvTerv_v1) ═══

FELADAT: a(z) F<szám> „<cím>" fejezet elkészítése a KonyvLeltar_v1_A/B
alapján. EGY ügynök-futás = EGY fejezet.

OLVASÁSI LISTA ( KöTELEZŐ, ebben a sorrendben — §N11 ):
  1. /Users/joco/opencode/AGENTS.md  (§1.0, §13, §16, §17, §18, §24, §25)
  2. /Users/joco/opencode/HOROG.md
  3. docs/KonyvTerv_v1.md   (ez a terv: sablon + architektúra)
  4. docs/KonyvLeltar_v1_A.md + docs/KonyvLeltar_v1_B.md (a te fejezeted moduljai!)
  5. docs/muszerefal_v2.html (renderer-minta) + docs/konyv/index.html (ha él)
  6. A fejezet forrás-moduljai egyenként, TELJESSEN (nem csak fejléc!)

SZABÁLYOK:
  - §24 KÓD DUPLIKÁCIÓ TILOS: új függvény ELŐTT grep a projektre, aztán
    Prelude/Data.List, aztán IMPORT. (AlphaSteaneDashboard/SzimaDashboard
    mintái: az adat-kiíró szerkezetet import-szinten hasznosítsd.)
  - §25 ÉKEZETES MAGYAR: minden új azonosító és komment ékezetes
    (KonyvAdat_…, kártyaLeírás, lépésSzám…). Az Idris2 teljes Unicode.
  - §18 KÉT-ÚT: minden kártya REFLe ⟷ szimulációja; a kommentben állított
    és a típusban lévő állítás eltérése = NEM bizonyított (listáld!).
  - TAUTOLÓGIA: az ismert 5 (bizFoldingIteraciokNegy, bizSteane,
    bizStopKodonHarom, bizAlphaHelixHusz, bizZartParkettaTeljes-gyenge)
    + minden újonnan felfedezett ŐSZINTÉN „TAUTOLÓGIA" jelölést kap
    (§18.1) — ez nem szégyen, ez mérés.
  - §N8 PYTHON: CSAK az Idris által kibocsátott Python futtatható;
    kézzel Pythont SOHA (még javítani sem — hiba esetén az IDRISt
    javítod, és újrageneráltatod a szkriptet).
  - §17: minden fizikai konstans-összehasonlás négysoros formában
    (érték_levezetett / érték_mért σ / Δ / Δ/σ).
  - §13 NINCS FELÜLÍRÁS: a forrás-modulokat nem bántod; ha hiányzik
    valami, ÚJ fájl (_v2 suffix) — és jelzed a jegyzékben.
  - §20 SEMMIT NEM TÖRLÖLÉS; /tmp TILOS.
  - Let-lánc TILOS (KisAI-tanulság): az adatok listákból, egy
    konstrukciós menetben épülnek.
  - Nagy számok INTEGER-kernellel (E8Gyokok_v2-tanulság) — Nat-Reflek
    696729600-ra SOHA.

ELFOGADÁSI KRITÉRIUMOK (minden teljesül, különben a fejezet NEM kész):
  1. `idris2 --find-ipkg` build: 0 hiba (a KonyvAdat_… modulra).
  2. A main lefut; minden szám, ami a kártyákon szerepel, FUTÁSBÓL
     jön (adat.js-ben és a stdoutban is ott van — GAUGE).
  3. Minden levezetés-kártyához 5 PNG létezik (docs/konyv/<slug>/grafikonok/).
  4. A generált Python lefut headless (Agg), a maradékok kiíródnak;
     a szimulációs maradékok a várt nagyságrendben (a leltár szerint).
  5. A fejezet-oldal a rendererben 0 konzolhibával betölt (headless
     ellenőrzés), a szűrők működnek.
  6. Minden kártyán és szakasz-záráson megvan a négy nyelv
     (magyar törzs + 中文 + Deutsch + עברית) — §22a.
  7. A tautológiák, a negatív tételek és a spekulatív szakaszok
     (§18.4 STATUS: SPECULATIVE) jelölve vannak.

TILTÁSOK:
  - NINCS kézzel írt Python (a generált .py-t sem javítod kézzel).
  - NINCS felülírás, NINCS törlés, NINCS /tmp.
  - NINCS rövidítés (§0), NINCS ékezet nélküli magyar (§25).
  - NINCS jelentett kimenet futtatás nélkül (GAUGE; „0 hiba" műtermék!).

KIMENET: docs/konyv/<slug>/{adat.js, grafikon_rajzolo.py,
grafikonok/*.png} + a KonyvAdat_…idr a modul-könyvtárban + rövid
fejezet-jelentés (docs/KonyvJelentes_F<szám>_v1.md): kártyaszám,
tautológia-lista, hiányzó-törvény-lista, futási idők.
═══ PROTOKOLL VÉGE ═══
```

---

## 6. SORREND + PILOT

### 6.1. Pilot-döntés: **F2 — E8 gyökrendszer és W(E8)**

Indoklás:

1. **A legtöbb látványos grafikon**: petri-vetületek, eloszlások,
   Weyl-vektorok, prím-tornyok — a 3.2-beli lista fejezet-szinten is
   a legsűrűbb (45 kártya, 82 Refl).
2. **Tiszta Integer-kernel** → gyors build, nincs Double-kerekítési
   vita a maradékokról; a két-út-ellenőrzés (enumeráció ⟷ kombinatorika)
   itt a legélesebb.
3. **A legjobb minták már élnek**: E8Gyokok_v2 (négynyelvű fejléc,
   Integer-tanulság), AlphaSteaneDashboard/SzimaDashboard (Idris-írja-
   a-Pythont minta) — a pilot ezek importálásával megy.
4. **Felfedő hatás**: a F2 adja a 240/112/128/696 729 600 számokat,
   amelyekre F4 (nyelv) és F5 (Carnot) épít — korán kiderül, ha a
   adat.js-séma vagy a renderer szűk.
5. Az α-fejezet (zászlóshajó) másodikként következik: a pilot
   tapasztalataival finomított sablonnal készül, így a legjobb
   anyagra jut a legérettebb forma.

### 6.2. Ütemterv (fejezet / prompt-bontás — 1 fejezet = 1 ügynök-futás)

| Lépés | Futás | Tartalom | Függőség |
|---|---|---|---|
| 0. | Ügynök-0 | **Renderer** megépítése: docs/konyv/index.html a muszerefal_v2-mintára (csoportok, szűrők, RTL-héber, 4-nyelvű blokkok) + üres minta-adat.js | — |
| 1. | **PILOT** | **F2 E8 gyökrendszer** (45 kártya) — teljes lánc: KonyvAdat-modul → generált .py → 225 PNG → adat.js → renderer-vizsgálat | 0 |
| 2. | Pilot-review | Független alügynök (§18.3): tautológia-átvizsgálás, két-út-cenzúra, GAUGE-újrafuttatás → docs/Review_KonyvPilot_v1.md | 1 |
| 3. | F1 | α és a fizikai állandók (35 kártya; §17-négysorosok itt kritikusak) | 2 |
| 4. | F3 | [[7,1,3]] híd (28 kártya) | 2 |
| 5. | F4 | 3D nyelv (48 kártya — a legnagyobb; szükség esetén F4a/F4b bontás: emelet 1–2 / 3–4) | 2 |
| 6. | F5 | Carnot + mérések (15) | 3 |
| 7. | F6 | Magyar–kínai funktorok (30) | 2 |
| 8. | F7 | Univerzalitás (7) | 2 |
| 9. | F8 | Hierarchia + holográfia (25) | 2 |
| 10. | F9 | 49 typeclass (22) | 2 |
| 11. | F10 | Műszerfal + kronológia (12) | 3, 6 |
| 12. | F0 | Bevezetés és módszertan (10) — UTOLSÓKÉNT, mert addigra minden szám ismert | mind |

Párhuzamosítás: a 3–10. lépések a 2. lépés után egymástól függetlenek
(kivéve F5←F1, F10←F5/F6 függéseket) — szükség esetén párosával
futtathatók.

---

## 7. KOCKÁZATOK + NYITOTT KÉRDÉSEK

### 7.1. Ellenőrizve: matplotlib ✅

`python3 -c "import matplotlib"` → **OK, 3.9.2** (numpy 2.0.2).
Telepítés NEM szükséges. A generált szkript `matplotlib.use("Agg")`
-headless; a PNG a matplotlib natív formátuma. (JPG-opcióhoz Pillow
kellene — l. 7.2.1.)

### 7.2. Kockázatok és kezelések

1. **PNG-méret a repóban** (a legnagyobb kockázat): ~336 kártya × 5
   = **~1680 PNG**; dpi=110, figsize≈(8,5) mellett becsült 100–250
   KB/db → **170–420 MB**. Kezelési lehetőségek (döntés a pilot
   mérésével!): (a) dpi=90–110 + kisebb figsize; (b) JPG q=85, ha
   Pillow elérhető (ellenőrizendő — a generált szkript
   `import PIL`-t próbál); (c) git-lfs; (d) csak a Pages-artifacts
   hordozzák a PNG-ket. JAVASLAT: a pilot (225 PNG) után mérjünk, és
   a mért átlag alapján döntsünk — a terv ne találgasson (GAUGE).
2. **Tautológia-kártyák**: a leltár 5 darabot talált. Kezelés: saját
   kártyatípus „TAUTOLÓGIA (§18)" jelöléssel + metódus-tanulság; NEM
   tüntetjük fel bizonyításként, NEM hagyjuk ki (§16: semmi
   információ el nem dobható). A pilot-review újabbakat kereshet.
3. **CarnotCiklus_v1 nincs a leltárakban** — a Muszerefal_v1 importálja,
   tehát létezik, de a leltár nem fedte. Az F5 ügynöke ELŐSZÖR leltározza
   (a leltár-minta szerint), és a KonyvLeltar kiegészül (§16: új fájl).
4. **Steane713 az osveny_index/-ben él**, nem a modul/-ban — ipkg
   útvonal-rendellenesség; az F3 kártyái a könyvben is jelzik (a B-leltár
   3. megjegyzése szerint).
5. **Nat-fagyás**: minden nagy számú Refl Integer-en (E8Gyokok_v2
   tanulsága); a KonyvAdat-modulok Nat-Reflet nagy értékre soha.
6. **Let-lánc-robbanás**: a fejezet-adatlista EGY konstruktór-hívásban
   épül (KisAI-tanulság; a Muszerefal_v1 „EGYETLEN rekord-konstans"
   mintája).
7. **Cong-csavar** (CongBeragadtGlobálisFejCsapda): ha egy törvény-típus
   nem elaborál, futásidejű kimerítés + jelölés (KetoldaliKategoria_v3
   mintája) — a kártya őszintén jelzi a módszert.
8. **adat.js mérete**: F2-nél ~45 kártya × ~2–4 KB ≈ 100–200 KB —
   bőven jó; F4-nél (48 kártya, hosszú lépéssorok) is < 1 MB. A
   renderer lazy-oljon (fejezet-szintű fetch, nem egy óriás-fájl).
9. **Héber RTL**: a muszerefal már kezelni (`direction: rtl;
   unicode-bidi: isolate`) — a renderer átveszi (§24: minta-import).
10. **Kézzel írt szám beszivárgása**: a renderer 0 számot tartalmaz;
    minden érték adat.js-ből. Elfogadási kritérium #2 ezt őrzi.
11. **Idő**: F4 (48 kártya) egy futásra nagy — engedélyezett bontás
    F4a/F4b-re (6.2).

### 7.3. Nyitott kérdések (a felhasználónak / a pilotnak)

1. PNG vs JPG vs lfs — a pilot mérése után (7.2.1).
2. Legyen-e minden fejezetnek önálló nyomtatható `fejezet.html`-je,
   vagy elég a single-page renderer? (Javaslat: elég a renderer;
    a nyomtatás a Pages-oldalból.)
3. A iker-modulok (ékezetes/nem-ékezetes nemzedékek) közös kártyán
   jelenjenek-e (javaslat: IGEN + külön iker-kártya) — a pilotban
   döntjük el a F2-n belül (E8Gyokok_v2/E8Gyökök).
4. A 22 eset leltára: MagyarNyelvtan_v4 18 esetragot tartalmaz (Kiefer
   2011), a MagyarOntologia 22-t — a könyv a KÜLÖNBSÉGET (4 hiányzó
   eset) egy külön kártyán tisztázza (F4 ügynök feladata).

---

> **Zárás (négynyelvű, §22a):** A terv 11 fejezetet (0–10), ~336
> bizonyítás-kártyát + ~30 szerkezeti kártyát, 1000–1700 oldalt
> irányoz elő; a pilot az F2 (E8 gyökrendszer); a matplotlib elérhető.
>
> **中文：** 本计划将 336 条证明做成卡片（每卡 3–5 页），共 11 章、约
> 1000–1700 页、四种语言；每一章由一个 Idris 模块生成图表脚本与数据；
> 试点章节选定为 E8 根系（第 2 章）；matplotlib 已确认可用（3.9.2）。
>
> **Deutsch:** Der Plan gliedert die 336 Beweise in Karten (je 3–5
> Seiten), insgesamt 11 Kapitel und rund 1000–1700 Seiten, vier­sprachig;
> pro Kapitel erzeugt ein Idris-Modul den Plotter und den Datenblock;
> Pilot ist Kapitel 2 (E8-Wurzelsystem); matplotlib ist vorhanden (3.9.2).
>
> **עברית:** התוכנית הופכת 336 הוכחות לכרטיסים (3–5 עמודים כל אחד),
> ב־11 פרקים, כ־1000–1700 עמודים בארבע שפות; מודול Idris אחד לכל פרק
> מייצר את תסריט הגרפים ואת בלוק הנתונים; הפרק הפיילוט — מערכת שורשי
> E8; matplotlib זמין (3.9.2).
