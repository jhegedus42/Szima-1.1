# Idris2-ben bizonyítás — RÉSZLETES összefoglaló

**Dátum:** 2026-08-31
**Források:** `trail_index/books/idris2_docs/theorems.rst`, `interactive.rst`, `osveny_index/Alap/DependensSzamT.idr`, `Steane713Dependent.idr`, `KostantFelbontás.idr`, `Torusz.idr`, `KategóriaElmélet64.idr`, `K_E9_Idr.idr`, `LegkisebbMuvelet/IngyenesTetelek.idr`, `AGENTS.md` §7, §16, §18.

**A felhasználó kérdése (szó szerint):** „A feladat: olvasd el az alábbi fájlokat és készíts egy RÉSZLETES összefoglalót arról, hogyan kell Idris2-ben BIZONYÍTANI. Az összefoglaló magyarul, ékezetesen legyen (nincs tömörítés, szó szerint, minden részlettel)."

---

## 0. A Curry–Howard izomorfizmus — az alap

A hivatalos Idris2 dokumentáció (`theorems.rst` 100–102. sor) kimondja: **a bizonyítás és a program között nincs valódi különbség**. A Curry–Howard-korrespondencia szerint egy állítás típus, a bizonyítás pedig ennek a típusnak egy értéke. Ahogy a dokumentáció fogalmaz (95–98. sor): „A proof, as far as we are concerned here, is merely a program with a precise enough type to guarantee a particular property of interest" — tehát egy bizonyítás egyszerűen egy olyan program, amelynek típusa elég pontos egy adott tulajdonság garantálásához.

Példa a dokumentációból (92–106. sor):
```idris
plusReduces : (n:Nat) -> plus Z n = n
plusReduces n = Refl
```
Itt az állítás típusa: bármely `n : Nat`-ra `plus Z n = n`. A bizonyítás az érték: `Refl`. A típusellenőrző a `plus Z n` kifejezést redukálja, és mivel `plus Z n` definíció szerint (a `plus` rekurziója az első argumentumon) `n`-re redukálódik, a két oldal egyezik, és a `Refl` átmegy.

---

## 1. A Refl taktika

### 1.1 Mit bizonyít a Refl?

A `Refl` a `Equal` (egyenlőség) adattípus egyetlen konstrukora. A definíció a Prelude-ben (`theorems.rst` 16–19. sor):
```idris
data Equal : a -> b -> Type where
     Refl : Equal x x
```
Notációs kényelem szerint az `Equal x y` írható `x = y`-ként. A `Refl : Equal x x` jelentése: **a `Refl` csak akkor konstruálható, ha a két oldal definíció szerint megegyezik** (definitional equality). Egyenlőségek bármely típusú értékek között felállíthatók, de a konkrét bizonyítást csak akkor lehet megadni, ha az értékek tényleg egyenlők.

### 1.2 Mikor működik (definitional equality)?

A `Refl` akkor működik, ha a típusellenőrző a bizonyítás típusának mindkét oldalát ki tudja számolni (normalizálni), és a kettő megegyezik. A függvények definíció szerint redukálódnak — például a `plus Z n` definíció szerint `n`-re redukálódik, mert a `plus` az első argumentum szerinti rekurzióval van definiálva.

Példák a hivatalos dokumentációból (`theorems.rst` 24–30. sor):
```idris
fiveIsFive : 5 = 5
fiveIsFive = Refl

twoPlusTwo : 2 + 2 = 4
twoPlusTwo = Refl
```
Mindkettő azonnal átmegy, mert `5` definíció szerint `5`, és `2 + 2` redukálódik `4`-re.

Példák a meglévő projekt-kódból:

`Alap/DependensSzamT.idr` (50–56. sor):
```idris
uresVektorHosszBizonyitas : vektorHossz UresVektor = 0
uresVektorHosszBizonyitas = Refl

egyKubitHosszBizonyitas : vektorHossz (Kombinalt NullaD UresVektor) = 1
egyKubitHosszBizonyitas = Refl
```
A `vektorHossz UresVektor` definíció szerint `0` (a `vektorHossz` első klauzája), a `vektorHossz (Kombinalt NullaD UresVektor)` pedig `S (vektorHossz UresVektor)` = `S 0` = `1`.

`Steane713Dependent.idr` (50–56. sor):
```idris
uresVektorHossz : vektorHossz UresVektor = 0
uresVektorHossz = Refl

egyKubitHossz : vektorHossz (Kombinalt NullaD UresVektor) = 1
egyKubitHossz = Refl
```

`Torusz.idr` (68–71. sor) — az involúció bizonyítása (`X² = I`):
```idris
bizPozícióVáltásInvolúció : (p : Pozíció) -> pozícióVáltás (pozícióVáltás p) = p
bizPozícióVáltásInvolúció Pozíció0 = Refl
bizPozícióVáltásInvolúció Pozíció1 = Refl
```
Itt a `pozícióVáltás` mindkét konstruktora külön van kezelve. A `pozícióVáltás (pozícióVáltás Pozíció0)` redukálódik: `pozícióVáltás Pozíció0 = Pozíció1`, majd `pozícióVáltás Pozíció1 = Pozíció0`, tehát a végeredmény `Pozíció0`, ami megegyezik a baloldallal. A `Refl` átmegy.

`KostantFelbontás.idr` (68–70. sor):
```idris
bizKostantFelbontásE8 : kostantFelbontásÖssge = E8Dimenzió
bizKostantFelbontásE8 = Refl
```
Ahol `kostantFelbontásÖssgege = So8Dimenzió + So8Dimenzió + Blokk64Dimenzió + Blokk64Dimenzió + Blokk64Dimenzió = 28 + 28 + 64 + 64 + 64 = 248`, és `E8Dimenzió = 248`. A típusellenőrző mindkét oldalt kiszámolja Nat-ként, és egyezést talál.

`KostantFelbontás.idr` (143–146. sor) — a triality T³=1 bizonyítása (három konstruktor, három Refl):
```idris
bizTrialityHarmadik : (r : Rep8) -> triality (triality (triality r)) = r
bizTrialityHarmadik VektorRep     = Refl
bizTrialityHarmadik PozitívSpinor = Refl
bizTrialityHarmadik NegatívSpinor = Refl
```
Mivel a `triality` egy véges enumeráció három elemén van definiálva, minden esetre külön `Refl` adható. A `triality VektorRep = PozitívSpinor`, `triality PozitívSpinor = NegatívSpinor`, `triality NegatívSpinor = VektorRep`, tehát háromszor alkalmazva visszakapjuk az eredetit.

### 1.3 Mikor NEM működik a Refl?

