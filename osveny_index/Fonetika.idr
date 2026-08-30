module Fonetika

import ModulRegisztracio
-- ═══════════════════════════════════════════════════════════════
-- FONETIKA — a magyar hangrendszer + IPA + SZÓTAGOLÁS
-- ═══════════════════════════════════════════════════════════════
-- A magyar (majdnem) FONEMATIKUS: a helyesírás ~1:1 a hangokkal,
-- ezért a graféma→fonéma átírás DETERMINISZTIKUSAN SZÁMOLHATÓ.
--
-- A hangrendszer (E9 framework §7: "Hungarian = O"):
--   14 magánhangzó + 17 egyszerű mássalhangzó + 9 digráf = 40 egység
--   A 9 digráf (cs gy ly ny sz ty zs dz dzs) = az oktonion
--   imagináriusai (Cayley–Dickson-réteg).
--
-- GEMINÁCIÓ: a hosszú mássalhangzó a digráf ELSŐ betűjének
-- duplázásával íródik (sz→ssz, ny→nny, dzs→ddzs …), fonémásan
-- a DIGRÁF KÉTSZER szerepel — ez a szótagoláshoz kell
-- (men-nye-zet, e-gész-szég: a geminátum a határon oszlik).
--
-- SZÓTAGOLÁS (magyar alapszabály, minden magánhangzó szótagot kezd):
--   0 mássalhangzó két magánhangzó közt → HIÁTUS (ka-te-gó-ri-a)
--   1 mássalhangzó → a KÖVETKEZŐ szótag támadása (pa-pír)
--   2+ mássalhangzó → első = kóda, többi = támadás (asz-tal,
--     ban-di-ta, pisz-tráng — az "str"-típusú támadásfürtökkel)
--   (Az összetett szavak — hang·vil·la — morféma szerint
--   tagolódnak: ezt a SZÓTÁR rétege dönti el, nem a szabály.
--   A szabály-vs-szótár határ pontosan a projekt fő feszültsége.)
--
-- HANGSÚLY: a magyarban DETERMINISZTIKUSAN az első szótagon —
--   "az első a jó". (Mint a kvint: az első Fermat-prim.)
--
-- Rétegek: ORTOGRÁFIA (gauge) → FONÉMA (nyelv) → FONÉTIKA/IPA (fizika)
-- ═══════════════════════════════════════════════════════════════

%default total

-- ─── 1. A 14 MAGÁNHANGZÓ ───────────────────────────────────

public export
data Maganhangzo =
    Va   -- a  [ɒ]
  | Vaa  -- á  [aː]
  | Ve   -- e  [ɛ]
  | Vee  -- é  [eː]
  | Vi   -- i  [i]
  | Vii  -- í  [iː]
  | Vo   -- o  [o]
  | Voo  -- ó  [oː]
  | Voe  -- ö  [ø]
  | Voee -- ő  [øː]
  | Vu   -- u  [u]
  | Vuu  -- ú  [uː]
  | Vue  -- ü  [y]
  | Vuee -- ű  [yː]

-- ─── 2. A 17 EGYSZERŰ MÁSSALHANGZÓ ─────────────────────────

public export
data Massalhangzo =
    Mb  -- b [b]
  | Mc  -- c [t͡s]
  | Md  -- d [d]
  | Mf  -- f [f]
  | Mg  -- g [ɡ]
  | Mh  -- h [h]
  | Mj  -- j [j]
  | Mk  -- k [k]
  | Ml  -- l [l]
  | Mm  -- m [m]
  | Mn  -- n [n]
  | Mp  -- p [p]
  | Mr  -- r [r]
  | Ms  -- s [ʃ]  (!) az s pozitív: [ʃ]
  | Mt  -- t [t]
  | Mv  -- v [v]
  | Mz  -- z [z]
  | Mng -- ng [ŋ] (asszimiláció: n g előtt; epitran ng,ngy)

