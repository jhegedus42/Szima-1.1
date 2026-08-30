module Main

-- ═══════════════════════════════════════════════════════════════
-- FŐ TESZT — a paragrafus-kódolás futtatható ellenőrzése
-- ═══════════════════════════════════════════════════════════════
-- AGENTS.md: a Show-értékek = futtatható ellenőrzés.
-- Ez a modul kinyomtatja:
--   - a szó → jelentésvektor → komplex bájt átalakítást,
--   - egy paragrafus kódolását a Peldaszotar-ral.
--
-- Futtatás: idris2 -i . Main.idr -o szima_ter_teszt && ./szima_ter_teszt
-- ═══════════════════════════════════════════════════════════════

import KomplexByte
import Paragrafus

%default total

-- A Peldaszotar exportált, a feldolgozás exportált. Show instance-ok
-- a Komplex-re és HetesKod-ra megvannak; a KomplexBajt-ra is kell egy.

showCptIdo : Igeido -> String
showCptIdo MultI = "mult"
showCptIdo JelenI = "jelen"
showCptIdo JovoI = "jovo"

showCptSzemlelet : Szemlelet -> String
showCptSzemlelet FolyamatosSz = "folyamatos"
showCptSzemlelet BefejezettSz = "befejezett"
showCptSzemlelet SzokasosSz = "szokasos"

showCptForras : Forras -> String
showCptForras KozvetlenF = "kozvetlen"
showCptForras KovetkeztetettF = "kovetkeztetett"
showCptForras JelentettF = "jelentett"

public export
Show CptFazis where
  show (CptFazisKonstruktor ido szemlelet forras) =
    "(" ++ showCptIdo ido ++ "," ++ showCptSzemlelet szemlelet
    ++ "," ++ showCptForras forras ++ ")"

public export
Show KomplexBajt where
  show (KomplexBajtKonstruktor a b c d e f g h cpt steane cimke) =
    "[" ++ show a ++ " " ++ show b ++ " " ++ show c ++ " " ++ show d ++ " "
    ++ show e ++ " " ++ show f ++ " " ++ show g ++ " " ++ show h ++ " "
    ++ show cpt ++ " | " ++ show steane ++ " | " ++ show cimke ++ "]"

public export
Show SzoJelentes where
  show (SzoJelentesKonstruktor szo a b c d e f g h) =
    "(" ++ szo ++ ": " ++ show a ++ " " ++ show b ++ " " ++ show c ++ " "
    ++ show d ++ " " ++ show e ++ " " ++ show f ++ " " ++ show g ++ " "
    ++ show h ++ ")"

-- ─── FŐ ─────────────────────────────────────────────────────

||| Saját listaprinter a paragrafus-lista megjelenítéséhez
||| (nem definiálunk Show (List a)-t, mert az ütközik a Prelude-dal).
kinyomtatLista : List KomplexBajt -> String
kinyomtatLista [] = "[]"
kinyomtatLista (x :: xs) = show x ++ "\n" ++ kinyomtatLista xs

||| Szöveglista megjelenítése (a Prelude Show-ütközést kerülve).
kinyomtatSzovegLista : List String -> String
kinyomtatSzovegLista [] = "[]"
kinyomtatSzovegLista (x :: xs) = x ++ " :: " ++ kinyomtatSzovegLista xs

main : IO ()
main = do
  putStrLn "════════════════════════════════════════════"
  putStrLn "SZIMA-TER teszt — a komplex bájt kódolása"
  putStrLn "════════════════════════════════════════════"

  putStrLn ""
  putStrLn "1. A farkas jelentésvektora (a szótárból):"
  printLn (szotarKeres "farkas" Peldaszotar)

  putStrLn ""
  putStrLn "2. A 'Piroska.' paragrafus kódolása (nagybetűs kezdet):"
  putStrLn (kinyomtatLista (paragrafusKodol "Piroska." Peldaszotar))

  putStrLn ""
  putStrLn "3. A 'Mit mondott a farkas?' paragrafus:"
  putStrLn (kinyomtatLista (paragrafusKodol "Mit mondott a farkas?" Peldaszotar))

  putStrLn ""
  putStrLn "4. A kétmondatos paragrafus:"
  putStrLn (kinyomtatLista (paragrafusKodol "Piroska. A farkas hazugsagot mondott." Peldaszotar))

  putStrLn ""
  putStrLn "5. Az üres szöveg (nem tartalmaz mondatot):"
  putStrLn (kinyomtatSzovegLista (szovegMondatokra ""))

  putStrLn ""
  putStrLn "6. Az üres komplex bájt életjele (vakum = 0):"
  printLn (komplexBajtEletjel UressKomplexBajt)

  putStrLn ""
  putStrLn "Kesz."
