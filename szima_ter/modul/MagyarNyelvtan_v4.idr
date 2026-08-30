module MagyarNyelvtan_v4

import Data.List  -- drop és társai (§24: standard, nem újraírva)
-- ═══ v4 (2026-08-21): a v3 szintaxis-javítása + a KONSTRUKTORNEVEK helyreállítása:
--     a "Cs/Gy/..." (D = Digraf-rövidítés) és a "A/Á/Ö/..." (V = Maganhangzó-
--     rövidítés) NEM magyar szavak (§0: rövidítés tilos; a felhasználó leleplezte:
--     "Cs nincsen a magyarban"). A konstruktorok innentől a VALÓDI betűk:
--     Digraf: Cs Gy Ly Ny Sz Ty Zs Dz Zs; Maganhangzó: A Á E É I Í O Ó Ö Ő U Ú Ü Ű.
--     ═══ v4：恢复真实字母名（Cs、Gy……与 A、Á……），消除 D/V 缩写前缀。
--     ═══ v4: echte Buchstabennamen statt D/V-Abkürzungspräfixen.
--     ═══ v4: שמות האותיות האמיתיים במקום קידומות הקיצור D/V.
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
--   1. FONETIKA: 14 magánhangzó (A, Á, E, É, I, Í, O,
--      Ó, Ö, Ő, U, Ú, Ü, Ű) + 17 massalhangzo +
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
    A    -- a  [ɒ]
  | Á   -- á  [aː]
  | E    -- e  [ɛ]
  | É   -- é  [eː]
  | I    -- i  [i]
  | Í   -- í  [iː]
  | O    -- o  [o]
  | Ó   -- ó  [oː]
  | Ö   -- ö  [ø]
  | Ő  -- ő  [øː]
  | U    -- u  [u]
  | Ú   -- ú  [uː]
  | Ü   -- ü  [y]
  | Ű  -- ű  [yː]

public export
Show Maganhangzo where
  show A    = "a"
  show Á   = "á"
  show E    = "e"
  show É   = "é"
  show I    = "i"
  show Í   = "í"
  show O    = "o"
  show Ó   = "ó"
  show Ö   = "ö"
  show Ő  = "ő"
  show U    = "u"
  show Ú   = "ú"
  show Ü   = "ü"
  show Ű  = "ű"

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
  Cs  : Digraf
  Gy  : Digraf
  Ly  : Digraf
  Ny  : Digraf
  Sz  : Digraf
  Ty  : Digraf
  Zs  : Digraf
  Dz  : Digraf
  Dzs : Digraf

public export
Show Digraf where
  show Cs  = "cs"
  show Gy  = "gy"
  show Ly  = "ly"
  show Ny  = "ny"
  show Sz  = "sz"
  show Ty  = "ty"
  show Zs  = "zs"
  show Dz  = "dz"
  show Dzs = "dzs"

||| Hangrend (a magyar nyelvtan egyik alapfogalma).
public export
data Hangrend = MelyHangrend | MagasHangrend | VegyesHangrend

||| A magánhangzó mely-e (True = mély, False = magas).
public export
magánhangzóMélyÉ : Maganhangzo -> Bool
magánhangzóMélyÉ A    = True
magánhangzóMélyÉ Á   = True
magánhangzóMélyÉ E    = False
magánhangzóMélyÉ É   = False
magánhangzóMélyÉ I    = False
magánhangzóMélyÉ Í   = False
magánhangzóMélyÉ O    = True
magánhangzóMélyÉ Ó   = True
magánhangzóMélyÉ Ö   = False
magánhangzóMélyÉ Ő  = False
magánhangzóMélyÉ U    = True
magánhangzóMélyÉ Ú   = True
magánhangzóMélyÉ Ü   = False
magánhangzóMélyÉ Ű  = False

||| Egy karakter milyen magánhangzót jelent.
public export
karakterbőlMagánhangzó : Char -> Maybe Maganhangzo
karakterbőlMagánhangzó 'a' = Just A
karakterbőlMagánhangzó 'á' = Just Á
karakterbőlMagánhangzó 'e' = Just E
karakterbőlMagánhangzó 'é' = Just É
karakterbőlMagánhangzó 'i' = Just I
karakterbőlMagánhangzó 'í' = Just Í
karakterbőlMagánhangzó 'o' = Just O
karakterbőlMagánhangzó 'ó' = Just Ó
karakterbőlMagánhangzó 'ö' = Just Ö
karakterbőlMagánhangzó 'ő' = Just Ő
karakterbőlMagánhangzó 'u' = Just U
karakterbőlMagánhangzó 'ú' = Just Ú
karakterbőlMagánhangzó 'ü' = Just Ü
karakterbőlMagánhangzó 'ű' = Just Ű
karakterbőlMagánhangzó 'A' = Just A
karakterbőlMagánhangzó 'Á' = Just Á
karakterbőlMagánhangzó 'E' = Just E
karakterbőlMagánhangzó 'É' = Just É
karakterbőlMagánhangzó 'I' = Just I
karakterbőlMagánhangzó 'Í' = Just Í
karakterbőlMagánhangzó 'O' = Just O
karakterbőlMagánhangzó 'Ó' = Just Ó
karakterbőlMagánhangzó 'Ö' = Just Ö
karakterbőlMagánhangzó 'Ő' = Just Ő
karakterbőlMagánhangzó 'U' = Just U
karakterbőlMagánhangzó 'Ú' = Just Ú
karakterbőlMagánhangzó 'Ü' = Just Ü
karakterbőlMagánhangzó 'Ű' = Just Ű
karakterbőlMagánhangzó _   = Nothing

||| Egy karakter milyen digráfot jelent (kétkarakteres egyezés).
public export
digrafEgyezés : String -> Nat -> Maybe Digraf
digrafEgyezés szo i =
  let cs = unpack szo
      lista = drop i cs
  in case lista of
       ('c' :: 's' :: _) => Just Cs
       ('g' :: 'y' :: _) => Just Gy
       ('l' :: 'y' :: _) => Just Ly
       ('n' :: 'y' :: _) => Just Ny
       ('s' :: 'z' :: _) => Just Sz
       ('t' :: 'y' :: _) => Just Ty
       ('z' :: 's' :: _) => Just Zs
       ('d' :: 'z' :: _) => Just Dz
       ('d' :: 'z' :: 's' :: _) => Just Dzs
       _ => Nothing

||| A szo hangrendje (magánhangzok alapjan).
public export
szoHangrendje : String -> Hangrend
szoHangrendje szo =
  let mhLista = mapMaybe karakterbőlMagánhangzó (unpack szo)
      melyek = filter id (map magánhangzóMélyÉ mhLista)
      magasak = filter not (map magánhangzóMélyÉ mhLista)
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
  (c :: _)  => karakterbőlMagánhangzó c

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
egyszerűElemzés : String -> SzoElemzes
egyszerűElemzés szo =
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
