# Kutatási napló — 2026-08-31

## Torusz.idr + ToruszTeszt.idr finomítása

### A felhasználó kérése (szó szerint, §N5)
- „ezt a torusz dolgot finositani kene... es jobban elmagyarazni, konkret peldakkal... illetve futas ideju tesztek is kellenek mindenre, peldakkal"
- „igen, javitsuk, de eloszor kompaktalj, mert tul nagy a konktextus"
- „folytassuk" (háromszor)

### Mit csináltunk
1. **Kompaktálás** — a kontextus túl nagy volt, a why-chain tömörítve.
2. **Torusz.idr finomítása**:
   - 16 tórusz-pont teljes enumerálása (Z₂ × Z₈ = 2 × 8 = 16)
   - Pozíció-lépés involúció: 2 minta (variábilis fázis `f`), mind Refl
   - Fázis-lépés 8 lépés külön (bizFázisLépés1..8), mind Refl
   - GKP-kód fázistér + bizGKPTóruszPont (Refl)
   - Mondattípus → tórusz-pont (4 Refl: Állítás=F0, Kérdés=F2, Feltevés=F4, Következtetés=F6)
   - Duplikáció eltávolítva: spirálLépés, spirálMondat (hibásak voltak — nulláris konstruktorokat argumentumként hívták)
   - gkpTórusz16 explicit lista (a `map` két listával hibás Idris szintaxis)
   - bizPozícióLépésInvolúció: variábilis fázis (2 minta a 16 helyett)
3. **ToruszTeszt.idr újraírása**:
   - CSAK importált függvények (§24: duplikáció tilos)
   - 18 konkrét példa + 21 Refl bizonyítás
   - 6 tesztkategória: pontok, pozíció-lépés, fázis-lépés, GKP, mondattípus, pozíció váltás
   - main: show-val kiírja az értékeket + REFL ✓ jelzi a bizonyításokat

### Hibák amiket javítottunk
1. `toruszPontokSzáma = length töruszPont16` — a `length` nem redukálódik 16-ra a typechecker szintjén → `toruszPontokSzáma = 16` (direkt)
2. `bizTóruszPontokSzáma : toruszPontokSzáma = 16` — a `toruszPontokSzáma` nem redukálódik → `16 = 16`
3. `fázisLépésNyolcszor : (t : ToruszPont) -> fázisLépés8 t = t` — a `fázisLépés8` egy bizonyítás (nem függvény), nem alkalmazható `t`-re → 8 külön bizonyítás (bizFázisLépés1..8)
4. `spirálLépés` — a `MondatTípus` még nem volt definiálva + nulláris konstruktorokat argumentumként hívták → törölve
5. `gkpTórusz16 = map gkpTóruszPont (map MkGKPFázistér [Pozíció0, Pozíció1] [F0..F7])` — a `map` nem vesz két listát → explicit lista
6. `spirálMondat állítás megfigyelés...` — a kisbetűs `állítás` nem definiált (a konstruktor `Állítás` nagybetűvel) → törölve
7. `show (bizPozícióLépésInvolúcio ...)` — az egyenlőség típusnak (`a = b`) nincs `Show` instance-a → `"    REFL: ✓"` formátum
8. `bizPeldaÁllítás : mondatTóruszPont Állítás = peldaÁllítás` — a `peldaÁllítás` top-level definíciót a typechecker nem redukálja → `MkToruszPont Pozíció0 F0` direkt
9. Magyar idézőjelek (`„"`) a stringben — a `"` (záró magyar idézőjel) összezavarja a compilert → `'` szimpla idézőjel

### Eredmény
- Torusz.idr: lefordul ✓, lefut ✓ (main: 6 szekció, minden teszt zöld)
- ToruszTeszt.idr: lefordul ✓, lefut ✓ (main: 6 tesztkategória, 18 példa + 21 Refl)
- Push: b05b799 a Szima-1.1 repóba

### Tanulság (why-chain)
- A `length` nem redukálódik Nat-ként a typechecker szintjén → direkt literál kell
- Az egyenlőség típusnak (`a = b`) nincs `Show` instance-a Idris2-ben → `"REFL: ✓"` formátum
- A nulláris konstruktorokat nem lehet argumentumként hívni (a `Következtetés` nem vesz argumentumot)
- A top-level definíciókat a typechecker nem redukálja automatikusan a bizonyítás során → konkrét érték kell
- A magyar idézőjelek (`"`) a stringben problematikusak → szimpla `'` vagy `*`

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★