module E8SteaneLevezetes

import Data.Vect
import Data.List

%default total

-- =====================================================================
-- FÜGGETLEN E8–STEANE LEVEZETÉS
--
-- Ez a modul nem importálja a projekt meglévő algebrai moduljait.
-- Véges felsorolással ellenőrzi a valódi matematikai láncot:
--
--   kiterjesztett Hamming-kód [8,4,4]
--     → egy koordináta elhagyása
--   Hamming-kód [7,4,3]
--     → Calderbank–Shor–Steane-konstrukció
--   kvantumkód [[7,1,3]]
--
-- Ezután külön választja:
--   1. a véges kódolási tételeket,
--   2. a definíció szerinti számtani azonosságokat,
--   3. a még le nem vezetett fizikai feltevéseket.
-- =====================================================================

-- =====================================================================
-- 1. BINÁRIS VEKTORTÉR
-- =====================================================================

public export
data BinarisJel = NullaJel | EgyJel

public export
Eq BinarisJel where
  NullaJel == NullaJel = True
  EgyJel == EgyJel = True
  _ == _ = False

public export
Show BinarisJel where
  show NullaJel = "0"
  show EgyJel = "1"

public export
jelOsszead : BinarisJel -> BinarisJel -> BinarisJel
jelOsszead NullaJel jel = jel
jelOsszead jel NullaJel = jel
jelOsszead EgyJel EgyJel = NullaJel

public export
jelSzoroz : BinarisJel -> BinarisJel -> BinarisJel
jelSzoroz EgyJel EgyJel = EgyJel
jelSzoroz _ _ = NullaJel

public export
jelTermeszetesSzam : BinarisJel -> Nat
jelTermeszetesSzam NullaJel = 0
jelTermeszetesSzam EgyJel = 1

public export
vektorOsszead : Vect hossz BinarisJel -> Vect hossz BinarisJel
              -> Vect hossz BinarisJel
vektorOsszead = zipWith jelOsszead

public export
jelSzorozVektort : BinarisJel -> Vect hossz BinarisJel
                 -> Vect hossz BinarisJel
jelSzorozVektort NullaJel vektor = map (\_ => NullaJel) vektor
jelSzorozVektort EgyJel vektor = vektor

public export
vektorSulya : Vect hossz BinarisJel -> Nat
vektorSulya = foldr (\jel, osszeg => jelTermeszetesSzam jel + osszeg) 0

public export
vektorSkalarisParitasa : Vect hossz BinarisJel
                      -> Vect hossz BinarisJel
                      -> BinarisJel
vektorSkalarisParitasa bal jobb =
  foldr jelOsszead NullaJel (zipWith jelSzoroz bal jobb)

public export
listaTartalmaz : {elemTipus : Type} ->
                 Eq elemTipus => elemTipus -> List elemTipus -> Bool
listaTartalmaz keresett [] = False
listaTartalmaz keresett (elso :: tobbi) =
  if keresett == elso then True else listaTartalmaz keresett tobbi

public export
listaIsmetlodesNelkul : {elemTipus : Type} ->
  Eq elemTipus => List elemTipus -> Bool
listaIsmetlodesNelkul [] = True
listaIsmetlodesNelkul (elso :: tobbi) =
  not (listaTartalmaz elso tobbi) && listaIsmetlodesNelkul tobbi

public export
mindenListaElemTeljesiti : {elemTipus : Type} ->
  (elemTipus -> Bool) -> List elemTipus -> Bool
mindenListaElemTeljesiti tulajdonsag [] = True
mindenListaElemTeljesiti tulajdonsag (elso :: tobbi) =
  tulajdonsag elso && mindenListaElemTeljesiti tulajdonsag tobbi

public export
mindenKodSzoParonkentOrtogonalis :
  {hossz : Nat} -> List (Vect hossz BinarisJel) -> Bool
mindenKodSzoParonkentOrtogonalis kodSzavak =
  mindenListaElemTeljesiti
    (\bal => mindenListaElemTeljesiti
      (\jobb => vektorSkalarisParitasa bal jobb == NullaJel)
      kodSzavak)
    kodSzavak

public export
mintaSulyNeggyelOszthato : Nat -> Bool
mintaSulyNeggyelOszthato 0 = True
mintaSulyNeggyelOszthato 4 = True
mintaSulyNeggyelOszthato 8 = True
mintaSulyNeggyelOszthato _ = False

