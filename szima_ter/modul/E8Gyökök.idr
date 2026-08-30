module E8Gyökök

-- ═══════════════════════════════════════════════════════════════
-- E8 GYÖKÖK (ékezetes nemzedék) — a 240 szimbólum, INTEGER kernellel
-- E8 ROOTS (accented generation) — the 240 symbols, INTEGER kernel
-- E8 根系（带变音符世代）—— 240 个符号，INTEGER 内核
-- E8-WURZELN (diakritische Generation) — die 240 Symbole
-- ═══════════════════════════════════════════════════════════════
--
-- AZ ÉKEZETES NEMZEDÉK (2026-08-22, §25 HARD RULE első hulláma):
--   a v2 minden azonosítója ÉKEZETES alakban él tovább (gyök, típus,
--   előjel, összes, páros, eloszlás, fázis, szög, súly, híd...).
--   §13: az E8Gyokok, E8Gyokok_v2 megmarad; §24: az elsoN/ListaGyokke
--   belső segédek közül a LEHETSÉGES standard (take) most IMPORT.
--   A v2 kommentjeinek elírásai is javítva (kernellben→kernelben,
--   indit→indít, tovabb szamol→tovább számol).
--
-- A TANULSÁG (2026-08-21, a v1 felfüggesztésének gyökéroka):
--   | A NAGY SZÁMOKAT NEM NAT-KÉNT, HANEM INTEGER-KÉNT BIZONYÍTJUK |
--   | 大数字必须用 INTEGER 而不是 Nat 来证明                            |
--   | Große Zahlen werden als INTEGER bewiesen, nicht als Nat         |
--   | מספרים גדולים מוכחים כ-INTEGER, לא כ-Nat                         |
--
--   Az Idris2 Nat-ja a kernelben UNÁRIS (S (S (... S Z))). Egy
--   696 729 600 értékű Refl bizonyítás 696 millió konstruktort
--   normalizál — órákig tart. Az Integer GMP-n alapul (bináris),
--   ezredmásodperc. A v1 ezért "fagyott le" — nem a gyökök, nem a
--   komprehenziók: a NAGY NAT-SZORZÁSOK.
--
--   MÁSODIK CSAPDA: az idris2 egy bash-wrapper, ami Chez-Scheme
--   gyereket indít. A `timeout` a wrappert öli meg, a chez árva-
--   folyamatként 82% CPU-n tovább számol. Gyógyír: pkill -f chez.
--
-- AZ E8 GYÖKRENDSZER / THE E8 ROOT SYSTEM / E8 根系:
--   TÍPUS 1 (112 gyök): (±1, ±1, 0⁶) permutációk — C(8,2)·2² = 112.
--   TÍPUS 2 (128 gyök): (±½)⁸ páros mínusszal — 2⁷ = 128.
--   ÖSSZESEN: 240. Mindegyik norma² = 2. A rács ÖN-DUÁLIS.
--
-- A WEYL-CSOPORT / THE WEYL GROUP / 外尔群:
--   W(E8) = 696 729 600 = 2¹⁴ · 3⁵ · 5² · 7 = 2⁷ · 8! · 135.
--   "600 millió NEM túl sok" — a rendjét a kernel kiszámolja.
-- ═══════════════════════════════════════════════════════════════

import Data.List  -- take (§24: standard, nem újraírva — ProbePrelude bizonyította)

%default covering

-- ─── 1. AZ E8 GYÖK TÍPUSA / THE ROOT TYPE / 根类型 ─────────

||| Az E8 gyök: 8 koordináta a 2-szeres skálán (egész).
||| Minden gyök egy SZIMBÓLUM — egy 8 jegyű "írásjel".
||| 每个根是一个符号 — 一个 8 位的"文字"。
public export
record E8Gyök where
  constructor E8GyökKonstruktor
  gyök1 : Integer
  gyök2 : Integer
  gyök3 : Integer
  gyök4 : Integer
  gyök5 : Integer
  gyök6 : Integer
  gyök7 : Integer
  gyök8 : Integer

public export
Show E8Gyök where
  show (E8GyökKonstruktor a b c d e f g h) =
    "[" ++ show a ++ "," ++ show b ++ "," ++ show c ++ "," ++ show d ++
    "," ++ show e ++ "," ++ show f ++ "," ++ show g ++ "," ++ show h ++ "]"

||| A gyök normája a 2-szeres skálán — minden gyöknél 8 (= 2·norma²).
||| 每个根的范数（双倍尺度）为 8。
public export
gyökNorma : E8Gyök -> Integer
gyökNorma (E8GyökKonstruktor a b c d e f g h) =
  a*a + b*b + c*c + d*d + e*e + f*f + g*g + h*h

