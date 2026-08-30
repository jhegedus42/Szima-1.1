module KonyvAdat_E8Gyokrendszer_v1

-- ═══════════════════════════════════════════════════════════════
-- KÖNYV-ADAT — F2: E8 GYÖKRENDSZER ÉS W(E8) — a Kristálytiszta Könyv pilot-fejezete
-- BOOK DATA — F2: the E8 root system — pilot chapter of the Crystal-clear Book
-- 书籍数据 — F2：E8 根系与外尔群 — 水晶之书的试点章节
-- BUCH-DATEN — F2: das E8-Wurzelsystem — Pilotkapitel des kristallklaren Buchs
-- נתוני ספר — F2: מערכת שורשי E8 — פרק הפיילוט של הספר הצלול
-- ═══════════════════════════════════════════════════════════════
--
-- A §1.0 MINTA SZERINT: AZ IDRIS ÍRJA A PYTHONT. Az ügynök keze
-- Pythont NEM ír (§N8): a grafikon_gen.py teljes szövegét EZ a modul
-- bocsátja ki string-konkatenációval, minden kernel-számát az
-- IMPORTÁLT, Refl-lel ellenőrzött konstansokból és a futásidőben
-- mért értékekből véve (GAUGE-elv: semmit nem jelentünk ki futás
-- nélkül). | 本模块生成 Python 的全部文本（§1.0 模式）——一切数字
-- 来自导入的、Refl 检验过的常量（GAUGE 原则）。 |
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS): SEMMIT nem számol újra — a 240 gyöklista,
-- a belső szorzat, a norma, a Weyl-rendek, a pengék, a kódszavak ÉS a
-- 240 szavas alapszókincs MIND IMPORTÁLVA az öt forrás-modulból:
--   E8Gyokok_v2      — a 240 gyök, gyokNorma, WeylE8Rend (13 Refl)
--   E8BelsoSzorzat   — belsoszorzat, weylReflexio, eloszlas (6 Refl + kimerítés)
--   E8Iranymutato_v1 — a kivételesség mutatói (5 Refl)
--   E8TizenhatPenge  — a 16 penge + Hamming + a 256-os híd (9 Refl)
--   GyokSzo_v1       — a 240 szavas alapszókincs (az F4-híd kártyája)
--
-- A KÁRTYA (a KonyvTerv_v1 §4 sablonja): (a) cím négy nyelven;
-- (b) definíciók szó szerint; (c) levezetés lépésről lépésre, minden
-- szám a futásból; (d) bizonyítás-típus szó szerint + a kernel szerepe;
-- (e) szimuláció (mit számolt az Idris-írta Python, milyen maradékkal);
-- (f) 5 grafikon (SZERKEZET/SZÁMOLÁS/ELLENŐRZÉS/SPEKTRUM/HÍD);
-- (g) forrás-modul + futtatási parancs; (h) négynyelvű összefoglaló.
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2
import E8BelsoSzorzat
import E8Iranymutato_v1
import E8TizenhatPenge
import GyokSzo_v1
import Data.List
import System
import System.Directory
import System.File

%default covering

-- ═══ 1. A FUTÁSI ÉRTÉKEK · 运行值 · Laufwerte · ערכי ריצה ═══
--    Minden szám az IMPORTÁLT modulokból, EGYSZER mérve (nincs
--    let-lánc — a KisAI-tanulság: egy rekord, egy konstrukciós menet).

||| A fejezet összes futásidőben mért értéke — a kártyák ÉS a
||| generált Python KERNEL-blokkja ugyaninnen kapja a számait.
public export
record FutásiÉrtékek where
  constructor FutásiÉrtékekKonstruktor
  pozícióPárokSzáma : Nat
  előjelPárokSzáma : Nat
  összesElőjelSzáma : Nat
  típusEgySzáma : Nat
  típusKettőSzáma : Nat
  gyökSzáma : Nat
  példaTípusEgyNorma : Integer
  példaTípusKettőNorma : Integer
  faktoriálisNyolcÉrték : Integer
  faktoriálisPrímÚtÉrték : Integer
  faktoriálisPrímtényezők : List Integer
  weylD8Érték : Integer
  trialitásÉrték : Integer
  weylE8Érték : Integer
  weylE8PrímÚtÉrték : Integer
  weylPrímtényezők : List Integer
  e8DimenzióÉrték : Integer
  e8e8DimenzióÉrték : Integer
  híd256Érték : Integer
  szorzatTípusKettőEgyÉrték : Integer
  szorzatEllentettÉrték : Integer
  szorzatMerőlegesÉrték : Integer
  reflexióÖnmagáraSzöveg : String
  reflexióMerőlegesSzöveg : String
  reflexióSzomszédSzöveg : String
  eloszlásHibákSzáma : Nat
  zárásHibákSzáma : Nat
  példaEloszlásSzöveg : String
  fokszámÖsszegÉrték : Integer
  hodgePéldaÉrték : Integer
  hodgeInvolúcióPéldaÉrték : Integer
  kódszóElsőLista : List Integer
  kódszóMindEgyesLista : List Integer
  súlyÖsszegÉrték : Integer
  kódszavakSzáma : Nat
  egyediKódszavakSzáma : Nat
  mindTávolságLegalábbHarom : Bool
  egészSzavakSzáma : Nat
  félEgészSzavakSzáma : Nat
  alapszókincsSzáma : Nat
  gyökNormákMindNyolcSzöveg : String

||| A mért értékek — minden tag IMPORTÁLT függvény hívása (§24).
public export
futásiÉrtékek : FutásiÉrtékek
futásiÉrtékek = FutásiÉrtékekKonstruktor
  (length pozicioParok)
  (length elojelParok)
  (length osszesElojel)
  (length tipus1Gyokok)
  (length tipus2Gyokok)
  (length e8Gyokok)
  (gyokNorma (tipus1GyokTeljes 1 2 1 1))
  (gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1))
  (Faktorialis 8)
  (128 * 9 * 5 * 7)
  [128, 9, 5, 7]
  WeylD8Rend
  TrialitySzazharmincot
  WeylE8Rend
  (16384 * 243 * 25 * 7)
  [16384, 243, 25, 7]
  (240 + 8)
  (e8E8Dimenzio iranymutatoMutatok)
  hid256Szamitott
  (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 1 1 1 1 1 1 1 1))
  (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor (-2) (-2) 0 0 0 0 0 0))
  (belsoszorzat (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0))
  (show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 2 0 0 0 0 0 0)))
  (show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 (-2) 0 0 0 0 0 0)))
  (show (weylReflexio (E8GyokKonstruktor 2 2 0 0 0 0 0 0) (E8GyokKonstruktor 2 0 2 0 0 0 0 0)))
  eloszlasHibakSzama
  zarasHibakSzama
  (show (eloszlas (E8GyokKonstruktor 2 2 0 0 0 0 0 0)))
  (1 + 4 + 6 + 4 + 1)
  (pengeDual 3)
  (pengeDual (pengeDual 5))
  (kodszamitas [1, 0, 0, 0])
  (kodszamitas [1, 1, 1, 1])
  (1 + 7 + 7 + 1)
  (length mindenKodszo)
  (length (egyedi mindenKodszo))
  mindLegalabbHarom
  (length egészSzavak)
  (length félEgészSzavak)
  (length alapszókincs)
  (show mindenGyokNormajaNyolc)

-- ═══ 2. A KÁRTYA-TÍPUSOK · 卡片类型 · Kartentypen · סוגי כרטיסים ═══

||| Egy levezetési lépés: képlet + kiszámolt érték + a MIÉRT.
public export
record Lépés where
  constructor LépésKonstruktor
  képlet : String
  érték : String
  miért : String

||| Egy grafikon-bejegyzés a 5-sávós sémából (KonyvTerv §3.1):
||| a függvény a generált Python egyik ábrája; az adatok a Python
||| kifejezések szövege (a Python értékeli ki futás közben — GAUGE).
public export
record GrafikonBejegyzés where
  constructor GrafikonBejegyzésKonstruktor
  sáv : String
  cím : String
  függvény : String
  adatok : String

||| Segédkonstruktor (teljes szavak — §0): sáv, cím, függvény, adatok.
||| TANULSÁG (Idris 0.8.0): a mintakötések nem kezdődhetnek ékezetes
||| betűvel, és nem lehetnek meglévő rekordmező-nevek — a mezők
||| projekció-függvényként élnek a névtérben, és a LHS őket kötné.
grafikon : String -> String -> String -> String -> GrafikonBejegyzés
grafikon sávNév címNév függvényNév adatokNév =
  GrafikonBejegyzésKonstruktor sávNév címNév függvényNév adatokNév

||| Egész kiíratása — a literálok típusa így egyértelmű Integer
||| (a (show (128 : Integer)) alakú annotáció az 0.8.0 parsert megtöri;
||| a definíció a használat ELŐTT áll — az Idris ezt igényli).
egészSzöveg : Integer -> String
egészSzöveg szám = show szám

||| A Kristálytiszta Könyv egy kártyája (KonyvTerv_v1 §4, (a)–(h)).
public export
record Kártya where
  constructor KártyaKonstruktor
  azonosító : String
  címMagyar : String
  címKínai : String
  címNémet : String
  címHéber : String
  forrásModul : String
  futtatásiParancs : String
  bizonyításTípus : String
  kernelSzerepe : String
  besorolás : String
  definíciók : List String
  lépések : List Lépés
  szimuláció : String
  grafikonBejegyzések : List GrafikonBejegyzés
  összefoglalóMagyar : String
  összefoglalóKínai : String
  összefoglalóNémet : String
  összefoglalóHéber : String

||| Szövegek összefűzése elválasztóval — a base 0.8.0 Data.List
||| intercalate-je CSAK List (List a)-ra él (String-változat nincs),
||| ezért az intersperse + concat párossal élünk (§24: standardokból).
szövegÖsszefűz : String -> List String -> String
szövegÖsszefűz elválasztó sorok = concat (intersperse elválasztó sorok)

-- ═══ 3. A KÁRTYÁK — E8Gyokok_v2 (F2.01–F2.13) ═══
--    A 240 gyök és a Weyl-csoport · 240 个根与外尔群 · Die 240 Wurzeln

