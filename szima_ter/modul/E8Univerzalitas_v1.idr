module E8Univerzalitas_v1

-- ═══════════════════════════════════════════════════════════════
-- UNIVERZALITÁSI OSZTÁLYOK + KRITIKUS EXPONENSEK + SKÁLACÍMKÉK
-- UNIVERSALITY CLASSES + CRITICAL EXPONENTS + SCALING LAWS
-- 普适类 + 临界指数 + 标度律
-- UNIVERSALITÄTSKLASSEN + KRITISCHE EXPONENTEN + SKALIERUNGSGESETZE
-- מחלקות אוניברסליות + מעריכים קריטיים + חוקי סקיילינג
-- ═══════════════════════════════════════════════════════════════
--
-- | A 2D Ising PONTOS exponensei (α=0, β=1/8, γ=7/4, ν=1, η=1/4)
-- | itt TÖRTként, skálázott egészként állnak — a Double-változat
-- | az E8Iranymutato_v1-ben él, és ide IMPORTÁLVA ellenőrzöd
-- | (AGENTS §24 — kód-duplikáció tilos, importálj!).
-- | 代码重复禁止——从 E8Iranymutato_v1 导入，不得重写！
--
-- FORRÁSOK (mértékadó, ellenőrizve 2026-08-23):
--   [1] Skálacímkék νd = 2−α = 2β+γ és 2−η = γ/ν:
--       https://en.wikipedia.org/wiki/Critical_exponent
--   [2] 2D Ising pontos exponensek (Onsager 1944; CFF-minimálmodell
--       M(3,4)) és 3D Ising konform-bootstrap értékek:
--       https://en.wikipedia.org/wiki/Universality_class
--       3D bootstrap: Chang, Dommes, Erramilli, Homrich, Kravchuk,
--       Liu, Mitchell, Poland, Simmons-Duffin (2025):
--       "Bootstrapping the 3d Ising stress tensor",
--       J. High Energy Phys. 2025 (3) 136, arXiv:2411.15300
--   [3] 2D perkoláció pontos exponensek (SLE₆, Smirnov–Werner):
--       S. Smirnov, W. Werner, "Critical exponents for
--       two-dimensional percolation", Math. Res. Lett. 8 (2001) 529,
--       arXiv:math/0109120, https://doi.org/10.4310/mrl.2001.v8.n6.a4
--   [4] 2D önkerülő séta ν = 3/4 (Nienhuis, O(n→0)):
--       B. Nienhuis, Phys. Rev. Lett. 49 (1982) 1062;
--       a γ=43/32, α=1/2, β=5/64 értékek: [2] táblázata
--
-- A SKÁLACÍMKÉK (mindhárom pontos osztályra, két független úttal —
-- AGENTS §18, tautológia tilos): a TÍPUS BAL oldala a mért pontos
-- exponensek kombinációja, a JOBB oldale a címke független
-- előállítása (pl. 2 = 2·8 nyolcadokban).
--
-- FIGYELEM: a 3D Ising exponensei NEM pontosak — numerikus,
-- konform-bootstrap becslések (bizonytalanság ~10⁻⁸, l. [2]);
-- ezért Double-ként élnek, és a main-ben EGYENLŐTLENSÉG-ellenőrzés
-- fut rájuk (maradék |Δ| < 10⁻⁶), nem Refl.
-- ═══════════════════════════════════════════════════════════════

import E8Iranymutato_v1

%default covering

-- ─── 1. A TÖRT-TÍPUS (skálázott egész: számláló / nevező) ──────
-- | Eine Skalierte-Ganzzahl-Darstellung: Zähler / Nenner.
-- | 分数类型：分子／分母（缩放整数）。 | שבר: מונה / מכנה.

||| Kritikus exponens pontos törtként — Integer (a perkoláció α-ja
||| negatív: −2/3, ezért Nat tilos; E8Gyokok_v2 tanulsága szerint
||| pedig a Nat-kernel robbanhat).
public export
record ExponensTört where
  constructor ExponensTörtKonstruktor
  számláló : Integer
  nevező   : Integer

