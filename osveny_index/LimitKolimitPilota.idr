module LimitKolimitPilota

-- ═══════════════════════════════════════════════════════════════
-- LIMIT/KOLIMIT PILÓTA — 000.03 lépés (EGY VONAL)
-- / 四语言标题：极限/余极限试点模块 /
-- / Pilotmodul für Limiten/Kolimiten /
-- / מודול פיילוט לגבולות/קו-גבולות /
-- ═══════════════════════════════════════════════════════════════
-- Az öreg LimitKolimitDemo.idr (record-newtype-stílus) ÚJRAÍRÁSA
-- data-típusokkal, az Alap.CsomagoltTipusok + Alap.Hatar API-ján.
-- A típus = a dokumentáció; semmi csomagolatlan Nat/String/List.
-- Források: nLab, Awodey §5.1–5.4, Mac Lane §III.4 (a szavakban!).
-- GAN-terv: 2026-09-02_000.03_LimitKolimitPilota_GAN_terv.md
-- ═══════════════════════════════════════════════════════════════

import Alap.CsomagoltTipusok
import Alap.Hatar

%default total

-- ─── A TÍPUS: a tíz limit/kolimit fogalom ─────────────────────
-- Az objektumok, amelyekkel a kategóriaelmélet dolgozik:
-- a lista-kategória lim/colim objektumai, típusban.

public export
data Fogalom : Type where
  Végződés       : Fogalom
  Kezdet         : Fogalom
  Szorzat        : Fogalom
  Koprodukt      : Fogalom
  Egyenlítő      : Fogalom
  Koegyenlítő    : Fogalom
  Pullback       : Fogalom
  Pushout        : Fogalom
  ÁltalánosLimit   : Fogalom
  ÁltalánosKolimit : Fogalom

-- ─── A SORSZÁM-KÓDOLÁS ────────────────────────────────────────

public export
fogalomSorszám : Fogalom -> Sorszám
fogalomSorszám Végződés         = sorEgy
fogalomSorszám Kezdet           = sorKettő
fogalomSorszám Szorzat          = sorHárom
fogalomSorszám Koprodukt        = sorNégy
fogalomSorszám Egyenlítő        = sorÖt
fogalomSorszám Koegyenlítő      = sorHat
fogalomSorszám Pullback         = sorHét
fogalomSorszám Pushout          = sorNyolc
fogalomSorszám ÁltalánosLimit   = sorKilenc
fogalomSorszám ÁltalánosKolimit = sorTíz

-- ─── A SZÓ: minden fogalom egy graféma-szóval ─────────────────
-- (digráf-barát bontás — a mohó olvasó szerint: sz=Sz, gy=Gy,
--  ny=Ny, zs=Zs; a «pullback» ll-je NEM LyBetű — az ly=l+y!)

public export
fogalomSzava : Fogalom -> Szöveg
fogalomSzava Végződés = BetűtFűz VBetű (BetűtFűz ÉBetű (BetűtFűz GBetű
  (BetűtFűz ZBetű (BetűtFűz ŐBetű (BetűtFűz DBetű (BetűtFűz ÉBetű
  (BetűtFűz SBetű ÜresSzöveg)))))))
fogalomSzava Kezdet = BetűtFűz KBetű (BetűtFűz EBetű (BetűtFűz ZBetű
  (BetűtFűz DBetű (BetűtFűz EBetű (BetűtFűz TBetű ÜresSzöveg)))))
fogalomSzava Szorzat = BetűtFűz SzBetű (BetűtFűz OBetű (BetűtFűz RBetű
  (BetűtFűz ZBetű (BetűtFűz ABetű (BetűtFűz TBetű ÜresSzöveg)))))
fogalomSzava Koprodukt = BetűtFűz KBetű (BetűtFűz OBetű (BetűtFűz PBetű
  (BetűtFűz RBetű (BetűtFűz OBetű (BetűtFűz DBetű (BetűtFűz UBetű
  (BetűtFűz KBetű (BetűtFűz TBetű ÜresSzöveg))))))))
fogalomSzava Egyenlítő = BetűtFűz EBetű (BetűtFűz GyBetű (BetűtFűz EBetű
  (BetűtFűz NBetű (BetűtFűz LBetű (BetűtFűz ÍBetű (BetűtFűz TBetű
  (BetűtFűz ŐBetű ÜresSzöveg)))))))
fogalomSzava Koegyenlítő = BetűtFűz KBetű (BetűtFűz OBetű (BetűtFűz EBetű
  (BetűtFűz GyBetű (BetűtFűz EBetű (BetűtFűz NBetű (BetűtFűz LBetű
  (BetűtFűz ÍBetű (BetűtFűz TBetű (BetűtFűz ŐBetű
  ÜresSzöveg)))))))))
fogalomSzava Pullback = BetűtFűz PBetű (BetűtFűz UBetű (BetűtFűz LBetű
  (BetűtFűz LBetű (BetűtFűz BBetű (BetűtFűz ABetű (BetűtFűz CBetű
  (BetűtFűz KBetű ÜresSzöveg)))))))
fogalomSzava Pushout = BetűtFűz PBetű (BetűtFűz UBetű (BetűtFűz SBetű
  (BetűtFűz HBetű (BetűtFűz OBetű (BetűtFűz UBetű (BetűtFűz TBetű
  ÜresSzöveg))))))
fogalomSzava ÁltalánosLimit = BetűtFűz ÁBetű (BetűtFűz LBetű (BetűtFűz TBetű
  (BetűtFűz ABetű (BetűtFűz LBetű (BetűtFűz ÁBetű (BetűtFűz NBetű
  (BetűtFűz OBetű (BetűtFűz SBetű (BetűtFűz LBetű (BetűtFűz IBetű
  (BetűtFűz MBetű (BetűtFűz IBetű (BetűtFűz TBetű
  ÜresSzöveg)))))))))))))
