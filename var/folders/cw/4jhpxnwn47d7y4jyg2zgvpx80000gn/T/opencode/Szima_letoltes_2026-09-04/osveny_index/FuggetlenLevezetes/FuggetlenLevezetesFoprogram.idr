module FuggetlenLevezetesFoprogram

import E8SteaneLevezetes
import ParitasBuborek
import AffinE8KarakterLevezetes
import MagyarTeriTetrakod

main : IO ()
main = do
  E8SteaneLevezetes.main
  putStrLn ""
  paritasBuborekJelentes
  putStrLn ""
  affinE8KarakterJelentes
  putStrLn ""
  magyarTeriTetrakodJelentes