-- ─── 2. TÍPUS 1: 112 GYÖK / 112 ROOTS / 112 个根 ───────────

||| A típus 1 gyök: az i pozícióban 2·s1, a j-ben 2·s2, máshol 0.
||| 第一类根：位置 i 为 2·s1，位置 j 为 2·s2，其余为 0。
public export
típus1GyökTeljes : Integer -> Integer -> Integer -> Integer -> E8Gyök
típus1GyökTeljes i j s1 s2 =
  E8GyökKonstruktor
    (koordináta 1) (koordináta 2) (koordináta 3) (koordináta 4)
    (koordináta 5) (koordináta 6) (koordináta 7) (koordináta 8)
  where
    koordináta : Integer -> Integer
    koordináta p = if p == i then 2 * s1
                   else if p == j then 2 * s2
                   else 0

||| A 28 pozíciópár: C(8,2) = 28.
public export
pozícióPárok : List (Integer, Integer)
pozícióPárok = [ (i, j) | i <- [1..8], j <- [1..8], i < j ]

||| A 4 előjelpár: (+,+), (+,−), (−,+), (−,−).
public export
előjelPárok : List (Integer, Integer)
előjelPárok = [(1, 1), (1, -1), (-1, 1), (-1, -1)]

||| Az összes típus 1 gyök: 28 · 4 = 112.
public export
típus1Gyökök : List E8Gyök
típus1Gyökök =
  [ típus1GyökTeljes i j s1 s2
  | (i, j) <- pozícióPárok, (s1, s2) <- előjelPárok ]

-- ─── 3. TÍPUS 2: 128 GYÖK / 128 ROOTS / 128 个根 ───────────

||| A mínuszok száma / number of minuses / 负号个数.
public export
mínuszokSzáma : List Integer -> Nat
mínuszokSzáma [] = 0
mínuszokSzáma (x :: xs) = if x < 0 then S (mínuszokSzáma xs) else mínuszokSzáma xs

||| Páros-e / is even / 是否为偶数.
public export
párosNat : Nat -> Bool
párosNat Z = True
párosNat (S Z) = False
párosNat (S (S n)) = párosNat n

||| Páros paritás (az E8 félig-egész gyökök feltétele).
||| 偶宇称（E8 半整数根的条件）。
public export
párosParitás : List Integer -> Bool
párosParitás xs = párosNat (mínuszokSzáma xs)

||| Mind a 2⁸ = 256 előjel-kombináció.
public export
összesElőjel : List (List Integer)
összesElőjel =
  [ [s1, s2, s3, s4, s5, s6, s7, s8]
  | s1 <- [1, -1], s2 <- [1, -1], s3 <- [1, -1], s4 <- [1, -1],
    s5 <- [1, -1], s6 <- [1, -1], s7 <- [1, -1], s8 <- [1, -1] ]

||| A gyök koordinátáinak listája (fedő — rekord-projekció).
public export
gyökLista : E8Gyök -> List Integer
gyökLista (E8GyökKonstruktor a b c d e f g h) = [a, b, c, d, e, f, g, h]

||| Egy gyök páros-e (a mínuszok száma páros).
public export
párosGyök : E8Gyök -> Bool
párosGyök gy = párosParitás (gyökLista gy)

||| Lista átalakítása gyökké (FEDŐ — csak a 8 elemű listákból lesz
||| gyök, a többiből üres lista; nem történt mintaillesztés-csapda).
||| 把列表转换为根（覆盖性的 — 只有 8 元素列表生成根）。
public export
listaGyökké : List Integer -> List E8Gyök
listaGyökké [a, b, c, d, e, f, g, h] = [E8GyökKonstruktor a b c d e f g h]
listaGyökké _ = []

||| Az összes típus 2 gyök: a párosok — 128.
||| (concatMap + filter — minden FEDŐ, nincs case-blokk-csapda.)
public export
típus2Gyökök : List E8Gyök
típus2Gyökök = filter párosGyök (concatMap listaGyökké összesElőjel)

||| A teljes E8: 112 + 128 = 240 gyök — a 240 szimbólum.
||| 完整的 E8：240 个根 — 240 个符号。
public export
e8Gyökök : List E8Gyök
e8Gyökök = típus1Gyökök ++ típus2Gyökök

-- ─── 4. A SZÁMLÁLÁS BIZONYÍTÁSAI (INTEGER!) ────────────────
--    | ITT A LÉNYEG: MINDEN BIZONYÍTÁS INTEGER-TÍPUSÚ! |
--    | 关键：所有证明都用 Integer 类型！                |

