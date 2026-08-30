module Magyar

import Data.String
import Data.List

-- =====================================================================
-- Magyar morfológiai elemző Idrisben.
-- A baby-AI / Stabilizátor keretrendszerhez építve.
--
-- A magyar agglutináló nyelv: tő + toldalék1 + toldalék2 + ...
-- Minden toldalék a 6 generátor egyikét aktiválja:
--   g1 = hangzó harmónia / tér   (bit 0)
--   g2 = határozottság            (bit 1)
--   g3 = szám                     (bit 2)
--   g4 = idő / igeidő            (bit 3)
--   g5 = mód                      (bit 4)
--   g6 = birtoklás                (bit 5)
--
-- A CPT maszk = g1 `xor` g4 `xor` g6 = bitek 0,3,5 = 37.
-- =====================================================================

||| Hangzóharmónia osztály.
public export
data Hangharmonia = Hatter | Elolo | Vegyes

public export
Show Hangharmonia where
  show Hatter  = "Hátul"
  show Elolo   = "Elől"
  show Vegyes  = "Vegyes"

||| Egy karakter magánhangzó-e? Visszaadja a magánhangzót vagy Nothing.
isMagHangzo : Char -> Maybe Char
isMagHangzo c =
  if elem c (unpack "aáeéiíoóöőuúüű")
     then Just c
     else Nothing

||| Egyetlen magánhangzó hangzóharmóniája.
magHangzoHarmonia : Char -> Hangharmonia
magHangzoHarmonia c =
  if elem c (unpack "aáoóuú")      then Hatter
  else if elem c (unpack "eéiíöőüű") then Elolo
  else Vegyes

||| Lista utolsó eleme (biztonságos).
utolsoBiztos : List a -> Maybe a
utolsoBiztos [] = Nothing
utolsoBiztos [x] = Just x
utolsoBiztos (x :: xs) = utolsoBiztos xs

||| A teljes szó hangzóharmóniája (az utolsó magánhangzó dönt).
public export
szHarmonia : String -> Hangharmonia
szHarmonia s =
  let mh = mapMaybe isMagHangzo (unpack s)
  in case utolsoBiztos mh of
       Nothing => Vegyes
       Just v  => magHangzoHarmonia v

-- =====================================================================
-- Toldalék táblázat: (toldalék_string, feature bitek)
-- A feature bitek azt jelölik, mely generátorok aktívak.
-- =====================================================================

||| Toldalék bejegyzés: string alak + feature maszk.
public export
record Toldalek where
  constructor MkToldalek
  told    : String
  feat    : Nat       -- bit minta: g1=1, g2=2, g3=4, g4=8, g5=16, g6=32
  nev     : String    -- nyelvtani címke, pl. "Tb", "Acc", "Iness"

