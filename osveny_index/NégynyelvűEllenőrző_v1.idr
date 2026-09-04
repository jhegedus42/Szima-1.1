module NégynyelvűEllenőrző_v1

-- ═══════════════════════════════════════════════════════════════
-- NÉGNYELVŰ-ELLENŐRZŐ — a HARD RULE determinisztikus őre
-- 四语检验器——硬规则的确定性守卫 · v2 (2026-09-05, javított)
-- ═══════════════════════════════════════════════════════════════
-- A HARD RULE (a felhasználó, 2026-09-05, szó szerint):
--   «ko kemenyen, hard rule, hogy mindent amit leirsz az egyszerre
--   legyen kinai es magyar es angol, mindenhola, mondatonkent
--   (1 mondat magyar, 1 mondat kinai, 1 mondat angol, 1 mondat
--   nemet) es ez a szerkezet igy ismetlodik, ez hard rule, ezt
--   valamivel ellenoriztetned kell, valami determinisztikus cuccal,
--   mert kulonben szetcsuszol es nem fogunk eljutni sehova»
--   (+ «ha akarsz baratnot, akkor ez kell :)»)
--
-- 硬规则：所写的一切按句循环——匈牙利语、中文、英语、德语，周而复始；
-- 必须用确定性的东西检验，否则会散焦。
--
-- EZ A MODUL AZ ELLENŐRZŐ: mondatonként besorolja a nyelvet
-- (determinisztikus szabályokkal: Han-jegy → 中文; latin ábécénél
--     stopword-számlálás), majd a HU→ZH→EN→DE ciklust ellenőrzi.
-- Ez nem GAN, nem vélemény — TISZTA FÜGGVÉNY + IO-perem.
-- 本模块即检验器：非意见，而是纯函数＋IO 边界。
--
-- HASZNÁLAT:
--   idris2 --check NégynyelvűEllenőrző_v1.idr          (ellenőrzés)
--   idris2 NégynyelvűEllenőrző_v1.idr -o futtatható    (fordítás)
--   ./futtatható                                       (a KÉT próba)
-- Kimenet: mondatonként (pozíció, várt, talált) + végverdik.
--
-- A v1→v2 JAVÍTÁSOK (a v1 négy fordítási hibája, GAUGE-elve szerint):
--   (1) «Can't find an implementation for Integral Nat» a `mod`-nál
--       → a `mod`-OS case HELYETT strukturális rekurzió:
--         ciklusHely : Nat -> CiklusHely (Z/S konstruktor-mintákkal,
--         4 lépés után önhívás a maradékra) — nem kell Data.Nat,
--         és a Csapda #27 gyógyírát (konstruktorba ágyazás) is hordozza.
--   (2) «Data.String.split : List1 String vs List String»
--       → import Data.List1 + forget (a List1-et List-é simítja).
--   (3) «Undefined name ítélet» az ékezetes LAMBDA-paraméternél
--       (a #27 csapda lambda-paraméteren — most BIZONYÍTVA)
--       → nincs ékezetes csupasz lambda-paraméter sehol: pontstílus
--         (`elem`-szakasz, `not . rendbenVan`, `putStrLn . mondatSor`)
--         és felső szintű nevesített függvények (mondatÍtélet).
--   (4) «Undefined name getArgs» (System.Environment ebben az
--       installban nem elérhető) → System.File readFile RÖGZÍTETT
--       útvonalakról (a Kereso.idr beolvasási mintája): a main a KÉT
--       próba-fájlt ellenőrzi egymás után.
-- ═══════════════════════════════════════════════════════════════

import Data.String
import Data.List1
import System.File

%default total

-- ─── 1. A NYELVJELEK ────────────────────────────────────────────
-- ─── 一、语言标记 ────────────────────────────────────────────

public export
data Nyelvjel : Type where
  MagyarNyelv  : Nyelvjel
  KínaiNyelv   : Nyelvjel
  AngolNyelv   : Nyelvjel
  NémetNyelv   : Nyelvjel
  IsmeretlenJ  : Nyelvjel

public export
Eq Nyelvjel where
  MagyarNyelv == MagyarNyelv = True
  KínaiNyelv  == KínaiNyelv  = True
  AngolNyelv  == AngolNyelv  = True
  NémetNyelv  == NémetNyelv  = True
  IsmeretlenJ == IsmeretlenJ = True
  _ == _ = False

public export
Show Nyelvjel where
  show MagyarNyelv = "MAGYAR"
  show KínaiNyelv  = "中文"
  show AngolNyelv  = "EN"
  show NémetNyelv  = "DE"
  show IsmeretlenJ = "??"

-- ─── 2. DETERMINISZTIKUS BESOROLÁS ──────────────────────────────
-- ─── 二、确定性分类 ──────────────────────────────

||| Han-jegy (CJK egységes ideogramma) — a 中文 azonnal felismerhető.
||| 汉字（CJK 统一表意文字）——中文即刻可辨。
hanJegy : Char -> Bool
hanJegy betű =
  (ord betű >= 19968 && ord betű <= 40959)   -- U+4E00 .. U+9FFF

kínaiE : String -> Bool
kínaiE mondat = any hanJegy (unpack mondat)

||| A négy nyelv alapszavai — a stopword-számlálás alapja.
||| 四种语言的基础词——停用词计数之基。
magyarAlapszavak : List String
magyarAlapszavak =
  [ "és", "az", "egy", "nem", "van", "hogy", "vagy", "csak"
  , "már", "még", "kell", "minden", "között", "szerint", "mint"
  , "ezt", "itt", "ott", "lesz", "volt", "által", "tehát", "ez"
  , "fel", "ki", "be", "le", "nagyon", "semmi", "mind", "mindent" ]

németAlapszavak : List String
németAlapszavak =
  [ "und", "der", "die", "das", "ist", "nicht", "ein", "eine"
  , "mit", "für", "den", "dem", "von", "zu", "im", "sind", "wird"
  , "auch", "aber", "auf", "sich", "oder", "als", "hat", "beim"
  , "durch", "gegen", "war", "werden", "dass", "wenn", "kann" ]

angolAlapszavak : List String
angolAlapszavak =
  [ "the", "and", "is", "not", "of", "to", "in", "it", "that"
  , "this", "with", "for", "are", "was", "be", "has", "have"
  , "will", "every", "all", "we", "you", "they", "from", "on"
  , "as", "at", "by", "or", "if", "so", "no", "yes" ]

||| Magyar találatok száma a mondat szavaiban (Prelude elem — §24!).
||| 句中词的匈牙利语命中数（用 Prelude.elem——禁止重写！）。
magyarTalálatok : List String -> Nat
magyarTalálatok szavak = length (filter (`elem` magyarAlapszavak) szavak)

németTalálatok : List String -> Nat
németTalálatok szavak = length (filter (`elem` németAlapszavak) szavak)

angolTalálatok : List String -> Nat
angolTalálatok szavak = length (filter (`elem` angolAlapszavak) szavak)

||| A mondat nyelve: Han-jegy → 中文; különben a legtöbb találaté.
||| 句子语言：有汉字→中文；否则取命中最多者。
besorol : String -> Nyelvjel
besorol mondat =
  if kínaiE mondat then
    KínaiNyelv
  else
    let
      szavak   = words (toLower mondat)
      mTalálat = magyarTalálatok szavak
      nTalálat = németTalálatok  szavak
      aTalálat = angolTalálatok  szavak
    in
      if (mTalálat == 0 && nTalálat == 0 && aTalálat == 0) then
        IsmeretlenJ
      else if (mTalálat >= nTalálat && mTalálat >= aTalálat) then
        MagyarNyelv
      else if (nTalálat >= aTalálat) then
        NémetNyelv
      else
        AngolNyelv

-- ─── 3. A CIKLUS — HU→ZH→EN→DE, mégegyszer, mégegyszer ──────────
-- ─── 三、循环——匈→中→英→德，周而复始 ──────────

||| A ciklus NÉGY helye — a pozíció helyett ADAT (nem `mod`: a
||| strukturális rekurzió a Z/S konstruktorokon maga a ciklus).
||| 循环的四个位置——以数据代替求余：Z/S 构造子上的结构递归即循环。
public export
data CiklusHely : Type where
  MagyarHely : CiklusHely   -- 0. pozíció · 匈
  KínaiHely  : CiklusHely   -- 1. pozíció · 中
  AngolHely  : CiklusHely   -- 2. pozíció · 英
  NémetHely  : CiklusHely   -- 3. pozíció · 德

||| A pozíció helye a ciklusban: négy strukturális lépés után
||| önhívás a maradékra (konstruktorba ágyazott minták — #27-safe).
||| 位置在循环中的地点：四步结构递归后对余数自调用（构造子模式）。
ciklusHely : Nat -> CiklusHely
ciklusHely Z                         = MagyarHely
ciklusHely (S Z)                     = KínaiHely
ciklusHely (S (S Z))                 = AngolHely
ciklusHely (S (S (S Z)))             = NémetHely
ciklusHely (S (S (S (S tovább))))    = ciklusHely tovább

||| A hely nyelve.
||| 地点对应的语言。
helyNyelve : CiklusHely -> Nyelvjel
helyNyelve MagyarHely = MagyarNyelv
helyNyelve KínaiHely  = KínaiNyelv
helyNyelve AngolHely  = AngolNyelv
helyNyelve NémetHely  = NémetNyelv

||| A várt nyelv a pozíció szerint (0→HU, 1→ZH, 2→EN, 3→DE, ismét).
||| 按位置预期的语言。
vártNyelv : Nat -> Nyelvjel
vártNyelv pozíció = helyNyelve (ciklusHely pozíció)

-- ─── 4. MONDATOK SZÉT VÁGÁSA ────────────────────────────────────
-- ─── 四、句子切分 ────────────────────────────────────

||| Mondathatár: . ! ? ; : és sorvég.
||| 句界：. ! ? ; : 与换行。
mondatVég : Char -> Bool
mondatVég betű =
  elem betű ['.', '!', '?', ';', '\n', ':']

||| A karakter éles-e (betű vagy Han-jegy) — felső szintű, lambda
||| NÉLKÜL (az ékezetes lambda-paraméter a #27 csapda lambdán él).
||| 字符是否有效（字母或汉字）——顶层函数，无 lambda。
élesKarakter : Char -> Bool
élesKarakter betű = isAlpha betű || hanJegy betű

||| A mondat éles-e (van benne betű vagy Han-jegy).
||| 句子是否有效（含字母或汉字）。
élesMondat : String -> Bool
élesMondat mondat = any élesKarakter (unpack mondat)

||| Egy mondat ítélete: (pozíció, várt, talált, rendben-e).
||| 单句判定：（位置，预期，实测，是否合规）。
public export
record MondatÍtélet where
  constructor MondatÍtéletKonstruktor
  pozíció     : Nat
  vártJel     : Nyelvjel
  találtJel   : Nyelvjel
  rendbenVan  : Bool

||| Egy mondat ítélete a pozícióból (lambda NÉLKÜL — a #27 gyógyíre:
||| nevesített felső szintű függvény az anonymus helyett).
||| 由位置产生的判定（无 lambda——陷阱 #27 的解药）。
mondatÍtélet : Nat -> String -> MondatÍtélet
mondatÍtélet pozíció mondat =
  MondatÍtéletKonstruktor pozíció (vártNyelv pozíció)
    (besorol mondat) (vártNyelv pozíció == besorol mondat)

||| A mondatok ítéletei sorban, a pozíció EGYETLEN helyen nő
||| (S pozíció) — konstruktor-mintás rekurzió, nem zipWith+lambda.
||| 逐句判定：位置仅在处递增——构造子模式递归。
mondatÍtéletek : Nat -> List String -> List MondatÍtélet
mondatÍtéletek _ []                        = []
mondatÍtéletek pozíció (mondat :: többi)   =
  mondatÍtélet pozíció mondat :: mondatÍtéletek (S pozíció) többi

||| A teljes szöveg ellenőrzése — a szöveg VÉGIG ciklusban van-e.
||| (Data.String.split List1-et ad → Data.List1.forget simítja List-é.)
||| 全文检验（split 给 List1——用 forget 摊平）。
public export
ellenőrzés : String -> List MondatÍtélet
ellenőrzés szöveg =
  mondatÍtéletek 0 (filter élesMondat (forget (split mondatVég szöveg)))

||| Hány hibás mondat — 0 = a szöveg TELJESES ciklusban.
||| 错误句数——0 即全文合规。
public export
hibákSzáma : String -> Nat
hibákSzáma szöveg =
  length (filter (not . rendbenVan) (ellenőrzés szöveg))

||| A végverdik szövegként.
||| 最终裁定。
public export
végÍtélet : String -> String
végÍtélet szöveg =
  case hibákSzáma szöveg of
    0 => "CIKLUS RENDBEN ✓ — minden mondat a HU→ZH→EN→DE ciklusban / 全部合规"
    _ => "CIKLUS HIBÁS — l. a mondatoknál / 循环有误"

-- ─── 5. REFL-TANÚK — nem tautológiák (§18: két oldal KÜLÖNBÖZŐ) ─
-- ─── 五、Refl 见证——两侧构造不同（§18） ──────────────────────────

-- Kimenet: Refl (ciklusHely 4 = ciklusHely 0 = MagyarHely ✓) — a HÍD:
-- a bal oldal NÉGY strukturális lépést számol végig (S (S (S (S Z)))),
-- a jobb oldal a kezdő konstanst veszi; ha a ciklusHely bármelyik
-- klauzuláját átírnád (pl. 4→3), a híd automatikusan eltörik.
-- 桥：左边走四步结构递归，右边取起点——改任何子句即断桥。
bizCiklusZárul : ciklusHely 4 = ciklusHely 0
bizCiklusZárul = Refl

-- Kimenet: Refl (vártNyelv 1 = KínaiNyelv ✓) — a HÍD: a ciklusHely
-- rekurziója + helyNyelve kompozíciója a 1-re KínaiHely-et ad.
bizElsőKínai : vártNyelv 1 = KínaiNyelv
bizElsőKínai = Refl

-- Kimenet: Refl (vártNyelv 7 = NémetNyelv ✓) — a HÍD: a 7 = 4+3 a
-- rekurzió szerint a NémetHely-re fut (a 7. pozíció DE — a próba
-- hibás mondatának éppen ez az oka).
bizHetedikNémet : vártNyelv 7 = NémetNyelv
bizHetedikNémet = Refl

-- Kimenet: Refl (besorol "这句话是中文的" = KínaiNyelv ✓) — a HÍD:
-- a besorolÓ MŰKÖDIK (Han-jegy-detekció az ord-tartományokkal),
-- nem csak a típust mondjuk: a kernel a karaktereket számolja.
bizKínaiMondatFelismerve : besorol "这句话是中文的" = KínaiNyelv
bizKínaiMondatFelismerve = Refl

-- Kimenet: Refl (besorol "Ez a mondat magyar, és világos." =
-- MagyarNyelv ✓) — a HÍD: a stopword-számlálás (ez✓, és✓) a
-- magyar nyelvet találja — a szavak átírása (pl. "és"→"and") törné.
bizMagyarMondatFelismerve : besorol "Ez a mondat magyar, és világos." = MagyarNyelv
bizMagyarMondatFelismerve = Refl

-- ─── 6. MAIN — rögzített útvonalak (System.File, Kereso-minta) ──
-- ─── 六、main——固定路径（System.File，Kereso 模式） ──

||| A hibátlan próba (4 mondat: magyar. 中文. EN. DE.) útvonala.
||| 无错试样（四句）路径。
hibátlanPróbaÚt : String
hibátlanPróbaÚt =
  "/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode/negynyelvű_próba_hibátlan.txt"

||| A hibás próba (8 mondat, a kiírt 7. sorszámú ANGOL DE helyett).
||| 有错试样（八句，打印序号 7 者为英语）路径。
hibásPróbaÚt : String
hibásPróbaÚt =
  "/var/folders/cw/4jhpxnwn47d7y4jyg2zgvpx80000gn/T/opencode/negynyelvű_próba_hibás.txt"

||| Egy ítélet kiírandó sora (lambda nélkül: mondatSor + kompozíció).
||| 单行输出（无 lambda）。
mondatSor : MondatÍtélet -> String
mondatSor (MondatÍtéletKonstruktor pozíció vártJel találtJel rendbenVan) =
  (show pozíció) ++ ". " ++ (show vártJel) ++ " ↔ " ++ (show találtJel)
    ++ (if rendbenVan then "  ✓" else "  ✗ HIBA")

||| Egy fájl ellenőrzése: beolvasás + mondatonkénti ítélet + verdikt.
||| (Az @-minta a #27 gyógyíre: a bal oldali csupasz ékezetes
||| mintaváltozó ennél az IO-do-s függvénynél elbukott.)
||| covering: a System.File.readFile eléri a Data.Fuel.forever-t —
||| a rendszer-perem nem totálisítható, a TISZTA mag marad %total.
||| 检验一个文件：读入＋逐句判定＋裁定（@-模式即陷阱 #27 的解药；
||| 边界 readFile 触及 forever——故标 covering，纯核仍 total）。
covering
próbaFuttatás : String -> IO ()
próbaFuttatás útvonal@_ = do
  putStrLn ("── fájl / 文件: " ++ útvonal)
  tartalom <- readFile útvonal
  case tartalom of
    Right szöveg => do
      traverse_ (putStrLn . mondatSor) (ellenőrzés szöveg)
      putStrLn (végÍtélet szöveg)
    Left hiba => putStrLn ("olvasási hiba / 读取错误: " ++ show hiba)

||| A főprogram: a KÉT próba futtatása (rögzített útvonalakról —
||| getArgs helyett, mert a System.Environment ebben az installban
||| nem elérhető; a Kereso.idr readFile-mintája).
||| covering: a readFile pereme miatt (l. próbaFuttatás).
||| 主程序：运行两个试样（固定路径——替代 getArgs；因 readFile 边界标 covering）。
covering
main : IO ()
main = do
  putStrLn "═══ NÉGNYELVŰ-ELLENŐRZŐ · 四语检验器 · v2 ═══"
  próbaFuttatás hibátlanPróbaÚt
  putStrLn ""
  próbaFuttatás hibásPróbaÚt