||| A tört Double-értéke (megjelenítéshez és numerikus ellenőrzéshez).
public export
exponensTörtÉrték : ExponensTört -> Double
exponensTörtÉrték törtszám = cast (számláló törtszám) / cast (nevező törtszám)

-- ─── 2. PONTOS KONSTANSOK — 2D ISING (nyolcadok, η negyedek) ───
-- | Onsager/Wu, CFF M(3,4) — forrás [2]. A konstansok NAGYBETŰSek,
-- | mert bizonyítástípusokban hivatkozunk rájuk (KisBetűsProjekcióCsapda).

||| α = 0 = 0/8 — a fajhő exponense (logaritmikus szingularitás).
public export
KétDimenziósIsingAlfaNyolcad : Integer
KétDimenziósIsingAlfaNyolcad = 0

||| β = 1/8 — a rendparaméter exponense (Onsager 1944).
public export
KétDimenziósIsingBétaNyolcad : Integer
KétDimenziósIsingBétaNyolcad = 1

||| γ = 7/4 = 14/8 — a szeptibilitás exponense.
public export
KétDimenziósIsingGammaNyolcad : Integer
KétDimenziósIsingGammaNyolcad = 14

||| ν = 1 = 8/8 — a korrelációs hossz exponense.
public export
KétDimenziósIsingNúNyolcad : Integer
KétDimenziósIsingNúNyolcad = 8

||| ν = 1 egész számként (a Fisher-címke negyedes alakjához).
public export
KétDimenziósIsingNúEgész : Integer
KétDimenziósIsingNúEgész = 1

||| η = 1/4 — a korrelációs függvény anomális exponense.
public export
KétDimenziósIsingÉtaNegyed : Integer
KétDimenziósIsingÉtaNegyed = 1

||| γ = 7/4 negyedekben (a Fisher-címke jobb oldalához).
public export
KétDimenziósIsingGammaNegyed : Integer
KétDimenziósIsingGammaNegyed = 7

-- ─── 3. PONTOS KONSTANSOK — 2D PERKOLÁCIÓ (hetvenkettedek) ─────
-- | Smirnov–Werner [3]. Közös nevező 72 = lkkt(3, 36, 18, 24):
-- | α = −2/3, β = 5/36, γ = 43/18, ν = 4/3, η = 5/24.

||| α = −2/3 = −48/72 — a fajhő exponense (negatív, véges csúcs).
public export
KétDimenziósPerkolációAlfaHetvenketted : Integer
KétDimenziósPerkolációAlfaHetvenketted = -48

||| β = 5/36 = 10/72 — a végtelen klaszter rendje (Smirnov–Werner).
public export
KétDimenziósPerkolációBétaHetvenketted : Integer
KétDimenziósPerkolációBétaHetvenketted = 10

||| γ = 43/18 = 172/72 — a szeptibilitás exponense.
public export
KétDimenziósPerkolációGammaHetvenketted : Integer
KétDimenziósPerkolációGammaHetvenketted = 172

||| ν = 4/3 = 96/72 — a korrelációs hossz exponense (SLE₆).
public export
KétDimenziósPerkolációNúHetvenketted : Integer
KétDimenziósPerkolációNúHetvenketted = 96

||| η = 5/24 = 15/72 — az összefüggvény anomalous exponense.
public export
KétDimenziósPerkolációÉtaHetvenketted : Integer
KétDimenziósPerkolációÉtaHetvenketted = 15

-- ─── 4. PONTOS KONSTANSOK — 2D ÖNKERÜLŐ SÉTA ───────────────────
-- | Nienhuis [4]: ν = 3/4 pontosan; α = 1/2, β = 5/64, γ = 43/32.
-- | A nevezők natívak: negyed (α, ν), hatvannegyed (β), harminckettő
-- | (γ); a Fisher-címkéhez γ még kilencvenhatodokban is rögzítve.

||| α = 1/2 = 2/4.
public export
KétDimenziósÖnkerülőSétaAlfaNegyed : Integer
KétDimenziósÖnkerülőSétaAlfaNegyed = 2