Ha a két oldal nem redukálódik azonos formára. A dokumentáció példája (`theorems.rst` 34–48. sor):
```idris
twoPlusTwoBad : 2 + 2 = 5
twoPlusTwoBad = Refl
```
Hiba:
```
When unifying 4 = 4 and (fromInteger 2 + fromInteger 2) = (fromInteger 5)
Mismatch between:
        4
and
        5
```
A típusellenőrző a baloldalt `4`-re redukálja, a jobboldalt `5`-re, és nem egyeznek.

A Refl akkor is elbukik, ha a függvény nem az első argumentum szerint redukál. Például `plus n Z` nem redukálódik `n`-re (a `plus` az első argumentum szerint rekurzív, és `n` változó, nem konkrét érték), ezért:
```idris
plusReducesZ : (n:Nat) -> n = plus n Z
plusReducesZ Z = Refl     -- ez megy: plus Z Z = Z
plusReducesZ (S k) = ...  -- ez NEM megy Refl-lel, mert plus (S k) Z nem redukálódik (S k)-ra közvetlenül
```
Ilyenkor `cong` kell (l. §3).

---

## 2. A rewrite taktika

### 2.1 Hogyan működik?

A `rewrite ... in ...` szintaxis lehetővé teszi a céltípus átiratát egy egyenlőségi bizonyítás (equation proof) alapján. A dokumentáció (`theorems.rst` 228–230. sor): „The `rewrite ... in` syntax allows you to change the required type of an expression by rewriting it according to an equality proof."

Pontosabban: ha van egy bizonyítás `prf : x = y`, akkor `rewrite prf in kifejezes` a kifejezés típusában minden előforduló `x`-et `y`-ra cserél (a baloldalt a jobboldalra). **Az irány számít**: a `rewrite` a baloldalt helyettesíti a jobboldallal.

### 2.2 A `rewrite sym ... in ...` (irány!)

Ha az egyenlőség iránya nem megfelelő, a `sym`-mel megfordítható (l. §5). Tehát `rewrite sym prf in kifejezes` a `prf : x = y` egyenlőséget `y = x`-ként használja, és a `y`-t helyettesíti `x`-re.

### 2.3 Példa a hivatalos dokumentációból — a `parity` függvény

A `theorems.rst` 220–291. sora a legkiterjedtebb `rewrite` példa. A probléma: a `parity` függvény definíciója típushibát okoz, mert `S j + S j` nem redukálódik `S (S (plus j j))`-re. A megoldás: egy segédfüggvény, amely `rewrite`-tal átirja a típust.

A kulcsfontosságú segédfüggvény (`theorems.rst` 279–280. sor):
```idris
helpEven : (j : Nat) -> Parity (S j + S j) -> Parity (S (S (plus j j)))
helpEven j p = rewrite plusSuccRightSucc j j in p
```
Ahol `plusSuccRightSucc` típusa (`theorems.rst` 234. sor):
```idris
plusSuccRightSucc : (left : Nat) -> (right : Nat) -> S (left + right) = left + S right
```
Tehát `plusSuccRightSucc j j : S (j + j) = j + S j`. A `rewrite` ezt alkalmazza: a céltípusban (`Parity (S (S (plus j j)))`) a `S (plus j j)` (ami `S (j + j)` redukált alakja) helyébe `j + S j` = `plus j (S j)` kerül. Így a céltípus `Parity (S (plus j (S j)))` lesz, ami megegyezik a `p` típusával (`Parity (S j + S j)` = `Parity (S (plus j (S j)))`).

A dokumentáció lépésről lépésre bemutatja (`theorems.rst` 240–273. sor): ha a jobboldalt lyukkal helyettesítjük, és megnézzük a lyuk típusát `:t helpEven_rhs`, akkor látszik az átirat hatása:
```
   j : Nat
   p : Parity (S (plus j (S j)))
-------------------------------------
helpEven_rhs : Parity (S (plus j (S j)))
```
A `p` típusa és a lyuk típusa egybeesett — a `rewrite` megtette a dolgát.

### 2.4 A projektben nincs `rewrite` — ez tanulság

A projekt Idris fájljai (`DependensSzamT.idr`, `Steane713Dependent.idr`, `KostantFelbontás.idr`, `Torusz.idr`) **egyáltalán nem használnak `rewrite`-ot**. Minden bizonyítás `Refl`. Ez azért van, mert a projektfájlok úgy vannak felépítve, hogy a típusok már redukálódjanak — nem kell átirat. Ahol a hivatalos dokumentáció `rewrite`-ot használna (pl. `plus n Z`), ott a projekt vagy más struktúrát választ, vagy `cong`-ot, vagy egyszerűen olyan értékeket bizonyít, amelyek definíció szerint redukálódnak.

Ez fontos tanulság: **a `rewrite` akkor kell, ha a típusellenőrző nem tudja magától redukálni a kifejezést, és kézzel kell megadni az átiratot.** Ha a kód úgy van írva, hogy a redukció egyértelmű, a `Refl` elegendő.

---

## 3. A cong taktika

### 3.1 Hogyan működik?

A `cong` egy könyvtári függvény, amely kimondja, hogy az egyenlőség tiszteletben tartja a függvényalkalmazást. A definíció (`theorems.rst` 123. sor):
```idris
cong : (f : t -> u) -> a = b -> f a = f b
```
Tehát ha `a = b` (van rá bizonyítás), és `f : t -> u` egy függvény, akkor `cong f (a=b_bizonyitas) : f a = f b`. A `cong` „felemeli" az egyenlőséget a függvényen keresztül: ha az inputok egyenlők, az outputok is egyenlők.

### 3.2 Mikor kell használni?

Amikor a bizonyítás az indukciós lépésben egy konstruktorral van körülvéve, és a `Refl` közvetlenül nem működik, mert a redukció megakad a konstrukoron.

### 3.3 Példa a hivatalos dokumentációból — `plusReducesZ`

A `theorems.rst` 114–116. sora:
```idris
plusReducesZ : (n:Nat) -> n = plus n Z
plusReducesZ Z = Refl
plusReducesZ (S k) = cong S (plusReducesZ k)
```
Az első klauzában `plus Z Z = Z` redukálódik, `Refl` megy. A második klauzában a cél `(S k) = plus (S k) Z`. A `plus (S k) Z` nem redukálódik `S k`-ra (a `plus` az első argumentum szerint rekurzív, de `Z` a második argumentum). Viszont az indukciós feltételezés `plusReducesZ k : k = plus k Z`. Ha ezt „felemeljük" az `S` konstruktorral: `cong S (plusReducesZ k) : S k = S (plus k Z)`. És `S (plus k Z)` redukálódik `plus (S k) Z`-re (a `plus` második klauzála: `plus (S k) Z = S (plus k Z)`). Tehát a cél teljesül.

