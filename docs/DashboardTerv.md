# AlphaSteane Dashboard — Tervező Dokumentum

**Dátum:** 2026-08-19
**Szerző:** IDRIS DASHBOARD TERVEZŐ alügynök (csak olvasás + új fájl)
**Státusz:** TERV (nem implementáció — ez a megvalósítás előtti specifikáció)
**Források:** `szima_ter/modul/AlphaSteane.idr`, `szima_ter/modul/SzimaDashboard.idr`, `szima_ter/modul/TetrapodaTest.idr`
**Szabályok:** AGENTS §13 (soha ne írj felül — új fájl), §16 (információveszteség nélküli dokumentáció), §17 (mérési hiba-kötelezettség), §18 (őszinte verifikáció), §20 (soha semmit nem lehet törölni)

---

## 0. A tervezés célja

Egy **új Idris-modul** (`szima_ter/modul/AlphaSteaneDashboard.idr`) generáljon egy
**teljes weboldalt** (`docs/dashboard_alphasteane/index.html`), amely a 17 lépéses
levezetést mutatja be interaktívan:

- **Idris számol** — minden érték `AlphaSteane.idr` és `TetrapodaTest.idr` Refl-bizonyításaiból + Double-aritmetikájából jön,
- **Idris generál HTML-t + SVG-t + CSS-t + JavaScriptet** — egyetlen `main : IO ()` írja ki az `index.html`-t,
- **Idris generál Python plottert** — a `rajzol_alphasteane.py` a `adatok_alphasteane.json`-ből olvassa a számokat (a Python sosem számol, csak rajzol, AGENTS §3 / SzimaDashboard.idr minta),
- **Minden lépéshez**: Idris Refl-bizonyítás + numerikus érték + vizualizáció (SVG vagy PNG) + irodalmi hivatkozás,
- **Interaktivitás**: JavaScript animációk (a lobásás lépésről lépésre, a konstans konvergencia, a Hox-gén lánc),
- **Biológiai illusztrációk**: SVG-ben rajzolt tetrapoda csontváz, 5 ujj, bilaterális tükör — **nincs külső kép**.

A dashboard a **`SzimaDashboard.idr` mintáját** követi (JSON + Python plotter), de
kibővítve inline HTML/SVG/CSS/JS generálással.

---

## 1. Az Idris-modul szerkezete

### 1.1. Modul és importok

```idris
module AlphaSteaneDashboard

import AlphaSteane        -- minden fizikai konstans (n, k, d, alphaBare, delta, ...)
import TetrapodaTest      -- oldalakSzama, ujjakSzama, vegltagokSzama, szazHaromHet, ...
import System.File

%default total
```

Az `AlphaSteane` és `TetrapodaTest` már tartalmazza az összes levezetést és Refl-bizonyítást.
**A dashboard modul nem számolja újra** a konstansokat — csak hivatkozik rájuk (`show alphaBare`, `show delta`, stb.), és a bizonyításokat felsorolja (a típusokat kiírja a HTML bizonyítás-szekciójába).

### 1.2. Adatszerkezetek

Minden lépést egy **indexelt rekord** ír le (a lépés sorszáma = a típusparaméter, AGENTS §13: a típus legyen annyira pontos, hogy csak egy implementáció lehetséges):

```idris
||| A 17 lépés indexelt típusa — minden lépéshez egy konstruktor.
||| A típus maga hordozza a lépés sorszámát (dependent indexing).
data LepesSorszam : Type where
  Le01_KodParameterek   : LepesSorszam
  Le02_Levezetett       : LepesSorszam
  Le03_EgeszResz137     : LepesSorszam
  Le04_TortSzamlalo9    : LepesSorszam
  Le05_TortNevezo250    : LepesSorszam
  Le06_AlphaBare        : LepesSorszam
  Le07_TisztaTer121     : LepesSorszam
  Le08_LobaszasExponens : LepesSorszam
  Le09_PithagorasziHang : LepesSorszam
  Le10_Delta            : LepesSorszam
  Le11_AlphaDressed     : LepesSorszam
  Le12_CodataOsszehasonlitas : LepesSorszam
  Le13_GGravitacio      : LepesSorszam
  Le14_137BaseTiz       : LepesSorszam
  Le15_BaseTizFelbontas : LepesSorszam
  Le16_Szimmetriak      : LepesSorszam
  Le17_HoxGenek         : LepesSorszam
```

Minden lépéshez egy **rekord** tartozza a megjelenítendő tartalmat:

```idris
||| Egy lépés tartalma: cím, képlet (LaTeX-szerű szöveg), numerikus érték,
||| Refl-bizonyítás típusa (szövegként kiírva), SVG-azonosító, hivatkozás.
record LepesTartalom where
  constructor LepesKonstruktor
  lepesSorszam   : LepesSorszam
  lepesCim       : String        -- pl. "A Steane [[7,1,3]] kód paraméterei"
  lepesKeplet    : String        -- pl. "n = 7, k = 1, d = 3"
  lepesErtek     : String        -- a numerikus érték (show-val)
  lepesBizonyitas : String       -- a Refl típus szövege (pl. "bizKodSzoTer : KodSzoTerKonst = 128.0")
  lepesSvgAzon   : String        -- a lépés SVG-jének azonosítója (pl. "svg-le01")
  lepesHivatkozas : String       -- irodalmi hivatkozás (pl. "Steane (1996), Proc. R. Soc. A 452")
  lepesAnimacio  : String        -- a JS animáció azonosítója (vagy üres)
```

A 17 `LepesTartalom` rekordot **két független úton** kell konstruálni (AGENTS §18.4: kettős fedés):
1. **Az `AlphaSteane`/`TetrapodaTest` értékeiből** (`show alphaBare`, stb.),
2. **Egy hardcodeolt ellenőrző listából** (a numerikus értékek szövegesen).
A `main` összehasonlítja a kettőt, és ha eltérés van, hibát jelez (a HTML-be piros figyelmeztetés).

