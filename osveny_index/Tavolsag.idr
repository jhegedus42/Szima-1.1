module Tavolsag

-- ═══════════════════════════════════════════════════════════════
-- TAVOLSAG — Ket E8E8KodSzo tavolsaga + [[15,1,3]] hibajavitas
-- ═══════════════════════════════════════════════════════════════
-- A tavolsag = a Carnot-ciklus masodik lepese: munka (kereses).
-- Minel kisebb a tavolsag, annal kozelibb a ket mondat.
-- A [[15,1,3]] hibajavitas javitja az 1-bites kodolasi hibat.
-- ═══════════════════════════════════════════════════════════════

import Steane713
import E8E8Algebra

-- ─── 1. E8E8KodSzo TAVOLSAG ─────────────────────────────────

||| Ket E8E8KodSzo tavolsaga: 32 - atfedes.
||| 0 = azonos, 32 = teljesen kulonbozo.
||| Ez a 4×E8Pont (bal+jobb+harmadik+negyedik) atfedesének inverze.
public export
kodszoTavolsag : E8E8KodSzo -> E8E8KodSzo -> Nat
kodszoTavolsag a b = 32 `minus` e8e8Atfedes a b

-- ─── 2. CLIFFORD ELEM TAVOLSAG ──────────────────────────────

||| Ket CliffordElem tavolsaga: hány Kubit kulonbozik.
||| 0 = azonos CPT, 3 = teljesen kulonbozo CPT.
public export
cliffordTavolsag : CliffordElem -> CliffordElem -> Nat
cliffordTavolsag a b =
  (if kubitEgyezik a.skalar b.skalar then 0 else 1) +
  (if kubitEgyezik a.vektor b.vektor then 0 else 1) +
  (if kubitEgyezik a.bivektor b.bivektor then 0 else 1)

-- ─── 3. STEANE HAMMING TAVOLSAG ─────────────────────────────

||| Ket HetesKod Hamming tavolsaga.
||| 0 = azonos, 7 = teljesen kulonbozo.
public export
steaneTavolsag : HetesKod -> HetesKod -> Nat
steaneTavolsag a b =
  (if kubitEgyezik (k1 a) (k1 b) then 0 else 1) +
  (if kubitEgyezik (k2 a) (k2 b) then 0 else 1) +
  (if kubitEgyezik (k3 a) (k3 b) then 0 else 1) +
  (if kubitEgyezik (k4 a) (k4 b) then 0 else 1) +
  (if kubitEgyezik (k5 a) (k5 b) then 0 else 1) +
  (if kubitEgyezik (k6 a) (k6 b) then 0 else 1) +
  (if kubitEgyezik (k7 a) (k7 b) then 0 else 1)
  where
    k1 : HetesKod -> Kubit
    k1 (HetesKonstruktor x _ _ _ _ _ _) = x
    k2 : HetesKod -> Kubit
    k2 (HetesKonstruktor _ x _ _ _ _ _) = x
    k3 : HetesKod -> Kubit
    k3 (HetesKonstruktor _ _ x _ _ _ _) = x
    k4 : HetesKod -> Kubit
    k4 (HetesKonstruktor _ _ _ x _ _ _) = x
    k5 : HetesKod -> Kubit
    k5 (HetesKonstruktor _ _ _ _ x _ _) = x
    k6 : HetesKod -> Kubit
    k6 (HetesKonstruktor _ _ _ _ _ x _) = x
    k7 : HetesKod -> Kubit
    k7 (HetesKonstruktor _ _ _ _ _ _ x) = x

-- ─── 4. TELJES TAVOLSAG ─────────────────────────────────────

||| A teljes tavolsag: E8⁴ + Clifford + Steane.
||| Max: 32 (E8) + 3 (Clifford) + 7 (Steane) = 42.
||| Min: 0 = azonos mondat.
|||
||| Sulyozas:
|||   E8⁴ tavolsag × 2  (a fogalom + eset a legfontosabb)
|||   Clifford tavolsag × 1  (CPT fázis)
|||   Steane tavolsag × 1  (struktúra)
public export
teljesTavolsag : E8E8KodSzo -> E8E8KodSzo -> Nat
teljesTavolsag a b =
  (kodszoTavolsag a b) * 2 +
  (cliffordTavolsag a.clifford b.clifford) +
  (steaneTavolsag a.steane b.steane)

-- ─── 5. [[15,1,3]] HIBAJAVITAS ──────────────────────────────

||| A [[15,1,3]] kod: 15 bitbol 1 hibaj javit.
||| A 15 bit = 7 Steane + 7 Steane + 1 paritas.
||| Ha a tavolsag <= 3 (1 hiba a 15 bitben), javithato.
|||
||| Itt: ha a tavolsag <= 3, a ket mondat "ugyanazt mondja"
||| egy 1-bites kodolasi hibaval. A javitas = a kerdessel azonos.
public export
hibajavithato : Nat -> Bool
hibajavithato d = d <= 3

||| A tavolsag alapjan a hasonlosag kategoriaja.
public export
data Hasonlosag = Azonos | EgyBitHiba | Hasonlo | Tavoli

public export
hasonlosag : Nat -> Hasonlosag
hasonlosag d =
  if d == 0 then Azonos
  else if d <= 3 then EgyBitHiba
  else if d <= 10 then Hasonlo
  else Tavoli

public export
Show Hasonlosag where
  show Azonos = "Azonos"
  show EgyBitHiba = "EgyBitHiba (javítható)"
  show Hasonlo = "Hasonló"
  show Tavoli = "Távoli"

-- ─── 6. FŐPROGRAM ───────────────────────────────────────────

public export
tavolsagFom : IO ()
tavolsagFom = do
  putStrLn "=== TAVOLSAG — E8E8KodSzo tavolsag + hibajavitas ==="
  putStrLn ""
  putStrLn "A teljes tavolsag max = 42 (32+3+7)"
  putStrLn "Hibajavitas: tavolsag <= 3 → 1-bites hiba javítható"
  putStrLn ""
  putStrLn "Példa: ket azonos mondat tavolsaga = 0"
  let ks1 = KodKonstruktor "teszt" e8Egy e8Egy e8Nulla e8Nulla
                            (CliffordKonstruktor Nulla Nulla Nulla)
                            (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  let d1 = teljesTavolsag ks1 ks1
  putStrLn ("  tavolsag = " ++ show d1 ++ " (" ++ show (hasonlosag d1) ++ ")")
  putStrLn ""
  putStrLn "Példa: egy bit hiba a balE8-ben"
  let ks2 = KodKonstruktor "teszt2" e8Nulla e8Egy e8Nulla e8Nulla
                            (CliffordKonstruktor Nulla Nulla Nulla)
                            (HetesKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla)
  let d2 = teljesTavolsag ks1 ks2
  putStrLn ("  tavolsag = " ++ show d2 ++ " (" ++ show (hasonlosag d2) ++ ")")
  putStrLn ""
  putStrLn "Kész."