||| Magyar névszói toldalékok, hátsó magánhangzós először.
public export
toldalekok : List Toldalek
toldalekok =
  -- 5 betűs toldalékok
  [ MkToldalek "jatok" 16 "Imp2Tb"
  , MkToldalek "ötök"  32 "Birt2Tb(elore)"
  -- 4 betűs toldalékok
  , MkToldalek "otok" 32 "Birt2Tb(hatul)"
  , MkToldalek "etek" 32 "Birt2Tb(elore)"
  -- 3 betűs toldalékok
  , MkToldalek "ban" 1  "Iness(hatul)"
  , MkToldalek "ben" 1  "Iness(elore)"
  , MkToldalek "ból" 1  "El(hatul)"
  , MkToldalek "ből" 1  "El(elore)"
  , MkToldalek "ról" 1  "Del(hatul)"
  , MkToldalek "ről" 1  "Del(elore)"
  , MkToldalek "hoz" 1  "Allat(hatul)"
  , MkToldalek "hez" 1  "Allat(elore)"
  , MkToldalek "höz" 1  "Allat(elore)"
  , MkToldalek "nál" 1  "Ade(hatul)"
  , MkToldalek "nél" 1  "Ade(elore)"
  , MkToldalek "tól" 1  "Abl(hatul)"
  , MkToldalek "től" 1  "Abl(elore)"
  , MkToldalek "nak" 1  "Dat(hatul)"
  , MkToldalek "nek" 1  "Dat(elore)"
  , MkToldalek "val" 1  "Instr(hatul)"
  , MkToldalek "vel" 1  "Instr(elore)"
  , MkToldalek "ért" 1  "Caus"
  , MkToldalek "nák" 24 "CondTb(hatul)"
  , MkToldalek "nék" 24 "CondTb(elore)"
  , MkToldalek "junk" 16 "Imp1Tb"
  -- 2 betűs toldalékok
  , MkToldalek "ok"  4  "Tb(hatul)"
  , MkToldalek "ök"  4  "Tb(elore)"
  , MkToldalek "ek"  4  "Tb(elore)"
  , MkToldalek "ak"  4  "Tb(hatul)"
  , MkToldalek "ot"  2  "Acc(hatul)"
  , MkToldalek "et"  2  "Acc(elore)"
  , MkToldalek "öt"  2  "Acc(elore)"
  , MkToldalek "at"  2  "Acc(hatul)"
  , MkToldalek "ba"  1  "Ill(hatul)"
  , MkToldalek "be"  1  "Ill(elore)"
  , MkToldalek "on"  1  "Sup(hatul)"
  , MkToldalek "en"  1  "Sup(elore)"
  , MkToldalek "ön"  1  "Sup(elore)"
  , MkToldalek "ra"  1  "Subl(hatul)"
  , MkToldalek "re"  1  "Subl(elore)"
  , MkToldalek "vá"  1  "Trans(hatul)"
  , MkToldalek "vé"  1  "Trans(elore)"
  , MkToldalek "om"  32 "Birt1E(hatul)"
  , MkToldalek "em"  32 "Birt1E(elore)"
  , MkToldalek "od"  32 "Birt2E(hatul)"
  , MkToldalek "ed"  32 "Birt2E(elore)"
  , MkToldalek "ja"  32 "Birt3E(hatul)"
  , MkToldalek "je"  32 "Birt3E(elore)"
  , MkToldalek "unk" 32 "Birt1T(hatul)"
  , MkToldalek "ünk" 32 "Birt1T(elore)"
  , MkToldalek "juk" 32 "Birt3T(hatul)"
  , MkToldalek "jük" 32 "Birt3T(elore)"
  , MkToldalek "ni"   8  "Inf"
  , MkToldalek "tt"   8  "Mult"
  , MkToldalek "ná"   24 "Cond(hatul)"
  , MkToldalek "né"   24 "Cond(elore)"
  , MkToldalek "ig"   1  "Term"
  , MkToldalek "tok"  8  "Pres2Tb"
  -- 1 betűs toldalékok (lege rövidebb, utolsó próbálkozás)
  , MkToldalek "k"   4  "Tb"
  , MkToldalek "t"   2  "Acc"
  , MkToldalek "n"   1  "Sup"
  , MkToldalek "j"   16 "Imp"
  ]

-- =====================================================================
-- Lehúzó algoritmus: megpróbáljuk lehúzni a toldalékokat a végéről.
-- =====================================================================

||| Természetes kivonás 0-ba korlátozva.
natMinus : Nat -> Nat -> Nat
natMinus Z _ = 0
natMinus n Z = n
natMinus (S n) (S m) = natMinus n m

||| Megpróbál egy ismert toldalékot lehúzni a szó végéről.
||| Visszaadja a (tő, toldalék) párt siker esetén.
tryStrip : String -> List Toldalek -> Maybe (String, Toldalek)
tryStrip szo [] = Nothing
tryStrip szo (t :: ts) =
  if isSuffixOf (told t) szo
     then let rLen = length szo `natMinus` length (told t)
          in Just (substr 0 rLen szo, t)
     else tryStrip szo ts

||| Morfológiai elemzés eredménye.
public export
record Elemzes where
  constructor MkElemzes
  torzs      : String
  szegmensek : List (Toldalek, String)   -- toldalék + a lefedett részszó
  teljesFeat : Nat
  harmonia   : Hangharmonia

||| Minimális tő hossz: ha a tő rövidebb, nem húzunk le többet.
minTorzs : Nat
minTorzs = 3

||| Egy szó elemzése: legfeljebb 3 toldalék lehúzása.
||| Leáll, ha a tő rövidebb lenne mint minTorzs vagy nincs toldalék egyezés.
public export
elemzes : String -> Elemzes
elemzes szo = elemzesN 3 szo [] 0
  where
    elemzesN : Nat -> String -> List (Toldalek, String) -> Nat -> Elemzes
    elemzesN Z t s f = MkElemzes t (reverse s) f (szHarmonia t)
    elemzesN (S k) sz s f =
      if length sz <= minTorzs
         then MkElemzes sz (reverse s) f (szHarmonia sz)
         else case tryStrip sz toldalekok of
                Nothing => MkElemzes sz (reverse s) f (szHarmonia sz)
                Just (maradek, t) =>
                  if length maradek < minTorzs
                     then MkElemzes sz (reverse s) f (szHarmonia sz)
                     else elemzesN k maradek ((t, told t) :: s) (f + feat t)

||| Elemzés kiírása.
public export
showElemzes : Elemzes -> String
showElemzes e =
  let szStrs = map (\x => nev (fst x) ++ "(" ++ snd x ++ ")") (szegmensek e)
  in "tő=" ++ torzs e
      ++ "  harmonia=" ++ show (harmonia e)
      ++ "  feat=" ++ show (teljesFeat e)
      ++ "  szegmensek=" ++ show szStrs
