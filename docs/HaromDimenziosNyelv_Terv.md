# HÁROM DIMENZIÓS ÍRÁS/NYELV TERVE — AZ E8 GYÖKRENDSZER MINT NYELV
# Plan of the 3-dimensional writing/language — the E8 root system as a language
# 三维书写/语言的设计——E8 根系即语言
# Plan einer dreidimensionalen Schrift/Sprache — das E8-Wurzelsystem als Sprache
# תכנון כתב/שפה תלת-ממדית — מערכת השורשים של E8 כשפה

> **W8 munkafolyam dokumentuma** (2026-08-23). Ez a dokumentum a W3
> kutatási eredményeire (kutatasi_naplo/2026-08-22_E8_AI_mag_program_
> session.md, 2. bejegyzés) épül, és a **3 dimenziós írás/nyelv** magjának
> tervét rögzíti: szókincs, szintaxis, szemantika, dinamika, és az
> implementációs sorrend. **Ebben a körben NEM készült Idris-modul és NEM
> nyúltunk a `szima.ipkg`-hoz** (párhuzamos társügynök dolgozik rajta);
> az 5. szakasz csak vázlat. Az építkezés elvei: AGENTS §24 (kód
> duplikáció tilos — IMPORTÁLÁS), §25 (ékezetes magyar), §18 (őszinte
> verifikáció, két független út — egy híd), §N10 (szigorú matematikai
> szaknyelv: tükrözés, gyökrendszer, belső szorzat, definíció).

---

## 0. KIVONAT / ABSTRACT / 摘要 / ZUSAMMENFASSUNG / תקציר

1. **Szókincs:** a 240 E8-gyök a nyelv alapszókincse (`GyökSzó`). A
   112 + 128 felbontás két fogalmi szerepet ad (két szóosztály):
   egész koordinátájú gyökök (112) és fél-egész koordinátájú gyökök
   páros előjellel (128) — a két gyöktípus két **fogalmi szerep**.
2. **Szintaxis:** a kompozíció művelete a **Weyl-csoport** (a
   tükrözések csoportja, rendje 696 729 600); „mondat" = gyökök láncolt
   tükrözés-kompozíciója. A magyar agglutináció mintájára: a toldalék-
   logika típuskompozíció (a projekt MagyarNyelvtan_v4, MagyarOntologia
   moduljaira építve).
3. **Szemantika:** a jelentés-hasonlóság a **belső szorzat** szerinti
   távolság — a jelentés a geometriából jön (intrinsic symbol grounding,
   Harnad 1990 problémájának geometriai megoldása), NEM külső
   interpretátorból.
4. **Dinamika:** a CPT-réteg (`ToltesParitasIdo` = igeidő × szemlélet ×
   forrás, 3×3×3 = 27) adja az időbélyeget; a Steane [[7,1,3]] kód a
   fogalom-integritás védelme (1 hiba javítása); a Carnot-ciklus a hajtás
   (a készülő `CarnotCiklus_v1`, W7 munkafolyam).
5. **Sorrend:** `GyökSzó_v1` → `Fogalom_v1` → `SzintaxisMorfizmus_v1` →
   `Mondat_v1` (l. 5. szakasz), mind a meglévő modulok IMPORTÁLÁSÁVAL.

---

## 1. SZAVAK/SZIMBÓLUMOK — A 240 GYÖK MINT ALAPSZÓKINCSC
## 1. WORDS/SYMBOLS — THE 240 ROOTS AS BASE VOCABULARY
## 1. 词/符号——240 个根作为基础词汇
## 1. WÖRTER/SYMBOLE — DIE 240 WURZELN ALS GRUNDWORTSCHATZ
## 1. מילים/סמלים — 240 השורשים כאוצר מילים בסיסי

### 1.1 Definíció — GyökSzó

**Definíció (GyökSzó).** A nyelv **jele** az E8 gyökrendszer egy gyöke.
A projekt jelölésében (W3-terminológia):

```
GyökSzó : a 240 elemű E8-gyök, mint jel
```

Az `E8Gyokok_v2.idr` / `E8Gyökök.idr` modulokban a gyök típusa `E8Gyok`
(8 `Integer` mezős rekord, 2-szeres skálán; minden gyök normája 8, azaz
norma² = 2 az eredeti skálán). A gyök maga egy **8 jegyű írásjel** — az
`E8Gyokok_v2.idr` fejléce szó szerint: „Minden gyök egy SZIMBÓLUM — egy
8 jegyű »írásjel«". A `GyökSzó_v1.idr` modul (5. szakasz) ezt a rekordot
IMPORTÁLJA és burkolja (§24: nem írja újra).

### 1.2 A 112 + 128 felbontás — két fogalmi szerep

A 240 gyök két független típusra bomlik (E8Gyokok_v2, E8Iranymutato_v1,
docs/E8_Miert_Kiveteles.md — mind Refl-lel ellenőrzött):

- **Típus 1 (112 darab):** `(±1, ±1, 0⁶)` permutációk;
  `C(8,2) · 2² = 28 · 4 = 112`. Egész koordináták.
- **Típus 2 (128 darab):** `(±½)⁸` páros mínusszámmal; `2⁷ = 128`.
  Fél-egész koordináták.