kártyaCsoportGyökök : FutásiÉrtékek -> List Kártya
kártyaCsoportGyökök adat = [

  KártyaKonstruktor "F2.01"
    "A 8! = 40 320 — a permutációk száma, két független út"
    "8! = 40320——置换数，两条独立道路"
    "8! = 40320 — die Zahl der Permutationen auf zwei Wegen"
    "‏8! = 40320 — מספר התמורות בשני נתיבים עצמאיים"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizFaktorialisNyolc : Faktorialis 8 = 40320"
    "a kernel a Faktorialis 8 rekurziót nyolc lépésben normalizálja, és összeveti a 40320 literállal"
    "VALÓDI (rekurziós definíció ⟷ literál)"
    [ "public export"
    , "Faktorialis : Nat -> Integer"
    , "Faktorialis Z = 1"
    , "Faktorialis (S n) = cast (S n) * Faktorialis n" ]
    [ LépésKonstruktor "Faktorialis 8 = 8 · 7 · 6 · 5 · 4 · 3 · 2 · 1"
        (show (faktoriálisNyolcÉrték adat))
        "a rekurzió kibontva: minden S n szint egy szorzás (az Integer kernel bináris — GMP)"
    , LépésKonstruktor "2⁷ · 3² · 5 · 7 = 128 · 9 · 5 · 7"
        (show (faktoriálisPrímÚtÉrték adat))
        "a prímfelbontás útja — a második, fogalmilag más konstrukció (bizFaktorialisPrim, F2.02)"
    , LépésKonstruktor "Δ = 40320 − 40320"
        (show (faktoriálisNyolcÉrték adat - faktoriálisPrímÚtÉrték adat))
        "a két független út maradéka: nulla — a híd áll (§18)" ]
    "a Python math.factorial(8) = 40320 és 128·9·5·7 = 40320; Δ = 0 (maradekok.csv)"
    [ grafikon "SZERKEZET" "A faktoriális létra: 1!, 2!, …, 8!" "faktoriálisLétra" ""
    , grafikon "SZÁMOLÁS" "Két út a 40320-hez: rekurzió ⟷ prímek" "kétÚtHíd"
        "'rekurzió (math.factorial)', f8, '128·9·5·7', prímÚtFaktoriális"
    , grafikon "ELLENŐRZÉS" "Maradékok: f8 ⟷ kernel, prím-út ⟷ kernel (Δ = 0)" "maradékSáv"
        "['f8−kernel', 'prímút−kernel'], [f8 - KERNEL['faktorialisNyolc'], prímÚtFaktoriális - KERNEL['faktorialisPrim']]"
    , grafikon "SPEKTRUM" "A 40320 prímtornyai: 2⁷, 3², 5, 7" "prímTorony"
        "['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']"
    , grafikon "HÍD" "Híd: Idris-Refl Faktorialis 8 ⟷ Python math.factorial(8)" "kétÚtHíd"
        "'Idris Faktorialis 8 (Refl)', KERNEL['faktorialisNyolc'], 'Python math.factorial(8)', f8" ]
    "A 8! a W(D8) előjeles permutációinak magja: két független úton (rekurzió és prímfelbontás) ugyanaz a 40320 adódik — a kernel és a szimuláció maradéka nulla."
    "8! 是 W(D8) 带符号排列的核心：递归与质因数分解两条路都得出 40320，残差为零。"
    "8! ist der Kern der vorzeichenbehafteten Permutationen von W(D8): Rekursiver und Primweg ergeben 40320, Rest null."
    "‏8! הוא ליבת התמורות המסומנות של W(D8): שני נתיבים עצמאיים נותנים 40320, שארית אפס."

  , KártyaKonstruktor "F2.02"
    "A 8! prímfelbontása: 2⁷·3²·5·7 = 128·9·5·7 = 40 320"
    "8! 的质因数分解：2⁷·3²·5·7"
    "Die Primfaktorzerlegung von 8!: 2⁷·3²·5·7"
    "‏פירוק 8! לגורמים ראשוניים: 2⁷·3²·5·7"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320"
    "a kernel négy egész szorzatát normalizálja és összeveti a 40320 literállal"
    "KÉT ÚT-HÍD (prímfelbontás ⟷ rekurzió)"
    [ "public export"
    , "bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320"
    , "bizFaktorialisPrim = Refl" ]
    [ LépésKonstruktor "2⁷ = 128" (egészSzöveg 128) "a kettes prím hetedik hatványa"
    , LépésKonstruktor "3² = 9, 5, 7" (egészSzöveg (9 + 5 + 7)) "a további prímtényezők (3² + 5 + 7 = 21)"
    , LépésKonstruktor "128 · 9 · 5 · 7" (show (faktoriálisPrímÚtÉrték adat)) "a prím-út szorzata"
    , LépésKonstruktor "Δ = prím-út − Faktorialis 8"
        (show (faktoriálisPrímÚtÉrték adat - faktoriálisNyolcÉrték adat))
        "a maradék nulla: a prímfelbontás és a rekurzió ugyanazt a számot adja" ]
    "a Python 128·9·5·7 = 40320 = math.factorial(8); Δ = 0 (maradekok.csv)"
    [ grafikon "SZERKEZET" "A prímtorony: 2⁷ = 128, 3² = 9, 5, 7" "prímTorony"
        "['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']"
    , grafikon "SZÁMOLÁS" "A prím-út szorzata: 128·9·5·7" "oszlop"
        "['128·9·5·7'], [128 * 9 * 5 * 7], 'érték'"
    , grafikon "ELLENŐRZÉS" "Maradék: prím-út ⟷ kernel 40320 (Δ = 0)" "maradékSáv"
        "['prímút−kernel'], [prímÚtFaktoriális - KERNEL['faktorialisPrim']]"
    , grafikon "SPEKTRUM" "A faktoriális létra 1!…8!" "faktoriálisLétra" ""
    , grafikon "HÍD" "Híd: prím-út ⟷ rekurzió (8!)" "kétÚtHíd"
        "'prím-út 128·9·5·7', prímÚtFaktoriális, 'rekurzió 8!', f8" ]
    "A 40320 prímfelbontása (2⁷·3²·5·7) fogalmilag más konstrukció, mint a rekurzió — a kernel mégis ugyanarra kényszeríti a kettőt: ez a két-út-híd mintapéldája."
    "40320 的质因数分解与递归是概念上不同的构造，内核强制二者一致——两路桥的范例。"
    "Die Primzerlegung und die Rekursion sind verschiedene Konstruktionen, die der Kernel zur selben Zahl zwingt — das Musterbeispiel einer Zwei-Wege-Brücke."
    "‏הפירוק לגורמים והרקורסיה בנויים אחרת, אך הליבה מכריחה אותם להתלכד — מופת לגשר שני הנתיבים."

  , KártyaKonstruktor "F2.03"
    "A típus-1 gyökök száma: C(8,2)·2² = 28·4 = 112"
    "第一类根的个数：C(8,2)·2² = 112"
    "Die Zahl der Typ-1-Wurzeln: C(8,2)·2² = 112"
    "‏מספר שורשי הטיפוס הראשון: 112"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizTipusEgy : 28 * 4 = 112"
    "a kernel a 28·4 szorzatot normalizálja és összeveti a 112 literállal; futásidőben a felsorolt tipus1Gyokok hossza is 112"
    "KÉT ÚT (kombinatorika ⟷ enumeráció)"
    [ "public export"
    , "pozicioParok : List (Integer, Integer)"
    , "pozicioParok = [ (i, j) | i <- [1..8], j <- [1..8], i < j ]"
    , "elojelParok : List (Integer, Integer)"
    , "elojelParok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]"
    , "tipus1Gyokok : List E8Gyok" ]
    [ LépésKonstruktor "C(8,2) — a pozíciópárok száma" (show (pozícióPárokSzáma adat))
        "két nemnulla koordináta helye a 8 közül: 8·7/2 (futásidőben mérve)"
    , LépésKonstruktor "2² — az előjelpárok száma" (show (előjelPárokSzáma adat))
        "(+,+), (+,−), (−,+), (−,−) — a két nemnulla hely előjele"
    , LépésKonstruktor "28 · 4" (show (pozícióPárokSzáma adat * előjelPárokSzáma adat))
        "a kombinatorikai szorzat"
    , LépésKonstruktor "length tipus1Gyokok (enumeráció)"
        (show (típusEgySzáma adat))
        "a kernel a felépített lista hosszát számolja — a második út" ]
    "a Python ugyanezzel a két úttal: 28 pozíciópár × 4 előjel = 112 enumerált gyök; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 gyök 2D-petri-vetülete (kiválasztott koordináta-sík)" "petri" ""
    , grafikon "SZÁMOLÁS" "28 pozíciópár · 4 előjelpár → 112 típus-1 gyök" "oszlop"
        "['C(8,2) pozíciópár', '2² előjelpár', 'típus-1 gyök'], [len(pozícióPárok), len(előjelPárok), len(típus1)], 'darab'"
    , grafikon "ELLENŐRZÉS" "Maradék: típus-1 enumeráció ⟷ kernel 112 (Δ = 0)" "maradékSáv"
        "['típus1−kernel'], [len(típus1) - KERNEL['tipus1Szam']]"
    , grafikon "SPEKTRUM" "A két gyöktípus halmazai: 112 egész + 128 fél-egész" "típusok" ""
    , grafikon "HÍD" "Híd: kombinatorika 28·4 ⟷ enumeráció" "kétÚtHíd"
        "'kombinatorika 28·4', len(pozícióPárok) * len(előjelPárok), 'enumeráció', len(típus1)" ]
    "A 112 típus-1 gyök (±1,±1,0⁶-permutációk a 2-szeres skálán) két úton áll elő: a C(8,2)·2² kombinatorikából és a tényleges felsorolásból — a kettő maradéka nulla."
    "112 个第一类根由两条路得出：组合 C(8,2)·2² 与实际枚举，残差为零。"
    "Die 112 Typ-1-Wurzeln entstehen auf zwei Wegen: Kombinatorik und Enumeration, Rest null."
    "‏112 שורשי טיפוס 1 נובעים בשני נתיבים: קומבינטוריקה וספירה, שארית אפס."

  , KártyaKonstruktor "F2.04"
    "A típus-2 gyökök száma: 2⁸ = 256 → páros mínusszal 128"
    "第二类根的个数：256 个符号组合中偶负号者 128"
    "Die Zahl der Typ-2-Wurzeln: 256 Kombinationen, 128 mit gerader Minuszahl"
    "‏מספר שורשי הטיפוס השני: 128"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizTipusKetto : 256 = 128 + 128"
    "a kernel a 256 = 128 + 128 egyenletet normalizálja: a páros és páratlan előjel-kombinációk szétválasztása"
    "VALÓDI (páros paritás felezés)"
    [ "public export"
    , "osszesElojel : List (List Integer)"
    , "osszesElojel = [ [s1, …, s8] | s1 <- [1, -1], …, s8 <- [1, -1] ]"
    , "parosParitas : List Integer -> Bool"
    , "tipus2Gyokok : List E8Gyok"
    , "tipus2Gyokok = filter parosGyok (concatMap listaGyokke osszesElojel)" ]
    [ LépésKonstruktor "2⁸ — az összes előjel-kombináció" (show (összesElőjelSzáma adat))
        "minden koordináta ±1 lehet — a fél-egész gyökök dupla skálája"
    , LépésKonstruktor "páros mínusszal (0, 2, 4, 6, 8 mínusz)" (show (típusKettőSzáma adat))
        "a parosParitas szűrő: a mínuszok száma páros — a spinor-szerkezet feltétele"
    , LépésKonstruktor "256 = 128 + 128" (show (összesElőjelSzáma adat))
        "a páros és páratlan kombinációk fele-fele arányban oszlanak meg"
    , LépésKonstruktor "length tipus2Gyokok" (show (típusKettőSzáma adat)) "a felsorolás méri a 128-at" ]
    "a Python 256 kombinációt generál és megszámolja a párosakat: 128; a mínusz-szám szerinti eloszlás 1, 28, 70, 28, 1 (0, 2, 4, 6, 8 mínusszal)"
    [ grafikon "SZERKEZET" "A két gyöktípus halmazai: 112 egész + 128 fél-egész" "típusok" ""
    , grafikon "SZÁMOLÁS" "2⁸ kombináció → 128 páros + 128 páratlan" "oszlop"
        "['2⁸ kombináció', 'páros mínusszal (típus-2)', 'páratlan (kiesett)'], [2**8, len(típus2), 2**8 - len(típus2)], 'darab'"
    , grafikon "ELLENŐRZÉS" "Maradék: típus-2 enumeráció ⟷ kernel 128 (Δ = 0)" "maradékSáv"
        "['típus2−kernel'], [len(típus2) - KERNEL['tipus2Szam']]"
    , grafikon "SPEKTRUM" "A mínuszok számának eloszlása a 128 gyökön" "oszlop"
        "['0','1','2','3','4','5','6','7','8'], mínuszEloszlásTípus2, 'gyök'"
    , grafikon "HÍD" "Híd: 256/2 = 128 ⟷ enumeráció" "kétÚtHíd"
        "'256/2', 2**8 // 2, 'enumeráció párosok', len(típus2)" ]
    "A fél-egész gyökök (±½)⁸ a dupla skálán (±1)⁸: a 256 előjel-kombinációból a páros mínusszámúak maradnak — ez a 128, a demiocteract csúcsai."
    "半整数根（±½）⁸ 在双倍尺度上：256 个组合中偶负号者保留——即 128，即半八维立方体的顶点。"
    "Die halbzahligen Wurzeln: von 256 Kombinationen bleiben die mit gerader Minuszahl — die 128 Ecken des Demiocteracts."
    "‏שורשי החצאים: מתוך 256 צירופי סימן נותרים אלה עם מספר זוגי של מינוסים — 128 קודקודי הדמיאוקטרקט."

  , KártyaKonstruktor "F2.05"
    "A 240 gyök: 112 + 128 = 240 — a 240 szimbólum"
    "240 个根：112 + 128 = 240——240 个符号"
    "Die 240 Wurzeln: 112 + 128 = 240 — die 240 Symbole"
    "‏240 השורשים: 112 + 128 = 240"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizE8GyokSzam : 112 + 128 = 240"
    "a kernel a két típus összegét normalizálja; futásidőben az e8Gyokok lista hossza is 240"
    "KÉT ÚT (típus-szétválasztás ⟷ teljes enumeráció)"
    [ "public export"
    , "tipus1Gyokok : List E8Gyok   -- 112"
    , "tipus2Gyokok : List E8Gyok   -- 128"
    , "e8Gyokok : List E8Gyok"
    , "e8Gyokok = tipus1Gyokok ++ tipus2Gyokok" ]
    [ LépésKonstruktor "112 (típus-1)" (show (típusEgySzáma adat)) "a (±1,±1,0⁶)-permutációk (F2.03)"
    , LépésKonstruktor "128 (típus-2)" (show (típusKettőSzáma adat)) "a páros (±½)⁸ gyökök (F2.04)"
    , LépésKonstruktor "112 + 128" (show (típusEgySzáma adat + típusKettőSzáma adat)) "a típusok összege"
    , LépésKonstruktor "length e8Gyokok" (show (gyökSzáma adat)) "a teljes felsorolás hossza — a híd másik oldala" ]
    "a Python mindkét típust felsorolja és összefűzi: 240; minden norma² = 8 (0 hibás)"
    [ grafikon "SZERKEZET" "A 240 gyök 2D-petri-vetülete" "petri" ""
    , grafikon "SZÁMOLÁS" "112 + 128 → 240" "oszlop"
        "['típus-1', 'típus-2', 'összes'], [len(típus1), len(típus2), len(e8)], 'darab'"
    , grafikon "ELLENŐRZÉS" "Maradékok: típus-1, típus-2, e8 ⟷ kernel (Δ = 0)" "maradékSáv"
        "['típus1−kernel', 'típus2−kernel', 'e8−kernel'], [len(típus1) - KERNEL['tipus1Szam'], len(típus2) - KERNEL['tipus2Szam'], len(e8) - KERNEL['gyokSzam']]"
    , grafikon "SPEKTRUM" "norma²-hisztogram mind a 240 gyökön (mind = 8)" "normaHisztogram" ""
    , grafikon "HÍD" "Híd: 112+128 kombinatorika ⟷ enumeráció 240" "kétÚtHíd"
        "'112+128 kombinatorika', 112 + 128, 'enumeráció length', len(e8)" ]
    "Az E8 gyökrendszere 240 szimbólum: 112 egész + 128 fél-egész gyök. A típus-szétválasztás és a teljes felsorolás ugyanoda érkezik — ez a fejezet központi hídja."
    "E8 根系是 240 个符号：112 整数根 + 128 半整数根；类型分解与完整枚举殊途同归。"
    "Das E8-Wurzelsystem: 240 Symbole aus 112 ganzen und 128 halbzahligen Wurzeln — Trennung und Enumeration treffen sich."
    "‏מערכת שורשי E8: 240 סמלים — 112 שלמים ו־128 חצאים; הפירוק והספירה נפגשים."

  , KártyaKonstruktor "F2.06"
    "A 240 + 16 = 256 híd előszava: gyökök + pengék = a teljes bájt"
    "240 + 16 = 256 之桥的序言：根 + 刃 = 完整字节"
    "Vorschau der 256-Brücke: Wurzeln + Blades = das volle Byte"
    "‏הקדמת גשר 256: שורשים + להבים = בייט מלא"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizGyokPluszTizenhat : 240 + 16 = 256"
    "a kernel a 240+16 összeget normalizálja a 256 literálhoz — a Cl(4) pengékkel közös híd (részletek: F2.34)"
    "KÉT ÚT-HÍD (enumeráció ⟷ hatvány)"
    [ "public export"
    , "bizGyokPluszTizenhat : 240 + 16 = 256"
    , "bizGyokPluszTizenhat = Refl" ]
    [ LépésKonstruktor "240 (E8 gyökök)" (show (gyökSzáma adat)) "a tartalom (F2.05)"
    , LépésKonstruktor "16 (Cl(4) pengék)" (show (fokszámÖsszegÉrték adat)) "a keret: 1+4+6+4+1 (F2.27)"
    , LépésKonstruktor "240 + 16" (show (híd256Érték adat)) "tartalom + keret"
    , LépésKonstruktor "2⁸" (egészSzöveg 256) "a teljes bájt — a második út" ]
    "a Python len(e8) + len(pengék) = 240 + 16 = 256 = 2**8; Δ = 0"
    [ grafikon "SZERKEZET" "240 gyök + 16 penge egy rácsban (a 256 mező)" "híd256Rács" ""
    , grafikon "SZÁMOLÁS" "240 gyök + 16 penge → 256" "oszlop"
        "['E8 gyök', 'Cl(4) penge', 'összes'], [len(e8), len(pengék), len(e8) + len(pengék)], 'elem'"
    , grafikon "ELLENŐRZÉS" "Maradék: híd ⟷ kernel 256 (Δ = 0)" "maradékSáv"
        "['híd−kernel'], [len(e8) + len(pengék) - KERNEL['hid256']]"
    , grafikon "SPEKTRUM" "A 16 penge fokszámai: (1, 4, 6, 4, 1)" "pengeFok" ""
    , grafikon "HÍD" "Híd: enumeráció 240+16 ⟷ 2⁸" "kétÚtHíd"
        "'240+16 enumeráció', len(e8) + len(pengék), '2⁸', 2**8" ]
    "A 240 szimbólum (tartalom) és a 16 penge (keret) együtt a 256-os tér: a bájt. A híd teljes kifejtése a F2.34 kártyán."
    "240 个符号（内容）与 16 刃（框架）合成 256 空间：一个字节。完整展开见 F2.34。"
    "240 Symbole (Inhalt) und 16 Blades (Rahmen) ergeben den 256-Raum: das Byte — voll entfaltet auf F2.34."
    "‏240 סמלים (תוכן) ו־16 להבים (מסגרת) יוצרים את מרחב 256: הבייט — הפריסה המלאה ב־F2.34."

  , KártyaKonstruktor "F2.07"
    "A típus-1 norma: gyokNorma (2,2,0⁶) = 8 — a 2-szeres skála"
    "第一类根的范数：8（双倍尺度）"
    "Die Norm einer Typ-1-Wurzel: 8 (doppelte Skala)"
    "‏נורמת שורש טיפוס 1: 8"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizTipus1Norma : gyokNorma (tipus1GyokTeljes 1 2 1 1) = 8"
    "a kernel a konstruktor-alkalmazást kibontja és a nyolc négyzetösszeget normalizálja a 8 literálhoz"
    "VALÓDI (definíció ⟷ literál)"
    [ "public export"
    , "gyokNorma : E8Gyok -> Integer"
    , "gyokNorma (E8GyokKonstruktor a b c d e f g h) = a*a + b*b + … + h*h"
    , "tipus1GyokTeljes : Integer -> Integer -> Integer -> Integer -> E8Gyok" ]
    [ LépésKonstruktor "tipus1GyokTeljes 1 2 1 1 → (2,2,0,0,0,0,0,0)" "(2,2,0,0,0,0,0,0)"
        "az 1. helyen 2·(+1), a 2. helyen 2·(+1), máshol 0"
    , LépésKonstruktor "2² + 2² + 0²·6" (show (példaTípusEgyNorma adat))
        "a nyolc koordináta négyzetének összege a 2-szeres skálán"
    , LépésKonstruktor "értelmezés: norma² = 2 az eredeti skálán" "8 = 2·2"
        "a 2-szeres skála miatt minden szorzatérték 4-szeres — a simply-laced norma 2" ]
    "a Python mind a 240 gyökön sum(v²)-t számol: mind 8, hibás 0"
    [ grafikon "SZERKEZET" "A példagyök (2,2,0⁶) a petri-vetületben" "petri" ""
    , grafikon "SZÁMOLÁS" "A négyzettagok: 2² + 2² + 0·6" "oszlop"
        "['2²', '2²', '0²·6'], [4, 4, 0], 'négyzet'"
    , grafikon "ELLENŐRZÉS" "Hibás normák száma a 240 gyökön (várható 0)" "maradékSáv"
        "['rossz norma²'], [rosszNormák]"
    , grafikon "SPEKTRUM" "norma²-hisztogram mind a 240 gyökön (mind = 8)" "normaHisztogram" ""
    , grafikon "HÍD" "Híd: kernel gyokNorma ⟷ szimuláció sum(v²)" "kétÚtHíd"
        "'kernel gyokNorma (2,2,0⁶)', KERNEL['tipus1Norma'], 'szimuláció sum(v²)', sum(x * x for x in e8[0])" ]
    "Az E8 egyszerűen fűzött (simply-laced): minden gyök normája azonos. A 2-szeres skálán ez 8 — az egész tábla ezen a skálán egész marad."
    "E8 为单连（simply-laced）：所有根范数相同；双倍尺度下为 8，使全表保持整数。"
    "E8 ist simply-laced: alle Wurzeln haben dieselbe Norm — auf der doppelten Skala 8, damit alles ganzzahlig bleibt."
    "‏E8 פשוטת־קשר: לכל השורשים אותה נורמה — בסקאלה הכפולה 8, כדי שהכול יישאר שלם."

  , KártyaKonstruktor "F2.08"
    "A típus-2 norma: gyokNorma (1⁸) = 8 — a fél-egész gyök is azonos"
    "第二类根的范数也是 8"
    "Die Norm einer Typ-2-Wurzel: ebenfalls 8"
    "‏גם נורמת שורש טיפוס 2 היא 8"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizTipus2Norma : gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 8"
    "a kernel a nyolc 1² összeget normalizálja a 8 literálhoz"
    "VALÓDI (definíció ⟷ literál)"
    [ "public export"
    , "bizTipus2Norma : gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 8"
    , "bizTipus2Norma = Refl" ]
    [ LépésKonstruktor "(1,1,1,1,1,1,1,1) — a (±½)⁸ gyök a 2-szeres skálán" "(1,1,1,1,1,1,1,1)"
        "az (½⁸) gyök koordinátánként duplázva"
    , LépésKonstruktor "1² · 8" (show (példaTípusKettőNorma adat)) "nyolc egyes négyzete"
    , LépésKonstruktor "konklúzió: a két típus normája azonos" "8 = 8"
        "a típus-1 és típus-2 gyökök azonos hosszúak — ez teszi lehetővé a közös skálát" ]
    "a Python a típus-2 gyökökön is sum(v²) = 8-t mér: hibás 0"
    [ grafikon "SZERKEZET" "A fél-egész gyökök halmaza" "típusok" ""
    , grafikon "SZÁMOLÁS" "1² × 8 négyzettag" "oszlop"
        "['1² × 8'], [8 * 1], 'négyzet'"
    , grafikon "ELLENŐRZÉS" "Hibás normák a 240 gyökön (várható 0)" "maradékSáv"
        "['rossz norma²'], [rosszNormák]"
    , grafikon "SPEKTRUM" "norma²-hisztogram mind a 240 gyökön" "normaHisztogram" ""
    , grafikon "HÍD" "Híd: kernel gyokNorma (1⁸) ⟷ szimuláció" "kétÚtHíd"
        "'kernel gyokNorma (1⁸)', KERNEL['tipus2Norma'], 'szimuláció', sum(x * x for x in [1, 1, 1, 1, 1, 1, 1, 1])" ]
    "A (±½)⁸ gyökök a 2-szeres skálán (±1)⁸: nyolc egyes négyzete ugyanannyi, mint a típus-1 gyököknél — a két család egyformán hosszú."
    "(±½)⁸ 在双倍尺度为 (±1)⁸：八个 1² 之和与第一类根相同——两族等长。"
    "(±½)⁸ wird auf der doppelten Skala zu (±1)⁸: acht Einsquadrate, gleich lang wie Typ 1."
    "‏(±½)⁸ בסקאלה הכפולה הוא (±1)⁸: שמונה ריבועי אחד — אותו אורך כמו טיפוס 1."

  , KártyaKonstruktor "F2.09"
    "W(D8) = 2⁷·8! = 5 160 960 — az előjeles permutációk csoportja"
    "W(D8) = 2⁷·8! = 5160960"
    "W(D8) = 2⁷·8! = 5160960 — die vorzeichenbehafteten Permutationen"
    "‏W(D8) = 2⁷·8! = 5160960"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizWeylD8 : WeylD8Rend = 5160960"
    "a kernel a WeylD8Rend = 128 · Faktorialis 8 szorzatot normalizálja a literálhoz (Integer-kernel — a v1 Nat-fagyásának gyógyíra)"
    "KÉT ÚT (2⁷·8! struktúra ⟷ literál)"
    [ "public export"
    , "WeylD8Rend : Integer"
    , "WeylD8Rend = 128 * Faktorialis 8" ]
    [ LépésKonstruktor "2⁷ = 128 — az előjelek cseréi" (egészSzöveg 128)
        "nyolc koordináta előjele önállóan cserélhető"
    , LépésKonstruktor "8! = 40320 — a permutációk" (show (faktoriálisNyolcÉrték adat)) "a koordináták helycseréi (F2.01)"
    , LépésKonstruktor "128 · 40320" (show (weylD8Érték adat)) "a D8 rács szimmetriáinak száma"
    , LépésKonstruktor "ellenőrzés futásidőben" (show (weylD8Érték adat)) "a main kiírja: 5160960" ]
    "a Python 128·math.factorial(8) = 5160960; Δ = 0"
    [ grafikon "SZERKEZET" "A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)" "weylLánc" ""
    , grafikon "SZÁMOLÁS" "2⁷ · 8! → 5 160 960" "oszlop"
        "['2⁷', '8!', 'W(D8)'], [128, f8, 128 * f8], 'elem'"
    , grafikon "ELLENŐRZÉS" "Maradék: W(D8) ⟷ kernel (Δ = 0)" "maradékSáv"
        "['W(D8)−kernel'], [weylD8 - KERNEL['weylD8']]"
    , grafikon "SPEKTRUM" "A 40320 prímtornyai: 2⁷, 3², 5, 7" "prímTorony"
        "['2⁷','3²','5','7'], KERNEL['faktorialisPrimTenyezok']"
    , grafikon "HÍD" "Híd: struktúra 2⁷·8! ⟷ kernel WeylD8Rend" "kétÚtHíd"
        "'struktúra 2⁷·8!', 128 * f8, 'kernel WeylD8Rend', KERNEL['weylD8']" ]
    "A D8 rács szimmetriacsoportja a 240 gyök 112 egész tagját őrzi: előjelcsere × permutáció. A nagy szám Integer-kernellel bizonyítható — ez a v1 fagyásának tanulsága."
    "D8 格的对称群由符号交换与排列构成；大数用 Integer 内核证明——v1 冻结之训。"
    "Die Symmetriegruppe des D8-Gitters: Vorzeichenwechsel × Permutation; große Zahlen mit Integer-Kernel — die Lehre des eingefrorenen v1."
    "‏חבורת הסימטריה של סריג D8: החלפת סימנים × תמורות; מספרים גדולים בליבת Integer — מוראת v1."

  , KártyaKonstruktor "F2.10"
    "A trialitás-faktor: 135 = 3³·5"
    "三重性因子：135 = 3³·5"
    "Der Trialitätsfaktor: 135 = 3³·5"
    "‏גורם הטריאליות: 135 = 3³·5"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizSzazharmincot : TrialitySzazharmincot = 135"
    "a kernel a 3·3·3·5 szorzatot normalizálja a 135 literálhoz"
    "VALÓDI (szorzat ⟷ literál)"
    [ "public export"
    , "TrialitySzazharmincot : Integer"
    , "TrialitySzazharmincot = 3 * 3 * 3 * 5" ]
    [ LépésKonstruktor "3 · 3 · 3 = 27" (egészSzöveg 27) "a triality harmadik hatványa"
    , LépésKonstruktor "27 · 5 = 135" (show (trialitásÉrték adat)) "szorozva az ötössel"
    , LépésKonstruktor "W(E8) = W(D8) · 135" (show (weylE8Érték adat)) "a D8-csoport és az E8-csoport közti arány (F2.11)" ]
    "a Python 3·3·3·5 = 135; Δ = 0"
    [ grafikon "SZERKEZET" "A trialitás-faktor felépítése: 3·3·3·5" "oszlop"
        "['3', '3', '3', '5', '135'], [3, 3, 3, 5, 3 * 3 * 3 * 5], 'tényező'"
    , grafikon "SZÁMOLÁS" "27 · 5 → 135" "oszlop"
        "['3³ = 27', '5', '135'], [27, 5, 27 * 5], 'érték'"
    , grafikon "ELLENŐRZÉS" "Maradék: trialitás ⟷ kernel (Δ = 0)" "maradékSáv"
        "['trialitás−kernel'], [trialitás - KERNEL['triality']]"
    , grafikon "SPEKTRUM" "A prímtornyok: 3³ és 5" "prímTorony"
        "['3³', '5'], [27, 5]"
    , grafikon "HÍD" "Híd: 3·3·3·5 ⟷ kernel TrialitySzazharmincot" "kétÚtHíd"
        "'3·3·3·5', 3 * 3 * 3 * 5, 'kernel 135', KERNEL['triality']" ]
    "A 135 az a faktor, amellyel a D8 szimmetriák tere E8-va bővül: a spinor-tér trialitása (3³) és az ötös tükör szorzata."
    "135 是 D8 对称扩张为 E8 的因子：旋量空间三重性（3³）与五重镜之积。"
    "135 ist der Faktor, der D8 zu E8 erweitert: die Trialität des Spinnorraums (3³) mal fünf."
    "‏135 הוא הגורר שמרחיב את D8 ל־E8: טריאליות מרחב הספינורים (3³) כפול חמש."

  , KártyaKonstruktor "F2.11"
    "W(E8) = 696 729 600 = W(D8)·135 — a struktúra-út"
    "W(E8) = 696729600 = W(D8)·135——结构之路"
    "W(E8) = 696729600 = W(D8)·135 — der Strukturweg"
    "‏W(E8) = 696729600 = W(D8)·135"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizWeylE8 : WeylE8Rend = 696729600"
    "a kernel a WeylD8Rend · TrialitySzazharmincot szorzatot normalizálja a 696729600 literálhoz"
    "KÉT ÚT (struktúra-szorzat ⟷ literál)"
    [ "public export"
    , "WeylE8Rend : Integer"
    , "WeylE8Rend = WeylD8Rend * TrialitySzazharmincot" ]
    [ LépésKonstruktor "W(D8) = 5 160 960" (show (weylD8Érték adat)) "az előjeles permutációk (F2.09)"
    , LépésKonstruktor "135 = 3³·5" (show (trialitásÉrték adat)) "a trialitás-faktor (F2.10)"
    , LépésKonstruktor "5 160 960 · 135" (show (weylE8Érték adat)) "a struktúra-út szorzata"
    , LépésKonstruktor "696 729 600 — NEM túl sok" (show (weylE8Érték adat))
        "a kernel ezredmásodperc alatt normalizálja (Integer, nem Nat)" ]
    "a Python weylD8 · trialitás = 696729600; Δ = 0"
    [ grafikon "SZERKEZET" "A Weyl-lánc: 2⁷ → 8! → 135 → W(D8) → W(E8)" "weylLánc" ""
    , grafikon "SZÁMOLÁS" "W(D8) · 135 → 696 729 600" "oszlop"
        "['W(D8)', '·135', 'W(E8)'], [weylD8, trialitás, weylE8], 'elem'"
    , grafikon "ELLENŐRZÉS" "Maradék: W(E8) ⟷ kernel (Δ = 0)" "maradékSáv"
        "['W(E8)−kernel'], [weylE8 - KERNEL['weylE8']]"
    , grafikon "SPEKTRUM" "A prímtornyok: 2¹⁴, 3⁵, 5², 7" "prímTorony"
        "['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']"
    , grafikon "HÍD" "Híd: struktúra-út ⟷ kernel WeylE8Rend" "kétÚtHíd"
        "'struktúra W(D8)·135', weylE8, 'kernel WeylE8Rend', KERNEL['weylE8']" ]
    "Az E8 Weyl-csoportjának rendje a struktúra-úton: az előjeles permutációk (W(D8)) szorozva a trialitás-faktorral (135). A 696 729 600 nem visszaélés — a kernel kiszámolja."
    "E8 外尔群之阶沿结构之路：带符号排列（W(D8)）乘以三重性因子 135；696729600 由内核直接算出。"
    "Die Ordnung der E8-Weyl-Gruppe auf dem Strukturweg: W(D8) mal Trialitätsfaktor 135 — 696729600 rechnet der Kernel direkt aus."
    "‏סדר חבורת וייל של E8 בדרך המבנה: W(D8) כפול גורם הטריאליות 135 — 696729600 הליבה מחשבת ישירות."

  , KártyaKonstruktor "F2.12"
    "W(E8) = 2¹⁴·3⁵·5²·7 = 696 729 600 — KÉT FÜGGETLEN ÚT, EGY HÍD"
    "W(E8) = 2¹⁴·3⁵·5²·7——两条独立道路，一座桥"
    "W(E8) = 2¹⁴·3⁵·5²·7 — zwei unabhängige Wege, eine Brücke"
    "‏W(E8) = 2¹⁴·3⁵·5²·7 — שני נתיבים, גשר אחד"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600"
    "a kernel a prímtényezős szorzatot normalizálja ugyanahhoz a 696729600-hoz, mint a struktúra-út (F2.11) — a két fogalmilag különböző konstrukció kényszerített találkozása"
    "KÉT ÚT-HÍD (struktúra ⟷ prímfelbontás)"
    [ "public export"
    , "bizWeylE8 : WeylE8Rend = 696729600"
    , "bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600"
    , "bizWeylE8Prim = Refl" ]
    [ LépésKonstruktor "2¹⁴ = 16384" (egészSzöveg 16384) "a kettes prím tizennegyedik hatványa"
    , LépésKonstruktor "3⁵ = 243, 5² = 25, 7" (egészSzöveg (243 * 25 * 7)) "a további prímtényezők szorzata"
    , LépésKonstruktor "16384 · 243 · 25 · 7" (show (weylE8PrímÚtÉrték adat)) "a prím-út szorzata"
    , LépésKonstruktor "Δ = prím-út − struktúra-út"
        (show (weylE8PrímÚtÉrték adat - weylE8Érték adat))
        "a maradék nulla: a struktúra (W(D8)·135) és a prímfelbontás ugyanazt a csoportrendet adja" ]
    "a Python 16384·243·25·7 = 696729600 = weylD8·135; Δ = 0"
    [ grafikon "SZERKEZET" "A prím-torony: 2¹⁴ · 3⁵ · 5² · 7" "prímTorony"
        "['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']"
    , grafikon "SZÁMOLÁS" "A prím-út szorzatlánca" "oszlop"
        "['16384', '243', '25', '7', 'szorzat'], [16384, 243, 25, 7, 16384 * 243 * 25 * 7], 'érték'"
    , grafikon "ELLENŐRZÉS" "Maradék: prím-út ⟷ kernel (Δ = 0)" "maradékSáv"
        "['W(E8) prímút−kernel'], [prímÚtWeyl - KERNEL['weylE8Prim']]"
    , grafikon "SPEKTRUM" "A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)" "weylLánc" ""
    , grafikon "HÍD" "Híd: struktúra-út W(D8)·135 ⟷ prím-út 2¹⁴·3⁵·5²·7" "kétÚtHíd"
        "'struktúra W(D8)·135', weylE8, 'prím 2¹⁴·3⁵·5²·7', prímÚtWeyl" ]
    "A W(E8) rendjét két fogalmilag különböző konstrukció adja: a csoportszerkezet (W(D8)·135) és a prímfelbontás (2¹⁴·3⁵·5²·7). A kernel mindkettőt ugyanarra a 696 729 600-ra kényszeríti — a tétel-írás kanonikus mintája (AGENTS §18)."
    "W(E8) 的阶由两条概念不同的路给出：群结构（W(D8)·135）与质因数分解；内核强制二者同为 696729600——写定理的典范模式。"
    "Die Ordnung von W(E8) entsteht auf zwei konzeptuell verschiedenen Wegen: Gruppenstruktur und Primzerlegung; der Kernel zwingt beide auf 696729600 — das kanonische Muster des Theoremschreibens."
    "‏סדר W(E8) ניתן בשני נתיבים מושגית שונים: מבנה החבורה ופירוק ראשוני; הליבה מכריחה את שניהם אל 696729600 — הדגם הקנוני לכתיבת משפטים."

  , KártyaKonstruktor "F2.13"
    "Az E8 dimenziója: 240 + 8 = 248 — gyökök + Cartan-algebra"
    "E8 的维数：240 + 8 = 248"
    "Die Dimension von E8: 240 + 8 = 248 — Wurzeln + Cartan-Algebra"
    "‏ממד E8: 240 + 8 = 248"
    "szima_ter/modul/E8Gyokok_v2.idr"
    "idris2 szima_ter/modul/E8Gyokok_v2.idr --exec main"
    "bizE8Dimenzio : 240 + 8 = 248"
    "a kernel a gyökök és a Cartan-algebra összegeként normalizálja a 248-at"
    "VALÓDI (gyök + rang)"
    [ "public export"
    , "bizE8Dimenzio : 240 + 8 = 248"
    , "bizE8Dimenzio = Refl" ]
    [ LépésKonstruktor "240 — a gyökök" (show (gyökSzáma adat)) "minden gyök egy gyökteret feszít ki (F2.05)"
    , LépésKonstruktor "8 — a Cartan-algebra rang" (egészSzöveg 8) "a nyolc diagonális irány — a rang (F2.03: a 8 koordináta)"
    , LépésKonstruktor "240 + 8" (show (e8DimenzióÉrték adat)) "a Lie-algebra dimenziója: gyökterek + Cartan"
    , LépésKonstruktor "248 — a legnagyobb kivételes egyszerű Lie-algebra" (show (e8DimenzióÉrték adat))
        "az E8 ∈ {g2, f4, e6, e7, e8} közül a legnagyobb" ]
    "a Python len(e8) + 8 = 248; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 gyök 2D-petri-vetülete" "petri" ""
    , grafikon "SZÁMOLÁS" "240 gyök + 8 Cartan → 248" "oszlop"
        "['240 gyök', '+8 Cartan', '=248'], [len(e8), 8, len(e8) + 8], 'dimenzió'"
    , grafikon "ELLENŐRZÉS" "Maradék: dimenzió ⟷ kernel (Δ = 0)" "maradékSáv"
        "['248−kernel'], [len(e8) + 8 - KERNEL['e8Dimenzio']]"
    , grafikon "SPEKTRUM" "A gyökök eloszlása egy gyök körül: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: gyök+Cartan ⟷ kernel bizE8Dimenzio" "kétÚtHíd"
        "'240+8 (gyök+Cartan)', len(e8) + 8, 'kernel 248', KERNEL['e8Dimenzio']" ]
    "Az E8 Lie-algebra 248 dimenziós: 240 gyökter és a 8 dimenziós Cartan-algebra. Ez a legnagyobb kivételes egyszerű Lie-algebra — a projektstruktúra gerince."
    "E8 李代数为 248 维：240 个根空间与 8 维嘉当代数——最大的例外单李代数。"
    "Die E8-Lie-Algebra ist 248-dimensional: 240 Wurzelräume und die 8-dimensionale Cartan-Algebra — die größte Ausnahmealgebra."
    "‏אלגברת לי E8 בת 248 ממדים: 240 מרחבי שורש ואלגברת קרטן בת 8 — האלגברה הפשוטה היוצאת מן הכלל הגדולה ביותר."

  ]

