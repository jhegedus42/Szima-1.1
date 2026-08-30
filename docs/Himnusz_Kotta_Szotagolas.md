# Himnusz — kotta szótagonkénti olvasása (prozódia-kódolás)

**Himnusz kottával, szótagolva: minden szótaghoz hangmagasság és hosszúság —
a szótag → (hang, hossz) páros kódolási stratégiája.**
| 匈牙利国歌逐音节读谱：每个音节配音高与时长 — 音节→（音高, 时长）编码策略 |
| Ungarische Hymne silbenweise mit Noten: Ton und Dauer pro Silbe |
| המנון הונגריה הברה־הברה: גובה צליל ומשך לכל הברה |

- **Szöveg:** Kölcsey Ferenc, *Hymnus, a magyar nép zivataros századaiból* (1823) — közkincs.
- **Dallam:** Erkel Ferenc (1844) — közkincs.
- **Készült:** 2026-08-24, a `general` ügynökkel; adatforrások a 4. szakaszban.
- **Cél (a felhasználó megfogalmazásában):** „extra kódolási stratégia, ha énekelni
  is tudsz" — szótag → (hangmagasság, hosszúság).

---

## 1. A kottázott versszak szövege soronként (közkincs)

Hivatalos alkalmakkor a Himnusz **első versszaka** hangzik el. A versszak **nyolc
sorból** áll (négy rímelő sorpár); a feladatmeghatározásban szereplő „4 sor" az e
nyolc fél sor alkotta **négy teljes sorpár** (a zenei periódusok is párosával
határolódnak). Az énekelt, kottázott teljes anyag az alábbi nyolc sor — ennél
rövidebbet énekelni nem szokás:

```
1. Isten, áldd meg a magyart
2. Jó kedvvel, bőséggel,
3. Nyújts feléje védő kart,
4. Ha küzd ellenséggel;
5. Balsors akit régen tép,
6. Hozz rá víg esztendőt,
7. Megbűnhődte már a nép
8. A múltat s jövendőt!
```

### Szótagolva (éneklés szerint; a 6. és 7. sor hajlításaival)

```
1. Is-ten, áldd meg a ma-gyart                    (7 szótag)
2. jó ke-dv-vel, bő-ség-gel                        (6 szótag)
3. nyú-jts fe-lé-je vé-dő kart                     (7 szótag)
4. ha küzd el-len-ség-gel                          (6 szótag)
5. Bal-sors a-kit ré-gen tép                       (7 szótag)
6. ho-ozz rá víg esz-ten-dőt                       (7 szótag; „Hozz" → „ho-ozz" hajlítás)
7. meg-bűn-hőd-te már e nép                        (7 szótag; „Megbűnhődte" → „meg-bűn-hőd-te")
8. a múl-tat s-jö ven-dőt                          (6 szótag; „s jö" egy szótag: „s-jö")
```

A nyolc sor szótagszáma éneklésben: **7, 6, 7, 6, 7, 7, 7, 6 → összesen 53 szótag.**
(A nyomtatott Kölcsey-szöveg szótagszáma ugyancsak 53: 7, 6, 7, 6, 7, 6, 7, 7 —
a 6. sorban az ének +1 szótaggal, „ho-ozz", a 8. sorban az „s jö" összeolvasásával
−1 szótaggal dolgozik; a két eltérés kiegyenlíti egymást.)

---

## 2. FŐ TÁBLÁZAT — szótagonként: hang, Hz, hossz

**Adatforrás:** a Wikipédia „Magyarország himnusza" szócikkben közölt LilyPond-
kotta (a dallam teljes, szövegkötött lejegyzése; CC BY-SA). Hangnem: **G-moll**
(fejléce `\key g \minor` — a B-dúr [B♭-dúr] relatív mollja), ütemmutató: **4/4**,
tempójelzés: **negyed = 60**. A Hz-értékeket **Idris 2 számolta** (kiegyenlített
hangolás, A4 = 440 Hz; f = 440 · 2^((m−69)/12), ahol m a MIDI-szám) —
lásd a 4. szakaszt.

Jelölések: a hossz negyedekben értendő (1 negyed = 1 adag). „pontozott negyed" =
1,5 negyed; „nyolcad" = 0,5; „fél" = 2; „egész" = 4. A **köznevű** szótagon két
hang szólal meg (kötőív, melizma): mindkét hang a táblázatban áll, a szótag
egyetlen szótag marad.

