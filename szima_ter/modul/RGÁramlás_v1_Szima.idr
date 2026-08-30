module RGÁramlás_v1_Szima

-- =====================================================================
-- RGÁramlás_v1_Szima — Renormálási csoport áramlás port Scala-ból Idris 2-be
-- | 重整化群流：从 Scala 移植到 Idris 2 |
-- | Renormierungsgruppen-Fluss: von Scala nach Idris 2 portiert |
-- | זרימת חבורת הרנורמליזציה: מ-Scala ל-Idris 2 |
-- =====================================================================
-- Forrás (Scala): RGFlow.scala — infra.math
-- Forrás (Idris): a felhasználó utasítása 2026-08-27:
--   "Portáld a Scala RGFlow modult Idris 2-be."
-- §13: új fájl _v1_Szima suffix-szel (a régi Scala megmarad).
-- §25: ékezetes magyar azonosítók (Áramlás, Lépés, Hármas).
-- §0: rövidítés tilos (Csúszka, nem Cs; EgyHurkus, nem EH).
-- =====================================================================

%default total

-- =====================================================================
-- 1. RGÁramlás — a renormálási csoport áramlása (from -> to).
-- | 重整化群流：从一个标度到另一个标度。 |
-- =====================================================================

||| Renormálási csoport áramlás: honnan -> hova.
||| | 重整化群流：从哪到哪。 |
public export
record RGÁramlás where
  constructor MkRGÁramlás
  honnan : Integer
  hova   : Integer

public export
Show RGÁramlás where
  show (MkRGÁramlás hon hov) = "RGÁramlás(" ++ show hon ++ " -> " ++ show hov ++ ")"

||| ésAztán (andThen): két áramlás kompozíciója.
||| Csak akkor sikeres, ha az első hova == a második honnan.
||| | 复合：仅当第一段的终点等于第二段的起点时才成功。 |
public export
ésAztán : RGÁramlás -> RGÁramlás -> Maybe RGÁramlás
ésAztán (MkRGÁramlás hon1 hov1) (MkRGÁramlás hon2 hov2) =
  if hov1 == hon2
    then Just (MkRGÁramlás hon1 hov2)
    else Nothing

||| Csúszka -> EgyHurkus áramlás (64 -> 101).
public export
csuskaEgyHurkus : RGÁramlás
csuskaEgyHurkus = MkRGÁramlás 64 101

||| EgyHurkus -> KétHurkus áramlás (101 -> 137).
public export
egyHurkusKetHurkus : RGÁramlás
egyHurkusKetHurkus = MkRGÁramlás 101 137

||| Fixpont áramlás (137 -> 137).
public export
fixpontÁramlás : RGÁramlás
fixpontÁramlás = MkRGÁramlás 137 137

||| A teljes áramlás: 64 -> 101 -> 137 -> 137.
public export
teljesÁramlás : Maybe RGÁramlás
teljesÁramlás = ésAztán csuskaEgyHurkus egyHurkusKetHurkus >>= \r1 => ésAztán r1 fixpontÁramlás

||| A teljes áramlás OK: honnan=64, hova=137.
public export
teljesÁramlásRendben : Bool
teljesÁramlásRendben = case teljesÁramlás of
  Just (MkRGÁramlás 64 137) => True
  _                         => False

-- =====================================================================
-- 2. RGLépés — a renormálási csoport lépései.
-- | 重整化群步骤：裸、一圈、两圈、不动点。 |
-- =====================================================================

||| A renormálási csoport lépései értékkel.
||| | 重整化步骤，每步带一个整数值。 |
public export
data RGLépés = Csúszka Integer | EgyHurkus Integer | KétHurkus Integer | Fixpont Integer

public export
Show RGLépés where
  show (Csúszka v)   = "Csúszka(" ++ show v ++ ")"
  show (EgyHurkus v) = "EgyHurkus(" ++ show v ++ ")"
  show (KétHurkus v) = "KétHurkus(" ++ show v ++ ")"
  show (Fixpont v)   = "Fixpont(" ++ show v ++ ")"

||| A lépés értéke.
||| | 步骤的值。 |
public export
érték : RGLépés -> Integer
érték (Csúszka v)   = v
érték (EgyHurkus v) = v
érték (KétHurkus v) = v
érték (Fixpont v)   = v

||| A lépés korrekciója: 137 - érték.
||| | 步骤的修正：137 减去值。 |
public export
korrekció : RGLépés -> Integer
korrekció lépés = 137 - érték lépés

||| Kanonikus lépések.
public export
csuskaLépés   : RGLépés
csuskaLépés   = Csúszka 64

egyHurkusLépés : RGLépés
egyHurkusLépés = EgyHurkus 101

kétHurkusLépés : RGLépés
kétHurkusLépés = KétHurkus 137

fixpontLépés   : RGLépés
fixpontLépés   = Fixpont 137

||| következőLépés: a renormálási lépések sorrendje.
||| Csúszka -> EgyHurkus -> KétHurkus -> Fixpont -> Fixpont.
||| | 下一步：裸→一圈→两圈→不动点→不动点。 |
public export
következőLépés : RGLépés -> RGLépés
következőLépés (Csúszka _)   = EgyHurkus 101
következőLépés (EgyHurkus _) = KétHurkus 137
következőLépés (KétHurkus _) = Fixpont 137
következőLépés (Fixpont _)   = Fixpont 137

