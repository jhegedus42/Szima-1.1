module Muszerefal_v1

-- ═══════════════════════════════════════════════════════════════
-- MŰSZERFAL v1 — a projekt ÖSSZES kulcsmutatója egy helyen (W9)
-- INSTRUMENT PANEL v1 — ALL key indicators of the project in one place
-- 仪表盘 v1 — 项目全部关键指标集于一处（W9）
-- INSTRUMENTENTAFEL v1 — alle Schlüsselkennzahlen an einem Ort
-- לוח מחוונים גרסה 1 — כל מדדי המפתח של הפרויקט במקום אחד
-- ═══════════════════════════════════════════════════════════════
--
-- §24 (KÓD DUPLIKÁCIÓ TILOS — PRIORITÁS): EGYETLEN szám sem itt
--   születik — minden mutató az IMPORTÁLT modulok kifutása
--   (projekció). A műszerfal CSAK összegyűjti és KIÍRJA.
--   | 代码重复禁止——一切导入！ | Codeduplikation VERBOTEN! |
-- §18 (KÉT FÜGGETLEN ÚT, EGY HÍD): az EGYETLEN új tétel itt a
--   bizMűszerfalEmeletekHídja — a szókincs-lista hossza ⟷ a
--   fogalomtár-lista hossza, KÉT IMPORTÁLT bizonyítás (bizKétÚtHíd,
--   bizKétPályaHídFogalmon) összetételével: a nyelv két emelete
--   ugyanannyi jelet fog át. Nincs X = X.
-- GAUGE-elv: a docs/Muszerefal.md számai CSAK a tényleges
--   `--exec main` kimenetből kerülnek bele (semmi ellenőrizetlen
--   kijelentés — AGENTS §18/5).
-- §13: EZ EGY ÚJ MODUL — minden korábbi modul érintetlenül marad.
-- ═══════════════════════════════════════════════════════════════

import E8Iranymutato_v1        -- iranymutatoMutatok, tipus*SzamSzamitott, hid256Szamitott, mindenGyokNormajaNyolc (§24)
import E8Univerzalitas_v1      -- skálacímke-maradékok, tűrés, két egyezés-Bool (§24)
import CarnotCiklus_v1         -- hatásfokTört, landauerKüszöb, boltzmannÁllandó (§24)
import MagyarCarnotE9_v3_CodatAlpha -- carnotHatekonysag (§24 — KÖZVETLEN: publikus hatásfok-képlet)
import GyokSzo_v1              -- AlapszókincsKonst, EgészSzavakKonst, FélEgészSzavakKonst, hibaszámlálók, jel, PéldaEgészSzó (§24)
import Fogalom_v1              -- FogalomTárKonst, pálya-méretek, kategóriaHozzárendelésHibákSzáma, fogalomTárMéreteFutás (§24)
import SzintaxisMorfizmus_v1   -- komponálásZártságiHibákSzáma, involúcióHibákSzáma, ellenpontPályaHibákSzáma (§24)
import Mondat_v1               -- CPTBélyegekKonst, különbözőBélyegekSzáma, fázistényező, PéldaBélyegKonst (§24)
import E8FazisKapcsolat_v2     -- PozitivGyokokKonst, SteaneFazisIndexKonst, steaneHetBitNevek (§24)
import E8BelsoSzorzat          -- eloszlas (§24 — KÖZVETLEN: a távolság-eloszlás-mezőhöz)
import E8Gyokok_v2             -- E8Gyok (§24 — KÖZVETLEN: az eloszlas/PozitivGyokokKonst típusához)
import Data.List               -- length (§24: standard, nem újraírva)
import Data.String             -- unwords (§24: standard — az ékezetes nevek olvasható kiírásához)

%default covering

-- ===============================================================
-- 1. A MŰSZERFAL REKORDJA — AZ ÖSSZES KULCSMUTATÓ EGY SZERKEZETBEN
--    The dashboard record · 仪表盘记录 · Die Instrumententafel
--    רשומת לוח המחוונים
-- ===============================================================

