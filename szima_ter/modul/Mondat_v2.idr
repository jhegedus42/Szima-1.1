module Mondat_v2

-- ═══════════════════════════════════════════════════════════════
-- MONDAT v2 — a v1 MEGGYÓGYÍTVA: az import-lánc átirányítva
-- SENTENCE v2 · 句子 v2 · SATZ v2 · משפט v2
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v2? (§13: a javítás ÚJ FÁJL — a Mondat_v1.idr ÉRINTETLEN.)
--   A v1 SAJÁT magában nem hibás — a Hullam_3 build (2026-09-05) az
--   IMPORT-LÁNCON át bukott: Mondat_v1 → FazisAlgebra_v2, ami NEM
--   fordul («Undefined name azonosFazis — Did you mean: azonosFázis?»,
--   «Undefined name Irany», «No type declaration for
--   FazisAlgebra_v2.töltésParitásIdőIrány» — a v2 ékezet nélküli
--   neveket hívott, pedig a szima_ter világ ékezetes). A FazisAlgebra_v3
--   (2026-09-04) LÉTEZIK és TISZTA — ez a v2 az importot RÁIRÁNYÍTJA.
--
-- A LÁNC-ÁTIRÁNYÍTÁS RÉSZLETEI (a v1-hez képest CSAK ezek változnak):
--   1. `import FazisAlgebra_v2` → `import FazisAlgebra_v3`.
--   2. `idoFazisba` → `időFázisba`: a szima_ter/modul/HaromKubit.idr
--      (100.01-es generáció) ÉKEZETES neveket visel (időFázisba,
--      VilágKonstruktor) — a v1 csupasz `idoFazisba`-ja itt nem él.
--   3. A FazisAlgebra_v3 ToltesParitasIdo-mezői a FAZISALGEBRA_V3 SAJÁT
--      HaromKubit-rekordját várják (mezők: saját/másik/fázis :
--      Steane713.Kubit) — nem a HaromKubit-modul azonos alakját. A
--      kettő NOMINÁLISAN KÜLÖNBÖZŐ (trap: «Mismatch between: Kubit and
--      Kubit» család) — ezért a bélyegTöltésParitásIdőre HIDAT épít:
--      a HaromKubit-modul időFázisba-képét mezőiProjectsziójakkal
--      szedi szét, és a FazisAlgebra_v3.VilágKonstruktorral építi újra
--      (MINŐSÍTVE: a `VilágKonstruktor` nevet MINDKÉT modul exportálja —
--      a minősítés nélküli név kétértelmű lenne, csapda #24b).
--   4. Minden más (a CPTBélyeg-rekord, a 27 bélyeg enumerációja, a
--      Eq/Show instance-ok, mind az öt Refl-tanú, a különbözőség-mérés,
--      a main) SZÓ SZERINT a v1 tartalma — a bizonyítások ugyanazok.
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS):
--   | 代码重复禁止——必须导入，不得重写！ | Codeduplikation VERBOTEN! |
--   A Mondat és a mondatVégpont a SzintaxisMorfizmus_v1-ben ÉL — ez a
--   modul NEM újraírja, hanem IMPORTÁLJA és KIBŐVÍTI (CímkézettMondat
--   = importált Mondat + CPT-bélyeg). A három igei dimenzium típusai
--   (IgeIdo, IgeSzem, Forras, IdoBeljegyzes) a Steane713-ban élnek; a
--   ToltesParitasIdo és a fazisFaktorialis a FazisAlgebra_v3-ban; az
--   időFázisba híd a HaromKubit-ban; a jelentésTávolság a GyokSzo_v1-ben;
--   a példamondat (RövidMondatKonst) a SzintaxisMorfizmus_v1-ben.
--   SEMMI nincs újraírva ide.
-- §18 (KÉT FÜGGETLEN ÚT, EGY HÍD):
--   a bélyegszámlálás ENUMERÁCIÓ (a felépített 27-es lista hossza)
--   ⟷ SZORZAT (3×3×3) hídjával; a végpont-bizonyítás a CímkézettMondat-
--   projekción át vezető TÜKRÖZÉS-KIFEJTÉS (két W(E8)-tükrözés, D8-
--   pályaváltással) ⟷ a teljes kiírt fogalom-KONSTANS hídjával; a
--   távolság-bizonyítás a jelentésTávolság-kiszámítás ⟷ az ötszintű
--   skála konstansa hídjával. Nincs X = X.
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- ═══════════════════════════════════════════════════════════════

