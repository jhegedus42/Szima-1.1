# Kutatási napló — 2026-09-01 (§N14 hard rule + GAN kiegészítés)

## A felhasználó kérdése (szó szerint, §N5)
- „minden lepes utan GAN-nal kell ellenorizni a sikert, illetve forditassal, numerikus verifikacioval, relevans irodalommal, vizualizacioval, hasznalhato-demonstralhato interaktiv programmal, amit idrisz general... a definiciokat le kell pontosan irni minden feladatba, ezeket, idrsz-bol kell generalni, ezek hard rule-ok-amik bemennek a pluginba, az emlekeztetobe... ezt tegye bele egy GAN, aki csak hozzatesz, javit, korrigal, de nem mondja azt, hogy valamit nem erdemes megprobalni, mert barmibol itt johet ki mar eredmeny"

## Mit csináltunk

### 1. A §N14 hard rule beírása a pluginba (AGENTS.md)
A `~/.config/opencode/AGENTS.md`-hez hozzáadtuk a §N14-et: a 6-szintű verifikációs protocol minden lépés után:
1. GAN-ellenőrzés (hozzátesz, nem elvesz)
2. Fordítás (Idris2 typechecker — ami fordul, az igaz)
3. Numerikus verifikáció (Idris2 --exec main — értelmes kimenet)
4. Releváns irodalom (§N12 — arXiv, Wikipedia, nLab, könyv)
5. Vizualizáció (Mermaid-diagram, táblázat, vagy Idris-kimenet)
6. Használható-demonstrálható interaktív program (Idris2 --exec — getLine + putStrLn — a program REAGÁL)

A definíciók Idris-ből generálódnak — a kód = a definíció (Curry-Howard: a típus = az állítás, a program = a bizonyítás).

### 2. A GAN-alügynök kiegészítése (task)
A GAN átnézte a 43 feladatot és megállapította:
- GAN-ellenőrzés: 42/43-ból hiányzik
- Vizualizáció: 43/43-ból hiányzik
- Interaktív program: 42/43-ból hiányzik
- Irodalom: 42/43-ból hiányzik
- Idris-definíciók: 41/43-ból hiányzik

A GAN CSAK hozzátesz — 15 új feladatot javasolt (11.1-11.15):
- 11.1: VerifikációsProtokoll typeclass (a 6-szintű ellenőrzés Idris-típusként — a typechecker = a bíró)
- 11.2-11.4: a GAN, a fordítás, a numerikus verifikáció automatizálása
- 11.5: IrodalomHivatkozás typeclass (az arXiv/Wikipedia/nLab/könyv hivatkozások)
- 11.6-11.7: a vizualizáció és az interaktív program generálása
- 11.8: a DefinícióGenerálás (typeclass/record = a matematikai definíció)
- 11.9-11.10: a VerifikációsJelentés + a 43 feladat kiegészítése
- 11.11-11.15: az irodalom MCP-keresése, a diagram MCP-generálás, a GAN-visszacsatolás, a verifikációs napló, a demonstrációs műsor

### 3. A végrehajtási terv kiegészítve (43→58 feladat)
A `docs/VegrehajtasiTerv_2026-09-01.md` 614 sor — a 43 feladat + a 15 új feladat, a sorrend-korrekcióval.

## Push
- `015933f` — végrehajtási terv + GAN kiegészítés (43→58 feladat)

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★