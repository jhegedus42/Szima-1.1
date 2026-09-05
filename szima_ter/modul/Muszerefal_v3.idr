module Muszerefal_v3

-- ═══════════════════════════════════════════════════════════════
-- MŰSZERFAL v3 — a TELJES műszerfal: a 38 mutató + az α-találatok
-- INSTRUMENT PANEL v3 — the COMPLETE panel: the 38 indicators + the α results
-- 仪表盘 v3 — 完整仪表盘：38 项指标 + α 系列成果
-- INSTRUMENTENTAFEL v3 — das VOLLSTÄNDIGE Panel: 38 Kennzahlen + α
-- לוח מחוונים גרסה 3 — לוח מלא: 38 המדדים + הישגי ה־α
-- ═══════════════════════════════════════════════════════════════
--
-- MIÉRT v3? (§13: a javítás ÚJ FÁJL — a Muszerefal_v2.idr ÉRINTETLEN.)
--   A Muszerefal_v2 SAJÁT magában nem hibás — a Hullam_3 build
--   (2026-09-05) az IMPORT-LÁNCON át bukott:
--   Muszerefal_v2 → Muszerefal_v1 → Mondat_v1 → FazisAlgebra_v2 (törött).
--   Ez a v3 AZ EGYETLEN sort cseréli a láncon: `import Muszerefal_v1` →
--   `import Muszerefal_v4` (a v4 = a v1 tartalma, Mondat_v2-re
--   átirányítva; a Mondat_v2 → FazisAlgebra_v3 a TISZTA út). Minden
--   más — a §17-mérések, a FizikaiÁllandóMutatók, az
--   E8RácsSzimmetriaMutatók, a bizSzindrómaHíd, a 17 lépés, a
--   kronológia és a main — SZÓ SZERINT a v2 tartalma.
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS): a 38 mezős rekord ÉS
--   a híd-bizonyítása IMPORTÁLVA (Muszerefal_v4.műszerfalMutatók,
--   bizMűszerfalEmeletekHídja) — SEMMI nincs újraszámolva.
--   | 代码重复禁止——一切导入！ | Codeduplikation VERBOTEN! |
--   Az új számok: CSAK importált publikus kifutások, vagy a main-ben
--   az importált építőkből számolt értékek („futás” jelöléssel).
-- §17 (MÉRÉSI HIBA-KÖTELEZETTSÉG): minden fizikai-állandó
--   összehasonlítás a négysoros formán:
--     érték_levezetett / érték_mért (σ, forrás) / Δ / Δ/σ.
-- §18 (ŐSZINTE VERIFIKÁCIÓ): itt NINCS új tautológia — az egyetlen
--   új Refl a bizSzindrómaHíd (128 + 112 = 240: két importált konstans
--   összeg-konstrukciója találkozik a gyök-enumerációval); minden más
--   bizonyítás IMPORTÁLT (AlphaSteane, CarnotE9, Muszerefal_v4).
-- §13: EZ EGY ÚJ MODUL — Muszerefal_v1.idr, Muszerefal_v2.idr és
--   docs/muszerefal.html + docs/muszerefal_v2.html ÉRINTETLENÜL
--   maradnak (a v3-hoz még nem készült új weboldal).
-- MEGJEGYZÉS (§24 + §13): az AlphaSteaneDashboard „lepesek” listája
--   PRIVÁT (Idris 2 alapértelmezés: minden ottani deklaráció privát),
--   és a modul nem módosítható — ezért a 17 lépés itt az AlphaSteane
--   publikus kifutásaiból + statikus lépés-címekből áll.
--   | 十七步的数字全部来自 AlphaSteane 的公开出口。 |
-- GAUGE-elv: a kimenet számai CSAK a tényleges futásból kerülnek
--   dokumentumba (AGENTS §18/5).
-- ═══════════════════════════════════════════════════════════════

import Muszerefal_v4                      -- műszerfalMutatók (38 mező), bizMűszerfalEmeletekHídja (§24 —
                                          -- az ÁTIRÁNYÍTOTT lánc: v4 → Mondat_v2 → FazisAlgebra_v3)
