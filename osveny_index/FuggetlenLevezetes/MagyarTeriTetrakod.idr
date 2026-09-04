module MagyarTeriTetrakod

import Data.List
import Data.Vect
import E8SteaneLevezetes

%default total

-- =====================================================================
-- MAGYAR TÉRBELI ESETEK, TERNÁRIS TETRAKÓD ÉS HATSZÖGŰ GYÖKÖK
--
-- A pontos, véges állítás:
--
--   három tértartomány × három irányállapot
--     = kilenc magyar térbeli eset
--     = két információtrit.
--
-- A ternáris [4,2,3] tetrakód a két információtritet négy kódtritre
-- képezi. A kód tökéletes: minden egytrit-hibát kijavít.
--
-- A hat irányított eset három ellentétes párként egy választott
-- hatszögű A₂-gyökrendszer hat gyökéhez rendelhető. Ez a hozzárendelés
-- megőrzi a forrás--cél ellentétet, de nem állítja, hogy a magyar
-- nyelvtanból következik a teljes gyökalgebra.
--
-- A tetrakód ugyanaz a kilenc ragasztási osztályt szervező kód, amely
-- négy A₂-rácsból E8-at ad. A modul a 24 + 8·27 = 240 gyökszámot
-- ellenőrzi; az általános rácsizomorfia irodalmi tétel.
-- =====================================================================

-- =====================================================================
-- 1. A HÁROM ELEMŰ TEST
-- =====================================================================

public export
data Trit = TritNulla | TritEgy | TritKetto

public export
Eq Trit where
  TritNulla == TritNulla = True
  TritEgy == TritEgy = True
  TritKetto == TritKetto = True
  _ == _ = False

public export
Show Trit where
  show TritNulla = "0"
  show TritEgy = "1"
  show TritKetto = "2"

public export
tritOsszead : Trit -> Trit -> Trit
tritOsszead TritNulla jobb = jobb
tritOsszead bal TritNulla = bal
tritOsszead TritEgy TritEgy = TritKetto
tritOsszead TritEgy TritKetto = TritNulla
tritOsszead TritKetto TritEgy = TritNulla
tritOsszead TritKetto TritKetto = TritEgy

public export
tritEllentettje : Trit -> Trit
tritEllentettje TritNulla = TritNulla
tritEllentettje TritEgy = TritKetto
tritEllentettje TritKetto = TritEgy

public export
tritKivon : Trit -> Trit -> Trit
tritKivon bal jobb = tritOsszead bal (tritEllentettje jobb)

public export
tritSzoroz : Trit -> Trit -> Trit
tritSzoroz TritNulla _ = TritNulla
tritSzoroz _ TritNulla = TritNulla
tritSzoroz TritEgy jobb = jobb
tritSzoroz bal TritEgy = bal
tritSzoroz TritKetto TritKetto = TritEgy

public export
TritErtekek : List Trit
TritErtekek = [TritNulla, TritEgy, TritKetto]

public export
listaParok : List balTipus -> List jobbTipus -> List (balTipus, jobbTipus)
listaParok [] _ = []
listaParok (balElem :: tobbiBalElem) jobbLista =
  map (\jobbElem => (balElem, jobbElem)) jobbLista ++
  listaParok tobbiBalElem jobbLista

-- =====================================================================
-- 2. A TERNÁRIS [4,2,3] TETRAKÓD
--
-- Generátorsorok:
--
--   (1, 1,  1, 0)
--   (0, 1, -1, 1)
--
-- Ezért (a,b) kódolása:
--
--   (a, a+b, a-b, b).
-- =====================================================================

public export
TetrakodInformacioParok : List (Trit, Trit)
TetrakodInformacioParok = listaParok TritErtekek TritErtekek

public export
tetrakodKodol : (Trit, Trit) -> Vect 4 Trit
tetrakodKodol (elsoInformacio, masodikInformacio) =
  [ elsoInformacio
  , tritOsszead elsoInformacio masodikInformacio
  , tritKivon elsoInformacio masodikInformacio
  , masodikInformacio
  ]

public export
TetrakodSzavak : List (Vect 4 Trit)
TetrakodSzavak = map tetrakodKodol TetrakodInformacioParok