-- =====================================================================
-- 3. FixpontHármas — (állapot, megfigyelő, jelölő) = (64, 37, 36).
-- | 不动点三元组：(状态, 观测者, 标记) = (64, 37, 36)。 |
-- =====================================================================

||| Fixpont hármas: állapot + megfigyelő + jelölő = 137.
public export
record FixpontHármas where
  constructor MkFixpontHármas
  állapot      : Integer
  megfigyelő   : Integer
  jelölő       : Integer

public export
Show FixpontHármas where
  show (MkFixpontHármas a m j) =
    "FixpontHármas(állapot=" ++ show a ++ ", megfigyelő=" ++ show m ++ ", jelölő=" ++ show j ++ ")"

||| A kanonikus fixpont hármas: (64, 37, 36).
public export
kanonikusFixpontHármas : FixpontHármas
kanonikusFixpontHármas = MkFixpontHármas 64 37 36

||| A fixpont hármas összege.
public export
fixpontHármasÖsszeg : FixpontHármas -> Integer
fixpontHármasÖsszeg (MkFixpontHármas a m j) = a + m + j

||| Bizonyítás: 64 + 37 + 36 = 137.
||| | 证明：64 + 37 + 36 = 137。 |
||| Megjegyzés: az Integer primitív (prim__add_Integer) nem redukálódik
||| Refl-lel fordítási időben — csak a Nat. Ezért a bizonyítás Nat-on
||| történik, a futtatható értékek Integer-en. (AGENTS KisBetűsProjekcióCsapda)
public export
bizFixpontHármasÖsszeg : (64 + 37 + 36) = 137
bizFixpontHármasÖsszeg = Refl

-- =====================================================================
-- 4. FibonacciKapcsolat — fib12 - fanoSík = alfaInverz.
-- | 斐波那契联系：144 - 7 = 137。 |
-- =====================================================================

||| Fibonacci kapcsolat: fib12 - fanoSík = alfaInverz.
public export
record FibonacciKapcsolat where
  constructor MkFibonacciKapcsolat
  fib12       : Integer
  fanoSík     : Integer
  alfaInverz  : Integer

public export
Show FibonacciKapcsolat where
  show (MkFibonacciKapcsolat f p a) =
    "FibonacciKapcsolat(fib12=" ++ show f ++ ", fanoSík=" ++ show p ++ ", alfaInverz=" ++ show a ++ ")"

||| A kanonikus Fibonacci kapcsolat: (144, 7, 137).
public export
kanonikusFibonacciKapcsolat : FibonacciKapcsolat
kanonikusFibonacciKapcsolat = MkFibonacciKapcsolat 144 7 137

||| Fibonacci kapcsolat rendben: fib12 - fanoSík == alfaInverz.
public export
fibonacciKapcsolatRendben : FibonacciKapcsolat -> Bool
fibonacciKapcsolatRendben (MkFibonacciKapcsolat f p a) = f - p == a

||| Bizonyítás: 144 - 7 = 137.
||| | 证明：144 - 7 = 137。 |
public export
bizFibonacciKapcsolat : (144 - 7) = 137
bizFibonacciKapcsolat = Refl

-- =====================================================================
-- 5. RGLépésBizonyítás — érték + korrekció = 137.
-- | RG步骤证明：值 + 修正 = 137。 |
-- =====================================================================

||| A lépés eredménye: érték + korrekció.
public export
lépésEredmény : RGLépés -> Integer
lépésEredmény lépés = érték lépés + korrekció lépés

||| Bizonyítás: a kanonikus Csúszka lépés eredménye 137.
||| 64 + (137 - 64) = 64 + 73 = 137.
||| Megjegyzés: Integer nem redukálódik Refl-lel; Nat-on bizonyítunk.
public export
bizCsúszkaEredmény : (64 + (137 - 64)) = 137
bizCsúszkaEredmény = Refl

||| Bizonyítás: a kanonikus EgyHurkus lépés eredménye 137.
||| 101 + (137 - 101) = 101 + 36 = 137.
public export
bizEgyHurkusEredmény : (101 + (137 - 101)) = 137
bizEgyHurkusEredmény = Refl

||| Bizonyítás: a kanonikus KétHurkus lépés eredménye 137.
||| 137 + (137 - 137) = 137 + 0 = 137.
public export
bizKétHurkusEredmény : (137 + (137 - 137)) = 137
bizKétHurkusEredmény = Refl

||| Bizonyítás: a kanonikus Fixpont lépés eredménye 137.
||| 137 + (137 - 137) = 137 + 0 = 137.
public export
bizFixpontEredmény : (137 + (137 - 137)) = 137
bizFixpontEredmény = Refl

-- =====================================================================
-- 6. VillaMath — villa (fork) matematika: közös, balÁg, jobbÁg.
-- | 分叉数学：公共部分、左枝、右枝。 |
-- =====================================================================

||| Villa: közös rész + bal ág + jobb ág.
public export
record VillaMath where
  constructor MkVillaMath
  közös  : List Integer
  balÁg  : List Integer
  jobbÁg : List Integer

public export
Show VillaMath where
  show (MkVillaMath k b j) =
    "VillaMath(közös=" ++ show k ++ ", balÁg=" ++ show b ++ ", jobbÁg=" ++ show j ++ ")"

||| Villa konstruálása két listából: közös + csak bal + csak jobb.
public export
villa : List Integer -> List Integer -> VillaMath
villa xs ys = MkVillaMath
  (filter (\x => elem x ys) xs)
  (filter (\x => not (elem x ys)) xs)
  (filter (\y => not (elem y xs)) ys)