||| A SZIMA MŰSZERFALA: a projekt minden kulcsmutatója egy rekordban.
||| Minden mezőérték az IMPORTÁLT modulok konstansainak/azok
||| projekcióinak kifutása (§24) — a rekord CSAKOL, nem számít.
||| A mezők csoportjai: E8-geometria, [[7,1,3]]-híd, nyelv,
||| kimerítő futásidejű állapotok (GAUGE), fizika.
||| 西玛仪表盘：项目全部关键指标装于一条记录（一切数值皆导入投影）。
public export
record MűszerfalMutatók where
  constructor MűszerfalMutatókKonstruktor
  -- ── E8-geometria (forrás: E8Iranymutato_v1) ──
  gyökSzáma             : Integer                          -- 240
  egészGyökökSzáma      : Integer                          -- 112
  félEgészGyökökSzáma   : Integer                          -- 128
  weylCsoportRendje     : Integer                          -- 696729600
  e8Dimenziója          : Integer                          -- 248
  e8E8Dimenziója        : Integer                          -- 496
  tizenhatPengeHídja    : Integer                          -- 256 (240 gyök + 16 penge)
  mindenGyökNormájaMegNyolc : Bool                         -- minden gyök normája² = 8?
  -- ── a [[7,1,3]] híd és a pozitív ábécé (forrás: E8FazisKapcsolat_v2) ──
  pozitívÁbécéMérete    : Integer                          -- 120 (a 240 felső fele)
  fázisBitIndexe        : Nat                              -- 5 (0-alapú; a 7. bit a „fázis")
  steaneBitNevei        : List String                      -- [idő, okság, tér, szín, hang, fázis, mód]
  -- ── a nyelv (forrás: GyokSzo_v1, Fogalom_v1, Mondat_v1) ──
  alapszókincsMérete    : Nat                              -- 240
  egészSzavakSzáma      : Nat                              -- 112 (állandó fogalmak)
  félEgészSzavakSzáma   : Nat                              -- 128 (kapcsolati fogalmak)
  fogalomTárMérete      : Nat                              -- 240 (szó + D8-pálya + kategória)
  bélyegekSzáma         : Nat                              -- 27 (3×3×3 töltés·paritás·idő)
  példaBélyegFázistényezője : Double                       -- 1.0 (a diagonális koherenciája)
  példaTávolságEloszlás : (Nat, Nat, Nat, Nat, Nat)        -- (1, 56, 126, 56, 1)
  -- ── kimerítő futásidejű állapotok (GAUGE — mindegyik várt értéke 0) ──
  szóOsztályHibái       : Nat                              -- szó↔osztály konzisztencia (240 szó)
  távolságSkálaHibái    : Nat                              -- megengedetlen szorzatú párok (240×240)
  kategóriaHibákSzáma   : Nat                              -- fogalom↔kategória konzisztencia (240)
  zártságiHibákSzáma    : Nat                              -- nyelven kívüli komponálás (240×240)
  involúcióHibái        : Nat                              -- σ∘σ ≠ id sértések (240×240)
  ellenpontPályaHibái   : Nat                              -- pályaváltó ellenpontok (240)
  bélyegKülönbözőségekSzáma : Nat                          -- nub után maradt bélyegek (27)
  -- ── fizika (forrás: E8Univerzalitas_v1, CarnotCiklus_v1) ──
  isingEgyezésÁllapota  : Bool                             -- törtek ⟷ Double mezők (import-híd)
  skálacímkékÁllapota   : Bool                             -- 3D Ising három címkéje a tűrésen belül
  rushbrookeMaradéka    : Double                           -- |α + 2β + γ − 2|
  hiperskálázásMaradéka : Double                           -- |2 − α − 3ν|
  fisherMaradéka        : Double                           -- |γ − ν(2−η)|
  skálacímkeTűrése      : Double                           -- 10⁻⁶ (konzervatív küszöb)
  hatásfokÖtszázHáromszáz : Double                         -- η(Th=500 K, Tc=300 K) — carnotHatekonysag
  hatásfokHatszázHáromszáz : Double                        -- η(Th=600 K, Tc=300 K)
  hatásfokNyolcszázHáromszáz : Double                      -- η(Th=800 K, Tc=300 K)
  hatásfokVízJég : Double                                  -- η(Th=373 K, Tc=273 K)
  landauerKüszöbSzobahőmérsékleten : Double                -- E = kB·300 K·ln 2
  landauerKüszöbEgyKelvinen : Double                       -- E = kB·1 K·ln 2
  boltzmannÁllandóÉrtéke : Double                          -- kB = 1,380649×10⁻²³ J/K (SI-exakt)

-- ===============================================================
-- 2. A MŰSZERFAL FELÉPÍTÉSE — CSAK IMPORTÁLT PROJEKCIÓKBÓL (§24)
--    Building the dashboard — IMPORTED projections only
--    仪表盘的构建——仅用导入投影 · Nur importierte Projektionen
-- ===============================================================

||| A műszerfal ÉRTÉKEI: minden mező az importált konstansok
||| kifutása (egyetlen literál sem — a §24 szellemében a rekord
||| CSAKOL). Lista-konstans a kályha-minta szerint: EGYETLEN
||| rekord-konstrukció, NEM let-lánc (l. LetLáncProbe).
public export
műszerfalMutatók : MűszerfalMutatók
műszerfalMutatók = MűszerfalMutatókKonstruktor
  (gyokSzam iranymutatoMutatok)
  tipus1SzamSzamitott
  tipus2SzamSzamitott
  (weylCsoportRend iranymutatoMutatok)
  (e8Dimenzio iranymutatoMutatok)
  (e8E8Dimenzio iranymutatoMutatok)
  hid256Szamitott
  mindenGyokNormajaNyolc
  (cast (List.length PozitivGyokokKonst))
  SteaneFazisIndexKonst
  steaneHetBitNevek
  (List.length AlapszókincsKonst)
  (List.length EgészSzavakKonst)
  (List.length FélEgészSzavakKonst)
  fogalomTárMéreteFutás
  (List.length CPTBélyegekKonst)
  (fázistényező PéldaBélyegKonst)
  (eloszlas (jel PéldaEgészSzó))
  osztályHibákSzáma
  távolságSkálaHibákSzáma
  kategóriaHozzárendelésHibákSzáma
  komponálásZártságiHibákSzáma
  involúcióHibákSzáma
  ellenpontPályaHibákSzáma
  különbözőBélyegekSzáma
  kétDimenziósIsingEgyezésE8Iranymutatóval
  mindenHáromDimenziósCímkeTeljesül
  rushbrookeMaradékHáromDimenziós
  hiperskálázásMaradékHáromDimenziós
  fisherMaradékHáromDimenziós
  skálacímkeTűrés
  (carnotHatekonysag 300.0 500.0)
  (carnotHatekonysag 300.0 600.0)
  (carnotHatekonysag 300.0 800.0)
  (carnotHatekonysag 273.0 373.0)
  (landauerKüszöb 300.0)
  (landauerKüszöb 1.0)
  boltzmannÁllandó

-- ===============================================================
-- 3. HÍD-BIZONYÍTÁS — KÉT FÜGGETLEN ÚT, EGY HÍD (§18)
--    Bridge proof — two independent paths, one bridge
--    桥证明——两条独立道路，一座桥 · Brückenbeweis
-- ===============================================================

-- ─── A híd tétel: a nyelv két emelete ugyanannyi jelet fog át ────
-- | A két oldal KÉT FÜGGETLEN enumeráció: a szókincs-lista (GyokSzo_v1)
-- | és a fogalomtár-lista (Fogalom_v1) — két külön építmény, a kernel
-- | sosem hasonlítja össze őket közvetlenül. A találkozás a
-- | KOMBINATORIKAI hídon (112 + 128) át vezet: a bizonyítás az IMPORTÁLT
-- | bizKétÚtHíd és bizKétPályaHídFogalmon tétel ÖSSZETÉTELE (§24: a
-- | bizonyításokat is ÚJRAHASZNÁLJUK, nem újraírjuk; §18: nincs X = X).

-- Kimenet: trans-szorzat — a NYELV KÉT EMELETE (szavak és fogalmak)
-- ugyanannyi jelet fog át. Első út: bizKétÚtHíd (GyokSzo_v1):
-- 112 + 128 = length AlapszókincsKonst; második út:
-- bizKétPályaHídFogalmon (Fogalom_v1): 112 + 128 = length FogalomTárKonst.
-- Két importált, független enumeráció kényszerített találkozása.
public export
bizMűszerfalEmeletekHídja :
  List.length AlapszókincsKonst = List.length FogalomTárKonst
bizMűszerfalEmeletekHídja = trans (sym bizKétÚtHíd) bizKétPályaHídFogalmon

-- ===============================================================
-- 4. A FUTTATHATÓ MŰSZERFAL — CSOPORTOSÍTOTT KIÍRÁS (W9)
--    The runnable dashboard — grouped printout
--    可运行的仪表盘——分组输出 · Das lauffähige Panel
-- ===============================================================

||| A W9-futtatás: a műszerfal teljes kiírása — címsorokkal,
||| csoportokba rendezve, minden szám a forrás-modullal megjelölve.
||| A kimenet értelmezhető (GAUGE-elv) — a docs/Muszerefal.md ebből
||| a futásból töltődik.
main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  SZIMA MŰSZERFAL v1 — minden kulcsmutató egy helyen (W9)"
  putStrLn "  SZIMA INSTRUMENT PANEL · 西玛仪表盘 · Instrumententafel"
  putStrLn "  לוח המחוונים של סימה — כל המדדים במקום אחד"
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
  putStrLn "── 3. A NYELV (forrás: GyokSzo_v1, Fogalom_v1, Mondat_v1) ──"
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
  putStrLn "── 6. HÍD-BIZONYÍTÁS (kernel-Refl, §18 — két út, egy híd) ──"
  putStrLn "  length AlapszókincsKonst = length FogalomTárKonst   [bizMűszerfalEmeletekHídja]"
  putStrLn "    — a nyelv két emelete (szavak ⟷ fogalmak) ugyanannyi jelet fog át;"
  putStrLn "      a híd: trans bizKétÚtHíd (sym bizKétPályaHídFogalmon) — két importált, független út"
  putStrLn "  importált támaszok: TipusOsszegBizonyit, WeylRendPrimtenyezosBizonyit (E8Iranymutato_v1);"
  putStrLn "    bizKétÚtHíd (GyokSzo_v1); bizKétPályaHídFogalmon (Fogalom_v1); bizBélyegHíd (Mondat_v1)"
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
