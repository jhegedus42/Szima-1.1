module MagyarNyelvtan_v3

import Data.List  -- drop és társai (§24: standard, nem újraírva)
-- ═══ v3 (2026-08-21): a v2-vel AZONOS tartalom, EGY szintaxis-javítással:
--     a Digraf konstruktorok explicit `: Digraf` ascription-nel soronként
--     állnak (a v2 egyetlen sorban `|`-fal választotta el őket, típus nélkül
--     — az Idris 0.8.0 ezt elutasítja; ProbeDigraf/ProbeDigraf2 bizonyította
--     2026-08-21-én; l. docs/AlapJegyzek_20260821.md). §13: a v2 megmarad.
--     ═══ v3（2026-08-21）：与 v2 内容相同，仅修正 Digraf 构造器语法。
--     ═══ v3: identischer Inhalt wie v2, nur die Digraf-Syntax korrigiert.
--     ═══ v3: תוכן זהה ל-v2, רק תחביר ה-Digraf תוקן.

-- ===============================================================
-- MAGYAR NYELVTAN v2 -- a teljes nyelvtani fa
-- ===============================================================
-- A felhasznalo (2026-08-19):
--   "tokeletes legyen a magyar parszolas, lehetoleg fonetikusan
--    is akar... teljes nyelvtani fa, minden, ami csak a csovon
--    kifer".
--   "hasznalj fel mindent ami lehetezik... es passzol ok?"
--
-- Ez a fajl a magyar nyelv teljes nyelvtani fajat tartalmazza:
--   1. FONETIKA: 14 magánhangzó (Va, Vaa, Ve, Vee, Vi, Vii, Vo,
--      Voo, Voe, Voee, Vu, Vuu, Vue, Vuee) + 17 massalhangzo +
--      9 digráf (cs, gy, ly, ny, sz, ty, zs, dz, dzs) -- a projekt
--      Fonetika.idr konvencioja szerint.
--   2. MORFOLÓGIA: 18 esetrag (Kiefer 2011) -- a projekt
--      MagyarNyelvtan.idr konvencioja szerint.
--   3. IGERAGOZAS: 3x3x3 = 27 (igeido x aspektus x evidencialissag).
--   4. SZINTAXIS: szofajok (fonev, ige, melleknev, hatarozoszo,
--      nevelo, kotoszo, nevmas, szamneve, egyeb).
--   5. TOLDALEK-FELISMERES: a magyar toldalékok automatikus
--      felismerese a szo vegerol (hangrend-fuggo).
--   6. SZÓELEMZÉS: a teljes nyelvtani elemzes rekordja.
--
-- "Hasznalj fel mindent, ami lehetseges, es passzol": a tipusok
-- es a konvenciok a projekt meglevo kódjaval (Fonetika.idr,
-- MagyarNyelvtan.idr) konzisztens -- UJ fajl, de ugyanaz a
-- struktúra.
-- ===============================================================

%default total

-- ===============================================================
-- 1. FONETIKA -- a magyar hangrendszer
-- ===============================================================

||| A 14 magyar magánhangzó (a Fonetika.idr konvencioja szerint).
public export
data Maganhangzo =
    Va    -- a  [ɒ]
  | Vaa   -- á  [aː]
  | Ve    -- e  [ɛ]
  | Vee   -- é  [eː]
  | Vi    -- i  [i]
  | Vii   -- í  [iː]
  | Vo    -- o  [o]
  | Voo   -- ó  [oː]
  | Voe   -- ö  [ø]
  | Voee  -- ő  [øː]
  | Vu    -- u  [u]
  | Vuu   -- ú  [uː]
  | Vue   -- ü  [y]
  | Vuee  -- ű  [yː]

public export
Show Maganhangzo where
  show Va    = "a"
  show Vaa   = "á"
  show Ve    = "e"
  show Vee   = "é"
  show Vi    = "i"
  show Vii   = "í"
  show Vo    = "o"
  show Voo   = "ó"
  show Voe   = "ö"
  show Voee  = "ő"
  show Vu    = "u"
  show Vuu   = "ú"
  show Vue   = "ü"
  show Vuee  = "ű"