public export
mindenKodSzoSulyaNeggyelOszthato :
  {hossz : Nat} -> List (Vect hossz BinarisJel) -> Bool
mindenKodSzoSulyaNeggyelOszthato =
  mindenListaElemTeljesiti
    (\kodSzo => mintaSulyNeggyelOszthato (vektorSulya kodSzo))

public export
minimumNemNullaSuly :
  Nat -> List (Vect hossz BinarisJel) -> Nat
minimumNemNullaSuly eddigiMinimum [] = eddigiMinimum
minimumNemNullaSuly eddigiMinimum (kodSzo :: tobbi) =
  case vektorSulya kodSzo of
    0 => minimumNemNullaSuly eddigiMinimum tobbi
    suly => minimumNemNullaSuly (min eddigiMinimum suly) tobbi

public export
adottSulyuKodSzavakSzama :
  Nat -> List (Vect hossz BinarisJel) -> Nat
adottSulyuKodSzavakSzama keresettSuly [] = 0
adottSulyuKodSzavakSzama keresettSuly (kodSzo :: tobbi) =
  if vektorSulya kodSzo == keresettSuly
    then S (adottSulyuKodSzavakSzama keresettSuly tobbi)
    else adottSulyuKodSzavakSzama keresettSuly tobbi

public export
osszesBinarisVektor : (hossz : Nat) -> List (Vect hossz BinarisJel)
osszesBinarisVektor 0 = [[]]
osszesBinarisVektor (S rovidebbHossz) =
  map (NullaJel ::) (osszesBinarisVektor rovidebbHossz) ++
  map (EgyJel ::) (osszesBinarisVektor rovidebbHossz)

public export
kodDualisa : {hossz : Nat} ->
  List (Vect hossz BinarisJel) -> List (Vect hossz BinarisJel)
kodDualisa kodSzavak =
  filter
    (\jelolt => mindenListaElemTeljesiti
      (\kodSzo => vektorSkalarisParitasa jelolt kodSzo == NullaJel)
      kodSzavak)
    (osszesBinarisVektor hossz)

public export
listaReszhalmaza : {elemTipus : Type} -> Eq elemTipus =>
  List elemTipus -> List elemTipus -> Bool
listaReszhalmaza bal jobb =
  mindenListaElemTeljesiti (\elem => listaTartalmaz elem jobb) bal

public export
listakUgyanaztAHalmaztAdjak : {elemTipus : Type} -> Eq elemTipus =>
  List elemTipus -> List elemTipus -> Bool
listakUgyanaztAHalmaztAdjak bal jobb =
  listaReszhalmaza bal jobb && listaReszhalmaza jobb bal

public export
kodZartOsszeadasra : {hossz : Nat} ->
  List (Vect hossz BinarisJel) -> Bool
kodZartOsszeadasra kodSzavak =
  mindenListaElemTeljesiti
    (\bal => mindenListaElemTeljesiti
      (\jobb => listaTartalmaz (vektorOsszead bal jobb) kodSzavak)
      kodSzavak)
    kodSzavak

public export
kettoHatvany : Nat -> Nat
kettoHatvany 0 = 1
kettoHatvany (S kitevo) = 2 * kettoHatvany kitevo

-- =====================================================================
-- 2. A KÉTSZERESEN PÁROS ÖNDUÁLIS [8,4,4] KÓD
--
-- Ez az a bináris kód, amelyből a Construction A az E8-rácsot adja.
-- A négy sor a háromváltozós affin logikai függvények kiértékelése.
-- =====================================================================

public export
E8AllandoGenerator : Vect 8 BinarisJel
E8AllandoGenerator =
  [EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel]

public export
E8ElsoValtozoGenerator : Vect 8 BinarisJel
E8ElsoValtozoGenerator =
  [EgyJel, EgyJel, EgyJel, EgyJel,
   NullaJel, NullaJel, NullaJel, NullaJel]

public export
E8MasodikValtozoGenerator : Vect 8 BinarisJel
E8MasodikValtozoGenerator =
  [EgyJel, EgyJel, NullaJel, NullaJel,
   EgyJel, EgyJel, NullaJel, NullaJel]

public export
E8HarmadikValtozoGenerator : Vect 8 BinarisJel
E8HarmadikValtozoGenerator =
  [EgyJel, NullaJel, EgyJel, NullaJel,
   EgyJel, NullaJel, EgyJel, NullaJel]

