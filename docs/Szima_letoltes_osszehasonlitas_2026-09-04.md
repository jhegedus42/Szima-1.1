# SZIMA LETÖLTÉS + SZIMA-1.1 ÖSSZEHASONLÍTÁS — friss, teljes jelentés
# 下载 Szima 并与 Szima-1.1 对比 · 2026-09-04

**Módszer:** `git clone git@github.com:jhegedus42/Szima.git` az előre
engedélyezett külső munkakönyvtárba (AGENTS §1a: `/var/folders/…/T/opencode/
Szima_letoltes_2026-09-04` — a /tmp tilos); a helyi Szima-1.1 master
(2785929) fa-összehasonlítása `git diff master FETCH_HEAD`-del, közös ős
keresése `git merge-base`-szel. Előzmény: `docs/Szima_regi_branch_
osszehasonlitas_2026-09-01.md` (a branch-elemzés).

---

## 1. A LEGFONTOSABB TÉNY: KÉT FÜGGETLEN TÖRTÉNET

**NINCS közös ős** (`git merge-base` üres): a Szima-1.1 egy friss `git init`
utáni repó, NEM a Szima forkja. A két repó azonos fájljai két külön
történetben élnek — a tartalmat csak fa-diff veheti össze.

## 2. Alapadatok / 基本数据