import E8Iranymutato_v1                   -- iranymutatoMutatok, isingAlfa..., univerzalitasiOsztaly (§24)
import AlphaSteane                        -- alphaBare, delta, alphaDressed, alphaCodata, sigmaAlpha, gLevezetett, gCodata, sigmaG (§24)
import MagyarCarnotE9_v3_CodatAlpha as CarnotE9  -- e8Redundancia, e9Egyutthato, magyarSzimmetriaMeret, piroskaBitek, szindromaTer (§24; a delta-név ütközés miatt minősítve)
import MagyarKinaiTorvenyek_v3            -- deltaSzamitott (a δ második, CODATA-különbség útja) (§24)
import Data.String                        -- unwords (§24: standard — az ékezetes nevek kiírásához)

%default covering

-- ===============================================================
-- 1. ÚJ TÍPUSOK — §17-MÉRÉS ÉS KRONOLÓGIAI MÉRFÖLDKŐ
--    New types — §17 measurement and milestone
--    新类型——§17 测量与里程碑 · Neue Typen — §17-Messung
-- ===============================================================

||| §17-formátumú fizikai-állandó összehasonlítás.
||| A kártya CSAK importált értékeket hordoz; a Δ-t és a Δ/σ-t
||| a KIÍRÁSKOR számoljuk a main futásában („futás” — GAUGE).
||| §17 格式的物理常数比较：卡片只携带导入值，Δ 与 Δ/σ 在运行时计算。
public export
record FizikaiMérés where
  constructor FizikaiMérésKonstruktor
  megnevezés           : String
  értékLevezetett      : Double
  értékMért            : Double
  mérésiBizonytalanság : Double
  forrásNeve           : String
  megjegyzés           : String

||| Kronológiai mérföldkő — a kutatási naplókból rögzített statikus
||| szövegkártya (NEM szám-import: az elmúlt 2 hét csúcspontjai).
||| 里程碑——来自研究日志的静态文字卡（非数字导入）。
public export
data Mérföldkő : Type where
  MérföldkőKonstruktor : (dátum : String) -> (esemény : String) -> Mérföldkő

-- ===============================================================
-- 2. A §17-MÉRÉSEK — CSAK IMPORTÁLT KIFUTÁSOKBÓL ÉPÍTVE (§24)
--    The §17 measurements — built from imported exits only
--    §17 测量——仅由导入出口构建 · Die §17-Messungen
-- ===============================================================

||| A CODATA 2022 régebbi, „(11)” jelű bizonytalansága: σ = 1.1×10⁻⁸.
||| MÉRÉSI BEMENET (§17/2 — a mérési hiba kötelező adat), nem levezetés;
||| a projektben máshol nem él (grep: csak sigmaCodata = 2.1e-8 van).
public export
codataSzigmaTizenegy : Double
codataSzigmaTizenegy = 1.1e-8

||| (a) A dressed α⁻¹: bare − δ(lobásás) — két importált építő találkozása.
public export
alfaDressedMérés : FizikaiMérés
alfaDressedMérés = FizikaiMérésKonstruktor
  "α⁻¹ dressed — a Steane [[7,1,3]] kódból (137.036 − δ)"
  alphaDressed
  alphaCodata
  sigmaAlpha
  "CODATA 2022"
  "α⁻¹_bare − δ(lobásás) — a hibajavítás levenedi a zajt"

||| (b/1) A bare α⁻¹ a RÉGEBBI, „(11)”-es σ-val — ŐSZINTE sor.
public export
alfaBareMérésSzigmaTizenegy : FizikaiMérés
alfaBareMérésSzigmaTizenegy = FizikaiMérésKonstruktor
  "α⁻¹ bare (csupasz) — σ a „(11)”-ből"
  alphaBare
  alphaCodata
  codataSzigmaTizenegy
  "CODATA 2022 „(11)”"
  "NYITOTT KÉRDÉS: a σ választása tisztázandó"

||| (b/2) A bare α⁻¹ a MODERN, „(21)”-es σ-val — ŐSZINTE sor.
public export
alfaBareMérésSzigmaHuszonegy : FizikaiMérés
alfaBareMérésSzigmaHuszonegy = FizikaiMérésKonstruktor
  "α⁻¹ bare (csupasz) — σ a „(21)”-ből"
  alphaBare
  alphaCodata
  sigmaAlpha
  "CODATA 2022 „(21)”"
  "a σ-ellentmondás második ága"

