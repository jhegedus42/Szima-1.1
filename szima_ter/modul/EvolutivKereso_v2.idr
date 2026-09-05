module EvolutivKereso_v2

-- ═══════════════════════════════════════════════════════════════
-- EVOLUTÍVKERESŐ v2 — a v1 MEGGYÓGYÍTVA (#27-lánc + bizonyítás-lánc)
-- EVOLUTIONARY SEARCHER v2 · 演化搜索器 v2 · Evolutionärer Sucher v2
-- · מחפש אבולוציוני v2
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v2? (§13: a javítás ÚJ FÁJL — az EvolutivKereso_v1.idr
--   ÉRINTETLENÜL marad; semmi nem íródik felül, semmi nem törlődik.)
--
-- ─── A v1 HIBÁI SZÓ SZERINT (idris2 --check, 2026-09-05) ───────
--   1. «Warning: We are about to implicitly bind the following
--      lowercase names… e8Gyokok is shadowing E8Gyokok_v2.e8Gyokok»
--      (a bizMutációZártPélda TÍPUSÁBAN — KisBetűsProjekcióCsapda)
--   2. «Error: While processing left hand side of útVége.
--      Undefined name útvonal.»                     (115. sor)
--   3. ugyanez útLépéseinekSzáma (160), fitnesz (167),
--      legjobbFitnesz — jobboldal, a lambdában (176),
--      útElériACélt (188), kiterjeszt (206) — ÖSSZESEN ×6
--   4. «Error: While processing right hand side of bizMéretMegmarad.
--      Can't solve constraint between: 6 and length (következőGeneráció
--      KezdőPopulációKonst).»                       (349. sor)
--   5. ugyanez bizMéretMegmaradKlasszikus           (357. sor)
--   6. «Error: While processing type of bizMutációZártPélda.
--      Can't find an implementation for Foldable ?t.» (382. sor)
--   7. «Error: While processing right hand side of
--      bizMegtaláltÚtVégeACél. Can't solve constraint between:
--      AzonosJel and if szorzat … == 8 then AzonosJel else …» (404)
--
-- ─── A GYÓGYÍTÁS ÉS AZ ÚJ, ÉLESÍTETT CSAPDA-ISMERET ────────────
--   A ProbeKeresoRefl.idr (a repóban, 13 adatpont) kimérte a #27
--   VALÓDI mintáját — az eddigi «IO-do-s függvénynél nem megy»
--   finomításnál ÉLESEBBEN:
--   ★ CSAPDA #27b (2026-09-05, mért): az ékezetes KEZDŐBETŰS csupasz
--     kötőnév bukik (import mellett): útvonal, űr, ábra, ék, útjelző,
--     ábrázat, ábrix, ábraLambda, ékesKonstruktorban — MIND «Undefined
--     name». AZ ASCII-KEZDÉSŰ ékezetes név viszont ÁTMEGY: gyök, béta,
--     népességLista, kiesőkSzáma, sorszám, többi, eddig, vonal.
--     A konstruktor-minta NEM véd ((Just ékesKonstruktorban) is elbukott!).
--   Gyógyír-rend (CSAPDA_27-revízió, tanúsított sorrend):
--     (a) pont-stílus / magasabb-rendű függvény — LEGBIZTOSABB;
--     (b) @-minta (`útvonal@_`) — tiszta ÉS IO klauzulán is bizonyított;
--     (c) konstruktor-minta — NEM megbízható;
--     (d) ASCII-kezdésű név (az ékezetes farok marad, §25).
--   Az egyes gyógyítások ITT:
--     • útVege, útLépéseinekSzáma, fitnesz, útElériACélt, kiterjeszt:
--       LHS `útvonal@_` (b-ág);
--     • legjobbFitnesz: a kétparaméteres lambda helyett PONT-STÍLUS
--       (a-ág): `foldl (\eddig => max eddig . fitnesz) …`;
--     • bizMutációZártPélda típusa: a csupasz kisbetűs `e8Gyokok`
--       helyett NAGYBETŰS alias `E8GyokokKonst` (KisBetűsProjekcióCsapda;
--       a foldable-?t-hiba is ez volt: a be nem kötött implicit elrontotta
--       az elem Foldable-feloldását);
--     • bizMéretMegmarad(+Klasszikus) és bizMegtaláltÚtVégeACél: a v1-ben
--       azért ragadtak be, mert a TÖRÖTT útVege/fitnesz blokkolta a
--       redukciót (a bizonyítás-hibák a #27 FOLYOMDÁI voltak, az állítások
--       IGAZAK) — a fenti javítások után a lánc MÉG MINDIG beragadt, és a
--       ProbeEV2.idr bisect (p1–p8) kimérte az igazi okot:
--       ★ CSAPDA #30 (2026-09-05, mért): a Data.List.sortBy csak `export`
--         (NEM public export) — base-0.8.0/Data/List.idr:747. sor — ezért
--         definíciója láthatatlan az importáló modulból, és fordítási
--         időben NEM redukál: `sortBy f [1,3,2] = [3,2,1]` Refl-lel NEM
--         zár (a ProbeEV2 p3/p4/p5; a Double-tól FÜGGETLENÜL). Gyógyír:
--         a bizonyításban részt vevő rendezés legyen SAJÁT, public
--         export (itt: fitneszRendezés — stabil beszúrásos); a futás
--         ugyanezt használja (egységesen, §24-szelvédve: egy rendezés
--         van, a nem-redukáló sortBy-t nem hívjuk sehova).
--
-- ─── A BIZONYÍTÁS-VÁZLAT (a kód ELŐTT, §18) ────────────────────
--   bizMéretMegmarad: a KITERJESZTÉS (6 út × 4 tengely = 24 jelölt)
--     → RENDEZÉS → KIVÁLASZTÁS (take 6) lánc kifejtése a konkrét
--     kezdőpopuláción — indukció nem kell, a kernel a konkrétumon
--     kényszerített számítást futtat; a bal oldal SZÁMÍTÓ recept, a
--     jobb oldal a független PopulációMéret konstans.
--   bizMéretMegmaradKlasszikus: ugyanez a FÚZIONÁLT láncon
--     (kiterjesztés + szelektál egy lépésben).
--   bizMutációZártPélda: σ_(1⁸)(2,2,0⁶) = (1,1,−1⁶) — a kernel az
--     elem-keresést a 240-es listán végigszámolja (zártság-híd).
--   bizMegtaláltÚtVégeACél: a kétszöres Weyl-tükrözés (2,2,0⁶)
--     →σ(1⁸)→ (1,1,−1⁶) →σ(2,2)→ (−1)⁸; ⟨(−1)⁸,(−1)⁸⟩ = +8 → AzonosJel.
--     A futás GAUGE-kimenete és ez a kifejtés KÉT független út.
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2     -- e8Gyokok, gyokSzimbolum (§24)
import E8BelsoSzorzat  -- weylReflexio, gyokEllentett, Eq E8Gyok (§24)
import GyokSzo_v1      -- GyökSzó, jel, szóOsztályMeghatároz, jelentésTávolság,
                       -- HasonlóságÖtSzint, Példa*-konstansok (§24)