public export
e8KodSzo : BinarisJel -> BinarisJel -> BinarisJel -> BinarisJel
          -> Vect 8 BinarisJel
e8KodSzo allando elso masodik harmadik =
  vektorOsszead (jelSzorozVektort allando E8AllandoGenerator)
    (vektorOsszead (jelSzorozVektort elso E8ElsoValtozoGenerator)
      (vektorOsszead (jelSzorozVektort masodik E8MasodikValtozoGenerator)
        (jelSzorozVektort harmadik E8HarmadikValtozoGenerator)))

public export
E8KodSzavak : List (Vect 8 BinarisJel)
E8KodSzavak =
  [ e8KodSzo NullaJel NullaJel NullaJel NullaJel
  , e8KodSzo NullaJel NullaJel NullaJel EgyJel
  , e8KodSzo NullaJel NullaJel EgyJel NullaJel
  , e8KodSzo NullaJel NullaJel EgyJel EgyJel
  , e8KodSzo NullaJel EgyJel NullaJel NullaJel
  , e8KodSzo NullaJel EgyJel NullaJel EgyJel
  , e8KodSzo NullaJel EgyJel EgyJel NullaJel
  , e8KodSzo NullaJel EgyJel EgyJel EgyJel
  , e8KodSzo EgyJel NullaJel NullaJel NullaJel
  , e8KodSzo EgyJel NullaJel NullaJel EgyJel
  , e8KodSzo EgyJel NullaJel EgyJel NullaJel
  , e8KodSzo EgyJel NullaJel EgyJel EgyJel
  , e8KodSzo EgyJel EgyJel NullaJel NullaJel
  , e8KodSzo EgyJel EgyJel NullaJel EgyJel
  , e8KodSzo EgyJel EgyJel EgyJel NullaJel
  , e8KodSzo EgyJel EgyJel EgyJel EgyJel
  ]

public export
E8KodSzavakSzama : Nat
E8KodSzavakSzama = length E8KodSzavak

public export
E8KodSzavakKulonboznek : Bool
E8KodSzavakKulonboznek = listaIsmetlodesNelkul E8KodSzavak

public export
E8KodNullaSulyuSzavai : Nat
E8KodNullaSulyuSzavai = adottSulyuKodSzavakSzama 0 E8KodSzavak

public export
E8KodNegySulyuSzavai : Nat
E8KodNegySulyuSzavai = adottSulyuKodSzavakSzama 4 E8KodSzavak

public export
E8KodNyolcSulyuSzavai : Nat
E8KodNyolcSulyuSzavai = adottSulyuKodSzavakSzama 8 E8KodSzavak

public export
E8KodMinimumTavolsaga : Nat
E8KodMinimumTavolsaga = minimumNemNullaSuly 8 E8KodSzavak

public export
E8KodOnortogonalitasEllenorzes : Bool
E8KodOnortogonalitasEllenorzes =
  mindenKodSzoParonkentOrtogonalis E8KodSzavak

public export
E8KodKetszeresenParosEllenorzes : Bool
E8KodKetszeresenParosEllenorzes =
  mindenKodSzoSulyaNeggyelOszthato E8KodSzavak

public export
E8KodLinearitasEllenorzes : Bool
E8KodLinearitasEllenorzes = kodZartOsszeadasra E8KodSzavak

public export
E8KodOndataEllenorzes : Bool
E8KodOndataEllenorzes =
  listakUgyanaztAHalmaztAdjak E8KodSzavak (kodDualisa E8KodSzavak)

BizonyitasE8KodSzavakSzama :
  E8KodSzavakSzama = kettoHatvany 4
BizonyitasE8KodSzavakSzama = Refl

BizonyitasE8KodSzavakKulonboznek :
  E8KodSzavakKulonboznek = True
BizonyitasE8KodSzavakKulonboznek = Refl

export
BizonyitasE8KodNullaSulyuSzavai :
  E8KodNullaSulyuSzavai = 1
BizonyitasE8KodNullaSulyuSzavai = Refl

export
BizonyitasE8KodNegySulyuSzavai :
  E8KodNegySulyuSzavai = 14
BizonyitasE8KodNegySulyuSzavai = Refl

export
BizonyitasE8KodNyolcSulyuSzavai :
  E8KodNyolcSulyuSzavai = 1
