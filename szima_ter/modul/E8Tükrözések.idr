module E8Tükrözések

-- ═══════════════════════════════════════════════════════════════
-- E8 TÜKRÖZÉSEK — a Weyl-tükrözések mint FÁZIS-ÁTMENETEK
-- a 120 pozitív gyökön; az egyszerű gyökök EMERGENCIÁJA
-- E8 REFLECTIONS — Weyl reflections as PHASE TRANSITIONS on the
-- 120 positive roots; the emergence of the simple roots
-- E8 镜射——外尔镜射作为 120 个正根上的相变；单根的涌现
-- ═══════════════════════════════════════════════════════════════
--
-- A (C) FÁZIS (a kutatási napló 24. bejegyzése): a 2. fázis szíve.
--
-- A MATEMATIKA (2-szeres skálán, norma² = 8):
--   1. POZITÍV GYÖKÖK: a 240 gyök 120 ±-pár; a lexikografikus választás
--      (az első nemnulla koordináta pozitív) kettévágja: 56 (típus-1)
--      + 64 (típus-2) = 120 pozitív.
--   2. A TÜKRÖZÉS MINT FÁZIS-ÁTMENET: σ_α a pozitívak egy RÉSZÉT
--      negatívba fordítja (α-string); a többi pozitív marad. A
--      "fázisfordítás" száma = hány pozitív kap π-t (α → −α = e^{iπ}α).
--   3. AZ EGYSZERŰ GYÖKÖK EMERGENCIÁJA: azok a gyökök, amelyek
--      tükrözése PONTOSAN EGY pozitívat fordít (önmagát!), az egyszerű
--      gyökök — a mérésből születnek, nem a Bourbaki-táblából.
--      Elvárt: pontosan 8 darab (a rang).
--   4. A CARTAN-MÁTRIX (a 8 egyszerű gyökből, C_ij = ⟨αi,αj⟩/4):
--      simán-gerezdázott (off-diag ∈ {0,−1}), élek száma 7 (fa),
--      det(C) = 1 — az E8 rács UNIMODULARITÁSÁNAK aláírása.
--   5. A FAZISKUBIT-HÍD (FazisKubit.idr): i² = −1 a "kifordulás"
--      (kernel-Refl!); a gyök-ellentett = e^{iπ}-szorzás; az egyszerű
--      tükrözések = a fázis generátorai (a minimális fáziskvantum π).
--      A NAGY SEJTÉS (SPECULATÍV, §18.4): a fázist az E8 kvantálja.
--
-- A KETTŐS FEDEZÉS (§18): (a) kernel-Refl aritmetikai + példa-
-- bizonyítások; (b) futásidejű KIMERÍTŐ mérés (240 tükrözés ×
-- 120 pozitív = 28 800 fázis-átmenet); (c) irodalom: Humphreys,
-- Introduction to Lie Algebras and Representation Theory (a pozitív
-- gyökök / egyszerű gyökök / magasság fejezet), Bourbaki, Planche VII.
-- ═══════════════════════════════════════════════════════════════

import E8Gyökök
import E8BelsőSzorzat
import FazisKubit
import Data.List  -- minimum/maximum (§24: standard, Maybe-vel)
import Data.Nat

%default covering

-- ─── 1. A POZITÍV GYÖKÖK (lexikografikus kamara) ────────────

||| A lex-pozitivitás: az első nemnulla koordináta pozitív.
||| A 240 gyök e szerint 120 pozitívra és 120 negatívra bomlik.
public export
pozitívE : E8Gyök -> Bool
pozitívE gy = elsőNemNullaPozitív (gyökLista gy)
  where
    elsőNemNullaPozitív : List Integer -> Bool
    elsőNemNullaPozitív [] = True
    elsőNemNullaPozitív (x :: xs) =
      if x > 0 then True
      else if x < 0 then False
      else elsőNemNullaPozitív xs

