# SZIMA MŰSZERFAL v1 — a projekt minden kulcsmutatója egy helyen

> **Webes kiadás:** a műszerfal élő weboldalként is elérhető — `docs/muszerefal.html`, a GitHub Pages kiadás URL-je: `https://jhegedus42.github.io/Szima/muszerefal.html` (a `.github/workflows/pages.yml` workflow minden docs-változásnál automatikusan kiteszi a `/docs` mappát).

# SZIMA INSTRUMENT PANEL v1 · 西玛仪表盘 v1 · Instrumententafel v1 · לוח המחוונים v1

**W9 munkafolyam terméke.** A műszerfal (`szima_ter/modul/Muszerefal_v1.idr`)
NEM számol új számot — minden mutató az importált modulok kifutása
(AGENTS §24: kód duplikáció tilos). Ez a dokumentum a tényleges
`--exec main` futás kimenetét rögzíti (GAUGE-elv — semmit nem jelentünk ki
ellenőrizetlenül, AGENTS §18/5).

---

## Futtatási parancsok · 运行命令 · Ausführungsbefehle · פקודות הרצה

```
# Fordítás (teljes csomag, 0 hiba kötelező):
idris2 --build szima_ter/szima.ipkg

# Futtatás (a modulkönyvtárból, hogy a testvérmodulok feloldódjanak):
cd szima_ter/modul
idris2 --exec main Muszerefal_v1.idr
```

Mért futási idő (2026-08-23, macOS arm64): összesen ~8,2 s — ebbe beletartozik
a fordító általi újratípusellenőrzés és a **kimerítő futásidejű táblák**
(240×240 = 57 600 páros ellenőrzések) kiszámítása is.

---

## 1. E8 GEOMETRIA · E8 几何 · E8-Geometrie · גיאומטריית E8

Forrás-modul: **`E8Iranymutato_v1`** (a számok a modul
`iranymutatoMutatok` rekordjából és futásidejű számlálásából).

| Mutató | Érték (a futásból) | Forrás-modul |
|---|---|---|
| gyök száma | **240** | E8Iranymutato_v1 |
| egész gyökök (112-es osztály) | **112** | E8Iranymutato_v1 (tipus1SzamSzamitott) |
| fél-egész gyökök (128-as osztály) | **128** | E8Iranymutato_v1 (tipus2SzamSzamitott) |
| W(E8) rendje | **696729600** = 2¹⁴·3⁵·5²·7 | E8Iranymutato_v1 |
| E8 dimenzió | **248** | E8Iranymutato_v1 |
| E8×E8 dimenzió (heterotikus string) | **496** | E8Iranymutato_v1 |
| 240 gyök + 16 penge hídja | **256** | E8Iranymutato_v1 (hid256Szamitott; E8TizenhatPenge) |
| minden gyök normája² = 8? | **True** | E8Iranymutato_v1 (mindenGyokNormajaNyolc; E8BelsoSzorzat) |

## 2. A [[7,1,3]] HÍD ÉS A POZITÍV ÁBÉCÉ · 斯坦恩码桥 · Die [[7,1,3]]-Brücke

Forrás-modul: **`E8FazisKapcsolat_v2`**.

| Mutató | Érték (a futásból) | Forrás-modul |
|---|---|---|
| pozitív ábécé (a 240 felső fele) | **120** | E8FazisKapcsolat_v2 (PozitivGyokokKonst) |
| Steane 7 bit | **idő okság tér szín hang fázis mód** | E8FazisKapcsolat_v2 (steaneHetBitNevek) |
| a „fázis" bit indexe (0-alapú) | **5** | E8FazisKapcsolat_v2 (SteaneFazisIndexKonst; Refl: BizFazisBitHíd) |

## 3. A NYELV · 语言 · Die Sprache · השפה

Forrás-modulok: **`GyokSzo_v1`** (szókincs), **`Fogalom_v1`** (fogalomtár),
**`Mondat_v1`** (CPT-bélyegek), **`E8BelsoSzorzat`** (eloszlás).