BizonyitasE8KodNyolcSulyuSzavai = Refl

BizonyitasE8KodMinimumTavolsaga :
  E8KodMinimumTavolsaga = 4
BizonyitasE8KodMinimumTavolsaga = Refl

BizonyitasE8KodOnortogonalis :
  E8KodOnortogonalitasEllenorzes = True
BizonyitasE8KodOnortogonalis = Refl

BizonyitasE8KodKetszeresenParos :
  E8KodKetszeresenParosEllenorzes = True
BizonyitasE8KodKetszeresenParos = Refl

BizonyitasE8KodLinearis :
  E8KodLinearitasEllenorzes = True
BizonyitasE8KodLinearis = Refl

BizonyitasE8KodOndata :
  E8KodOndataEllenorzes = True
BizonyitasE8KodOndata = Refl

-- A Construction A minimális vektorainak száma:
-- 16 koordinátavektor és minden súlynégyes kódszóhoz 16 előjel.

public export
ConstructionAKoordinataVektorokSzama : Nat
ConstructionAKoordinataVektorokSzama = 2 * 8

public export
ConstructionAKodSzoVektorokSzama : Nat
ConstructionAKodSzoVektorokSzama =
  E8KodNegySulyuSzavai * kettoHatvany 4

public export
E8MinimalisVektorokSzama : Nat
E8MinimalisVektorokSzama =
  ConstructionAKoordinataVektorokSzama +
  ConstructionAKodSzoVektorokSzama

BizonyitasConstructionAKoordinataVektorok :
  ConstructionAKoordinataVektorokSzama = 16
BizonyitasConstructionAKoordinataVektorok = Refl

BizonyitasConstructionAKodSzoVektorok :
  ConstructionAKodSzoVektorokSzama = 224
BizonyitasConstructionAKodSzoVektorok = Refl

export
BizonyitasE8MinimalisVektorokSzama :
  E8MinimalisVektorokSzama = 240
BizonyitasE8MinimalisVektorokSzama = Refl

-- =====================================================================
-- 3. PONTÍROZÁS: [8,4,4] → [7,4,3]
-- =====================================================================

public export
elsoKoordinataElhagyasa : {elemTipus : Type} ->
  Vect 8 elemTipus -> Vect 7 elemTipus
elsoKoordinataElhagyasa (_ :: tobbi) = tobbi

public export
HetesHammingKodSzavak : List (Vect 7 BinarisJel)
HetesHammingKodSzavak = map elsoKoordinataElhagyasa E8KodSzavak

public export
HetesHammingKodSzavakSzama : Nat
HetesHammingKodSzavakSzama = length HetesHammingKodSzavak

public export
HetesHammingKodSzavakKulonboznek : Bool
HetesHammingKodSzavakKulonboznek =
  listaIsmetlodesNelkul HetesHammingKodSzavak

public export
HetesHammingKodMinimumTavolsaga : Nat
HetesHammingKodMinimumTavolsaga =
  minimumNemNullaSuly 7 HetesHammingKodSzavak

public export
HetesHammingKodLinearitasEllenorzes : Bool
HetesHammingKodLinearitasEllenorzes =
  kodZartOsszeadasra HetesHammingKodSzavak

BizonyitasHetesHammingKodSzavakSzama :
  HetesHammingKodSzavakSzama = kettoHatvany 4
BizonyitasHetesHammingKodSzavakSzama = Refl

BizonyitasHetesHammingKodSzavakKulonboznek :
  HetesHammingKodSzavakKulonboznek = True
BizonyitasHetesHammingKodSzavakKulonboznek = Refl

BizonyitasHetesHammingKodMinimumTavolsaga :
  HetesHammingKodMinimumTavolsaga = 3
BizonyitasHetesHammingKodMinimumTavolsaga = Refl

BizonyitasHetesHammingKodLinearis :
  HetesHammingKodLinearitasEllenorzes = True
BizonyitasHetesHammingKodLinearis = Refl

-- =====================================================================
-- 4. A [7,3,4] DUÁLIS KÓD ÉS A TARTALMAZÁS
-- =====================================================================

public export
DualisElsoGenerator : Vect 7 BinarisJel
DualisElsoGenerator =
  [NullaJel, NullaJel, NullaJel, EgyJel, EgyJel, EgyJel, EgyJel]

