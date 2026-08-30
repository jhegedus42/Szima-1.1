module FuttatoKetoldaliKategoria

-- §18(b) futtató: a kimerítő ellenőrzés kiértékelése (a bizonyítás-
-- TÍPUSOK nem show-olhatók — értékeket írunk ki).
import KetoldaliKategoria_v3
import KomplexByte

main : IO ()
main = do
  putStrLn ("termeszetesTranszformacioKimerito = " ++ show természetesTranszformációKimerítő ++ "  (várható: True)")
  putStrLn ("dualitas Nulla = " ++ show (dualitas Nulla) ++ "  (várható: Egy)")
  putStrLn ("kubitFuggvenyek szama = 4; listak hosszig 6 = " ++ show (length (összesKubitLista 6)) ++ "  (várható: 127)")
