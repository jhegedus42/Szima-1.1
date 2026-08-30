module Alap.AlphaKözös

-- ═══════════════════════════════════════════════════════════════
-- ALPHA-KÖZÖS (ékezetes nemzedék) — az Alpha-család KANONIKUS alaprétege
-- ALPHA-COMMON (accented generation) — the canonical base layer
-- Alpha-公共（带变音符世代）—— Alpha 模块族的规范基础层
-- ═══════════════════════════════════════════════════════════════
--
-- ÉKEZETES NEMZEDÉK (2026-08-22, §25 hullám 5/5): minden magyar
-- azonosító ékezetes (kódszóTér, kiterjesztettTér, törtrész,
-- lobásásBázis, pithagorásziHang...). §13: az Alap.AlphaKozos
-- megmarad; minden ÉKEZETES nemzedékbeli modul innentől:
--   import Alap.AlphaKözös
--
-- KÓD DUPLIKÁCIÓ TILOS (AGENTS §24 — prioritás, 2026-08-21):
--   | EZ a delta / sigmaG / lobásásBázis / ... EGYETLEN (ékezetes) otthona. |
--   | 这是 delta / sigmaG 等的唯一（带变音符）规范住所。                   |
--
--   A definíciók 3-4 modulban éltek duplikátumként (l. KodDuplikacioAudit):
--     delta, lobásásBázis, lobásásExponens, lobásásExponensEgész,
--     tisztaTér, logPithagorászi, pithagorásziHang:
--         AlphaSteane.idr, AlphaSteaneE8.idr, AlphaSteaneVegso.idr
--     sigmaG (1.5e-15, szó szerint azonos):
--         AlphaSteane.idr, AlphaE8Szigor.idr, AlphaGCheck.idr,
--         AlphaLobaszas.idr
--
-- A RECEPTEK SZÓRÓL SZÓRA megőrizve az AlphaSteane.idr-ből
-- (§16/§N5 — a kommentek és a levezetés láncolata információ,
-- nem dobható el):
--   n=7 fizikai qubit, k=1 logikai, d=3 távolság ([[7,1,3]] Steane),
--   s = n−k = 6 stabilizátor-generátor,
--   kódszóTér = 2⁷ = 128, kiterjesztettTér = 2⁸ = 256,
--   alphaBare = 128 + 2³ + 1 + 9/250 = 137.036,
--   delta = (121/128)^(249+ln(9/8)) ≈ 8.23×10⁻⁷,
--   sigmaG = 1.5×10⁻¹⁵ (a G mérési bizonytalansága, CODATA arány).
-- ═══════════════════════════════════════════════════════════════

%default covering

-- ─── A Steane [[7,1,3]] paraméterei ───────────────────────

public export
n : Double
n = 7.0   -- fizikai qubitek / 物理量子比特 / physische Qubits

public export
k : Double
k = 1.0   -- logikai qubitek / 逻辑量子比特 / logische Qubits

public export
d : Double
d = 3.0   -- távolság (1 hibát javít) / 距离（纠 1 位错）

-- ─── Levezetett mennyiségek ────────────────────────────────

public export
s : Double
s = n - k   -- 6 = stabilizátor-generátorok száma

public export
nPlusK : Double
nPlusK = n - k   -- s ál-név (a v1-gyel azonos alak)

public export
kódszóTér : Double
kódszóTér = pow 2.0 n   -- N = 2^7 = 128

public export
kiterjesztettTér : Double
kiterjesztettTér = pow 2.0 (n + 1.0)   -- M = 2^8 = 256

-- ─── A bare csatolás ───────────────────────────────────────

public export
stabilizátorPluszTávolság : Double
stabilizátorPluszTávolság = s + d   -- 9 = 6 + 3

public export
törtrészSzámláló : Double
törtrészSzámláló = stabilizátorPluszTávolság   -- 9

public export
törtrészNevező : Double
törtrészNevező = kiterjesztettTér - s   -- 250 = 256 - 6

public export
törtrész : Double
törtrész = törtrészSzámláló / törtrészNevező   -- 9/250

public export
egyesRész : Double
egyesRész = kódszóTér + pow 2.0 d + 1.0   -- 128 + 8 + 1 = 137

public export
alphaBare : Double
alphaBare = egyesRész + törtrész   -- 137 + 9/250 = 137.036

-- ─── A lobásás ─────────────────────────────────────────────

public export
tisztaTér : Double
tisztaTér = kódszóTér - n   -- 121 = 128 - 7

public export
lobásásBázis : Double
lobásásBázis = tisztaTér / kódszóTér   -- 121/128

public export
lobásásExponensEgész : Double
lobásásExponensEgész = kiterjesztettTér - n   -- 249 = 256 - 7

public export
pithagorásziHang : Double
pithagorásziHang = stabilizátorPluszTávolság / pow 2.0 d   -- 9/8

public export
logPithagorászi : Double
logPithagorászi = log pithagorásziHang   -- ln(9/8)

public export
lobásásExponens : Double
lobásásExponens = lobásásExponensEgész + logPithagorászi   -- 249 + ln(9/8)

public export
delta : Double
delta = pow lobásásBázis lobásásExponens   -- (121/128)^(249+ln(9/8)) ≈ 8.23e-7

-- ─── A G bizonytalanság ───────────────────────────────────

public export
sigmaG : Double
sigmaG = 1.5e-15   -- a G relatív mérési bizonytalansága (CODATA arány)

-- ─── Nagybetűs aliasok (KisBetűs-csapda ellen — a bizonyításokhoz) ──

public export
DeltaKonst : Double
DeltaKonst = delta

public export
SigmaGKonst : Double
SigmaGKonst = sigmaG

public export
AlphaBareKonst : Double
AlphaBareKonst = alphaBare

-- ─── A futtatható ellenőrzés (GAUGE-elv: értelmezhető kimenet) ──

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  ALPHA-KÖZÖS (ékezetes nemzedék) — a kanonikus alapréteg"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ("  n=" ++ show n ++ "  k=" ++ show k ++ "  d=" ++ show d ++ "  s=" ++ show s)
  putStrLn ("  kódszóTér 2⁷ = " ++ show kódszóTér ++ "   (várható: 128.0)")
  putStrLn ("  kiterjesztettTér 2⁸ = " ++ show kiterjesztettTér ++ "   (várható: 256.0)")
  putStrLn ("  alphaBare = " ++ show alphaBare ++ "   (várható: 137.036)")
  putStrLn ("  delta = " ++ show delta ++ "   (várható: ≈8.23e-7)")
  putStrLn ("  sigmaG = " ++ show sigmaG ++ "   (várható: 1.5e-15)")
  putStrLn "  — a definíciók szó szerint az AlphaSteane.idr-beliek (§16);"
  putStrLn "    az ékezetes nemzedék moduljai innentől IMPORTÁLJÁK (§24)."
  putStrLn "Kész / 完成 / Fertig / גמר"