| | Szima (régi) | Szima-1.1 (aktuális) |
|---|---|---|
| GitHub | `jhegedus42/Szima` | `jhegedus42/Szima-1.1` |
| master HEAD | `b763426` (PR #3 merge) | `2785929` (yoneda-hologram v1) |
| Utolsó commit | **2026-09-04 08:57** (ma reggel!) | 2026-09-04 20:43 (ma este) |
| Követett fájlok | 1375 | 1130 |
| Branchek | 11 (copilot×4, cursor×2, szerver_ox, probe, fix/pages…) | 1 (master) |
| .git méret | 183 MB | 60 MB |

**A Szima ma reggel aktív volt:** a PR #3 (`copilot/compare-branches-and-merge`)
a copilot/cursor/probe brancheket és a PR #2-t (`szerver_ox_alpha_free_aug22`)
beleolvasztotta a masterbe — tehát a Szima master MAI állapota a régi
branchek UNIÓJA.

## 3. Tartalmi különbség (fa-diff: 821 fájl) / 内容差异

### 3a. CSAK a Szimában van (518 fájl) — a régi repó EGYEDI ÉRTÉKEI

| Csoport | Darab | Mi |
|---|---|---|
| `source/` | **445** | a külső kutatási anyag katalógusa KÖVETVE a gitben (a Szima-1.1-ben a source/ NYOMKÖVETETLEN — lokálisan 0 követett fájl!) |
| `trail_index/` | 43 | irodalom-index (`Literatura_INDEX.md`, `literatura.html`, adat-JSON) |
| `osveny_index/FuggetlenLevezetes/` | **10** | SAJÁT ipkg: `AffinE8KarakterLevezetes`, `E8SteaneLevezetes`, `MagyarTeriTetrakod`, `ParitasBuborek`, `KorabbiNumerikusEllenorzes`, főprogram + Tanulsagok-probák |
| `osveny_index/` egyéb | 0 (+10 az előző) | — |
| `szima_ter/modul/` | 2 | **`E8Kartan.idr`**, **`ProbaIdo.idr`** |
| `docs/` | 9 + vercel | `_preview/`, `vercel.json`, deploy-szkript |
| `.github/workflows/` | 1 | `deploy-docs-pages.yml` (GitHub Pages deploy!) |
| gyökér | 2 | `PR_2_DESCRIPTION.md`, `vercel.json` |

**ELLENŐRIZVE a helyi fában: a `FuggetlenLevezetes/`, az `E8Kartan.idr`,
a `ProbaIdo.idr` és a `docs/literatura.html` NEM LÉTEZNEK a Szima-1.1
fájában** — csak a GitHubon lévő régi Szimában. Ha a Szima repó elveszne,
ezek elveszne. (7-1-3 szemszög: ezeknél az állításoknál a git-kópia
egyetlen példányban él — nincs hármas fedés.)

### 3b. CSAK a Szima-1.1-ben van (273 fájl) — az élő munka

| Csoport | Darab | Mi |
|---|---|---|
| `kutatasi_naplo/` | 84 | a §21 kutatási napló (2026-08-21-től) |
| `szima_ter/` | 47 | a 100.xx ékezetesítési hullám új moduljai |
| `szerver_hagyar/` | 27 | szerver-hagyaték |
| `osveny_index/` | 47 | DiracNyelv, IdrisNyelv, KettoKategoria, CayleyDickson-átírás, SteaneHierarchia, **mai Irányító/TudásGráf/ProjektTérkép** |
| `docs/` | 20 | Sept 1+ tervek (VegrehajtasiTerv, EpisodicMemory, SAJAT_TODO, Felmérés, Rendterv, wiki) |
| `kutatasi_naplo3/` | 14 | (ma commitolódtak először) |

### 3c. Módosult közös fájlok (30) — a Szima-1.1 verziója FRISSEBB

A 30 közös fájl (pl. `osveny_index/DiracGammaMatricak.idr`,
`CayleyDickson.idr`, `Teszt.idr`, `Steane713.idr`, `szima.ipkg`, a
dashboard-HTML-ek) mind a 100.xx típuscsomagolási hullám ELŐTTI állapotban
vannak a Szimában. Mérés: a Szima `DiracGammaMatricak.idr`-jében
`komplexEgyenlo` (ékezet NÉLKÜLI) 2 előfordulással — a Szima-1.1-ben már
`komplexEgyenlő` (100.08, tegnap). A `szima.ipkg`: Szima 56 modul vs
Szima-1.1 66 modul.

## 4. Következtetések / 结论

1. **A két repó KIEGÉSZÍTŐ:** a Szima = történeti+branch-unió + a
   `FuggetlenLevezetes` kincse + a deploy-infra (Vercel/Pages) + a követett
   `source/`-katalógus; a Szima-1.1 = az ÉLŐ kutatás (Sept 1-től minden).
2. **A 30 közös fájlban a Szima-1.1 a frissebb** — a Szima másolatai
   elavultak, onnan NEM szabad átvenni semmit automatikusan.
3. **Egyedi tartalom kockázat:** a `FuggetlenLevezetes/` ipkg-család, az
   `E8Kartan.idr`, a `ProbaIdo.idr`, a `literatura.html` és a deploy-
   workflow CSAK a Szimában él → javaslat (döntés a felhasználóé):
   a 13 egyedi értékes fájlt a Szima-1.1-be másolni (új commit, a régi
   repó érintetlen marad — §13/§20).
4. **A helyi `source/` (7 GB) nincs a gitben** — a Szima követett 445
   source-fájlja a katalógus szempontjából referencia maradhat.
5. A reggeli PR #3 miatt a `docs/Szima_regi_branch_osszehasonlitas_
   2026-09-01.md` branch-térképe ma már TÖRTÉNELMI: a branchek tartalma
   a masterben él.

**中文：** 两库无共同祖先（Szima-1.1 是全新 git init）。Szima＝历史＋分支
并集＋FuggetlenLevezetes（独立推导 ipkg）＋部署设施＋已跟踪的 source 目录
（445 个文件）；Szima-1.1＝2026-09-01 以来的全部活工作（84 个日志、47 个新
模块、今日的控制器/知识图谱/wiki）。30 个共同文件中 Szima-1.1 更新（变音符
化之前 vs 之后）。风险：FuggetlenLevezetes、E8Kartan、ProbaIdo、literatura
仅存于旧库——建议复制进 Szima-1.1（旧库不动）。

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