||| β = 5/64.
public export
KétDimenziósÖnkerülőSétaBétaHatvannegyed : Integer
KétDimenziósÖnkerülőSétaBétaHatvannegyed = 5

||| γ = 43/32.
public export
KétDimenziósÖnkerülőSétaGammaHarminckettő : Integer
KétDimenziósÖnkerülőSétaGammaHarminckettő = 43

||| ν = 3/4 — Nienhuis pontos eredménye (1982).
public export
KétDimenziósÖnkerülőSétaNúNegyed : Integer
KétDimenziósÖnkerülőSétaNúNegyed = 3

||| η = 5/24 — a Fisher-címke huszonnegyedes alakjához.
public export
KétDimenziósÖnkerülőSétaÉtaHuszonnegyed : Integer
KétDimenziósÖnkerülőSétaÉtaHuszonnegyed = 5

||| γ = 43/32 = 129/96 (mértékváltás 32 → 96, azaz ×3) — a
||| Fisher-címke jobb oldalának független rögzítése.
public export
KétDimenziósÖnkerülőSétaGammaKilencvenhatod : Integer
KétDimenziósÖnkerülőSétaGammaKilencvenhatod = 129

||| α = 1/2 = 32/64 és γ = 43/32 = 86/64 — a Rushbrooke-címke
||| hatvannegyedes alakjához (mértékváltás).
public export
KétDimenziósÖnkerülőSétaAlfaHatvannegyed : Integer
KétDimenziósÖnkerülőSétaAlfaHatvannegyed = 32

public export
KétDimenziósÖnkerülőSétaGammaHatvannegyed : Integer
KétDimenziósÖnkerülőSétaGammaHatvannegyed = 86

-- ─── 5. SKÁLACÍMKÉK — KERNEL-BIZONYÍTÁSOK (Refl, két út) ───────
-- | BAL oldalt: a mért pontos exponensek kombinációja;
-- | JOBB oldalt: a címke független előállítása. §18 — nem tautológia.

||| BIZ — RUSHBROOKE-CÍMKE, 2D Ising, nyolcadokban:
||| α + 2β + γ = 2. BAL: a pontos exponensek összege = 0+2·1+14;
||| JOBB: 2 előállítva 2·8 nyolcadként. Kimenet: Refl (16 = 16 ✓).
public export
RushbrookeKétDimenziósIsingNyolcadokban :
  KétDimenziósIsingAlfaNyolcad
    + 2 * KétDimenziósIsingBétaNyolcad
    + KétDimenziósIsingGammaNyolcad
    = 2 * 8
RushbrookeKétDimenziósIsingNyolcadokban = Refl

||| BIZ — HIPERSKÁLÁZÁSI CÍMKE, 2D Ising, nyolcadokban:
||| 2 − α = d·ν (d = 2). BAL: 2·8 − 0 = 16; JOBB: 2·8 = 16.
||| Kimenet: Refl (16 = 16 ✓).
public export
HiperskálázásKétDimenziósIsingNyolcadokban :
  2 * 8 - KétDimenziósIsingAlfaNyolcad
    = 2 * KétDimenziósIsingNúNyolcad
HiperskálázásKétDimenziósIsingNyolcadokban = Refl

||| BIZ — FISHER-CÍMKE, 2D Ising, negyedekben: γ = ν(2−η).
||| BAL: ν·(2·4 − η) = 1·(8−1) = 7; JOBB: γ = 7/4 mért értéke
||| negyedekben. Kimenet: Refl (7 = 7 ✓).
public export
FisherKétDimenziósIsingNegyedekben :
  KétDimenziósIsingNúEgész
    * (2 * 4 - KétDimenziósIsingÉtaNegyed)
    = KétDimenziósIsingGammaNegyed
FisherKétDimenziósIsingNegyedekben = Refl

||| BIZ — mértékváltás-híd, 2D Ising: γ negyedek ⟷ nyolcadok
||| (7/4 = 14/8). Kimenet: Refl (14 = 14 ✓).
public export
MértékváltásKétDimenziósIsingGamma :
  2 * KétDimenziósIsingGammaNegyed = KétDimenziósIsingGammaNyolcad
