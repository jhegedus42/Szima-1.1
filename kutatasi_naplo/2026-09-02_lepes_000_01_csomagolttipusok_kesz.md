# Kutatási napló — 2026-09-02 — 000.01 KÉSZ: a CsomagoltTípusok alapmodul

## A felhasználó utasítása szó szerint (§N5)

«inditsuk»

— a 000.01-es lépés (az alapmodul) indítása az EgyVonalTerv_v1 szerint.

## A mérföldkő: `osveny_index/Alap/CsomagoltTipusok.idr` (~1600 sor)

**Fordul: exit 0** (`idris2 --check Alap/CsomagoltTipusok.idr`, %default total).
**Fut: a HatarElottiGepiTeszt kiírja** — 7+1=nyolc, 2×5=tíz, a 18 esetrag
(t+nak+val+ért+vá+ba+ban+ból+ra+on/ról→n+hoz+nál+tól+ig+ként+ul + az üres
alanyeset), végEgyezzik("ban","n")=igaz, normalizál=igaz, Pi="pi".

### A 23 típus
Igazság, Sorszám (Peano — Nat helyett!), EgészSzám 0–10 (sorzám-hídon),
Számjegy, Előjel, Fűzér (List helyett), SzámjegyesSzám (Integer helyett),
Betű (44 — a digráfok és q/w/x/y saját konstruktorok), Szöveg (String helyett),
Talán (Maybe), Pár (Pair), Kubit, SteaneVektor : Sorszám → Type (Nat-index
NÉLKÜL) + SorIndex (Fin-analóg), E8Koordináta {0,±1,±½} (a 240 gyök véges
készlete — Double helyett!), MatematikaiKonstans (π, e, φ, √2 — SZIMBÓLUMOK:
«Pi is Pi»), FizikaiKonstans (c, h, G, kB, α — a CÉL öt tagja),
Esetrag (18 VALÓDI — l. lent), Időbélyeg, VerzióSzám, BájtláncIndex,
Megbízhatóság.

### A 12 typeclass
EgyenlőségT (Igazságot ad, nem Bool-t), IgazságT, RendezésT, ÖsszeadásT,
SzorzásT, KivonásT, SzövegT (végEgyezzikE-vel!), SzámsorT (következő +
előző), KonstansT, MennyiségT, BetűT, MegjelenítésT (a → Szöveg — SOHA
String; a String csak a Határ-modulban, az IO peremén).

### A bizonyítások (Refl — a fordító ellenőrizte MINDET)
deMorgan (4 eset), másodikDeMorgan, duplaTagadás, kizártHarmadik,
ellentmondás, ésKommutativitás, sorBalEgység, sorJobbEgység (indukció+cong),
hétPluszEgyNyolcSor, kettőSzorÖtTízSor, egyPluszEgyKettő, kettőSzorKettőNégy,
hétPluszEgyNyolcEgész, ötKivonEgyNégy, kilencPluszKettőTelít (a kapu),
normalizálIdempotens (tanú) + **normalizálFixpont / normalizálIdempotensTétel
(ÁLTALÁNOS — indukció, GAN 7)**, mínuszNullaPozitív, szövegBalEgység,
szövegJobbEgység, **szövegRefl, végEgyezzikRefl, végEgyezzikÜresRag (GAN 11)**,
végEgyezzikPélda, tízUtánSemmi, nullaElőttSemmi, sorszámMindigFolytatódik,
kubitKülönbségTörvény, **kubitKülönbségKommutatív/Asszociatív, kubitNulla-
Bal/JobbEgység (GAN 8 — a Z₂ teljes törvényrendszere)**, kettőKubitIndexel-
Bizonyítás, vektorFűzésPélda, tükörInvolúció (E8-CPT!), piJelePélda,
**tizennyolcEsetrag (a megszámlálás: fűzérHossz mindA18Esetrag = sorTíz+sorNyolc)**,
**betűRefl (44 sor — a TYPO-HÁLÓ, GAN 9.c), sorszámRefl**,
magánhangzóBizonyítás, igazMegjelenítésPélda.