-- ═══ 4. A KÁRTYÁK — E8BelsoSzorzat (F2.14–F2.21) ═══
--    A belső szorzat-tábla és a tükrözések · 内积表与反射

kártyaCsoportSzorzat : FutásiÉrtékek -> List Kártya
kártyaCsoportSzorzat adat = [

  KártyaKonstruktor "F2.14"
    "Keverelt pár: (2,2,0⁶)·(1⁸) = 4 — a 60°-os szög"
    "混合对：(2,2,0⁶)·(1⁸) = 4——60° 角"
    "Gemischtes Paar: (2,2,0⁶)·(1⁸) = 4 — der 60°-Winkel"
    "‏זוג מעורב: (2,2,0⁶)·(1⁸) = 4 — זווית 60°"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizSzorzatT1T2 : belsoszorzat (2,2,0⁶) (1⁸) = 4"
    "a kernel a típus-1 ∩ típus-2 szorzat nyolc tagját adja össze és normalizálja a 4-hez"
    "VALÓDI (tagonkénti összeg ⟷ literál)"
    [ "public export"
    , "belsoszorzat : E8Gyok -> E8Gyok -> Integer"
    , "belsoszorzat (E8GyokKonstruktor a1 … a8) (E8GyokKonstruktor b1 … b8)"
    , "  = a1*b1 + a2*b2 + … + a8*b8" ]
    [ LépésKonstruktor "a tagok: 2·1 + 2·1 + 0·1·6" (show (szorzatTípusKettőEgyÉrték adat))
        "csak a két nemnulla koordináta járul hozzá: 2 + 2"
    , LépésKonstruktor "⟨α,β⟩ = 4 a 2-szeres skálán" (show (szorzatTípusKettőEgyÉrték adat))
        "a normalizált érték: 4/8 = +½, azaz 60°-os szög (F2.20: az 56 szomszéd egyike)"
    , LépésKonstruktor "értelmezés: SzorosanHasonló (+½)" "+½ szorosan hasonló (60°)"
        "ez a híd a GyökSzó ötszintű skálája felé (bizTávolságKevereltPár, F2.36)" ]
    "a Python sum(a·b) = 4; Δ = 0"
    [ grafikon "SZERKEZET" "A két gyöktípus halmazai" "típusok" ""
    , grafikon "SZÁMOLÁS" "A tagok: 2·1 + 2·1 + 0·6" "oszlop"
        "['2·1', '2·1', '0·1 × 6'], [2, 2, 0], 'tag'"
    , grafikon "ELLENŐRZÉS" "Maradék: kevert pár szorzata ⟷ kernel (Δ = 0)" "maradékSáv"
        "['T1T2−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (1, 1, 1, 1, 1, 1, 1, 1))) - KERNEL['szorzatT1T2']]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizSzorzatT1T2 ⟷ szimuláció" "kétÚtHíd"
        "'kernel BizSzorzatT1T2', KERNEL['szorzatT1T2'], 'szimuláció', 2 + 2" ]
    "A típus-1 és típus-2 gyökök nem merőlegesek egymásra: a (2,2,0⁶)·(1⁸) = 4 a 60°-os szög jele — a két család között VAN kapcsolat, ez a szorosan-hasonló szint."
    "第一类与第二类根并非正交：(2,2,0⁶)·(1⁸) = 4 标志 60° 角——两族之间确有联系，即紧密相似层。"
    "Typ-1- und Typ-2-Wurzeln sind nicht orthogonal: (2,2,0⁶)·(1⁸) = 4 markiert den 60°-Winkel — es gibt eine Verbindung zwischen den Familien."
    "‏שורשי טיפוס 1 ו־2 אינם אורתוגונליים: (2,2,0⁶)·(1⁸) = 4 מסמן זווית 60° — יש קשר בין המשפחות."

  , KártyaKonstruktor "F2.15"
    "Az ellentett szorzata: α·(−α) = −8 (norma² = 8 ellentettel)"
    "相反根的内积：α·(−α) = −8"
    "Das Produkt mit dem Entgegengesetzten: α·(−α) = −8"
    "‏מכפלה עם ההפוך: α·(−α) = −8"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizSzorzatEllentett : belsoszorzat (2,2,0⁶) (−2,−2,0⁶) = -8"
    "a kernel a nyolc ellentett tagot adja össze: −4 − 4 = −8"
    "VALÓDI (ellentett ⟷ −norma²)"
    [ "public export"
    , "gyokEllentett : E8Gyok -> E8Gyok"
    , "gyokEllentett = gyokSkalar (-1)"
    , "BizSzorzatEllentett : belsoszorzat (2,2,0⁶) (-2,-2,0⁶) = -8" ]
    [ LépésKonstruktor "(−2)·2 + (−2)·2 + 0·6" (show (szorzatEllentettÉrték adat)) "minden tag előjeles négyzet: −4 − 4"
    , LépésKonstruktor "⟨α,−α⟩ = −⟨α,α⟩ = −8" (show (szorzatEllentettÉrték adat))
        "a norma ellentettje — a 180°-os szög (Ellentett szint)"
    , LépésKonstruktor "konklúzió: minden gyök párja a −α" "1 gyök = −8 az eloszlásban"
        "ezért pontosan EGY ellentett van gyökenként (F2.20: az (1,56,126,56,1) első oszlopa)" ]
    "a Python sum(a·b) a −α-n: −8; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 gyök petri-vetülete (α és −α átellenesen)" "petri" ""
    , grafikon "SZÁMOLÁS" "−4 − 4 → −8" "oszlop"
        "['(−2)·2', '(−2)·2', '0·6'], [-4, -4, 0], 'tag'"
    , grafikon "ELLENŐRZÉS" "Maradék: ellentett-szorzat ⟷ kernel (Δ = 0)" "maradékSáv"
        "['ellentett−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (-2, -2, 0, 0, 0, 0, 0, 0))) - KERNEL['szorzatEllentett']]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizSzorzatEllentett ⟷ szimuláció" "kétÚtHíd"
        "'kernel α·(−α)', KERNEL['szorzatEllentett'], 'szimuláció', -(2 * 2 + 2 * 2)" ]
    "A gyökrendszer centrális szimmetriájú: minden gyök ellentettje is gyök. A ⟨α,−α⟩ = −8 a táblázat minimuma — az Ellentett jelentésszint forrása."
    "根系中心对称：每个根的相反也是根；⟨α,−α⟩ = −8 是表格最小值——相反意义层的来源。"
    "Das Wurzelsystem ist zentralsymmetrisch: das Negative jeder Wurzel ist Wurzel; ⟨α,−α⟩ = −8 ist das Tabellenminimum."
    "‏מערכת השורשים מרכזית־סימטרית: שלילת כל שורש היא שורש; ⟨α,−α⟩ = −8 הוא מינימום הטבלה."

  , KártyaKonstruktor "F2.16"
    "Merőleges pár: (2,2,0⁶)·(2,−2,0⁶) = 0"
    "正交对：(2,2,0⁶)·(2,−2,0⁶) = 0"
    "Orthogonales Paar: (2,2,0⁶)·(2,−2,0⁶) = 0"
    "‏זוג ניצב: (2,2,0⁶)·(2,−2,0⁶) = 0"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizSzorzatMeroleges : belsoszorzat (2,2,0⁶) (2,-2,0⁶) = 0"
    "a kernel a nyolc tagot adja össze: 4 − 4 = 0"
    "VALÓDI (tagösszeg ⟷ 0 literál)"
    [ "public export"
    , "BizSzorzatMeroleges : belsoszorzat (2,2,0⁶) (2,-2,0⁶) = 0"
    , "BizSzorzatMeroleges = Refl" ]
    [ LépésKonstruktor "2·2 + 2·(−2) + 0·6" (show (szorzatMerőlegesÉrték adat)) "4 − 4 = 0 — a tagok kioltják egymást"
    , LépésKonstruktor "⟨α,β⟩ = 0 → 90°" "90°-os szög"
        "a Semleges jelentésszint forrása (bizTávolságMerőleges)"
    , LépésKonstruktor "az eloszlásban: 126 gyök" "126 merőleges gyök"
        "a legtöbb pár merőleges (F2.20: a 126-os oszlop)" ]
    "a Python sum(a·b) = 0; Δ = 0"
    [ grafikon "SZERKEZET" "A merőleges vektorok az (x₁,x₂)-síkban" "reflexióVektor" ""
    , grafikon "SZÁMOLÁS" "4 − 4 → 0" "oszlop"
        "['2·2', '2·(−2)', '0·6'], [4, -4, 0], 'tag'"
    , grafikon "ELLENŐRZÉS" "Maradék: merőleges szorzat ⟷ kernel (Δ = 0)" "maradékSáv"
        "['merőleges−kernel'], [sum(a * b for a, b in zip((2, 2, 0, 0, 0, 0, 0, 0), (2, -2, 0, 0, 0, 0, 0, 0))) - KERNEL['szorzatMeroleges']]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizSzorzatMeroleges ⟷ szimuláció" "kétÚtHíd"
        "'kernel α·β⊥', KERNEL['szorzatMeroleges'], 'szimuláció', 4 - 4" ]
    "A 240 gyök többsége merőleges egymásra: a 0 a tábla közepe. A merőlegesség a semleges jelentés forrása — a független fogalmak geometriája."
    "240 个根大多互相正交：0 是表格中心；正交性是中性意义的来源——独立概念的几何。"
    "Die meisten der 240 Wurzeln sind orthogonal: 0 ist die Tabellenmitte — die Quelle neutraler Bedeutung."
    "‏רוב 240 השורשים ניצבים זה לזה: 0 הוא מרכז הטבלה — מקור המשמעות הנייטרלית."

  , KártyaKonstruktor "F2.17"
    "A tükrözés önmagán: σ_α(α) = −α"
    "反射作用于自身：σ_α(α) = −α"
    "Die Spiegelung auf sich selbst: σ_α(α) = −α"
    "‏השתקפות על עצמו: σ_α(α) = −α"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizReflexioOnmagara : weylReflexio (2,2,0⁶) (2,2,0⁶) = (-2,-2,0⁶)"
    "a kernel a σ_α(α) = α − (8/4)·α = α − 2α = −α számítást normalizálja"
    "VALÓDI (képlet-alkalmazás ⟷ konstruktor)"
    [ "public export"
    , "weylReflexio : E8Gyok -> E8Gyok -> E8Gyok"
    , "weylReflexio alfa beta ="
    , "  gyokKulonbseg beta (gyokSkalar (div (belsoszorzat alfa beta) 4) alfa)" ]
    [ LépésKonstruktor "⟨α,α⟩ = 8" (show (példaTípusEgyNorma adat)) "a norma a 2-szeres skálán (F2.07)"
    , LépésKonstruktor "8 / 4 = 2" (egészSzöveg (8 `div` 4)) "egész osztás — nincs törtszám"
    , LépésKonstruktor "σ_α(α) = α − 2·α = −α" (reflexióÖnmagáraSzöveg adat)
        "a kernel az eredményt konstruktor-egyenlőségre normalizálja: (−2,−2,0,0,0,0,0,0)" ]
    "a Python tükröz(α, α) az újjáépített gyökrendszeren: (−2,−2,0,0,0,0,0,0); a kernel-szöveggel egyezik"
    [ grafikon "SZERKEZET" "A tükrözés vektor-ábrája: α → −α" "reflexióVektor" ""
    , grafikon "SZÁMOLÁS" "⟨α,α⟩/4 = 2 → α − 2α" "oszlop"
        "['⟨α,α⟩', '/4', 'α−2α'], [8, 2, 0], 'lépés'"
    , grafikon "ELLENŐRZÉS" "Maradék: σ(α,α) szöveg ⟷ kernel (0 = egyezik)" "maradékSáv"
        "['σ(α,α)−kernel'], [(0 if str(list(tükröz(e8[0], e8[0]))) == KERNEL['reflexioOnmagara'].replace(' ', '') else 1)]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizReflexioOnmagara ⟷ szimuláció" "kétÚtHíd"
        "'kernel σ(α,α) x-koord.', -2, 'szimuláció x-koord.', tükröz(e8[0], e8[0])[0]" ]
    "A Weyl-tükrözés a gyök saját tükörsíkján megszűnteti a gyököt és előhozza az ellentettjét: σ_α(α) = −α. Az egész osztás (⟨α,β⟩/4) a simply-laced szerkezet ajándéka."
    "外尔反射把根变为其相反：σ_α(α) = −α；整除（⟨α,β⟩/4）是单连结构的馈赠。"
    "Die Weyl-Spiegelung kehrt die Wurzel um: σ_α(α) = −α; die Ganzzahldivision ist das Geschenk der simply-laced-Struktur."
    "‏השתקפות וייל הופכת את השורש להפוכו: σ_α(α) = −α; החילוק השלם הוא מתנת המבנה הפשוט."

  , KártyaKonstruktor "F2.18"
    "Merőleges tükrözés: σ_α(β) = β, ha ⟨α,β⟩ = 0"
    "正交反射：若 ⟨α,β⟩ = 0，则 σ_α(β) = β"
    "Orthogonale Spiegelung: σ_α(β) = β, wenn ⟨α,β⟩ = 0"
    "‏השתקפות ניצבת: אם ⟨α,β⟩ = 0 אז σ_α(β) = β"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizReflexioMeroleges : weylReflexio (2,2,0⁶) (2,-2,0⁶) = (2,-2,0⁶)"
    "a kernel a σ_α(β) = β − (0/4)·α = β − 0 számítást normalizálja: a merőleges gyök rögzített"
    "VALÓDI (képlet-alkalmazás ⟷ konstruktor)"
    [ "public export"
    , "BizReflexioMeroleges : weylReflexio (2,2,0⁶) (2,-2,0⁶) = (2,-2,0⁶)"
    , "BizReflexioMeroleges = Refl" ]
    [ LépésKonstruktor "⟨α,β⊥⟩ = 0" (show (szorzatMerőlegesÉrték adat)) "a merőleges szorzat (F2.16)"
    , LépésKonstruktor "0 / 4 = 0" (egészSzöveg (0 `div` 4)) "nincs elmozdulás"
    , LépésKonstruktor "σ_α(β⊥) = β⊥ − 0·α = β⊥" (reflexióMerőlegesSzöveg adat)
        "a tükör síkján fekvő gyök NEM mozdul — a kernel konstruktor-egyenlőséget normalizál" ]
    "a Python tükröz(α, β⊥) = (2,−2,0,0,0,0,0,0); egyezik a kernel-szöveggel"
    [ grafikon "SZERKEZET" "A merőleges β⊥ a tükör síkján marad" "reflexióVektor" ""
    , grafikon "SZÁMOLÁS" "⟨α,β⊥⟩/4 = 0 → β − 0·α" "oszlop"
        "['⟨α,β⊥⟩', '/4', 'β−0·α'], [0, 0, 0], 'lépés'"
    , grafikon "ELLENŐRZÉS" "Maradék: σ(α,β⊥) ⟷ kernel (0 = egyezik)" "maradékSáv"
        "['σ(α,β⊥)−kernel'], [(0 if str(list(tükröz(e8[0], (2, -2, 0, 0, 0, 0, 0, 0)))) == KERNEL['reflexioMeroleges'].replace(' ', '') else 1)]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizReflexioMeroleges ⟷ szimuláció" "kétÚtHíd"
        "'kernel σ(α,β⊥) x-koord.', 2, 'szimuláció x-koord.', tükröz(e8[0], (2, -2, 0, 0, 0, 0, 0, 0))[0]" ]
    "A tükör síkján fekvő gyökök invariánsak: a 126 merőleges gyök mindegyike rögzített a tükrözés alatt. Ez a szimmetria rögzített-pontja — a fogalmi függetlenség algebrai oka."
    "位于镜面上的根在反射下不变：126 个正交根皆为不动点——概念独立的代数根源。"
    "Wurzeln in der Spiegelebene bleiben fix: alle 126 orthogonalen Wurzeln sind Fixpunkte — der algebraische Grund begrifflicher Unabhängigkeit."
    "‏שורשים במישור המראה נשארים קבועים: כל 126 השורשים הניצבים הם נקודות שבת — הסיבה האלגברית לעצמאות מושגית."

  , KártyaKonstruktor "F2.19"
    "Szomszéd tükrözése: σ_α(β) = (0,−2,2,0⁵), ha ⟨α,β⟩ = 4"
    "相邻根的反射：σ_α(β) = (0,−2,2,0⁵)"
    "Spiegelung einer Nachbarnwurzel: σ_α(β) = (0,−2,2,0⁵)"
    "‏השתקפות שכן: σ_α(β) = (0,−2,2,0⁵)"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "BizReflexioSzomszed : weylReflexio (2,2,0⁶) (2,0,2,0⁵) = (0,-2,2,0⁵)"
    "a kernel a σ_α(β) = β − (4/4)·α = β − α számítást normalizálja: az eredmény GYÖK marad"
    "VALÓDI (képlet-alkalmazás ⟷ konstruktor) — a zártság magja"
    [ "public export"
    , "BizReflexioSzomszed : weylReflexio (2,2,0⁶) (2,0,2,0⁵) = (0,-2,2,0⁵)"
    , "BizReflexioSzomszed = Refl" ]
    [ LépésKonstruktor "⟨α,β⟩ = 4" (show (szorzatTípusKettőEgyÉrték adat)) "a 60°-os szomszéd (F2.14)"
    , LépésKonstruktor "4 / 4 = 1" (egészSzöveg (4 `div` 4)) "egyszer hozzáadás"
    , LépésKonstruktor "σ_α(β) = β − α = (0,−2,2,0,0,0,0,0)" (reflexióSzomszédSzöveg adat)
        "a tükörrel szemben a szomszéd — az eredmény a 240 gyök egyike (zártság!)" ]
    "a Python tükröz(α, β) = (0,−2,2,0,0,0,0,0); a teljes 57 600 páros zártság a F2.21 kártyán"
    [ grafikon "SZERKEZET" "A tükrözés vektor-ábrája: β → β − α" "reflexióVektor" ""
    , grafikon "SZÁMOLÁS" "⟨α,β⟩/4 = 1 → β − α" "oszlop"
        "['⟨α,β⟩', '/4', 'β−α'], [4, 1, 0], 'lépés'"
    , grafikon "ELLENŐRZÉS" "Maradék: σ(α,β) ⟷ kernel (0 = egyezik)" "maradékSáv"
        "['σ(α,β)−kernel'], [(0 if str(list(tükröz(e8[0], (2, 0, 2, 0, 0, 0, 0, 0)))) == KERNEL['reflexioSzomszed'].replace(' ', '') else 1)]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel BizReflexioSzomszed ⟷ szimuláció" "kétÚtHíd"
        "'kernel σ(α,β) x-koord.', 0, 'szimuláció x-koord.', tükröz(e8[0], (2, 0, 2, 0, 0, 0, 0, 0))[0]" ]
    "A tükrözés a szomszédot a tükör túloldalára viszi — és az eredmény GYÖK marad. Ez az egyetlen példa a zártság magva: a teljes 57 600 páros kimerítés a F2.21-en."
    "反射把邻居送到镜面另一侧，而结果仍是根——封闭性的种子；完整的 57600 对穷举在 F2.21。"
    "Die Spiegelung trägt die Nachbarnwurzel auf die andere Seite — das Resultat bleibt Wurzel: der Kern der Abgeschlossenheit; die volle Prüfung auf F2.21."
    "‏ההשתקפות מעבירה את השכן לעבר השני של המראה — והתוצאה נשארת שורש: גרעין הסגירות; הבדיקה המלאה ב־F2.21."

  , KártyaKonstruktor "F2.20"
    "Az eloszlás: minden gyökre (1, 56, 126, 56, 1) — futásidejű kimerítés"
    "分布：每个根皆为 (1, 56, 126, 56, 1)——运行时穷举"
    "Die Verteilung: für jede Wurzel (1, 56, 126, 56, 1) — Laufzeit-Erschöpfung"
    "‏ההתפלגות: לכל שורש (1, 56, 126, 56, 1)"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "eloszlasHibakSzama : Nat (futásidőben 0) — eloszlas alfa = (1, 56, 126, 56, 1)"
    "a kernel nem bizonyítja Refl-lel a 240 eloszlást (az 240×240 kimerítés túlságosan nagy a normalizálónak) — a FUTÁSIDŐŰ KIMERÍTÉS a fedés: minden gyökre kiszámolja az eloszlást és összeveti a várttal"
    "FUTÁSIDŐŰ KIMERÍTÉS (240 gyök × 240 gyök)"
    [ "public export"
    , "eloszlas : E8Gyok -> (Nat, Nat, Nat, Nat, Nat)"
    , "eloszlas alfa = ( darab (-8), darab (-4), darab 0, darab 4, darab 8 )"
    , "eloszlasHibakSzama : Nat"
    , "eloszlasHibakSzama ="
    , "  length (filter (\\a => eloszlas a /= (1, 56, 126, 56, 1)) e8Gyokok)" ]
    [ LépésKonstruktor "a példagyök (2,2,0⁶) eloszlása" (példaEloszlásSzöveg adat)
        "futásidőben mérve: 1 ellentett, 56×120°-os, 126 merőleges, 56×60°-os, 1 önmaga"
    , LépésKonstruktor "hibás eloszlású gyökök száma" (show (eloszlásHibákSzáma adat))
        "mind a 240 gyökön kimerítve — várt érték 0"
    , LépésKonstruktor "ellenőrzés: 1+56+126+56+1" (egészSzöveg (1 + 56 + 126 + 56 + 1))
        "az eloszlás összege 240 — minden gyök pontosan osztályozva" ]
    "a Python a 240×240 mátrixon megszámolja mind az öt érték oszlopait: páronként 240, 13440, 30240, 13440, 240 (össz 57600); a rosszEloszlás száma 0"
    [ grafikon "SZERKEZET" "A 240×240 belsőszorzat-mátrix hőképe" "hőKép" ""
    , grafikon "SZÁMOLÁS" "A példagyök eloszlása: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "ELLENŐRZÉS" "Rossz eloszlású gyökök száma (várható 0)" "maradékSáv"
        "['rossz eloszlás−kernel'], [rosszEloszlás - KERNEL['eloszlasHibak']]"
    , grafikon "SPEKTRUM" "A pár-számok: 240, 13440, 30240, 13440, 240" "oszlop"
        "['−8', '−4', '0', '+4', '+8'], párszámok, 'pár'"
    , grafikon "HÍD" "Híd: kernel eloszlasHibakSzama ⟷ szimuláció rosszEloszlás" "kétÚtHíd"
        "'kernel eloszlasHibakSzama', KERNEL['eloszlasHibak'], 'szimuláció rosszEloszlás', rosszEloszlás" ]
    "A belső szorzat értékei csak ötfélék {−8,−4,0,+4,+8}, és minden gyök körül pontosan ugyanaz a zenéjű eloszlás áll: 1, 56, 126, 56, 1. Ez a krisztalografikus kvantálás numerikus arca (Conway–Sloane, SPLAG 8. fejezet)."
    "内积只取五个值 {−8,−4,0,+4,+8}，且每个根周围的分布都是 1, 56, 126, 56, 1——晶体学量子化的数值面貌。"
    "Die Innerprodukte nehmen nur fünf Werte an, und um jede Wurzel steht dieselbe Verteilung 1, 56, 126, 56, 1 — das numerische Gesicht der kristallographischen Quantelung."
    "‏המכפלות הפנימיות נוטלות חמישה ערכים בלבד, וסביב כל שורש אותה התפלגות 1, 56, 126, 56, 1 — פניו המספריים של הקוונטום הגבישי."

  , KártyaKonstruktor "F2.21"
    "A Weyl-zártság: mind az 57 600 tükrözés gyököt ad — futásidejű kimerítés"
    "外尔封闭性：57600 次反射全给出根——运行时穷举"
    "Die Weyl-Abgeschlossenheit: alle 57600 Spiegelungen ergeben Wurzeln"
    "‏סגירות וייל: כל 57600 ההשתקפויות נותנות שורש"
    "szima_ter/modul/E8BelsoSzorzat.idr"
    "idris2 szima_ter/modul/E8BelsoSzorzat.idr --exec main"
    "zarasHibakSzama : Nat (futásidőben 0)"
    "a kernel Refl-lel csak konkrét párokat bizonyít (F2.17–19); a TELJES zártság 240×240 = 57 600 páros futásidejű kimerítéssel federett: minden σ_α(β) benne van a 240-ban"
    "FUTÁSIDŐŰ KIMERÍTÉS (57 600 pár)"
    [ "public export"
    , "zar : E8Gyok -> E8Gyok -> Bool"
    , "zar alfa beta = benVan (weylReflexio alfa beta) e8Gyokok"
    , "zarasHibakSzama : Nat"
    , "zarasHibakSzama = length (filter not [ zar alfa beta | alfa <- e8Gyokok, beta <- e8Gyokok ])" ]
    [ LépésKonstruktor "a párok száma: 240 · 240" (show (gyökSzáma adat * gyökSzáma adat))
        "minden (α, β) párra kiszámoljuk σ_α(β)-t"
    , LépésKonstruktor "nem-gyök reflexiók száma" (show (zárásHibákSzáma adat))
        "futásidőben mérve — várt érték 0"
    , LépésKonstruktor "következmény: a tükrözések generálják W(E8)-t" (show (weylE8Érték adat))
        "a zártság miatt a tükrözések csoportot alkotnak — rendje 696 729 600 (F2.11–12)" ]
    "a Python halmaz-tagsággal (set) ellenőrzi mind az 57 600 tükrözést: zárásHibák = 0; a mátrix-hőképen a {−8,−4,0,+4,+8} rácsos mintázat látszik"
    [ grafikon "SZERKEZET" "A 240×240 belsőszorzat-mátrix hőképe" "hőKép" ""
    , grafikon "SZÁMOLÁS" "240·240 pár → 0 hibás tükrözés" "oszlop"
        "['240·240 pár', 'zárásHibák'], [240 * 240, zárásHibák], 'darab'"
    , grafikon "ELLENŐRZÉS" "ZárásHibák ⟷ kernel zarasHibakSzama (0 = 0)" "maradékSáv"
        "['zárás−kernel'], [zárásHibák - KERNEL['zarasHibak']]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: kernel zarasHibakSzama ⟷ szimuláció zárásHibák" "kétÚtHíd"
        "'kernel zarasHibakSzama', KERNEL['zarasHibak'], 'szimuláció zárásHibák', zárásHibák" ]
    "A tükrözések nem vezetnek ki a gyökrendszerből: mind az 57 600 reflexió-pár eredménye gyök. Ez a zártság teszi a tükrözéseket csoporttá — a W(E8) létezésének numerikus bizonyítéka."
    "反射不会走出根系：全部 57600 对的结果都是根——正是封闭性使反射成群，即 W(E8) 存在的数值证明。"
    "Die Spiegelungen verlassen das Wurzelsystem nicht: alle 57600 Paare ergeben Wurzeln — die Abgeschlossenheit macht die Spiegelungen zur Gruppe, der numerische Beweis der Existenz von W(E8)."
    "‏ההשתקפויות אינן יוצאות ממערכת השורשים: כל 57600 הזוגות נותנים שורשים — הסגירות הופכת את ההשתקפויות לחבורה, ההוכחה המספרית לקיום W(E8)."

  ]

