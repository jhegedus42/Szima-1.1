module HadamardTavolsag

import Steane713
import E8E8Algebra

-- Kubit -> +1 vagy -1 (Hadamard konvencio)
public export
kubitElojel : Kubit -> Integer
kubitElojel Nulla = 1
kubitElojel Egy = -1

-- E8Pont Hamming tavolsag (alap: bitenkenti elteres)
public export
hammingTavolsagE8 : E8Pont -> E8Pont -> Nat
hammingTavolsagE8 a b =
  (if a.x1 == b.x1 then 0 else 1) +
  (if a.x2 == b.x2 then 0 else 1) +
  (if a.x3 == b.x3 then 0 else 1) +
  (if a.x4 == b.x4 then 0 else 1) +
  (if a.x5 == b.x5 then 0 else 1) +
  (if a.x6 == b.x6 then 0 else 1) +
  (if a.x7 == b.x7 then 0 else 1) +
  (if a.x8 == b.x8 then 0 else 1)

-- Steane kivetelo (top-level)
k1H : HetesKod -> Kubit; k1H (HetesKonstruktor x _ _ _ _ _ _) = x
k2H : HetesKod -> Kubit; k2H (HetesKonstruktor _ x _ _ _ _ _) = x
k3H : HetesKod -> Kubit; k3H (HetesKonstruktor _ _ x _ _ _ _) = x
k4H : HetesKod -> Kubit; k4H (HetesKonstruktor _ _ _ x _ _ _) = x
k5H : HetesKod -> Kubit; k5H (HetesKonstruktor _ _ _ _ x _ _) = x
k6H : HetesKod -> Kubit; k6H (HetesKonstruktor _ _ _ _ _ x _) = x
k7H : HetesKod -> Kubit; k7H (HetesKonstruktor _ _ _ _ _ _ x) = x

-- Steane Hamming tavolsag
public export
steaneTavolsagH : HetesKod -> HetesKod -> Nat
steaneTavolsagH a b =
  (if k1H a == k1H b then 0 else 1) +
  (if k2H a == k2H b then 0 else 1) +
  (if k3H a == k3H b then 0 else 1) +
  (if k4H a == k4H b then 0 else 1) +
  (if k5H a == k5H b then 0 else 1) +
  (if k6H a == k6H b then 0 else 1) +
  (if k7H a == k7H b then 0 else 1)

-- Clifford tavolsag
public export
cliffordTavolsagH : CliffordElem -> CliffordElem -> Nat
cliffordTavolsagH a b =
  (if a.skalar == b.skalar then 0 else 1) +
  (if a.vektor == b.vektor then 0 else 1) +
  (if a.bivektor == b.bivektor then 0 else 1)

-- E84 Hadamard tavolsag: 4 reteg kulon-kulon + fazis-sulyozas
-- A fazis-sulyozas: ha ter-szin egyezik de hang-mod nem,
-- a hang-mod tav 2x sulyozott (dekoherens).
public export
hadamardTavolsagE8Negy : E8E8KodSzo -> E8E8KodSzo -> Nat
hadamardTavolsagE8Negy a b =
  let terTav = hammingTavolsagE8 a.balE8 b.balE8
      szinTav = hammingTavolsagE8 a.jobbE8 b.jobbE8
      hangTav = hammingTavolsagE8 a.harmadikE8 b.harmadikE8
      modTav = hammingTavolsagE8 a.negyedikE8 b.negyedikE8
      terSzinEgyezik = terTav == 0 && szinTav == 0
      hangModEgyezik = hangTav == 0 && modTav == 0
      -- Ha ter-szin dekoherens de hang-mod koherens, a ter-szin suly 2x
      terSzinSuly = if (not terSzinEgyezik) && hangModEgyezik then 2 else 1
      -- Ha hang-mod dekoherens de ter-szin koherens, a hang-mod suly 2x
      hangModSuly = if (not hangModEgyezik) && terSzinEgyezik then 2 else 1
  in (terTav * terSzinSuly) + szinTav + (hangTav * hangModSuly) + modTav

-- Teljes Hadamard tavolsag
public export
teljesHadamardTavolsag : E8E8KodSzo -> E8E8KodSzo -> Nat
teljesHadamardTavolsag a b =
  hadamardTavolsagE8Negy a b +
  cliffordTavolsagH a.clifford b.clifford +
  steaneTavolsagH a.steane b.steane

-- Hamming (regi, puszta bit-elteres, osszehasonlitashoz)
public export
hammingTavolsagTeljes : E8E8KodSzo -> E8E8KodSzo -> Nat
hammingTavolsagTeljes a b =
  (32 `minus` e8e8Atfedes a b) * 2 +
  cliffordTavolsagH a.clifford b.clifford +
  steaneTavolsagH a.steane b.steane

-- Fomprogram
public export
hadamardFom : IO ()
hadamardFom = do
  putStrLn "=== HADAMARD TAVOLSAG — Hamming vs Hadamard ==="
  putStrLn ""
  let ks1 = KodKonstruktor "kategoria" e8Egy e8Egy e8Nulla e8Nulla
                            (CliffordKonstruktor Nulla Nulla Nulla)
                            (alapKod Nulla)
  let ks2 = KodKonstruktor "funktor" e8Ketto e8Egy e8Nulla e8Nulla
                            (CliffordKonstruktor Nulla Nulla Nulla)
                            (alapKod Nulla)
  let ks3 = KodKonstruktor "kategoria mas" e8Egy e8Nulla e8Nulla e8Nulla
                            (CliffordKonstruktor Nulla Nulla Nulla)
                            (alapKod Nulla)
  putStrLn ("1 vs 2 (mas fogalom, azonos szin):")
  putStrLn ("  Hamming:  " ++ show (hammingTavolsagTeljes ks1 ks2))
  putStrLn ("  Hadamard: " ++ show (teljesHadamardTavolsag ks1 ks2))
  putStrLn ""
  putStrLn ("1 vs 3 (azonos fogalom, mas szin):")
  putStrLn ("  Hamming:  " ++ show (hammingTavolsagTeljes ks1 ks3))
  putStrLn ("  Hadamard: " ++ show (teljesHadamardTavolsag ks1 ks3))
  putStrLn ""
  putStrLn "Kesz."