### 1.3. Fő függvények

| Függvény | Típus | Feladat |
|---|---|---|
| `lepesekLista` | `List LepesTartalom` | a 17 lépés tartalma (az `AlphaSteane` értékeiből) |
| `lepesekEllenorzo` | `List LepesTartalom` | a hardcodeolt ellenőrző lista (kettős fedés) |
| `lepesekEgyeznekE` | `Bool` | a két lista numerikus értékeinek egyezősége (GAUGE-elv) |
| `htmlFejlec` | `String` | a `<!DOCTYPE html>...<head>...<style>...</head><body>` |
| `htmlLablec` | `String` | a `</body></html>` + a hivatkozások listája |
| `htmlLepesBlokk` | `LepesTartalom -> String` | egy lépés HTML-blokkja (cím + képlet + érték + bizonyítás + SVG + hivatkozás) |
| `svgKodStruktura` | `String` | az [[7,1,3]] kód 7 qubitjének SVG-je (körök + stabilizátorok) |
| `svgLobaszasGrafikon` | `String` | a (121/128)^n görbe SVG-je (statikus, a Python dinamikus) |
| `svgAlphaKonvergencia` | `String` | a α⁻¹_bare → α⁻¹_dressed → CODATA konvergencia SVG |
| `svgBiologiaiKapcsolat` | `String` | a tetrapoda csontváz + 5 ujj + Hox-gén lánc SVG |
| `svgBaseTiz` | `String` | a 2 × 5 = 10 base-10 felbontás SVG |
| `svgHoxGenek` | `String` | a Shh / Hoxa11 / Hoxa13 génlánc SVG |
| `cssStilus` | `String` | a teljes CSS (sötét téma, magyar feliratok) |
| `javascriptAnimaciok` | `String` | a `<script>` blokk: a lobásás lépésről lépésre, a konvergencia, a Hox-lánc |
| `adatokJson` | `String` | a JSON a Python plotternek (minden szám Idrisből) |
| `rajzoloPython` | `String` | a `rajzol_alphasteane.py` forrása (csak rajzol, JSON-ból olvas) |
| `main` | `IO ()` | kiírja az `index.html`-t, az `adatok_alphasteane.json`-t, a `rajzol_alphasteane.py`-t |

### 1.4. Kimeneti fájlok

A `main` három fájlt ír (a `docs/dashboard_alphasteane/` könyvtárba, AGENTS §16: új könyvtár, nem felülírja a `docs/dashboard/`-t):

1. **`index.html`** — a teljes weboldal (HTML + inline SVG + inline CSS + inline JS),
2. **`adatok_alphasteane.json`** — minden numerikus érték (a Python plotternek),
3. **`rajzol_alphasteane.py`** — a Python plotter (csak rajzol, JSON-ból olvas).

A Python plotter futtatása (`python3 rajzol_alphasteane.py`) generálja a `docs/dashboard_alphasteane/`-be:
- `lobaszas_gorbe.png` — a (121/128)^n görbe n=0..256-ra,
- `delta_konvergencia.png` — a δ értéke az exponens növelésével,
- `alpha_osszehasonlitas.png` — α⁻¹_bare vs α⁻¹_dressed vs CODATA (hibasávval),
- `g_osszehasonlitas.png` — a G levezetett vs CODATA (hibasávval),
- `konstansok_tabla.png` — a 17 lépés numerikus értékei táblázatban.

---

## 2. A HTML oldal szerkezete

A HTML egyetlen `index.html` fájl, **inline** SVG-vel, CSS-sel, JavaScripttel (nincs külső függőség, hordozható, offline is működik).

### 2.1. A `<head>`

- `<meta charset="utf-8">`, `<title>α⁻¹ a Steane [[7,1,3]] kódból — dashboard</title>`,
- `<style>` — a `cssStilus` által generált CSS (sötét téma, `#0a0a0f` háttér, `#e8e8f0` szöveg, monospace a képleteknek, zöld a bizonyításoknak, piros a hibáknak),
- `<link>` a Google Fonts `Fira Code` (monospace) — vagy ha offline kell, akkor rendszer monospace.

### 2.2. A `<body>` szekciói

A oldal **függőlegesen gördíthető**, 17 szekcióval (egy lépés = egy `<section>`). A tetején egy **fix oldalsáv** a lépések navigációjával (anchor linkek). A szekciók:

```
┌──────────────────────────────────────────────────────────────┐
│  OLDALSÁV (fix, bal)        │  FŐ TARTALOM (gördülő)          │
│  ─────────────────          │  ──────────────────────────────│
│  01. Kód paraméterei        │  SZFEJLÉC                       │
│  02. Levezetett             │  "α⁻¹ a Steane [[7,1,3]]-ból"   │
│  03. 137 = egész rész       │  (nagyméretű SVG: a kód struktúra)│
│  04. 9 = számláló           │                                 │
│  05. 250 = nevező           │  SZFEJLÉC-VÁZLAT: a 17 lépés     │
│  06. α⁻¹_bare               │  (merleg-diagram, SVG)          │
│  07. 121 = tiszta tér       │                                 │
│  08. 249 = exponens         │  ─── 01. KÓD PARAMÉTEREI ───    │
│  09. 9/8 = pithagoraszi     │  [képlet] [érték] [bizonyítás]   │
│  10. δ                      │  [SVG] [hivatkozás]              │
│  11. α⁻¹_dressed            │                                 │
│  12. CODATA összeh.         │  ─── 02. LEVEZETETT ───         │
│  13. G                      │  ...                             │
│  14. 137 base 10            │                                 │
│  15. base 10 = 2×5          │  ─── 17. HOX-GENEK ───          │
│  16. szimmetriák            │  [biológiai SVG]                │
│  17. Hox-gének              │                                 │
│                             │  HIVATKOZÁSOK (lábléc)           │
└─────────────────────────────┴─────────────────────────────────┘
```

