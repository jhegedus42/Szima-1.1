# KonyvKivonat_Idris — Bizonyítás-írás technikák

Kivonat forrásai:
- `trail_index/books/Idris_Tutorial_v1.3.4.txt` (3433 sor) — röviden: **Tutorial**
- `trail_index/books/idris2_docs/` — `theorems.rst`, `interactive.rst`, `typesfuns.rst`, `debugging.rst`, `index.rst`, `introduction.rst` — röviden: **Docs**

Cél: valódi, nem-tautologikus Refl-bizonyítások írása Idris 2-ben.

---

## 1. Bizonyítás-technikák szintaxisa

### 1.1 Az egyenlőség típus (=) szerkezete

Az egyenlőség konceptuálisan egy `data` deklaráció, EGYETLEN konstruktorral:

```idris
data (=) : a -> b -> Type where
  Refl : x = x
```

(Tutorial:2225-2226). A Docs-ban `Equal` néven szerepel, `x = y` jelölés-kényelem (theorems.rst:16-19).

**Kritikus megértés:** az egyenlőség bármely két érték közt FELÍRHATÓ, de csak akkor konstruálható, ha a két oldal **definíció szerint (számítással, azaz konverzióval) ugyanaz**. A típusellenőrzéskor a típus **normalizálódik** (theorems.rst:86): a kernel mindkét oldalt redukálja, és ha a redukált formák egyeznek, a `Refl` elfogadott.

Példák (Tutorial:2230-2233):

```idris
fiveIsFive : 5 = 5
fiveIsFive = Refl
twoPlusTwo : 2 + 2 = 4
twoPlusTwo = Refl        -- 2+2 és 4 redukálva egyezik
```

Ezért működik `plusReduces n = Refl` a `plus Z n = n` típusra: `plus Z n` definíció szerint `n`-re redukálódik (Tutorial:2267-2275, theorems.rst:92-106).

**A "nem-tautologikus" Refl kulcsa** (l. AGENTS.md tanulság): az állítás legyen KÉT KÜLÖNBÖZŐ RECEPT hídja, pl. `plusReduces : (n:Nat) -> plus Z n = n` — a bal oldal egy rekurzív függvény alkalmazása, a jobb oldal egy változó; a kernelnek munkát kell végeznie a redukcióval. A `KettoLegNev = 2`-féle csupasz-ismétlés üres.

### 1.2 Refl — csak definíciós egyenlőségre

```idris
plusReduces : (n:Nat) -> plus Z n = n
plusReduces n = Refl
```

(Tutorial:2267-2275). Ha az oldalak NEM redukálódnak ugyanarra, a hiba:

```
When unifying 4 = 4 and (fromInteger 2 + fromInteger 2) = (fromInteger 5)
Mismatch between: 4 and 5
```

(theorems.rst:43-48, a `twoPlusTwoBad : 2 + 2 = 5` eset).

### 1.3 cong — egyenlőség emelése függvénnyel

A `cong` kimondja, hogy az egyenlőség tiszteletben tartja a függvényalkalmazást (theorems.rst:123):

```idris
cong : (f : t -> u) -> a = b -> f a = f b
```

Klasszikus minta (theorems.rst:114-116, Tutorial:2279-2281):

```idris
plusReducesZ : (n:Nat) -> n = plus n Z
plusReducesZ Z     = Refl
plusReducesZ (S k) = cong S (plusReducesZ k)
```

Itt a rekurziós hívás ad `k = plus k Z`-t, a `cong S` pedig ezt `S k = S (plus k Z)`-ra emeli — és `S (plus k Z)` definíció szerint `plus (S k) Z`. **A bizonyítás szerkezete a függvény rekurzióját követi.**

Ugyanez két argumentummal (theorems.rst:145-147):

```idris
plusReducesS : (n:Nat) -> (m:Nat) -> S (plus n m) = plus n (S m)
plusReducesS Z     m = Refl
plusReducesS (S k) m = cong S (plusReducesS k m)
```

### 1.4 sym — az egyenlőség megfordítása

```idris
sym : l = r -> r = l
sym Refl = Refl
```

(Tutorial:2602-2604). A `rewrite`-tal együtt használjuk, amikor az IRÁNY nem stimmel (l. 1.5).