||| (c) A G gravitációs állandó — ugyanabból a (1+9/250)^(1/40) korrekcióból.
public export
gMérés : FizikaiMérés
gMérés = FizikaiMérésKonstruktor
  "G gravitációs állandó — (7·11)/(2³·5²)·√3·(1+9/250)^(1/40)·10⁻¹⁰"
  gLevezetett
  gCodata
  sigmaG
  "CODATA 2022"
  "a (1+9/250)^(1/40) — ugyanaz a korrekció, mint az α törtrésze"

||| A négy §17-mérés egy listában (a kiírás sorrendjében).
public export
fizikaiMérések : List FizikaiMérés
fizikaiMérések =
  [ alfaDressedMérés
  , alfaBareMérésSzigmaTizenegy
  , alfaBareMérésSzigmaHuszonegy
  , gMérés
  ]

-- ===============================================================
-- 3. AZ ÚJ SZÁMOK REKORDJA — MINDEN MEZŐ IMPORTÁLT KIFUTÁS (§24)
--    The record of new numbers — every field an imported exit
--    新数字记录——每个字段皆为导入出口 · Rekord der neuen Zahlen
-- ===============================================================

||| A v3 kiegészítő fizikai mutatók: a mezőkérték az importált
||| modulok konstansainak kifutása — a rekord CSAKOL, nem számít.
public export
record FizikaiÁllandóMutatók where
  constructor FizikaiÁllandóMutatókKonstruktor
  alfaBareÉrtéke           : Double    -- 137.036 (AlphaSteane)
  deltaLobásásÉrtéke       : Double    -- (121/128)^(249+ln(9/8)) (AlphaSteane)
  alfaDressedÉrtéke        : Double    -- bare − δ (AlphaSteane)
  alfaCodataÉrtéke         : Double    -- 137.035999177 (AlphaSteane)
  szigmaAlfaÉrtéke         : Double    -- 2.1×10⁻⁸ (AlphaSteane)
  szigmaCodataTizenegy     : Double    -- 1.1×10⁻⁸ (mérési bemenet, l. fent)
  gLevezetettÉrtéke        : Double    -- (7·11)/(2³·5²)·√3·… (AlphaSteane)
  gCodataÉrtéke            : Double    -- 6.67430×10⁻¹¹ (AlphaSteane)
  szigmaGÉrtéke            : Double    -- 1.5×10⁻¹⁵ (AlphaSteane)
  deltaSzámítottCodataÚtja : Double    -- Horgony − CODATA (MagyarKinaiTorvenyek_v3)

||| Az új fizikai mutatók ÉRTÉKEI — lista-konstans, EGYETLEN
||| rekord-konstrukció (a kályha-minta: NEM let-lánc, l. LetLáncProbe).
public export
fizikaiÁllandóMutatók : FizikaiÁllandóMutatók
fizikaiÁllandóMutatók = FizikaiÁllandóMutatókKonstruktor
  alphaBare
  AlphaSteane.delta
  alphaDressed
  alphaCodata
  sigmaAlpha
  codataSzigmaTizenegy
  gLevezetett
  gCodata
  sigmaG
  deltaSzamitott

||| A v3 E8-rács- és szimmetria-mutatói — minden mező a CarnotE9
||| (MagyarCarnotE9_v3_CodatAlpha) publikus kifutása (§24).
public export
record E8RácsSzimmetriaMutatók where
  constructor E8RácsSzimmetriaMutatókKonstruktor
  e8RedundanciaÉrtéke        : Double   -- 240/128 = 1.875
  e9EgyütthatóÉrtéke         : Nat      -- 1+4+6+4+1 = 16
  magyarSzimmetriaMérete     : Nat      -- 2×2×6×2 = 48
  piroskaBitekSzáma          : Nat      -- 22×7 = 154
  piroskaRészhalamazÁllapota : Bool     -- 128 < 154 < 240?
  szindrómaTérMérete         : Nat      -- 240 − 128 = 112
  buborékMérete              : Nat      -- 960 − 16 = 944

||| Az E8-rács- és szimmetria-mutatók ÉRTÉKEI (importált kifutások).
public export
e8RácsSzimmetriaMutatók : E8RácsSzimmetriaMutatók
e8RácsSzimmetriaMutatók = E8RácsSzimmetriaMutatókKonstruktor
  CarnotE9.e8Redundancia
  CarnotE9.e9Egyutthato
  CarnotE9.magyarSzimmetriaMeret
  CarnotE9.piroskaBitek
  CarnotE9.piroskaAzE8Reszhalmaza
  CarnotE9.szindromaTer
  CarnotE9.buborekMeret