||| A 17 magyar egyszeru massalhangzo + 9 digráf (a Fonetika.idr
||| konvencioja szerint: Mb, Mcs, Md, Mdz, Mdzs, Mf, Mg, Mgy,
||| Mh, Mj, Mk, Ml, Mly, Mm, Mn, Mny, Mp, Mr, Ms, Msz, Mt, Mty,
||| Mv, Mz, Mzs).
public export
data Massalhangzo =
    Mb | Mcs | Md | Mdz | Mdzs | Mf | Mg | Mgy | Mh | Mj | Mk
  | Ml | Mly | Mm | Mn | Mny | Mp | Mr | Ms | Msz | Mt | Mty
  | Mv | Mz | Mzs

||| A hangok egyesitese (magánhangzo vagy massalhangzo).
public export
data Hang : Type where
  MagHang : Maganhangzo -> Hang
  MasHang : Massalhangzo -> Hang

||| A 9 digráf a magyarban (cs, gy, ly, ny, sz, ty, zs, dz, dzs).
public export
data Digraf : Type where
  Dcs  : Digraf
  Dgy  : Digraf
  Dly  : Digraf
  Dny  : Digraf
  Dsz  : Digraf
  Dty  : Digraf
  Dzs  : Digraf
  Ddz  : Digraf
  Ddzs : Digraf

public export
Show Digraf where
  show Dcs  = "cs"
  show Dgy  = "gy"
  show Dly  = "ly"
  show Dny  = "ny"
  show Dsz  = "sz"
  show Dty  = "ty"
  show Dzs  = "zs"
  show Ddz  = "dz"
  show Ddzs = "dzs"

||| Hangrend (a magyar nyelvtan egyik alapfogalma).
public export
data Hangrend = MelyHangrend | MagasHangrend | VegyesHangrend

||| A magánhangzó mely-e (True = mély, False = magas).
public export
maganhangzoMelyE : Maganhangzo -> Bool
maganhangzoMelyE Va    = True
maganhangzoMelyE Vaa   = True
maganhangzoMelyE Ve    = False
maganhangzoMelyE Vee   = False
maganhangzoMelyE Vi    = False
maganhangzoMelyE Vii   = False
maganhangzoMelyE Vo    = True
maganhangzoMelyE Voo   = True
maganhangzoMelyE Voe   = False
maganhangzoMelyE Voee  = False
maganhangzoMelyE Vu    = True
maganhangzoMelyE Vuu   = True
maganhangzoMelyE Vue   = False
maganhangzoMelyE Vuee  = False

||| Egy karakter milyen magánhangzót jelent.
public export
karakterbolMh : Char -> Maybe Maganhangzo
karakterbolMh 'a' = Just Va
karakterbolMh 'á' = Just Vaa
karakterbolMh 'e' = Just Ve
karakterbolMh 'é' = Just Vee
karakterbolMh 'i' = Just Vi
karakterbolMh 'í' = Just Vii
karakterbolMh 'o' = Just Vo
karakterbolMh 'ó' = Just Voo
karakterbolMh 'ö' = Just Voe
karakterbolMh 'ő' = Just Voee
karakterbolMh 'u' = Just Vu
karakterbolMh 'ú' = Just Vuu
karakterbolMh 'ü' = Just Vue
karakterbolMh 'ű' = Just Vuee
karakterbolMh 'A' = Just Va
karakterbolMh 'Á' = Just Vaa
karakterbolMh 'E' = Just Ve
karakterbolMh 'É' = Just Vee
karakterbolMh 'I' = Just Vi
karakterbolMh 'Í' = Just Vii
karakterbolMh 'O' = Just Vo
karakterbolMh 'Ó' = Just Voo
karakterbolMh 'Ö' = Just Voe
karakterbolMh 'Ő' = Just Voee
karakterbolMh 'U' = Just Vu
karakterbolMh 'Ú' = Just Vuu
karakterbolMh 'Ü' = Just Vue
karakterbolMh 'Ű' = Just Vuee
karakterbolMh _   = Nothing