public export
tritNemNullaJelzo : Trit -> Nat
tritNemNullaJelzo TritNulla = 0
tritNemNullaJelzo _ = 1

public export
tetrakodSuly : Vect 4 Trit -> Nat
tetrakodSuly =
  foldr (\trit, osszeg => tritNemNullaJelzo trit + osszeg) 0

public export
tetrakodTavolsag : Vect 4 Trit -> Vect 4 Trit -> Nat
tetrakodTavolsag bal jobb =
  foldr
    (\(balTrit, jobbTrit), osszeg =>
      (if balTrit == jobbTrit then 0 else 1) + osszeg)
    0
    (zip bal jobb)

public export
tetrakodSkalarisSzorzat : Vect 4 Trit -> Vect 4 Trit -> Trit
tetrakodSkalarisSzorzat bal jobb =
  foldr tritOsszead TritNulla (zipWith tritSzoroz bal jobb)

public export
KulonbozoTetrakodSzoParok :
  List (Vect 4 Trit, Vect 4 Trit)
KulonbozoTetrakodSzoParok =
  filter
    (\(bal, jobb) => not (bal == jobb))
    (listaParok TetrakodSzavak TetrakodSzavak)

public export
minimumTetrakodTavolsag :
  Nat -> List (Vect 4 Trit, Vect 4 Trit) -> Nat
minimumTetrakodTavolsag eddigiMinimum [] = eddigiMinimum
minimumTetrakodTavolsag eddigiMinimum ((bal, jobb) :: tobbiPar) =
  minimumTetrakodTavolsag
    (min eddigiMinimum (tetrakodTavolsag bal jobb))
    tobbiPar

public export
TetrakodMinimumTavolsaga : Nat
TetrakodMinimumTavolsaga =
  minimumTetrakodTavolsag 4 KulonbozoTetrakodSzoParok

public export
TetrakodSzavakSzama : Nat
TetrakodSzavakSzama = length TetrakodSzavak

public export
TetrakodSzavakKulonboznek : Bool
TetrakodSzavakKulonboznek =
  listaIsmetlodesNelkul TetrakodSzavak

public export
TetrakodOnortogonalis : Bool
TetrakodOnortogonalis =
  mindenListaElemTeljesiti
    (\bal => mindenListaElemTeljesiti
      (\jobb =>
        tetrakodSkalarisSzorzat bal jobb == TritNulla)
      TetrakodSzavak)
    TetrakodSzavak

public export
TetrakodNemNullaSzavak : List (Vect 4 Trit)
TetrakodNemNullaSzavak =
  filter (\kodSzo => tetrakodSuly kodSzo /= 0) TetrakodSzavak

public export
TetrakodMindenNemNullaSzavaHaromSulyu : Bool
TetrakodMindenNemNullaSzavaHaromSulyu =
  mindenListaElemTeljesiti
    (\kodSzo => tetrakodSuly kodSzo == 3)
    TetrakodNemNullaSzavak

BizonyitasTetrakodKilencSzavas :
  TetrakodSzavakSzama = 9
BizonyitasTetrakodKilencSzavas = Refl

BizonyitasTetrakodSzavakKulonboznek :
  TetrakodSzavakKulonboznek = True
BizonyitasTetrakodSzavakKulonboznek = Refl

BizonyitasTetrakodMinimumTavolsagaHarom :
  TetrakodMinimumTavolsaga = 3
BizonyitasTetrakodMinimumTavolsagaHarom = Refl

BizonyitasTetrakodOnortogonalis :
  TetrakodOnortogonalis = True
BizonyitasTetrakodOnortogonalis = Refl

BizonyitasTetrakodNemNullaSzavaiHaromSulyuak :
  TetrakodMindenNemNullaSzavaHaromSulyu = True
BizonyitasTetrakodNemNullaSzavaiHaromSulyuak = Refl

-- =====================================================================
-- 3. MINDEN EGYTRIT-HIBA JAVÍTÁSA
-- =====================================================================

public export
record EgyTritHiba where
  constructor EgyTritHibaKonstruktor
  hibaHelye : Nat
  hibaErteke : Trit

public export
EgyTritHibak : List EgyTritHiba
EgyTritHibak =
  map
    (\(hely, ertek) => EgyTritHibaKonstruktor hely ertek)
    (listaParok [0, 1, 2, 3] [TritEgy, TritKetto])

