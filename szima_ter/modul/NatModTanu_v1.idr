module NatModTanu_v1

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ NAT-MOD TANÚ · v1 — az isPrime/factorize nyitott tanúi, lezárva    ║
-- ║ NAT-MOD 见证 · v1 — isPrime/factorize 的悬置见证在此闭合            ║
-- ║ NAT-MOD WITNESS · v1 — the open isPrime/factorize witnesses closed ║
-- ║ NAT-MOD ZEUGE · v1 — die offenen isPrime/factorize-Zeugen          ║
-- ╚══════════════════════════════════════════════════════════════════╝
--
-- A MODULHATÁR-JELENSÉG (mérés: ModulhatárProbe_v1, 2026-09-04) /
-- 模块边界现象（见探针测量）/ THE MODULE-BOUNDARY PHENOMENON:
-- A PrimeLogic_v1_Szima-ban `natMod`/`natDiv`/`isPrimeHelper`/
-- `factorizeHelper` PRIVÁT. Az `isPrime` törzse látszik (public
-- export), de a privát segédek nem nyithatók fel modulhatáron át →
-- külső modulban friss `Refl : isPrime 4 = False` NEM zár:
--   «Can't solve constraint between: False and if natMod 4 2 == 0
--    then False else isPrimeHelper 4 3.»
-- 在 PrimeLogic 内部 natMod/isPrimeHelper 为私有——跨模块不可展开，
-- 外部新写 Refl 不闭合（错误信息原文如上）。
-- Inside PrimeLogic the helpers are private; they cannot unfold
-- across the module boundary, so a fresh Refl outside fails.
-- Die privaten Helfer falten über Modulgrenzen nicht auf; ein
-- frisches Refl draußen schließt nicht.
--
-- A KÉT GYÓGYÍR EGY FÁJLBAN / 一文件两种疗法 / BOTH CURES, ONE FILE:
-- (1) FORDÍTÁSI IDEJŰ: a PrimeLogic BELSEJÉBEN már elaborált tanúk
--     (fourIsComposite, sixFactors, compositeIsMorphism, …) IMPORTÁLVA
--     (§24: soha nem újraírni!) — a bizonyítás-TERV a típusben él,
--     a Refl a belsejében már lefutott.
--     (2) 编译期：导入已在 PrimeLogic 内部完成的证明（不重写）。
--     (1) COMPILE-TIME: the proofs already elaborated INSIDE
--     PrimeLogic are IMPORTED, never rewritten.
--     (1) KOMPILIERZEIT: die innerhalb PrimeLogic elaborierten
--     Beweise werden importiert, nie neu geschrieben.
-- (2) FUTÁSIDEJŰ Show-teszt: `main` KIÍRJA az értékeket — az igazságot
--     a futás viszi oda, ahol a Refl nem megy át a határon.
--     (2) 运行时 Show 测试：main 打印值——跨不过边界处由运行证真。
--     (2) RUNTIME Show-test: main prints the values — truth carried
--     by execution where Refl cannot cross.
--     (2) LAUFZEIT-Show-Test: main druckt die Werte.

import PrimeLogic_v1_Szima
import HungarianLexicon_v1_Szima

%default total

-- ═══════════════════════════════════════════════════════════════════
-- (1) FORDÍTÁSI IDEJŰ TANÚK — IMPORTÁLVA (§24) · 编译期见证（导入）
--     COMPILE-TIME WITNESSES — IMPORTED · KOMPILIERZEIT — IMPORTIERT
-- ═══════════════════════════════════════════════════════════════════

-- Kimenet: Refl a PrimeLogic belsejében elaborálva, itt importálva —
-- a 4 összetett: natMod 4 2 = 0, azaz osztója a 2.
public export
négyÖsszetettTanú : PrimeLogic_v1_Szima.isPrime 4 = False
négyÖsszetettTanú = PrimeLogic_v1_Szima.fourIsComposite

-- Kimenet: Refl (importálva) — a 6 bontása: 6 = 2 × 3.
public export
hatBontásaTanú : PrimeLogic_v1_Szima.factorize 6 = [2, 3]
hatBontásaTanú = PrimeLogic_v1_Szima.sixFactors

-- Kimenet: Refl (importálva) — az összetett szám morfizmus-szerepű.
public export
négyMorfizmusTanú : PrimeLogic_v1_Szima.numberRole 4 = MorphismRole
négyMorfizmusTanú = PrimeLogic_v1_Szima.compositeIsMorphism

-- Kimenet: Refl (importálva) — az 5 prím, az 5-ödik.
public export
ötPrímTanú : PrimeLogic_v1_Szima.isPrime 5 = True
ötPrímTanú = PrimeLogic_v1_Szima.fiveIsPrime

-- ═══════════════════════════════════════════════════════════════════
-- (2) FUTÁSIDEJŰ Show-teszt · 运行时 Show 测试 · RUNTIME SHOW-TEST
-- ═══════════════════════════════════════════════════════════════════

||| A MathRole megjelenítése (nincs Show-instance-ütközés — saját név).
||| MathRole 的显示（避免 Show 实例冲突——自起名）。
public export
szerepkörSzöveg : MathRole -> String
szerepkörSzöveg ObjectRole    = "ObjectRole (prím = főnév = objektum)"
szerepkörSzöveg MorphismRole  = "MorphismRole (összetett = ige = morfizmus)"
szerepkörSzöveg PropertyRole  = "PropertyRole"
szerepkörSzöveg ModifierRole  = "ModifierRole"

||| A bemutató szövege: a natMod mögötti gép futásidőben SZÁMOL.
||| 演示文本：natMod 背后的机器在运行时真实计算。
||| CSAPDA-JEGYZET (új változat, 2026-09-04): %default total mellett a
||| fordító elutasítja, mert a hívólánc isPrime → isPrimeHelper → natMod
||| «possibly not terminating» («Error: bemutatóSzöveg is not total,
||| possibly not terminating due to function PrimeLogic_v1_Szima.natMod
||| being reachable via …»). A natMod nem strukturálisan rekurzív
||| (if + minus). Gyógyír: a PEREM `partial` (a PrimeLogic maga is
||| %default partial) — a tiszta mag (az importált tanúk) total marad.
||| ÉS: az -o build exit-kódja 0 volt a hibaüzenet MELLETT (GAUGE #23
||| ismét!) — a kimenetet OLVASNI kell, az exit-kód hazudik.
partial
bemutatóSzöveg : String
bemutatóSzöveg =
  "=== NatModTanu_v1 — futásidejű Show-teszt ===\n" ++
  "  isPrime 4    = " ++ show (isPrime 4)    ++ "   (elvárt: False — a 4 összetett)\n" ++
  "  isPrime 5    = " ++ show (isPrime 5)    ++ "   (elvárt: True — az 5 prím)\n" ++
  "  factorize 6  = " ++ show (factorize 6)  ++ " (elvárt: [2, 3])\n" ++
  "  numberRole 4 = " ++ szerepkörSzöveg (numberRole 4) ++ "\n" ++
  "  fordítási idejű tanúk: négyÖsszetettTanú, hatBontásaTanú,\n" ++
  "                         négyMorfizmusTanú, ötPrímTanú (importálva, §24)\n" ++
  "  Megjegyzés: a natMod önmaga privát — közvetlenül nem importálható;\n" ++
  "  az értékét a fenti hívások belsejében számolja a futtatókörnyezet.\n"

partial
main : IO ()
main = putStrLn bemutatóSzöveg