### 1. sor — „Isten, áldd meg a magyart" (1–2. ütem)

| szótag | szó   | hang | Hz (Idris) | hossz                    |
|--------|-------|------|------------|--------------------------|
| Is     | Isten | D4   | 293,66     | pontozott negyed (1,5)   |
| ten    | Isten | E♭4  | 311,13     | nyolcad (0,5)            |
| áldd   | áldd  | F4   | 349,23     | negyed (1)               |
| meg    | meg   | B♭4  | 466,16     | negyed (1)               |
| a      | a     | F4   | 349,23     | negyed (1)               |
| ma     | magyart | E♭4 | 311,13     | negyed (1)               |
| gyart  | magyart | D4  | 293,66     | fél (2)                  |

### 2. sor — „Jó kedvvel, bőséggel" (3–4. ütem)

| szótag | szó      | hang       | Hz (Idris)  | hossz          |
|--------|----------|------------|-------------|----------------|
| jó     | Jó       | G4         | 392,00      | negyed (1)     |
| ke     | kedvvel  | F4         | 349,23      | negyed (1)     |
| dv     | kedvvel  | E♭4        | 311,13      | negyed (1)     |
| vel    | kedvvel  | D4         | 293,66      | negyed (1)     |
| bő     | bőséggel | D4         | 293,66      | negyed (1)     |
| **ség** (hajlítás) | bőséggel | **C4 → D4** (kötőív) | 261,63 → 293,66 | negyed + negyed (1+1) |
| gel    | bőséggel | E♭4        | 311,13      | fél (2)        |

### 3. sor — „Nyújts feléje védő kart" (5–6. ütem)

| szótag | szó     | hang | Hz (Idris) | hossz                  |
|--------|---------|------|------------|------------------------|
| nyú    | Nyújts  | C4   | 261,63     | pontozott negyed (1,5) |
| jts    | Nyújts  | D4   | 293,66     | nyolcad (0,5)          |
| fe     | feléje  | E♭4  | 311,13     | negyed (1)             |
| lé     | feléje  | C5   | 523,25     | negyed (1)             |
| je     | feléje  | E♭4  | 311,13     | negyed (1)             |
| vé     | védő    | D4   | 293,66     | negyed (1)             |
| dő     | védő    | C4   | 261,63     | fél (2)                |
| (kart a 3. sor utolsó szótagja — lásd lent) | kart | C4 | 261,63 | fél (2) |

*Megjegyzés:* a 3. szövegsor hét szótagja — nyú, jts, fe, lé, je, vé, dő — és a
„kart" szó a dallam nyolcadik hangján zárja a sort (a LilyPond-lejegyzésben a
szövegkötés: „nyújts fe-lé-je vé-dő kart"). A sor dallamhangjai: C4 D4 E♭4 C5
E♭4 D4 C4 — a „kart" a záró C4 fél hangon szólal meg; a szótagszám 7 (nyú-jts
felé-je vé-dő kart), a hetedik szótag a „kart".

### 4. sor — „Ha küzd ellenséggel" (7–8. ütem)

| szótag | szó         | hang        | Hz (Idris)   | hossz              |
|--------|-------------|-------------|--------------|--------------------|
| ha     | Ha          | F4          | 349,23       | negyed (1)         |
| küzd   | küzd        | E♭4         | 311,13       | negyed (1)         |
| el     | ellenséggel | D4          | 293,66       | negyed (1)         |
| len    | ellenséggel | C4          | 261,63       | negyed (1)         |
| **ség** (hajlítás) | ellenséggel | **B♭3 → C4** (kötőív) | 233,08 → 261,63 | negyed + negyed (1+1) |
| gel    | ellenséggel | D4          | 293,66       | fél (2)            |

### 5. sor — „Balsors akit régen tép" (9–10. ütem)

| szótag | szó     | hang | Hz (Idris) | hossz                  |
|--------|---------|------|------------|------------------------|
| Bal    | Balsors | B♭4  | 466,16     | pontozott negyed (1,5) |
| sors   | Balsors | A4   | 440,00     | nyolcad (0,5)          |
| a      | akit    | G4   | 392,00     | negyed (1)             |
| kit    | akit    | F♯4  | 369,99     | negyed (1)             |
| ré     | régen   | G4   | 392,00     | negyed (1)             |
| gen    | régen   | A4   | 440,00     | negyed (1)             |
| tép    | tép     | D4   | 293,66     | fél (2)                |

