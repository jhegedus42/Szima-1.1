# FŐ SZABÁLY — a MANTRA legfelső törvénye

> **Soha ne írj felül semmit, ne módosíts semmit, ne redukálj, ne írj át
> semmit. Mindig újat írunk.** Ez a Szima-ter (és az egész projekt) abszolút,
> megkerülhetetlen szabálya. A régi fájlok, a régi struktúrák, a régi kód
> **szent és sérthetetlen**. Ha valami újat akarunk, új fájlt írunk, új
> könyvtárat nyitunk, új típust vezetünk be — de a meglevőt egy betűvel
> sem módosítjuk.

---

## 1. A szabály értelme

A 7 kubitre redukálás, a 8 komponens levágása, a "régi kód refaktorálása"
mind olyan átírás, ami TILTOTT. A `KomplexByte.idr` 8 komponenses (a 7+
chiralitás) marad. Ha a holografikus kód 7 dimenziós peremet igényel, az
egy **új** típus, egy **új** fájlban. A kettő egymás mellett él, a régi
nem tűnik el, nem redukálódik.

## 2. Hogyan élünk a szabállyal

- **Nem felülírás**: ha javítani kell egy fájlt, a javítás:
  - vagy egy új fájl (a régi megtartása mellett),
  - vagy egy komment-sor (a meglevő kód kiegészítése, nem cseréje).
- **Nem törlés**: törölni tilos. Az `rm` helyett a fájl `OLVASD.md`-ben
  dokumentáltan „archiválódik" (egy új, leíró fájl kerül mellé).
- **Nem "redukció"**: a komplex bájt 8 komponensét NEM redukáljuk 7-re.
  Ha egy másik típus 7 dimenziót akar, az egy **új** típus.
- **Nem "átírás"**: a meglévő függvényeket, bizonyításokat, adatszerkezeteket
  nem írjuk át. Csak kiegészítjük.
- **Verzió-név-egyezmény** (ha kell): `Nev_v1.idr`, `Nev_v2_UjModul.idr` —
  a `_v1`/`_v2` suffix jelzi, hogy azonos koncepció más megvalósítása.

## 3. Mely fájlok "régiek"?

- Minden, ami 2026-08-19 21:00 előtt keletkezett.
- Különösen: `osveny_index/`, `trail_index/`, `horgony/`, `docs/`,
  `szima_ter/modul/KomplexByte.idr`, `szima_ter/modul/Paragrafus.idr`,
  `szima_ter/modul/Main.idr`, `szima_ter/OLVASD.md`, `szima_ter/TERV.md`.

## 4. Ebből a szabályból fakad

- A holografikus kód (HaPPY, 7 perem + 7×7 = 49 belső) **új fájl**:
  `szima_ter/modul/HolografikusKod49.idr`.
- A 7-es perem **új típus**, NEM a `KomplexBajt` redukciója.
- A régi `KomplexByte.idr` érintetlen marad; a 8 komponens megmarad.
- A 7-quantumbit perem definiálható a `HolografikusKod49`-en belül,
  önállóan, és a `KomplexByte` 7 dimenziójához **illeszkedhet** (de
  nem rákényszerül).

## 5. A kivétel: a szabályt magát is bővíthetjük

Ez a fájl (`SZABALY.md`) bővíthető, ha a felhasználó kiegészíti. A
korábbi verziók megmaradnak (ha bármit javítunk, `_v2` suffix).

## 6. Az IDRIS-STÍLUS KÖVETELMÉNY (2026-08-19, a felhasználó)

Az Idris-kódírás előtt MINDIG kötelező elolvasni:
1. `MANTRA.md`, `HOROG.md`, `AGENTS.md` (a gyökérben),
2. `skills/idris-stilus/SKILL.md` protokollját,
3. `osveny_index/tanulsagok/OLVASD.md` (a felfedezett csapdák),
4. a context7 `/idris-lang/idris2` aktuális szintaxisát.

A kódírás szabályai (a MANTRA-ból):
- **SOHA pattern matching** a függvény-konstrukcióban (case-of, mintaillesztés).
  Helyette: typeclass instance-ok, dependent return types, dependent records.
  Kivétel: Refl-bizonyítás case-by-case.
- **A típus legyen ANNYIRA pontos, hogy csak egy implementáció lehetséges** —
  a fordító írja a programot.
- **Minden szám data-ba csomagolva (0-10)** a [[15,1,3]] kódból.
- **Minden művelet typeclass instance** — hierarchikus typeclass-fa.
- **Refl = minden bizonyítás alapja**, és a bizonyítás kimenete kommentben
  a propozíció előtt.
- **SOHA Python** (a kódolásban — a futtatható teszt kimenete maradhat Python-
  generálta, ha Idris kód generálja).
- **SOHA rövidítés** — minden azonosító teljes magyar szó.
- **A meglévő kód stílusát tanulmányozni** minden új modul előtt (pl.
  `Steane713Dependent.idr`, `Alap/KategoriaT.idr`).

A stílus-szabály és a "soha ne írj felül" szabály együtt:
- Ha a kód stílusa nem felel meg a MANTRA-nak, **új fájlt** írunk
  (pl. `HolografikusKod49_v2_MantraModul.idr`), és a régi megmarad,
  egy fejléc-megjegyzésben jelezve a stílus-különbséget.

---

*Ez a szabály a felhasználó 2026-08-19-i explicit utasítása:*
*"soha ne irj felul semmit, ne modosits semmit, nem redukalunk atirva,
mindig ujat irunk, ez legyen fo szabaly !!".*