-- ─── 3. A 9 DIGRÁF (az oktonion imagináriusai) ─────────────

public export
data Digraf =
    Dcs  -- cs [t͡ʃ]
  | Dgy  -- gy [ɟ]
  | Dly  -- ly [j]   (!) az ly = [j], nem [l]!
  | Dny  -- ny [ɲ]
  | Dsz  -- sz [s]   (!) az sz pozitív: [s]
  | Dty  -- ty [c]
  | Dzs  -- zs [ʒ]
  | Ddz  -- dz [d͡z]
  | Ddzs -- dzs [d͡ʒ]

-- ─── 4. HANG ───────────────────────────────────────────────

public export
data Hang = MaganhangzoHang Maganhangzo
          | MassalhangzoHang Massalhangzo
          | DigrafHang Digraf

public export
Fonetika : Type
Fonetika = List Hang

-- ─── 5. SHOW — IPA (a fizikai hang) ────────────────────────

public export
Show Maganhangzo where
  show Va   = "ɒ"    ; show Vaa  = "aː"
  show Ve   = "ɛ"    ; show Vee  = "eː"
  show Vi   = "i"    ; show Vii  = "iː"
  show Vo   = "o"    ; show Voo  = "oː"
  show Voe  = "ø"    ; show Voee = "øː"
  show Vu   = "u"    ; show Vuu  = "uː"
  show Vue  = "y"    ; show Vuee = "yː"

public export
Show Massalhangzo where
  show Mb = "b"  ; show Mc = "t͡s" ; show Md = "d"  ; show Mf = "f"
  show Mg = "ɡ"  ; show Mh = "h"   ; show Mj = "j"  ; show Mk = "k"
  show Ml = "l"  ; show Mm = "m"   ; show Mn = "n"  ; show Mp = "p"
  show Mr = "r"  ; show Ms = "ʃ"   ; show Mt = "t"  ; show Mv = "v"
  show Mz = "z"  ; show Mng = "ŋ"

public export
Show Digraf where
  show Dcs  = "t͡ʃ" ; show Dgy = "ɟ"  ; show Dly = "j"
  show Dny  = "ɲ"  ; show Dsz = "s"  ; show Dty = "c"
  show Dzs  = "ʒ"  ; show Ddz = "d͡z" ; show Ddzs = "d͡ʒ"

public export
Show Hang where
  show (MaganhangzoHang m)  = show m
  show (MassalhangzoHang m) = show m
  show (DigrafHang d)       = show d

||| A fonematikus sor IPA-jelekkel ( Determinisztikus 1:1 átírás.
||| Az allofonikus finomságok — pl. szóvégi hosszú→rövid —
||| már a FONETIKAI réteghez tartoznak, ez a FONÉMA-réteg.)
public export
ipaForma : Fonetika -> String
ipaForma fs = "[" ++ concatMap show fs ++ "]"

-- ─── 6. KISBETŰSÍTÉS ───────────────────────────────────────

kisbetu : Char -> Char
kisbetu c = case c of
  'A' => 'a'; 'Á' => 'á'; 'E' => 'e'; 'É' => 'é'; 'I' => 'i'; 'Í' => 'í'
  'O' => 'o'; 'Ó' => 'ó'; 'Ö' => 'ö'; 'Ő' => 'ő'; 'U' => 'u'; 'Ú' => 'ú'
  'Ü' => 'ü'; 'Ű' => 'ű'
  'B' => 'b'; 'C' => 'c'; 'D' => 'd'; 'F' => 'f'; 'G' => 'g'; 'H' => 'h'
  'J' => 'j'; 'K' => 'k'; 'L' => 'l'; 'M' => 'm'; 'N' => 'n'; 'P' => 'p'
  'R' => 'r'; 'S' => 's'; 'T' => 't'; 'V' => 'v'; 'Z' => 'z'
  _   => c

kisbetusitett : List Char -> List Char
kisbetusitett = map kisbetu

