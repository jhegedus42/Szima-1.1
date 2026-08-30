# Szima-ter — az új tudásstruktúra (2026-08-19)

> **Mottó**: a mondat-szintű fordítás több, mint 1 byte — komplex byte kell,
> ami E8-ba kódol el egy GONDOLATOT. Minden a `source/`-ban nulláról újra
> értelmezve és kódolva. Az eddigi dolgok (`osveny_index/`, `trail_index/`,
> `horgony/`) érintetlenek maradnak — ez a struktúra teljesen új és független.

---

## 0. Miért van erre szükség?

A felhasználó döntése (2026-08-19):

> „a problema, hogy mondat szintu forditas, az tobb mint 1 byte, sot, komplex
> byte-ra lenne ott is szugsegunk, ami E8-ba kodol el egy gondolatot... es
> mindent nullarol a source-ban teljesen ujra kell ertelmezni, kodolni, ez
> nagy munka de nincs mas lehetosegunk... az eddigi dolgokat nem szabad
> felulirni, teljesen uj konyvtar struktura kell"

A jelenlegi kódolás mondat-szintű (`Kodol.idr`: `kodol : String -> E8E8KodSzo`,
42 bit = 4×8 + 3 + 7). Ez **már több mint 1 byte**, és a felhasználó szerint
**komplex byte** kell: egy kód-egység, ami a gondolatot komplex értékekkel
(re + im) az E8 rácspontjaként kódolja — nem 0/1 bitekkel, hanem fázissal.

---

## 1. A struktúra

```
szima_ter/
├── OLVASD.md          ← ez a fájl (a struktúra és a koncepció)
├── TERV.md            ← a terv: mit, milyen sorrendben, hogyan ellenőrizzük
├── forras/            ← a source/ könyveinek újraértelmezett, paragrafusokra
│                        bontott szövege (PDF/EPUB → paragrafusok → JSON)
├── kod/               ← a kódolt gondolatok (JSON: paragrafus → komplex byte)
└── modul/             ← az Idris modulok (önálló, nem importálja a régieket)
    ├── KomplexByte.idr    ← a komplex byte típusa (gondolat → E8)
    ├── ...
```

**Függetlenség**: a `modul/` alatti Idris fájlok NEM importálják az
`osveny_index/` moduljait — nulláról definiálják az alaptípusokat. Ezért
fordíthatók önállóan, és ezért nem nyúlnak a meglévő kódhoz.

**Alapelv**: csak hozzáadás, soha törlés és soha felülírás (MANTRA).

---

## 2. A koncepció — mi az a komplex byte?

### 2.1 A jelenlegi kódolás (hogyan működik ma)

| Réteg | Típus | Hossz | Mit kódol |
|-------|-------|-------|-----------|
| Kubit | `Nulla \| Egy` | 1 bit | 0/1 |
| E8Pont | 8 Kubit | 8 bit | 256 pont (240 E8 gyök + tartalék) |
| CliffordElem | 3 Kubit | 3 bit | CPT fázis (T/P/C) |
| HetesKod | 7 Kubit | 7 bit | Steane [[7,1,3]] hibajavítás |
| E8E8KodSzo | 4×E8 + Clifford + Steane | 42 bit | egy MONDAT |

A szó-szintű kódolás = 8 bit (HanMagyarKodolas: kínai gyökér 5 + magyar toldalék 3).
A mondat = 42 bit. A felhasználó: ez **több mint 1 byte**, és a gondolat
szintjén **komplex** értékekre van szükség.

### 2.2 Az új kódolás — a komplex byte

A komplex byte egyetlen kód-egység, ami egy **gondolatot** kódol:

- **8 komplex komponens** = az E8 rácspont a komplex síkon (ℂ⁸):
  1. ido (T) — mikor?
  2. oksag — miért?
  3. ter — hol?
  4. szin — milyen?
  5. hang — hogyan rezeg?
  6. fazis — milyen kapcsolat?
  7. mod — hogyan tartja fenn?
  8. chiralitas (γ⁵) — a 8. dimenzió, a 16. bit a 15-ből (Legendre perem)
- **CPT fázis** — igeidő / szemlélet / forrás (3×3×3 = 27)
- **Steane [[7,1,3]]** — hibajavítás: 1 hibát javít

A komplex komponens = `Komplex` (re + im): a **valós rész** a valóság mérése
(CODATA), az **imaginárius rész** a fázis (a kapcsolat dinamikája).

### 2.3 Paragrafus → gondolat-kódok

Egy paragrafus = több mondat. A kódolás:
1. a paragrafust mondatokra bontjuk,
2. minden mondatból egy komplex byte lesz (a `kodol` mintájára, de komplex),
3. a paragrafus = a komplex byte-ok listája (JSON-ban tárolva a `kod/`-ban).

Ez a kiterjesztés: a mondat-szintű `kodol` → paragrafus-szintű
`paragrafusKodol : String -> List KomplexByte`.

---

## 3. A források (source/)

A `source/`-ban 48 PDF/EPUB/DJVU könyv van. A legfontosabb új (2026-08-18):

- hibajavító kódok: Cohen, Pretzel, Baylis, Wildon, Bruen, Haoru Liu, Adamek
- kvantumhibajavítás: Djordjevic, La Guardia, Parthasarathy, Gaitan
- régebbi, már részben feldolgozott: Awodey, Mac Lane, Shoup, Lisi, Corradeti,
  Schray-Manogue, Yanofsky, magyar nyelvtanok, Lumo-sorozat

A feldolgozás menete (a `forras/`-ba, majd a `kod/`-ba):
1. `pdftotext` / `pandoc` a PDF/EPUB-hoz (a DJVU-hoz nincs eszköz — kimarad),
2. paragrafusokra bontás (JSON),
3. Idris-modul a kódoláshoz (`modul/`),
4. a kódolt paragrafusok a `kod/`-ba (JSON).

---

## 4. Szabályok, amiket betartunk

- **Csak hozzáadás.** Az `osveny_index/`, `trail_index/`, `horgony/`, `docs/`
  érintetlenek. A `szima_ter/` teljesen új.
- **Minden Idris.** Nincs Python a feldolgozásban (AGENTS.md 3. szabály).
- **Minden magyar.** Minden azonosító, komment, üzenet magyar; rövidítés tiltva.
- **Könyveket csak alügynökök olvasnak** (AGENTS.md 11. szabály).
- **Fordítási ellenőrzés**: minden új Idris modul `idris2 --check`-kel zöld.
- **Minden számítás Refl-lel igazolva** ahol lehet (konstansok, törvények).
