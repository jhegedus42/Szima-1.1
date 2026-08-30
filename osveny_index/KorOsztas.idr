module KorOsztas

-- ═══════════════════════════════════════════════════════════════
-- KÖR OSZTÁSA ÉS A BÁJT = 8 BIT
-- ═══════════════════════════════════════════════════════════════
-- A kérdés: hány részre osztható a kör? És mi köze van a 8 bithez?
--
-- 1. GAUSS–WANTZEL: a szabályos N-szög szerkeszthető (körző + vonalzó)
--    ⇔ N = 2^k × p₁·p₂·…·pₘ, ahol pᵢ KÜLÖNBÖZŐ Fermat-prímek
--    (Fermat-prímek: 3, 5, 17, 257, 65537).
--    Szerkeszthető: 1,2,3,4,5,6,8,10,12,15,16,17,20,24…
--    NEM szerkeszthető: 7, 9, 11, 13, 14, 18, 19…
--    (360° = 2³·3²·5 — a 3² miatt a teljes 360-asztás NEM
--     szerkeszthető! A babilóniai 360 csak közelítés.)
--
-- 2. MIÉRT PONT 8? — HURWITZ + BOTT + CLIFFORD:
--    Hurwitz-tétel: normált osztóalgebra csak dim 1,2,4,8-ban létezik:
--      R(1) → C(2) → H(4) → O(8) — és itt VÉGE.
--      16-nál (sedenion) zero-divisor jelenik meg → információ VÉSZIK EL.
--    Bott-periodicitás: a szimmetriák 8-as periódussal ismétlődnek:
--      π_k = π_{k+8},  Cl(n+8) ≅ Cl(n) ⊗ R(16)
--    Cl(8) elemszáma = 2⁸ = 256 = pontosan EGY BÁJT.
--    E8: 240 gyök + 8 Cartan = 248 = 256 − 8 (a bájt "lyuka").
--
-- 3. A BÁJT = 8 BIT MERT:
--    Az információmegmaradás algebrája 8-periodikus.
--    E8Pont = 8 Kubit = 1 bájt. E8⁴ (ter/szín/hang/mod) = 4 bájt = 32 bit.
--    A Kereso minden mondatot bájtokba (= E8 rácspontokba) kódol.
--
-- 4. BACH: a körülírható ötödkör (12 ötöd ≈ 7 oktáv):
--    (3/2)¹² / 2⁷ = 3¹²/2¹⁹ = 531441/524288 ≈ 1.01364
--    = a PITAGORESZI KOMMA — a kör NEM záródik! Ugyanaz a δ-struktúra,
--    mint ϱ-nál (1 − Re(ϱ)π = 5.6×10⁻⁴). Bach korrekciója = a komma
--    elosztása 12 egyenlő részre = a wohltemperiert = a Bach-tag.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra
import ModulRegisztracio

-- ─── 1. FERMAT-PRÍMEK ──────────────────────────────────────

public export
fermatPrimek : List Integer
fermatPrimek = [3, 5, 17, 257, 65537]

-- ─── 2. GAUSS–WANTZEL SZERKESZTHETŐSÉG ─────────────────────

-- A 2-ozót lehántjuk (2^k tetszőleges kitevővel szerkeszthető)
public export
ketesLehantas : Integer -> Integer
ketesLehantas n =
  if (n `mod` 2) == 0
    then ketesLehantas (n `div` 2)
    else n

-- A maradékot Fermat-prímekre bontjuk: mindegyik LEGFELJEBB EGYSZER
-- szabad szerepelnie (különbözőek), különben NEM szerkeszthető.
public export
fermatBontas : Integer -> List Integer -> Bool
fermatBontas 1 _ = True
fermatBontas _ [] = False
fermatBontas n (p :: ps) =
  if (n `mod` p) == 0
    then if ((n `div` p) `mod` p) == 0
           then False
           else fermatBontas (n `div` p) ps
    else fermatBontas n ps

||| A szabályos N-szög szerkeszthető-e (Gauss–Wantzel).
public export
szerkesztheto : Integer -> Bool
szerkesztheto n = fermatBontas (ketesLehantas n) fermatPrimek

-- ─── 3. A 8 DIMENZIÓ CSODÁJA ───────────────────────────────

||| Cl(8) elemszáma = 2^8 = 256 = 1 bájt értéktere.
public export
cliffordNyolcElemszam : Nat
cliffordNyolcElemszam = 256

||| E8 dimenziója = 248 = 240 gyök + 8 Cartan = 256 − 8.
public export
e8Dimenzio : Nat
e8Dimenzio = 248

||| Az E8Pont = 8 Kubit = pontosan EGY BÁJT.
||| E8⁴ (ter/szín/hang/mod) = 4 bájt = 32 bit.
public export
e8pontBajtban : Nat
e8pontBajtban = 1

public export
e8negyBajtban : Nat
e8negyBajtban = 4