| Mutató | Érték (a futásból) | Forrás-modul |
|---|---|---|
| alapszókincs | **240** | GyokSzo_v1 (AlapszókincsKonst) |
| egész szavak (állandó fogalmak) | **112** | GyokSzo_v1 (EgészSzavakKonst) |
| fél-egész szavak (kapcsolati fogalmak) | **128** | GyokSzo_v1 (FélEgészSzavakKonst) |
| fogalomtár (szó + D8-pálya + kategória) | **240** | Fogalom_v1 (fogalomTárMéreteFutás) |
| távolság-eloszlás (+1, +½, 0, −½, −1) | **(1, 56, 126, 56, 1)** | E8BelsoSzorzat (eloszlas) — a futás nyers Show-képe: `(1, (56, (126, (56, 1))))` (az Idris2 a 5-ös tuple-t jobbra zárójelezi) |
| bélyegek (3×3×3 töltés·paritás·idő) | **27** | Mondat_v1 (CPTBélyegekKonst) |
| példabélyeg fázistényezője (diagonális koherencia) | **1.0** | Mondat_v1 (fázistényező; FazisAlgebra_v2) |

## 4. FIZIKA · 物理 · Physik · פיזיקה

Forrás-modulok: **`E8Iranymutato_v1`** (2D Ising), **`E8Univerzalitas_v1`**
(skálacímkék), **`CarnotCiklus_v1`** + **`MagyarCarnotE9_v3_CodatAlpha`**
(Carnot, Landauer).

| Mutató | Érték (a futásból) | Forrás-modul |
|---|---|---|
| 2D Ising α, β, γ, ν | **0.0, 0.125, 1.75, 1.0** | E8Iranymutato_v1 (ising-mezők; pontos törtek: E8Univerzalitas_v1) |
| univerzalitási osztály | 2D Ising (Z2 szimmetria-törés) | E8Iranymutato_v1 |
| ising-egyezés (tört ⟷ Double) | **True** | E8Univerzalitas_v1 (kétDimenziósIsingEgyezésE8Iranymutatóval) |
| 3D skálacímkék teljesülnek? | **True** (tűrés: 1e-6) | E8Univerzalitas_v1 |
| Rushbrooke-maradék \|α+2β+γ−2\| | **9.99999993922529e-9** | E8Univerzalitas_v1 (bootstrap: Chang et al. 2025) |
| Hiperskála-maradék \|2−α−3ν\| | **9.99999993922529e-9** | E8Univerzalitas_v1 |
| Fisher-maradék \|γ−ν(2−η)\| | **1.1840323610456949e-8** | E8Univerzalitas_v1 |
| Carnot η(Th=500 K, Tc=300 K) | **0.4** (tört alakban 200/500, Refl) | MagyarCarnotE9_v3_CodatAlpha (carnotHatekonysag); CarnotCiklus_v1 (hatásfokTört) |
| Carnot η(Th=600 K, Tc=300 K) | **0.5** (1/2) | mint fent |
| Carnot η(Th=800 K, Tc=300 K) | **0.625** (5/8) | mint fent |
| Carnot η(Th=373 K, Tc=273 K) | **0.26809651474530827** (100/373) | mint fent (víz/jég pár) |
| Boltzmann kB (SI-exakt, 2019 SI) | **1.380649e-23 J/K** | CarnotCiklus_v1 (boltzmannÁllandó) |
| Landauer-küszöb T = 300 K | **2.870978885078724e-21 J** | CarnotCiklus_v1 (landauerKüszöb) |
| Landauer-küszöb T = 1 K | **9.569929616929079e-24 J** | CarnotCiklus_v1 (landauerKüszöb) |

§17 megjegyzés: a kB SI-definíció szerint exakt (nincs mérési σ); az egyetlen
számítási pontatlanság az IEEE-754 kerekítés (ln 2). A 3D maradékok (~10⁻⁸)
a bootstrap-bizonytalanság skáláján vannak, jóval a 10⁻⁶-os konzervatív
tűrés alatt.

## 5. KIMERÍTŐ FUTÁSIDEJŰ ÁLLAPOTOK (GAUGE-elv) · 穷举运行时状态

Forrás-modulok: **`GyokSzo_v1`**, **`Fogalom_v1`**, **`SzintaxisMorfizmus_v1`**,
**`Mondat_v1`**.