Ugyanez a minta a `plusReducesS` esetében (`theorems.rst` 145–147. sor):
```idris
plusReducesS : (n:Nat) -> (m:Nat) -> S (plus n m) = plus n (S m)
plusReducesS Z m = Refl
plusReducesS (S k) m = cong S (plusReducesS k m)
```

### 3.4 Példa a dokumentációból — a lyuk vizsgálata

A `theorems.rst` 125–139. sora bemutatja, hogyan lehet a `cong` helyett lyukat tenni és megnézni a típusát:
```idris
plusReducesZ (S k) = cong S ?help
```
A `:t help` parancs kiadja:
```
   k : Nat
-------------------------------------
help : k = (plus k Z)
```
Tehát a lyuk típusa pontosan az indukciós hipotézis — a `cong S` „leveszi" az `S`-t a célról.

### 3.5 A projektben nincs `cong`

A projekt Idris fájljai nem használnak `cong`-ot. Ennek oka: a projektfájlok nem bizonyítanak rekurzív aritmetikai tételeket (mint `n = plus n Z`), hanem konkrét értékeket (pl. `7 + 1 = 8`, `28 + 28 + 64 + 64 + 64 = 248`), amelyek `Refl`-lel azonnal bizonyíthatók. Ahol rekurzió van (pl. `bizTrialityHarmadik`), ott a véges enumeráció minden konstruktorára külön `Refl` adható, mert a `triality` nem rekurzív függvény, hanem véges permutáció.

---

## 4. A trans taktika

### 4.1 Hogyan működik (bizonyítás-lánc)?

A `trans` az egyenlőség tranzitivitása: ha `a = b` és `b = c`, akkor `a = c`. A `trans` típusa a Prelude-ben:
```idris
trans : (0 _ : a = b) -> (0 _ : b = c) -> a = c
```
A két bizonyítást láncba fűzi. A köztes lépés (`b`) köti össze a két véget.

### 4.2 Mikor kell használni?

Amikor a `Refl` nem elég, és nem is egyetlen `cong` lépés oldja meg, hanem több lépéses lánc kell. Például: `a = b` (bizonyítva), `b = c` (bizonyítva), cél `a = c` → `trans (a=b) (b=c)`.

### 4.3 A projektben nincs `trans`

A projekt Idris fájljai nem használnak `trans`-t. Ugyanaz az oka, mint a `cong` esetében: a bizonyítások konkrét értékekre vonatkoznak, amelyek egy lépésben redukálódnak. Az AGENTS.md §16.5 (334–336. sor) azonban felsorolja az eszköztárt: „Refl (kiszámolt egyezés) → cong (függvény emeli) → trans (bizonyítás-lánc) → rewrite (behelyettesítés; IRÁNYRA figyelni!) → ?lyuk + `:ps` proof search (interaktív)."

---

## 5. A sym taktika

### 5.1 Hogyan működik (egyenlőség megfordítása)?

A `sym` megfordítja az egyenlőség irányát: ha `a = b`, akkor `b = a`. A Prelude-ben:
```idris
sym : (0 _ : a = b) -> b = a
```

### 5.2 Mikor kell használni?

1. Amikor egy bizonyításunk van `a = b` alakban, de a cél `b = a`.
2. Amikor a `rewrite` irányát kell megfordítani: `rewrite sym prf in ...` (l. §2.2).

### 5.3 A projektben nincs `sym`

A projekt Idris fájljai nem használnak `sym`-et. A bizonyítások mindig olyan irányban vannak felírva, ahogy a `Refl` megköveteli.

---

## 6. Az interaktív proof mode

### 6.1 A lyukak (`?lyuk`) és kitöltésük

A lyuk (hole) egy még ki nem töltött rész a programban. Szintaxis: `?lyukNév`. A típusellenőrző a lyukat egy függőben lévő céltípusként kezeli, és megmondja, mit kell oda írni.

Példa a dokumentációból (`theorems.rst` 128–131. sor):
```idris
plusReducesZ (S k) = cong S ?help
```
Itt `?help` egy lyuk. A `:t help` parancs kiadja a lyuk típusát és a kontextust (a lokális változókat):
```
   k : Nat
-------------------------------------
help : k = (plus k Z)
```

### 6.2 A `:t` (type) parancs

A `:t név` parancs megmutatja egy név típusát. Ha a név egy lyuk, akkor a kontextussal együtt jeleníti meg a céltípust. A Vim módban a `\t` billentyűkombináció ugyanezt csinálja (`interactive.rst` 250–252. sor).

### 6.3 A `:ps` (proof search) parancs

A `:ps n f` parancs (proof search) megpróbálja automatikusan kitölteni a lyukat. A dokumentáció (`interactive.rst` 156–191. sor): „attempts to find a value for the hole `f` on line `n` by proof search, trying values of local variables, recursive calls and constructors of the required family." Opcionálisan megadhatók hint-ek (függvények, amelyeket megpróbálhat alkalmazni).

Példa (`interactive.rst` 165–191. sor): ha a kód:
```idris
vzipWith : (a -> b -> c) ->
           Vect n a -> Vect n b -> Vect n c
vzipWith f [] [] = ?vzipWith_rhs_1
vzipWith f (x :: xs) (y :: ys) = ?vzipWith_rhs_2
```
Akkor `:ps 96 vzipWith_rhs_1` eredménye:
```idris
[]
```
(mert a `Vect 0 c` egyetlen eleme az üres vektor). És `:ps 97 vzipWith_rhs_2` eredménye:
```idris
f x y :: vzipWith f xs ys
```
(mert a típus eléggé pontos: a result nem lehet üres, az első elem típusa `c`, csak `f x y` adhatja, a farok rekurzívan épül).

### 6.4 Egyéb interaktív parancsok

- `:addclause` (`:ac n f`): sablon-definíciót generál (`interactive.rst` 69–96. sor).
- `:casesplit` (`:cs n c x`): pattern-változót felbont az esetekre (`interactive.rst` 98–130. sor).
- `:addmissing` (`:am n f`): hiányzó klauzákat ad hozzá (`interactive.rst` 132–153. sor).
- `:makewith` (`:mw n f`): `with` klauzát ad (`interactive.rst` 193–224. sor).

Vim módban (`interactive.rst` 226–256. sor):
- `\a` = addclause
- `\c` = casesplit
- `\m` = addmissing
- `\w` = makewith
- `\s` = proofsearch
- `\t` = típus megmutatása
- `\e` = kifejezés kiértékelése
- `\r` = újratöltés + típusellenőrzés