### 1.5 rewrite ... in — és az IRÁNY szabálya

`rewrite bizonyitas in kifejezes` a kívánt típust az egyenlőség-bizonyítás szerint átírja (theorems.rst:228).

A legfontosabb prelude-lemma: `plusSuccRightSucc : (left : Nat) -> (right : Nat) -> S (left + right) = left + S right` (theorems.rst:234).

Teljes, működő minta (theorems.rst:279-283):

```idris
helpEven : (j : Nat) -> Parity (S j + S j) -> Parity (S (S (plus j j)))
helpEven j p = rewrite plusSuccRightSucc j j in p
```

**Hogyan látjuk az irányt:** a rewrite előtt lyukat teszünk és `:t`-vel megnézzük (theorems.rst:237-272):

- rewrite előtt: `helpEven_rhs : Parity (S (S (plus j j)))`
- rewrite után a kontextusba bekerül `_rewrite_rule : S (plus j j) = plus j (S j)`, és a cél: `helpEven_rhs : Parity (S (plus j (S j)))`

Tehát: a `rewrite e in ...` a célban az `e` **bal oldalának** előfordulásait a **jobb oldalra** írja át. `S (S (plus j j))`-ben a `S (plus j j)` részt (ami a lemma bal oldala) lecseréli `plus j (S j)`-re.

**IRÁNY-szabály:** ha a lemmád épp a másik irányban áll, fordítsd meg `sym`-mel: `rewrite sym (plusSuccRightSucc j j)` (Tutorial:2597, 2680). A projekt AGENTS.md-je szerint is: **"rewrite — IRÁNYRA figyelni!"**

### 1.6 replace — egyenlőséggel predikátum-transzformáció (a disjoint-minta)

A negáció klasszikus Idris-bizonyítása (theorems.rst:62-67, Tutorial:2243-2248):

```idris
disjoint : (n : Nat) -> Z = S n -> Void
disjoint n prf = replace {p = disjointTy} prf ()
  where
    disjointTy : Nat -> Type
    disjointTy Z     = ()
    disjointTy (S k) = Void
```

Működés: a `prf : Z = S n` egyenlőséggel a `disjointTy Z = ()` (létező, az `()` értékkel megadott) típusból átírunk a `disjointTy (S n) = Void` típusba — a semmiből konstruáljuk a lehetetlent, tehát az egyenlőség sem létezhet. A `replace {p = ...}` a Docs-ban szerepel így; a Tutorial 1.3.4 ugyanezt `replace {P = disjointTy}` formában írja.

### 1.7 impossible / Void / void — negáció bizonyítása

- `Void` az ÜRES típus, nincs konstruktora → lehetetlen kanonikus elemet építeni (theorems.rst:55-57).
- `void : Void -> a` — ha már van egy `Void`-od, MINDENT bebizonyíthatsz (ellentmondásból következik bármi) (theorems.rst:79-81, Tutorial:2257-2259).
- A `disjoint` (1.6) az alapminta: `Z = S n -> Void`.
- A totality lényeges: részleges vagy nem termináló függvénnyel TILOS `Void`-ot építeni, mert akkor a logika összeomlik. A Docs két rossz példát mutat: `hd []` (részleges) és `empty2 = empty2` (nem terminál) — mindkettő `Void`-ot adna, és a `:total` parancs elkapja: "is not covering" illetve "possibly not terminating due to recursive path" (theorems.rst:306-327).
- Az `impossible` eseteket Idris 2-ben általában a típus szorítja ki (pl. `index`-nek nincs `Nil`-esete, mert `Fin Z` lakója nincs — Tutorial:555-557). A függvényben egyszerűen nem írunk ágat arra az esetre, amelyet a típus kizár.

### 1.8 Lyukak (?lyuk), :t, :doc, :ps

A `?nev` lyuk = befejezetlen rész (theorems.rst:269-287, Tutorial:415-441). A `:t lyuknev` megmutatja a KONtextust ÉS a célt:

```
 k : Nat
-----------------------------
help : k = (plus k Z)
```

(theorems.rst:136-139). **Ez a bizonyítás-írás fő munkaeszköze:** lyukat teszel, `:t`-vel megnézed, mit kell még bizonyítani, majd szűkíted.