public export
egyTritHibatAd : EgyTritHiba -> Vect 4 Trit -> Vect 4 Trit
egyTritHibatAd hiba [elso, masodik, harmadik, negyedik] =
  case hiba.hibaHelye of
    0 => [tritOsszead elso hiba.hibaErteke,
          masodik, harmadik, negyedik]
    1 => [elso, tritOsszead masodik hiba.hibaErteke,
          harmadik, negyedik]
    2 => [elso, masodik,
          tritOsszead harmadik hiba.hibaErteke, negyedik]
    3 => [elso, masodik, harmadik,
          tritOsszead negyedik hiba.hibaErteke]
    _ => [elso, masodik, harmadik, negyedik]

public export
legkozelebbiTetrakodSzoKereses :
  Vect 4 Trit ->
  Vect 4 Trit ->
  List (Vect 4 Trit) ->
  Vect 4 Trit
legkozelebbiTetrakodSzoKereses vett eddigiLegjobb [] =
  eddigiLegjobb
legkozelebbiTetrakodSzoKereses
  vett eddigiLegjobb (jelolt :: tobbiJelolt) =
    if tetrakodTavolsag vett jelolt <
       tetrakodTavolsag vett eddigiLegjobb
      then legkozelebbiTetrakodSzoKereses vett jelolt tobbiJelolt
      else legkozelebbiTetrakodSzoKereses
             vett eddigiLegjobb tobbiJelolt

public export
tetrakodDekodol : Vect 4 Trit -> Vect 4 Trit
tetrakodDekodol vett =
  case TetrakodSzavak of
    [] => [TritNulla, TritNulla, TritNulla, TritNulla]
    elsoKodSzo :: tobbiKodSzo =>
      legkozelebbiTetrakodSzoKereses vett elsoKodSzo tobbiKodSzo

public export
MindenEgyTritHibaJavithato : Bool
MindenEgyTritHibaJavithato =
  mindenListaElemTeljesiti
    (\kodSzo => mindenListaElemTeljesiti
      (\hiba =>
        tetrakodDekodol (egyTritHibatAd hiba kodSzo) == kodSzo)
      EgyTritHibak)
    TetrakodSzavak

public export
TernarisNegydimenziosTerMerete : Nat
TernarisNegydimenziosTerMerete = 3 * 3 * 3 * 3

public export
NemNullaHibaErtekekSzama : Nat
NemNullaHibaErtekekSzama =
  length (the (List Trit) [TritEgy, TritKetto])

public export
EgySugaruHammingGombMerete : Nat
EgySugaruHammingGombMerete =
  1 + 4 * NemNullaHibaErtekekSzama

public export
TetrakodHammingGombokLefedikATeret : Nat
TetrakodHammingGombokLefedikATeret =
  TetrakodSzavakSzama * EgySugaruHammingGombMerete

BizonyitasMindenEgyTritHibaJavithato :
  MindenEgyTritHibaJavithato = True
BizonyitasMindenEgyTritHibaJavithato = Refl

BizonyitasTetrakodTokeletes :
  TetrakodHammingGombokLefedikATeret =
  TernarisNegydimenziosTerMerete
BizonyitasTetrakodTokeletes = Refl

-- =====================================================================
-- 4. A KILENC MAGYAR TÉRBELI ESET
-- =====================================================================

public export
data TerTartomany = BelsoTer | Felszin | Kozelseg

public export
Eq TerTartomany where
  BelsoTer == BelsoTer = True
  Felszin == Felszin = True
  Kozelseg == Kozelseg = True
  _ == _ = False

public export
Show TerTartomany where
  show BelsoTer = "belső tér"
  show Felszin = "felszín"
  show Kozelseg = "közelség"

public export
data TerIrany = Forras | Hely | Cel

public export
Eq TerIrany where
  Forras == Forras = True
  Hely == Hely = True
  Cel == Cel = True
  _ == _ = False

public export
Show TerIrany where
  show Forras = "forrás"
  show Hely = "hely"
  show Cel = "cél"

public export
record MagyarTeriEset where
  constructor MagyarTeriEsetKonstruktor
  tartomany : TerTartomany
  irany : TerIrany

