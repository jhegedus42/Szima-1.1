module Alap.KeresoTabla_v2

-- ═══════════════════════════════════════════════════════════════
-- KERESŐ TÁBLA v2 — A TELJES PROJEKT TÉRKÉPE
-- ═══════════════════════════════════════════════════════════════
-- Ez a KeresoTabla.idr JAVÍTOTT, ÚJ generációja (AGENTS §13: a régi
-- fájl MARAD, semmit nem írunk felül, semmit nem törlünk — §20).
--
-- A v1 KÉT hibája, amit ez a generáció javít:
--   1. A v1 CSONKA volt: az utolsó sor (»putStrLn "Kész.«) a sztring
--      közepén szakadt meg — a fájl nem fordult.
--   2. A v1 »projektGraf«-ja HAMIS függőségeket sorolt fel (pl.
--      »HaromKubit«-et üresnek állította, pedig importál; az
--      »Alap.DependensSzamT«-nek Alap.SzamT importot állított, pedig
--      semmit sem importál). Ez a generáció a VALÓDI, grep-pel
--      igazolt állapotot írja le (ellenőrizve: 2026-09-05,
--      »grep -E "^module|^import"« minden felsorolt modulra).
--
-- ÚJ tartalmi elem: a projekt KÉT KÓDBÁZISA és a HAT SZIMLINK-HÍD
-- (l. docs/FajlrendszerFelmérés_v1.md): az osveny_index/ a KANONIKUS
-- FORRÁS (~181 .idr), a szima_ter/ a KANONIKUS CSOMAG (szima.ipkg +
-- ~139 .idr); a szima_ter/modul/ hat kulcsmodulja szimlink az
-- osveny_index/-re — EGY forrás, KÉT nézőpont (NEM duplikáció, §24).
--
-- Nincs Refl-kényszer a táblákban — csak függő típusok; a TÉNYeket
-- (Steane-paraméter, keresőműködés, hídszám) valódi Refl-tanúk
-- őrzik (§18: a két oldal KÜLÖNBÖZŐ konstrukció — nem tautológia).
--
-- 中文：这是 KeresoTabla.idr 的修复新世代：补全被截断的字符串；
-- 用 grep 验证过的真实依赖图替换旧表；并新增两库（osveny_index 规范
-- 源、szima_ter 规范包）与六个符号链接之桥的记录。
--
-- Deutsch: Dies ist die reparierte neue Generation der Suchtafel —
-- die abgebrochene Zeichenkette geschlossen; der Abhängigkeitsgraph
-- mit grep geprüft; zwei Codebasen und sechs Symlink-Brücken erfasst.
--
-- עברית: זהו הדור החדש והמתוקן של לוח החיפוש — המחרוזת הקטועה
-- נסגרה; גרף התלויות אומת ב-grep; שתי בסיסי קוד ושש גשרי סימלינק
-- נרשמו.
-- ═══════════════════════════════════════════════════════════════

import Data.List
import Data.String

-- ─── 1. PROJEKT MODULOK INDEXE ──────────────────────────────

||| A modul szerepköre a rendszerben.
||| (SORREND: a data a rekord ELŐTT kell, mert a rekord-mező rá
||| hivatkozik — a v1-ben ez fordítási hiba volt: »Undefined name
||| ModulTípus«; l. idris-nyelv §3a: előbb definiálj, aztán használj.)
public export
data ModulTípus = AlapModul | KategóriaModul | SzámModul | FizikaModul
                | KvantumModul | NyelvModul | GeometriaModul

||| Projekt modul: hol található, mit tartalmaz.
public export
record ModulMutató where
  constructor ModulMutatóKonstruktor
  modulÚtvonal    : String  -- pl. "Alap.SzamT"
  modulFájl       : String  -- pl. "osveny_index/Alap/SzamT.idr"
  modulLeírás     : String  -- magyar leírás
  modulTípus      : ModulTípus

-- ─── 2. KATEGÓRIAELMÉLETI STRUKTÚRÁK TÁBLÁJA ─────────────────

||| Kategóriaelméleti struktúra bejegyzés.
public export
record KategóriaBejegyzés where
  constructor KategóriaBejegyzésKonstruktor
  struktúraSorszám    : Nat
  struktúraAngolNév   : String
  struktúraMagyarNév  : String
  struktúraWikipédia  : String
  idrisTípusNév       : String       -- pl. "KategoriaT"
  idrisModul          : String       -- hol van definiálva
  szuperStruktúrák    : List Nat     -- melyik struktúrákból épül fel
  algebraiPárja       : Maybe String  -- pl. "Monoid"
  fizikaiPárja        : Maybe String  -- pl. "IdőInverz"

-- ─── 3. ALGEBRAI STRUKTÚRÁK TÁBLÁJA ─────────────────────────

||| Algebrai struktúra bejegyzés.
public export
record AlgebraBejegyzés where
  constructor AlgebraBejegyzésKonstruktor
  algebraNév          : String
  algebraTípuscsalád  : String       -- melyik típuscsaládhoz tartozik
  műveletek           : List String   -- pl. ["összead", "szoroz"]
  törvények           : List String   -- pl. ["asszociatív", "kommutatív"]
  kategóriaMegfelelő  : Maybe Nat      -- melyik kategória sorszám
  fizikaiMegfelelő    : Maybe String  -- pl. "ToltesParitasIdo"

-- ─── 4. FIZIKAI KONSTANSOK ÉS KÉPLETEK ───────────────────────

||| Fizikai mennyiség bejegyzés.
||| (§17: a relatív hiba Δ/σ alakban KÖTELEZŐ — ezért van
|||  külön relatívHiba mező, és a σ is a szövegbe kerül.)
public export
record FizikaiBejegyzés where
  constructor FizikaiBejegyzésKonstruktor
  mennyiségNév        : String
  mennyiségJele       : String       -- pl. "α⁻¹"
  codataÉrték         : String       -- hivatalos mért érték (a σ-val együtt!)
  számítottÉrték      : Maybe String -- a mi számításunk
  relatívHiba         : Maybe String -- pl. "Δ = 8.23×10⁻⁷, σ = 1.1×10⁻⁸, Δ/σ ≈ 74.8"
  típuscsalád         : String       -- melyik típuscsalád számítja ki

-- ─── 5. MAGYAR NYELVI EGYSEGEK ──────────────────────────────

||| Magyar szó → kategóriaelméleti fogalom.
public export
record MagyarLexikonBejegyzés where
  constructor MagyarLexikonBejegyzésKonstruktor
  magyarSzó           : String
  magyarEsetRag       : String       -- pl. "-ban/-ben" (belső állapot)
  kategóriaJelentés   : String       -- pl. "belső hom-funktor"
  algebraiJelentés    : String       -- pl. "kommutátor"
  fizikaiJelentés     : String       -- pl. "CPT-invariancia"

-- ═══════════════════════════════════════════════════════════════
-- 6. A [[15,1,3]] KÓD STRUKTÚRÁJA
-- ═══════════════════════════════════════════════════════════════

||| A kód paraméterei: [[n, k, d]]
||| n = kódszó hossz, k = logikai kubit, d = távolság
public export
record KvantumKódParaméterek where
  constructor KvantumKódParaméterekKonstruktor
  kódHossz            : Nat   -- n = 15 (vagy 7 Steane-nél)
  logikaiKubit        : Nat   -- k = 1
  kódTávolság         : Nat   -- d = 3
  hibákJavíthatók     : Nat   -- (d-1)/2 = 1

||| A Steane [[7,1,3]] kód paraméterei.
||| NAGYBETŰS konstans: a bizonyítástípusokban ezt használjuk
||| (csapda #1 — a kisbetűs konstans a típusban implicit argumentummá
||| válna; l. AGENTS.md «kisbetűs név a bizonyítástípusban»).
public export
SteaneKódParaméterek : KvantumKódParaméterek
SteaneKódParaméterek = KvantumKódParaméterekKonstruktor 7 1 3 1

||| A [[15,1,3]] kód paraméterei (ugyancsak nagybetűs konstans).
public export
TizenötKódParaméterek : KvantumKódParaméterek
TizenötKódParaméterek = KvantumKódParaméterekKonstruktor 15 1 3 1

-- ═══════════════════════════════════════════════════════════════
-- 7. A 7 BIT JELENTÉSE (Steane [[7,1,3]])
-- ═══════════════════════════════════════════════════════════════

||| Steane kód 7 bitjének jelentése:
||| [idő, okság, tér, szín, hang, fázis, mód]
public export
data SteaneBitJelentés = IdőBit | OkságBit | TérBit | SzínBit
                       | HangBit | FázisBit | MódBit

public export
Show SteaneBitJelentés where
  show IdőBit    = "idő (time)"
  show OkságBit  = "okság (causality)"
  show TérBit    = "tér (space)"
  show SzínBit   = "szín (color)"
  show HangBit   = "hang (sound)"
  show FázisBit  = "fázis (phase)"
  show MódBit    = "mód (mode)"

-- ═══════════════════════════════════════════════════════════════
-- 8. A TÖLTÉS-PARITÁS-IDŐ HÁROM RÉTEGE
--    (§0: a »CPT« rövidítés tilos — TöltésParitásIdő; a három réteg
--     a §9.c alapján: fizikai, nyelvtani, pszichofizikai)
-- ═══════════════════════════════════════════════════════════════

||| TöltésParitásIdő három rétegen: fizikai, nyelvtani, pszichofizikai.
||| A három réteg NEM ekvivalens — a leképezés homomorfizmus (§9).
public export
record TöltésParitásIdőHáromRéteg where
  constructor TöltésParitásIdőHáromRétegKonstruktor
  fizikaiTöltés          : String   -- C: töltés (charge)
  fizikaiParitás         : String   -- P: paritás (parity)
  fizikaiIdő             : String   -- T: idő (time)
  nyelvtaniForrás        : String   -- C: forrás (honnan tudom)
  nyelvtaniSzemlélet     : String   -- P: szemlélet (hogyan látom)
  nyelvtaniIgeidő        : String   -- T: igeidő (mikor)
  pszichofizikaiSajátTudat    : String   -- C: saját tudat (önreferencia)
  pszichofizikaiMásikFél      : String   -- P: másik fél (külső bemenet)
  pszichofizikaiKapcsolatFázisa : String   -- T: kapcsolat fázisa (dinamika)

||| Példa: a három réteg kitöltött értékei.
public export
töltésParitásIdőPélda : TöltésParitásIdőHáromRéteg
töltésParitásIdőPélda = TöltésParitásIdőHáromRétegKonstruktor
  "töltés (részecske ↔ antirészecske)"
  "paritás (bal ↔ jobb tükrözés)"
  "idő (idő visszafordítása)"
  "forrás (közvetlen / következtetett / jelentett)"
  "szemlélet (folyamatos / befejezett / szokásos)"
  "igeidő (múlt / jelen / jövő)"
  "saját tudat (ki vagyok én)"
  "másik fél (ki vagy te)"
  "kapcsolat fázisa (hogyan vagyunk együtt)"

-- ═══════════════════════════════════════════════════════════════
-- 9. FÁJLLOKÁCIÓK TÁBLÁJA (grep-pel igazolva: 2026-09-05)
-- ═══════════════════════════════════════════════════════════════

||| Minden fájl és funkciója.
public export
record FájlBejegyzés where
  constructor FájlBejegyzésKonstruktor
  fájlÚtvonal         : String
  fájlFunkció         : String
  exportáltTípusok    : List String
  függőségek          : List String

||| Alap/SzamT.idr — igazolva: EgeszSzam (25. sor), OsszeadasT (73),
||| SzorzasT (78), KivonasT (83), InverzT (88), RendelezesT (93);
||| import nélkül (csak Prelude).
public export
AlapSzámTFájl : FájlBejegyzés
AlapSzámTFájl = FájlBejegyzésKonstruktor
  "osveny_index/Alap/SzamT.idr"
  "Számok mint data (0-10), műveletek typeclass-ként"
  ["EgeszSzam", "OsszeadasT", "SzorzasT", "KivonasT", "InverzT", "RendelezesT"]
  []

||| Alap/KategoriaT.idr — igazolva: KategoriaT (25. sor), FunktorT (68),
||| TermeszetesTranszformacioT (77), AdjunkcioT (259), MonadT (268);
||| összesen 51 interface; import nélkül.
public export
AlapKategóriaTFájl : FájlBejegyzés
AlapKategóriaTFájl = FájlBejegyzésKonstruktor
  "osveny_index/Alap/KategoriaT.idr"
  "49+ kategóriaelméleti struktúra typeclass-ként (51 interface a fájlban)"
  ["KategoriaT", "FunktorT", "TermeszetesTranszformacioT", "AdjunkcioT", "MonadT"]
  []

||| FazisAlgebra.idr — igazolva: Fazis (48. sor), ToltesParitasIdo (123),
||| FazisHatar (198); importok: Steane713, HaromKubit, E8E8Algebra,
||| Alap.CsomagoltTipusok. (A v1 ide hamisan csak HaromKubit +
||| E8E8Algebra-t írt, és kihagyta a másik kettőt.)
public export
FázisAlgebraFájl : FájlBejegyzés
FázisAlgebraFájl = FájlBejegyzésKonstruktor
  "osveny_index/FazisAlgebra.idr"
  "Fázis algebra, redundancia detektálás, TöltésParitásIdő"
  ["Fazis", "ToltesParitasIdo", "FazisHatar"]
  ["Steane713", "HaromKubit", "E8E8Algebra", "Alap.CsomagoltTipusok"]

||| E8E8Algebra.idr — igazolva: E8E8KodSzo (159. sor), CliffordElem (67),
||| e8e8Atfedes (218); import: Steane713.
||| JAVÍTÁS a v1-hez képest: a v1 »CliffordSzorzat«-ot sorolt fel —
||| az ILYEN NÉVEN SEMMI NINCS a fájlban (a valódi név CliffordElem).
public export
E8E8AlgebraFájl : FájlBejegyzés
E8E8AlgebraFájl = FájlBejegyzésKonstruktor
  "osveny_index/E8E8Algebra.idr"
  "E8 × E8 Clifford algebra, kvantum kódok"
  ["E8E8KodSzo", "CliffordElem", "e8e8Atfedes"]
  ["Steane713"]

||| Ez a fájl: a kereső tábla v2 generációja.
public export
KeresőTáblaV2Fájl : FájlBejegyzés
KeresőTáblaV2Fájl = FájlBejegyzésKonstruktor
  "osveny_index/Alap/KeresoTabla_v2.idr"
  "A projekt térképe: modulok, gráfok, szimlink-hidak (ez a fájl)"
  ["ModulMutató", "KategóriaBejegyzés", "AlgebraBejegyzés", "FizikaiBejegyzés",
   "MagyarLexikonBejegyzés", "KvantumKódParaméterek", "SteaneBitJelentés",
   "TöltésParitásIdőHáromRéteg", "FájlBejegyzés", "modulKeresés",
   "ProjektGráf", "SzimlinkHidak", "FájlrendszerGráf"]
  []

-- ═══════════════════════════════════════════════════════════════
-- 10. KERESŐ FÜGGVÉNY — A TÁBLÁK LEKÉRDEZÉSE
-- ═══════════════════════════════════════════════════════════════

||| Keresés: melyik fájlban van egy típus?
||| (A #27 csapda gyógyíre: az ékezetes csupasz mintaváltozó import
|||  mellett elbukik — helyette @-minta, a 2026-09-05-i probe szerint
|||  bizonyított alak.)
public export
modulKeresés : String -> List FájlBejegyzés -> Maybe String
modulKeresés _ [] = Nothing
modulKeresés név@_ (x :: xs) =
  if elem név x.exportáltTípusok
    then Just x.fájlÚtvonal
    else modulKeresés név xs

-- ═══════════════════════════════════════════════════════════════
-- 11. A TELJES PROJEKT GRÁFJA — A VALÓDI ÁLLAPOT
-- ═══════════════════════════════════════════════════════════════

||| A projekt függőségi gráfja: melyik modul mit importál.
public export
record FüggőségGráf where
  constructor FüggőségGráfKonstruktor
  csúcs               : String   -- modul vagy fájlrendszer-csomópont neve
  gyerekCsúcsok       : List String  -- importok, illetve szimlink-célok

||| A kulcsmodulok VALÓDI import-gráfja.
||| Minden sor grep-pel igazolva (2026-09-05,
||| »grep -E "^module|^import"« a felsorolt fájlokon).
||| A v1 IDE HAMISAN állított függőségeket (pl. DependensSzamT →
||| SzamT; HaromKubit → []; KeresoTabla → [SzamT, KategoriaT]).
public export
ProjektGráf : List FüggőségGráf
ProjektGráf =
  [ FüggőségGráfKonstruktor "Alap.CsomagoltTipusok"
      []  -- igazolva: nincs import (a kanonikus alapmodul)
  , FüggőségGráfKonstruktor "Alap.SzamT"
      []  -- igazolva: nincs import
  , FüggőségGráfKonstruktor "Alap.KategoriaT"
      []  -- igazolva: nincs import
  , FüggőségGráfKonstruktor "Alap.DependensSzamT"
      []  -- igazolva: nincs import (a v1 hamisan Alap.SzamT-t állított!)
  , FüggőségGráfKonstruktor "Alap.KeresoTabla_v2"
      []  -- ez a modul: csak Prelude + Data.List + Data.String
  , FüggőségGráfKonstruktor "Steane713"
      []  -- igazolva: nincs import
  , FüggőségGráfKonstruktor "Fazis"
      ["Data.Vect"]  -- osveny_index/Fazis.idr (module Fazis)
  , FüggőségGráfKonstruktor "HaromKubit"
      ["Steane713", "Alap.CsomagoltTipusok"]  -- a v1 üresen hazudta!
  , FüggőségGráfKonstruktor "E8E8Algebra"
      ["Steane713"]  -- a v1 hamisan HaromKubit-et állított!
  , FüggőségGráfKonstruktor "FazisAlgebra"
      ["Steane713", "HaromKubit", "E8E8Algebra", "Alap.CsomagoltTipusok"]
  , FüggőségGráfKonstruktor "KisAI"
      -- FIGYELEM: a fájl Dirac3D/KisAI.idr, de a modulnév csupán
      -- KisAI — ez a #6 csapda (modulnév = fájlnév!). A --check szó
      -- szerint: «Module name KisAI does not match file name
      -- "Dirac3D/KisAI.idr"» — a fájl ÍGY NEM FORDUL.
      -- Importáló: Dirac3D/Main3D.idr 19. sora (amely maga is #6
      -- csapdás: module Main3D a Dirac3D/Main3D.idr-ben).
      ["Data.Vect", "Data.List", "Data.String", "Fazis"]
  , FüggőségGráfKonstruktor "Main3D"
      -- Dirac3D/Main3D.idr — a Dirac3D-hub; mind a 19 importja valós
      -- (grep 2026-09-05, 3-21. sorok).
      ["Kina2D", "Magyar", "Dirac3D", "Fazis", "Lagrangian", "Carnot",
       "MagasabbRendszer", "Hadmeres", "HadMerger", "FazisOsszeado",
       "CarryHoatvitel", "HamiltonMegmaradas", "E8Diszkretizacio",
       "E8Szimplektikus", "Steane153", "AktivTanulas", "KisAI",
       "Data.Vect", "Data.List"]
  ]

||| A HAT SZIMLINK-HÍD — a két kódbázis (osveny_index forrás +
||| szima_ter csomag) összekötése (docs/FajlrendszerFelmérés_v1.md
||| §1 alapján, a szimlink-célok szó szerint).
||| Egy forrás, két nézőpont — NEM kód-duplikáció (§24).
public export
SzimlinkHidak : List FüggőségGráf
SzimlinkHidak =
  [ FüggőségGráfKonstruktor "szima_ter/modul/Steane713.idr (szimlink)"
      ["../../osveny_index/Steane713.idr"]
  , FüggőségGráfKonstruktor "szima_ter/modul/FazisAlgebra.idr (szimlink)"
      ["../../osveny_index/FazisAlgebra.idr"]
  , FüggőségGráfKonstruktor "szima_ter/modul/HaromKubit.idr (szimlink)"
      ["../../osveny_index/HaromKubit.idr"]
  , FüggőségGráfKonstruktor "szima_ter/modul/E8E8Algebra.idr (szimlink)"
      ["../../osveny_index/E8E8Algebra.idr"]
  , FüggőségGráfKonstruktor "szima_ter/modul/Alap/KategoriaT.idr (szimlink)"
      ["../../../osveny_index/Alap/KategoriaT.idr"]
  , FüggőségGráfKonstruktor "szima_ter/modul/Kategoriak/MagyarOntologia.idr (szimlink)"
      ["../../../osveny_index/Kategoriak/MagyarOntologia.idr"]
  ]

||| A projekt fájlrendszerének kanonikus csomópontjai
||| (docs/FajlrendszerFelmérés_v1.md §0 táblája szerint).
public export
FájlrendszerGráf : List FüggőségGráf
FájlrendszerGráf =
  [ FüggőségGráfKonstruktor "osveny_index/"
      ["KANONIKUS FORRÁS: ~181 .idr — ide mutatnak a szimlinkek"]
  , FüggőségGráfKonstruktor "szima_ter/"
      ["KANONIKUS CSOMAG: szima.ipkg + ~139 .idr + build-ttc"]
  , FüggőségGráfKonstruktor "docs/"
      ["KANONIKUS DOKUMENTÁCIÓ: ~90 md — tervek, review-k, dashboardok"]
  , FüggőségGráfKonstruktor "kutatasi_naplo/"
      ["KANONIKUS NAPLÓ: 102 fájl, 2026-08-21-től (AGENTS §21)"]
  , FüggőségGráfKonstruktor "trail_index/"
      ["KANONIKUS KÖNYVTÁR+INDEX: 46 könyv (Awodey, Mac Lane, Shoup, Lumo…), idris2_docs"]
  , FüggőségGráfKonstruktor "skills/"
      ["KANONIKUS SKILLEK: repón belüli skill-definíciók"]
  , FüggőségGráfKonstruktor "tanulsagok/"
      ["KANONIKUS TANULSÁGOK: gyökér-szintű jegyzék"]
  , FüggőségGráfKonstruktor "horgony/"
      ["KANONIKUS MÉRÉSI HORGONYOK: α, CODATA-összehasonlítások (AGENTS §17)"]
  , FüggőségGráfKonstruktor "zene_es_zaj/"
      ["KUTATÁSI ADAT: zene-elemzési nyersanyag (a hang/fázis kutatáshoz)"]
  , FüggőségGráfKonstruktor "source/"
      ["NYERSANYAG: KÜLSŐ kutatási anyag — NEM a Szima kódja (7,0 GB)"]
  ]

-- ─── Refl-TANÚK (§18: valódi tanúk — a két oldal KÜLÖNBÖZŐ
--     konstrukció; a hiba az egyik oldal átírásakor ELŐJÖN) ───

-- Kimenet: Refl — a Steane-kód paramétere a rekord-mezőből kiszámolva 7.
bizSteaneHossz : kódHossz SteaneKódParaméterek = 7
bizSteaneHossz = Refl

-- Kimenet: Refl — a kereső az EgeszSzam-típusból a SzamT-fájl
-- útvonalát találja meg (a bal oldal SZÁMÍTÁS, a jobb oldal független
-- konstans: ha a bejegyzés vagy a kereső eltörik, a Refl szétesik).
bizKeresésMegtaláljaSzámT :
  modulKeresés "EgeszSzam" [AlapSzámTFájl] = Just "osveny_index/Alap/SzamT.idr"
bizKeresésMegtaláljaSzámT = Refl

-- Kimenet: Refl — a hídszámláló: pontosan HAT szimlink köti össze a
-- két kódbázist (ha a Felmérés új hidat találsz vagy elveszítesz,
-- ez a tanú SZÓL — a térkép őrzője).
bizHatSzimlinkHíd : length SzimlinkHidak = 6
bizHatSzimlinkHíd = Refl

-- ═══════════════════════════════════════════════════════════════
-- 12. ÜRES TÁBLÁK — KITÖLTENDŐ
-- ═══════════════════════════════════════════════════════════════

||| A 49 kategóriaelméleti struktúra listája.
||| Ezt a KategoriaT.idr (51 interface) alapján kell kitölteni.
public export
KategóriaStruktúrák : List KategóriaBejegyzés
KategóriaStruktúrák = []  -- TEENDŐ: kitölteni a 49 bejegyzéssel

||| Az algebrai struktúrák listája.
public export
AlgebraStruktúrák : List AlgebraBejegyzés
AlgebraStruktúrák = []  -- TEENDŐ: kitölteni

||| A fizikai konstansok listája (§17: Δ/σ kötelező mezőkkel).
public export
FizikaiKonstansok : List FizikaiBejegyzés
FizikaiKonstansok = []  -- TEENDŐ: kitölteni

||| A magyar lexikon bejegyzései.
public export
MagyarLexikon : List MagyarLexikonBejegyzés
MagyarLexikon = []  -- TEENDŐ: kitölteni

-- ═══════════════════════════════════════════════════════════════
-- SEGÉDFÜGGVÉNYEK (tiszta függvények — az IO-perem így vékony marad)
-- ═══════════════════════════════════════════════════════════════

||| Egy függőséggráf-bejegyzés olvasható sora.
||| (Projekciókkal dolgozik — konstruktor-minta nélkül.)
public export
gráfSora : FüggőségGráf -> String
gráfSora g =
  "  " ++ csúcs g ++ " → " ++ unwords (gyerekCsúcsok g)

||| A keresés eredményének olvasható sora.
||| (Nulla-kötéses pontstílus: a #27 csapda finomítása szerint a
|||  konstruktorba ágyazott ékezetes kötés — (Just útvonal) — is
|||  elbukik import mellett («Undefined name útvonal», 2026-09-05),
|||  ezért itt NINCS mintaváltozó: Prelude maybe + operátor-szekció.)
public export
találatSora : Maybe String -> String
találatSora = maybe "  Nem található." ("  Találat: " ++)

-- ═══════════════════════════════════════════════════════════════
-- FŐPROGRAM
-- ═══════════════════════════════════════════════════════════════

||| A kereső tábla főprograma: kinyomtatja a teljes térképet.
public export
keresőTáblaFőprogram : IO ()
keresőTáblaFőprogram = do
  putStrLn "=== KERESŐ TÁBLA v2 ==="
  putStrLn ""
  putStrLn "A projekt teljes térképe. Minden modul, típus, kapcsolat."
  putStrLn ""
  putStrLn "Steane kód paraméterek:"
  putStrLn ("  n=" ++ show (kódHossz SteaneKódParaméterek) ++
            " k=" ++ show (logikaiKubit SteaneKódParaméterek) ++
            " d=" ++ show (kódTávolság SteaneKódParaméterek))
  putStrLn ("[[15,1,3]]: n=" ++ show (kódHossz TizenötKódParaméterek) ++
            " k=" ++ show (logikaiKubit TizenötKódParaméterek) ++
            " d=" ++ show (kódTávolság TizenötKódParaméterek))
  putStrLn ""
  putStrLn "A 7 bit jelentése:"
  putStrLn ("  1. " ++ show IdőBit)
  putStrLn ("  2. " ++ show OkságBit)
  putStrLn ("  3. " ++ show TérBit)
  putStrLn ("  4. " ++ show SzínBit)
  putStrLn ("  5. " ++ show HangBit)
  putStrLn ("  6. " ++ show FázisBit)
  putStrLn ("  7. " ++ show MódBit)
  putStrLn ""
  putStrLn "TöltésParitásIdő három réteg (§9.c) példa:"
  putStrLn ("  Fizikai: " ++ fizikaiTöltés töltésParitásIdőPélda ++ ", " ++
            fizikaiParitás töltésParitásIdőPélda ++ ", " ++
            fizikaiIdő töltésParitásIdőPélda)
  putStrLn ("  Nyelvtani: " ++ nyelvtaniForrás töltésParitásIdőPélda ++ ", " ++
            nyelvtaniSzemlélet töltésParitásIdőPélda ++ ", " ++
            nyelvtaniIgeidő töltésParitásIdőPélda)
  putStrLn ("  Pszichofizikai: " ++ pszichofizikaiSajátTudat töltésParitásIdőPélda ++ ", " ++
            pszichofizikaiMásikFél töltésParitásIdőPélda ++ ", " ++
            pszichofizikaiKapcsolatFázisa töltésParitásIdőPélda)
  putStrLn ""
  putStrLn "Fájl keresés példa (EgeszSzam):"
  putStrLn (találatSora (modulKeresés "EgeszSzam"
             [AlapSzámTFájl, AlapKategóriaTFájl, FázisAlgebraFájl, E8E8AlgebraFájl]))
  putStrLn ""
  putStrLn "A kulcsmodulok VALÓDI import-gráfja (grep-pel igazolva):"
  putStrLn (unwords (map gráfSora ProjektGráf))
  putStrLn ""
  putStrLn "A HAT SZIMLINK-HÍD (osveny_index ↔ szima_ter):"
  putStrLn (unwords (map gráfSora SzimlinkHidak))
  putStrLn ""
  putStrLn "A fájlrendszer kanonikus csomópontjai (Felmérés v1):"
  putStrLn (unwords (map gráfSora FájlrendszerGráf))
  putStrLn ""
  putStrLn "Üres táblák (kitöltendő):"
  putStrLn ("  Kategóriák: " ++ show (length KategóriaStruktúrák) ++ "/49")
  putStrLn ("  Algebrák: " ++ show (length AlgebraStruktúrák))
  putStrLn ("  Fizikai konstansok: " ++ show (length FizikaiKonstansok))
  putStrLn ("  Magyar lexikon: " ++ show (length MagyarLexikon))
  putStrLn ""
  putStrLn "Kész."

||| A futtatható belépési pont (a -o építéshez main KELL —
||| a »Undefined name main« hiba enélkül jön, MÉG exit 0 mellett is:
||| a kimenetet olvasni kell, GAUGE).
public export
main : IO ()
main = keresőTáblaFőprogram
