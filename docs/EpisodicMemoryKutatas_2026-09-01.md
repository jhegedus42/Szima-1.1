# EPISZODIKUS MEMÓRIA-KUTATÁS — az exponenciálisan gyors szemantikus keresés

**Dátum:** 2026-09-01
**A felhasználó kérése (szó szerint):** „fel kene tolteni a szotarat, meg kene nezni elotte, hogy mi a helyzet a toruszokkal - toruszon valo kodolassal - ki kene talalni, hogy a markov blanket/yoneda/fixpont/aranymetszes/bergman/carnot hogyan hasznalhato keresesre - termeszetesen ez egy kutatasi projekt, amivel javitanunk kell a meglevo keresot... egy indexelt epizodikus memoria, ami brutal gyorsan keresheto, exponencialisan gyorsan, meg kene nezni, hogy erre milyen kutatasok vannak mar a projektben, source-okban"

**A kutatás módszere:** a hard rule szerint a teljes projekt-grep (szima_ter/modul/, osveny_index/, docs/, source/, szerver_hagyar/, skills/).

---

## 1. A MEGLÉVŐ KUTATÁSOK (a projektben talált források)

### 1.1. Tórusz-kódolás — KÉSZ, bevethető

- `osveny_index/Torusz.idr` (479 sor) + `ToruszTeszt.idr`: a bináris tórusz Z₂ × Z₈ = 16 pont, a GKP-kód diszkretizált fázistere. A tórusz-pont kódolás: pozíció (Z₂) + fázis (Z₈).
- A mondattípusok tórusz-pontjai: Állítás=F0, Kérdés=F2, Feltevés=F4, Következtetés=F6 (a spirál: a 2-szeres fázis-lépés).
- `GeneralizedPauli.idr`: a modular-qudit GKP (d_p=2, d_f=8), ω₂=−1, ω₈=(1+i)/√2.
- **A felhasználás:** a tórusz-pont az INDEX első dimenziója — a 16 pont = 16 klaszter, a keresés először a klaszteren (O(1) szűrés), majd a klaszteren belül (a részletes távolság).

### 1.2. EpisodicMemory — a fehérje-elmélet (1309 sor!)

- `szima_ter/modul/EpisodicMemory_v1_Szima.idr`: az epizodikus memória = **összehajtott fehérje**:
  - 1D (aminosav-sor) = a magyar szólánc (tő + toldalékok)
  - 2D (másodlagos szerkezet) = a kínai kompozíció (a 7 Fano-pont)
  - 3D (harmadlagos) = a memória maga (a hajtásgeometria = a metrikus tenzor)
  - 4D (negyedleges) = a társítás (ER=EPR = fehérje-fehérje kötés)
- **A holografikus elv:** a 2D felület (kínai) kódolja a 3D hajtást (magyar) — a felület területe = az entrópia (Bekenstein–Hawking): nagyobb felület = több információ.
- **A felhasználás:** az index bejegyzés = „fehérje" (a mondat 1D lánc + 2D kompozíció), a keresés = a felületi QFT (a 2D belső szorzat olcsóbb, mint a 3D).

### 1.3. GoldenFixpoint + Y-kombinátor (393 + 276 sor)

- `szima_ter/modul/GoldenFixpoint_v1_Szima.idr`: **φ = 1 + 1/φ** UGYANAZ a struktúra, mint **Y(f) = f(Y(f))** — mindkettő önreferenciális x = g(x).
- `SolomonoffIndukció_v1_Szima.idr`: **γ = 7/64** (a Fano/állapottér — a korlát/szabadság aránya), és a csatolás: **Y(f)(x) = x + γ·(világ − x) → fixpont** — a tanulás konvergenciája!
- MDL/Solomonoff: a legrövidebb leírás = az intelligencia — a keresés eredménye is a legrövidebb leírás (a legkomporbb találat).
- **A felhasználás:** a keresés iteratív finomítása: minden lépés x → x + γ·(cél − x), a konvergencia aránya 1/φ — **exponenciális konvergencia** (a φ-kontrakció, l. Komplex.idr φ-kontrakció 10⁻¹⁰).

### 1.4. Markov-blanket + Stoßzahlansatz (docs, kész kutatás)

