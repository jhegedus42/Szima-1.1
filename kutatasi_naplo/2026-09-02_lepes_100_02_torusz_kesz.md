# Kutatási napló — 2026-09-02 — 100.02 KÉSZ: a Torusz átírása (a 17-elemű bug és a csővezeték-tanú)

## A felhasználó utasítása szó szerint (§N5)

«folytassuk»

## Amit végeztem

### 1. A célállapot (mind exit 0 + futás)
- **toruszPontokSzáma : Sorszám = füzérHossz Torusz.töruszPont16** — az érték
  ADATVEZÉRELT (nem literál!): a tényleges lánc hossza.
- **töruszPont16 : Füzér ToruszPont** — let-láncolás (első…tizenhatodik);
  a GAN-felfedezés szerinti TIZENHÉT elemű bug JAVÍTVA: a duplikált
  «tautológia-pont» (1, F0)=(1, 360°) száműzve — a Füzér hossz-törvénye
  kikényszerítette (Curry–Howard: az erősebb típus leleplezte a hibát).
- **gkpTórusz16 = töruszPont16** (§24 — az eredeti azonos Listát másolta).
- **Két-út bizonyítások Refl** (AGENTS §18): 8+8 (direkt szorzat) és a
  Pascal 1+4+6+4+1 (Cl(4) 16 pengéje) — mindkettő a füzér hosszáig fut.
- **CSŐVEZETÉK-TANÚ (toruszSzámaSzava)**: a 16 pont füzére → a hossza →
  a magyar szó = «tizenhat» — EGYETLEN Refl, amely a teljes láncot
  lefuttatja (típus-szinten!).
- Torusz + ToruszTeszt main fut: «Tórusz pontjainak száma = tizenhat» ✓.

### 2. A sorSzöveggé-híd története — két új csapda
- **CSAPDA #19 — a case/with mély ág-mintái TÍPUSBAN nem redukálnak**:
  a kompozicionális (tízAlattiSzó/tízFelett + case) forma FUT, de a
  toruszSzámaSzava-tanúhoz TÍPUS-SZINTŰ redukció kellett — a case és a
  with ág-mintái (mély SorKövetkező-láncok) blokkolják az unifiert.
  MEGOLDÁS: a 21-KLAUZÚLÁS forma (a klauzulák típusban IS redukálnak),
  GÉPI GENERÁLÁSSAL (bash-ciklus — a kézi mélységszámolás #18b után
  ez az egyetlen biztonságos út; a generált klauzulákat még a
  beillesztés is elrontotta egy-egy wrapper-rel — gépi ellenőrzéssel
  fogtam meg).
- **CSAPDA #20 — a privát konstansok OPAKOK a típusokban**: a
  szó-konstansok (szorzámTizenSzó stb.) privátok voltak → a tanú
  típusában nem bonthatták ki őket → «Can't solve constraint».
  MEGOLDÁS: a teljes szócsalád public export (197 publikus most).
- **A kapu-elv fogó-klauzula**: a Sorszám végtelen — a 21 explicit
  klauzula után `sorSzöveggé _ = szorzámHúszSzó` zár (húsz felett
  dokumentált telítés, a MegjelenítésT Sorszám mintájára).

### 3. Állapot
- A vonal: 74+2 lépés, **8 kész** (000.00–000.04, 100.01, 100.01b, 100.02);
  következő: **100.02b — Torusz→TÓRUSZ** (AkH.12; word-boundary csere,
  csapda #17) + a Dirac3D/Torusz.idr árva duplikátum sorsa
  (TÖRLÉS ENGEDÉLYRE VÁR — destruktil tilalom).

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
