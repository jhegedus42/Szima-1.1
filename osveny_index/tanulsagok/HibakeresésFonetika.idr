module HibakeresésFonetika
import Fonetika

mutual
  fo : IO ()
  fo = do
    putStrLn ("IPA kategória : " ++ magyarIPA "kategória")
    putStrLn ("IPA kutya     : " ++ magyarIPA "kutya")
    putStrLn ("IPA anya      : " ++ magyarIPA "anya")
    putStrLn ("IPA asztal    : " ++ magyarIPA "asztal")
    putStrLn ("szotag kutya  : " ++ szotagForma "kutya")
    putStrLn ("szotag anya   : " ++ szotagForma "anya")
    putStrLn ("szotag asztal : " ++ szotagForma "asztal")
    putStrLn ("szotag kateg. : " ++ szotagForma "kategória")
    putStrLn ("szotag mennyt : " ++ szotagForma "mennyezet")
    putStrLn ("IPA mennyezet : " ++ magyarIPA "mennyezet")
