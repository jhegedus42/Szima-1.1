module E8ProjekcióVizsga_v1

-- ═══════════════════════════════════════════════════════════════
-- E8 PETRIE-PROJEKCIÓ VIZSGA — melyik szöglista adja a kanonikus
-- „8 koncentrikus 30-szög" szerkezetet? (konyv_v2.tex ábra-alapja)
-- E8 PETRIE PROJECTION TRIAL — which angle list gives the canonical
-- "8 concentric 30-gons" structure?
-- E8 佩特里投影试验——哪个角度表给出标准“8个同心三十边形”结构？
-- E8-Petrie-Projektionsprüfung — welche Winkelliste liefert die
-- kanonische „8 konzentrische 30-Ecke"-Struktur?
-- ═══════════════════════════════════════════════════════════════
--
-- A MÓDSZER (§18 két út, GAUGE):
--   | A GYÖKLISTÁT IMPORTÁLJUK (E8Gyokok_v2 — §24, NEM írjuk újra) |
--   | 每一个数字来自运行；导入根列表，不重写！                        |
--   A projekció: P(v) = Σ_k v_k·(cos θ_k, sin θ_k) — lineáris leképezés,
--   a θ_k-jelöltek a Coxeter-exponensekből ({1,7,11,13,17,19,23,29},
--   h=30) és irodalmi variánsokból jönnek.
--   ELFOGADÁSI TESZT (diszkrét, pontos):
--     (a) a 240 vetített pont halmaza 12°-forgesésre INVARIÁNS;
--     (b) a sugár²-kerekített értékek szerint pontosan 8 gyűrű,
--         mindegyiken 30 ponttal (= 8 koncentrikus szabályos 30-szög).
--   A nyertes szöglista megy a könyv TikZ-ábrájába, forrásmegjelöléssel.
-- ═══════════════════════════════════════════════════════════════

%default covering

-- ─── 1. ALAPMŰVELETEK / BASIC OPS / 基本运算 ────────────────

-- saját Pi — semmire nem támaszkodunk a Prelude-ben
-- 自带 π 常量 | eigene π-Konstante
teljesPi : Double
teljesPi = 3.141592653589793

||| Szög = π·n/30 (a Coxeter-szám h = 30 harmincada).
||| 角 = π·n/30（科克斯特数 h = 30）。
szögHarmincad : Integer -> Double
szögHarmincad n = teljesPi * cast n / 30.0

||| A 12°-os forgatás szöge = 2π/30 = π/15 (a 30-szög lépése).
||| 12°旋转角 = 2π/30 = π/15。
tizenketFok : Double
tizenketFok = teljesPi / 15.0

||| Pont forgatása az origó körül.
||| 点绕原点旋转。
forgat : Double -> (Double, Double) -> (Double, Double)
forgat szög (x, y) = (x * cos szög - y * sin szög, x * sin szög + y * cos szög)

||| Két pont távolságának négyzete.
||| 两点距离的平方。
távolságNegyzet : (Double, Double) -> (Double, Double) -> Double
távolságNegyzet (ax, ay) (bx, by) =
  (ax - bx) * (ax - bx) + (ay - by) * (ay - by)

||| Legközelebbi halmaz-elem távolságának négyzete.
||| 到集合中最近点的距离平方。
legközelebbi : (Double, Double) -> List (Double, Double) -> Double
legközelebbi _ [] = 1.0e300
legközelebbi p (q :: qs) = min (távolságNegyzet p q) (legközelebbi p qs)

-- ─── 2. A PROJEKCIÓ / THE PROJECTION / 投影 ─────────────────

||| P(v) = Σ_k v_k·(cos θ_k, sin θ_k) — az importált gyöklistán.
||| 投影：P(v) = Σ_k v_k·(cos θ_k, sin θ_k)，用于导入的根列表。
projektál : List Double -> E8Gyok -> (Double, Double)
projektál szögek gy = segít (0.0, 0.0) szögek (gyokLista gy)
  where
    segít : (Double, Double) -> List Double -> List Integer -> (Double, Double)
    segít acc [] _ = acc
    segít acc _ [] = acc
    segít (ax, ay) (s :: ss) (k :: ks) =
      segít (ax + cast k * cos s, ay + cast k * sin s) ss ks