Minden lépés-szekció **azonos szerkezetű**:

```html
<section id="le-01">
  <h2>01. A Steane [[7,1,3]] kód paraméterei</h2>
  <div class="lepes-keplet"><code>n = 7, k = 1, d = 3</code></div>
  <div class="lepes-ertek">érték: n=7.0, k=1.0, d=3.0</div>
  <div class="lepes-bizonyitas">
    <span class="biz-igen">✓ Refl</span> a típus: <code>KodSzoTerKonst = 128.0</code>
  </div>
  <div class="lepes-svg"><svg id="svg-le01">...</svg></div>
  <div class="lepes-hivatkozas">Steane (1996), Proc. R. Soc. A 452:2551-2577</div>
  <div class="lepes-animacio">
    <button onclick="animaloLobaszas()">▶ Lobásás animáció</button>
  </div>
</section>
```

### 2.3. A CSS (`cssStilus`)

- Sötét téma (`#0a0a0f` háttér, `#e8e8f0` szöveg),
- Monospace a képleteknek (`Fira Code`, `JetBrains Mono`, vagy rendszer monospace),
- A bizonyítások zöld háttérrel (`#1a2e1a`), a hiányzó/gyenge bizonyítások sárgával,
- Az SVG-k középre igazítva, reszponzív (`max-width: 100%`),
- Az oldalsáv fix, `position: sticky; top: 0`,
- A gombok (`▶ animáció`) kék téglalapok, hover-rel világosodnak,
- A hivatkozások `#6ea8fe` (világoskék), aláhúzás nélkül, hover-rel aláhúzott.

---

## 3. A Python plotter szerkezete

A `rajzol_alphasteane.py` a `SzimaDashboard.idr` `rajzoloPython` mintáját követi:
**csak rajzol, minden számot a JSON-ból olvas** (AGENTS §3: Python sosem számol).

### 3.1. A JSON (`adatok_alphasteane.json`)

Az `adatokJson` függvény generálja, minden érték `show`-val Idrisből:

```json
{
  "n": 7.0,
  "k": 1.0,
  "d": 3.0,
  "s": 6.0,
  "N": 128.0,
  "M": 256.0,
  "egyes_resz": 137.0,
  "tort_szamlalo": 9.0,
  "tort_nevezo": 250.0,
  "tortresz": 0.036,
  "alpha_bare": 137.036,
  "tiszta_ter": 121.0,
  "lobaszas_base": 0.9453125,
  "lobaszas_exponens_egesz": 249.0,
  "pithagoraszi_hang": 1.125,
  "log_pithagoraszi": 0.117783,
  "lobaszas_exponens": 249.117783,
  "delta": 0.000000823,
  "alpha_dressed": 137.035999177,
  "alpha_codata": 137.035999177,
  "sigma_alpha": 2.1e-8,
  "delta_sigma_alpha": 0.00017,
  "g_levezetett": 6.67430e-11,
  "g_codata": 6.67430e-11,
  "sigma_g": 1.5e-15,
  "delta_sigma_g": 0.038,
  "oldalak_szama": 2,
  "vegltagok_szama": 4,
  "ujjak_szama": 5,
  "osszes_ujj": 10,
  "base_tiz": 10,
  "szaz_harom_het": 137,
  "lepesek_szama": 17,
  "bizonyitasok_valodi": 5,
  "bizonyitasok_tautologia": 0,
  "bizonyitasok_hianyzo": 12
}
```

A `bizonyitasok_*` mezők a 17 lépés besorolása (AGENTS §18):
- **valodi** (5 db): ahol a Refl két különböző konstrukciót köt össze (pl. `bizKodSzoTer : KodSzoTerKonst = 128.0`, ahol `KodSzoTerKonst = pow 2.0 7.0`),
- **hianyzo** (12 db): ahol nincs külön Refl, csak a `show` numerikus értéke (a δ, a α⁻¹_dressed, a G — ezek Double-aritmetika, nem Refl-bizonyíthatóak könnyen),
- **tautologia** (0 db): a dashboard nem tartalmaz tautológ bizonyításokat (AGENTS §18.1).

A `main` a HTML-be **kijelzi** ezt a besorolást (egy kis táblázat a láblécben), hogy a néző lássa: mely lépések tényleg bizonyítottak, melyek csak numerikusan ellenőrzöttek (AGENTS §18.4: "speculatív" jelölés).

### 3.2. A `rajzol_alphasteane.py` grafikonjai

A Python **5 PNG-t** generál (a `docs/dashboard_alphasteane/`-be):

| # | Fájlnév | Grafikon | Adatok (JSON-ból) |
|---|---|---|---|
| 1 | `lobaszas_gorbe.png` | a `(121/128)^n` görbe n=0..256-ra (log-Y skála) | `lobaszas_base`, `lobaszas_exponens` (függőleges vonal n=249-nél) |
| 2 | `delta_konvergencia.png` | a δ értéke az exponens növelésével (n=0..300) | `lobaszas_base`, a `delta` a végén (piros pont) |
| 3 | `alpha_osszehasonlitas.png` | α⁻¹_bare (137.036) vs α⁻¹_dressed (137.035999177) vs CODATA (137.035999177±2.1e-8) — hibasávval, log-Y | `alpha_bare`, `alpha_dressed`, `alpha_codata`, `sigma_alpha` |
| 4 | `g_osszehasonlitas.png` | a G levezetett vs CODATA (hibasávval, log-Y) | `g_levezetett`, `g_codata`, `sigma_g` |
| 5 | `konstansok_tabla.png` | a 17 lépés numerikus értékei táblázatban | a teljes JSON |

A Python kód szerkezete (a `SzimaDashboard.idr` `rajzoloPython`-hoz hasonlóan):

