module EvolutivKereso_v1

-- ═══════════════════════════════════════════════════════════════
-- EVOLUTÍVKERESŐ v1 — CARNOT-hajtású vs. evolúciós-hajtású kereső
-- EVOLUTIONARY SEARCHER v1 · 演化搜索器 v1 · Evolutionärer Sucher v1
-- · מחפש אבולוציוני v1
-- ═══════════════════════════════════════════════════════════════
--
-- A FELADAT (docs/EvoluciosAlgoritmusok_Tanulas.md §5.8 vázlata):
--   Kis keresési demó a gyökrácson: KEZDŐ gyök → CÉL gyök. A populáció
--   út-jelöltek (gyökök láncolata); a fitness a céltól mért
--   jelentésTávolság-alapú pontszám + lépésszám-büntetés.
--   Két variáns:
--   A) CARNOT-HAJTÁS: a generációt a Carnot-négy-lépés ütemezi
--      (izoterma tágulás = EXPANZIÓ; adiabata lehűlés = KIÉRTÉKELÉS;
--       izoterma sűrítés = SZELEKCIÓ, ára landauerKüszöb · törölt bit;
--       adiabata melegítés = PIHENŐ). A hő KUMULÁLÓDIK (J összesen).
--   B) KLASSZIKUS EVOLÚCIÓS: ugyanaz a populáció és fitness, DE a
--      szelekció NEM Landauer-árazott, a hurok NEM ciklus-ütemű.
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS): MINDEN művelet IMPORT.
--   | 代码重复禁止——必须导入，不得重写！ | Codeduplikation VERBOTEN! |
--   weylReflexio, gyokEllentett, Eq E8Gyok (E8BelsoSzorzat);
--   e8Gyokok, gyokSzimbolum (E8Gyokok_v2);
--   GyökSzó, GyökSzóKonstruktor, jel, szóOsztályMeghatároz,
--   jelentésTávolság, HasonlóságÖtSzint, Példa*-konstansok
--   (GyokSzo_v1); CarnotÁllapot, állapotLépése, landauerKüszöb
--   (CarnotCiklus_v1); length, take, sortBy, map, filter, elem, any,
--   foldl, iterateN, intersperse, concatMap, replicate, ++
--   (Data.List / Prelude — standard, §24).
--   SEMMI nincs újraírva ide. Az egyetlen ÚJ sor a fitness-pont
--   leképezése (jelPontszáma) és a könyvelési képlet — ezek a demó
--   SAJÁTjai, sehol sem léteznek a projektben (grep 2026-08-25).
-- §18 (ŐSZINTE VERIFIKÁCIÓ): a Refl-célok két független utat kötnek:
--   a méretmegmaradás a KITERJESZTÉS→RENDEZÉS→KIVÁLASZTÁS láncot
--   futtatja le a kernellel (nem X = X); a megtalált-út-bizonyítás
--   a futásban felfedezett utat konstruktorosan újjáépíti, és a két
--   út az AzonosJel-osztályozásnál találkozik. A fitness (Double)
--   ellenőrzése FUTÁSIDEJŰ GAUGE, NEM Refl-tárgy.
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
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
public export
útVége : ÚtJelölt -> E8Gyok
útVége útvonal = foldl (\_, gyök => gyök) KezdőGyök útvonal

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
public export
útLépéseinekSzáma : ÚtJelölt -> Nat
útLépéseinekSzáma útvonal = minus (length útvonal) 1

||| A FITNESS: a végpont céltól mért jelentéspontja MÍNUSZ a
||| lépésszám-büntetés. (Double — ellenőrzése futásidejű GAUGE,
||| a Double-egyenlőség NEM Refl-tárgy, §18.)
public export
fitnesz : ÚtJelölt -> Double
fitnesz útvonal =
  jelPontszáma (jelentésTávolság (szóváEmel (útVége útvonal)) Célszó)
    - lépésBüntetés * cast (útLépéseinekSzáma útvonal)

||| A populáció LEGJOBB fitness-e (a kiértékelő ütem írja be az
||| állapotba; az alsó „padló" −999.0 lehetetlen érték).
public export
legjobbFitnesz : Populáció -> Double
legjobbFitnesz népességLista =
  foldl (\eddig, útvonal => max eddig (fitnesz útvonal)) (-999.0) népességLista

||| Az ötszintű skála AZONOSJEL-próbája (a cél-elérés detektora:
||| egység-normájú gyököknél a ⟨α,β⟩ = +8 pontosan az azonosság).
public export
azonosJelE : HasonlóságÖtSzint -> Bool
azonosJelE AzonosJel = True
azonosJelE _         = False

||| Egy út eléri-e a célt (a végpont AzonosJel-e a célszóval).
public export
útElériACélt : ÚtJelölt -> Bool
útElériACélt útvonal =
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
public export
kiterjeszt : ÚtJelölt -> List ÚtJelölt
kiterjeszt útvonal =
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

||| A SZELEKCIÓ: fitness-szerinti rendezés + az első PopulációMéret
||| megtartása (csonkolás — terv §1.1/3; Data.List.sortBy stabil,
||| ezért kötéseknél determinisztikus).
public export
szelektál : Populáció -> Populáció
szelektál jelöltek = take PopulációMéret (sortBy fitneszSorrend jelöltek)

||| A TÖRÖLT BITEK száma: kieső egyedenként log₂ N bit (az „melyik
||| maradjon" döntés információtartalma — terv §4.1/§5.5 képlete);
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
-- számolja a sortBy-hívást és a take-ot. Nem X = X: a lánc bármely
-- átírása (pl. rossz szelekciós méret) automatikusan eltöri.
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
-- (σ_(1⁸)(2,2,0⁶)) eredménye gyök — a kernel az elem-keresést a
-- 240-es listán végigszámolja (a BizTukrozés*-család mintájára).
public export
bizMutációZártPélda :
  elem (weylReflexio (jel PéldaFélEgészSzó) KezdőGyök) e8Gyokok = True
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
-- belső szorzatot ((−1)⁸·(−1)⁸ = +8) végigszámolja.
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
  putStrLn "═══ EVOLUTÍVKERESŐ v1 — Carnot-hajtás vs. klasszikus evolúció ═══"
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