fogalomSzava ÁltalánosKolimit = BetűtFűz ÁBetű (BetűtFűz LBetű (BetűtFűz TBetű
  (BetűtFűz ABetű (BetűtFűz LBetű (BetűtFűz ÁBetű (BetűtFűz NBetű
  (BetűtFűz OBetű (BetűtFűz SBetű (BetűtFűz KBetű (BetűtFűz OBetű
  (BetűtFűz LBetű (BetűtFűz IBetű (BetűtFűz MBetű (BetűtFűz IBetű
  (BetűtFűz TBetű ÜresSzöveg))))) ))))) )))))

-- ─── A DUÁLISÁG: a tükrözés a tízen ───────────────────────────
-- Végződés↔Kezdet, Szorzat↔Koprodukt, Egyenlítő↔Koegyenlítő,
-- Pullback↔Pushout, Limit↔Kolimit — az öt duális-pár.

public export
fogalomDuálisa : Fogalom -> Fogalom
fogalomDuálisa Végződés         = Kezdet
fogalomDuálisa Kezdet           = Végződés
fogalomDuálisa Szorzat          = Koprodukt
fogalomDuálisa Koprodukt        = Szorzat
fogalomDuálisa Egyenlítő        = Koegyenlítő
fogalomDuálisa Koegyenlítő      = Egyenlítő
fogalomDuálisa Pullback         = Pushout
fogalomDuálisa Pushout          = Pullback
fogalomDuálisa ÁltalánosLimit   = ÁltalánosKolimit
fogalomDuálisa ÁltalánosKolimit = ÁltalánosLimit

-- BIZONYÍTÁS: a duális tükrözése involúció — tíz Refl.
public export
duálisInvolúció : (f : Fogalom) -> fogalomDuálisa (fogalomDuálisa f) = f
duálisInvolúció Végződés         = Refl
duálisInvolúció Kezdet           = Refl
duálisInvolúció Szorzat          = Refl
duálisInvolúció Koprodukt        = Refl
duálisInvolúció Egyenlítő        = Refl
duálisInvolúció Koegyenlítő      = Refl
duálisInvolúció Pullback         = Refl
duálisInvolúció Pushout          = Refl
duálisInvolúció ÁltalánosLimit   = Refl
duálisInvolúció ÁltalánosKolimit = Refl

-- ─── AZ EGYENLŐSÉG-INSTANCE A BIZONYÍTÁSOK ELŐTT ──────────────
-- (a 0.8.0-csapda #: az interface-metódus a TÍPUSBAN csak akkor
--  oldódik, ha az instance KORÁBBAN szerepel a fájlban)

public export
EgyenlőségT Fogalom where
  egyenlőE a b = egyenlőE (fogalomSorszám a) (fogalomSorszám b)

-- BIZONYÍTÁS: nincs önduális a tíz között (a tükrözés fixpontmentes).
public export
duálisNemFixpont : (f : Fogalom) -> egyenlőE (fogalomDuálisa f) f = Hamis
duálisNemFixpont Végződés         = Refl
duálisNemFixpont Kezdet           = Refl
duálisNemFixpont Szorzat          = Refl
duálisNemFixpont Koprodukt        = Refl
duálisNemFixpont Egyenlítő        = Refl
duálisNemFixpont Koegyenlítő      = Refl
duálisNemFixpont Pullback         = Refl
duálisNemFixpont Pushout          = Refl
duálisNemFixpont ÁltalánosLimit   = Refl
duálisNemFixpont ÁltalánosKolimit = Refl

-- ─── A TOVÁBBI INSTANCE-OK ─────────────────────────────────────

public export
RendezésT Fogalom where
  kisebbE a b = sorKisebb (fogalomSorszám a) (fogalomSorszám b)

public export
MegjelenítésT Fogalom where
  megjelenít = fogalomSzava

-- ─── A SORSZÁM-VISSZAFORDÍTÁS ──────────────────────────────────

public export
sorbólFogalom : Sorszám -> Talán Fogalom
sorbólFogalom s = case sorbólEgész s of
  EgészEgy    => Csak Végződés
  EgészKettő  => Csak Kezdet
  EgészHárom  => Csak Szorzat
  EgészNégy   => Csak Koprodukt
  EgészÖt     => Csak Egyenlítő
  EgészHat    => Csak Koegyenlítő
  EgészHét    => Csak Pullback
  EgészNyolc  => Csak Pushout
  EgészKilenc => Csak ÁltalánosLimit
  EgészTíz    => Csak ÁltalánosKolimit
  _           => Semmi

-- BIZONYÍTÁS: a kódolás bijektív — tíz Refl.
public export
sorszámVisszafordít : (f : Fogalom) -> sorbólFogalom (fogalomSorszám f) = Csak f
sorszámVisszafordít Végződés         = Refl
sorszámVisszafordít Kezdet           = Refl
sorszámVisszafordít Szorzat          = Refl
sorszámVisszafordít Koprodukt        = Refl
sorszámVisszafordít Egyenlítő        = Refl
sorszámVisszafordít Koegyenlítő      = Refl
sorszámVisszafordít Pullback         = Refl
sorszámVisszafordít Pushout          = Refl
sorszámVisszafordít ÁltalánosLimit   = Refl
sorszámVisszafordít ÁltalánosKolimit = Refl

-- ─── A FŰZÉR-MOTOR: a bejárás (TOTAL — strukturális) ──────────