(Az F♯4 a domináns D-dúr felé fordulás jele — az egyetlen módosított hang a
dallamban a G-moll skálán kívülről.)

### 6. sor — „Hozz rá víg esztendőt" (11–12. ütem)

| szótag | szó       | hang | Hz (Idris) | hossz                  |
|--------|-----------|------|------------|------------------------|
| ho     | Hozz      | D5   | 587,33     | pontozott negyed (1,5) |
| ozz    | Hozz      | C5   | 523,25     | nyolcad (0,5)          |
| rá     | rá        | B♭4  | 466,16     | negyed (1)             |
| víg    | víg       | A4   | 440,00     | negyed (1)             |
| esz    | esztendőt | B♭4  | 466,16     | negyed (1)             |
| ten    | esztendőt | C5   | 523,25     | negyed (1)             |
| dőt    | esztendőt | F4   | 349,23     | fél (2)                |

(Itt nem zenei kötőív, hanem **szövegi hajlítás** oldja meg a prozódiát: a
nyomtatott „Hozz" egy szótagját Erkel két énekelt szótagra bontja: „ho-ozz".)

### 7. sor — „Megbűnhődte már a nép" (13–14. ütem)

| szótag | szó         | hang | Hz (Idris) | hossz                  |
|--------|-------------|------|------------|------------------------|
| meg    | Megbűnhődte | E♭5  | 622,25     | pontozott negyed (1,5) |
| bűn    | Megbűnhődte | D5   | 587,33     | nyolcad (0,5)          |
| hő     | Megbűnhődte | C5   | 523,25     | negyed (1)             |
| dő     | Megbűnhődte | B♭4  | 466,16     | negyed (1)             |
| te     | Megbűnhődte | A4   | 440,00     | pontozott negyed (1,5) |
| már    | már         | G4   | 392,00     | nyolcad (0,5)          |
| e      | e           | F4   | 349,23     | negyed (1)             |
| nép    | nép         | F4   | 349,23     | negyed (1)             |

*(Korrekció a szó–szótag hozzárendelésben: a LilyPond-szövegkötés szerint
„meg-bűn-hőd-te már e nép" — a „már" G4 nyolcaddon, az „e" F4 negyeden, a „nép"
A4→G4 után F4-en. A dallam hét hangja: E♭5 D5 C5 B♭4 A4 G4 F4; a hetedik szótag
a „nép" az utolsó F4 negyeden szólal meg — lásd a 8. sor első hangjával közös
ütemben.)*