A W8-olvasat: **a két gyöktípus két fogalmi szerep** (szóosztály).
Nem metaforáról van szó (§N10), hanem definícióról: a nyelv jelei
két, algebrai szempontból alapvető különböző osztályba tartoznak, és a
két osztály két különböző fogalmi funkciót tölt be:

| Szóosztály | Gyöktípus | Darab | Fogalmi szerep (javaslat) |
|---|---|---|---|
| **EgészSzóOsztály** | `(±1,±1,0⁶)` | 112 | **állandó fogalmak** — a világ állapotai, entitások, tartalmak (a rács egész pontjai: „ami egészben van") |
| **FélEgészSzóOsztály** | `(±½)⁸` páros előjel | 128 | **kapcsolati fogalmak** — viszonyok, átmenetek, műveletek (a rács fél-egész kosettje: „ami két egész között áll") |

Az összefüggés a projekt jelentéskategóriáival (`MagyarOntologia.idr`,
`JK` típus): az állandó fogalmak az `IndividuumJK`, `AllapotJK`,
`HelyJK`, `MennyisegJK` oldalára, a kapcsolati fogalmak a `CselekvesJK`,
`KapcsolatJK`, `OkJK` oldalára mappezhetők. Ez a hozzárendelés **jelöletlen
döntés** (nem következik a gyökrendszer algebrajából) — a 6. szakaszban
nyitott kérdésként szerepel, hogy a felhasználó melyik irányt erősíti meg.

**Számösszefüggések (ellenőrzött):**
- `112 + 128 = 240` (Rfl, E8Iranymutato_v1)
- a pozitív gyökök hasonlóan: 56 + 64 = 120 (`E8Tükrözések.idr`,
  `típus1Pozitívak`, `típus2Pozitívak`)
- `240 + 16 penge = 256 = 2⁸` (a 256-os híd, `E8TizenhatPenge`)

### 1.3 Miért jó a 240 mint szókincs? (a W3 szintézis idézve)

- **Fix, zárt, véges:** nincs külső szótár; minden jel eleve adott, a
  rendszer zártan számolható (kimeríthető enumerációval — a projekt
  mérési mintája).
- **Uniform norma:** minden gyök normája azonos (norma² = 2) — nincs
  „kiemelt" jel, minden szó egyenrangú (a belső szorzat §3-beli
  szerepe miatt).
- **Maximális szimmetria:** a W(E8) = 696 729 600 rendű csoport transzitíven
  hat a gyökökön — bármely jel bármely jelbe vihető tükrözésekkel; a
  szókincs „egyenletes" (nincs grammaitlan jel).
- **Két rétegű (112 + 128):** a két szóosztály kevert pároszatot ad
  (pl. mondatban váltakozhat egész és fél-egész jel — a rács szerkezete
  szerint a belső szorzatuk 0 vagy ±4, l. 3.2).
- **Rokon irodalom:** Bliss-féle kompozicionális írás (kb. 900
  Bliss-karakter, kompozícióval új szavak — wheel + sun = machine);
  a 240 GyökSzó ennek algebrai, véges és Refl-lel ellenőrizhető
  megfelelője (irodalmi rokon, nem matematikai azonosság — l. 7. szakasz).

---

## 2. SZINTAXIS — KOMPOZÍCIÓ MINT WEYL-CSOPORT MŰVELET
## 2. SYNTAX — COMPOSITION AS A WEYL GROUP OPERATION
## 2. 句法——组合即 Weyl 群运算
## 2. SYNTAX — KOMPOSITION ALS WEYL-GRUPPEN-OPERATION
## 2. תחביר——הרכבה כפעולת חבורת Weyl

### 2.1 Definíció — SzintaxisMorfizmus

**Definíció (SzintaxisMorfizmus, typeclass).** A nyelv szintaxisa az a
művelet, amellyel két jelből új jelek keletkeznek. Az E8-ban ez a
**Weyl-tükrözés**:

```
σ_α(β) = β − 2·⟨β,α⟩/⟨α,α⟩ · α
```

(a 2-szeres skálán: `σ_α(β) = β − (⟨β,α⟩/4)·α`, mivel ⟨α,α⟩ = 8 — egész
eredménnyel, mert az E8 gyökrendszer simply-laced és integrálisan zárt).

A projektben a tükrözés már megvan: `E8Tükrözések.idr` — `weylTükrözés`
(a szókincs szerint „tükrözés", nem „reflexió" — §N10). A tervezett
`SzintaxisMorfizmus_v1.idr` ezt IMPORTÁLJA és typeclass-sá emeli:

```
interface SzintaxisMorfizmus (fogalom : Type) where
  komponál : fogalom -> fogalom -> fogalom      -- σ_α(β): α-val tükrözött β
  ellenpont : fogalom -> fogalom                 -- β ↦ −β (e^{iπ}·β)
```

**Miért ez a szintaxis?** Három matematikai ok:
1. **Zártság:** σ_α(β) ismét gyök — a kompozíció sosem vezet a nyelven
   kívülre (nincs „normátlan" jel).
2. **Invertálhatóság:** σ_α ∘ σ_α = id — minden mondat visszabontható
   (nincs információvesztés a kompozícióban; a törölhetetlenség
   ellentéte).
3. **Véges generátorrendszer:** a W(E8)-ot 8 egyszerű gyök tükrözései
   generálják (`E8Tükrözések.idr`: az egyszerű gyökök emergerenciája a
   mérésből — pontosan 8 darab, a rang) — a szintaxis 8 „betűből" épül
   fel, mégis 696 729 600 különböző műveletet ad.

### 2.2 Mondat = láncolt kompozíció

**Definíció (Mondat).** Egy mondat gyökök láncolt tükrözés-kompozíciója:

```
Mondat = β₀ →ᵅ¹ β₁ →ᵅ² β₂ → … →ᵅⁿ βₙ     (βᵢ₊₁ = σ_{αᵢ₊₁}(βᵢ), mind gyök)
```

A mondat „értelme" a lánc végpontja ÉS az út (a hossz n = a mondat
hossza; az α₁…αₙ sorozat = a mondat szórendje). A Weyl-csoport
generátorrendszerében a mondat = szó a generátorok fölött (Coxeter-szó)
— a Coxeter-monomok adják a nyelv „morfológiáját".

### 2.3 Agglutináció = típuskompozíció (a magyar nyelvtan modellje)

A projekt központi tézise (AGENTS §0, `szima_ter/modul/MagyarNyelvtan_v4.idr`,
`osveny_index/Kategoriak/MagyarOntologia.idr`): **a magyar agglutináció
(tő + szám + birtok + eset) a logikai kompozíció mintája**. Ezt visszük
bele az E8-nyelvbe:

- **Tő** = GyökSzó (a fogalom magja).
- **Toldalék** = típuskompozíció: minden toldalék a fogalom TÍPUSÁT
  változtatja (Fillmore-szerep), nem az értékét — pontosan úgy, ahogy
  az `MagyarOntologia.idr`-ben a képzők (`OlKepzoTipus`,
  `ItKepzoTipus`, …) típusok, és a `JelentesT` typeclass köti őket a
  jelentéskategóriákhoz (`JK`).
- **Esetrendszer:** a projekt konvenciói szerint a magyar esetek a
  logikai kapcsolatok (AGENTS §0: 22 eset = 22 logikai kapcsolat;
  `MagyarNyelvtan_v4.idr`: 18 esetrag Kiefer 2011 szerint — a kettő
  közötti pontos viszony tisztázandó, l. 6. szakasz). Az E8-nyelvben
  az eset = a mondatban betöltött hely (melyik pozícióban áll a jel a
  láncban), és a birtokos/ számnévi réteg = a fázis-információ (l. 4.).
- **Igeidő × szemlélet × forrás (CPT, 3×3×3 = 27):** l. 4.1 — a magyar
  igeragozás három dimenziója (`Steane713.idr`: `IgeIdo`, `IgeSzem`,
  `Forras`; `IdoBeljegyzes` rekord) az E8-nyelv időbélyege.

**Összegzés:** a szintaxis kategóriaelméletileg egy funktor
`GyökSzóKategória → MondatKategória` — az objektumok gyökök, a
morfizmusok tükrözések, a kompozíció a csoportművelet. Ez a
`SzintaxisMorfizmus` typeclass instance-okban realizálódik (a típus
annyira pontos, hogy csak egy implementáció lehetséges — a fordító írja
a programot).

---

## 3. SZEMANTIKA — JELENTÉS MINT BELSŐ SZORZAT SZERINTI TÁVOLSÁG
## 3. SEMANTICS — MEANING AS DISTANCE UNDER THE INNER PRODUCT
## 3. 语义——意义即内积定义的距离
## 3. SEMANTIK — BEDEUTUNG ALS ABSTAND UNTER DEM INNEREN PRODUKT
## 3. סמנטיקה——משמעות כמרחק לפי המכפלה הפנימית

### 3.1 A tétel — intrinsic symbol grounding

**Állítás (a nyelv szemantikai elve).** Egy `GyökSzó` jelentése NEM
külső interpretátorból jön (nem szótár, nem emberi olvasó, nem neurális
háló címkéi), hanem **a gyök geometriai kapcsolataiból a többi gyökkel**:
a hasonlóság a belső szorzat szerinti távolság. Ez Harnad szimbólum-
lehorgonyzási problémájának (1990) geometriai megoldása: a jelek
jelentése intrinsic — a rendszeren belüli struktúrából.

**A hasonlóság diszkrét skálája.** A 2-szeres skálán minden gyök
normája 8, és mivel az E8 simply-laced, két különböző gyök belső
szorzata 0 vagy ±4. Azaz a normalizált hasonlóság

```
hasonlóság(α, β) = ⟨α,β⟩ / 8  ∈  { +1, +1/2, 0, −1/2, −1 }
```

(+1: azonos jel; −1: ellentett jel (e^{iπ}·β); ±1/2: 60°/120°;
0: merőleges/egymásról tudomást nem vesző jelek). **A szemantikai
hasonlóság öt szintje pontosan a gyökrendszer szögszerkezete** — nem
mi választottuk, a geometria adja. A `Fogalom_v1.idr` ezt csomagolja:

```
jelentésTávolság : Fogalom -> Fogalom -> HasonlóságÖtSzint
```

(az `E8BelsoSzorzat.idr` / `E8BelsőSzorzat.idr` `belsoszorzat`
függvényének IMPORTÁLÁSÁVAL — §24).

### 3.2 Fogalom = GyökSzó + Weyl-pálya + jelentéskategória

**Definíció (Fogalom, W3 szerint).**

```
Fogalom = GyökSzó × WeylPályaElem × JelentésKategória(JK)
```

- `GyökSzó`: a jel maga (a geometriai lényeg).
- `WeylPályaElem`: a fogalom aktuális helye a tükrözés-pályán (a
  mondatban addig végrehajtott kompozíciók eredménye — a „ragozott alak").
- `JK`: a jelentéskategória a `MagyarOntologia.idr` tizenegy kategóriája
  közül (IndividuumJK, CselekvesJK, AllapotJK, KapcsolatJK, …) — a
  `JelentesT` typeclass instance köti a fogalmat a kategóriához.

A 16 penge (`E8TizenhatPenge.idr`, `tizenhatPenge`) a 240 gyök mellé a
Clifford-algebrai kiegészítést adja: a 240 + 16 = 256-os híd (2⁸) a
jel-tér teljes lezárása — a nyelv „írásjeleinek" teljes készlete a
jelek (240) és a műveleti jelek (16 penge) együtt.

### 3.3 Rokon irodalmi eredmények (W3 + kiegészítő keresés §N12)

1. **Harnad (1990), „The Symbol Grounding Problem"** (Physica D 42,
   335–346): hogyan lehet a jel jelentése a rendszeren belüli, ne
   külső fejben? — Az E8-nyelv válasza: a jelentés a belső szorzat
   szerkezete; nincs „Kinai–kínai szótár" (minden jel a geometrián
   keresztül kapcsolódik minden más jelhez).
