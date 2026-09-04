module ParitasBuborek

import Data.Vect
import Data.List
import E8SteaneLevezetes

%default total

-- =====================================================================
-- PARITÁSBUBORÉK
--
-- A pontos állítás:
--
--   [8,4,4] önduális kód
--       -- egy koordináta elhagyása -->
--   [7,4,3] kód, amelynek duálisa [7,3,4].
--
-- A kilyukasztás után maradó egyetlen mellekosztalyjel a paritás:
--
--   C7 / C7-duális  ≅  kettes test.
--
-- A törölt nyolcadik koordináta pontosan ezt a paritást tárolta.
-- A Calderbank–Shor–Steane-konstrukcióban a két Pauli-összetevő
-- két ilyen jelet ad; a normalizátor és a stabilizátor hányadosa
-- a globális Pauli-fázisok elhagyása után ezért négyelemű,
-- nemelfajuló szimplektikus tér: egy logikai kubit. A teljes
-- Pauli-csoportban a középponttal is hányadosolni kell.
--
-- Ez a modul ezt nevezi paritásbuboréknak. A név új, a tartalma
-- véges kódelméleti állítás, nem fizikai metafora.
-- =====================================================================

-- =====================================================================
-- 1. PARITÁS ÉS A TÖRÖLT KOORDINÁTA
-- =====================================================================

public export
vektorParitasa : Vect hossz BinarisJel -> BinarisJel
vektorParitasa = foldr jelOsszead NullaJel

public export
elsoKoordinata : Vect (S hossz) elemTipus -> elemTipus
elsoKoordinata (elso :: _) = elso

public export
NyolcasHetesKodSzoParok :
  List (Vect 8 BinarisJel, Vect 7 BinarisJel)
NyolcasHetesKodSzoParok =
  zip E8KodSzavak HetesHammingKodSzavak

public export
ToroltKoordinataParitasEllenorzes : Bool
ToroltKoordinataParitasEllenorzes =
  mindenListaElemTeljesiti
    (\(nyolcasKodSzo, hetesKodSzo) =>
      elsoKoordinata nyolcasKodSzo == vektorParitasa hetesKodSzo)
    NyolcasHetesKodSzoParok

BizonyitasToroltKoordinataParitas :
  ToroltKoordinataParitasEllenorzes = True
BizonyitasToroltKoordinataParitas = Refl

public export
ParosHetesHammingKodSzavak : List (Vect 7 BinarisJel)
ParosHetesHammingKodSzavak =
  filter
    (\kodSzo => vektorParitasa kodSzo == NullaJel)
    HetesHammingKodSzavak

public export
ParatlanHetesHammingKodSzavak : List (Vect 7 BinarisJel)
ParatlanHetesHammingKodSzavak =
  filter
    (\kodSzo => vektorParitasa kodSzo == EgyJel)
    HetesHammingKodSzavak

public export
ParitasMagjaMegegyezikADualissal : Bool
ParitasMagjaMegegyezikADualissal =
  listakUgyanaztAHalmaztAdjak
    ParosHetesHammingKodSzavak
    DualisKodSzavak

BizonyitasParitasMagjaMegegyezikADualissal :
  ParitasMagjaMegegyezikADualissal = True
BizonyitasParitasMagjaMegegyezikADualissal = Refl

public export
ParosMellekosztalyMerete : Nat
ParosMellekosztalyMerete = length ParosHetesHammingKodSzavak

public export
ParatlanMellekosztalyMerete : Nat
ParatlanMellekosztalyMerete = length ParatlanHetesHammingKodSzavak

BizonyitasParosMellekosztalyNyolc :
  ParosMellekosztalyMerete = 8
BizonyitasParosMellekosztalyNyolc = Refl

BizonyitasParatlanMellekosztalyNyolc :
  ParatlanMellekosztalyMerete = 8
BizonyitasParatlanMellekosztalyNyolc = Refl

public export
ValasztottParatlanKodSzo : Vect 7 BinarisJel
ValasztottParatlanKodSzo =
  [EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel]

public export
DualisKodEltoltja : List (Vect 7 BinarisJel)
DualisKodEltoltja =
  map (vektorOsszead ValasztottParatlanKodSzo) DualisKodSzavak

public export
ParatlanMellekosztalyValobanEltolt : Bool
ParatlanMellekosztalyValobanEltolt =
  listakUgyanaztAHalmaztAdjak
    ParatlanHetesHammingKodSzavak
    DualisKodEltoltja

BizonyitasParatlanMellekosztalyValobanEltolt :
  ParatlanMellekosztalyValobanEltolt = True
BizonyitasParatlanMellekosztalyValobanEltolt = Refl