||| A 120 pozitív gyök (a lexikografikus kamara zárta).
public export
pozitívGyökök : List E8Gyök
pozitívGyökök = filter pozitívE e8Gyökök

||| A típus-1 pozitívok (56) és típus-2 pozitívok (64).
public export
típus1Pozitívak : List E8Gyök
típus1Pozitívak = filter pozitívE típus1Gyökök

public export
típus2Pozitívak : List E8Gyök
típus2Pozitívak = filter pozitívE típus2Gyökök

-- ─── 2. A TÜKRÖZÉS MINT FÁZIS-ÁTMENET ───────────────────────

||| A Weyl-TÜKRÖZÉS (a szókincs szerint tükrözés, nem reflexió —
||| MagyarMatematikaiSzókincs; §24: IMPORT-alias, nem újraírás).
public export
weylTükrözés : E8Gyök -> E8Gyök -> E8Gyök
weylTükrözés = weylReflexió

||| Az α-tükrözés FÁZISFORDÍTÁSAINAK száma: hány pozitív gyök
||| negatívba fordul (π-fázist kap) σ_α hatására.
||| A minimális érték = 1 (az egyszerű gyökök jele).
public export
fázisFordításokSzáma : E8Gyök -> Nat
fázisFordításokSzáma alfa =
  length (filter not
    [ pozitívE (weylTükrözés alfa béta) | béta <- pozitívGyökök ])

-- ─── 3. AZ EGYSZERŰ GYÖKÖK EMERGENCIÁJA ─────────────────────

||| Az egyszerű gyökök: amelyek tükrözése PONTOSAN EGY pozitívat
||| fordít (önmagát) — a kamara falai. Elvárt: pontosan 8 darab.
public export
egyszerűGyökök : List E8Gyök
egyszerűGyökök = filter (\alfa => fázisFordításokSzáma alfa == 1) e8Gyökök

public export
egyszerűDarab : Nat
egyszerűDarab = length egyszerűGyökök

||| Az egyszerű tükrözések darabszáma = a rang (elvárt 8).
public export
flipEgyDarab : Nat
flipEgyDarab = length (filter (\alfa => fázisFordításokSzáma alfa == 1) e8Gyökök)

||| A legkisebb és legnagyobb fázisfordítás-szám (a 240 tükrözésen).
||| (Saját segéd: a Data.List `minimum` ezen az Idris-verzión Num-
||| constraint-ütközést ad — PróbaMinMax2 izolálta; ez nem Prelude-
||| duplikátum, hanem használható helyettes.)
public export
legkisebbSzám : List Nat -> Maybe Nat
legkisebbSzám =
  foldr (\x, acc => Just (maybe x (\a => if x < a then x else a) acc)) Nothing

public export
legnagyobbSzám : List Nat -> Maybe Nat
legnagyobbSzám =
  foldr (\x, acc => Just (maybe x (\a => if x > a then x else a) acc)) Nothing

public export
legkisebbFlip : Maybe Nat
legkisebbFlip = legkisebbSzám (map fázisFordításokSzáma e8Gyökök)

public export
legnagyobbFlip : Maybe Nat
legnagyobbFlip = legnagyobbSzám (map fázisFordításokSzáma e8Gyökök)

-- ─── 4. A CARTAN-MÁTRIX (az egyszerű gyökökből) ─────────────

||| A Cartan-mátrix egység-skálán: C_ij = ⟨αi,αj⟩/4 (a 2-szeres
||| belső szorzat 4-szerese az egységnyinek). Diag = 2, off = 0/−1.
public export
cartanMátrix : List (List Integer)
cartanMátrix =
  [ [ div (belsőSzorzat ai aj) 4 | aj <- egyszerűGyökök ]
  | ai <- egyszerűGyökök ]

||| A Dynkin-élek száma: a −1-es bejegyzések fele (szimmetria).
||| Elvárt: 7 (a 8 csúcsú fa).
public export
élekSzáma : Integer
élekSzáma =
  let darab = length (filter (== the Integer (-1)) (concat cartanMátrix))
  in div (cast darab) 2