-- ═══ 5. A KÁRTYÁK — E8Iranymutato_v1 (F2.22–F2.26) ═══
--    Az E8 kivételességének mutatói · E8 特殊性的指针

kártyaCsoportIrány : FutásiÉrtékek -> List Kártya
kártyaCsoportIrány adat = [

  KártyaKonstruktor "F2.22"
    "A típus-összeg híd: 112 + 128 = 240 (iránymutató-modul)"
    "类型之和桥：112 + 128 = 240（指针模块）"
    "Die Typensummen-Brücke: 112 + 128 = 240 (Kompassmodul)"
    "‏גשר סכום הטיפוסים: 112 + 128 = 240"
    "szima_ter/modul/E8Iranymutato_v1.idr"
    "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main"
    "TipusOsszegBizonyit : 112 + 128 = 240"
    "a kernel az összeg-típust normalizálja; a modul futásidejű számlálóval (gyokSzamSzamitott) is méri a 240-et — MINDEN IMPORTÁLVA (§24), semmi nincs újraírva"
    "KÉT ÚT (Refl-összeg ⟷ futásidejű számláló)"
    [ "public export"
    , "gyokSzamSzamitott : Integer"
    , "gyokSzamSzamitott = cast (List.length e8Gyokok)"
    , "TipusOsszegBizonyit : 112 + 128 = 240"
    , "TipusOsszegBizonyit = Refl" ]
    [ LépésKonstruktor "112 (típus-1) + 128 (típus-2)" (show (típusEgySzáma adat + típusKettőSzáma adat)) "a két típus futásidőben mért hossza"
    , LépésKonstruktor "gyokSzamSzamitott = cast (length e8Gyokok)" (show (gyökSzáma adat))
        "a teljes lista hossza Integer-re öntve — a modul saját futásidejű ellenőrzése"
    , LépésKonstruktor "TipusOsszegBizonyit : 112 + 128 = 240" (show (típusEgySzáma adat + típusKettőSzáma adat))
        "a kernel-tétel — a kártyázás célja, hogy a kettő ugyanaz a szám legyen" ]
    "a Python len(e8) = 240 és 112+128 = 240; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 gyök 2D-petri-vetülete" "petri" ""
    , grafikon "SZÁMOLÁS" "112 + 128 → 240" "oszlop"
        "['típus-1', 'típus-2', 'összes'], [len(típus1), len(típus2), len(e8)], 'darab'"
    , grafikon "ELLENŐRZÉS" "Maradék: gyökSzám ⟷ kernel (Δ = 0)" "maradékSáv"
        "['gyökSzám−kernel'], [len(e8) - KERNEL['gyokSzam']]"
    , grafikon "SPEKTRUM" "norma²-hisztogram mind a 240 gyökön" "normaHisztogram" ""
    , grafikon "HÍD" "Híd: Refl-összeg ⟷ futásidejű számláló" "kétÚtHíd"
        "'112+128 (Refl)', 112 + 128, 'gyokSzamSzamitott', KERNEL['gyokSzam']" ]
    "Az iránymutató-modul mintája: semmit nem ír újra, importálja a gyöklistát, és a kernel-tételt futásidejű számlálóval fedi. Ez a §24 mintakártyája."
    "指针模块的范式：一切导入、零重写，用运行时计数器覆盖内核定理——§24 的范例卡。"
    "Das Kompassmodul als Muster: alles importiert, nichts neu geschrieben; der Kern-Satz wird durch einen Laufzeitzähler gedeckt — die §24-Musterkarte."
    "‏מודול המצפן כדפוס: הכול מיובא, כלום לא נכתב מחדש; משפט הליבה מכוסה במונה בזמן־ריצה — כרטיס המופת של §24."

  , KártyaKonstruktor "F2.23"
    "A felezett út: 2 · 348 364 800 = 696 729 600"
    "折半之路：2 · 348364800 = 696729600"
    "Der halbierte Weg: 2 · 348364800 = 696729600"
    "‏דרך החצייה: 2 · 348364800 = 696729600"
    "szima_ter/modul/E8Iranymutato_v1.idr"
    "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main"
    "WeylRendFelezettBizonyit : 2 * 348364800 = 696729600"
    "a kernel a felezett rend megkettőzését normalizálja (Conway–Sloane, SPLAG)"
    "KÉT ÚT (felezett × 2 ⟷ teljes rend)"
    [ "public export"
    , "WeylRendFelezettBizonyit : 2 * 348364800 = 696729600"
    , "WeylRendFelezettBizonyit = Refl" ]
    [ LépésKonstruktor "W(E8) fele" (show (weylE8Érték adat `div` 2)) "a csoport fele (a lehetséges felezések egyike)"
    , LépésKonstruktor "2 · 348 364 800" (show (weylE8Érték adat)) "megkettőzve"
    , LépésKonstruktor "ellenőrzés a struktúra-úttal" (show (weylE8Érték adat))
        "W(D8)·135 = 696 729 600 (F2.11) — a felezett út ugyanoda ér" ]
    "a Python 2·348364800 = 696729600 = weylD8·trialitás; Δ = 0"
    [ grafikon "SZERKEZET" "A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)" "weylLánc" ""
    , grafikon "SZÁMOLÁS" "A felezett rend megkettőzése" "oszlop"
        "['fél', 'fél', '2·fél'], [weylE8 // 2, weylE8 // 2, 2 * (weylE8 // 2)], 'elem'"
    , grafikon "ELLENŐRZÉS" "Maradék: felezett út ⟷ kernel (Δ = 0)" "maradékSáv"
        "['2·fél−kernel'], [2 * 348364800 - KERNEL['weylE8']]"
    , grafikon "SPEKTRUM" "A prímtornyok: 2¹⁴, 3⁵, 5², 7" "prímTorony"
        "['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']"
    , grafikon "HÍD" "Híd: 2·348364800 ⟷ kernel W(E8)" "kétÚtHíd"
        "'2·348364800', 2 * 348364800, 'kernel W(E8)', KERNEL['weylE8']" ]
    "A W(E8) rendje felezhető úton is előáll: 2 · 348 364 800. A különös felezés a SPLAG-hivatkozás nyomán él a modulban — harmadik független út a 696 729 600-hoz."
    "W(E8) 的阶也可由折半路得出：2 · 348364800——通往 696729600 的第三条独立路。"
    "Die Ordnung von W(E8) auch auf dem halbierten Weg: 2 · 348364800 — ein dritter unabhängiger Weg zu 696729600."
    "‏סדר W(E8) גם בדרך החצייה: 2 · 348364800 — נתיב שלישי ועצמאי אל 696729600."

  , KártyaKonstruktor "F2.24"
    "A prímtényezős út: 16384·243·25·7 = 696 729 600 (iránymutató)"
    "质因数之路：16384·243·25·7 = 696729600"
    "Der Primfaktorenweg: 16384·243·25·7 = 696729600"
    "‏דרך הגורמים הראשוניים: 16384·243·25·7"
    "szima_ter/modul/E8Iranymutato_v1.idr"
    "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main"
    "WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600"
    "a kernel a prímtényezős szorzatot normalizálja ugyanahhoz a rendhez — az E8Gyokok_v2 bizWeylE8Prím-jének importált ikertestvére"
    "KÉT ÚT-HÍD (struktúra ⟷ prímek — az iránymutató modulban)"
    [ "public export"
    , "WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600"
    , "WeylRendPrimtenyezosBizonyit = Refl" ]
    [ LépésKonstruktor "2¹⁴ · 3⁵ · 5² · 7" (show (weylE8PrímÚtÉrték adat)) "a prímfelbontás"
    , LépésKonstruktor "W(D8) · 135" (show (weylE8Érték adat)) "a struktúra-út (F2.11)"
    , LépésKonstruktor "Δ a két út közt" (show (weylE8PrímÚtÉrték adat - weylE8Érték adat))
        "a két fogalmilag különböző konstrukció maradéka: nulla" ]
    "a Python prímÚtWeyl = weylE8 = 696729600; Δ = 0"
    [ grafikon "SZERKEZET" "A prím-torony: 2¹⁴ · 3⁵ · 5² · 7" "prímTorony"
        "['2¹⁴','3⁵','5²','7'], KERNEL['weylPrimTenyezok']"
    , grafikon "SZÁMOLÁS" "A prím-út szorzata" "oszlop"
        "['16384·243·25·7'], [16384 * 243 * 25 * 7], 'érték'"
    , grafikon "ELLENŐRZÉS" "Maradék: prím-út ⟷ kernel (Δ = 0)" "maradékSáv"
        "['prímút−kernel'], [prímÚtWeyl - KERNEL['weylE8Prim']]"
    , grafikon "SPEKTRUM" "A Weyl-lánc: 2⁷ → 8! → 135 → W(E8)" "weylLánc" ""
    , grafikon "HÍD" "Híd: prím-út ⟷ struktúra-út" "kétÚtHíd"
        "'prím 2¹⁴·3⁵·5²·7', prímÚtWeyl, 'struktúra W(D8)·135', weylE8" ]
    "Ugyanaz a két-út-híd, mint F2.12 — de az iránymutató-modul saját Refl-jével: a modulok egymás tényeit importálva fedik, nem másolva (§24)."
    "与 F2.12 相同的两路桥，但由指针模块自己的 Refl 覆盖：模块通过导入而非复制来相互印证（§24）。"
    "Dieselbe Zwei-Wege-Brücke wie F2.12, doch mit dem eigenen Refl des Kompassmoduls: Module decken einander durch Import, nicht durch Kopie."
    "‏אותו גשר כמו F2.12, אך עם ה־Refl של מודול המצפן: מודולים מכסים זה את זה בייבוא, לא בהעתקה."

  , KártyaKonstruktor "F2.25"
    "E8 × E8 = 496 — a heterotikus string dimenziója"
    "E8 × E8 = 496——杂弦维度"
    "E8 × E8 = 496 — die Dimension der heterotischen Stringtheorie"
    "‏E8 × E8 = 496 — ממד המיתר ההטרוטי"
    "szima_ter/modul/E8Iranymutato_v1.idr"
    "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main"
    "E8E8DimenzioBizonyit : 248 * 2 = 496"
    "a kernel a két 248-as Lie-algebra szorzatát normalizálja: a bal E8 a tér, a jobb E8 a szín (AGENTS §7)"
    "KÉT ÚT (dimenzió-szorzat ⟷ fizikai értelmezés)"
    [ "public export"
    , "e8E8Dimenzio : Integer   -- 496"
    , "E8E8DimenzioBizonyit : 248 * 2 = 496"
    , "E8E8DimenzioBizonyit = Refl" ]
    [ LépésKonstruktor "248 (E8 dimenzió, F2.13)" (show (e8DimenzióÉrték adat)) "gyökök + Cartan"
    , LépésKonstruktor "248 · 2" (show (e8e8DimenzióÉrték adat)) "két E8: bal (tér) és jobb (szín)"
    , LépésKonstruktor "496 — a heterotikus string" (show (e8e8DimenzióÉrték adat))
        "a gauge-csoport E8×E8 esetén a bozonok 496 szabadságfokon élnek — ez a projekt fizikai horgonya" ]
    "a Python 248·2 = 496; Δ = 0"
    [ grafikon "SZERKEZET" "Két E8: bal (tér) × jobb (szín)" "oszlop"
        "['E8 (bal, tér)', 'E8 (jobb, szín)', 'E8×E8'], [248, 248, 248 * 2], 'dimenzió'"
    , grafikon "SZÁMOLÁS" "248 · 2 → 496" "oszlop"
        "['240+8', '240+8', '496'], [240 + 8, 240 + 8, (240 + 8) * 2], 'dim'"
    , grafikon "ELLENŐRZÉS" "Maradék: 496 ⟷ kernel (Δ = 0)" "maradékSáv"
        "['496−kernel'], [248 * 2 - KERNEL['e8e8Dimenzio']]"
    , grafikon "SPEKTRUM" "A 240 gyök petri-vetülete" "petri" ""
    , grafikon "HÍD" "Híd: dimenzió-szorzat ⟷ kernel 496" "kétÚtHíd"
        "'248·2', 248 * 2, 'kernel e8E8Dimenzio', KERNEL['e8e8Dimenzio']" ]
    "A 496 a heterotikus string dimenziója: a bal E8 a tér, a jobb E8 a szín oldala. A projekt központi fizikai sejtése ebből a számból nő ki (AGENTS §7)."
    "496 是杂弦维度：左 E8 主空间，右 E8 主颜色——项目核心物理猜想由此而生（AGENTS §7）。"
    "496 ist die Dimension der heterotischen Stringtheorie: links E8 der Raum, rechts E8 die Farbe — die zentrale physikalische Vermutung des Projekts."
    "‏496 הוא ממד המיתר ההטרוטי: שמאל E8 המרחב, ימין E8 הצבע — משם צומחת ההשערה הפיזיקלית המרכזית."

  , KártyaKonstruktor "F2.26"
    "A gyökök felezése: 240 = 2 · 120 — a pozitív/negatív ábécé"
    "根的对分：240 = 2·120——正负字母表"
    "Die Halbierung der Wurzeln: 240 = 2 · 120 — das positive/negative Alphabet"
    "‏חלוקת השורשים: 240 = 2·120"
    "szima_ter/modul/E8Iranymutato_v1.idr"
    "idris2 szima_ter/modul/E8Iranymutato_v1.idr --exec main"
    "GyokFelezingBizonyit : 240 = 2 * 120"
    "a kernel a felezést normalizálja: minden gyök párja az ellentettjével — a pozitív gyökök száma 120"
    "KÉT ÚT (párosítás ⟷ felezés)"
    [ "public export"
    , "GyokFelezingBizonyit : 240 = 2 * 120"
    , "GyokFelezingBizonyit = Refl" ]
    [ LépésKonstruktor "240 gyök" (show (gyökSzáma adat)) "a teljes rendszer (F2.05)"
    , LépésKonstruktor "α és −α párok" (egészSzöveg 120) "a centrális szimmetria miatt fele-fele (F2.15)"
    , LépésKonstruktor "120 pozitív gyök" (egészSzöveg 120)
        "a pozitív ábécé — a nyelv építőkőze (E8FazisKapcsolat_v2: pozitivGyokok)" ]
    "a Python párosítja a gyököket (v, −v): 120 pár; 2·120 = 240; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 gyök 2D-petri-vetülete (α, −α átellenesen)" "petri" ""
    , grafikon "SZÁMOLÁS" "2 · 120 → 240" "oszlop"
        "['120 pozitív', '120 negatív', 'összes'], [120, 120, 240], 'gyök'"
    , grafikon "ELLENŐRZÉS" "Maradék: felezés ⟷ enumeráció (Δ = 0)" "maradékSáv"
        "['párok−120'], [len([(v, tuple(-x for x in v)) for v in e8 if tuple(-x for x in v) in e8Halmaz]) - 240]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1)" "eloszlás" ""
    , grafikon "HÍD" "Híd: 2·120 ⟷ enumeráció 240" "kétÚtHíd"
        "'2·120', 2 * 120, 'enumeráció', len(e8)" ]
    "A 240 gyök 120 ±-párba rendezhető: a pozitív fél a szimbólum-ábécé (a nyelvi réteg ezt használja). A felezés a centrális szimmetria közvetlen következménye."
    "240 个根可排成 120 个 ± 对：正半是符号字母表（语言层所用）；对分是中心对称的直接推论。"
    "Die 240 Wurzeln bilden 120 ±-Paare: die positive Hälfte ist das Symbolalphabet (die Sprachschicht benutzt es) — die Halbierung folgt direkt aus der Zentralsymmetrie."
    "‏240 השורשים יוצרים 120 זוגות ±: החצי החיובי הוא אלפבית הסמלים — החלוקה נובעת ישירות מהסימטריה המרכזית."

  ]

