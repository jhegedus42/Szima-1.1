module PróbaKetoldaliFutás

-- §18(b) futtató: a természetesTranszformációKimerítő kiértékelése
import KetoldaliKategoria_v3

main : IO ()
main = do
  putStrLn ("természetesTranszformációKimerítő = " ++ show természetesTranszformációKimerítő ++ "  (várható: True)")
  putStrLn ("De Morgan OR  = " ++ show (bizDeMorganOR Nulla Egy))
  putStrLn ("MapId példa   = " ++ show (bizMapId [Nulla, Egy, Nulla]))
