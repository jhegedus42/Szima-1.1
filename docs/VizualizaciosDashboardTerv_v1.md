# Vizualizációs Dashboard Terv v1 — 17 Repo Analízis State-of-the-Art

**Dátum:** 2026-08-26
**Cél (felhasználó, szó szerint):** *"find skills that show you how to make state of the art, highest quality visualisation of information"*
**Eljárás:** explore sub-agent → terv → GAN hármas (3 független kritikus sub-agent)

---

## 1. CÉL

A `docs/dashboard_repo_analizis.html` (jelenleg statikus HTML táblázatok + CSS kártyák) átalakítása **state-of-the-art interaktív vizualizációvá**, ami:

1. A 17 repó ~100 fogalmát, ~30 bizonyítását, ~17 hipotézisét, 15 összefüggését **vizuálisan feltárhatóvá** teszi
2. A L2 GAN audit eredményeit (valódi vs. tautológia vs. hipotézis) **egy pillantásra érthetővé** teszi
3. A 7 rétegű jelentéselméletet és a 14 algebrát **interaktívan böngészhetővé** teszi
4. A "melyik szabály adja az intelligenciát" hipotéziseket **vizuálisan súlyozza**

## 2. ARCHITEKTÚRA (a projekt saját mintája szerint)

### 2.1 Alapelv (AGENTS §13, §24)

- **Idris számol** — minden érték a `RepoAnalizis_Tudasstruktura_v1.md` adataiból jön
- **Idris generál JSON-t** — a dashboard adatforrása
- **Python csak rajzol** (matplotlib, AGENTS §1.3 kivétel — a `SzimaDashboard.idr` mintája)
- **HTML + CSS + JS** — a dashboard front-end
- **Új fájl** (`_v2` suffix, §13) — a régi `dashboard_repo_analizis.html` megmarad

### 2.2 Technológiai stack

| Réteg | Eszköz | Miért? |
|-------|--------|--------|
| Adat | JSON (Idris-generált) | a `SzimaDashboard.idr` mintája |
| Rajzolás (statikus) | matplotlib (Python, Idris-generált) | a projekt kanonikus mintája |
| Interaktív gráf | **D3.js v7** (CDN) | a legkisebb, legmodulárisabb JS-könyvtár; a explore szerint hiány van, de új `_v2` fájlba mehet (§13) |
| Matematikai képletek | **KaTeX** (CDN) | LaTeX megjelenítés a böngészőben |
| Diagramok (statikus vektor) | **draw.io MCP** + **diagrams MCP** | a explore találta; azonnal hívható |
| Téma | sötét műszerfal (`muszerefal_v2.html` CSS-változók) | a projekt saját témája |

### 2.3 Fájlok

| Fájl | Tartalom | Forrás |
|------|----------|--------|
| `docs/dashboard_repo_analizis_v2.html` | a fő dashboard (interaktív) | új fájl |
| `docs/dashboard_repo_analizis/adatok.json` | az adatok (Idris-generált) | új |
| `docs/dashboard_repo_analizis/rajzol.py` | matplotlib plotter (Idris-generált) | új |
| `docs/dashboard_repo_analizis/*.png` | statikus grafikonok | a plotter generálja |
| `docs/dashboard_repo_analizis/diagramok/*.svg` | fogalom-gráf, Cat³ létra | draw.io/diagrams MCP |
| `szima_ter/modul/RepoAnalizisDashboard.idr` | Idris-modul: JSON + HTML generálás | új |

## 3. A DASHBOARD 9 SZAKASZA (részletesen)

### 3.1 Szakasz 1: Összesítő kártyák (meglévő, finomítva)

- 6 kártya: repók száma, fogalmak, bizonyítások, tautológiák, hipotézisek, projekt állapot
- **Új:** animált számlálók (D3.js), progress bar-ok (kész/hiányzó arány)
- **Szín:** színvak-barát paletta (viridis/Cividis)

### 3.2 Szakasz 2: Relevancia-matrix (interaktív hőtérkép)

