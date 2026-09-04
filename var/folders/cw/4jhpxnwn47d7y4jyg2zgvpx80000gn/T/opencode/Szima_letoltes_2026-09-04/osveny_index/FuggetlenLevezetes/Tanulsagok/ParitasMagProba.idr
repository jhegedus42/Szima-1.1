module Tanulsagok.ParitasMagProba

import Data.Vect
import Data.List
import E8SteaneLevezetes

%default total

vektorParitasa : Vect hossz BinarisJel -> BinarisJel
vektorParitasa = foldr jelOsszead NullaJel

elsoKoordinata : Vect (S hossz) elemTipus -> elemTipus
elsoKoordinata (elso :: _) = elso

NyolcasHetesKodSzoParok :
  List (Vect 8 BinarisJel, Vect 7 BinarisJel)
NyolcasHetesKodSzoParok =
  zip E8KodSzavak HetesHammingKodSzavak

ToroltKoordinataParitasEllenorzes : Bool
ToroltKoordinataParitasEllenorzes =
  mindenListaElemTeljesiti
    (\(nyolcasKodSzo, hetesKodSzo) =>
      elsoKoordinata nyolcasKodSzo == vektorParitasa hetesKodSzo)
    NyolcasHetesKodSzoParok

BizonyitasToroltKoordinataParitas :
  ToroltKoordinataParitasEllenorzes = True
BizonyitasToroltKoordinataParitas = Refl

ParosHetesHammingKodSzavak : List (Vect 7 BinarisJel)
ParosHetesHammingKodSzavak =
  filter
    (\kodSzo => vektorParitasa kodSzo == NullaJel)
    HetesHammingKodSzavak

ParatlanHetesHammingKodSzavak : List (Vect 7 BinarisJel)
ParatlanHetesHammingKodSzavak =
  filter
    (\kodSzo => vektorParitasa kodSzo == EgyJel)
    HetesHammingKodSzavak

ParitasMagjaMegegyezikADualissal : Bool
ParitasMagjaMegegyezikADualissal =
  listakUgyanaztAHalmaztAdjak
    ParosHetesHammingKodSzavak
    DualisKodSzavak

BizonyitasParitasMagjaMegegyezikADualissal :
  ParitasMagjaMegegyezikADualissal = True
BizonyitasParitasMagjaMegegyezikADualissal = Refl

ParosMellekosztalyMerete : Nat
ParosMellekosztalyMerete = length ParosHetesHammingKodSzavak

ParatlanMellekosztalyMerete : Nat
ParatlanMellekosztalyMerete = length ParatlanHetesHammingKodSzavak

BizonyitasParosMellekosztalyNyolc :
  ParosMellekosztalyMerete = 8
BizonyitasParosMellekosztalyNyolc = Refl

BizonyitasParatlanMellekosztalyNyolc :
  ParatlanMellekosztalyMerete = 8
BizonyitasParatlanMellekosztalyNyolc = Refl

ValasztottParatlanKodSzo : Vect 7 BinarisJel
ValasztottParatlanKodSzo =
  [EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel, EgyJel]

DualisKodEltoltja : List (Vect 7 BinarisJel)
DualisKodEltoltja =
  map (vektorOsszead ValasztottParatlanKodSzo) DualisKodSzavak

ParatlanMellekosztalyValobanEltolt : Bool
ParatlanMellekosztalyValobanEltolt =
  listakUgyanaztAHalmaztAdjak
    ParatlanHetesHammingKodSzavak
    DualisKodEltoltja

BizonyitasParatlanMellekosztalyValobanEltolt :
  ParatlanMellekosztalyValobanEltolt = True
BizonyitasParatlanMellekosztalyValobanEltolt = Refl
