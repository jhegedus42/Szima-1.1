module Main_MagyarKinaiGenKod_v2

-- ═══════════════════════════════════════════════════════════════
-- A magyar ↔ kínai genetikai kód demója
-- ═══════════════════════════════════════════════════════════════
-- A genetikai kód analógia:
--   4 bazis × 64 kodon × 20 aminosav × 2 tRNS ×
--   4 riboszóma-fázis × Steane [7,1,3] × 3 stop kodon ×
--   α-hélix periódus (20)

import KomplexByte
import MagyarKinaiGenKod_v2

%default total

||| Az elso ot kodon listaja.
public export
elsoOtKodon : List Kodon -> List Kodon
elsoOtKodon (a :: b :: c :: d :: e :: _) = [a, b, c, d, e]
elsoOtKodon xs = xs

main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "MAGYAR ↔ KÍNAI GENETIKAI KÓD"
  putStrLn "============================================"

  putStrLn ""
  putStrLn "1. A 4 bazis (a magyar toldalék 4 alapeleme):"
  printLn negyBazis

  putStrLn ""
  putStrLn "2. A kodonok szama (4^3 = 64):"
  printLn kodonSzam

  putStrLn ""
  putStrLn "3. Az aminosavak szama (a parketta-darabok = 20):"
  printLn aminosavSzam

  putStrLn ""
  putStrLn "4. A degeneraltsag (64/20 = 3.2):"
  printLn degeneraltsag

  putStrLn ""
  putStrLn "5. A stop kodonok szama (a delta maradeka = 3):"
  printLn stopKodonSzam

  putStrLn ""
  putStrLn "6. A delta (a Carnot-buborek maradeka = 8.23e-7):"
  printLn deltaGenKod

  putStrLn ""
  putStrLn "7. A Steane [7,1,3] kod (7 qubit, 1 logikai, tavolsag 3):"
  printLn steaneKod

  putStrLn ""
  putStrLn "8. Az alfa-helix periodusa (= 20 aminosav):"
  printLn alphaHelixPeriódus

  putStrLn ""
  putStrLn "9. Az elso kodon indexe (a kodonToAminosav fuggvennyel):"
  printLn (kodonToAminosav (KodonKonstruktor EsetBazis IgeidoBazis AspektusBazis))

  putStrLn ""
  putStrLn "10. Az elso 5 kodon listaja:"
  printLn (elsoOtKodon osszesKodon)

  putStrLn ""
  putStrLn "============================================"
  putStrLn "OSSZEFOGLALO"
  putStrLn "============================================"
  putStrLn genKodMagyarKinai
  putStrLn ""
  putStrLn alphaHelixMegfelel

  putStrLn ""
  putStrLn "Kesz."