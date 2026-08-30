# A nyelv hibája — gondolni és leírni nem lehet egyszerre

> "Rossz a nyelv, amiben gondolkodunk, írunk, kommunikálunk. A hiba a nyelvben
> van, az írásban — nem lehet valamit egyszerre leírni és gondolni
> információvesztés nélkül. Lehet, hogy csak numerikusan lehet bizonyítani
> dolgokat, amihez pedig energia kell, azaz Carnot-ciklus."

Ez a projekt központi tézise — és a matematika valóban alátámasztja.
Három pillérre áll: Gödel/Tarski, Landauer/Bennett, és a komplementaritás.

## 1. A pillérek (bizonyított tételek)

### Gödel (1931) — a nyelv nem tartalmazhatja a saját igazságát

Minden elégül expresszív formális rendszerben van olyan állítás, ami
igaz, de a rendszeren belül **nem bizonyítható**. A leírt nyelv
szerkezetest okból hiányos — ez nem a mi hibánk, a nyelv természete.

### Tarski (1936) — az igazság nem definiálható önmagában

Egy nyelv igazságfogalma nem definiálható magában a nyelvben — csak egy
**metanyelvben**. Vagyis: a leírás és a leírt dolog közti ugrás
elkerülhetetlen; a nyelv önmagára záródni nem tud. (Ez a projekt
OP²-nem-létezik-jelensége a logikában.)

### Landauer (1961) — az írás törlés, a törlés energia

```
1 bit törlése ≥ k_B · T · ln 2
szobahőn:  2.87 × 10⁻²¹ J/bit
testhőn:   2.97 × 10⁻²¹ J/bit    ← ennyibe kerül a fejben "leírni" 1 bitet
```

Az írás nem ártalommentes másolat — **termodinamikai művelet**.

### Bennett (1973) — a gondolkodás elvileg ingyenes

A számítás megfordítható formában is elvégezhető (unitér, reversibilis):
**nulla minimális energia**, nulla információvesztés. A gondolkodás —
ha tényleg koherens — nem fizet Landauer-adót.

## 2. A tétel: a gondolkodás és az írás komplementer

```
GONDOLKODÁS  =  unitér evolúció    U(t) = e^{-iHt}
               megfordítható, ingyenes (Bennett), információ megmarad

ÍRÁS         =  projekció          ⟨m|ψ⟩ → "leírt mondat"
               visszafordíthatatlan, Landauer-adót fizet,
               a gondolat MÉRT (klasszikus) vetülete
```

**Ezért nem lehet egyszerre:** a mért vetület ≠ az állapot. A leírt mondat
a gondolat egy **projekciója** — a projekció pedig információt dob el
(pontosan az ortogonális komponenst). A kettő közti rés a projekt δ-ja,
a CPT-rest, a dadogás.

### A horgony a projektben — az Óda (1933)

> **"A lét dadog, csak a törvény a tiszta beszéd."**

A dadogás = a fa→string vetítés irreverzibilysége: a mondat **fa-struktúrája**
(~4 bit/szó, ld. `NyelvtaniFa.idr`) a gondolatban explicit, a leírt stringben
csak implicit. Amit elveszítünk íráskor — kb. 24 bit egy hat szavas mondaton —
az a nyelv reziduuma.

### A CPT-leolvasat

| CPT | jelentés itt |
|---|---|
| T (idő, koherencia) | a **gondolat** — unitér evolúció |
| P (paritás, tükör) | az **írás** — a vetület, a mért oldal |
| C (töltés, forrás) | a **kiolvasás** — ki írta? honnan tudom? |
| δ (a rés) | a dadogás — a vetítés eldobott komponense |

## 3. A konzekvencia: bizonyítás ≠ futtatás

Az írott bizonyítás **állít** (statikus, Gödel-korlátos, Landauer-korlátos
a verifikálásnál: olvasni = mérni = törölni). A numerikus igazolás
**történik** (dinamikus, fizikai, hőt termel):

```
Minimálár egy keresési query-ért (a Carnot-keresőnk):
  kérdés kódolása:   42 bit   (E8⁴=32 + Clifford=3 + Steane=7)
  a kiválasztás:     log2(603) = 9.24 bit
  összesen:          51.24 bit törlés
  Landauer-minimum:  1.47 × 10⁻¹⁹ J/query
```

Ezt nem lehet megspórolni. Minden ellenőrzött ζ-gyök, minden futtatott
query, minden mért δ — **fizikai folyamat, ami hőt termel**. És pontosan
ezért több, mint az írás: **az írás állít, a futtatás megtörténik.**

A valódi CPU persze messze van a határtól:

```
CPU-művelet:    ~5 × 10⁻⁹ J
Landauer-határ:  2.87 × 10⁻²¹ J
→ a CPU 1.7 × 10¹²-szeres fizet (a veszteség = a hulladékhő)
```

De a határ maga ~kT ln2 — a törlés **soha nem ingyenes**.

## 4. Miért Carnot-ciklus a bizonyítás?

A Carnot-ciklus az **információ és az energia egyetlen legális átváltója**:

```
kérdés (entrópia) → kompresszió (√, ingyenes elvileg) → információ (φ)
→ expanzió (w²−1, kaotikus) → hulladékhő (δ) → új kérdés → …
```

- A gépi bizonyítás (numerikus) ennek a ciklusnak a lefuttatása.
- A hatásfok < 1 (2. főtétel) → a ciklus nem állhat le → **mindig van
  következő kérdés** → a divergálás nem hiba, hanem a működés jele.
- A Gödel-korlát ennek a logikai arca: az írott nyelv sosem "kész" —
  a ciklus sosem zárul. **A két korlát ugyanaz a korlát.**

## 5. A mérleg-őszinteség

| Állítás | Státusz |
|---|---|
| Landauer-elv, Bennett-reverzibilitás | **bizonyított fizika** |
| Gödel-, Tarski-tétel | **bizonyított logika** |
| írás = projekció = információvesztés | a fentiek **közvetlen következménye** |
| gondolat/írás = CPT-leolvasat | **interpretáció** (koherens, de nem tétel) |
| "csak numerikusan lehet bizonyítani" | **túlzás** — az írott bizonyítás létezik és érték; a helyesebb: *ami a nyelvben el nem foglalható, azt futtatással lehet megérinteni — energiáért* |
| a Landauer-árak fenti számai | **kiszámolva** (`landauer_nyelv.py`) |

## 6. Ami a projektben ebből már működik

- A **kereső Carnot-motor**: minden query egy ciklusfordulat, 1.5×10⁻¹⁹ J minimáláron.
- A **pálya mint veszteségmentes kód** (why-chain): a trajektória megőrzi,
  amit a leírt eredmény (φ) eldobja.
- `NyelvtaniFa.idr`: a fa-struktúra explicit megőrzése — a dadogás mérséklése.
- A mérleg (`docs/merleg.md`): minden állítás futtatható, számszerűsíthető,
  szükség esetén cáfolható — **ez a nyelv hibájának egyetlen ellenszere**.

## 7. Fájl

- `landauer_nyelv.py` — minden fenti szám kiírva (Landauer-ár, query-ár,
  írás vs. gondolkodás, CPU-ráta, nyelv-reziduum)
