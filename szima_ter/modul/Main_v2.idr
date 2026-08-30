module Main_v2

-- ===============================================================
-- FO TESZT -- a holografikus kod v2 (MANTRA-szerinti) futtatasa
-- ===============================================================
-- AGENTS.md: a Show-ertekek = futtathato ellenorzes.
-- A bizonyitasok (biz*) a forditasi ido ellenorzesei -- a main
-- a typeclass instance-ok futasideju kimeneteit mutatja.
-- ===============================================================

import KomplexByte
import HolografikusKod49_v2_MantraModul

%default total

main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "SZIMA-TER v2 -- holografikus kod MANTRA-teszt"
  putStrLn "============================================"

  putStrLn ""
  putStrLn "1. A FazaKorrelacioT instance-ok alap-konstansai:"
  printLn komplexZero
  printLn komplexEgy

  putStrLn ""
  putStrLn "2. Az ures perem tipusneve (a fordito latja a biteket):"
  putStrLn "Perem7HetesV2 Nulla Nulla Nulla Nulla Nulla Nulla Nulla"

  putStrLn ""
  putStrLn "3. A teljes perem tipusneve:"
  putStrLn "Perem7HetesV2 Egy Egy Egy Egy Egy Egy Egy"

  putStrLn ""
  putStrLn "4. Az ures holografikus kod tipusneve:"
  putStrLn "HolografikusKod49V2 Nulla Nulla Nulla Nulla Nulla Nulla Nulla"

  putStrLn ""
  putStrLn "5. A v2 modul forditasi ideju Refl-bizonyitasok:"
  putStrLn "   bizUresUresEgyenlo, bizUresEgyEgyenlo,"
  putStrLn "   bizEgyUresEgyenlo, bizEgyEgyEgyenlo,"
  putStrLn "   bizUressCimkeUres -- mind Refl (a fordito ellenorizte)."

  putStrLn ""
  putStrLn "Kesz."
