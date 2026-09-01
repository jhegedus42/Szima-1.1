# Kutatási napló — 2026-09-01 — a GAN-javaslatok beolvasztása (ÚJ HARD RULE) + a 000.02 kiegészítések

## A felhasználó új hard rule-ja (szó szerint, §N5)

„a gan javaslatait figyelembe kell venni es annak megfeleloen modositani a todo-t es javitania munkat, ez hard rule"

## 1. A TODO módosítása (a hard rule szerint)

- **000.02** vissza Folyamatba vétel → a GAN-kiegészítések elvégzése → vissza Kész (a cím bővült: „+ GAN-kiegészítések")
- **ÚJ: 000.07** „Gyakorisági rang mező (webcorpus/MNSZ — Bayes-prior)" [Vár, Közepes] — a GAN szerint a gyakoriság kettős szerepű: Bayes-prior a dekóderben ÉS fonológiai ok (a neutralizáció)
- **ÚJ: 003.07** „Közös dekóder (Maybe-korrekció — a CSS-szindróma: kvantitás⊕jelentés-fázis)" [Vár, Magas] — a d=1 honest típusa: a korrekció `Maybe`, mert a magyar szókincs kódtávolsága 1
- **ÚJ: 008.06** „A hangsúly természetességi lemmája (az append nem változtatja a fejet — Refl)" [Vár, Közepes] — σ_{F(w)} = F(σ_w): a toldalékolás nem mozdítja a hangsúlyt; Idrisben bizonyítható

## 2. A MUNKA javítása — a GAN-mérések megvalósítva (SzotarHid_v2, III/C szakasz)

### a) A dekvantitálás + a MINIMÁLPÁR-GRÁF (a confusability-gráf)
- `dekvantitáló` (á→a, é→e, í→i, ó→o, ő→ö, ú→u, ű→ü) + `dekvantitál`
- `minimálpárE`: a dekvantitált alakok egyeznek ÉS az eredetiek eltérnek → a különbség PONTOSAN kvantitás-párokból áll
- `dekvantitáltCsoportok`: rendezés + csoportosítás (a `groupBy` List1-et ad — `forget`-tel List-té; `import Data.List1` hozzáadva)
- `minimálpárGráf` = a teljes 3460 szó d=1 párosításai
- **CSAPDA javítva:** a lexikonban azonos huText-ű duplikátumok élnek («achát»—«achát» ön-párok!) → a `párokCsoportból` kiszűri az azonos szövegűeket

### b) A VALÓDI eredmény: a d=1 zóna = 10 él
```
«besugó»—«besúgó»  «bor»—«bór»  «elvesz»—«elvész»  «fellazíttat»—«fellázíttat»
«fellazíttatás»—«fellázíttatás»  «lap»—«láp»  «lazít»—«lázít»  «lazítás»—«lázítás» …
```
— a «bor»/«bór» PONTOSAN a Mády & Reichel (2007) irodalmi példája! Az élek többsége az a/á csere (az e/é: «elvesz»/«elvész»; o/ó: «bor»/«bór»).

### c) A KVANTITÁS-HISZTOGRAM (99 mintázat a 3460 szóban)
```
[Rövid, Rövid] → 429        [Rövid, Rövid, Rövid] → 346
[Rövid, Rövid, Hosszú] → 330   [Rövid, Hosszú] → 251
[Rövid, Rövid, Rövid, Hosszú] → 170   [Rövid, Rövid, Rövid, Rövid] → 169
```
— ebből számolható a csatorna entrópiája (a jövő); a `nub` a Data.List-ből (§24 ✓).

### d) A HANGREND (a GAN „második ingyenes paritás-csatornája")
- `data Hangrend = Mély | Magas | Vegyes` + `hangrendKinyerő`
- Eloszlás a 3460 szón: **Mély 934, Magas 1160, Vegyes 1366**

### e) A PROZÓDIA-SZINDRÓMA (Bool → HOL a hiba)
- `data ProzódiaSzindróma = NincsHiba | HibásSzótag Nat | SzótagszámEltér Nat Nat`
- `prozódiaSzindróma`: az első eltérő pozíció (a Hamming-szindróma szó-szintű megfelelője)
- **Működik:** «abákusz» a «abakusz» ellen → **HibásSzótag 1** ✓ (az «á» az 1. indexű szótagon)
- **A GAN-elemzés empirikus igazolása:** «abekus» → **NincsHiba** a ritmuson! (a-e-u mind rövid = a-ba-kusz ritmusa) — vagyis a ritmus-szindróma NEM LÁTJA a mássalhangzó-szintű hibát → TOBB csatorna kell (a fonetikus + a jelentés-fázis) — pontosan a CSS-következtetés.

### f) TILTVÁNY rögzítve a kódban
A geminát-csatorna (mássalhangzó-kvantitás) TILOS paritásként (Siptár 1995: kevés minimálpár).

## 3. A verifikáció (§N14)
1. GAN ✓ (a javaslatok BEOLVASZTVA — a hard rule teljesül) 2. Fordítás ✓ (0 hiba) 3. Numerikus ✓ (fenti táblázatok) 4. Irodalom ✓ (Mády & Reichel 2007; Siptár & Törkenczy 2000; Siptár 1995) 5. Vizualizáció ✓ (a II/C táblázat) 6. Interaktív ✓ (a main getLine-műszere)

## 4. A tanulság
A minimálpár-gráf 10 éle EMPIRIKUSAN igazolja a GAN d=1 felismerését: a magyar szókincsben a kvantitás-flip JOGI szót ad (bor↔bór) — a ritmus-csatorna önmagában CSAK detektál, a korrekcióhoz a jelentés-fázis-csatorna társasága kell (a 003.07 közös dekóder).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★