public export
Eq MagyarTeriEset where
  bal == jobb =
    bal.tartomany == jobb.tartomany &&
    bal.irany == jobb.irany

public export
Show MagyarTeriEset where
  show teriEset =
    show teriEset.tartomany ++ " × " ++ show teriEset.irany

public export
TerTartomanyok : List TerTartomany
TerTartomanyok = [BelsoTer, Felszin, Kozelseg]

public export
TerIranyok : List TerIrany
TerIranyok = [Forras, Hely, Cel]

public export
MagyarTeriEsetek : List MagyarTeriEset
MagyarTeriEsetek =
  map
    (\(tartomany, irany) =>
      MagyarTeriEsetKonstruktor tartomany irany)
    (listaParok TerTartomanyok TerIranyok)

public export
terTartomanyTritje : TerTartomany -> Trit
terTartomanyTritje BelsoTer = TritNulla
terTartomanyTritje Felszin = TritEgy
terTartomanyTritje Kozelseg = TritKetto

public export
terIranyTritje : TerIrany -> Trit
terIranyTritje Forras = TritNulla
terIranyTritje Hely = TritEgy
terIranyTritje Cel = TritKetto

public export
teriEsetInformacioja : MagyarTeriEset -> (Trit, Trit)
teriEsetInformacioja teriEset =
  ( terTartomanyTritje teriEset.tartomany
  , terIranyTritje teriEset.irany
  )

public export
teriEsetTetrakodSzava : MagyarTeriEset -> Vect 4 Trit
teriEsetTetrakodSzava =
  tetrakodKodol . teriEsetInformacioja

public export
MagyarTeriEsetekKodSzavai : List (Vect 4 Trit)
MagyarTeriEsetekKodSzavai =
  map teriEsetTetrakodSzava MagyarTeriEsetek

public export
MagyarTeriEsetKodolasBijektiv : Bool
MagyarTeriEsetKodolasBijektiv =
  listaIsmetlodesNelkul MagyarTeriEsetekKodSzavai &&
  listakUgyanaztAHalmaztAdjak
    MagyarTeriEsetekKodSzavai TetrakodSzavak

BizonyitasKilencMagyarTeriEset :
  length MagyarTeriEsetek = 9
BizonyitasKilencMagyarTeriEset = Refl

BizonyitasMagyarTeriEsetKodolasBijektiv :
  MagyarTeriEsetKodolasBijektiv = True
BizonyitasMagyarTeriEsetKodolasBijektiv = Refl

-- grafikusan: „-ból/-ből”
public export
BelsoForrasEset : MagyarTeriEset
BelsoForrasEset = MagyarTeriEsetKonstruktor BelsoTer Forras

-- grafikusan: „-ban/-ben”
public export
BelsoHelyEset : MagyarTeriEset
BelsoHelyEset = MagyarTeriEsetKonstruktor BelsoTer Hely

-- grafikusan: „-ba/-be”
public export
BelsoCelEset : MagyarTeriEset
BelsoCelEset = MagyarTeriEsetKonstruktor BelsoTer Cel

-- grafikusan: „-ról/-ről”
public export
FelszinForrasEset : MagyarTeriEset
FelszinForrasEset = MagyarTeriEsetKonstruktor Felszin Forras

-- grafikusan: „-on/-en/-ön/-n”
public export
FelszinHelyEset : MagyarTeriEset
FelszinHelyEset = MagyarTeriEsetKonstruktor Felszin Hely

-- grafikusan: „-ra/-re”
public export
FelszinCelEset : MagyarTeriEset
FelszinCelEset = MagyarTeriEsetKonstruktor Felszin Cel

-- grafikusan: „-tól/-től”
public export
KozelsegForrasEset : MagyarTeriEset
KozelsegForrasEset = MagyarTeriEsetKonstruktor Kozelseg Forras

-- grafikusan: „-nál/-nél”
public export
KozelsegHelyEset : MagyarTeriEset
KozelsegHelyEset = MagyarTeriEsetKonstruktor Kozelseg Hely

-- grafikusan: „-hoz/-hez/-höz”
public export
KozelsegCelEset : MagyarTeriEset
KozelsegCelEset = MagyarTeriEsetKonstruktor Kozelseg Cel