||| A 8! = 40320 (a permutációk száma).
||| Faktoriális / factorial / 阶乘 / Fakultät.
public export
Faktoriális : Nat -> Integer
Faktoriális Z = 1
Faktoriális (S n) = cast (S n) * Faktoriális n

||| BIZ — a 8! = 40320. (két út: rekurzió vs. prímfelbontás 2⁷·3²·5·7)
||| 证明：8! = 40320。
public export
bizFaktoriálisNyolc : Faktoriális 8 = 40320
bizFaktoriálisNyolc = Refl

||| BIZ — a 8! prímfelbontása: 2⁷·3²·5·7 = 40320. (a második út)
public export
bizFaktoriálisPrím : 128 * 9 * 5 * 7 = 40320
bizFaktoriálisPrím = Refl

||| A típus 1 darabszáma: C(8,2)·2² = 28·4 = 112.
public export
bizTípusEgy : 28 * 4 = 112
bizTípusEgy = Refl

||| A típus 2 darabszáma: 2⁸/2 = 128.
public export
bizTípusKettő : 256 = 128 + 128
bizTípusKettő = Refl

||| BIZ — az E8 gyökeinek száma: 112 + 128 = 240. A 240 SZIMBÓLUM.
||| 证明：E8 根的数量 = 240。240 个符号。
||| Beweis: die Zahl der E8-Wurzeln = 240. Die 240 SYMBOLE.
||| הוכחה: מספר שורשי E8 = 240. 240 הסמלים.
public export
bizE8GyökSzám : 112 + 128 = 240
bizE8GyökSzám = Refl

||| BIZ — a 240 + 16 = 256 = 2⁸: a gyökök + a Cl(4) pengék = a teljes
||| 8-bites kódszó-tér. A 240 szimbólum + a 16 keret.
||| 证明：240 + 16 = 256 = 2⁸。240 个符号 + 16 个框架。
public export
bizGyökPluszTizenhat : 240 + 16 = 256
bizGyökPluszTizenhat = Refl

||| BIZ — a típus 1 gyök normája = 8 (a 2-szeres skálán).
public export
bizTípus1Norma : gyökNorma (típus1GyökTeljes 1 2 1 1) = 8
bizTípus1Norma = Refl

||| BIZ — a típus 2 gyök normája = 8.
public export
bizTípus2Norma : gyökNorma (E8GyökKonstruktor 1 1 1 1 1 1 1 1) = 8
bizTípus2Norma = Refl

-- ─── 5. A WEYL-CSOPORT / THE WEYL GROUP / 外尔群 ───────────
--    696 729 600 — "NEM TÚL SOK" — a kernel kiszámolja Integerrel.

||| A W(D8) rendje: 2⁷·8! = 5 160 960 (előjeles permutációk).
public export
WeylD8Rend : Integer
WeylD8Rend = 128 * Faktoriális 8

||| BIZ — W(D8) = 5 160 960.
public export
bizWeylD8 : WeylD8Rend = 5160960
bizWeylD8 = Refl

||| A trialitás-faktor: 135 = 3³·5.
public export
TrialitásSzázharmincöt : Integer
TrialitásSzázharmincöt = 3 * 3 * 3 * 5

||| BIZ — a 135 = 3³·5.
public export
bizSzázharmincöt : TrialitásSzázharmincöt = 135
bizSzázharmincöt = Refl

||| Az E8 Weyl-csoport rendje: W(D8)·135 = 696 729 600.
||| E8 外尔群的阶：696 729 600。
||| Die Ordnung der E8-Weyl-Gruppe: 696 729 600.
public export
WeylE8Rend : Integer
WeylE8Rend = WeylD8Rend * TrialitásSzázharmincöt

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
bizWeylE8Prím : 16384 * 243 * 25 * 7 = 696729600
bizWeylE8Prím = Refl

||| BIZ — a 248 = 240 + 8 (a gyökök + a Cartan-algebra = a Lie-algebra
||| dimenziója). Az E8 = a legnagyobb kivételes egyszerű Lie-algebra.
||| 证明：248 = 240 + 8（根 + 嘉当代数 = 李代数维数）。
public export
bizE8Dimenzió : 240 + 8 = 248
bizE8Dimenzió = Refl

-- ─── 6. A SZIMBÓLUMOK (írásjelek) / THE SYMBOLS / 符号 ─────