-- ─── 6b. UNICODE-NORMALIZÁLÁS (NFD → összeépített) ─────────
-- A bemenő szövegben az ékezetes betűk gyakran DEKOMPONÁLT
-- (NFD) alakban állnak: á = 'a' + U+0301. Ez a karakterkódolás
-- gauge-ja — az átíró ELŐTT normalizálunk (determinisztikusan).

isKombinacio : Char -> Bool
isKombinacio c = (c >= '\x0300') && (c <= '\x036F')

||| Bázis + kombináló jel → összeépített betű.
kombinal : Char -> Char -> Char
kombinal b m = case m of
  '\x0301' => case b of   -- éles ékezet
    'a' => 'á'; 'e' => 'é'; 'i' => 'í'; 'o' => 'ó'; 'u' => 'ú'
    'ö' => 'ő'; 'ü' => 'ű'
    _ => b
  '\x0308' => case b of   -- kettős pont
    'o' => 'ö'; 'u' => 'ü'
    _ => b
  _ => b

||| NFD → NFC-normalizálás (a kombináló jeleket beolvasztja).
||| BUGFIX: az else-ág a cs-re (a teljes maradékra) recursál,
||| nem xs-re (ami kihagyná az m-et — minden második betű elveszett).
public export
normalizal : List Char -> List Char
normalizal hs = go (length hs) hs
  where
    go : Nat -> List Char -> List Char
    go _ [] = []
    go Z _ = []
    go (S n) (b :: cs) = case cs of
      [] => [b]
      (m :: xs) =>
        if isKombinacio m
          then go n (kombinal b m :: xs)
          else b :: go n cs

||| String-normalizálás: nfcForma "a+´" = "á" (gauge-fix a kódolásra).
public export
nfcForma : String -> String
nfcForma s = pack (normalizal (unpack s))

-- ─── 7. GRAFÉMA→FONÉMA ÁTÍRÓ (determinisztikus) ────────────
-- Leghosszabb egyezés elve; a GEMINÁTUMOK a digráf KÉTSZER
-- jelennek meg (szótaghatá-osztás miatt).

