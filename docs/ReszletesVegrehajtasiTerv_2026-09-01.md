# RÉSZLETES VÉGREHAJTÁSI TERV — a graf-alapú kutatási keretrendszer építése

**Dátum:** 2026-09-01
**A források (szintézis):**
- `docs/GrafKeretrendszerTerv_2026-09-01.md` (a 2 GAN szintézise — 13 fejezet)
- `docs/VegrehajtasiTerv_2026-09-01.md` (a 76-feladatos lineáris terv)
- `docs/EpisodicMemoryTerv_50pont_2026-09-01.md` (az 50-pontos kutatási terv)
- `kutatasi_naplo/2026-09-01_paradigmavaltas_graf_keretrendszer.md` (a 2 GAN)
- `kutatasi_naplo/2026-09-01_kategoriaelmeleti_fogalmak.md` (a 50 fogalom)
- `kutatasi_naplo/2026-09-01_meglevo_konyvtarak.md` (a 6 kategóriaelméleti könyvtár)
- `kutatasi_naplo/2026-09-01_tobb_konyvtar_nyelv.md` (a 10 fizikai/kvantum könyvtár)

**A felhasználó (szó szerint, §N5):** „most keszitsunk ehhez egy reszletes tervet"

**A cél:** egy Idris2-ben implementált gráf-adatbázis, amely a 16 külső könyvtár (Coq, Agda, Lean) koncepcióit adaptálva + a 50 kategóriaelméleti fogalmat + a 76-feladatos lineáris tervet ráépítve + a magyar nyelvű keresést (a 18 esetrag mint operátor) egy EGYSÉGES, kereshető hálózattá szervezi — amely mutatja, merre kell menni.

---

## A. A SZERKEZET (az architektúra)

### A.1. A három réteg

A keretrendszer HÁROM RÉTEGBŐL áll:

**1. réteg (az ALAPOK):** a kategóriaelméleti fogalmak Idris2-ben
- a `KategoriaElmelet.idr` (1337 sor, 16 fogalom már megvan) kiegészítése a 34 hiányzóval → 50 fogalom
- a 16 külső könyvtár koncepcióinak adaptálása (a proof-struktúrák, a definíciók)
- a dagger kategória, a kompakt zárt kategória, a szalagos kategória (a CPT/E8×E8×E8/Fano kapcsolat — SAJÁT, nincs egyetlen könyvtárban sem)

**2. réteg (a GRÁF):** a kutatási gráf-adatbázis
- a csúcsok (koncepciók + állítások + feladatok + ellenőrzések)
- az élek (morfizmusok: Bizonyított/Hipotézis, súlyozva a justification cost szerint)
- a szabad kategória (a kompozíció = a következtetés-lánc)
- a Yoneda lemma (a jelentés definíciója)
- a magyar 18 esetrag mint gráf-lekérdezési operátor
- a Kan-kiterjesztés (a részleges tudás befejezése)

**3. réteg (a TÉRVÉT):** a 76-feladatos lineáris terv ráépítése
- a feladatok `Feladat` típusú csúcsokként
- a függőségek élekként
- a §N14 hat ellenőrzés gyermek-csúcsokként (76 × 6 = 456)
- a gráf generálja a hiányzó feladatokat (a hipotézis-élek → új feladatjavaslat)

### A.2. Az Idris2 a „összefogó" nyelv

Az Idris2 a főnyelv (a hard rule szerint). A 16 külső könyvtár (Coq, Agda, Lean) koncepcióit és bizonyítás-struktúráit adaptáljuk Idris2-be:

| A külső könyvtár | A koncepció | Az Idris2-be adaptálva |
|---|---|---|
| agda-categories | a proof-relevant Setoid-enriched megközelítés | a `KategoriaElmelet.idr` kiegészítése |
| agda-unimath | a Yoneda/Kan/limit/kolimit (L/R) | a 34 hiányzó fogalom |
| Cat_on_Coq | a setoid-alapú limit/kolimit/adjunction/KanExt | a limit/kolimit család |
| Mathlib (Lean) | az adjunction + a Monad.Adjunction | a monad/comonad család |
| catagi (Lean) | a YonedaAttention + ToposCausal | a gráf keresési felület |
| physlib (Lean) | a fizika digitalizálása | a fizikai csúcsok beágyazása |
| LeanQuantum (Lean) | a Pauli-operátor-algebra + a `solve_matrix` | a Pauli-mátrixok |
| QECLean (Lean) | a Steane [[7,1,3]] + toric + CSS | a holografikus kódok |
| Lean-QEC (Lean) | a bináris szimplektikus + SAT | a szindróma-dekódolás |
| TNLean (Lean) | az MPS/PEPS fundamentális tétel | a tenzor-hálózatok |
| LEGO_HQEC (Python) | a HaPPY code + a tensor network decoder | a holografikus elv |
| t6s/qecc (Coq) | a caps and cups (kompakt zárt!) | a kompakt zárt kategória |
| QuantumLib/SQIR (Coq) | a kvantum-számítás | a kvantum-kapuk |
| shape-of-logic (Lean) | az 8-tick connection | a [[7,1,3]] 7+1 dimenziója |
| agda-algebras (Agda) | az univerzális algebra | az algebrai struktúrák |
| fredefox/cat (Agda) | a cubical Agda + univalencia | ( referencia — a magasabb szintekhez) |

### A.3. A „saját" (a projekt eredeti hozzájárulása)

A 16 könyvtár egyike SEM tartalmazza:
- **a dagger kategóriát** (a CPT-buborék!)
- **a szalagos kategóriát** (a Fano!)
- **a CPT-buborékot** (a 2 idődimenzió)
- **az E8×E8×E8 mint kompakt zárt kategória** (a kvantum-szimmetria)
- **az E9/E10 mint hiperbolikus Kac-Moody** (a kozmológia)
- **a magyar 18 esetrag mint gráf-lekérdezési operátor** (a magyar nyelv = a gráf nyelve)

Ezeket a projekt SAJÁT magának kell implementálnia — ez a projekt EREDETI hozzájárulása.

---

## B. A VÉGREHAJTÁSI LÉPÉSEK (10 fázis)

### FÁZIS 0 — az alapozás (a meglévő munka összefoglalása)

**A meglévő (KÉSZ):**
- 000.01 HungarianLexicon v2 (3460 szó publikus)
- 000.02 Szótár-generátor + prozódia (ritmus + hangsúly + fonetika + minimálpár-gráf + hisztogram + hangrend + szindróma)
- 000.04 Tő-keresés 22 esetrag + rekurzív + birtokos ragok
- 001.01 Mondat-tokenizáló (szavakTisztítva + mondatTövei)
- 011.01 VerifikációsProtokoll typeclass
- 011.10 A terv kiegészítése a §N14-gyel
- `KategoriaElmelet.idr` (1337 sor, 16 kategóriaelméleti fogalom)
- `Torusz.idr`, `GeneralizedPauli.idr`, `KostantFelbontás_v2.idr`, `KvantumY.idr`, `ForditasCarnot.idr`, `KomplexByte.idr`, `Paragrafus.idr`, `BabyAGI_v1_Szima.idr`, `EpisodicMemory_v1_Szima.idr`, `MagyarNyelvtan.idr`

**A hiányzó (a 4 KRITIKUS + 10 FONTOS GAN-javaslat, a todo-ban Vár):**
- 000.05 Funkciószó-lexikon (KRITIKUS — a CPT előfeltétele)
- 000.06 Bájt-kanonizálás (KRITIKUS — a metrikák előfeltétele)
- 001.00 Mondat-szegmentáló (KRITIKUS — a CPT mondatonként)
- 000.11 OOV-bájtgenerálás (KRITIKUS — a keresés előfeltétele)

### FÁZIS 1 — a kategóriaelméleti alapok kiegészítése (a 34 hiányzó fogalom)

**A feladat:** a `KategoriaElmelet.idr` (1337 sor) kiegészítése a 34 hiányzó kategóriaelméleti fogalommal, a 16 külső könyvtár adaptálásával.

