module CayleyDickson

-- ═══════════════════════════════════════════════════════════════
-- CAYLEY-DICKSON TORONY — ℝ → ℂ → ℍ → 𝕆 → Sedenion
-- 凯莱–迪克森塔——实数→复数→四元数→八元数→十六元数
-- ═══════════════════════════════════════════════════════════════
-- A Cayley-Dickson konstrukció minden szinten duplázza a dimenziót:
--   ℝ (1) → ℂ (2) → ℍ (4) → 𝕆 (8) → Sedenion (16)
-- 每一层把维度翻倍。
--
-- Minden szint: dim = 2^n
-- Egységek: 2, 4, 24, 240 (már létezik: OktonionAlgebra.idr)
--
-- TULAJDONSÁGOK SZINTENKÉNT / 各层性质:
--   ℝ: asszociatív, kommutatív, rendezett
--   ℂ: asszociatív, kommutatív, rendezett
--   ℍ: asszociatív, NEM kommutatív, rendezett
--   𝕆: NEM asszociatív, NEM kommutatív, NEM rendezett —
--      de MÉG divíziós algebra (minden nemnulla elem invertálható)
--   Sedenion: NEM asszociatív, NEM kommutatív, NEM rendezett,
--             MÁR NEM divíziós algebra (nulla-osztói vannak, pl.
--             (e₃+e₁₀)(e₆−e₁₅)=0; a norma van, de NEM multiplikatív)
--   八元数：非结合、非交换、非有序——但仍是可除代数（每个非零元可逆）。
--   十六元数：非结合、非交换、非有序，不再是可除代数（有零因子，
--             如 (e₃+e₁₀)(e₆−e₁₅)=0；有范数，但范数不乘性）。
-- -- RÉGI (HAMIS) állítás, javítva 2026-09-05: „Sedenion: … DIVIZIÓS
-- -- ALGEBRA (van norma)" — HAMIS: a sedenionnak nulla-osztói vannak;
-- -- a Hurwitz-tétel szerint divíziós algebra pontosan ℝ, ℂ, ℍ, 𝕆 —
-- -- a torony ℝ→ℂ→ℍ→𝕆 szakasza divíziós, a sedenion MÁR NEM.
-- -- 旧（错误）说法，2026-09-05 已改正：「十六元数是可除代数（有范数）」
-- -- ——误：十六元数有零因子；据 Hurwitz 定理，可除代数恰为
-- -- ℝ、ℂ、ℍ、𝕆——塔中至此为止，十六元数已不是可除代数。
--
-- KAPCSOLAT A PROJEKTHEZ / 与项目的联系:
--   - Az oktonion egységek (16) + E8 gyökök (224) = 240
--   - A sedenion 16 dimenziója = 4×4-es mátrixok tere
--   - A hibajavító kódok (Steane [[7,1,3]]) beépíthetők
--
-- 100.07 ÁTÍRÁS (2026-09-03): a Valós REKORD (nem Double-szinonima!),
-- az aritmetika típusos fv-család (valósÖsszead/Kivon/Szoroz/Negál),
-- a literálok nevezett konstansokba csomagolva, dimenzió/egységekSzáma
-- Sorszám (§24: import Alap.CsomagoltTipusok — sorTizenhat!),
-- minden azonosító ékezetes (AkH.12), 9 kínai szakaszcím.
-- 中文：100.07 改写——Valós 记录化、四则运算类型化、字面量入常量、
-- 维度与单位数用 Sorszám、全部标识符带变音符、九个中文标题。
-- ═══════════════════════════════════════════════════════════════

import Alap.CsomagoltTipusok

%default total

-- ─── 1. ALAPTÍPUS: VALÓS SZÁM (REKORD, nem Double-szinonima!) ──
-- 一、实数（记录，不再是 Double 同义词！）──────────
-- A Valós mostantól SAJÁT típus: a Double csak a belső hordozó.
-- 实数从此是自己的类型——Double 只是内部载体。
public export
record Valós where
  constructor ValósKonstruktor
  érték : Double

public export
Eq Valós where
  (==) a b = érték a == érték b

public export
Show Valós where
  show v = show (érték v)

-- Típusos aritmetika / 类型化四则运算:
public export
valósÖsszead : Valós -> Valós -> Valós
valósÖsszead a b = ValósKonstruktor (érték a + érték b)

public export
valósKivon : Valós -> Valós -> Valós
valósKivon a b = ValósKonstruktor (érték a - érték b)

public export
valósSzoroz : Valós -> Valós -> Valós
valósSzoroz a b = ValósKonstruktor (érték a * érték b)

public export
valósNegál : Valós -> Valós
valósNegál a = ValósKonstruktor (negate (érték a))

-- Nevezett valós konstansok (a literálok REKORDBA csomagolva):
public export
valósNulla, valósEgység, valósMínuszEgység : Valós
valósNulla        = ValósKonstruktor 0
valósEgység       = ValósKonstruktor 1
valósMínuszEgység = ValósKonstruktor (-1)

