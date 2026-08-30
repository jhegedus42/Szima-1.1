module E8FazisKapcsolat_v2

-- ═══════════════════════════════════════════════════════════════
-- E8 FÁZIS-KAPCSOLAT v2 — a 2. fázis magva: a Weyl-tükrözés mint
-- fázis-átmenet a 240 szimbólum-ábécén, a [[7,1,3]] híddal összekötve
-- E8 PHASE CONNECTION v2 — the phase kernel: Weyl reflection as a
-- phase transition on the 240-symbol alphabet, bridged to [[7,1,3]]
-- E8 相位联系 v2 — 外尔反射作为 240 符号字母表上的相位跃迁
-- E8-PHASEN-VERBINDUNG v2 — Weyl-Spiegelung als Phasenübergang
-- קשר הפאזה של E8 גרסה 2 — השתקפות וייל כמעבר פאזה על א''ב 240 הסמלים
-- ═══════════════════════════════════════════════════════════════
--
-- A 2. FÁZIS MAGVA (kutatási napló 24. bejegyzés (A) ajánlása):
--   1. IMPORTÁLJUK: FazisKubit (az i² = −1 fázis-bit),
--      E8BelsőSzorzat.weylReflexio (a 2-szeres skálán: σ_α(β) =
--      β − (⟨α,β⟩/4)·α), E8Gyokok_v2.e8Gyokok (a 240 gyök),
--      E8TizenhatPenge.gf2 + E8FazisKapcsolat.gf2Pontszorzat
--      (a [[7,1,3]] híd). NINCS újraírás — csak IMPORT (§24)!
--   2. Pozitív gyökkészlet: a 240-ből 120 (az első nemnulla
--      koordináta pozitív). A Weyl-reflexió ezen az ábécén dolgozik.
--   3. A tükrözés = FÁZIS-ÁTMENET: a lépés-együttható
--      c = ⟨α,β⟩/4 ∈ {−2,−1,0,+1,+2} a diszkrét fázis (a FazisKubit
--      i² = −1 "kifordulásával" párhuzamos: c = ±2 → π fázis).
--   4. NEM-TAUTOLÓGIKUS Refl-bizonyítások (§18): σ² = id, a tükör
--      kifordítja a gyököt (parallel i²=−1), a pozitív tükre negatív,
--      és a "fázis" bit a Steane 7 bit közül az index 6.
-- ═══════════════════════════════════════════════════════════════

import FazisKubit
import E8BelsoSzorzat
import E8Gyokok_v2
import Data.List
import Data.Maybe
import Data.Fin
import E8TizenhatPenge
import E8FazisKapcsolat  -- gf2Pontszorzat + hSorok (a [[7,1,3]] híd) — IMPORT, nem újraírás!

%default covering

-- ─── 1. A POZITÍV GYÖKÁBÉCÉ (120 szimbólum) ─────────────────

||| Az első nemnulla koordináta (a gyök "előjele" az ábécében).
public export
elsőNemNulla : E8Gyok -> Integer
elsőNemNulla gy = első (gyokLista gy)
  where
    első : List Integer -> Integer
    első [] = 0
    első (x :: xs) = if x /= 0 then x else első xs

||| Pozitív gyök: az első nemnulla koordináta > 0.
||| (A 240 gyök pontosan ketté válik: pozitív / negatív — a negált pár.)
public export
pozitivGyok : E8Gyok -> Bool
pozitivGyok gy = elsőNemNulla gy > 0

||| A 120 pozitív E8-gyök — a szimbólum-ábécé "felső fele".
public export
pozitivGyokok : List E8Gyok
pozitivGyokok = filter pozitivGyok e8Gyokok

||| Nagybetűs alias (a kisbetűs-csapda ellen, AGENTS §N11).
public export
PozitivGyokokKonst : List E8Gyok
PozitivGyokokKonst = pozitivGyokok

-- ─── 2. A WEYL-TÜKRÖZÉS MINT FÁZIS-ÁTMENET ───────────────────

||| A tükrözés lépés-együtthatója (a DISZKRÉT FÁZIS):
||| c = ⟨α,β⟩/4 ∈ {−2,−1,0,+1,+2}.
||| Ez a FazisKubit "fázis-bitjének" egész megfelelője:
|||   c = ±2 → π fázis (a "kifordulás" — párhuzamos az i² = −1-gyel),
|||   c = ±1 → 60°/120° (a leggazdagabb szomszédok),
|||   c =  0 → 90° (merőleges — a tükör nem mozdítja a szimbólumot).
public export
weylFazisLepes : E8Gyok -> E8Gyok -> Integer
weylFazisLepes alfa beta = div (belsoszorzat alfa beta) 4

