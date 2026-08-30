# KodDuplikacioAudit — 2026-08-21 (AGENTS §24 nyilvántartás)
# 代码重复审计 · Code-Duplikation-Audit · ביקורת כפילויות קוד

**Forrás (a felhasználó, 2026-08-21, szó szerint):**
> "ne legyen kod duplikacio!!!! A gf2 az E8TizenhatPenge-ben van, ezt a modul
> nem importálja. Saját gf2Osszeadas helyben <--- ilyenek, keresd meg a
> problemat miert nem importalja, kod duplikacio tilos !!! ez most prioritas,
> add hozza a hook-hoz, kod duplikacio kinyirja az egesz projektet, minden
> szetcsuszik, hasznalhatatlan lesz, kovetkezo lepes, minden kod duplikaciot
> ellenorzunk es eltuntetunk... anelkul hogy informacio veszne el, ez egy
> refaktoralas... olvass el idrisz hasznalatorol irasrol konyveket... keress
> ra neten, stackoverflow, akarmi, minden... nezd meg a csatolt konyveket...
> ez nem meno, EZ TILOS !!! kodot ujra kell hasznallni !!! nem ujra irni !!!!!"

## 1. A gyökérok (miért nem importáltam?)

Az E8FazisKapcsolat.idr-be helyi `gf2Osszeadas`-t írtam, miközben a `gf2`
MÁR LÉTEZETT az E8TizenhatPenge.idr:84-ben (`public export gf2 x = mod x 2`).
**Technikai akadály NEM VOLT** — az Idris2 modulrendszere (l.
trail_index/books/idris2_docs/modules.rst) minden modult név szerint importálhatóvá
tesz (`import E8TizenhatPenge`); a testvér-modulok ugyanabból a könyvtárból
eddig is gond nélkül importálódtak (E8Gyokok_v2, E8BelsoSzorzat).
**A hiba a módszerben volt**: új függvény írásakor NEM futtattam grepet a
projektre. Gyógyír: AGENTS §24 + HOROG 9. szindróma + plugin §N6 + a
horog-injektor 5. pontja (minden prompt után injektálva).

## 2. Az azonnali javítás (megtörtént)

- `E8FazisKapcsolat.idr`: `import E8TizenhatPenge` hozzáadva; a helyi
  `gf2Osszeadas` TÖRÖLVE; `gf2Pontszorzat` az importált `gf2`-t használja.
- BÓNUSZ: a másolás közben belopódzott **matematikai hiba** is kijavult —
  a per-tag redukálás (`gf2(x·y)`-t összeadva) 1+1=2-t adott; a kernel
  leplezte le ("Mismatch between: 0 and 2"). A helyes: a TELJES egész
  pontszorzat, a VÉGÉN egyszeri `gf2` redukció. **A kernel a duplikáció
  szövetségese** (§24.4). Eredmény: CSS 0 megsértés a 9 sorpárra ✓.

## 3. A kimerítő audit eredménye (grep: minden .idr a repóban)

### 3a. Standard-könyvtár újraírásai (Prelude/Data.List — kernel-Refl-lel bizonyítva, hogy LÉTEZNEK: ProbePrelude)

| duplikátum | hol | eredeti | teendő |
|---|---|---|---|
| `elsoN : Nat -> List a -> List a` | E8Gyokok.idr, E8Gyokok_v2.idr | `Data.List.take` (ProbePrelude: `take 2 [1,2,3] = [1,2]` Refl ✓) | v2-ben take-re cserélné — de §13: E8Gyokok_v2 marad; KÖVETKEZŐ modul már importálja |
| `benVan : a -> List a -> Bool` | E8BelsoSzorzat.idr | `Prelude.elem` (Refl ✓) | következő verzióban elem |
| `benVanLista : List Integer -> List (List Integer) -> Bool` | E8TizenhatPenge.idr | `elem` (+ Eq) | következő verzióban elem |
| `egyedi : List (List Integer) -> ...` | E8TizenhatPenge.idr | `Data.List.nub` (ProbePrelude: `nub [1,1,2] = [1,2]` Refl ✓) | következő verzióban nub |