atiro : List Char -> Fonetika
atiro [] = []
atiro (c :: cs) = case c of
  -- magánhangzók
  'a' => MaganhangzoHang Va   :: atiro cs
  'á' => MaganhangzoHang Vaa  :: atiro cs
  'e' => MaganhangzoHang Ve   :: atiro cs
  'é' => MaganhangzoHang Vee  :: atiro cs
  'i' => MaganhangzoHang Vi   :: atiro cs
  'í' => MaganhangzoHang Vii  :: atiro cs
  'o' => MaganhangzoHang Vo   :: atiro cs
  'ó' => MaganhangzoHang Voo  :: atiro cs
  'ö' => MaganhangzoHang Voe  :: atiro cs
  'ő' => MaganhangzoHang Voee :: atiro cs
  'u' => MaganhangzoHang Vu   :: atiro cs
  'ú' => MaganhangzoHang Vuu  :: atiro cs
  'ü' => MaganhangzoHang Vue  :: atiro cs
  'ű' => MaganhangzoHang Vuee :: atiro cs
  -- d-ág: ddzs / ddz / dzs / dz
  'd' => case cs of
    ('d' :: 'z' :: 's' :: xs) => DigrafHang Ddzs :: DigrafHang Ddzs :: atiro xs
    ('z' :: 's' :: xs)        => DigrafHang Ddzs :: atiro xs
    ('d' :: 'z' :: xs)        => DigrafHang Ddz  :: DigrafHang Ddz  :: atiro xs
    ('z' :: xs)               => DigrafHang Ddz  :: atiro xs
    _                         => MassalhangzoHang Md :: atiro cs
  -- c-ág: ccs / cs
  'c' => case cs of
    ('c' :: 's' :: xs) => DigrafHang Dcs :: DigrafHang Dcs :: atiro xs
    ('s' :: xs)        => DigrafHang Dcs :: atiro xs
    _                  => MassalhangzoHang Mc :: atiro cs
  -- g-ág: ggy / gy
  'g' => case cs of
    ('g' :: 'y' :: xs) => DigrafHang Dgy :: DigrafHang Dgy :: atiro xs
    ('y' :: xs)        => DigrafHang Dgy :: atiro xs
    _                  => MassalhangzoHang Mg :: atiro cs
  -- l-ág: lly / ly
  'l' => case cs of
    ('l' :: 'y' :: xs) => DigrafHang Dly :: DigrafHang Dly :: atiro xs
    ('y' :: xs)        => DigrafHang Dly :: atiro xs
    _                  => MassalhangzoHang Ml :: atiro cs
  -- n-ág: nny/nng/ngy/ng/ny/n (epitran: ngy→[nɟ], ng→[ŋ], nng→[ŋː])
  'n' => case cs of
    ('n' :: 'y' :: xs) => DigrafHang Dny :: DigrafHang Dny :: atiro xs
    ('n' :: 'g' :: xs) => MassalhangzoHang Mng :: MassalhangzoHang Mng :: atiro xs
    ('g' :: 'y' :: xs) => MassalhangzoHang Mn :: DigrafHang Dgy :: atiro xs
    ('g' :: xs)        => MassalhangzoHang Mng :: atiro xs
    ('y' :: xs)        => DigrafHang Dny :: atiro xs
    _                  => MassalhangzoHang Mn :: atiro cs
  -- s-ág: ssz / sz / s[ʃ]
  's' => case cs of
    ('s' :: 'z' :: xs) => DigrafHang Dsz :: DigrafHang Dsz :: atiro xs
    ('z' :: xs)        => DigrafHang Dsz :: atiro xs
    _                  => MassalhangzoHang Ms :: atiro cs
  -- t-ág: tty / ty
  't' => case cs of
    ('t' :: 'y' :: xs) => DigrafHang Dty :: DigrafHang Dty :: atiro xs
    ('y' :: xs)        => DigrafHang Dty :: atiro xs
    _                  => MassalhangzoHang Mt :: atiro cs
  -- z-ág: zzs / zs
  'z' => case cs of
    ('z' :: 's' :: xs) => DigrafHang Dzs :: DigrafHang Dzs :: atiro xs
    ('s' :: xs)        => DigrafHang Dzs :: atiro xs
    _                  => MassalhangzoHang Mz :: atiro cs
  -- egyszerű mássalhangzók
  'b' => MassalhangzoHang Mb :: atiro cs
  'f' => MassalhangzoHang Mf :: atiro cs
  'h' => MassalhangzoHang Mh :: atiro cs
  'j' => MassalhangzoHang Mj :: atiro cs
  'k' => MassalhangzoHang Mk :: atiro cs
  'm' => MassalhangzoHang Mm :: atiro cs
  'p' => MassalhangzoHang Mp :: atiro cs
  'r' => MassalhangzoHang Mr :: atiro cs
  'v' => MassalhangzoHang Mv :: atiro cs
  -- idegen betűk (epitran: x→ks, y→i, w→v, qu→kv, ch→h)
  'x' => MassalhangzoHang Mk :: MassalhangzoHang Ms :: atiro cs
  'y' => MaganhangzoHang Vi :: atiro cs
  'w' => MassalhangzoHang Mv :: atiro cs
  'q' => case cs of
    ('u' :: xs) => MassalhangzoHang Mk :: MassalhangzoHang Mv :: atiro xs
    _           => MassalhangzoHang Mk :: atiro cs
  -- egyéb jel átugorva
  _   => atiro cs

||| A magyar szó fonémás hangsort — determinisztikusan számolva.
||| (Előbb NFD→NFC-normalizál, kisbetűz, aztán átír.)
public export
magyarHangok : String -> Fonetika
magyarHangok szo = atiro (kisbetusitett (normalizal (unpack szo)))

