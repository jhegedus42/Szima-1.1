# FÁJLRENDSZER-FELMÉRÉS — a Szima repó teljes térképe
# 文件系统普查——Szima 仓库全图 · v1 (2026-09-04)

**Készült:** a külső determinisztikus irányító (`osveny_index/Irányító_v1.idr`)
1. lépéseként. **Szabály:** semmit nem mozgatunk, semmit nem törlünk (AGENTS
§13, §20) — ez a dokumentum CSAK feltérképez. A rendezési JAVASLATOK a
`docs/FajlrendszerRendterv_v1.md`-ben vannak; mozgatás kizárólag a felhasználó
jóváhagyása után.
**本文件仅为普查，不移动、不删除任何文件；整理建议另见 Rendterv，移动须获批准。**

**Módszer:** `find -type l`, `du -sh`, `ls` — csak olvasási parancsok; az
eredmények újrafuttathatók (GAUGE-elv).

---

## 0. ÖSSZEFOGLALÓ EGY TÁBLÁZATBAN / 总览

| Könyvtár | Méret | Szerepkör | Miért kell / 为什么需要 |
|---|---|---|---|
| `osveny_index/` | 20 MB | **KANONIKUS forrás** | ~181 .idr: a típuscsomagolási hullám (100.xx) otthona; ide mutatnak a szima_ter-i szimlinkek · 规范源：类型化重写浪潮之家 |
| `szima_ter/` | 72 MB | **KANONIKUS csomag** | `szima.ipkg` + ~139 .idr forrás (a „SZILÁRD ALAP" ~64 kurátori modulja) + build-ttc · 规范打包层 |
| `docs/` | 11 MB | **KANONIKUS dokumentáció** | ~90 md: tervek, review-k, dashboardok · 规范文档 |
| `kutatasi_naplo/` | 7,4 MB | **KANONIKUS napló** | 102 fájl, 2026-08-21-től (§21) · 规范研究日志 |
| `trail_index/` | 38 MB | **KANONIKUS könyvtár+index** | 46 könyv (Awodey, Mac Lane, Shoup, Lumo…), idris2_docs, cikkek · 书库与索引 |
| `skills/` | 148 kB | KANONIKUS skill-ek | repón belüli skill-definíciók (idris-stilus stb.) |
| `tanulsagok/` | 8 kB | KANONIKUS tanulságok | gyökér-szintű tanulság-jegyzék |
| `horgony/` | 2 MB | KANONIKUS mérési horgonyok | α, CODATA-összehasonlítások (§17) |
| `memory/`, `plans/`, `cikkek/` | <1 MB | KANONIKUS kiegészítők | why-chain.jsonl lexikon, tervek, cikkek |
| `zene_es_zaj/` | 165 MB | KUTATÁSI ADAT | zene-elemzési nyersanyag (Sziami-dalok) — a hang/fázis kutatáshoz |
| `diagnosztika/` | 23 MB | KUTATÁSI ADAT | diagnosztikai eszközök/kimenetek |
| `szerver_hagyar/` | 328 kB | HAGYATÉK | szerver-elérés maradványai (l. szerver-ismeret skill) |
| `source/` | 7,0 GB | **NYERSANYAG** | KÜLSŐ kutatási anyag — NEM a Szima kódja (l. §3 alul) · 外部原材料，非本项目代码 |
| `.git_régi/`, `.git_régi2/` | 795+747 MB | **ARCHÍVUM** | két levált git-történelem — nem nyúlunk hozzá · 旧 git 历史，不动 |
| `build/` | 2,1 MB | MELLÉKTERMÉK | Idris fordítási maradvány |
| `.opencode/`, `.playwright-mcp/` | 61+0,6 MB | MELLÉKTERMÉK | eszközök node-moduljai, böngésző-nyomok |
| `kutatasi_naplo2/` | 720 kB | **RENDTELNÉS** | plugin-naplók + `datjumok/download.txt` — l. §4 · 杂乱遗留 |
| `kutatasi_naplo3/` | 9,5 MB | **RENDTELNÉS** | elásott .idr-k + EGY MÁSODIK naplóhalmaz — l. §4 |
| `session_export/` | 0 B | ÜRES | valószínűleg a session-exportoknak szánták — üresem áll |
| `.github/` | 4 kB | CI | repo-beállítások |

---

## 1. A HAT SZIMLINK — A KÉT KÓDBÁZIS HÍDJA / 六个符号链接——两库之桥

**Legfontosabb szerkezeti felfedezés:** a `szima_ter/modul/` hat kulcsmodula
NEM másolat, hanem **szimlink az `osveny_index/`-re**. Az `osveny_index/` a
kanonikus forrás; a `szima_ter/` a csomagoló réteg. Ez NEM kód-duplikáció
(§24), hanem SZÁNDÉKOS híd: egy forrás, két nézőpont.
**重要发现：szima_ter 六个关键模块是指向 osveny_index 的符号链接——一源两视图，非重复。**

| Szimlink | Cél |
|---|---|
| `szima_ter/modul/Steane713.idr` | `../../osveny_index/Steane713.idr` |
| `szima_ter/modul/FazisAlgebra.idr` | `../../osveny_index/FazisAlgebra.idr` |
| `szima_ter/modul/HaromKubit.idr` | `../../osveny_index/HaromKubit.idr` |
| `szima_ter/modul/E8E8Algebra.idr` | `../../osveny_index/E8E8Algebra.idr` |
| `szima_ter/modul/Alap/KategoriaT.idr` | `../../../osveny_index/Alap/KategoriaT.idr` |
| `szima_ter/modul/Kategoriak/MagyarOntologia.idr` | `../../../osveny_index/Kategoriak/MagyarOntologia.idr` |

(Változás dátuma: 2026-08-23. A gyökérben nincs szimlink; a többi talált
szimlink `node_modules/.bin`-beli, eszköz-melléktermék.)

---

## 2. A GYÖKÉR FÁJLJAI (~89 bejegyzés) — szerepkörönként / 根目录文件按角色

### 2a. KANONIKUS gyökérdokumentumok (5)
- `AGENTS.md` — az ügynök kemény szabályai (§0–§25)
- `MANTRA.md` — a típus-szabályok és a 9 szint hierarchiája
- `HOROG.md` — a 12 szindróma + bírák + célok önéleztetője
- `README.md`, `LICENSE`

### 2b. KANONIKUS LaTeX-könyv (4 valódi + 5 melléktermék)
- `konyv.tex` + `konyv.pdf`, `konyv_v2.tex` + `konyv_v2.pdf`, `bizonyitasok.tex` + `bizonyitasok.pdf`
- MELLÉKTERMÉK: `.aux/.log/.out/.toc` fájlok (9 db) — újragenerálhatók

### 2c. ESZKÖZ-PYTHON (~14 db) — bejelentve (§3 kivétel-szabály: meglévő eszközök)
`delta_analizis.py`, `e8_4_heatmap.py`, `e8_4_sphere.py`, `e8_4_unitary_heatmap.py`,
`e8_e9_cpt_inside.py`, `e8_e9_cpt_inside_static.py`, `e8_e9_cpt_wave.py`,
`instanton_lyuk.py`, `kor_ujraolvasa_check.py`, `landauer_nyelv.py`,
`ro_fixpont_plot.py`, `steane_3d.py`, `steane_scipy.py`, `zeta_ke9_spectrum.py`
— mind VIZUALIZÁCIÓ (PNG/GIF-t rajzol). Az „Idris számol, a rajzoló rajzol"
elv szerint az adatforrás Idris kell legyen; a jövőben az ellenőrzött út:
Idris → adat → rajzoló. Új Python NEM készül (§3).

### 2d. Kép/GIF-melléktermékek (~8 db)
`attekintes_ellenorzes.png`, `e8_4_heatmap.png`, `e8_4_sphere_mag.png`,
`e8_4_sphere_phase.png`, `e8_4_unitary_heatmap.png`, `e8_e9_cpt_wave.gif`,
`ro_fixpont_plot.png`, `steane_3d_fele.png`, `steane_scipy.gif`,
`steane_scipy_frame0.png`, `zeta_ke9_spectrum.png`, `steane_3d.html`

### 2e. TERVEK/JEGYZETEK gyökérben (4)
`kategoria_katalogus.md` (110+ kategória, HOROG hivatkozza), `NOBEL_CEL_TERKEP.md`,
`otletek_megertes_hibajavitas.md`, `terv_donteshozo_rendszer.md`, `FaVizualizacio.idr`

### 2f. SESSION-EXPORTOK (~18 db) — RENDTELNÉS
`session-ses_00a2*.md` (9 db), `session-ses_00ae.md`, `session-ses_00ca.md`,
`session-ses_04f3.md`, `session-ses_074e.md`, `session-ses_fe95*.md` (5 db),
`session_export.md`, `session_export_ses_04b6cfaa.md`
— a `.gitignore` a `session-*.md` mintát KIZÁRJA: ezek a fájlnevek NEM is
commitolódnak (de lokálisan itt vannak). Az üres `session_export/` mappa
valószínűleg az összegyűjtésükre volt tervezve.

### 2g. EGYÉB
`copilot-Aug1-checker-agent` — korábbi eszköz-maradvány.

---

## 3. `source/` — a 7 GB NYERSANYAG (NEM a Szima kódja) / 外部原材料

| Almappa | Méret | Mi |
|---|---|---|
| `OKComputer_Algorithm_Idea_Extraction 3/` | 1,1 GB | külső projekt-másolat |
| `OKComputer_3-Layer_Additive_NN` + ` 2`…` 5` | ~1,9 GB összesen | **UGYANAZ a projekt ÖTSZÖR** (macOS „ másolat" sorszámozással) |
| `small/` | 778 MB | kis kísérleti projektek (terminal-mcp, stagehand, eigent…) |
| `n8n-mcp/` | 753 MB | n8n MCP szerver klón |
| `gondnok-laptop/` | 235 MB | a ProtonDrive-katalógus másolata (mega_catalog.json 15 MB, source_signature_graph.json 152 MB) |
| `Kimi_Agent_Metaforikus Fizika File Request/` | 80 MB | Kimi-metaforikus-fizika anyag |
| `tasks/`, `cline/`, `deepseek-exporter/`, `deepseekPage/`, `gut/`, `lumo/`, `claude/`, `fromdownload/`, `workspace/`, `Metaforikus…files/` | 6–28 MB | további külső exportok/klónok |

**Megjegyzés:** a méret duplikációból (` 2`–` 5` mappák) jelentős részt
foglal; SEMMIT nem törlünk — a Rendterv csak jelzi a tényt.

---

## 4. A HÁROM NAPLÓ-KÖNYVTÁR — a fő RENDTELNÉS / 三个日志目录

| Könyvtár | Tartalom | Állapot |
|---|---|---|
| `kutatasi_naplo/` | 102 fájl, 2026-08-21-től naprakész | **KANONIKUS** (§21) |
| `kutatasi_naplo2/` | 4 plugin-napló (`.log`, 2026-08-23…09-04) + `datjumok/download.txt` | rendetlen perem |
| `kutatasi_naplo3/` | `KonstansHitelesites.idr` (19 kB, 2026-08-29), `MindenKonstans.idr` (29 kB, 2026-08-29) + **saját `kutatasi_naplo/` almappa 14 fájllal** (2026-08-29…08-30, E8-Pauli, port-hitelesítés…) | **.idr-k NAPLÓ-mappában** — a modulfán kívül |

**A két elásott .idr kérdése:** a `KonstansHitelesites.idr` és `MindenKonstans.idr`
a típuscsomagolási/ékezetesítési hullám ELŐTTI generáció (2026-08-29). A
`kutatasi_naplo3/kutatasi_naplo/` bejegyzései (pl. `2026-08-29_idris_port_
hitelesites.md`) írják le őket. Kanonikus-e valamelyik? — a Rendterv foglalkozik
veluk ( javaslat: NEM mozgatjuk, a TudásGráf Könyvtár-Hely csomópontként
jegyzi, a tartalmuk import-szempontból felmérendő a BFS hullámaiban).

---

## 5. STATISZTIKA / 统计

- **Idris-forrásfájlok:** ~415 db repó-szerte (139: szima_ter/modul, 181:
  osveny_index, továbbiak trail_index/source-rész); a `szima.ipkg` ~64
  kurátori modult sorol (13 szándékosan kivonva, de megtartva).
- **Könyvek:** 46 tétel a `trail_index/books/`-ben + `forras/` (magyar
  nyelvészet ~12 MB).
- **docs/:** ~90 markdown.
- **Napló:** 102 + 5 + 3(+14) fájl a három könyvtárban.
- **Teszt-állapot (utolsó commit):** 164/164 integrációs Show-teszt +
  50 Refl-szint zöld (`osveny_index/Teszt.idr`, `Attekintes.idr`).
- **Git:** master, tiszta munkaterület a felmérés pillanatában; remote
  `git@github.com:jhegedus42/Szima.git`.

---

## 6. MI ÉRTÜK MEG A FELMÉRBŐL (Yoneda: a jelentés a kapcsolatokból) / 普查结论

1. **A repó két szívverése** — `osveny_index/` (forrás) és `szima_ter/`
   (csomag) — egy szimlink-hídon át ver együtt. Minden további elem ehhez
   a két ponthoz kötődik: a docs/ leírja, a Teszt/Attekintes méri, a
   napló kronológiája megköti.
2. **A rendetlenség három góca** van, mind perem: (a) `source/` 7 GB
   külső anyag, (b) a három napló, (c) a gyökér ~35 melléktermék/export.
   A MAG (két kódbázis + docs + trail_index) rendezett.
3. **A `kutatasi_naplo3`-beli .idr-k** a gráf „elszigetelt csomópontjai":
   senki nem importálja őket — a BFS első könyv-hulláma előtt fel kell
   mérni, mi a viszonyuk a kanonikus konstans-modulokhoz.
4. **Semmi sem veszett el** (§20): minden rendetlenség megnevezett,
   javaslat a Rendtervben — döntés a felhasználóé.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