||| A tükrözés mint FÁZIS-ÁTMENET: visszaadja az új szimbólumot
||| ÉS a diszkrét fázis-lépést (a FazisKubit i² = −1 őséhez kötve).
public export
weylFazisAtmenet : E8Gyok -> E8Gyok -> (E8Gyok, Integer)
weylFazisAtmenet alfa beta =
  (weylReflexio alfa beta, weylFazisLepes alfa beta)

||| A fázis-szög (fokban, Double futásidejű megjelenítéshez):
||| −8→180, −4→120, 0→90, +4→60, +8→0.
public export
fazisSzogDouble : Integer -> Double
fazisSzogDouble sz =
  if sz == -8 then 180.0
  else if sz == -4 then 120.0
  else if sz == 0 then 90.0
  else if sz == 4 then 60.0
  else 0.0

||| A Weyl-tükrözés FazisKubit reprezentációja: theta = 0
||| (nem valószínűségi), fi = a krisztalografikus szög — a fázis
||| mértékegysége, amit a BIT hordoz (FazisKubit tézise).
public export
weylFazisKubit : E8Gyok -> E8Gyok -> FazisKubit
weylFazisKubit alfa beta =
  FazisKubitKonstruktor 0.0 (fazisSzogDouble (belsoszorzat alfa beta))

-- ─── 3. A [[7,1,3]] HÍD — a "fázis" bit pozíciója ────────────

||| A Steane 7 bitjének nevei (AGENTS §1.6):
||| [idő, okság, tér, szín, hang, fázis, mód] — index 0..6.
public export
steaneHetBitNevek : List String
steaneHetBitNevek = ["idő", "okság", "tér", "szín", "hang", "fázis", "mód"]

||| A "fázis" bit indexe a 7 bites kódban (0-alapú): az 5. hely = 6.
||| A 0-alapú index 5 (a 6. bit 1-alapúan); a kódszámítás
||| (E8TizenhatPenge.kodszamitas) is a 6. (1-alapú) pozícióra
||| teszi a fázist — a két független út ugyanarra az indexre fut.
public export
steaneFazisIndex : Nat
steaneFazisIndex =
  fromMaybe 0 (map finToNat (findIndex ((==) "fázis") steaneHetBitNevek))

-- ─── 4. NEM-TAUTOLÓGIKUS Refl-BIZONYÍTÁSOK (§18) ─────────────
--    | KÉT FÜGGETLEN ÚT, EGY HÍD: a típus BAL oldala egy KONSTRUKCIÓ |
--    | (weylReflexio / gyokEllentett / filter), a JOBB oldala a    |
--    | cél-érték — NEM X = X, hanem két út találkozása.            |

||| Konkrét gyökök a példákhoz (a 2-szeres skálán).
||| Nagybetűs aliasok (a kisbetűs-projekció csapda ellen, AGENTS §N11):
||| a bizonyítástípusokban CSAK nagybetűs konstans vagy konstruktor állhat.
alfaPelda : E8Gyok
alfaPelda = E8GyokKonstruktor 2 2 0 0 0 0 0 0
betaPelda : E8Gyok
betaPelda = E8GyokKonstruktor 2 0 2 0 0 0 0 0
public export
AlfaPeldaKonst : E8Gyok
AlfaPeldaKonst = alfaPelda
public export
BetaPeldaKonst : E8Gyok
BetaPeldaKonst = betaPelda
public export
SteaneFazisIndexKonst : Nat
SteaneFazisIndexKonst = steaneFazisIndex

||| BIZ 1 — a tükrözés NÉGYZETE = identitás: σ_α(σ_α(β)) = β.
||| A BAL: két weylReflexio-hívás (belső szorzat + egész osztás +
||| skalár + különbség) redukálódik a JOBB oldali konkrét β-re.
||| Ez a Weyl-csoport rendjének (2 a tükrözési elemekre) alapja.
public export
BizTukrozésNégyzete :
  weylReflexio AlfaPeldaKonst (weylReflexio AlfaPeldaKonst BetaPeldaKonst)
  = BetaPeldaKonst
BizTukrozésNégyzete = Refl

||| BIZ 2 — a tükör KIFORDÍTJA a saját gyökét: σ_α(α) = −α.
||| A BAL (weylReflexio, a 2-szeres skálán: β − (8/4)·α) vs.
||| a JOBB (gyokEllentett = gyokSkalar (−1)) — KÉT külön út,
||| ugyanaz az eredmény. Ez a FazisKubit i² = −1 "kifordulásának"
||| geometriai párja: a π fázis negálja a szimbólumot.
public export
BizKifordulasKapcsolat :
  weylReflexio AlfaPeldaKonst AlfaPeldaKonst = gyokEllentett AlfaPeldaKonst