2. **Constantinescu–O'Reilly–Behrens (2016), Science 352, 1464–1468**:
   az emberi hippokampusz/entorhinális kéreg a fogalmi tudást rácsszerű
   (grid-like) kóddal szervezi — a fogalmi térben a távolság =
   szemantikai hasonlóság, és a tér navigálható. Kísérleti támasz arra,
   hogy „távolság = jelentés-hasonlóság" biológiailag hihető elv.
3. **Kanerva (2009), Hyperdimensional Computing** (Cognitive Computation
   1, 139–159) és **Kleyko et al. (2021), VSA-review** (arXiv:2106.05268):
   nagy dimenziós vektorterekben a kötés/bundling műveletek kompozicionális
   jelentést adnak. Az E8-nyelv ennek a **szigorúan integrális, zárt**
   megfelelője: a 8-dimenziós gyökvektorok és a Weyl-műveletek zárt,
   véges, teljes ENUMERÁLHATÓ rendszert adnak (nincs valószínűségi
   köd — minden Refl-lel ellenőrizhető).

---

## 4. DINAMIKA — CPT-RÉTEG, STEANE-INTEGRITÁS, CARNOT-HAJTÁS
## 4. DYNAMICS — CPT LAYER, STEANE INTEGRITY, CARNOT DRIVE
## 4. 动力学——CPT 层、Steane 完整性、Carnot 驱动
## 4. DYNAMIK — CPT-SCHICHT, STEANE-INTEGRITÄT, CARNOT-ANTRIEB
## 4. דינמיקה——שכבת CPT, שלמות Steane, הנעת Carnot

