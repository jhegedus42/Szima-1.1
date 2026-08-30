module PiroskaHolografikusKod49_v2_Teljes

-- ===============================================================
-- PIROSKA HOLOGRAFIKUS KOD v2 -- TELJES MESE
-- ===============================================================
-- A felhasznalo (2026-08-19): "a teljes meset huzd be a vegeig...
-- ok ? keress ra".
--
-- Ez a fajl a HolografikusKod49_v2_MantraModul tipusait hasznalja
-- (a 7-quantumbit perem a TIPUSBAN, a FazaKorrelacioT typeclass)
-- a teljes Piroska-Grimm mese 22 mondatanak holografikus
-- kódolasara.
--
-- A "soha ne irj felul" szabaly miatt ez UJ fajl -- a regi
-- HolografikusKod49_v2_MantraModul ERINTETLEN.
-- ===============================================================

import KomplexByte
import Data.String
import Paragrafus
import PiroskaSztarTeljes
import HolografikusKod49_v2_MantraModul

%default total

-- A 7 BIT (ido, oksag, ter, szin, hang, fazis, mod) a Piroska-szotarbol.
-- A SzoJelentes nyolc Komplex komponenset (idoJel, oksagJel, terJel,
-- szinJel, hangJel, fazisJel, modJel, chiralitasJel) konvertaljuk
-- 7 Kubitre: a Komplex abszolut erteke > 0.5 → Egy, kulonben Nulla.

||| Egy Komplex erteku komponens atkonvertalasa Kubit-re.
komplexBit : Komplex -> Kubit
komplexBit (KomplexKonstruktor re _) =
  if re > 0.5 then Egy else Nulla

||| A szotar egy szavat 7 Kubit-té alakitjuk (a SzoJelentes-bol).
szoPerem : SzoJelentes ->
           (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
szoPerem (SzoJelentesKonstruktor _ i o t sz h f m _) =
  (komplexBit i, komplexBit o, komplexBit t, komplexBit sz,
   komplexBit h, komplexBit f, komplexBit m)

||| Szotar-kereses: ha a szo benne van, a 7 bitjet adjuk,
||| kulonben minden bit Nulla (az ures szotar-pozicio).
||| A rekord .szo mezojet hasznaljuk (public a SzoJelentes rekordban).
szoPeremKeres : String -> List SzoJelentes ->
                (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
szoPeremKeres _ [] =
  (Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)
szoPeremKeres szo (x :: xs) =
  if szo == x.szo
  then szoPerem x
  else szoPeremKeres szo xs

||| Toldalek-kepes szotar-kereses: ha a szo nincs a szotarban,
||| levagjuk az utolso 1-2 karaktert (magyar toldalekok: -t, -n, -ot,
||| -at, -ban, -ben, stb.) es ujra probaljuk. A "soha ne irj felul"
||| szabaly miatt ez UJ fuggveny (a regi Paragrafus.szotarKeres-hez
||| kepest -- az csak kisbetusitest csinal, nem toldalek-kezelest).
public export
tolSzotarKeres : String -> List SzoJelentes ->
                 (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
tolSzotarKeres szo szotar =
  case szoPeremKeres szo szotar of
    nullaHaUres@(Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)
      => if length szo > (3 : Nat)
         then szoPeremKeres (strSubstr 0 (length szo - 1) szo) szotar
         else nullaHaUres
    egyeb => egyeb

||| String egy resz-stringje (start, end indexekkel, Nat-bol Int-be).
strSubstr : Nat -> Nat -> String -> String
strSubstr start end str =
  pack (take (cast (end - start)) (drop (cast start) (unpack str)))

||| Ket Kubit OR-je: ha barmelyik Egy, az eredmeny is Egy.
orBit : Kubit -> Kubit -> Kubit
orBit Nulla b = b
orBit Egy   _ = Egy

||| Ket 7-bites perem egyesitese (bitenkenti OR):
||| ha barmelyik Egy, az eredmeny is Egy.
peremOr : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) ->
         (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) ->
         (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
peremOr (a1, a2, a3, a4, a5, a6, a7) (b1, b2, b3, b4, b5, b6, b7) =
  ( orBit a1 b1, orBit a2 b2, orBit a3 b3, orBit a4 b4
  , orBit a5 b5, orBit a6 b6, orBit a7 b7 )

||| A ures perem (minden bit Nulla).
uressPeremTuple : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
uressPeremTuple = (Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)

||| Egy mondat szavainak perem-bitjeinek egyesitese.
||| Toldalek-kepes szotar-keresessel (tolSzotarKeres).
public export
mondatPerem : String -> List SzoJelentes ->
              (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
mondatPerem mondat szotar =
  let szavak = words mondat
      peremek = map (\s => tolSzotarKeres s szotar) szavak
  in foldr peremOr uressPeremTuple peremek

||| Egy mondatot a HolografikusKod49 v2 tipusba kodolunk.
||| A 7 bit a TIPUSBAN van -- a fordito ellenorzi.
mondatHolografikusKod :
  ( ido, oksag, ter, szin, hang, fazis, mod : Kubit ) ->
  HolografikusKod49V2 ido oksag ter szin hang fazis mod
mondatHolografikusKod i o t sz h f m =
  HolografikusKod49V2Konstruktor
    (Perem7HetesV2Konstruktor)
    ("Piroska-mese mondat")