public export
füzérBejárás : {tag : Type} -> (tag -> IO ()) -> Füzér tag -> IO ()
füzérBejárás _ FüzérVége = pure ()
füzérBejárás teendő (Fűzés elem tovább) = do
  teendő elem
  füzérBejárás teendő tovább

-- ─── A TÍZ FOGLALOM LISTÁJA ───────────────────────────────────

public export
fogalomListája : Füzér Fogalom
fogalomListája = Fűzés Végződés (Fűzés Kezdet (Fűzés Szorzat
  (Fűzés Koprodukt (Fűzés Egyenlítő (Fűzés Koegyenlítő (Fűzés Pullback
  (Fűzés Pushout (Fűzés ÁltalánosLimit (Fűzés ÁltalánosKolimit
  FüzérVége)))))))))

-- BIZONYÍTÁS: a lista tíz elemű.
-- (a 0.8.0-csapda #4: a típusban álló kisbetűs konstans minősítendő)
public export
fogalomListájaHossza :
  füzérHossz LimitKolimitPilota.fogalomListája
  = Alap.CsomagoltTipusok.sorTíz
fogalomListájaHossza = Refl

-- ─── AZ ÖT DUÁLIS-PÁR TÁBLÁZATA ───────────────────────────────

public export
duálisPárok : Füzér (Pár Fogalom Fogalom)
duálisPárok = Fűzés (Párosít Végződés Kezdet) (Fűzés (Párosít Szorzat
  Koprodukt) (Fűzés (Párosít Egyenlítő Koegyenlítő) (Fűzés (Párosít
  Pullback Pushout) (Fűzés (Párosít ÁltalánosLimit ÁltalánosKolimit)
  FüzérVége))))

-- BIZONYÍTÁS: öt pár; és mindegyik pár a duális-leképezés igazát hordozza.
public export
duálisPárokHossza :
  füzérHossz LimitKolimitPilota.duálisPárok
  = Alap.CsomagoltTipusok.sorÖt
duálisPárokHossza = Refl

public export
végződésPárTanú : egyenlőE (fogalomDuálisa Végződés) Kezdet = Igaz
végződésPárTanú = Refl

public export
szorzatPárTanú : egyenlőE (fogalomDuálisa Szorzat) Koprodukt = Igaz
szorzatPárTanú = Refl

public export
egyenlítőPárTanú : egyenlőE (fogalomDuálisa Egyenlítő) Koegyenlítő = Igaz
egyenlítőPárTanú = Refl

public export
pullbackPárTanú : egyenlőE (fogalomDuálisa Pullback) Pushout = Igaz
pullbackPárTanú = Refl

public export
általánosLimitPárTanú : egyenlőE (fogalomDuálisa ÁltalánosLimit)
  ÁltalánosKolimit = Igaz
általánosLimitPárTanú = Refl

-- ─── A SZÁMNEVEK: a magyar bemenet szavai ──────────────────────
-- (graféma-bontás a mohó olvasó szerint: egy=[e,gy], négy=[n,é,gy],
--  nyolc=[ny,o,l,c] — a YBetű nem létezik, a fordító kényszeríti!)

public export
egySzava : Szöveg
egySzava = BetűtFűz EBetű (BetűtFűz GyBetű ÜresSzöveg)

public export
kettőSzava : Szöveg
kettőSzava = BetűtFűz KBetű (BetűtFűz EBetű (BetűtFűz TBetű (BetűtFűz TBetű
  (BetűtFűz ŐBetű ÜresSzöveg))))

public export
háromSzava : Szöveg
háromSzava = BetűtFűz HBetű (BetűtFűz ÁBetű (BetűtFűz RBetű (BetűtFűz OBetű
  (BetűtFűz MBetű ÜresSzöveg))))

public export
négySzava : Szöveg
négySzava = BetűtFűz NBetű (BetűtFűz ÉBetű (BetűtFűz GyBetű ÜresSzöveg))

public export
ötSzava : Szöveg
ötSzava = BetűtFűz ÖBetű (BetűtFűz TBetű ÜresSzöveg)

public export
hatSzava : Szöveg
hatSzava = BetűtFűz HBetű (BetűtFűz ABetű (BetűtFűz TBetű ÜresSzöveg))

public export
hétSzava : Szöveg
hétSzava = BetűtFűz HBetű (BetűtFűz ÉBetű (BetűtFűz TBetű ÜresSzöveg))

public export
nyolcSzava : Szöveg
nyolcSzava = BetűtFűz NyBetű (BetűtFűz OBetű (BetűtFűz LBetű (BetűtFűz CBetű
  ÜresSzöveg)))

public export
kilencSzava : Szöveg
kilencSzava = BetűtFűz KBetű (BetűtFűz IBetű (BetűtFűz LBetű (BetűtFűz EBetű
  (BetűtFűz NBetű (BetűtFűz CBetű ÜresSzöveg)))))

public export
tízSzava : Szöveg
tízSzava = BetűtFűz TBetű (BetűtFűz ÍBetű (BetűtFűz ZBetű ÜresSzöveg))

public export
kilépésSzava : Szöveg
kilépésSzava = BetűtFűz KBetű (BetűtFűz IBetű (BetűtFűz LBetű (BetűtFűz ÉBetű
  (BetűtFűz PBetű (BetűtFűz ÉBetű (BetűtFűz SBetű ÜresSzöveg))))))

public export
mindSzava : Szöveg
mindSzava = BetűtFűz MBetű (BetűtFűz IBetű (BetűtFűz NBetű (BetűtFűz DBetű
  ÜresSzöveg)))

public export
duálisSzava : Szöveg
duálisSzava = BetűtFűz DBetű (BetűtFűz UBetű (BetűtFűz ÁBetű (BetűtFűz LBetű
  (BetűtFűz IBetű (BetűtFűz SBetű ÜresSzöveg)))))

public export
súgóSzava : Szöveg
súgóSzava = BetűtFűz SBetű (BetűtFűz ÚBetű (BetűtFűz GBetű (BetűtFűz ÓBetű
  ÜresSzöveg)))

-- ─── SZÁM-NÉV-ÁTJÁRÓK ──────────────────────────────────────────

public export
számNévbőlEgész : EgészSzám -> Szöveg
számNévbőlEgész EgészEgy    = egySzava
számNévbőlEgész EgészKettő  = kettőSzava
számNévbőlEgész EgészHárom  = háromSzava
számNévbőlEgész EgészNégy   = négySzava
számNévbőlEgész EgészÖt     = ötSzava
számNévbőlEgész EgészHat    = hatSzava
számNévbőlEgész EgészHét    = hétSzava
számNévbőlEgész EgészNyolc  = nyolcSzava
számNévbőlEgész EgészKilenc = kilencSzava
számNévbőlEgész EgészTíz    = tízSzava
számNévbőlEgész _           = ÜresSzöveg

public export
számNév : Sorszám -> Szöveg
számNév s = számNévbőlEgész (sorbólEgész s)

public export
szókéntSor : Szöveg -> Talán Sorszám
szókéntSor szó = case szövegEgyenlő szó egySzava of
  Igaz => Csak sorEgy
  Hamis => case szövegEgyenlő szó kettőSzava of
    Igaz => Csak sorKettő
    Hamis => case szövegEgyenlő szó háromSzava of
      Igaz => Csak sorHárom
      Hamis => case szövegEgyenlő szó négySzava of
        Igaz => Csak sorNégy
        Hamis => case szövegEgyenlő szó ötSzava of
          Igaz => Csak sorÖt
          Hamis => case szövegEgyenlő szó hatSzava of
            Igaz => Csak sorHat
            Hamis => case szövegEgyenlő szó hétSzava of
              Igaz => Csak sorHét
              Hamis => case szövegEgyenlő szó nyolcSzava of
                Igaz => Csak sorNyolc
                Hamis => case szövegEgyenlő szó kilencSzava of
                  Igaz => Csak sorKilenc
                  Hamis => case szövegEgyenlő szó tízSzava of
                    Igaz => Csak sorTíz
                    Hamis => Semmi

public export
számNévből : Szöveg -> Talán Fogalom
számNévből szó = case szókéntSor szó of
  Csak s => sorbólFogalom s
  Semmi  => Semmi

-- ─── A TANÚ-HÁLÓ: a szóliterálok fordítási idejű körútjai ──────
-- (a kernel a strCons-építette sztringet és a mohó digráf-olvasót
--  is redukálja — egy elírás a FORDÍTÁST buktatja, nem a futást;
--  ékezetes karakterek hexa-literálként, a 0.8.0 biztonságáért)

public export
egyKörút : karakterláncbólSzöveg (strCons 'e' (strCons 'g' (strCons 'y' "")))
  = Csak LimitKolimitPilota.egySzava
egyKörút = Refl

public export
kettőKörút : karakterláncbólSzöveg (strCons 'k' (strCons 'e' (strCons 't'
  (strCons 't' (strCons '\x0151' "")))))
  = Csak LimitKolimitPilota.kettőSzava
kettőKörút = Refl

public export
háromKörút : karakterláncbólSzöveg (strCons 'h' (strCons '\x00E1'
  (strCons 'r' (strCons 'o' (strCons 'm' "")))))
  = Csak LimitKolimitPilota.háromSzava
háromKörút = Refl

public export
négyKörút : karakterláncbólSzöveg (strCons 'n' (strCons '\x00E9'
  (strCons 'g' (strCons 'y' ""))))
  = Csak LimitKolimitPilota.négySzava
négyKörút = Refl

public export
ötKörút : karakterláncbólSzöveg (strCons '\x00F6' (strCons 't' ""))
  = Csak LimitKolimitPilota.ötSzava
ötKörút = Refl

public export
hatKörút : karakterláncbólSzöveg (strCons 'h' (strCons 'a' (strCons 't' "")))
  = Csak LimitKolimitPilota.hatSzava
hatKörút = Refl

public export
hétKörút : karakterláncbólSzöveg (strCons 'h' (strCons '\x00E9'
  (strCons 't' "")))
  = Csak LimitKolimitPilota.hétSzava
hétKörút = Refl

public export
nyolcKörút : karakterláncbólSzöveg (strCons 'n' (strCons 'y' (strCons 'o'
  (strCons 'l' (strCons 'c' "")))))
  = Csak LimitKolimitPilota.nyolcSzava
nyolcKörút = Refl

public export
kilencKörút : karakterláncbólSzöveg (strCons 'k' (strCons 'i' (strCons 'l'
  (strCons 'e' (strCons 'n' (strCons 'c' ""))))))
  = Csak LimitKolimitPilota.kilencSzava
kilencKörút = Refl

public export
tízKörút : karakterláncbólSzöveg (strCons 't' (strCons '\x00ED'
  (strCons 'z' "")))
  = Csak LimitKolimitPilota.tízSzava
tízKörút = Refl

public export
kilépésKörút : karakterláncbólSzöveg (strCons 'k' (strCons 'i' (strCons 'l'
  (strCons '\x00E9' (strCons 'p' (strCons '\x00E9' (strCons 's' "")))))))
  = Csak LimitKolimitPilota.kilépésSzava
kilépésKörút = Refl

public export
mindKörút : karakterláncbólSzöveg (strCons 'm' (strCons 'i' (strCons 'n'
  (strCons 'd' ""))))
  = Csak LimitKolimitPilota.mindSzava
mindKörút = Refl

public export
duálisKörút : karakterláncbólSzöveg (strCons 'd' (strCons 'u'
  (strCons '\x00E1' (strCons 'l' (strCons 'i' (strCons 's' ""))))))
  = Csak LimitKolimitPilota.duálisSzava
duálisKörút = Refl

public export
súgóKörút : karakterláncbólSzöveg (strCons 's' (strCons '\x00FA'
  (strCons 'g' (strCons '\x00F3' ""))))
  = Csak LimitKolimitPilota.súgóSzava
súgóKörút = Refl

-- ─── A LEÍRÁS SZAVAI (mind betűződő magyar grafémákkal) ────────
-- Irányelv (2026-09-02, a felhasználó döntése): IDEGEN NYELVŰ SZAVAK
-- IDEGEN NYELVŰEK MARADNAK — az idegen tulajdonnevek (Awodey, MacLane,
-- nLab) NEM magyarosodnak (AkH-elv: idegen tulajdonnév eredeti alakjában
-- marad). A «maclane» betűzhető magyar grafémákkal = az idegen név
-- torzítás NÉLKÜL; az «awodey» w-je viszont nem betűzhető a 44-ből —
-- ezért az awodej-átírás ELVETVE, a szerző neve a KOMMENTBEN él,
-- és az IdegenBetű-réteg a 200.37-es tervezési lépés kérdése.

mindenSzó : Szöveg
mindenSzó = BetűtFűz MBetű (BetűtFűz IBetű (BetűtFűz NBetű (BetűtFűz DBetű
  (BetűtFűz EBetű (BetűtFűz NBetű ÜresSzöveg)))))

objektumbólSzó : Szöveg
objektumbólSzó = BetűtFűz OBetű (BetűtFűz BBetű (BetűtFűz JBetű (BetűtFűz EBetű
  (BetűtFűz KBetű (BetűtFűz TBetű (BetűtFűz UBetű (BetűtFűz MBetű (BetűtFűz BBetű
  (BetűtFűz ÓBetű (BetűtFűz LBetű ÜresSzöveg))))))))))

egyetlenSzó : Szöveg
egyetlenSzó = BetűtFűz EBetű (BetűtFűz GyBetű (BetűtFűz EBetű (BetűtFűz TBetű
  (BetűtFűz LBetű (BetűtFűz EBetű (BetűtFűz NBetű ÜresSzöveg))))))

morfizmusSzó : Szöveg
morfizmusSzó = BetűtFűz MBetű (BetűtFűz OBetű (BetűtFűz RBetű (BetűtFűz FBetű
  (BetűtFűz IBetű (BetűtFűz ZBetű (BetűtFűz MBetű (BetűtFűz UBetű
  (BetűtFűz SBetű ÜresSzöveg))))))))

végződésbeSzó : Szöveg
végződésbeSzó = BetűtFűz VBetű (BetűtFűz ÉBetű (BetűtFűz GBetű (BetűtFűz ZBetű
  (BetűtFűz ŐBetű (BetűtFűz DBetű (BetűtFűz ÉBetű (BetűtFűz SBetű (BetűtFűz BBetű
  (BetűtFűz EBetű ÜresSzöveg)))))))))

kezdetbőlSzó : Szöveg
kezdetbőlSzó = BetűtFűz KBetű (BetűtFűz EBetű (BetűtFűz ZBetű (BetűtFűz DBetű
  (BetűtFűz EBetű (BetűtFűz TBetű (BetűtFűz BBetű (BetűtFűz ŐBetű
  (BetűtFűz LBetű ÜresSzöveg))))))))

objektumbaSzó : Szöveg
objektumbaSzó = BetűtFűz OBetű (BetűtFűz BBetű (BetűtFűz JBetű (BetűtFűz EBetű
  (BetűtFűz KBetű (BetűtFűz TBetű (BetűtFűz UBetű (BetűtFűz MBetű (BetűtFűz BBetű
  (BetűtFűz ABetű ÜresSzöveg)))))))))

kétSzó : Szöveg
kétSzó = BetűtFűz KBetű (BetűtFűz ÉBetű (BetűtFűz TBetű ÜresSzöveg))

vetületSzó : Szöveg
vetületSzó = BetűtFűz VBetű (BetűtFűz EBetű (BetűtFűz TBetű (BetűtFűz ÜBetű
  (BetűtFűz LBetű (BetűtFűz EBetű (BetűtFűz TBetű ÜresSzöveg))))))

univerzálisSzó : Szöveg
univerzálisSzó = BetűtFűz UBetű (BetűtFűz NBetű (BetűtFűz IBetű (BetűtFűz VBetű
  (BetűtFűz EBetű (BetűtFűz RBetű (BetűtFűz ZBetű (BetűtFűz ÁBetű (BetűtFűz LBetű
  (BetűtFűz IBetű (BetűtFűz SBetű ÜresSzöveg))))))))))

tulajdonságSzó : Szöveg
tulajdonságSzó = BetűtFűz TBetű (BetűtFűz UBetű (BetűtFűz LBetű (BetűtFűz ABetű
  (BetűtFűz JBetű (BetűtFűz DBetű (BetűtFűz OBetű (BetűtFűz NBetű (BetűtFűz SBetű
  (BetűtFűz ÁBetű (BetűtFűz GBetű ÜresSzöveg))))))))))

duálisaSzó : Szöveg
duálisaSzó = BetűtFűz DBetű (BetűtFűz UBetű (BetűtFűz ÁBetű (BetűtFűz LBetű
  (BetűtFűz IBetű (BetűtFűz SBetű (BetűtFűz ABetű ÜresSzöveg))))))

szorzatnakSzó : Szöveg
szorzatnakSzó = BetűtFűz SzBetű (BetűtFűz OBetű (BetűtFűz RBetű (BetűtFűz ZBetű
  (BetűtFűz ABetű (BetűtFűz TBetű (BetűtFűz NBetű (BetűtFűz ABetű (BetűtFűz KBetű
  ÜresSzöveg))))))))

leképezésSzó : Szöveg
leképezésSzó = BetűtFűz LBetű (BetűtFűz EBetű (BetűtFűz KBetű (BetűtFűz ÉBetű
  (BetűtFűz PBetű (BetűtFűz EBetű (BetűtFűz ZBetű (BetűtFűz ÉBetű (BetűtFűz SBetű
  ÜresSzöveg))))))))

egyezikSzó : Szöveg
egyezikSzó = BetűtFűz EBetű (BetűtFűz GyBetű (BetűtFűz EBetű (BetűtFűz ZBetű
  (BetűtFűz IBetű (BetűtFűz KBetű ÜresSzöveg)))))

rajtaSzó : Szöveg
rajtaSzó = BetűtFűz RBetű (BetűtFűz ABetű (BetűtFűz JBetű (BetűtFűz TBetű
  (BetűtFűz ABetű ÜresSzöveg))))

azSzó : Szöveg
azSzó = BetűtFűz ABetű (BetűtFűz ZBetű ÜresSzöveg)

egyenlítőnekSzó : Szöveg
egyenlítőnekSzó = BetűtFűz EBetű (BetűtFűz GyBetű (BetűtFűz EBetű (BetűtFűz NBetű
  (BetűtFűz LBetű (BetűtFűz ÍBetű (BetűtFűz TBetű (BetűtFűz ŐBetű (BetűtFűz NBetű
  (BetűtFűz EBetű (BetűtFűz KBetű ÜresSzöveg))))))))))

kommutatívSzó : Szöveg
kommutatívSzó = BetűtFűz KBetű (BetűtFűz OBetű (BetűtFűz MBetű (BetűtFűz MBetű
  (BetűtFűz UBetű (BetűtFűz TBetű (BetűtFűz ABetű (BetűtFűz TBetű (BetűtFűz ÍBetű
  (BetűtFűz VBetű ÜresSzöveg)))))))))

négyzetSzó : Szöveg
négyzetSzó = BetűtFűz NBetű (BetűtFűz ÉBetű (BetűtFűz GyBetű (BetűtFűz ZBetű
  (BetűtFűz EBetű (BetűtFűz TBetű ÜresSzöveg)))))

szorzatonSzó : Szöveg
szorzatonSzó = BetűtFűz SzBetű (BetűtFűz OBetű (BetűtFűz RBetű (BetűtFűz ZBetű
  (BetűtFűz ABetű (BetűtFűz TBetű (BetűtFűz OBetű (BetűtFűz NBetű
  ÜresSzöveg)))))))

átSzó : Szöveg
átSzó = BetűtFűz ÁBetű (BetűtFűz TBetű ÜresSzöveg)

pullbacknekSzó : Szöveg
pullbacknekSzó = BetűtFűz PBetű (BetűtFűz UBetű (BetűtFűz LBetű (BetűtFűz LBetű
  (BetűtFűz BBetű (BetűtFűz ABetű (BetűtFűz CBetű (BetűtFűz KBetű (BetűtFűz NBetű
  (BetűtFűz EBetű (BetűtFűz KBetű ÜresSzöveg))))))))))

kúpSzó : Szöveg
kúpSzó = BetűtFűz KBetű (BetűtFűz ÚBetű (BetűtFűz PBetű ÜresSzöveg))

kompatibilitásSzó : Szöveg
kompatibilitásSzó = BetűtFűz KBetű (BetűtFűz OBetű (BetűtFűz MBetű (BetűtFűz PBetű
  (BetűtFűz ABetű (BetűtFűz TBetű (BetűtFűz IBetű (BetűtFűz BBetű (BetűtFűz IBetű
  (BetűtFűz LBetű (BetűtFűz IBetű (BetűtFűz TBetű (BetűtFűz ÁBetű (BetűtFűz SBetű
  ÜresSzöveg)))))))))))))

általánoslimitnekSzó : Szöveg
általánoslimitnekSzó = BetűtFűz ÁBetű (BetűtFűz LBetű (BetűtFűz TBetű
  (BetűtFűz ABetű   (BetűtFűz LBetű (BetűtFűz ÁBetű (BetűtFűz NBetű (BetűtFűz OBetű
  (BetűtFűz SBetű (BetűtFűz LBetű (BetűtFűz IBetű (BetűtFűz MBetű (BetűtFűz IBetű
  (BetűtFűz TBetű (BetűtFűz NBetű (BetűtFűz EBetű (BetűtFűz KBetű
  ÜresSzöveg))))))))))))))))

nlabSzó : Szöveg
nlabSzó = BetűtFűz NBetű (BetűtFűz LBetű (BetűtFűz ABetű (BetűtFűz BBetű ÜresSzöveg)))

-- ELAVULT (2026-09-02): az awodej v-átírás ELVETVE — az idegen nevek
-- idegenek maradnak (a felhasználó irányelve). Nincs használó; megőrizve
-- a MANTRA szerint. A szerző neve a kommentekben él: Awodey.
ávodejSzó : Szöveg
ávodejSzó = BetűtFűz ÁBetű (BetűtFűz VBetű (BetűtFűz OBetű (BetűtFűz DBetű
  (BetűtFűz EBetű (BetűtFűz JBetű ÜresSzöveg)))))

maclaneSzó : Szöveg
maclaneSzó = BetűtFűz MBetű (BetűtFűz ABetű (BetűtFűz CBetű (BetűtFűz LBetű
  (BetűtFűz ABetű (BetűtFűz NBetű (BetűtFűz EBetű ÜresSzöveg))))))

pontSzó : Szöveg
pontSzó = BetűtFűz PBetű (BetűtFűz OBetű (BetűtFűz NBetű (BetűtFűz TBetű ÜresSzöveg)))

harmadikSzó : Szöveg
harmadikSzó = BetűtFűz HBetű (BetűtFűz ABetű (BetűtFűz RBetű (BetűtFűz MBetű
  (BetűtFűz ABetű (BetűtFűz DBetű (BetűtFűz IBetű (BetűtFűz KBetű ÜresSzöveg)))))))

fejezetSzó : Szöveg
fejezetSzó = BetűtFűz FBetű (BetűtFűz EBetű (BetűtFűz JBetű (BetűtFűz EBetű
  (BetűtFűz ZBetű (BetűtFűz EBetű (BetűtFűz TBetű ÜresSzöveg))))))

negyedikSzó : Szöveg
negyedikSzó = BetűtFűz NBetű (BetűtFűz EBetű (BetűtFűz GyBetű (BetűtFűz EBetű
  (BetűtFűz DBetű (BetűtFűz IBetű (BetűtFűz KBetű ÜresSzöveg))))))

szakaszSzó : Szöveg
szakaszSzó = BetűtFűz SzBetű (BetűtFűz ABetű (BetűtFűz KBetű (BetűtFűz ABetű
  (BetűtFűz SzBetű ÜresSzöveg))))

parancsokSzó : Szöveg
parancsokSzó = BetűtFűz PBetű (BetűtFűz ABetű (BetűtFűz RBetű (BetűtFűz ABetű
  (BetűtFűz NBetű (BetűtFűz CBetű (BetűtFűz SBetű (BetűtFűz OBetű (BetűtFűz KBetű
  ÜresSzöveg))))))))

viszlátSzó : Szöveg
viszlátSzó = BetűtFűz VBetű (BetűtFűz IBetű (BetűtFűz SBetű (BetűtFűz ZBetű
  (BetűtFűz LBetű (BetűtFűz ÁBetű (BetűtFűz TBetű ÜresSzöveg))))))

aSzó : Szöveg
aSzó = BetűtFűz ABetű ÜresSzöveg

-- ─── A FŰZÉR-ÖSSZEFŰZÉS (a 000.04-előzetes; §24-grep: nem létezett) ──

public export
füzérFűzés : {tag : Type} -> Füzér tag -> Füzér tag -> Füzér tag
füzérFűzés FüzérVége második = második
füzérFűzés (Fűzés elem tovább) második = Fűzés elem (füzérFűzés tovább második)

-- ─── A LEÍRÁSOK (szavak füzére — írásjel a Mondat-rétegen) ────

public export
fogalomLeírása : Fogalom -> Füzér Szöveg
fogalomLeírása Végződés = Fűzés mindenSzó (Fűzés objektumbólSzó
  (Fűzés egyetlenSzó (Fűzés morfizmusSzó (Fűzés aSzó
  (Fűzés végződésbeSzó FüzérVége)))))
fogalomLeírása Kezdet = Fűzés aSzó (Fűzés kezdetbőlSzó (Fűzés egyetlenSzó
  (Fűzés morfizmusSzó (Fűzés mindenSzó (Fűzés objektumbaSzó
  FüzérVége)))))
fogalomLeírása Szorzat = Fűzés kétSzó (Fűzés vetületSzó
  (Fűzés univerzálisSzó (Fűzés tulajdonságSzó FüzérVége)))
fogalomLeírása Koprodukt = Fűzés duálisaSzó (Fűzés aSzó
  (Fűzés szorzatnakSzó FüzérVége))
fogalomLeírása Egyenlítő = Fűzés aSzó (Fűzés kétSzó (Fűzés leképezésSzó
  (Fűzés egyezikSzó (Fűzés rajtaSzó FüzérVége))))
fogalomLeírása Koegyenlítő = Fűzés duálisaSzó (Fűzés azSzó
  (Fűzés egyenlítőnekSzó FüzérVége))
fogalomLeírása Pullback = Fűzés kommutatívSzó (Fűzés négyzetSzó
  (Fűzés szorzatonSzó (Fűzés átSzó FüzérVége)))
fogalomLeírása Pushout = Fűzés duálisaSzó (Fűzés aSzó
  (Fűzés pullbacknekSzó FüzérVége))
fogalomLeírása ÁltalánosLimit = Fűzés kúpSzó (Fűzés kompatibilitásSzó
  (Fűzés univerzálisSzó (Fűzés tulajdonságSzó FüzérVége)))
fogalomLeírása ÁltalánosKolimit = Fűzés duálisaSzó (Fűzés azSzó
  (Fűzés általánoslimitnekSzó FüzérVége))

-- ─── A FORRÁSOK (nLab + a pontszámok szavakban; az idegen szerzők
-- —— nevei — Awodey, Mac Lane — a kommentekben, torzítás nélkül) ──
-- Awodey §5.1 (Végződés, Kezdet, Szorzat, Koprodukt), §5.2 (Pullback,
-- Pushout), §5.3 (Egyenlítő, Koegyenlítő); Mac Lane §III.4 (Limit,
-- Kolimit); nLab megfelelő szócikkek.

forrásÖtEgy : Füzér Szöveg
forrásÖtEgy = Fűzés nlabSzó (Fűzés ötSzava
  (Fűzés pontSzó (Fűzés egySzava FüzérVége)))

forrásÖtKettő : Füzér Szöveg
forrásÖtKettő = Fűzés nlabSzó (Fűzés ötSzava
  (Fűzés pontSzó (Fűzés kettőSzava FüzérVége)))

forrásÖtHárom : Füzér Szöveg
forrásÖtHárom = Fűzés nlabSzó (Fűzés ötSzava
  (Fűzés pontSzó (Fűzés háromSzava FüzérVége)))

forrásMacLane : Füzér Szöveg
forrásMacLane = Fűzés nlabSzó (Fűzés maclaneSzó (Fűzés harmadikSzó
  (Fűzés fejezetSzó (Fűzés negyedikSzó (Fűzés szakaszSzó
  FüzérVége)))))

public export
fogalomForrása : Fogalom -> Füzér Szöveg
fogalomForrása Végződés         = forrásÖtEgy
fogalomForrása Kezdet           = forrásÖtEgy
fogalomForrása Szorzat          = forrásÖtEgy
fogalomForrása Koprodukt        = forrásÖtEgy
fogalomForrása Egyenlítő        = forrásÖtHárom
fogalomForrása Koegyenlítő      = forrásÖtHárom
fogalomForrása Pullback         = forrásÖtKettő
fogalomForrása Pushout          = forrásÖtKettő
fogalomForrása ÁltalánosLimit   = forrásMacLane
fogalomForrása ÁltalánosKolimit = forrásMacLane

-- ─── A MONDAT-ÉPÍTŐK (írásjelek itt térnek vissza) ─────────────

public export
mondatVégére : Írásjel -> Mondat -> Mondat
mondatVégére jel FüzérVége = Fűzés (JelDarab jel) FüzérVége
mondatVégére jel (Fűzés darab tovább) = Fűzés darab (mondatVégére jel tovább)

public export
számozottNévMondat : Fogalom -> Mondat
számozottNévMondat f = mondatVégére PontJel (szavakbólMondat
  (Fűzés (számNév (fogalomSorszám f)) (Fűzés (fogalomSzava f) FüzérVége)))

public export
leírásMondat : Fogalom -> Mondat
leírásMondat f = mondatVégére PontJel (szavakbólMondat
  (füzérFűzés (Fűzés (számNév (fogalomSorszám f)) (Fűzés (fogalomSzava f)
  FüzérVége)) (fogalomLeírása f)))

public export
forrásMondat : Fogalom -> Mondat
forrásMondat f = mondatVégére PontJel (szavakbólMondat (fogalomForrása f))

-- ─── A KIÍRÁSOK ────────────────────────────────────────────────

public export
fogalomKiírása : Fogalom -> IO ()
fogalomKiírása f = do
  határMondatKiírás (számozottNévMondat f)
  határMondatKiírás (leírásMondat f)
  határMondatKiírás (forrásMondat f)
  putStrLn ""

public export
duálisPárKiírása : Pár Fogalom Fogalom -> IO ()
duálisPárKiírása pár = case pár of
  Párosít elsőTag másodikTag =>
    határMondatKiírás (mondatVégére PontJel (szavakbólMondat
      (Fűzés (fogalomSzava elsőTag) (Fűzés duálisSzava
      (Fűzés (fogalomSzava másodikTag) FüzérVége)))))

public export
mindKiírása : IO ()
mindKiírása = füzérBejárás fogalomKiírása fogalomListája

public export
duálisTáblázatKiírása : IO ()
duálisTáblázatKiírása = füzérBejárás duálisPárKiírása duálisPárok

public export
súgóMondat : Mondat
súgóMondat = mondatVégére PontJel (szavakbólMondat (Fűzés parancsokSzó
  (Fűzés egySzava (Fűzés kettőSzava (Fűzés háromSzava (Fűzés négySzava
  (Fűzés ötSzava (Fűzés hatSzava (Fűzés hétSzava (Fűzés nyolcSzava
  (Fűzés kilencSzava (Fűzés tízSzava (Fűzés mindSzava (Fűzés duálisSzava
  (Fűzés súgóSzava (Fűzés kilépésSzava FüzérVége))))))))))))))))

public export
súgóKiírás : IO ()
súgóKiírás = do
  határMondatKiírás súgóMondat
  putStrLn ""

public export
búcsúMondat : Mondat
búcsúMondat = mondatVégére FelkiáltójelJel (szavakbólMondat
  (Fűzés viszlátSzó FüzérVége))

-- ─── A VEZÉRLÉS (interaktív loop — a Hatar-minta) ──────────────

covering
feldolgoz : Füzér Szöveg -> IO ()

covering
fogadás : IO ()
fogadás = do
  szavakTalán <- határSzavakOlvasás
  case szavakTalán of
    Csak szavak => feldolgoz szavak
    Semmi => fogadás

feldolgoz FüzérVége = fogadás
feldolgoz (Fűzés parancs _) =
  case szövegEgyenlő parancs kilépésSzava of
    Igaz => határMondatKiírás búcsúMondat
    Hamis => case szövegEgyenlő parancs mindSzava of
      Igaz => do mindKiírása; fogadás
      Hamis => case szövegEgyenlő parancs duálisSzava of
        Igaz => do duálisTáblázatKiírása; putStrLn ""; fogadás
        Hamis => case szövegEgyenlő parancs súgóSzava of
          Igaz => do súgóKiírás; fogadás
          Hamis => case számNévből parancs of
            Csak f => do fogalomKiírása f; fogadás
            Semmi => do súgóKiírás; fogadás

-- ─── A FŐPROGRAM ───────────────────────────────────────────────

covering
main : IO ()
main = do
  putStrLn "═══ LIMIT-KOLIMIT PILÓTA — a tíz fogalom (000.03) ═══"
  putStrLn ""
  súgóKiírás
  fogadás
