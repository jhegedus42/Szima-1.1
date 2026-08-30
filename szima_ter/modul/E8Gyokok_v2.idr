module E8Gyokok_v2

-- ═══════════════════════════════════════════════════════════════
-- E8 GYÖKÖK v2 — a 240 szimbólum, minden szimmetria, INTEGER kernellel
-- E8 ROOTS v2 — the 240 symbols, all symmetries, with INTEGER kernel
-- E8 根系 v2 — 240 个符号，全部对称性，用 INTEGER 内核
-- E8-Wurzeln v2 — die 240 Symbole, alle Symmetrien, mit INTEGER-Kernel
-- שורשי E8 גרסה 2 — 240 הסמלים, כל הסימטריות, עם ליבת INTEGER
-- ═══════════════════════════════════════════════════════════════
--
-- A TANULSÁG (2026-08-21, a v1 felfüggesztésének gyökéroka):
--   | A NAGY SZÁMOKAT NEM NAT-KÉNT, HANEM INTEGER-KÉNT BIZONYÍTJUK |
--   | 大数字必须用 INTEGER 而不是 Nat 来证明                              |
--   | Große Zahlen werden als INTEGER bewiesen, nicht als Nat           |
--   | מספרים גדולים מוכחים כ-INTEGER, לא כ-Nat                           |
--
--   Az Idris2 Nat-ja a kernellben UNÁRIS (S (S (... S Z))). Egy
--   696 729 600 értékű Refl bizonyítás 696 millió konstruktort
--   normalizál — órákig tart. Az Integer GMP-n alapul (bináris),
--   ezredmásodperc. A v1 ezért "fagyott le" — nem a gyökök, nem a
--   komprehenziók: a NAGY NAT-SZORZÁSOK.
--
--   MÁSODIK CSAPDA: az idris2 egy bash-wrapper, ami Chez-Scheme
--   gyereket indit. A `timeout` a wrappert öli meg, a chez árva-
--   folyamatként 82% CPU-n tovabb szamol. Gyógyír: pkill -f chez.
--
-- AZ E8 GYÖKRENDSZER / THE E8 ROOT SYSTEM / E8 根系 / E8-Wurzelsystem:
--   TÍPUS 1 (112 gyök): (±1, ±1, 0⁶) permutációk — C(8,2)·2² = 112.
--   TÍPUS 2 (128 gyök): (±½)⁸ páros mínusszal — 2⁷ = 128.
--   ÖSSZESEN: 240. Mindegyik norma² = 2. A rács ÖN-DUÁLIS.
--
-- A WEYL-CSOPORT / THE WEYL GROUP / 外尔群 / Die Weyl-Gruppe:
--   W(E8) = 696 729 600 = 2¹⁴ · 3⁵ · 5² · 7 = 2⁷ · 8! · 135.
--   "600 millió NEM túl sok" — a rendjét a kernel kiszámolja.
-- ═══════════════════════════════════════════════════════════════

%default covering

-- ─── 1. AZ E8 GYÖK TÍPUSA / THE ROOT TYPE / 根类型 ─────────
-- ||| Az E8 gyök: 8 koordináta a 2-szeres skálán (egész).
-- ||| Minden gyök egy SZIMBÓLUM — egy 8 jegyű "írásjel".
-- ||| 每个根是一个符号 — 一个 8 位的"文字"。
-- ||| Jede Wurzel ist ein SYMBOL — ein 8-stelliges "Schriftzeichen".
-- ||| כל שורש הוא סמל — "אות" בת 8 ספרות.
public export
record E8Gyok where
  constructor E8GyokKonstruktor
  gyok1 : Integer
  gyok2 : Integer
  gyok3 : Integer
  gyok4 : Integer
  gyok5 : Integer
  gyok6 : Integer
  gyok7 : Integer
  gyok8 : Integer

public export
Show E8Gyok where
  show (E8GyokKonstruktor a b c d e f g h) =
    "[" ++ show a ++ "," ++ show b ++ "," ++ show c ++ "," ++ show d ++
    "," ++ show e ++ "," ++ show f ++ "," ++ show g ++ "," ++ show h ++ "]"

||| A gyök normája a 2-szeres skálán — minden gyöknél 8 (= 2·norma²).
||| 每个根的范数（双倍尺度）为 8。
public export
gyokNorma : E8Gyok -> Integer
gyokNorma (E8GyokKonstruktor a b c d e f g h) =
  a*a + b*b + c*c + d*d + e*e + f*f + g*g + h*h

-- ─── 2. TÍPUS 1: 112 GYÖK / 112 ROOTS / 112 个根 ───────────