```python
import json, os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ALAP = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(ALAP, "adatok_alphasteane.json"), encoding="utf-8") as f:
    A = json.load(f)

def ment(nev):
    plt.tight_layout(); plt.savefig(os.path.join(ALAP, nev), dpi=120); plt.close()
    print("kesz:", nev)

# 1. Lobásás görbe (a base a JSON-ból, a görbe pontjait a Python rakja össze —
#    de csak a MEGJELENÍTÉSHEZ, nem a konstans értékéhez)
b = A["lobaszas_base"]
n_max = 300
xs = np.arange(0, n_max + 1)
ys = b ** xs
plt.figure(figsize=(8, 5))
plt.semilogy(xs, ys, color="tab:cyan", linewidth=2)
plt.axvline(A["lobaszas_exponens_egesz"], color="tab:red", linestyle="--",
            label="n=249 (lobásás exponens)")
plt.axhline(A["delta"], color="tab:green", linestyle=":",
            label="δ = (121/128)^(249+ln(9/8))")
plt.title("A lobásás: (121/128)^n  (Idris számolta a base-t és δ-t)")
plt.xlabel("n"); plt.ylabel("(121/128)^n  (log skála)"); plt.legend()
ment("lobaszas_gorbe.png")

# 2-5. ... (hasonló minta, minden érték A["..."]-ból)
```

**Fontos (AGENTS §18):** a Python a görbe **alakját** rajzolja (a `b ** xs` pontokat),
de a **konstans értékeket** (δ, α⁻¹, G) **sosem számolja** — csak a JSON-ból olvassa és
ábrázolja. Ha a Pythonban `delta = ...` képlet szerepelne, az AGENTS §3 megsértése.

---

## 4. Az SVG-k listája

Az SVG-ket **az Idris generálja inline** (a `svgXxx` függvények), nem külső fájlok.
Minden SVG **magyar feliratokkal**, sötét téma színekkel (`#1a1a2e` háttér, `#e8e8f0` vonalak).

| # | SVG azonosító | Lépés | Tartalom | Elemek |
|---|---|---|---|---|
| 1 | `svg-fejlec` | (szfejléc) | a [[7,1,3]] kód 7 qubitje + 6 stabilizátor | 7 kör (fizikai qubitek), 1 nagy kör (logikai qubit), 6 négyzet (stabilizátor-generátorok), vonalak (a stabilizátorok hatóköre) |
| 2 | `svg-vazlat` | (szfejléc) | a 17 lépés merleg-diagramja (a levezetés vázlata) | 17 doboz függőlegesen, nyilak közöttük, a Δ/σ=0.00017 zölddel, a Δ/σ=0.038 sárgával |
| 3 | `svg-le01` | 01 | a (n, k, d) = (7, 1, 3) paraméterek | 3 doboz: n=7 (7 kis kör), k=1 (1 kör), d=3 (3 kör távolság-jelöléssel) |
| 4 | `svg-le02` | 02 | a levezetett mennyiségek (s=6, N=128, M=256) | 3 doboz a számokkal, nyilak az 1. lépésből (n-k=s, 2^n=N, 2^(n+1)=M) |
| 5 | `svg-le03` | 03 | a 137 = 2⁷ + 2³ + 1 felbontás | 128 + 8 + 1 dobozok, összeadva 137 |
| 6 | `svg-le04` | 04 | a 9 = s + d = 6 + 3 | két doboz (6 és 3), összeadva 9 |
| 7 | `svg-le05` | 05 | a 250 = M − s = 256 − 6 | két doboz, kivonva 250 |
| 8 | `svg-le06` | 06 | a α⁻¹_bare = 137 + 9/250 | a 137.036 szám nagy méretben, a 9/250 törtrész kiemelve |
| 9 | `svg-le07` | 07 | a 121 = N − n = 128 − 7 | a 128 kódszó 7 kiválasztva (a 7 qubit), marad 121 |
| 10 | `svg-le08` | 08 | a 249 = M − n = 256 − 7 | a 256 kiterjesztett tér 7 kiválasztva, marad 249 |
| 11 | `svg-le09` | 09 | a 9/8 = (s+d)/2ᵈ püthagoraszi hang | egy hangvonal (zenei vonal), a 9/8 arányú intervallum (204 cent) |
| 12 | `svg-le10` | 10 | a δ = (121/128)^(249+ln(9/8)) | a lobásás görbe (statikus, a Python a dinamikus) — az exponens és a base jelölve |
| 13 | `svg-le11` | 11 | a α⁻¹_dressed = α⁻¹_bare − δ | a 137.036 → 137.035999177 konvergencia (nagyított törtrész) |
| 14 | `svg-le12` | 12 | a CODATA összehasonlítás | a 137.035999177 ± 2.1e-8 hibasáv, a levezetett benne van (zöld pipa) |
| 15 | `svg-le13` | 13 | a G gravitációs állandó | a 6.67430e-11 ± 1.5e-15 hibasáv, a levezetett benne van (sárga — 0.038σ) |
| 16 | `svg-le14` | 14 | a 137 = [k, d, n] base 10-ben | a 137 szám három számjegyre bontva: 1 (k), 3 (d), 7 (n), a base 10 jelölve |
| 17 | `svg-le15` | 15 | a base 10 = 2 × 5 (oktáv × tükör) | a 10 két prímre bontva: 2 (oktáv, bilaterális) és 5 (tükör, pentadactylia) |
| 18 | `svg-le16` | 16 | a szimmetriák (2, 5, 4) | a 2 (bal/job tükör), az 5 (5 ujj), a 4 (4 végtag = D_CRIT) — három panel |
| 19 | `svg-le17` | 17 | a Hox-gének (Shh, Hoxa11, Hoxa13) | a tetrapoda csontváz SVG-ben: gerinc, 4 végtag, 5 ujj/végtag, a Hox-gének a megfelelő régiókban |
| 20 | `svg-biologia` | (biológiai) | a teljes biológiai lánc | a tetrapoda (Tiktaalik → ember), az 5 ujj evolúciós konzervációja, a Hox-gén lánc |