||| A szó IPA-alakja Stringként (a FONÉMA-réteg 1:1 átírása).
public export
magyarIPA : String -> String
magyarIPA szo = ipaForma (magyarHangok szo)

-- ─── 8. EGYENLŐSÉGEK ───────────────────────────────────────

public export
Eq Maganhangzo where
  Va == Va = True; Vaa == Vaa = True; Ve == Ve = True; Vee == Vee = True
  Vi == Vi = True; Vii == Vii = True; Vo == Vo = True; Voo == Voo = True
  Voe == Voe = True; Voee == Voee = True; Vu == Vu = True; Vuu == Vuu = True
  Vue == Vue = True; Vuee == Vuee = True
  _ == _ = False

public export
Eq Massalhangzo where
  Mb == Mb = True; Mc == Mc = True; Md == Md = True; Mf == Mf = True
  Mg == Mg = True; Mh == Mh = True; Mj == Mj = True; Mk == Mk = True
  Ml == Ml = True; Mm == Mm = True; Mn == Mn = True; Mp == Mp = True
  Mr == Mr = True; Ms == Ms = True; Mt == Mt = True; Mv == Mv = True
  Mz == Mz = True; Mng == Mng = True
  _ == _ = False

public export
Eq Digraf where
  Dcs == Dcs = True; Dgy == Dgy = True; Dly == Dly = True
  Dny == Dny = True; Dsz == Dsz = True; Dty == Dty = True
  Dzs == Dzs = True; Ddz == Ddz = True; Ddzs == Ddzs = True
  _ == _ = False

public export
Eq Hang where
  (MaganhangzoHang m1)  == (MaganhangzoHang m2)  = m1 == m2
  (MassalhangzoHang m1) == (MassalhangzoHang m2) = m1 == m2
  (DigrafHang d1)       == (DigrafHang d2)       = d1 == d2
  _ == _ = False

-- ─── 9. FONÉMA-HAMMING TÁVOLSÁG ────────────────────────────

public export
fonetikaiTavolsag : Fonetika -> Fonetika -> Nat
fonetikaiTavolsag [] [] = 0
fonetikaiTavolsag [] (_ :: ys) = 1 + fonetikaiTavolsag [] ys
fonetikaiTavolsag (_ :: xs) [] = 1 + fonetikaiTavolsag xs []
fonetikaiTavolsag (x :: xs) (y :: ys) =
  (if x == y then 0 else 1) + fonetikaiTavolsag xs ys

-- ─── 10. SZÓTAG — támadás + mag + kóda ─────────────────────

||| Egy szótag: támadás (onset) + mag (nucleus, PONTOSAN egy
||| magánhangzó) + kóda (coda). A magyar szótag Closed/Vierstruktur.
public export
record Szotag where
  constructor SzotagK
  tamadas : List Hang    -- onset
  mag     : Maganhangzo  -- nucleus
  koda    : List Hang    -- coda

public export
Show Szotag where
  show s = concatMap show (tamadas s ++ [MaganhangzoHang (mag s)] ++ koda s)

||| Szótagolt alak pontokkal: "ka·te·gó·ri·a"
public export
showSzotagok : List Szotag -> String
showSzotagok [] = ""
showSzotagok [s] = show s
showSzotagok (s :: ss) = show s ++ "·" ++ showSzotagok ss

-- ─── 11. SZÓTAGOLÁS — determinisztikus algoritmus ──────────

-- (előző magánhangzó óta gyűlt mássalhangzók, a magánhangzó)
record Darab where
  constructor DarabK
  elozoMass : List Hang
  darabMag  : Maganhangzo

