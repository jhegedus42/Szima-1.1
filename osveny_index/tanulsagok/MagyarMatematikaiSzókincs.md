# Tanulság: magyar matematikai szókincs — a projekt hivatalos nyelvezete
# 教训：匈牙利语数学词汇表 · Lehre: ungarischer Mathematikwortschatz · לקח: אוצר מילים מתמטי הונגרי
# (2026-08-22; források lent)

## A források / Sources / 来源

1. **Magyar Wikipédia: Gyökrendszer** (hu.wikipedia.org/wiki/Gyökrendszer) —
   a gyökrendszerek kanonikus magyar szakszókincse (tükrözés, hipersík,
   krisztalografikus tulajdonság, generátorrendszer…).
2. **Matematikai fogalomtár** (mbuttons.bolyai.hu — Bolyai János
   Matematikai Társulat, MINERVA-projekt, kilencnyelvű szakszótár).
3. **Matekarcok** (matekarcok.hu) — fogalom- és tételnevek listája.
4. **AkH.12** (helyesiras.mta.hu) — a helyesírás alapszabályai (§N9).

## 1. A bizonyítás szerkezetének szavai (a Wikipédia minta szerint)

| magyar | jelentés a projektben | megjegyzés |
|---|---|---|
| **tétel** | fő állítás | „a Pitagorasz-tétel" |
| **lemma** | segédtétel | fő tétel előkészítése |
| **következmény** | a tételből azonnal adódó állítás | |
| **állítás** | bizonyítandó/definícióközeli kijelentés | a Wikipédia így vezeti |
| **megjegyzés** | kiegészítő észrevétel | nem része a fő láncnak |
| **definíció** | fogalom-meghatározás | NEM „recept"! |
| **axióma** | bizonyítás nélkül elfogadott kiindulás | |
| **sejtés** | bizonyítatlan, de gyanított állítás | „a Collatz-sejtés" |
| **cáfolat** | a sejtés megcáfoló példája | l. Cáfolat.idr |
| **bizonyítás** | a levezetés teljes láncolata | |
| **Q.E.D.** | a bizonyítás vége | „ebből adódik" |

## 2. A gyökrendszer-szókincs (a szócikkből szó szerint)

| magyar kifejezés | idegen név | példa a használatra |
|---|---|---|
| **gyökrendszer** (EGY szó!) | root system | „a 240 gyökből álló gyökrendszer" |
| **gyök** | root | „R elemeit gyököknek nevezzük" |
| **tükrözés** | reflection | „az α által meghatározott s_α tükrözés" |
| **hipersík** | hyperplane | „az s által fixen hagyott pontok H hipersíkja" |
| **normálvektor** | normal vector | „n az S sík normálvektora" |
| **merőleges vetület** | orthogonal projection | „a v vektor n egyenesére eső merőleges vetülete" |
| **skaláris szorzat** | scalar product | „a ⋅ skaláris szorzással állítottuk elő" |
| **belső szorzat** | inner product | szinonima — MI EZT HASZNÁLJUK (belsőSzorzat) |
| **generátorrendszer** | generating set | „R generátorrendszere V-nek" |
| **duális tér** | dual space | „a V* duális tér tulajdonságaiból" |
| **izomorfizmus** | isomorphism | „vektortér-izomorfizmus" |
| **vektortér** | vector space | „véges dimenziós vektortér" |
| **altér** | subspace | „a H altér" |
| **lefájozás / lineáris leképezés** | linear map | |
| **krisztalografikus tulajdonság** | crystallographic property | „szokás krisztalografikus tulajdonságnak nevezni" |
| **rács** | lattice | „a gyökrendszer rácsként is ábrázolható" |

## 3. KÉT AZONNALI JAVÍTÁS A SAJÁT SZAVAINKRA (önkritika)

1. **„reflexió" → „tükrözés"**: a magyar matematikai nyelv a Weyl-csoport
   elemeit **tükrözésnek** hívja (a szócikk következetesen így használja;
   a „reflexió" latinizmus). A `weylReflexió` helyes neve a következő
   generációban: **`weylTükrözés`** (§13: a mostani modulok maradnak;
   a következő _v2-hullámban átnevezve).
2. **„kristallográfiai" → „krisztalografikus"**: a szócikk szerint a
   tulajdonság neve **krisztalografikus** (a magyar alak: krisztall- +
   -ografikus, egy f-fel; nem „kristallo-gráfiai"). Az
   E8FázisKapcsolat `kristallográfiaiSzög`-e a következő generációban:
   **`krisztalografikusSzög`**, a `fázisSpektrum` melletti megjegyzésben
   pedig „krisztalografikus szögek".

## 4. Stíluspéldák a matematikai prózához (a szócikkből)

- „Teljesül, hogy…" / „a következő három kijelentés egymással ekvivalens"
- „egyértelműen meghatározza" / „bizonyítható, hogy" / „felhasználásával"
- „adódik, hogy…" / „érdemes megjegyezni, hogy…"
- Definíció vezetése: „Definíció – Legyen V véges dimenziós vektortér…"
- Jelölés bevezetése: „Ezt s_α-val jelöljük."

## 5. A szabály

A projekt magyar matematikai szövege (kommentek, napló, bizonyítások)
INNENTŐL e szókincs szerint íródik: tükrözés (nem reflexió),
krisztalografikus (nem kristallográfiai), gyökrendszer (egy szó),
belső szorzat/skalárszorzat (mindkettő jó; kódban belsőSzorzat marad).
| 项目从此采用此词表：tükrözés、krisztalografikus、gyökrendszer。 |