public export
ParitasValtozatlanDualisEltolasra : Bool
ParitasValtozatlanDualisEltolasra =
  mindenListaElemTeljesiti
    (\hammingSzo => mindenListaElemTeljesiti
      (\dualisSzo =>
        vektorParitasa (vektorOsszead hammingSzo dualisSzo) ==
        vektorParitasa hammingSzo)
      DualisKodSzavak)
    HetesHammingKodSzavak

BizonyitasParitasValtozatlanDualisEltolasra :
  ParitasValtozatlanDualisEltolasra = True
BizonyitasParitasValtozatlanDualisEltolasra = Refl

-- A hányadostípus két eleme. A paritás a konkrét hányadosleképezés.

public export
data LogikaiMellekosztaly = LogikaiNulla | LogikaiEgy

public export
Eq LogikaiMellekosztaly where
  LogikaiNulla == LogikaiNulla = True
  LogikaiEgy == LogikaiEgy = True
  _ == _ = False

public export
Show LogikaiMellekosztaly where
  show LogikaiNulla = "0"
  show LogikaiEgy = "1"

public export
logikaiMellekosztaly :
  Vect 7 BinarisJel -> LogikaiMellekosztaly
logikaiMellekosztaly kodSzo =
  case vektorParitasa kodSzo of
    NullaJel => LogikaiNulla
    EgyJel => LogikaiEgy

-- =====================================================================
-- 2. PAULI-NORMALIZÁTOR / STABILIZÁTOR = EGY LOGIKAI KUBIT
-- =====================================================================

public export
listaParok : List balTipus -> List jobbTipus -> List (balTipus, jobbTipus)
listaParok [] jobbLista = []
listaParok (balElem :: tobbiBalElem) jobbLista =
  map (\jobbElem => (balElem, jobbElem)) jobbLista ++
  listaParok tobbiBalElem jobbLista

public export
NormalizerPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NormalizerPauliMintak =
  listaParok HetesHammingKodSzavak HetesHammingKodSzavak

public export
StabilizatorPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
StabilizatorPauliMintak =
  listaParok DualisKodSzavak DualisKodSzavak

public export
record LogikaiPauliOsztaly where
  constructor LogikaiPauliOsztalyKonstruktor
  elsoLogikaiJel : BinarisJel
  masodikLogikaiJel : BinarisJel

public export
Eq LogikaiPauliOsztaly where
  bal == jobb =
    bal.elsoLogikaiJel == jobb.elsoLogikaiJel &&
    bal.masodikLogikaiJel == jobb.masodikLogikaiJel

public export
Show LogikaiPauliOsztaly where
  show osztaly =
    "(" ++ show osztaly.elsoLogikaiJel ++
    "," ++ show osztaly.masodikLogikaiJel ++ ")"

public export
pauliLogikaiOsztalya :
  (Vect 7 BinarisJel, Vect 7 BinarisJel) -> LogikaiPauliOsztaly
pauliLogikaiOsztalya (elsoMinta, masodikMinta) =
  LogikaiPauliOsztalyKonstruktor
    (vektorParitasa elsoMinta)
    (vektorParitasa masodikMinta)

public export
LogikaiAzonossag : LogikaiPauliOsztaly
LogikaiAzonossag =
  LogikaiPauliOsztalyKonstruktor NullaJel NullaJel

public export
LogikaiElsoOperator : LogikaiPauliOsztaly
LogikaiElsoOperator =
  LogikaiPauliOsztalyKonstruktor EgyJel NullaJel

public export
LogikaiMasodikOperator : LogikaiPauliOsztaly
LogikaiMasodikOperator =
  LogikaiPauliOsztalyKonstruktor NullaJel EgyJel

public export
LogikaiHarmadikOperator : LogikaiPauliOsztaly
LogikaiHarmadikOperator =
  LogikaiPauliOsztalyKonstruktor EgyJel EgyJel

public export
adottLogikaiPauliOsztalyMerete : LogikaiPauliOsztaly -> Nat
adottLogikaiPauliOsztalyMerete keresettOsztaly =
  length
    (filter
      (\pauliMinta => pauliLogikaiOsztalya pauliMinta == keresettOsztaly)
      NormalizerPauliMintak)

public export
NormalizerPauliMintakSzama : Nat
NormalizerPauliMintakSzama = length NormalizerPauliMintak

public export
StabilizatorPauliMintakSzama : Nat
StabilizatorPauliMintakSzama = length StabilizatorPauliMintak

BizonyitasNormalizerKetszazOtvenhat :
  NormalizerPauliMintakSzama = 256