| Állapot | Érték (a futásból; várt) | Lefedett tér | Forrás-modul |
|---|---|---|---|
| szó-osztályhibák | **0** (0) | 240 szó | GyokSzo_v1 (osztályHibákSzáma) |
| távolság-skála hibái | **0** (0) | 240×240 = **57600** pár | GyokSzo_v1 (távolságSkálaHibákSzáma) |
| kategória-hibák | **0** (0) | 240 fogalom | Fogalom_v1 (kategóriaHozzárendelésHibákSzáma) |
| zártságsértések (komponálás) | **0** (0) | 240×240 = 57600 komponálás | SzintaxisMorfizmus_v1 (komponálásZártságiHibákSzáma) |
| involúció-sértések (σ∘σ=id) | **0** (0) | 240×240 = 57600 dupla komponálás | SzintaxisMorfizmus_v1 (involúcióHibákSzáma) |
| ellenpont pályaváltásai | **0** (0) | 240 ellenpont | SzintaxisMorfizmus_v1 (ellenpontPályaHibákSzáma) |
| bélyeg-különbözőségek (nub) | **27** (27) | 27 bélyeg | Mondat_v1 (különbözőBélyegekSzáma) |

## 6. HÍD-BIZONYÍTÁS (kernel-Refl, §18 — két független út, egy híd)

A műszerfal EGYETLEN új tétele (minden más importált):

```
bizMűszerfalEmeletekHídja :
  List.length AlapszókincsKonst = List.length FogalomTárKonst
bizMűszerfalEmeletekHídja = trans (sym bizKétÚtHíd) bizKétPályaHídFogalmon
```

Jelentése: **a nyelv két emelete (szavak és fogalmak) ugyanannyi jelet fog
át** — a szókincs-lista (GyokSzo_v1) és a fogalomtár-lista (Fogalom_v1) két
független enumeráció, amelyek a kombinatorikai hídon (112 + 128) keresztül
kényszerülnek ugyanarra a 240-re. Nem X = X (§18); a bizonyítás két IMPORTÁLT
tétel (bizKétÚtHíd, bizKétPályaHídFogalmon) összetétele (§24: a
bizonyítások is újból használandók, nem újraírandók).

Importált támasz-bizonyítások, amelyeket a műszerfal megnevez:
- `TipusOsszegBizonyit` (112 + 128 = 240), `WeylRendFelezettBizonyit`,
  `WeylRendPrimtenyezosBizonyit`, `E8E8DimenzioBizonyit` — E8Iranymutato_v1;
- `bizKétÚtHíd` — GyokSzo_v1;
- `bizKétPályaHídFogalmon` — Fogalom_v1;
- `bizBélyegHíd` (3×3×3 = 27) — Mondat_v1.

---

## A futás teljes kimenete (szó szerint, 2026-08-23)