**A biológiai SVG (19, 20) részletei:**
- **Tetrapoda csontváz**: gerinc (kék vonal), 4 végtag (2 elülső + 2 hátsó, zöld vonalak), 5 ujj végtagonként (5 kis kör végtagonként),
- **Bilaterális tükör**: egy függőleges szaggatott vonal a gerinc mentén, a bal/jobb oldal tükrözve,
- **Hox-gén lánc**: 3 doboz a gerinc mentén (Shh = fejnél, Hoxa11 = középen, Hoxa13 = végtagoknál), nyilak a génexpresszió irányába,
- **Evolúciós lánc**: 7 kis ikon (Tiktaalik, béka, gyík, teknős, madár, ló, ember), mindegyik 5 ujjal (a ló 1-gyel, a madár 3-mal — redukció, jelezve),
- **Nincs külső kép** — minden SVG path/okozatú primitív (kör, vonal, téglalap, path).

---

## 5. Az animációk listája

A `javascriptAnimaciok` függvény generálja a `<script>` blokkot. Minden animáció **tiszta JavaScript** (nincs külső library, nincs Canvas — SVG manipuláció `requestAnimationFrame`-mel).

| # | Animáció azonosító | Lépés | Leírás | Irányítás |
|---|---|---|---|---|
| 1 | `animaloKodStruktura` | 01 | a 7 qubit fokozatos megjelenése (körönként 200ms), majd a 6 stabilizátor vonalak bekapcsolódása | gomb: ▶ / ⏸ |
| 2 | `animaloLevezetett` | 02 | a s=6, N=128, M=256 értékek "kiszámolása" (a n-k, 2^n, 2^(n+1) képletek beíródnak, az eredmények megjelennek) | automatikus a szekció nézetbe érkezésekor (`IntersectionObserver`) |
| 3 | `animaloEgeszResz` | 03 | a 128 + 8 + 1 = 137 összeadás animált (a három doboz egymás mellé csúszik, az összeadó vonal megjelenik) | gomb |
| 4 | `animaloLobaszas` | 10 | **a fő animáció**: a (121/128)^n görbe rajzolódása n=0-tól 256-ig, a görbe pontonként rajzolódik (SVG path `stroke-dasharray` trükk), az exponens növekedése számlálóval, a δ végpontja piros ponttal | gomb: ▶ / ⏸ / ↻ (újraindítás), sebességcsúszka |
| 5 | `animaloAlphaKonvergencia` | 11 | a α⁻¹_bare (137.036) → α⁻¹_dressed (137.035999177) konvergencia — a törtrész "zoom" animáció (a 137.036 nagyítása a 6. tizedesjegyig) | gomb |
| 6 | `animaloCodataOsszehasonlitas` | 12 | a CODATA hibasáv megjelenése (a ±2.1e-8 sáv kinyílik), a levezetett érték "belepottyan" a sávba (zöld pipa) | automatikus |
| 7 | `animaloGOsszehasonlitas` | 13 | a G hibasáv megjelenése (±1.5e-15), a levezetett érték "belepottyan" (sárga — 0.038σ, majdnem belül) | automatikus |
| 8 | `animaloBaseTizFelbontas` | 15 | a 10 felbontása 2 × 5-re (a 10 doboz szétválik 2 és 5-re, az oktáv és tükör címkék megjelennek) | gomb |
| 9 | `animaloSzimmetriak` | 16 | a 2 (tükör) + 5 (ujjak) + 4 (végtagok) szimmetriák fokozatos megjelenése — a tükörvononal először, majd az 5 ujj, majd a 4 végtag | gomb |
| 10 | `animaloHoxGenek` | 17 | a Hox-gén lánc animációja — a Shh, Hoxa11, Hoxa13 dobozok a gerinc mentén "bekapcsolódnak" (színváltozás), az 5 ujj kialakulása (5 kör növekszik a végtagonként) | gomb |
| 11 | `animaloLanc` | (biológiai) | a teljes lánc animációja: emberi test 2×5 ujj → base 10 → 137 → Steane → α⁻¹ → CODATA — a lánc elemei egymás után kiemelődnek, nyilak jelennek meg közöttük | gomb: ▶ teljes lánc |

**Technikai részletek:**
- Minden animáció `requestAnimationFrame`-et használ (60fps),
- Az SVG path animációk `stroke-dasharray` + `stroke-dashoffset` trükkel (a path "rajzolódik"),
- Az `IntersectionObserver` automatikusan elindítja az animációt, ha a szekció a nézetbe érkezik,
- A gombok (`▶ / ⏸ / ↻`) SVG-vel rajzolt ikonok (nem külső ikon-készlet),
- A sebességcsúszka (a 4. animációnál) egy `<input type="range">`, amely a `requestAnimationFrame` léptékét módosítja.

---

## 6. A hivatkozások elhelyezése

Minden lépéshez **egy irodalmi hivatkozás** tartozik (a `lepesHivatkozas` mező).
A hivatkozások a HTML láblécében **együtt is megjelennek** (egy `<ol>` listában, számozva).

### 6.1. A 17 lépés hivatkozásai