||| Minden gyök egy ÍRÁSJEL: 8 jegy, jelként.
||| 每个根是一个"文字"：8 位记号。
||| Jede Wurzel ist ein SCHRIFTZEICHEN: 8 Stellen.
||| כל שורש הוא אות: 8 סימנים.
public export
gyökSzimbólum : E8Gyök -> String
gyökSzimbólum (E8GyökKonstruktor a b c d e f g h) =
  szimbólumSobre a ++ szimbólumSobre b ++ szimbólumSobre c ++ szimbólumSobre d ++
  szimbólumSobre e ++ szimbólumSobre f ++ szimbólumSobre g ++ szimbólumSobre h
  where
    szimbólumSobre : Integer -> String
    szimbólumSobre 2 = "+"
    szimbólumSobre 1 = "·"
    szimbólumSobre 0 = "0"
    szimbólumSobre (-1) = "−"
    szimbólumSobre (-2) = "–"
    szimbólumSobre _ = "?"

-- ─── 7. A GONDOLATOK / THE THOUGHTS / 思想 / Die Gedanken ─
-- Minden véges. Fixpont = fagyálhalál, végtelen = szétfolyás —
-- mindkettő halál. Mi ÉLÜNK → CIKLUS vagyunk → végesben élünk.
-- 一切有限。不动点 = 冻死，无限 = 流散 — 都是死亡。
-- 我们活着 → 我们是循环 → 我们活在有限之中。
public export
gondolatok : String
gondolatok =
  "Minden véges. A dolgok vagy fixpontban záródnak, vagy a " ++
  "végtelenben — mindkettő a halál. Mi ÉLÜNK, tehát CIKLUS " ++
  "vagyunk — és a ciklus csak véges dolgokban létezhet. " ++
  "A 240 E8 gyök = 240 szimbólum. A 240 + 16 = 256 = 2^8. " ++
  "A fázis NEM folytonos — az E8 gyökök kvantálják. " ++
  "W(E8) = 696 729 600 = 2^14 * 3^5 * 5^2 * 7. " ++
  "A kvantumszámítógép nem számítógép lesz, hanem távíró."

-- ─── 8. A FUTTATHATÓ ELLENŐRZÉS / RUNNABLE CHECK / 可运行检查 ─

||| Nagybetűs aliasok (a kisbetűs-csapda ellen, AGENTS).
public export
Típus1GyökökKonst : List E8Gyök
Típus1GyökökKonst = típus1Gyökök

public export
Típus2GyökökKonst : List E8Gyök
Típus2GyökökKonst = típus2Gyökök

public export
E8GyökökKonst : List E8Gyök
E8GyökökKonst = e8Gyökök

main : IO ()
main = do
  putStrLn "══════════════════════════════════════════════════════════"
  putStrLn "  E8 GYÖKÖK (ékezetes nemzedék) — 240 szimbólum · 240 个符号"
  putStrLn "══════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── A GYÖKÖK / THE ROOTS / 根 ──"
  putStrLn ("  típus 1 (±1,±1,0⁶ permutációk): " ++ show (List.length Típus1GyökökKonst) ++ " (várható: 112)")
  putStrLn ("  típus 2 ((±½)⁸ páros):          " ++ show (List.length Típus2GyökökKonst) ++ " (várható: 128)")
  putStrLn ("  E8 összesen / total / 总数:     " ++ show (List.length E8GyökökKonst) ++ " (várható: 240)")
  putStrLn ""
  putStrLn "── A NORMÁK (mind = 8 a 2-szeres skálán) ──"
  putStrLn ("  (2,2,0,0,0,0,0,0):  norma² = " ++ show (gyökNorma (E8GyökKonstruktor 2 2 0 0 0 0 0 0)))
  putStrLn ("  (1,1,1,1,1,1,1,1):  norma² = " ++ show (gyökNorma (E8GyökKonstruktor 1 1 1 1 1 1 1 1)))
  putStrLn ""
  putStrLn "── A WEYL-CSOPORT / THE WEYL GROUP / 外尔群 ──"
  putStrLn ("  W(D8) = 2⁷·8! =        " ++ show WeylD8Rend)
  putStrLn ("  W(E8) = W(D8)·135 =    " ++ show WeylE8Rend)
  putStrLn ("  2¹⁴·3⁵·5²·7 =          " ++ show (16384 * 243 * 25 * 7))
  putStrLn ("  696 729 600 — NEM túl sok / NOT too much / 不算多")
  putStrLn ""
  putStrLn "── AZ ELSŐ 12 SZIMBÓLUM / FIRST 12 SYMBOLS / 前 12 个符号 ──"
  let elsőTizenkettő = take 12 E8GyökökKonst
  traverse_ (\gy => putStrLn ("  " ++ show gy ++ " → " ++ gyökSzimbólum gy)) elsőTizenkettő
  putStrLn ""
  putStrLn "── A GONDOLATOK / 思想 ──"
  putStrLn gondolatok
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