-- =====================================================================
-- 5. A HAT IRÁNYÍTOTT ESET MINT HATSZÖGŰ GYÖKIRÁNY
--
-- Egyszerűgyök-koordinátákban a Gram-mátrix:
--
--   [ 2 -1 ]
--   [-1  2 ].
--
-- Ezért (x,y) normanégyzete 2·(x² - xy + y²).
-- =====================================================================

public export
record HatszoguGyok where
  constructor HatszoguGyokKonstruktor
  elsoKoordinata : Integer
  masodikKoordinata : Integer

public export
Eq HatszoguGyok where
  bal == jobb =
    bal.elsoKoordinata == jobb.elsoKoordinata &&
    bal.masodikKoordinata == jobb.masodikKoordinata

public export
Show HatszoguGyok where
  show gyok =
    "(" ++ show gyok.elsoKoordinata ++
    "," ++ show gyok.masodikKoordinata ++ ")"

public export
hatszoguGyokNormaNegyzete : HatszoguGyok -> Integer
hatszoguGyokNormaNegyzete gyok =
  2 *
  ( gyok.elsoKoordinata * gyok.elsoKoordinata
  - gyok.elsoKoordinata * gyok.masodikKoordinata
  + gyok.masodikKoordinata * gyok.masodikKoordinata
  )

public export
data IranyitottTeriEset
  = BelsoForrasIrany
  | BelsoCelIrany
  | FelszinForrasIrany
  | FelszinCelIrany
  | KozelsegForrasIrany
  | KozelsegCelIrany

public export
Eq IranyitottTeriEset where
  BelsoForrasIrany == BelsoForrasIrany = True
  BelsoCelIrany == BelsoCelIrany = True
  FelszinForrasIrany == FelszinForrasIrany = True
  FelszinCelIrany == FelszinCelIrany = True
  KozelsegForrasIrany == KozelsegForrasIrany = True
  KozelsegCelIrany == KozelsegCelIrany = True
  _ == _ = False

public export
IranyitottTeriEsetek : List IranyitottTeriEset
IranyitottTeriEsetek =
  [ BelsoForrasIrany
  , BelsoCelIrany
  , FelszinForrasIrany
  , FelszinCelIrany
  , KozelsegForrasIrany
  , KozelsegCelIrany
  ]

public export
iranyitottTeriEsetGyoke : IranyitottTeriEset -> HatszoguGyok
iranyitottTeriEsetGyoke BelsoForrasIrany =
  HatszoguGyokKonstruktor (-1) 0
iranyitottTeriEsetGyoke BelsoCelIrany =
  HatszoguGyokKonstruktor 1 0
iranyitottTeriEsetGyoke FelszinForrasIrany =
  HatszoguGyokKonstruktor 0 (-1)
iranyitottTeriEsetGyoke FelszinCelIrany =
  HatszoguGyokKonstruktor 0 1
iranyitottTeriEsetGyoke KozelsegForrasIrany =
  HatszoguGyokKonstruktor (-1) (-1)
iranyitottTeriEsetGyoke KozelsegCelIrany =
  HatszoguGyokKonstruktor 1 1

public export
IranyitottTeriEsetGyokok : List HatszoguGyok
IranyitottTeriEsetGyokok =
  map iranyitottTeriEsetGyoke IranyitottTeriEsetek

public export
MindenIranyitottTeriEsetGyokeKettesNormaju : Bool
MindenIranyitottTeriEsetGyokeKettesNormaju =
  mindenListaElemTeljesiti
    (\gyok => hatszoguGyokNormaNegyzete gyok == 2)
    IranyitottTeriEsetGyokok

BizonyitasHatIranyitottTeriEset :
  length IranyitottTeriEsetek = 6
BizonyitasHatIranyitottTeriEset = Refl

BizonyitasIranyitottTeriEsetGyokokKulonboznek :
  listaIsmetlodesNelkul IranyitottTeriEsetGyokok = True
BizonyitasIranyitottTeriEsetGyokokKulonboznek = Refl

BizonyitasMindenIranyitottTeriEsetGyokeKettesNormaju :
  MindenIranyitottTeriEsetGyokeKettesNormaju = True