| Lépés | Hivatkozás | Típus |
|---|---|---|
| 01 | Steane, A.M. (1996). "Multiple-particle interference and quantum error correction". *Proc. R. Soc. A* 452:2551-2577. | a [[7,1,3]] kód eredeti leírása |
| 02 | Nielsen, M.A. & Chuang, I.L. (2010). *Quantum Computation and Quantum Information*. Cambridge Univ. Press. §10.5. | a stabilizátor-formalizmus (s = n-k) |
| 03 | — (belső levezetés: 2⁷+2³+1 = 137) | a 137 egész rész struktúrája |
| 04 | — (belső: s+d = 6+3 = 9) | a 9 számláló |
| 05 | — (belső: M-s = 256-6 = 250) | a 250 nevező |
| 06 | — (belső: α⁻¹_bare = 137 + 9/250) | a bare csatolás definíciója |
| 07 | — (belső: N-n = 128-7 = 121) | a tiszta tér |
| 08 | — (belső: M-n = 256-7 = 249) | a lobásás exponensének egész része |
| 09 | Helmholtz, H. (1877). *Die Lehre von den Tonempfindungen*. | a püthagoraszi 9/8 egész hang (204 cent) |
| 10 | — (belső: δ = (121/128)^(249+ln(9/8))) | a lobásás definíciója |
| 11 | — (belső: α⁻¹_dressed = α⁻¹_bare − δ) | a dressed csatolás |
| 12 | CODATA 2022 / NIST. α⁻¹ = 137.035999177(11). https://physics.nist.gov/cuu/Constants/ | a CODATA referencia + mérési hiba (AGENTS §17) |
| 13 | CODATA 2022 / NIST. G = 6.67430(15)×10⁻¹¹ m³kg⁻¹s⁻². | a G CODATA érték + hiba |
| 14 | — (belső: 137 = [k,d,n] base 10-ben) | a 137 számjegyeinek a Steane paraméterekkel való egyezése |
| 15 | — (belső: base 10 = 2×5) | a base 10 felbontása prímekre |
| 16 | Conway, J.H. & Sloane, N.J.A. (1988). *Sphere Packings, Lattices and Groups*. Springer. | az oktáv (2) és tükör (5) prímek (SPLAG) |
| 17 | Shubin, N. (2008). *Your Inner Fish*. Pantheon. | a Hox-gének (Shh, Hoxa11, Hoxa13) és a pentadactylia (Tiktaalik, 360 Mya) |

### 6.2. A hivatkozások megjelenítése

- **Minden lépés-szekció végén** egy kis `<div class="lepes-hivatkozas">` (a lépés saját hivatkozása),
- **A HTML láblécében** egy `<section id="hivatkozasok">` az összes hivatkozással (`<ol>`),
- **A hivatkozások kattinthatóak** (ha van DOI/URL, `<a href>`),
- **A belső levezetéseknél** "(belső levezetés)" jelölés — ez nem külső hivatkozás, hanem a projekt saját Idris-moduljára (`AlphaSteane.idr`, `TetrapodaTest.idr`) mutat (link a GitHub-repo forrására).

---

## 7. A lépésről lépésre tartalom (17 lépés)

Minden lépéshez: **(a) cím, (b) képlet, (c) numerikus érték (Idris `show`-val), (d) Refl-bizonyítás (ha van), (e) SVG, (f) hivatkozás, (g) animáció (ha van).**

### 01. A Steane [[7,1,3]] kód paraméterei

- **Cím:** A Steane [[7,1,3]] kód paraméterei
- **Képlet:** n = 7, k = 1, d = 3
- **Érték:** `show n` = 7.0, `show k` = 1.0, `show d` = 3.0
- **Bizonyítás:** — (a paraméterek a bemenetek, nem levezetett értékek)
- **SVG:** `svg-le01` — 3 doboz (n=7 qubit, k=1 logikai, d=3 távolság)
- **Hivatkozás:** Steane (1996), Proc. R. Soc. A 452:2551-2577
- **Animáció:** `animaloKodStruktura` — a 7 qubit fokozatos megjelenése

### 02. A levezetett mennyiségek (s=6, N=128, M=256)

- **Cím:** A levezetett mennyiségek
- **Képlet:** s = n − k = 6, N = 2ⁿ = 128, M = 2^(n+1) = 256
- **Érték:** `show s` = 6.0, `show kodSzoTer` = 128.0, `show kiterjesztettTer` = 256.0
- **Bizonyítás:** `bizKodSzoTer : KodSzoTerKonst = 128.0` (Refl — a `KodSzoTerKonst = pow 2.0 7.0`, a 128.0 a numerikus ellenőrzés, AGENTS §18.1: nem tautológia, mert a bal oldal `pow 2.0 7.0`, a jobb oldal `128.0`)
- **SVG:** `svg-le02` — 3 doboz a levezetett értékekkel, nyilak az 1. lépésből
- **Hivatkozás:** Nielsen & Chuang (2010) §10.5
- **Animáció:** `animaloLevezetett` — automatikus a nézetbe érkezéskor

### 03. A 137 = 2ⁿ + 2ᵈ + 1 (az egész rész)

- **Cím:** A 137 = 2⁷ + 2³ + 1 (az egész rész)
- **Képlet:** 137 = 2⁷ + 2³ + 1 = 128 + 8 + 1
- **Érték:** `show egyesResz` = 137.0
- **Bizonyítás:** `bizEgyesResz : EgyesReszKonst = 137.0` (Refl — a bal oldal `kodSzoTer + pow 2.0 d + 1.0`, a jobb oldal 137.0)
- **SVG:** `svg-le03` — 128 + 8 + 1 dobozok, összeadva 137
- **Hivatkozás:** (belső levezetés)
- **Animáció:** `animaloEgeszResz` — az összeadás animált

### 04. A 9 = s + d (a törtrész számlálója)

- **Cím:** A 9 = s + d (a törtrész számlálója)
- **Képlet:** 9 = s + d = 6 + 3
- **Érték:** `show stabilizatorPluszTavolsag` = 9.0
- **Bizonyítás:** — (nincs külön Refl, a `stabilizatorPluszTavolsag = s + d` definíció + a `show` numerikus ellenőrzés; AGENTS §18.4: "speculatív" jelölés, de valójában triviális — a `s + d` Double-aritmetika)
- **SVG:** `svg-le04` — 6 + 3 = 9 dobozok
- **Hivatkozás:** (belső levezetés)
- **Animáció:** —

### 05. A 250 = M − s (a törtrész nevezője)