### 3b. Valós kereszt-modul duplikációk (ugyanaz a fogalom, több fájl)

| név | fájlok | kanonikus hely (döntés) | teendő |
|---|---|---|---|
| `gf2` | E8TizenhatPenge (volt: E8FazisKapcsolat is — TÖRÖLVE) | **E8TizenhatPenge** (első otthona; Kodol.idr-ben nincs) | minden új modul importálja |
| `delta` (és a teljes lánc: n,k,d,s,kodSzoTer,kiterjesztettTer,...,lobaszasBase,lobaszasExponens) | AlphaSteane, AlphaSteaneE8, AlphaSteaneVegso (a Dashboard-beli PYTHON-string, NEM Idris-duplikáció) | **Alap.AlphaKozos** (kész, fut, értékek egyeznek) | v1-ek maradnak; _v2-ik importálnak |
| `sigmaG` (1.5e-15, szó szerint azonos ×4) | AlphaE8Szigor, AlphaGCheck, AlphaLobaszas, AlphaSteane | **Alap.AlphaKozos** (kész) | v1-ek maradnak; _v2-ik importálnak |
| `hammingTavolsag` | E8TizenhatPenge, osveny_index/E8E8Algebra.idr | **E8TizenhatPenge** (új kód otthona) | E8E8Algebra v2-ben importál |
| `elsoN` | E8Gyokok, E8Gyokok_v2 (verzió-pár — §13 szerint elfogadható) | Data.List.take (standard!) | új modulokban take |
| `kodSuly`/`minuszokSzama`/`pengeFok` | E8TizenhatPenge / E8Gyokok_v2 | közös "darab : (a -> Bool) -> List a -> Nat" alap | refaktor-hullám 2 |

### 3c. NEM duplikáció (megnézve, ártatlan)

- `plt` (55×), `esetragAlapja`, `bitTerBetu` stb.: egyazon fájlon BELÜLI
  where-szintű előfordulások vagy v1/v2 verziópárok — kereszt-modul
  definíció nincs (fájl-szintű grep igazolta).
- `Kodol.idr`: nincs benne gf2/GF(2) — nem ütközik az E8* családdal.

## 4. A refaktorálási terv (§13 szerint — semmi nem vész el)

1. **Hullám 0 (kész, ma)**: gf2 import; szabály a 4 horogban; ez az audit.
2. **Hullám 1 (KÉSZ, ma)**: `szima_ter/modul/Alap/AlphaKozos.idr` ELKÉSZÜLT —
   a teljes Alpha-alapréteg kanonikus otthona (n→k→d→s→kodSzoTer→
   kiterjesztettTer→...→alphaBare=137.036, delta≈8.23e-7, sigmaG=1.5e-15);
   fordul (1,0 s), fut, minden érték EGYEZIK a v1 kimenetekkel;
   a fogyasztói IMPORT bizonyítva (AlphaKozosImportProbe — 2/2 buildek;
   archiválva). Az Alpha* `_v2`-i innentől importálnak; a v1-ek maradnak.
3. **Hullám 2**: `Alap/ListaiAlap.idr` (darab/számláló, GF(2) lista-műveletek,
   súly, távolság) — az E8* modulok következő verziói importálják;
   standard-könyvtár (take/elem/nub) ahogy létezik.
4. **Python-maradvány** (AGENTS §1.3): `kor_ujraolvasa_check.py` a gyökérben —
   Idrisre írható; külön feladatként vezetve (nem sürgős, de nyitott).

## 5. A szabály mostantól hol él?

- projekt AGENTS.md **§24** (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS)
- HOROG.md **9. szindróma** ("Kódot duplikálok → IMPORTÁLJ!")
- plugin `~/.config/opencode/AGENTS.md` **§N6** (minden sessionbe)
- horog-injektor **5. pont** (minden LLM-hívásnál injektálva; újraindítás után)
