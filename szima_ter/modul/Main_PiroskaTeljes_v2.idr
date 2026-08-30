module Main_PiroskaTeljes_v2

-- ===============================================================
-- PIROSKA HOLOGRAFIKUS KOD v2 -- TELJES MESE DEMO
-- ===============================================================
-- A felhasznalo (2026-08-19): "huzd be a piroska es a farkas meset
-- konkretan".
--
-- Ez a demo a teljes Grimm-Piroska meset (22 mondat) a holografikus
-- kod v2 tipusok segitsegevel mutatja be:
--   - minden mondatot egy 7-quantumbit peremre kodolunk,
--   - a perem a Steane [[7,1,3]] 7 dimenziojaban (ido, oksag, ter,
--     szin, hang, fazis, mod) a szavak egyesitese,
--   - a belso 7x7 = 49 korrelacio matrix a FazaKorrelacioT typeclass
--     instance-ok szerint.
--
-- Futtatas:
--   cd szima_ter/modul
--   idris2 Main_PiroskaTeljes_v2.idr -o piroska_teljes_demo
--   ./piroska_teljes_demo
-- ===============================================================

import KomplexByte
import Data.List
import Data.String
import Paragrafus
import PiroskaSztarTeljes
import PiroskaHolografikusKod49_v2_Teljes
import HolografikusKod49_v2_MantraModul

%default total

-- Seged-printer (a Prelude Show (List a)-val valo utkozes elkerulese)

kinyomtatSor : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) -> String
kinyomtatSor (a, b, c, d, e, f, g) =
  show a ++ show b ++ show c ++ show d ++ show e ++ show f ++ show g

bitSzam : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) -> Nat
bitSzam (a, b, c, d, e, f, g) =
  bitErtek a + bitErtek b + bitErtek c + bitErtek d +
  bitErtek e + bitErtek f + bitErtek g
  where
    bitErtek : Kubit -> Nat
    bitErtek Nulla = 0
    bitErtek Egy   = 1

||| A peremek listajanak az ossz-szamitasa (Nat).
osszegPeremek :
  List (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) -> Nat
osszegPeremek [] = 0
osszegPeremek (p :: ps) = bitSzam p + osszegPeremek ps

-- A teljes mese holografikus kodja: minden mondat egy 7-bites perem.
main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "PIROSKA HOLOGRAFIKUS KOD v2 -- TELJES MESE"
  putStrLn "============================================"
  putStrLn ""
  putStrLn "A Steane [[7,1,3]] 7 bitje:"
  putStrLn "  bit1=ido, bit2=oksag, bit3=ter, bit4=szin,"
  putStrLn "  bit5=hang, bit6=fazis, bit7=mod"
  putStrLn ""
  putStrLn "--------------------------------------------"
  putStrLn "A teljes Piroska-Grimm mese 22 mondata:"
  putStrLn "--------------------------------------------"

  let peremek = map (\m => mondatPerem m PiroskaSztarTeljesLista)
                      PiroskaSztarTeljesMondatok
  let egybenPeremek = zip PiroskaSztarTeljesMondatok peremek

  putStrLn ""
  putStrLn "Az elso 5 mondat:"
  putStrLn ""
  let elsoOt = take 5 egybenPeremek
  putStrLn "Mondat | Perem (7 bit) | #bit"
  putStrLn "-------+----------------+------"
  traverse_ kiIrSor elsoOt

  putStrLn ""
  putStrLn "--------------------------------------------"
  putStrLn "Az utolso 3 mondat:"
  putStrLn "--------------------------------------------"
  putStrLn ""
  let utolsoHarom = drop 19 egybenPeremek
  putStrLn "Mondat | Perem (7 bit) | #bit"
  putStrLn "-------+----------------+------"
  traverse_ kiIrSor utolsoHarom

  putStrLn ""
  putStrLn "--------------------------------------------"
  putStrLn "A teljes mese osszesitese:"
  putStrLn "--------------------------------------------"
  putStrLn ""
  putStrLn ("Mondatok szama: " ++ show (length peremek))

  let osszBit = osszegPeremek peremek
  putStrLn ("Osszes bekapcsolt bit: " ++ show osszBit)

  putStrLn ""
  putStrLn "--------------------------------------------"
  putStrLn "A v2 FazaKorrelacioT typeclass 4 instance-a:"
  putStrLn "--------------------------------------------"
  putStrLn ""
  putStrLn "Nulla ⊗ Nulla:"
  printLn komplexZero
  putStrLn "Nulla ⊗ Egy:"
  printLn komplexZero
  putStrLn "Egy   ⊗ Nulla:"
  printLn komplexZero
  putStrLn "Egy   ⊗ Egy:"
  printLn komplexEgy

  putStrLn ""
  putStrLn "Kesz."
  where
    kiIrSor : (String,
               (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)) ->
              IO ()
    kiIrSor (m, p) = do
      putStrLn (m ++ " | " ++ kinyomtatSor p ++ " | " ++ show (bitSzam p))