- `docs/stosszahlansatz_markov_blanket.md`: a Boltzmann-Stoßzahlansatz (f₂ = f₁·f₁ — a korrelálatlanság) és a Markov-blanket (a szeparációs határ).
- **A felhasználás a keresésre:** a lekérdezés Markov-blanketje (a lekérdezés szavainak korrelációs gömbje) **behelyezi a keresést** — csak a blanket-en belüli (korrelált) index-bejegyzések relevánsak, a blanket-en kívüli korrelálatlan (Stoßzahlansatz!) → **eldobható**. Ez a szűrés adja az exponenciális gyorsaságot: a blanket darab ~ log(n), nem n.

### 1.5. Yoneda-lemma (több modulban)

- `Kategóriaelmélet64_v1_Szima.idr`, `HaromKategoria_v2/v3.idr`, `KategoriaElmelet.idr` (yonedaEgyertelmu): **minden objektum = a kapcsolatai** (Hom(A, −)).
- **A felhasználás a keresésre:** a lekérdezés „Yoneda-képe" = a lekérdezés komplex bátja (a kapcsolatai az 8 dimenzióval). A legjobb találat = a legjobb Yoneda-egyezés — ez NEM új elv, hanem a meglévő komplex-bájt-távolság **matematikai igazolása**: a távolság = a természetes transzformációk távolsága.

### 1.6. Bergman — NINCS a projektben (új kutatás!)

- A grep nem talált semmit — a **Bergman-kernel/mag** ÚJ elem.
- A Bergman-térben (A²(D) holomorf függvények): **f(z) = ⟨f, K_z⟩** — a kiértékelés = belső szorzat a maggal. A Bergman-mag K_z = a z-pont **reprezentátora**.
- **A párhuzam:** a Yoneda: Hom(A, −) = a reprezentátor; a Bergman: K_z = a reprezentátor. **A keresés: találat(q) = ⟨index, K_q⟩** — a lekérdezés Bergman-magával való belső szorzat. Ez a szemantikus keresés matematikailag pontos alakja — ÉS identikus a Yoneda-lemmával és a komplex-bájt belső szorzattal!
- **A tétel (bizonyítandó):** a LumoKereso Manhattan-távolsága ≈ a Bergman-mag normája közti eltérés.

### 1.7. Carnot-ciklus (több modul, kész)

- `Dirac3D/Carnot.idr` (entropia, hatásfok), `ForditasCarnot.idr` (a fordítási 4 lépés), `MagyarCarnotE9_v3` (a CODATA-α), `E8Fa_v2/v3` (a 4 fázis).
- **A felhasználás a keresésre — a KERESÉSI CARNOT-CIKLUS:**
  1. **Izentróp tágulás** (dS=0): a lekérdezés szétbontása (a szavakra — reverzibilis)
  2. **Izoterm tágulás** (a forró tárolón): a jelentés átadása az indexnek (a komplex bájt kódolás)
  3. **Izentróp kompresszió**: a találatok visszanyerése (a rangsor)
  4. **Izoterm kompresszió** (a hideg tárolón): a válasz összerakása (a top-k)
- A hatásfok η = 1 − T_C/T_H — a keresés hatékonysága (a T_H = a lekérdezés információ-tartalma, T_C = az index zajszintje).

### 1.8. Hadamard-távolság + skill-router (a gyors keresés mintája)

- `HadamardTavolsag.idr` (110 sor): hadamardTavolsagE8Negy — az E8E8KodSzo távolság.
- A skill-router: **a 15-dim fázistéres kódolás + Hadamard = a KeresesFunktor** — „a kérdés kódolása a 15 dimenzióba, a legközelebbi skill Hadamard-távolsággal".
- **A tanulság:** a bit-szintű Hadamard GYORS (Nat-összehasonlítás), a Double Manhattan LASSÚ — a hierarchia: először Hadamard (bit), majd Manhattan (Double) finomítás.

---

## 2. A KUTATÁSI TERV — az exponenciálisan gyors episodic memory

### 2.1. A hierarchikus index (a „brutál gyors" titka)

```
0. szint: a tórusz-pont (16 lehetőség — Z₂ × Z₈)     → O(1) szűrés
1. szint: a Steane-kód (7 bit — a komplex bájt erős kubiti) → O(1) szűrés (Hadarmard!)
2. szint: a komplex bájt Manhattan-távolsága (8 komponens)  → a finomítás
3. szint: a mondat maga (a címke — veszteségmentes)
```

A keresés: a lekérdezés → tórusz-pont (a 16-ból 1) → Steane-kód (Hadamard-szűrés) → Manhattan (rangsor). **A szűrés exponenciális:** minden szint 1/16, 1/128, ... arányban szűkít.

