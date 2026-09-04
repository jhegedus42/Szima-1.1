module Tanulsagok.PauliOsztalyProba

import Data.Vect
import Data.List
import E8SteaneLevezetes

%default total

vektorParitasa : Vect hossz BinarisJel -> BinarisJel
vektorParitasa = foldr jelOsszead NullaJel

listaParok : List balTipus -> List jobbTipus -> List (balTipus, jobbTipus)
listaParok [] jobbLista = []
listaParok (balElem :: tobbiBalElem) jobbLista =
  map (\jobbElem => (balElem, jobbElem)) jobbLista ++
  listaParok tobbiBalElem jobbLista

NormalizerPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NormalizerPauliMintak =
  listaParok HetesHammingKodSzavak HetesHammingKodSzavak

StabilizatorPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
StabilizatorPauliMintak =
  listaParok DualisKodSzavak DualisKodSzavak

record LogikaiPauliOsztaly where
  constructor LogikaiPauliOsztalyKonstruktor
  elsoLogikaiJel : BinarisJel
  masodikLogikaiJel : BinarisJel

Eq LogikaiPauliOsztaly where
  bal == jobb =
    bal.elsoLogikaiJel == jobb.elsoLogikaiJel &&
    bal.masodikLogikaiJel == jobb.masodikLogikaiJel

pauliLogikaiOsztalya :
  (Vect 7 BinarisJel, Vect 7 BinarisJel) -> LogikaiPauliOsztaly
pauliLogikaiOsztalya (elsoMinta, masodikMinta) =
  LogikaiPauliOsztalyKonstruktor
    (vektorParitasa elsoMinta)
    (vektorParitasa masodikMinta)

LogikaiAzonossag : LogikaiPauliOsztaly
LogikaiAzonossag =
  LogikaiPauliOsztalyKonstruktor NullaJel NullaJel

LogikaiElsoOperator : LogikaiPauliOsztaly
LogikaiElsoOperator =
  LogikaiPauliOsztalyKonstruktor EgyJel NullaJel

LogikaiMasodikOperator : LogikaiPauliOsztaly
LogikaiMasodikOperator =
  LogikaiPauliOsztalyKonstruktor NullaJel EgyJel

LogikaiHarmadikOperator : LogikaiPauliOsztaly
LogikaiHarmadikOperator =
  LogikaiPauliOsztalyKonstruktor EgyJel EgyJel

adottLogikaiPauliOsztalyMerete : LogikaiPauliOsztaly -> Nat
adottLogikaiPauliOsztalyMerete keresettOsztaly =
  length
    (filter
      (\pauliMinta => pauliLogikaiOsztalya pauliMinta == keresettOsztaly)
      NormalizerPauliMintak)

NormalizerPauliMintakSzama : Nat
NormalizerPauliMintakSzama = length NormalizerPauliMintak

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

NormalizerNullaOsztalya :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NormalizerNullaOsztalya =
  filter
    (\pauliMinta => pauliLogikaiOsztalya pauliMinta == LogikaiAzonossag)
    NormalizerPauliMintak

StabilizatorPontosanANullaOsztaly : Bool
StabilizatorPontosanANullaOsztaly =
  listakUgyanaztAHalmaztAdjak
    StabilizatorPauliMintak
    NormalizerNullaOsztalya

BizonyitasStabilizatorPontosanANullaOsztaly :
  StabilizatorPontosanANullaOsztaly = True
BizonyitasStabilizatorPontosanANullaOsztaly = Refl

jelVagy : BinarisJel -> BinarisJel -> BinarisJel
jelVagy NullaJel NullaJel = NullaJel
jelVagy _ _ = EgyJel

pauliTartoSulya :
  (Vect 7 BinarisJel, Vect 7 BinarisJel) -> Nat
pauliTartoSulya (elsoMinta, masodikMinta) =
  vektorSulya (zipWith jelVagy elsoMinta masodikMinta)

NemTrivialisNormalizerPauliMintak :
  List (Vect 7 BinarisJel, Vect 7 BinarisJel)
NemTrivialisNormalizerPauliMintak =
  filter
    (\pauliMinta => not (pauliLogikaiOsztalya pauliMinta ==
                         LogikaiAzonossag))
    NormalizerPauliMintak

minimumPauliTartoSuly :
  Nat -> List (Vect 7 BinarisJel, Vect 7 BinarisJel) -> Nat
minimumPauliTartoSuly eddigiMinimum [] = eddigiMinimum
minimumPauliTartoSuly eddigiMinimum (pauliMinta :: tobbi) =
  minimumPauliTartoSuly
    (min eddigiMinimum (pauliTartoSulya pauliMinta))
    tobbi

KozvetlenLogikaiPauliTavolsag : Nat
KozvetlenLogikaiPauliTavolsag =
  minimumPauliTartoSuly 7 NemTrivialisNormalizerPauliMintak

-- Tanulság: ennek Refl-normalizálása Idris 2 0.8.0 alatt több mint
-- egy percig fut. A fő modul ezért a már bizonyított klasszikus
-- mellékosztály-távolságot használja, ezt pedig futásidejű független
-- ellenőrzésként tartja meg.