```
════════════════════════════════════════════════════════
  SZIMA MŰSZERFAL v1 — minden kulcsmutató egy helyen (W9)
  SZIMA INSTRUMENT PANEL · 西玛仪表盘 · Instrumententafel
  לוח המחוונים של סימה — כל המדדים במקום אחד
════════════════════════════════════════════════════════

── 1. E8 GEOMETRIA (forrás: E8Iranymutato_v1) ──
  gyök száma                    : 240
  egész gyökök (112-es osztály) : 112
  fél-egész gyökök (128-as)     : 128
  W(E8) rendje                  : 696729600
  E8 dimenzió                   : 248
  E8×E8 dimenzió                : 496
  240 gyök + 16 penge hídja     : 256
  minden gyök normája² = 8?     : True

── 2. A [[7,1,3]] HÍD ÉS A POZITÍV ÁBÉCÉ (forrás: E8FazisKapcsolat_v2) ──
  pozitív ábécé (a 240 fele)    : 120
  Steane 7 bit                  : [idő okság tér szín hang fázis mód]
  a fázis-bit indexe (0-alapú)  : 5

── 3. A NYELV (forrás: GyokSzo_v1, Fogalom_v1, Mondat_v1) ──
  alapszókincs                  : 240
  egész szavak (állandó)        : 112
  fél-egész szavak (kapcsolati) : 128
  fogalomtár (szó+pálya+kateg.) : 240
  távolság-eloszlás (+1,+½,0,−½,−1): (1, (56, (126, (56, 1))))
  bélyegek (3×3×3)              : 27
  példabélyeg fázistényezője    : 1.0

── 4. FIZIKA (forrás: E8Iranymutato_v1, E8Univerzalitas_v1, CarnotCiklus_v1) ──
  2D Ising α, β, γ, ν           : 0.0, 0.125, 1.75, 1.0
  univerzalitási osztály        : 2D Ising (Z2 szimmetria-torés)
  ising-egyezés (tört ⟷ Double) : True
  3D skálacímkék teljesülnek?   : True   (tűrés: 1e-6)
    Rushbrooke-maradék |α+2β+γ−2|  : 9.99999993922529e-9
    Hiperskála-maradék  |2−α−3ν|   : 9.99999993922529e-9
    Fisher-maradék      |γ−ν(2−η)| : 1.1840323610456949e-8
  Carnot η(Th=500 K, Tc=300 K)  : 0.4
  Carnot η(Th=600 K, Tc=300 K)  : 0.5
  Carnot η(Th=800 K, Tc=300 K)  : 0.625
  Carnot η(Th=373 K, Tc=273 K)  : 0.26809651474530827
  Boltzmann kB (SI-exakt)       : 1.380649e-23 J/K
  Landauer-küszöb T = 300 K     : 2.870978885078724e-21 J
  Landauer-küszöb T = 1 K       : 9.569929616929079e-24 J

── 5. KIMERÍTŐ FUTÁSIDEJŰ ÁLLAPOTOK (GAUGE-elv; mindegyik várt: 0) ──
  szó-osztályhibák (240 szó)    : 0
  távolság-skála hibái          : 0   (a 57600 párból)
  kategória-hibák (240 fogalom) : 0
  zártságsértések (komponálás)  : 0
  involúció-sértések (σ∘σ=id)   : 0
  ellenpont pályaváltásai (240) : 0
  bélyeg-különbözőségek (nub)   : 27   (várható: 27)

── 6. HÍD-BIZONYÍTÁS (kernel-Refl, §18 — két út, egy híd) ──
  length AlapszókincsKonst = length FogalomTárKonst   [bizMűszerfalEmeletekHídja]
    — a nyelv két emelete (szavak ⟷ fogalmak) ugyanannyi jelet fog át;
      a híd: trans bizKétÚtHíd (sym bizKétPályaHídFogalmon) — két importált, független út
  importált támaszok: TipusOsszegBizonyit, WeylRendPrimtenyezosBizonyit (E8Iranymutato_v1);
    bizKétÚtHíd (GyokSzo_v1); bizKétPályaHídFogalmon (Fogalom_v1); bizBélyegHíd (Mondat_v1)

Kész / 完成 / Fertig / גמר
```

(Megjegyzés: a 6. szakasz kiírt szövegében a híd szó szerinti alakja
`trans (sym bizKétÚtHíd) bizKétPályaHídFogalmon`; a kiírás rövidítetlen
megnevezése a két importált tételnek.)

---

## Mérnöki megjegyzések · 工程说明 · Anmerkungen

1. **A Carnot-hatásfokok kijelzése**: a `CarnotCiklus_v1`-beli `Hatásfok`
   rekord modulon belüli (nem `public export`), ezért a műszerfal a publikus
   `carnotHatekonysag` képlettel (MagyarCarnotE9_v3_CodatAlpha) jeleníti
   meg a négy párt; a pontos törtek (200/500, 300/600→1/2, 500/800→5/8,
   100/373) a CarnotCiklus_v1 saját, Refl-lel bizonyított kimenetén élnek.
2. **A távolság-eloszlás nyers Show-képe** `(1, (56, (126, (56, 1))))` —
   az Idris 2 az n-es tuple-t jobbra zárójelezve nyomja; a matematikai
   tartalom (1, 56, 126, 56, 1).
3. **A Steane-bitnevek** a `Data.String.unwords` stdlib-függvénnyel
   olvasható alakban jelennek meg (a `show (List String)` oktális
   escape-elné a.diakritikus betűket — Idris2/Chez megjelenítési sajátosság).
