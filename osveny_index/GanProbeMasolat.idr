module GanProbeMasolat

import Alap.CsomagoltTipusok
import Alap.Hatar

main : IO ()
main = do
  határKiírás (megjelenít (egyenlőE
    (füzérHossz (füzérFűzés mindA18Esetrag mindA18Esetrag))
    (sorÖsszeadás (füzérHossz mindA18Esetrag) (füzérHossz mindA18Esetrag))))
  putStrLn "vege"