### A 18 valódi esetrag (Wikipédia-ellenőrzött, §N12)
Forrás: https://hu.wikipedia.org/wiki/A_magyar_nyelv_eseteinek_listája
(ellenőrzött változat 2025-11-13; É. Kiss Katalin: Új magyar nyelvtan,
ISBN 963-389-521-9). **FELFEDEZÉS: a -nként, -stul/-stül, -kor, -képp(en)
NEM valódi esetrag — KÉPZŐ!** A valódi 18: alany(∅), tárgy(-t),
részes(-nak/-nek), eszköztárs(-val/-vel), okcél(-ért), eredmény(-vá/-vé) +
a 9 helyi eset irányhármassággal (honnan?/hol?/hová? × belső/felszín/közel:
melybe/melyben/melyből, felszínre/felszínen/felszínről, közelbe/közelben/
közelből) + meddig(-ig), ként(-ként), ul/ül(-ul/-ül).
A 22 morfizmus (AGENTS) = 18 Esetrag + 4 Képző → a 600.11-es lépésben
TÍPUSBAN zárul (GAN 14).

## A GAN-felismerések (§N14/1 — a 15 pontos lista, mind beépítve)
- **MOST beépítve**: 6 (sorElőző, számElőző, RendezésT/SzámsorT Sorszám),
  7 (általános normalizál-fixponttétel), 8 (Z₂-törvények), 9 (második De
  Morgan, kizárt harmadik, ellentmondás, és-kommutativitás, betűRefl/
  sorszámRefl/szövegRefl typo-hálók), 13-rész (FelszínRag alapalak "n").
- **A tervbe ütemezve**: 000.02 (1: Írásjel+Mondat réteg; 10: NFC/NFD,
  Char-határozat), 000.04 (2: Fűzér-API; 4: literál-építők, szám240/137),
  200.34 (3: ragotLeválaszt!, elejeEgyezzik, résztSzöveg; 12: hangrend-
  motor), 200.35 (5: SorVektor paraméterezés — az E8-gyök E8Koordináta-
  vektor, NEM Kubit!, vektorXOR), 200.36 (15: metrika-instance-ok),
  600.11 (13: esetragVáltozatai, hasonulás; 14: Képző+MondatMorfizmus).
- **végEgyezzik VERDIKT**: a suffix-motor HELYES (mind a négy határeset);
  a hasonulási hézag (ház+val→házzal) DOKUMENTÁLVA a modulban (a 600.10-es
  motor tudja).

## IDRIS 0.8.0-CSAPDÁK — A MIGRÁCIÓ TANULSÁGAI (kutatási érték!)
1. **Vesszős teleszkóp `(a, b : T)` TÖRT** → külön kötések `(a : T) -> (b : T)`.
2. **Rekord-konstruktor MINTA tört** (a pozíciós argumentumokat kifejezésként
   oldja fel!) → **mező-accessorok** (számElőjele/számjegyei/éve/…) +
   esetleg `case` az accessor eredményén.
3. **Interface-METÓDUS a TÍPUSBAN nem oldódik fel** (ésE/vagyE/nemE/
   konstansJeLe/megjelenít/magánhangzóE) → **top-level függvények +
   delegáló instance-ok** (ésIgazsággal, matematikaiKonstansJeLe,
   igazságMegjelenítése, betűMagánhangzóE…).
4. **Szabad kisbetűs konstans a TÍPUSBAN implicit paraméterként kötődik**
   (árnyékolva a globálist! — pl. `sorHét` a Refl-tételben) → **minősített
   hivatkozás** `Alap.CsomagoltTipusok.sorHét`.
5. **Constrained instance**: `[név] {p : Type} -> Osztály p => Osztály (T p)
   where` — de a NÉVVEL ellátott nem auto-feloldó → **név nélkül +
   teleszkóp**; a nyíl-teleszkóp nevesített kötései (vektorFűzés) inaccessible-
   ek a törzsben → **explicit implicit teleszkóp** `{sor : Sorszám} ->`.
6. **NFC/NFD**: ékezetes FÁJLNÉV (GépiEllenőrzésIdeiglenes.idr) elhasalt a
   macOS-formázás miatt → ASCII fájlnevek (mint a projektben eddig is),
   ékezetes azonosítók a fájl BELSEJÉBEN rendben.
7. **A totality-ellenőr nem lát át az accessoros rekurzión** → **strukturális
   mag** (normalizálFűzér) + delegáló burkoló (normalizál).
8. **Heterogén egyenlőség**: a vektorFűzés jobb-egység tételéhez (n+0 ≠ n a
   típusban) — TODO 400.03-előkészület.

## A terv frissítése
`EgyVonalTerv_v1.idr`: 000.01 → **Kész**; új lépések: 000.04 (Fűzér-API),
200.34 (szöveg-műveletek + hangrend + ragotLeválaszt), 200.35 (SorVektor
paraméterezés), 200.36 (metrika-instance-ok), 600.11 (a 22 morfizmus zárása).
**74 lépés, 2 kész. A következő: 000.02 Határ-modul.**

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★