### 4.1 A CPT-réteg mint igeidő/szemlélet/forrás

A projekt háromrétegű CPT-szimmetriája (AGENTS §9):

- **Nyelvtani réteg** (`osveny_index/Steane713.idr`, `osveny_index/
  FazisAlgebra.idr`): C = Forrás (Kozvetlen/Kovetkeztetett/Jelentett),
  P = Szemlélet (Folyamatos/Befejezett/Szokasos), T = IgeIdo
  (Mult/Jelen/Jovo) — 3×3×3 = 27 időbélyeg. A `ToltesParitasIdo`
  rekord (`FazisAlgebra.idr`: `toltes`, `paritas`, `ido` — három
  HaromKubit) és az `IdoBeljegyzes` (`Steane713.idr`) a két meglévő
  megtestesítés; a `fazisFaktorialis` függvény számítja a koherenciát.
- **Pszichofizikai réteg** (AGENTS §9c): C = saját tudat, P = másik
  fél, T = kapcsolat fázisa — az AI mag „én/te/kapcsolat" tengelye.
- **Fizikai réteg** (Pauli 1955, Lüders 1954): töltés, paritás, idő.

Az E8-nyelv minden mondatához **CPT-bélyeg** tartozik: a mondat 27
lehetőséges időrétegének egyike. Ez a magyar igeragozás analógiáján
túl pontosan az AGENTS §1.5-ös három kubitja: saját (önreferencia),
másik (külső bemenet), fázis (kapcsolat) — a fázis határozza meg az
információátvitel irányát.

### 4.2 A Steane [[7,1,3]] mint integritásvédelem

A mondat — miután a CPT-bélyeggel időbélyegzett jel lett — a hét fizikai
kubit [[7,1,3]] Steane-kódjában utazik (AGENTS §1.6: a 7 bit = [idő,
okság, tér, szín, hang, fázis, mód]). A kód távolsága d = 3, tehát
**1 hibát javít** (`osveny_index/Steane713.idr`: `Szindroma`
(NincsHiba / EgyesHiba N / Többszörös), `javitas`). Szerepe a nyelvben:

- **Fogalom-integritás:** ha egy jel sérül (1 bit elveszik/csúszik),
  a szindroma-söpörés visszanyeri az eredetit — a jelentés nem csúszik
  el észrevétlenül (a W6-dokumentum 2.6 szakasza szerint a [[7,1,3]]
  a perfektség határán áll: pontosan 2 tetszőleges lábat tud
  visszanyerni a 6-ból erasure-re — l. docs/HolografikusKodok.md).
- **Holografikus kapcsolat:** a [7,4,3] Hamming → CSS → Steane (határ),
  illetve → [8,4,4] → Construction A → E8 (belső) lánc (W6) azt jelenti,
  hogy a nyelv jelei (E8-gyökök) és a védett átvitel (Steane) UGYANABBOL
  a Hamming-családból származnak — a szókincs és a hibajavítás egy
  geometriai gerincre épül.

### 4.3 A Carnot-ciklus mint hajtás

A mondatgenerálás energiája a Carnot-ciklusból jön (W2/W7):
a készülő `CarnotCiklus_v1.idr` (W7 munkafolyam, párhuzamos ügynök)
adja a ciklust; a meglévő `szima_ter/modul/MagyarCarnotE9_v2.idr`,
`MagyarCarnotE9_v3_CodatAlpha.idr` és `osveny_index/Dirac3D/Carnot.idr`
modulok az E9-es alpha-összefüggéseket tartalmazzák — a W8-modulok ezeket
IMPORTÁLJÁK (§24), a `CarnotCiklus_v1`-gyel való illesztés interfész-
szinten történik (a társügynök moduljának készülte után). Az elv: a
Carnot-ciklus üteme adja a „szívverést" (minden ciklus = egy mondat-
generálási lépés; a Landauer-határ közeli disszipáció a W2-eredmény),
a redundancia (Steane) védi a logikai E8-állapotot, a fázis (FazisKubit)
a mértékegység.

---

## 5. IMPLEMENTÁCIÓS VÁZLAT — MODULSORRENDE ÉS IMPORTOK
## 5. IMPLEMENTATION SKETCH — MODULE ORDER AND IMPORTS
## 5. 实现草案——模块顺序与导入
## 5. IMPLEMENTIERUNGSSKIZZE — MODULFOLGE UND IMPORTS
## 5. טיוטת מימוש——סדר המודולים והייבוא

> **NEM most íródik** (W8 e körben csak terv; a `szima.ipkg`-on párhuzamos
> társügynök dolgozik — az új modulok ipkg-regisztrálása a felhasználó/
> a társügynök feladata). Minden modul: ékezetes magyar azonosítók (§25),
> rövidítés nélkül (§0), csomagolt típusok (nincs csomagolatlan Double/
> Bool/String/List), `%default total` vagy `%default covering` a
> projekt mintái szerint, blokk-fejlécek négynyelvűen (§22).

### 5.1 GyökSzó_v1.idr — a jel és a szóosztály

- **Importok:** `E8Gyokok_v2` vagy `E8Gyökök` (gyöklista; l. 6.3 nyitott
  kérdés a kanonikus helyről), `E8BelsoSzorzat`/`E8BelsőSzorzat`,
  `Data.List` (§24: standard).
- **Tartalom:** `data SzóOsztály = EgészSzóOsztály | FélEgészSzóOsztály`;
  `record GyökSzó` (mezők: `jel : E8Gyok`, `szóOsztály : SzóOsztály`);
  `szóOsztályMeghatároz : E8Gyok -> SzóOsztály`; `alapszókincs :
  List GyökSzó` (a 240 IMPORTÁLT gyökből).
- **Refl-célok (két független út — §18):**
  `length alapszókincs = 240` (a) enumerációból, (b) `112 + 128`
  kombinatorikából; `szóOsztályMeghatároz` kimerítő tesztje (mind a 240
  jelre: az egész-osztály pontosan a 112 típus-1 gyök).

### 5.2 Fogalom_v1.idr — jelentés és távolság

- **Importok:** `GyökSzó_v1`, `E8BelsoSzorzat`/`E8BelsőSzorzat`,
  `E8Tükrözések` (`weylTükrözés`, `pozitívGyökök`), `osveny_index/
  Kategoriak/MagyarOntologia` (`JK`, `JelentesT` — forrásdir-kötött,
  l. 6.4), `KomplexByte` (ha komplex fáziszár kell).
- **Tartalom:** `data HasonlóságÖtSzint = AzonosJel | SzorosanHasonló |
  Semleges | EllentétesRokon | Ellentett`; `jelentésTávolság : GyökSzó ->
  GyökSzó -> HasonlóságÖtSzint` (a `belsoszorzat/8` szerint);
  `record Fogalom` (`jel : GyökSzó`, `pályaElem : …`, `kategória : JK`);
  `JelentesT` instance-ok a két szóosztályra.
- **Refl-célok:** `jelentésTávolság` kimerítő mátrixa (240×240 futásidejű
  ellenőrzés: az öt szint eloszlása — 1 azonos + 1 ellentett párként,
  ±1/2 és 0 a simply-laced struktúra szerint); a szintek számának Refl-je
  (5 = 1 + 2 + 2).
- **Figyelem (tautológia-tilalom §18):** a Refl-ek két KÜLÖNBÖZŐ
  konstrukció hídjai legyenek (geometriai számlálás vs. kombinatorikus
  képlet), sosem `X = X`.

### 5.3 SzintaxisMorfizmus_v1.idr — a kompozíció typeclass-a