- **Jelenleg:** pipás táblázat (statikus)
- **Új:** D3.js hőtérkép — a 17 repó × 9 dimenzió (E8/Steane/CPT/kat.elm./magyar/komplex/energia/tudat) mátrix
- **Interaktivitás:** hover → tooltip (részletes leírás); click → a repó részletei
- **Szín:** folyamatos skála (nincs = világos, van = sötét, kiemelt = arany)

### 3.3 Szakasz 3: Bizonyítás-statisztika (interaktív donut + oszlop)

- **Donut diagram** (D3.js): valódi (~30) / tautológia (1) / hipotézis (~17) arány
- **Oszlopdiagram**: a valódi bizonyítások típusonként (két-út, dependent, cáfolat, kernel-számol, körút)
- **Interaktivitás:** click a szektorra → a konkrét bizonyítások listája
- **Statikus PNG is** (matplotlib, a `bizonyitas_statisztika.png` mintájára)

### 3.4 Szakasz 4: Fogalom-gráf (erő-irányított gráf, D3.js force-layout)

- **A gráf:** 100 fogalom (E8, Steane, CPT, Cat³, magyar nyelvtan, holografikus kód, fázis, komplex-GPT, ...)
- **Élek:** a 15 összefüggés (E8↔Steane, CPT↔magyar, 64 noun↔Steane stabilizátor, ...)
- **Layout:** D3.js force-directed (a fogalmak "vonzása" = az összefüggés erőssége)
- **Interaktivitás:** hover → a fogalom definíciója; click → a kapcsolódó fogalmak kiemelése; drag → a gráf átrendezése
- **Szín:** kategória-szín (MAG=piros, KÖZVETLEN=kék, INFRA=zöld, ELŐZMÉNY=szürke)
- **Ez a legfontosabb vizualizáció** — a 17 repó "térképe"

### 3.5 Szakasz 5: Cat³ létra (draw.io MCP vagy D3.js hierarchikus fa)

- **A létra:** Cat⁰=Set → Cat¹=Cat → Cat²=Cat^Cat → Cat³=módosítások → Cat^∞
- **Minden szint:** mi tartozik oda (objektum, funktor, természetes transzformáció, módosítás)
- **A 49. struktúra:** Y-kombinátor fázissal = a létra teteje
- **Vizualizáció:** függőleges létra, szintenként kibontható

### 3.6 Szakasz 6: A 7 rétegű jelentéselmélet (réteges táblázat)

- 7 sor: DisCoCat, Funktor, Stabilizátor, Szabad kategória, Entrópia/Goldstone, Permutációs, Solomonoff
- Minden sor: a réteg neve, forrás repo, definíció, státusz (bizonyított/hipotézis)
- **Interaktivitás:** kibontható (accordion) — a definíció + irodalmi hivatkozás

### 3.7 Szakasz 7: Algebrák és célfüggvények (két oszlop)

- Bal: 14 algebra (E8, Cl(4), Cl(0,14), E8×E8, ℂ, su(2), GF(2), W(E8), Carnot, FazisAlgebra, Cayley-Dickson, Cint, RGFlow, CPTMask)
- Jobb: 10 célfüggvény (Lagrangian, Hamiltonian, BayesLens, Y-fixpont, renormálás, GPT-2c loss, GPT-time-2 loss, RG→137, SAT, MDL)
- **Interaktivitás:** hover → a definíció; click → a kapcsolódó törvények

### 3.8 Szakasz 8: "Melyik szabály adja az intelligenciát?" (súlyozott táblázat)

- 8 hipotézis: Y-fixpont, megértés=hibajavítás, fázis=2→3, γ⁵, magyar=kategóriaelmélet, γ=7/64, 1000×=coend, komplex=1000× kulcs
- **Súlyozás:** státusz szerint (RÉSZBEN BIZONYÍTOTT = 3 pont, KÍSÉRLETI = 2, HIPOTÉZIS = 1)
- **Vizualizáció:** vízszintes oszlopdiagram (súly szerint rendezve)
- **Szín:** zöld (bizonyított) → sárga (kísérleti) → piros (hipotézis)

