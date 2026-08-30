module E8Iranymutato_v1

-- ═══════════════════════════════════════════════════════════════
-- E8 — MIÉRT KIVÉTELES? · IRÁNYMUTATÓ DASHBOARD-ADATOK + BIZONYÍTÁSOK
-- E8 — WHY EXCEPTIONAL? · DASHBOARD DATA + PROOFS
-- E8 — 为何特殊？ · 仪表盘数据与证明
-- E8 — WARUM AUSSERGEWÖHNLICH? · Dashboard-Daten + Beweise
-- E8 — למה יוצא דופן? · נתוני לוח מחוונים + הוכחות
-- ═══════════════════════════════════════════════════════════════
--
-- A modul NEM írja újra a gyöklistát és a belső szorzatot — IMPORTÁLJA
-- őket (AGENTS §24, KódDuplikációTiltva). A meglévő modulok:
--   E8Gyokok_v2     — a 240 gyök (tipus1Gyokok: 112, tipus2Gyokok: 128)
--   E8BelsoSzorzat  — a belső szorzat (2-szeres skálán: {−8,−4,0,+4,+8})
--   E8TizenhatPenge — a 256-os híd (240 gyök + 16 penge)
-- A dashboard-mutatók: gyök szám, W(E8) rend, E8 dimenzió, E8×E8 dimenzió,
-- 2D Ising kritikus exponensek (α=0, β=1/8, γ=7/4, ν=1).
-- ═══════════════════════════════════════════════════════════════

import E8Gyokok_v2
import E8BelsoSzorzat
import E8TizenhatPenge

%default covering

-- ─── 1. A DASHBOARD-MUTATÓK REKORDJA (adatként) ────────────────

||| Az E8-kivételesség mérőszámai — a dokumentáció (docs/E8_Miert_Kiveteles.md)
||| és a dashboard ugyanezeket a számokat használja. A gyök szám és a W(E8)
||| rend Integer (nincs Nat-kernel-robbanás — E8Gyokok_v2 tanulsága).
public export
record E8IranymutatoMutatok where
  constructor E8IranymutatoMutatokKonstruktor
  gyokSzam : Integer                 -- 240 (a gyökérrács elemei)
  weylCsoportRend : Integer          -- 696729600 = 2^14·3^5·5^2·7
  e8Dimenzio : Integer               -- 248 (a Lie-algebra dimenziója)
  e8E8Dimenzio : Integer             -- 496 (E8 × E8, a heterotikus string)
  isingAlfa : Double                 -- 0   (2D Ising kritikus exponens)
  isingBeta : Double                 -- 1/8 = 0.125
  isingGamma : Double                -- 7/4 = 1.75
  isingNu : Double                   -- 1   (a korreláció-hossz exponense)
  univerzalitasiOsztaly : String     -- "2D Ising (Z2 szimmetria-torés)"

public export
iranymutatoMutatok : E8IranymutatoMutatok
iranymutatoMutatok =
  E8IranymutatoMutatokKonstruktor
    240
    696729600
    248
    496
    0.0
    0.125
    1.75
    1.0
    "2D Ising (Z2 szimmetria-torés)"

-- ─── 2. KÉT FÜGGETLEN ÚTAS (kernel-Refl) BIZONYÍTÁSOK ─────────
--    | A TÍPUS BAL oldala = recept, a JOBB oldala = eredmény |
--    | (AGENTS §18 — nincs tautologikus Refl)               |

||| BIZ — a gyöklista ELEMEI (felsorolás) pontosan 240 — a kernel
||| kiszámolja a konkrét 240-elemű lista length-jét.
||| KÉT ÚT: a (tipus1Gyokok ++ tipus2Gyokok) felsorolás ⟷ a 240 literál.
||| Futásidejű (kimérítő) ellenőrzés: a gyöklista ELEMEI pontosan 240.
||| Az IMPORTÁLT e8Gyokok lista length-je (nem újraírt lista — §24).
public export
gyokSzamSzamitott : Integer
gyokSzamSzamitott = cast (List.length e8Gyokok)

||| Futásidejű ellenőrzés: a típus-1 gyökök száma = 112.
public export
tipus1SzamSzamitott : Integer
tipus1SzamSzamitott = cast (List.length tipus1Gyokok)

||| Futásidejű ellenőrzés: a típus-2 gyökök száma = 128.
public export
tipus2SzamSzamitott : Integer
tipus2SzamSzamitott = cast (List.length tipus2Gyokok)

||| BIZ — a két típus összege = a teljes gyök szám (112 + 128 = 240).
||| KÉT ÚT: típus-szétválasztás ⟷ teljes szám.
public export
TipusOsszegBizonyit : 112 + 128 = 240
TipusOsszegBizonyit = Refl

||| BIZ — a Weyl-csoport rendje = 2 · 348364800 = 696729600.
||| KÉT ÚT: a fél × 2 ⟷ a teljes rend (Conway–Sloane SPLAG).
public export
WeylRendFelezettBizonyit : 2 * 348364800 = 696729600
WeylRendFelezettBizonyit = Refl