-- ═══ 6. A KÁRTYÁK — E8TizenhatPenge (F2.27–F2.35) + az F4-híd (F2.36) ═══
--    A 16 penge és a 256-os híd · 16 刃与 256 之桥

kártyaCsoportPenge : FutásiÉrtékek -> List Kártya
kártyaCsoportPenge adat = [

  KártyaKonstruktor "F2.27"
    "A Cl(4) fokszámainak összege: 1+4+6+4+1 = 16 (binomiális tétel)"
    "Cl(4) 各阶之和：1+4+6+4+1 = 16（二项式定理）"
    "Die Summe der Cl(4)-Grade: 1+4+6+4+1 = 16 (Binomialtheorem)"
    "‏סכום דרגות Cl(4): 1+4+6+4+1 = 16"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizFokszamOsszeg : 1 + 4 + 6 + 4 + 1 = 16"
    "a kernel az öt binomiális együttható összegét normalizálja a 16-hoz"
    "KÉT ÚT (binomiális összeg ⟷ hatvány — l. F2.28)"
    [ "public export"
    , "pengeFok : Integer -> Nat"
    , "fokSzamlalok : (Nat, Nat, Nat, Nat, Nat)"
    , "BizFokszamOsszeg : 1 + 4 + 6 + 4 + 1 = 16"
    , "BizFokszamOsszeg = Refl" ]
    [ LépésKonstruktor "C(4,0)=1, C(4,1)=4, C(4,2)=6, C(4,3)=4, C(4,4)=1" "1, 4, 6, 4, 1"
        "a {1,2,3,4} halmaz részhalmazai fokszám szerint — futásidőben a fokSzamlalok méri"
    , LépésKonstruktor "1+4+6+4+1" (show (fokszámÖsszegÉrték adat)) "a binomiális együtthatók összege"
    , LépésKonstruktor "2⁴ = 16" (egészSzöveg 16) "a binomiális tétel: Σ C(4,k) = 2⁴ (a második út — F2.28)" ]
    "a Python popcount-szal fokszámot számol mind a 16 pengére: (1, 4, 6, 4, 1); az összeg 16; Δ = 0"
    [ grafikon "SZERKEZET" "A Cl(4) fokszámai: (1, 4, 6, 4, 1)" "pengeFok" ""
    , grafikon "SZÁMOLÁS" "C(4,k) oszlopok: 1, 4, 6, 4, 1" "oszlop"
        "['fok 0', 'fok 1', 'fok 2', 'fok 3', 'fok 4'], fokszámok, 'penge'"
    , grafikon "ELLENŐRZÉS" "Maradék: fokszám-összeg ⟷ kernel (Δ = 0)" "maradékSáv"
        "['fokösszeg−kernel'], [sum(fokszámok) - KERNEL['fokszamOsszeg']]"
    , grafikon "SPEKTRUM" "A Hodge-duál nyilai: k ↔ 4−k" "hodgeNyilak" ""
    , grafikon "HÍD" "Híd: binomiális összeg ⟷ szimuláció" "kétÚtHíd"
        "'1+4+6+4+1', 1 + 4 + 6 + 4 + 1, 'szimuláció', sum(fokszámok)" ]
    "A 4 dimenziós Clifford-algebra pengéi a részhalmazok: fokszám szerint 1, 4, 6, 4, 1 — a binomiális tétel élő példája, és a Hamming-súlyeloszlás (1,7,7,1) testvére."
    "四维 Clifford 代数的刃即子集：按阶为 1,4,6,4,1——二项式定理的活例，也是汉明重量分布 (1,7,7,1) 的姊妹。"
    "Die Blades der vierdimensionalen Clifford-Algebra sind die Teilmengen: nach Grad 1, 4, 6, 4, 1 — das lebende Binomialtheorem und Schwester der Hamming-Verteilung (1,7,7,1)."
    "‏להבי אלגברת קליפורד הארבע־ממדית הם תת־קבוצות: לפי דרגה 1, 4, 6, 4, 1 — משפט הבינום החי, אחותה של התפלגות המינג (1,7,7,1)."

  , KártyaKonstruktor "F2.28"
    "A 2⁴ = 16 — a pengék számának hatvány-útja"
    "2⁴ = 16——刃数的幂路"
    "2⁴ = 16 — der Potenzweg der Blade-Anzahl"
    "‏2⁴ = 16 — דרך החזקה של מספר הלהבים"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizKettoNegyedik : 2 * 2 * 2 * 2 = 16"
    "a kernel a négy kettes szorzatát normalizálja a 16-hoz"
    "KÉT ÚT (hatvány ⟷ binomiális összeg)"
    [ "public export"
    , "BizKettoNegyedik : 2 * 2 * 2 * 2 = 16"
    , "BizKettoNegyedik = Refl" ]
    [ LépésKonstruktor "2 · 2 · 2 · 2" (egészSzöveg 16) "négy generátor: mindegyik jelen/nincs"
    , LépésKonstruktor "= 16 penge" (show (fokszámÖsszegÉrték adat)) "ugyanaz, mint 1+4+6+4+1 (F2.27)"
    , LépésKonstruktor "bitmask 0..15" (egészSzöveg 15) "a pengék természetes indexelése: 0000₂ … 1111₂" ]
    "a Python 2**4 = 16 = len(pengék); Δ = 0"
    [ grafikon "SZERKEZET" "240 gyök + 16 penge egy rácsban" "híd256Rács" ""
    , grafikon "SZÁMOLÁS" "A kettő-hatvány létra: 2¹…2⁴" "oszlop"
        "['2¹','2²','2³','2⁴'], [2**k for k in range(1, 5)], 'hatvány'"
    , grafikon "ELLENŐRZÉS" "Maradék: 2⁴ ⟷ len(pengék) (Δ = 0)" "maradékSáv"
        "['2⁴−pengék'], [2**4 - len(pengék)]"
    , grafikon "SPEKTRUM" "A Cl(4) fokszámai: (1, 4, 6, 4, 1)" "pengeFok" ""
    , grafikon "HÍD" "Híd: 2·2·2·2 ⟷ enumeráció" "kétÚtHíd"
        "'2·2·2·2', 2 * 2 * 2 * 2, 'enumeráció len(pengék)', len(pengék)" ]
    "A 16 penge két úton áll elő: négy bit helyeinek hatványaaként és a binomiális együtthatók összegeként. A két út a F2.27-tel közös híd."
    "16 刃由两条路得出：四个比特的幂次与二项式系数之和；两路之桥与 F2.27 共享。"
    "Die 16 Blades entstehen auf zwei Wegen: als Potenz von vier Bits und als Summe der Binomialkoeffizienten — die Brücke teilt sich mit F2.27."
    "‏16 הלהבים נובעים בשני נתיבים: חזקה של ארבעה סיביות וסכום מקדמים בינומיים — הגשר משותף עם F2.27."

  , KártyaKonstruktor "F2.29"
    "A Hodge-duál példája: duál(e1∧e2) = e3∧e4 (3 → 12)"
    "霍奇对偶例：duál(e1∧e2) = e3∧e4（3 → 12）"
    "Das Hodge-Dual-Beispiel: duál(e1∧e2) = e3∧e4 (3 → 12)"
    "‏דואל הודג' לדוגמה: 3 → 12"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizHodgePelda : pengeDual 3 = 12"
    "a kernel a bitkomplemens számítást normalizálja: 0011₂ → 1100₂"
    "VALÓDI (bitkomplemens ⟷ konstruktor)"
    [ "public export"
    , "pengeDual : Integer -> Integer"
    , "pengeDual x = 15 - x"
    , "BizHodgePelda : pengeDual 3 = 12"
    , "BizHodgePelda = Refl" ]
    [ LépésKonstruktor "3 = 0011₂ = e1∧e2" (egészSzöveg 3) "az első két generátor jelen"
    , LépésKonstruktor "15 − 3 = 12" (show (hodgePéldaÉrték adat)) "a bitmask komplemense (nincs átvitel)"
    , LépésKonstruktor "12 = 1100₂ = e3∧e4" (show (hodgePéldaÉrték adat))
        "a duál bivektor: a hiányzó generátorok éppenessége" ]
    "a Python duál(3) = 15−3 = 12; fok(3) = fok(12) = 2; Δ = 0"
    [ grafikon "SZERKEZET" "A Hodge-duál nyilai: k ↔ 4−k mind a 16 pengén" "hodgeNyilak" ""
    , grafikon "SZÁMOLÁS" "15 − 3 → 12" "oszlop"
        "['3 (0011₂)', '12 (1100₂)'], [3, 12], 'maszk'"
    , grafikon "ELLENŐRZÉS" "Maradék: duál(3) ⟷ kernel (Δ = 0)" "maradékSáv"
        "['duál(3)−kernel'], [duál(3) - KERNEL['hodgePelda']]"
    , grafikon "SPEKTRUM" "A Cl(4) fokszámai: (1, 4, 6, 4, 1)" "pengeFok" ""
    , grafikon "HÍD" "Híd: kernel BizHodgePelda ⟷ szimuláció duál(3)" "kétÚtHíd"
        "'kernel pengeDual 3', KERNEL['hodgePelda'], 'szimuláció duál(3)', duál(3)" ]
    "A Hodge-duál a fokot kiegészíti 4-ig: a 2-fokú e1∧e2 duálja a szintén 2-fokú e3∧e4. A bitkomplemens átvitel nélküli — a bitek függetlenek."
    "霍奇对偶把阶补足到 4：2 阶的 e1∧e2 之对偶是同为 2 阶的 e3∧e4；按位取反无进位——比特彼此独立。"
    "Das Hodge-Dual ergänzt den Grad bis 4: das Dual des 2-gradigen e1∧e2 ist das ebenfalls 2-gradige e3∧e4; das Bitkomplement ohne Übertrag."
    "‏דואל הודג' משלים את הדרגה עד 4: הדואל של e1∧e2 הוא e3∧e4; השלמת הסיביות בלי נשיאה."

  , KártyaKonstruktor "F2.30"
    "A duál involúció: duál(duál(5)) = 5"
    "对合：duál(duál(5)) = 5"
    "Die Dual-Involution: duál(duál(5)) = 5"
    "‏חזרה כפולה: duál(duál(5)) = 5"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizHodgeInvolutioPelda : pengeDual (pengeDual 5) = 5"
    "a kernel a kétszeres komplemenst normalizálja az identitásra (0101₂)"
    "VALÓDI (involúció ⟷ konstruktor)"
    [ "public export"
    , "BizHodgeInvolutioPelda : pengeDual (pengeDual 5) = 5"
    , "BizHodgeInvolutioPelda = Refl" ]
    [ LépésKonstruktor "5 = 0101₂" (egészSzöveg 5) "e1∧e3"
    , LépésKonstruktor "duál(5) = 15 − 5 = 10" (egészSzöveg 10) "1010₂ = e2∧e4"
    , LépésKonstruktor "duál(duál(5)) = 15 − 10 = 5" (show (hodgeInvolúcióPéldaÉrték adat))
        "a kétszeres komplemens visszaadja az eredetit — involúció" ]
    "a Python mind a 16 pengén ellenőrzi: duál(duál(p)) = p (hibák: 0); fok(duál(p)) + fok(p) = 4 mindig"
    [ grafikon "SZERKEZET" "A Hodge-duál nyilai: k ↔ 4−k" "hodgeNyilak" ""
    , grafikon "SZÁMOLÁS" "5 → 10 → 5 (oda-vissza)" "oszlop"
        "['duál(5)', 'duál(duál(5))'], [duál(5), duál(duál(5))], 'maszk'"
    , grafikon "ELLENŐRZÉS" "Involúció-hibák a 16 pengén (várható 0)" "maradékSáv"
        "['hodgeInvolúcióHibák'], [hodgeInvolúcióHibák]"
    , grafikon "SPEKTRUM" "A Cl(4) fokszámai: (1, 4, 6, 4, 1)" "pengeFok" ""
    , grafikon "HÍD" "Híd: kernel duál(duál(5)) ⟷ szimuláció" "kétÚtHíd"
        "'kernel pengeDual (pengeDual 5)', KERNEL['hodgeInvolutioPelda'], 'szimuláció', duál(duál(5))" ]
    "A Hodge-duál involúció: kétszer alkalmazva az identitás. Ugyanez a szerkezet él a Weyl-tükrözésnél (σ² = id) — a duális szerkezetek közös mintája."
    "霍奇对合：两次作用等于恒等；与外尔反射 σ² = id 同构——对偶结构的共同模式。"
    "Das Hodge-Dual ist eine Involution — dasselbe Muster wie die Weyl-Spiegelung σ² = id: das gemeinsame Bild dualer Strukturen."
    "‏דואל הודג' הוא אינבולוציה — אותו מופע כמו השתקפות וייל σ² = id: תבנית משותפת למבנים דואליים."

  , KártyaKonstruktor "F2.31"
    "A Hamming-kód első kódszava: [1,0,0,0] → [1,0,0,0,0,1,1]"
    "汉明码首码字：[1,0,0,0] → [1,0,0,0,0,1,1]"
    "Das erste Hamming-Codewort: [1,0,0,0] → [1,0,0,0,0,1,1]"
    "‏מילת הקוד הראשונה: [1,0,0,0] → [1,0,0,0,0,1,1]"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizKodszoElso : kodszamitas [1,0,0,0] = [1,0,0,0,0,1,1]"
    "a kernel az m·G mod 2 mátrix-szorzást hét koordinátán normalizálja"
    "VALÓDI (m·G mod 2 ⟷ kódszó)"
    [ "public export"
    , "kodszamitas : List Integer -> List Integer"
    , "-- a 7 bit: [idő, okság, tér, szín, hang, fázis, mód]"
    , "BizKodszoElso : kodszamitas [1,0,0,0] = [1,0,0,0,0,1,1]"
    , "BizKodszoElso = Refl" ]
    [ LépésKonstruktor "az üzenet m = [1,0,0,0]" (show (kódszóElsőLista adat))
        "csak az első (idő) bit van bekapcsolva"
    , LépésKonstruktor "m · G mod 2" (show (kódszóElsőLista adat))
        "a generátormátrix első sora: [1,0,0,0,0,1,1] — az idő bit + a fázis és mód paritások"
    , LépésKonstruktor "a 7 bit jelentése" "[idő, okság, tér, szín, hang, fázis, mód]"
        "a kódszó hét dimenziója — a Steane [[7,1,3]] klasszikus alapja" ]
    "a Python ugyanezt a G-mátrixszal számolja (a KERNEL-be az Idris show generaloSorok kerül): kódszavak[8] = [1,0,0,0,0,1,1]; Δ = 0"
    [ grafikon "SZERKEZET" "A 16 kódszó 7 bites rácsa" "kódszóRács" ""
    , grafikon "SZÁMOLÁS" "4 bites üzenet → 7 bites kódszó" "oszlop"
        "['üzenet bit', 'kódszó bit'], [4, 7], 'bit'"
    , grafikon "ELLENŐRZÉS" "Maradék: első kódszó ⟷ kernel (0 = egyezik)" "maradékSáv"
        "['kódszó1−kernel'], [(0 if kódszavak[8] == KERNEL['kodszoElso'] else 1)]"
    , grafikon "SPEKTRUM" "A súlyeloszlás: (1, 7, 7, 1)" "kódszóSúly" ""
    , grafikon "HÍD" "Híd: kernel kódszó súlya ⟷ szimuláció súlya" "kétÚtHíd"
        "'kernel első kódszó súlya', sum(KERNEL['kodszoElso']), 'szimuláció súlya', sum(kódszavak[8])" ]
    "A Hamming [7,4,3] kód a Steane [[7,1,3]] klasszikus alapja: 4 információs bitből 7 bites kódszó. Az első kódszó az idő-bitől a fázisig és módig feszül ki."
    "汉明 [7,4,3] 码是 Steane [[7,1,3]] 的经典基础：4 信息位生成 7 位码字；首码字从时间位延伸到相位与方式。"
    "Der Hamming-Code ist die klassische Grundlage des Steane-Codes: aus 4 Informationsbits wird ein 7-Bit-Codewort."
    "‏קוד המינג הוא היסוד הקלאסי של קוד Steane: מ־4 סיביות מידע נוצרת מילת קוד בת 7 סיביות."

  , KártyaKonstruktor "F2.32"
    "A mind-egyes kódszó: [1,1,1,1] → [1,1,1,1,1,1,1] (súly 7)"
    "全一码字：[1,1,1,1] → [1,1,1,1,1,1,1]（重量 7）"
    "Das All-Eins-Codewort: [1,1,1,1] → [1,1,1,1,1,1,1]"
    "‏מילת הקוד הכול־אחדים: [1,1,1,1] → [1,1,1,1,1,1,1]"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizKodszoMindEgyes : kodszamitas [1,1,1,1] = [1,1,1,1,1,1,1]"
    "a kernel a maximális súlyú kódszót normalizálja: mind a hét bit egyes"
    "VALÓDI (m·G mod 2 ⟷ kódszó)"
    [ "public export"
    , "BizKodszoMindEgyes : kodszamitas [1,1,1,1] = [1,1,1,1,1,1,1]"
    , "BizKodszoMindEgyes = Refl" ]
    [ LépésKonstruktor "m = [1,1,1,1]" (show (kódszóMindEgyesLista adat)) "mind a négy információs bit"
    , LépésKonstruktor "m · G mod 2" (show (kódszóMindEgyesLista adat)) "a paritások is mind egyesek lesznek"
    , LépésKonstruktor "súly = 7" (egészSzöveg 7) "a maximális súly — az (1,7,7,1) eloszlás utolsó tagja" ]
    "a Python kódszavak[15] = [1,1,1,1,1,1,1], súly 7; Δ = 0"
    [ grafikon "SZERKEZET" "A 16 kódszó 7 bites rácsa" "kódszóRács" ""
    , grafikon "SZÁMOLÁS" "A súlyok: 0, 3, 4, 7" "oszlop"
        "['w=0', 'w=3', 'w=4', 'w=7'], súlyEloszlás, 'kódszó'"
    , grafikon "ELLENŐRZÉS" "Maradék: mind-egyes kódszó ⟷ kernel (0 = egyezik)" "maradékSáv"
        "['kódszó16−kernel'], [(0 if kódszavak[15] == KERNEL['kodszoMindEgyes'] else 1)]"
    , grafikon "SPEKTRUM" "A súlyeloszlás: (1, 7, 7, 1)" "kódszóSúly" ""
    , grafikon "HÍD" "Híd: kernel súly 7 ⟷ szimuláció súly 7" "kétÚtHíd"
        "'kernel mind-egyes súlya', sum(KERNEL['kodszoMindEgyes']), 'szimuláció', sum(kódszavak[15])" ]
    "A kód maximális súlyú szava a hét egyes: az összes dimenzió (idő…mód) egyszerre aktív. Az (1,7,7,1) eloszlás szélei: az üres és a teli szó."
    "码的最大重量字是七个一：所有维度同时激活；(1,7,7,1) 分布的两端是空词与满词。"
    "Das Wort maximalen Gewichts sind sieben Einsen: alle Dimensionen gleichzeitig aktiv; die Ränder der (1,7,7,1)-Verteilung sind das leere und das volle Wort."
    "‏מילת המשקל המרבי היא שבע אחדות: כל הממדים פעילים יחד; קצוות ההתפלגות (1,7,7,1) הם המילה הריקה והמלאה."

  , KártyaKonstruktor "F2.33"
    "A súlyeloszlás összege: 1+7+7+1 = 16 — a (1,4,6,4,1) testvére"
    "重量分布之和：1+7+7+1 = 16——(1,4,6,4,1) 之姊妹"
    "Die Summe der Gewichtsverteilung: 1+7+7+1 = 16"
    "‏סכום התפלגות המשקלים: 1+7+7+1 = 16"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizSulyOsszeg : 1 + 7 + 7 + 1 = 16"
    "a kernel a súlyeloszlás összegét normalizálja a kódszavak számára"
    "KÉT ÚT (súly-binning ⟷ fokszám-binning)"
    [ "public export"
    , "kodSuly : List Integer -> Nat"
    , "BizSulyOsszeg : 1 + 7 + 7 + 1 = 16"
    , "BizSulyOsszeg = Refl" ]
    [ LépésKonstruktor "w=0: 1, w=3: 7, w=4: 7, w=7: 1" "1, 7, 7, 1"
        "futásidőben mérve a 16 kódszón (a kodSuly mindegyikén)"
    , LépésKonstruktor "1+7+7+1" (show (súlyÖsszegÉrték adat)) "mind a 16 kódszó pontosan egy binben"
    , LépésKonstruktor "a Hodge-tükrözés: (1,4,6,4,1) ↔ (1,7,7,1)" "a Hodge testvére"
        "a súly-fokszám duál a kód és a Clifford-algebra közti szerkezeti híd (a terv „testvér-szimmetriája”)" ]
    "a Python megszámolja a súlyokat: (1, 7, 7, 1), összeg 16; min távolság 3; Δ = 0"
    [ grafikon "SZERKEZET" "A súlyeloszlás: (1, 7, 7, 1)" "kódszóSúly" ""
    , grafikon "SZÁMOLÁS" "1+7+7+1 → 16" "oszlop"
        "['w=0', 'w=3', 'w=4', 'w=7'], súlyEloszlás, 'kódszó'"
    , grafikon "ELLENŐRZÉS" "Maradék: súly-összeg ⟷ kernel (Δ = 0)" "maradékSáv"
        "['súlyösszeg−kernel'], [sum(súlyEloszlás) - KERNEL['sulyOsszeg']]"
    , grafikon "SPEKTRUM" "A Cl(4) fokszámai: (1, 4, 6, 4, 1) — a testvér" "pengeFok" ""
    , grafikon "HÍD" "Híd: (1,7,7,1) összeg ⟷ (1,4,6,4,1) összeg" "kétÚtHíd"
        "'1+7+7+1 (kódszó)', sum(súlyEloszlás), '1+4+6+4+1 (penge)', sum(fokszámok)" ]
    "A 16 kódszó súly szerint 1, 7, 7, 1 — ugyanaz a palindrom minta, mint a pengék fokszámai (1,4,6,4,1). Két 16-os szerkezet, egy tükör-alak: a kód és a geometria testvérei."
    "16 个码字按重量 1,7,7,1——与刃的阶数 (1,4,6,4,1) 同为回文：码与几何是姊妹。"
    "Die 16 Codewörter nach Gewicht 1, 7, 7, 1 — dasselbe Palindrom wie die Blade-Grade (1,4,6,4,1): Code und Geometrie sind Geschwister."
    "‏16 מילות הקוד לפי משקל 1, 7, 7, 1 — אותו פלינדרום כמו דרגות הלהבים: הקוד והגאומטריה אחיות."

  , KártyaKonstruktor "F2.34"
    "A 256-OS HÍD: 240 gyök (TARTALOM) + 16 penge (KERET) = 256 = 2⁸"
    "256 之桥：240 根（内容）+ 16 刃（框架）= 256 = 2⁸"
    "DIE 256-BRÜCKE: 240 Wurzeln (Inhalt) + 16 Blades (Rahmen) = 256 = 2⁸"
    "‏גשר 256: 240 שורשים (תוכן) + 16 להבים (מסגרת) = 256 = 2⁸"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizHid : 240 + 16 = 256"
    "a kernel a gyökök és pengék összegét normalizálja a 2⁸-hoz — KÉT FÜGGETLEN ÚT: az E8-kombinatorika (240) ÉS a Cl(4)-binomiálisok (16) ugyanabba a 256-os térbe futnak"
    "KÉT ÚT-HÍD (kombinatorika ⟷ binomiális)"
    [ "public export"
    , "BizHid : 240 + 16 = 256"
    , "BizHid = Refl"
    , "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2" ]
    [ LépésKonstruktor "240 (E8 gyökök — kombinatorika, F2.05)" (show (gyökSzáma adat)) "a tartalom: a 240 szimbólum"
    , LépésKonstruktor "16 (Cl(4) pengék — binomiálisok, F2.27)" (show (fokszámÖsszegÉrték adat)) "a keret: 1+4+6+4+1"
    , LépésKonstruktor "240 + 16" (show (híd256Érték adat)) "tartalom + keret = a teljes bájt"
    , LépésKonstruktor "2⁸ (a második út)" (egészSzöveg 256) "a nyolcbites tér — a híd megáll" ]
    "a Python len(e8) + len(pengék) = 240 + 16 = 256 = 2**8; Δ = 0. A SEJTÉS (a felhasználó, 2026-08-21): a 240 kódszó 16 keret-biten tárolható — ÁLLAPOT: SPECULATÍV (a számok bizonyítva, az értelmezés sejtés)"
    [ grafikon "SZERKEZET" "240 gyök + 16 penge egy rácsban (a 16×16 mező)" "híd256Rács" ""
    , grafikon "SZÁMOLÁS" "240 + 16 → 256" "oszlop"
        "['E8 gyök', 'penge', 'összes'], [len(e8), len(pengék), len(e8) + len(pengék)], 'elem'"
    , grafikon "ELLENŐRZÉS" "Maradék: híd ⟷ kernel (Δ = 0)" "maradékSáv"
        "['híd−kernel'], [len(e8) + len(pengék) - KERNEL['hid256']]"
    , grafikon "SPEKTRUM" "A (1,7,7,1) súly- ⟷ (1,4,6,4,1) fok-tükrözés" "pengeFok" ""
    , grafikon "HÍD" "Híd: 240+16 enumeráció ⟷ 2⁸ = 256" "kétÚtHíd"
        "'240+16 enumeráció', len(e8) + len(pengék), '2⁸', 2**8" ]
    "A fejezet központi hídja: a 240 E8-gyök (tartalom) és a 16 Cl(4)-penge (keret) együtt a 256-os tér — egy bájt. A szám két úton bizonyított; az értelmezés (a kvantum-távíró sejtése) SPECULATÍV jelölésű."
    "本章核心之桥：240 个 E8 根（内容）与 16 刃（框架）合成 256 空间——一个字节；数字经两路证明，解释（量子电报猜想）标注为推测。"
    "Die zentrale Brücke: 240 Wurzeln (Inhalt) und 16 Blades (Rahmen) ergeben den 256-Raum — ein Byte; die Zahlen sind auf zwei Wegen bewiesen, die Deutung SPEKULATIV markiert."
    "‏הגשר המרכזי: 240 שורשים ו־16 להבים יוצרים את מרחב 256 — בייט אחד; המספרים הוכחו בשני נתיבים, הפרשנות מסומנת כספקולטיבית."

  , KártyaKonstruktor "F2.35"
    "A 256 = 2⁸ — a híd második (hatvány-) útja"
    "256 = 2⁸——桥的幂路"
    "256 = 2⁸ — der Potenzweg der Brücke"
    "‏256 = 2⁸ — דרך החזקה של הגשר"
    "szima_ter/modul/E8TizenhatPenge.idr"
    "idris2 szima_ter/modul/E8TizenhatPenge.idr --exec main"
    "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2"
    "a kernel a nyolc kettes szorzatát normalizálja a 256-hoz"
    "KÉT ÚT (hatvány ⟷ enumeráció)"
    [ "public export"
    , "BizKettoNyolcadik : 256 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2"
    , "BizKettoNyolcadik = Refl" ]
    [ LépésKonstruktor "2 · 2 · 2 · 2 · 2 · 2 · 2 · 2" (egészSzöveg 256) "nyolc bit: mind kétféle lehet"
    , LépésKonstruktor "= 256" (egészSzöveg 256) "a nyolcbites kódszó-tér"
    , LépésKonstruktor "ellenőrzés: 240 + 16" (show (híd256Érték adat)) "az enumeráció ugyanideér (F2.34)" ]
    "a Python 2**8 = 256 = len(e8) + len(pengék); Δ = 0"
    [ grafikon "SZERKEZET" "240 gyök + 16 penge egy rácsban" "híd256Rács" ""
    , grafikon "SZÁMOLÁS" "A kettő-hatvány létra 2¹…2⁸" "oszlop"
        "['2¹','2²','2³','2⁴','2⁵','2⁶','2⁷','2⁸'], [2**k for k in range(1, 9)], 'hatvány'"
    , grafikon "ELLENŐRZÉS" "Maradék: 2⁸ ⟷ enumeráció (Δ = 0)" "maradékSáv"
        "['2⁸−enumeráció'], [2**8 - (len(e8) + len(pengék))]"
    , grafikon "SPEKTRUM" "A 16 kódszó rácsa (2⁴ = 16)" "kódszóRács" ""
    , grafikon "HÍD" "Híd: 2·2·…·2 ⟷ 240+16" "kétÚtHíd"
        "'2⁸', 2**8, '240+16', len(e8) + len(pengék)" ]
    "A 256 mint nyolc bit hatványa a híd második útja: nem számoljuk ki a 240+16 összeget, hanem a tér méretéből indulunk — a kettő ugyanoda ér."
    "256 作为八个比特的幂是桥的第二条路：不数 240+16，而由空间大小出发——二者同归。"
    "256 als Potenz von acht Bits ist der zweite Weg der Brücke: nicht 240+16 gezählt, sondern von der Raumgröße her — beide kommen an."
    "‏256 כחזקת שמונה סיביות הוא הנתיב השני של הגשר: לא סופרים 240+16 אלא יוצאים מגודל המרחב — שניהם מגיעים."

  ]