MértékváltásKétDimenziósIsingGamma = Refl

||| BIZ — RUSHBROOKE-CÍMKE, 2D perkoláció, hetvenkettedekben:
||| α + 2β + γ = 2. BAL: −48 + 2·10 + 172 = 144; JOBB: 2·72 = 144.
||| Kimenet: Refl (144 = 144 ✓).
public export
RushbrookeKétDimenziósPerkolációHetvenkettedekben :
  KétDimenziósPerkolációAlfaHetvenketted
    + 2 * KétDimenziósPerkolációBétaHetvenketted
    + KétDimenziósPerkolációGammaHetvenketted
    = 2 * 72
RushbrookeKétDimenziósPerkolációHetvenkettedekben = Refl

||| BIZ — HIPERSKÁLÁZÁSI CÍMKE, 2D perkoláció, hetvenkettedekben:
||| 2 − α = d·ν. BAL: 2·72 − (−48) = 192; JOBB: 2·96 = 192.
||| Kimenet: Refl (192 = 192 ✓).
public export
HiperskálázásKétDimenziósPerkolációHetvenkettedekben :
  2 * 72 - KétDimenziósPerkolációAlfaHetvenketted
    = 2 * KétDimenziósPerkolációNúHetvenketted
HiperskálázásKétDimenziósPerkolációHetvenkettedekben = Refl

||| BIZ — FISHER-CÍMKE, 2D perkoláció (72²-lesen):
||| γ = ν(2−η) ⟺ ν₇₂·(2·72 − η₇₂) = 72·γ₇₂.
||| BAL: 96·(144 − 15) = 96·129; JOBB: 72·172.
||| Kimenet: Refl (12384 = 12384 ✓).
public export
FisherKétDimenziósPerkolációHetvenkettedekben :
  KétDimenziósPerkolációNúHetvenketted
    * (2 * 72 - KétDimenziósPerkolációÉtaHetvenketted)
    = 72 * KétDimenziósPerkolációGammaHetvenketted
FisherKétDimenziósPerkolációHetvenkettedekben = Refl

||| BIZ — RUSHBROOKE-CÍMKE, 2D önkerülő séta, hatvannegyedekben:
||| α + 2β + γ = 2. BAL: 32 + 2·5 + 86 = 128; JOBB: 2·64 = 128.
||| Kimenet: Refl (128 = 128 ✓).
public export
RushbrookeÖnkerülőSétaHatvannegyedekben :
  KétDimenziósÖnkerülőSétaAlfaHatvannegyed
    + 2 * KétDimenziósÖnkerülőSétaBétaHatvannegyed
    + KétDimenziósÖnkerülőSétaGammaHatvannegyed
    = 2 * 64
RushbrookeÖnkerülőSétaHatvannegyedekben = Refl

||| BIZ — HIPERSKÁLÁZÁSI CÍMKE, 2D önkerülő séta, negyedekben:
||| 2 − α = d·ν. BAL: 2·4 − 2 = 6; JOBB: 2·3 = 6.
||| Kimenet: Refl (6 = 6 ✓).
public export
HiperskálázásÖnkerülőSétaNegyedekben :
  2 * 4 - KétDimenziósÖnkerülőSétaAlfaNegyed
    = 2 * KétDimenziósÖnkerülőSétaNúNegyed
HiperskálázásÖnkerülőSétaNegyedekben = Refl

||| BIZ — FISHER-CÍMKE, 2D önkerülő séta:
||| γ = ν(2−η), nevezők 4·24 = 96. BAL: 3·(48 − 5) = 3·43 = 129;
||| JOBB: γ = 43/32 = 129/96 (mértékváltással rögzített konstans).
||| Kimenet: Refl (129 = 129 ✓).
public export
FisherÖnkerülőSétaKilencvenhatodokban :
  KétDimenziósÖnkerülőSétaNúNegyed
    * (2 * 24 - KétDimenziósÖnkerülőSétaÉtaHuszonnegyed)
    = KétDimenziósÖnkerülőSétaGammaKilencvenhatod