### 2.2. A Markov-blanket szűrő (a Stoßzahlansatz-elv)

A lekérdezés szavai meghatározzák a blanketet (a korrelált dimenziókat). A keresés CSAK a blanket dimenzióin zajlik — a blanket-en kívüli korrelálatlan (Stoßzahlansatz). A blanket-méret ~ log(n) — **a keresés成本ja logaritmikus**.

### 2.3. A Bergman-kernel (az új matematika)

A lekérdezés Bergman-magja: K_q = a lekérdezés reprezentátora az A²-ben. A találat: ⟨index_bájt, K_q⟩ — a belső szorzat. **A tétel:** ez ekvivalens a Manhattan-távolsággal a kis távolsásoknál (a first-order közelítés), de pontosabb (a másodrendű korrekciókkal).

### 2.4. A fixpont-iteráció (a konvergencia)

A keresés finomítása: x_{k+1} = x_k + γ·(cél − x_k), γ = 7/64 (a Fano-arány). A konvergencia 1/φ-lépésköz — **exponenciális**. A stop-kritérium: a fixpont (a további iteráció nem változtat).

### 2.5. A szótár bővítése (a gyakorlati alap)

1. A HungarianLexicon 3460 szava publikussá tévole (v2 fájl, §13 — a régi marad)
2. A szótár generálása: minden HuWord → huWordToJelentes (a SzotarHid motorja)
3. A Lumo-szövegek szavainak automatikus betanítása (ko-okkurencia — TERV.md 3.5)
4. A normalizált távolság: távolság ÷ mondathossz (a 4. keresés korlátjának javítása)

### 2.6. A megvalósítás sorrendje

1. **A szótár v2** (a lexikon 3460 szava publikusként — a kereső szótára 15 → 3475 szó)
2. **A normalizált távolság** (a rövid-mondat korlát javítása — egy sor)
3. **A tórusz-pont index** (a 16 klaszter — a mondatok tórusz-pont szerinti csoportosítása)
4. **A Steane-Hadamard szűrő** (a bit-szintű előszűrés — a gyorsaság)
5. **A Markov-blanket** (a lekérdezés-szavak szerinti dimszió-szűrés)
6. **A Bergman-kernel** (a matematikai finomítás — kutatási tétel)
7. **A fixpont-iteráció** (a relevancia-visszacsatolás)

---

## 3. A FORRÁS-JEGYZÉK (minden talált fájl)

| Fogalom | Fájl | Sor | Státusz |
|---------|------|-----|---------|
| Tórusz | osveny_index/Torusz.idr | 479 | KÉSZ (keresésre: új) |
| EpisodicMemory | szima_ter/modul/EpisodicMemory_v1_Szima.idr | 1309 | KÉSZ (fehérje-elmélet) |
| GoldenFixpoint | szima_ter/modul/GoldenFixpoint_v1_Szima.idr | 393 | KÉSZ (φ = Y-struktúra) |
| Solomonoff/MDL | szima_ter/modul/SolomonoffIndukció_v1_Szima.idr | 324 | KÉSZ (γ = 7/64) |
| Markov-blanket | docs/stosszahlansatz_markov_blanket.md | — | KÉSZ (Stoßzahlansatz) |
| Yoneda | Kategóriaelmélet64_v1_Szima.idr, KategoriaElmelet.idr | — | KÉSZ (yonedaEgyertelmu) |
| **Bergman** | — | — | **HIÁNYZIK — ÚJ kutatás!** |
| Carnot | Dirac3D/Carnot.idr, ForditasCarnot.idr, E8Fa_v2 | — | KÉSZ (4 fázis) |
| Hadamard | osveny_index/HadamardTavolsag.idr | 110 | KÉSZ (E8E8-távolság) |
| skill-router | ~/.agents/skills/skill-router/SKILL.md | — | KÉSZ (15-dim + Hadamard) |
| BabyAGI | szima_ter/modul/BabyAGI_v1_Szima.idr | 191 | KÉSZ (15 szint, learnWord) |
| HungarianLexicon | szima_ter/modul/HungarianLexicon_v1_Szima.idr | 6952 | 3460 szó (privát!) |
| SzotarHid | szima_ter/modul/SzotarHid_v1.idr | 322 | KÉSZ (a híd + tő-keresés) |
| LumoKereso | szima_ter/modul/LumoKereso_v1.idr | 406 | KÉSZ (a v1 kereső) |

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★