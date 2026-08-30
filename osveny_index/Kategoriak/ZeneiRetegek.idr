module Kategoriak.ZeneiRetegek

import Steane713

-- ═══════════════════════════════════════════════════════════════
-- ZENEI RÉTEG — HANGOK + RITMUS + DALLAM
-- ═══════════════════════════════════════════════════════════════
-- A dalok és versek 7 bites [[7,1,3]] kódja mellett a zenei réteg:
--   hangok : a hangközök (Clifford-szorzat = hang a keretben)
--   ritmus : a metrika (az idő szerkezete = T dimenzió)
--   dallam : a dallamvonal iránya (a fázis kiterjedése)
-- A 7 bit zenei altere: [hang, fazis, ido] → [hangok, dallam, ritmus]
-- A hangközök a ZeneKategoria 5 prímje (2/1, 3/2, 5/4, 7/4, 10/1).

public export
data Hangkozi = OktavH | KvintH | TercH | SzeptimH | UndeciumH

public export
Show Hangkozi where
  show OktavH = "oktav(2/1)"
  show KvintH = "kvint(3/2)"
  show TercH = "terc(5/4)"
  show SzeptimH = "szeptim(7/4)"
  show UndeciumH = "undecium(10/1)"

public export
data Ritmus = Idomertekes | UtemHangsulyos | Szimultan | SzabadVers

public export
Show Ritmus where
  show Idomertekes = "idomertekes (T-ep)"
  show UtemHangsulyos = "utemhangsulyos (P-broken)"
  show Szimultan = "szimultan (fazisatmenet)"
  show SzabadVers = "szabadvers (dekoherens)"

public export
data DallamIrany = Emelkedo | Ereszkedo | Sik

public export
Show DallamIrany where
  show Emelkedo = "emelkedo (fel)"
  show Ereszkedo = "ereszkedo (le)"
  show Sik = "sik (oldal)"

public export
record ZeneiRetegek where
  constructor ZeneiKonstruktor
  hangok : Hangkozi
  ritmus : Ritmus
  dallam : DallamIrany

public export
Show ZeneiRetegek where
  show (ZeneiKonstruktor h r d) =
    "hangok: " ++ show h ++ " | ritmus: " ++ show r ++ " | dallam: " ++ show d

||| A 7 bit zenei altere: (hang, fazis, ido).
||| A HetesKod 5. bitje a hang, 6. a fazis, 1. az ido.
public export
zeneiAlter : HetesKod -> (Kubit, Kubit, Kubit)
zeneiAlter (HetesKonstruktor ido _ _ _ hang fazis _) = (hang, fazis, ido)

-- ═══════════════════════════════════════════════════════════════
-- JÓZSEF ATTILA — ZENEI RÉTEGEK
-- ═══════════════════════════════════════════════════════════════

-- Óda (1933): 1111111 → zenei altér (Egy,Egy,Egy) = teljes zeneiség.
-- Szimultán verselés (ütemhangsúlyos + anapesztusos lejtés), felemelő dallam.
odaZene : ZeneiRetegek
odaZene = ZeneiKonstruktor OktavH Szimultan Emelkedo

-- Két hexameter (1936): tiszta időmértékes, a C→G kvint-eltolás itt a
-- "Mért legyek / Mért ne legyek" tükör-pár. A dallam a kérdés-felelet kvinje.
ketHexameterZene : ZeneiRetegek
ketHexameterZene = ZeneiKonstruktor KvintH Idomertekes Emelkedo

-- Reménytelenül (1933): hang=0, fazis=0 → hangtalan, törött dallam,
-- ereszkedő vonal ("hangtalan vacog").
remenytelenulZene : ZeneiRetegek
remenytelenulZene = ZeneiKonstruktor SzeptimH SzabadVers Ereszkedo

-- ═══════════════════════════════════════════════════════════════
-- MAGYAR HIMNUSZ (Kölcsey 1823, Erkel 1844) — ZENEI RÉTEG
-- ═══════════════════════════════════════════════════════════════
-- Himnusz: 1111111 → zenei altér (Egy,Egy,Egy) = teljes szentséges
-- koherencia. Mind a 7 bit Egy: az ima az időben (múlt-jelen-jövő),
-- az okságban (Isten áldása), a térben (magyar haza), a színben
-- (világosság és vér), a hangban (éneklés), a fázisban (állandó áhítat)
-- és a módban (ceremoniális) koherens.
-- A dallam a fohászkodás felfelé íve (oktáv-távolság), a vers 8.7.8.7
-- trochaikus himnusz-versidom (időmértékes alap), az ív felemelkedő.
himnuszZene : ZeneiRetegek
himnuszZene = ZeneiKonstruktor OktavH Idomertekes Emelkedo