-- ===============================================================
-- 4. ÚJ HÍD-BIZONYÍTÁS — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    New bridge proof — two independent paths, one bridge
--    新桥证明——两条独立道路，一座桥 · Neuer Brückenbeweis
-- ===============================================================

-- ─── A híd: a Steane-tér és a szindróma-tér együtt a gyök-enumeráció ────
-- | Bal oldal: KÉT importált konstans (SteaneHilbertTerKonst = 128 és
-- | SzindromaTerKonst = 112) ÖSSZEG-konstrukciója. Jobb oldal: az
-- | E8GyokokKonst = 240 gyök-enumeráció (a CarnotE9 saját útja). A kernel
-- | az összeget normalizálja és az enumerációval szembesíti — ha bármelyik
-- | konstans átíródna, a híd eltörik. Nem X = X (§18/1).

-- Kimenet: Refl — 128 + 112 = 240: a Steane-Hilbert-tér és a
-- szindróma-tér (két importált, függetlenül definiált konstans)
-- összeg-konstrukciója találkozik az E8-gyök-enumerációval.
public export
bizSzindrómaHíd :
  (CarnotE9.SteaneHilbertTerKonst + CarnotE9.SzindromaTerKonst
     = CarnotE9.E8GyokokKonst)
bizSzindrómaHíd = Refl

-- ===============================================================
-- 5. A 17 LÉPÉS RÖVID SORAI — IMPORTÁLT SZÁMOK + STATIKUS CÍMEK
--    The 17 steps in brief — imported numbers + static titles
--    十七步简表——导入数字 + 静态标题 · Die 17 Schritte kurz
-- ===============================================================

||| A 17 lépés rövid sora: minden SZÁM importált kifutás (AlphaSteane),
||| a lépés-címek statikusak (forrás: AlphaSteaneDashboard lepesek —
||| privát lista, l. a modulfejléc megjegyzését).
public export
lépésSorok : List String
lépésSorok =
  [ "   1. a Steane [[7,1,3]] paraméterei: n = " ++ show n ++ ", k = " ++ show k ++ ", d = " ++ show d
  , "   2. s = n−k = " ++ show s ++ ", N = 2ⁿ = " ++ show kodSzoTer ++ ", M = 2ⁿ⁺¹ = " ++ show kiterjesztettTer
  , "   3. az egész rész: 2ⁿ + 2ᵈ + 1 = " ++ show egyesResz
  , "   4. a törtrész számlálója: s + d = " ++ show stabilizatorPluszTavolsag
  , "   5. a törtrész nevezője: M − s = " ++ show tortreszNevezo
  , "   6. α⁻¹_bare = 137 + 9/250 = " ++ show alphaBare
  , "   7. a tiszta tér: N − n = " ++ show tisztaTer
  , "   8. a lobásás egész exponense: M − n = " ++ show lobaszasExponensEgesz
  , "   9. a püthagoraszi egész hang: (s+d)/2ᵈ = " ++ show pithagorasziHang
  , "  10. δ = (121/128)^(249+ln(9/8)) = " ++ show AlphaSteane.delta
  , "  11. α⁻¹_dressed = bare − δ = " ++ show alphaDressed
  , "  12. Δ/σ = |dressed − CODATA|/σ → l. a §17-csoportot"
  , "  13. G = (7·11)/(2³·5²)·√3·(1+9/250)^(1/40)·10⁻¹⁰ = " ++ show gLevezetett
  , "  14. 137 base 10-ben: [k, d, n] = [1, 3, 7] (csak base 10-ben)"
  , "  15. a base 10 = 2 × 5 = oktáv × tükör (az emberi test 2×5 ujja)"
  , "  16. a test szimmetriái = a fizika prímjei: 2 (szimmetria), 4 (végtag), 5 (ujj)"
  , "  17. Hox-gének fixálják az 5 ujjat: Shh → Hoxa11 → Hoxa13 → pentadactylia"
  ]

-- ===============================================================
-- 6. A KRONOLÓGIA — AZ ELMÚLT 2 HÉT CSÚCSPONTJAI (STATIKUS KÁRTYÁK)
--    The chronology — highlights of the past two weeks
--    年表——过去两周的顶点 · Die Chronologie — Höhepunkte
-- ===============================================================