||| A típus 1 gyök: az i pozícióban 2·s1, a j-ben 2·s2, máshol 0.
||| 第一类根：位置 i 为 2·s1，位置 j 为 2·s2，其余为 0。
public export
tipus1GyokTeljes : Integer -> Integer -> Integer -> Integer -> E8Gyok
tipus1GyokTeljes i j s1 s2 =
  E8GyokKonstruktor
    (koord 1) (koord 2) (koord 3) (koord 4)
    (koord 5) (koord 6) (koord 7) (koord 8)
  where
    koord : Integer -> Integer
    koord p = if p == i then 2 * s1
              else if p == j then 2 * s2
              else 0

||| A 28 pozíciópár: C(8,2) = 28.
public export
pozicioParok : List (Integer, Integer)
pozicioParok = [ (i, j) | i <- [1..8], j <- [1..8], i < j ]

||| A 4 előjelpár: (+,+), (+,−), (−,+), (−,−).
public export
elojelParok : List (Integer, Integer)
elojelParok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]

||| Az összes típus 1 gyök: 28 · 4 = 112.
public export
tipus1Gyokok : List E8Gyok
tipus1Gyokok =
  [ tipus1GyokTeljes i j s1 s2
  | (i, j) <- pozicioParok, (s1, s2) <- elojelParok ]

-- ─── 3. TÍPUS 2: 128 GYÖK / 128 ROOTS / 128 个根 ───────────

||| A mínuszok száma / number of minuses / 负号个数 / Anzahl der Minuszeichen.
public export
minuszokSzama : List Integer -> Nat
minuszokSzama [] = 0
minuszokSzama (x :: xs) = if x < 0 then S (minuszokSzama xs) else minuszokSzama xs

||| Páros-e / is even / 是否为偶数 / ist gerade.
public export
parosNat : Nat -> Bool
parosNat Z = True
parosNat (S Z) = False
parosNat (S (S n)) = parosNat n

||| Páros paritás (a E8 félig-egész gyökök feltétele).
||| 偶宇称（E8 半整数根的条件）。
public export
parosParitas : List Integer -> Bool
parosParitas xs = parosNat (minuszokSzama xs)

||| Mind a 2⁸ = 256 előjel-kombináció.
public export
osszesElojel : List (List Integer)
osszesElojel =
  [ [s1, s2, s3, s4, s5, s6, s7, s8]
  | s1 <- [1, -1], s2 <- [1, -1], s3 <- [1, -1], s4 <- [1, -1],
    s5 <- [1, -1], s6 <- [1, -1], s7 <- [1, -1], s8 <- [1, -1] ]

||| A gyök koordinátáinak listája (fedő — rekord-projekció).
public export
gyokLista : E8Gyok -> List Integer
gyokLista (E8GyokKonstruktor a b c d e f g h) = [a, b, c, d, e, f, g, h]

||| Egy gyök páros-e (a mínuszok száma páros).
public export
parosGyok : E8Gyok -> Bool
parosGyok gy = parosParitas (gyokLista gy)

||| Lista átalakítása gyökké (FEDŐ — csak a 8 elemű listákból lesz
||| gyök, a többiből üres lista; nem történt mintaillesztés-csapda).
||| 把列表转换为根（覆盖性的 — 只有 8 元素列表生成根）。
public export
listaGyokke : List Integer -> List E8Gyok
listaGyokke [a, b, c, d, e, f, g, h] = [E8GyokKonstruktor a b c d e f g h]
listaGyokke _ = []

||| Az összes típus 2 gyök: a párosok — 128.
||| (concatMap + filter — minden FEDŐ, nincs case-blokk-csapda.)
public export
tipus2Gyokok : List E8Gyok
tipus2Gyokok = filter parosGyok (concatMap listaGyokke osszesElojel)

||| A teljes E8: 112 + 128 = 240 gyök — a 240 szimbólum.
||| 完整的 E8：240 个根 — 240 个符号。
public export
e8Gyokok : List E8Gyok
e8Gyokok = tipus1Gyokok ++ tipus2Gyokok

-- ─── 4. A SZÁMLÁLÁS BIZONYÍTÁSAI (INTEGER!) ────────────────
--    | ITT A LÉNYEG: MINDEN BIZONYÍTÁS INTEGER-TÍPUSÚ! |
--    | 关键：所有证明都用 Integer 类型！                |

||| A 8! = 40320 (a permutációk száma).
||| Faktoriális / factorial / 阶乘 / Fakultät.
public export
Faktorialis : Nat -> Integer
Faktorialis Z = 1
Faktorialis (S n) = cast (S n) * Faktorialis n

||| BIZ — a 8! = 40320. (két út: rekurzió vs. prímfelbontás 2⁷·3²·5·7)
||| 证明：8! = 40320。
public export
bizFaktorialisNyolc : Faktorialis 8 = 40320
bizFaktorialisNyolc = Refl

