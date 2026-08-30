# SZIMA-TER — TERV (2026-08-19)

> A felhasználó: a mondat-szintű fordítás már 42 bit (E8E8KodSzo), de a
> **gondolat** szintjéhez komplex byte kell, ami E8-ba kódolja a gondolatot.
> A `source/` könyveit nulláról újra kell értelmezni. Teljesen új
> könyvtárstruktúra — a régieket nem felülírni.

---

## 1. A komplex bájt — végső típus

```
KomplexBajt =
  (ℂ⁸)               -- 8 komplex komponens
  × CptFazis          -- 3×3×3 = 27 (igeidő, szemlélet, forrás)
  × HetesKod          -- Steane [[7,1,3]] = 7 bit (hibajavítás)
  × String            -- a gondolat szövege (címke, veszteségmentes)

A 8 komponens:
  k0: ido    (T)
  k1: oksag  (C)
  k2: ter    (P, paritás)
  k3: szin
  k4: hang
  k5: fazis
  k6: mod
  k7: chiralitas (γ⁵) — a 8. dimenzió, a 16. bit a 15-ből

A re rész = mérés (CODATA), az im rész = fázis (kapcsolat-dinamika).
```

Fájl: `szima_ter/modul/KomplexByte.idr` — önálló, nem importálja az
`osveny_index/`-et. ✅ `idris2 --check` zöld.

---

## 2. A paragrafus-kódoló — végső típus

```
Paragrafus = String -> Szotar -> List KomplexBajt

Lépések:
  1. paragrafus → mondatok (Data.String.split + filter)
  2. mondat → szavak (words)
  3. szó → jelentésvektor (szotarKeres, kisbetűsített)
  4. szavak összege → SzoJelentes (8 komplex súlyozott)
  5. SzoJelentes → KomplexBajt (erős-küszöb → Steane bitek)
  6. mondatok listája → List KomplexBajt
```

Fájl: `szima_ter/modul/Paragrafus.idr` — önálló. ✅ `idris2 --check` zöld.

Futtatási teszt (`Main.idr`) kimenete:
- `"Piroska."`      → `[1,0,0,1,0,0,0]`  = idő + szín
- `"Mit mondott a farkas?"` → `[0,1,0,0,1,0,0,1]` = okság + hang + chiralitás
- 2-mondatos → 2 külön komplex bájt

---

## 3. Soron következő lépések

### 3.1 Tő- és toldalék-szétválasztás (magyar ragozás)
- *"hazugsagot"* (ragozott) most nem találja *"hazugsag"* (tő) szótári vektort.
- Megoldás: a szó szótári keresés kiterjesztése tőmetszésre (a `MagyarNyelvtan.idr`
  22 esetragja alapján), vagy a szótár a töveket is tárolja.
- A `Paragrafus` modul kiegészítése egy `szotarKeresTomesterrel` függvénnyel.

### 3.2 A CPT fázis a mondatból
- Jelenleg a komplex bájt CPT-fázisa fix: `jelen, folyamatos, kozvetlen`.
- A jövőben a magyar igeidő/szemlélet/forrás a szavakból kinyerhető
  (a 22 esetrag és a 3×3×3 igeragozás kombinációja).

### 3.3 A Steane-hibajavítás bekötése
- A `HetesKod` (a Steane [[7,1,3]] 7 bitje) jelenleg csak a komponensek
  erősségéből van kiszámítva.
- A jövőben a `Steane713.javitas` mintájára be kell kötni a szindróma-
  javítást: a komplex bájt komponenseiből kiszámítható a szindróma,
  és 1 bites hiba javítható.

### 3.4 A source/ újraértelmezése
- Minden PDF/EPUB → `szima_ter/forras/` (paragrafusokra bontott JSON/TXT).
- A DJVU kimarad (nincs konverziós eszköz — `djvutxt`/`ddjvu` hiányzik).
- A feldolgozás alügynökökkel megy (AGENTS.md 11.: könyveket csak
  alügynökök olvasnak).

### 3.5 A szótár bővítése a source-ból
- A `forras/`-ból a leggyakoribb szavak automatikus kiemelése és
- a `Peldaszotar` kibővítése a tényleges jelentésvektorokkal.
- A jelentésvektorok 8 komponensét a szó kontextusából lehet megbecsülni
  (ko-okkorencia, szintaktikai kategória, stb.).

### 3.6 A baby AI (KisAI) kiterjesztése
- A `Dirac3D/KisAI.idr` `kodolSzoveg` függvénye szavakra bont, és a
  7 bites kódokat OR-zi. Ez egy szótár + 7-bit kód rendszer.
- A bővítés: a `KisAI` a `Paragrafus` modullal komplex bájtokkal dolgozik,
  a keresés a komplex bájtok Hamming/Damerau-távolsága vagy komplex
  belső szorzata alapján.

---

## 4. A struktúra szabályai

- **Csak hozzáadás.** Semmi felülírás, semmi törlés. Az új Idris modulok
  az `osveny_index/`-et NEM importálják — függetlenek.
- **Minden magyar.** Azonosítók, kommentek, üzenetek magyar, rövidítés nélkül
  (kivéve az E8 és a Kubit standard terminusokat).
- **Minden Idris.** Nincs Python a feldolgozásban. A JSON-t Idris generálja.
- **Fordítás-ellenőrzés**: minden modul `idris2 --check`-kel zöld.
- **Refl, ahol a típus redukálódik; Show-teszt, ahol nem** (pl. a szótári
  keresés `==`-e nem redukálódik Refl-lel — futásidejű ellenőrzés).
- **Könyveket csak alügynökök olvasnak** (AGENTS.md 11.).
- **Kommentek magyarul, kód is.** A KomplexByte modul 200+ sora magyar
  kommentekkel és Refl-bizonyításokkal (üres életjel, szorzás-egység,
  kubit-forgatás 0-ra, üres súly).

---

## 5. Megnyitott kérdések (a felhasználónak)

1. A komplex bájt 8 komponense: a jelenlegi 7+chiralitás felosztás jó,
   vagy a 8 komponens más legyen?
2. A CPT fázis: fixen jelen/folyamatos/közvetlen, vagy a szövegből
   kinyerhető (igeidő, aspektus, evidenciálisság)?
3. A tő- és toldalék-szétválasztás: a `MagyarNyelvtan.idr` 22 esetragját
   használjuk fel (az `osveny_index/`-ből), vagy önálló tőmetszőt írunk?
4. A JSON-generátor: külön Idris modul (`szima_ter/modul/JsonKodolo.idr`),
   ami a `szima_ter/kod/`-t generálja?
5. A push (a `git-push` skill minden 3. szívdobbanásnál): a `szima_ter/`
   gyökérben legyen, vagy a `source/` mellett?

---

## 6. A protokoll (MANTRA)

- Kegyetlen add-only: `osveny_index/`, `trail_index/`, `horgony/`, `docs/`
  érintetlenek.
- `idris2 --check` minden modulra.
- Futtatható teszt (Show-érték) a Main.idr-ből.
- Commit + push a `git-push` skill ritmusa szerint.
- A `python` TILTOTT — minden számítás Idrisben (Komplex, Refl-bizonyítás).