BizonyitasNormalizerKetszazOtvenhat = Refl

BizonyitasStabilizatorHatvannegy :
  StabilizatorPauliMintakSzama = 64
BizonyitasStabilizatorHatvannegy = Refl

BizonyitasLogikaiAzonossagOsztalyMerete :
  adottLogikaiPauliOsztalyMerete LogikaiAzonossag = 64
BizonyitasLogikaiAzonossagOsztalyMerete = Refl

BizonyitasLogikaiElsoOsztalyMerete :
  adottLogikaiPauliOsztalyMerete LogikaiElsoOperator = 64
BizonyitasLogikaiElsoOsztalyMerete = Refl

BizonyitasLogikaiMasodikOsztalyMerete :
  adottLogikaiPauliOsztalyMerete LogikaiMasodikOperator = 64
BizonyitasLogikaiMasodikOsztalyMerete = Refl

BizonyitasLogikaiHarmadikOsztalyMerete :
  adottLogikaiPauliOsztalyMerete LogikaiHarmadikOperator = 64
BizonyitasLogikaiHarmadikOsztalyMerete = Refl

public export
NormalizerNullaOsztalya :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NormalizerNullaOsztalya =
  filter
    (\pauliMinta => pauliLogikaiOsztalya pauliMinta == LogikaiAzonossag)
    NormalizerPauliMintak

public export
StabilizatorPontosanANullaOsztaly : Bool
StabilizatorPontosanANullaOsztaly =
  listakUgyanaztAHalmaztAdjak
    StabilizatorPauliMintak
    NormalizerNullaOsztalya

BizonyitasStabilizatorPontosanANullaOsztaly :
  StabilizatorPontosanANullaOsztaly = True
BizonyitasStabilizatorPontosanANullaOsztaly = Refl

public export
logikaiSzimplektikusParositas :
  LogikaiPauliOsztaly -> LogikaiPauliOsztaly -> BinarisJel
logikaiSzimplektikusParositas bal jobb =
  jelOsszead
    (jelSzoroz bal.elsoLogikaiJel jobb.masodikLogikaiJel)
    (jelSzoroz bal.masodikLogikaiJel jobb.elsoLogikaiJel)

BizonyitasLogikaiOperatorokNemKommutalnak :
  logikaiSzimplektikusParositas
    LogikaiElsoOperator LogikaiMasodikOperator = EgyJel
BizonyitasLogikaiOperatorokNemKommutalnak = Refl

BizonyitasLogikaiParositasValtakozo :
  logikaiSzimplektikusParositas
    LogikaiHarmadikOperator LogikaiHarmadikOperator = NullaJel
BizonyitasLogikaiParositasValtakozo = Refl

public export
jelVagy : BinarisJel -> BinarisJel -> BinarisJel
jelVagy NullaJel NullaJel = NullaJel
jelVagy _ _ = EgyJel

public export
pauliTartoSulya :
  (Vect 7 BinarisJel, Vect 7 BinarisJel) -> Nat
pauliTartoSulya (elsoMinta, masodikMinta) =
  vektorSulya (zipWith jelVagy elsoMinta masodikMinta)

public export
NemTrivialisNormalizerPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NemTrivialisNormalizerPauliMintak =
  filter
    (\pauliMinta => not (pauliLogikaiOsztalya pauliMinta ==
                         LogikaiAzonossag))
    NormalizerPauliMintak

public export
minimumPauliTartoSuly :
  Nat -> List (Vect 7 BinarisJel, Vect 7 BinarisJel) -> Nat
minimumPauliTartoSuly eddigiMinimum [] = eddigiMinimum
minimumPauliTartoSuly eddigiMinimum (pauliMinta :: tobbi) =
  minimumPauliTartoSuly
    (min eddigiMinimum (pauliTartoSulya pauliMinta))
    tobbi

public export
KozvetlenLogikaiPauliTavolsag : Nat
KozvetlenLogikaiPauliTavolsag =
  minimumPauliTartoSuly 7 NemTrivialisNormalizerPauliMintak

-- A Calderbank–Shor–Steane-távolságot az alapkód C7 / C7-duális
-- legkisebb súlyú nemtriviális mellékosztálya adja. Ezt a megelőző
-- modul már önálló Refl-bizonyítással kiszámította. A 256 Pauli-pár
-- közvetlen bejárása futásidejű, független ellenőrzés marad; ha a
-- Refl típusába tesszük, Idris 2 0.8.0 túl nagy normalizálási fát épít.
public export
LogikaiPauliTavolsag : Nat
LogikaiPauliTavolsag = KvantumKodTavolsaga

BizonyitasLogikaiPauliTavolsagHarom :
  LogikaiPauliTavolsag = 3