public export
DualisMasodikGenerator : Vect 7 BinarisJel
DualisMasodikGenerator =
  [NullaJel, EgyJel, EgyJel, NullaJel, NullaJel, EgyJel, EgyJel]

public export
DualisHarmadikGenerator : Vect 7 BinarisJel
DualisHarmadikGenerator =
  [EgyJel, NullaJel, EgyJel, NullaJel, EgyJel, NullaJel, EgyJel]

public export
dualisKodSzo : BinarisJel -> BinarisJel -> BinarisJel
             -> Vect 7 BinarisJel
dualisKodSzo elso masodik harmadik =
  vektorOsszead (jelSzorozVektort elso DualisElsoGenerator)
    (vektorOsszead (jelSzorozVektort masodik DualisMasodikGenerator)
      (jelSzorozVektort harmadik DualisHarmadikGenerator))

public export
DualisKodSzavak : List (Vect 7 BinarisJel)
DualisKodSzavak =
  [ dualisKodSzo NullaJel NullaJel NullaJel
  , dualisKodSzo NullaJel NullaJel EgyJel
  , dualisKodSzo NullaJel EgyJel NullaJel
  , dualisKodSzo NullaJel EgyJel EgyJel
  , dualisKodSzo EgyJel NullaJel NullaJel
  , dualisKodSzo EgyJel NullaJel EgyJel
  , dualisKodSzo EgyJel EgyJel NullaJel
  , dualisKodSzo EgyJel EgyJel EgyJel
  ]

public export
DualisKodSzavakKulonboznek : Bool
DualisKodSzavakKulonboznek = listaIsmetlodesNelkul DualisKodSzavak

public export
DualisKodMinimumTavolsaga : Nat
DualisKodMinimumTavolsaga =
  minimumNemNullaSuly 7 DualisKodSzavak

public export
DualisKodReszeAHammingKodnak : Bool
DualisKodReszeAHammingKodnak =
  mindenListaElemTeljesiti
    (\kodSzo => listaTartalmaz kodSzo HetesHammingKodSzavak)
    DualisKodSzavak

public export
DualisKodValobanOrtogonalis : Bool
DualisKodValobanOrtogonalis =
  mindenListaElemTeljesiti
    (\dualisSzo => mindenListaElemTeljesiti
      (\hammingSzo =>
        vektorSkalarisParitasa dualisSzo hammingSzo == NullaJel)
      HetesHammingKodSzavak)
    DualisKodSzavak

public export
KiszamitottDualisMegegyezik : Bool
KiszamitottDualisMegegyezik =
  listakUgyanaztAHalmaztAdjak
    DualisKodSzavak
    (kodDualisa HetesHammingKodSzavak)

BizonyitasDualisKodSzavakSzama :
  length DualisKodSzavak = kettoHatvany 3
BizonyitasDualisKodSzavakSzama = Refl

BizonyitasDualisKodSzavakKulonboznek :
  DualisKodSzavakKulonboznek = True
BizonyitasDualisKodSzavakKulonboznek = Refl

BizonyitasDualisKodMinimumTavolsaga :
  DualisKodMinimumTavolsaga = 4
BizonyitasDualisKodMinimumTavolsaga = Refl

BizonyitasDualisKodReszeAHammingKodnak :
  DualisKodReszeAHammingKodnak = True
BizonyitasDualisKodReszeAHammingKodnak = Refl

BizonyitasDualisKodValobanOrtogonalis :
  DualisKodValobanOrtogonalis = True
BizonyitasDualisKodValobanOrtogonalis = Refl

BizonyitasKiszamitottDualisMegegyezik :
  KiszamitottDualisMegegyezik = True
BizonyitasKiszamitottDualisMegegyezik = Refl

-- =====================================================================
-- 5. CALDERBANK–SHOR–STEANE: [[7,1,3]]
-- =====================================================================

public export
kodKulonbseg : {elemTipus : Type} ->
  Eq elemTipus => List elemTipus -> List elemTipus -> List elemTipus
kodKulonbseg bal jobb = filter (\elem => not (listaTartalmaz elem jobb)) bal

public export
NemDualisHammingKodSzavak : List (Vect 7 BinarisJel)
NemDualisHammingKodSzavak =
  kodKulonbseg HetesHammingKodSzavak DualisKodSzavak

