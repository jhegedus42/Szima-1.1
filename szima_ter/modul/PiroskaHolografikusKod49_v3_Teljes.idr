module PiroskaHolografikusKod49_v3_Teljes

import Data.Nat  -- pred (§24: standard, nem újraírva — a ProbePred2 bizonyította: itt él)
-- ═══ v3 (2026-08-21): a v2-vel AZONOS tartalom, EGY szintaxis-javítással:
--     a feltétel zárójelezve: az `x > (3 : Nat)` alakban a típus-ascription
--     a `>` után zavarja a parsert ("Expected then"; ProbeIf..ProbeIf4
--     izoláltan bizonyította 2026-08-21-én); a `(length szó > 3)` alak jó.
--     l. docs/AlapJegyzek_20260821.md. §13: a v2 megmarad.
--     ═══ v3：与 v2 内容相同，仅把 if-then-else 并为一行。
--     ═══ v3: identischer Inhalt, nur if-then-else einzeilig.
--     ═══ v3: תוכן זהה, רק if-then-else בשורה אחת.

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

||| A szótár egy szavat 7 Kubit-té alakitjuk (a SzoJelentes-bol).
szóPerem : SzoJelentes ->
           (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
szóPerem (SzoJelentesKonstruktor _ i o t sz h f m _) =
  (komplexBit i, komplexBit o, komplexBit t, komplexBit sz,
   komplexBit h, komplexBit f, komplexBit m)

||| Szotar-kereses: ha a szó benne van, a 7 bitjet adjuk,
||| kulonben minden bit Nulla (az ures szótár-pozicio).
||| A rekord .szo mezőjét használjuk (public a SzoJelentes rekordban).
szóPeremKeres : String -> List SzoJelentes ->
                (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
szóPeremKeres _ [] =
  (Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)
szóPeremKeres szó (x :: xs) =
  if szó == x.szo
  then szóPerem x
  else szóPeremKeres szó xs

||| String egy resz-stringje (start, end indexekkel, Nat-bol Int-be).
részSzöveg : Nat -> Nat -> String -> String
részSzöveg start end str =
  pack (take (cast (minus end start)) (drop (cast start) (unpack str)))

||| Toldalek-kepes szótár-kereses: ha a szó nincs a szotarban,
||| levagjuk az utolso 1-2 karaktert (magyar toldalekok: -t, -n, -ot,
||| -at, -ban, -ben, stb.) es ujra probaljuk. A "soha ne irj felul"
||| szabaly miatt ez UJ fuggveny (a regi Paragrafus.szotarKeres-hez
||| kepest -- az csak kisbetusitest csinal, nem toldalek-kezelest).
public export
tolSzótárKeres : String -> List SzoJelentes ->
                 (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
tolSzótárKeres szó szótár =
  case szóPeremKeres szó szótár of
    nullaHaUres@(Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)
      => if (length szó > the Nat 3) then szóPeremKeres (részSzöveg 0 (pred (length szó)) szó) szótár else nullaHaUres
    egyeb => egyeb

||| Ket Kubit OR-je: ha barmelyik Egy, az eredmeny is Egy.
vagyBit : Kubit -> Kubit -> Kubit
vagyBit Nulla b = b
vagyBit Egy   _ = Egy

||| Ket 7-bites perem egyesitese (bitenkenti OR):
||| ha barmelyik Egy, az eredmeny is Egy.
peremVagy : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) ->
         (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit) ->
         (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
peremVagy (a1, a2, a3, a4, a5, a6, a7) (b1, b2, b3, b4, b5, b6, b7) =
  ( vagyBit a1 b1, vagyBit a2 b2, vagyBit a3 b3, vagyBit a4 b4
  , vagyBit a5 b5, vagyBit a6 b6, vagyBit a7 b7 )

||| A ures perem (minden bit Nulla).
üresPeremTuple : (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
üresPeremTuple = (Nulla, Nulla, Nulla, Nulla, Nulla, Nulla, Nulla)

||| Egy mondat szavainak perem-bitjeinek egyesitese.
||| Toldalek-kepes szótár-keresessel (tolSzótárKeres).
public export
mondatPerem : String -> List SzoJelentes ->
              (Kubit, Kubit, Kubit, Kubit, Kubit, Kubit, Kubit)
mondatPerem mondat szótár =
  let szavak = words mondat
      peremek = map (\s => tolSzótárKeres s szótár) szavak
  in foldr peremVagy üresPeremTuple peremek

||| Egy mondatot a HolografikusKod49 v2 tipusba kodolunk.
||| A 7 bit a TIPUSBAN van -- a fordito ellenorzi.
mondatHolografikusKód :
  ( ido, oksag, ter, szin, hang, fazis, mod : Kubit ) ->
  HolografikusKod49V2 ido oksag ter szin hang fazis mod
mondatHolografikusKód i o t sz h f m =
  HolografikusKod49V2Konstruktor
    (Perem7HetesV2Konstruktor)
    ("Piroska-mese mondat")