BizonyitasLogikaiPauliTavolsagHarom = Refl

-- =====================================================================
-- 3. A 240 E8-GYÖK MINT 15 DARAB, EGYENKÉNT 16 ELEMŰ ROST
--
-- A felbontás Construction A koordinátakerethez kötött:
--
--   16 koordinátagyök
--   14 súlynégyes kódszó × 16 előjel = 224 gyök.
--
-- A koordinátagyökök címkéje a nullakódszó. Így 15 címke van:
-- nullakódszó + 14 súlynégyes kódszó. Mindegyikhez 16 gyök tartozik.
-- A csupa-egy kódszóval való eltolás ezt a címkehalmazt az E8-kód
-- 15 nemnulla szavára képezi.
--
-- Ezek redukciós rostok, nem ortogonális gyökkeretek. Az E8 ismert,
-- 15 ortogonális keretes felbontása más ekvivalenciarelációt használ.
-- =====================================================================

public export
HaromBitesTengelyCimkek : List (Vect 3 BinarisJel)
HaromBitesTengelyCimkek = osszesBinarisVektor 3

public export
KetElojel : List BinarisJel
KetElojel = [NullaJel, EgyJel]

public export
NegyBitesElojelMintak : List (Vect 4 BinarisJel)
NegyBitesElojelMintak = osszesBinarisVektor 4

public export
NegySulyuE8KodSzavak : List (Vect 8 BinarisJel)
NegySulyuE8KodSzavak =
  filter (\kodSzo => vektorSulya kodSzo == 4) E8KodSzavak

public export
E8NullaKodSzo : Vect 8 BinarisJel
E8NullaKodSzo =
  e8KodSzo NullaJel NullaJel NullaJel NullaJel

public export
E8CsupaEgyKodSzo : Vect 8 BinarisJel
E8CsupaEgyKodSzo =
  e8KodSzo EgyJel NullaJel NullaJel NullaJel

public export
data ConstructionAGyok
  = KoordinataGyokKonstruktor (Vect 3 BinarisJel) BinarisJel
  | KodSzoGyokKonstruktor (Vect 8 BinarisJel) (Vect 4 BinarisJel)

public export
Eq ConstructionAGyok where
  KoordinataGyokKonstruktor balTengely balElojel ==
    KoordinataGyokKonstruktor jobbTengely jobbElojel =
      balTengely == jobbTengely && balElojel == jobbElojel
  KodSzoGyokKonstruktor balKodSzo balElojel ==
    KodSzoGyokKonstruktor jobbKodSzo jobbElojel =
      balKodSzo == jobbKodSzo && balElojel == jobbElojel
  _ == _ = False

public export
KoordinataGyokok : List ConstructionAGyok
KoordinataGyokok =
  map
    (\(tengely, elojel) => KoordinataGyokKonstruktor tengely elojel)
    (listaParok HaromBitesTengelyCimkek KetElojel)

public export
KodSzoGyokok : List ConstructionAGyok
KodSzoGyokok =
  map
    (\(kodSzo, elojelMinta) =>
      KodSzoGyokKonstruktor kodSzo elojelMinta)
    (listaParok NegySulyuE8KodSzavak NegyBitesElojelMintak)

public export
ConstructionAE8Gyokok : List ConstructionAGyok
ConstructionAE8Gyokok = KoordinataGyokok ++ KodSzoGyokok

public export
gyokKodCimkeje : ConstructionAGyok -> Vect 8 BinarisJel
gyokKodCimkeje (KoordinataGyokKonstruktor _ _) = E8NullaKodSzo
gyokKodCimkeje (KodSzoGyokKonstruktor kodSzo _) = kodSzo

public export
GyokRostCimkek : List (Vect 8 BinarisJel)
GyokRostCimkek = E8NullaKodSzo :: NegySulyuE8KodSzavak

public export
adottRostGyokeinekSzama : Vect 8 BinarisJel -> Nat
adottRostGyokeinekSzama cimke =
  length
    (filter
      (\gyok => gyokKodCimkeje gyok == cimke)
      ConstructionAE8Gyokok)

public export
MindenGyokRostMereteTizenhat : Bool
MindenGyokRostMereteTizenhat =
  mindenListaElemTeljesiti
    (\cimke => adottRostGyokeinekSzama cimke == 16)
    GyokRostCimkek

public export
ConstructionAE8GyokokSzama : Nat
ConstructionAE8GyokokSzama = length ConstructionAE8Gyokok

public export
GyokRostCimkekSzama : Nat
GyokRostCimkekSzama = length GyokRostCimkek