||| A determináns (Laplace-kifejtés, Integer-aritmetika — pontos).
||| A Cartan det = 1 ↔ az E8 rács unimoduláris (240 ön-dualitás).
public export
determináns : List (List Integer) -> Integer
determináns [] = 1
determináns (sor :: többi) = sorKifejtés sor 0 többi
  where
    sorKifejtés : List Integer -> Nat -> List (List Integer) -> Integer
    sorKifejtés [] _ _ = 0
    sorKifejtés (x :: xs) j alsó =
      x * előjel j * determináns (oszlopotKihagy j alsó)
        + sorKifejtés xs (S j) alsó
    előjel : Nat -> Integer
    előjel n = if párosNat n then 1 else -1
    oszlopotKihagy : Nat -> List (List Integer) -> List (List Integer)
    oszlopotKihagy _ [] = []
    oszlopotKihagy j (s :: ss) = oszlopKihagySor j s :: oszlopotKihagy j ss
    oszlopKihagySor : Nat -> List Integer -> List Integer
    oszlopKihagySor _ [] = []
    oszlopKihagySor Z (_ :: ys) = ys
    oszlopKihagySor (S k) (y :: ys) = y :: oszlopKihagySor k ys

public export
cartanDetermináns : Integer
cartanDetermináns = determináns cartanMátrix

-- ─── 5. KERNEL-BIZONYÍTÁSOK (Refl) ─────────────────────────

||| Nagybetűs aliasok (a típusokhoz — KisBetűsProjekcióCsapda).
public export
EgyszerűDarabKonst : Nat
EgyszerűDarabKonst = egyszerűDarab

public export
Típus1PozitívDarabKonst : Nat
Típus1PozitívDarabKonst = length típus1Pozitívak

public export
Típus2PozitívDarabKonst : Nat
Típus2PozitívDarabKonst = length típus2Pozitívak

||| BIZ — a pozitívok száma: 56 + 64 = 120 (a típusok fele-fele).
public export
BizPozitívSzázhúsz : 56 + 64 = 120
BizPozitívSzázhúsz = Refl

||| BIZ — a típus-1 fele pozitív: 56 + 56 = 112.
public export
BizTípus1Fele : 56 + 56 = 112
BizTípus1Fele = Refl

||| BIZ — példa pozitívra: (2,−2,0⁶) az első nemnulla pozitív.
public export
BizPéldaPozitív :
  pozitívE (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0) = True
BizPéldaPozitív = Refl

||| BIZ — példa negatívra: (−2,2,0⁶).
public export
BizPéldaNegatív :
  pozitívE (E8GyökKonstruktor (-2) 2 0 0 0 0 0 0) = False
BizPéldaNegatív = Refl

||| BIZ — a tükrözés önmagára: σ_α(α) = −α (a π-fázis kvantuma;
||| a FazisKubit bizIKet-jével: i² = −1 — a kifordulás).
public export
BizTükrözésEllentett :
  weylTükrözés (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)
               (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)
  = E8GyökKonstruktor (-2) 2 0 0 0 0 0 0
BizTükrözésEllentett = Refl

||| BIZ — a Laplace-determináns az A2 Cartanon: det[[2,−1],[−1,2]] = 3
||| (a hatszög-rács indexe 3 — kontraszt az E8 det = 1-gyel).
public export
BizLaplaceA2 : determináns [[the Integer 2, -1], [-1, 2]] = 3
BizLaplaceA2 = Refl

||| BIZ — a 2π visszafordul: a tükrözés kétszer = identitás (α-ra).
||| (σ∘σ)(α) = α — az i⁴ = +1 gyök-oldali társa.
public export
BizTükrözésNégyzet :
  weylTükrözés (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)
               (weylTükrözés (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0)
                             (E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0))
  = E8GyökKonstruktor 2 (-2) 0 0 0 0 0 0