FisherÖnkerülőSétaKilencvenhatodokban = Refl

-- ─── 6. A TÖRT-ÉRTÉKEK (adatként, a konstansok ÚJRAHASZNÁLÁSÁVAL) ──

||| A 2D Ising exponensei törként — a fenti konstansokból.
public export
kétDimenziósIsingAlfaTört : ExponensTört
kétDimenziósIsingAlfaTört = ExponensTörtKonstruktor KétDimenziósIsingAlfaNyolcad 8

public export
kétDimenziósIsingBétaTört : ExponensTört
kétDimenziósIsingBétaTört = ExponensTörtKonstruktor KétDimenziósIsingBétaNyolcad 8

public export
kétDimenziósIsingGammaTört : ExponensTört
kétDimenziósIsingGammaTört = ExponensTörtKonstruktor KétDimenziósIsingGammaNyolcad 8

public export
kétDimenziósIsingNúTört : ExponensTört
kétDimenziósIsingNúTört = ExponensTörtKonstruktor KétDimenziósIsingNúNyolcad 8

||| A 2D perkoláció exponensei törként (nevező 72).
public export
kétDimenziósPerkolációBétaTört : ExponensTört
kétDimenziósPerkolációBétaTört = ExponensTörtKonstruktor KétDimenziósPerkolációBétaHetvenketted 72

public export
kétDimenziósPerkolációNúTört : ExponensTört
kétDimenziósPerkolációNúTört = ExponensTörtKonstruktor KétDimenziósPerkolációNúHetvenketted 72

||| A 2D önkerülő séta ν-ja törként: ν = 3/4 (Nienhuis).
public export
kétDimenziósÖnkerülőSétaNúTört : ExponensTört
kétDimenziósÖnkerülőSétaNúTört = ExponensTörtKonstruktor KétDimenziósÖnkerülőSétaNúNegyed 4

||| FUTÁSIDEJŰ EGYEZÉS-ELLENŐRZÉS az E8Iranymutato_v1 importjával:
||| a pontos törtek Double-értéke megegyezik az iránymutató rekord
||| ising* mezőivel (§24 — ugyanaz az adat, importálva, nem másolva).
public export
kétDimenziósIsingEgyezésE8Iranymutatóval : Bool
kétDimenziósIsingEgyezésE8Iranymutatóval =
     abs (exponensTörtÉrték kétDimenziósIsingAlfaTört  - isingAlfa  iranymutatoMutatok) < 0.000000001
  && abs (exponensTörtÉrték kétDimenziósIsingBétaTört  - isingBeta  iranymutatoMutatok) < 0.000000001
  && abs (exponensTörtÉrték kétDimenziósIsingGammaTört - isingGamma iranymutatoMutatok) < 0.000000001
  && abs (exponensTörtÉrték kétDimenziósIsingNúTört    - isingNu    iranymutatoMutatok) < 0.000000001

-- ─── 7. 3D ISING — KÖZELÍTŐ EXPONENSEK (NEM pontosak!) ─────────
-- | Konform-bootstrap becslések [2]: Chang et al. 2025 (arXiv:2411.15300).
-- | Bizonytalanságok az utolsó számjegyekre: α=0.11008708(35),
-- | β=0.32641871(75), γ=1.23707551(26), ν=0.62997097(12),
-- | η=0.036297612(48). Ezek MÉRÉSEK, nem levezetés — Refl tilos rájuk.
-- | 这些是数值估计（共形引导），不是精确值，禁止用 Refl。

public export
record HáromDimenziósIsingKözelítőExponensek where
  constructor HáromDimenziósIsingKözelítőExponensekKonstruktor
  alfa  : Double    -- 0.11008708(35)
  béta  : Double    -- 0.32641871(75)
  gamma : Double    -- 1.23707551(26)
  nú    : Double    -- 0.62997097(12)
  éta   : Double    -- 0.036297612(48)