Interactive editing parancsok (interactive.rst:66-224, Tutorial:2738-2831):

| Parancs | Rövidítés | Mit csinál |
|---|---|---|
| `:addclause n f` | `:ac n f` | függvény-váz `?f_rhs` lyukkal |
| `:casesplit n c x` | `:cs n c x` | a `x` mintaváltozó eseteire bont; az egyesíthetetlen (lehetetlen) eseteket ELDOBJA |
| `:addmissing n f` | `:am n f` | hiányzó (lefedő) esetek hozzáadása |
| `:proofsearch n f` | `:ps n f` | bizonyítás-keresés: lokális változókat, rekurzív hívásokat, a célcsalád konstruktorait próbálja; hint-listát is fogad |
| `:makewith n f` | `:mw n f` | `with`-klauzulát illeszt |
| `:t nev` | — | típus kérdezése |
| `:total nev` | — | totality ellenőrzése |

A `:ps` erejének példája: `vzipWith f [] [] = ?vzipWith_rhs_1`-re a keresés `[]`-t ad (az egyetlen 0 hosszú vektor), a nem-üres esetre pedig `f x y :: vzipWith f xs ys`-t — mert a típus olyan pontos, hogy csak egy program illik rá (interactive.rst:155-191). **Ez a projekt "a típus legyen annyira pontos, hogy a fordító írja a programot" elvének dokumentált alapja.**

`:t` REPL-ek kívülről is: `idris2 --client ':t plus'` (interactive.rst:54-64).

### 1.9 with és case bizonyításokban

A `with` közbülső értékre mintáz, ÉS — ez a kulcs — **a dependens eredmény finomíthatja a többi argumentum alakját** (Tutorial:2131-2194).

Példa a Parity-view-val (Tutorial:2164-2194):

```idris
data Parity : Nat -> Type where
  Even : Parity (n + n)
  Odd  : Parity (S (n + n))

natToBin : Nat -> List Bool
natToBin Z     = Nil
natToBin k with (parity k)
  natToBin (j + j)         | Even = False :: natToBin j
  natToBin (S (j + j))     | Odd  = True  :: natToBin j
```

A `|` bal oldalán a **finomított argumentum-minták** állnak (a view-konstruktor típusából: `Even : Parity (n+n)` → `k` finomodik `j+j`-re), a jobb oldalán a közbülső eredmény mintája. A `j` mindkét oldalon használható.

**`with ... proof p`** — a mintázás által generált BIZONYÍTÁS néven elérhető (Tutorial:2200-2213):

```idris
isFInt : (foo : Foo) -> Maybe (x : Int ** (optional foo = Just x))
isFInt foo with (optional foo) proof p
  isFInt foo | Nothing  = Nothing          -- itt p : Nothing = optional foo
  isFInt foo | (Just x) = Just (x ** Refl) -- itt p : Just x = optional foo
```

A `case` egyszerű, nem-dependens közbülső értékekhez való; KORLÁTOZÁSAI: minden ág azonos típusú értéket ad vissza, és az eredmény típusa a case-től függetlenül meghatározható kell legyen (Tutorial:1099-1104).

### 1.10 Dependent pairs (Sigma-típusok)

```idris
data DPair : (a : Type) -> (P : a -> Type) -> Type where
  MkDPair : {P : a -> Type} -> (x : a) -> P x -> DPair a P
```

Cukor: `(n : Nat ** Vect n Int)` típus, `(2 ** [3,4])` érték, `_`-tel kitaláltatva: `(_ ** [3, 4])` (Tutorial:902-945). A bizonyításban így csomagolunk "létezik x, hogy P x" állítást: `Just (x ** Refl)` (Tutorial:2213).

### 1.11 Eq interfész kézi implementálása

Interfész-deklaráció default definíciókkal (Tutorial:1194-1198):

```idris
interface Eq a where
  (==) : a -> a -> Bool
  (/=) : a -> a -> Bool
  x /= y = not (x == y)
  x == y = not (x /= y)
```

Minimális implementáció: **vagy** `==` **vagy** `/=` (Tutorial:1200-1202). Kézi implementáció `Nat`-ra (Tutorial:1178-1187):

