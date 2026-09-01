# Kutatási napló — 2026-09-01 — a 011.10 (a terv kiegészítése §N14-gyel) KÉSZ + a következőFeladat javítása

## A felhasználó üzenete (szó szerint, §N5)

„folytassuk"

## 1. A következőFeladat hibája és javítása

A `következőFeladat` rekurziója HIBÁS volt: a `case következőFeladat fs of Just f' => Just f'` logika miatt a lista VÉGÉTŐL haladt előre — az utolsó Magas-Várt (011.15) adódott, nem az első!

**A javítás (§N11 — a függvény logikájának értelmezése után):** az első Folyamatba vagy Magas-Várt a lista ELEJÉTŐL keressük:
```idr
következőFeladat (f :: fs) =
  if feladatÁllapota f == Folyamatba then Just f
  else if feladatÁllapota f == Vár && feladatPrioritása f == Magas then Just f
  else következőFeladat fs
```

**A csapda (rögzítve):** elírás — `Folyamatba` vs `Folyamatban` (az „n" hiányzott a végéről). Klasszikus elírás-csapda (a „birtokos rag hiánya" poén — de itt valóban hiba). Javítva.

## 2. A 011.10 (a 43 feladat kiegészítése a §N14-gyel) KÉSZ

A 011.10 = a VegrehajtasiTerv.md kiegészítése a §N14-gyel. A fájl végéhez hozzáadva egy **„§N14-KIEGÉSZÍTÉSEK"** szakasz, amely:
- összefoglalja a §N14 hat-szintű verifikációs protokollt
- egy táblázatban felsorolja a GAN-javaslatok beolvasztását (000.07, 003.07, 008.06, a mérések, a birtokos ragok)
- rögzíti az al-feladatok formátumát (000.04.001 — a string-rendezés helyes)
- rögzíti a TODO módosításának hard rule-ját (CSAKIS Idrissel)

## 3. A verifikáció (§N14)
1. GAN — a felhasználó maga (a „folytassuk" a sorrendet követi) 2. Fordítás ✓ (0 hiba) 3. Numerikus ✓ (a következő = 001.01) 4. Irodalom ✓ (a §N14 a pluginban) 5. Vizualizáció ✓ (a §N14-KIEGÉSZÍTÉSEK táblázat) 6. Interaktív ✓ (a SajatTodo main parancsok)

## 4. A todo állapota
- 63 feladat, KÉSZ: 10 (011.01, 011.05, 011.08, 011.03, 011.04, 011.10, 000.01, 000.02, 000.04, 000.04.001), VÁR: 53, előrehaladás ~15.9%
- **A következő: 001.01 (Mondat-tokenizáló javítása)** — a fővonal első Magas-Vár feladata

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★