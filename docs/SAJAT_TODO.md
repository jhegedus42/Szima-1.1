# SAJÁT TODO — a végrehajtási terv nyilvántartása

**Dátum:** 2026-09-01
**A forrás:** `docs/VegrehajtasiTerv_2026-09-01.md` (614 sor, 58 feladat, 10+1 fázis)
**A szabály:** a beépített todo nem működik — ezt a fájlt én írom és frissítem.

---

## A TODO ÁLLAPOTA

### ✅ KÉSZ (lefordul + lefut)

| # | Feladat | Fájl | Refl | Futás |
|---|---------|------|------|-------|
| 11.1 | VerifikációsProtokoll typeclass | `szima_ter/modul/VerifikaciosProtokoll_v1.idr` | 3 Refl | ✓ (main kiírja a 6 szintet) |

### 🔄 FOLYAMATBAN

| # | Feladat | Fájl | Státusz |
|---|---------|------|---------|
| 0.1 | HungarianLexicon publikus-v2 | `szima_ter/modul/HungarianLexicon_v2_Szima.idr` | a `sed` hibás volt (a `public export` és a szó neve egybeolvadt) — javitando |

### ⏳ VÁR

| # | Feladat | Függ | Fájl (tervezett) |
|---|---------|------|------------------|
| 0.2 | Szótár-generátor | 0.1 | `SzotarHid_v2.idr` |
| 0.3 | Lumo-szókincs bővítés | 0.1, Lumo-txt | `LumoSzokincs_v1.idr` |
| 0.4 | Tő-keresés 22 esetrag + rekurzív | SzotarHid_v1 | `SzotarHid_v2.idr` |
| 0.5 | Ékezet-normalizáció vizsgálata | — | `EkezetNormalizalo_v1.idr` |
| 0.6 | Bájt-egységesség (Peldaszotar vs lexikon) | SzotarHid, Paragrafus | (dokumentum) |
| 1.1 | Mondat-tokenizáló javítása | Paragrafus, Kodol | (SzotarHid_v2) |
| 1.2 | CPT-fázis kinyerése a mondatból | Torusz, MagyarNyelvtan | `MondatCPT_v1.idr` |
| 1.3 | Steane-kód generálás ellenőrzése | 0.2, KomplexByte | (futásidejű teszt) |
| 1.4 | Idris IO-réteg (readFile) | 0.2, 1.1 | `IndexeloIO_v1.idr` |
| 1.5 | Streamelt indexelés (batch=100) | 1.4 | `StreamIndexelo_v1.idr` |
| 2.1 | Tórusz-pont mint index 0. szintje | Torusz, 1.2 | `IndexBejegyzes_v1.idr` |
| 2.2 | 16 klaszter | 2.1 | `Klaszterezes_v1.idr` |
| 2.3 | Lemez-alapú index (B-tree) | 1.4, 2.2 | `LemezIndex_v1.idr` |
| 3.1 | Hadamard előszűrő | HadamardTav, 2.2 | `SteaneSzuro_v1.idr` |
| 3.2 | Normalizált Manhattan-távolság | LumoKereso | (LumoKereso_v2) |
| 3.3 | Belső szorzat | Komplex, KomplexByte | `BelsoSzorzat_v1.idr` |
| 3.4 | IDF-súlyozás | 0.2 | (SzotarHid_v2) |
| 3.5 | Hossz-normalizálás | 3.3 | (BelsoSzorzat_v1) |
| 3.6 | Klaszter-egyensúly | 2.2 | `KlaszterEgyensuly_v1.idr` |
| 4.1 | Hierarchikus keresés | 2.2, 3.1, 3.2 | `HierarchikusKereses_v1.idr` |
| 4.2 | Könyvek indexelése | 1.4-1.5, 4.1 | (IndexeloIO_v1) |
| 5.1 | Metrikák (NDCG, MRR) | 4.2 | `KeresesiMetrikak_v1.idr` |
| 5.2 | Ground-truth építése | 4.2 | `tesztek/GroundTruth_v1.txt` |
| 5.3 | Könyvtalálatok tesztje | 5.1, 5.2 | (GroundTruth_v1) |
| 5.4 | Teljesítménymérés | 4.1, 4.2 | (futásidejű) |
| 6.1 | Visszacsatolás | 3.4, 4.1 | `Visszacsatolas_v1.idr` |
| 6.2 | Aktív tanulás | 6.1 | `AktivTanulas_v1.idr` |
| 7.1 | Markov-blanket | stossz_doc, 3.3 | `MarkovBlanket_v1.idr` |
| 7.2 | Bergman-kernel | 3.3, 3.5 | `BergmanKernel_v1.idr` |
| 7.3 | Tétel: Berg≈Manh | 7.2, 3.2 | (dokumentum) |
| 7.4 | Hiperbolikus beágyazás | Torusz, 4.1, KvantumY | `HiperbolikusBeagyazas_v1.idr` |
| 8.1 | Yoneda | KategoriaElmelet | (dokumentum) |
| 8.2 | Fixpont 1/φ | Solomonoff, Komplex, KvantumY | `FixpontKereses_v1.idr` |
| 8.3 | Aranymetszés-spirál | KvantumY, 7.4 | `AranymetszesSpiral_v1.idr` |
| 8.4 | Carnot + reverzibilitás | ForditasCarnot, Carnot | (dokumentum) |
| 8.5 | GKP + Wadler | Torusz, GeneralizedPauli | (dokumentum) |
| 9.1 | Fehérje-modell | EpisodicMemory, 4.1 | (IndexBejegyzes_v2) |
| 9.2 | BabyAGI learnWord/sleepFilter | BabyAGI, 9.1 | (IndexeloIO_v2) |
| 9.3 | Online tanulás | 9.2, 0.2 | `OnlineTanulas_v1.idr` |
| 9.4 | Hangrendszer (Fano) | FanoParitas, KomplexByte | `HangrendszerKodolas_v1.idr` |
| 9.5 | Magánadatok | 9.2 | `Maganadatok_v1.idr` |
| 10.1 | GAN-ellenőrzés | 5.1-5.3, 9.5 | (task-alügynök) |
| 10.2 | Publikáció | 10.1, összes | `cikkek/episodic_memory_cikk.md` |
| 10.3 | 9. szint (élő) | összes | (főprogram) |
| 11.2 | GAN automatizálása | 11.1 | (task-hívás) |
| 11.3 | FordításEredménye | 11.1 | (idris2 exit 0) |
| 11.4 | NumerikusVerifikáció | 11.1 | (idris2 --exec) |
| 11.5 | IrodalomHivatkozás | 11.1 | (Hivatkozás record) |
| 11.6 | VizualizációGenerálás | 11.1 | (Mermaid/táblázat) |
| 11.7 | InteraktívProgram | 11.1 | (getLine + putStrLn) |
| 11.8 | DefinícióGenerálás | 11.1 | (typeclass/record) |
| 11.9 | VerifikációsJelentés | 11.1 | (jelentésÍrása) |
| 11.10 | A 43 feladat kiegészítése | 11.1, 11.5, 11.8 | (a terv átszerkesztése) |
| 11.11 | IrodalomKeresés (MCP) | 11.5 | (MCP-hívás) |
| 11.12 | DiagramGenerálás (MCP) | 11.6 | (MCP-hívás) |
| 11.13 | GAN-Visszacsatolás | 11.2 | (beépítés) |
| 11.14 | VerifikációsNapló | 11.9 | (kutatasi_naplo) |
| 11.15 | DemonstrációsMűsor | 10.3, összes | `DemonstraciosMusor_v1.idr` |

---

## A KÖVETKEZŐ LÉPÉS

A 0.1 (HungarianLexicon v2) javítása: a `sed` hibás volt (a `public export` és a szó neve egybeolvadt: `public exportn_abakusz : HuWord`). A javítás: új `sed` vagy az `edit` eszköz — a `public export` külön sorba kerül, nem egybeolvadva.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★