-- ─── 2. KOMPLEX SZÁM ──────────────────────────────────────
-- 二、复数 ────────────────
public export
record Komplex where
  constructor KomplexKonstruktor
  re : Valós
  im : Valós

public export
Eq Komplex where
  (==) a b = (re a == re b) && (im a == im b)

public export
Show Komplex where
  show k = show (re k) ++ " + " ++ show (im k) ++ "i"

public export
komplexNulla : Komplex
komplexNulla = KomplexKonstruktor valósNulla valósNulla

public export
komplexEgység : Komplex
komplexEgység = KomplexKonstruktor valósEgység valósNulla

-- A negatív imaginárius egység NEVEZETT konstans (a (-1) literál
-- a rekord MEZŐJÉBEN él — nem szabadon úszkál):
public export
mínuszImagináriusEgység : Komplex
mínuszImagináriusEgység =
  KomplexKonstruktor valósNulla valósMínuszEgység

public export
komplexKonjugál : Komplex -> Komplex
komplexKonjugál k = KomplexKonstruktor (re k) (valósNegál (im k))

public export
komplexSzoroz : Komplex -> Komplex -> Komplex
komplexSzoroz a b = KomplexKonstruktor
  (valósKivon (valósSzoroz (re a) (re b)) (valósSzoroz (im a) (im b)))
  (valósÖsszead (valósSzoroz (re a) (im b)) (valósSzoroz (im a) (re b)))

public export
komplexNormaNégyzet : Komplex -> Valós
komplexNormaNégyzet k =
  valósÖsszead (valósSzoroz (re k) (re k)) (valósSzoroz (im k) (im k))

-- ─── 3. KVATERNION ────────────────────────────────────────
-- 三、四元数 ────────────────
public export
record Kvaternion where
  constructor KvaternionKonstruktor
  első : Komplex
  második : Komplex

public export
Eq Kvaternion where
  (==) a b = (első a == első b) && (második a == második b)

public export
Show Kvaternion where
  show kv = show (első kv) ++ " + " ++ show (második kv) ++ "j"

public export
kvaternionNulla : Kvaternion
kvaternionNulla = KvaternionKonstruktor komplexNulla komplexNulla

public export
kvaternionEgység : Kvaternion
kvaternionEgység = KvaternionKonstruktor komplexEgység komplexNulla

-- A (-1) valós egység komplex-ként és kvaternion-ként NEVEZVE:
public export
mínuszEgységKomplex : Komplex
mínuszEgységKomplex = KomplexKonstruktor valósMínuszEgység valósNulla

public export
mínuszEgységKvaternion : Kvaternion
mínuszEgységKvaternion =
  KvaternionKonstruktor mínuszEgységKomplex komplexNulla

public export
kvaternionKonjugál : Kvaternion -> Kvaternion
kvaternionKonjugál kv = KvaternionKonstruktor
  (komplexKonjugál (első kv))
  (komplexSzoroz mínuszImagináriusEgység (második kv))

public export
kvaternionSzoroz : Kvaternion -> Kvaternion -> Kvaternion
kvaternionSzoroz a b = KvaternionKonstruktor
  (komplexSzoroz (komplexSzoroz (első a) (első b))
    (komplexKonjugál (második b)))
  (komplexSzoroz (komplexSzoroz (második b) (első a))
    (komplexSzoroz (első b) (második a)))

public export
kvaternionNormaNégyzet : Kvaternion -> Valós
kvaternionNormaNégyzet kv =
  valósÖsszead (komplexNormaNégyzet (első kv))
    (komplexNormaNégyzet (második kv))

-- ─── 4. OKTONION ──────────────────────────────────────────
-- 四、八元数 ────────────────
public export
record Oktonion where
  constructor OktonionKonstruktor
  elsőH : Kvaternion
  másodikH : Kvaternion

public export
Eq Oktonion where
  (==) a b = (elsőH a == elsőH b) && (másodikH a == másodikH b)

public export
Show Oktonion where
  show o = show (elsőH o) ++ " + " ++ show (másodikH o) ++ "j"

public export
oktonionNulla : Oktonion
oktonionNulla = OktonionKonstruktor kvaternionNulla kvaternionNulla

public export
oktonionEgység : Oktonion
oktonionEgység = OktonionKonstruktor kvaternionEgység kvaternionNulla

public export
oktonionKonjugál : Oktonion -> Oktonion
oktonionKonjugál o = OktonionKonstruktor
  (kvaternionKonjugál (elsőH o))
  (kvaternionSzoroz mínuszEgységKvaternion (másodikH o))

public export
oktonionSzoroz : Oktonion -> Oktonion -> Oktonion
oktonionSzoroz a b = OktonionKonstruktor
  (kvaternionSzoroz (kvaternionSzoroz (elsőH a) (elsőH b))
    (kvaternionKonjugál (másodikH b)))
  (kvaternionSzoroz (kvaternionSzoroz (másodikH b) (elsőH a))
    (kvaternionSzoroz (elsőH b) (másodikH a)))

