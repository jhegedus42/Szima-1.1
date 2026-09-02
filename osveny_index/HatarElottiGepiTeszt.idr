module HatarElottiGepiTeszt

-- ─────────────────────────────────────────────────────────────────────
-- ELAVULT (2026-09-02, 000.02 lépés): a szerepét az Alap.Hatar vette át
-- (digráf-barát betűKarakterlánca-val és a teljes Határ-API-val).
-- MEGŐRIZVE a MANTRA szerint (nem törlünk) — a 500.01-es archiválási
-- lépés során kerül a tanulsagok/ anyag közé. A regressziós kimenetek
-- a HatarGepeiTeszt-féle új tesztbe költöztek (000.03+).
-- ─────────────────────────────────────────────────────────────────────
import Alap.CsomagoltTipusok

||| A betű grafémája (kisbetűs) — határ-konverzió (Betű → Char).
betűbölKarakter : Betű -> Char
betűbölKarakter ABetű = 'a'
betűbölKarakter ÁBetű = 'á'
betűbölKarakter BBetű = 'b'
betűbölKarakter CBetű = 'c'
betűbölKarakter CsBetű = 'c'
betűbölKarakter DBetű = 'd'
betűbölKarakter DzBetű = 'd'
betűbölKarakter DzsBetű = 'd'
betűbölKarakter EBetű = 'e'
betűbölKarakter ÉBetű = 'é'
betűbölKarakter FBetű = 'f'
betűbölKarakter GBetű = 'g'
betűbölKarakter GyBetű = 'g'
betűbölKarakter HBetű = 'h'
betűbölKarakter IBetű = 'i'
betűbölKarakter ÍBetű = 'í'
betűbölKarakter JBetű = 'j'
betűbölKarakter KBetű = 'k'
betűbölKarakter LBetű = 'l'
betűbölKarakter LyBetű = 'l'
betűbölKarakter MBetű = 'm'
betűbölKarakter NBetű = 'n'
betűbölKarakter NyBetű = 'n'
betűbölKarakter OBetű = 'o'
betűbölKarakter ÓBetű = 'ó'
betűbölKarakter ÖBetű = 'ö'
betűbölKarakter ŐBetű = 'ő'
betűbölKarakter PBetű = 'p'
betűbölKarakter QBetű = 'q'
betűbölKarakter RBetű = 'r'
betűbölKarakter SBetű = 's'
betűbölKarakter SzBetű = 's'
betűbölKarakter TBetű = 't'
betűbölKarakter TyBetű = 't'
betűbölKarakter UBetű = 'u'
betűbölKarakter ÚBetű = 'ú'
betűbölKarakter ÜBetű = 'ü'
betűbölKarakter ŰBetű = 'ű'
betűbölKarakter VBetű = 'v'
betűbölKarakter WBetű = 'w'
betűbölKarakter XBetű = 'x'
betűbölKarakter YBetű = 'y'
betűbölKarakter ZBetű = 'z'
betűbölKarakter ZsBetű = 'z'

||| Szöveg → String — a HATÁR-átjáró (az egyetlen String a rendszerben).
szövegbőlKarakterlánc : Szöveg -> String
szövegbőlKarakterlánc ÜresSzöveg = ""
szövegbőlKarakterlánc (BetűtFűz b tovább) =
  strCons (betűbölKarakter b) (szövegbőlKarakterlánc tovább)

main : IO ()
main = do
  putStrLn "─── A CSOMAGOLTTÍPUSOK GÉPI ELLENŐRZÉSE (000.01) ───"
  putStrLn ("7 + 1  = " ++ szövegbőlKarakterlánc (megjelenít (sorÖsszeadás sorHét sorEgy)))
  putStrLn ("2 x 5  = " ++ szövegbőlKarakterlánc (megjelenít (sorSzorzás sorKettő sorÖt)))
  putStrLn ("esetragok szama = " ++ szövegbőlKarakterlánc (megjelenít (füzérHossz mindA18Esetrag)))
  putStrLn ("'ban' vegzodik 'n'-nel: " ++ szövegbőlKarakterlánc (megjelenít (végEgyezzik
    (BetűtFűz BBetű (BetűtFűz ABetű (BetűtFűz NBetű ÜresSzöveg)))
    (BetűtFűz NBetű ÜresSzöveg))))
  putStrLn ("a 18 esetrag: " ++ szövegbőlKarakterlánc (megjelenít mindA18Esetrag))
  putStrLn ("normalizal(+[0,2,4]) = +[2,4] : " ++ szövegbőlKarakterlánc (megjelenít
    (egyenlőE (számjegyei (normalizál (SzámjegyesSzámKonstruktor PozitívElőjel
      (Fűzés SzámjegyNulla (Fűzés SzámjegyKettő (Fűzés SzámjegyNégy FüzérVége))))))
      (Fűzés SzámjegyKettő (Fűzés SzámjegyNégy FüzérVége)))))
  putStrLn ("Pi jele: " ++ szövegbőlKarakterlánc (matematikaiKonstansJeLe PiSzimbólum))
  putStrLn "─── KESZ — a modul nemcsak fordul, hanem SZAMIT ───"