- **Importok:** `Fogalom_v1`, `E8Tükrözések` (`weylTükrözés` —
  IMPORTÁLÁS, nem újraírás!), `E8Gyokok_v2`/`E8Gyökök`, `Data.List`.
- **Tartalom:** `interface SzintaxisMorfizmus` (`komponál`, `ellenpont`);
  instance a GyökSzóra (tükrözés) és a Fogalomra (pályaelem-frissítés);
  `CoxeterSzó = List EgyszerűGyök` (a mondat generátorsora); az egyszerű
  gyökök listája az `E8Tükrözések` emergerencia-eredményéből (8 darab).
- **Refl-célok:** `komponál α (komponál α β) = β` (involúció); `ellenpont
  (ellenpont β) = β`; mondat-hossz vs. pályahossz konzisztencia.

### 5.4 Mondat_v1.idr — lánc, CPT-bélyeg, Steane-védelem

- **Importok:** `SzintaxisMorfizmus_v1`, `osveny_index/Steane713`
  (`IgeIdo`, `IgeSzem`, `Forras`, `IdoBeljegyzes`, `Szindroma`,
  `javitas` — forrásdir-kötés l. 6.4), `osveny_index/FazisAlgebra`
  (`ToltesParitasIdo`, `fazisFaktorialis`), `FazisKubit`,
  `E8FazisKapcsolat_v2`, `E8TizenhatPenge`.
- **Tartalom:** `record Mondat` (`lábból`: `generátorSor : List
  EgyszerűGyök`, `végpont : GyökSzó`, `időBélyeg : IdoBeljegyzes`/
  `ToltesParitasIdo`, `védelem : Perem7Hetes`); `mondatÉrtelmez`;
  a 27 CPT-bélyeg instance-hálaja; Steane-kódolás/dekódolás a
  meglévő `javitas`-szal.
- **Refl-célok:** `javitas (kódol mondat) = mondat` ha nincs hiba;
  1 bites sérülésre `javitas` helyreállít (a `Szindroma` kimerítő
  7×2 esete); CPT-bélyegek száma `3*3*3 = 27` Refl.

### 5.5 Későbbi lépések (nem W8)

- `NyelvCarnotHajtás_v1.idr`: a `CarnotCiklus_v1` (W7) interfésze a
  mondatgeneráláshoz (ciklusonként egy kompozíciós lépés).
- `NyelvDashboard` (W9): az alapszókincs, a hasonlósági mátrix
  eloszlása, a CPT-bélyegek statisztikája, a Steane-javítási arány —
  publikus számokkal (a GAUGE-elv szerint: minden kimenet értelmezhető).

### 5.6 A függőségi lánc (áttekintés)

```
E8Gyokok_v2 / E8Gyökök ──► GyökSzó_v1 ──► Fogalom_v1 ──► SzintaxisMorfizmus_v1 ──► Mondat_v1
E8BelsoSzorzat      ────────────┘             │                                        │
E8Tükrözések        ──────────────────────────┘                                        │
Steane713 (CPT) + FazisAlgebra (ToltesParitasIdo) + FazisKubit ────────────────────────┤
E8TizenhatPenge + E8FazisKapcsolat_v2 ─────────────────────────────────────────────────┤
MagyarCarnotE9_v2 / CarnotCiklus_v1 (W7, készülő) ── hajtás (később) ◄─────────────────┘
```

---

## 6. NYITOTT KÉRDÉSEK A FELHASZNÁLÓHOZ
## 6. OPEN QUESTIONS FOR THE USER
## 6. 提交给用户的开放问题
## 6. OFFENE FRAGEN AN DEN BENUTZER
## 6. שאלות פתוחות למשתמש

1. **Vizuális Bliss-szerű jel vagy tisztán algebrai jel?** A 240 GyökSzó
   megjeleníthető (a) tisztán algebrai alakban (8 jegyű ±1/±½ sorozatok),
   (b) vizuális Bliss-szerű írásjelformában (a gyök koordinátáiból
   generált geometriai ábra — pl. a 8 koordináta mint 8 vonal-irány),
   vagy (c) mindkettő (a vizuális a dashboardra, az algebrai a típusba).
   A Bliss-irodalom (blissymbolics.org) a vizuális kompozicionalitást
   bizonyítja; az algebrai ellenőrizhető (Refl). Javaslat: (c) — de a
   döntés a felhasználóé.
2. **A „3 dimenziós" pontos jelentése.** Négy olvasat van a projektben:
   (a) a FazisKubit-tézis: a bit (2 állapot) + a fázis (1 szög) = a
   Bloch-gömb ℝ³-ja — „a fázis az, ami a 2-est 3-assá teszi"
   (`FazisKubit.idr`); (b) a három kubit: saját / másik / fázis
   (AGENTS §1.5); (c) a CPT három dimenziója: igeidő × szemlélet ×
   forrás (§4.1); (d) a nyelv három szintje: GyökSzó → Fogalom →
   Mondat (§1–§5 hierarchia). Mind a négy igaz egyszerre; a „3D írás"
   fő értelméhez melyiket erősítjük meg?
