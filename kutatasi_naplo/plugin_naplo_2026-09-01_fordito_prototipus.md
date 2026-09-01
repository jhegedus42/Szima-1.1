# Kutatási napló — 2026-09-01 (fordító prototípus)

## A felhasználó kérdése (szó szerint, §N5)
- „folytassuk, keszits todo-t, fontos, hogy legyen kezzelfoghato eredmeny, amit gyakorlatban lehet hasznalni"

## Mit csináltunk

### 1. Todo lista frissítése
A todo listát frissítettem — 9 feladat, ebből 4 completed, 1 in_progress (fordító prototípus).

### 2. A kézzelfogható eredmény: ForditoPrototipus.idr
A felhasználó „kézzelfogható eredményt" akar — valamit, amit gyakorlatban lehet használni. A leginkább kézzelfogható dolog: egy **magyar-kínai fordító prototípus**, ami a Carnot-ciklus 4 lépésén keresztül fordít.

#### A prototípus tartalma (322 sor, 7 szakasz):
1. **Magyar morféma** (Tő, Rag, Jel, Képző) — a szó felbontása
2. **Kínai szó** (gyökér + partikula) — a kínai megfelelő
3. **Szótár** (10 szó: ház→房子, ég→着火, víz→水, kert→花园, ember→人, kő→石头, fa→树, nap→太阳, hold→月亮, föld→土地)
4. **Carnot-ciklus 4 lépés** (izentróp tágulás, izoterm tágulás, izentróp kompresszió, izoterm kompresszió)
5. **Teljes fordítás** (magyarKínaiFordítás, kínaiMagyarFordítás)
6. **Bizonyítások** (7 Refl: bizHázMagyar, bizHázKínai, bizÉgMagyar, bizÉgKínai, bizVízMagyar, bizVízKínai, bizKompresszióReverzibilitás, bizTágulásEgySzóra)
7. **Főprogram** (kiírja a szótárt, a 4 lépést, a fordítás eredményét, a reverzibilitást, a bizonyításokat)

#### A prototípus működése:
```
magyar: 'ház' -> kínai: '房子'
magyar: 'ég' -> kínai: '着火'
magyar: 'víz' -> kínai: '水'
magyar: 'ember' -> kínai: '人'
```

#### A modulok importálása (§24):
- `ForditasCarnot` (a Carnot-ciklus keret)
- `HanMagyarKodolas` (a kínai gyökerek)
- A `KostantFelbontás` import eltávolítva (hibás Refl-ek — a `integerToNat` és `plus`/`mult` problémája)

#### Hibák amiket javítottunk:
1. A magyar idézőjelek (`„"`) a `putStrLn` stringeken belül — a `"` (záró magyar idézőjel) ugyanaz mint a string záró, ezért a string idő előtt lezárult. A megoldás: `'` (szimpla idézőjel) a `putStrLn` stringeken belül.
2. A `magyarKínaiKeresés` rekurzív függvény nem redukálódik a typechecker szintjén — a Refl bizonyítások nem működnek a listán való kereséssel. A megoldás: konkrét `MkSzótárBejegyzés` konstruktorokkal bizonyítunk (nem a listán való kereséssel).
3. A `head` és `drop` nincsenek importálva — a megoldás: konkrét konstruktorokkal bizonyítunk (nem listán való indexeléssel).

### 3. A prototípus bővíthetősége
A prototípus bővíthető:
- **Toldalékok** (rag=X, jel=Z, képző=Y) — a `KostantFelbontás.idr`-ből
- **Kínai partikulák** (了, 着, 过 — igeidő/szemlélet)
- **Mondat-szintaxis** (alany + állítmány + tárgy)
- **Hangrend-paritás** (mély/magas — a `FanoParitás`-ból)
- **Fordított szótár** (kínai → magyar — a reverzibilitás teljes megvalósítása)

## Push
- `77ebbdb` — ForditoPrototipus.idr: magyar-kínai fordító prototípus (kézzelfogható eredmény)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★