### 6.5 A proof state

Amikor egy lyuk van, a proof state = (1) a lokális kontextus (változónevek és típusaik), (2) a céltípus (amit a lyuknak ki kell töltenie). A `:t` parancs ezt jeleníti meg. A proof search (`:ps`) ezt a state-et használja: végignézi a lokális változókat, a rekurzív hívásokat, és a konstruktort, hogy melyik illeszkedik a céltípusra.

---

## 7. A Void és az impossible

### 7.1 A Void típus

A `Void` egy üres típus — nincsenek konstruktorai. Ezért lehetetlen kanonikus elemet konstruálni belőle. A dokumentáció (`theorems.rst` 55–58. sor): „There is an empty type, `Void`, which has no constructors. It is therefore impossible to construct a canonical element of the empty type."

A `Void` használatával bizonyítható, hogy valami lehetetlen. Példa a dokumentációból (`theorems.rst` 62–73. sor) — a nulla sosem egyenlő egy utóddal:
```idris
disjoint : (n : Nat) -> Z = S n -> Void
disjoint n prf = replace {p = disjointTy} prf ()
  where
    disjointTy : Nat -> Type
    disjointTy Z = ()
    disjointTy (S k) = Void
```
Itt a `replace` függvényt használjuk (l. §8): a `prf : Z = S n` egyenlőséget alkalmazva egy `()` értékre (amely a `disjointTy Z = ()` típusú), átalakítjuk `disjointTy (S n) = Void` típusúvá. Mivel a `prf` azt mondja, hogy `Z = S n`, a `replace` „cseréli" a típust. De mivel `Z` és `S n` sosem egyenlőek, a `prf` valójában nem konstruálható — ez a bizonyítás lényege.

### 7.2 A `void` függvény — bizonyítás ellentmondásból

A `void` könyvtári függvény (`theorems.rst` 79–81. sor):
```idris
void : Void -> a
```
Ha van egy `Void` elemünk, abból BÁRMIT ki lehet vezetni (ex falso quodlibet). Ez a bizonyítás ellentmondásból (proof by contradiction) alapja.

### 7.3 Az `impossible` kulcsszó

Az `impossible` kulcsszó akkor használható, amikor egy klauza baloldala olyan típusú, amelyet lehetetlen konstruálni — tehát a jobboldal sosem kerül kiértékelésre. A típusellenőrző ellenőrzi, hogy a baloldali minta valóban elérhetetlen-e.

Példa a projektből — `KategóriaElmélet64.idr` (568–570. sor):
```idris
yonedaNonEmpty : (a : YonedaObj) -> Not (hom a a = False)
yonedaNonEmpty YA Refl impossible
yonedaNonEmpty YB Refl impossible
```
Itt a cél `Not (hom a a = False)`, ami az `hom a a = False -> Void` függvény. A `Refl` a paraméter — az a feltételezés, hogy `hom a a = False`. De `hom YA YA = True` (definíció szerint), tehát `hom YA YA = False` sosem teljesülhet. A `Refl`-ként adott argumentum tehát elérhetetlen, és a `impossible` kulcsszó jelzi ezt. A típusellenőrző megerősíti: ha `hom YA YA` és `False` nem egyeznek meg, akkor a `Refl` minta nem illeszkedik, így a klauza elérhetetlen — az `impossible` jogos.

Ez a minta általános: `Not (P)` = `P -> Void`, és ha `P` maga egy egyenlőség `x = y` ahol `x` és `y` nem egyeznek, akkor a `Refl` argumentum lehetetlen, és `impossible` használható.

---

## 8. A replace és a dependens típusok

### 8.1 A `replace` függvény

A `replace` függvény a Prelude-ben egy egyenlőségi bizonyítást használ egy predikátum átalakítására. A típusa (koncepcionálisan):
```idris
replace : (0 _ : x = y) -> (p : a -> Type) -> p x -> p y
```
Azaz: ha `x = y` (bizonyítva), és van egy `p x` értékünk, akkor kaphatunk `p y`-t. A `p` egy predikátum (függvény `a -> Type`), és a `replace` „átviszi" az értéket az `x`-típusból a `y`-típusba.

### 8.2 Hogyan használjuk dependens típusoknál?

A `replace` akkor hasznos, amikor egy dependens típusban (ahol a típus egy értéktől függ) az értéket cserélni kell egy egyenlőségi bizonyítás alapján. A `disjoint` példa (`theorems.rst` 62–73. sor, l. §7.1) pontosan ezt mutatja: a `disjointTy` predikátum `Z`-re `()`-t, `S k`-ra `Void`-ot ad. A `replace {p = disjointTy} prf ()` a `()` értéket (amely `disjointTy Z` típusú) átalakítja `disjointTy (S n)` = `Void` típusúvá, a `prf : Z = S n` segítségével.

### 8.3 A `rewrite` a `replace` szintaktikus cukra

A `rewrite` valójában a `replace`-t implementálja, csak kényelmesebb szintaktikával. Amikor `rewrite prf in kifejez`-t írunk, a fordító valójában egy `replace`-en alapuló átiratot végez. Ezért a `rewrite` irányára figyelni kell (l. §2): a `replace` az `x = y` alapján `p x`-ből `p y`-t csinál, tehát az `x`-et helyettesíti `y`-jal.

---

## 9. A tautológia csapda (AGENTS.md §16/§18)

### 9.1 Mi az a tautológia (`X = X`)?

A tautológia egy olyan bizonyítás, ahol a definíció és az állítás megegyezik — nincs közöttük távolság. Az AGENTS.md §16.2 (321–324. sor) így fogalmaz: „Köröző (tautologikus) bizonyítás nulla információ. `E8Beirva = 240` + `E8Beirva = 240` bizonyítás — üres. Az érték a DEFINÍCIÓ és az ÁLLÍTÁS közti távolságban van."

### 9.2 Miért nulla információ?

Mert a típusellenőrző a bizonyítás típusának mindkét oldalát kiszámolja, és ha a definíció és az állítás megegyezik, akkor a `Refl` triviálisan átmegy — nem mond semmit a világról. A kernel nem tud megtéveszteni, de nem is tud semmit bizonyítani, ha a két oldal azonos.

Példa a tautológiára (a projektben lévő rossz minta): ha `E8Beirva = 240` a definíció, és a bizonyítás `E8Beirva = 240`, az üres.

### 9.3 A jó minta (KÉT független út, egy híd)