-- ─── 4. A PITAGORESZI KOMMA (a zenei δ) ────────────────────

||| 12 ötöd ≈ 7 oktáv — a kör NEM záródik:
||| (3/2)^12 / 2^7 = 3^12 / 2^19 = 531441/524288 ≈ 1.01364
public export
pitagoresziKomma : Double
pitagoresziKomma = 531441.0 / 524288.0

||| A komma centben (1 cent = 1/1200 oktáv)
public export
kommaCentben : Double
kommaCentben = 1200.0 * (log pitagoresziKomma / log 2.0)

||| A ϱ-rés (összehasonlításul): δ = 1 − Re(ϱ)·π
public export
roRes : Double
roRes = 1.0 - 0.31813150520476413531 * 3.141592653589793

-- ─── 5. FŐPROGRAM ──────────────────────────────────────────

public export
sorozatKiir : Integer -> Integer -> IO ()
sorozatKiir n hatar =
  if n > hatar then pure () else do
    let jelzes = if szerkesztheto n then "✓" else "✗"
    putStrLn ("  " ++ show n ++ " : " ++ jelzes)
    sorozatKiir (n + 1) hatar

public export
korOsztasFom : IO ()
korOsztasFom = do
  putStrLn "=== KOR OSZTASA ES A BAJT = 8 BIT ==="
  putStrLn ""
  putStrLn "1. GAUSS-WANTZEL: az N-szog szerkesztheto,"
  putStrLn "   ha N = 2^k x kulonbozo Fermat-primek (3,5,17,257,65537):"
  putStrLn "   N = 1..24:"
  sorozatKiir 1 24
  putStrLn "   (7, 9, 11, 13, 14, 18, 19, 22, 23 NEM szerkesztheto;"
  putStrLn "    12 = 2^2*3 SZERKESZTHETO — Bach 12-hangola!)"
  putStrLn "   360 = 2^3 * 3^2 * 5: a 3^2 miatt a teljes 360-osztas"
  putStrLn "   NEM szerkesztheto — a babilon 360 kozelites."
  putStrLn ""
  putStrLn "2. MIERT PONT 8? HURWITZ + BOTT + CLIFFORD:"
  putStrLn "   Hurwitz: normalt osztoalgebra csak dim 1,2,4,8-ban:"
  putStrLn "     R(1) -> C(2) -> H(4) -> O(8) — ITT VEGE."
  putStrLn "     16 (sedenion): zero-divisor -> informacio VESZIK EL."
  putStrLn "   Bott-periodicitas: a szimmetriak 8-as perioddal:"
  putStrLn "     pi_k = pi_{k+8},   Cl(n+8) = Cl(n) x R(16)"
  putStrLn ("   Cl(8) elemszama = 2^8 = " ++ show cliffordNyolcElemszam
            ++ " = pontosan EGY BAJT ertektere.")
  putStrLn ("   E8: 240 gyok + 8 Cartan = " ++ show e8Dimenzio
            ++ " = 256 - 8 (a bajt 'lyuka').")
  putStrLn ""
  putStrLn "3. A BAJT = 8 BIT MERT az informaciomegmaradas"
  putStrLn "   algebraja 8-periodikus. A projektben:"
  putStrLn ("   E8Pont = 8 Kubit = " ++ show e8pontBajtban ++ " bajt.")
  putStrLn ("   E8^4 (ter/szin/hang/mod) = " ++ show e8negyBajtban
            ++ " bajt = 32 bit.")
  putStrLn "   A Kereso minden mondatot bajtokba (= E8 racspontokba) kodol."
  putStrLn ""
  putStrLn "4. BACH: a korulirhato otdkor (12 otd ~ 7 oktav):"
  putStrLn ("   (3/2)^12 / 2^7 = 531441/524288 = " ++ show pitagoresziKomma)
  putStrLn ("   = a PITAGORESZI KOMMA = " ++ show kommaCentben ++ " cent")
  putStrLn "   A kor NEM zarodik — ugyanaz a delta-struktura, mint ronal:"
  putStrLn ("   ro-res: 1 - Re(ro)*pi = " ++ show roRes)
  putStrLn "   Bach korrekcioja = a komma elosztasa 12 reszre ="
  putStrLn "   a wohltemperiert = a Bach-tag = a delta elosztasa."
  putStrLn ""
  putStrLn "VEGSO: a kor osztasa 8 reszre (oktagon = 2^3) az utolso"
  putStrLn "osztas, ahol az informacio meg NEM veszik el —"
  putStrLn "ezert 1 bajt = 8 bit = E8Pont = a projekt alapegysege."
  putStrLn ""
  putStrLn "Kesz."

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
KorOsztasLeiras : ModulLeirasT
KorOsztasLeiras = ModulLeirasKonstruktor
  "KorOsztas.idr" "Gauss-Wantzel; komma=23,46 cent; bájt=8 (256)" "a konszonancia-prímek = Fermat-prímek" "Refl"