- **Cím:** A 250 = M − s (a törtrész nevezője)
- **Képlet:** 250 = M − s = 256 − 6
- **Érték:** `show tortreszNevezo` = 250.0
- **Bizonyítás:** `bizTortreszNevezo : TortreszNevezoKonst = 250.0` (Refl — a bal oldal `kiterjesztettTer - s`, a jobb oldal 250.0)
- **SVG:** `svg-le05` — 256 − 6 = 250
- **Hivatkozás:** (belső levezetés)
- **Animáció:** —

### 06. A α⁻¹_bare = 137 + 9/250

- **Cím:** A α⁻¹_bare = 137 + 9/250
- **Képlet:** α⁻¹_bare = 137 + 9/250 = 137.036
- **Érték:** `show alphaBare` = 137.036
- **Bizonyítás:** — (a `alphaBare = egyesResz + tortresz` definíció + `show`; AGENTS §18.4: numerikusan ellenőrzött, nem Refl-bizonyított)
- **SVG:** `svg-le06` — a 137.036 szám, a 9/250 törtrész kiemelve
- **Hivatkozás:** (belső levezetés)
- **Animáció:** —

### 07. A 121 = N − n (a tiszta tér)

- **Cím:** A 121 = N − n (a tiszta tér)
- **Képlet:** 121 = N − n = 128 − 7
- **Érték:** `show tisztaTer` = 121.0
- **Bizonyítás:** `bizTisztaTer : TisztaTerKonst = 121.0` (Refl — a bal oldal `kodSzoTer - n`, a jobb oldal 121.0)
- **SVG:** `svg-le07` — a 128 kódszó 7 kiválasztva, marad 121
- **Hivatkozás:** (belső levezetés)
- **Animáció:** —

### 08. A 249 = M − n (a lobásás exponensének egész része)

- **Cím:** A 249 = M − n (a lobásás exponensének egész része)
- **Képlet:** 249 = M − n = 256 − 7
- **Érték:** `show lobaszasExponensEgesz` = 249.0
- **Bizonyítás:** `bizLobaszasExponensEgesz : LobaszasExponensEgeszKonst = 249.0` (Refl)
- **SVG:** `svg-le08` — a 256 kiterjesztett tér 7 kiválasztva, marad 249
- **Hivatkozás:** (belső levezetés)
- **Animáció:** —

### 09. A 9/8 = (s+d)/2ᵈ (a püthagoraszi egész hang)

- **Cím:** A 9/8 = (s+d)/2ᵈ (a püthagoraszi egész hang)
- **Képlet:** 9/8 = (s+d)/2ᵈ = 9/8, ln(9/8) ≈ 0.1178
- **Érték:** `show pithagorasziHang` = 1.125, `show logPithagoraszi` = 0.117783...
- **Bizonyítás:** — (Double-aritmetika, `show` ellenőrzés)
- **SVG:** `svg-le09` — egy hangvonal, a 9/8 intervallum (204 cent)
- **Hivatkozás:** Helmholtz (1877), *Die Lehre von den Tonempfindungen*
- **Animáció:** —

### 10. A δ = (121/128)^(249+ln(9/8))

- **Cím:** A δ = (121/128)^(249+ln(9/8)) (a lobásás)
- **Képlet:** δ = (121/128)^(249+ln(9/8))
- **Érték:** `show delta` ≈ 8.23×10⁻⁷
- **Bizonyítás:** — (Double-aritmetika, `show` ellenőrzés; a `pow` nem Refl-bizonyítható könnyen)
- **SVG:** `svg-le10` — a lobásás görbe (statikus), az exponens és a base jelölve
- **Hivatkozás:** (belső levezetés)
- **Animáció:** `animaloLobaszas` — **a fő animáció**: a görbe rajzolódása n=0-tól 256-ig, a δ végpontja piros ponttal

### 11. A α⁻¹_dressed = α⁻¹_bare − δ

- **Cím:** A α⁻¹_dressed = α⁻¹_bare − δ
- **Képlet:** α⁻¹_dressed = 137.036 − 8.23×10⁻⁷ = 137.035999177
- **Érték:** `show alphaDressed` ≈ 137.035999177
- **Bizonyítás:** — (Double-aritmetika)
- **SVG:** `svg-le11` — a 137.036 → 137.035999177 konvergencia (nagyított törtrész)
- **Hivatkozás:** (belső levezetés)
- **Animáció:** `animaloAlphaKonvergencia` — a törtrész "zoom" animáció

### 12. A CODATA összehasonlítás (Δ/σ = 0.00017)

- **Cím:** A CODATA összehasonlítás
- **Képlet:** Δ = |α⁻¹_dressed − α⁻¹_CODATA|, σ = 2.1×10⁻⁸, Δ/σ = 0.00017
- **Érték:** `show (abs (alphaDressed - alphaCodata) / sigmaAlpha)` ≈ 0.00017
- **Bizonyítás:** — (Double-aritmetika; AGENTS §17: a Δ/σ kötelező formátum)
- **SVG:** `svg-le12` — a CODATA hibasáv (±2.1e-8), a levezetett benne (zöld pipa)
- **Hivatkozás:** CODATA 2022 / NIST, α⁻¹ = 137.035999177(11)
- **Animáció:** `animaloCodataOsszehasonlitas` — a hibasáv megnyitása, a levezetett "belepottyan"
- **Kimeneti formátum (AGENTS §17.4):**
  ```
  érték_levezetett = 137.035999177
  érték_mért       = 137.035999177 (σ = 2.1e-8, forrás: CODATA 2022)
  Δ                = ~0
  Δ/σ              = 0.00017
  ```

### 13. A G = (7×11)/(2³×5²)×√3×(1+9/250)^(1/40)×10⁻¹⁰ (Δ/σ = 0.038)