Az AGENTS.md §16.3 (325–329. sor) leírja a jó mintát: „A legjobb minta: KÉT független út, egy híd. `BizOktonionEgyenloE8 : OktonionEgysegekSzama = E8GyokokSzama` — két fogalmilag különböző konstrukció (16+224 oktonion egységek vs 112+128 rács-gyökök) kényszerítve, hogy ugyanarra fusson. Bármelyik oldal átírása a hidat automatikusan töri."

Tehát a jó bizonyítás:
1. **Két fogalmilag különböző konstrukció** ugyanarra a céltípusra.
2. **Egy híd** (egyenlőség), amely a kettőt összeköti.
3. Ha bármelyik oldalt átírják, a híd automatikusan megtörik — a típusellenőrző elbukik.

### 9.4 Példák a projektből

**Tautológiák** (a projektben lévő gyenge bizonyítások):

`Torusz.idr` (123–130. sor) — ezek tautológiák:
```idris
bizTóruszPontokSzáma : 16 = 16
bizTóruszPontokSzáma = Refl

bizTóruszCl4Penge : 16 = 16
bizTóruszCl4Penge = Refl
```
A `16 = 16` tautológia — a két oldal azonos, a `Refl` triviálisan átmegy, de nulla információt hordoz. Helyesebb lenne: `bizTóruszPontokSzáma : 2 * 8 = 16` (ahol a baloldal strukturált: `2 * 8`, a jobboldal konkrét: `16` — a távolság a szorzás redukciója).

**Valódi bizonyítások** (strukturált baloldal, konkrét jobboldal):

`KostantFelbontás.idr` (68–70. sor) — ez valódi:
```idris
bizKostantFelbontásE8 : kostantFelbontásÖssge = E8Dimenzió
bizKostantFelbontásE8 = Refl
```
A baloldal `kostantFelbontásÖssge = So8Dimenzió + So8Dimenzió + Blokk64Dimenzió + Blokk64Dimenzió + Blokk64Dimenzió = 28 + 28 + 64 + 64 + 64` — strukturált. A jobboldal `E8Dimenzió = 248` — konkrét. A távolság az összeg kiszámolása.

`KostantFelbontás.idr` (91–92. sor) — valódi:
```idris
bizHáromBlokkPluszTengely : háromBlokkÖsszege + tengelyDimenzió = E8Dimenzió
bizHáromBlokkPluszTengely = Refl
```
Balfeloldal: `3 * 64 + (28 + 28)` = `192 + 56` — strukturált. Jobboldal: `248`. A távolság a számtani.

**KÉT független út, egy híd** — a projektben ez a minta:

`KostantFelbontás.idr` (102–115. sor) — a 64 három független úton bizonyítva:
```idris
biz64Tenzorszorzat : Blokk64Dimenzió = 8 * 8
biz64Tenzorszorzat = Refl

biz64KetHatvány : Blokk64Dimenzió = 2 * 2 * 2 * 2 * 2 * 2
biz64KetHatvány = Refl

biz64FelEgeszgyökFele : Blokk64Dimenzió = 128 `div` 2
biz64FelEgeszgyökFele = Refl
```
A `Blokk64Dimenzió = 8 * 8` (tenzorszorzat), `= 2⁶` (stabilizátor-állapotok), `= 128/2` (pozitív kamara) — három fogalmilag különböző konstrukció, mind 64-re fut. Ha bármelyik definíciót átírják (pl. `8 * 8` → `9 * 9`), a bizonyítás automatikusan megtörik. Ez a jó minta.

Ugyanez a `bizHid` (`KostantFelbontás.idr` 299–300. sor):
```idris
bizHid : hídÖsszeg = Cl8Dimenzió
bizHid = Refl
```
Ahol `hídÖsszeg = 240 + 16` (E8-gyökök + Cl(4)-pengék) és `Cl8Dimenzió = 256`. Két különböző fogalom (gyökök+pengék vs. Clifford-algebra dimenzió) egy hídon.

---

## 10. A kisbetűs név csapda (AGENTS.md §7, az "Idris 2 csapda" szekció)

### 10.1 Mi a probléma a kisbetűs névvel a bizonyítás típusában?