import CarnotCiklus_v1 -- CarnotÁllapot, állapotLépése, landauerKüszöb (§24)
import Data.List       -- standard lista-műveletek (§24)

%default covering

-- ===============================================================
-- 1. A KERESÉSI FELADAT — KEZDŐ, CÉL, TENGELYEK (mind IMPORT, §24)
--    The search problem · 搜索问题 · Das Suchproblem · בעיית החיפוש
-- ===============================================================

||| A KEZDŐ gyök: a PéldaEgészSzó jele — (2,2,0⁶), a tipus1Gyokok
||| első tagja. IMPORTÁLT konstans — nem építünk új gyököt (§24).
public export
KezdőGyök : E8Gyok
KezdőGyök = jel PéldaEgészSzó

||| A CÉL gyök: (−1)⁸ — az IMPORTÁLT gyokEllentettel: −(1⁸), a
||| PéldaFélEgészSzó ellentettje. Két lépésre a kezdőtől a
||| dokumentált láncon: (2,2,0⁶) →σ(1⁸)→ (1,1,−1⁶) →σ(2,2,0⁶)→ (−1)⁸.
public export
CélGyök : E8Gyok
CélGyök = gyokEllentett (jel PéldaFélEgészSzó)

||| A célszó: a célgyök GyökSzó-burkolása az IMPORTÁLT
||| szóOsztályMeghatározzal (a burkolás maga is kompozíció, §24).
public export
Célszó : GyökSzó
Célszó = GyökSzóKonstruktor CélGyök (szóOsztályMeghatároz CélGyök)

||| A MUTÁCIÓS TENGELYEK: a négy IMPORTÁLT példaszó jele —
||| (1⁸), (2,2,0⁶), (2,−2,0⁶), (−1⁶,1,1). Az expander ennyiféle
||| weylReflexio-lépést kínál útvégpontra (lista-konstans, NEM
||| let-lánc — LetLáncProbe tanulsága).
public export
TengelyGyökök : List E8Gyok
TengelyGyökök =
  [ jel PéldaFélEgészSzó        -- (1⁸)      — átvisz a másik D8-pályára
  , jel PéldaEgészSzó           -- (2,2,0⁶)  — öntükröz: σ_S(S) = −S
  , jel PéldaMerőlegesSzó       -- (2,−2,0⁶) — merőleges: σ = identitás
  , jel PéldaEllentétesRokonSzó -- (−1⁶,1,1) — 120°-os szomszéd
  ]