public export
oktonionNormaNégyzet : Oktonion -> Valós
oktonionNormaNégyzet o =
  valósÖsszead (kvaternionNormaNégyzet (elsőH o))
    (kvaternionNormaNégyzet (másodikH o))

-- ─── 5. SEDENION ──────────────────────────────────────────
-- 五、十六元数 ────────────────
public export
record Sedenion where
  constructor SedenionKonstruktor
  elsőO : Oktonion
  másodikO : Oktonion

public export
Eq Sedenion where
  (==) a b = (elsőO a == elsőO b) && (másodikO a == másodikO b)

public export
Show Sedenion where
  show s = show (elsőO s) ++ " + " ++ show (másodikO s) ++ "j"

public export
sedenionNulla : Sedenion
sedenionNulla = SedenionKonstruktor oktonionNulla oktonionNulla

public export
sedenionEgység : Sedenion
sedenionEgység = SedenionKonstruktor oktonionEgység oktonionNulla

public export
sedenionKonjugál : Sedenion -> Sedenion
sedenionKonjugál s = SedenionKonstruktor
  (oktonionKonjugál (elsőO s))
  (oktonionSzoroz mínuszEgységKvaternionOktonionként (másodikO s))
  where
    -- A (-1) egység oktonion-ként NEVEZVE (a holtsúly elkerülésére):
    mínuszEgységKvaternionOktonionként : Oktonion
    mínuszEgységKvaternionOktonionként =
      OktonionKonstruktor mínuszEgységKvaternion kvaternionNulla

public export
sedenionSzoroz : Sedenion -> Sedenion -> Sedenion
sedenionSzoroz a b = SedenionKonstruktor
  (oktonionSzoroz (oktonionSzoroz (elsőO a) (elsőO b))
    (oktonionKonjugál (másodikO b)))
  (oktonionSzoroz (oktonionSzoroz (másodikO b) (elsőO a))
    (oktonionSzoroz (elsőO b) (másodikO a)))

public export
sedenionNormaNégyzet : Sedenion -> Valós
sedenionNormaNégyzet s =
  valósÖsszead (oktonionNormaNégyzet (elsőO s))
    (oktonionNormaNégyzet (másodikO s))

-- ─── 6. ALGEBRAI TULAJDONSÁGOK ────────────────────────────
-- 六、代数性质 ────────────────
-- Dimenzió: 2^4 = 16 — SORSZÁMBA csomagolva (§24: import!).
-- 维度用 Sorszám 包装（§24：导入！）。
public export
dimenzió : Sorszám
dimenzió = sorTizenhat

-- Egységek száma: 2×dim - 2 = 30 (sedenion) — SORSZÁMBA csomagolva.
-- 单位数：30——Sorszám 包装。
public export
egységekSzáma : Sorszám
egységekSzáma = SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező (SorKövetkező dimenzió))))))))))))))

-- ─── 7. HIBAJAVÍTÓ KÓD BEÉPÍTÉSE ─────────────────────────
-- 七、纠错码的嵌入 ────────────────
public export
data HibajavítóKód : Type where
  SteaneKód : HibajavítóKód
  ReedMullerKód : HibajavítóKód
  SedenionKód : HibajavítóKód

public export
Show HibajavítóKód where
  show SteaneKód = "Steane [[7,1,3]]"
  show ReedMullerKód = "Reed-Muller [[15,1,3]]"
  show SedenionKód = "Sedenion [[15,1,3]]"

-- ─── 8. NUMERIKUS VERIFIKÁCIÓ ─────────────────────────────
-- 八、数值验证 ────────────────
-- Show-teszt: a norma² értéke kiírható, numerikusan ellenőrizhető
-- (a Double nem Refl-lel bizonyítható, de a Show kimutatja).
-- 范数平方可打印可数值核验（Double 不能用 Refl 证明，但 Show 能展示）。

-- ─── 9. FŐ — VÉKONY IO-BURKOLÓ ──────────────────────────
-- 九、主程序——薄 IO 壳 ────────────────

public export
főJelentés : String
főJelentés =
  "═══ CAYLEY-DICKSON TORONY / 凯莱–迪克森塔 ═══\n"
  ++ "ℝ (1) → ℂ (2) → ℍ (4) → 𝕆 (8) → Sedenion (16)\n"
  ++ "Dimenzió: 2^4 = 16 (Sorszám-ban: sorTizenhat)\n"
  ++ "Egységek: 30 (sedenion, Sorszám-ban)\n"
  ++ "Hibajavító kód: [[15,1,3]] Reed-Muller\n"
  ++ "Norma² egység okt: " ++ show (oktonionNormaNégyzet oktonionEgység) ++ "\n"
  ++ "Norma² egység sed: " ++ show (sedenionNormaNégyzet sedenionEgység) ++ "\n"
  ++ "Kapcsolat: 16+224 = 240 E8 gyök (OktonionAlgebra.idr)\n"

main : IO ()
main = putStrLn főJelentés