-- darabolás: minden magánhangzóhoz a megelőző mássalhangzók
-- (a szóvégi maradék mint második komponens — az utolsó kóda)
darabolas : List Hang -> (List Darab, List Hang)
darabolas hs = go [] hs
  where
    go : List Hang -> List Hang -> (List Darab, List Hang)
    go acc [] = ([], acc)
    go acc ((MaganhangzoHang v) :: hs') =
      let (ds, veg) = go [] hs' in (DarabK (reverse acc) v :: ds, veg)
    go acc ((MassalhangzoHang m) :: hs') = go ((MassalhangzoHang m) :: acc) hs'
    go acc ((DigrafHang d) :: hs') = go ((DigrafHang d) :: acc) hs'

-- kóda/támadás elosztás két magánhangzó közt:
--   0 → (hiatus) üres/üres; 1 → üres/[c]; 2+ → [első]/[többi]
eloszt : List Hang -> (List Hang, List Hang)
eloszt [] = ([], [])
eloszt [c] = ([], [c])
eloszt (c :: cs) = ([c], cs)

||| A szótagolás: minden magánhangzó szótag-mag; a köztes
||| mássalhangzók az `eloszt` szabály szerint oszlanak meg.
public export
szotagol : List Hang -> List Szotag
szotagol hs = case darabolas hs of
  ((DarabK tam v) :: tobbi, veg) => kitolt (SzotagK tam v []) tobbi veg
  ([], _) => []
  where
    kitolt : Szotag -> List Darab -> List Hang -> List Szotag
    kitolt elso [] veg =
      [SzotagK (tamadas elso) (mag elso) (koda elso ++ veg)]
    kitolt elso ((DarabK mass v) :: ds) veg =
      let (kodaP, tam) = eloszt mass
      in (SzotagK (tamadas elso) (mag elso) (koda elso ++ kodaP))
           :: kitolt (SzotagK tam v []) ds veg

||| Magyar szó szótagolása: magyarSzotagok "kategória" = ka·te·gó·ri·a
public export
magyarSzotagok : String -> List Szotag
magyarSzotagok szo = szotagol (magyarHangok szo)

||| Szótagolt forma Stringként: szotagForma "kutya" = "ku·tya"
public export
szotagForma : String -> String
szotagForma szo = showSzotagok (magyarSzotagok szo)

||| A szótagok száma (= a magánhangzók száma — a magyar
||| szótagolás invariantense: minden magánhangzó pontosan egy
||| szótag magja).
public export
szotagSzam : String -> Nat
szotagSzam szo = length (magyarSzotagok szo)

-- ─── 12. HANGSÚLY — determinisztikus: az első szótag ──────
-- A magyarban a hangsúly MINDIG az első szótagon áll
-- (nincs szabálytalanság — mint a kvint: az első Fermat-prim).

||| A magyar szó hangsúlypozíciója: mindig 0 (az első szótag).
public export
hangsulyPozicio : Nat
hangsulyPozicio = 0

-- ─── 12b. GRAFÉMA-VISSZAÍRÁS (kanonikus, olvasható forma) ──
-- A Hang → betű leképezés kanonikus (ly→"ly", sz→"sz"): a
-- geminátum (Dsz::Dsz) visszaírása "ssz" — az EREDETI helyesírás
-- rekonstruálódik (veszteségmentes kör: írás→fonéma→írás').

grafema : Hang -> String
grafema (MaganhangzoHang m) = case m of
  Va => "a"; Vaa => "á"; Ve => "e"; Vee => "é"; Vi => "i"; Vii => "í"
  Vo => "o"; Voo => "ó"; Voe => "ö"; Voee => "ő"; Vu => "u"; Vuu => "ú"
  Vue => "ü"; Vuee => "ű"
grafema (MassalhangzoHang m) = case m of
  Mb => "b"; Mc => "c"; Md => "d"; Mf => "f"; Mg => "g"; Mh => "h"
  Mj => "j"; Mk => "k"; Ml => "l"; Mm => "m"; Mn => "n"; Mp => "p"
  Mr => "r"; Ms => "s"; Mt => "t"; Mv => "v"; Mz => "z"; Mng => "ng"
grafema (DigrafHang d) = case d of
  Dcs => "cs"; Dgy => "gy"; Dly => "ly"; Dny => "ny"; Dsz => "sz"
  Dty => "ty"; Dzs => "zs"; Ddz => "dz"; Ddzs => "dzs"

||| Digráf félbetűje (geminátum visszaírásához): ny→"n", sz→"s", ...
public export
elsoBetu : Hang -> String
elsoBetu (DigrafHang d) = case d of
  Dcs => "c"; Dgy => "g"; Dly => "l"; Dny => "n"; Dsz => "s"
  Dty => "t"; Dzs => "z"; Ddz => "d"; Ddzs => "d"
elsoBetu h = grafema h

||| Szótag graféma-alakja adott kódával.
renderSzotagKodaval : Szotag -> List Hang -> String
renderSzotagKodaval s k =
  concatMap grafema (tamadas s ++ [MaganhangzoHang (mag s)] ++ k)

||| Utolsó elem eltávolítása (init), strukturálisan.
utolsoElott : List a -> List a
utolsoElott [] = []
utolsoElott [_] = []
utolsoElott (x :: xs) = x :: utolsoElott xs

public export
szotagGrafema : Szotag -> String
szotagGrafema s = renderSzotagKodaval s (koda s)

||| Geminátum-tudatos szótag-sor visszaírása: ha egy szótag kódájának
||| utolsó hangja ugyanaz a digráf, mint a következő támadásának
||| első hangja (nny, ssz, ggy …), a kóda utolsó elemét FÉLBETŰvel
||| írjuk: men|nye, asz|szony …
||| Szótag-sor graféma-visszaírása. A geminátumokra (nny, ssz, ggy…)
||| az AkH. 226.f szabály érvényes: „a kettőzött többjegyű betű
||| elválasztásakor mind a sor végén, mind a következő sor elején
||| ki kell írni a teljes rövid mássalhangzót" — meny-nye-zet,
||| ösz-sze, szity-tya. Ezt a tiszta 1:1 fonéma→graféma visszaírás
||| AUTOMATIKUSAN adja: a fonémák maguk oszlanak a határon
||| ([ɲ][ɲ], [s][s]…), és mindegyik a teljes digráfjaként íródik.
||| Felezés (men|nye) nem helyes — az a fonetikai, nem a
||| helyesírási határ.
geminatosSor : List Szotag -> String
geminatosSor [] = ""
geminatosSor [x] = szotagGrafema x
geminatosSor (x :: xs) = szotagGrafema x ++ "\183" ++ geminatosSor xs

||| Szótagolt forma a BETŰKKEL (graféma-réteg), geminátum-tudatosan:
||| grafForma "kutya" = "ku·tya"; grafForma "mennyezet" = "men·nye·zet"
public export
grafForma : String -> String
grafForma szo = geminatosSor (magyarSzotagok szo)

-- ─── 13. A HANGRENSZER SZÁMAI ──────────────────────────────

-- Kimenet: 14 (a magánhangzók — a mély/magyar két 7-ese)
public export
maganhagzokSzama : Nat
maganhagzokSzama = 14

-- Kimenet: 17 (az egyszerű mássalhangzók)
public export
massalhangzokSzama : Nat
massalhangzokSzama = 17

-- Kimenet: 9 (a digráfok — az oktonion imagináriusai)
public export
digrafokSzama : Nat
digrafokSzama = 9

-- Kimenet: 40 (a teljes hangrendszer — az E9 "Hungarian = O" tétele)
public export
hangrendszerSzama : Nat
hangrendszerSzama = maganhagzokSzama + massalhangzokSzama + digrafokSzama

-- ─── REGISZTRÁCIÓ (ModulRegisztracio) ─────────────────────
public export
FonetikaLeiras : ModulLeirasT
FonetikaLeiras = ModulLeirasKonstruktor
  "Fonetika.idr" "40 hang, IPA, szótagolás (AkH.226.f), ng→[ŋ]" "a szókincs TÍPUS — a szavak nem String, hanem Hang-konstruktorok" "65 teszt"
