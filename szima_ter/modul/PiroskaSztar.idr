module PiroskaSztar

-- ===============================================================
-- PIROSKA-SZOTAR -- a teljes Piroska-es a farkas mese szavai
-- ===============================================================
-- A felhasznalo (2026-08-19): "huzd be a piroska es a farkas meset
-- konkretan".
--
-- Ez a fajl a szima_ter uj Piroska-szotara, ami a teljes meset
-- kodolja. A regi Peldaszotar (4 szo) ERINTETLEN -- a "soha ne irj
-- felul" szabaly miatt ez UJ fajl.
--
-- A szavak a Steane [[7,1,3]] 7 dimenziojaban (ido, oksag, ter, szin,
-- hang, fazis, mod) + a 8. chiralitas komponensben kapnak
-- egy-egy 8-komplex komponensu vektort.
--
-- A 12 szo a mese 5 mondatat fedi le:
--   1. "Piroska viszi a kalacsot a nagyanyjahoz."
--   2. "Az erdoen talalkozik a farkassal."
--   3. "A farkas megkerdezi, hova megy."
--   4. "Piroska elmondja az igazat."
--   5. "A farkas hamis tanacsot ad."
-- ===============================================================

import KomplexByte
import Paragrafus

%default total

-- A 12 szo a Steane 7 dimenziojaban (ido, oksag, ter, szin, hang, fazis, mod)
-- + a 8. (chiralitas, γ⁵) komponensben. Minden szo 8 kulon Komplex
-- argumentumot kap a SzoJelentesKonstruktor-nak.

||| A Piroska-szotar: a teljes mese 12 szava.
public export
PiroskaSztarLista : Szotar
PiroskaSztarLista =
  [ -- 1. mondat: "Piroska viszi a kalacsot a nagyanyjahoz."
    SzoJelentesKonstruktor
      "piroska"
      (KomplexKonstruktor 1.0 0.0)  -- ido
      (KomplexKonstruktor 0.0 0.0)  -- oksag
      (KomplexKonstruktor 0.0 0.0)  -- ter
      (KomplexKonstruktor 1.0 0.0)  -- szin (piros)
      (KomplexKonstruktor 0.0 0.0)  -- hang
      (KomplexKonstruktor 0.0 0.0)  -- fazis
      (KomplexKonstruktor 0.0 0.0)  -- mod
      (KomplexKonstruktor 0.0 0.0)  -- chiralitas
  , SzoJelentesKonstruktor
      "viszi"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "kalacs"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "nagyany"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)

  -- 2. mondat: "Az erdoen talalkozik a farkassal."
  , SzoJelentesKonstruktor
      "erdo"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "talalkozik"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "farkas"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)

  -- 3. mondat: "A farkas megkerdezi, hova megy."
  , SzoJelentesKonstruktor
      "megkerdezi"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "hova"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "megy"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)

  -- 4. mondat: "Piroska elmondja az igazat."
  , SzoJelentesKonstruktor
      "elmondja"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "igazat"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)

  -- 5. mondat: "A farkas hamis tanacsot ad."
  , SzoJelentesKonstruktor
      "hamis"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor
      "tanacsot"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  ]

-- A teljes Piroska-mese 5 mondata.

||| A Piroska-mese 5 mondata (a kodolashoz).
public export
PiroskaMese : List String
PiroskaMese =
  [ "Piroska viszi a kalacsot a nagyanyjahoz."
  , "Az erdoen talalkozik a farkassal."
  , "A farkas megkerdezi, hova megy."
  , "Piroska elmondja az igazat."
  , "A farkas hamis tanacsot ad."
  ]
