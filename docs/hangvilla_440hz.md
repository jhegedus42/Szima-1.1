# A hangvilla és a 440 Hz — honnan jön?

## A kérdés

A projektben mindenhol A4 = 440 Hz áll (a Bach-korrekcio: α⁻¹ = 137 + 9/250 − A4·(3/4)²/c),
de sosem kérdeztük meg: **honnan jön maga a 440?**

Rövid válasz: **sehonnan — konvenció.** De a története tanulságos, és a
projekt-honestynak is fájó pontot érinti.

## 1. A hangvilla (1711) — az első zseben hordozható frekvencia-szabvány

A **hangvillát John Shore** találta fel 1711-ben — Handel és Purcell trombitása.
("The pitch I give you, Sir" — a vigasz-díj a rossz hangnemű hangokért.)

Előtte nem volt hordozható, stabil frekvencia-referencia: a hangmagasság
templomonként, városonként, kórusonként **309 Hz-től (17. sz. Párizs) egészen
480+ Hz-ig** cibálódott. A jelenség neve *pitch inflation*: a kórusok és
orgonák versenyeztek, ki hangosabb-fényesebb — a hangok egyre feljebb
csúsztak, az énekesek pedig tönkrementek.

**A hangvilla = az első mérőeszköz, ami a hangot számmá tette.**
(A projekt nyelvén: az első eszköz, ami a zenei Vetület-módot kalibrálta.)

## 2. A 440 előélete

| Év | Esemény | Pitch |
|---|---|---|
| ~1700 | Sauveur: "tudományos hangolás" | **C4 = 256 Hz = 2⁸** (!), A ≈ 430.5 |
| 1711 | Shore: a hangvilla | — |
| 1834 | **Scheibler + Stuttgart**: a német természettudományos kongresszus | **A = 440 javaslat** |
| 1859 | **Francia törvény**: diapason normal (Berlioz, Meyerbeer, Rossini a bizottságban) | **A = 435** (@15°C) |
| 1885 | Bécsi konferencia | 435 |
| 1896 | Brit Royal Philharmonic | 439 |
| 1926 | USA hangszeripar informálisan | 440 |
| **1939. máj.** | **London, Broadcasting House (BBC)** | **A = 440 döntés** |
| 1955/1975 | ISO R16 / **ISO 16** | 440 (ma is) |

Kulcsalakok:
- **Johann Heinrich Scheibler** (1777–1837): selyemgyáros-akusztikus, feltalálta
  a **tonométert** — 52 hangvillából álló létra — és a leütés-módszert
  (beat method), amivel ~0,1 Hz pontossággal mért. Az ő mérései adták az
  1834-es stuttgarti **A = 440** javaslatot.
- **Giuseppe Verdi** 1885-ben a C = 256-os (2⁸!) "tudományos hangolást" szerette
  volna — sikertelenül. (Érdekesség a projektnek: a 2⁸ = bájt-szál!)

## 3. A csavar: miért pont 440? — Egy mérnöki érv döntött

1937-ben **Sir James Swinburne** (villamosmérnök, amatőr zenész) előadásában
érvelt a britek akkori 439-e ellen:

> **A 439 prímszám; a 440 = 2³·5·11 — könnyen faktorizálható,
> elektronikusan egyszerűbb szintetizálni és osztani.**

1939 májusában, a BBC Broadcasting House-ban (Francia-, Német-, Holland-,
Olasz-, Angliország; Svájc és USA postán) a győztes érv ez a **szám-technikai
kényelem** volt — nem a fizika, nem a fül, nem a zene.

Tehát: **a 440 Hz oka részben az, hogy a 439 prím.**

(A Hz név maga is friss volt: a Hz elnevezést 1930-ban vezette be az IEC
Heinrich Hertz után — a 440 Hz döntésnél alig kilenc éves a név.)

## 4. Az őszinte tétel a projekt számára

### 4.1 Bach NEM 440-en játszott

A "barokk" Kammerton ~415 Hz (félhanggal a 440 alatt), a német templomi
Chorton ~466 Hz volt. Az A440-es világ Bach hallgatása szempontjából
**történelmileg anakronisztikus**. A "Bach-korrekcio" neve tehát költői —
a valódi tartalma: *temperálási* elv (a komma elosztása), nem egy konkrét Hz.

### 4.2 A Bach-korrekcio státusza finomodik

```
α⁻¹ = 137 + 9/250 − A4·(3/4)²/c
                         ↑
       ez a tag 440-t használ — ami ISO-16 KONVENCIÓ (1975),
       ráadásul részben azért, mert a 439 prím
```

- A CODATA-egyezés (0,12σ) **tény** marad — a szám stimmel.
- De az értelmezés: a formula **egyszer fizikai** (c = fénysebesség),
  **egyszer racionális** (137 + 9/250), **egyszer konvencionális** (A4 = 440).
- A korrekciós tag nagysága: 440·(9/16)/299792458 ≈ 8,26×10⁻⁷ — a
  CODATA-mérési bizonytalanságnál (2,1×10⁻⁸) ~40-szor nagyobb. A formula
  ezen tagja tehát **számszerű játékérintés**, nem mérhető fizika.

### 4.3 A mélyebb szerkezet mégis megmarad

Amit a 440-történet *megerősít* (és nem gyengít):

1. **A szám-szépség döntött, nem a fizika** — pontosan úgy, ahogy a projekt
   a φ-t, a Gauss–Wantzel-t, a bájt=8-at találja: a faktorizálhatóság
   (2³·5·11) a választó. Ugyanaz az elv, mint a szerkeszthetőség.
2. **A hangvilla = mérés = Vetület-mód**: minden kalibrált hangvilla
   mérési művelet → Landauer-ár → a "tiszta beszéd" (pontos frekvencia)
   körül mindig ott a rezgés-komplement.
3. **Sauveur/Verdi C = 256 = 2⁸**: a történelem "tudományos" hangolása
   pont a **bájt-szálat** (2⁸ = 256 = |Cl(8)|) választotta volna — 1885-ben,
   jóval a bájt előtt. A projekt bájt=8 tézisének távoli rokona.

## 5. A hangvilla és az Y

A hangvilla maga egy **mechanikai fixpont-kereső**: két ága tiszta
tömeg-rugó-rezgés, aminek frekvenciáját a méret határozza meg —
kihangolás után örök (veszteségmentes oszcillátor, a kis súrlódás = a δ).

A projekt nyelvén:
- hangvilla = fizikai megvalósítása a **konstans referenciának** (a Válasz-oldal)
- a leütés-módszer (Scheibler) = **két oszcillátor interferenciája** =
  a projekt Hadamard-távolságának fizikaielőképe: két frekvencia különbsége
  hallható ütközésekben — a távolság maga hang!

## 6. Források

- Wikipedia: *A440 (pitch standard)*; *Concert pitch — History of pitch standards*
- Lynn Cavanagh: *A brief history of the establishment of international standard pitch a=440 Hz*
- Fanny Gribenski (2023): **Tuning the World: The Rise of 440 Hertz in Music,
  Science, and Politics, 1859–1955**, University of Chicago Press
- Roel Hollander: *Tuning Temperaments (A4=440/435/430.5/415Hz)*
- Alexander Ellis (1880): *The History of Musical Pitch* (Society of Arts, London)
- ISO 16:1975 — Acoustics: Standard tuning frequency

## 7. Fájl

- `docs/hangvilla_440hz.md` — ez az anyag
- `Szotar.idr` — új fogalmak: hangvilla, tonométer, A440, diapason-normal, ISO-16 (+7 él)
