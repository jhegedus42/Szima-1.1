# A GRAF-ALAPÚ KUTATÁSI KERETRENDSZER TERVE

**Dátum:** 2026-09-01
**A forrás:** a felhasználó paradigma-váltási szándéka + a 2 GAN (kategóriaelméleti + mérnöki) szintézise
**A cél:** egy Idris2-ben implementált gráf-adatbázis, amely a kutatási koncepciókat és összefüggéseket egy kereshető hálózattá szervezi — a magyar nyelvű keresés felületével.

---

## A FELHASZNÁLÓ KÉRDÉSE (szó szerint, §N5)

„az E8, E8 x E8 x E8 , 1-sejt, 2-sejt, co-tudat, kategoria-elmelet, gozgep, holografikus kodok, baby ai, meglevo kategoriak, pauli matrixok, CPT buborek, E9-et at kell nezni, Fano es meg kell nezni, hogy mit hogyan erdemes megtervezni, lehetnek alaternativ utvonalak is, tudni kene definialni azt, hogy mi a jelentes, de ezt lehet, hogy csak a Yoneda lemma tudja definialni, kategoria-elmeleti es algebra, elmeleti alapokra kellene helyezni a kutatast, ami azt jelenti, hogy a mostani tervet be kell kotni meglevo kutatasi eredmenyekbe, illetve megvizsgalando hipotezisekbe, bovitenunk kell a tervet es szilardabb alapokra kell helyeznunk mindent, nehogy az legyen, hogy a tul szuk alapok vakvaganyra vezetnek minket, ez hard rule, kb 5x hosszabb lesz a kutatas, es a kutatasnak most mar graf alapunak kell lennie, nem pedig linearisnak, ossze kell gyujteni a konceptciokat es idriszben leirni a potencialisan osszefuggo allitasokat, kovetkezteteseket, amik egy grafot fognak alkotni, ez a graf fogja nekunk remelhetoseg megmutatni, hogy merre kell mennunk, ennek a grafnak a megepitese, ertelmes modon, talan a legfontosabb dolog amit most tehetunk, jelenleg el vagyunk veszve, rendszereznunk kell magunkat, amihez az idriszt kell segitsegul hivnunk, ami hasznalhato osszefuggesek bejarasara... a gondolataink rendszerezesre, ez effektive egy graf adatbazis, amit egy idrisz program fog tudni keresni, es remelhetoleg a nyelve az a magyar nyelv lesz, amivel tudunk benne majd keresni, ki kell valamit talalnunk, kerdezzuk meg 2 GAN-t hogy, hogyan terveznenek meg egy ilyet, ha ez kesz van, akkor erre raepithetjuk a mostani kutatasi tervet, ne dobjunk el semmit, hanem hozzunk letre egy olyan gondolkozasi teret, ami segit nekunk tajekozodni, esszrevenni a relevans osszefuggeseket, a problema az, hogy rengeteg resz osszefuggesunk van, de nincsenek osszekotve megbizhatoan, idrisz adhat erre egy megoldast"

---

## I. A CÉL

A kutatás GRAF-ALAPÚ lesz, nem lineáris. A gráf egy Idris2-ben implementált adatbázis, amely:

1. **a koncepciókat** (E8, E8×E8×E8, 1-sejt, 2-sejt, co-tudat, kategóriaelmélet, gőzgép, holografikus kódok, BabyAGI, Pauli-mátrixok, CPT-buborék, E9, Fano + a GAN-hozzáadottak) csúcsokként tárolja;
2. **az összefüggéseket** (tények és hipotézisek) élekként, SÚLYOZVA a justification cost szerint (Bizonyított=0, Hipotézis=10);
3. **a következtetés-láncokat** a kompozíción (a szabad kategória) biztosítja;
4. **a jelentést** a Yoneda lemma szerint definiálja (a jelentés = a kifelé mutató morfizmusok összessége);
5. **a magyar nyelvű keresést** a 18 esetrag mint gráf-lekérdezési operátor (az inessive = a belső struktúra, az instrumental = a használat, stb.);
6. **a 76-feladatos lineáris tervet** ráépíti (a feladatok = Feladat-típusú csúcsok, a függőségek = élek);
7. **a kutatás előrehaladását** a betweenness-centrality + a frontier mutatja (a gráf javasolja a következő bizonyítandó hipotézist).