#### Lépés 1.1 — a limit/kolimit család (10 fogalom)
- Végződés (terminal) — a Cat_on_Coq Cons/ adaptálása
- Kezdet (initial)
- Szorzat (product) — az Idris2 `record` mint univerzális tulajdonság
- Koprodukt (coproduct) — a duális
- Pullback (fiber product) — a szorzat általánosítása
- Pushout — a koprodukt általánosítása
- Egyenlőség (equalizer)
- Koegyenlőség (coequalizer)
- Limit (általános) — az agda-unimath Limits adaptálása
- Kolimit (általános)
- **Refl-bizonyítások:** az egyértelműség (az univerzális tulajdonság egyértelműsége)
- **Futtatás:** `idris2 --check KategoriaElmelet.idr` (exit 0)

#### Lépés 1.2 — a monad/comonad család (5 fogalom)
- Monad (a join + unit + a monad-törvények) — a Mathlib Monad.Adjunction adaptálása
- Comonad (a comultiplication + counit)
- Kleisli-kategória (a `hom a (T b)` morfizmusok + a Kleisli-kompozíció)
- Eilenberg-Moore-kategória (a modulok)
- Szabad monad (a szabad objektum)
- **Refl-bizonyítások:** az asszociativitás + az egység
- **A kapcsolat:** Adjunkció → Monad (a bal+jobb adjunktus kompozíciója)

#### Lépés 1.3 — a morfizmus-típusok (4 fogalom)
- Monomorfizmus (injektív)
- Epimorfizmus (szürjektív — a duális)
- Izomorfizmus (a kétoldali inverz)
- Retrakció (a bal-inverz)

#### Lépés 1.4 — a funktor-típusok (4 fogalom)
- Teljes funktor (a Hom surjektív)
- Hűséges funktor (a Hom injektív)
- Ekvivalencia (teljes + hűséges + esszenciálisan surjektív)
- Felejtő funktor (a struktúrát elfelejti)
- **A kapcsolat:** Szabad ⊣ Felejtő (az adjunkció)

#### Lépés 1.5 — a magasabb kategóriák (3 fogalom)
- Bikategória (a gyengébb 2-kategória — a KettoKategoria kiterjesztése)
- Profunctor (a `C^op × C → Set` bifunktor)
- Kan kiterjesztés (a `Lan_K F` — az agda-unimath Left/Right Kan adaptálása)
- **A kapcsolat:** Yoneda → Kan-kiterjesztés (az általánosítás)

#### Lépés 1.6 — a kvantum/fizika kategóriák (4 fogalom — SAJÁT!)
- **Dagger kategória** — minden morfizmusnak van duálisa (†); a tükör; a CPT-buborék alapja
- **Kompakt zárt kategória** — a duális objektum + a coevaluation; az E8×E8×E8 alapja (a caps and cups — a t6s/qecc kqm.v inspirálta)
- **Szalagos kategória** (ribbon) — a braiding + a twist; a Fano alapja
- **Nyom** (trace) — a partial trace; a kvantum-mérés
- **Forrás:** a t6s/qecc `kqm.v` (caps and cups) inspirálta, de SAJÁT implementáció (nincs egyetlen könyvtárban sem)
- **Refl-bizonyítások:** a dagger involúció (†† = id); a braiding involúció (β_{b,a} ∘ β_{a,b} = id); a nyom egyértelműsége