```idris
Eq Nat where
  Z     == Z     = True
  (S x) == (S y) = x == y
  Z     == (S y) = False
  (S x) == Z     = False
  x /= y = not (x == y)
```

Szabályok: típusonként CSAK EGY implementáció lehet; az implementáció argumentuma konstruktor vagy változó lehet (függvény nem); konstraintekkel: `Show a => Show (Vect n a)` (Tutorial:1152-1158). **Figyelem:** ez a `==` BOOL egyenlőség — NEM a bizonyítások `=` típusa! A `Refl`-hez nem kell `Eq`; a kettőt soha ne keverjük. Több implementáció kell? Nevesített: `[myord] Ord Nat where` és használat `compare @{myord}` (Tutorial:1501-1513).

### 1.12 Provisional definitions (?=), szimmetrikus rewrite, trivial/exact taktikák

Amikor a cél-típus és a megírt kifejezés típusa PROVABLY egyenlő, de nem azonos normálformájú, `?=` helyettesíti az `=`-t — Idris lyukat (bizonyítási kötelezettséget) generál (Tutorial:2547-2566):

```idris
parity (S (S (j + j)))       | Even ?= Even {n=S j}
parity (S (S (S (j + j))))   | Odd  ?= Odd {n=S j}
```

A kötelezettségek listája: `:m` (global holes), típusuk `:p views.parity_lemma_1` (Tutorial:2568-2578). A bizonyítási szekvencia a taktikanyelvben (Tutorial:2586-2607):

```
compute                                    -- plus definíciójának kibontása
intros                                     -- argumentumok a kontextusba
rewrite sym (plusSuccRightSucc j j)        -- átírás, IRÁNY szerint megfordítva!
trivial                                    -- a cél megtalálása a premisszák közt
```

A `proof { intro; intro; exact ...; }` blokk-nyelv is elérhető (Tutorial:2630-2634). A `believe_me : a -> b` tetszőleges koerció, CSAK prototípushoz / külső C-kódhoz; a fordítóhoz KELL a teljes bizonyítás, bár a REPL nélküle is kiértékel (Tutorial:2615-2637).

### 1.13 trans — bizonyítás-láncolás

A docs itt nem mutat példát rá, de a `replace` és `rewrite` mögött ugyanaz a tranzitivitás-mechanizmus áll; az AGENTS.md eszköztára (Refl → cong → trans → rewrite) ebből a családból épül. `trans : a = b -> b = c -> a = c` — két egyenlőség összefűzése, amikor a `rewrite` nem elegendő.

### 1.14 A KISBETŰS-NÉV implicit kötés (shadowing) — a projekt csapdájának dokumentált forrása

Az Idris SZABÁLYA (typesfuns.rst:502-507, Tutorial:568-572):

> **Any name beginning with a lowercase letter that appears as a parameter or index in a type declaration, and which is not applied to any arguments, will always be automatically bound as an implicit argument.**

Ezért **nem kezdődhet adattípus neve kisbetűvel** (typesfuns.rst:506-507). A mechanizmus következménye (a projekt KisAI-csapdája): ha egy bizonyítás TÍPUSÁBAN kisbetűs definiált konstans áll (pl. `bizKetto : kettoLeg = 2`), az elaborátor azt friss implicit argumentumként köti — a definiált konstans helyett —, így a `Refl` nem redukálódik, és "shadowing" figyelmeztetés jön. **Gyógyítás: a bizonyítástípusokban nagybetűs név (vagy konstruktor-alkalmazás) álljon.** Futásidejű kódban a kisbetűs név szabad. (L. `osveny_index/tanulsagok/KisBetusProjekcioCsapda.idr`.)

Az implicit argumentumok explicit átadása: `{a=value}`, `{n=value}` (Tutorial:576), és a bal oldalon is mintázhatók: `isEmpty {n = Z} _ = True` (Tutorial:584-589). A `forall a, n .` forma Idris 2-ben ugyanezt fejezi ki (typesfuns.rst:497-501).

---

## 2. Hibák magyarázata

### 2.1 "Mismatch between / When unifying"