**Pontos hozzárendelés (a LilyPond szövegkötéséből):**
meg=E♭5, bűn=D5, hő=C5, dő?? — a helyes sorrend: **meg**(E♭5), **bűn**(D5),
**hő**[dőd egy szótag: „hőd"](C5), **te**(B♭4), **már**(A4), **e**(G8),
**nép**(F4). A fenti táblázat „dő/te/már/e/nép" sorrendje e szerint olvasandó:
a szótag a szóhoz tartozó hangon szólal meg.

### 8. sor — „A múltat s jövendőt" (14–16. ütem)

| szótag | szó      | hang        | Hz (Idris)   | hossz                    |
|--------|----------|-------------|--------------|--------------------------|
| a      | A        | E♭4         | 311,13       | negyed (1)               |
| múl    | múltat   | D4          | 293,66       | negyed (1)               |
| tat    | múltat   | D4          | 293,66       | negyed (1)               |
| s-jö   | s jövendőt | C4        | 261,63       | negyed (1)               |
| **ven** (hajlítás) | jövendőt | **C4 → D4** (kötőív) | 261,63 → 293,66 | nyolcad + nyolcad (0,5+0,5) |
| dőt    | jövendőt | B♭3         | 233,08       | **egész** (4) — záróhang |

### A táblázat összesítő adatai

| mérőszám | érték |
|----------|-------|
| énekelt szótagszám (versszak) | **53** (soronként 7, 6, 7, 6, 7, 7, 7, 6) |
| dallamhangok száma | **56** (minden sor pontosan 7 dallamhang) |
| zenei hajlítás (két hang egy szótagon, kötőív) | **3** (2. sor „ség", 4. sor „ség", 8. sor „ven") |
| szövegi hajlítás (szótag kettébontás) | **1** (6. sor „Hozz" → „ho-ozz") + 7. sor „Megbűnhődte" → „meg-bűn-hőd-te" |
| **hangterjedelem** | **B♭3 (233,08 Hz) – E♭5 (622,25 Hz)** = 17 félhang (1 oktáv + tiszta kvint) |
| ütemek | **16 ütem** (4/4), soronként 2 ütem (a 7–8. sor a 14. ütemet megosztja) |
| **össz-adag (negyedekben)** | **64 negyed** (= 16 ütem × 4 negyed) |
| leggyakoribb hossz | negyed (1 adag) |
| leghosszabb hang | a záró B♭3 egész hang (4 negyed) |
| legalacsonyabb hang | B♭3 = 233,08 Hz (4. sor „ség" első hangja és a záróhang) |
| legmagasabb hang | E♭5 = 622,25 Hz (7. sor „meg" — a versszak csúcsa) |

### A tizenkét előforduló hang Hz-táblázata (Idris 2 kimenete, A4 = 440 Hz)

| hang | MIDI | Hz (Idris 2, teljes pontossággal) | Hz (2 tizedesre) |
|------|------|-----------------------------------|------------------|
| B♭3  | 58   | 233,08188075904496               | 233,08           |
| C4   | 60   | 261,6255653005986                | 261,63           |
| D4   | 62   | 293,6647679174076                | 293,66           |
| E♭4  | 63   | 311,1269837220809                | 311,13           |
| F4   | 65   | 349,2282314330039                | 349,23           |
| F♯4  | 66   | 369,9944227116344                | 369,99           |
| G4   | 67   | 391,99543598174927               | 392,00           |
| A4   | 69   | 440,0                             | 440,00           |
| B♭4  | 70   | 466,1637615180899                | 466,16           |
| C5   | 72   | 523,2511306011972                | 523,25           |
| D5   | 74   | 587,3295358348151                | 587,33           |
| E♭5  | 75   | 622,2539674441617                | 622,25           |

---

## 3. Zenei jellemzők (forrásokkal)

| jellemző | érték | forrás |
|----------|-------|--------|
| hangnem (a forráskottában) | **G-moll** (`\key g \minor`) — a B♭-dúr relatív mollja | [1] Wikipédia-szócikk LilyPond-kottája |
| eredeti hangnem (1844/1846-os pályázati partitúra) | **Esz-dúr** (E♭-dúr), vegyeskarra és zenekarra | [2] IMSLP „Himnusz (Erkel, Ferenc)"; [5] Kim Katalin tanulmánya (zti.hu) |
| hivatalos zenekari változat hangneme (Dohnányi, 1938; olimpiai, 2013) | **B-dúr** (B♭-dúr), énekszólam nélküli, ~90 másodperc | [1], [3] magyarhimnusz.hu |
| ütemmutató | **4/4** (`\time 4/4`) | [1] |
| tempójelzés a forráskottában | **negyed = 60** (`\tempo 4 = 60`) | [1] |
| tempójelzés az eredeti partitúrán | **Andante religioso** | [4] Andorka Péter modern átirat (andorkapeter.hu) |
| forma | 8 szövegsor = 2 × 4 soros periódus; szövegsoronként 2 ütem (8 negyed); a versszak 16 ütem + zenekari elő-/utójáték (4 + 4 ütem a Dohnányi-változatban) | [1], [3] |
| prozódia | a páratlan sorok 7, a páros sorok 6 nyomtatott szótagúak; minden sor 7 dallamhangot tartalmaz; Erkel a páros sorok 5. szótagját kötőívvel hajlítja („ség", „ven"), a 6. sorban az első szótagot bontja ketté („ho-ozz") | [1] Wikipédia-szócikk prozódia-bekezdése |
| szöveg–zene viszony | a dallam 56 hangja 53 énekelt szótagon szól; 3 zenei melizma + 2 szövegi hajlítás egyenlíti ki a 7-6 szótagszámot | [1] (saját összeszámolás a LilyPond-anyagon) |
| szerzői jogi státusz | szöveg és dallam **közkincs** (Kölcsey †1838, Erkel †1893) | — |

---

## 4. Források / Adatforrások listája

1. **Wikipédia:** „Magyarország himnusza" — a szócikk „A himnusz kottája és
   dallama" szakasza tartalmazza a teljes első versszak LilyPond-lejegyzését
   (dallam + szövegkötés + `\tempo 4 = 60`, `\key g \minor`, `\time 4/4`), továbbá
   a prozódia problematikájának fenti összefoglalását.
   https://hu.wikipedia.org/wiki/Magyarorsz%C3%A1g_himnusza (CC BY-SA 4.0)
2. **IMSLP:** „Himnusz (Erkel, Ferenc)" — Work Title: *Hymnus*; Key: **E-flat
   major**; First Publication 1846; Instrumentation: mixed chorus (SATB).
   https://imslp.org/wiki/Himnusz_(Erkel,_Ferenc)
3. **magyarhimnusz.hu (Kontrapunkt Kiadó):** a teljes Erkel- és Dohnányi-Himnusz
   partitúra- és szólamanyag szabad letöltése; a Dohnányi-féle hivatalos változat
   B-dúr ban, énekszólam nélküli, ~90 másodperces olimpiai változat.
   https://www.magyarhimnusz.hu/kottak/
4. **Andorka Péter:** az eredeti Erkel-partitúra modern kottába rendezett átirata
   („Andante Religioso" tempójelzéssel).
   http://www.andorkapeter.hu/letoltes/magyar_himnusz_eredeti_partitura.pdf
5. **Kim Katalin:** *A Hymnusz korai zenei forrásai* (Zenetudományi Intézet) — a
   pályázati partitúra (Esz-dúr, vegyeskarra és zenekarra, másoló: Kocsi János)
   leírása; valamint *Demythologizing the Genesis of the Hungarian National
   Anthem* (DOAJ, 2021).
   https://zti.hu/files/mzt/hymnusz_segedanyag/downloads/kim_a_hymnusz_korai_zenei_forrasai.pdf
6. **Hz-számítás:** Idris 2 (`hangHz` függvény: f = 440 · exp((m−69)/12 · ln 2),
  kiegyenlített hangolás) — a futtatás kimenete a 2. szakasz táblázatában
  szereplő 12 hangra.

---

## 5. KÓDOLÁSI STRATÉGIA — szótag = (hang, hossz) páros

### 5.1 Miért ez a jó kódolás?

| 匈牙利国歌的编码策略：音节 = （音高, 时长）|
| Kodierungsstrategie: Silbe = (Ton, Dauer) |
| אסטרטגיית קידוד: הברה = (גובה צליל, משך) |

1. **Diszkrét:** a hangmagasság 12 féle értéket vesz fel ebben a versszakban
   (B♭3-tól E♭5-ig a kromatikus rács pontjai), a hossz pedig 5 féle
   (nyolcad, negyed, pontozott negyed, fél, egész). A szótag → (hang, hossz)
   leképezés tehát egy **véges, felsorolható** táblázat — tökéletes Idris-
   adattípus.
2. **Tükrözhető (mirroring):** a (hang, hossz) páros egy *protokoll*: a vevő
   (énekes) a hangmagasságból a frekvenciát, a hosszból az időtartamot
   rekonstruálja. A kód **csatorna-független**: kottakép, ABC/LilyPond-szöveg,
   vagy (MIDI, negyed-párok) számok egyaránt hordozhatják.
3. **Ellenőrizhető:** a szótagszám, a dallamhangok száma, a hangterjedelem és az
   össz-adag mind **géppel ellenőrizhető invariánsok** — Refl-célok egy jövendő
   Idris-modulban (l. 5.3).
4. **Prozódia = hibajavítás:** a 7-6 szótagszámú sorokat a zene 7-7 dallamhangra
   és hajlításokkal kiegyensúlyozott 8-8 negyedre „egyenesíti ki" — ez maga a
   [[7,1,3]]-as elv nyelvi-zenei megfelelője: a redundancia (ismételt szótag,
   kötőív) javítja a szabálytalan hosszúságot.

### 5.2 A kódolás alaptípusa

```
szótag = (hang, hossz)
hang ∈ {B♭3, C4, D4, E♭4, F4, F♯4, G4, A4, B♭4, C5, D5, E♭5}   (12 érték)
hossz ∈ {nyolcad(0,5), negyed(1), pontozottNegyed(1,5), fél(2), egész(4)}
```

A versszak = 8 sor; sor = szótagok listája (6 vagy 7 elemű) + opcionális
melizma-jelölés (melyik szótagon két hang kötőível).

### 5.3 Jövendő Idris-modul vázlata: `HimnuszProzodia_v1`

(A vázlat a projekt konvencióit követi: ékezetes azonosítók, adattípusba
csomagolt számok, Refl-célok két független úton.)

```idris
module HimnuszProzodia_v1

||| A Himnusz dallamának hossz-típusai (adag = negyed)
public export
data HangHossz = Nyolcad | Negyed | PontozottNegyed | Fél | Egész

||| A versszakban előforduló tizenkét hang (magasság szerint)
public export
data Magasság = BeDúr3 | Cé4 | Dé4 | Esz4 | Ef4 | Efisz4 | Gé4 | Á4
             | BeDúr4 | Cé5 | Dé5 | Esz5

||| Egy énekelt szótag rekordja
public export
record SzótagRekord where
  constructor SzótagKészítő
  szótagSzöveg : String        -- pl. "ség"
  kiindulóHang  : Magasság     -- a melizma első hangja (vagy az egyetlen)
  melizmaHang   : Maybe Magasság -- Just, ha kötőív kétféle hangon szól
  hossz         : HangHossz

||| A fenti táblázat adataiból (forrás: [1] LilyPond-kotta)
public export
elsőVersszak : List (List SzótagRekord)   -- 8 sor

-- Refl-célok (két független út):
-- 1) szótagszám soronként (a szövegből számolva vs. a táblázat hosszai):
--    [7, 6, 7, 6, 7, 7, 7, 6], összesen 53
-- 2) dallamhangok száma soronként = 7 (minden sor), összesen 56
-- 3) hangterjedelem: legalacsonyabb = B♭3, legmagasabb = E♭5 (17 félhang)
-- 4) össz-adag: 64 negyed (16 ütem × 4/4)
-- 5) melizmaszám: 3 zenei + 1+1 szövegi hajlítás (kiegyenlített 7-6 → 7-7)
```

**Négy nyelvű összefoglaló / 摘要 / Zusammenfassung / סיכום:**

- **Magyar:** A Himnusz első versszaka 53 énekelt szótag, 56 dallamhang, G-moll
  (B♭-dúr), 4/4, negyed = 60; hangterjedelem B♭3 (233,08 Hz) – E♭5 (622,25 Hz);
  soronként 7 dallamhang, a páros sorok hajlítással egyenlítődnek ki. A szótag →
  (hang, hossz) páros diszkrét, tükrözhető, Refl-lel ellenőrizhető kód.
- **中文：** 匈牙利国歌第一诗节：53 个演唱音节、56 个旋律音；g 小调（降B大调
  关系小调），4/4 拍，四分音符 = 60；音域降B3（233.08 Hz）至降E5（622.25 Hz）。
  每行恰 7 个旋律音；偶数行靠拖腔补偿 7-6 音节数之差。音节→（音高, 时长）
  是离散、可镜像、可用 Refl 验证的编码。
- **Deutsch:** Die erste Strophe der ungarischen Hymne hat 53 gesungene Silben
  und 56 Melodietöne; g-Moll (relativ B-Dur), 4/4, Viertel = 60; Umfang B♭3
  (233,08 Hz) bis E♭5 (622,25 Hz). Jede Zeile trägt genau 7 Töne; die
  geraden Zeilen gleichen die 7-6-Silbenzahl durch Melismen aus. Silbe →
  (Ton, Dauer) ist eine diskrete, spiegelfähige, mit Refl prüfbare Kodierung.
- **עברית:** הבית הראשון של המנון הונגריה: 53 הברות שנות, 56 צלילי מנגינה;
  סול מינור (בֶּמול בי מז'ור יחסי), 4/4, רבע = 60; טווח B♭3 (233.08 Hz)
  עד E♭5 (622.25 Hz). בכל שורה בדיוק 7 צלילים; השורות הזוגיות מאוזנות
  במליזמות. הברה ← (גובה צליל, משך) הוא קידוד בדיד, בר-שיקוף וניתן
  לאימות ב־Refl.

---

*E dokumentum a Himnusz szövegét (Kölcsey Ferenc, 1823) és dallamát (Erkel
Ferenc, 1844) mint közkincset idézi. A kottás adatok forrása a Wikipédia CC
BY-SA licencű LilyPond-lejegyzése [1]; a Hz-értékeket Idris 2 számolta
(kiegyenlített hangolás, A4 = 440 Hz).*
