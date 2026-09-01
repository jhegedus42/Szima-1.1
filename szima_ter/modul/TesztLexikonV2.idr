module TesztLexikonV2

-- A 000.01 verifikációja: a HungarianLexicon_v2 szavai PUBLIKUSAK.
-- Az import után a n_abakusz közvetlenül hivatkozható.

import HungarianLexicon_v2_Szima

elsőSzó : HuWord
elsőSzó = n_abakusz

harmadikSzó : HuWord
harmadikSzó = n_abisszikus

main : IO ()
main = do
  putStrLn ("elsőSzó szövege:   " ++ huText elsőSzó)
  putStrLn ("harmadikSzó szövege: " ++ huText harmadikSzó)
  putStrLn ("lexikon mérete:      " ++ show lexiconSize)
