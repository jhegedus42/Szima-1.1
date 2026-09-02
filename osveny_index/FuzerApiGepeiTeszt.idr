module FuzerApiGepeiTeszt

-- ═══════════════════════════════════════════════════════════════
-- FÜZÉR-API GÉPI TESZT (000.04 — §N14/3 numerikus + §N14/5 táblázat)
-- / 串API机检 / Füzér-API-Maschinentest / בדיקת מכונה ל-API של הפוזר ═══
-- ═══════════════════════════════════════════════════════════════

import Alap.CsomagoltTipusok
import Alap.Hatar
import LimitKolimitPilota

main : IO ()
main = do
  putStrLn ""
  putStrLn "═══ FÜZÉR-API GÉPI TESZT (000.04) ═══"
  putStrLn ""
  putStrLn "1. a hossz-additivitás (18+18 = 18+18):"
  határKiírás (megjelenít (egyenlőE
    (füzérHossz (füzérFűzés mindA18Esetrag mindA18Esetrag))
    (sorÖsszeadás (füzérHossz mindA18Esetrag) (füzérHossz mindA18Esetrag))))
  putStrLn "2. a tagság: hét eleme a szám137 jegyeinek:"
  határKiírás (megjelenít (füzérEleme SzámjegyHét (számjegyei szám137)))
  putStrLn "3. a tagság: kettő NEM eleme a szám137 jegyeinek:"
  határKiírás (megjelenít (füzérEleme SzámjegyKettő (számjegyei szám137)))
  putStrLn "4. a fordítás első eleme (137 → hét):"
  case füzérElső (füzérFordít (számjegyei szám137)) of
    Csak jegy => határKiírás (megjelenít (jegybőlSor jegy))
    Semmi => putStrLn "—"
  putStrLn "5. a fordítás első eleme (240 → nulla):"
  case füzérElső (füzérFordít (számjegyei szám240)) of
    Csak jegy => határKiírás (megjelenít (jegybőlSor jegy))
    Semmi => putStrLn "—"
  putStrLn "6. a hajtás: TárgyRag benne van a 18 esetragban:"
  határKiírás (megjelenít (füzérHajtás
    (\x => \eddig => vagyIgazsággal (egyenlőE x TárgyRag) eddig)
    Hamis mindA18Esetrag))
  putStrLn "7. a hajtás: nyolcas NINCS a szám137 jegyeiben:"
  határKiírás (megjelenít (füzérHajtás
    (\x => \eddig => vagyIgazsággal (egyenlőE x SzámjegyNyolc) eddig)
    Hamis (számjegyei szám137)))
  putStrLn "8. az idegen név torzítás nélkül (awodey):"
  határKiírás awodeySzó
  putStrLn ""
  putStrLn "═══ ═══ ═══"