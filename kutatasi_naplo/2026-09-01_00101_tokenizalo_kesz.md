# Kutatási napló — 2026-09-01 — az 001.01 (Mondat-tokenizáló) KÉSZ

## A felhasználó üzenete (szó szerint, §N5)

„folytasd"

## Az 001.01 végrehajtása

### A specifikáció (a VegrehajtasiTerv 1.1 — §N11)
- `szavakTisztítva s = map (kisbetus . irasjelLevagas) (words s)`
- Siker: „Mit mondott a farkas?" → [„mit", „mondott", „a", „farkas"]

### A §24 — a meglévő gyökerek
- `Paragrafus.kisbetus` (81–92. sor) — a kisbetűsítés (importálva a SzotarHid_v2-be)
- `Kodol.irasjelLevagas` (osveny_index/Kodol.idr 151–) — az írásjelek levágása + kisbetűsítés. DE: a Kodol az `osveny_index/` könyvtárban — a build-path kérdéses. Megoldás: egy saját `végírásjelekLevágása` (CSAK a szó végéről vág; a `Kodol.irasjelLevagas` más: az kisbetűsítést is csinál + belső go) — kommentben §24-hivatkozás.

### A megvalósítás (SzotarHid_v2 III/E)
- `végírásjelek : List Char` — a magyar írásjelek (.,!?:;„""()+-–—*[]{}'")
- `végírásjelekLevágása : String → String` — a szó végéről levágja az írásjeleket (reverse + dropWhile + reverse)
- `szavakTisztítva : String → List String` = `map (kisbetus . végírásjelekLevágása) (words mondat)`
- `mondatTövei : String → List String` = `mapMaybe (\szó => map fst (tőKeresés szó)) (szavakTisztítva mondat)` — a `mapMaybe` a Data.List-ből (§24: import, nem duplikáció)

### A csapdák
- A `words` → `import Data.String` (a Prelude nem tartalmazza automatikusan)
- A `mapMaybe` — az őrszem jelzte a PreludeDuplikatum-csapdát → a saját where-blokk törlése, a Data.List-ből import
- A `||    ` doc-komment-folytatás → `|||` (az Idris2-ben a doc-komment folytatása `||`, nem `||    `)

### A futás eredménye (§N14/3)
```
─── V/A. A MONDAT-TOKENIZÁLÓ (a 001.01) ───
  A beírt mondat tisztított szavai:
    «mit»
    «mondott»
    «a»
    «farkas»
  A beírt mondat szavainak tövei (a 000.04 tő-kereséssel):
    «farkas»
```
— **a terv siker-kritériuma teljesült**: «Mit mondott a farkas?» → [«mit», «mondott», «a», «farkas»] ✓ (a nagybetűs «Mit» → «mit», a «mondott?» → «mondott», a «farkas?» → «farkas» — az írásjelek levágva, a kisbetűsítés megtörtént!)

A tövei: [«farkas»] — csak a «farkas» találtatott (a «mit», «mondott», «a» nincsenek a 3460-as lexikonban — funkciószavak; a jövőbeli 000.03 Lumo-szókincs vagy a funkciószó-kiegészítés megoldja).

## A verifikáció (§N14)
1. GAN — a felhasználó „folytasd"-ja a sorrendet követi 2. Fordítás ✓ (0 hiba) 3. Numerikus ✓ (fenti teszt) 4. Irodalom ✓ (a Paragrafus + a Kodol) 5. Vizualizáció ✓ (a main V/A szekciója) 6. Interaktív ✓ (a getLine-re a tisztított szavak + a tövei)

## A todo állapota
- 63 feladat, KÉSZ: 11, VÁR: 52, előrehaladás ~17.5%
- 001.01 KÉSZ
- A következő: a 001.02 (CPT-fázis kinyerése a mondatból) — a fővonal következő Magas-Vár feladata

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★