BizonyitasMindenIranyitottTeriEsetGyokeKettesNormaju = Refl

-- =====================================================================
-- 6. A TETRAKÓDOS E8-RAGASZTÁS VÉGES SZÁMOLÁSA
-- =====================================================================

public export
AlapracsGyokeinekSzama : Nat
AlapracsGyokeinekSzama = 4 * 6

public export
NemNullaRagasztasiOsztalyokSzama : Nat
NemNullaRagasztasiOsztalyokSzama = length TetrakodNemNullaSzavak

public export
EgyRagasztasiOsztalyGyokeinekSzama : Nat
EgyRagasztasiOsztalyGyokeinekSzama = 3 * 3 * 3

public export
RagasztottGyokokSzama : Nat
RagasztottGyokokSzama =
  NemNullaRagasztasiOsztalyokSzama *
  EgyRagasztasiOsztalyGyokeinekSzama

public export
TetrakodosE8GyokokSzama : Nat
TetrakodosE8GyokokSzama =
  AlapracsGyokeinekSzama + RagasztottGyokokSzama

public export
NegyHatszoguRacsGramDeterminansa : Nat
NegyHatszoguRacsGramDeterminansa = 3 * 3 * 3 * 3

public export
RagasztasiIndex : Nat
RagasztasiIndex = TetrakodSzavakSzama

BizonyitasAlapracsHuszonnegyGyoku :
  AlapracsGyokeinekSzama = 24
BizonyitasAlapracsHuszonnegyGyoku = Refl

BizonyitasNyolcNemNullaRagasztasiOsztaly :
  NemNullaRagasztasiOsztalyokSzama = 8
BizonyitasNyolcNemNullaRagasztasiOsztaly = Refl

BizonyitasRagasztottGyokokKetszazTizenhat :
  RagasztottGyokokSzama = 216
BizonyitasRagasztottGyokokKetszazTizenhat = Refl

BizonyitasTetrakodosE8GyokokKetszazNegyven :
  TetrakodosE8GyokokSzama = 240
BizonyitasTetrakodosE8GyokokKetszazNegyven = Refl

BizonyitasRagasztasiIndexKilenc :
  RagasztasiIndex = 9
BizonyitasRagasztasiIndexKilenc = Refl

BizonyitasUnimodularisDeterminansSzamolas :
  NegyHatszoguRacsGramDeterminansa =
  RagasztasiIndex * RagasztasiIndex
BizonyitasUnimodularisDeterminansSzamolas = Refl

BizonyitasKetE8GyokszamReceptEgyenlo :
  TetrakodosE8GyokokSzama = E8MinimalisVektorokSzama
BizonyitasKetE8GyokszamReceptEgyenlo =
  trans
    BizonyitasTetrakodosE8GyokokKetszazNegyven
    (sym BizonyitasE8MinimalisVektorokSzama)

-- =====================================================================
-- 7. FUTTATHATÓ JELENTÉS
-- =====================================================================

public export
magyarTeriTetrakodJelentes : IO ()
magyarTeriTetrakodJelentes = do
  putStrLn "Magyar térbeli esetek ternáris tetrakódja:"
  putStrLn ("  térbeli esetek száma: " ++
            show (length MagyarTeriEsetek))
  putStrLn ("  kódolás bijektív a kilenc tetrakódszóra: " ++
            show MagyarTeriEsetKodolasBijektiv)
  putStrLn ("  tetrakód paraméterei: [4,2," ++
            show TetrakodMinimumTavolsaga ++ "] a három elemű test felett")
  putStrLn ("  minden egytrit-hiba javítható: " ++
            show MindenEgyTritHibaJavithato)
  putStrLn ("  hat irányított eset gyökei: " ++
            show IranyitottTeriEsetGyokok)
  putStrLn ("  mind a hat gyök normanégyzete kettő: " ++
            show MindenIranyitottTeriEsetGyokeKettesNormaju)
  putStrLn ("  E8-gyökszám: " ++
            show AlapracsGyokeinekSzama ++ " + " ++
            show RagasztottGyokokSzama ++ " = " ++
            show TetrakodosE8GyokokSzama)
  putStrLn "Határ: a kódolás pontos; a nyelvmodellbeli tömörítési előny mérendő."