import SzintaxisMorfizmus_v1      -- Mondat, mondatVégpont, RövidMondatKonst (§24 — NEM újraírva!)
import Fogalom_v1                 -- Fogalom, gyökSzó, pálya, Példa*Fogalom (§24)
import GyokSzo_v1                 -- GyökSzó, jel, jelentésTávolság, Példa*Szó (§24)
import E8Gyokok_v2                -- E8GyokKonstruktor (§24 — KÖZVETLEN: a Refl-típushoz)
import E8BelsoSzorzat             -- belsoszorzat (§24 — KÖZVETLEN: where-lánc-transzparencia)
import Kategoriak.MagyarOntologia -- IndividuumJK (§24 — KÖZVETLEN, a Refl-típushoz)
import Steane713                  -- IgeIdo, IgeSzem, Forras, IdoBeljegyzes (§24)
import HaromKubit                 -- időFázisba (§24 — a szima_ter generáció ÉKEZETES neve)
import FazisAlgebra_v3            -- ToltesParitasIdo, ToltesParitasIdoKonstruktor,
                                  -- fazisFaktorialis, VilágKonstruktor (§24 — a v2 TÖRÖTT
                                  -- volt: ékezet nélküli neveket hívott; a v3 TISZTA)
import Data.List                  -- length, nub (§24: standard, nem újraírva)

%default covering

-- ===============================================================
-- 1. A CPT-BÉLYEG — A MONDAT IDŐRÉTEGE (terv §4.1)
--    The CPT stamp — the sentence's time layer
--    CPT 印章——句子的时间层 · Der CPT-Stempel — die Zeitschicht
--    חותמת CPT — שכבת הזמן של המשפט
-- ===============================================================

||| A CPT-BÉLYEG: a mondat időrétegének bélyege — a magyar ige
||| ragozásának három dimenziója (AGENTS §9 nyelvtani rétege):
|||   töltés  (C) = Forrás    — honnan tudom? (közvetlen/következtetett/jelentett)
|||   paritás (P) = Szemlélet — hogyan látom?  (folyamatos/befejezett/szokásos)
|||   idő     (T) = Igeidő   — mikor?         (múlt/jelen/jövő)
||| A három dimenzió típusai IMPORTÁLVA élnek a Steane713-ban (§24);
||| ez a rekord CSAKOLJA őket egy időbélyeggé: 3×3×3 = 27 kombináció.
||| A mezőnevek a FazisAlgebra ToltesParitasIdo mezőinek (töltés,
||| paritás, idő) ékezetes alakját követik (§25) — a két réteget a
||| 3. szakasz homomorfizmusa köti össze.
||| CPT 印章：匈牙利语动词三个维度（证据/体/时）的封缄——27 种组合。
public export
record CPTBélyeg where
  constructor CPTBélyegKonstruktor
  töltés  : Forras   -- C — a bizonyítás forrása: honnan tudom?
  paritás : IgeSzem  -- P — a szemlélet módja: hogyan látom?
  idő     : IgeIdo   -- T — az igeideje: mikor?

||| Az igei dimenziók egyenlősége (a nub-különbözőségi ellenőrzéshez;
||| új instance-ok IMPORTÁLT típusokra — a Steane713-ban nincs ilyen,
||| nem duplikáció; a minta: Eq SzóOsztály a GyokSzo_v1-ből).
public export
Eq IgeIdo where
  (==) Mult  Mult  = True
  (==) Jelen Jelen = True
  (==) Jovo  Jovo  = True
  (==) _ _ = False