BizonyitasConstructionAE8GyokokSzama :
  ConstructionAE8GyokokSzama = 240
BizonyitasConstructionAE8GyokokSzama = Refl

BizonyitasGyokRostCimkekSzama :
  GyokRostCimkekSzama = 15
BizonyitasGyokRostCimkekSzama = Refl

BizonyitasMindenGyokRostMereteTizenhat :
  MindenGyokRostMereteTizenhat = True
BizonyitasMindenGyokRostMereteTizenhat = Refl

public export
NemNullaE8KodSzavak : List (Vect 8 BinarisJel)
NemNullaE8KodSzavak =
  filter (\kodSzo => vektorSulya kodSzo /= 0) E8KodSzavak

public export
EltoltGyokRostCimkek : List (Vect 8 BinarisJel)
EltoltGyokRostCimkek =
  map (vektorOsszead E8CsupaEgyKodSzo) GyokRostCimkek

public export
EltoltCimkekPontosanANemNullaKodSzavak : Bool
EltoltCimkekPontosanANemNullaKodSzavak =
  listakUgyanaztAHalmaztAdjak
    EltoltGyokRostCimkek
    NemNullaE8KodSzavak

BizonyitasEltoltCimkekPontosanANemNullaKodSzavak :
  EltoltCimkekPontosanANemNullaKodSzavak = True
BizonyitasEltoltCimkekPontosanANemNullaKodSzavak = Refl

public export
NegyBitesNemNullaPontok : List (Vect 4 BinarisJel)
NegyBitesNemNullaPontok =
  filter (\pont => vektorSulya pont /= 0) (osszesBinarisVektor 4)

public export
e8KodSzoEgyutthatokbol : Vect 4 BinarisJel -> Vect 8 BinarisJel
e8KodSzoEgyutthatokbol [allando, elso, masodik, harmadik] =
  e8KodSzo allando elso masodik harmadik

public export
NemNullaEgyutthatokKodSzavai : List (Vect 8 BinarisJel)
NemNullaEgyutthatokKodSzavai =
  map e8KodSzoEgyutthatokbol NegyBitesNemNullaPontok

public export
TizenotPontCimkeziAGyokRostokat : Bool
TizenotPontCimkeziAGyokRostokat =
  listakUgyanaztAHalmaztAdjak
    NemNullaEgyutthatokKodSzavai
    EltoltGyokRostCimkek

BizonyitasNegyBitesNemNullaPontokSzama :
  length NegyBitesNemNullaPontok = 15
BizonyitasNegyBitesNemNullaPontokSzama = Refl

BizonyitasTizenotPontCimkeziAGyokRostokat :
  TizenotPontCimkeziAGyokRostokat = True
BizonyitasTizenotPontCimkeziAGyokRostokat = Refl

-- =====================================================================
-- 4. FUTTATHATÓ JELENTÉS
-- =====================================================================

public export
paritasBuborekJelentes : IO ()
paritasBuborekJelentes = do
  putStrLn "Paritásbuborék:"
  putStrLn ("  törölt koordináta = maradék paritása: " ++
            show ToroltKoordinataParitasEllenorzes)
  putStrLn ("  paritás magja = [7,3,4] duális kód: " ++
            show ParitasMagjaMegegyezikADualissal)
  putStrLn ("  két mellékosztály mérete: " ++
            show ParosMellekosztalyMerete ++ " és " ++
            show ParatlanMellekosztalyMerete)
  putStrLn ("  normalizátor / stabilizátor mérete: " ++
            show NormalizerPauliMintakSzama ++ " / " ++
            show StabilizatorPauliMintakSzama ++ " = 4")
  putStrLn ("  logikai szimplektikus pár: " ++
            show (logikaiSzimplektikusParositas
                    LogikaiElsoOperator LogikaiMasodikOperator))
  putStrLn ("  mellékosztályból bizonyított Pauli-távolság: " ++
            show LogikaiPauliTavolsag)
  putStrLn ("  256 Pauli-pár közvetlen ellenőrzése: " ++
            show KozvetlenLogikaiPauliTavolsag)
  putStrLn "E8-gyökrostok:"
  putStrLn ("  gyökök: " ++ show ConstructionAE8GyokokSzama)
  putStrLn ("  rostok: " ++ show GyokRostCimkekSzama)
  putStrLn ("  minden rost mérete 16: " ++
            show MindenGyokRostMereteTizenhat)
  putStrLn ("  a 15 nemnulla négydimenziós bináris pont címkéz: " ++
            show TizenotPontCimkeziAGyokRostokat)
  putStrLn "Megjegyzés: a 15×16 felbontás Construction A keretfüggő."