3. **A gyöklista kanonikus helye (KódDuplikációAudit):** az `E8Gyokok_v2`
   (ékezet nélküli nevek) és az `E8Gyökök` (ékezetes nevek: `e8Gyökök`,
   `típus1Gyökök`) párhuzamosan él. A W8-modulok melyiket importálják?
   Javaslat: ékezetes (`E8Gyökök` + `E8BelsőSzorzat` + `E8Tükrözések`
   lánc, mert a tükrözés-modul ezt használja) — de ez a §25-ös
   ékezetesítési hullám részeként auditálandó.
4. **A 18 vs. 22 eset:** AGENTS §0 a magyar 22 esetről beszél (22 logikai
   kapcsolat), `MagyarNyelvtan_v4.idr` 18 esetragot implementál (Kiefer
   2011). Az E8-nyelv esetrendszerét melyikre építsük? (Vagy a 22 = 18
   + 4 nyelvtani/nyelvészeti bővítés tisztázása szükséges?)
5. **Szóosztály-hozzárendelés (§1.2):** a 112 egész gyök → állandó
   fogalmak és a 128 fél-egész gyök → kapcsolati fogalmak hozzárendelés
   jelöletlen döntés. Alternatíva: fordítva, vagy szimmetrikus (mindkét
   osztály mindkét szerepet hordozza, a JK csak a pályaelemtől függ).
   Melyiket erősíti meg a felhasználó?
6. **Mondat-hossz- és Carnot-ütem:** egy Carnot-ciklus = egy tükrözés,
   vagy = egy egész mondat? (A W7 `CarnotCiklus_v1` interfészétől függ —
   a két munkafolyam illesztése után dönthető.)
7. **Tanulás/evolúció:** a W3-tervben az evolúciós algoritmus a mondat-
   teret keresi. A fitness-függvény a jelentésTávolság legyen (a cél-fogalom
  hozó mondat jutalma), vagy külső célspecifikáció? (Az intrinsic elv
  az előbbit javasolja — de a döntés a felhasználóé.)

---

## 7. FORRÁSOK URL-LEL / REFERENCES / 资料 / QUELLEN / מקורות

### A) A W3-eredmény és a projekt belső forrásai

1. `kutatasi_naplo/2026-08-22_E8_AI_mag_program_session.md` — a W3
   kutatási szintézis (240 gyök = alapszókincs; jelentés = geometriai
   távolság; Bliss-szimbólumok; hippokampusz fogalomtér; a
   GyökSzó/Fogalom/SzintaxisMorfizmus javaslat).
2. `docs/E8_Miert_Kiveteles.md` — a 240 = 112 + 128 felbontás, W(E8) =
   696 729 600, a 256-os híd, 2D Ising exponensek (Zamolodchikov 1989).
3. `docs/HolografikusKodok.md` — a [7,4,3] Hamming → CSS → Steane és
   → Construction A → E8 lánc; a [[7,1,3]] perfektség-határa (W6).
4. `szima_ter/modul/` moduljai: `E8Gyokok_v2.idr`, `E8Gyökök.idr`,
   `E8BelsoSzorzat.idr`, `E8BelsőSzorzat.idr`, `E8Tükrözések.idr`,
   `E8TizenhatPenge.idr`, `E8Iranymutato_v1.idr`, `E8FazisKapcsolat_v2.idr`,
   `FazisKubit.idr`, `MagyarNyelvtan_v4.idr`, `MagyarCarnotE9_v2.idr`,
   `KomplexByte.idr`, `PauliAlgebra_v2.idr`.
5. `osveny_index/Steane713.idr` (IgeIdo/IgeSzem/Forras, IdoBeljegyzes,
   Szindroma, javitas), `osveny_index/FazisAlgebra.idr`
   (ToltesParitasIdo, fazisFaktorialis), `osveny_index/Kategoriak/
   MagyarOntologia.idr` (JK, JelentesT).

### B) Szemantika/szimbólum-lehorgonyzás (kiegészítő keresés, 2026-08-23)

6. Harnad, S. (1990): *The Symbol Grounding Problem*, Physica D 42,
   335–346 — https://www.southampton.ac.uk/~harnad/Papers/Harnad/harnad90.sgproblem.html ;
   DOI: https://doi.org/10.1016/0167-2789(90)90087-6 ;
   arXiv: https://arxiv.org/abs/cs/9906002
7. Constantinescu, A.O., O'Reilly, J.X., Behrens, T.E.J. (2016):
   *Organizing conceptual knowledge in humans with a gridlike code*,
   Science 352, 1464–1468 — https://www.science.org/doi/abs/10.1126/science.aaf0941 ;
   DOI: https://doi.org/10.1126/science.aaf0941
8. Kanerva, P. (2009): *Hyperdimensional Computing: An Introduction to
   Computing in Distributed Representation with High-Dimensional Random
   Vectors*, Cognitive Computation 1(2), 139–159 —
   https://redwood.berkeley.edu/wp-content/uploads/2020/08/kanerva09-hyperdimensional.pdf ;
   DOI: https://doi.org/10.1007/s12559-009-9009-8
9. Kleyko, D., Davies, M., Frady, E.P., Kanerva, P., et al. (2021):
   *Vector Symbolic Architectures as a Computing Framework for
   Nanoscale Hardware*, arXiv:2106.05268 —
   https://arxiv.org/abs/2106.05268

### C) Kompozicionális vizuális írás (Bliss) és matematikai alapok