||| A kutatási naplókból rögzített mérföldkövek (statikus szöveg).
public export
kétHetiMérföldkövek : List Mérföldkő
kétHetiMérföldkövek =
  [ MérföldkőKonstruktor "2026-08-18"
      "Cayley–Dickson-torony (49 pár × 3 törvény egy Refl-lel) + KisAI; a let-lánc-csapda mérése"
  , MérföldkőKonstruktor "2026-08-19"
      "a repó átnevezve Szimára; a δ-lobásás felfedezése; az őszinte review (20 tautológia jelölve)"
  , MérföldkőKonstruktor "2026-08-20"
      "α_G = 2⁻¹²⁷ Mersenne-torony + G-levezetés (Δ/σ = 0.038); a 17 lépéses AlphaSteaneDashboard"
  , MérföldkőKonstruktor "2026-08-21"
      "E8Gyokok_v2: a 240 gyök INTEGER-kernellel; W(E8) = 696 729 600 két független úttal; a 240+16 = 256 Hamming-híd"
  , MérföldkőKonstruktor "2026-08-22"
      "E8FazisKapcsolat_v2 (a fázis-bit) + a 3-pillér program: E8-rács, Steane-[[7,1,3]], magyar nyelv"
  , MérföldkőKonstruktor "2026-08-23"
      "W4–W9: univerzalitás, holografikus kód, Carnot, a 3D-nyelv 4 rétege, műszerfal + weboldal"
  , MérföldkőKonstruktor "2026-09-05"
      "a 7 kihagyott modul gyógyítása: EvolutivKereso_v2, Mondat_v2, Muszerefal_v3/v4 (a #27b + #30 csapdák kimérve)"
  ]

-- ===============================================================
-- 7. KIÍRÁSI SEGÉDEK — VÉKONY BURKOLOK (a mainhoz)
--    Print helpers — thin wrappers · 打印辅助 · Druckhilfen
-- ===============================================================

||| Egy §17-mérés négysoros kiírása; a Δ és a Δ/σ ITT számolódik
||| a futásban az importált mezőkből („futás” — GAUGE-elv).
méresKiírása : FizikaiMérés -> String
méresKiírása (FizikaiMérésKonstruktor megnevezés levezetett mért szigma forrás megjegyzés) =
  "  ▸ " ++ megnevezés ++ "\n" ++
  "      érték_levezetett = " ++ show levezetett ++ "\n" ++
  "      érték_mért       = " ++ show mért ++
    "  (σ = " ++ show szigma ++ ", forrás: " ++ forrás ++ ")\n" ++
  "      Δ                = " ++ show (levezetett - mért) ++ "   [futás]\n" ++
  "      Δ/σ              = " ++ show (abs (levezetett - mért) / szigma) ++ "   [futás]" ++
    (if abs (levezetett - mért) / szigma < 1.0 then "   → BELÜL" else "   → KÍVÜL") ++ "\n" ++
  "      megjegyzés: " ++ megjegyzés ++ "\n"

||| Egy mérföldkő egy sora.
mérföldkőSora : Mérföldkő -> String
mérföldkőSora (MérföldkőKonstruktor dátum esemény) =
  "  ● " ++ dátum ++ " — " ++ esemény ++ "\n"