-- ═══════════════════════════════════════════════════════════════
-- SZIÁMI — ZENEI RÉTEGEK
-- ═══════════════════════════════════════════════════════════════

-- Ne félj (1992/93): 1110111 → zenei altér (Egy,Egy,Egy) = teljes zeneiség.
-- "énekel, ugat" — a szöveg maga hangos; bátorító kvint-dallam.
neFeljZene : ZeneiRetegek
neFeljZene = ZeneiKonstruktor KvintH UtemHangsulyos Emelkedo

-- Annyit szív (1989): 1010100 → (Egy,Nulla,Egy) = hang van, dallam törött.
-- Szívdobogás-ritmus, ereszkedő, disszonáns szeptim.
annyitSzivZene : ZeneiRetegek
annyitSzivZene = ZeneiKonstruktor SzeptimH SzabadVers Ereszkedo

-- Balatoni nyár (1986): 1110001 → (Nulla,Nulla,Egy) = ritmus van.
-- Könnyed terc-dallam, nyugodt, oldalirányú vonal.
balatoniNyarZene : ZeneiRetegek
balatoniNyarZene = ZeneiKonstruktor TercH UtemHangsulyos Sik

-- ═══════════════════════════════════════════════════════════════
-- BIZONYÍTÁSOK — A ZENEI ALTÉR A 7 BITBŐL
-- ═══════════════════════════════════════════════════════════════

-- Kimenet: Refl (Óda 1111111 → zenei altér (Egy,Egy,Egy) ✓)
zeneiAlterOdaBizonyitas : zeneiAlter (HetesKonstruktor Egy Egy Egy Egy Egy Egy Egy) = (Egy, Egy, Egy)
zeneiAlterOdaBizonyitas = Refl

-- Kimenet: Refl (Annyit szív 1010100 → (Egy,Nulla,Egy) ✓)
zeneiAlterAnnyitSzivBizonyitas
  : zeneiAlter (HetesKonstruktor Egy Nulla Egy Nulla Egy Nulla Nulla) = (Egy, Nulla, Egy)
zeneiAlterAnnyitSzivBizonyitas = Refl

-- Kimenet: Refl (Himnusz 1111111 → zenei altér (Egy,Egy,Egy) ✓)
zeneiAlterHimnuszBizonyitas : zeneiAlter (HetesKonstruktor Egy Egy Egy Egy Egy Egy Egy) = (Egy, Egy, Egy)
zeneiAlterHimnuszBizonyitas = Refl

main : IO ()
main = do
  putStrLn "=== ZENEI RÉTEG: HANGOK + RITMUS + DALLAM ==="
  putStrLn "JÓZSEF ATTILA:"
  putStrLn ("  Oda (1111111):            " ++ show odaZene)
  putStrLn ("  Ket hexameter (idomertek): " ++ show ketHexameterZene)
  putStrLn ("  Remenytelenul (hangtalan): " ++ show remenytelenulZene)
  putStrLn "MAGYAR HIMNUSZ:"
  putStrLn ("  Himnusz (1111111):        " ++ show himnuszZene)
  putStrLn "SZIÁMI:"
  putStrLn ("  Ne felj (1110111):         " ++ show neFeljZene)
  putStrLn ("  Annyit sziv (1010100):     " ++ show annyitSzivZene)
  putStrLn ("  Balatoni nyar (1110001):   " ++ show balatoniNyarZene)
  putStrLn ""
  putStrLn "Bizonyitasok (Refl = a 7 bitből a zenei altér helyes):"
  putStrLn "  zeneiAlterOda        = (Egy,Egy,Egy) ✓"
  putStrLn "  zeneiAlterAnnyitSziv = (Egy,Nulla,Egy) ✓"
  putStrLn "  zeneiAlterHimnusz    = (Egy,Egy,Egy) ✓"