#### Lépés 1.7 — a toposz/zárt (4 fogalom)
- Toposz (a részobjektum-osztályozóval rendelkező kategória — a „gondolkodási tér")
- Részobjektum-osztályozó (az Ω objektum)
- Exponenciális (a belső hom: `b^a`)
- Grothendieck-konstrukció (a fibred/indexed kategóriák)
- **Forrás:** a Cat_on_Coq CCC/ + a catagi ToposCausal adaptálása

### FÁZIS 2 — a gráf-adatbázis építése (a `KutatasiGraf_v1.idr`)

#### Lépés 2.1 — a csúcs- és éltípusok
- `data CsúcsTípus` (Koncepció, Állítás, Definíció, Megfigyelés, Feladat, IrodalomHivatkozás, Ellenőrzés)
- `record Csúcs` (név, leírás, típus, beágyazás KomplexByte, forrás Maybe String)
- `data ÉlTípus` (Bizonyított Refl, ErősHipotézis Bool, GyengeHipotézis String, Definíció String, Megfigyelés String Double)
- `record Él` (forrás, cél, típus, súly Nat)
- `record Hiperél` (többváltozós — források List Csúcs, célok List Csúcs, típus, súly)
- `record KutatásiGráf` (csúcsok, élek, hiperélek, verzió Nat)

#### Lépés 2.2 — a szabad kategória (a gráf felett)
- `data Mor : Csúcs → Csúcs → Type` (IdPath, ÉlMor, Comp)
- Refl-bizonyítások: az asszociativitás (`Comp (Comp f g) h = Comp f (Comp g h)`) + az identitás (`Comp IdPath f = f`)

#### Lépés 2.3 — a súlyozás (justification cost)
- `élSúlya : Él → Nat` — Bizonyított=0, ErősHipotézis=5, GyengeHipotézis=10, Definíció=0, Megfigyelés=5
- `útSúlya : List Él → Nat` — az élek súlyainak összege

#### Lépés 2.4 — a csúcsok beágyazása (KomplexByte)
- minden csúcshoz a `KomplexByte` (a 8-dim fázistér-vektor, a meglévő `KomplexByte.idr`-ből — §24: import)
- a Hadamard-távolság a csúcsok között (a meglévő `HadamardTavolsag.idr`-ből — §24: import)

### FÁZIS 3 — a koncepciók felvétele (a csúcsok)

#### Lépés 3.1 — a 13 felhasználói koncepció
- E8, E8×E8×E8, 1-sejt, 2-sejt, co-tudat, kategóriaelmélet, gőzgép, holografikus kódok, BabyAGI, Pauli-mátrixok, CPT-buborék, E9, Fano
- mindegyik csúcshoz a `KomplexByte` beágyazás (a meglévő `KomplexByte.idr`-ből)

#### Lépés 3.2 — a 9 GAN-hozzáadott koncepció
- Yoneda, Curry-Howard, Steane-kód, spin(8), Carnot-ciklus, tórusz, Y-combinator, Kan-kiterjesztés, oktoniók

#### Lépés 3.3 — a további hiányzó koncepciók (a GAN-2 szerint)
- Clifford-algebra, spinor, Kac-Moody-algebra, W-algebra, AGT, AdS/CFT, kvantum-hibajavító kód, gömbes-csomagolás, Maxwell-démon, Arnold-szingularitás, McKay-korrespondencia, moduláris forma, ADE-osztályozás

### FÁZIS 4 — a morfizmusok felvétele (az élek)

#### Lépés 4.1 — a tény-élek ([T] = bizonyított)
- E8 → E8×E8×E8 (Definíció)
- E8 → spin(8) (Definíció)
- E8 → Steane-kód (Definíció — Conway-Sloane)
- E8 → tórusz (Definíció — R^8 / E8 = T^8)
- E8 → E9 (Transzformáció — az affin Kac-Moody)
- Fano → oktoniók → G2 → E8 (Definíció)
- Pauli-mátrixok → kvantum-mechanika (Definíció)
- gőzgép → Carnot-ciklus (Definíció)
- kategóriaelmélet → Yoneda (Definíció)
- Yoneda → Kan-kiterjesztés (Definíció)
- Curry-Howard → Y-combinator (Definíció)
- holografikus kódok → AdS/CFT (Definíció)
- MagyarNyelvtan → kategóriaelmélet (Definíció — a 18 esetrag = 18 morfizmus)
- Adjunkció → Monad (Definíció)
- (… a teljes lista a GrafKeretrendszerTerv IV.1)

#### Lépés 4.2 — a hipotézis-élek ([H] = feltételezett)
- E8 → Pauli-mátrixok (Hipotézis — a spin(8) ⊃ su(2) lánc)
- E8×E8×E8 → 1-sejt (Hipotézis — a 3 objektum + 3 funktor)
- 1-sejt → 2-sejt (Hipotézis — az endoszimbiozis)
- 2-sejt → co-tudat (Hipotézis)
- co-tudat → BabyAGI (Hipotézis)
- CPT-buborék → 1-sejt/2-sejt (Hipotézis)
- gőzgép → E8 (Hipotézis — a termodinamika ↔ kvantum-információ)
- Y-combinator → co-tudat (Hipotézis — az önhivatkozás = a tudat)
- Fano → hangrendszer (Hipotézis)
- E9 → kozmológia (Hipotézis — Nicolai)
- Kan-kiterjesztés → gráfbejárás (Hipotézis)
- (… a teljes lista a GrafKeretrendszerTerv IV.2)

### FÁZIS 5 — a Yoneda lemma (a jelentés definíciója)

#### Lépés 5.1 — a Jelentés típus
- `record Jelentés (a : Csúcs)` — a kifelé mutató morfizmusok: `kifeléMorfizmusok : (b : Csúcs) → List (Mor a b)`
- a jelentés = a `Hom(a, —)` presheaf

#### Lépés 5.2 — a Yoneda-izomorfizmus
- `yoneda : (F : Csúcs → Type) → Jelentés a → F a`
- `yonedaInv : (F : Csúcs → Type) → F a → Jelentés a`
- a jelentés TELJES (minden információt tartalmaz) és HŰSÉGES (nem veszít el információt)

### FÁZIS 6 — a magyar nyelvű keresés (a 18 esetrag mint operátor)

#### Lépés 6.1 — a 18 esetrag mint lekérdezési operátor
- «-ban/-ben» (inessive) → a belső struktúra lekérdezése (a kifelé mutató Definíció/Substruktúra élek)
- «-val/-vel» (instrumental) → a használati kapcsolatok (a Funktor/Eszköz élek)
- «-hoz/-hez/-höz» (allative) → a befelé mutató kapcsolatok
- «-ból/-ből» (elative) → a deduktív kimenet (az Implikáció/Következtetés élek)
- «-ért» (causative) → az oki kapcsolat
- «-vá/-vé» (translative) → a dinamika/fejlődés (a Transzformáció élek — E8→E9)
- (a többi 12 esetrag hasonlóan — a `MagyarNyelvtan.idr`-ben már megvan)

#### Lépés 6.2 — a keresési pipeline
- magyar mondat → `SzotarHid_v2.szavakTisztítva` → tokenek → `SzotarHid_v2.tőKeresés` → tők → `KomplexByte` (8-dim) → a mondat KomplexByte-ja → Hadamard-távolság a gráf csúcsainak KomplexByte-jaihoz → a legközelebbi csúcs(ok) → a szomszédok (a 18 esetrag szerint) = a válasz

#### Lépés 6.3 — a Kleisli-morfizmus (a kérdés-monádban)
- `KerdesMonad a = Kerdes → List a`
- `kereses : Kerdes → KerdesMonad Csúcs`
- a Kleisli-kompozíció: a láncolt keresés

#### Lépés 6.4 — a Kan-kiterjesztés (a részleges tudás befejezése)
- ha egy részgráfot bejártunk, a `Lan_K F` a „tipp" a nem bejárt koncepciókra

### FÁZIS 7 — a keresés (a gráf bejárása)

#### Lépés 7.1 — a négy alapvető keresés
- szomszédok lekérdezése (`szomszédok : Gráf → Csúcs → Irány → List Él`)
- összeköttetőség (BFS — `Maybe (List Csúcs)`)
- legrövidebb út (Dijkstra — a justification-súlyozással)
- frontier (a magas bejövő fokszámú Hipotézis csúcsok — a kutatás prioritása)

#### Lépés 7.2 — a körözészlelés + a topologikus rendezés + a betweenness-centrality
- körözészlelés (a körkörös érvelés zászlózása — a §N10 gépesített őre)
- topologikus rendezés a feladatgráfra (végrehajtási sorrend)
- betweenness-centrality (a kutatás prioritása — a gráf mutatja a következő lépést)

### FÁZIS 8 — a terv ráépítése (a 76 feladat mint részgráf)

#### Lépés 8.1 — a feladatok csúcsokként
- a 76 feladat `Feladat` típusú csúcsokként (a `SajatTodo_v1.idr`-ből importálva — §24)
- a függőségek `Függőség` típusú élekként

#### Lépés 8.2 — a §N14 hat ellenőrzés gyermek-csúcsokként
- minden Feladat csúcsnak HAT gyermeke (GAN, Fordítás, Numerika, Irodalom, Vizualizáció, Interaktív)
- a 76 × 6 = 456 ellenőrzés-csúcs

#### Lépés 8.3 — a gráf generálja a hiányzó feladatokat
- ha egy `Hipotézis` élt semmi `Feladat` csúcs nem hidalja át → a gráf javasol egy új feladatot
- a „5x hosszabb" szerkezeti oka: 76 → ~380 (a hiányzó bizonyítások + a 6 ellenőrzés)

### FÁZIS 9 — az alternatív útvonalak

#### Lépés 9.1 — a 9 útvonal kiszámítása
- a Dijkstra a justification-súlyozással (a 9 útvonal — l. a GrafKeretrendszerTerv IX)
- a Pareto-frontier (a legrövidebb ÉS justification-szilárd utak)

#### Lépés 9.2 — a vakvágány-észlelés
- a csúcsok, amelyek CSAK egy úton érhetők el, és amelyek élei mind Hipotézis-ek → VAKVÁGÁNY
- a gráf megmutatja, hol kell alternatív utakat keresni

### FÁZIS 10 — a verifikáció (§N14 — mind a 6 szint)

#### Lépés 10.1 — a GAN (a gráf szerkezetének ellenőrzése)
- körözészlelés, hiányzó csúcsok, téves élek
- a gráf REKURZÍV GAN-ellenőrzése (a §N14/1 a gráf szerkezetére is vonatkozik)

#### Lépés 10.2 — a fordítás + a numerikus + az irodalom + a vizualizáció + az interaktív
- `idris2 --check KutatasiGraf_v1.idr` (exit 0)
- `idris2 --exec main` (a gráf bejárása, a keresés, a magyar kérdés → a válasz)
- minden élhez irodalmi hivatkozás (DOI/könyv)
- a Mermaid-diagram a gráfról (a §N14/5)
- a magyar nyelvű kérdés → a gráf válasza (a §N14/6)

---

## C. A FÜGGŐSÉGEK (a topologikus sorrend)

```
FÁZIS 0 (az alapozás — KÉSZ)
  ↓
FÁZIS 1 (a 34 kategóriaelméleti fogalom) ← a 16 külső könyvtár adaptálása
  ↓
FÁZIS 2 (a gráf-adatbázis — a típusok) ← a FÁZIS 1 (a kategóriaelmélet)
  ↓
FÁZIS 3 (a koncepciók felvétele) ← a FÁZIS 2 (a gráf) + a meglévő Idris-modulok
  ↓
FÁZIS 4 (a morfizmusok felvétele) ← a FÁZIS 3 (a csúcsok)
  ↓
FÁZIS 5 (a Yoneda — a jelentés) ← a FÁZIS 1 (a Yoneda-beágyazás) + a FÁZIS 4
  ↓
FÁZIS 6 (a magyar nyelvű keresés) ← a FÁZIS 5 (a jelentés) + a SzotarHid_v2 + a MagyarNyelvtan
  ↓
FÁZIS 7 (a gráf bejárása) ← a FÁZIS 6 (a keresés) + a FÁZIS 1 (a Kan-kiterjesztés)
  ↓
FÁZIS 8 (a terv ráépítése) ← a FÁZIS 7 (a bejárás) + a SajatTodo_v1 (a 76 feladat)
  ↓
FÁZIS 9 (az alternatív útvonalak) ← a FÁZIS 7 + a FÁZIS 8
  ↓
FÁZIS 10 (a verifikáció) ← az összes
```

---

## D. A „5x HOSSZABB" KUTATÁS

A 76-feladatos lineáris terv → ~380 feladat (a hiányzó bizonyítások + a 6 ellenőrzés/feladat). A gráf FELTÁRJA ezt a bővülést — a felhasználó nem tudta előre, hogy 76 helyett ~380 feladat lesz. A gráf mutatja a vakvágányokat és a hiányokat.

---

## E. A HOROG ÉS A HARD RULE-OK

- §N5 (szóról-szóra, nincs tömörítés): ez a terv SZÓRÓL SZÓRA idézi a felhasználót
- §24 (kód-duplikáció tilos): a 16 külső könyvtár + a meglévő Idris-modulok mind IMPORTÁLANDÓK
- §N11 (olvass-előbb): a 3 tervdokumentum + a 4 kutatási napló szintézise
- §N12 (keress a neten): a 2 GAN + a 16 könyvtár keresése megtörtént
- §N13 (push): ez a terv push-olva
- §N14 (hat-szintű verifikáció): a FÁZIS 10 szerint
- A TODO módosítása CSAKIS Idrissel (a hard rule — a `SajatTodo_v1.idr` programmal)

---

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★