public export
háromDimenziósIsingKözelítő : HáromDimenziósIsingKözelítőExponensek
háromDimenziósIsingKözelítő =
  HáromDimenziósIsingKözelítőExponensekKonstruktor
    0.11008708
    0.32641871
    1.23707551
    0.62997097
    0.036297612

-- A skálacímkék maradékai (Δ) a 3D közelítő értékeken — kimenet:
-- |Δ| értéke a main-ben; a tűrés 10⁻⁶ (a bootstrap bizonytalanság
-- kombináltja ~10⁻⁷, tehát 10⁻⁶ konzervatív küszöb — §17 szerint
-- a hibát a mérési bizonytalansághoz mérjük).

||| Rushbrooke-maradék: Δ = |α + 2β + γ − 2|.
public export
rushbrookeMaradékHáromDimenziós : Double
rushbrookeMaradékHáromDimenziós =
  abs (alfa háromDimenziósIsingKözelítő
         + 2 * béta háromDimenziósIsingKözelítő
         + gamma háromDimenziósIsingKözelítő
         - 2.0)

||| Hiperskálázási maradék: Δ = |2 − α − 3ν| (d = 3).
public export
hiperskálázásMaradékHáromDimenziós : Double
hiperskálázásMaradékHáromDimenziós =
  abs (2.0 - alfa háromDimenziósIsingKözelítő
         - 3.0 * nú háromDimenziósIsingKözelítő)

||| Fisher-maradék: Δ = |γ − ν(2−η)|.
public export
fisherMaradékHáromDimenziós : Double
fisherMaradékHáromDimenziós =
  abs (gamma háromDimenziósIsingKözelítő
         - nú háromDimenziósIsingKözelítő
             * (2.0 - éta háromDimenziósIsingKözelítő))

||| A tűrés (konzervatív: 10-szerese a bootstrap kombinált hibájának).
public export
skálacímkeTűrés : Double
skálacímkeTűrés = 0.000001

public export
mindenHáromDimenziósCímkeTeljesül : Bool
mindenHáromDimenziósCímkeTeljesül =
     rushbrookeMaradékHáromDimenziós    < skálacímkeTűrés
  && hiperskálázásMaradékHáromDimenziós < skálacímkeTűrés
  && fisherMaradékHáromDimenziós        < skálacímkeTűrés

