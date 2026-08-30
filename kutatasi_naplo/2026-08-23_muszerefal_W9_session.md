# Kutatási napló — 2026-08-23 · Műszerfal (W9) session

## 1. bejegyzés

**Időbélyeg:** 2026-08-23 (a W9 munkafolyam futása; ellenőrzés:
`idris2 --build szima_ter/szima.ipkg` → 0 hiba, és a main futása).

### KÉRDÉS (a felhasználó, szó szerint)

"`general` ügynök. Szima-projekt (`/Users/joco/opencode`). Munkafolyam W9: a
projekt MŰSZERFALA (dashboard) — minden eddigi modul számának egy helyre
gyűjtése, futtatással ellenőrizve.

ELŐSZÖR OLVASS (§N11): gyökér AGENTS.md, HOROG.md;
`skills/idris-stilus/SKILL.md`, `skills/magyar-matematika/SKILL.md`. EZUTÁN a
metrika-modulok (MINDET IMPORTÁLNI FOGOD, §24): `szima_ter/modul/E8Iranymutato_v1.idr`
(240 gyök, W(E8)=696729600, 248/496, 2D Ising exponensek), `E8Univerzalitas_v1.idr`
(skálacímkék, 3D Ising közelítők), `CarnotCiklus_v1.idr` (hatásfokok, Landauer),
`GyokSzo_v1.idr` (112/128, távolság-eloszlás (1,56,126,56,1)), `Fogalom_v1.idr`
(D8-pályák), `SzintaxisMorfizmus_v1.idr` (57 600 kimerítő), `Mondat_v1.idr`
(27 CPT-bélyeg), `E8FazisKapcsolat_v2.idr`. Lásd stílusmintának `E8Iranymutato_v1.idr`-t.

SZIGORÚ SZABÁLYOK: §24 duplikáció TILOS — a mutatókat IMPORTÁLD, a műszerfal
csak ÖSSZEGYŰJTI és KIÍRJA; §25 ékezetes azonosítók/kommentek, fájlnév ékezet
nélkül; §0 rövidítés TILOS; §22 négy nyelvű blokk-fejlécek; §18 tautologikus
Refl TILOS; §N8 Python TILOS (a dashboard generátora Idris!); `data Név : Type
where` teleszkóp; közvetlen importok.

TERMÉKEK:
1. `szima_ter/modul/Muszerefal_v1.idr`: a projekt műszerfala — rekord/generátor,
amely az importált modulokból az ÖSSZES kulcsmutatót összefogja (E8:
240/112/128/248/496/W(E8); nyelv: szókincs 240, osztályok, távolság-eloszlás,
27 CPT-bélyeg; fizika: skálacímkék állapota, Carnot-hatásfokok,
Landauer-küszöbök); `main` = futtatható műszerfal-kiírás (címsorokkal,
csoportosítva, Show-szal, szépen olvasható).
2. `docs/Muszerefal.md`: a dashboard dokumentált változata — négy nyelvű
fejlécek, táblázatok, minden szám mellé a FORRÁS-MODUL neve; a számokat CSAK a
tényleges `--exec main` futás kimenetéből írd be (GAUGE-elv — semmit nem
jelentünk ki ellenőrizetlenül), a futtatás parancsát is dokumentáld.
3. `szima_ter/szima.ipkg` (olvasd, add hozzá a `Muszerfal_v1`-t).

ELLENŐRZÉS: `idris2 --build szima_ter/szima.ipkg` → 0 hiba kötelező; futtasd a
main-t, ellenőrizd a kimenet értelmezhetőségét. NE commitolj, NE pusholj.

TÉRJ VISSZA: fájllista + fordítási/futtatási eredmény (a main kimenetének
váza) + max 5 mondat összefoglaló."

### VÁLASZ (összefoglaló)

1. **Olvasás (§N11)**: gyökér AGENTS.md, HOROG.md, idris-stilus SKILL,
   magyar-matematika SKILL, mind a 8 metrika-modul teljes terjedelemben,
   plusz az E8Gyokok_v2/E8BelsoSzorzat exportjai (grep) és a szima.ipkg.