Az AGENTS.md (265–274. sor) leírja: ha egy felső szintű deklaráció TÍPUSÁBAN csupasz kisbetűs definiált név áll (pl. `bizKetto : kettoLeg = 2`), az Idris 2 elaborátora azt automatikusan új implicit argumentumként köti be („shadowing" figyelmeztetés), és a `Refl` nem redukálódik. A nagybetűs konstansnév jó: `bizNagy : KettoLegNev = 2` átmegy.

### 10.2 Miért történik ez?

Az Idris 2 elaborátor a kisbetűs neveket a típusban implicit paraméterekként próbálja megkötni, ha azok nem találhatók a kontextusban explicit konstansokként. Ez „shadowing" figyelmeztetést ad, és a bizonyítás típusa megváltozik: a kisbetűs név egy friss implicit argumentummá válik, amely bármilyen értéket felvehet, így az egyenlőség sosem redukálódik.

### 10.3 Hogyan javítható (nagybetűs alias)?

Az AGENTS.md (281–284. sor) szerint a gyógyítás MANTRA-konform: a kisbetűs definíció marad (mert a futásidejű kód használja), és mellé egy **nagybetűs alias** kerül a bizonyítások számára:
```idris
public export KezdoKisAI : KisAI
KezdoKisAI = kezdoKisAI
```
Ezután a bizonyítások a nagybetűs `KezdoKisAI`-t használják a típusban.

### 10.4 A csapda függvény-argumentumként is él

Az AGENTS.md (276–280. sor) figyelmeztet: a csapda nem csak csupasz konstansoknál él, hanem függvény-argumentumként is. A KisAI.idr esetében a `tudastar kezdoKisAI = []` legegyszerűbb projekció is elbukott, mert a `kezdoKisAI` kisbetűs konstans a bizonyítás TÍPUSÁBAN implicit argumentummá vált. A szerkezetileg azonos önálló probe (minden konstansa nagybetűs) átment — a vak probe-ok nem találták meg a hibát.

Példa a javításra: `osveny_index/tanulsagok/KisBetűsProjekcióCsapda.idr`.

### 10.5 A projektben minden bizonyítás nagybetűs neveket használ

A projektfájlok (`DependensSzamT.idr`, `KostantFelbontás.idr`, `Torusz.idr`) a bizonyítások típusaiban nagybetűs konstansokat használnak: `kostantFelbontásÖssge`, `E8Dimenzió`, `Blokk64Dimenzió`, `Cl8Dimenzió` — mind nagybetűvel kezdődnek. Ezért a kisbetűs-név csapda nem lép fel.

---

## 11. A meglévő kód bizonyításainak katalógusa

### 11.1 Alap/DependensSzamT.idr

Minden bizonyítás `Refl`:

| Bizonyítás | Típus | Tautológia? | Megjegyzés |
|---|---|---|---|
| `uresVektorHosszBizonyitas` | `vektorHossz UresVektor = 0` | Nem | Strukturált: `vektorHossz` redukció |
| `egyKubitHosszBizonyitas` | `vektorHossz (Kombinalt NullaD UresVektor) = 1` | Nem | Strukturált |
| `oktonioDimenzioBizonyitas` | `7 + 1 = 8` | Nem | Számtani, de strukturált |
| `dimenzioAzonosKompozicioBizonyitas` | `dimenzioKompozicio DimenzioAzonos DimenzioAzonos = DimenzioAzonos` | Nem | Függvényalkalmazás redukció |
| `hetPluszEgyNyolc` | `7 + 1 = 8` | Nem | Számtani |
| `nullaPluszEgyEgy` | `0 + 1 = 1` | Nem | Számtani |
| `egyPluszEgyKetto` | `1 + 1 = 2` | Nem | Számtani |
| `kettoPluszEgyHarom` | `2 + 1 = 3` | Nem | Számtani |
| `hetPluszHetTiznegy` | `7 + 7 = 14` | Nem | Számtani |
| `hetPluszHetPluszEgyTizenot` | `7 + 7 + 1 = 15` | Nem | Számtani |
| `haromSzorHaromKilenc` | `3 * 3 = 9` | Nem | Számtani |
| `kettoSzorOtTiz` | `2 * 5 = 10` | Nem | Számtani |

Megjegyzés: ezen bizonyítások többsége strukturált (a baloldal egy kifejezés, a jobboldal egy konkrét érték), de **nem KÉT független út** — csak egyetlen konstrukció és az értéke. Erősebb lenne, ha minden értéket két különböző konstrukcióval bizonyítanánk.

### 11.2 Steane713Dependent.idr

| Bizonyítás | Típus | Tautológia? | Megjegyzés |
|---|---|---|---|
| `uresVektorHossz` | `vektorHossz UresVektor = 0` | Nem | Strukturált |
| `egyKubitHossz` | `vektorHossz (Kombinalt NullaD UresVektor) = 1` | Nem | Strukturált |
| `forditDInvolucioNulla` | `forditD (forditD NullaD) = NullaD` | Nem | Involúció (X²=I) |
| `forditDInvolucioEgy` | `forditD (forditD EgyD) = EgyD` | Nem | Involúció (X²=I) |
| `noetherTetelDNulla` | `dekodolD (kodolD NullaD) = NullaD` | Nem | Noether-tétel (dekodol∘kodol=id) |

A `noetherTetelDNulla` a Steane-kód Noether-tételének bizonyítása: a dekódolás és kódolás kompozíciója identitás. Ez valódi bizonyítás — a `kodolD NullaD = alapKodNullaD` (7 NullaD), és `dekodolD alapKodNullaD` = `steaneDekodolD` = `NullaD` (mert 0 egyes < 4). A `Refl` átmegy, mert a teljes lánc redukálódik.

### 11.3 KostantFelbontás.idr

| Bizonyítás | Típus | Tautológia? | KÉT út? |
|---|---|---|---|
| `bizKostantFelbontásE8` | `kostantFelbontásÖssge = E8Dimenzió` | Nem | Nem (egy út: 28+28+64+64+64=248) |
| `bizHáromBlokkPluszTengely` | `háromBlokkÖsszege + tengelyDimenzió = E8Dimenzió` | Nem | Nem (egy út: 192+56=248) |
| `biz64Tenzorszorzat` | `Blokk64Dimenzió = 8 * 8` | Nem | IGEN — egy a három útból |
| `biz64KetHatvány` | `Blokk64Dimenzió = 2 * 2 * 2 * 2 * 2 * 2` | Nem | IGEN — egy a három útból |
| `biz64FelEgeszgyökFele` | `Blokk64Dimenzió = 128 \`div\` 2` | Nem | IGEN — egy a három útból |
| `bizTrialityHarmadik` | `(r : Rep8) -> triality³ r = r` | Nem | Nem (T³=1, egy út) |
| `bizPauliXInvolúció` | `pauliSzorzas PauliX2 PauliX2 = (PauliI2, True)` | Nem | Nem |
| `bizPauliZInvolúció` | `pauliSzorzas PauliZ2 PauliZ2 = (PauliI2, True)` | Nem | Nem |
| `bizPauliXZegyenlőY` | `pauliSzorzas PauliX2 PauliZ2 = (PauliY2, True)` | Nem | Nem |
| `bizPauliZXegyenlőY` | `pauliSzorzas PauliZ2 PauliX2 = (PauliY2, False)` | Nem | Nem (Heisenberg-fázis!) |
| `bizRagPauliX` | `toldalékPauli RagTípus = PauliX2` | Nem | Nem |
| `bizJelPauliZ` | `toldalékPauli JelTípus = PauliZ2` | Nem | Nem |
| `bizKépzőPauliY` | `toldalékPauli KépzőTípus = PauliY2` | Nem | Nem |
| `bizÉsPauliZ` | `logikaiPauli ÉsKapcsolat = PauliZ2` | Nem | Nem |
| `bizVagyPauliX` | `logikaiPauli VagyKapcsolat = PauliX2` | Nem | Nem |
| `bizEzértPauliY` | `logikaiPauli EzértKapcsolat = PauliY2` | Nem | Nem |
| `bizCl8Grádok` | `cl8GrádokÖsszege = Cl8Dimenzió` | Nem | Nem (1+8+28+56+70+56+28+8+1=256) |
| `bizHid` | `hídÖsszeg = Cl8Dimenzió` | Nem | IGEN — híd (240+16=256 vs 2⁸=256) |

A **KÉT független út** minta legjobb példája a 64 három útja:
- `biz64Tenzorszorzat`: 64 = 8×8 (a vektor reprezentáció tenzorzorzata önmagával)
- `biz64KetHatvány`: 64 = 2⁶ (a 6 stabilizátor-generátor 2⁶ állapota)
- `biz64FelEgeszgyökFele`: 64 = 128/2 (a 128 félegész gyök fele = pozitív kamara)

Ez három fogalmilag teljesen különböző konstrukció, mind 64-re fut. Ha bármelyiket átírják, a bizonyítás megtörik. Ez az AGENTS.md §16.3-as minta megvalósítása.

### 11.4 Torusz.idr

| Bizonyítás | Típus | Tautológia? | Megjegyzés |
|---|---|---|---|
| `bizPozícióVáltásInvolúció` | `(p : Pozíció) -> pozícióVáltás² p = p` | Nem | Involúció, 2 konstruktor |
| `bizTóruszPontokSzáma` | `16 = 16` | **IGEN** | Tautológia! |
| `bizTóruszCl4Penge` | `16 = 16` | **IGEN** | Tautológia! |
| `bizPozícióLépésInvolúció` | `(t : ToruszPont) -> pozícióLépés² t = t` | Nem | Involúció, 2 konstruktor |
| `bizFázisLépés1`–`bizFázisLépés8` | `fázisLépés (pont) = (következő pont)` | Nem | 8 lépés, mindegyik Refl |
| `bizGKPTóruszPont` | `gkpTóruszPont g = MkToruszPont (...)` | Nem | Rekord konstrukció |
| `bizÁllításF0` | `mondatFázis Állítás = F0` | Nem | Megfeleltetés |
| `bizKérdésF2` | `mondatFázis Kérdés = F2` | Nem | Megfeleltetés |
| `bizFeltevésF4` | `mondatFázis Feltevés = F4` | Nem | Megfeleltetés |
| `bizKövetkeztetésF6` | `mondatFázis Következtetés = F6` | Nem | Megfeleltetés |
| `bizÁllításPont` | `mondatTóruszPont Állítás = MkToruszPont Pozíció0 F0` | Nem | Kompozíció |
| `bizKérdésPont` | `mondatTóruszPont Kérdés = MkToruszPont Pozíció0 F2` | Nem | Kompozíció |
| `bizFeltevésPont` | `mondatTóruszPont Feltevés = MkToruszPont Pozíció0 F4` | Nem | Kompozíció |
| `bizKövetkeztetésPont` | `mondatTóruszPont Következtetés = MkToruszPont Pozíció0 F6` | Nem | Kompozíció |

**A két tautológia javítása**: `bizTóruszPontokSzáma : 16 = 16` helyett `bizTóruszPontokSzáma : 2 * 8 = 16` (ahol a baloldal strukturált: `2 × 8 = Z₂ × Z₈`), vagy `toruszPontokSzáma = 16` definícióval `bizTóruszPontokSzáma : toruszPontokSzáma = 16` — de még ez is gyenge. A legjobb: KÉT út, pl. `bizTóruszPontokSzáma : 2 * 8 = length töruszPont16` (a szorzat vs. a lista hossza — két független konstrukció).

### 11.5 KategóriaElmélet64.idr

| Bizonyítás | Típus | Megjegyzés |
|---|---|---|
| `homHasId YA` | `hom YA YA = True` | Refl |
| `homHasId YB` | `hom YB YB = True` | Refl |
| `yonedaNonEmpty YA` | `Not (hom YA YA = False)` | **impossible** — a `Refl` elérhetetlen |
| `yonedaNonEmpty YB` | `Not (hom YB YB = False)` | **impossible** |

A `yonedaNonEmpty` a projektben az egyetlen `impossible` használat (a `K_E9_Idr.idr` `believe_me`-in kívül). Ez a Void/impossible minta (§7) megvalósítása: a `Not (hom a a = False)` = `hom a a = False -> Void`, és mivel `hom a a = True` (sosem `False`), a `Refl` argumentum elérhetetlen.

### 11.6 K_E9_Idr.idr — a `believe_me` csapda

A `K_E9_Idr.idr` kétszer használ `believe_me`-t:

1. (224. sor) A hurok-érték involúciója:
```idris
omegaInvolucioTorveny (HurokErtekKonstruktor t) =
  let inv = 1.0 / t
  in believe_me (Refl {x = HurokErtekKonstruktor (1.0 / inv)})
```
Itt a `believe_me` megkerüli a típusellenőrzést. A `Refl {x = ...}` egy explicit `x` paraméterrel, ami trükk — de a `believe_me` miatt a típusellenőrző nem ellenőrzi, hogy a két oldal valóban egyenlő. Ez gyenge bizonyítás — a `believe_me` tiltandó, kivéte, ha külső okból (pl. lebegőpontos pontatlanság) elkerülhetetlen.

2. (475. sor) Általános kihagyás:
```idris
bizonyitasKihagyas : {0 a : Type} -> {0 x : a} -> {0 y : a} -> x = y
bizonyitasKihagyas = believe_me (the (x = x) Refl)
```
Ez egy általános „bizonyítás kihagyása" függvény, ami BÁRMILYEN `x = y` állítást bizonyít — a `believe_me` miatt a típusellenőrző elhiszi. Ez veszélyes: megtévesztő, mert a név azt sugallja, hogy bizonyít, de valójában megkerüli az ellenőrzést. **A `believe_me` csak végső esetben használandó, és a bizonyítás érvényességét külsően (numerika, irodalom) kell alátámasztani.**

---

## 12. A Wadler „free proof" (Theorems for Free!)

### 12.1 Mi az?

A Wadler-féle „Theorems for Free!" (1989) elv: **minden polimorf függvény típusából LEVEZETHETŐ egy tétel, amit a függvény BIZTOSAN teljesít — anélkül, hogy látnánk a kódját.** A Reynolds-féle absztrakciós tétel (parametricity): minden `∀X. T(X)` típusú kifejezés kielégít egy logikai relációt. Wadler ezt visszafordította gyakorlati tételekké.

A projektben (`LegkisebbMuvelet/IngyenesTetelek.idr` 9–28. sor) így van megfogalmazva: „A polimorf típus AUTOMATIKUSAN bizonyítja a természetességi négyzetet. A parametricity = a típus kikényszeríti az optimális utat. A 'free theorem' = a Lagrangian geodetikája."

### 12.2 Hogyan működik a polimorf típus bizonyítása?

A parametricity elv: egy polimorf függvény nem vizsgálhatja a típusparaméter értékeit, csak alkalmazza a kapott függvényeket. Ez a korlátozás kikényszeríti a funktor törvényeket és más természetes transzformáció-kommutativitásokat.

Példák a projektből (`IngyenesTetelek.idr`):

**Tétel 1 — a `map` funktor törvénye** (50–72. sor):
```
map : (a -> b) -> List a -> List b
Free theorem: map f ∘ map g = map (f ∘ g)
```
A parametricity biztosítja, hogy a `map` uniform viselkedésű minden típuspéldányban. A típus `(a -> b) -> List a -> List b` megköti a viselkedést: a `map` nem vizsgálhatja az elemeket, csak alkalmazza a függvényt. Ez kikényszeríti a kompozíció törvényt.

**Tétel 2 — a `filter`** (74–93. sor):
```
filter : (a -> Bool) -> List a -> List a
Free theorem: filter p ∘ map f = map f ∘ filter (p ∘ f)
```
A parametricity biztosítja, hogy a `filter` és a `map` „kommutálnak" — a szűrés és a leképezés felcserélhető.

**Tétel 3 — a `foldl`** (95–110. sor):
```
foldl : (b -> a -> b) -> b -> List a -> b
Free theorem: foldl f z ∘ map g = foldl (f') z
ahol f' = \b a -> f b (g a)
```

### 12.3 A parametricity a magyar nyelvben

A projekt érdekes analógiát von (`IngyenesTetelek.idr` 24–28. sor): „A magyar agglutináció: tő ⊗ képző ⊗ rag = szó. A tő polimorf — minden raggal kombinálható. A parametricity biztosítja, hogy a ragozás uniform. A 'free theorem' = a ragozás törvénye (a ragozás természetes transzformáció)."

Ez a Wadler-elv alkalmazása a nyelvre: a magyar tő (mint polimorf típus) minden raggal (mint függvénnyel) kombinálható, és a parametricity garantálja, hogy a ragozás uniform — nem függ a tő konkrét értékétől.

### 12.4 A „free proof" a Steane-kódban

A `Steane713Dependent.idr` (158. sor) szerint: „A free proof (Wadler): a tipus garantalja hogy dekodol ∘ kodol = id." A `KodoloD` typeclass (`KodoloD KubitD (SteaneVektor 7)` instance) típusa: `kodolD : KubitD -> SteaneVektor 7` és `dekodolD : SteaneVektor 7 -> KubitD`. A Wadler-elv szerint a típus (a `KodoloD` interface) garantálja, hogy a `dekodolD ∘ kodolD = id` — de ezt a projekt `Refl`-lel is bizonyítja (`noetherTetelDNulla`).

### 12.5 A `DependensSzamT.idr` funktor instance — free proof

A `DependensSzamT.idr` (201–215. sor) definiálja a `DimenzioFunktorT` typeclass-t és a `natFunktor` instance-t:
```idris
interface DimenzioFunktorT (f : Nat -> Type) where
  dimenzioKep : Nat -> Type
  dimenzioMorfolgia : {n, m : Nat} -> DimenzioMorf n m -> dimenzioKep n -> dimenzioKep m

[natFunktor] DimenzioFunktorT (\n => dimenzioTipus n) where
  dimenzioKep n = dimenzioTipus n
  dimenzioMorfolgia DimenzioAzonos x = x
  dimenzioMorfolgia DimenzioLepes x = believe_me x
```
A `DimenzioAzonos` esetre `dimenzioMorfolgia DimenzioAzonos x = x` — ez a funktor identitás-törvénye (`F(id) = id`). A komment (203–204. sor) szerint ez a „free proof (Wadler parametricity): a típus garantálja a funktor törvényt." A `DimenzioLepes` esetben `believe_me` van — ez gyenge, mert a `dimenzioTipus n`-ből `dimenzioTipus (S n)`-be való átmenet nem triviális (más típusok), és a típusellenőrző nem tudja magától megoldani.

---

## Összegzés — a bizonyítás eszköztára (sorrendben)

Az AGENTS.md §16.5 (334–337. sor) szerint az eszköztár:

1. **Refl** (kiszámolt egyezés) — ha a két oldal definíció szerint redukálódik azonosra.
2. **cong** (függvény emeli) — ha az egyenlőséget egy konstruktorral kell „körülvenni" (indukciós lépés).
3. **trans** (bizonyítás-lánc) — ha több lépéses lánc kell (a=b, b=c → a=c).
4. **rewrite** (behelyettesítés; IRÁNYRA figyelni!) — ha a céltípust kell átirni egy egyenlőség alapján.
5. **sym** (egyenlőség megfordítása) — ha az irányt kell megfordítani (vagy a rewrite irányát).
6. **replace** (dependens típusok átalakítása) — ha egy predikátumot kell átirni.
7. **?lyuk + `:ps` proof search** (interaktív) — ha nem tudjuk előre a bizonyítást, a REPL segít.
8. **impossible** (Void) — ha a bizonyítás célja egy lehetetlen állítás cáfolata.
9. **believe_me** (csak végső eset) — ha a típusellenőrzést kell megkerülni (veszélyes, külső ellenőrzés kell).

**A jó bizonyítás mintája**: KÉT fogalmilag különböző konstrukció, egy híd. Nem `X = X` (tautológia), hanem két különböző út, amelyek kényszerítve vannak ugyanarra a célra.

---

**中文：** 本文档详尽总结了 Idris2 中的证明方法。核心要点：Refl 证明定义性相等（两边能归约到同一范式）；cong 将等式提升通过函数；trans 链接多个等式；rewrite 按相等证明改写目标类型（注意方向！）；sym 翻转方向；Void/impossible 证明不可能；replace 处理依赖类型。最佳模式：两条概念上独立的构造路径，一座桥连接它们——而非 `X = X` 同义反复（零信息）。项目中 KostantFelbontás.idr 的三个 64 证明（8×8、2⁶、128/2）即此模式的范例。避免 `believe_me`（绕过类型检查）。

**Deutsch:** Dieses Dokument fasst ausführlich zusammen, wie in Idris2 bewiesen wird. Refl beweist definitorische Gleichheit (beide Seiten reduzieren auf dieselbe Normalform); cong hebt Gleichheit durch eine Funktion; trans verkettet Gleichungen; rewrite schreibt den Zieltyp um (Richtung beachten!); sym kehrt die Richtung um; Void/impossible beweist Unmögliches; replace behandelt abhängige Typen. Bestes Muster: ZWEI begrifflich unabhängige Konstruktionen, eine Brücke — nicht `X = X` (Tautologie, null Information). Die drei 64-Beweise in KostantFelbontás.idr (8×8, 2⁶, 128/2) sind ein Beispiel. `believe_me` vermeiden (umgeht die Typprüfung).

**עברית:** מסמך זה מסכם בפירוט כיצד מוכיחים ב־Idris2. Refl מוכיח שוויון הגדרתי; cong מרים שוויון דרך פונקציה; trans משרשר שוויונים; rewrite משכתב את סוג היעד (שים לב לכיוון!); sym הופך כיוון; Void/impossible מוכיח אי־אפשר; replace לטיפוסים תלויים. הדפוס הטוב ביותר: שני מסלולי בנייה עצמאיים מבחינה מושגית וגשר אחד — לא `X = X` (טאוטולוגיה). שלושת הוכחות ה־64 ב־KostantFelbontás.idr הן דוגמה. להימנע מ־`believe_me`.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★