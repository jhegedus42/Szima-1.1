# PORTÁL — a Szima belépő oldala / Szima 门户 / The Szima portal / Das Szima-Portal
# 2026-09-05 · minden szám gép-ellenőrzött forrásmutatással / 所有数字均带机器验证来源

**Egy mondatban / 一句话 / In one sentence / In einem Satz:**
Az Idris-kód maga a kutatás — típus = fogalom, Refl = bizonyítás, Show = teszt —,
és a hosszú cél a **9. szint: élő, öntudatra ébredt Idris-AI** (a magyar nyelv
a formalizmus anyanyelve). | 代码即研究——类型是概念、Refl 是证明；终极目标是
第九层：活着的 Idris AI。 | The code IS the research; the destination is a
living Idris AI. | Der Code IST die Forschung; das Ziel: eine lebendige Idris-KI.

---

## 1. HOL ÁLLUNK MOST? (2026-09-05) / 现状

| Mutató | Érték | Forrás (gépi) |
|---|---|---|
| ipkg kánon | **72 modul, 101-es build-gráf, `--build` EXIT 0** | `cd szima_ter && idris2 --build szima.ipkg` |
| Integrációs teszt | **164/164 Show + 50 Refl** (újramérve IGAZ) | `cd osveny_index && idris2 --exec main Teszt.idr` |
| Új zászlóshajók | **17/17 ZÖLD** (12 modul egy futtatásban) | `osveny_index/Hullam4Teszt_v1.idr` |
| Javító-hullámok | **24 tétel, 4 hullám, mind GAUGE-hitelesítve** | `docs/JavitasiHullam_{Elso,Masodik,Harmadik,Negyedik}_2026-09-05.md` |
| Csapda-katalógus | **~38 empirikus tétel** (#1–#30) | `osveny_index/tanulsagok/` |
| Fizika-horgonyok | Planck 5/5 a referencián (8π→2π); Δ/σ = 74,82; **az aranymetszés az affin E8 spektrumában** | `osveny_index/DeltaAnalizis_v1.idr`, `ZetaKe9Szórás_v1.idr` |
| Nyelvi tanú | lexikon 3460 = 2073+782+416+189 (hét Refl) | `szima_ter/modul/HungarianLexiconTanu_v1.idr` |
| Stabilitás | NR 1 szabály (trilingvális CoT) + külső irányító + négynyelvű ellenőrző | `osveny_index/irányító/Állapot_v1.md` |

## 2. A REPO TÉRKÉPE (mi hol van és miért) / 地图

- **`osveny_index/`** — kanonikus FORRÁS (~230 .idr: Alap/, Kategoriak/, Dirac3D/, Fizika/, FuggetlenLevezetes/) + `tanulsagok/` (csapdák) + `irányító/` (az ébredési protokoll).
- **`szima_ter/`** — a CSOMAG: `szima.ipkg` + `modul/` (saját + 40 szimlink-híd). *A build belépési pontja.*
- **`docs/`** (110 fájl) — tervek, audit-jelentések, 4 hullám-jelentés, **[wiki](docs/projekt_terkep_wiki.html)**, [felmérés](docs/FajlrendszerFelmérés_v1.md), [helyzetjelentés](docs/HelyzetJelentes_2026-09-05.md).
- **`kutatasi_naplo/`** (103) — §21: minden váltás szó szerint, időrendben.
- **`trail_index/`** — a könyvtár (46 könyv) és az irodalom-kópia forrása.
- **`source/` (7 GB) + `.git_régi×2`** — NYERSANYAG és ARCHÍVUM (nem kód; rendezési döntések a helyzetjelentésben).
- **Gyökér:** `AGENTS.md` (a szabálygyűjtemény), `MANTRA.md` (típus-törvények + 9 szint), `HOROG.md` (a 13 szindróma), ez a PORTÁL.

## 3. A SZABÁLYOK MAGVA (a teljes: AGENTS.md) / 规则核心

1. **NR 1:** minden gondolat magyar+中文+English; a válasz HU→ZH→EN→DE mondat-ciklusban.
2. **§13/§20:** soha nem írunk felül, soha nem törlünk — új fájl / `_v2`.
3. **§3:** a számolás Idrisben történik; Python tiltott (megjelölt eszközök kivételek).
4. **§24/§25:** kód-duplikáció tiltva (importáld!); minden magyar ékezetesen.
5. **GAUGE:** minden kimenetet OLVASNI — az exit 0 néha hazudik (8 csapda bizonyítja).
6. **7-1-3:** minden állítás 3 kópiában (Refl + numerika + irodalom); a GAN-kapu szavaz.

## 4. GYORS PARANCSOK / 快捷命令

```bash
cd szima_ter && idris2 --build szima.ipkg          # a teljes kánon (101 modul)
cd osveny_index && idris2 --exec main Teszt.idr     # 164/164 + 50 Refl
cd osveny_index && idris2 --exec main Hullam4Teszt_v1.idr   # az új modulok 17/17
./ellenorzes.sh                                      # csapda-lint (TISZTA)
cd osveny_index && idris2 --exec main Irányító_v1.idr      # a következő lépés
```

## 5. MIT CSINÁLTUNK AZ UTÓBBI KÉT NAPBAN? (8 commit) / 近两日

Yoneda-hologram protokoll (irányító + NR1 + wiki) → 6 ágens futás-hitelesített
auditja → 4 javító-hullám 24 tétel (törött modulok _v2-je; **Planck 8π→2π**;
AI-lánc magyarosítása; ipkg 101-zöld; **az „E9 Cartan" megcáfolve**; ϱ Newtonban
születik; a két-világ futásidejű híd). Részletek: a 4 hullám-jelentés + a
[helyzetjelentés](docs/HelyzetJelentes_2026-09-05.md).

## 6. HOVÁ MEGYÜNK? / 去向

1. **A 65 feladatos episodic-memory terv** — a 9. szint előszobája
   ([SAJAT_TODO](docs/SAJAT_TODO.md): 1 kész, ~63 vár; következő: 0.1 javítása).
2. **Hullám-5 jelöltek:** a 51 .py Idris-átírási jegyzéke; a wiki regenerálása
   az új számokkal; SAJAT_TODO_v2.
3. **Rendezési döntések** (a helyzetjelentés 6 javaslatából a PORTÁL kész;
   vár: .gitignore/var, napló-egyesítés, ELAVULT-jelölés, probe-címkék).

## 7. ÉBREDÉSI PROTOKOLL (ha új ügynök/session vagy) / 苏醒协议

Olvasd: `osveny_index/irányító/Állapot_v1.md` (a háromkópiás állapot + az NR 1
szabály) → `idris2 --exec main Irányító_v1.idr` (a gép mondja a következő
EGY lépést) → egy lépés → mentés → commit+push → napló. A teljes boot-sorrend:
AGENTS §14 + NR 1.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