```idris
twoPlusTwoBad : 2 + 2 = 5
twoPlusTwoBad = Refl
-- When unifying 4 = 4 and (fromInteger 2 + fromInteger 2) = (fromInteger 5)
-- Mismatch between: 4 and 5
```

(theorems.rst:43-48). Jelentés: a `Refl` miatt a típusellenőrző a két oldalt egyesíteni próbálta, de a normálformák ELTÉRNEK. A projekt-nyelven: az állításod nem definíciós egyenlőség — hiányzik a lemma. A vektor-változat (Tutorial:505-520) megmutatja a teljes képét: `Type mismatch between plus k k and plus k m` — a hiba nemcsak a hibát, hanem az elvárt (`Expected type`) és a kapott (`Type of`) típust is kiírja; **a kettő különbsége mondja meg, melyik oldal a hibás**.

### 2.2 "Can't solve constraint between"

A `parity` naiv definíciójának hibája (theorems.rst:186-195):

```
Can't solve constraint between: plus j (S j) and S (plus j j)
```

Jelentés: a `with`-blokkban a kívánt típus `S (S (plus j j))`, a konstruktor (`Even`) pedig `S j + S j`-t ad — a kettő PROVABLY egyenlő, de NEM definíció szerint (a `plus` az ELSŐ argumentumán rekurzál, a `S j + S j` nem redukálódik tovább). **Gyógyítás: `rewrite plusSuccRightSucc j j`** (theorems.rst:225-283) vagy provisional `?=` (Tutorial:2557-2607). Ez A típushiba, amikor "tudjuk, hogy egyenlő, de a fordító nem számolja ki magától".

### 2.3 "is not covering / Missing cases"

```
frommaybe.idr:1:1--2:1:fromMaybe is not covering. Missing cases:
        fromMaybe Nothing
```

(typesfuns.rst:252-253). Jelentés: a minták nem fedik le az összes bemenetet. Idris 2-ben alapértelmezésben KÖTELEZŐ a covering (typesfuns.rst:238-240). Gyógyítás: add hozzá a hiányzó eseteket (`:am`), vagy — csak prototípusnál — `partial` annotáció (typesfuns.rst:255-264). A totality verziója: `:total empty1` → "not covering due to call to function empty1:hd" — a függvény AZÉRT nem totális, mert részleges függvényt hív (theorems.rst:322-327).

### 2.4 "possibly not terminating due to recursive path"

(theorems.rst:326-327, 2420-2423). A totality-checker nem lát csökkenő argumentumot a rekurziós láncban. Nem biztos, hogy tényleg nem terminál (a checker konzervatív, a halting-probléma eldönthetetlen — theorems.rst:329-333). Gyógyítás: `assert_smaller` a csökkenés elmagyarázására (theorems.rst:399-435: `qsort (assert_smaller (x :: xs) (filter (< x) xs))`), végső esetben `assert_total` (kerülendő — theorems.rst:441-448).

### 2.5 "Ambiguous elaboration" / kétértelmű nevek

A docs a mechanizmust mutatja, a hibát nem szó szerint: a konstruktor- és függvénynevek névterekben túlterhelhetők, a feloldás kontextusból történik — de ha a kontextus nem dönt, kétértelműség lép fel (typesfuns.rst:367-370, Tutorial:479-481, 800-804). A `testVec` példánál a Tutorial explicitté teszi: minősített név kell, `Main.testVec` (Tutorial:608-612). **Gyógyítás: minősített név (`Modul.nev`), nevesített implementáció (`@{myord}`), vagy a típus pontosítása.** A típusvezérelt projektben ez a leggyakoribb kétértelműségi forrás: ugyanaz a név több névtérben.

### 2.6 "Missing telescope"

Egyik beolvasott forrásban SEM szerepel — a docs nem dokumentálja. A terminológiából (a "telescope" az Idris-ben a típus implicit+explicit bindereinek lánca) a valószínű ok: egy nevet a kötelező implicit-argumentum-lista (a telescope) nélkül használtunk, vagy egy deklaráció fejlécéből hiányzik egy kötelező argumentum-réteg, amit az elaborátor nem tud kikövetkeztetni. Gyakorlati teendő: ellenőrizd, hogy a hivatkozott függvényt/konstruktort az ÖSSZES implicit argumentummal használod-e (`:t`-vel nézd meg a teljes típust, `:set showimplicits` a REPL-ben), és hogy a deklaráció típusa az összes szükséges bindert tartalmazza.