public export
FizikaiKubitokSzama : Nat
FizikaiKubitokSzama = 7

public export
KlasszikusKodDimenzioja : Nat
KlasszikusKodDimenzioja = 4

public export
LogikaiKubitokSzama : Nat
LogikaiKubitokSzama =
  KlasszikusKodDimenzioja + KlasszikusKodDimenzioja
    `minus` FizikaiKubitokSzama

public export
KvantumKodTavolsaga : Nat
KvantumKodTavolsaga =
  minimumNemNullaSuly 7 NemDualisHammingKodSzavak

public export
StabilizatorGeneratorokSzama : Nat
StabilizatorGeneratorokSzama =
  FizikaiKubitokSzama `minus` LogikaiKubitokSzama

BizonyitasLogikaiKubitokSzama :
  LogikaiKubitokSzama = 1
BizonyitasLogikaiKubitokSzama = Refl

BizonyitasKvantumKodTavolsaga :
  KvantumKodTavolsaga = 3
BizonyitasKvantumKodTavolsaga = Refl

BizonyitasStabilizatorGeneratorokSzama :
  StabilizatorGeneratorokSzama = 6
BizonyitasStabilizatorGeneratorokSzama = Refl

-- =====================================================================
-- 6. A DISZKRÉT PARAMÉTEREK ÉS A PONTOS ARITMETIKA
-- =====================================================================

public export
E8Rang : Nat
E8Rang = 8

public export
HetesHilbertTerAllapotainakSzama : Nat
HetesHilbertTerAllapotainakSzama = kettoHatvany FizikaiKubitokSzama

public export
NyolcBitesTerAllapotainakSzama : Nat
NyolcBitesTerAllapotainakSzama = kettoHatvany E8Rang

public export
KiterjesztoParitasJelekSzama : Nat
KiterjesztoParitasJelekSzama = E8Rang `minus` FizikaiKubitokSzama

public export
HorgonyEgeszResze : Nat
HorgonyEgeszResze =
  HetesHilbertTerAllapotainakSzama
    + kettoHatvany KvantumKodTavolsaga
    + KiterjesztoParitasJelekSzama

public export
HorgonyTortSzamlaloja : Nat
HorgonyTortSzamlaloja =
  StabilizatorGeneratorokSzama + KvantumKodTavolsaga

public export
HorgonyTortNevezoje : Nat
HorgonyTortNevezoje =
  NyolcBitesTerAllapotainakSzama `minus`
    StabilizatorGeneratorokSzama

BizonyitasHetesHilbertTerSzazHuszonnyolc :
  HetesHilbertTerAllapotainakSzama = 128
BizonyitasHetesHilbertTerSzazHuszonnyolc = Refl

BizonyitasNyolcBitesTerKetszazOtvenhat :
  NyolcBitesTerAllapotainakSzama = 256
BizonyitasNyolcBitesTerKetszazOtvenhat = Refl

BizonyitasHorgonyEgeszResze :
  HorgonyEgeszResze = 137
BizonyitasHorgonyEgeszResze = Refl

BizonyitasHorgonyTortSzamlaloja :
  HorgonyTortSzamlaloja = 9
BizonyitasHorgonyTortSzamlaloja = Refl

BizonyitasHorgonyTortNevezoje :
  HorgonyTortNevezoje = 250
BizonyitasHorgonyTortNevezoje = Refl

-- A következő három azonosság megmutatja, hogy a gravitációs képlet
-- számai ugyanabból a paramétercsomagból származnak. Ez még nem
-- fizikai levezetés: csak a behelyettesítés pontos ellenőrzése.

public export
GravitaciosAranySzamlaloja : Nat
GravitaciosAranySzamlaloja =
  FizikaiKubitokSzama *
    (FizikaiKubitokSzama + KvantumKodTavolsaga + LogikaiKubitokSzama)

public export
GravitaciosAranyNevezoje : Nat
GravitaciosAranyNevezoje =
  kettoHatvany KvantumKodTavolsaga *
    ((FizikaiKubitokSzama `minus` (2 * LogikaiKubitokSzama)) *
     (FizikaiKubitokSzama `minus` (2 * LogikaiKubitokSzama)))

public export
GravitaciosHatvanyNevezoje : Nat
GravitaciosHatvanyNevezoje =
  kettoHatvany KvantumKodTavolsaga *
    (FizikaiKubitokSzama `minus` (2 * LogikaiKubitokSzama))