-- ═══ 7. AZ F4-HÍD KÁRTYA — GyokSzo_v1 (F2.36) ═══
--    A 240 szó — híd a nyelv felé · 240 词——通往语言的桥

kártyaCsoportHíd : FutásiÉrtékek -> List Kártya
kártyaCsoportHíd adat = [

  KártyaKonstruktor "F2.36"
    "A 240 szó: az E8 gyökök mint alapszókincs — híd az F4 (nyelv) fejezethez"
    "240 个词：E8 根即基础词汇——通往 F4（语言）章的桥"
    "Die 240 Wörter: E8-Wurzeln als Grundwortschatz — Brücke zu Kapitel F4"
    "‏240 המילים: שורשי E8 כאוצר מילים בסיסי — גשר אל פרק F4"
    "szima_ter/modul/GyokSzo_v1.idr"
    "idris2 szima_ter/modul/GyokSzo_v1.idr --exec main"
    "bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst (GyokSzo_v1)"
    "a kernel a szókincs-lista hosszát normalizálja a kombinatorikai összeghez — a szókincs az IMPORTÁLT gyöklistákból épül (§24), semmit nem másol"
    "KÉT ÚT-HÍD (kombinatorika ⟷ szókincs-enumeráció) + KIINDULÓ KÁRTYA az F4-hez"
    [ "public export"
    , "record GyökSzó where"
    , "  constructor GyökSzóKonstruktor"
    , "  jel : E8Gyok"
    , "  szóOsztály : SzóOsztály"
    , "alapszókincs : List GyökSzó   -- egészSzavak ++ félEgészSzavak"
    , "bizKétÚtHíd : 112 + 128 = length AlapszókincsKonst" ]
    [ LépésKonstruktor "egész szavak (állandó fogalmak)" (show (egészSzavakSzáma adat))
        "a 112 típus-1 gyök burkolva (EgészGyökSzó)"
    , LépésKonstruktor "fél-egész szavak (kapcsolati fogalmak)" (show (félEgészSzavakSzáma adat))
        "a 128 típus-2 gyök burkolva (FélEgészGyökSzó)"
    , LépésKonstruktor "alapszókincs = egészSzavak ++ félEgészSzavak" (show (alapszókincsSzáma adat))
        "a teljes szókincs — futásidőben mérve"
    , LépésKonstruktor "bizKétÚtHíd: 112 + 128 = length" (show (alapszókincsSzáma adat))
        "a híd: a kombinatorika és a szókincs-enumeráció ugyanazt a 240-et adja" ]
    "a Python a gyököket szavakként számolja (a KERNEL-ben egész/fél-egész szószámok): 112 + 128 = 240; Δ = 0"
    [ grafikon "SZERKEZET" "A 240 szó két osztályban (112/128) — petri-vetület" "petri" ""
    , grafikon "SZÁMOLÁS" "112 egész + 128 fél-egész → 240 szó" "oszlop"
        "['egész szavak', 'fél-egész szavak', 'alapszókincs'], [KERNEL['egeszSzavak'], KERNEL['felegeszSzavak'], KERNEL['alapszokincszam']], 'szó'"
    , grafikon "ELLENŐRZÉS" "Maradék: szókincs ⟷ gyökrendszer (Δ = 0)" "maradékSáv"
        "['szókincs−240'], [KERNEL['alapszokincszam'] - KERNEL['gyokSzam']]"
    , grafikon "SPEKTRUM" "Az eloszlás: (1, 56, 126, 56, 1) — a jelentés-távolság forrása" "eloszlás" ""
    , grafikon "HÍD" "Híd: 112+128 kombinatorika ⟷ alapszókincs hossza" "kétÚtHíd"
        "'112+128', KERNEL['egeszSzavak'] + KERNEL['felegeszSzavak'], 'alapszókincs', KERNEL['alapszokincszam']" ]
    "A 240 gyök egyszerre 240 szó: a 112 egész gyök állandó fogalom, a 128 fél-egész kapcsolati fogalom. Ez a kártya az F4 (a 3 dimenziós nyelv) fejezet kapuja — a számok innen, a jelentés onnan."
    "240 个根同时是 240 个词：112 整数根为恒常概念，128 半整数根为关系概念——此卡是 F4（三维语言）章之门：数字由此来，意义由彼来。"
    "Die 240 Wurzeln sind zugleich 240 Wörter: 112 ganze für beständige Begriffe, 128 halbzahlige für Beziehungsbegriffe — das Tor zu Kapitel F4."
    "‏240 השורשים הם גם 240 מילים: 112 שלמים למושגים קבועים, 128 חצאים למושגי יחס — השער לפרק F4."

  ]

||| A fejezet teljes kártyalista — EGY láncolt összefűzés (nem let-lánc).
public export
kártyaLista : FutásiÉrtékek -> List Kártya
kártyaLista adat =
  kártyaCsoportGyökök adat ++ kártyaCsoportSzorzat adat ++
  kártyaCsoportIrány adat ++ kártyaCsoportPenge adat ++
  kártyaCsoportHíd adat

-- ═══ 8. AZ ADAT.JS GENERÁLÁSA · 生成 adat.js · adat.js-Erzeugung ═══
--    A muszerefal-v2 minta: beágyazott JS-adat + csoportok.
--    A renderer (fejezet.html) SEMMILYEN számot nem tartalmaz —
--    minden érték innen, az adat.js-ből jön.

||| (Az egészSzöveg definíciója a 2. szekció végén áll — a kártyák
||| ELŐTT, mert az Idris a definíciót a használat előtt igényli.)

