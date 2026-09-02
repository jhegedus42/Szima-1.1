# Kutatási napló — 2026-09-02 — «akkor mi legyen a terv ?» (a végleges terv + GAN-ellenőrzés)

## A felhasználó kérdése szó szerint (§N5)

«akkor mi legyen a terv ?»

## A válasz — A VÉGSŐ TERV: EGY ALAP + HÁROM VONAL

A kulcsbelátás: **az új kód azonnal az új alapon íródik, a régi kód lassan vándorol.** A típuscsomagolás nem blokkolja a kutatást — az alapja lesz.

### 0. AZ ALAP (most azonnal)
- `Alap/CsomagoltTipusok.idr` — a kanonikus modul (data Sorszám, Betű, Szöveg, Igazság, EgészSzám, SzámjegyesSzám, MatematikaiKonstans, FizikaiKonstans, Fűzér, Talán, Pár + typeclassok SzámsorT/SzövegT/IgazságT/KonstansT/MennyiségT + Refl-bizonyítások + saját indexelt struktúrák)
- A PILOT: LimitKolimitDemo újraírása data-típusokkal

### 1. VONAL — az új kód csak az új alapon (párhuzamosan)
- A FÁZIS 1 maradék 24 kategóriaelméleti fogalma ÚJONNAN data-típusokkal (nem kell átírni — még nem léteznek)
- Beleértve a SAJÁT hozzájárulást: dagger / kompakt zárt / szalagos / nyom

### 2. VONAL — a régi kód migrációja (lassan, precízen)
- 2a. levelek (Torusz, GeneralizedPauli, HaromKubit...)
- 2b. középcsomópontok (+ trail_index 12 fájl + Kodol a MagyarNyelv ELŐTT)
- 2c. nagy fájlok (KategóriaElméletUniverzális 78, EpisodicMemory 89, KonyvAdat 124, szima_ter 138, szerver_hagyar 11)
- 2d. a legnagyobb csomópontok a VÉGÉN (E8E8Algebra 23 import, ModulRegisztracio 15, Steane713 31 import)
- Minden fájl után fordítás; a 4 KRITIKUS (000.05, 000.06, 001.00, 000.11) a migrációval együtt oldódik meg
- diagnosztika/ + tanulsagok/ → ARCHIVÁLÁS (nem futó kód)

### 3. VONAL — a gráf-adatbázis (FÁZIS 2–10) az új alapon

### A döntések
1. Betű független a Char-tól — IGEN
2. Show-határ — String csak a main-ben (Alap/Határ.idr)
3. tanulsagok/ — ARCHIVÁLÁS
4. Nat — ELDÖNTVE: sehol

### A mérföldköveket
M1 alap fordul + Refl ✓ → M2 pilot fut ✓ → M3 FÁZIS 1 kész → M4 gráf kereshető → M5 4429 → 0

## A GAN-ELLLENŐRZÉS (sikerült — a 3. próbára; az előző kettő limit/abort volt)

A GAN ELFOGADTA a szerkezetet és KIEGÉSZÍTETTE (mind beépítve a terv VIII. szakaszába):

1. **HIÁNYZÓ TÍPUSOK (kritikus!)**: `Fűzér a` (a List csomagolása — a MANTRA tiltja a csomagolatlan List-et, de a tervből kimaradt!), `Talán a` (Maybe), `Pár a b` (Pair), `Időbélyeg`, `VerzióSzám`, `Megbízhatóság`, `BájtláncIndex`, `Esetrag`, `Előjel`, `Számjegy`
2. **SzövegT-műveletek**: `végEgyezikE` KRITIKUS (a 18 esetrag utótag-illesztés!), `elejeEgyezikE`, `egyezikE`, `hossz`, `résztSzöveg`, `szövegÖsszefűz`, `BetűT.előbbE` (a magyar ábécérend NEM ASCII!)
3. **Betű-névhibák javítva**: a 44-es listámban a `FBBetű` nem létező betű volt; hiányoztak `QBetű WBetű XBetű YBetű`; a digráfok javítva (CsBetű, DzBetű, DzsBetű, GyBetű, LyBetű, NyBetű, SzBetű, TyBetű, ZsBetű)
4. **E8Koordináta {0, ±1, ±½}** — a kulcs-hozzátétel: az E8 240 gyökének koordinátái VÉGES értékkészletűek, nem kell általános tizedes! A 137.036 a RánszerkezetKonstansSzimbólum jegyeiként él
5. **Azonnali Refl-törvények**: De Morgan, dupla tagadás, Sorszám jobb-egység, Szöveg üres-egység, számjegy-normalizáció
6. **Besorolási hézagok**: trail_index → 2b, szerver_hagyar → 2c, diagnosztika → archív, Kodol a MagyarNyelv ELŐTT, FaVizualizacio-kettőzés egyesítése
7. **Kockázatok**: `Hossz`-névütközés BIZONYÍTVA (SzotarHid_v2:57 prozódiai Hossz → a fizikai legyen HosszMennyiség); `Alap/Határ.idr` (az EGYETLEN hely, ahol String megjelenik); SzamT.idr ékezet-kanonizációja; SteaneVektor-aritmetika saját törvényekkel; Sorszám-mélység-mérés az M1-ben

## A teendők (a jóváhagyás után)

1. `Alap/CsomagoltTipusok.idr` megírása (M1)
2. `Alap/Határ.idr` megírása
3. A pilot: LimitKolimitDemo data-típusokkal (M2)
4. Az 1. vonal indul: Lépés 1.2 (monad/comonad) az új alapon

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★