-- ===============================================================
-- 2. AZ ÚT-JELÖLT ÉS A POPULÁCIÓ
--    The path candidate and the population · 路径候选与种群
-- ===============================================================

||| Az ÚT-JELÖLT: gyökök láncolata — [kezdő, r₁, r₂, …]; az út
||| értelme a VÉGPONT ÉS a lépéssor (mint a Mondat tükrözésSora,
||| csak itt nyers gyökön, CPT-bélyeg nélkül).
public export
ÚtJelölt : Type
ÚtJelölt = List E8Gyok

||| A POPULÁCIÓ: út-jelöltek listája.
public export
Populáció : Type
Populáció = List ÚtJelölt

||| A populáció mérete — rögzített, mindkét variánsban ugyanaz.
public export
PopulációMéret : Nat
PopulációMéret = 6

||| Az út VÉGPONTJA: az utolsó gyök (üres útra a kezdő — a foldl
||| kezdőértéke adja a totalitást; Data.List.foldl, §24).
||| CSAPDA #27b-gyógyír: `útvonal@_` — az ékezetes KEZDŐBETŰS csupasz
||| kötőnév import mellett «Undefined name»; az @-minta tanúsított áthidaló.
public export
útVége : ÚtJelölt -> E8Gyok
útVége útvonal@_ = foldl (\_, gyök => gyök) KezdőGyök útvonal

||| Egy gyök SZÓVÁ emelése: GyökSzó-burkolás az IMPORTÁLT
||| szóOsztályMeghatározzal (híd a jelentésTávolsághoz).
public export
szóváEmel : E8Gyok -> GyökSzó
szóváEmel gyök = GyökSzóKonstruktor gyök (szóOsztályMeghatároz gyök)

||| A kezdőpopuláció: PopulációMéret darab egytagú út — [kezdő].
||| Determinisztikus (véletlen nélküli) inicializálás.
public export
KezdőPopuláció : Populáció
KezdőPopuláció = replicate PopulációMéret [KezdőGyök]

||| Nagybetűs konstans a bizonyítás-típusokhoz
||| (KisBetűsProjekcióCsapda).
public export
KezdőPopulációKonst : Populáció
KezdőPopulációKonst = KezdőPopuláció

-- ===============================================================
-- 3. A FITNESS — JELENTÉSPONT − LÉPÉSBÜNTETÉS (Double)
--    Fitness · 适应度 · Fitness · כושר
-- ===============================================================

||| Az ötszintű skála PONTSZÁMA: az IMPORTÁLT HasonlóságÖtSzint
||| szintjei ±1/±½/0 pontot kapnak (a GyokSzo_v1 Show-instance
||| értékei pontosan ezek — itt Double-ként). Ez a demó EGETLEN
||| új leképezése (grep: máshol nincs a projektben).
public export
jelPontszáma : HasonlóságÖtSzint -> Double
jelPontszáma AzonosJel       = 1.0
jelPontszáma SzorosanHasonló = 0.5
jelPontszáma Semleges        = 0.0
jelPontszáma EllentétesRokon = -0.5
jelPontszáma Ellentett       = -1.0

||| A lépésszám-BÜNTETÉS: egy lépés ára — a rövidebb utat jutalmazza.
public export
lépésBüntetés : Double
lépésBüntetés = 0.05

||| Az út LÉPÉSEINEK száma: a gyökök száma mínusz a kezdő (Nat minus).
||| CSAPDA #27b-gyógyír: `útvonal@_` (@-minta).
public export
útLépéseinekSzáma : ÚtJelölt -> Nat
útLépéseinekSzáma útvonal@_ = minus (length útvonal) 1

||| A FITNESS: a végpont céltól mért jelentéspontja MÍNUSZ a
||| lépésszám-büntetés. (Double — ellenőrzése futásidejű GAUGE,
||| a Double-egyenlőség NEM Refl-tárgy, §18.)
||| CSAPDA #27b-gyógyír: `útvonal@_` (@-minta).
public export
fitnesz : ÚtJelölt -> Double
fitnesz útvonal@_ =
  jelPontszáma (jelentésTávolság (szóváEmel (útVége útvonal)) Célszó)
    - lépésBüntetés * cast (útLépéseinekSzáma útvonal)