BizonyitasGravitaciosAranySzamlaloja :
  GravitaciosAranySzamlaloja = 77
BizonyitasGravitaciosAranySzamlaloja = Refl

BizonyitasGravitaciosAranyNevezoje :
  GravitaciosAranyNevezoje = 200
BizonyitasGravitaciosAranyNevezoje = Refl

BizonyitasGravitaciosHatvanyNevezoje :
  GravitaciosHatvanyNevezoje = 40
BizonyitasGravitaciosHatvanyNevezoje = Refl

-- =====================================================================
-- 7. A FIZIKAI HÍD HATÁRA
-- =====================================================================

public export
data AllitasEredete
  = VegesKodolasbolBizonyitott
  | DefinicioSzerintiAritmetika
  | FizikaiFelvetesAlapjan
  | MeresselOsszevetett

public export
data FizikaiFelvetes
  = FinomszerkezetiAzonositas
  | FinomszerkezetiKorrekcioAlakja
  | GravitaciosKepletAlakja
  | GravitaciosMertekegysegSkala

-- Az E8 Lie-algebra nem tartalmazza a Yang–Mills-csatolás számértékét.
-- Ugyanahhoz az algebrai adathoz különböző csatolás választható.

public export
data E8AlgebraiAdat = E8AlgebraiAdatKonstruktor

public export
record E8MertekElmelet where
  constructor E8MertekElmeletKonstruktor
  algebraiAdat : E8AlgebraiAdat
  mertekCsatolas : Double

public export
ElsoE8MertekElmelet : E8MertekElmelet
ElsoE8MertekElmelet =
  E8MertekElmeletKonstruktor E8AlgebraiAdatKonstruktor 1.0

public export
MasodikE8MertekElmelet : E8MertekElmelet
MasodikE8MertekElmelet =
  E8MertekElmeletKonstruktor E8AlgebraiAdatKonstruktor 2.0

public export
MertekCsatolasokEgyenlosegenekEllenorzese : Bool
MertekCsatolasokEgyenlosegenekEllenorzese =
  mertekCsatolas ElsoE8MertekElmelet ==
  mertekCsatolas MasodikE8MertekElmelet

BizonyitasMertekCsatolasNemEgyedi :
  MertekCsatolasokEgyenlosegenekEllenorzese = False
BizonyitasMertekCsatolasNemEgyedi = Refl

-- A gravitációs állandó dimenziós. Dimenziótlan kombinatorikából
-- csak külön dimenziós skála megadásával készíthető.

public export
data MertekDimenzio = Dimenziotlan | GravitaciosDimenzio

public export
data Mennyiseg : MertekDimenzio -> Type where
  DimenziotlanMennyisegKonstruktor : Double -> Mennyiseg Dimenziotlan
  GravitaciosMennyisegKonstruktor : Double
    -> Mennyiseg GravitaciosDimenzio

public export
gravitaciosSkalazas :
  Mennyiseg Dimenziotlan ->
  Mennyiseg GravitaciosDimenzio ->
  Mennyiseg GravitaciosDimenzio
gravitaciosSkalazas
  (DimenziotlanMennyisegKonstruktor arany)
  (GravitaciosMennyisegKonstruktor skala) =
    GravitaciosMennyisegKonstruktor (arany * skala)

public export
dimenzioAzonositasLehetetlen :
  Dimenziotlan = GravitaciosDimenzio -> Void
dimenzioAzonositasLehetetlen Refl impossible

-- =====================================================================
-- 8. NUMERIKUS ELLENŐRZÉS IDRIS DOUBLE-LEL
-- =====================================================================

public export
HorgonyTort : Double
HorgonyTort =
  cast HorgonyTortSzamlaloja / cast HorgonyTortNevezoje

public export
FinomszerkezetiKorrekcioAlapja : Double
FinomszerkezetiKorrekcioAlapja =
  (cast HetesHilbertTerAllapotainakSzama - cast FizikaiKubitokSzama) /
  cast HetesHilbertTerAllapotainakSzama

public export
FinomszerkezetiKorrekcioKitevoje : Double
FinomszerkezetiKorrekcioKitevoje =
  cast (NyolcBitesTerAllapotainakSzama `minus` FizikaiKubitokSzama)
    + log (cast HorgonyTortSzamlaloja /
           cast (kettoHatvany KvantumKodTavolsaga))

