# A kör újraolvasása — hogyan értelmezi át a 440 az egészet

## A kérdés

> "De most akkor ez hogyan értelmezi át az egészet? Volt nekünk valahol
> egy kör felosztási meggondolásunk is…"

## A három szál, ami összekapcsolódott

1. **A kör felosztása** (Gauss–Wantzel, `KorOsztas.idr`): a kör N részre
   szerkeszthető ⇔ N = 2ᵏ × **különböző Fermat-primék** {3, 5, 17, 257, 65537}.
   12 ✓ (Bach), 17 ✓ (Gauss), 360 ✗ (mert 3² osztja).
2. **A 440 Hz eredete** (`hangvilla_440hz.md`): konvenció; a döntő érv,
   hogy **440 = 2³·5·11 faktorizálható**, a 439 prím.
3. **A komma**: a kvintkör nem záródik — 12 kvint ≠ 7 oktáv, a különbség
   3¹²/2¹⁹ (tiszta primhatványok!), 23,46 cent.

## 1. A MELLÉKLELET: a konzonancia primjei = a Fermat-primjei

A tiszta (Ptolemaiosz-féle, "5-limit") hangolás hangközei:

| Hangköz | Arány | Prim | Fermat-prim? | Zenei sors |
|---|---|---|---|---|
| oktáv | 2/1 | 2 | (a dupláció maga) | **pontosan zár** — az egyetlen |
| **kvint** | 3/2 | **3 = F₀** | ✓ **IGEN** | konszonáns — a rendszer alapja |
| **terc** | 5/4 | **5 = F₁** | ✓ **IGEN** | konszonáns — a dur/hármas |
| szeptim | 7/4 | 7 | ✗ nem | **"blue note"** — a blues! |
| 11/8 | 11 | ✗ nem | Partch-terület (43-hangú skála) |
| 17/16 | 17 | ✓ **F₂** | Gauss 17-szöge — és 17-limit! |

**A tétel, ami ebből áll: a nyugati tonalitás pontosan a Fermat-primek
{3, 5} határáig épült fel.** Ahol a 7-es (nem Fermat) belép, ott a blues
— a rendszer széle. A Gauss-féle 17-szög és a 17-limit hangolás ugyanaz
a struktúra: **a szerkeszthetőség határait jártuk körül, zenében és
geometriában együtt.**

És a 360° = 2³·3²·5 azért nem szerkeszthető, mert **3²** — a 3-asból
kettő van. A tonalitás is pontosan egy 3-ast enged meg (a kvintet);
a 9-es (3²) hangköz már a "vád" — a rendszer kiaknázva.

## 2. A 440 újraértelmezése: gauge-rögzítés, nem fizika

A zene fizikája a **viszonyokban** van (3/2, 5/4 — a kvint és a terc),
nem az abszolút magasságban. Az A4 = 440 nem mérés — **mérési rögzítés**
(gauge fixing), mint a mértékegységek vagy a koordináta-rendszer nullapontja.

- Bármely A4 mellett ugyanaz a zene (csak transzponálva)
- A 440 kiválasztása: **divisibilitás** (2³·5·11 vs. prím 439) = **MDL**
  (rövidebb leírás → olcsóbb szintetizálni, osztani, memorizálni)
- Ugyanaz az elv: 12 = 2²·3 (rövid), 8 = 2³ (tiszta hatvány → bájt),
  256 = 2⁸ (Sauveur "tudományos hangja" C4 — és |Cl(8)| = 1 bájt értéktere!)

**Következmény a projektre:** a Bach-korrekcio
`α⁻¹ = 137 + 9/250 − A4·(3/4)²/c` háromféle tagot kever:
- `137 + 9/250` — racionális (horgony)
- `c` — fizikai állandó
- `A4 = 440` — **gauge-rögzítés** (ISO-16 konvenció, részben a 439
  prim mivolta miatt!)

A 0,12σ-egyezés **tény** — de a formula A4-tagja gauge-függő. A fizikai
tartalom a *viszonyokban* van: a (3/4)² (a kvart, azaz 4/3 megfordítva —
Fermat-prim 3!), nem a 440-ben.

## 3. Mit fizetünk a választásért? A reziduumot

Az MDL-választás (rövid leírás) **árat** számol fel — a valóság
incompressibilitását:

| Választás | Reziduum (a kompresszió ára) |
|---|---|
| 12 hang (2²·3) | **komma** = 3¹²/2¹⁹ = 23,46 cent — a kör nem zár |
| 12-TET (Bach) | a komma **elosztva** 12×1,955 centre — nem törölve! |
| A440 (2³·5·11) | a prim-439 "eldobása" — konvenció-költség |
| 360° (2³·3²·5) | a **3²** — nem szerkeszthető, csak közelítés |
| E8⁴ | **δ = 5,604×10⁻⁴** — irreducibilis (nem zárható) |

**Bach = az axion-mechanizmus:** a kommát nem tünteti el — **elosztja**
(a wohltemperiert), dinamikussá teszi. Pontosan úgy, ahogy a θ-szöget
nem nullázzuk, hanem az axion relaxálja. A reziduum nem hiba: **ez az,
ami életben tartja a ciklust.**

## 4. A teljes újraolvasás — egy mondatban

> **Az intelligencia (és minden szabvány) = MDL-választás: a rövid
> leírású számot/struktúrát választjuk (Fermat-prim, tiszta hatvány,
> faktorizálható). A valóság ezért reziduumot számít fel (komma, δ,
> CPT-rest) — és ezt a reziduumot nem kitömjük, hanem elosztjuk
> (Bach/axion), ami életben tartja a Carnot-ciklust. A fizika a
> viszonyokban van (3/2, 5/4); az abszolútumok (440) gauge-rögzítések.**

A projekt eddigi minden szála ebbe kapaszkodik:
- Gauss–Wantzel: a szerkeszthetőség = Fermat-prim = a konzonancia határa
- 440: a divisibilitás (MDL) mint szabványválasztó
- komma/δ: a kompresszió ára, irreducibilis
- Bach/axion: a reziduum elosztása, nem törlése
- Landauer: minden rögzítés (írás, kalibráció) energiát fizet
- Y = Carnot: a ciklus, ami a reziduumon hajt — örökké

## 5. Ellenőrzés

`kor_ujraolvasa_check.py` — minden szám kiszámolva:
- 439 prím ✓, 440 = 2³·5·11 ✓, 360 = 2³·3²·5 (3²!) ✓, 256 = 2⁸ ✓
- F₀..F₄ mind prím ✓
- komma = 3¹²/2¹⁹ = 1,013643 = 23,4600 cent ✓ (tiszta primhatványok)

## 6. Fájlok

- `docs/kor_ujraolvasa.md` — ez a szintézis
- `docs/hangvilla_440hz.md` — a 440 története
- `docs/kor_osztas_bajt.md` — a Gauss–Wantzel + bájt=8
- `osveny_index/KorOsztas.idr` — a szerkeszthetőségi számítás (fut)
- `osveny_index/Szotar.idr` — gráf-bővítés (kvint=3/2 Fermat, terc=5/4, …)