||| Egy szöveg JS-string-literálként (a kártyaszövegek nem
||| tartalmaznak ASCII idézőjelet — az ékezetes „…"-jeleket használjuk).
jsSzöveg : String -> String
jsSzöveg sz = "\"" ++ sz ++ "\""

||| A JS-csoportcímkék (forrás-modul → négy nyelvű csoportfejléc).
public export
record CsoportCímke where
  constructor CsoportCímkeKonstruktor
  modulNév : String
  címMagyar : String
  címKínai : String
  címNémet : String
  címHéber : String

public export
csoportCímkék : List CsoportCímke
csoportCímkék = [
  CsoportCímkeKonstruktor "szima_ter/modul/E8Gyokok_v2.idr"
    "A 240 gyök és a Weyl-csoport"
    "240 个根与外尔群"
    "Die 240 Wurzeln und die Weyl-Gruppe"
    "‏240 השורשים וחבורת וייל"
, CsoportCímkeKonstruktor "szima_ter/modul/E8BelsoSzorzat.idr"
    "A belső szorzat-tábla és a tükrözések"
    "内积表与反射"
    "Die Innerprodukttabelle und die Spiegelungen"
    "‏טבלת המכפלה הפנימית וההשתקפויות"
, CsoportCímkeKonstruktor "szima_ter/modul/E8Iranymutato_v1.idr"
    "Az E8 kivételességének mutatói"
    "E8 特殊性的指针"
    "Die Kennzahlen der Ausnahme"
    "‏מדדי ייחודיות E8"
, CsoportCímkeKonstruktor "szima_ter/modul/E8TizenhatPenge.idr"
    "A 16 penge és a 256-os híd"
    "16 刃与 256 之桥"
    "Die 16 Blades und die 256-Brücke"
    "‏16 הלהבים וגשר 256"
, CsoportCímkeKonstruktor "szima_ter/modul/GyokSzo_v1.idr"
    "A 240 szó — híd a nyelvhez (F4)"
    "240 个词——通往语言的桥（F4）"
    "Die 240 Wörter — Brücke zur Sprache (F4)"
    "‏240 המילים — גשר אל השפה (F4)"
]

csoportCímkeJs : CsoportCímke -> String
csoportCímkeJs (CsoportCímkeKonstruktor modulÚt magyar kínai német héber) =
  "    {\"modul\": " ++ jsSzöveg modulÚt ++
  ", \"címMagyar\": " ++ jsSzöveg magyar ++
  ", \"címKínai\": " ++ jsSzöveg kínai ++
  ", \"címNémet\": " ++ jsSzöveg német ++
  ", \"címHéber\": " ++ jsSzöveg héber ++ "}"

||| Egy lépés JS-objektuma.
lépésJs : Lépés -> String
lépésJs (LépésKonstruktor képletSzöveg kiszámoltSzöveg miértSzöveg) =
  "        {\"képlet\": " ++ jsSzöveg képletSzöveg ++
  ", \"érték\": " ++ jsSzöveg kiszámoltSzöveg ++
  ", \"miért\": " ++ jsSzöveg miértSzöveg ++ "}"

||| Egy grafikon-bejegyzés JS-objektuma (cím + fájlnév).
grafikonBejegyzésJs : String -> Nat -> GrafikonBejegyzés -> String
grafikonBejegyzésJs kártyaAzonosító sorszám (GrafikonBejegyzésKonstruktor sávNeve címSzövege _ _) =
  "        {\"cím\": " ++ jsSzöveg (sávNeve ++ " — " ++ címSzövege) ++
  ", \"fájl\": " ++ jsSzöveg (kártyaAzonosító ++ "_" ++ show sorszám ++ ".png") ++ "}"

||| A számokkal jelölt fájlnevek listája (1-től n-ig).
sorszámok : Nat -> List Nat
sorszámok Z = []
sorszámok (S k) = sorszámok k ++ [S k]

||| Egy kártya JS-objektuma.
kártyaJs : Kártya -> String
kártyaJs (KártyaKonstruktor azonosítóSzöveg címMagyarSzöveg címKínaiSzöveg címNémetSzöveg címHéberSzöveg
    forrásModulÚt futtatásiParancsSzöveg bizonyításTípusSzöveg kernelSzerepeSzöveg besorolásSzöveg
    definícióLista lépésLista szimulációSzöveg grafikonBejegyzésLista
    magyarÖsszefoglalóSzöveg kínaiÖsszefoglalóSzöveg németÖsszefoglalóSzöveg héberÖsszefoglalóSzöveg) =
  "    {\n" ++
  "      \"azonosító\": " ++ jsSzöveg azonosítóSzöveg ++ ",\n" ++
  "      \"címMagyar\": " ++ jsSzöveg címMagyarSzöveg ++ ",\n" ++
  "      \"címKínai\": " ++ jsSzöveg címKínaiSzöveg ++ ",\n" ++
  "      \"címNémet\": " ++ jsSzöveg címNémetSzöveg ++ ",\n" ++
  "      \"címHéber\": " ++ jsSzöveg címHéberSzöveg ++ ",\n" ++
  "      \"forrásModul\": " ++ jsSzöveg forrásModulÚt ++ ",\n" ++
  "      \"futtatásiParancs\": " ++ jsSzöveg futtatásiParancsSzöveg ++ ",\n" ++
  "      \"bizonyításTípus\": " ++ jsSzöveg bizonyításTípusSzöveg ++ ",\n" ++
  "      \"kernelSzerepe\": " ++ jsSzöveg kernelSzerepeSzöveg ++ ",\n" ++
  "      \"besorolás\": " ++ jsSzöveg besorolásSzöveg ++ ",\n" ++
  "      \"definíciók\": [" ++ szövegÖsszefűz ", " (map jsSzöveg definícióLista) ++ "],\n" ++
  "      \"lépések\": [\n" ++ szövegÖsszefűz ",\n" (map lépésJs lépésLista) ++ "\n      ],\n" ++
  "      \"szimuláció\": " ++ jsSzöveg szimulációSzöveg ++ ",\n" ++
  "      \"grafikonok\": [\n" ++
  szövegÖsszefűz ",\n" (zipWith (grafikonBejegyzésJs azonosítóSzöveg) (sorszámok (length grafikonBejegyzésLista)) grafikonBejegyzésLista) ++
  "\n      ],\n" ++
  "      \"összefoglalóMagyar\": " ++ jsSzöveg magyarÖsszefoglalóSzöveg ++ ",\n" ++
  "      \"összefoglalóKínai\": " ++ jsSzöveg kínaiÖsszefoglalóSzöveg ++ ",\n" ++
  "      \"összefoglalóNémet\": " ++ jsSzöveg németÖsszefoglalóSzöveg ++ ",\n" ++
  "      \"összefoglalóHéber\": " ++ jsSzöveg héberÖsszefoglalóSzöveg ++ "\n" ++
  "    }"

||| A teljes adat.js — a fejezet adatai JS-objektumként.
public export
adatJs : List Kártya -> String
adatJs kártyák =
  "window.KONYV_ADAT = window.KONYV_ADAT || {};\n" ++
  "window.KONYV_ADAT.e8gyokrendszer = {\n" ++
  "  \"címMagyar\": \"F2 — E8 gyökrendszer és W(E8)\",\n" ++
  "  \"címKínai\": \"F2 — E8 根系与外尔群\",\n" ++
  "  \"címNémet\": \"F2 — Das E8-Wurzelsystem und W(E8)\",\n" ++
  "  \"címHéber\": \"‏F2 — מערכת שורשי E8 וחבורת וייל\",\n" ++
  "  \"csoportok\": [\n" ++ szövegÖsszefűz ",\n" (map csoportCímkeJs csoportCímkék) ++ "\n  ],\n" ++
  "  \"kártyák\": [\n" ++ szövegÖsszefűz ",\n" (map kártyaJs kártyák) ++ "\n  ]\n};\n"

-- ═══ 9. A GENERÁLT PYTHON (grafikon_gen.py) — AZ IDRIS ÍRJA · Idris 写 Python ═══
--    A §1.0 minta: minden kernel-szám string-konkatenációval, az
--    importált Refl-konstansokból és a futás mért értékeiből.
--    A Python-oldal ÚJRAÉPÍTI a gyökrendszert (a szimulációs út),
--    majd maradéktáblát ír (Δ = szimuláció − kernel).

||| A KERNEL-blokk: az Idris-futás összes mért értéke, py-literálként.
kernelKonstansokPy : FutásiÉrtékek -> String
kernelKonstansokPy adat =
  "KERNEL = {\n" ++
  "  'tipus1Szam': " ++ show (típusEgySzáma adat) ++ ",\n" ++
  "  'tipus2Szam': " ++ show (típusKettőSzáma adat) ++ ",\n" ++
  "  'gyokSzam': " ++ show (gyökSzáma adat) ++ ",\n" ++
  "  'pozicioParokSzam': " ++ show (pozícióPárokSzáma adat) ++ ",\n" ++
  "  'elojelParokSzam': " ++ show (előjelPárokSzáma adat) ++ ",\n" ++
  "  'osszesElojelSzam': " ++ show (összesElőjelSzáma adat) ++ ",\n" ++
  "  'faktorialisNyolc': " ++ show (faktoriálisNyolcÉrték adat) ++ ",\n" ++
  "  'faktorialisPrim': " ++ show (faktoriálisPrímÚtÉrték adat) ++ ",\n" ++
  "  'faktorialisPrimTenyezok': " ++ show (faktoriálisPrímtényezők adat) ++ ",\n" ++
  "  'weylD8': " ++ show (weylD8Érték adat) ++ ",\n" ++
  "  'triality': " ++ show (trialitásÉrték adat) ++ ",\n" ++
  "  'weylE8': " ++ show (weylE8Érték adat) ++ ",\n" ++
  "  'weylE8Prim': " ++ show (weylE8PrímÚtÉrték adat) ++ ",\n" ++
  "  'weylPrimTenyezok': " ++ show (weylPrímtényezők adat) ++ ",\n" ++
  "  'e8Dimenzio': " ++ show (e8DimenzióÉrték adat) ++ ",\n" ++
  "  'e8e8Dimenzio': " ++ show (e8e8DimenzióÉrték adat) ++ ",\n" ++
  "  'hid256': " ++ show (híd256Érték adat) ++ ",\n" ++
  "  'tipus1Norma': " ++ show (példaTípusEgyNorma adat) ++ ",\n" ++
  "  'tipus2Norma': " ++ show (példaTípusKettőNorma adat) ++ ",\n" ++
  "  'szorzatT1T2': " ++ show (szorzatTípusKettőEgyÉrték adat) ++ ",\n" ++
  "  'szorzatEllentett': " ++ show (szorzatEllentettÉrték adat) ++ ",\n" ++
  "  'szorzatMeroleges': " ++ show (szorzatMerőlegesÉrték adat) ++ ",\n" ++
  "  'reflexioOnmagara': '" ++ reflexióÖnmagáraSzöveg adat ++ "',\n" ++
  "  'reflexioMeroleges': '" ++ reflexióMerőlegesSzöveg adat ++ "',\n" ++
  "  'reflexioSzomszed': '" ++ reflexióSzomszédSzöveg adat ++ "',\n" ++
  "  'eloszlasHibak': " ++ show (eloszlásHibákSzáma adat) ++ ",\n" ++
  "  'zarasHibak': " ++ show (zárásHibákSzáma adat) ++ ",\n" ++
  "  'fokszamOsszeg': " ++ show (fokszámÖsszegÉrték adat) ++ ",\n" ++
  "  'hodgePelda': " ++ show (hodgePéldaÉrték adat) ++ ",\n" ++
  "  'hodgeInvolutioPelda': " ++ show (hodgeInvolúcióPéldaÉrték adat) ++ ",\n" ++
  "  'kodszoElso': " ++ show (kódszóElsőLista adat) ++ ",\n" ++
  "  'kodszoMindEgyes': " ++ show (kódszóMindEgyesLista adat) ++ ",\n" ++
  "  'sulyOsszeg': " ++ show (súlyÖsszegÉrték adat) ++ ",\n" ++
  "  'kodszoDb': " ++ show (kódszavakSzáma adat) ++ ",\n" ++
  "  'kodszoEgyediDb': " ++ show (egyediKódszavakSzáma adat) ++ ",\n" ++
  "  'mindLegalabbHarom': " ++ show (mindTávolságLegalábbHarom adat) ++ ",\n" ++
  "  'egeszSzavak': " ++ show (egészSzavakSzáma adat) ++ ",\n" ++
  "  'felegeszSzavak': " ++ show (félEgészSzavakSzáma adat) ++ ",\n" ++
  "  'alapszokincszam': " ++ show (alapszókincsSzáma adat) ++ ",\n" ++
  "}\n" ++
  "GENERALOSOROK = " ++ show generaloSorok ++ "\n"

||| A Python fejléce és a gyökrendszer újjáépítése (szimulációs út).
pythonSzámítás : String
pythonSzámítás = """
import itertools
import json
import math
import os
import sys
import time
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ALAP = os.path.dirname(os.path.abspath(__file__))
GRAFIKONOK = os.path.join(ALAP, "grafikonok")
os.makedirs(GRAFIKONOK, exist_ok=True)
MENT_DARAB = 0

# ─── A GYÖKRENDSZER ÚJRAÉPÍTÉSE (a szimulációs út — §18 két út) ───
def párosMínusz(vektor):
    return sum(1 for x in vektor if x < 0) % 2 == 0

pozícióPárok = [(i, j) for i in range(1, 9) for j in range(1, 9) if i < j]
előjelPárok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
típus1 = []
for (i, j) in pozícióPárok:
    for (s1, s2) in előjelPárok:
        vektor = [0] * 8
        vektor[i - 1] = 2 * s1
        vektor[j - 1] = 2 * s2
        típus1.append(tuple(vektor))
típus2 = [tuple(v) for v in itertools.product([1, -1], repeat=8) if párosMínusz(v)]
e8 = típus1 + típus2
típus1Halmaz = set(típus1)
e8Halmaz = set(e8)
mínuszEloszlásTípus2 = [sum(1 for v in típus2 if sum(1 for x in v if x < 0) == k) for k in range(9)]

# ─── A BELSŐ SZORZAT-TÁBLA (240×240) ÉS A NORMÁK ───
MÁTRIX = np.array([[sum(a * b for a, b in zip(u, v)) for v in e8] for u in e8])
engedélyezett = [-8, -4, 0, 4, 8]
normák = [sum(x * x for x in v) for v in e8]
rosszNormák = sum(1 for n in normák if n != 8)
rosszSzorzatok = int(np.sum(~np.isin(MÁTRIX, engedélyezett)))
eloszlásPélda = [int(np.sum(MÁTRIX[0] == c)) for c in engedélyezett]
rosszEloszlás = sum(1 for k in range(len(e8)) if [int(np.sum(MÁTRIX[k] == c)) for c in engedélyezett] != [1, 56, 126, 56, 1])
párszámok = [int(np.sum(MÁTRIX == c)) for c in engedélyezett]

# ─── A WEYL-TÜKRÖZÉS ÉS A ZÁRTSÁG (57 600 pár) ───
def tükröz(alfa, béta):
    szorzat = sum(a * b for a, b in zip(alfa, béta))
    return tuple(b - (szorzat // 4) * a for a, b in zip(alfa, béta))
zárásHibák = sum(1 for alfa in e8 for béta in e8 if tükröz(alfa, béta) not in e8Halmaz)

# ─── RENDEK ÉS FAKTORIÁLISOK ───
f8 = math.factorial(8)
prímÚtFaktoriális = 128 * 9 * 5 * 7
weylD8 = 128 * f8
trialitás = 3 * 3 * 3 * 5
weylE8 = weylD8 * trialitás
prímÚtWeyl = 16384 * 243 * 25 * 7

# ─── A 16 PENGE (Cl(4)) ───
pengék = list(range(16))
def fok(x):
    return bin(x).count("1")
def duál(x):
    return 15 - x
fokszámok = [sum(1 for p in pengék if fok(p) == k) for k in range(5)]
hodgeInvolúcióHibák = sum(1 for p in pengék if duál(duál(p)) != p)
fokTükrözésHibák = sum(1 for p in pengék if fok(duál(p)) + fok(p) != 4)

# ─── A HAMMING [7,4,3] KÓD ───
G = GENERALOSOROK
def kódszó(üzenet):
    return [sum(üzenet[i] * G[i][b] for i in range(4)) % 2 for b in range(7)]
üzenetek = [list(m) for m in itertools.product([0, 1], repeat=4)]
kódszavak = [kódszó(m) for m in üzenetek]
súlyok = [sum(c) for c in kódszavak]
súlyEloszlás = [súlyok.count(w) for w in (0, 3, 4, 7)]
egyediKódszavak = len({tuple(c) for c in kódszavak})
párTávolságok = [sum(a != b for a, b in zip(x, y)) for x in kódszavak for y in kódszavak if x != y]
minimálisTáv = min(párTávolságok)

# ─── MARADÉKOK (Δ = szimuláció − kernel) ───
maradékok = [
    ("típus-1 gyökök száma", len(típus1), KERNEL["tipus1Szam"]),
    ("típus-2 gyökök száma", len(típus2), KERNEL["tipus2Szam"]),
    ("E8 gyökök száma", len(e8), KERNEL["gyokSzam"]),
    ("pozíciópárok C(8,2)", len(pozícióPárok), KERNEL["pozicioParokSzam"]),
    ("előjel-kombinációk 2^8", 2 ** 8, KERNEL["osszesElojelSzam"]),
    ("rossz norma² (nem 8)", rosszNormák, 0),
    ("rossz belsőszorzat-érték", rosszSzorzatok, 0),
    ("rossz eloszlású gyök", rosszEloszlás, KERNEL["eloszlasHibak"]),
    ("Weyl-zárási hiba", zárásHibák, KERNEL["zarasHibak"]),
    ("8! rekurzió", f8, KERNEL["faktorialisNyolc"]),
    ("8! prím-út", prímÚtFaktoriális, KERNEL["faktorialisPrim"]),
    ("W(D8) = 2^7·8!", weylD8, KERNEL["weylD8"]),
    ("trialitás 135", trialitás, KERNEL["triality"]),
    ("W(E8) struktúra-út", weylE8, KERNEL["weylE8"]),
    ("W(E8) prím-út", prímÚtWeyl, KERNEL["weylE8Prim"]),
    ("E8 dimenzió 240+8", len(e8) + 8, KERNEL["e8Dimenzio"]),
    ("E8×E8 dimenzió 248·2", (len(e8) + 8) * 2, KERNEL["e8e8Dimenzio"]),
    ("híd 240+16", len(e8) + len(pengék), KERNEL["hid256"]),
    ("penge-fokszámösszeg", sum(fokszámok), KERNEL["fokszamOsszeg"]),
    ("Hodge-példa duál(3)", duál(3), KERNEL["hodgePelda"]),
    ("Hodge-involúció duál(duál(5))", duál(duál(5)), KERNEL["hodgeInvolutioPelda"]),
    ("Hodge-involúció hibák (16 penge)", hodgeInvolúcióHibák, 0),
    ("fok-tükrözés hibák (k+4−k=4)", fokTükrözésHibák, 0),
    ("kódszavak száma", len(kódszavak), KERNEL["kodszoDb"]),
    ("egyedi kódszavak", egyediKódszavak, KERNEL["kodszoEgyediDb"]),
    ("súly-összeg 1+7+7+1", sum(súlyEloszlás), KERNEL["sulyOsszeg"]),
    ("minden pártávolság ≥ 3 (d = 3)", minimálisTáv >= 3, KERNEL["mindLegalabbHarom"]),
]

print("═══ MARADÉKTÁBLA (Δ = szimuláció − kernel) ═══")
maximumDéltérés = 0
with open(os.path.join(ALAP, "maradekok.csv"), "w", encoding="utf-8") as fájl:
    print("név;szimuláció;kernel;Δ", file=fájl)
    for (név, szimuláció, kernel) in maradékok:
        eltérés = szimuláció - kernel
        maximumDéltérés = max(maximumDéltérés, abs(eltérés))
        print(f"{név:38s} szimuláció={szimuláció:>12} kernel={kernel:>12} Δ={eltérés}")
        print(f"{név};{szimuláció};{kernel};{eltérés}", file=fájl)
print(f"max |Δ| = {maximumDéltérés}")
"""

||| A ábra-rajzoló függvények (kártyánként 5 PNG — a terv 5-sávós sémája).
pythonÁbrák : String
pythonÁbrák = """
# ─── ÁBRÁK · 绘图 · Diagramme ───
SZÍN_TÍPUS1 = "#e3b341"
SZÍN_TÍPUS2 = "#39d2c0"
SZÍN_HÍD = "#58a6ff"
SZÍN_HIBA = "#f85149"

def ment(azonosító, sorszám):
    út = os.path.join(GRAFIKONOK, azonosító + "_" + str(sorszám) + ".png")
    plt.tight_layout()
    plt.savefig(út, dpi=110)
    plt.close()
    global MENT_DARAB
    MENT_DARAB = MENT_DARAB + 1

def petri(az, n, cím):
    x = [v[0] for v in e8]
    y = [v[1] for v in e8]
    színek = [SZÍN_TÍPUS1 if v in típus1Halmaz else SZÍN_TÍPUS2 for v in e8]
    plt.figure(figsize=(8.5, 5.2))
    plt.scatter(x, y, c=színek, s=28, alpha=0.75, edgecolors="none")
    plt.scatter([], [], c=SZÍN_TÍPUS1, label="típus-1: (±1,±1,0⁶) — " + str(len(típus1)))
    plt.scatter([], [], c=SZÍN_TÍPUS2, label="típus-2: (±½)⁸ — " + str(len(típus2)))
    plt.axhline(0, color="#26303d", linewidth=0.6)
    plt.axvline(0, color="#26303d", linewidth=0.6)
    plt.gca().set_aspect("equal")
    plt.xlabel("1. koordináta")
    plt.ylabel("2. koordináta")
    plt.title(cím, fontsize=10)
    plt.legend(fontsize=8)
    ment(az, n)

def típusok(az, n, cím):
    fig, tengelyek = plt.subplots(1, 2, figsize=(8.5, 5.2))
    tengelyek[0].scatter([v[0] for v in típus1], [v[1] for v in típus1], c=SZÍN_TÍPUS1, s=24)
    tengelyek[0].set_title("típus-1: " + str(len(típus1)) + " db", fontsize=9)
    tengelyek[1].scatter([v[0] for v in típus2], [v[1] for v in típus2], c=SZÍN_TÍPUS2, s=24)
    tengelyek[1].set_title("típus-2: " + str(len(típus2)) + " db", fontsize=9)
    for tengely in tengelyek:
        tengely.set_aspect("equal")
        tengely.axhline(0, color="#26303d", linewidth=0.6)
        tengely.axvline(0, color="#26303d", linewidth=0.6)
    fig.suptitle(cím, fontsize=10)
    ment(az, n)

def normaHisztogram(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    plt.hist(normák, bins=[7.5, 8.5], color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    plt.xlabel("norma² (a 2-szeres skálán)")
    plt.ylabel("gyökök száma")
    rossz = rosszNormák
    plt.title(cím + "  (hibás: " + str(rossz) + ")", fontsize=10)
    ment(az, n)

def eloszlás(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    oszlopok = [str(c) for c in engedélyezett]
    plt.bar(oszlopok, eloszlásPélda, color=[SZÍN_HIBA, "#bc8cff", "#7d8a99", SZÍN_TÍPUS2, SZÍN_TÍPUS1])
    for k, érték in enumerate(eloszlásPélda):
        plt.text(k, érték + 1, str(érték), ha="center", fontsize=9)
    plt.xlabel("⟨α,β⟩ érték")
    plt.ylabel("darab (a példagyök körül)")
    plt.title(cím + "  —  (1, 56, 126, 56, 1)", fontsize=10)
    ment(az, n)

def hőKép(az, n, cím):
    plt.figure(figsize=(7.2, 6.2))
    kép = plt.imshow(MÁTRIX, cmap="RdBu_r", vmin=-8, vmax=8, aspect="auto", interpolation="nearest")
    plt.colorbar(kép, label="⟨α,β⟩")
    plt.xlabel("β index (0…239)")
    plt.ylabel("α index (0…239)")
    plt.title(cím + "  —  {−8,−4,0,+4,+8} rácsos minta", fontsize=10)
    ment(az, n)

def szögRend(az, n, cím):
    szögek = [math.degrees(math.acos(c / 8)) for c in engedélyezett]
    rendek = [1 if szög < 1 else round(360 / szög) for szög in szögek]
    plt.figure(figsize=(8.5, 5.2))
    plt.scatter(szögek, rendek, s=140, c=SZÍN_HÍD, zorder=3)
    for szög, rend in zip(szögek, rendek):
        plt.annotate(str(rend), (szög, rend), textcoords="offset points", xytext=(8, 4), fontsize=10)
    plt.xlabel("szög a gyökök között (fok)")
    plt.ylabel("forgás rendje (360/szög)")
    plt.grid(color="#26303d", linewidth=0.5)
    plt.title(cím + "  —  rendek {1, 2, 3, 4, 6}", fontsize=10)
    ment(az, n)

def reflexióVektor(az, n, cím):
    alfa = (2, 2, 0, 0, 0, 0, 0, 0)
    béta = (2, 0, 2, 0, 0, 0, 0, 0)
    tükörKép = tükröz(alfa, béta)
    plt.figure(figsize=(7.2, 6.2))
    plt.quiver(0, 0, alfa[0], alfa[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_TÍPUS1, label="α = (2,2,0⁶)")
    plt.quiver(0, 0, béta[0], béta[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_TÍPUS2, label="β = (2,0,2,0⁵)")
    plt.quiver(0, 0, tükörKép[0], tükörKép[1], angles="xy", scale_units="xy", scale=1, color=SZÍN_HIBA, label="σ_α(β) = " + str(list(tükörKép)))
    tükörVonalX = [-3, 3]
    tükörVonalY = [3, -3]
    plt.plot(tükörVonalX, tükörVonalY, "--", color="#7d8a99", linewidth=1, label="tükörsík (⊥α)")
    plt.axhline(0, color="#26303d", linewidth=0.6)
    plt.axvline(0, color="#26303d", linewidth=0.6)
    plt.xlim(-3.5, 3.5)
    plt.ylim(-3.5, 3.5)
    plt.gca().set_aspect("equal")
    plt.legend(fontsize=8)
    plt.title(cím + "  (az (x₁,x₂)-vetület)", fontsize=10)
    ment(az, n)

def pengeFok(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    címkék = ["fok " + str(k) for k in range(5)]
    plt.bar(címkék, fokszámok, color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    for k, érték in enumerate(fokszámok):
        plt.text(k, érték + 0.08, str(érték), ha="center", fontsize=10)
    plt.xlabel("a penge foka (popcount)")
    plt.ylabel("pengék száma")
    plt.title(cím + "  —  (1, 4, 6, 4, 1)", fontsize=10)
    ment(az, n)

def hodgeNyilak(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    for p in pengék:
        plt.annotate("", xy=(duál(p), 0.55), xytext=(p, 0.45), arrowprops=dict(arrowstyle="->", color=SZÍN_HÍD, alpha=0.65))
    plt.scatter(pengék, [0.45] * 16, c=SZÍN_TÍPUS1, s=40, zorder=3, label="penge (bitmask)")
    plt.scatter([duál(p) for p in pengék], [0.55] * 16, c=SZÍN_TÍPUS2, s=40, zorder=3, label="Hodge-duál (15−x)")
    for p in pengék:
        plt.text(p, 0.40, str(p), ha="center", fontsize=8)
    plt.xlabel("bitmask 0…15")
    plt.yticks([])
    plt.legend(fontsize=8)
    plt.title(cím + "  —  duál(duál(x)) = x mind a 16-on", fontsize=10)
    ment(az, n)

def kódszóRács(az, n, cím):
    plt.figure(figsize=(7.2, 5.6))
    rács = np.array(kódszavak)
    plt.imshow(rács, cmap="YlGnBu", aspect="auto", vmin=0, vmax=1.4)
    plt.xlabel("bit: [idő, okság, tér, szín, hang, fázis, mód]")
    plt.ylabel("üzenet (0…15)")
    plt.title(cím + "  —  " + str(len(kódszavak)) + " kódszó", fontsize=10)
    ment(az, n)

def kódszóSúly(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(["w=0", "w=3", "w=4", "w=7"], súlyEloszlás, color=SZÍN_HÍD, edgecolor="#0b0f14")
    for k, érték in enumerate(súlyEloszlás):
        plt.text(k, érték + 0.08, str(érték), ha="center", fontsize=10)
    plt.xlabel("kódszó súlya (az 1-esek száma)")
    plt.ylabel("kódszavak száma")
    plt.title(cím + "  —  (1, 7, 7, 1)", fontsize=10)
    ment(az, n)

def oszlop(az, n, cím, címkék, értékek, függő):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(címkék, értékek, color=SZÍN_HÍD, edgecolor="#0b0f14")
    for k, érték in enumerate(értékek):
        plt.text(k, érték, str(érték), ha="center", va="bottom", fontsize=9)
    plt.ylabel(függő)
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím, fontsize=10)
    ment(az, n)

def prímTorony(az, n, cím, címkék, értékek):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(címkék, értékek, color=SZÍN_TÍPUS2, edgecolor="#0b0f14")
    szorzat = 1
    for érték in értékek:
        szorzat = szorzat * érték
    for k, érték in enumerate(értékek):
        plt.text(k, érték, str(érték), ha="center", va="bottom", fontsize=9)
    plt.yscale("log")
    plt.ylabel("tényező (log skála)")
    plt.title(cím + "  —  szorzatuk: " + str(szorzat), fontsize=10)
    ment(az, n)

def kétÚtHíd(az, n, cím, címkeEgy, értékEgy, címkeKettő, értékKettő):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar([címkeEgy, címkeKettő], [értékEgy, értékKettő], color=[SZÍN_TÍPUS1, SZÍN_TÍPUS2], edgecolor="#0b0f14")
    plt.axhline(értékEgy, color=SZÍN_HÍD, linestyle="--", linewidth=1)
    eltérés = értékEgy - értékKettő
    plt.text(0.5, max(értékEgy, értékKettő), "Δ = " + str(eltérés), ha="center", fontsize=11, color=SZÍN_HÍD)
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím, fontsize=10)
    ment(az, n)

def maradékSáv(az, n, cím, nevek, értékek):
    plt.figure(figsize=(8.5, 5.2))
    plt.bar(nevek, értékek, color=(SZÍN_HIBA if max([abs(e) for e in értékek] + [0]) > 0 else SZÍN_TÍPUS2), edgecolor="#0b0f14")
    felső = max([abs(e) for e in értékek] + [0])
    plt.ylim(-1 if felső == 0 else -felső * 1.3, max(felső * 1.3, 1))
    plt.axhline(0, color="#3ddc84", linewidth=1)
    plt.ylabel("Δ (várható 0)")
    plt.xticks(fontsize=8, rotation=12)
    plt.title(cím + "  —  max |Δ| = " + str(felső), fontsize=10)
    ment(az, n)

def faktoriálisLétra(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    fokozatok = [str(k) for k in range(1, 9)]
    értékek = [math.factorial(k) for k in range(1, 9)]
    plt.bar(fokozatok, értékek, color=SZÍN_TÍPUS1, edgecolor="#0b0f14")
    plt.yscale("log")
    plt.xlabel("k")
    plt.ylabel("k! (log skála)")
    plt.title(cím + "  —  8! = " + str(f8), fontsize=10)
    ment(az, n)

def weylLánc(az, n, cím):
    plt.figure(figsize=(8.5, 5.2))
    címkék = ["2⁷", "8!", "135", "W(D8)", "W(E8)"]
    értékek = [128, f8, trialitás, weylD8, weylE8]
    plt.bar(címkék, értékek, color=SZÍN_HÍD, edgecolor="#0b0f14")
    plt.yscale("log")
    plt.ylabel("érték (log skála)")
    plt.title(cím + "  —  2⁷·8!·135 = " + str(weylE8), fontsize=10)
    ment(az, n)

def híd256Rács(az, n, cím):
    mezők = np.zeros((16, 16))
    for sor in range(16):
        for oszlopIndex in range(16):
            mezők[sor][oszlopIndex] = 0 if sor * 16 + oszlopIndex < len(e8) else 1
    plt.figure(figsize=(7.2, 6.2))
    plt.imshow(mezők, cmap=matplotlib.colors.ListedColormap([SZÍN_TÍPUS1, SZÍN_TÍPUS2]), vmin=0, vmax=1)
    plt.scatter([], [], c=SZÍN_TÍPUS1, label="E8 gyök (tartalom): " + str(len(e8)))
    plt.scatter([], [], c=SZÍN_TÍPUS2, label="Cl(4) penge (keret): " + str(16 * 16 - len(e8)))
    plt.xlabel("16 oszlop")
    plt.ylabel("16 sor")
    plt.legend(fontsize=8, loc="lower right")
    plt.xticks([])
    plt.yticks([])
    plt.title(cím + "  —  " + str(len(e8)) + " + " + str(16 * 16 - len(e8)) + " = " + str(16 * 16), fontsize=10)
    ment(az, n)
"""

||| Egy grafikon-bejegyzés py-tuple-e: (függvény, cím, extra…).
kártyaPyBejegyzés : GrafikonBejegyzés -> String
kártyaPyBejegyzés (GrafikonBejegyzésKonstruktor sávNeve címSzövege függvényNeve adatokSzöveg) =
  "    (\"" ++ függvényNeve ++ "\", \"" ++ sávNeve ++ " — " ++ címSzövege ++ "\"" ++
  (if adatokSzöveg == "" then "" else ", " ++ adatokSzöveg) ++ ")"

||| Egy kártya sora a KÁRTYÁK-táblában.
kártyaPySor : Kártya -> String
kártyaPySor (KártyaKonstruktor azonosítóSzöveg _ _ _ _ _ _ _ _ _ _ _ _ bejegyzések _ _ _ _) =
  "  '" ++ azonosítóSzöveg ++ "': [\n" ++
  szövegÖsszefűz ",\n" (map kártyaPyBejegyzés bejegyzések) ++
  "\n  ]"

||| A KÁRTYÁK-tábla — ugyanabból az egyetlen Kártya-listából, mint az
||| adat.js (egyetlen igazságforrás: a kártyaLista).
pythonKártyákTábla : FutásiÉrtékek -> String
pythonKártyákTábla adat =
  "KÁRTYÁK = {\n" ++
  szövegÖsszefűz ",\n" (map kártyaPySor (kártyaLista adat)) ++
  "\n}\n"

||| A diszpécser és a GAUGE-zárás.
||| TANULSÁG: a KÁRTYÁK-tábla a py-ban a MINDEN számítás után áll,
||| ezért a tuple-elemek KÉSZ ÉRTÉKEK (sztringek, számok, listák) —
||| eval NEM kell, a diszpécser közvetlenül továbbadja őket.
pythonVég : String
pythonVég = """
# ─── A DISZPÉCSER: kártyánként 5 ábra · 每卡五图 · Dispatcher ───
for kártyaAzonosító, bejegyzések in KÁRTYÁK.items():
    for sorszám, (függvény, cím, *extra) in enumerate(bejegyzések, 1):
        globals()[függvény](kártyaAzonosító, sorszám, cím, *extra)

# ─── GAUGE-ZÁRÁS · 收尾 · Abschluss ───
print()
print("═══ GAUGE ═══")
print("megrajzolt PNG-ek száma:", MENT_DARAB)
print("várt PNG-szám:", 5 * len(KÁRTYÁK))
print("max |Δ| a maradéktáblában:", maximumDéltérés)
if maximumDéltérés == 0 and MENT_DARAB == 5 * len(KÁRTYÁK):
    print("GAUGE: OK — minden maradék 0, minden PNG megvan.")
    sys.exit(0)
else:
    print("GAUGE: HIBA — nézd a maradéktáblát / a PNG-számot!")
    sys.exit(1)
"""

||| A teljes generált Python — fejléctől a GAUGE-zárásig.
||| TANULSÁG: a hármas-idézőletes blokkok a záró """ előtti újsort
||| LEVÁGJÁK — ezért minden illesztéshez explicit "\n" kell.
public export
grafikonPythonTeljes : FutásiÉrtékek -> String
grafikonPythonTeljes adat =
  "# ═══ GRAFIKON-GENERÁTOR — F2: E8 gyökrendszer ═══\n" ++
  "# EZT A FÁJLT AZ IDRIS GENERÁLTA (KonyvAdat_E8Gyokrendszer_v1.main,\n" ++
  "# §1.0: az Idris írja a Pythont — kéz nem írt sort).\n" ++
  "# Minden kernel-érték az Idris-futásból (GAUGE); a Python-oldal\n" ++
  "# ÚJRAÉPÍTI a gyökrendszert — a két út maradéka a maradekok.csv-ben.\n" ++
  kernelKonstansokPy adat ++
  pythonSzámítás ++ "\n" ++
  pythonÁbrák ++ "\n" ++
  pythonKártyákTábla adat ++
  pythonVég

-- ═══ 10. A MAIN — ÍR, FUTTAT, JELENT · 写入、运行、报告 · Schreiben, ausführen ═══
--    A §1.0 minta szerint: az Idris minden fájlt ír, majd ELINDÍTJA
--    a generált Pythont (System.system); a GAUGE-összefoglaló csak a
--    TENYÉGES futás adatait mondja.

||| A fejezet könyvtára a repóban. BÁZIS: az ipkg könyvtára (szima_ter)
||| — az `idris2 --find-ipkg` a futtatásnál oda teszi a CWD-t (ez a
||| futtatási parancs dokumentált formája lenn).
könyvKönyvtár : String
könyvKönyvtár = "../docs/konyv/e8gyokrendszer"

||| Visszaolvasás — a writeFile GAUGE-őszinte ellenőrzése: nem elég
||| kiírni, hogy megírva — vissza is olvassuk és a hosszát mondjuk.
fájlHosszJelentés : String -> String -> IO ()
fájlHosszJelentés leírás fájlÚtja = do
  visszaolvasás <- readFile fájlÚtja
  case visszaolvasás of
    Left hiba => putStrLn ("  " ++ leírás ++ ": HIBA — " ++ show hiba)
    Right tartalom => putStrLn ("  " ++ leírás ++ ": megírva és visszaolvasva (" ++
      show (length (unpack tartalom)) ++ " karakter) → " ++ fájlÚtja)

main : IO ()
main = do
  putStrLn "══════════════════════════════════════════════════════════"
  putStrLn "  KÖNYV-ADAT F2 — E8 GYÖKRENDSZER ÉS W(E8)"
  putStrLn "  A Kristálytiszta Könyv pilot-fejezete · 水晶之书试点章节"
  putStrLn "══════════════════════════════════════════════════════════"
  munkakönyvtár <- currentDir
  putStrLn ("  CWD: " ++ show munkakönyvtár ++ "  (a --find-ipkg az ipkg könyvtárába teszi)")
  putStrLn ""
  _ <- createDir "../docs/konyv"
  _ <- createDir "../docs/konyv/e8gyokrendszer"
  _ <- createDir "../docs/konyv/e8gyokrendszer/grafikonok"
  let adat = futásiÉrtékek
  let kártyák = kártyaLista adat
  putStrLn "── A KERNEL ÉRTÉKEI (GAUGE — a futásból) ──"
  putStrLn ("  pozíciópárok C(8,2)      : " ++ show (pozícióPárokSzáma adat))
  putStrLn ("  előjelpárok               : " ++ show (előjelPárokSzáma adat))
  putStrLn ("  előjel-kombinációk 2⁸     : " ++ show (összesElőjelSzáma adat))
  putStrLn ("  típus-1 gyökök            : " ++ show (típusEgySzáma adat))
  putStrLn ("  típus-2 gyökök            : " ++ show (típusKettőSzáma adat))
  putStrLn ("  E8 gyökök összesen        : " ++ show (gyökSzáma adat))
  putStrLn ("  gyokNorma (2,2,0⁶)        : " ++ show (példaTípusEgyNorma adat))
  putStrLn ("  gyokNorma (1⁸)            : " ++ show (példaTípusKettőNorma adat))
  putStrLn ("  Faktorialis 8             : " ++ show (faktoriálisNyolcÉrték adat))
  putStrLn ("  128·9·5·7 (prím-út)       : " ++ show (faktoriálisPrímÚtÉrték adat))
  putStrLn ("  W(D8)                     : " ++ show (weylD8Érték adat))
  putStrLn ("  trialitás 135             : " ++ show (trialitásÉrték adat))
  putStrLn ("  W(E8) = W(D8)·135         : " ++ show (weylE8Érték adat))
  putStrLn ("  2¹⁴·3⁵·5²·7 (prím-út)     : " ++ show (weylE8PrímÚtÉrték adat))
  putStrLn ("  E8 dimenzió 240+8         : " ++ show (e8DimenzióÉrték adat))
  putStrLn ("  E8×E8 dimenzió            : " ++ show (e8e8DimenzióÉrték adat))
  putStrLn ("  híd 240+16                : " ++ show (híd256Érték adat))
  putStrLn ("  (2,2,0⁶)·(1⁸)             : " ++ show (szorzatTípusKettőEgyÉrték adat))
  putStrLn ("  (2,2,0⁶)·(−2,−2,0⁶)      : " ++ show (szorzatEllentettÉrték adat))
  putStrLn ("  (2,2,0⁶)·(2,−2,0⁶)       : " ++ show (szorzatMerőlegesÉrték adat))
  putStrLn ("  σ_α(α)                    : " ++ reflexióÖnmagáraSzöveg adat)
  putStrLn ("  σ_α(β⊥)                   : " ++ reflexióMerőlegesSzöveg adat)
  putStrLn ("  σ_α(β szomszéd)           : " ++ reflexióSzomszédSzöveg adat)
  putStrLn ("  példa-eloszlás (2,2,0⁶)   : " ++ példaEloszlásSzöveg adat)
  putStrLn ("  eloszlasHibakSzama        : " ++ show (eloszlásHibákSzáma adat) ++ " (várható: 0)")
  putStrLn ("  zarasHibakSzama           : " ++ show (zárásHibákSzáma adat) ++ " (várható: 0, 57 600 pár)")
  putStrLn ("  penge-fokszám-összeg      : " ++ show (fokszámÖsszegÉrték adat))
  putStrLn ("  pengeDual 3               : " ++ show (hodgePéldaÉrték adat))
  putStrLn ("  pengeDual (pengeDual 5)   : " ++ show (hodgeInvolúcióPéldaÉrték adat))
  putStrLn ("  kodszamitas [1,0,0,0]     : " ++ show (kódszóElsőLista adat))
  putStrLn ("  kodszamitas [1,1,1,1]     : " ++ show (kódszóMindEgyesLista adat))
  putStrLn ("  kódszavak / egyedi        : " ++ show (kódszavakSzáma adat) ++ " / " ++ show (egyediKódszavakSzáma adat))
  putStrLn ("  minden gyök normája 8?    : " ++ gyökNormákMindNyolcSzöveg adat)
  putStrLn ("  alapszókincs (GyokSzo_v1) : " ++ show (alapszókincsSzáma adat) ++
    " (112 egész + " ++ show (félEgészSzavakSzáma adat) ++ " fél-egész)")
  putStrLn ""
  putStrLn "── A FÁJLOK ÍRÁSA ÉS VISSZAOLVASÁSA (AZ IDRIS ÍR MINDENT) ──"
  let pythonÚt = könyvKönyvtár ++ "/grafikon_gen.py"
  let adatÚt = könyvKönyvtár ++ "/adat.js"
  _ <- writeFile pythonÚt (grafikonPythonTeljes adat)
  _ <- writeFile adatÚt (adatJs kártyák)
  fájlHosszJelentés "grafikon_gen.py" pythonÚt
  fájlHosszJelentés "adat.js        " adatÚt
  putStrLn ("  kártyák száma   : " ++ show (length kártyák) ++
    "  (várt PNG: " ++ show (5 * length kártyák) ++ ")")
  putStrLn ""
  putStrLn "── A GENERÁLT PYTHON FUTTATÁSA (System.system) ──"
  kilépésiKód <- System.system ("python3 " ++ pythonÚt)
  putStrLn ("  kilépési kód: " ++ show kilépésiKód ++ "  (0 = GAUGE OK)")
  putStrLn ""
  putStrLn "── ÖSSZEFOGLALÓ ──"
  putStrLn ("  kártyák : " ++ show (length kártyák))
  putStrLn ("  csoportok: 5 (E8Gyokok_v2, E8BelsoSzorzat, E8Iranymutato_v1, E8TizenhatPenge, GyokSzo_v1-híd)")
  putStrLn ("  PNG     : " ++ show (5 * length kártyák) ++ " (grafikonok/ mappába)")
  putStrLn ("  maradék : maradekok.csv (max |Δ| a Python kimenetén)")
  putStrLn "Kész / 完成 / Fertig / גמר"