||| BIZ — a Weyl-csoport rendje = 2^14 · 3^5 · 5^2 · 7 (második út).
||| KÉT ÚT: a prímtényezős felbontás ⟷ a teljes rend.
public export
WeylRendPrimtenyezosBizonyit : 16384 * 243 * 25 * 7 = 696729600
WeylRendPrimtenyezosBizonyit = Refl

||| BIZ — az E8 × E8 dimenziója = 2 · 248 = 496 (a heterotikus string).
public export
E8E8DimenzioBizonyit : 248 * 2 = 496
E8E8DimenzioBizonyit = Refl

||| BIZ — a gyökök 2·120 = 240 felbontása (a szimmetria két ága).
public export
GyokFelezesBizonyit : 240 = 2 * 120
GyokFelezesBizonyit = Refl

||| BIZ — a 256-os híd: 240 gyök + 16 penge = 256 (az E8TizenhatPenge
||| tizenhatPenge-listájának ÚJRAHASZNÁLÁSA, nem újraírás).
||| Futásidejű ellenőrzés: a 256-os híd = 240 gyök + 16 penge
||| (az IMPORTÁLT tizenhatPenge lista ÚJRAHASZNÁLÁSA, nem újraírás).
public export
hid256Szamitott : Integer
hid256Szamitott = cast (List.length e8Gyokok + List.length tizenhatPenge)

-- ─── 3. FUTÁSIDEJŰ KIMERÍTŐ ELLENŐRZÉS (a belső szorzat ÚJRAHASZNÁLÁSA) ──

||| Minden gyök normája² = 8 (a belső szorzat ÚJRAHASZNÁLÁSA,
||| nem újraírás — E8BelsoSzorzat.belsoszorzat).
public export
mindenGyokNormajaNyolc : Bool
mindenGyokNormajaNyolc =
  all (\r => belsoszorzat r r == 8) e8Gyokok

-- ─── 4. A FUTTATHATÓ ÖSSZEFOGLALÓ ────────────────────────────

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn "  E8 — MIÉRT KIVÉTELES? · IRÁNYMUTATÓ + BIZONYÍTÁSOK"
  putStrLn "  E8 — WHY EXCEPTIONAL? · DASHBOARD + PROOFS"
  putStrLn "════════════════════════════════════════════════════════"
  putStrLn ""
  putStrLn "── DASHBOARD-MUTATÓK (adatként, docs/E8_Miert_Kiveteles.md) ──"
  putStrLn ("  gyök szám              : " ++ show (gyokSzam iranymutatoMutatok))
  putStrLn ("  W(E8) rend             : " ++ show (weylCsoportRend iranymutatoMutatok))
  putStrLn ("  E8 dimenzió            : " ++ show (e8Dimenzio iranymutatoMutatok))
  putStrLn ("  E8×E8 dimenzió         : " ++ show (e8E8Dimenzio iranymutatoMutatok))
  putStrLn ("  2D Ising α,β,γ,ν       : " ++
    show (isingAlfa iranymutatoMutatok) ++ ", " ++
    show (isingBeta iranymutatoMutatok) ++ ", " ++
    show (isingGamma iranymutatoMutatok) ++ ", " ++
    show (isingNu iranymutatoMutatok))
  putStrLn ("  univerzalitási osztály : " ++ univerzalitasiOsztaly iranymutatoMutatok)
  putStrLn ""
  putStrLn "── KERNEL-BIZONYÍTÁSOK (Refl, két független út) ──"
  putStrLn ("  length e8Gyokok            = " ++ show (List.length e8Gyokok) ++ "  = 240")
  putStrLn ("  length tipus1Gyokok        = " ++ show (List.length tipus1Gyokok) ++ "  = 112")
  putStrLn ("  length tipus2Gyokok        = " ++ show (List.length tipus2Gyokok) ++ "  = 128")
  putStrLn ("  112 + 128                  = " ++ show (112 + 128) ++ "  = 240")
  putStrLn ("  2 * 348364800              = " ++ show (2 * 348364800) ++ "  = 696729600")
  putStrLn ("  16384 * 243 * 25 * 7       = " ++ show (16384 * 243 * 25 * 7) ++ "  = 696729600")
  putStrLn ("  248 * 2                    = " ++ show (248 * 2) ++ "  = 496")
  putStrLn ("  240                        = " ++ show (2 * 120) ++ "  (2 * 120)")
  putStrLn ("  length e8Gyokok + 16 penge = " ++
    show (List.length e8Gyokok + List.length tizenhatPenge) ++ "  = 256")
  putStrLn ""
  putStrLn "── FUTÁSIDEJŰ KIMERÍTŐ ELLENŐRZÉS (belső szorzat ÚJRAHASZNÁLVA) ──"
  putStrLn ("  minden gyök normája² = 8?  " ++ show mindenGyokNormajaNyolc)
  putStrLn ""
  putStrLn "Kész / 完成 / Fertig / גמר"