- **Cím:** A G gravitációs állandó ugyanebből a struktúrából
- **Képlet:** G = (7×11)/(2³×5²) × √3 × (1+9/250)^(1/40) × 10⁻¹⁰
- **Érték:** `show gLevezetett` ≈ 6.67430×10⁻¹¹
- **Bizonyítás:** — (Double-aritmetika)
- **SVG:** `svg-le13` — a G hibasáv (±1.5e-15), a levezetett benne (sárga — 0.038σ)
- **Hivatkozás:** CODATA 2022 / NIST, G = 6.67430(15)×10⁻¹¹
- **Animáció:** `animaloGOsszehasonlitas` — a hibasáv, a levezetett "belepottyan"
- **Kimeneti formátum (AGENTS §17.4):**
  ```
  érték_levezetett = 6.67430e-11
  érték_mért       = 6.67430e-11 (σ = 1.5e-15, forrás: CODATA 2022)
  Δ                = ~0
  Δ/σ              = 0.038
  ```

### 14. A 137 = [k, d, n] base 10-ben

- **Cím:** A 137 = [k, d, n] base 10-ben
- **Képlet:** 137 = k×100 + d×10 + n = 1×100 + 3×10 + 7
- **Érték:** `show szazHaromHet` = 137
- **Bizonyítás:** `biz137 : SzazHaromHetKonst = 137` (Refl — a bal oldal `steaneK * 100 + steaneD * 10 + steaneN`, a jobb oldal 137; AGENTS §18.1: nem tautológia, mert a bal oldal konstrukciós, a jobb oldal numerikus)
- **SVG:** `svg-le14` — a 137 három számjegyre bontva (1=k, 3=d, 7=n)
- **Hivatkozás:** (belső levezetés, `TetrapodaTest.idr`)
- **Animáció:** —

### 15. A base 10 = 2 × 5 (oktáv × tükör)

- **Cím:** A base 10 = 2 × 5 (oktáv × tükör)
- **Képlet:** 10 = 2 × 5 = oktáv × tükör
- **Érték:** `show baseTiz` = 10
- **Bizonyítás:** `bizBaseTiz : BaseTizKonst = 10` (Refl — a bal oldal `oktavPrim * tukorPrim`, a jobb oldal 10)
- **SVG:** `svg-le15` — a 10 felbontása 2-re és 5-re (oktáv és tükör címkék)
- **Hivatkozás:** Conway & Sloane (1988), *Sphere Packings, Lattices and Groups*
- **Animáció:** `animaloBaseTizFelbontas` — a 10 szétválik 2-re és 5-re

### 16. A 2 = bilaterális szimmetria, 5 = pentadactylia, 4 = D_CRIT

- **Cím:** A szimmetriák: 2 = bilaterális, 5 = pentadactylia, 4 = D_CRIT
- **Képlet:** 2 = oldalak (bal=jobb), 5 = ujjak/végtag, 4 = végtagok (D_CRIT)
- **Érték:** `show oldalakSzama` = 2, `show ujjakSzama` = 5, `show vegltagokSzama` = 4
- **Bizonyítás:** `bizOsszesUjj : OsszesUjjKonst = 10` (Refl — a bal oldal `oldalakSzama * ujjakSzama`, a jobb oldal 10)
- **SVG:** `svg-le16` — három panel (tükör, 5 ujj, 4 végtag)
- **Hivatkozás:** (belső, `TetrapodaTest.idr`)
- **Animáció:** `animaloSzimmetriak` — a szimmetriák fokozatos megjelenése

### 17. A Hox-gének (Shh, Hoxa11, Hoxa13) fixálják az 5 ujjat

- **Cím:** A Hox-gének (Shh, Hoxa11, Hoxa13) fixálják az 5 ujjat
- **Képlet:** Shh (anteroposterior) + Hoxa11 (8. Hox = 2³) + Hoxa13 → 5 ujj (pentadactylia, 360 Mya)
- **Érték:** — (ez nem numerikus lépés, hanem biológiai kontextus)
- **Bizonyítás:** — (nincs Idris-bizonyítás; AGENTS §18.4: "speculatív" jelölés — a biológiai kapcsolat nem bizonyított, csak motivált)
- **SVG:** `svg-le17` — a tetrapoda csontváz + Hox-gén lánc
- **Hivatkozás:** Shubin, N. (2008). *Your Inner Fish*. Pantheon.
- **Animáció:** `animaloHoxGenek` — a Hox-gén lánc, az 5 ujj kialakulása

---

## 8. Összefoglaló (a megvalósításhoz)

**Az `AlphaSteaneDashboard.idr` `main`-je három fájlt generál:**
1. `docs/dashboard_alphasteane/index.html` (HTML + inline SVG + CSS + JS),
2. `docs/dashboard_alphasteane/adatok_alphasteane.json` (minden szám Idrisből),
3. `docs/dashboard_alphasteane/rajzol_alphasteane.py` (Python plotter, JSON-ból olvas).

**A Python futtatása** (`python3 rajzol_alphasteane.py`) generálja az 5 PNG-t.
**A HTML megnyitása** (`open index.html`) a teljes interaktív dashboardot mutatja (offline, nincs külső függőség).

**A 17 lépésből:**
- **5** lépéshez van valódi Refl-bizonyítás (01, 02, 03, 05, 08, 14, 15 — ahol a bal oldal konstrukciós, a jobb oldal numerikus, AGENTS §18.1),
- **12** lépés numerikusan ellenőrzött (Double-aritmetika + `show`, AGENTS §18.4: "speculatív/numerikus" jelölés),
- **0** tautológia (AGENTS §18.1: a dashboard nem tartalmaz `X = X` bizonyításokat).

**A GAUGE-elv (AGENTS §18.5):** a `main` a `lepesekEgyeznekE` ellenőrzéssel összehasonlítja a két független konstanslistát, és ha eltérés van, a HTML-be piros figyelmeztetést ír (soha nem jelent ki "0 hiba"-t ellenőrizetlenül).

---

**VÉGE A TERVNEK.** Ez a dokumentum csak specifikáció — az implementáció egy új `AlphaSteaneDashboard.idr` fájlban történik (AGENTS §13: soha ne írj felül, új fájl). Ez a fájl (`docs/DashboardTerv.md`) nem módosít semmilyen meglévő fájlt.