public export
Eq IgeSzem where
  (==) Folyamatos Folyamatos = True
  (==) Befejezett Befejezett = True
  (==) Szokasos   Szokasos   = True
  (==) _ _ = False

public export
Eq Forras where
  (==) Kozvetlen      Kozvetlen      = True
  (==) Kovetkeztetett Kovetkeztetett = True
  (==) Jelentett      Jelentett      = True
  (==) _ _ = False

||| Két bélyeg egyenlősége (a futásidejű különbözőségi ellenőrzéshez).
public export
Eq CPTBélyeg where
  (==) (CPTBélyegKonstruktor töltésEgy paritásEgy időEgy)
       (CPTBélyegKonstruktor töltésKettő paritásKettő időKettő) =
    töltésEgy == töltésKettő && paritásEgy == paritásKettő && időEgy == időKettő

||| Az igei dimenziók megjelenítése — a bélyeg kiírásához (új instance
||| IMPORTÁLT típusra; a Steane713-ban nincs ilyen — nem duplikáció).
public export
Show IgeIdo where
  show Mult   = "múlt"
  show Jelen  = "jelen"
  show Jovo   = "jövő"

public export
Show IgeSzem where
  show Folyamatos  = "folyamatos"
  show Befejezett  = "befejezett"
  show Szokasos    = "szokásos"

public export
Show Forras where
  show Kozvetlen      = "közvetlen (látom)"
  show Kovetkeztetett = "következtetett (látszik)"
  show Jelentett      = "jelentett (állítólag)"

||| A bélyeg megjelenítése — a három dimenzióval.
public export
Show CPTBélyeg where
  show bélyeg =
    "CPT-bélyeg ‹töltés: " ++ show bélyeg.töltés
      ++ "; paritás: " ++ show bélyeg.paritás
      ++ "; idő: " ++ show bélyeg.idő ++ "›"

