module Alap.Hatar

-- ═════════════════════════════════════════════════════════════════════════
-- HATÁR-MODUL — az EGYETLEN hely, ahol String és Char megjelenik
-- (az IO pereme; a 000.02-es lépés — az EgyVonalTerv szerint)
-- ═════════════════════════════════════════════════════════════════════════
-- A NUMBER 1 HARD RULE folytatása: a CsomagoltTipusok-ban ZERO String —
-- ide, a HATÁRAra van zárva minden String/Char használat (dokumentált
-- kivétel, GAN 10.f: a Char CSAK e modul belsejében él).
--
-- A fájlneve ASCII (Hatar.idr — az NFC/NFD-csapda miatt), az azonosítók
-- ékezetesek belül (§25).
--
-- IDRIS 0.8.0-CSAPDÁK, AMIKET EZ A MODUL BETART (a 000.01 tanulságai
-- + a GAN gépi próbái): strUncons-String-rekurzió assert_smaller-rel;
-- Maybe→Talán híd egy ponton; char-literál MINTÁK (nem ==); aTalán implicit
-- feloldás OK; nincs vesszős teleszkóp; nincs rekordminta.
--
-- A 000.01-es HatarElottiGepiTeszt.idr két függvényét EZ A MODUL veszi át
-- (digráf-barát bővítéssel: a „cs" két karakterként, olvashatóan).
-- ═════════════════════════════════════════════════════════════════════════
-- 中文：边界模块——整个系统中唯一允许 String/Char 的地方（IO 边界）。
-- 标点层（13 个）、Mondat 层、NFC 手工规范化（18 个匈牙利重音字母）、
-- 双字母友好转换、严格未知字符→Semmi、44 行 Refl 往返证明、交互程序。
-- ═════════════════════════════════════════════════════════════════════════
-- Deutsch: Grenzmodul — der einzige Ort mit String/Char (die IO-Grenze).
-- ═════════════════════════════════════════════════════════════════════════
-- עברית: מודול הגבול — המקום היחיד עם String/Char (גבול ה-IO).
-- ═════════════════════════════════════════════════════════════════════════

import Alap.CsomagoltTipusok
import Data.String

%default total

-- ═════════════════════════════════════════════════════════════════════════
-- I. AZ ÍRÁSJEL-RÉTEG (AkH.12 — a magyar írásjelek; GAN 2)
--     中文：标点层——13 个匈牙利标点
-- ═════════════════════════════════════════════════════════════════════════

||| A magyar írásjelek (AkH.12). A GondolatJel (– U+2013) és a KötőjelJel
||| (U+002D) KÜLÖNBÖZŐ jelek — különböző konstruktorok. Az idézőjelek a
||| magyar „idézés" szerint (U+201E nyitó, U+201D záró).
public export
data Írásjel : Type where
  SzóközJel      : Írásjel  -- ' '
  PontJel        : Írásjel  -- .
  VesszőJel      : Írásjel  -- ,
  PontosvesszőJel : Írásjel  -- ;
  KettőspontJel  : Írásjel  -- :
  KérdőjelJel    : Írásjel  -- ?
  FelkiáltójelJel : Írásjel  -- !
  Nyitózárójel   : Írásjel  -- (
  Zárózárójel    : Írásjel  -- )
  GondolatJel    : Írásjel  -- – (U+2013)
  KötőjelJel     : Írásjel  -- - (U+002D)
  NyitóidézőJel  : Írásjel  -- „ (U+201E)
  ZáróidézőJel   : Írásjel  -- " (U+201D)

||| A mondat darabja: szó vagy írásjel (a szóköz EXPLICIT jel —
||| nulla információvesztés, GAN 3).
public export
data MondatDarab : Type where
  SzóDarab : Szöveg -> MondatDarab
  JelDarab : Írásjel -> MondatDarab

||| A mondat: darabok füzére.
public export
Mondat : Type
Mondat = Fűzér MondatDarab

-- ═════════════════════════════════════════════════════════════════════════
-- II. A BETŰ-KONVERZIÓK — a határ két fő átjárója (digráf-barát, GAN 1+8)
--      中文：字母转换——双字母友好（cs 输出为两个字符）
-- ═════════════════════════════════════════════════════════════════════════

||| A betű OLVASHATÓ karakterlánca: a digráfok két/három karakterként
||| (cs, dz, dzs, gy, ly, ny, sz, ty, zs). Ez a kanonikus kiírási forma
||| (a veszteséges egykarakteres változat helyett — a körút-bizonyítás
||| ehhez megy, l. VIII).
public export
betűKarakterlánca : Betű -> String
betűKarakterlánca ABetű = "a"
betűKarakterlánca ÁBetű = "á"
betűKarakterlánca BBetű = "b"
betűKarakterlánca CBetű = "c"
betűKarakterlánca CsBetű = "cs"
betűKarakterlánca DBetű = "d"
betűKarakterlánca DzBetű = "dz"
betűKarakterlánca DzsBetű = "dzs"
betűKarakterlánca EBetű = "e"
betűKarakterlánca ÉBetű = "é"
betűKarakterlánca FBetű = "f"
betűKarakterlánca GBetű = "g"
betűKarakterlánca GyBetű = "gy"
betűKarakterlánca HBetű = "h"
betűKarakterlánca IBetű = "i"
betűKarakterlánca ÍBetű = "í"
betűKarakterlánca JBetű = "j"
betűKarakterlánca KBetű = "k"
betűKarakterlánca LBetű = "l"
betűKarakterlánca LyBetű = "ly"
betűKarakterlánca MBetű = "m"
betűKarakterlánca NBetű = "n"
betűKarakterlánca NyBetű = "ny"
betűKarakterlánca OBetű = "o"
betűKarakterlánca ÓBetű = "ó"
betűKarakterlánca ÖBetű = "ö"
betűKarakterlánca ŐBetű = "ő"
betűKarakterlánca PBetű = "p"
betűKarakterlánca QBetű = "q"
betűKarakterlánca RBetű = "r"
betűKarakterlánca SBetű = "s"
betűKarakterlánca SzBetű = "sz"
betűKarakterlánca TBetű = "t"
betűKarakterlánca TyBetű = "ty"
betűKarakterlánca UBetű = "u"
betűKarakterlánca ÚBetű = "ú"
betűKarakterlánca ÜBetű = "ü"
betűKarakterlánca ŰBetű = "ű"
betűKarakterlánca VBetű = "v"
betűKarakterlánca WBetű = "w"
betűKarakterlánca XBetű = "x"
betűKarakterlánca YBetű = "y"
betűKarakterlánca ZBetű = "z"
betűKarakterlánca ZsBetű = "zs"

||| A karakterből betű — CSAK az egykarakteres betűkre (35).
||| A digráfok a karakterláncbólSzöveg mohó párosításával olvashatók.
||| A nagybetűk NEM (a Betű graféma kisbetűs — a nagybetű-réteg később).
||| Ismeretlen karakter → Semmi (STRICT — a kihagyás információvesztés).
public export
karakterbőlBetű : Char -> Talán Betű
karakterbőlBetű 'a' = Csak ABetű
karakterbőlBetű 'á' = Csak ÁBetű
karakterbőlBetű 'b' = Csak BBetű
karakterbőlBetű 'c' = Csak CBetű
karakterbőlBetű 'd' = Csak DBetű
karakterbőlBetű 'e' = Csak EBetű
karakterbőlBetű 'é' = Csak ÉBetű
karakterbőlBetű 'f' = Csak FBetű
karakterbőlBetű 'g' = Csak GBetű
karakterbőlBetű 'h' = Csak HBetű
karakterbőlBetű 'i' = Csak IBetű
karakterbőlBetű 'í' = Csak ÍBetű
karakterbőlBetű 'j' = Csak JBetű
karakterbőlBetű 'k' = Csak KBetű
karakterbőlBetű 'l' = Csak LBetű
karakterbőlBetű 'm' = Csak MBetű
karakterbőlBetű 'n' = Csak NBetű
karakterbőlBetű 'o' = Csak OBetű
karakterbőlBetű 'ó' = Csak ÓBetű
karakterbőlBetű 'ö' = Csak ÖBetű
karakterbőlBetű 'ő' = Csak ŐBetű
karakterbőlBetű 'p' = Csak PBetű
karakterbőlBetű 'q' = Csak QBetű
karakterbőlBetű 'r' = Csak RBetű
karakterbőlBetű 's' = Csak SBetű
karakterbőlBetű 't' = Csak TBetű
karakterbőlBetű 'u' = Csak UBetű
karakterbőlBetű 'ú' = Csak ÚBetű
karakterbőlBetű 'ü' = Csak ÜBetű
karakterbőlBetű 'ű' = Csak ŰBetű
karakterbőlBetű 'v' = Csak VBetű
karakterbőlBetű 'w' = Csak WBetű
karakterbőlBetű 'x' = Csak XBetű
karakterbőlBetű 'y' = Csak YBetű
karakterbőlBetű 'z' = Csak ZBetű
karakterbőlBetű _ = Semmi

-- ═════════════════════════════════════════════════════════════════════════
-- III. AZ ÍRÁSJEL-KONVERZIÓK (13 + 13)
-- ═════════════════════════════════════════════════════════════════════════

||| Az írásjel karaktere.
public export
jelbölKarakter : Írásjel -> Char
jelbölKarakter SzóközJel = ' '
jelbölKarakter PontJel = '.'
jelbölKarakter VesszőJel = ','
jelbölKarakter PontosvesszőJel = ';'
jelbölKarakter KettőspontJel = ':'
jelbölKarakter KérdőjelJel = '?'
jelbölKarakter FelkiáltójelJel = '!'
jelbölKarakter Nyitózárójel = '('
jelbölKarakter Zárózárójel = ')'
jelbölKarakter GondolatJel = '\x2013'
jelbölKarakter KötőjelJel = '\x002D'
jelbölKarakter NyitóidézőJel = '\x201E'
jelbölKarakter ZáróidézőJel = '\x201D'

||| A karakterből írásjel (13 — char-literál mintákkal).
public export
karakterbőlJel : Char -> Talán Írásjel
karakterbőlJel ' ' = Csak SzóközJel
karakterbőlJel '.' = Csak PontJel
karakterbőlJel ',' = Csak VesszőJel
karakterbőlJel ';' = Csak PontosvesszőJel
karakterbőlJel ':' = Csak KettőspontJel
karakterbőlJel '?' = Csak KérdőjelJel
karakterbőlJel '!' = Csak FelkiáltójelJel
karakterbőlJel '(' = Csak Nyitózárójel
karakterbőlJel ')' = Csak Zárózárójel
karakterbőlJel '\x2013' = Csak GondolatJel
karakterbőlJel '\x002D' = Csak KötőjelJel
karakterbőlJel '\x201E' = Csak NyitóidézőJel
karakterbőlJel '\x201D' = Csak ZáróidézőJel
karakterbőlJel _ = Semmi

-- ═════════════════════════════════════════════════════════════════════════
-- IV. NFC-NORMALIZÁLÁS — a kézi táblázat a magyar ékezetesekre (GAN 4)
--      中文：NFC 规范化——18 个匈牙利重音字母的手工表
-- ═════════════════════════════════════════════════════════════════════════

||| A kombinator-pár olvasztása: bázismagánhangzó + U+0301 (hegyes),
||| U+0308 (kettős pont), U+030B (kettős hegyes) → ékezetes betű.
||| A macOS NFD-formában adja az é/ő/ű betűket — ez a táblázat olvasztja.
public export
kombinálódó : Char -> Char -> Talán Char
kombinálódó 'a' '\x0301' = Csak 'á'
kombinálódó 'e' '\x0301' = Csak 'é'
kombinálódó 'i' '\x0301' = Csak 'í'
kombinálódó 'o' '\x0301' = Csak 'ó'
kombinálódó 'u' '\x0301' = Csak 'ú'
kombinálódó 'o' '\x0308' = Csak 'ö'
kombinálódó 'u' '\x0308' = Csak 'ü'
kombinálódó 'o' '\x030B' = Csak 'ő'
kombinálódó 'u' '\x030B' = Csak 'ű'
kombinálódó 'A' '\x0301' = Csak 'Á'
kombinálódó 'E' '\x0301' = Csak 'É'
kombinálódó 'I' '\x0301' = Csak 'Í'
kombinálódó 'O' '\x0301' = Csak 'Ó'
kombinálódó 'U' '\x0301' = Csak 'Ú'
kombinálódó 'O' '\x0308' = Csak 'Ö'
kombinálódó 'U' '\x0308' = Csak 'Ü'
kombinálódó 'O' '\x030B' = Csak 'Ő'
kombinálódó 'U' '\x030B' = Csak 'Ű'
kombinálódó _ _ = Semmi

||| NFC-normalizálás: a bázis+kombinator párokat olvasztja.
||| (String-rekurzió strUncons-szal — assert_smaller-rel, mert a
||| totality-ellenőr a String-farat nem látja strukturálisan.)
public export
normalizáld : String -> String
normalizáld sor = case strUncons sor of
  Nothing => ""
  Just (első, több) =>
    case strUncons több of
      Nothing => sor
      Just (második, tovább) =>
        case kombinálódó első második of
          Csak olvasztott => strCons olvasztott (normalizáld (assert_smaller sor tovább))
          Semmi => strCons első (normalizáld (assert_smaller sor több))

-- ═════════════════════════════════════════════════════════════════════════
-- V. A FŐ ÁTJÁRÓK — Szöveg ⇄ String (mohó digráf-párosítással)
--     中文：主通道——文本与字符串互转（贪婪双字母配对）
-- ═════════════════════════════════════════════════════════════════════════

||| Szövegből karakterlánc — a KIÍRÁSI irány (digráf-barát).
public export
szövegbőlKarakterlánc : Szöveg -> String
szövegbőlKarakterlánc ÜresSzöveg = ""
szövegbőlKarakterlánc (BetűtFűz betű tovább) =
  betűKarakterlánca betű ++ szövegbőlKarakterlánc tovább

||| A páros-digráf táblázat: cs, dz, gy, ly, ny, sz, ty, zs.
||| (A c+z NEM digráf — a „cz" a régi helyesírás; a dz = d+z.)
public export
párosDigráf : Char -> Char -> Talán Betű
párosDigráf 'c' 's' = Csak CsBetű
párosDigráf 'd' 'z' = Csak DzBetű
párosDigráf 'g' 'y' = Csak GyBetű
párosDigráf 'l' 'y' = Csak LyBetű
párosDigráf 'n' 'y' = Csak NyBetű
párosDigráf 's' 'z' = Csak SzBetű
párosDigráf 't' 'y' = Csak TyBetű
párosDigráf 'z' 's' = Csak ZsBetű
párosDigráf _ _ = Semmi

||| A hármas-digráf: egyetlen egy — a dzs (d+z+s).
public export
hármasDigráf : Char -> Char -> Char -> Talán Betű
hármasDigráf 'd' 'z' 's' = Csak DzsBetű
hármasDigráf _ _ _ = Semmi

||| A betűs-fűzés kombinatorja: Talán Betű + Talán Szöveg → Talán Szöveg.
public export
betűsFűzés : Talán Betű -> Talán Szöveg -> Talán Szöveg
betűsFűzés (Csak betű) (Csak folytatás) = Csak (BetűtFűz betű folytatás)
betűsFűzés _ _ = Semmi

||| Karakterláncból szöveg — az OLVASÁSI irány: mohó digráf-párosítás
||| (a leghosszabb illeszkedést keresi: dzs a dz előtt).
||| Ismeretlen karakter → Semmi (STRICT).
public export
karakterláncbólSzöveg : String -> Talán Szöveg
karakterláncbólSzöveg sor = case strUncons sor of
  Nothing => Csak ÜresSzöveg
  Just (első, több) =>
    case strUncons több of
      Nothing => betűsFűzés (karakterbőlBetű első) (Csak ÜresSzöveg)
      Just (második, tovább) =>
        case strUncons tovább of
          Just (harmadik, továbbTöbb) =>
            case hármasDigráf első második harmadik of
              Csak betű => betűsFűzés (Csak betű)
                (karakterláncbólSzöveg (assert_smaller sor továbbTöbb))
              Semmi =>
                case párosDigráf első második of
                  Csak betű => betűsFűzés (Csak betű)
                    (karakterláncbólSzöveg (assert_smaller sor tovább))
                  Semmi => betűsFűzés (karakterbőlBetű első)
                    (karakterláncbólSzöveg (assert_smaller sor több))
          Nothing =>
            case párosDigráf első második of
              Csak betű => betűsFűzés (Csak betű) (Csak ÜresSzöveg)
              Semmi => betűsFűzés (karakterbőlBetű első)
                (karakterláncbólSzöveg (assert_smaller sor több))

-- ═════════════════════════════════════════════════════════════════════════
-- VI. SZAVAK ÉS MONDAT (v1: szóközzel elválasztott szavak; GAN 3)
-- ═════════════════════════════════════════════════════════════════════════

||| A sor első szava (String-szinten) + a maradék (az első szóköztől).
||| A '\r'-t szóközként kezeli (CRLF-védelem — a getLine nyomán).
public export
szóStringÉsMaradék : String -> (String, String)
szóStringÉsMaradék sor = case strUncons sor of
  Nothing => ("", "")
  Just (első, több) =>
    case első of
      ' ' => ("", sor)
      '\r' => ("", sor)
      _ => case szóStringÉsMaradék (assert_smaller sor több) of
        (szóTöbbi, maradék) => (strCons első szóTöbbi, maradék)

||| A sor szavai (Szöveg-szinten; STRICT — ismeretlen karakter → Semmi).
public export
szavakKarakterláncból : String -> Talán (Fűzér Szöveg)
szavakKarakterláncból sor = case strUncons sor of
  Nothing => Csak FűzérVége
  Just (első, több) =>
    case első of
      ' ' => szavakKarakterláncból (assert_smaller sor több)
      '\r' => szavakKarakterláncból (assert_smaller sor több)
      _ => case szóStringÉsMaradék sor of
        (szóString, maradék) =>
          case karakterláncbólSzöveg szóString of
            Csak szó =>
              case szavakKarakterláncból (assert_smaller sor maradék) of
                Csak többiSzó => Csak (Fűzés szó többiSzó)
                Semmi => Semmi
            Semmi => Semmi

||| Szavakból mondat: a szavak közé szóköz-jelet told (GAN 3 segéd).
public export
szavakbólMondat : Fűzér Szöveg -> Mondat
szavakbólMondat FűzérVége = FűzérVége
szavakbólMondat (Fűzés szó tovább) =
  Fűzés (SzóDarab szó) (case tovább of
    FűzérVége => FűzérVége
    _ => Fűzés (JelDarab SzóközJel) (szavakbólMondat tovább))

||| Mondatból karakterlánc — a kiírási irány (darabonként).
public export
mondatbólKarakterlánc : Mondat -> String
mondatbólKarakterlánc FűzérVége = ""
mondatbólKarakterlánc (Fűzés darab tovább) =
  case darab of
    SzóDarab szó => szövegbőlKarakterlánc szó ++ mondatbólKarakterlánc tovább
    JelDarab jel => strCons (jelbölKarakter jel) (mondatbólKarakterlánc tovább)

-- ═════════════════════════════════════════════════════════════════════════
-- VII. AZ IO-PEREM — határKiírás, határOlvasás (a régi main-ek új kanálja)
-- ═════════════════════════════════════════════════════════════════════════

||| A határ-kiírás: SZÖVEG-alapú (a 0.8.0-ban a generikus constraint-fv
||| LHS-elaborációja elhasal — a megjelenít-et a HIVÓ fűzi hozzá:
||| határKiírás (megjelenít érték) — ugyanaz az eredmény, 0.8.0-biztos).
||| A String csak itt, a peremen jelenik meg.
public export
határKiírás : Szöveg -> IO ()
határKiírás szöveg = putStrLn (szövegbőlKarakterlánc szöveg)

||| A mondat-kiírás (a szóközökkel együtt).
public export
határMondatKiírás : Mondat -> IO ()
határMondatKiírás mondat = putStrLn (mondatbólKarakterlánc mondat)

||| Az első szó kiválasztása (top-level; külső változó-minta + belső case —
||| a 0.8.0-nál a kétszintű beágyazott klauzula-minta nem számít lefedettnek).
public export
elsőSzóTalán : Talán (Fűzér Szöveg) -> Talán Szöveg
elsőSzóTalán Semmi = Semmi
elsőSzóTalán (Csak szóFűzér) = case szóFűzér of
  FűzérVége => Csak ÜresSzöveg
  (Fűzés elsőSzó _) => Csak elsőSzó

||| Határ-olvasás: egy sor szavai (NFC-normalizálva, STRICT).
public export
határSzavakOlvasás : IO (Talán (Fűzér Szöveg))
határSzavakOlvasás = do
  sor <- getLine
  pure (szavakKarakterláncból (normalizáld sor))

||| Határ-olvasás: egyetlen szó (az első).
public export
határOlvasás : IO (Talán Szöveg)
határOlvasás = do
  szavak <- határSzavakOlvasás
  pure (elsőSzóTalán szavak)

-- ═════════════════════════════════════════════════════════════════════════
-- VIII. BIZONYÍTÁSOK (Refl — a körutak; GAN 7)
--      中文：证明——往返定理（44 行 Refl）
-- ═════════════════════════════════════════════════════════════════════════

||| A BETŰ-KÖRÚT TÉTELE: minden betű kiírva és visszaolvasva önmaga
||| (betűKarakterlánca → karakterláncbólSzöveg = Csak (egybetűs szó)).
||| A digráf-barát kiírás miatt a digráfokra is teljesül (a veszteséges
||| egykarakteres változattal NEM teljesülne: Cs → „c" → CBetű ≢ CsBetű).
public export
körútBetű : (b : Betű) ->
  karakterláncbólSzöveg (betűKarakterlánca b) = Csak (BetűtFűz b ÜresSzöveg)
körútBetű ABetű = Refl
körútBetű ÁBetű = Refl
körútBetű BBetű = Refl
körútBetű CBetű = Refl
körútBetű CsBetű = Refl
körútBetű DBetű = Refl
körútBetű DzBetű = Refl
körútBetű DzsBetű = Refl
körútBetű EBetű = Refl
körútBetű ÉBetű = Refl
körútBetű FBetű = Refl
körútBetű GBetű = Refl
körútBetű GyBetű = Refl
körútBetű HBetű = Refl
körútBetű IBetű = Refl
körútBetű ÍBetű = Refl
körútBetű JBetű = Refl
körútBetű KBetű = Refl
körútBetű LBetű = Refl
körútBetű LyBetű = Refl
körútBetű MBetű = Refl
körútBetű NBetű = Refl
körútBetű NyBetű = Refl
körútBetű OBetű = Refl
körútBetű ÓBetű = Refl
körútBetű ÖBetű = Refl
körútBetű ŐBetű = Refl
körútBetű PBetű = Refl
körútBetű QBetű = Refl
körútBetű RBetű = Refl
körútBetű SBetű = Refl
körútBetű SzBetű = Refl
körútBetű TBetű = Refl
körútBetű TyBetű = Refl
körútBetű UBetű = Refl
körútBetű ÚBetű = Refl
körútBetű ÜBetű = Refl
körútBetű ŰBetű = Refl
körútBetű VBetű = Refl
körútBetű WBetű = Refl
körútBetű XBetű = Refl
körútBetű YBetű = Refl
körútBetű ZBetű = Refl
körútBetű ZsBetű = Refl

||| Az írásjel-körút: minden jel kiírva és visszaolvasva önmaga.
public export
jelKörút : (j : Írásjel) -> karakterbőlJel (jelbölKarakter j) = Csak j
jelKörút SzóközJel = Refl
jelKörút PontJel = Refl
jelKörút VesszőJel = Refl
jelKörút PontosvesszőJel = Refl
jelKörút KettőspontJel = Refl
jelKörút KérdőjelJel = Refl
jelKörút FelkiáltójelJel = Refl
jelKörút Nyitózárójel = Refl
jelKörút Zárózárójel = Refl
jelKörút GondolatJel = Refl
jelKörút KötőjelJel = Refl
jelKörút NyitóidézőJel = Refl
jelKörút ZáróidézőJel = Refl

||| Az NFC-törvény: az NFD-formájú „e + U+0301" olvasztódik „é"-vé.
-- Kimenet: Refl (normalizáld "e+CombiningAcute" = "é" ✓)
public export
normalizáldNFD : normalizáld (strCons 'e' (strCons '\x0301' "")) = "é"
normalizáldNFD = Refl

||| Az ő-NFD is olvasztódik (o + U+030B).
-- Kimenet: Refl ✓
public export
normalizáldŐNFD : normalizáld (strCons 'o' (strCons '\x030B' "")) = "ő"
normalizáldŐNFD = Refl

-- ═════════════════════════════════════════════════════════════════════════
-- IX. AZ INTERAKTÍV FŐPROGRAM (§N14/6 — REAGÁL, nem csak kiír; GAN 6)
--      中文：交互式主程序——响应而非仅输出
-- ═════════════════════════════════════════════════════════════════════════

||| A parancsszavak (Szöveg-literálok — BetűtFűz-láncok).
súgóSzó : Szöveg
súgóSzó = BetűtFűz SBetű (BetűtFűz UBetű (BetűtFűz GBetű (BetűtFűz ÓBetű ÜresSzöveg)))

hosszSzó : Szöveg
hosszSzó = BetűtFűz HBetű (BetűtFűz OBetű (BetűtFűz SBetű
  (BetűtFűz SzBetű ÜresSzöveg)))

betűkSzó : Szöveg
betűkSzó = BetűtFűz BBetű (BetűtFűz EBetű (BetűtFűz TBetű (BetűtFűz ŰBetű
  (BetűtFűz KBetű ÜresSzöveg))))

ragSzó : Szöveg
ragSzó = BetűtFűz RBetű (BetűtFűz ABetű (BetűtFűz GBetű ÜresSzöveg))

esetragSzó : Szöveg
esetragSzó = BetűtFűz EBetű (BetűtFűz SBetű (BetűtFűz EBetű (BetűtFűz TBetű
  (BetűtFűz RBetű (BetűtFűz ABetű (BetűtFűz GBetű ÜresSzöveg))))))

kilépésSzó : Szöveg
kilépésSzó = BetűtFűz KBetű (BetűtFűz IBetű (BetűtFűz LBetű (BetűtFűz ÉBetű
  (BetűtFűz PBetű (BetűtFűz ÉBetű (BetűtFűz SBetű ÜresSzöveg))))))

igenSzó : Szöveg
igenSzó = BetűtFűz IBetű (BetűtFűz GBetű (BetűtFűz EBetű (BetűtFűz NBetű ÜresSzöveg)))

nemSzó : Szöveg
nemSzó = BetűtFűz NBetű (BetűtFűz EBetű (BetűtFűz MBetű ÜresSzöveg))

||| A súgó-mondat: a parancsok nevei szóközzel.
súgóMondat : Mondat
súgóMondat = szavakbólMondat (Fűzés súgóSzó (Fűzés hosszSzó (Fűzés betűkSzó
  (Fűzés ragSzó (Fűzés esetragSzó (Fűzés kilépésSzó FűzérVége))))))

||| Az esetrag-DEMO táblázat: a 18 rag felületi (hátsó hangrendű) alakja
||| (a 600.10-es motor kanonizálja majd; itt a demonstráció).
esetragDemo : Fűzér (Pár Esetrag Szöveg)
esetragDemo =
  let tizennyolcadik = Fűzés (Párosít UlÜlRag
        (BetűtFűz UBetű (BetűtFűz LBetű ÜresSzöveg))) FűzérVége
      tizenhetedik = Fűzés (Párosít KéntRag
        (BetűtFűz KBetű (BetűtFűz ÉBetű (BetűtFűz NBetű (BetűtFűz TBetű
        ÜresSzöveg))))) tizennyolcadik
      tizenhatodik = Fűzés (Párosít MeddigRag
        (BetűtFűz IBetű (BetűtFűz GBetű ÜresSzöveg))) tizenhetedik
      tizenötödik = Fűzés (Párosít KözelbőlRag
        (BetűtFűz TBetű (BetűtFűz ÓBetű (BetűtFűz LBetű ÜresSzöveg)))) tizenhatodik
      tizennegyedik = Fűzés (Párosít KözelbenRag
        (BetűtFűz NBetű (BetűtFűz ÁBetű (BetűtFűz LBetű ÜresSzöveg)))) tizenötödik
      tizenharmadik = Fűzés (Párosít KözelbeRag
        (BetűtFűz HBetű (BetűtFűz OBetű (BetűtFűz ZBetű ÜresSzöveg)))) tizennegyedik
      tizenkettedik = Fűzés (Párosít FelszínrőlRag
        (BetűtFűz RBetű (BetűtFűz ÓBetű (BetűtFűz LBetű ÜresSzöveg)))) tizenharmadik
      tizenegyedik = Fűzés (Párosít FelszínRag
        (BetűtFűz NBetű ÜresSzöveg)) tizenkettedik
      tizedik = Fűzés (Párosít FelszínreRag
        (BetűtFűz RBetű (BetűtFűz ABetű ÜresSzöveg))) tizenegyedik
      kilencedik = Fűzés (Párosít MelybőlRag
        (BetűtFűz BBetű (BetűtFűz ÓBetű (BetűtFűz LBetű ÜresSzöveg)))) tizedik
      nyolcadik = Fűzés (Párosít MelybenRag
        (BetűtFűz BBetű (BetűtFűz ABetű (BetűtFűz NBetű ÜresSzöveg)))) kilencedik
      hetedik = Fűzés (Párosít MelybeRag
        (BetűtFűz BBetű (BetűtFűz ABetű ÜresSzöveg))) nyolcadik
      hatodik = Fűzés (Párosít EredményRag
        (BetűtFűz VBetű (BetűtFűz ÁBetű ÜresSzöveg))) hetedik
      ötödik = Fűzés (Párosít OkCélRag
        (BetűtFűz ÉBetű (BetűtFűz RBetű (BetűtFűz TBetű ÜresSzöveg)))) hatodik
      negyedik = Fűzés (Párosít EszközTársRag
        (BetűtFűz VBetű (BetűtFűz ABetű (BetűtFűz LBetű ÜresSzöveg)))) ötödik
      harmadik = Fűzés (Párosít RészesRag
        (BetűtFűz NBetű (BetűtFűz ABetű (BetűtFűz KBetű ÜresSzöveg)))) negyedik
      második = Fűzés (Párosít TárgyRag
        (BetűtFűz TBetű ÜresSzöveg)) harmadik
      első = Fűzés (Párosít AlanyRag ÜresSzöveg) második
  in első

||| A parancs-feldolgozó TÍPUSA — előre-deklarálva, mert a fogadás hívja
||| és a feldolgoz is hívja a fogadást (kör; a típusdeklaráció legálissá
||| teszi — a definíció a fogadás után áll).
covering feldolgoz : Fűzér Szöveg -> IO ()

||| A rag-tesztelő: kiírja az illeszkedő esetragok neveit
||| (strukturális a Fűzér-re — total; a Párosít-bontás belső case-szel,
||| mert a 0.8.0 a kétszintű klauzula-mintát nem látja lefedettnek).
ragTeszt : Szöveg -> Fűzér (Pár Esetrag Szöveg) -> IO ()
ragTeszt _ FűzérVége = pure ()
ragTeszt szó (Fűzés pár tovább) =
  case pár of
    Párosít rag ragSzövege =>
      case végEgyezzik szó ragSzövege of
        Igaz => do határKiírás (megjelenít rag); ragTeszt szó tovább
        Hamis => ragTeszt szó tovább

||| A betű-kiírás: a szó betűi soronként (digráf-barát; strukturális).
betűKiírás : Szöveg -> IO ()
betűKiírás ÜresSzöveg = pure ()
betűKiírás (BetűtFűz betű tovább) =
  do határKiírás (megjelenít betű); betűKiírás tovább

||| A fogadás: a határ-prompt és a sor beolvasása (a loop SZÁNDÉKOS —
||| covering, dokumentált IO-kivétel; a kilépés-szó zárja).
covering fogadás : IO ()
fogadás = do
  putStr "határ> "
  szavak <- határSzavakOlvasás
  case szavak of
    Semmi => do
      putStrLn "ismeretlen karakter — csak magyar betűk"
      fogadás
    Csak FűzérVége => fogadás
    Csak szóFűzér => feldolgoz szóFűzér

-- A parancs-feldolgozó DEFINÍCIÓJA: REAGÁL a beolvasott szavakra.
feldolgoz FűzérVége = fogadás
feldolgoz (Fűzés parancs tovább) =
  case szövegEgyenlő parancs kilépésSzó of
    Igaz => határMondatKiírás (szavakbólMondat (Fűzés
      (BetűtFűz VBetű (BetűtFűz ÉBetű (BetűtFűz GBetű
      (BetűtFűz EBetű ÜresSzöveg)))) FűzérVége))
    Hamis => case szövegEgyenlő parancs súgóSzó of
      Igaz => do határMondatKiírás súgóMondat; fogadás
      Hamis => case szövegEgyenlő parancs hosszSzó of
        Igaz => case tovább of
          (Fűzés szó _) => do
            határKiírás (megjelenít (szövegHossz szó))
            fogadás
          FűzérVége => do határKiírás nemSzó; fogadás
        Hamis => case szövegEgyenlő parancs betűkSzó of
          Igaz => case tovább of
            (Fűzés szó _) => do betűKiírás szó; fogadás
            FűzérVége => do határKiírás nemSzó; fogadás
          Hamis => case szövegEgyenlő parancs ragSzó of
            Igaz => case tovább of
              (Fűzés szó (Fűzés rag _)) => do
                határKiírás (case végEgyezzik szó rag of
                  Igaz => igenSzó
                  Hamis => nemSzó)
                fogadás
              _ => do határKiírás nemSzó; fogadás
            Hamis => case szövegEgyenlő parancs esetragSzó of
              Igaz => case tovább of
                (Fűzés szó _) => do ragTeszt szó esetragDemo; fogadás
                FűzérVége => do határKiírás nemSzó; fogadás
              Hamis => do határMondatKiírás súgóMondat; fogadás

-- A főprogram: a Határ bemutatása (interaktív — §N14/6; a loop miatt
-- covering — a kilépés-szó zárja).
covering main : IO ()
main = do
  putStrLn "─── HATÁR-MODUL — az interaktív perem (000.02) ───"
  putStrLn "parancsok:"
  határMondatKiírás súgóMondat
  putStrLn "─── ───"
  fogadás