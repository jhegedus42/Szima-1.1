# MÁSODIK JAVÍTÓ-HULLÁM — a maradó négy tétel gyógyítása
# 第二修复浪潮——剩余四项的医治 · 2026-09-05
# SECOND REPAIR WAVE — healing the remaining four items
# ZWEITE REPARATURWELLE — Heilung der restlichen vier Punkte

**Előzmény:** `docs/JavitasiHullam_Elso_2026-09-05.md` maradó-listája; a
felhasználó: «folytasd mig nincs kesz». Két tételt a fő ügynök, kettőt
háttér-ágens gyógyított; minden futás-ellenőrzött (GAUGE), semmi törlés.

---

## 1. A NÉGY GYÓGYÍTÁS / 四项医治

### 1.1 PLANCK-FELEZÉS — a gyökérok EGYETLEN TOKEN (fő ügynök)
A `Fizika/Legendre.idr`-ben a `planckHossz` és `planckTomeg` **8π**-vel
osztott a helyes **2π** helyett (ħ = h/2π!); a √ alatt 4-szeres különbség
= pontosan fele értékek — ez volt az audit arány-2,0 rejtélye. Javítás
helyben, a régi alak `-- RÉGI (HIBÁS) … javítva 2026-09-05` jelöléssel
megőrizve (az Einstein-féle 8πG/c⁴ a 405. sorban HELYES, érintetlen).
**Ellenőrzés (GAUGE, Rendszer_v2 futtatásból):** mP = 2.1764e-8
(ref 2.176e-8) ✓ · lP = 1.6163e-35 (ref 1.616e-35) ✓ · tP = 5.3912e-44
(ref 5.391e-44) ✓ · TP = 1.4168e32 (ref 1.417e32) ✓ · EP = 1.9561e9
(ref 1.956e9) ✓ — **ötött öt érték a referencián.**

### 1.2 GENERALIZEDPAULI futásidejű hazugságai (fő ügynök)
A `main` két `putStrLn`-ja (346., 431. sor) „bizonyítása/bizonyítva"-t írt —
a kimenet hazudott a javított kommenteknek. Javítva: „OSZTÁLYOZVA (nem
bizonyítva)" magyarul ÉS kínaiul, RÉGI-jelöléssel; `--check` tiszta.

### 1.3 DEPENDENSSZAMT_V2 — a believe_me-orvoslás (Javító 7)
**A döntés három lépése:** (1) a v1 morfizmus-család NEM záródik kompozíció
alatt (Lepes∘Lepes uninhabited); (2) az egyetlen `DimenzioKetLepes`
konstruktor ELÉGTELEN — a lefedettség-ellenőr végtelen regresszust követelne
(VÉGES konstruktor-készlet sosem záródik); (3) a természetes megoldás a
**LÉPÉS-LÁNC család**: `DimenzioLepes : DimenzioMorf n m → DimenzioMorf n (S m)`
— „m−n lépés" típusa, kompozíció-zárt, total; `DimenzioKetLepes` levezetett
konstansként marad. **A 215. sor meglepetése:** a `dimenzioTipus n →
dimenzioTipus (S n)` leképezés esetszétbontással VALÓDIAN felírható — a v1
állítása IGAZ volt, csak a bizonyítás hiányzott (a deklaráció nem szűkült).
**Tanúk:** `Alap/DependensSzamT_v2.idr` — `1/1 Building, EXIT=0`, nulla hiba
nulla figyelmeztetés; `believe_me` a fájlban 13× — **mind a 13 komment/doc-
komment/putStrLn (a hamis tanúk dokumentált története), KÓDBAN nulla**
(GAUGE-úJRAFUTTATÁS: a saját szűrőm 3 `|||`-doc-kommentet jelzett, mind
ellenőrizve). **Importőrök:** senki (csak komment/adat-hivatkozás) — senki
nem törik. Új csapdák: instance-önrekurzió lehetetlen interfész-paraméter
nélkül (sík top-level függvény + vékony delegáló); meta-invertálás bukása
(explicit implicit indexek); VÉGES konstruktor-készlet nem záródik (§18).

### 1.4 AZ AI-LÁNC ÉKEZETESÍTÉSE (Javító 6)
- **`EpisodicMemory_v2_Szima.idr`** (1390 sor, 68 613 bájt): 12 típus +
  70 függvény — a v1 mind a 69 definíciója nulla vesztességgel átment;
  ~200 azonosító ékezetes magyarra (Aminosav, Polipeptid, HajtogatottFehérje,
  fehérjétHajt, hajtÉsKódol…; Mk → Konstruktor-utótag; mind a 20 aminosav-
  konstruktor magyar nevet kapott); **IUPAC-kódok a stringekben megmaradtak**
  (`show Alanin = "Ala"`, görög szimbólumok, Bekenstein/Hawking nevek);
  **`%default total` az EGÉSZ fájlra** (a v1-ben 0 volt!) — két totality-
  gyógyszer: `láncHajt` strukturális négyesével-bontásra (drop-rekurzió
  helyett), `powIntD` → `hatványNat` + `valósHatvány`; `main` hozzáadva.
  `--check`: `4/4 Building, EXIT=0`; futás: teljes magyar demo, exit 0.
- **`BabyAGI_v2_Szima.idr`** (264 sor): `Szint`, `szótTanul`, `alvásSzűr`;
  `%default total` megmarad; 7 `-- Kimenet: Refl` komment; a
  `lexikonHasWords : 3460 = 3460` tautológia §18-szerinti JELZÉSSEL
  helyettesítve — őszintén jelezve: definicionálisan még mindig zár, a
  VALÓDI tanúhoz a lexikon összegző listája kell (a 3460 szó egyéni
  konstansokként él; a listaépítés a let-lánc-robbanást kockáztatná, §2)
  → nyitott tétel a későbbi hullámra. `--check`: `10/10 Building, EXIT=0`;
  futás: „tanult szó: ház … alvásSzűr után (Hawking-elpárolgás…): 0", exit 0.
- Minden blokk-fejléc négynyelvű (HU+ZH+EN+DE); a v1-ekben egy sor sem
  változott (§13); BabyAGI_v2 az EpisodicMemory_v2-re importál (a v1-lánc
  érintetlen maradt).

## 2. AMI MÉG NYITOTT (hullám 3 jelöltek) / 仍开放项

1. A lexikon VALÓDI hossz-tanúja (3460 szó aggregált listából — a
   let-lánc-rovás ellen biztonságos építési móddal).
2. A BabyAGI v1-es nyitott tanúi (isPrime 4 = False, factorize 6 = [2,3] —
   a natMod modulhatár-redukció miatt; a TODO-k átmentek).
3. A gyökér ~14 vizualizációs .py (§3) Idris-átírása vagy hivatalos
   eszköz-státusz; 43 megjelöletlen .py az ellenorzes.sh-ban.
4. A PrimekAnalizis/SzamT tautológiák (külön kis hullám); ipkg-kánon
   frissítése (12 hiányzó + a fejléc); KisAI + Main3D közös migrációja.

## 3. ÁLLAPOT / 状态

A hét + négy = **tizenegy javítandóból tizenegy kész**; minden új fájl
fordul (GAUGE: kimenet olvasva); v1-ek érintetlenek; semmi nem törlődött;
a maradó-lista hullám-3-ra ütemezve, az Irányító (Irányító_v1) sorába
írva. Commit + push: a hullám végén egyben.

★ NEGYNYELVŰ VÁLASZ: magyar + 中文 + Deutsch + עברית ★