-- ===============================================================
-- 2. A 27 BÉLYEG — ENUMERÁCIÓ (terv §5.4: „3*3*3 = 27 Refl")
--    The 27 stamps — enumeration · 27 个印章——枚举
--    Die 27 Stempel — Aufzählung · 27 החותמות — מנייה
-- ===============================================================

||| A három igeidő (IMPORTÁLT konstruktorokkal — §24).
public export
igeidők : List IgeIdo
igeidők = [Mult, Jelen, Jovo]

||| A három szemlélet.
public export
szemléletek : List IgeSzem
szemléletek = [Folyamatos, Befejezett, Szokasos]

||| A három forrás (evidenciális fokozat).
public export
források : List Forras
források = [Kozvetlen, Kovetkeztetett, Jelentett]

||| A NYELV 27 CPT-BÉLYEGE: a három dimenzió teljes enumerációja
||| (lista-konstans a kályha-minta szerint — NEM let-lánc, l. LetLáncProbe).
public export
cptBélyegek : List CPTBélyeg
cptBélyegek =
  [ CPTBélyegKonstruktor forrás szemlélet igeidő
  | igeidő <- igeidők, szemlélet <- szemléletek, forrás <- források ]

||| Nagybetűs konstans a bizonyítás-típusokhoz (KisBetűsProjekcióCsapda).
public export
CPTBélyegekKonst : List CPTBélyeg
CPTBélyegekKonst = cptBélyegek

-- ===============================================================
-- 3. RÉTEGHIDAK — NYELVTANI ⟷ PSZICHOFIZIKAI (AGENTS §9)
--    Layer bridges · 层间桥 · Schichten-Brücken · גשרי שכבות
-- ===============================================================

||| A bélyeg NYELVTANI megtestesítése: az IMPORTÁLT IdoBeljegyzes
||| (Steane713 — §24) ugyanazzal a három dimenzióval.
public export
bélyegIdőBejegyzésre : CPTBélyeg -> IdoBeljegyzes
bélyegIdőBejegyzésre bélyeg =
  IdoBeljegyzesKonstruktor bélyeg.idő bélyeg.paritás bélyeg.töltés

||| A bélyeg PSZICHOFIZIKAI megtestesítése: az IMPORTÁLT ToltesParitasIdo
||| (FazisAlgebra_v3 — §24) az IMPORTÁLT időFázisba híd (HaromKubit) képén
||| át. A leképezés HOMOMORFIZMUS, nem izomorfizmus (AGENTS §9): a
||| nyelvtani réteg 27 pontja a pszichofizikai réteg DIAGONÁLISÁRA képez
||| le — mindhárom C/P/T helyre ugyanaz az időFázisba-kép kerül. A
||| diagonális koherenciáját a futásidejű fázistényező méri (alább).
||| A HÍD KÉT LÉPÉSE (a két HaromKubit-rekord nominálisan különbözik —
||| l. a fejléc 3. pontját): (a) a HaromKubit-modul időFázisba-képét a
||| SAJÁT mező-projekcióival szedjük széle (a pont-szintaxis a TÍPUS
||| alapján oldja fel a mezőnevet); (b) a FazisAlgebra_v3.VilágKonstruktorral
||| építjük újra — MINŐSÍTVE, mert a `VilágKonstruktor` nevet a HaromKubit
||| modul IS exportálja (kétértelműség — csapda #24b).
||| 层间同态（非同构）：语法层的 27 点映到对角线上；两座桥接两record。
public export
bélyegTöltésParitásIdőre : CPTBélyeg -> ToltesParitasIdo
bélyegTöltésParitásIdőre bélyeg =
  let kubithármas = időFázisba (bélyegIdőBejegyzésre bélyeg)
  in ToltesParitasIdoKonstruktor
       (FazisAlgebra_v3.VilágKonstruktor kubithármas.saját kubithármas.másik kubithármas.fázis)
       (FazisAlgebra_v3.VilágKonstruktor kubithármas.saját kubithármas.másik kubithármas.fázis)
       (FazisAlgebra_v3.VilágKonstruktor kubithármas.saját kubithármas.másik kubithármas.fázis)

||| A bélyeg FÁZISTÉNYEZŐJE: az IMPORTÁLT fazisFaktorialis
||| (FazisAlgebra_v3 — §24) a diagonális beágyazáson. Értéke 1.0, ha a
||| három időFázisba-kép páronként azonos fázisú (a diagonális
||| koherenciája — futásidejű Show-ellenőrzés a main-ben; a
||| Double-egyenlőség NEM Refl-tárgy, l. a Komplex.idr oda-vissza
||| teszt mintája).
public export
fázistényező : CPTBélyeg -> Double
fázistényező bélyeg = fazisFaktorialis (bélyegTöltésParitásIdőre bélyeg)

-- ===============================================================
-- 4. A CÍMKÉZETT MONDAT — IMPORTÁLT MONDAT + BÉLYEG (§24: NEM újraírás)
--    The labeled sentence — IMPORTED sentence + stamp
--    带标句子——导入的句子 + 印章 · Der etikettierte Satz · משפט מתויג
-- ===============================================================

||| A CÍMKÉZETT MONDAT: az IMPORTÁLT Mondat (SzintaxisMorfizmus_v1 —
||| §24, a láncolt kompozíció: β₀ →ᵅ¹ β₁ → … →ᵅⁿ βₙ) CSAKOLVA egy
||| CPT-bélyeggel. A terv §5.4 „Mondat" rekordjának kibővített alakja:
||| a lánc típusa NEM duplikálódik — a bélyeg ráaggatásra kerül.
public export
record CímkézettMondat where
  constructor CímkézettMondatKonstruktor
  mondat : Mondat     -- az importált lánc (kezdőFogalom + tükrözésSor)
  bélyeg : CPTBélyeg  -- a mondat időrétege (a 27 kombináció egyike)

||| A címkézett mondat megjelenítése — az importált Show Mondattal
||| (a lánc és a végpont) és a bélyeggel.
public export
Show CímkézettMondat where
  show címkézett =
    "CímkézettMondat ‹" ++ show címkézett.mondat
      ++ " + " ++ show címkézett.bélyeg ++ "›"

-- ===============================================================
-- 5. A VÉGPONT CPT-MUTATÓJA (a feladat magja)
--    The endpoint's CPT pointer · 终点的 CPT 指针
--    Der CPT-Zeiger des Endpunkts · מצביע ה-CPT של נקודת הקצה
-- ===============================================================

||| A VÉGPONT CPT-MUTATÓJA: a mondat végpontfogalma, annak D8-pályája
||| (a fogalom mondatbeli ÁLLAPOTA — a SzintaxisMorfizmus_v1 kutatási
||| indoklása szerint a W(E8)-tükrözés átléphet a két pálya közt) és a
||| mondat CPT-bélyege EGY szerkezetben — a végpont helye a pálya×bélyeg
||| térben. A pálya NEM a rekordból másolódik: a végpontfogalomból
||| ÚJRASZÁMOLÓDIK (a pálya-mező projekciója).
public export
record VégpontCPTMutató where
  constructor VégpontCPTMutatóKonstruktor
  végpontFogalom : Fogalom   -- a lánc végpontja (mondatVégpont — importált)
  végpontPálya   : D8Pálya   -- a végpont pályája (újraszámolva a fogalomból)
  végpontBélyeg  : CPTBélyeg -- a mondat időrétege

||| A mutató kiszámítása: az IMPORTÁLT mondatVégpont (§24) futtatása a
||| címkézett mondat láncán, a pálya projekciója és a bélyeg átvétele.
public export
végpontCPTMutató : CímkézettMondat -> VégpontCPTMutató
végpontCPTMutató címkézett =
  VégpontCPTMutatóKonstruktor (mondatVégpont címkézett.mondat)
                               (pálya (mondatVégpont címkézett.mondat))
                               címkézett.bélyeg

||| A mutató megjelenítése — végpont, pálya, bélyeg egyben.
public export
Show VégpontCPTMutató where
  show mutató =
    "VégpontCPTMutató ‹végpont: " ++ show mutató.végpontFogalom
      ++ "; pálya: " ++ show mutató.végpontPálya
      ++ "; bélyeg: " ++ show mutató.végpontBélyeg ++ "›"

-- ─── 5a. Példakonstansok (nagybetűs — KisBetűsProjekcióCsapda) ──

||| A példabélyeg: jelen idejű, befejezett szemléletű, közvetlen
||| forrású — mint a „látom, hogy felépült a ház" (látom = közvetlen
||| evidencia; felépült = befejezett szemlélet; jelen = az igeideje).
public export
PéldaBélyegKonst : CPTBélyeg
PéldaBélyegKonst = CPTBélyegKonstruktor Kozvetlen Befejezett Jelen

||| A példamondat-bélyeg páros: az IMPORTÁLT RövidMondatKonst
||| (SzintaxisMorfizmus_v1 — §24: (2,2,0⁶) →σ(1⁸)→ (1,1,−1⁶) →σ(2,2)→
||| (−1)⁸, kétszeres D8-pályaváltással) a példabélyeggel megcímkézve.
public export
CímkézettPéldaKonst : CímkézettMondat
CímkézettPéldaKonst = CímkézettMondatKonstruktor RövidMondatKonst PéldaBélyegKonst

-- ===============================================================
-- 6. BIZONYÍTÁSOK — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Proofs — two independent paths, one bridge
--    证明——两条独立道路，一座桥 · Beweise — zwei Wege, eine Brücke
-- ===============================================================

-- ─── 6a. A bélyegek száma: enumeráció ⟷ szorzat ──────────────────
--    (a) út: a kernel a FELÉPÍTETT lista hosszát számolja (a három
--    3-es listán átmenő teljes enumeráció); (b) út: a SZORZAT 3×3×3.
--    A híd kényszeríti, hogy a kettő ugyanarra a 27-re fusson.

-- Kimenet: Refl — az enumeráció: a felépített bélyeglista hossza 27.
public export
bizBélyegekSzáma : length CPTBélyegekKonst = 27
bizBélyegekSzáma = Refl

-- Kimenet: Refl — A HÍD (§18): a bal oldal a SZORZAT (3×3×3 — a három
-- dimenzió függetlenségének kombinatorikája), a jobb oldal az
-- ENUMERÁCIÓ (a kernel a felépített lista hosszát számolja ki).
public export
bizBélyegHíd : 3 * 3 * 3 = length CPTBélyegekKonst
bizBélyegHíd = Refl

-- ─── 6b. A végpont: tükrözés-kifejtés ⟷ konstans ─────────────────
--    A bal oldal a CímkézettMondat-PROJEKCIÓN át vezető lánc-kifejtés
--    (rekord-mező → mondatVégpont → foldl → két weylReflexio →
--    szóOsztályMeghatároz 112-elemes kereséssel → pályaOsztályból),
--    a jobb oldal a teljes kiírt fogalom-KONSTANS (az enumerált (−1)⁸
--    gyök — a tipus2Gyokok egy tagja). Két fogalmilag különböző
--    konstrukció — egy kényszerített találkozás.

-- Kimenet: Refl — a címkézett példamondat végpontja (−1)⁸, fél-egész
-- pályán, a kezdő fogalom kategóriájával (egyed) — a lánc kétszer
-- váltott D8-pályát, a kategória megmaradt.
public export
bizCímkézettVégpont :
  mondatVégpont (mondat CímkézettPéldaKonst) =
    FogalomKonstruktor
      (GyökSzóKonstruktor (E8GyokKonstruktor (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)) FélEgészGyökSzó)
      FélEgészGyökPálya
      IndividuumJK
bizCímkézettVégpont = Refl

-- Kimenet: Refl — a végpont CPT-mutatójának PÁLYA-mezője: a bal oldal
-- a mutató-projekció → mondatVégpont → pálya-újraszámolás útja, a jobb
-- oldal a D8-osztály-konstans (a végpont a fél-egész pályán áll).
public export
bizVégpontPályaMutató :
  végpontPálya (végpontCPTMutató CímkézettPéldaKonst) = FélEgészGyökPálya
bizVégpontPályaMutató = Refl

-- ─── 6c. A végpont távolsága: kiszámítás ⟷ ötszintű konstans ────
--    A bal oldal a jelentésTávolság-kiszámítás (burkolat-projekció →
--    IMPORTÁLT belsoszorzat: (−1)⁸·(1⁸) = −8 → ötszintű osztályozás),
--    a jobb oldal a HasonlóságÖtSzint konstruktora.

-- Kimenet: Refl — a végpont szava és a (1⁸) szó ELLENTETT jelei
-- egymásnak: ⟨(−1)⁸,(1⁸)⟩ = −8 → −1 az ötszintű skálán.
public export
bizVégpontTávolság :
  jelentésTávolság (gyökSzó (végpontFogalom (végpontCPTMutató CímkézettPéldaKonst))) PéldaFélEgészSzó
    = Ellentett
bizVégpontTávolság = Refl

-- ===============================================================
-- 7. FUTÁSIDEJŰ KIMERÍTŐ ELLENŐRZÉSEK (GAUGE-elv)
--    Exhaustive runtime checks · 运行时穷举检查
--    Erschöpfende Laufzeitprüfungen · בדיקות ממצות בזמן ריצה
-- ===============================================================

||| A 27 bélyeg KÜLÖNBÖZŐSÉGE: a nub (Data.List — §24) után is 27
||| marad-e (nincs duplikátum az enumerációban). Várt: 27.
public export
különbözőBélyegekSzáma : Nat
különbözőBélyegekSzáma = length (nub CPTBélyegekKonst)

-- ===============================================================
-- 8. A MAIN — MONDAT FELÉPÍTÉSE, BÉLYEG RÁAGGATÁSA, VÉGPONT KIÍRÁSA
--    main — build a sentence, attach the stamp, print the endpoint
--    主函数——构建句子、加盖印章、输出终点 · Hauptprogramm
-- ===============================================================

main : IO ()
main = do
  putStrLn "═══ MONDAT v2 — CímkézettMondat + CPT-bélyeg (W8, terv §4.1 + §5.4) ═══"
  putStrLn ""
  putStrLn "-- 1. A CPT-bélyegek (IMPORTÁLT Steane713-dimenziókból, §24):"
  putStrLn ("   CPT-bélyegek száma (enumeráció):        "
    ++ show (List.length CPTBélyegekKonst) ++ "   (várható: 27; Refl: bizBélyegekSzáma)")
  putStrLn ("   szorzat-úton: 3×3×3 = 27               "
    ++ "   [Refl-híd: bizBélyegHíd — enumeráció ⟷ szorzat]")
  putStrLn ("   különböző bélyegek (nub):              "
    ++ show különbözőBélyegekSzáma ++ "   (várható: 27 — nincs duplikátum)")
  putStrLn ""
  putStrLn "-- 2. A példabélyeg (jelen + befejezett + közvetlen):"
  putStrLn ("   " ++ show PéldaBélyegKonst
    ++ "   [mint: „látom, hogy felépült a ház\"]")
  putStrLn ("   fázistényező a diagonálon:             "
    ++ show (fázistényező PéldaBélyegKonst)
    ++ "   (várható: 1.0 — az IMPORTÁLT fazisFaktorialis szerint a diagonális koherens)")
  putStrLn ""
  putStrLn "-- 3. A címkézett mondat (IMPORTÁLT RövidMondatKonst + bélyeg, §24):"
  putStrLn ("   " ++ show CímkézettPéldaKonst)
  putStrLn "   A lánc: (2,2,0⁶) →σ(1⁸)→ (1,1,−1⁶) →σ(2,2)→ (−1)⁸   [kétszeres D8-pályaváltás]"
  putStrLn ""
  putStrLn "-- 4. A végpont CPT-mutatója (végpont + pálya + bélyeg):"
  putStrLn ("   " ++ show (végpontCPTMutató CímkézettPéldaKonst))
  putStrLn ("   végpont pályája: " ++ show (végpontPálya (végpontCPTMutató CímkézettPéldaKonst))
    ++ "   [Refl: bizVégpontPályaMutató; a kategória (egyed) megmaradt]")
  putStrLn ""
  putStrLn "-- 5. Távolság-ellenőrzések (IMPORTÁLT jelentésTávolság, §24):"
  putStrLn ("   végpontszó ↔ (1⁸):        "
    ++ show (jelentésTávolság (gyökSzó (végpontFogalom (végpontCPTMutató CímkézettPéldaKonst))) PéldaFélEgészSzó)
    ++ "   [⟨·⟩ = −8, Refl: bizVégpontTávolság]")
  putStrLn ("   végpontszó ↔ (2,2,0⁶):    "
    ++ show (jelentésTávolság (gyökSzó (végpontFogalom (végpontCPTMutató CímkézettPéldaKonst))) PéldaEgészSzó)
    ++ "   [⟨·⟩ = −4 — ellentétes rokon]")
  putStrLn ("   végpontszó ↔ önmaga:      "
    ++ show (jelentésTávolság (gyökSzó (végpontFogalom (végpontCPTMutató CímkézettPéldaKonst)))
                       (gyökSzó (végpontFogalom (végpontCPTMutató CímkézettPéldaKonst))))
    ++ "   [⟨·⟩ = +8 — azonos jel]")
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
