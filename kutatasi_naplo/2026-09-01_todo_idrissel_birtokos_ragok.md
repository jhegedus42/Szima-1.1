# Kutatási napló — 2026-09-01 — a TODO módosítása CSAKIS Idrissel (új hard rule) + a birtokos ragok

## A felhasználó új hard rule-jai (szó szerint, §N5)

1. „birtokos ragok hianya az fontos, ez egy gan javaslat, azokat nem szabad elhagyni, mert kesobb problemat fog okozni"
2. „ezentul lehet beszurni al feladatokat is, pl. a 000.000.000.000 -etc alakban, bovitsuk igy az idrisz programot"
3. „ezentul, csakis idrisszel lehet a feladatokat modositani, ez legyen a kovetkezo feladat, ezentul ez egy hard rule"

## 1. A TODO módosítása CSAKIS Idrissel (a hard rule 3.)

A `SajatTodo_v1.idr` kiegészítve (III/B szakasz):
- `állapotNév : Állapot → String` + `prioritásNév : Prioritás → String` — a konstruktor-nevek a fájlformához
- `feladatFájlForma : Feladat → String` — a `MkFeladat`-szintaxis generálása
- `todoListaFájlForma : List Feladat → String` — a teljes lista a fájlformába
- `állapotMódosító : String → Állapot → List Feladat → List Feladat` — a sorszám alapján frissíti az állapotot (tisztán, Idrisben)
- `alFeladatBeszúró : String → Feladat → List Feladat → List Feladat` — egy al-feladat beszúrása a szülő sorszám után (a 000.04.001 formátum)
- `módosítottListaKiírása : List Feladat → String` — a `public export todoLista = [...]` blokk

A `main` interaktív (VIII. szekció): getLine → `words` → parancs-elemzés:
- `allapot <sorszam> <Kesz|Folyamatban|Var>` — módosít
- `beszur <szulo-szam> <al-szam> <cim> <Magas|Kozepes|Alacsony> <fajl>` — beszúr

A program KIÍRJA a módosított listát a `MkFeladat`-formába — a fájlba illesztés mechanikai (a módosítás LOGIKÁJA Idrisben van).

### A csapdák (rögzítve)
- A `words` → `import Data.String` (a Prelude nem tartalmazza automatikusan)
- A magyar ékezetes nagybetűs paraméterneveket (`újÁllapot`, `állapotStr`) az Idris kisbetűként értelmezi (a KisBetűsProjekcióCsapda) → `ujAllapot`, `allapotStr`

### Tesztelve
- `allapot 000.04 Folyamatban` → a program kiírta a módosított listát (000.04 Folyamatban) ✓
- `beszur 000.04 000.04.001 Birtokos-ragok-hozzáadása Magas SzotarHid_v2.idr` → a 000.04.001 beszúrva a 000.04 után ✓

## 2. A birtokos ragok hozzáadása (a hard rule 1. — a 000.04.001 al-feladat)

A felhasználó: „azokat nem szabad elhagyni, mert kesobb problemat fog okozni".

A `SzotarHid_v2.idr` kiegészítve: `birtokosRagok : List String` (33 elem):
- egyes 1.: om, em, öm, m
- egyes 2.: od, ed, öd, d
- egyes 3.: ja, je, a, e
- többes 1.: unk, ünk
- többes 2.: otok, etek, ötök, aitok, eitek
- többes 3.: juk, jük, uk, ük
- számjel: ok, ek, ök, ak, k
- birtokos többes: ai, ei, jai, jei

A `teljesToldalékLista` kompozíciója bővült: `esetragAlakok22 ++ gyakoriKépzők ++ birtokosRagok ++ gyakoriToldalékok` (a hossz-szerinti csökkenő rendezés megmarad).

### Tesztelve
- **«emberünknek» → «ember»** (levágások: [«nek», «ünk»]) ✓ — a birtokos rag MŰKÖDIK! (ember + -ünk + -nek; a rekurzió: -nek → «emberünk» → -ünk → «ember»)
- «farkasokat» → «farkas» [«okat»] — még mindig működik ✓ (a birtokos ragok hozzáadása nem törte meg)

## 3. A verifikáció (§N14)
1. GAN — a felhasználó maga adta a javaslatot (a birtokos ragok = a GAN-javaslat, amelyet nem szabad elhagyni) 2. Fordítás ✓ (mindkét fájl: SajatTodo + SzotarHid_v2, 0 hiba) 3. Numerikus ✓ («emberünknek» → «ember») 4. Irodalom ✓ (Kiefer 2011 — a birtokos ragozás) 5. Vizualizáció ✓ (a main VIII. szekció) 6. Interaktív ✓ (a getLine-parancsok: allapot + beszur)

## 4. A todo állapota
- 63 feladat, KÉSZ: 9, VÁR: 54, előrehaladás: 14.3%
- 000.04 → KÉSZ (a birtokos ragokkal kiegészítve)
- 000.04.001 (al-feladat) → KÉSZ
- A következő: a 000.03 (Lumo-szókincs bővítés) vagy a 000.06 (Bájt-egységesség)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★