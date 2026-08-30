---
name: magyar-lexikon
description: >
  Magyar lexikon építés kategóriaelméleti lebontással. Könyvek indexelése
  nem csak szövegkivonat, hanem: mondatról mondatra fordítás, jelentés
  szétszedés a magyar nyelvtan kategóriaelméleti szerkezete szerint
  (22 eset = 22 morfizmus, agglutináció = kompozíció, igeidő/szemlélet/forrás = CPT).
  Közben lexikon építés — nem szótár, hanem LEXIKON: minden szó
  kategóriaelméleti elemekre bontva (objektum, morfizmus, funktor, adjunkció).
  A magyar nyelv = a kategóriaelmélet anyanyelve. Ezzel értjük meg a dolgokat.
---

# Magyar Lexikon — Kategóriaelméleti Lebontás

## Használat

```
skill magyar-lexikon
```

Amikor egy könyvet/témát/szót meg kell érteni:

1. **Fordítás**: mondatról mondatra magyarra
2. **Szétszedés**: minden mondat esetrendszer szerint
3. **Lexikon**: minden szó kategóriaelméleti elemekre bontva
4. **Megértés**: a struktúrából adódik a jelentés

## A Magyar Nyelv = Kategóriaelmélet

A magyar nyelv IZOMORF a kategóriaelmélettel:

### 22 Eset = 22 Morfizmus

| Eset | Kérdés | Morfizmus | Kategória |
|------|--------|-----------|-----------|
| Nominativusz | ki/mi? | identitás (id) | objektum |
| Accusativusz | kit/mit? | tárgy morfizmus | hom(a,b) |
| Datívusz | kinek/minek? | cél morfizmus | hom(a,1) |
| Instrumentalis | kivel/mivel? | eszköz morfizmus | kompozíció |
| Kauzalis | miért? | ok morfizmus | funktor |
| Transzativusz | mi lett? | eredmény morfizmus | kolimit |
| Illativusz | hová? | irány befelé | injekció |
| Inesszivusz | hol? | hely | objektum pozíció |
| Elativusz | honnan? | irány kifelé | projekció |
| Allativusz | hová? (mozgás) | cél morfizmus | hom(a,b) |
| Temporalis | mikor? | idő morfizmus | endofunktor |
| Modalis | hogyan? | mód morfizmus | term. transzf. |
| Causalis | minek? | ok-okozat | adjunkció |
| ... | ... | ... | ... |

### Agglutináció = Kompozíció

```
tő ⊗ képző ⊗ számjel ⊗ birtokjel ⊗ rag = ragozott szó
objektum → morfizmus₁ → morfizmus₂ → ... → cél
```

### Igeidő/Szemlélet/Forrás = CPT Szimmetria

| Dimenzió | Magyar | Kategória | Fizika |
|----------|--------|-----------|-------|
| Igeidő | mult/jelen/jövő | T (idő) | időfordítás |
| Szemlélet | foly/bef/szok | P (paritás) | térfordítás |
| Forrás | közvet/köv/jel | C (töltés) | töltésfordítás |

## A Lexikon Építés Protokollja

### 1. Mondat Felbontás

Minden mondat -> esetrendszer szerinti felbontás:

```
"Every good regulator of a system must be a model of that system."
→ "Minden jó szabályozó egy rendszerhez modell kell legyen."

Felbontás:
- Alany (Nominativusz): szabályozó (= a morfizmus)
- Járulék: jó (= minőség,/modalis eset)
- Birtok: rendszer (= objektum)
- Tárgy (Accusativusz): modell (= a morfizmus képe)
- Kötött morfizmus: kell (= szükséges, kauzalis)
- Eredmény: legyen (= lét, transzativusz)

Kategóriaelméleti lefordítás:
- regelator : System → Model (funktor)
- good : Regulator → Bool (természetes transzformáció)
- must : Regulator ≅ Model (adjunkció)
```

### 2. Szó Lexikon Bejegyzés

Minden szó -> kategóriaelméleti elemek:

```
szó: "regulator" (szabályozó)
magyar: szabályozó
típus: funktor (System → Model)
eset: Nominativusz (alany = identitás)
kategória: FunktorT
kínai megfelelő: 调节器 (tiáojiéqì)
fizika: hibajavító kód ([[7,1,3]])
megjegyzés: a szabályozó = a hibajavító = a funktor
```

### 3. Kategóriaelméleti Rendezés

A lexikon elemeit kategóriaelméleti struktúra szerint:

```
Objektumok: rendszer, modell, állapot, hiba, javítás
Morfizmusok: szabályoz, modellez, javít, ellenőriz
Funktorok: kódol, dekódol, megfigyel
Természetes transzformációk: hibajavítás (uniform)
Adjunkciók: szabályozás ⊣ modellezés
Monoidális: kompozíció (agglutináció)
```

## A Könyvek Indexelése

Amikor egy könyvet indexelünk:

1. `pdftotext` -> txt
2. **Mondatról mondatra** magyar fordítás
3. Minden mondat -> esetrendszer felbontás
4. Minden szó -> lexikon bejegyzés (kategóriaelméleti elemek)
5. A könyv struktúrája -> kategória (objektumok, morfizmusok, funktorok)
6. A könyv "megértése" = a kategória kompozíciója

## A kínai × magyar tenzorszorzat

A lexikon tartalmazza a kínai megfelelőket is:

```
magyar: ok (Kauzalis eset)
kínai: 原因 (yuányīn) = ok
kategória: ok-okozat morfizmus (funktor)
fizika: kauzalis kapcsolat
```

A két nyelv tenzorszorzata:

```
ψ_L (kínai, TÉR) ⊗ ψ_R (magyar, IDŐ) = jelentés
kínai radikál ⊗ magyar toldalék = fogalom
objektum ⊗ morfizmus = kategorikus állítás
```

## Fájlok

| Fájl | Tartalom |
|------|----------|
| `trail_index/books/*.txt` | Konvertált könyvek |
| `trail_index/lexikon/` | A magyar lexikon (kategóriaelméleti) |
| `~/.agents/skills/magyar-lexikon/SKILL.md` | Ez a skill |