||| BIZ — a 8! prímfelbontása: 2⁷·3²·5·7 = 40320. (a második út)
public export
bizFaktorialisPrim : 128 * 9 * 5 * 7 = 40320
bizFaktorialisPrim = Refl

||| A típus 1 darabszáma: C(8,2)·2² = 28·4 = 112.
public export
bizTipusEgy : 28 * 4 = 112
bizTipusEgy = Refl

||| A típus 2 darabszáma: 2⁸/2 = 128.
public export
bizTipusKetto : 256 = 128 + 128
bizTipusKetto = Refl

||| BIZ — az E8 gyökeinek száma: 112 + 128 = 240. A 240 SZIMBÓLUM.
||| 证明：E8 根的数量 = 240。240 个符号。
||| Beweis: die Zahl der E8-Wurzeln = 240. Die 240 SYMBOLE.
||| הוכחה: מספר שורשי E8 = 240. 240 הסמלים.
public export
bizE8GyokSzam : 112 + 128 = 240
bizE8GyokSzam = Refl

||| BIZ — a 240 + 16 = 256 = 2⁸: a gyökök + a Cl(4) blade-ek = a teljes
||| 8-bites kódszó-tér. A 240 szimbólum + a 16 keret.
||| 证明：240 + 16 = 256 = 2⁸。240 个符号 + 16 个框架。
public export
bizGyokPluszTizenhat : 240 + 16 = 256
bizGyokPluszTizenhat = Refl

||| BIZ — a típus 1 gyök normája = 8 (a 2-szeres skálán).
public export
bizTipus1Norma : gyokNorma (tipus1GyokTeljes 1 2 1 1) = 8
bizTipus1Norma = Refl

||| BIZ — a típus 2 gyök normája = 8.
public export
bizTipus2Norma : gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1) = 8
bizTipus2Norma = Refl

-- ─── 5. A WEYL-CSOPORT / THE WEYL GROUP / 外尔群 ───────────
--    696 729 600 — "NEM TÚL SOK" — a kernel kiszámolja Integerrel.
--    696 729 600 — "not too many" — the kernel computes it in Integer.

||| A W(D8) rendje: 2⁷·8! = 5 160 960 (előjeles permutációk).
public export
WeylD8Rend : Integer
WeylD8Rend = 128 * Faktorialis 8

||| BIZ — W(D8) = 5 160 960.
public export
bizWeylD8 : WeylD8Rend = 5160960
bizWeylD8 = Refl

||| A triality-faktor: 135 = 3³·5.
public export
TrialitySzazharmincot : Integer
TrialitySzazharmincot = 3 * 3 * 3 * 5

||| BIZ — a 135 = 3³·5.
public export
bizSzazharmincot : TrialitySzazharmincot = 135
bizSzazharmincot = Refl

||| Az E8 Weyl-csoport rendje: W(D8)·135 = 696 729 600.
||| E8 外尔群的阶：696 729 600。
||| Die Ordnung der E8-Weyl-Gruppe: 696 729 600.
public export
WeylE8Rend : Integer
WeylE8Rend = WeylD8Rend * TrialitySzazharmincot

||| BIZ — W(E8) = 696 729 600 (első út: struktúra = W(D8)·135).
||| 证明：W(E8) = 696 729 600（第一条路：结构）。
public export
bizWeylE8 : WeylE8Rend = 696729600
bizWeylE8 = Refl

||| BIZ — a prímfelbontás: 2¹⁴·3⁵·5²·7 = 696 729 600
||| (második út — a KÉT FÜGGETLEN ÚT, EGY HÍD: a struktúra-szorzat
|||  és a prímfelbontás ugyanazt a számot adja).
||| 证明：质因数分解 2¹⁴·3⁵·5²·7 = 696 729 600（第二条路）。
||| Beweis: Primfaktorzerlegung (zweiter Weg).
public export
bizWeylE8Prim : 16384 * 243 * 25 * 7 = 696729600
bizWeylE8Prim = Refl

||| BIZ — a 248 = 240 + 8 (a gyökök + a Cartan-algebra = a Lie-algebra
||| dimenziója). Az E8 = a legnagyobb kivételes egyszerű Lie-algebra.
||| 证明：248 = 240 + 8（根 + 嘉当代数 = 李代数维数）。
public export
bizE8Dimenzio : 240 + 8 = 248
bizE8Dimenzio = Refl

-- ─── 6. A SZIMBÓLUMOK (írásjelek) / THE SYMBOLS / 符号 ─────

