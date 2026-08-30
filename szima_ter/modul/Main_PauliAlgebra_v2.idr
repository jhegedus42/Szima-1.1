module Main_PauliAlgebra_v2

-- ===============================================================
-- FO TESZT -- a PauliAlgebra_v2 futtatasa
-- ===============================================================
-- AGENTS.md: a Show-ertekek = futtathato ellenorzes.
-- A bizonyitasok (biz*) a forditasi ido ellenorzesei -- a main
-- a typeclass instance-ok futasideju kimeneteit mutatja.
-- ===============================================================

import PauliAlgebra_v2

%default total

main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "SZIMA-TER v2 -- Pauli-algebra MANTRA-teszt"
  putStrLn "============================================"

  putStrLn ""
  putStrLn "1. A PauliHarom ertekei:"
  putStrLn "Px, Py, Pz -- a 3 Pauli-matrix."

  putStrLn ""
  putStrLn "2. A 6 forgatas alkalmazasa a nulla-elemre:"
  putStrLn (show (forgatasCl07 (Px, Px) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Px, Py) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Px, Pz) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Py, Px) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Py, Py) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Py, Pz) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Pz, Px) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Pz, Py) UrressCl07Elem))
  putStrLn (show (forgatasCl07 (Pz, Pz) UrressCl07Elem))

  putStrLn ""
  putStrLn "3. A forgatasCl07 a nulla-elemre:"
  printLn (forgatasCl07 (Px, Py) UrressCl07Elem)
  printLn (forgatasCl07 (Py, Pz) UrressCl07Elem)
  printLn (forgatasCl07 (Pz, Px) UrressCl07Elem)

  putStrLn ""
  putStrLn "4. A 6 stabilizator-generator szama:"
  printLn (length SteaneHatGeneratorKonst)

  putStrLn ""
  putStrLn "5. A Cl(0,14) egysegeleme:"
  printLn Cl014EgysegKonst

  putStrLn ""
  putStrLn "6. A Cl(0,14) nulla-eleme:"
  printLn UrressCl014Elem

  putStrLn ""
  putStrLn "7. A kod1513Ertek:"
  printLn (kod1513Ertek Tizenot)

  putStrLn ""
  putStrLn "8. A bizonyitasok (Refl, a fordito mar ellenorizte):"
  putStrLn "   - bizPermutacioHat: 6 permutacio = 6"
  putStrLn "   - bizStabilizatorHat: 6 stabilizator"
  putStrLn "   - bizCl07Dim: Cl(0,7) = 128 dimenzio"
  putStrLn "   - bizCl014Dim: Cl(0,14) = 16384 dimenzio"
  putStrLn "   - bizKod1513Dimenzio: [[15,1,3]] = 15 dimenzio"
  putStrLn "   - bizHangSzam: 37 hang"
  putStrLn "   - bizBitPozicioHeten: 7 bit"
  putStrLn "   - bizHatForgatasInverz: (Px,Py) inverze = (Py,Px)"
  putStrLn "   - bizHatForgatasNegyzet: (Px,Py)² = id (nulla-elemre)"
  putStrLn "   - bizHatForgatasCl14: a forgatas a Cl(0,14) elemein is"
  putStrLn "   - bizCl014Asszociativ: tenzor asszociativ (nulla-elemre)"
  putStrLn "   - bizCl014EgysegJobb: tenzor egyseggel jobbrol = id"
  putStrLn "   - bizGamma5Invarians: γ⁵ invarians (nulla-elemre)"
  putStrLn "   - 10+ egyeb Refl-bizonyitas"

  putStrLn ""
  putStrLn "Kesz."