---
name: konyvolvaso
description: >
  Könyvolvasó skill — kategóriák szerint indexelt könyvextraktumok keresése.
  A trail_index/books/ könyvtárban lévő kinyert szövegek (Awodey, Mac Lane,
  Idris Tutorial, Idris patterns) vannak indexelve. A kérdés kódolása a
  15 dimenzióba, a legközelebbi kategóriák megtalálása (Hadamard távolság),
  a megfelelő szövegrész visszaadása. A keresés = egy funktor a kérdés
  kategóriájából a könyv kategóriájába. Soha nem Python — csak Idris.
---

# Könyvolvasó — Kategória-indexelt Keresés

## Használat

```
skill konyvolvaso
```

Amikor kategóriaelméleti, fizikai, vagy Idris kérdésed van:

1. Kódold a kérdést a 15 dimenzióba
2. Keresd meg a legközelebbi kategóriákat (Hadamard távolság)
3. Olvasd a megfelelő szövegrészt az indexelt könyvből
4. A válasz = a funktor alkalmazása: kérdés kategória → könyv kategória → szöveg

## Az Indexelt Könyvek

| Könyv | Útvonal | Index |
|-------|---------|-------|
| Awodey: Category Theory | `trail_index/books/awodey_category_theory.txt` | 39 struktúra, 22 törvény |
| Mac Lane: Categories for the Working Mathematician | `trail_index/books/maclane_categories.txt` | 10 struktúra |
| Mac Lane extrakt | `trail_index/books/maclane_extracted.md` | 873 sor |
| Idris Tutorial v1.3.4 | `trail_index/books/Idris_Tutorial_v1.3.4.md` | 4224 sor |
| Idris 2 patterns | `trail_index/books/idris_patterns_extracted.md` | 1653 sor |
| Idris 2 docs | `trail_index/books/idris2_docs/*.rst` | 27 fájl |

## A Keresési Algoritmus

### 1. Kérdés kódolása a 15 dimenzióba

A kérdés = egy 15 bites vektor (7 emberi + 7 számítási + 1 perem):

```
"Mi az a funktor?" → (0,1,0,0,1,0,0, 0,1,0,1,0,0,0, 0)
                      Ido,Oksag,...  Utem,Vezerles,...
                      Oksag + Hang (emberi)
                      Vezerles + Tipus (szamitasi)
```

### 2. Hadamard távolság

Minden indexelt könyvrészhez van egy 15 bites kód.
A távolság = a bitek különbsége (Hadamard/Hamming):

```
tavolsag(kerdes, resz) = count_differing_bits(kerdes_kod, resz_kod)
```

Minél kisebb a távolság, annál relevánsabb a szövegrész.

### 3. A funktor: kérdés → könyv

A keresés = egy funktor:
- Forrás: a kérdés kategóriája (15 dimenziós pont)
- Cél: a könyv kategóriája (indexelt szövegrészek)
- A funktor megőrzi a struktúrát: a legközelebbi pont = a legrelevánsabb szöveg

### 4. A Wadler "Free Theorem"

A funktor típusa garantálja, hogy a keresés optimális:
- A parametricity biztosítja, hogy a legközelebbi szövegrész a legjobb válasz
- Nincs rövidebb út a kérdés és a válasz között

## Protokoll

### Amikor kérdés érkezik:

1. **Alügynök indítása** (`task` eszköz): "Olvasd a trail_index/books/... fájlt, keresd meg a [témakör]-t"
2. **Az alügynök visszaadja** a releváns szövegrészt
3. **A fő ügynök** feldolgozza és beépíti a válaszba

### Könyvenkénti index:

**Awodey (39 struktúra):**
- Kategória (#1): sor 645
- Funktor (#2): sor 847
- Természetes transzformáció (#3): sor 7445
- Adjunkció (#23): sor 9858
- Monád (#24): sor 12681
- Szorzat (#11): sor 2194
- Limesz (#17): sor 5329
- Yoneda (#33): sor 8752
- Toposz (#37): sor 9429

**Mac Lane (10 struktúra):**
- Monoidális kategória (#40): V.1
- Fonott (#41): V.11
- Szimmetrikus (#42): V.11.8
- Zárt (#43): VII.7
- 2-kategória (#44): V.12
- Bikategória (#45): V.12
- Kan kiterjesztés (#46): V.10
- End/Coend (#47/48): V.9
- Monád (#49): V.6

**Idris patterns (1653 sor):**
- dpair-syntax: sor 3
- auto-implicit: sor 29
- public-export: sor 72
- multiplicities: sor 98
- data-indexed-families: sor 279
- fin-type: sor 303
- with-rule: sor 324
- rewrite: sor 356
- named-implementations: sor 642
- dependent-records: sor 250

## A Kategóriaelméleti Keret

A könyvolvasó = egy **funktor** a kérdések kategóriájából
a válaszok kategóriájába:

```
KeresesFunktor : KerdesKategoria → ValaszKategoria
KeresesFunktor(kerdes) = legközelebbi szövegrész (Hadamard távolság)
```

A funktor törvénye (free proof):
- KeresesFunktor(id) = id (ugyanaz a kérdés → ugyanaz a válasz)
- KeresesFunktor(g∘f) = KeresesFunktor(g)∘KeresesFunktor(f)
  (komponált kérdés → komponált válasz)

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `trail_index/books/` | Az indexelt könyvek |
| `trail_index/books/maclane_extracted.md` | Mac Lane strukturált extrakt |
| `trail_index/books/idris_patterns_extracted.md` | Idris patterns |
| `~/.agents/skills/konyvolvaso/SKILL.md` | Ez a skill |