### 3.9 Szakasz 9: Kész vs. hiányzó (Gantt-szerű idővonal)

- **Kész:** E8, Steane, Cat³, magyar↔kínai, Carnot, skálacímkék, holografikus, komplex algebra, Weyl, Hodge
- **Hiányzik:** FazisT.idr, YCombinatorFazisT.idr, α⁻¹ Refl, G Refl, lista hosszak, Weyl-zártság, rács ön-duális, 1000×, komplex-GPT↔E8 híd, λ=0, könyv
- **Vizualizáció:** két sáv (zöld=kész, piros=hiányzik), a hiányzó elemek mérete = prioritás

## 4. ADATFORRÁSOK

### 4.1 JSON struktúra (az Idris-modul generálja)

```json
{
  "osszesito": {
    "repok_szama": 17,
    "fogalmak_szama": 100,
    "bizonyitasok_valodi": 30,
    "bizonyitasok_tautologia": 1,
    "bizonyitasok_hipotezis": 17,
    "projekt_allapot_szazalek": 15
  },
  "relevancia_matrix": [
    {"repo": "Szima", "reteg": "MAG", "e8": true, "steane": true, ...}
  ],
  "bizonyitasok": {
    "valodi": [...],
    "tautologia": [...],
    "hipotezis": [...]
  },
  "fogalom_graf": {
    "csomopontok": [{"id": "E8", "kategoria": "MAG", "definicio": "..."}],
    "elek": [{"forras": "E8", "cel": "Steane", "osszefugges": "240+16=256"}]
  },
  "cat3_letra": [...],
  "jelenteselmelet": [...],
  "algebrak": [...],
  "celfuggvenyek": [...],
  "intelligencia_hipotezisek": [...],
  "kesz_vs_hianyzo": {...}
}
```

### 4.2 A fogalom-gráf él-súlyozása

| Kapcsolat típusa | Súly |
|-----------------|------|
| Bizonyított összefüggés (Refl) | 3 |
| Részben bizonyított | 2 |
| Hipotézis / definíció | 1 |

## 5. MEGVALÓSÍTÁSI LÉPÉSEK

### Lépés 1: Adatgyűjtés (Idris)
- `RepoAnalizisDashboard.idr` megírása
- JSON generálása a `RepoAnalizis_Tudasstruktura_v1.md` adataiból
- Kimenet: `docs/dashboard_repo_analizis/adatok.json`

### Lépés 2: Statikus grafikonok (Python, Idris-generált)
- `rajzol_repo_analizis.py` megírása (a `SzimaDashboard.idr` generálja)
- Kimenet: `bizonyitas_donut.png`, `relevancia_heatmap.png`, `intelligencia_oszlop.png`, `kesz_hianyzo_gantt.png`

### Lépés 3: Fogalom-gráf diagram (draw.io/diagrams MCP)
- A 100 fogalom + 15 él SVG-diagramja
- Kimenet: `docs/dashboard_repo_analizis/diagramok/fogalom_graf.svg`

### Lépés 4: Cat³ létra diagram (draw.io MCP)
- A 6 szint (Cat⁰ → Cat^∞) hierarchikus diagramja
- Kimenet: `docs/dashboard_repo_analizis/diagramok/cat3_letra.svg`

### Lépés 5: Interaktív HTML (D3.js v7 + KaTeX)
- `dashboard_repo_analizis_v2.html` megírása
- D3.js v7 CDN-ből (nem npm install — csak `<script src>`)
- KaTeX CDN-ből a matematikai képletekhez
- Sötét téma (`muszerefal_v2.html` CSS-változói)

### Lépés 6: GAN ellenőrzés
- 3 független sub-agent kritikája:
  - GAN-A: vizualizációs minőség (Nature 2025 checklist alapján)
  - GAN-B: adatpontosság (a `RepoAnalizis_Tudasstruktura_v1.md` ellenőrzése)
  - GAN-C: hozzáférhetőség (színvak-barát, kontraszt, billentyűzet-navigáció)