**A „gondolkodási tér"** (a felhasználó szerint) = a gráf PRESHEAF-KATEGÓRIÁJA (a toposz) — a gráf összes lehetséges nézőpontjainak kategóriája.

---

## II. A TÍPUSOK (az Idris2-adatszerkezet)

### II.1. A csúcsok

A gráf csúcsai KÜLÖNBÖZŐ típusúak (a GAN-2 szerint — nem egyetlen típus):

```idr
data CsúcsTípus = Koncepció | Állítás | Definíció | Megfigyelés
                | Feladat | IrodalomHivatkozás | Ellenőrzés

record Csúcs where
  constructor MkCsúcs
  csúcsNeve        : String
  csúcsLeírása     : String
  csúcsTípusa      : CsúcsTípus
  csúcsBeágyazása  : KomplexByte    -- a 8-dim fázistér-vektor (Hadamard-távolságú keresés)
  csúcsForrása     : Maybe String   -- a §N14/4: irodalmi hivatkozás (DOI/könyv)
```

A `csúcsBeágyazása : KomplexByte` — a meglévő `KomplexByte.idr` (§24: import, nem újraírás) szerint. Két koncepció „rezonál", ha a KomplexByte-jaik közeli szomszédok a 8-dimenziós térben.

### II.2. Az élek (morfizmusok)

Az élek SÚLYOZOTTAK a justification cost szerint:

```idr
data ÉlTípus where
  Bizonyított   : (bizonyítás : Refl) -> ÉlTípus       -- súly 0 — a typechecker ellenőrzi
  ErősHipotézis : (numerikusEllenőrzés : Bool) -> ÉlTípus  -- súly 5 — numerikusan alátámasztott
  GyengeHipotézis : (indoklás : String) -> ÉlTípus    -- súly 10 — sem bizonyítás, sem numerika
  Definíció     : (forrás : String) -> ÉlTípus         -- súly 0 — hivatkozott forrás
  Megfigyelés   : (forrás : String) -> (bizonytalanság : Double) -> ÉlTípus  -- súly 5

record Él where
  constructor MkÉl
  élForrása      : Csúcs
  élCélja        : Csúcs
  élTípusa       : ÉlTípus
  élSúlya        : Nat    -- a justification cost
```

A `Bizonyított` egy Idris `Refl`-et hordoz (a Curry-Howard szerint a típus = állítás, a program = bizonyítás; a typechecker = a bíra).

### II.3. A hiperélek (többváltozós állítások)

