module Main_MagyarKinaiPar_v2

-- ═══════════════════════════════════════════════════════════════
-- A magyar ↔ kínai partikula-pár fordítás demója
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import MagyarKinaiPar_v2

%default total

main : IO ()
main = do
  putStrLn "============================================"
  putStrLn "MAGYAR ↔ KÍNAI PARTIKULA-PÁR (Cat² szint)"
  putStrLn "============================================"

  putStrLn ""
  putStrLn "1. A magyar CPT elemei (a szintaxis):"
  putStrLn "   MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento"
  putStrLn "   MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento"
  putStrLn "   MagyarCPTKonstruktor MagyarJovo MagyarHabituális MagyarFelteteles"
  putStrLn "   MagyarCPTKonstruktor MagyarJelen MagyarPerfectum MagyarFelszolito"

  putStrLn ""
  putStrLn "2. Az F functor alkalmazasa (MagyarCPT → KinaiCPT):"
  printLn (forditF (MagyarCPTKonstruktor MagyarJelen MagyarImperfectum MagyarKijelento))
  printLn (forditF (MagyarCPTKonstruktor MagyarMult MagyarPerfectum MagyarKijelento))
  printLn (forditF (MagyarCPTKonstruktor MagyarJovo MagyarHabituális MagyarFelteteles))
  printLn (forditF (MagyarCPTKonstruktor MagyarJelen MagyarPerfectum MagyarFelszolito))

  putStrLn ""
  putStrLn "3. A G functor alkalmazasa (KinaiCPT → MagyarCPT):"
  printLn (forditG (KinaiCPTKonstruktor KinaiLe KinaiDe (KubitTonalitasKonstruktor Nulla Nulla)))
  printLn (forditG (KinaiCPTKonstruktor KinaiGuo KinaiBa (KubitTonalitasKonstruktor Nulla Egy)))
  printLn (forditG (KinaiCPTKonstruktor KinaiZai KinaiMa (KubitTonalitasKonstruktor Egy Nulla)))

  putStrLn ""
  putStrLn "4. A magyar aspektus-lista hossza (Refl-bizonyítva):"
  printLn (length magyarAspektusLista)

  putStrLn ""
  putStrLn "5. A kínai aspektus-lista hossza (Refl-bizonyítva):"
  printLn (length kinaiAspektusLista)

  putStrLn ""
  putStrLn "6. Az F functor a magyar listán (3 kínai elem):"
  printLn magyarAspektusToKinaiLista

  putStrLn ""
  putStrLn "7. A magyar-kínai rendszer helyzete a Cat^∞ hierarchiaban:"
  printLn magyarKinaiRendszerSzintje

  putStrLn ""
  putStrLn "8. A bizonyítasok (Refl, a fordito mar ellenorizte):"
  putStrLn "   - bizMagyarAspektusHarom: magyar aspektus = 3"
  putStrLn "   - bizKinaiAspektusNegy: kinai aspektus = 4"
  putStrLn "   - bizFListaMeret: F functor alkalmazasa = 3"
  putStrLn "   - bizMagyarHabituToKinaiGuo: Magyar Habitualis → Kinai Guo"
  putStrLn "   - bizMagyarImperfToKinaiZhe: Magyar Imperfectum → Kinai Zhe"
  putStrLn "   - bizMagyarPerfToKinaiLe: Magyar Perfectum → Kinai Le"
  putStrLn "   - bizKinaiLeToMagyarPerf: Kinai Le → Magyar Perfectum"
  putStrLn "   - bizKinaiZaiToMagyarImperf: Kinai Zai → Magyar Imperfectum"
  putStrLn "   - bizMagyarKijToKinaiDe: Magyar Kijelento → Kinai De"
  putStrLn "   - bizMagyarFelszToKinaiBa: Magyar Felszolito → Kinai Ba"
  putStrLn "   - bizForditFPelda: F functor egy konkrét elemen"
  putStrLn "   - bizForditGPelda: G functor egy konkrét elemen"

  putStrLn ""
  putStrLn "Kesz."