2. **Új modul**: `szima_ter/modul/Muszerefal_v1.idr` — `MűszerfalMutatók`
   rekord (38 mező: E8-geometria, [[7,1,3]]-híd, nyelv, GAUGE-állapotok,
   fizika), `műszerfalMutatók` konstrukció (kizárólag importált projekciók,
   kályha-minta: egyetlen rekord-konstrukció, let-lánc nélkül), és a main
   (csoportosított, címsoros kiírás). Az EGYETLEN új tétel:
   `bizMűszerfalEmeletekHídja : List.length AlapszókincsKonst =
   List.length FogalomTárKonst`, két IMPORTÁLT bizonyítás (bizKétÚtHíd,
   bizKétPályaHídFogalmon) trans-szim összetételével — nem tautológia (§18),
   a bizonyítások sem duplikálódnak (§24).
3. **Hibák és gyógyításuk** (bisect-szerűen, minden gyökérokban):
   - `„fázis"` záró ASCII idézőjel a sztringben → zárójel-hiba; átírva.
   - `műyszerfal` tipó (fölösleges y) a deklaráció `műszerfal`-ja ellenében.
   - A nagy-listás híd (`length e8Gyokok = length AlapszókincsKonst`) Refl-lel
     elakadt a unifikációban → importált tételek összetételére cserélve.
   - `CarnotCiklus_v1.Hatásfok` NEM `public export` → mezőként használhatatlan
     (§13: a régi modulhoz nem nyúltunk); megoldás: a publikus
     `carnotHatekonysag` (MagyarCarnotE9_v3_CodatAlpha) Double-képlete.
   - Mezőnév-ütközés az importált konstansokkal (`különbözőBélyegekSzáma`,
     `osztályHibákSzáma` — a rekord-accessor árnyékolta volna az értéket) →
     átnevezve (`bélyegKülönbözőségekSzáma`, `szóOsztályHibái`), és a hiányzó
     7. GAUGE-mező pótolva.
   - „KÖZVETLEN import" lecke újra (SzintaxisMorfizmus fejléce): az
     `E8Gyokok_v2` közvetlen importja kötelező az `E8Gyok`-típusú nevekhez.
   - `show (List String)` oktális escape-eli az ékezeteket → `Data.String.unwords`.
4. **ipkg**: `Muszerefal_v1` hozzáadva a modullistához.
5. **Fordítás**: `idris2 --build szima_ter/szima.ipkg` → 0 hiba (63/63 modul).
   **Futtatás**: `cd szima_ter/modul && idris2 --exec main Muszerefal_v1.idr`
   → minden kimenet értelmezhető (GAUGE): E8 240/112/128/696729600/248/496/256,
   norma-ellenőrzés True; pozitív ábécé 120, fázis-bit 5; nyelv 240/112/128/240,
   eloszlás (1,56,126,56,1), 27 bélyeg, fázistényező 1.0; fizika: ising-egyezés
   True, 3D skálacímkék True (maradékok ~10⁻⁸), Carnot 0.4/0.5/0.625/0.2681,
   Landauer 2.87×10⁻²¹ J / 9.57×10⁻²⁴ J; mind a 6 GAUGE-számláló 0 (az 57 600-as
   táblákon), nub-bélyegek 27.
6. **Dokumentáció**: `docs/Muszerefal.md` — négy nyelvű fejlécek, táblázatok
   forrás-modullal minden szám mellett, futtatási parancsok, és a teljes
   szó szerinti futási kimenet.

**Létrejött fájlok:**
- `szima_ter/modul/Muszerefal_v1.idr` (új modul)
- `docs/Muszerefal.md` (dokumentált dashboard)
- `szima_ter/szima.ipkg` (1 sor hozzáadás: `Muszerefal_v1` a modullistában)
- `kutatasi_naplo/2026-08-23_muszerefal_W9_session.md` (ez a fájl)

**Commit/push: NEM történt** (a felhasználó explicit utasítása:
"NE commitolj, NE pusholj").