-- ─── 3. A KÉT TESZT / THE TWO TESTS / 两项测试 ──────────────

||| (a) 12°-forgesési invariancia: minden pontra a forgatott kép
|||     a halmaz valamelyik pontjával egyezik (max. eltérés, négyzet).
||| （a）12°旋转不变性：每个点旋转后与集合中某点重合的最大偏差。
szimmetriaLegrosszabb : List (Double, Double) -> Double
szimmetriaLegrosszabb [] = 0.0
szimmetriaLegrosszabb (p :: ps) =
  max (legközelebbi (forgat tizenketFok p) (p :: ps)) (szimmetriaLegrosszabb ps)

||| (b) Gyűrű-statisztika: sugár² 4 tizedesjegyre kerekítve,
|||     darabszámmal. A kanonikus alak: 8 gyűrű · 30 pont.
||| （b）环统计：半径²四舍五入到4位小数并计数。标准形：8环·30点。
gyűrűStatisztika : List (Double, Double) -> List (Integer, Nat)
gyűrűStatisztika = számol . map (kerekNégy . sugárNegyzet)
  where
    sugárNegyzet : (Double, Double) -> Double
    sugárNegyzet (x, y) = x * x + y * y
    kerekNégy : Double -> Integer
    kerekNégy x = floor (x * 10000.0 + 0.5)
    számol : List Integer -> List (Integer, Nat)
    számol [] = []
    számol (v :: vs) = beszúr v (számol vs)
    beszúr : Integer -> List (Integer, Nat) -> List (Integer, Nat)
    beszúr v [] = [(v, 1)]
    beszúr v ((w, n) :: maradék) =
      if v == w then (w, S n) :: maradék else (w, n) :: beszúr v maradék

||| Gyűrűk rendezve sugár szerint (olvasható kimenetért).
||| 半径排序后的环（便于阅读输出）。
gyűrűRendezett : List (Integer, Nat) -> List (Integer, Nat)
gyűrűRendezett [] = []
gyűrűRendezett (x :: xs) =
  gyűrűRendezett (filter ((/= fst x) . fst) xs) ++ [x]

-- ─── 4. A JELÖLTEK / THE CANDIDATES / 候选角度表 ────────────

||| Jelölt szöglisták (radiánban). A jelölések a Coxeter-exponenseken
||| és irodalmi variánsokon alapulnak (Heckman jegyzetek; Dechant 2016;
||| Madore E8-oldala).
||| 候选角度表（弧度），基于考克斯特指数及文献变体。
jelöltek : List (String, List Double)
jelöltek =
  [ ("A  expo: 1,7,11,13,17,19,23,29 · pi/30",
      map szögHarmincad [1, 7, 11, 13, 17, 19, 23, 29])
  , ("B  1,11,19,29,31,41,49,59 · pi/30",
      map szögHarmincad [1, 11, 19, 29, 31, 41, 49, 59])
  , ("H  2*expo: 2,14,22,26,34,38,46,58 · pi/30",
      map (\n => 2.0 * szögHarmincad n) [1, 7, 11, 13, 17, 19, 23, 29])
  , ("D  Madore-alap: 16-ad gyökök · pi/8",
      map (\k => teljesPi * cast k / 8.0) [1, 2, 3, 4, 5, 6, 7, 8])
  ]

-- ─── 5. A VIZSGA FUTTATÁSA / RUN THE TRIAL / 运行试验 ───────

vizsgál : (String, List Double) -> IO ()
vizsgál (név, szögek) = do
  let pontok = map (projektál szögek) e8Gyokok
  let legrosszabb = szimmetriaLegrosszabb pontok
  putStrLn ""
  putStrLn ("jelölt: " ++ név)
  putStrLn ("  12°-forgesés legnagyobb eltérése: " ++ show legrosszabb)
  putStrLn ("  elfogadva (eltérés < 1e-6)?        " ++ show (legrosszabb < 1.0e-6))
  putStrLn ("  gyűrűk (sugár² · darab):           " ++
    show (gyűrűRendezett (gyűrűStatisztika pontok)))

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 PETRIE-PROJEKCIÓ VIZSGA · 佩特里投影试验"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ("  gyökök száma (importálva, E8Gyokok_v2): " ++ show (List.length e8Gyokok))
  traverse_ vizsgál jelöltek
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
