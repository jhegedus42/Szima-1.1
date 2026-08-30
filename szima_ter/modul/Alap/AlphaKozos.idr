module Alap.AlphaKozos

-- ═══════════════════════════════════════════════════════════════
-- ALPHA-KÖZÖS — az Alpha-család KANONIKUS alaprétege
-- ALPHA-COMMON — the canonical base layer of the Alpha family
-- Alpha-公共 —— Alpha 模块族的规范基础层
-- ALPHA-GEMEINSAM — die kanonische Basisschicht der Alpha-Familie
-- Alpha-משותף — השכבה הקנונית של משפחת Alpha
-- ═══════════════════════════════════════════════════════════════
--
-- KÓD DUPLIKÁCIÓ TILOS (AGENTS §24 — prioritás, 2026-08-21):
--   | EZ a delta / sigmaG / lobaszasBase / ... EGYETLEN otthona. |
--   | 这是 delta / sigmaG 等的唯一规范住所。                      |
--   | DAS ist die EINE Heimat von delta / sigmaG / ...          |
--
--   Eddig a definíciók 3-4 modulban éltek duplikátumként:
--     delta, lobaszasBase, lobaszasExponens, lobaszasExponensEgesz,
--     tisztaTer, logPithagoraszi, pithagorasziHang:
--         AlphaSteane.idr, AlphaSteaneE8.idr, AlphaSteaneVegso.idr
--     sigmaG (1.5e-15, szó szerint azonos):
--         AlphaSteane.idr, AlphaE8Szigor.idr, AlphaGCheck.idr,
--         AlphaLobaszas.idr
--   (AlphaSteaneDashboard.idr "delta"-ja PYTHON-stringben él —
--   az NEM Idris-duplikáció; az audit ezt rögzíti.)
--
--   A v1 modulok §13 szerint ÉRINTETLENÜL maradnak (soha nem írunk
--   felül semmit); minden ÚJ és _v2 modul INNEN importál:
--     import Alap.AlphaKozos
--
-- A RECEPTEK SZÓRÓL SZÓRA megőrizve az AlphaSteane.idr-ből
-- (§16/§N5 — a kommentek és a levezetés láncolata információ,
-- nem dobható el):
--   n=7 fizikai qubit, k=1 logikai, d=3 távolság ([[7,1,3]] Steane),
--   s = n−k = 6 stabilizátor-generátor,
--   kodSzoTer = 2⁷ = 128, kiterjesztettTer = 2⁸ = 256,
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
nPlusK = n - k   -- s alias

public export
kodSzoTer : Double
kodSzoTer = pow 2.0 n   -- N = 2^7 = 128

public export
kiterjesztettTer : Double
kiterjesztettTer = pow 2.0 (n + 1.0)   -- M = 2^8 = 256

-- ─── A bare csatolás ───────────────────────────────────────

public export
stabilizatorPluszTavolsag : Double
stabilizatorPluszTavolsag = s + d   -- 9 = 6 + 3

public export
tortreszSzamlalo : Double
tortreszSzamlalo = stabilizatorPluszTavolsag   -- 9

public export
tortreszNevezo : Double
tortreszNevezo = kiterjesztettTer - s   -- 250 = 256 - 6

public export
tortresz : Double
tortresz = tortreszSzamlalo / tortreszNevezo   -- 9/250

public export
egyesResz : Double
egyesResz = kodSzoTer + pow 2.0 d + 1.0   -- 128 + 8 + 1 = 137

public export
alphaBare : Double
alphaBare = egyesResz + tortresz   -- 137 + 9/250 = 137.036

-- ─── A lobásás ─────────────────────────────────────────────

public export
tisztaTer : Double
tisztaTer = kodSzoTer - n   -- 121 = 128 - 7

public export
lobaszasBase : Double
lobaszasBase = tisztaTer / kodSzoTer   -- 121/128

public export
lobaszasExponensEgesz : Double
lobaszasExponensEgesz = kiterjesztettTer - n   -- 249 = 256 - 7

public export
pithagorasziHang : Double
pithagorasziHang = stabilizatorPluszTavolsag / pow 2.0 d   -- 9/8

public export
logPithagoraszi : Double
logPithagoraszi = log pithagorasziHang   -- ln(9/8)

public export
lobaszasExponens : Double
lobaszasExponens = lobaszasExponensEgesz + logPithagoraszi   -- 249 + ln(9/8)

public export
delta : Double
delta = pow lobaszasBase lobaszasExponens   -- (121/128)^(249+ln(9/8)) ≈ 8.23e-7

-- ─── A G bizonytalanság ───────────────────────────────────

public export
sigmaG : Double
sigmaG = 1.5e-15   -- a G relatív mérési bizonytalansága (CODATA arány)

-- ─── Nagybetűs aliasok (KisBetusCsapda — a bizonyításokhoz) ──

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
  putStrLn "  ALPHA-KÖZÖS — a kanonikus alapréteg · Alpha 公共基础层"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ("  n=" ++ show n ++ "  k=" ++ show k ++ "  d=" ++ show d ++ "  s=" ++ show s)
  putStrLn ("  kodSzoTer 2⁷ = " ++ show kodSzoTer ++ "   (várható: 128.0)")
  putStrLn ("  kiterjesztettTer 2⁸ = " ++ show kiterjesztettTer ++ "   (várható: 256.0)")
  putStrLn ("  alphaBare = " ++ show alphaBare ++ "   (várható: 137.036)")
  putStrLn ("  delta = " ++ show delta ++ "   (várható: ≈8.23e-7)")
  putStrLn ("  sigmaG = " ++ show sigmaG ++ "   (várható: 1.5e-15)")
  putStrLn "  — a definíciók szó szerint az AlphaSteane.idrbeliek (§16);"
  putStrLn "    az új és _v2 modulok innentől IMPORTÁLJÁK (§24)."
  putStrLn "Kész / 完成 / Fertig / גמר"