||| A populáció LEGJOBB fitness-e (a kiértékelő ütem írja be az
||| állapotba; az alsó „padló" −999.0 lehetetlen érték).
||| CSAPDA #27b-gyógyír: a v1 kétparaméteres lambdájában az ékezetes
||| KEZDŐBETŰS `útvonal` «Undefined name» volt — itt PONT-STÍLUS
||| (a revízió (a)-ág, LEGBIZTOSABB): `\eddig => max eddig . fitnesz`.
||| (`eddig` ASCII-kezdésű — az átment.)
public export
legjobbFitnesz : Populáció -> Double
legjobbFitnesz népességLista =
  foldl (\eddig => max eddig . fitnesz) (-999.0) népességLista

||| Az ötszintű skála AZONOSJEL-próbája (a cél-elérés detektora:
||| egység-normájú gyököknél a ⟨α,β⟩ = +8 pontosan az azonosság).
public export
azonosJelE : HasonlóságÖtSzint -> Bool
azonosJelE AzonosJel = True
azonosJelE _         = False

||| Egy út eléri-e a célt (a végpont AzonosJel-e a célszóval).
||| CSAPDA #27b-gyógyír: `útvonal@_` (@-minta).
public export
útElériACélt : ÚtJelölt -> Bool
útElériACélt útvonal@_ =
  azonosJelE (jelentésTávolság (szóváEmel (útVége útvonal)) Célszó)

||| A populáció cél-elérésének próbája (bármely útvégpont eléri-e).
public export
célElérveE : Populáció -> Bool
célElérveE népességLista = any útElériACélt népességLista

-- ===============================================================
-- 4. A VARIÁCIÓ — KITERJESZTÉS weylReflexio-LÉPÉSEKKEL (IMPORT, §24)
--    Variation — expansion · 变异——扩展 · Variation — Erweiterung
-- ===============================================================

||| Egy út KITERJESZTÉSE: mind a négy tengelyre egy új jelölt — a
||| végpontra alkalmazott IMPORTÁLT weylReflexio hozzáfűzve (a
||| tükrözés ZÁRT a 240 gyökre — l. a kimerítő mérést alább).
||| CSAPDA #27b-gyógyír: `útvonal@_` (@-minta); a belső lambda
||| `tengely`-e ASCII-kezdésű — az átment.
public export
kiterjeszt : ÚtJelölt -> List ÚtJelölt
kiterjeszt útvonal@_ =
  map (\tengely => útvonal ++ [weylReflexio tengely (útVége útvonal)])
      TengelyGyökök

||| A populáció kiterjesztése: minden útból a négy tengely-lépés.
public export
kiterjesztés : Populáció -> Populáció
kiterjesztés népességLista = concatMap kiterjeszt népességLista

-- ===============================================================
-- 5. A SZELEKCIÓ ÉS A LANDAUER-KÖNYVELÉS (IMPORTÁLT küszöb, §24)
--    Selection and the Landauer ledger · 选择与朗道尔记账
-- ===============================================================

||| A fitness-SORREND: csökkenő (a jobb fitness előre).
public export
fitneszSorrend : ÚtJelölt -> ÚtJelölt -> Ordering
fitneszSorrend egy kettő = compare (fitnesz kettő) (fitnesz egy)

||| BESZÚRÁS a csökkenő (stabil) sorrendbe — a fitneszRendezés segéde.
||| CSAPDA #30-gyógyír: public export, hogy a kernel redukálhassa
||| (a Data.List.sortBy csak `export` — nem redukál, l. a fejlécet).
||| Stabilitás: a fej ELŐRE marad, ha jobb VAGY egyenlő (nem GT) —
||| így az eredeti sorrend a kötésekben megmarad (determinisztikus).
public export
beszúrás : ÚtJelölt -> List ÚtJelölt -> List ÚtJelölt
beszúrás jelölt [] = [jelölt]
beszúrás jelölt (fej :: farok) =
  if fitneszSorrend fej jelölt == GT
    then jelölt :: fej :: farok
    else fej :: beszúrás jelölt farok

||| A FITNESS-SZERINTI RENDEZÉS: stabil beszúrásos — public export,
||| a kernel REDUKÁLJA (CSAPDA #30: a Data.List.sortBy csak `export`,
||| fordítási időben nem redukál — a bizonyítás ezt nem használhatja;
||| a futás is ezt hívja, egyetlen rendezés van a modulban, §24).
public export
fitneszRendezés : List ÚtJelölt -> List ÚtJelölt
fitneszRendezés [] = []
fitneszRendezés (jelölt :: többi) = beszúrás jelölt (fitneszRendezés többi)

||| A SZELEKCIÓ: fitness-szerinti rendezés + az első PopulációMéret
||| megtartása (csonkolás — terv §1.1/3; a rendezés a fenti
||| fitneszRendezés — stabil, ezért kötéseknél determinisztikus).
public export
szelektál : Populáció -> Populáció
szelektál jelöltek = take PopulációMéret (fitneszRendezés jelöltek)

||| A TÖRÖLT BITEK száma: kieső egyedenként log₂ N bit (az „melyik
||| maradjon" döntés információ tartalma — terv §4.1/§5.5 képlete);
||| a log₂ a Prelude log-jával (nem új logaritmus-implementáció).
public export
töröltBitek : Nat -> Double
töröltBitek kiesőkSzáma =
  cast kiesőkSzáma * (log (cast PopulációMéret) / log 2.0)

||| A szelekciós lépés HŐJE (Joule): töröltBitek · landauerKüszöb 300 K
||| — az IMPORTÁLT CarnotCiklus_v1.landauerKüszöbbel (SI-exakt kB;
||| §17: nincs mérési σ, a kB defináló állandó). ALSÓ KORLÁT és
||| könyvelési egység (terv §4.1 honest framing).
public export
szelekcióHője : Nat -> Double
szelekcióHője kiesőkSzáma =
  töröltBitek kiesőkSzáma * landauerKüszöb 300.0

-- ===============================================================
-- 6. A GENERÁCIÓS ÁLLAPOT ÉS A KÉT HAJTÁS
--    Generation state and the two drives · 世代状态与两种驱动
-- ===============================================================

||| A generációs ÁLLAPOT: a populáció + a felhalmozott hő (J) +
||| a jelenlegi legjobb fitness.
public export
record GenerációsÁllapot where
  constructor GenerációsÁllapotKonstruktor
  népesség        : Populáció
  felhalmozottHő  : Double  -- J — a KUMULÁLT Landauer-költség
  legjobbPontszám : Double

||| A kezdő-állapot: kezdőpopuláció, nulla hő, lehetetlen padló-fitnesz.
public export
KezdőGenerációsÁllapot : GenerációsÁllapot
KezdőGenerációsÁllapot =
  GenerációsÁllapotKonstruktor KezdőPopuláció 0.0 (-999.0)

-- ─── 6a. A-VARIÁNS: a CARNOT-NÉGYÜTEM (az IMPORTÁLT CarnotÁllapoton) ──

||| A Carnot-ütemek a generációs állapotra (mind a négy IMPORTÁLT
||| CarnotÁllapot-konstruktornak egy művelet felel meg):
|||   1. izoterma tágulás   = EXPANZIÓ (új jelöltek),
|||   2. adiabata lehűlés   = KIÉRTÉKELÉS (a legjobb fitness beírva),
|||   3. izoterma sűrítés   = SZELEKCIÓ (ár: landauerKüszöb · törölt bit),
|||   4. adiabata melegítés = PIHENŐ (identitás — a rendszer pihen).
public export
generációsÜtem : CarnotÁllapot -> GenerációsÁllapot -> GenerációsÁllapot
generációsÜtem ElsőIzotermaTágulás st =
  GenerációsÁllapotKonstruktor (kiterjesztés (népesség st))
                               (felhalmozottHő st) (legjobbPontszám st)
generációsÜtem MásodikAdiabataLehűlés st =
  GenerációsÁllapotKonstruktor (népesség st)
                               (felhalmozottHő st) (legjobbFitnesz (népesség st))
generációsÜtem HarmadikIzotermaSűrítés st =
  GenerációsÁllapotKonstruktor (szelektál (népesség st))
                               (felhalmozottHő st
                                  + szelekcióHője
                                      (minus (length (népesség st))
                                             PopulációMéret))
                               (legjobbPontszám st)
generációsÜtem NegyedikAdiabataMelegítés st = st

||| A CARNOT-HAJTÁSÚ generáció: a négy ütem a teljesCiklus sorrendjében.
public export
carnotGeneráció : GenerációsÁllapot -> GenerációsÁllapot
carnotGeneráció =
  generációsÜtem NegyedikAdiabataMelegítés
    . generációsÜtem HarmadikIzotermaSűrítés
    . generációsÜtem MásodikAdiabataLehűlés
    . generációsÜtem ElsőIzotermaTágulás

||| A vázlatbeli következőGeneráció: a négyfázis-lánc a populáción
||| (a bizMéretMegmarad bal oldala — a kernel végigszámolja).
public export
következőGeneráció : Populáció -> Populáció
következőGeneráció p =
  népesség (carnotGeneráció
    (GenerációsÁllapotKonstruktor p 0.0 (-999.0)))

-- ─── 6b. B-VARIÁNS: a klasszikus evolúciós hurok ─────────────────

||| A KLASSZIKUS generáció: expanzió + szelekció EGY fúzionált
||| lépésben; a hurok NEM ciklus-ütemű (nincs Carnot-állapotgép),
||| a szelekció NEM Landauer-árazott (a hőmező VÁLTOZATLAN marad).
public export
klasszikusGeneráció : GenerációsÁllapot -> GenerációsÁllapot
klasszikusGeneráció st =
  GenerációsÁllapotKonstruktor (szelektál (kiterjesztés (népesség st)))
                               (felhalmozottHő st)
                               (legjobbFitnesz (szelektál (kiterjesztés (népesség st))))

||| A klasszikus oldal következő generációja (a második
||| méretmegmarad-baloldal).
public export
klasszikusKövetkezőGeneráció : Populáció -> Populáció
klasszikusKövetkezőGeneráció p =
  népesség (klasszikusGeneráció
    (GenerációsÁllapotKonstruktor p 0.0 (-999.0)))

-- ===============================================================
-- 7. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Proofs — two independent paths, one bridge
--    证明——两条独立道路，一座桥 · Beweise — zwei Wege, eine Brücke
-- ===============================================================

||| A futtatott GENERÁCIÓK száma (mindkét variáns ugyanennyit fut).
public export
generációkSzáma : Nat
generációkSzáma = 4

-- Kimenet: Refl — a bal oldal a KITERJESZTÉS (6 út × 4 tengely = 24
-- jelölt) → RENDEZÉS → KIVÁLASZTÁS lánc kifejtése; a kernel végig-
-- számolja a fitneszRendezést és a take-ot. Nem X = X: a lánc bármely
-- átírása (pl. rossz szelekciós méret) automatikusan eltöri.
-- (A v1-ben azért ragadt be, mert a törött útVege/fitnesz blokkolta
-- a redukciót; a javítás után a #30-as sortBy-csapda jött elő —
-- a saját public export fitneszRendezés ezt is gyógyította.)
public export
bizMéretMegmarad :
  length (következőGeneráció KezdőPopulációKonst) = PopulációMéret
bizMéretMegmarad = Refl

-- Kimenet: Refl — ugyanaz a lánc a KLASSZIKUS hajtáson (a két
-- variáns populáció-mechanikája azonos; a bizonyítás ezt is
-- kényszeríti).
public export
bizMéretMegmaradKlasszikus :
  length (klasszikusKövetkezőGeneráció KezdőPopulációKonst) = PopulációMéret
bizMéretMegmaradKlasszikus = Refl

||| A demó MINDEN mutációjának listája: a négy tengely alkalmazva a
||| teljes IMPORTÁLT gyöklistára (concatMap — comprehension nélkül,
||| a Foldable-kötési kétértelműség elkerülve).
public export
mindenMutáció : List E8Gyok
mindenMutáció =
  concatMap (\tengely => map (weylReflexio tengely) e8Gyokok) TengelyGyökök

||| A MUTÁCIÓ zártságának KIMERÍTŐ futásidejű mérése: mind a
||| 4 × 240 = 960 weylReflexio eredménye benne van-e az IMPORTÁLT
||| e8Gyokok listájában? Várt érték: 0 — ez a projekt meglévő
||| zártsági-mérésének (zarasHibakSzama) futása a demó saját
||| tengelyhalmazán (GAUGE-elv).
public export
mutációsZártságiHibákSzáma : Nat
mutációsZártságiHibákSzáma =
  length (filter (\gyök => not (elem gyök e8Gyokok)) mindenMutáció)

-- Kimenet: Refl — ZÁRTSÁG-HÍD: a demó ELSŐ tényleges mutációja
-- (σ_(1⁸)(2,2,0⁶) = (1,1,−1⁶)) eredménye gyök — a kernel az
-- elem-keresést a 240-es listán végigszámolja. A típusban NAGYBETŰS
-- `E8GyokokKonst` áll (a csupasz kisbetűs konstans implicitcsé
-- kötődött — KisBetűsProjekcióCsapda).
public export
bizMutációZártPélda :
  elem (weylReflexio (jel PéldaFélEgészSzó) KezdőGyök) E8GyokokKonst = True
bizMutációZártPélda = Refl

||| A MEGTALÁLT ÚT konstruktoros újjáépítése: pontosan azt az utat,
||| amelyet a futás a 2. generációban felfedez. A futás GAUGE-kimenete
||| és ez a bizonyítás KÉT független út — a találkozás az
||| AzonosJel-osztályozásnál (§18).
public export
MegtaláltÚtKonst : ÚtJelölt
MegtaláltÚtKonst =
  [ KezdőGyök
  , weylReflexio (jel PéldaFélEgészSzó) KezdőGyök
  , weylReflexio (jel PéldaEgészSzó)
      (weylReflexio (jel PéldaFélEgészSzó) KezdőGyök)
  ]

-- Kimenet: Refl — a rekonstruált útvégpont (−1)⁸ AZONOS jel a
-- célszóval: a kernel két weylReflexiót, a szóOsztály-keresést és a
-- belső szorzatot ((−1)⁸·(−1)⁸ = +8) végigszámolja. (A v1-ben a
-- törött útVege blokkolta a kifejtést — a javítás után lefut.)
public export
bizMegtaláltÚtVégeACél :
  jelentésTávolság (szóváEmel (útVége MegtaláltÚtKonst)) Célszó = AzonosJel
bizMegtaláltÚtVégeACél = Refl

-- ===============================================================
-- 8. A FUTÁSOK — ITERATEN ÁLLOMÁSLISTÁK (NEM let-lánc!)
--    The runs · 运行 · Die Läufe · הריצות
-- ===============================================================

||| A CARNOT-futás állomáslistája: a kezdő-állapot + generációkSzáma
||| darab Carnot-generáció (Data.List.iterateN — lista-konstrukció,
||| LetLáncProbe-biztos).
carnotFutás : List GenerációsÁllapot
carnotFutás = iterateN (S generációkSzáma) carnotGeneráció KezdőGenerációsÁllapot

||| A klasszikus futás állomáslistája: ugyanonnan, ugyanennyi
||| generáció, de a fúzionált lépéssel.
klasszikusFutás : List GenerációsÁllapot
klasszikusFutás =
  iterateN (S generációkSzáma) klasszikusGeneráció KezdőGenerációsÁllapot

||| Egy futás UTOLSÓ állomása (a foldl kezdőértéke adja a totalitást).
utolsóÁllomás : List GenerációsÁllapot -> GenerációsÁllapot
utolsóÁllomás = foldl (\_, st => st) KezdőGenerációsÁllapot

||| Az első cél-elérés SORSZÁMA (0 = a kezdő-állapot): rekurzió a
||| állomáslistán; Nothing = nem érte el a célt N generáció alatt.
elsőCélElérés : List GenerációsÁllapot -> Maybe Nat
elsőCélElérés [] = Nothing
elsőCélElérés (st :: többi) =
  if célElérveE (népesség st)
    then Just 0
    else map S (elsőCélElérés többi)

||| Segéd: Bool magyar kiírása.
igenNem : Bool -> String
igenNem True  = "igen"
igenNem False = "nem"

||| Az első cél-elérés emberi formában (konstruktor-minta, case-nélkül).
célElérésSzöveg : Maybe Nat -> String
célElérésSzöveg (Just sorszám) = "a " ++ show sorszám ++ ". generációban"
célElérésSzöveg Nothing =
  "nem érte el " ++ show generációkSzáma ++ " generáció alatt"

||| Egy állomás SORÁnak kiírása: sorszám | legjobb fitness | cél? |
||| hő eddig (J) | a népesség útvégpont-jai (gyokSzimbolum-formában).
állomástÍr : Nat -> GenerációsÁllapot -> IO ()
állomástÍr sorszám st =
  putStrLn
    ( "   " ++ show sorszám ++ ". generáció"
      ++ " | legjobb fitness: " ++ show (legjobbPontszám st)
      ++ " | cél: " ++ igenNem (célElérveE (népesség st))
      ++ " | hő eddig: " ++ show (felhalmozottHő st) ++ " J"
      ++ " | útvégpontok: "
      ++ concat (intersperse ", "
           (map (gyokSzimbolum . útVége) (népesség st))) )

||| Egy teljes futás kiírása (a sorszám a rekurzió paramétere).
futástÍr : Nat -> List GenerációsÁllapot -> IO ()
futástÍr _ [] = pure ()
futástÍr sorszám (st :: többi) = do
  állomástÍr sorszám st
  futástÍr (S sorszám) többi

-- ===============================================================
-- 9. A MAIN — A DEMO FUTATSA ÉS AZ ÖSSZEHASONLÍTÓ TÁBLÁZAT (GAUGE)
--    main — the demo run and the comparison table
--    主函数——演示运行与对照表 · Hauptprogramm — der Vergleich
-- ===============================================================

main : IO ()
main = do
  putStrLn "═══ EVOLUTÍVKERESŐ v2 — Carnot-hajtás vs. klasszikus evolúció ═══"
  putStrLn ""
  putStrLn "-- 1. A keresési feladat (mind IMPORTÁLT konstans, §24):"
  putStrLn ("   kezdő gyök: " ++ gyokSzimbolum KezdőGyök
    ++ "   (= PéldaEgészSzó jele, a típus-1 lista feje)")
  putStrLn ("   cél gyök:   " ++ gyokSzimbolum CélGyök
    ++ "   (= gyokEllentett (PéldaFélEgészSzó jele), azaz −(1⁸))")
  putStrLn ("   mutációs tengelyek: "
    ++ concat (intersperse ", " (map gyokSzimbolum TengelyGyökök)))
  putStrLn ("   populáció-méret: " ++ show PopulációMéret
    ++ " | lépésbüntetés: " ++ show lépésBüntetés
    ++ " | futtatott generációk: " ++ show generációkSzáma)
  putStrLn ("   Landauer-küszöb 300 K-en (IMPORTÁLT): "
    ++ show (landauerKüszöb 300.0) ++ " J/bit")
  putStrLn ("   törölt bit kiesőnként: log₂ " ++ show PopulációMéret
    ++ " ≈ " ++ show (log (cast PopulációMéret) / log 2.0) ++ " bit")
  putStrLn ""
  putStrLn "-- 2. Fordítási idejű bizonyítások (§18 — két út, egy híd):"
  putStrLn "   bizMéretMegmarad:            Refl ✓  [a négyfázis-lánc után is 6 út]"
  putStrLn "   bizMéretMegmaradKlasszikus:  Refl ✓  [a fúzionált lánc után is 6 út]"
  putStrLn "   bizMutációZártPélda:         Refl ✓  [σ_(1⁸)(2,2,0⁶) benne van a 240-ben]"
  putStrLn "   bizMegtaláltÚtVégeACél:      Refl ✓  [a rekonstruált út vége = cél, AzonosJel]"
  putStrLn ("   mutációs zártsági hibák (4 × 240 = 960 reflexió): "
    ++ show mutációsZártságiHibákSzáma ++ "   (várható: 0)")
  putStrLn ""
  putStrLn "-- 3. A-VARIÁNS — CARNOT-HAJTÁSÚ futás (a négy ütem óránként):"
  putStrLn ("   első cél-elérés: " ++ célElérésSzöveg (elsőCélElérés carnotFutás))
  futástÍr 0 carnotFutás
  putStrLn ("   ÖSSZ-KÖLTSÉG (kumulált Landauer-hő): "
    ++ show (felhalmozottHő (utolsóÁllomás carnotFutás)) ++ " J")
  putStrLn ""
  putStrLn "-- 4. B-VARIÁNS — klasszikus evolúciós futás (fúzionált lépések):"
  putStrLn ("   első cél-elérés: " ++ célElérésSzöveg (elsőCélElérés klasszikusFutás))
  futástÍr 0 klasszikusFutás
  putStrLn ("   ÖSSZ-KÖLTSÉG (nincs könyvelés): "
    ++ show (felhalmozottHő (utolsóÁllomás klasszikusFutás)) ++ " J")
  putStrLn ""
  putStrLn "-- 5. ÖSSZEHASONLÍTÓ TÁBLÁZAT:"
  putStrLn "   ┌───────────────────────┬─────────────────────────────┬──────────────────────────────┐"
  putStrLn "   │ mutató                │ A: Carnot-hajtás            │ B: klasszikus evolúció       │"
  putStrLn "   ├───────────────────────┼─────────────────────────────┼──────────────────────────────┤"
  putStrLn ("   │ cél elérve            │ "
    ++ igenNem (célElérveE (népesség (utolsóÁllomás carnotFutás)))
    ++ " — " ++ célElérésSzöveg (elsőCélElérés carnotFutás))
  putStrLn ("   │                       │ "
    ++ igenNem (célElérveE (népesség (utolsóÁllomás klasszikusFutás)))
    ++ " — " ++ célElérésSzöveg (elsőCélElérés klasszikusFutás))
  putStrLn ("   │ futtatott generációk  │ "
    ++ show generációkSzáma ++ "                           │ "
    ++ show generációkSzáma)
  putStrLn ("   │ össz-Landauer-költség │ "
    ++ show (felhalmozottHő (utolsóÁllomás carnotFutás)) ++ " J  │ 0.0 J (nincs könyvelés)")
  putStrLn ("   │ legjobb végső fitness │ "
    ++ show (legjobbPontszám (utolsóÁllomás carnotFutás))
    ++ "                  │ "
    ++ show (legjobbPontszám (utolsóÁllomás klasszikusFutás)))
  putStrLn ("   │ Carnot-ütemek         │ "
    ++ show (4 * generációkSzáma) ++ "                           │ 0 (fúzionált lépések)")
  putStrLn "   └───────────────────────┴─────────────────────────────┴──────────────────────────────┘"
  putStrLn ""
  putStrLn "-- 6. ÉRTELMEZÉS (őszintén, §18):"
  putStrLn "   • A két variáns populáció-mechanikája AZONOS (ugyanaz a kiterjesztés,"
  putStrLn "     fitness, szelekció) — ezért ugyanannyi generációban ér célt."
  putStrLn "   • A különbség a KÖNYVELÉS és az ÓRAJEL: az A-variáns minden szelekciónál"
  putStrLn "     könyveli az irreverzibilis törlés fizikai alsó korlátját (Landauer),"
  putStrLn "     és a Carnot-négyütem adja a driftmentes generációs órajelet;"
  putStrLn "     a B-variáns ugyanezt a költséget NEM tünteti fel (de a fizikában"
  putStrLn "     felmerül — a könyvelés eltünteti, nem megszünteti)."
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