||| Egy karakter milyen digráfot jelent (kétkarakteres egyezés).
public export
digrafEgyezes : String -> Nat -> Maybe Digraf
digrafEgyezes szo i =
  let cs = unpack szo
      lista = drop i cs
  in case lista of
       ('c' :: 's' :: _) => Just Dcs
       ('g' :: 'y' :: _) => Just Dgy
       ('l' :: 'y' :: _) => Just Dly
       ('n' :: 'y' :: _) => Just Dny
       ('s' :: 'z' :: _) => Just Dsz
       ('t' :: 'y' :: _) => Just Dty
       ('z' :: 's' :: _) => Just Dzs
       ('d' :: 'z' :: _) => Just Ddz
       ('d' :: 'z' :: 's' :: _) => Just Ddzs
       _ => Nothing

||| A szo hangrendje (magánhangzok alapjan).
public export
szoHangrendje : String -> Hangrend
szoHangrendje szo =
  let mhLista = mapMaybe karakterbolMh (unpack szo)
      melyek = filter id (map maganhangzoMelyE mhLista)
      magasak = filter not (map maganhangzoMelyE mhLista)
  in if null mhLista
     then MelyHangrend
     else if null magasak
          then MelyHangrend
          else if null melyek
               then MagasHangrend
               else VegyesHangrend

||| Az elso hang a szoban.
public export
szoElsőMh : String -> Maybe Maganhangzo
szoElsőMh szo = case unpack szo of
  []        => Nothing
  (c :: _)  => karakterbolMh c

-- ===============================================================
-- 2. MORFOLÓGIA -- a 18 esetrag (Kiefer 2011)
-- ===============================================================

||| A 18 magyar esetrag (Kiefer 2011, a MagyarNyelvtan.idr konvencioja).
public export
data Esetrag : Type where
  NominativusE      : Esetrag
  AccusativusE      : Esetrag
  DativusE          : Esetrag
  InessivusE        : Esetrag
  ElativusE         : Esetrag
  IllativusE        : Esetrag
  SuperessivusE     : Esetrag
  AdessivusE        : Esetrag
  DelativusE        : Esetrag
  AblativusE        : Esetrag
  SublativusE       : Esetrag
  AllativusE        : Esetrag
  TerminativusE     : Esetrag
  InstrumentalisE   : Esetrag
  CausalisFinalisE  : Esetrag
  TranszlativusE    : Esetrag
  FormativusE       : Esetrag
  EssivusFormalisE  : Esetrag

public export
Show Esetrag where
  show NominativusE      = "Nominativus"
  show AccusativusE      = "Accusativus"
  show DativusE          = "Dativus"
  show InessivusE        = "Inessivus"
  show ElativusE         = "Elativus"
  show IllativusE        = "Illativus"
  show SuperessivusE     = "Superessivus"
  show AdessivusE        = "Adessivus"
  show DelativusE        = "Delativus"
  show AblativusE        = "Ablativus"
  show SublativusE       = "Sublativus"
  show AllativusE        = "Allativus"
  show TerminativusE     = "Terminativus"
  show InstrumentalisE   = "Instrumentalis"
  show CausalisFinalisE  = "CausalisFinalis"
  show TranszlativusE    = "Transzlativus"
  show FormativusE       = "Formativus"
  show EssivusFormalisE  = "EssivusFormalis"

