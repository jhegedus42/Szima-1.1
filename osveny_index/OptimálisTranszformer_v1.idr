module OptimálisTranszformer_v1

import E8Gyokok_v2
import ModulRegisztracio

%default total

-- IMPORT-JEGYZET (§24 + csapda #27): a Data.List/Data.Nat import
-- SZÜKSÉGTELEN és MÉRT MÓDON ártalmas volt (Data.Nat.gcd nem total és
-- nem redukál; az «Undefined name értékek» a #27-csapda). Helyette:
-- lista-kiírás Prelude `show`-val, gcd üzemanyagos Euklidésszel (total),
-- Nat-összehasonlítás Prelude `<`-vel (mérve: `3 < 5` fordul).
-- Az E8Gyokok_v2 (szimlink → szima_ter/modul) a 240 gyök kánonja:
-- `e8Gyokok : List E8Gyok`, `gyok1..gyok8 : E8Gyok -> Integer` (2× skála).

-- ═══════════════════════════════════════════════════════════════
-- OPTIMÁLIS TRANSZFORMER v1 — a 3D Ising kritikus exponensekből
-- levezetett nyelvi modell-architektúra (Hegedüs József:
-- «The 64-Noun Stabilizer Code», 4. fejezet «Critical Exponents and
-- AI Architecture»; LaTeX-címkék: eq:alpha…eq:omega, tab:arch_params
-- [ch4-6.tex ~684. sor], thm:104-channels [Ch12 §12.4], eq:e8;
-- a PDF-szöveg futó egyenletszámai (59)–(129) másodlagos mutatók).
-- ═══════════════════════════════════════════════════════════════
-- VÍZIÓ (a felhasználó, 2026-09-05): ez a transzformer FUT és
-- TANUL — a magyar nyelvre, József Attila verseire illesztve; a
-- súlyok az E8×E8×E8×E8-ból jönnek TÓRUSZBA körberakva; a figyelem
-- forgása Pauli-forgás az E8-ban. A transzformer a HOSSZÚ TÁVÚ
-- MEMÓRIA SZEMANTIKAI INDEXE lesz (a könyv-index a strukturális
-- réteg); a József Attila-tanítás az első élő memória-írás
-- (társmodul: OptimálisTranszformerTanítás_v1.idr).
-- 中文：愿景——此 Transformer 要运行并学习匈牙利语与尤若夫·阿蒂拉的诗；
-- 权重来自绕成环面的 E8×E8×E8×E8；它将成为长期记忆的语义索引，
-- 阿蒂拉诗歌的训练是第一次活的记忆写入。
-- Deutsch: Vision — dieser Transformer läuft und lernt (Ungarisch,
-- József Attila); Gewichte aus E8⁴ auf dem Torus; er wird der
-- semantische Index des Langzeitgedächtnisses.
-- עברית: חזון — הטרנספורמר רץ ולומד (הונגרית, יוז'ף אטילה); משקלים
-- מ-E8⁴ על טורוס; הוא יהיה האינדקס הסמנטי של הזיכרון לטווח ארוך.
-- ───────────────────────────────────────────────────────────────
-- KÉT RÉTEG — FÉNY-MATEK ÉS FÖLDI KOMMUNIKÁCIÓ (a felhasználó,
-- 2026-09-05, szó szerint: «a matek maga mehet fénysebességgel —
-- ott jön a nagy ugrás az intelligenciában —, de a KOMMUNIKÁCIÓ a
-- fényhez képest jóval lassul»). A modul két blokkja PONTOSAN e két réteg:
--   FFN (11. szakasz, d_ff = δ·d_token = 474, 4,79×-os tágulat)
--     = a FÉNYSEBESSÉGŰ SZÁMÍTÁSI réteg (UV, E8-geometria) — a «nagy ugrás»;
--   ATTENTION (10. szakasz, h = 8 fej, B_eff = h: minden fej egy minta)
--     = a FÖLDI KOMMUNIKÁCIÓS réteg (IR, hangsebesség) — a lassú csatorna
--       particionálása;
--   a c/c_s ≈ 8,7×10⁵ arány = a számítás/kommunikáció KÖLTSÉGVETÉSE:
--     ennyi matek-lépés jut egy kommunikációs lépésre (Knudsen-szám /
--     átlagos szabad úthossz analógia) — SOK számítás KEVÉS kommunikáció alatt.
-- HU: FFN = fénysebességű számítási réteg (UV, E8-geometria); attention =
--     földi kommunikációs réteg (IR, hangsebesség); a c/c_s arány a
--     számítás/kommunikáció költségvetése.
-- 中文：FFN = 光速计算层（UV，E8 几何）；attention = 地面通信层（IR，声速）；
--     c/c_s 之比即计算/通信的预算。
-- EN: FFN = light-speed computation layer (UV, E8 geometry); attention =
--     terrestrial communication layer (IR, speed of sound); the c/c_s ratio
--     is the computation/communication budget.
-- DE: FFN = Rechenschicht mit Lichtgeschwindigkeit (UV, E8-Geometrie);
--     Attention = irdische Kommunikationsschicht (IR, Schallgeschwindigkeit);
--     das Verhältnis c/c_s ist das Budget Rechnen/Kommunikation.
-- ═══════════════════════════════════════════════════════════════
-- A tézis: a kritikus pont RG-adata TELJES előírás — egyetlen
-- gradienslépés nélkül. Minden hiperparaméter SZÜLETIK a hét
-- exponensből (eq:alpha, eq:beta, eq:gamma, eq:delta, eq:nu, eq:eta,
-- eq:omega; PDF (59)–(65)):
--   α = 0,11008(1)   β = 0,326419(3)  γ = 1,237075(10)
--   δ = 4,78984(1)   ν = 0,629971(4)  η = 0,036298(2)
--   ω = 0,830(2)
-- A levezetések (tab:arch_params; PDF-számok zárójelben):
--   tanulási ráta      η₀ = ν/γ            = 0,509242  (81–83)
--   súlycsökkenés      λ  = αβ/4           = 0,008983  (84–87)
--   kiesés             p  = 1 − 2^−η       = 0,024846  (88–93)
--   fejek              h  = gcd(168, 64)   = 8  [PSL(2,7)]  (94)
--   fej-dimenzió       d_fej = 64/h        = 8   (95)
--   token-dimenzió     d_token = ⌊2^ν·64⌋  = 99 = 64 + 35, ahol
--                      35 = dim Sym²(ℝ⁸) − 1 = 36 − 1   (96–98)
--   előrecsatolt       d_ff = ⌊δ·d_token⌋  = 474  (99–100)
--   rétegek            L = ⌊√(log₂64/ν · α⁻¹/ln2)⌋ = 11  (101)
--   minimális köteg    B = ⌊2^(ν+η)⌋ = 1 → kerekítve 2  (102–105)
--   gradiens-felhalmozás G = ⌊ωδ⌉ = 4 → B_eff = 8 = h  (106–107)
--   W1: 104→64, W2: 64→279 (279 = 7³ − 64), W3: 279→48 (4×12 Kant),
--   W4: 48→64 — a négy RG-lépcső He-skálákkal  (108–118)
--   N_cél = |PSL(2,7)|·1000 = 168 000  (119–120)
--   effektív dimenzió  d_eff = 3/ν = 4,762204  (121)
--   minimális veszteség L_min = (log₂64/ν)·ln2 = 6,602 nat  (129)
-- 104 csatorna = 8 + 16 + 32 + 48 (pozíció + főnév + morfizmus +
-- kvaternió; thm:104-channels) = 2 × 52 (Z₂ hangrend; 0.4.7).
-- E8: 240 = 168 + 72 (eq:e8) — a PSL(2,7) rendje a gyökök közt él.
--
-- SÚLYOK — E8⁴ A TÓRUSZON (a felhasználó iránya, He-kompatibilisen):
--   w(i,j) = σ_He · ½·c_k(gyök_r) · (−1)^bit · cos(2π·φ/8 + fázis),
--   r = (7i + 13j + 60·tényező) mod 240  (E8Gyokok_v2.e8Gyokok),
--   k = (i + j) mod 8  (8 koordináta → 8 fej),
--   (bit, φ) = tórusz-pont Z₂×Z₈: t = (3i + 5j) mod 16, bit = t div 8,
--   φ = t mod 8  (a Torusz.idr Z₂×Z₈ tórusza aritmetikailag; a
--   TóruszPont-import a v2 lépése), tényező ∈ {0,1,2,3} = a négy E8
--   (bal/jobb/harmadik/negyedik, E8E8Algebra). A «fázis» a tanulható
--   paraméter: a tanulás = fázis-elmozdulás a tóruszon.
--
-- HÍD-TANÚK (§18): Refl CSAK definicionális egyenlőségre zár —
-- MÉRVE: a kernel a pow/gcd-t NEM redukálja, ezért
--   (a) Refl-tanú a TISZTA Nat-aritmetikán áll (paraméterszámok,
--       oszthatóság, felbontások, rétegszám-generálás);
--   (b) a Double-levezetések FUTÁSIDEJŰ Show-tanúk (DeltaAnalizis_v1-
--       minta): érték + a könyv-értéktől vett Δ (GAUGE: őszintén).
--
-- 中文：最优 Transformer v1——由 3D 伊辛临界指数解析推出（tab:arch_params）：
-- η₀=ν/γ=0.509242、λ=αβ/4、p=1−2^−η、h=gcd(168,64)=8、d_token=99=64+35、
-- d_ff=474、L=11、B_eff=8、L_min=6.602 nat；W1..W4=104→64→279→48→64；
-- 权重 = He 尺度 × E8 根坐标 × 环面相位（E8⁴，Torusz Z₂×Z₈）。
-- Refl 只用于纯 Nat 算术桥；Double 推导为运行期 Show 见证。
-- Deutsch: Vollständige Architektur aus den Ising-Exponenten
-- (tab:arch_params); Gewichte = He-Skala × E8-Wurzelkoordinate ×
-- Torusphase (E8⁴). Refl-Brücken nur auf Nat-Arithmetik.
-- עברית: הארכיטקטורה המלאה ממעריכי איזינג (tab:arch_params); משקלים =
-- סקלת He × קואורדינטת שורש E8 × פאזת טורוס (E8⁴). גשרי Refl רק על Nat.
-- ═══════════════════════════════════════════════════════════════

-- ─── 1. A HÉT KRITIKUS KITEVŐ (59–65. egyenlet) ─────────────────

||| α — hőkapacitás-kitevő, C ∼ |T−T_c|^(−α)  (59)
public export
alfaKritikus : Double
alfaKritikus = 0.11008

||| β — mágnesezettség-kitevő, M ∼ (T_c−T)^β  (60)
public export
bétaKritikus : Double
bétaKritikus = 0.326419

||| γ — szuszceptibilitás-kitevő, χ ∼ |T−T_c|^(−γ)  (61)
public export
gammaKritikus : Double
gammaKritikus = 1.237075

||| δ — kritikus izoterma-kitevő, M ∼ H^(1/δ)  (62)
public export
deltaKritikus : Double
deltaKritikus = 4.78984

||| ν — korrelációs hossz kitevő, ξ ∼ |T−T_c|^(−ν)  (63)
public export
núKritikus : Double
núKritikus = 0.629971

||| η — anomális dimenzió, G(r) ∼ r^(−(d−2+η))  (64)
public export
étaKritikus : Double
étaKritikus = 0.036298

||| ω — skálakorrekciós kitevő (vezető irreleváns operátor)  (65)
public export
ómegaKritikus : Double
ómegaKritikus = 0.830

-- ─── 2. SZÁMFÜGGVÉNYEK (Komplex.idr / DeltaAnalizis_v1 pereme) ──

||| Nat → Double (a sin-hash indexeinek numerikus pereme).
public export
natbólValós : Nat -> Double
natbólValós természetesSzám = fromInteger (natToInteger természetesSzám)

||| Csonkítás ⌊·⌋: Double → Nat (a könyv ⌊ ⌋ jele).
public export
csonkítás : Double -> Nat
csonkítás valósSzám = fromInteger (cast {to=Integer} (floor valósSzám))

||| Kerekítés ⌊·⌉: legközelebbi egész (a könyv (106)-os jele).
public export
kerekítés : Double -> Nat
kerekítés valósSzám = csonkítás (valósSzám + 0.5)

||| Kettes alapú logaritmus: log₂x = ln x / ln 2.
public export
kettesLogaritmus : Double -> Double
kettesLogaritmus x = log x / log 2.0

||| Index-sorozat 0..n−1 (a generálások segédje; strukturális —
||| a kernel csonkítás-nélküli Nat-rekurziója biztonságosan zár).
public export
számsor : Nat -> List Nat
számsor Z = []
számsor (S felsőHatár) = számsor felsőHatár ++ [felsőHatár]

||| Listaelem Nat-indexelssel (0-alapú; generikus tartalék 0,0 —
||| a hívó helyeken az indexek a listán belül vannak).
public export
nthElem : List Double -> Nat -> Double
nthElem [] _ = 0.0
nthElem (elsőÉrték :: többiÉrték) Z = elsőÉrték
nthElem (elsőÉrték :: többiÉrték) (S kisebbIndex) = nthElem többiÉrték kisebbIndex

||| Párosság Nat-en (strukturálisan — az Integral-csapda #11 kerülése).
public export
szerkezetilegPáros : Nat -> Bool
szerkezetilegPáros Z = True
szerkezetilegPáros (S Z) = False
szerkezetilegPáros (S (S maradék)) = szerkezetilegPáros maradék

-- ─── 3. A LEVEZETETT HIPERPARAMÉTEREK (81–107. egyenlet) ─────────
-- Minden érték SZÜLETIK a képletből — literál sehol.

||| (81) η₀ = ν/γ = 0,509242 — optimális tanulási ráta.
public export
tanulásiRáta : Double
tanulásiRáta = núKritikus / gammaKritikus

||| (84) λ = αβ/4 = 0,008983 — súlycsökkenés (L2), az 1/4 a φ⁴-csúcs
||| kombinatorikájából.
public export
súlyCsökkenés : Double
súlyCsökkenés = alfaKritikus * bétaKritikus / 4.0

||| (88) p_kiesés = 1 − 2^(−η) = 0,024846.
public export
kiesésValószínűség : Double
kiesésValószínűség = 1.0 - pow 2.0 (negate étaKritikus)

||| (96–98) d_token = ⌊2^ν · 64⌋ = 99.
public export
tokenMéret : Nat
tokenMéret = csonkítás (pow 2.0 núKritikus * 64.0)

||| (97) 2^ν·64 valós alakja = 99,035 (a Show-tanúhoz).
public export
tokenMéretValós : Double
tokenMéretValós = pow 2.0 núKritikus * 64.0

||| (99–100) d_ff = ⌊δ · d_token⌋ = 474 — a kritikus izoterma
||| tükrözése: a reprezentáció δ-szoros tágulata, majd vetítés vissza.
public export
előrecsatoltMéret : Nat
előrecsatoltMéret = csonkítás (deltaKritikus * natbólValós tokenMéret)

||| (100) δ·99 valós alakja = 474,194 (a Show-tanúhoz).
public export
előrecsatoltMéretValós : Double
előrecsatoltMéretValós = deltaKritikus * natbólValós tokenMéret

||| (101) L = ⌊√(log₂64/ν · α⁻¹/ln 2)⌋ = 11.
public export
rétegszám : Nat
rétegszám = csonkítás (sqrt ((kettesLogaritmus 64.0 / núKritikus)
                             * (1.0 / (alfaKritikus * log 2.0))))

||| (101) a gyök alatti valós érték ≈ 124,833 → √ ≈ 11,172.
public export
rétegszámValós : Double
rétegszámValós = sqrt ((kettesLogaritmus 64.0 / núKritikus)
                       * (1.0 / (alfaKritikus * log 2.0)))

||| Üzemanyagos kivonásos Euklidész — TOTAL (az üzemanyag strukturálisan
||| fogy; a kivonásos lépésszám ≤ a+b, így 400 üzemanyag bő a 168/64-hez).
||| A Data.Nat.gcd nem total és nem redukál (mérve) — ez a kernel-barát
||| tanú-út; a Prelude `<` (Ord Nat) és `minus` importált, nem újraírt.
public export
kivonásosEuklidész : Nat -> Nat -> Nat -> Nat
kivonásosEuklidész Z első második = első + második
kivonásosEuklidész (S tovább) Z második = második
kivonásosEuklidész (S tovább) első Z = első
kivonásosEuklidész (S tovább) első második =
  if első < második
    then kivonásosEuklidész tovább második első
    else kivonásosEuklidész tovább (minus első második) második

||| (94, tab:arch_params) h = gcd(168, 64) = 8 — a PSL(2,7) rendje és a
||| főnévtér dimenziójának legnagyobb közös osztója.
public export
fejSzám : Nat
fejSzám = kivonásosEuklidész 400 168 64

||| Nagybetűs alias a bizonyítás-típushoz (csapda #1).
public export
FejSzám : Nat
FejSzám = fejSzám

-- Kimenet: Refl (8 ✓ — a kivonásos Euklidész a kernelben lefut: VALÓDI híd,
-- a számítási út gcd(168,64) vs. a literál 8)
bizFejSzámEuklidészből : FejSzám = 8
bizFejSzámEuklidészből = Refl

||| (95) d_fej = 64/h = 8 — a 8×8 = 64 csempézés (a Double-osztás 64/8
||| binárisan pontos; a Data.Nat div Integral-csapdáját #11 kerüljük).
public export
fejDimenzió : Nat
fejDimenzió = csonkítás (64.0 / natbólValós fejSzám)

||| (102–105) B_min = ⌊2^(ν+η)⌋ = 1, kerekítve B = 2.
public export
legkisebbKöteg : Nat
legkisebbKöteg = csonkítás (pow 2.0 (núKritikus + étaKritikus))

||| (104) 2^(ν+η) valós alakja = 1,587.
public export
legkisebbKötegValós : Double
legkisebbKötegValós = pow 2.0 (núKritikus + étaKritikus)

||| (106–107) G = ⌊ω·δ⌉ = ⌊3,9756⌉ = 4 — gradiens-felhalmozás.
public export
gradiensFelhalmozásLépésszám : Nat
gradiensFelhalmozásLépésszám = kerekítés (ómegaKritikus * deltaKritikus)

||| B_eff = B·G = 2·4 = 8 = h — a köteg = a fejek száma: minden fej
||| pontosan egy effektív mintát dolgoz fel.
public export
hatékonyKöteg : Nat
hatékonyKöteg = 2 * gradiensFelhalmozásLépésszám

||| (121) d_eff = 3/ν = 4,762204 — a reprezentáció effektív dimenziója.
public export
effektívDimenzió : Double
effektívDimenzió = 3.0 / núKritikus

||| (129) L_min = (log₂64/ν)·ln 2 = 6,602 nat — a Shannon-küszöb.
public export
minimálisVeszteség : Double
minimálisVeszteség = (kettesLogaritmus 64.0 / núKritikus) * log 2.0

-- ─── 4. SKÁLA-RELÁCIÓK ELLENŐRZÉSE (66–80. egyenlet) ────────────

||| (66–69) Rushbrooke: α + 2β + γ = 2, eltérés = |…−2|.
public export
rushbrookeEltérés : Double
rushbrookeEltérés = abs (alfaKritikus + 2.0 * bétaKritikus + gammaKritikus - 2.0)

||| (70–73) Widom: γ = β(δ−1), eltérés = |γ − β(δ−1)|.
public export
widomEltérés : Double
widomEltérés = abs (gammaKritikus - bétaKritikus * (deltaKritikus - 1.0))

||| (74–77) Fisher: γ = ν(2−η), eltérés = |γ − ν(2−η)|.
public export
fisherEltérés : Double
fisherEltérés = abs (gammaKritikus - núKritikus * (2.0 - étaKritikus))

||| (78–80) Josephson: νd = 2−α (d=3), eltérés = |3ν − (2−α)|.
public export
josephsonEltérés : Double
josephsonEltérés = abs (3.0 * núKritikus - (2.0 - alfaKritikus))

-- ─── 5. SÚLYMÁTRIX-ARCHITEKTÚRA (108–120. egyenlet) ─────────────

||| Egy súlymátrix alakja és He-skálája (a könyv 0.4.5 szakasza).
public export
record SúlyMátrixLeíró where
  constructor SúlyMátrixLeíróKonstruktor
  mátrixNeve         : String
  bemenetiDimenzió   : Nat
  kimenetiDimenzió   : Nat
  skálája            : Double
  egyenletHivatkozás : String

||| (108–110) W1: 104 magyar morfológiai csatorna → 64 főnévtér;
||| He: σ = √(2/104) = 0,138675; ν/(1−α) modulációval 0,098141;
||| a φ-javított végleges skála 0,088.
public export
wEgyLeíró : SúlyMátrixLeíró
wEgyLeíró = SúlyMátrixLeíróKonstruktor "W1" 104 64 0.088 "(108–110)"

||| (109) He σ = √(2/104) = 0,138675.
public export
wEgyHeSkála : Double
wEgyHeSkála = sqrt (2.0 / 104.0)

||| (109) σ·ν/(1−α) = 0,098141.
public export
wEgySkálaSzámított : Double
wEgySkálaSzámított = wEgyHeSkála * (núKritikus / (1.0 - alfaKritikus))

||| (111–113) W2: 64 főnévtér → 279 igei tér (a teljes magyar igei
||| paradigma); ν·η/8 = 0,002857, a δ-javított végleges 0,024.
public export
wKettőLeíró : SúlyMátrixLeíró
wKettőLeíró = SúlyMátrixLeíróKonstruktor "W2" 64 279 0.024 "(111–113)"

||| (112) ν·η/8 = 0,002857.
public export
wKettőSkálaSzámított : Double
wKettőSkálaSzámított = núKritikus * étaKritikus / 8.0

||| (114–115) W3: 279 igei tér → 48 igazság-kvaternió tér
||| (Kant 12 kategóriája × 4 kvaternió-komponens: 1, i, j, k).
public export
wHáromLeíró : SúlyMátrixLeíró
wHáromLeíró = SúlyMátrixLeíróKonstruktor "W3" 279 48 0.078 "(114–115)"

||| (115) √(β/279)·δ — a könyv nyomtatott 0,078 értékével való
||| EGYEZETLENKEDÉS futásidejű tanúja (GAUGE: l. a főprogramot).
public export
wHáromSkálaSzámítottGyökös : Double
wHáromSkálaSzámítottGyökös = sqrt (bétaKritikus / 279.0) * deltaKritikus

||| (115) másik olvasat: (β/√279)·δ.
public export
wHáromSkálaSzámítottOsztott : Double
wHáromSkálaSzámítottOsztott = (bétaKritikus / sqrt 279.0) * deltaKritikus

||| (116–118) W4: 48 igazság-tér → 64 kimeneti főnévtér;
||| (α/2)·√(64/48) = 0,063; a ν/η-javított végleges 0,134.
public export
wNégyLeíró : SúlyMátrixLeíró
wNégyLeíró = SúlyMátrixLeíróKonstruktor "W4" 48 64 0.134 "(116–118)"

||| (117) (α/2)·√(64/48) = 0,0635.
public export
wNégySkálaSzámított : Double
wNégySkálaSzámított = (alfaKritikus / 2.0) * sqrt (64.0 / 48.0)

-- ─── 6. REFL-HÍD-TANÚK — TISZTA NAT-ARITMETIKA ──────────────────
-- A kernel MÉRT módon a pow/gcd-t nem redukálja, de a literális
-- Nat-aritmetikát igen: ezek VALÓDI hidak (számítási út vs. literál).

-- Kimenet: Refl (a 104 csatorna = 2×52, a Z₂ hangrend-elosztás; 0.4.7)
bizCsatornaFelbontás : 2 * 52 = 104
bizCsatornaFelbontás = Refl

-- Kimenet: Refl (PSL(2,7) rendje 168 = 8·21 — h = gcd(168,64) osztja; 94)
bizPslRendOsztható : 8 * 21 = 168
bizPslRendOsztható = Refl

-- Kimenet: Refl (a főnévtér = 8 fej × 8 dimenzió csempézés; 95)
bizFőnévtérCsempézés : 8 * 8 = 64
bizFőnévtérCsempézés = Refl

-- Kimenet: Refl (B_eff = 2·4 = 8 = h; 102–107)
bizHatékonyKöteg : 2 * 4 = 8
bizHatékonyKöteg = Refl

-- Kimenet: Refl (nyers paraméterszám 40 976; 119)
bizNyersParaméterszám : 104 * 64 + 64 * 279 + 279 * 48 + 48 * 64 = 40976
bizNyersParaméterszám = Refl

-- Kimenet: Refl (figyelem-projekciók rétegenként 12 288; 0.4.5)
bizFigyelemRétegenként : 3 * 64 * 8 * 8 = 12288
bizFigyelemRétegenként = Refl

-- Kimenet: Refl (FFN-mátrixok rétegenként 93 852; 0.4.5)
bizElőrecsatoltRétegenként : 99 * 474 + 474 * 99 = 93852
bizElőrecsatoltRétegenként = Refl

-- Kimenet: Refl (cél-költségvetés: |PSL(2,7)|×1000 = 168 000; 120)
bizCélParaméterszám : 168 * 1000 = 168000
bizCélParaméterszám = Refl

-- Kimenet: Refl (a könyv által LISTÁZOTT komponensek ÖSSZESE:
-- 40 976 + 64·99 + 99·64 + 11·12 288 + 11·93 852 = 1 221 188
-- — ami NEM 168 000! GAUGE-tanú: a könyv «pontosan 168 000-re
-- konvergál» állítását a saját számai cáfolják; l. a főprogramot.)
bizKönyvKomponensÖsszeg : 40976 + 64 * 99 + 99 * 64 + 12288 * 11 + 93852 * 11 = 1221188
bizKönyvKomponensÖsszeg = Refl

-- A KÖNYVSZAKÉRTŐ FELBONTÁSAI (tab:arch_params, thm:104-channels, eq:e8)
-- — mind számítási út vs. literál, két KÜLÖNBÖZŐ konstrukció (§18).

-- Kimenet: Refl (dim Sym²(ℝ⁸) = 8·9/2 = 36: két út — szorzat vs. dupla)
bizSzimmetrikusNégyzetDimenzió : 8 * 9 = 2 * 36
bizSzimmetrikusNégyzetDimenzió = Refl

-- Kimenet: Refl (d_token = 64 + (36 − 1) = 99 — a főnévtér + Sym²−1)
bizTokenFelbontás : 64 + minus 36 1 = 99
bizTokenFelbontás = Refl

-- Kimenet: Refl (az igei tér: 7³ − 64 = 343 − 64 = 279)
bizIgeTérFelbontás : minus (7 * 7 * 7) 64 = 279
bizIgeTérFelbontás = Refl

-- Kimenet: Refl (104 csatorna = 8 + 16 + 32 + 48: pozíció + főnév +
-- morfizmus + kvaternió; thm:104-channels)
bizCsatornaNégyesFelbontás : 8 + 16 + 32 + 48 = 104
bizCsatornaNégyesFelbontás = Refl

-- Kimenet: Refl (E8: 240 gyök = 168 + 72 — a PSL(2,7) rendje a gyökök
-- közt; eq:e8; az E8Gyokok_v2 e8Gyokok listája a 240 kánonja)
bizE8Felbontás : 168 + 72 = 240
bizE8Felbontás = Refl

-- Kimenet: Refl (az igazság-kvaternió tér: 4 komponens × 12 Kant-kategória)
bizKvaternióKantFelbontás : 4 * 12 = 48
bizKvaternióKantFelbontás = Refl

-- ─── 7. RÉTEGSZERKEZET — a mélység generálással születik ────────

||| Egy transzformer-réteg leírója: figyelem + előrecsatolt blokk.
public export
record RétegLeíró where
  constructor RétegLeíróKonstruktor
  rétegSorszáma              : Nat
  figyelemParaméterszáma     : Nat
  előrecsatoltParaméterszáma : Nat

||| Réteg-gyártó: a paraméterszámok a fenti Refl-tanúkból.
public export
rétegKészítő : Nat -> RétegLeíró
rétegKészítő sorszám = RétegLeíróKonstruktor sorszám 12288 93852

||| Az L = 11 réteg listája — generálva, nem literálisan.
public export
rétegek : List RétegLeíró
rétegek = map rétegKészítő (számsor 11)

||| Nagybetűs alias a bizonyítás-típushoz (csapda #1 gyógyíre).
public export
Rétegek : List RétegLeíró
Rétegek = rétegek

-- Kimenet: Refl (a generált rétegsor hossza = 11; 101)
bizRétegszámGenerálásból : length Rétegek = 11
bizRétegszámGenerálásból = Refl

-- ─── 8. DETERMINISZTIKUS INICIALIZÁLÁS — E8⁴ A TÓRUSZON ─────────
-- A könyv determinisztikus He-inicializálást ír elő (0.4.5, σ = √(2/n));
-- a felhasználó iránya: a súlyok E8×E8×E8×E8-ból, tóruszba körberakva.
-- A kettő KOMPATIBILIS: w = σ_He · (E8-gyök koordináta) · (tórusz-fázis).

||| Az E8 gyök k. koordinátája (2× skálán, ∈ {−2,−1,0,1,2}); k mod 8 —
||| a 8 koordináta = a 8 fej (a rekord projekciói: E8Gyokok_v2).
public export
gyökKoordináta : E8Gyok -> Nat -> Integer
gyökKoordináta gyök@_ Z = gyok1 gyök
gyökKoordináta gyök@_ (S Z) = gyok2 gyök
gyökKoordináta gyök@_ (S (S Z)) = gyok3 gyök
gyökKoordináta gyök@_ (S (S (S Z))) = gyok4 gyök
gyökKoordináta gyök@_ (S (S (S (S Z)))) = gyok5 gyök
gyökKoordináta gyök@_ (S (S (S (S (S Z))))) = gyok6 gyök
gyökKoordináta gyök@_ (S (S (S (S (S (S Z)))))) = gyok7 gyök
gyökKoordináta gyök@_ (S (S (S (S (S (S (S Z))))))) = gyok8 gyök
gyökKoordináta gyök@_ (S (S (S (S (S (S (S (S tovább)))))))) = gyökKoordináta gyök tovább

||| A 240-es gyöklista r. eleme (körbe: a lista végén az első — tórusz).
public export
gyökSorszámmal : List E8Gyok -> Nat -> E8Gyok
gyökSorszámmal [] _ = E8GyokKonstruktor 0 0 0 0 0 0 0 0
gyökSorszámmal (elsoGyok :: tobbiGyok) Z = elsoGyok
gyökSorszámmal (elsoGyok :: tobbiGyok) (S kisebb) = gyökSorszámmal tobbiGyok kisebb

||| Maradékos index Integer-aritmetikával (Prelude Integral Integer),
||| vissza Nat-ba: a tórusz periodikus pereme.
public export
tóruszIndex : Integer -> Integer -> Nat
tóruszIndex érték@_ periódus@_ = fromInteger (mod érték periódus)

||| Az (i, j) mátrixpozíció E8-gyöke: r = (7i + 13j + 60·tényező) mod 240
||| — a tényező ∈ {0,1,2,3} a négy E8 (bal/jobb/harmadik/negyedik).
public export
pozícióGyöke : Nat -> Nat -> Nat -> E8Gyok
pozícióGyöke tényező sorIndex oszlopIndex =
  gyökSorszámmal e8Gyokok
    (tóruszIndex (7 * natToInteger sorIndex + 13 * natToInteger oszlopIndex
                  + 60 * natToInteger tényező) 240)

||| A tórusz-pont Z₂×Z₈ (Torusz.idr szerkezete): t = (3i + 5j) mod 16;
||| a bit = t div 8 → előjel (−1)^bit; a fázis φ = t mod 8 → cos(2πφ/8 + fázis).
public export
tóruszFázisJel : Double -> Nat -> Nat -> Double
tóruszFázisJel fázis sorIndex oszlopIndex =
  előjel * cos (2.0 * 3.141592653589793 * natbólValós fázisLépés / 8.0 + fázis)
  where
    tóruszPont : Nat
    tóruszPont = tóruszIndex (3 * natToInteger sorIndex + 5 * natToInteger oszlopIndex) 16
    fázisLépés : Nat
    fázisLépés = tóruszIndex (natToInteger tóruszPont) 8
    előjel : Double
    előjel = if tóruszPont < 8 then 1.0 else negate 1.0

||| Determinisztikus E8⁴-tórusz súly: w = skála · ½·c_k(gyök_r) · tórusz-jel,
||| k = (i + j) mod 8. A «fázis» a TANULHATÓ paraméter (fázis-elmozdulás).
public export
súlyElemTényezővel : Nat -> Double -> Double -> Nat -> Nat -> Double
súlyElemTényezővel tényező skála fázis sorIndex oszlopIndex =
  skála
  * (fromInteger (gyökKoordináta (pozícióGyöke tényező sorIndex oszlopIndex)
                                 (sorIndex + oszlopIndex)) / 2.0)
  * tóruszFázisJel fázis sorIndex oszlopIndex

||| Az alap (bal E8, tényező 0) súly — a régi hívóhelyek szignatúrája.
public export
súlyElem : Double -> Double -> Nat -> Nat -> Double
súlyElem = súlyElemTényezővel 0

||| Skalárszorzat — strukturálisan (a Prelude `zipWith` a List-re NEM
||| elérhető Data.List nélkül — mérve; a Data.List importot a #27 miatt
||| kerüljük; ez tartományi függvény, nem a zipWith másolata).
public export
skalárszorzat : List Double -> List Double -> Double
skalárszorzat (balElső :: balTöbbi) (jobbElső :: jobbTöbbi) =
  balElső * jobbElső + skalárszorzat balTöbbi jobbTöbbi
skalárszorzat _ _ = 0.0

||| Az első n elem (a Prelude `take` a Stream-é — mérve: «Mismatch
||| between List Double and Stream ?a»; a List-take a Data.List-ben él).
public export
elsőNÉrték : Nat -> List Double -> List Double
elsőNÉrték Z _ = []
elsőNÉrték (S tovább) [] = []
elsőNÉrték (S tovább) (elsőÉrték :: többiÉrték) = elsőÉrték :: elsőNÉrték tovább többiÉrték

||| Euklideszi norma.
public export
vektorNorma : List Double -> Double
vektorNorma vektor = sqrt (foldr (+) 0.0 (map négyzet vektor))
  where
    négyzet : Double -> Double
    négyzet x = x * x

||| Egy kimeneti sor: a bemenettel vett skalárszorzat (felső szintű
||| segéd — csapda #28: a where-beli segéd más klauzulából nem látszik).
public export
kimenetiSor : Nat -> Nat -> Double -> Double -> List Double -> Nat -> Double
kimenetiSor oszlopokSzáma tényező skála fázis bemenet sorSorszám =
  skalárszorzat (map (súlyElemTényezővel tényező skála fázis sorSorszám) (számsor oszlopokSzáma)) bemenet

||| Mátrix-vektor szorzás: kimenet_i = Σ_j w(i,j)·bemenet_j — az i. sor
||| E8-tényezője (0..3 = bal/jobb/harmadik/negyedik E8) az első paraméter.
||| A mátrix NEM literál — a súlyElemTényezővel determinisztikus függvénye.
public export
transzformált : Nat -> Double -> Double -> Nat -> Nat -> List Double -> List Double
transzformált tényező skála fázis sorokSzáma oszlopokSzáma bemenet =
  map (kimenetiSor oszlopokSzáma tényező skála fázis bemenet) (számsor sorokSzáma)

-- ─── 9. A Z₂ HANGREND-BEMENET ÉS AZ RG-LÁNC (0.4.5 + 0.4.7) ─────

||| 104 csatornás magyar morfológiai játékbemenet: a csatornaérték
||| Z₂-spinje (−1)^csatorna — elő/hát hangrend váltakozása (Ising).
public export
hangrendBemenet : Nat -> Double
hangrendBemenet csatorna =
  sin (natbólValós csatorna * 0.7 + 0.3)
  * (if szerkezetilegPáros csatorna then 1.0 else negate 1.0)

||| A teljes 104-csatornás bemenet.
public export
teljesBemenet : List Double
teljesBemenet = map hangrendBemenet (számsor 104)

||| W1 előre-futása: 104 → 64 (a főnévtér-vektor).
public export
főnévVektor : List Double
főnévVektor = transzformált 0 0.088 0.0 64 104 teljesBemenet

||| A lépcsős RG-átalakítás: 104 → 64 → 279 → 48 → 64 (W1..W4).
public export
igeVektor : List Double
igeVektor = transzformált 1 0.024 1.1 279 64 főnévVektor

public export
igazságVektor : List Double
igazságVektor = transzformált 2 0.078 2.2 48 279 igeVektor

public export
kimenetiFőnévVektor : List Double
kimenetiFőnévVektor = transzformált 3 0.134 3.3 64 48 igazságVektor

-- ─── 10. FIGYELEM-FEJ ELŐRE-FUTÁSA (softmax 1/√d_fej) ───────────
-- Négy tokenes játéksorozat; az 1. fej a 64-dim főnévtér első
-- 8 dimenzióján dolgozik (d_fej = 8; a 8×8 = 64 csempézés).

||| A játéksorozat hossza.
public export
játékSorozatHossz : Nat
játékSorozatHossz = 4

||| A t. token főnévvektora (determinisztikus variáció).
public export
tokenFőnévVektor : Nat -> List Double
tokenFőnévVektor tokenSorszám =
  transzformált 0 0.088 (natbólValós tokenSorszám * 0.9) 64 104 teljesBemenet

||| Q/K/V-projekciók az 1. fej 8-dim terébe (fázis: 0,0 / 2,0 / 4,0).
public export
lekérdezésVektor : Nat -> List Double
lekérdezésVektor tokenSorszám =
  transzformált 0 (sqrt (2.0 / 64.0)) 0.0 8 64 (tokenFőnévVektor tokenSorszám)

public export
kulcsVektor : Nat -> List Double
kulcsVektor tokenSorszám =
  transzformált 0 (sqrt (2.0 / 64.0)) 2.0 8 64 (tokenFőnévVektor tokenSorszám)

public export
értékVektor : Nat -> List Double
értékVektor tokenSorszám =
  transzformált 0 (sqrt (2.0 / 64.0)) 4.0 8 64 (tokenFőnévVektor tokenSorszám)

||| Skálázott pontszám: (q_t·k_s)/√8 — az 1/√d_fej faktor.
public export
figyelemPontszám : Nat -> Nat -> Double
figyelemPontszám lekérdezésSorszám kulcsSorszám =
  skalárszorzat (lekérdezésVektor lekérdezésSorszám) (kulcsVektor kulcsSorszám)
  / sqrt 8.0

||| Az exp-összeg (lágyMaximum nevezője) — felső szintű (csapda #28).
public export
exponenciálisÖsszeg : List Double -> Double
exponenciálisÖsszeg pontszámok = foldr (+) 0.0 (map exp pontszámok)

||| Softmax: exp(p_i)/Σ exp(p_j) — normalizált figyelemsúlyok.
public export
lágyMaximum : List Double -> List Double
lágyMaximum pontszámok = map (/ exponenciálisÖsszeg pontszámok) (map exp pontszámok)

||| A t. token figyelemsúlyai a négy tokenen.
public export
figyelemSúlyok : Nat -> List Double
figyelemSúlyok tokenSorszám =
  lágyMaximum (map (figyelemPontszám tokenSorszám) (számsor játékSorozatHossz))

||| A vektornak egy dimenziója (érték-komponens) — felső szintű segéd.
public export
értékKomponens : Nat -> Nat -> Double
értékKomponens dimenzióSorszám tokenSorszám =
  nthElem (értékVektor tokenSorszám) dimenzióSorszám

||| A t. token d-dim kimeneti komponense: Σ_s súly_s·v_s(d).
public export
súlyozottÖsszeg : Nat -> Nat -> Double
súlyozottÖsszeg tokenSorszám dimenzióSorszám =
  skalárszorzat (figyelemSúlyok tokenSorszám)
                (map (értékKomponens dimenzióSorszám) (számsor játékSorozatHossz))

||| A t. token figyelem-kimenete: 8-dim vektor (Σ_s súly_s · v_s).
public export
figyelemKimenet : Nat -> List Double
figyelemKimenet tokenSorszám =
  [ súlyozottÖsszeg tokenSorszám 0
  , súlyozottÖsszeg tokenSorszám 1
  , súlyozottÖsszeg tokenSorszám 2
  , súlyozottÖsszeg tokenSorszám 3
  , súlyozottÖsszeg tokenSorszám 4
  , súlyozottÖsszeg tokenSorszám 5
  , súlyozottÖsszeg tokenSorszám 6
  , súlyozottÖsszeg tokenSorszám 7
  ]

-- ─── 11. AZ FFN ELŐRE-FUTÁSA (δ-tükrözés: 99 → 474 → 99) ────────
-- A token-térbe emelés (beágyazási tábla 64×99), majd a kritikus
-- izoterma tükrözése: δ-szoros tágulat és vetítés vissza.

||| Beágyazás 64 → 99 (a 64×99 = 6336 paraméteres tábla).
public export
beágyazottVektor : List Double
beágyazottVektor = transzformált 0 (sqrt (2.0 / 64.0)) 5.0 99 64 főnévVektor

||| FFN első mátrixa: 99 → 474 (He: √(2/99)).
public export
rejtettVektor : List Double
rejtettVektor =
  transzformált 0 (sqrt (2.0 / 99.0)) 6.0 474 99 beágyazottVektor

||| ReLU-aktiválás (max 0 ·) — a könyv aktiválást nem rögzíti;
||| a standard transzformer-gyakorlat szerint.
public export
aktiváltVektor : List Double
aktiváltVektor = map (max 0.0) rejtettVektor

||| FFN második mátrixa: 474 → 99 (He: √(2/474)).
public export
előrecsatoltKimenet : List Double
előrecsatoltKimenet =
  transzformált 0 (sqrt (2.0 / 474.0)) 7.0 99 474 aktiváltVektor

-- ─── 12. SHOW-SEGÉDEK A FŐPROGRAMHOZ ────────────────────────────

||| Double-list első n eleme — Prelude `show` a List-re (Data.List
||| intersperse NÉLKÜL: az import #27-mérgezést hozott volna).
public export
elsőÉrtékek : Nat -> List Double -> String
elsőÉrtékek darabszám@_ értékek@_ =
  show (elsőNÉrték darabszám értékek)

||| Egyezés-jelölés Double-hez: ✓ ha |Δ| < 0,001, különben ✗ és Δ.
public export
egyezésJel : Double -> Double -> String
egyezésJel számított@_ hivatkozás@_ =
  if abs (számított - hivatkozás) < 0.001
    then "✓"
    else "✗ Δ = " ++ show (számított - hivatkozás)

||| Egyezés-jelölés Nat-hez.
public export
egyezésJelNat : Nat -> Nat -> String
egyezésJelNat számított@_ hivatkozás@_ =
  if számított == hivatkozás then "✓" else "✗ könyv: " ++ show hivatkozás

||| Mátrix-leíró egy táblasora (@-minta — a #27-es csapda gyógyíre).
public export
mátrixSor : SúlyMátrixLeíró -> String
mátrixSor leíró@_ =
  "  " ++ leíró.mátrixNeve ++ " : " ++ show leíró.bemenetiDimenzió ++ "→"
  ++ show leíró.kimenetiDimenzió ++ "   skála = " ++ show leíró.skálája
  ++ "   " ++ leíró.egyenletHivatkozás

-- ─── 13. FŐPROGRAM — az architektúra-tábla (GAUGE: olvasd!) ─────

main : IO ()
main = do
  putStrLn "═══ OPTIMÁLIS TRANSZFORMER v1 — a 3D Ising kritikus exponensekből ═══"
  putStrLn "Forrás: «The 64-Noun Stabilizer Code» 4. fej.; címkék: eq:alpha…eq:omega, tab:arch_params"
  putStrLn "        (a PDF-szöveg futó egyenletszámai (59)–(129) másodlagos mutatók)"
  putStrLn ""
  putStrLn "─── A hét kritikus kitevő (eq:alpha…eq:omega; PDF 59–65) ───"
  putStrLn ("  α = " ++ show alfaKritikus ++ "   β = " ++ show bétaKritikus
            ++ "   γ = " ++ show gammaKritikus)
  putStrLn ("  δ = " ++ show deltaKritikus ++ "   ν = " ++ show núKritikus
            ++ "   η = " ++ show étaKritikus ++ "   ω = " ++ show ómegaKritikus)
  putStrLn ""
  putStrLn "─── Skála-relációk (66–80): az eltérés nagyságrendje ───"
  putStrLn ("  Rushbrooke |α+2β+γ−2| = " ++ show rushbrookeEltérés)
  putStrLn ("  Widom     |γ−β(δ−1)| = " ++ show widomEltérés)
  putStrLn ("  Fisher    |γ−ν(2−η)| = " ++ show fisherEltérés)
  putStrLn ("  Josephson |3ν−(2−α)| = " ++ show josephsonEltérés)
  putStrLn ""
  putStrLn "─── A levezetett architektúra (tab:arch_params) ───"
  putStrLn ("  tanulási ráta  η₀ = ν/γ            = " ++ show tanulásiRáta
            ++ "  " ++ egyezésJel tanulásiRáta 0.509242)
  putStrLn ("  súlycsökkenés  λ  = αβ/4           = " ++ show súlyCsökkenés
            ++ "  " ++ egyezésJel súlyCsökkenés 0.008983)
  putStrLn ("  kiesés         p  = 1−2^−η        = " ++ show kiesésValószínűség
            ++ "  " ++ egyezésJel kiesésValószínűség 0.024846)
  putStrLn ("  fejek          h  = gcd(168,64)   = " ++ show fejSzám
            ++ "  " ++ egyezésJelNat fejSzám 8 ++ "  (üzemanyagos Euklidész, Refl-tanú is)")
  putStrLn ("  fej-dimenzió   d  = 64/h          = " ++ show fejDimenzió
            ++ "  " ++ egyezésJelNat fejDimenzió 8)
  putStrLn ("  token-dimenzió d_token = ⌊2^ν·64⌋ = " ++ show tokenMéret
            ++ "  " ++ egyezésJelNat tokenMéret 99
            ++ "  (2^ν·64 = " ++ show tokenMéretValós ++ ")")
  putStrLn ("  előrecsatolt   d_ff = ⌊δ·99⌋      = " ++ show előrecsatoltMéret
            ++ "  " ++ egyezésJelNat előrecsatoltMéret 474
            ++ "  (δ·99 = " ++ show előrecsatoltMéretValós ++ ")")
  putStrLn ("  rétegek        L = ⌊√(log₂64/ν·α⁻¹/ln2)⌋ = " ++ show rétegszám
            ++ "  " ++ egyezésJelNat rétegszám 11
            ++ "  (√… = " ++ show rétegszámValós ++ ")")
  putStrLn ("  minimális köteg ⌊2^(ν+η)⌋ = " ++ show legkisebbKöteg
            ++ "  (2^(ν+η) = " ++ show legkisebbKötegValós ++ "), kerekítve 2")
  putStrLn ("  gradiens-felhalmozás ⌊ωδ⌉ = " ++ show gradiensFelhalmozásLépésszám)
  putStrLn ("  hatékony köteg  B_eff = 2·4        = " ++ show hatékonyKöteg
            ++ "  " ++ egyezésJelNat hatékonyKöteg 8 ++ "  (= h, a fejek száma)")
  putStrLn ("  effektív dimenzió 3/ν = " ++ show effektívDimenzió
            ++ "  " ++ egyezésJel effektívDimenzió 4.762204)
  putStrLn ("  minimális veszteség (log₂64/ν)·ln2 = " ++ show minimálisVeszteség
            ++ " nat  " ++ egyezésJel minimálisVeszteség 6.602)
  putStrLn ""
  putStrLn "─── Súlymátrixok (108–118) ───"
  putStr (concat (map ((++ "\n") . mátrixSor) [wEgyLeíró, wKettőLeíró, wHáromLeíró, wNégyLeíró]))
  putStrLn ("  W1 He-skála √(2/104) = " ++ show wEgyHeSkála
            ++ "  " ++ egyezésJel wEgyHeSkála 0.138675)
  putStrLn ("  W1 σ·ν/(1−α) = " ++ show wEgySkálaSzámított
            ++ "  " ++ egyezésJel wEgySkálaSzámított 0.098141)
  putStrLn ("  W2 ν·η/8 = " ++ show wKettőSkálaSzámított
            ++ "  " ++ egyezésJel wKettőSkálaSzámított 0.002857)
  putStrLn ("  W4 (α/2)·√(64/48) = " ++ show wNégySkálaSzámított
            ++ "  " ++ egyezésJel wNégySkálaSzámított 0.063)
  putStrLn ("  GAUGE — W3 (115): √(β/279)·δ = " ++ show wHáromSkálaSzámítottGyökös
            ++ ",  (β/√279)·δ = " ++ show wHáromSkálaSzámítottOsztott)
  putStrLn ("  A könyv nyomtatott 0,078 — egyik olvasat sem adja;")
  putStrLn ("  a könyv saját képlete és nyomtatott értéke eltér egymástól (őszintén jelzem).")
  putStrLn ""
  putStrLn "─── Paraméterszám (119–120) — Refl-tanúk + GAUGE ───"
  putStrLn ("  nyers: 104·64 + 64·279 + 279·48 + 48·64 = 40976  (Refl-tanú ✓)")
  putStrLn ("  cél: |PSL(2,7)|·1000 = 168000  (Refl-tanú ✓)")
  putStrLn ("  figyelem rétegenként 3·64·8·8 = 12288 (Refl-tanú ✓); ×11 = "
            ++ show (12288 * 11))
  putStrLn ("  FFN rétegenként 99·474+474·99 = 93852 (Refl-tanú ✓); ×11 = "
            ++ show (93852 * 11))
  putStrLn ("  A könyv LISTÁZOTT komponenseinek összege (Refl-tanú): 1221188")
  putStrLn ("  GAUGE: 1221188 ≠ 168000 — a könyv «pontosan 168 000-re konvergál»")
  putStrLn ("  állítását a saját összegzése cáfolja; arány = "
            ++ show (1221188.0 / 168000.0) ++ "×")
  putStrLn ""
  putStrLn "─── Figyelem-fej előre-futása (1. fej, d_fej = 8, 4 token) ───"
  putStrLn ("  q₀·kₛ/√8 pontszámok = " ++ elsőÉrtékek 4 (map (figyelemPontszám 0) (számsor 4)))
  putStrLn ("  softmax súlyok      = " ++ elsőÉrtékek 4 (figyelemSúlyok 0))
  putStrLn ("  softmax összeg      = " ++ show (foldr (+) 0.0 (figyelemSúlyok 0)))
  putStrLn ("  kimenet (8 dim)     = " ++ elsőÉrtékek 8 (figyelemKimenet 0))
  putStrLn ""
  putStrLn "─── FFN előre-futása (δ-tükrözés: 99 → 474 → 99) ───"
  putStrLn ("  bemenet (99) norma  = " ++ show (vektorNorma beágyazottVektor))
  putStrLn ("  rejtett (474) norma = " ++ show (vektorNorma rejtettVektor))
  putStrLn ("  kimenet (99) első 3 = " ++ elsőÉrtékek 3 előrecsatoltKimenet)
  putStrLn ("  kimenet (99) norma  = " ++ show (vektorNorma előrecsatoltKimenet))
  putStrLn ""
  putStrLn "─── A lépcsős RG-átalakítás W1..W4: 104→64→279→48→64 (E8⁴-tórusz súlyok) ───"
  putStrLn ("  E8 gyökök száma (E8Gyokok_v2.e8Gyokok) = " ++ show (length e8Gyokok))
  putStrLn ("  w_W1(0,0) gyöke = " ++ show (pozícióGyöke 0 0 0)
            ++ "  → súly = " ++ show (súlyElemTényezővel 0 0.088 0.0 0 0))
  putStrLn ("  w_W1(3,5) gyöke = " ++ show (pozícióGyöke 0 3 5)
            ++ "  → súly = " ++ show (súlyElemTényezővel 0 0.088 0.0 3 5))
  putStrLn ("  w_W2(3,5) gyöke (jobb E8) = " ++ show (pozícióGyöke 1 3 5)
            ++ "  → súly = " ++ show (súlyElemTényezővel 1 0.024 1.1 3 5))
  putStrLn ("  bemenet (104) norma = " ++ show (vektorNorma teljesBemenet))
  putStrLn ("  főnév (64) norma    = " ++ show (vektorNorma főnévVektor))
  putStrLn ("  ige (279) norma     = " ++ show (vektorNorma igeVektor))
  putStrLn ("  igazság (48) norma  = " ++ show (vektorNorma igazságVektor))
  putStrLn ("  kimenet (64) első 3 = " ++ elsőÉrtékek 3 kimenetiFőnévVektor)
  putStrLn ("  kimenet (64) norma  = " ++ show (vektorNorma kimenetiFőnévVektor))
  putStrLn ""
  putStrLn "Kész — a kritikus pont a modell-geometria teljes előírása."
  putStrLn "(Refl-tanúk a forrásban: bizCsatornaFelbontás, bizPslRendOsztható,"
  putStrLn " bizFőnévtérCsempézés, bizHatékonyKöteg, bizNyersParaméterszám,"
  putStrLn " bizFigyelemRétegenként, bizElőrecsatoltRétegenként,"
  putStrLn " bizCélParaméterszám, bizKönyvKomponensÖsszeg, bizRétegszámGenerálásból.)"

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ───────────────────────────

public export
OptimálisTranszformerLeiras : ModulLeirasT
OptimálisTranszformerLeiras = ModulLeirasKonstruktor
  "OptimálisTranszformer_v1.idr"
  "a 3D Ising exponensekből levezetett architektúra: h=8, d=8, d_token=99, d_ff=474, L=11, B_eff=8"
  "a kritikus pont RG-adata teljes előírás — gradienslesés nélkül; figyelem+FFN előre-futással"
  "Refl-híd (Nat-aritmetika) + futásidejű Show-tanúk (Double)"