BizTükrözésNégyzet = Refl

-- ─── 6. A GONDOLATOK (részben SPECULATÍV — §18.4) ──────────

public export
tükrözésGondolatok : String
tükrözésGondolatok =
  "A 240 gyok 120 pozitivra es 120 negativra bomlik (lex-kamara). " ++
  "Minden Weyl-tukrozes FAZIS-ATMENET: a pozitivak egy reszet pi-vel " ++
  "forditja (a -> -a = e^{i*pi}*a — a FazisKubit i^2 = -1 je, a " ++
  "kifordulas). Az EGYSZERU gyokok EMERGALNAK: amely tukrozes " ++
  "pontosan EGY pozitivat fordit, az egyszeru gyok — 8 darab, a " ++
  "rang. Cartan: el = 7 (fa), det = 1 (unimodularis racs). A NAGY " ++
  "SEJTES (SPECULATIV): a fazist az E8 kvantalja — az egyszeru " ++
  "tukrozesek a fazis generatori, a minimális faziskvantum pi. " ++
  "Allapot: a szamok mertek; az ertelmezes sejtes (§18.4)."

-- ─── 7. A FUTTATHATÓ KIMERÍTŐ MÉRÉS (§18(b)) ────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 TÜKRÖZÉSEK — fázis-átmenetek a 120 pozitív gyökön"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── A POZITÍV GYÖKÖK (lexikografikus kamara) ──"
  putStrLn ("  típus-1 pozitívak: " ++ show Típus1PozitívDarabKonst ++ " (várható: 56)")
  putStrLn ("  típus-2 pozitívak: " ++ show Típus2PozitívDarabKonst ++ " (várható: 64)")
  putStrLn ("  összesen:          " ++ show (length pozitívGyökök) ++ " (várható: 120)")
  putStrLn ""
  putStrLn "── A TÜKRÖZÉSEK MINT FÁZIS-ÁTMENETEK (240 × 120 mérés) ──"
  putStrLn ("  legkisebb fázisfordítás-szám:  " ++ show legkisebbFlip ++ " (várható: Just 1)")
  putStrLn ("  legnagyobb fázisfordítás-szám: " ++ show legnagyobbFlip)
  putStrLn ("  pontosan 1-et fordítók (egyszerű gyökök): " ++ show flipEgyDarab ++ " (várható: 8)")
  putStrLn ""
  putStrLn "── AZ EGYSZERŰ GYÖKÖK (a mérésből emergetálva) ──"
  traverse_ (\alfa => putStrLn ("  " ++ gyökSzimbólum alfa ++ "  = " ++ show alfa)) egyszerűGyökök
  putStrLn ""
  putStrLn "── A CARTAN-MÁTRIX ELLENŐRZÉSE ──"
  putStrLn ("  Dynkin-élek száma: " ++ show élekSzáma ++ " (várható: 7 — a fa)")
  putStrLn ("  det(Cartan) = " ++ show cartanDetermináns ++ " (várható: 1 — unimoduláris)")
  putStrLn ("  kontraszt: det(A2-Cartan) = " ++ show (determináns [[the Integer 2, -1], [-1, 2]]) ++ " (kernel-Refl-lel is bizonyítva)")
  putStrLn ""
  putStrLn "── A FAZISKUBIT-HÍD ──"
  putStrLn ("  i² = " ++ show (egeszSzoroz IEgysegEgeszKonst IEgysegEgeszKonst) ++ "  (a kifordulás — FazisKubit, kernel-Refl)")
  putStrLn "  σ_α(α) = −α  — a tükrözés π-fázist ad (a minimális kvantum)"
  putStrLn "  (σ∘σ)(α) = α — a 2π visszafordul (kernel-Refl-lel bizonyítva)"
  putStrLn ""
  putStrLn "── A GONDOLATOK (részben SPECULATÍV) ──"
  putStrLn tükrözésGondolatok
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