public export
FinomszerkezetiKorrekcio : Double
FinomszerkezetiKorrekcio =
  FinomszerkezetiKorrekcioAlapja
    `pow` FinomszerkezetiKorrekcioKitevoje

public export
FinomszerkezetiAllandoInverzJelolt : Double
FinomszerkezetiAllandoInverzJelolt =
  cast HorgonyEgeszResze + HorgonyTort - FinomszerkezetiKorrekcio

-- Ez az E8–Steane paraméterekből kapott konzisztens, dimenziótlan rész.
-- Fizikai jelentést csak egy megadott tömegskálán kap:
--
--   gravitációs csatolás(m) = G·m² / (ℏ·c)
--
-- Ha az alábbi számot ezzel a csatolással azonosítjuk, akkor a hozzá
-- tartozó tömegskála a Planck-tömeg sqrt(arany)-szorosa.

public export
DimenzioNelKuliGravitaciosCsatolasJelolt : Double
DimenzioNelKuliGravitaciosCsatolasJelolt =
  (cast GravitaciosAranySzamlaloja / cast GravitaciosAranyNevezoje)
  * sqrt (cast KvantumKodTavolsaga)
  * ((1.0 + HorgonyTort)
      `pow` (1.0 / cast GravitaciosHatvanyNevezoje))

public export
PlanckTomeghezViszonyitottModellSkala : Double
PlanckTomeghezViszonyitottModellSkala =
  sqrt DimenzioNelKuliGravitaciosCsatolasJelolt

public export
FinomszerkezetiMeresiReferencia : Double
FinomszerkezetiMeresiReferencia = 137.035999177

public export
FinomszerkezetiMeresiBizonytalansag : Double
FinomszerkezetiMeresiBizonytalansag = 2.1e-8

public export
main : IO ()
main = do
  putStrLn "E8-kód [8,4,4]:"
  putStrLn ("  kódszavak: " ++ show E8KodSzavakSzama)
  putStrLn ("  minimumtávolság: " ++ show E8KodMinimumTavolsaga)
  putStrLn ("  önortogonális: " ++ show E8KodOnortogonalitasEllenorzes)
  putStrLn ("  önduális: " ++ show E8KodOndataEllenorzes)
  putStrLn ("  lineáris: " ++ show E8KodLinearitasEllenorzes)
  putStrLn ("  kétszeresen páros: " ++ show E8KodKetszeresenParosEllenorzes)
  putStrLn ("  súlyeloszlás: 1 + 14·y⁴ + y⁸")
  putStrLn ("  Construction A minimális vektorai: " ++
            show E8MinimalisVektorokSzama)
  putStrLn "Pontírozott Hamming-kód és Steane-kód:"
  putStrLn ("  [7,4,3] minimumtávolság: " ++
            show HetesHammingKodMinimumTavolsaga)
  putStrLn ("  duális [7,3,4] benne van: " ++
            show DualisKodReszeAHammingKodnak)
  putStrLn ("  kvantumparaméterek: [[" ++ show FizikaiKubitokSzama ++
            "," ++ show LogikaiKubitokSzama ++
            "," ++ show KvantumKodTavolsaga ++ "]]")
  putStrLn "Definíció szerinti aritmetika:"
  putStrLn ("  egész rész: " ++ show HorgonyEgeszResze)
  putStrLn ("  tört: " ++ show HorgonyTortSzamlaloja ++
            "/" ++ show HorgonyTortNevezoje)
  putStrLn "Fizikai felvetések numerikus kimenete:"
  putStrLn ("  finomszerkezeti állandó inverze: " ++
            show FinomszerkezetiAllandoInverzJelolt)
  putStrLn ("  eltérés / mérési bizonytalanság: " ++
            show (abs (FinomszerkezetiAllandoInverzJelolt -
                       FinomszerkezetiMeresiReferencia) /
                  FinomszerkezetiMeresiBizonytalansag))
  putStrLn ("  dimenzió nélküli gravitációs csatolás: " ++
            show DimenzioNelKuliGravitaciosCsatolasJelolt)
  putStrLn ("  hozzá tartozó modellskála / Planck-tömeg: " ++
            show PlanckTomeghezViszonyitottModellSkala)
  putStrLn "Határ: a fizikai azonosítások felvetések, nem E8-tételek."