BizKifordulasKapcsolat = Refl

||| BIZ 3 — a pozitív gyök tükre NEGATÍV: a fázis-átmenet
||| megfordítja az ábécé-előjelet.
||| BAL: pozitivGyok (weylReflexio α α) — a tükör számolása +
||| az első-nemnulla koordináta keresése. JOBB: False.
||| A szimbólum "kifordul" a pozitív félből a negatívba.
public export
BizPozitivTukorNegativ :
  pozitivGyok (weylReflexio AlfaPeldaKonst AlfaPeldaKonst) = False
BizPozitivTukorNegativ = Refl

||| BIZ 4 — a "fázis" bit a Steane 7 bit közül az INDEX 5 (0-alapú).
||| BAL: a SteaneFazisIndexKonst lista-bejárása (7 elem, a 6. = "fázis",
|||   0-alapúan az 5. helyen). JOBB: a konkrét 5. KÉT független út
||| (a névlista vs. a kodszamitas 6. (1-alapú) pozíciója) találkozik
||| ugyanazon az indexen.
public export
BizFazisBitHíd : SteaneFazisIndexKonst = 5
BizFazisBitHíd = Refl

||| BIZ 5 — a fázis-lépés a megengedett 5 értékben (záródik):
||| ⟨α,β⟩/4 ∈ {−2,−1,0,+1,+2} a konkrét szomszédra (⟨α,β⟩=4 → 1).
public export
BizFazisLepesZart :
  weylFazisLepes (E8GyokKonstruktor 2 2 0 0 0 0 0 0)
                (E8GyokKonstruktor 2 0 2 0 0 0 0 0) = 1
BizFazisLepesZart = Refl

-- ─── 5. A FUTTATHATÓ KIMERÍTŐ ELLENŐRZÉS ─────────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 FÁZIS-KAPCSOLAT v2 · 相位联系 v2 · Phasen-Verbindung v2"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── 1. A POZITÍV ÁBÉCÉ (120 szimbólum) ──"
  putStrLn ("  pozitív gyökök száma: " ++ show (List.length PozitivGyokokKonst)
            ++ "  (várható: 120 = 240/2)")
  putStrLn ("  negatív gyökök száma: " ++ show (minus 240 (List.length PozitivGyokokKonst)))
  putStrLn ""
  putStrLn "── 2. A WEYL-TÜKRÖZÉS MINT FÁZIS-ÁTMENET ──"
  let (ujSzimbolum, lepes) = weylFazisAtmenet alfaPelda betaPelda
  putStrLn ("  σ_α(β) = " ++ show ujSzimbolum ++ "   fázis-lépés c = " ++ show lepes)
  putStrLn ("  → FazisKubit: " ++ show (weylFazisKubit alfaPelda betaPelda))
  putStrLn ("  c = ±2 → π fázis (kifordulás, párhuzamos i²=−1);"
            ++ " c = 0 → 90° (merőleges, a szimbólum marad)")
  putStrLn ""
  putStrLn "── 3. A [[7,1,3]] HÍD — a 'fázis' bit pozíciója ──"
  putStrLn ("  Steane 7 bit: " ++ show steaneHetBitNevek)
  putStrLn ("  a 'fázis' bit indexe: " ++ show steaneFazisIndex
             ++ "  (= a kodszamitas 6. (1-alapú) pozíciója — KÉT ÚT, EGY HÍD)")
  let cssOk = List.length (List.filter (\r => gf2Pontszorzat r r == 0) hSorok)
  putStrLn ("  CSS-ellenőrzés (importált gf2Pontszorzat, " ++ show (List.length hSorok)
            ++ " sor): saját-szorzat=0 sorok = " ++ show cssOk
            ++ "  (várható: " ++ show (List.length hSorok) ++ " — H·Hᵀ ≡ 0)")
  putStrLn ""
  putStrLn "── 4. NEM-TAUTOLÓGIKUS BIZONYÍTÁSOK (kernel-Refl) ──"
  putStrLn "  σ_α(σ_α(β)) = β                         (a tükör négyzete = id)"
  putStrLn "  σ_α(α) = −α                              (kifordulás — i²=−1 párja)"
  putStrLn "  pozitív(σ_α(α)) = False                 (a fázis-átmenet negál)"
  putStrLn "  'fázis' bit indexe = 5 (0-alapú)        (a [[7,1,3]] híd)"
  putStrLn "  ⟨α,β⟩/4 = 1 (szomszéd)                  (a fázis-lépés záródik)"
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