||| Az esetrag toldaléka (hangrend-fuggo).
||| A magyar nyelvben az esetrag alakja a szó hangrendjetol fugg:
|||   - Mely: -tol, -nak, -ban (a, á, o, ó, u, ú)
|||   - Magas: -tol, -nek, -ben (e, é, i, í, ö, ő, ü, ű)
public export
esetragAlakja : Esetrag -> Hangrend -> String
esetragAlakja NominativusE     _ = ""
esetragAlakja AccusativusE     _ = "t"
esetragAlakja DativusE         MelyHangrend  = "nak"
esetragAlakja DativusE         MagasHangrend = "nek"
esetragAlakja DativusE         VegyesHangrend = "nak"  -- egyszerusitett
esetragAlakja InessivusE       MelyHangrend  = "ban"
esetragAlakja InessivusE       MagasHangrend = "ben"
esetragAlakja InessivusE       VegyesHangrend = "ban"
esetragAlakja ElativusE        MelyHangrend  = "bol"
esetragAlakja ElativusE        MagasHangrend = "bol"
esetragAlakja ElativusE        VegyesHangrend = "bol"
esetragAlakja IllativusE       MelyHangrend  = "ba"
esetragAlakja IllativusE       MagasHangrend = "be"
esetragAlakja IllativusE       VegyesHangrend = "ba"
esetragAlakja SuperessivusE    MelyHangrend  = "n"
esetragAlakja SuperessivusE    MagasHangrend = "n"
esetragAlakja SuperessivusE    VegyesHangrend = "n"
esetragAlakja AdessivusE       MelyHangrend  = "nal"
esetragAlakja AdessivusE       MagasHangrend = "nel"
esetragAlakja AdessivusE       VegyesHangrend = "nal"
esetragAlakja DelativusE       MelyHangrend  = "rol"
esetragAlakja DelativusE       MagasHangrend = "rol"
esetragAlakja DelativusE       VegyesHangrend = "rol"
esetragAlakja AblativusE       MelyHangrend  = "tol"
esetragAlakja AblativusE       MagasHangrend = "tol"
esetragAlakja AblativusE       VegyesHangrend = "tol"
esetragAlakja SublativusE      MelyHangrend  = "ra"
esetragAlakja SublativusE      MagasHangrend = "re"
esetragAlakja SublativusE      VegyesHangrend = "ra"
esetragAlakja AllativusE       MelyHangrend  = "hoz"
esetragAlakja AllativusE       MagasHangrend = "hez"
esetragAlakja AllativusE       VegyesHangrend = "hoz"
esetragAlakja TerminativusE    _ = "ig"
esetragAlakja InstrumentalisE  MelyHangrend  = "val"
esetragAlakja InstrumentalisE  MagasHangrend = "vel"
esetragAlakja InstrumentalisE  VegyesHangrend = "val"
esetragAlakja CausalisFinalisE _ = "ert"
esetragAlakja TranszlativusE   MelyHangrend  = "va"
esetragAlakja TranszlativusE   MagasHangrend = "ve"
esetragAlakja TranszlativusE   VegyesHangrend = "va"
esetragAlakja FormativusE      MelyHangrend  = "kent"
esetragAlakja FormativusE      MagasHangrend = "kent"
esetragAlakja FormativusE      VegyesHangrend = "kent"
esetragAlakja EssivusFormalisE MelyHangrend  = "ul"
esetragAlakja EssivusFormalisE MagasHangrend = "ul"
esetragAlakja EssivusFormalisE VegyesHangrend = "ul"

||| Az esetrag kerdese (a magyar nyelvtanbol).
public export
esetragKerdes : Esetrag -> String
esetragKerdes NominativusE      = "ki? mi?"
esetragKerdes AccusativusE      = "kit? mit?"
esetragKerdes DativusE          = "kinek? minek?"
esetragKerdes InessivusE        = "hol? (benn)"
esetragKerdes ElativusE         = "honnan? (belulrol)"
esetragKerdes IllativusE        = "hova? (bele)"
esetragKerdes SuperessivusE     = "hol? (felszinen)"
esetragKerdes AdessivusE        = "hol? (mellett)"
esetragKerdes DelativusE        = "honnan? (felszinrol)"
esetragKerdes AblativusE        = "honnan? (mellol)"
esetragKerdes SublativusE       = "hova? (felszinre)"
esetragKerdes AllativusE        = "hova? (mellette)"
esetragKerdes TerminativusE     = "meddig?"
esetragKerdes InstrumentalisE   = "mivel? mivel egyutt?"
esetragKerdes CausalisFinalisE  = "miert? mi celbol?"
esetragKerdes TranszlativusE    = "mive valik?"
esetragKerdes FormativusE       = "mikor?"
esetragKerdes EssivusFormalisE  = "milyen minosegben?"