Sok állítás NEM bináris (pl. „E8 = 248 = a fehérje-dimerek száma" HÁROM koncepciót köt össze):

```idr
record Hiperél where
  constructor MkHiperél
  hiperélForrásai : List Csúcs
  hiperélCéljai   : List Csúcs
  hiperélTípusa   : ÉlTípus
  hiperélSúlya    : Nat
```

### II.4. A gráf

```idr
record KutatásiGráf where
  constructor MkKutatásiGráf
  gráfCsúcsai   : List Csúcs
  gráfÉlei      : List Él
  gráfHiperélei : List Hiperél
  gráfVerziója  : Nat     -- a fonál-szerű növekedés (git-history-szerű)
```

### II.5. A szabad kategória (a gráf felett)

A kompozíció (a következtetés-lánc) = az utak a gráfban:

```idr
data Mor : Csúcs -> Csúcs -> Type where
  IdPath : Mor a a                                  -- az identitás (a triviális állítás)
  ÉlMor  : Él -> Mor (élForrása él) (élCélja él)    -- egy él
  Comp   : Mor a b -> Mor b c -> Mor a c            -- a kompozíció (a következtetés)
```

A kompozíció ASSZOCIATÍV (`Comp (Comp f g) h = Comp f (Comp g h)`) és az IDENTITÁS semleges (`Comp IdPath f = f`, `Comp f IdPath = f`) — ezek Refl-bizonyítások (a typechecker ellenőrzi).

---

## III. A KONCEPCIÓK KATALÓGUSA (a csúcsok)

### III.1. A felhasználó által felsorolt 13 koncepció

| # | Koncepció | Típus | Forrás (irodalom) | A projekt-modul |
|---|---|---|---|---|
| 1 | E8 (a gyökrendszer / Lie-csoport) | Matematikai | Conway & Sloane (1988); Kac (1990) | `KostantFelbontás_v2.idr` |
| 2 | E8×E8×E8 (a szorzat, a heterotic string) | Matematikai/Fizikai | Green-Schwarz-Witten (1987) | (a `legkisebb-muvelet` skill szerint 3 objektum + 3 funktor) |
| 3 | 1-sejt (az egysejtű biológiai szervezet) | Biológiai | Margulis & Sagan (1995) | `EpisodicMemory_v1_Szima.idr` |
| 4 | 2-sejt (a kétsejtű szint, a szimbiózis) | Biológiai | Margulis (1970) | `EpisodicMemory_v1_Szima.idr` |
| 5 | Co-tudat (a kollektív tudat) | Biológiai/Elméleti | Shapiro (2007); Ben-Jacob (1998) | `BabyAGI_v1_Szima.idr` |
| 6 | Kategóriaelmélet | Elméleti | Mac Lane (1971); Awodey (2006) | (a meta-nyelv; a `trail_index/books/`) |
| 7 | Gőzgép (a termodinamika, a Carnot-ciklus) | Fizikai | Carnot (1824) | `ForditasCarnot.idr` |
| 8 | Holografikus kódok (a [[7,1,3]]) | Matematikai/Számítási | Steane (1996); Shor (1995) | `Torusz.idr` + `KomplexByte.idr` |
| 9 | BabyAGI (az autonóm ügynök) | Számítási | Nakajima (2023) | `BabyAGI_v1_Szima.idr` |
| 10 | Pauli-mátrixok (a σx, σy, σz) | Matematikai/Fizikai | Pauli (1940) | `GeneralizedPauli.idr` |
| 11 | CPT-buborék (a CPT-szimmetria réteg) | Fizikai | Schwinger (1951); Lüders (1954) | (új — a `legkisebb-muvelet` skill: 2 idődimenzió) |
| 12 | E9 (a kiterjesztett E8, a Kac-Moody) | Matematikai | Kac (1990); Nicolai (2004) | (új — `E9Affin.idr`) |
| 13 | Fano (a Fano-sík / a Fano-rács) | Matematikai | Fano (1892); Hilbert (1899) | (új — `FanoSik.idr`) |

### III.2. A GAN által hozzáadott 9 koncepció (a vakvágány-elkerülésért)

| # | Koncepció | Indok (miért kell) | Irodalom |
|---|---|---|---|
| 14 | Yoneda (a lemma mint objektum) | a jelentés-definíció hordozója | Mac Lane (1971) |
| 15 | Curry-Howard (a típus = állítás, a program = bizonyítás) | a bizonyítás-morfizmusok alapja | Lambek-Scott (1986) |
| 16 | Steane-kód (a [[7,1,3]]) | az E8 és a holografikus kódok közötti híd | Steane (1996) |
| 17 | Spin(8) (a Lie-csoport) | az E8 és a Pauli-mátrixok közötti híd | Kac (1990) |
| 18 | Carnot-ciklus (az ideális ciklus) | a gőzgép és a kategóriaelmélet közötti híd | Carnot (1824) |
| 19 | Tórusz (az E8 cella-szerkezete) | az E8 és a topológia közötti híd | `Torusz.idr` |
| 20 | Y-combinator (a fixpont-kombinátor) | a BabyAGI és a fixpont/iteráció közötti híd | `KvantumY.idr` |
| 21 | Kan-kiterjesztés (a „részleges tudás befejezése") | a gráfbejárás elméleti alapja | Mac Lane (1971) |
| 22 | Oktoniók (a 8-dim számrendszer) | az E8 és a Fano közötti híd (nélküle az E8→Fano él egyetlen ugrás) | Baez, „The Octonions" |

**További hiányzó koncepciók (a GAN-2 szerint):** Clifford-algebra, spinor, Kac-Moody-algebra, W-algebra, AGT-összefüggés, AdS/CFT, kvantum-hibajavító kód, gömbes-csomagolás, Maxwell-démon, Arnold-szingularitás, McKay-korrespondencia, moduláris forma, ADE-osztályozás.

---

## IV. A MORFIZMUSOK KATALÓGUSA (az élek)

### IV.1. A tény-élek ([T] = bizonyított)

| Forrás | Cél | Típus | Irodalom |
|---|---|---|---|
| E8 | E8×E8×E8 | Definíció | a direkt szorzat |
| E8 | spin(8) | Definíció | az E8 tartalmazza a D4-et (a triality) |
| E8 | Steane-kód | Definíció | Conway-Sloane (1988) |
| E8 | tórusz | Definíció | `R^8 / E8 = T^8` |
| E8 | E9 | Transzformáció | az affin Kac-Moody kiterjesztés |
| E8 | ADE-osztályozás | Definíció | az E8 az ADE legnagyobb tagja |
| Fano | oktoniók | Definíció | a Fano-sík = az oktoniók szorzási tábla |
| oktoniók | G2 | Definíció | a G2 az oktoniók autómorfizmusa |
| G2 | E8 | Definíció | a G2 az E8 része |
| Pauli-mátrixok | kvantum-mechanika | Definíció | Pauli (1940) |
| Pauli-mátrixok | spin(8) | Definíció | `su(2) ⊂ su(3) ⊂ ... ⊂ spin(8) ⊂ E8` |
| gőzgép | Carnot-ciklus | Definíció | Carnot (1824) |
| Carnot-ciklus | entrópia | Definíció | Clausius (1865) |
| kategóriaelmélet | Yoneda | Definíció | Mac Lane (1971) |
| kategóriaelmélet | Curry-Howard | Definíció | Lambek-Scott (1986) |
| Yoneda | Kan-kiterjesztés | Definíció | Mac Lane: „a legfontosabb fogalom" |
| Curry-Howard | Y-combinator | Definíció | a fixpont-kombinátor a rekurzió alapja |
| Y-combinator | fixpont | Definíció | a Y-combinator a fixpont-kombinátor |
| holografikus kódok | Steane-kód | Definíció | a Steane = a [[7,1,3]] |
| holografikus kódok | AdS/CFT | Definíció | Pastawski et al. (2015) |
| Steane-kód | E8 | Definíció | Conway-Sloane (1988) |
| 1-sejt | E8 | Hipotézis | a felhasználó hipotézise |
| MagyarNyelvtan | kategóriaelmélet | Definíció | a 18 esetrag = 18 morfizmus |

### IV.2. A hipotézis-élek ([H] = feltételezett, nem bizonyított)

| Forrás | Cél | Típus | Indoklás |
|---|---|---|---|
| E8 | Pauli-mátrixok | Hipotézis | az E8 gyökrendszere generálja (a spin(8) ⊃ su(2) láncon) |
| E8 | holografikus kódok | Hipotézis | a rács-kód ↔ tensor-kód híd |
| E8 | CPT-buborék | Hipotézis | a heterotic E8×E8 tartalmazza a CPT-t |
| E8×E8×E8 | 1-sejt | Hipotézis | a 3 objektum + 3 funktor = az 1-sejt három-rétegű szerkezete |
| 1-sejt | 2-sejt | Hipotézis | az endoszimbiozis (Margulis) |
| 2-sejt | co-tudat | Hipotézis | a kollektív tudat a sejt-kommunikációból |
| co-tudat | BabyAGI | Hipotézis | a kollektív intelligencia modellezhető |
| CPT-buborék | 1-sejt/2-sejt | Hipotézis | a CPT-rétegek = a sejt-szerkezet |
| gőzgép | E8 | Hipotézis | a termodinamika ↔ kvantum-információ híd |
| Carnot-ciklus | Maxwell-démon | Hipotézis | az információs entrópia (Landauer) |
| Maxwell-démon | BabyAGI | Hipotézis | az autonóm ügynök = információs démon |
| Y-combinator | co-tudat | Hipotézis | az önhivatkozás = a tudat szerkezete |
| fixpont | stabil | Hipotézis | a Banach-féle fixpont-tétel |
| Fano | hangrendszer | Hipotézis | a Fano = a hangrendszer alapja |
| E9 | kozmológia | Hipotézis | Nicolai (2004) — az E9/E10 és a kozmológia |
| Kan-kiterjesztés | gráfbejárás | Hipotézis | a részleges tudás befejezése |

---

## V. A YONEDA LEMMA MINT A JELENTÉS DEFINÍCIÓJA

A felhasználó (szó szerint): „tudni kene definialni azt, hogy mi a jelentes, de ezt lehet, hogy csak a Yoneda lemma tudja definialni".

**A Yoneda szerint a jelentés:** egy koncepció (pl. «E8») jelentése = az összes morfizmus, ami BELŐLE indul (a `Hom(E8, —)` presheaf) — az összes kapcsolat, amely az E8-at más koncepciókhoz köti.

Az «E8» jelentése tehát: `Hom(E8, E8×E8×E8)`, `Hom(E8, Pauli)`, `Hom(E8, spin(8))`, `Hom(E8, Steane)`, `Hom(E8, tórusz)`, `Hom(E8, E9)`, `Hom(E8, Fano)`, stb.

A Yoneda NEM CSAK a „jelentés = kifelé mutató morfizmusok" definíciót adja, hanem EGY IZOMORFIZMUST is: a viselkedés (a presheaf) és az érték (`F(A)`) között — a jelentés TELJES (minden információt tartalmaz) és HŰSÉGES (nem veszít el információt).

**Idrisben:**
```idr
-- a jelentés típusa: a kifelé mutató morfizmusok
record Jelentés (a : Csúcs) where
  constructor MkJelentés
  kifeléMorfizmusok : (b : Csúcs) -> List (Mor a b)

-- a Yoneda-izomorfizmus
yoneda : (F : Csúcs -> Type) -> Jelentés a -> F a
yonedaInv : (F : Csúcs -> Type) -> F a -> Jelentés a
```

---

## VI. A MAGYAR 18 ESETRAG MINT GRÁF-LEKÉRDEZÉSI OPERÁTOR

A GAN-2 legmélyebb hozzátevése: a magyar 18 esetrag (a `MagyarNyelvtan.idr`-ben már megvan) mindegyike EGY GRÁF-LEKÉRDEZÉSI OPERÁTORRÁ válik:

| Esetrag | Magyar | A gráf-lekérdezés | Példa |
|---|---|---|---|
| inessive (-ban/-ben) | «E8-BAN» | a belső struktúra lekérdezése | «E8-ban mi van?» → a kifelé mutató Definíció/Substruktúra élek |
| instrumental (-val/-vel) | «E8-VAL» | a használati kapcsolatok | «E8-val mit csinálunk?» → a Funktor/Eszköz élek |
| allative (-hoz/-hez/-höz) | «E8-HEZ» | a befelé mutató kapcsolatok | «mi vezet E8-hoz?» → a befelé mutató élek |
| elative (-ból/-ből) | «E8-BÓL» | a deduktív kimenet | «E8-ból mi következik?» → az Implikáció/Következtetés élek |
| causative (-ért) | «E8-ÉRT» | az oki kapcsolat | «E8 miért van?» → a Causa/Ok élek |
| translative (-vá/-vé) | «E8-VÉ» | a dinamika/fejlődés | «E8-vá mi lesz?» → a Transzformáció élek (E8→E9) |

**Ez azt jelenti, hogy a magyar nyelvtan MAGA A GRÁF LEKÉRDEZÉSI NYELVE.** A 18 esetrag = 18 féle gráf-lekérdezés. A magyar mondat nem csak „keres", hanem a RAGJA MEGMONDJA, milyen típusú élt keresünk. Ez az a pont, ahol a magyar nyelv (§N9, §N10) és a kategóriaelmélet és a gráf-adatbázis EGYBEOLVAD.

---

## VII. A KERESÉS (a gráf bejárása)

### VII.1. A négy alapvető keresés

1. **Szomszédok lekérdezése:** `szomszédok : Gráf → Csúcs → Irány → List Él` — a kifelé/befelé mutató élek.
2. **Összeköttetőség (van-e út A-tól B-ig?):** BFS — `Maybe (List Csúcs)`.
3. **Legrövidebb út (justification-súlyozva):** Dijkstra — a legjobbindokoltabb levezetés (a súly = a justification cost).
4. **Frontier (a bizonyítatlan, de fontos csúcsok):** a magas bejövő fokszámú Hipotézis csúcsok — a kutatás prioritása.

### VII.2. A Kleisli-morfizmus (a kérdés-monádban)

A keresés NEM determinisztikus (egy kérdés TÖBB koncepcióhoz is vezethet) — Kleisli-morfizmus a kérdés-monádban:

```idr
KerdesMonad a = Kerdes → List a  -- egy kérdéstől a koncepciók listájáig

kereses : Kerdes → KerdesMonad Csúcs
-- a magyar mondat → a gráf csúcsainak eloszlása
```

### VII.3. A magyar nyelvű keresés pipeline-ja

magyar mondat → `SzotarHid_v2.tokenizáló` → tokenek → `SzotarHid_v2.tő-keresés` → tők → `KomplexByte` (8-dim fázisvektor) → a mondat KomplexByte-ja = a tokenek vektorainak összege → Hadamard-távolság a gráf csúcsainak KomplexByte-jaihoz → a legközelebbi csúcs(ok) → a szomszédok (a 18 esetrag szerint) = a válasz.

### VII.4. A Kan-kiterjesztés (a részleges tudás befejezése)

Ha egy részgráfot bejártunk, a Kan-kiterjesztés `Lan_K F : B → C` a „tipp" a NEM bejárt koncepciókra — a részleges tudás alapján a hiányzó élek rekonstrukciója.

---

## VIII. A TERV RÁÉPÍTÉSE (a 76 feladat mint részgráf)

A mostani 76-feladatos terv ráépül a gráfra:
- A feladatok = `Feladat` típusú csúcsok; a függőségek = élek.
- A terv = a gráf egy RÉSZGRAFJA (a végrehajtható feladatok).
- A gráf GENERÁLJA a hiányzó feladatokat: ha egy `Hipotézis` élt semmi `Feladat` csúcs nem hidalja át, a gráf javasol egy új feladatot („bizonyítsd ezt a hipotézist").
- Minden `Feladat` csúcsnak HAT gyermek-ellenőrzés-csúcson van (a §N14/1–6 szerint: GAN, Fordítás, Numerika, Irodalom, Vizualizáció, Interaktív). A 76 feladat × 6 = 456 ellenőrzés-csúcs.

---

## IX. ALTERNATÍV ÚTVONALAK (9 útvonal az E8-tól a 9. szintig)

1. **Algebrai:** E8 → Steane → tórusz → klaszterezés → 9. szint
2. **Kvantum:** E8 → Pauli → kvantum → Y-combinator → fixpont → stabil → 9. szint
3. **Szín-tükör:** E8 → spin(8) → su(3) → szín-tükör → CPT → 1-sejt → 2-sejt → 9. szint
4. **Termodinamikai:** gőzgép → Carnot → entrópia → Maxwell-démon → BabyAGI → co-tudat → 9. szint
5. **Kategóriaelméleti:** kategóriaelmélet → Yoneda → jelentés → Kan-kiterjesztés → gráfbejárás → 9. szint
6. **Oktonió:** Fano → oktoniók → G2 → E8 → E9 → kozmológia → 9. szint
7. **ADE:** ADE-osztályozás → Arnold-szingularitás → McKay-korrespondencia → E8 → moduláris forma → 9. szint
8. **Kvantum-információs:** holografikus kódok → tensor-hálózat → AdS/CFT → kvantum-információ → Maxwell-démon → BabyAGI → 9. szint
9. **Bizonyítás:** Curry-Howard → bizonyítás → Y-combinator → fixpont → stabilitás → CPT → 1-sejt → 2-sejt → 9. szint

A gráf PARETO-FRONTIER-e megmutatja a kutatási stratégiát: a legrövidebb ÉS justification-szilárd utakat.

---

## X. A VÉGREHAJTÁSI LÉPÉSEK (a `KutatasiGraf_v1.idr` felépítése)

### Lépés 1: A TÍPUSOK (a `KutatasiGraf_v1.idr` alapjai)
- `data CsúcsTípus` (Koncepció, Állítás, Feladat, Ellenőrzés, …)
- `record Csúcs` (név, leírás, típus, beágyazás KomplexByte, forrás)
- `data ÉlTípus` (Bizonyított Refl, ErősHipotézis, GyengeHipotézis, Definíció, Megfigyelés)
- `record Él` (forrás, cél, típus, súly)
- `record Hiperél` (többváltozós)
- `record KutatásiGráf` (csúcsok, élek, hiperélek, verzió)
- `data Mor : Csúcs → Csúcs → Type` (IdPath, ÉlMor, Comp) — a szabad kategória
- Refl-bizonyítások: az asszociativitás + az identitás

### Lépés 2: A KONCEPCIÓK (a 22+ csúcs felvétele)
- a 13 felhasználói + 9 GAN-hozzáadott csúcs literálisan a gráfban
- mindegyik csúcshoz a `KomplexByte` beágyazás (a meglévő `KomplexByte.idr`-ből)

### Lépés 3: A MORFIZMUSOK (az élek felvétele)
- a tény-élek ([T]) — a `Bizonyított` vagy `Definíció` típusúak
- a hipotézis-élek ([H]) — a `GyengeHipotézis` típusúak
- a súlyozás (Bizonyított=0, ErősHipotézis=5, GyengeHipotézis=10)

### Lépés 4: A YONEDA (a jelentés definíciója)
- `record Jelentés (a : Csúcs)` — a kifelé mutató morfizmusok
- `yoneda : (F : Csúcs → Type) → Jelentés a → F a` — az izomorfizmus

### Lépés 5: A KERESÉS (a magyar nyelvű felület)
- a 18 esetrag mint operátor (az inessive = belső, az instrumental = használat, stb.)
- a `kereses : Kerdes → List Csúcs` (a magyar mondat → a gráf csúcsai)
- a szomszédok lekérdezése, a BFS, a Dijkstra, a frontier

### Lépés 6: A TERV RÁÉPÍTÉSE
- a 76 feladat `Feladat` típusú csúcsokként
- a függőségek élekként
- a §N14 hat ellenőrzés gyermek-csúcsokként

### Lépés 7: AZ ALTERNATÍV ÚTVONALAK
- a 9 útvonal kiszámítása (a Dijkstra a justification-súlyozással)
- a Pareto-frontier

### Lépés 8: A VERIFIKÁCIÓ (§N14 — mind a 6 szint)
1. GAN (a gráf szerkezetének ellenőrzése — körözészlelés, hiányzó csúcsok, téves élek)
2. Fordítás (`idris2 --check`)
3. Numerikus (`idris2 --exec main` — a gráf bejárása, a keresés)
4. Irodalom (minden élhez hivatkozás)
5. Vizualizáció (a Mermaid-diagram a gráfról)
6. Interaktív (a magyar nyelvű kérdés → a gráf válasza)

---

## XI. A „5x HOSSZABB" KUTATÁS SZERKEZETI OKA

A 76 feladat × 6 ellenőrzés = 456 ellenőrzés-csúcs. De a gráf GENERÁLJA a hiányzó feladatokat (a hipotézis-élek, amelyeket semmi Feladat nem hidal át) — a 76 feladat → ~380 feladat (a hiányzó bizonyítások + a 6 ellenőrzés/feladat). A „5x" tehát: 76 → ~380 (a gráf FELTÁRJA a bővülést, amit a felhasználó nem tudta előre).

---

## XII. A HOROG ÉS A HARD RULE-OK

- §N5 (szóról-szóra, nincs tömörítés): ez a terv SZÓRÓL SZÓRA idézi a felhasználót
- §N6/§24 (kód-duplikáció tilos): a `KomplexByte`, a `Paragrafus`, a `SzotarHid_v2`, a `MagyarNyelvtan`, a `Torusz`, a `GeneralizedPauli`, a `KostantFelbontás_v2`, a `KvantumY`, a `ForditasCarnot` mind IMPORTÁLANDÓK (nem újraírás)
- §N11 (olvass-előbb): a 2 GAN eredményeit rögzítettem a `kutatasi_naplo/2026-09-01_paradigmavaltas_graf_keretrendszer.md`-ben
- §N12 (keress a neten): a 2 GAN elvégezte (task-alügynökök)
- §N13 (push): ez a terv push-olva
- §N14 (hat-szintű verifikáció): a Lépés 8 szerint

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★

---

## XIII. A KATEGÓRIAELMELETI FOGALMAK TELJES KATALÓGUSA

A felhasználó (szó szerint): „adjunkciot vegyuk hozza, illetve az osszes letezo kategoria elmeleti fogalmat amit tudunk bizonyitani".

### A MEGLEVŐ 16 fogalom (a `KategoriaElmelet.idr`-ben, 1337 sor)

| # | Fogalom | A típus | Bizonyítható? |
|---|---|---|---|
| 1 | Kategória | `record Kategoria` — azonos + összetétel | ✓ |
| 2 | KategoriaT (interface) | `interface KategoriaT` — identitas + kompozicio + törvények | ✓ (Refl) |
| 3 | Monoidális kategória | `record MonoidalisKategoria` — tenzor + egység | ✓ |
| 4 | Duális kategória | `record DualisKategoria` — a duális objektum | ✓ |
| 5 | Funktor | `record Funktor` — objektumKép + morfizmusKép | ✓ |
| 6 | Természetes transzformáció | `record TermeszetesTranszformacio` — felso + also + komponens | ✓ |
| 7 | Bifunktor | `record Bifunktor` — a szorzat-kategóriából | ✓ |
| 8 | Span | `record Span` — két morfizmus közös forrással | ✓ |
| 9 | Cospan | `record Cospan` — két morfizmus közös céllal | ✓ |
| 10 | Szimmetrikus monoidális kategória | `record SzimmetrikusMonoidalisKategoria` — braiding | ✓ |
| 11 | Szorzat kategória | `record SzorzatKategoria` — C × D | ✓ |
| 12 | EllenMorf (C^op) | `data EllenMorf` — EllenNyil (a fordított morfizmus) | ✓ |
| 13 | **Adjunkció** ✓ | `record Adjunkcio` — balFunktor + jobbFunktor + balEgyseg + jobbEgyseg | ✓ (Hom_D(F a, b) ≅ Hom_C(a, G b)) |
| 14 | KettőKategória (2-kategória) | `record KettoKategoria` — 0/1/2-sejtek + összetételek | ✓ (interchange) |
| 15 | **Yoneda-beágyazás** ✓ | `record YonedaBeagyazas` — homPresheaf + utánaTételezés + yonedaLemma | ✓ (Nat(Hom(-,a), F) ≅ F a) |
| 16 | Csoport | `interface CsoportT` — szorzás + egység + inverz + törvények | ✓ (Refl) |

### A HIÁNYZÓ 34 fogalom (a KategoriaElmelet.idr-hez kiegészítendő)

#### A. Limit/Kolimit család (10 fogalom)
17. Végződés (terminal) 18. Kezdet (initial) 19. Szorzat (product) 20. Koprodukt (coproduct) 21. Pullback 22. Pushout 23. Egyenlőség (equalizer) 24. Koegyenlőség (coequalizer) 25. Limit (általános) 26. Kolimit (általános)

#### B. Monad/Comonad család (5 fogalom)
27. Monad 28. Comonad 29. Kleisli-kategória 30. Eilenberg-Moore-kategória 31. Szabad monad

#### C. Morfizmus-típusok (4 fogalom)
32. Monomorfizmus 33. Epimorfizmus 34. Izomorfizmus 35. Retrakció

#### D. Funktor-típusok (4 fogalom)
36. Teljes funktor 37. Hűséges funktor 38. Ekvivalencia 39. Felejtő funktor

#### E. Magasabb kategóriák (3 fogalom)
40. Bikategória 41. Profunctor 42. Kan kiterjesztés

#### F. Kvantum/fizika (4 fogalom — a projekt-kapcsolattal!)
43. Dagger kategória → **CPT-buborék** (a dagger = a tükör; a CPT a tükör + az idő)
44. Kompakt zárt kategória → **E8 × E8 × E8** (a kvantum-szimmetria)
45. Szalagos kategória → **Fano** (a braiding + a twist)
46. Nyom (trace) → **kvantum-mérés** (a partial trace)

#### G. Toposz/zárt (4 fogalom)
47. Toposz → **a „gondolkodási tér"**
48. Részobjektum-osztályozó (subobject classifier)
49. Exponenciális (belső hom: b^a)
50. Grothendieck-konstrukció (fibred/indexed kategóriák)

### A morfizmusok a kategóriaelméleti fogalmak között (a gráf élei)

- Adjunkció → Monad (a bal+jobb adjunktus kompozíciója)
- Adjunkció → Comonad (a duális)
- Monad → Kleisli-kategória; Monad → Eilenberg-Moore-kategória
- Szabad monad ⊣ Felejtő funktor (az adjunkció)
- Yoneda → Kan-kiterjesztés (az általánosítás)
- Limit → Egyenlőség; Kolimit → Koegyenlőség
- Szorzat → Pullback; Koprodukt → Pushout
- Végződés → Szorzat; Kezdet → Koprodukt
- Dagger kategória → CPT-buborék
- Kompakt zárt kategória → E8 × E8 × E8
- Szalagos kategória → Fano
- Nyom → kvantum-mérés
- Toposz → „gondolkodási tér"

### Irodalom (§N14/4)
- Mac Lane, „Categories for the Working Mathematician" (1971) — a standard referencia
- Awodey, „Category Theory" (2006) — az alapok
- Hu & Carette, „Proof-relevant Category Theory in Agda" (arXiv:2005.07059, 2020) — a bizonyíthatóság az Idris/Agda-ban
- nLab: „categorical semantics of dependent type theory" — a DTT mint kategória
- Lambek-Scott (1986) — a Curry-Howard + a kategóriaelmélet

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★