# Kutatási napló — 2026-08-23 — Mondat_v1 (a 3D nyelv negyedik modulja: teljes mondattípus + CPT-réteg)

## 1. bejegyzés (2026-08-23, ~16:05)

### KÉRDÉS (idézőjelben, szó szerint)

"`general` ügynök. Szima-projekt (`/Users/joco/opencode`). Munkafolyam: a 3D nyelv negyedik modulja: `Mondat_v1` (teljes mondattípus + CPT-réteg).

ELŐSZÖR OLVASS (§N11): gyökér AGENTS.md, HOROG.md; `skills/idris-stilus/SKILL.md`, `skills/magyar-matematika/SKILL.md`; `docs/HaromDimenziosNyelv_Terv.md` (Dinamika szakasz: ToltesParitasIdo / 27 CPT-bélyeg); meglévő modulok IMPORTÁLANDÓK: `szima_ter/modul/GyokSzo_v1.idr`, `Fogalom_v1.idr`, `SzintaxisMorfizmus_v1.idr` (Mondat + mondatVégpont már VAN — azt importáld, §24!), és a CPT-réteg: grep `ls szima_ter/modul/ | grep -i \"fazis\\|cpt\\|ido\"` → pl. `FazisAlgebra*.idr` (ToltesParitasIdo rekord, fazisFaktorialis). Lásd `CarnotCiklus_v1.idr` + `GyokSzo_v1.idr` stílusmintául.

[...] IDRIS MODUL `szima_ter/modul/Mondat_v1.idr`: CPTBélyeg a FazisAlgebra importált típusaiból; CímkézettMondat = importált Mondat + CPT-bélyeg; a mondat VÉGPONTJÁNAK CPT-mutatója értelmes Refl-ekkel (bélyeg-permutációk száma enumeráció ⟷ szorzat; mondatvégpont-példa tükrözés-kifejtés ⟷ konstans); main futtatható. UTÁNA: ipkg + build 0 hiba + --exec main. NE commitolj, NE pusholj. TÉRJ VISSZA: fájllista + fordítási/futtatási eredmény + max 5 mondat összefoglaló."

### VÁLASZ — összefoglaló

1. **Olvastam (§N11):** HOROG.md, idris-stilus + magyar-matematika skill-ek
   (~/.agents/skills/), terv §4.1 + §5.4, GyokSzo_v1, Fogalom_v1,
   SzintaxisMorfizmus_v1, FazisAlgebra, HaromKubit, Steane713,
   CarnotCiklus_v1 (stílus), szima.ipkg.
2. **Fő felfedezés:** a `FazisAlgebra` v1 NEM fordul (a
   `fazisOsszehasonlit` a sehol nem létező publikus `atfedes`-re és
   a nem-importált `CliﬀordKonstruktor`-ra hivatkozik — az
   osveny_index/build ttc régi maradvány). §13 szerint ÚJ modul:
   `FazisAlgebra_v2` (csak a CPT-mag: ToltesParitasIdo, koherencia,
   irány, fazisFaktorialis; v1 érintetlenül marad).
3. **Új fájlok:**
   - `szima_ter/modul/Mondat_v1.idr` — CPTBélyeg (töltés:Forras ×
     paritás:IgeSzem × idő:IgeIdo = 27), CímkézettMondat (IMPORTÁLT
     Mondat + bélyeg — §24, nem újraírás), VégpontCPTMutató,
     réteghidak (bélyegIdőBejegyzésre → IdoBeljegyzes;
     bélyegTöltésParitásIdőre → ToltesParitasIdo az idoFazisba
     diagonálishomomorfizmussal; fázistényező = fazisFaktorialis),
     5 kernel-Refl (bizBélyegekSzáma: length = 27; bizBélyegHíd:
     3*3*3 = length; bizCímkézettVégpont: lánc-kifejtés = (−1)⁸-as
     konstans; bizVégpontPályaMutató: pálya = FélEgészGyökPálya;
     bizVégpontTávolság: ⟨(−1)⁸,(1⁸)⟩ = −8 → Ellentett), main.
   - `szima_ter/modul/FazisAlgebra_v2.idr` — a CPT-mag fordítható
     újraalapozása (fent).
   - Symlinkek (a Kategoriak/MagyarOntologia mintájára, EGY forrás):
     `modul/Steane713.idr`, `modul/HaromKubit.idr`,
     `modul/E8E8Algebra.idr`, `modul/FazisAlgebra.idr` →
     ../../osveny_index/*.idr (az utóbbi kettő nincs az ipkg-ben).
   - `szima_ter/szima.ipkg`: +Steane713, +HaromKubit,
     +FazisAlgebra_v2, +Mondat_v1 (62 modul).
   - Ez a naplófájl.
4. **Fordítás:** `idris2 --build szima_ter/szima.ipkg` → EXIT 0,
   0 hiba (62 modul; a Mondat_v1 a 11.).
5. **Futtatás:** `cd szima_ter/modul && IDRIS2_PATH=../build/ttc/
   2025081600 idris2 --exec main Mondat_v1.idr` — minden érték a
   várt: 27/27/27 bélyeg, fázistényező 1.0, végpont (−1)⁸ fél-egész
   pályán, távolságok: −1 ellentett / −½ ellentétes rokon / +1 azonos.
6. **Hibajavítások útközben:** (a) symlink szint (../../../ →
   ../../); (b) zárójel a main-ben; (c) Eq IgeIdo/IgeSzem/Forras
   instance-ok pótlása (a Steane713-ban nincsenek).
7. **NEM commitoltam, NEM pusholtam** (a felhasználó explicit
   utasítása szerint).