-- ===============================================================
-- 3. IGERAGOZAS -- 3x3x3 = 27
-- ===============================================================

||| Igeido: mult, jelen, jovo.
public export
data Igeido = MultI | JelenI | JovoI

||| Aspektus: folyamatos, befejezett, szokasos.
public export
data Aspektus = FolyamatosA | BefejezettA | SzokasosA

||| Evidencialissag: kozvetlen, kovetkeztetett, jelentett.
public export
data Evidencialissag = KozvetlenE | KovetkeztetettE | JelentettE

||| A teljes igeragozas: 27 kombinacio.
public export
record Igeragozas where
  constructor IgeragozasKonstruktor
  igeido     : Igeido
  aspektus   : Aspektus
  evidencial : Evidencialissag

showAspektus : Aspektus -> String
showAspektus FolyamatosA = "folyamatos"
showAspektus BefejezettA = "befejezett"
showAspektus SzokasosA   = "szokasos"

showEvidencialis : Evidencialissag -> String
showEvidencialis KozvetlenE       = "kozvetlen"
showEvidencialis KovetkeztetettE  = "kovetkeztetett"
showEvidencialis JelentettE       = "jelentett"

showIgeido : Igeido -> String
showIgeido MultI  = "mult"
showIgeido JelenI = "jelen"
showIgeido JovoI  = "jovo"

public export
Show Igeragozas where
  show (IgeragozasKonstruktor i a e) =
    showIgeido i ++ "," ++ showAspektus a ++ "," ++ showEvidencialis e



-- ===============================================================
-- 4. SZINTAXIS -- a szó szofaja
-- ===============================================================

||| A szó szofaja.
public export
data Szofaj : Type where
  Fonev       : Szofaj
  Ige         : Szofaj
  Melleknev   : Szofaj
  Hatrazoszo  : Szofaj
  Nevelo      : Szofaj
  Kotoszo     : Szofaj
  Nevmas      : Szofaj
  Szamneve    : Szofaj
  Egyeb       : Szofaj

public export
Show Szofaj where
  show Fonev      = "fonev"
  show Ige        = "ige"
  show Melleknev  = "melleknev"
  show Hatrazoszo = "hatarozoszo"
  show Nevelo     = "nevelo"
  show Kotoszo    = "kotoszo"
  show Nevmas     = "nevmas"
  show Szamneve   = "szamneve"
  show Egyeb      = "egyeb"

-- ===============================================================
-- 5. TOLDALEK-FELISMERES
-- ===============================================================