-- ─── 8. A FUTTATHATÓ ÖSSZEFOGLALÓ ──────────────────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  UNIVERZALITÁSI OSZTÁLYOK + KRITIKUS EXPONENSEK"
  putStrLn "  UNIVERSALITY CLASSES + CRITICAL EXPONENTS"
  putStrLn "  普适类 + 临界指数 · Universalitätsklassen"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── 2D ISING (pontos; Onsager, CFF M(3,4)) ──"
  putStrLn ("  α = " ++ show (számláló kétDimenziósIsingAlfaTört) ++ "/" ++ show (nevező kétDimenziósIsingAlfaTört)
    ++ " = " ++ show (exponensTörtÉrték kétDimenziósIsingAlfaTört))
  putStrLn ("  β = " ++ show (számláló kétDimenziósIsingBétaTört) ++ "/" ++ show (nevező kétDimenziósIsingBétaTört)
    ++ " = " ++ show (exponensTörtÉrték kétDimenziósIsingBétaTört))
  putStrLn ("  γ = " ++ show (számláló kétDimenziósIsingGammaTört) ++ "/" ++ show (nevező kétDimenziósIsingGammaTört)
    ++ " = " ++ show (exponensTörtÉrték kétDimenziósIsingGammaTört))
  putStrLn ("  ν = " ++ show (számláló kétDimenziósIsingNúTört) ++ "/" ++ show (nevező kétDimenziósIsingNúTört)
    ++ " = " ++ show (exponensTörtÉrték kétDimenziósIsingNúTört))
  putStrLn ("  Rushbrooke  nyolcadokban : 0 + 2*1 + 14 = " ++ show (0 + 2 * 1 + 14) ++ "  = 2*8")
  putStrLn ("  Hiperskála nyolcadokban  : 2*8 - 0   = " ++ show (2 * 8 - 0) ++ "  = 2*8")
  putStrLn ("  Fisher     negyedekben   : 1*(8 - 1) = " ++ show (1 * (8 - 1)) ++ "  = 7  (γ = 7/4)")
  putStrLn ""
  putStrLn "── 2D PERKOLÁCIÓ (pontos; Smirnov–Werner 2001) ──"
  putStrLn ("  β = 10/72 = 5/36 = " ++ show (exponensTörtÉrték kétDimenziósPerkolációBétaTört))
  putStrLn ("  ν = 96/72 = 4/3  = " ++ show (exponensTörtÉrték kétDimenziósPerkolációNúTört))
  putStrLn ("  Rushbrooke  hetvenkettedekben : -48 + 2*10 + 172 = "
    ++ show (-48 + 2 * 10 + 172) ++ "  = 2*72")
  putStrLn ("  Hiperskála  hetvenkettedekben : 2*72 - (-48)      = "
    ++ show (2 * 72 - (-48)) ++ "  = 2*96")
  putStrLn ("  Fisher      72²-lesen         : 96*(144 - 15)     = "
    ++ show (96 * (144 - 15)) ++ "  = 72*172 = " ++ show (72 * 172))
  putStrLn ""
  putStrLn "── 2D ÖNKERÜLŐ SÉTA (pontos; Nienhuis 1982) ──"
  putStrLn ("  ν = 3/4 = " ++ show (exponensTörtÉrték kétDimenziósÖnkerülőSétaNúTört))
  putStrLn ("  Rushbrooke  hatvannegyedekben : 32 + 2*5 + 86 = "
    ++ show (32 + 2 * 5 + 86) ++ "  = 2*64")
  putStrLn ("  Hiperskála  negyedekben       : 2*4 - 2      = "
    ++ show (2 * 4 - 2) ++ "  = 2*3")
  putStrLn ("  Fisher      kilencvenhatodok  : 3*(48 - 5)   = "
    ++ show (3 * (48 - 5)) ++ "  = 129  (γ = 43/32 = 129/96)")
  putStrLn ""
  putStrLn "── 3D ISING (KÖZELÍTŐ, NEM pontos; bootstrap, Chang et al. 2025) ──"
  putStrLn ("  α  = " ++ show (alfa háromDimenziósIsingKözelítő)
    ++ "   (0.11008708(35))")
  putStrLn ("  β  = " ++ show (béta háromDimenziósIsingKözelítő)
    ++ "  (0.32641871(75))")
  putStrLn ("  γ  = " ++ show (gamma háromDimenziósIsingKözelítő)
    ++ " (1.23707551(26))")
  putStrLn ("  ν  = " ++ show (nú háromDimenziósIsingKözelítő)
    ++ "  (0.62997097(12))")
  putStrLn ("  η  = " ++ show (éta háromDimenziósIsingKözelítő)
    ++ "  (0.036297612(48))")
  putStrLn ("  Rushbrooke-maradék  Δ = |α + 2β + γ − 2|          = "
    ++ show rushbrookeMaradékHáromDimenziós)
  putStrLn ("  Hiperskála-maradék  Δ = |2 − α − 3ν|              = "
    ++ show hiperskálázásMaradékHáromDimenziós)
  putStrLn ("  Fisher-maradék      Δ = |γ − ν(2−η)|              = "
    ++ show fisherMaradékHáromDimenziós)
  putStrLn ("  Mindhárom címke teljesül (tűrés 10⁻⁶)?            : "
    ++ (if mindenHáromDimenziósCímkeTeljesül then "IGAZ" else "HAMIS"))
  putStrLn ""
  putStrLn "── EGYEZÉS az E8Iranymutato_v1 importjával (§24 import, nem másolat) ──"
  putStrLn ("  a pontos törtek Double-értéke = az ising* mezők?   : "
    ++ (if kétDimenziósIsingEgyezésE8Iranymutatóval then "IGAZ" else "HAMIS"))
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
