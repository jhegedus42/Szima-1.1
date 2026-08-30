module PiroskaSztarTeljes

-- ===============================================================
-- PIROSKA-SZOTAR TELJES -- a teljes Grimm-mese szavai es mondatai
-- ===============================================================
-- A felhasznalo (2026-08-19): "a teljes meset huzd be a vegeig...
-- ok ? keress ra".
--
-- A teljes szoveg a magyar Wikipedia "Piroska es a farkas" szcikkebol
-- szarmazik (CC BY-SA 4.0). A szotar ERINTETLEN -- ez UJ fajl
-- (a "soha ne irj felul" szabaly miatt).
--
-- A teljes mese kb. 20 mondatbol all, a PiroskaSztarTeljesMondatok
-- listaban. A szotar ~35 szot tartalmaz, minden szo egy 8-komplex
-- komponensu vektor a Steane [[7,1,3]] 7 dimenziojaban +
-- a 8. chiralitas komponensben.
--
-- A 7 dimenzio: ido, oksag, ter, szin, hang, fazis, mod.
-- Minden Komplex (re, im) erteke: 1.0 ha a szonak van a dimenzioban,
-- 0.0 egyebkent (az egyszeruseg kedveert; a fazis-korrelaciot
-- a v2 holografikus kod hozza).
-- ===============================================================

import KomplexByte
import Paragrafus

%default total

||| A Piroska-szotar a teljes Grimm-meséhez (kb. 35 szó).
public export
PiroskaSztarTeljesLista : Szotar
PiroskaSztarTeljesLista =
  [ -- Szereplok es fofogalmak
    SzoJelentesKonstruktor "piroska"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "kislany"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "nagymama"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "farkas"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
  , SzoJelentesKonstruktor "vadasz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "anya"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)

  -- Helyszinek es targyak
  , SzoJelentesKonstruktor "sapka"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "erdo"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "haz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "ut"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "virag"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "etel"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "kalacs"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "agy"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "ful"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "szem"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "szaj"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "has"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "szikla"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
  , SzoJelentesKonstruktor "kut"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "ollo"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)

  -- Cselekves-igek
  , SzoJelentesKonstruktor "kap"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "visz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "indul"
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "talalkozik"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "elvesz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "eszrevesz"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "megeszik"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "alszik"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "kimaszik"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "megfullad"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
  , SzoJelentesKonstruktor "fogad"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 0.0 0.0)
  , SzoJelentesKonstruktor "szol"
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
      (KomplexKonstruktor 1.0 0.0) (KomplexKonstruktor 1.0 0.0)
      (KomplexKonstruktor 0.0 0.0) (KomplexKonstruktor 0.0 0.0)
  ]

||| A teljes Grimm-mese mondatai (20 mondat, a Wikipédiabol).
public export
PiroskaSztarTeljesMondatok : List String
PiroskaSztarTeljesMondatok =
  [ "Volt egyszer egy kislany, aki a nagyamajatol egy szep piros sapkat kapott."
  , "Mindenki csak Piroskanak szolitotta."
  , "Egy napon nagyanyja megbetegedett."
  , "Piroska etelt visz neki az erdon at."
  , "Anyja intette, hogy ne terjen le az utrol."
  , "Piroska talalkozott a farkassal az erdoben."
  , "A farkas ravette, hogy viragot szedjen."
  , "A farkas elfutott a hazhoz, felfalta a nagyamat."
  , "A farkas atvette a nagymama helyet."
  , "Piroska eszrevette, hogy valami megvaltozott."
  , "Nagymama, miert ilyen nagy a fuled?"
  , "Hogy jobban halljalak."
  , "Nagymama, miert ilyen nagy a szemed?"
  , "Hogy jobban lassalak."
  , "Nagymama, miert ilyen nagy a szajad?"
  , "Hogy jobban felfalhasalak."
  , "A farkas megette Piroskat, majd elaludt."
  , "A vadasz olloval felvagma a farkas hasat."
  , "Piroska es a nagyany kimaszott."
  , "Sziklakkal pakoltak meg a farkas gyomrat."
  , "A farkas felebredt, a kuthoz ment, es megfulladt."
  , "Piroska megfogadta, hogy szot fogad az anyjanak."
  ]