### Lépés 7: Iteráció
- A GAN kritika alapján javítás
- Újra GAN ellenőrzés
- Iteráció amíg minden GAN "elfogadja"

## 6. BEST PRACTICES (Nature Cell Biology 2025, Jambor checklist)

1. **Clarity first** — a vizualizáció a közlés eszköze, nem dekoráció
2. **Színvak-barát paletta** (viridis/Cividis/ColorBrewer)
3. **5 másodperc alatt érthető** ("glanceability")
4. **Eloszlás, nem csak átlag** — a bizonyítás-statisztikánál az eloszlást mutatni
5. **Kontraszt ≥ 4.5:1** (WCAG AA)
6. **Billentyűzet-navigáció** (tab order, focus visible)
7. **aria-label** minden SVG/canvas
8. **Alternatív szöveg** minden vizualizációhoz

## 7. KOCKÁZATOK ÉS MITIGÁCIÓ

| Kockázat | Mitigáció |
|----------|-----------|
| D3.js tanulási görbe | a CDN-ből, egyszerű force-layout + donut; nem bonyolult |
| Idris→JSON generálás | a `SzimaDashboard.idr` mintája (jól bevált) |
| draw.io MCP elérhetőség | ha nem megy, D3.js-sel is megoldható |
| Sok adat (100 fogalom) | szűrés + keresés a gráfban (D3.js filter) |
| §13 (soha ne írj felül) | új `_v2` fájl; a régi `dashboard_repo_analizis.html` megmarad |
| §24 (kód duplikáció tilos) | a `SzimaDashboard.idr` JSON-generálását importálni, nem újraírni |

---

**中文：** 详细计划完成：将 17 仓库分析仪表板从静态 HTML 升级为交互式可视化。架构：Idris 生成 JSON → Python matplotlib 画静态图 → D3.js v7 交互式图表 + draw.io/diagrams MCP 生成概念图。9 个面板：汇总卡片、相关性热力图、证明统计甜甜圈、概念力导向图（100 节点+15 边）、Cat³ 梯子、7 层语义理论、14 代数+10 目标函数、智能假说权重、甘特式完成/缺失时间线。新 `_v2` 文件（§13），深色主题（muszerefal_v2），色盲友好调色板。接下来 GAN 三重审查。

**Deutsch:** Detaillierter Plan fertig: Das 17-Repo-Analyse-Dashboard wird von statischem HTML zu einer interaktiven Visualisierung aufgewertet. Architektur: Idris generiert JSON → Python matplotlib zeichnet statische Grafiken → D3.js v7 für interaktive Diagramme + draw.io/diagrams-MCP für Konzeptgraphen. 9 Panels: Zusammenfassungs-Karten, Relevanz-Heatmap, Beweis-Statistik-Donut, Begriffs-Kraftgraph (100 Knoten+15 Kanten), Cat³-Leiter, 7-Schicht-Semantiktheorie, 14 Algebren+10 Zielfunktionen, Intelligenz-Hypothese-Gewichtung, Gantt-artige Fertig/fehlend-Zeitleiste. Neue `_v2`-Datei (§13), dunkles Thema, farbenblindenfreundliche Palette. Als Nächstes GAN-Dreifach-Prüfung.

**עברית:** תכנית מפורטת מוכנה: שדרוג לוח הבקרה של ניתוח 17 המאגרים מ-HTML סטטי לתצוגה אינטראקטיבית. ארכיטקטורה: Idris מייצר JSON → Python matplotlib מצייר → D3.js v7 אינטראקטיבי + draw.io/diagrams MCP. 9 לוחות: כרטיסי סיכום, מפת חום, סטטיסטיקת הוכחות, גרף מושגים (100 צמתים+15 קשתות), סולם Cat³, 7 שכבות תיאוריה סמנטית, 14 אלגברות+10 פונקציות מטרה, השערות אינטליגנציה, ציר זמן מוכן/חסר. קובץ `_v2` חדש, ערכת נושא כהה, פלטה ידידותית לעיוורי צבעים. הלאה: ביקורת GAN משולשת.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★