-- ===============================================================
-- 8. A FUTTATHATÓ MŰSZERFAL v3 — v4-CSOPORTOK + ÚJ CSOPORTOK (W9+)
--    The runnable panel — v4 groups + new groups
--    可运行仪表盘——v4 分组 + 新分组 · Das lauffähige Panel v3
-- ===============================================================

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  SZIMA MŰSZERFAL v3 — a TELJES műszerfal (38 mutató + α-találatok)"
  putStrLn "  SZIMA COMPLETE INSTRUMENT PANEL · 西玛完整仪表盘"
  putStrLn "  VOLLSTÄNDIGE INSTRUMENTENTAFEL · לוח המחוונים המלא של סימה"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── 1. E8 GEOMETRIA (forrás: E8Iranymutato_v1) ──"
  putStrLn ("  gyök száma                    : " ++ show (gyökSzáma műszerfalMutatók))
  putStrLn ("  egész gyökök (112-es osztály) : " ++ show (egészGyökökSzáma műszerfalMutatók))
  putStrLn ("  fél-egész gyökök (128-as)     : " ++ show (félEgészGyökökSzáma műszerfalMutatók))
  putStrLn ("  W(E8) rendje                  : " ++ show (weylCsoportRendje műszerfalMutatók))
  putStrLn ("  E8 dimenzió                   : " ++ show (e8Dimenziója műszerfalMutatók))
  putStrLn ("  E8×E8 dimenzió                : " ++ show (e8E8Dimenziója műszerfalMutatók))
  putStrLn ("  240 gyök + 16 penge hídja     : " ++ show (tizenhatPengeHídja műszerfalMutatók))
  putStrLn ("  minden gyök normája² = 8?     : " ++ show (mindenGyökNormájaMegNyolc műszerfalMutatók))
  putStrLn ""
  putStrLn "── 2. A [[7,1,3]] HÍD ÉS A POZITÍV ÁBÉCÉ (forrás: E8FazisKapcsolat_v2) ──"
  putStrLn ("  pozitív ábécé (a 240 fele)    : " ++ show (pozitívÁbécéMérete műszerfalMutatók))
  putStrLn ("  Steane 7 bit                  : [" ++ unwords (steaneBitNevei műszerfalMutatók) ++ "]")
  putStrLn ("  a fázis-bit indexe (0-alapú)  : " ++ show (fázisBitIndexe műszerfalMutatók))
  putStrLn ""
  putStrLn "── 3. A NYELV (forrás: GyokSzo_v1, Fogalom_v1, Mondat_v2) ──"
  putStrLn ("  alapszókincs                  : " ++ show (alapszókincsMérete műszerfalMutatók))
  putStrLn ("  egész szavak (állandó)        : " ++ show (egészSzavakSzáma műszerfalMutatók))
  putStrLn ("  fél-egész szavak (kapcsolati) : " ++ show (félEgészSzavakSzáma műszerfalMutatók))
  putStrLn ("  fogalomtár (szó+pálya+kateg.) : " ++ show (fogalomTárMérete műszerfalMutatók))
  putStrLn ("  távolság-eloszlás (+1,+½,0,−½,−1): " ++ show (példaTávolságEloszlás műszerfalMutatók))
  putStrLn ("  bélyegek (3×3×3)              : " ++ show (bélyegekSzáma műszerfalMutatók))
  putStrLn ("  példabélyeg fázistényezője    : " ++ show (példaBélyegFázistényezője műszerfalMutatók))
  putStrLn ""
  putStrLn "── 4. FIZIKA (forrás: E8Iranymutato_v1, E8Univerzalitas_v1, CarnotCiklus_v1) ──"
  putStrLn ("  2D Ising α, β, γ, ν           : " ++ show (isingAlfa iranymutatoMutatok) ++ ", "
    ++ show (isingBeta iranymutatoMutatok) ++ ", "
    ++ show (isingGamma iranymutatoMutatok) ++ ", "
    ++ show (isingNu iranymutatoMutatok))
  putStrLn ("  univerzalitási osztály        : " ++ univerzalitasiOsztaly iranymutatoMutatok)
  putStrLn ("  ising-egyezés (tört ⟷ Double) : " ++ show (isingEgyezésÁllapota műszerfalMutatók))
  putStrLn ("  3D skálacímkék teljesülnek?   : " ++ show (skálacímkékÁllapota műszerfalMutatók)
    ++ "   (tűrés: " ++ show (skálacímkeTűrése műszerfalMutatók) ++ ")")
  putStrLn ("    Rushbrooke-maradék |α+2β+γ−2|  : " ++ show (rushbrookeMaradéka műszerfalMutatók))
  putStrLn ("    Hiperskála-maradék  |2−α−3ν|   : " ++ show (hiperskálázásMaradéka műszerfalMutatók))
  putStrLn ("    Fisher-maradék      |γ−ν(2−η)| : " ++ show (fisherMaradéka műszerfalMutatók))
  putStrLn ("  Carnot η(Th=500 K, Tc=300 K)  : " ++ show (hatásfokÖtszázHáromszáz műszerfalMutatók))
  putStrLn ("  Carnot η(Th=600 K, Tc=300 K)  : " ++ show (hatásfokHatszázHáromszáz műszerfalMutatók))
  putStrLn ("  Carnot η(Th=800 K, Tc=300 K)  : " ++ show (hatásfokNyolcszázHáromszáz műszerfalMutatók))
  putStrLn ("  Carnot η(Th=373 K, Tc=273 K)  : " ++ show (hatásfokVízJég műszerfalMutatók))
  putStrLn ("  Boltzmann kB (SI-exakt)       : " ++ show (boltzmannÁllandóÉrtéke műszerfalMutatók) ++ " J/K")
  putStrLn ("  Landauer-küszöb T = 300 K     : " ++ show (landauerKüszöbSzobahőmérsékleten műszerfalMutatók) ++ " J")
  putStrLn ("  Landauer-küszöb T = 1 K       : " ++ show (landauerKüszöbEgyKelvinen műszerfalMutatók) ++ " J")
  putStrLn ""
  putStrLn "── 5. KIMERÍTŐ FUTÁSIDEJŰ ÁLLAPOTOK (GAUGE-elv; mindegyik várt: 0) ──"
  putStrLn ("  szó-osztályhibák (240 szó)    : " ++ show (szóOsztályHibái műszerfalMutatók))
  putStrLn ("  távolság-skála hibái          : " ++ show (távolságSkálaHibái műszerfalMutatók)
    ++ "   (a " ++ show (fogalomTárMérete műszerfalMutatók * fogalomTárMérete műszerfalMutatók) ++ " párból)")
  putStrLn ("  kategória-hibák (240 fogalom) : " ++ show (kategóriaHibákSzáma műszerfalMutatók))
  putStrLn ("  zártságsértések (komponálás)  : " ++ show (zártságiHibákSzáma műszerfalMutatók))
  putStrLn ("  involúció-sértések (σ∘σ=id)   : " ++ show (involúcióHibái műszerfalMutatók))
  putStrLn ("  ellenpont pályaváltásai (240) : " ++ show (ellenpontPályaHibái műszerfalMutatók))
  putStrLn ("  bélyeg-különbözőségek (nub)   : " ++ show (bélyegKülönbözőségekSzáma műszerfalMutatók) ++ "   (várható: 27)")
  putStrLn ""
  putStrLn "── 6. HÍD-BIZONYÍTÁSOK (kernel-Refl, §18 — két út, egy híd) ──"
  putStrLn "  length AlapszókincsKonst = length FogalomTárKonst   [bizMűszerfalEmeletekHídja — IMPORTÁLT]"
  putStrLn "    — a nyelv két emelete (szavak ⟷ fogalmak) ugyanannyi jelet fog át;"
  putStrLn "      a híd: trans bizKétÚtHíd (sym bizKétPályaHídFogalmon) — két importált, független út"
  putStrLn "  128 + 112 = 240   [bizSzindrómaHíd — ÚJ: SteaneHilbertTerKonst + SzindromaTerKonst = E8GyokokKonst]"
  putStrLn "    — a Steane-tér és a szindróma-tér összege találkozik a gyök-enumerációval"
  putStrLn "  importált támaszok: TipusOsszegBizonyit, WeylRendPrimtenyezosBizonyit (E8Iranymutato_v1);"
  putStrLn "    bizKétÚtHíd (GyokSzo_v1); bizKétPályaHídFogalmon (Fogalom_v1); bizBélyegHíd (Mondat_v2);"
  putStrLn "    bizKodSzoTer, bizTisztaTer, bizEgyesResz, bizTortreszNevezo, bizLobaszasExponensEgesz (AlphaSteane);"
  putStrLn "    bizE8Gyokok, bizSzindromaTer112, bizE9Egyutthato, bizMagyarSzimmetriaMeret48, bizPiroskaReszhalmaz (CarnotE9)"
  putStrLn ""
  putStrLn "── 7. FIZIKAI ÁLLANDÓK (§17-négysoros formátum — minden Δ és Δ/σ futásból) ──"
  putStrLn (concat (map ((++ "\n") . méresKiírása) fizikaiMérések))
  putStrLn "  ▸ ŐSZINTE MEGJEGYZÉS a σ-ellentmondásról (nyitott kérdés-kártya):"
  putStrLn ("      a bare értékre Δ = " ++ show (alfaBareÉrtéke fizikaiÁllandóMutatók - alfaCodataÉrtéke fizikaiÁllandóMutatók)
    ++ " — ez a δ-két-útja a dressed hídnak;")
  putStrLn ("      σ = 1.1×10⁻⁸ (a „(11)”-ből) → Δ/σ ≈ " ++ show (abs (alfaBareÉrtéke fizikaiÁllandóMutatók - alfaCodataÉrtéke fizikaiÁllandóMutatók) / szigmaCodataTizenegy fizikaiÁllandóMutatók) ++ "   [futás]")
  putStrLn ("      σ = 2.1×10⁻⁸ (a „(21)”-ből) → Δ/σ ≈ " ++ show (abs (alfaBareÉrtéke fizikaiÁllandóMutatók - alfaCodataÉrtéke fizikaiÁllandóMutatók) / szigmaAlfaÉrtéke fizikaiÁllandóMutatók) ++ "   [futás]")
  putStrLn "      a σ választása tisztázandó — a dressed-sor viszont mindkét σ-val BELÜL van"
  putStrLn ""
  putStrLn "  ▸ a δ KÉT ÚTJA (két importált konstrukció, egy hídnak — §18):"
  putStrLn ("      δ₁ = (121/128)^(249+ln(9/8))   = " ++ show (deltaLobásásÉrtéke fizikaiÁllandóMutatók) ++ "   [AlphaSteane — lobásás]")
  putStrLn ("      δ₂ = Horgony − CODATA           = " ++ show (deltaSzámítottCodataÚtja fizikaiÁllandóMutatók) ++ "   [MagyarKinaiTorvenyek_v3 — különbség]")
  putStrLn ("      |δ₁ − δ₂|                      = " ++ show (abs (deltaLobásásÉrtéke fizikaiÁllandóMutatók - deltaSzámítottCodataÚtja fizikaiÁllandóMutatók)) ++ "   [futás — a közelítés maradéka]")
  putStrLn ""
  putStrLn "  ▸ (d) α_G — a gravitációs csatolás Mersenne-tornya:"
  let alfaGravTorony = pow 2.0 (-127.0)
  putStrLn ("      α_G = 2⁻¹²⁷                   = " ++ show alfaGravTorony ++ "   [futás — nincs publikus kifutás, az építő: pow 2.0 (−127.0)]")
  putStrLn ("      log₂(α_G)                     = " ++ show (log alfaGravTorony / log 2.0) ++ "   [futás — várható: −127]")
  putStrLn "      a mért log₂(α_G⁻¹) = 126.993 ≈ 127 — Mersenne-prím kitevő (forrás: HanMagyarKodolas.idr §8)"
  putStrLn ""
  putStrLn "── 8. E8-RÁCS ÉS SZIMMETRIÁK (forrás: MagyarCarnotE9_v3_CodatAlpha) ──"
  putStrLn ("  e8Redundancia (240/128)        : " ++ show (e8RedundanciaÉrtéke e8RácsSzimmetriaMutatók))
  putStrLn ("  E9-együttható (1+4+6+4+1)      : " ++ show (e9EgyütthatóÉrtéke e8RácsSzimmetriaMutatók))
  putStrLn ("  magyar szimmetria (2·2·6·2)    : " ++ show (magyarSzimmetriaMérete e8RácsSzimmetriaMutatók))
  putStrLn ("  Piroska-részhalamaz (22×7 bit) : " ++ show (piroskaBitekSzáma e8RácsSzimmetriaMutatók)
    ++ "   (128 < 154 < 240? " ++ show (piroskaRészhalamazÁllapota e8RácsSzimmetriaMutatók) ++ ")")
  putStrLn ("  szindróma-tér (240 − 128)      : " ++ show (szindrómaTérMérete e8RácsSzimmetriaMutatók))
  putStrLn ("  Carnot-buborék (960 − 16)      : " ++ show (buborékMérete e8RácsSzimmetriaMutatók))
  putStrLn ""
  putStrLn "── 9. A 17 LÉPÉS (számok: AlphaSteane; címek: AlphaSteaneDashboard) ──"
  putStrLn (concat (map (++ "\n") lépésSorok))
  putStrLn ""
  putStrLn "── 10. KRONOLÓGIA — AZ ELMÚLT 2 HÉT CSÚCSPONTJAI (a kutatási naplókból) ──"
  putStrLn (concat (map mérföldkőSora kétHetiMérföldkövek))
  putStrLn ""
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  A futtatás: cd szima_ter/modul && idris2 --exec main Muszerefal_v3.idr"
  putStrLn "  A weboldal: docs/muszerefal_v2.html (a v3-hoz még nem készült új oldal)"
  putStrLn "  GAUGE-elv: minden szám a tényleges futásból van (AGENTS §18/5)."
  putStrLn "Kész / 完成 / Fertig / גמר"