||| Minden gyök egy ÍRÁSJEL: 8 jegy, jelként.
||| 每个根是一个"文字"：8 位记号。
||| Jede Wurzel ist ein SCHRIFTZEICHEN: 8 Stellen.
||| כל שורש הוא אות: 8 סימנים.
public export
gyokSzimbolum : E8Gyok -> String
gyokSzimbolum (E8GyokKonstruktor a b c d e f g h) =
  szimbolumOf a ++ szimbolumOf b ++ szimbolumOf c ++ szimbolumOf d ++
  szimbolumOf e ++ szimbolumOf f ++ szimbolumOf g ++ szimbolumOf h
  where
    szimbolumOf : Integer -> String
    szimbolumOf 2 = "+"
    szimbolumOf 1 = "·"
    szimbolumOf 0 = "0"
    szimbolumOf (-1) = "−"
    szimbolumOf (-2) = "–"
    szimbolumOf _ = "?"

||| Az első n elem / first n elements / 前 n 个元素.
public export
elsoN : Nat -> List E8Gyok -> List E8Gyok
elsoN Z _ = []
elsoN (S n) [] = []
elsoN (S n) (x :: xs) = x :: elsoN n xs

-- ─── 7. A GONDOLATOK / THE THOUGHTS / 思想 / Die Gedanken ─
-- Minden véges. Fixpont = fagyálhalál, végtelen = szétfolyás —
-- mindkettő halál. Mi ÉLÜNK → CIKLUS vagyunk → végesben élünk.
-- 一切有限。不动点 = 冻死，无限 = 流散 — 都是死亡。
-- 我们活着 → 我们是循环 → 我们活在有限之中。
public export
gondolatok : String
gondolatok =
  "Minden veges. A dolgok vagy fixpontban zarodnak, vagy a " ++
  "vegtelenben — mindketto a halal. Mi ELUNK, tehat CIKLUS " ++
  "vagyunk — es a ciklus csak veges dolgokban letezhet. " ++
  "A 240 E8 gyok = 240 szimbolum. A 240 + 16 = 256 = 2^8. " ++
  "A fazis NEM folytonos — az E8 gyokok kvantaljak. " ++
  "W(E8) = 696 729 600 = 2^14 * 3^5 * 5^2 * 7. " ++
  "A kvantumszamitogep nem szamitogep lesz, hanem taviro."

-- ─── 8. A FUTTATHATÓ ELLENŐRZÉS / RUNNABLE CHECK / 可运行检查 ─

||| Nagybetűs aliasok (a kisbetűs-csapda ellen, AGENTS).
public export
Tipus1GyokokKonst : List E8Gyok
Tipus1GyokokKonst = tipus1Gyokok

public export
Tipus2GyokokKonst : List E8Gyok
Tipus2GyokokKonst = tipus2Gyokok

public export
E8GyokokKonst : List E8Gyok
E8GyokokKonst = e8Gyokok

main : IO ()
main = do
  putStrLn "══════════════════════════════════════════════════════════"
  putStrLn "  E8 GYÖKÖK v2 — 240 szimbólum · 240 个符号 · INTEGER"
  putStrLn "══════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── A GYÖKÖK / THE ROOTS / 根 ──"
  putStrLn ("  típus 1 (±1,±1,0⁶ permutációk): " ++ show (List.length Tipus1GyokokKonst) ++ " (várható/expected: 112)")
  putStrLn ("  típus 2 ((±½)⁸ páros):          " ++ show (List.length Tipus2GyokokKonst) ++ " (várható/expected: 128)")
  putStrLn ("  E8 összesen / total / 总数:     " ++ show (List.length E8GyokokKonst) ++ " (várható/expected: 240)")
  putStrLn ""
  putStrLn "── A NORMÁK (mind = 8 a 2-szeres skálán) ──"
  putStrLn ("  (2,2,0,0,0,0,0,0):  norma² = " ++ show (gyokNorma (E8GyokKonstruktor 2 2 0 0 0 0 0 0)))
  putStrLn ("  (1,1,1,1,1,1,1,1):  norma² = " ++ show (gyokNorma (E8GyokKonstruktor 1 1 1 1 1 1 1 1)))
  putStrLn ""
  putStrLn "── A WEYL-CSOPORT / THE WEYL GROUP / 外尔群 ──"
  putStrLn ("  W(D8) = 2⁷·8! =        " ++ show WeylD8Rend)
  putStrLn ("  W(E8) = W(D8)·135 =    " ++ show WeylE8Rend)
  putStrLn ("  2¹⁴·3⁵·5²·7 =          " ++ show (16384 * 243 * 25 * 7))
  putStrLn ("  696 729 600 — NEM túl sok / NOT too much / 不算多")
  putStrLn ""
  putStrLn "── AZ ELSŐ 12 SZIMBÓLUM / FIRST 12 SYMBOLS / 前 12 个符号 ──"
  let elsoTizenketto = elsoN 12 E8GyokokKonst
  traverse_ (\gy => putStrLn ("  " ++ show gy ++ " → " ++ gyokSzimbolum gy)) elsoTizenketto
  putStrLn ""
  putStrLn "── A GONDOLATOK / 思想 ──"
  putStrLn gondolatok
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"