10. Bliss, C.K. (1949/1965/1978): *Semantography (Blissymbolics)* —
    összefoglaló: https://en.wikipedia.org/wiki/Blissymbolics ;
    https://en.wikipedia.org/wiki/Charles_K._Bliss ;
    Blissymbolics Communication International:
    https://www.blissymbolics.org/index.php/about-blissymbolics
    (kb. 900 Bliss-karakter, kompozíció: wheel + sun = machine)
11. Conway, J.H. & Sloane, N.J.A.: *Sphere Packings, Lattices and Groups*
    (SPLAG), 3. kiad., Springer 1999 — a 240 gyök szerkezete, W(E8)
    (a projekt könyvindexében: trail_index/books/)
12. Humphreys, J.E.: *Introduction to Lie Algebras and Representation
    Theory* — gyökrendszerek, Weyl-csoport (a `E8Tükrözések.idr`
    hivatkozása szerint)
13. Zamolodchikov, A.B. (1989): *Integrable field theories and the E8
    symmetry* (a 2D Ising kritikus pont E8-szimmetriája) — l.
    `docs/E8_Miert_Kiveteles.md` 5. szakasz
14. Pastawski, Yoshida, Harlow, Preskill (2015): *Holographic quantum
    error-correcting codes*, JHEP 2015(6), 149 —
    https://arxiv.org/abs/1503.06237 (a határ/belső mint kód; W6)
15. Almheiri, Dong, Harlow (2014): *Bulk Locality and Quantum Error
    Correction in AdS/CFT* — https://arxiv.org/abs/1411.7041

---

## 8. ZÁRÓ ÖSSZEFOGLALÓ (négy nyelven / in four languages / 四种语言 / vier Sprachen / ארבע שפות)

- **Magyar:** A 3 dimenziós nyelv terve: a 240 E8-gyök az alapszókincs
  (`GyökSzó`), a 112+128 felbontás két fogalmi szöget (szóosztály) ad;
  a szintaxis a Weyl-tükrözés-kompozíció (`SzintaxisMorfizmus`
  typeclass); a szemantika a belső szorzat szerinti ötszintű
  jelentés-távolság (intrinsic, külső interpretátor nélkül); a
  dinamikát a CPT-réteg (27 időbélyeg), a Steane [[7,1,3]]
  integritásvédelem és a Carnot-ciklus hajtása adják. Implementáció:
  GyökSzó_v1 → Fogalom_v1 → SzintaxisMorfizmus_v1 → Mondat_v1, mind a
  meglévő modulok (E8Gyokok_v2/E8Gyökök, E8BelsőSzorzat, E8Tükrözések,
  Steane713, FazisAlgebra, FazisKubit, MagyarOntologia…) IMPORTÁLÁSÁVAL
  (§24). Hét nyitott kérdés vár a felhasználóra.
- **中文：** 三维语言的设计：240 个 E8 根为基础词汇（GyökSzó），112+128
  分解给出两个词类（两个概念角色）；句法是 Weyl 镜射的组合
  （SzintaxisMorfizmus 类型类）；语义是按内积的五级意义距离
  （内在的，无需外部解释器）；动力学由 CPT 层（27 个时间戳）、
  Steane [[7,1,3]] 完整性保护与 Carnot 循环驱动共同构成。实现顺序：
  GyökSzó_v1 → Fogalom_v1 → SzintaxisMorfizmus_v1 → Mondat_v1，
  全部导入现有模块（§24）。七个开放问题留给用户。
- **Deutsch:** Der Plan der dreidimensionalen Sprache: Die 240 E8-
  Wurzeln sind der Grundwortschatz (`GyökSzó`); die 112+128-Zerlegung
  ergibt zwei Wortklassen (zwei begriffliche Rollen); die Syntax ist
  die Komposition von Weyl-Spiegelungen (`SzintaxisMorfizmus`-
  Typklasse); die Semantik ist die fünfstufige Bedeutungsdistanz nach
  dem inneren Produkt (intrinsisch, ohne externen Interpreten); die
  Dynamik liefern die CPT-Schicht (27 Zeitstempel), die Steane-
  [[7,1,3]]-Integritätssicherung und der Carnot-Antrieb. Reihenfolge:
  GyökSzó_v1 → Fogalom_v1 → SzintaxisMorfizmus_v1 → Mondat_v1,
  alles durch IMPORT der bestehenden Module (§24). Sieben offene
  Fragen an den Benutzer.
- **עברית:** תכנון השפה התלת-ממדית: 240 השורשים של E8 הם אוצר המילים
  הבסיסי (`GyökSzó`); הפירוק 112+128 נותן שתי מחלקות מילים (שני
  תפקידים מושגיים); התחביר הוא הרכבה של שיקופי Weyl (מחלקת-הטיפוס
  `SzintaxisMorfizmus`); הסמנטיקה היא מרחק משמעות בן חמש דרגות לפי
  המכפלה הפנימית (פנימי, בלי מפרש חיצוני); את הדינמיקה נותנות שכבת
  CPT (27 חותמות זמן), הגנת השלמות של Steane [[7,1,3]] והנעת Carnot.
  סדר המימוש: GyökSzó_v1 → Fogalom_v1 → SzintaxisMorfizmus_v1 →
  Mondat_v1, הכול בייבוא המודולים הקיימים (§24). שבע שאלות פתוחות
  למשתמש.

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