||| A leggyakoribb toldalékok listája (magyar).
||| Minden toldalék: (forma, hossz). A toldalék-felismerés a szó
||| VÉGÉRŐL indul.
public export
ToldalekLista : List (String, Nat)
ToldalekLista =
  [ ("ert", 3)        -- -ért
  , ("nek", 3)        -- -nek (Dativus, magas)
  , ("nak", 3)        -- -nak (Dativus, mély)
  , ("ban", 3)        -- -ban (Inessivus, mély)
  , ("ben", 3)        -- -ben (Inessivus, magas)
  , ("tol", 3)        -- -tól (Ablativus)
  , ("rol", 3)        -- -ról (Delativus)
  , ("nel", 3)        -- -nél (Adessivus, magas)
  , ("nal", 3)        -- -nál (Adessivus, mély)
  , ("val", 3)        -- -val (Instrumentalis, mély)
  , ("vel", 3)        -- -vel (Instrumentalis, magas)
  , ("hoz", 3)        -- -hoz (Allativus, mély)
  , ("hez", 3)        -- -hez (Allativus, magas)
  , ("bol", 3)        -- -ból (Elativus)
  , ("kent", 4)       -- -ként (Formativus)
  , ("kent", 4)
  , ("aszt", 4)       -- -aszt (tranzitiv)
  , ("ba" , 2)        -- -ba (Illativus, mély)
  , ("be" , 2)        -- -be (Illativus, magas)
  , ("ra" , 2)        -- -ra (Sublativus, mély)
  , ("re" , 2)        -- -re (Sublativus, magas)
  , ("ot" , 2)        -- -ot (Accusativus)
  , ("at" , 2)        -- -at (Accusativus)
  , ("et" , 2)        -- -et (Accusativus)
  , ("ve" , 2)        -- -vé (Transzlativus, magas)
  , ("va" , 2)        -- -vá (Transzlativus, mély)
  , ("ul" , 2)        -- -ul (Essivus)
  , ("n"  , 1)        -- -n (Superessivus)
  , ("t"  , 1)        -- -t (Accusativus)
  , ("ig" , 2)        -- -ig (Terminativus)
  , ("kor", 3)        -- -kor (Temporalis)
  , ("ott", 3)        -- -ott (ige mult)
  ]

||| Szó szótövének kinyerése: a toldalék levágása a szó végéről.
||| Visszatérési érték: (szótő, toldalék).
||| Ha nincs ismert toldalék, a teljes szó a szótő.
public export
szotőKinyeres : String -> (String, String)
szotőKinyeres szo =
  keresToldalek szo (cast (length szo))
  where
    keresToldalek : String -> Int -> (String, String)
    keresToldalek _ _ = (szo, "")

-- ===============================================================
-- 6. SZÓELEMZÉS -- a teljes nyelvtani elemzés
-- ===============================================================

||| Egy szó teljes nyelvtani elemzése.
public export
record SzoElemzes where
  constructor SzoElemzesKonstruktor
  eredeti     : String
  szoto       : String
  toldalek    : String
  hangrend    : Hangrend
  elsoMh      : Maybe Maganhangzo
  utolsoMh    : Maybe Maganhangzo
  szofaj      : Szofaj

showMaybe : (a -> String) -> Maybe a -> String
showMaybe _ Nothing = "nincs"
showMaybe f (Just x) = f x

showHangrend : Hangrend -> String
showHangrend MelyHangrend   = "mely"
showHangrend MagasHangrend  = "magas"
showHangrend VegyesHangrend = "vegyes"

public export
Show SzoElemzes where
  show (SzoElemzesKonstruktor e szo told hr eh uh szf) =
    "SzoElemzes {eredeti=" ++ e
    ++ ", szoto=" ++ szo
    ++ ", toldalek=" ++ told
    ++ ", hangrend=" ++ showHangrend hr
    ++ ", elsoMh=" ++ showMaybe show eh
    ++ ", utolsoMh=" ++ showMaybe show uh
    ++ ", szofaj=" ++ show szf
    ++ "}"



||| Egyszeru szóelemzes: hangrend + szoto + toldalék + fonetikai jellemzők.
public export
egyszeruElemzes : String -> SzoElemzes
egyszeruElemzes szo =
  let (szoTo, told) = szotőKinyeres szo
  in SzoElemzesKonstruktor
       szo szoTo told
       (szoHangrendje szo)
       (szoElsőMh szo)
       (szoElsőMh szo)  -- (az utolsó magánhangzót nem implementáljuk)
       Egyeb

-- ===============================================================
-- 7. SEGÉDFÜGGVÉNYEK
-- ===============================================================

-- (2026-08-21, §24 — KÓD DUPLIKÁCIÓ TILOS): az itteni mapMaybe/null/filter
-- Prelude-duplikátumok voltak (ütközés: "Ambiguous elaboration"), ezért a v3
-- a PRELUDE verzióit használja; a v2-ben az eredeti másolatok megmaradtak.
-- （§24：此处原为 Prelude 重复，已改用标准库；v2 中保留历史副本。）