---

## 3. Tíz aranyszabály a Refl-bizonyításhoz

1. **A Refl csak definíciós egyenlőséget bizonyít.** A kernel mindkét oldalt normalizálja; ha a redukált formák nem azonosak, a Refl nem fogadható el (theorems.rst:86). Amit "tudsz, de nem redukálódik" — azt lemmával kell elmondani.

2. **A bizonyítás rekurziója a függvény rekurzióját tükrözi.** `plus` az első argumentumán rekurzál → a `plusReducesZ` bizonyítás is `n`-en, `Z`-ágra `Refl`, `(S k)`-ágra `cong S (plusReducesZ k)` (theorems.rst:114-116).

3. **Lyukkal és `:t`-vel dolgozz, ne fejben.** Tedd a `?lyuk`-at a bizonyításba, `:t lyuk` megmutatja a kontextust és a maradék célt; így lépésről lépésre szűkíthető (theorems.rst:128-139, 244-272). A "batch mode" bizonyítás-írás a docs szerint is csak triviális tételekig megy (theorems.rst:149-156).

4. **A rewrite irányát a lyuk típusa dönti el.** `rewrite e in p` a célban az `e` bal oldalát írja jobbra; a kontextusba kerülő `_rewrite_rule` megmutatja, melyik irány érvényes (theorems.rst:263-272). Fordított irány kell? `rewrite sym (...)` (Tutorial:2597).

5. **A `with` finomítja az argumentum-mintákat — a bizonyítási célok is finomodnak.** `with (parity k)` után a cél `k` helyett `j + j` / `S (j + j)` alakú lesz; a fennmaradó eltérés a "Can't solve constraint" hiba, amit `rewrite plusSuccRightSucc` old meg (theorems.rst:186-283). A `proof p` kulcsszóval maga a finomítási bizonyítás is kézbe vehető (Tutorial:2209-2213).

6. **A lehetetlent a `Void`-dal és a disjoint-mintával bizonyítsd.** `Z = S n -> Void` a `replace {p = disjointTy} prf ()` mintával, ahol a predikátum az egyik indexen `()`, a másikon `Void` (theorems.rst:62-67). Innentől `void : Void -> a` bármit ad.

7. **Bizonyítás CSAK totális függvényben lakhat.** A részleges `hd []` vagy a nem-termináló `empty2` triviálisan `Void`-ot konstruál → a logika összeomlik. A `:total` parancs az őr; bizonyításokra `%default total` (vagy `total` kulcsszó) a jó gyakorlat (theorems.rst:300-345, 375-381). A totality-checker konzervatív; `assert_smaller`-rel lehet neki segíteni (theorems.rst:399-435).

8. **A bizonyítás TÍPUSÁBAN nagybetűs név álljon.** A kisbetűs név típusban automatikus implicit argumentummá válik (typesfuns.rst:502-507), a `Refl` nem redukálódik, shadowing-figyelmeztetés jön. Nagybetűs konstansnév (vagy konstruktor-alkalmazás) a típusban, kisbetűs definíció futásidejű kódban maradhat (l. 1.14).

9. **A típus legyen olyan pontos, hogy csak egy érték illik rá — akkor a `:ps` megírja helyetted.** `:proofsearch` (`:ps`) lokális változókat, rekurzív hívásokat és konstruktorokat próbál; a `vzipWith` esetén az egyetlen lehetséges programot adja vissza (interactive.rst:155-191). Ez a projekt "a fordító írja a programot" elvének dokumentált működése.

10. **A "bizonyítva" szó annyit jelent, amennyit a típus mond.** Curry-Howard: a bizonyítás = pontos típusú program, semmi több (theorems.rst:94-98). A tautologikus `E8Beirva = 240` üres; az érték KÉT független recept hídjában van (`plusReduces : plus Z n = n` — függvény-alkalmazás az egyik, változó a másik oldalon). Amit a Refl ellenőriz, az a receptek egyezése; amit jelent, azt a numerika és az irodalom fedezi (AGENTS.md, "mit bizonyít a Refl").
