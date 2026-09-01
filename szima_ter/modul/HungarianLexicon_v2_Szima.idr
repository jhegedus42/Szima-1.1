module HungarianLexicon_v2_Szima

import Data.List
import Data.String

%default total

-- 3460 Hungarian words matched to mathematical types
-- Primes = nouns (objects), composites = verbs (morphisms)
-- Noun prefix n_, Verb prefix v_, Adj prefix a_, Adv prefix d_
-- Back harmony = Additive, Front = Multiplicative, Mixed = Ring

public export
data MathRole = ObjectRole | MorphismRole | PropertyRole | ModifierRole

public export
data Algebra = Additive | Multiplicative | Ring

public export
record HuWord where
  constructor MkHu
  huText : String
  huRoot : String
  huRole : MathRole
  huAlgebra : Algebra
  huFeat : Nat
  huLength : Nat

public export n_abakusz : HuWord
n_abakusz = MkHu "abakusz" "abakusz" ObjectRole Additive 0 7
public export n_abisszikus : HuWord
n_abisszikus = MkHu "abisszikus" "abisszikus" ObjectRole Additive 0 10
public export n_abla2cio2 : HuWord
n_abla2cio2 = MkHu "abláció" "abláció" ObjectRole Additive 0 7
public export n_abortusz : HuWord
n_abortusz = MkHu "abortusz" "abortusz" ObjectRole Additive 0 8
public export n_abszolutizmus : HuWord
n_abszolutizmus = MkHu "abszolutizmus" "abszolutizmus" ObjectRole Additive 0 13
public export n_aceta2tfilm : HuWord
n_aceta2tfilm = MkHu "acetátfilm" "acetátfilm" ObjectRole Multiplicative 0 10
public export n_acha2t : HuWord
n_acha2t = MkHu "achát" "achá" ObjectRole Additive 2 5
public export n_ace2l : HuWord
n_ace2l = MkHu "acél" "acél" ObjectRole Multiplicative 0 4
public export n_adhe2zio2 : HuWord
n_adhe2zio2 = MkHu "adhézió" "adhézió" ObjectRole Additive 0 7
public export n_adjuta2ns : HuWord
n_adjuta2ns = MkHu "adjutáns" "adjutáns" ObjectRole Additive 0 8
public export n_adminisztra2cio2 : HuWord
n_adminisztra2cio2 = MkHu "adminisztráció" "adminisztráció" ObjectRole Additive 0 14
public export n_adminisztra2la2s : HuWord
n_adminisztra2la2s = MkHu "adminisztrálás" "adminisztrálás" ObjectRole Additive 0 14
public export n_adminisztra2tor : HuWord
n_adminisztra2tor = MkHu "adminisztrátor" "adminisztrátor" ObjectRole Additive 0 14
public export n_admira2lis : HuWord
n_admira2lis = MkHu "admirális" "admirális" ObjectRole Multiplicative 0 9
public export n_adoma : HuWord
n_adoma = MkHu "adoma" "adoma" ObjectRole Additive 0 5
public export n_advekcio2 : HuWord
n_advekcio2 = MkHu "advekció" "advekció" ObjectRole Additive 0 8
public export n_adzsa2rok : HuWord
n_adzsa2rok = MkHu "adzsárok" "adzsár" ObjectRole Additive 4 8
public export n_aerosolok : HuWord
n_aerosolok = MkHu "aerosolok" "aerosol" ObjectRole Additive 4 9
public export n_affrika2ta : HuWord
n_affrika2ta = MkHu "affrikáta" "affrikáta" ObjectRole Additive 0 9
public export n_aggrega2t : HuWord
n_aggrega2t = MkHu "aggregát" "aggregá" ObjectRole Additive 2 8
public export n_agita2cio2 : HuWord
n_agita2cio2 = MkHu "agitáció" "agitáció" ObjectRole Additive 0 8
public export n_agita2tor : HuWord
n_agita2tor = MkHu "agitátor" "agitátor" ObjectRole Additive 0 8
public export n_agresszio2 : HuWord
n_agresszio2 = MkHu "agresszió" "agresszió" ObjectRole Additive 0 9
public export n_agresszor : HuWord
n_agresszor = MkHu "agresszor" "agresszor" ObjectRole Additive 0 9
public export n_agrofizika : HuWord
n_agrofizika = MkHu "agrofizika" "agrofizika" ObjectRole Additive 0 10
public export n_agroklimatolo2gia : HuWord
n_agroklimatolo2gia = MkHu "agroklimatológia" "agroklimatológia" ObjectRole Additive 0 16
public export n_agroke2mia : HuWord
n_agroke2mia = MkHu "agrokémia" "agrokémia" ObjectRole Additive 0 9
public export n_agrominimum : HuWord
n_agrominimum = MkHu "agrominimum" "agrominimum" ObjectRole Additive 0 11
public export n_agrono2mus : HuWord
n_agrono2mus = MkHu "agronómus" "agronómus" ObjectRole Additive 0 9
public export n_agyagpala : HuWord
n_agyagpala = MkHu "agyagpala" "agyagpala" ObjectRole Additive 0 9
public export n_agyonszu2ra2s : HuWord
n_agyonszu2ra2s = MkHu "agyonszúrás" "agyonszúrás" ObjectRole Additive 0 11
public export n_aha2 : HuWord
n_aha2 = MkHu "ahá" "ahá" ObjectRole Additive 0 3
public export n_akade2mia : HuWord
n_akade2mia = MkHu "akadémia" "akadémia" ObjectRole Additive 0 8
public export n_akade2mikus : HuWord
n_akade2mikus = MkHu "akadémikus" "akadémikus" ObjectRole Additive 0 10
public export n_akaratlan : HuWord
n_akaratlan = MkHu "akaratlan" "akaratla" ObjectRole Additive 1 9
public export n_akcelera2cio2 : HuWord
n_akcelera2cio2 = MkHu "akceleráció" "akceleráció" ObjectRole Additive 0 11
public export n_akcentus : HuWord
n_akcentus = MkHu "akcentus" "akcentus" ObjectRole Additive 0 8
public export n_akklimatiza2lo2da2s : HuWord
n_akklimatiza2lo2da2s = MkHu "akklimatizálódás" "akklimatizálódás" ObjectRole Additive 0 16
public export n_akkord : HuWord
n_akkord = MkHu "akkord" "akkord" ObjectRole Additive 0 6
public export n_akkredita2la2s : HuWord
n_akkredita2la2s = MkHu "akkreditálás" "akkreditálás" ObjectRole Additive 0 12
public export n_akkrediti2v : HuWord
n_akkrediti2v = MkHu "akkreditív" "akkreditív" ObjectRole Multiplicative 0 10
public export n_akkumula2cio2 : HuWord
n_akkumula2cio2 = MkHu "akkumuláció" "akkumuláció" ObjectRole Additive 0 11
public export n_akkumula2tor : HuWord
n_akkumula2tor = MkHu "akkumulátor" "akkumulátor" ObjectRole Additive 0 11
public export n_akkuzati2vusz : HuWord
n_akkuzati2vusz = MkHu "akkuzatívusz" "akkuzatívusz" ObjectRole Additive 0 12
public export n_akrobata : HuWord
n_akrobata = MkHu "akrobata" "akrobata" ObjectRole Additive 0 8
public export n_akrobatika : HuWord
n_akrobatika = MkHu "akrobatika" "akrobatika" ObjectRole Additive 0 10
public export n_akszio2ma : HuWord
n_akszio2ma = MkHu "akszióma" "akszióma" ObjectRole Additive 0 8
public export n_aktivista : HuWord
n_aktivista = MkHu "aktivista" "aktivista" ObjectRole Additive 0 9
public export n_aktivita2s : HuWord
n_aktivita2s = MkHu "aktivitás" "aktivitás" ObjectRole Additive 0 9
public export n_aktiva2la2s : HuWord
n_aktiva2la2s = MkHu "aktiválás" "aktiválás" ObjectRole Additive 0 9
public export n_aktus : HuWord
n_aktus = MkHu "aktus" "aktus" ObjectRole Additive 0 5
public export n_akti2v : HuWord
n_akti2v = MkHu "aktív" "aktív" ObjectRole Multiplicative 0 5
public export n_akvarell : HuWord
n_akvarell = MkHu "akvarell" "akvarell" ObjectRole Multiplicative 0 8
public export n_akva2rium : HuWord
n_akva2rium = MkHu "akvárium" "akvárium" ObjectRole Additive 0 8
public export n_alany : HuWord
n_alany = MkHu "alany" "alany" ObjectRole Additive 0 5
public export n_alapigazsa2g : HuWord
n_alapigazsa2g = MkHu "alapigazság" "alapigazság" ObjectRole Additive 0 11
public export n_alapte2tel : HuWord
n_alapte2tel = MkHu "alaptétel" "alaptétel" ObjectRole Multiplicative 0 9
public export n_alapto3rve2ny : HuWord
n_alapto3rve2ny = MkHu "alaptörvény" "alaptörvény" ObjectRole Multiplicative 0 11
public export n_album : HuWord
n_album = MkHu "album" "album" ObjectRole Additive 0 5
public export n_algebra : HuWord
n_algebra = MkHu "algebra" "algeb" ObjectRole Multiplicative 1 7
public export n_alizarin : HuWord
n_alizarin = MkHu "alizarin" "alizari" ObjectRole Multiplicative 1 8
public export n_alkaliza2la2s : HuWord
n_alkaliza2la2s = MkHu "alkalizálás" "alkalizálás" ObjectRole Additive 0 11
public export n_alkatre2szke2szlet : HuWord
n_alkatre2szke2szlet = MkHu "alkatrészkészlet" "alkatrészkészl" ObjectRole Multiplicative 2 16
public export n_alkohol : HuWord
n_alkohol = MkHu "alkohol" "alkohol" ObjectRole Additive 0 7
public export n_alkoholista : HuWord
n_alkoholista = MkHu "alkoholista" "alkoholista" ObjectRole Additive 0 11
public export n_alkoholizmus : HuWord
n_alkoholizmus = MkHu "alkoholizmus" "alkoholizmus" ObjectRole Additive 0 12
public export n_alkotma2ny : HuWord
n_alkotma2ny = MkHu "alkotmány" "alkotmány" ObjectRole Additive 0 9
public export n_alle2 : HuWord
n_alle2 = MkHu "allé" "allé" ObjectRole Multiplicative 0 4
public export n_alma : HuWord
n_alma = MkHu "alma" "alma" ObjectRole Additive 0 4
public export n_almanach : HuWord
n_almanach = MkHu "almanach" "almanach" ObjectRole Additive 0 8
public export n_alnasiak : HuWord
n_alnasiak = MkHu "alnasiak" "alnasi" ObjectRole Multiplicative 4 8
public export n_aloe2 : HuWord
n_aloe2 = MkHu "aloé" "aloé" ObjectRole Multiplicative 0 4
public export n_alpinista : HuWord
n_alpinista = MkHu "alpinista" "alpinista" ObjectRole Additive 0 9
public export n_alpinizmus : HuWord
n_alpinizmus = MkHu "alpinizmus" "alpinizmus" ObjectRole Additive 0 10
public export n_altalajre2teg : HuWord
n_altalajre2teg = MkHu "altalajréteg" "altalajréteg" ObjectRole Multiplicative 0 12
public export n_altata2s : HuWord
n_altata2s = MkHu "altatás" "altatás" ObjectRole Additive 0 7
public export n_alumi2nium : HuWord
n_alumi2nium = MkHu "alumínium" "alumínium" ObjectRole Additive 0 9
public export n_alva2s : HuWord
n_alva2s = MkHu "alvás" "alvás" ObjectRole Additive 0 5
public export n_alva2sido4 : HuWord
n_alva2sido4 = MkHu "alvásidő" "alvásidő" ObjectRole Multiplicative 0 8
public export n_alvo2hely : HuWord
n_alvo2hely = MkHu "alvóhely" "alvóhely" ObjectRole Multiplicative 0 8
public export n_ambulancia : HuWord
n_ambulancia = MkHu "ambulancia" "ambulancia" ObjectRole Additive 0 10
public export n_amfitea2trum : HuWord
n_amfitea2trum = MkHu "amfiteátrum" "amfiteátrum" ObjectRole Additive 0 11
public export n_ammo2nia : HuWord
n_ammo2nia = MkHu "ammónia" "ammónia" ObjectRole Additive 0 7
public export n_amnesztia : HuWord
n_amnesztia = MkHu "amnesztia" "amnesztia" ObjectRole Additive 0 9
public export n_amortiza2cio2 : HuWord
n_amortiza2cio2 = MkHu "amortizáció" "amortizáció" ObjectRole Additive 0 11
public export n_amplitu2do2 : HuWord
n_amplitu2do2 = MkHu "amplitúdó" "amplitúdó" ObjectRole Additive 0 9
public export n_anali2zis : HuWord
n_anali2zis = MkHu "analízis" "analízis" ObjectRole Multiplicative 0 8
public export n_anana2sz : HuWord
n_anana2sz = MkHu "ananász" "ananász" ObjectRole Additive 0 7
public export n_anarchia : HuWord
n_anarchia = MkHu "anarchia" "anarchia" ObjectRole Additive 0 8
public export n_anarchista : HuWord
n_anarchista = MkHu "anarchista" "anarchista" ObjectRole Additive 0 10
public export n_anarchizmus : HuWord
n_anarchizmus = MkHu "anarchizmus" "anarchizmus" ObjectRole Additive 0 11
public export n_anato2mia : HuWord
n_anato2mia = MkHu "anatómia" "anatómia" ObjectRole Additive 0 8
public export n_anekdota : HuWord
n_anekdota = MkHu "anekdota" "anekdota" ObjectRole Additive 0 8
public export n_anoma2lia : HuWord
n_anoma2lia = MkHu "anomália" "anomália" ObjectRole Additive 0 8
public export n_antagonizmus : HuWord
n_antagonizmus = MkHu "antagonizmus" "antagonizmus" ObjectRole Additive 0 12
public export n_antekli2zis : HuWord
n_antekli2zis = MkHu "anteklízis" "anteklízis" ObjectRole Multiplicative 0 10
public export n_antenna : HuWord
n_antenna = MkHu "antenna" "antenna" ObjectRole Additive 0 7
public export n_anticiklon : HuWord
n_anticiklon = MkHu "anticiklon" "anticikl" ObjectRole Multiplicative 1 10
public export n_antifasiszta : HuWord
n_antifasiszta = MkHu "antifasiszta" "antifasiszta" ObjectRole Additive 0 12
public export n_antiklina2l : HuWord
n_antiklina2l = MkHu "antiklinál" "antikli" ObjectRole Multiplicative 1 10
public export n_antikrisztus : HuWord
n_antikrisztus = MkHu "antikrisztus" "antikrisztus" ObjectRole Additive 0 12
public export n_antikva2rius : HuWord
n_antikva2rius = MkHu "antikvárius" "antikvárius" ObjectRole Additive 0 11
public export n_antilop : HuWord
n_antilop = MkHu "antilop" "antilop" ObjectRole Additive 0 7
public export n_antimilitarizmus : HuWord
n_antimilitarizmus = MkHu "antimilitarizmus" "antimilitarizmus" ObjectRole Additive 0 16
public export n_antiszemitizmus : HuWord
n_antiszemitizmus = MkHu "antiszemitizmus" "antiszemitizmus" ObjectRole Additive 0 15
public export n_antolo2gia : HuWord
n_antolo2gia = MkHu "antológia" "antológia" ObjectRole Additive 0 9
public export n_antonimia : HuWord
n_antonimia = MkHu "antonimia" "antonimia" ObjectRole Additive 0 9
public export n_antracit : HuWord
n_antracit = MkHu "antracit" "antraci" ObjectRole Multiplicative 2 8
public export n_anya : HuWord
n_anya = MkHu "anya" "anya" ObjectRole Additive 0 4
public export n_anyag : HuWord
n_anyag = MkHu "anyag" "anyag" ObjectRole Additive 0 5
public export n_anyasa2g : HuWord
n_anyasa2g = MkHu "anyaság" "anyaság" ObjectRole Additive 0 7
public export n_anya2cska : HuWord
n_anya2cska = MkHu "anyácska" "anyácska" ObjectRole Additive 0 8
public export n_anya2masszonykatona2ja : HuWord
n_anya2masszonykatona2ja = MkHu "anyámasszonykatonája" "anyámasszonykato" ObjectRole Additive 56 20
public export n_anyo2s : HuWord
n_anyo2s = MkHu "anyós" "anyós" ObjectRole Additive 0 5
public export n_ano2diza2la2s : HuWord
n_ano2diza2la2s = MkHu "anódizálás" "anódizálás" ObjectRole Additive 0 10
public export n_apa : HuWord
n_apa = MkHu "apa" "apa" ObjectRole Additive 0 3
public export n_apartheid : HuWord
n_apartheid = MkHu "apartheid" "apartheid" ObjectRole Multiplicative 0 9
public export n_appata2rus : HuWord
n_appata2rus = MkHu "appatárus" "appatárus" ObjectRole Additive 0 9
public export n_apro2fa : HuWord
n_apro2fa = MkHu "aprófa" "aprófa" ObjectRole Additive 0 6
public export n_apro2le2kosan : HuWord
n_apro2le2kosan = MkHu "aprólékosan" "aprólékosa" ObjectRole Additive 1 11
public export n_apa2cska : HuWord
n_apa2cska = MkHu "apácska" "apácska" ObjectRole Additive 0 7
public export n_apo2 : HuWord
n_apo2 = MkHu "apó" "apó" ObjectRole Additive 0 3
public export n_apo2s : HuWord
n_apo2s = MkHu "após" "após" ObjectRole Additive 0 4
public export n_arab : HuWord
n_arab = MkHu "arab" "arab" ObjectRole Additive 0 4
public export n_arany : HuWord
n_arany = MkHu "arany" "arany" ObjectRole Additive 0 5
public export n_aranyro3g : HuWord
n_aranyro3g = MkHu "aranyrög" "aranyrög" ObjectRole Multiplicative 0 8
public export n_arattata2s : HuWord
n_arattata2s = MkHu "arattatás" "arattatás" ObjectRole Additive 0 9
public export n_arattato2 : HuWord
n_arattato2 = MkHu "arattató" "arattató" ObjectRole Additive 0 8
public export n_arata2s : HuWord
n_arata2s = MkHu "aratás" "aratás" ObjectRole Additive 0 6
public export n_arato2 : HuWord
n_arato2 = MkHu "arató" "arató" ObjectRole Additive 0 5
public export n_arc : HuWord
n_arc = MkHu "arc" "arc" ObjectRole Additive 0 3
public export n_archaizmus : HuWord
n_archaizmus = MkHu "archaizmus" "archaizmus" ObjectRole Additive 0 10
public export n_archeikum : HuWord
n_archeikum = MkHu "archeikum" "archeikum" ObjectRole Additive 0 9
public export n_arcto3rlo4kendo4 : HuWord
n_arcto3rlo4kendo4 = MkHu "arctörlőkendő" "arctörlőkendő" ObjectRole Multiplicative 0 13
public export n_arisztokrata : HuWord
n_arisztokrata = MkHu "arisztokrata" "arisztokrata" ObjectRole Additive 0 12
public export n_arithmome2ter : HuWord
n_arithmome2ter = MkHu "arithmométer" "arithmométer" ObjectRole Multiplicative 0 12
public export n_aritmetika : HuWord
n_aritmetika = MkHu "aritmetika" "aritmetika" ObjectRole Additive 0 10
public export n_arsiztokra2cia : HuWord
n_arsiztokra2cia = MkHu "arsiztokrácia" "arsiztokrácia" ObjectRole Additive 0 13
public export n_arte2ria : HuWord
n_arte2ria = MkHu "artéria" "artéria" ObjectRole Additive 0 7
public export n_are2na : HuWord
n_are2na = MkHu "aréna" "aréna" ObjectRole Additive 0 5
public export n_aspirantu2ra : HuWord
n_aspirantu2ra = MkHu "aspirantúra" "aspirantú" ObjectRole Additive 1 11
public export n_aspira2ns : HuWord
n_aspira2ns = MkHu "aspiráns" "aspiráns" ObjectRole Additive 0 8
public export n_asszimila2cio2 : HuWord
n_asszimila2cio2 = MkHu "asszimiláció" "asszimiláció" ObjectRole Additive 0 12
public export n_asszisztens : HuWord
n_asszisztens = MkHu "asszisztens" "asszisztens" ObjectRole Multiplicative 0 11
public export n_aszfalt : HuWord
n_aszfalt = MkHu "aszfalt" "aszfal" ObjectRole Additive 2 7
public export n_aszfaltoza2s : HuWord
n_aszfaltoza2s = MkHu "aszfaltozás" "aszfaltozás" ObjectRole Additive 0 11
public export n_aszpirin : HuWord
n_aszpirin = MkHu "aszpirin" "aszpiri" ObjectRole Multiplicative 1 8
public export n_aszteroida2k : HuWord
n_aszteroida2k = MkHu "aszteroidák" "aszteroidá" ObjectRole Additive 4 11
public export n_asztrolo2gia : HuWord
n_asztrolo2gia = MkHu "asztrológia" "asztrológia" ObjectRole Additive 0 11
public export n_asztrolo2gus : HuWord
n_asztrolo2gus = MkHu "asztrológus" "asztrológus" ObjectRole Additive 0 11
public export n_asztrono2mia : HuWord
n_asztrono2mia = MkHu "asztronómia" "asztronómia" ObjectRole Additive 0 11
public export n_asztrono2mus : HuWord
n_asztrono2mus = MkHu "asztronómus" "asztronómus" ObjectRole Additive 0 11
public export n_atama2n : HuWord
n_atama2n = MkHu "atamán" "atamá" ObjectRole Additive 1 6
public export n_atlasz : HuWord
n_atlasz = MkHu "atlasz" "atlasz" ObjectRole Additive 0 6
public export n_atle2tika : HuWord
n_atle2tika = MkHu "atlétika" "atlétika" ObjectRole Additive 0 8
public export n_atmoszfe2ra : HuWord
n_atmoszfe2ra = MkHu "atmoszféra" "atmoszfé" ObjectRole Multiplicative 1 10
public export n_atom : HuWord
n_atom = MkHu "atom" "atom" ObjectRole Additive 0 4
public export n_atomgerjeszte2s : HuWord
n_atomgerjeszte2s = MkHu "atomgerjesztés" "atomgerjesztés" ObjectRole Multiplicative 0 14
public export n_atommag : HuWord
n_atommag = MkHu "atommag" "atommag" ObjectRole Additive 0 7
public export n_atommeghajta2su2 : HuWord
n_atommeghajta2su2 = MkHu "atommeghajtású" "atommeghajtású" ObjectRole Additive 0 14
public export n_attase2 : HuWord
n_attase2 = MkHu "attasé" "attasé" ObjectRole Multiplicative 0 6
public export n_augusztus : HuWord
n_augusztus = MkHu "augusztus" "augusztus" ObjectRole Additive 0 9
public export n_aul : HuWord
n_aul = MkHu "aul" "aul" ObjectRole Additive 0 3
public export n_autogram : HuWord
n_autogram = MkHu "autogram" "autogram" ObjectRole Additive 0 8
public export n_automatiza2la2s : HuWord
n_automatiza2la2s = MkHu "automatizálás" "automatizálás" ObjectRole Additive 0 13
public export n_autono2mia : HuWord
n_autono2mia = MkHu "autonómia" "autonómia" ObjectRole Additive 0 9
public export n_autorita2s : HuWord
n_autorita2s = MkHu "autoritás" "autoritás" ObjectRole Additive 0 9
public export n_auto2 : HuWord
n_auto2 = MkHu "autó" "autó" ObjectRole Additive 0 4
public export n_auto2busz : HuWord
n_auto2busz = MkHu "autóbusz" "autóbusz" ObjectRole Additive 0 8
public export n_auto2daru : HuWord
n_auto2daru = MkHu "autódaru" "autódaru" ObjectRole Additive 0 8
public export n_auto2gya2r : HuWord
n_auto2gya2r = MkHu "autógyár" "autógyár" ObjectRole Additive 0 8
public export n_auto2pa2lya : HuWord
n_auto2pa2lya = MkHu "autópálya" "autópálya" ObjectRole Additive 0 9
public export n_auto2u2t : HuWord
n_auto2u2t = MkHu "autóút" "autóú" ObjectRole Additive 2 6
public export n_avantga2rd : HuWord
n_avantga2rd = MkHu "avantgárd" "avantgárd" ObjectRole Additive 0 9
public export n_avia2tor : HuWord
n_avia2tor = MkHu "aviátor" "aviátor" ObjectRole Additive 0 7
public export n_azbeszt : HuWord
n_azbeszt = MkHu "azbeszt" "azbesz" ObjectRole Multiplicative 2 7
public export n_azimut : HuWord
n_azimut = MkHu "azimut" "azimu" ObjectRole Additive 2 6
public export n_azonalita2s : HuWord
n_azonalita2s = MkHu "azonalitás" "azonalitás" ObjectRole Additive 0 10
public export n_azonnal : HuWord
n_azonnal = MkHu "azonnal" "azonnal" ObjectRole Additive 0 7
public export n_azta2n : HuWord
n_azta2n = MkHu "aztán" "aztá" ObjectRole Additive 1 5
public export n_bab : HuWord
n_bab = MkHu "bab" "bab" ObjectRole Additive 0 3
public export n_babe2rro2zsa : HuWord
n_babe2rro2zsa = MkHu "babérrózsa" "babérrózsa" ObjectRole Additive 0 10
public export n_bacilus : HuWord
n_bacilus = MkHu "bacilus" "bacilus" ObjectRole Additive 0 7
public export n_bagoly : HuWord
n_bagoly = MkHu "bagoly" "bagoly" ObjectRole Additive 0 6
public export n_baj : HuWord
n_baj = MkHu "baj" "baj" ObjectRole Additive 0 3
public export n_balalajka : HuWord
n_balalajka = MkHu "balalajka" "balalajka" ObjectRole Additive 0 9
public export n_balansz : HuWord
n_balansz = MkHu "balansz" "balansz" ObjectRole Additive 0 7
public export n_balerina : HuWord
n_balerina = MkHu "balerina" "balerina" ObjectRole Additive 0 8
public export n_baleset : HuWord
n_baleset = MkHu "baleset" "bales" ObjectRole Multiplicative 2 7
public export n_balett : HuWord
n_balett = MkHu "balett" "bale" ObjectRole Multiplicative 8 6
public export n_balettmester : HuWord
n_balettmester = MkHu "balettmester" "balettmester" ObjectRole Multiplicative 0 12
public export n_balezino2iak : HuWord
n_balezino2iak = MkHu "balezinóiak" "balezinói" ObjectRole Multiplicative 4 11
public export n_balfa2ca2n : HuWord
n_balfa2ca2n = MkHu "balfácán" "balfácá" ObjectRole Additive 1 8
public export n_balkon : HuWord
n_balkon = MkHu "balkon" "bal" ObjectRole Additive 5 6
public export n_balka2r : HuWord
n_balka2r = MkHu "balkár" "balkár" ObjectRole Additive 0 6
public export n_ballada : HuWord
n_ballada = MkHu "ballada" "ballada" ObjectRole Additive 0 7
public export n_ballaszt : HuWord
n_ballaszt = MkHu "ballaszt" "ballasz" ObjectRole Additive 2 8
public export n_balliszitika : HuWord
n_balliszitika = MkHu "balliszitika" "balliszitika" ObjectRole Additive 0 12
public export n_ballon : HuWord
n_ballon = MkHu "ballon" "ball" ObjectRole Additive 1 6
public export n_balzsam : HuWord
n_balzsam = MkHu "balzsam" "balzsam" ObjectRole Additive 0 7
public export n_bambusz : HuWord
n_bambusz = MkHu "bambusz" "bambusz" ObjectRole Additive 0 7
public export n_banda : HuWord
n_banda = MkHu "banda" "banda" ObjectRole Additive 0 5
public export n_bandita : HuWord
n_bandita = MkHu "bandita" "bandita" ObjectRole Additive 0 7
public export n_bandura : HuWord
n_bandura = MkHu "bandura" "bandu" ObjectRole Additive 1 7
public export n_bandurka : HuWord
n_bandurka = MkHu "bandurka" "bandurka" ObjectRole Additive 0 8
public export n_bank : HuWord
n_bank = MkHu "bank" "ban" ObjectRole Additive 4 4
public export n_bankett : HuWord
n_bankett = MkHu "bankett" "banke" ObjectRole Multiplicative 8 7
public export n_banka2r : HuWord
n_banka2r = MkHu "bankár" "bankár" ObjectRole Additive 0 6
public export n_bana2n : HuWord
n_bana2n = MkHu "banán" "baná" ObjectRole Additive 1 5
public export n_baobab : HuWord
n_baobab = MkHu "baobab" "baobab" ObjectRole Additive 0 6
public export n_barack : HuWord
n_barack = MkHu "barack" "barac" ObjectRole Additive 4 6
public export n_barackfa : HuWord
n_barackfa = MkHu "barackfa" "barackfa" ObjectRole Additive 0 8
public export n_barakk : HuWord
n_barakk = MkHu "barakk" "barak" ObjectRole Additive 4 6
public export n_baretsapka : HuWord
n_baretsapka = MkHu "baretsapka" "baretsapka" ObjectRole Additive 0 10
public export n_bariton : HuWord
n_bariton = MkHu "bariton" "bari" ObjectRole Multiplicative 3 7
public export n_barko2 : HuWord
n_barko2 = MkHu "barkó" "barkó" ObjectRole Additive 0 5
public export n_barokk : HuWord
n_barokk = MkHu "barokk" "barok" ObjectRole Additive 4 6
public export n_barome2ter : HuWord
n_barome2ter = MkHu "barométer" "barométer" ObjectRole Multiplicative 0 9
public export n_barrika2d : HuWord
n_barrika2d = MkHu "barrikád" "barrikád" ObjectRole Additive 0 8
public export n_bara2t : HuWord
n_bara2t = MkHu "barát" "bará" ObjectRole Additive 2 5
public export n_bara2tno4 : HuWord
n_bara2tno4 = MkHu "barátnő" "barátnő" ObjectRole Multiplicative 0 7
public export n_bara2zda : HuWord
n_bara2zda = MkHu "barázda" "barázda" ObjectRole Additive 0 7
public export n_bara2zda2la2s : HuWord
n_bara2zda2la2s = MkHu "barázdálás" "barázdálás" ObjectRole Additive 0 10
public export n_basszus : HuWord
n_basszus = MkHu "basszus" "basszus" ObjectRole Additive 0 7
public export n_batiszt : HuWord
n_batiszt = MkHu "batiszt" "batisz" ObjectRole Multiplicative 2 7
public export n_bauxit : HuWord
n_bauxit = MkHu "bauxit" "bauxi" ObjectRole Multiplicative 2 6
public export n_bazalt : HuWord
n_bazalt = MkHu "bazalt" "bazal" ObjectRole Additive 2 6
public export n_becsapa2s : HuWord
n_becsapa2s = MkHu "becsapás" "becsapás" ObjectRole Additive 0 8
public export n_becsavaroda2s : HuWord
n_becsavaroda2s = MkHu "becsavarodás" "becsavarodás" ObjectRole Additive 0 12
public export n_becsavartata2s : HuWord
n_becsavartata2s = MkHu "becsavartatás" "becsavartatás" ObjectRole Additive 0 13
public export n_becsavara2s : HuWord
n_becsavara2s = MkHu "becsavarás" "becsavarás" ObjectRole Additive 0 10
public export n_becsu3let : HuWord
n_becsu3let = MkHu "becsület" "becsül" ObjectRole Multiplicative 2 8
public export n_beezu3sto3ztete2s : HuWord
n_beezu3sto3ztete2s = MkHu "beezüstöztetés" "beezüstöztetés" ObjectRole Multiplicative 0 14
public export n_beezu3sto3zo4de2s : HuWord
n_beezu3sto3zo4de2s = MkHu "beezüstöződés" "beezüstöződés" ObjectRole Multiplicative 0 13
public export n_befejezetlense2g : HuWord
n_befejezetlense2g = MkHu "befejezetlenség" "befejezetlenség" ObjectRole Multiplicative 0 15
public export n_befejeztete2s : HuWord
n_befejeztete2s = MkHu "befejeztetés" "befejeztetés" ObjectRole Multiplicative 0 12
public export n_befejeze2s : HuWord
n_befejeze2s = MkHu "befejezés" "befejezés" ObjectRole Multiplicative 0 9
public export n_befejezo4de2s : HuWord
n_befejezo4de2s = MkHu "befejeződés" "befejeződés" ObjectRole Multiplicative 0 11
public export n_befeste2s : HuWord
n_befeste2s = MkHu "befestés" "befestés" ObjectRole Multiplicative 0 8
public export n_befo4ttesu3veg : HuWord
n_befo4ttesu3veg = MkHu "befőttesüveg" "befőttesüveg" ObjectRole Multiplicative 0 12
public export n_begombolkoza2s : HuWord
n_begombolkoza2s = MkHu "begombolkozás" "begombolkozás" ObjectRole Additive 0 13
public export n_begomboltata2s : HuWord
n_begomboltata2s = MkHu "begomboltatás" "begomboltatás" ObjectRole Additive 0 13
public export n_begombola2s : HuWord
n_begombola2s = MkHu "begombolás" "begombolás" ObjectRole Additive 0 10
public export n_begyullaszta2s : HuWord
n_begyullaszta2s = MkHu "begyullasztás" "begyullasztás" ObjectRole Additive 0 13
public export n_begyu2jta2s : HuWord
n_begyu2jta2s = MkHu "begyújtás" "begyújtás" ObjectRole Additive 0 9
public export n_begyu4jtete2s : HuWord
n_begyu4jtete2s = MkHu "begyűjtetés" "begyűjtetés" ObjectRole Multiplicative 0 11
public export n_begyu4jte2s : HuWord
n_begyu4jte2s = MkHu "begyűjtés" "begyűjtés" ObjectRole Multiplicative 0 9
public export n_bego2nia : HuWord
n_bego2nia = MkHu "begónia" "begónia" ObjectRole Additive 0 7
public export n_bego3ngyo3ltete2s : HuWord
n_bego3ngyo3ltete2s = MkHu "begöngyöltetés" "begöngyöltetés" ObjectRole Multiplicative 0 14
public export n_bego3ngyo3le2s : HuWord
n_bego3ngyo3le2s = MkHu "begöngyölés" "begöngyölés" ObjectRole Multiplicative 0 11
public export n_bego3ngyo3lo3de2s : HuWord
n_bego3ngyo3lo3de2s = MkHu "begöngyölödés" "begöngyölödés" ObjectRole Multiplicative 0 13
public export n_bejegesede2s : HuWord
n_bejegesede2s = MkHu "bejegesedés" "bejegesedés" ObjectRole Multiplicative 0 11
public export n_bekezde2s : HuWord
n_bekezde2s = MkHu "bekezdés" "bekezdés" ObjectRole Multiplicative 0 8
public export n_bekre2ta2zo2da2s : HuWord
n_bekre2ta2zo2da2s = MkHu "bekrétázódás" "bekrétázódás" ObjectRole Additive 0 12
public export n_bekte2rium : HuWord
n_bekte2rium = MkHu "bektérium" "bektérium" ObjectRole Additive 0 9
public export n_beko3ttete2s : HuWord
n_beko3ttete2s = MkHu "beköttetés" "beköttetés" ObjectRole Multiplicative 0 10
public export n_beko3te2s : HuWord
n_beko3te2s = MkHu "bekötés" "bekötés" ObjectRole Multiplicative 0 7
public export n_beko3to3ztete2s : HuWord
n_beko3to3ztete2s = MkHu "bekötöztetés" "bekötöztetés" ObjectRole Multiplicative 0 12
public export n_beko3to3ze2s : HuWord
n_beko3to3ze2s = MkHu "bekötözés" "bekötözés" ObjectRole Multiplicative 0 9
public export n_beleuna2s : HuWord
n_beleuna2s = MkHu "beleunás" "beleunás" ObjectRole Additive 0 8
public export n_bele2po4jegy : HuWord
n_bele2po4jegy = MkHu "belépőjegy" "belépőjegy" ObjectRole Multiplicative 0 10
public export n_bemutata2s : HuWord
n_bemutata2s = MkHu "bemutatás" "bemutatás" ObjectRole Additive 0 9
public export n_bemutato2 : HuWord
n_bemutato2 = MkHu "bemutató" "bemutató" ObjectRole Additive 0 8
public export n_bennszu3lo3tt : HuWord
n_bennszu3lo3tt = MkHu "bennszülött" "bennszülö" ObjectRole Multiplicative 8 11
public export n_benzin : HuWord
n_benzin = MkHu "benzin" "benzi" ObjectRole Multiplicative 1 6
public export n_benzinku2t : HuWord
n_benzinku2t = MkHu "benzinkút" "benzinkú" ObjectRole Additive 2 9
public export n_benzintarta2ly : HuWord
n_benzintarta2ly = MkHu "benzintartály" "benzintartály" ObjectRole Additive 0 13
public export n_beno4ttse2g : HuWord
n_beno4ttse2g = MkHu "benőttség" "benőttség" ObjectRole Multiplicative 0 9
public export n_bepelenka2ztata2s : HuWord
n_bepelenka2ztata2s = MkHu "bepelenkáztatás" "bepelenkáztatás" ObjectRole Additive 0 15
public export n_bepelenka2za2s : HuWord
n_bepelenka2za2s = MkHu "bepelenkázás" "bepelenkázás" ObjectRole Additive 0 12
public export n_bepiszkolo2da2s : HuWord
n_bepiszkolo2da2s = MkHu "bepiszkolódás" "bepiszkolódás" ObjectRole Additive 0 13
public export n_bepa2ra2soda2s : HuWord
n_bepa2ra2soda2s = MkHu "bepárásodás" "bepárásodás" ObjectRole Additive 0 11
public export n_berek : HuWord
n_berek = MkHu "berek" "ber" ObjectRole Multiplicative 4 5
public export n_bereteszele2s : HuWord
n_bereteszele2s = MkHu "bereteszelés" "bereteszelés" ObjectRole Multiplicative 0 12
public export n_bereteszelo4de2s : HuWord
n_bereteszelo4de2s = MkHu "bereteszelődés" "bereteszelődés" ObjectRole Multiplicative 0 14
public export n_besmet : HuWord
n_besmet = MkHu "besmet" "besm" ObjectRole Multiplicative 2 6
public export n_besugo2 : HuWord
n_besugo2 = MkHu "besugó" "besugó" ObjectRole Additive 0 6
public export n_besze2d : HuWord
n_besze2d = MkHu "beszéd" "beszéd" ObjectRole Multiplicative 0 6
public export n_besze2des : HuWord
n_besze2des = MkHu "beszédes" "beszédes" ObjectRole Multiplicative 0 8
public export n_beton : HuWord
n_beton = MkHu "beton" "bet" ObjectRole Multiplicative 1 5
public export n_betu4 : HuWord
n_betu4 = MkHu "betű" "betű" ObjectRole Multiplicative 0 4
public export n_beva2sa2rla2s : HuWord
n_beva2sa2rla2s = MkHu "bevásárlás" "bevásárlás" ObjectRole Additive 0 10
public export n_beva2sa2rlo2 : HuWord
n_beva2sa2rlo2 = MkHu "bevásárló" "bevásárló" ObjectRole Additive 0 9
public export n_beve2geztete2s : HuWord
n_beve2geztete2s = MkHu "bevégeztetés" "bevégeztetés" ObjectRole Multiplicative 0 12
public export n_beza2ra2s : HuWord
n_beza2ra2s = MkHu "bezárás" "bezárás" ObjectRole Additive 0 7
public export n_beza2ro2da2s : HuWord
n_beza2ro2da2s = MkHu "bezáródás" "bezáródás" ObjectRole Additive 0 9
public export n_biblia : HuWord
n_biblia = MkHu "biblia" "biblia" ObjectRole Additive 0 6
public export n_bifsztek : HuWord
n_bifsztek = MkHu "bifsztek" "bifsz" ObjectRole Multiplicative 6 8
public export n_bilina : HuWord
n_bilina = MkHu "bilina" "bilina" ObjectRole Additive 0 6
public export n_bilincs : HuWord
n_bilincs = MkHu "bilincs" "bilincs" ObjectRole Multiplicative 0 7
public export n_bilia2rd : HuWord
n_bilia2rd = MkHu "biliárd" "biliárd" ObjectRole Additive 0 7
public export n_billegtete2s : HuWord
n_billegtete2s = MkHu "billegtetés" "billegtetés" ObjectRole Multiplicative 0 11
public export n_billege2s : HuWord
n_billege2s = MkHu "billegés" "billegés" ObjectRole Multiplicative 0 8
public export n_bina2ris : HuWord
n_bina2ris = MkHu "bináris" "bináris" ObjectRole Multiplicative 0 7
public export n_biofozoka : HuWord
n_biofozoka = MkHu "biofozoka" "biofozoka" ObjectRole Additive 0 9
public export n_biogeogra2fia : HuWord
n_biogeogra2fia = MkHu "biogeográfia" "biogeográfia" ObjectRole Additive 0 12
public export n_bioke2mia : HuWord
n_bioke2mia = MkHu "biokémia" "biokémia" ObjectRole Additive 0 8
public export n_biolumineszcencia : HuWord
n_biolumineszcencia = MkHu "biolumineszcencia" "biolumineszcencia" ObjectRole Additive 0 17
public export n_biolo2gia : HuWord
n_biolo2gia = MkHu "biológia" "biológia" ObjectRole Additive 0 8
public export n_biolo2gus : HuWord
n_biolo2gus = MkHu "biológus" "biológus" ObjectRole Additive 0 8
public export n_bioszfe2ra : HuWord
n_bioszfe2ra = MkHu "bioszféra" "bioszfé" ObjectRole Multiplicative 1 9
public export n_birka : HuWord
n_birka = MkHu "birka" "birka" ObjectRole Additive 0 5
public export n_birsalma : HuWord
n_birsalma = MkHu "birsalma" "birsalma" ObjectRole Additive 0 8
public export n_birsalmafa : HuWord
n_birsalmafa = MkHu "birsalmafa" "birsalmafa" ObjectRole Additive 0 10
public export n_birtokla2s : HuWord
n_birtokla2s = MkHu "birtoklás" "birtoklás" ObjectRole Additive 0 9
public export n_bitumen : HuWord
n_bitumen = MkHu "bitumen" "bitum" ObjectRole Additive 1 7
public export n_bivaly : HuWord
n_bivaly = MkHu "bivaly" "bivaly" ObjectRole Additive 0 6
public export n_bizonyi2t : HuWord
n_bizonyi2t = MkHu "bizonyít" "bizonyí" ObjectRole Multiplicative 2 8
public export n_bizonyi2tva2ny : HuWord
n_bizonyi2tva2ny = MkHu "bizonyítvány" "bizonyítvány" ObjectRole Additive 0 12
public export n_bizonyi2te2k : HuWord
n_bizonyi2te2k = MkHu "bizonyíték" "bizonyíté" ObjectRole Multiplicative 4 10
public export n_biztonsa2g : HuWord
n_biztonsa2g = MkHu "biztonság" "biztonság" ObjectRole Additive 0 9
public export n_blokk : HuWord
n_blokk = MkHu "blokk" "blok" ObjectRole Additive 4 5
public export n_bloka2d : HuWord
n_bloka2d = MkHu "blokád" "blokád" ObjectRole Additive 0 6
public export n_blu2z : HuWord
n_blu2z = MkHu "blúz" "blúz" ObjectRole Additive 0 4
public export n_bodorodott : HuWord
n_bodorodott = MkHu "bodorodott" "bodorodo" ObjectRole Additive 8 10
public export n_bodori2tott : HuWord
n_bodori2tott = MkHu "bodorított" "bodoríto" ObjectRole Additive 8 10
public export n_bodori2ta2s : HuWord
n_bodori2ta2s = MkHu "bodorítás" "bodorítás" ObjectRole Additive 0 9
public export n_bodori2to2 : HuWord
n_bodori2to2 = MkHu "bodorító" "bodorító" ObjectRole Additive 0 8
public export n_bogjaiak : HuWord
n_bogjaiak = MkHu "bogjaiak" "bogjai" ObjectRole Multiplicative 4 8
public export n_bogla2rka : HuWord
n_bogla2rka = MkHu "boglárka" "boglárka" ObjectRole Additive 0 8
public export n_bogna2r : HuWord
n_bogna2r = MkHu "bognár" "bognár" ObjectRole Additive 0 6
public export n_boga2ncs : HuWord
n_boga2ncs = MkHu "bogáncs" "bogáncs" ObjectRole Additive 0 7
public export n_boga2ncsfej : HuWord
n_boga2ncsfej = MkHu "bogáncsfej" "bogáncsfe" ObjectRole Multiplicative 16 10
public export n_boga2r : HuWord
n_boga2r = MkHu "bogár" "bogár" ObjectRole Additive 0 5
public export n_bojkott : HuWord
n_bojkott = MkHu "bojkott" "bojko" ObjectRole Additive 8 7
public export n_bojkotta2la2s : HuWord
n_bojkotta2la2s = MkHu "bojkottálás" "bojkottálás" ObjectRole Additive 0 11
public export n_bojtorja2n : HuWord
n_bojtorja2n = MkHu "bojtorján" "bojtorjá" ObjectRole Additive 1 9
public export n_boja2r : HuWord
n_boja2r = MkHu "bojár" "bojár" ObjectRole Additive 0 5
public export n_boka : HuWord
n_boka = MkHu "boka" "boka" ObjectRole Additive 0 4
public export n_bokacsont : HuWord
n_bokacsont = MkHu "bokacsont" "bokacso" ObjectRole Additive 3 9
public export n_boksz : HuWord
n_boksz = MkHu "boksz" "boksz" ObjectRole Additive 0 5
public export n_bokszola2s : HuWord
n_bokszola2s = MkHu "bokszolás" "bokszolás" ObjectRole Additive 0 9
public export n_bokszolo2 : HuWord
n_bokszolo2 = MkHu "bokszoló" "bokszoló" ObjectRole Additive 0 8
public export n_bolond : HuWord
n_bolond = MkHu "bolond" "bolond" ObjectRole Additive 0 6
public export n_bolsevik : HuWord
n_bolsevik = MkHu "bolsevik" "bolsevi" ObjectRole Multiplicative 4 8
public export n_bolsevizmus : HuWord
n_bolsevizmus = MkHu "bolsevizmus" "bolsevizmus" ObjectRole Additive 0 11
public export n_boltozat : HuWord
n_boltozat = MkHu "boltozat" "boltoz" ObjectRole Additive 2 8
public export n_bomba : HuWord
n_bomba = MkHu "bomba" "bom" ObjectRole Additive 1 5
public export n_bombata2mada2s : HuWord
n_bombata2mada2s = MkHu "bombatámadás" "bombatámadás" ObjectRole Additive 0 12
public export n_bomba2za2s : HuWord
n_bomba2za2s = MkHu "bombázás" "bombázás" ObjectRole Additive 0 8
public export n_bor : HuWord
n_bor = MkHu "bor" "bor" ObjectRole Additive 0 3
public export n_borbolya : HuWord
n_borbolya = MkHu "borbolya" "borbolya" ObjectRole Additive 0 8
public export n_borbolyabokor : HuWord
n_borbolyabokor = MkHu "borbolyabokor" "borbolyabokor" ObjectRole Additive 0 13
public export n_borba2lafu4 : HuWord
n_borba2lafu4 = MkHu "borbálafű" "borbálafű" ObjectRole Multiplicative 0 9
public export n_bordu3r : HuWord
n_bordu3r = MkHu "bordür" "bordür" ObjectRole Multiplicative 0 6
public export n_borosto3mlo4 : HuWord
n_borosto3mlo4 = MkHu "borostömlő" "borostömlő" ObjectRole Multiplicative 0 10
public export n_borotva : HuWord
n_borotva = MkHu "borotva" "borotva" ObjectRole Additive 0 7
public export n_borotva2lkoza2s : HuWord
n_borotva2lkoza2s = MkHu "borotválkozás" "borotválkozás" ObjectRole Additive 0 13
public export n_borscs : HuWord
n_borscs = MkHu "borscs" "borscs" ObjectRole Additive 0 6
public export n_borula2s : HuWord
n_borula2s = MkHu "borulás" "borulás" ObjectRole Additive 0 7
public export n_borz : HuWord
n_borz = MkHu "borz" "borz" ObjectRole Additive 0 4
public export n_borzko3lyo3k : HuWord
n_borzko3lyo3k = MkHu "borzkölyök" "borzköly" ObjectRole Multiplicative 4 10
public export n_bosszu2 : HuWord
n_bosszu2 = MkHu "bosszú" "bosszú" ObjectRole Additive 0 6
public export n_boszorka2ny : HuWord
n_boszorka2ny = MkHu "boszorkány" "boszorkány" ObjectRole Additive 0 10
public export n_bot : HuWord
n_bot = MkHu "bot" "bot" ObjectRole Additive 0 3
public export n_botanika : HuWord
n_botanika = MkHu "botanika" "botanika" ObjectRole Additive 0 8
public export n_botoza2s : HuWord
n_botoza2s = MkHu "botozás" "botozás" ObjectRole Additive 0 7
public export n_botra2ny : HuWord
n_botra2ny = MkHu "botrány" "botrány" ObjectRole Additive 0 7
public export n_bravo2 : HuWord
n_bravo2 = MkHu "bravó" "bravó" ObjectRole Additive 0 5
public export n_briga2d : HuWord
n_briga2d = MkHu "brigád" "brigád" ObjectRole Additive 0 6
public export n_briga2dvezeto4 : HuWord
n_briga2dvezeto4 = MkHu "brigádvezető" "brigádvezető" ObjectRole Multiplicative 0 12
public export n_brikett : HuWord
n_brikett = MkHu "brikett" "brike" ObjectRole Multiplicative 8 7
public export n_brilia2ns : HuWord
n_brilia2ns = MkHu "briliáns" "briliáns" ObjectRole Additive 0 8
public export n_brindza : HuWord
n_brindza = MkHu "brindza" "brindza" ObjectRole Additive 0 7
public export n_bronz : HuWord
n_bronz = MkHu "bronz" "bronz" ObjectRole Additive 0 5
public export n_bross : HuWord
n_bross = MkHu "bross" "bross" ObjectRole Additive 0 5
public export n_brosu2ra : HuWord
n_brosu2ra = MkHu "brosúra" "brosú" ObjectRole Additive 1 7
public export n_brucellosis : HuWord
n_brucellosis = MkHu "brucellosis" "brucellosis" ObjectRole Multiplicative 0 11
public export n_bro2m : HuWord
n_bro2m = MkHu "bróm" "bróm" ObjectRole Additive 0 4
public export n_budhizmus : HuWord
n_budhizmus = MkHu "budhizmus" "budhizmus" ObjectRole Additive 0 9
public export n_bugybore2kola2s : HuWord
n_bugybore2kola2s = MkHu "bugyborékolás" "bugyborékolás" ObjectRole Additive 0 13
public export n_bujasa2g : HuWord
n_bujasa2g = MkHu "bujaság" "bujaság" ObjectRole Additive 0 7
public export n_bujdosa2s : HuWord
n_bujdosa2s = MkHu "bujdosás" "bujdosás" ObjectRole Additive 0 8
public export n_buke2 : HuWord
n_buke2 = MkHu "buké" "buké" ObjectRole Multiplicative 0 4
public export n_buldo2zer : HuWord
n_buldo2zer = MkHu "buldózer" "buldózer" ObjectRole Multiplicative 0 8
public export n_bulldog : HuWord
n_bulldog = MkHu "bulldog" "bulldog" ObjectRole Additive 0 7
public export n_bumerang : HuWord
n_bumerang = MkHu "bumerang" "bumerang" ObjectRole Additive 0 8
public export n_bunker : HuWord
n_bunker = MkHu "bunker" "bunker" ObjectRole Multiplicative 0 6
public export n_burgonya : HuWord
n_burgonya = MkHu "burgonya" "burgonya" ObjectRole Additive 0 8
public export n_burgonyaboga2r : HuWord
n_burgonyaboga2r = MkHu "burgonyabogár" "burgonyabogár" ObjectRole Additive 0 13
public export n_burka : HuWord
n_burka = MkHu "burka" "burka" ObjectRole Additive 0 5
public export n_burzsoa2zia : HuWord
n_burzsoa2zia = MkHu "burzsoázia" "burzsoázia" ObjectRole Additive 0 10
public export n_burzsuj : HuWord
n_burzsuj = MkHu "burzsuj" "burzsu" ObjectRole Additive 16 7
public export n_bura2n : HuWord
n_bura2n = MkHu "burán" "burá" ObjectRole Additive 1 5
public export n_busz : HuWord
n_busz = MkHu "busz" "busz" ObjectRole Additive 0 4
public export n_buzdi2ta2s : HuWord
n_buzdi2ta2s = MkHu "buzdítás" "buzdítás" ObjectRole Additive 0 8
public export n_ba2ba : HuWord
n_ba2ba = MkHu "bába" "bába" ObjectRole Additive 0 4
public export n_ba2baasszony : HuWord
n_ba2baasszony = MkHu "bábaasszony" "bábaasszony" ObjectRole Additive 0 11
public export n_ba2csi : HuWord
n_ba2csi = MkHu "bácsi" "bácsi" ObjectRole Multiplicative 0 5
public export n_ba2gyadtsa2g : HuWord
n_ba2gyadtsa2g = MkHu "bágyadtság" "bágyadtság" ObjectRole Additive 0 10
public export n_ba2l : HuWord
n_ba2l = MkHu "bál" "bál" ObjectRole Additive 0 3
public export n_ba2rd : HuWord
n_ba2rd = MkHu "bárd" "bárd" ObjectRole Additive 0 4
public export n_ba2rium : HuWord
n_ba2rium = MkHu "bárium" "bárium" ObjectRole Additive 0 6
public export n_ba2rsony : HuWord
n_ba2rsony = MkHu "bársony" "bársony" ObjectRole Additive 0 7
public export n_ba2rsonyszalag : HuWord
n_ba2rsonyszalag = MkHu "bársonyszalag" "bársonyszalag" ObjectRole Additive 0 13
public export n_ba2ra2ny : HuWord
n_ba2ra2ny = MkHu "bárány" "bárány" ObjectRole Additive 0 6
public export n_ba2ro2 : HuWord
n_ba2ro2 = MkHu "báró" "báró" ObjectRole Additive 0 4
public export n_ba2stya : HuWord
n_ba2stya = MkHu "bástya" "bástya" ObjectRole Additive 0 6
public export n_ba2torsa2g : HuWord
n_ba2torsa2g = MkHu "bátorság" "bátorság" ObjectRole Additive 0 8
public export n_ba2ty : HuWord
n_ba2ty = MkHu "báty" "báty" ObjectRole Additive 0 4
public export n_ba2zis : HuWord
n_ba2zis = MkHu "bázis" "bázis" ObjectRole Multiplicative 0 5
public export n_be2ka : HuWord
n_be2ka = MkHu "béka" "béka" ObjectRole Additive 0 4
public export n_be2kapete : HuWord
n_be2kapete = MkHu "békapete" "békapete" ObjectRole Multiplicative 0 8
public export n_be2kaporonty : HuWord
n_be2kaporonty = MkHu "békaporonty" "békaporonty" ObjectRole Additive 0 11
public export n_be2klyo2lakat : HuWord
n_be2klyo2lakat = MkHu "béklyólakat" "béklyóla" ObjectRole Additive 6 11
public export n_be2ku3le2keny : HuWord
n_be2ku3le2keny = MkHu "békülékeny" "békülékeny" ObjectRole Multiplicative 0 10
public export n_be2les : HuWord
n_be2les = MkHu "béles" "béles" ObjectRole Multiplicative 0 5
public export n_be2na : HuWord
n_be2na = MkHu "béna" "béna" ObjectRole Additive 0 4
public export n_be2res : HuWord
n_be2res = MkHu "béres" "béres" ObjectRole Multiplicative 0 5
public export n_be2resasszony : HuWord
n_be2resasszony = MkHu "béresasszony" "béresasszony" ObjectRole Additive 0 12
public export n_be2rlet : HuWord
n_be2rlet = MkHu "bérlet" "bérl" ObjectRole Multiplicative 2 6
public export n_be2rletes : HuWord
n_be2rletes = MkHu "bérletes" "bérletes" ObjectRole Multiplicative 0 8
public export n_bi2zo2 : HuWord
n_bi2zo2 = MkHu "bízó" "bízó" ObjectRole Additive 0 4
public export n_bo2de2 : HuWord
n_bo2de2 = MkHu "bódé" "bódé" ObjectRole Multiplicative 0 4
public export n_bo2ja : HuWord
n_bo2ja = MkHu "bója" "bója" ObjectRole Additive 0 4
public export n_bo2r : HuWord
n_bo2r = MkHu "bór" "bór" ObjectRole Additive 0 3
public export n_bo2ra : HuWord
n_bo2ra = MkHu "bóra" "bóra" ObjectRole Additive 0 4
public export n_bo2rsav : HuWord
n_bo2rsav = MkHu "bórsav" "bórsav" ObjectRole Additive 0 6
public export n_bo3do3n : HuWord
n_bo3do3n = MkHu "bödön" "böd" ObjectRole Multiplicative 1 5
public export n_bo3lcso4 : HuWord
n_bo3lcso4 = MkHu "bölcső" "bölcső" ObjectRole Multiplicative 0 6
public export n_bo3le2ny : HuWord
n_bo3le2ny = MkHu "bölény" "bölény" ObjectRole Multiplicative 0 6
public export n_bo3rze : HuWord
n_bo3rze = MkHu "börze" "börze" ObjectRole Multiplicative 0 5
public export n_bu2csu2 : HuWord
n_bu2csu2 = MkHu "búcsú" "búcsú" ObjectRole Additive 0 5
public export n_bu2va2rpalack : HuWord
n_bu2va2rpalack = MkHu "búvárpalack" "búvárpalac" ObjectRole Additive 4 11
public export n_bu2zavira2g : HuWord
n_bu2zavira2g = MkHu "búzavirág" "búzavirág" ObjectRole Additive 0 9
public export n_bu3fe2 : HuWord
n_bu3fe2 = MkHu "büfé" "büfé" ObjectRole Multiplicative 0 4
public export n_bu3fe2s : HuWord
n_bu3fe2s = MkHu "büfés" "büfés" ObjectRole Multiplicative 0 5
public export n_bu3kkerdo4 : HuWord
n_bu3kkerdo4 = MkHu "bükkerdő" "bükkerdő" ObjectRole Multiplicative 0 8
public export n_bu3kkfa : HuWord
n_bu3kkfa = MkHu "bükkfa" "bükkfa" ObjectRole Additive 0 6
public export n_bu3szkese2g : HuWord
n_bu3szkese2g = MkHu "büszkeség" "büszkeség" ObjectRole Multiplicative 0 9
public export n_bu3szke2lkedett : HuWord
n_bu3szke2lkedett = MkHu "büszkélkedett" "büszkélkede" ObjectRole Multiplicative 8 13
public export n_bu3szke2lkede2s : HuWord
n_bu3szke2lkede2s = MkHu "büszkélkedés" "büszkélkedés" ObjectRole Multiplicative 0 12
public export n_bu3szke2lkedo4 : HuWord
n_bu3szke2lkedo4 = MkHu "büszkélkedő" "büszkélkedő" ObjectRole Multiplicative 0 11
public export n_bo4go4masina : HuWord
n_bo4go4masina = MkHu "bőgőmasina" "bőgőmasina" ObjectRole Additive 0 10
public export n_bo4se2g : HuWord
n_bo4se2g = MkHu "bőség" "bőség" ObjectRole Multiplicative 0 5
public export n_cefre : HuWord
n_cefre = MkHu "cefre" "cef" ObjectRole Multiplicative 1 5
public export n_cejgszo3vet : HuWord
n_cejgszo3vet = MkHu "cejgszövet" "cejgszöv" ObjectRole Multiplicative 2 10
public export n_cejgva2szon : HuWord
n_cejgva2szon = MkHu "cejgvászon" "cejgvász" ObjectRole Additive 1 10
public export n_cimke : HuWord
n_cimke = MkHu "cimke" "cimke" ObjectRole Multiplicative 0 5
public export n_cipo4 : HuWord
n_cipo4 = MkHu "cipő" "cipő" ObjectRole Multiplicative 0 4
public export n_csali : HuWord
n_csali = MkHu "csali" "csali" ObjectRole Multiplicative 0 5
public export n_csala2dfo4 : HuWord
n_csala2dfo4 = MkHu "családfő" "családfő" ObjectRole Multiplicative 0 8
public export n_csala2s : HuWord
n_csala2s = MkHu "csalás" "csalás" ObjectRole Additive 0 6
public export n_csale2tek : HuWord
n_csale2tek = MkHu "csalétek" "csalé" ObjectRole Multiplicative 6 8
public export n_csalo2 : HuWord
n_csalo2 = MkHu "csaló" "csaló" ObjectRole Additive 0 5
public export n_csapade2k : HuWord
n_csapade2k = MkHu "csapadék" "csapadé" ObjectRole Multiplicative 4 8
public export n_csapda : HuWord
n_csapda = MkHu "csapda" "csapda" ObjectRole Additive 0 6
public export n_csapszeg : HuWord
n_csapszeg = MkHu "csapszeg" "csapszeg" ObjectRole Multiplicative 0 8
public export n_csat : HuWord
n_csat = MkHu "csat" "csa" ObjectRole Additive 2 4
public export n_csata : HuWord
n_csata = MkHu "csata" "csata" ObjectRole Additive 0 5
public export n_csavar : HuWord
n_csavar = MkHu "csavar" "csavar" ObjectRole Additive 0 6
public export n_csavargo2 : HuWord
n_csavargo2 = MkHu "csavargó" "csavargó" ObjectRole Additive 0 8
public export n_csavaroda2s : HuWord
n_csavaroda2s = MkHu "csavarodás" "csavarodás" ObjectRole Additive 0 10
public export n_csavara2s : HuWord
n_csavara2s = MkHu "csavarás" "csavarás" ObjectRole Additive 0 8
public export n_csereboga2r : HuWord
n_csereboga2r = MkHu "cserebogár" "cserebogár" ObjectRole Additive 0 10
public export n_csibe2sz : HuWord
n_csibe2sz = MkHu "csibész" "csibész" ObjectRole Multiplicative 0 7
public export n_csiga : HuWord
n_csiga = MkHu "csiga" "csiga" ObjectRole Additive 0 5
public export n_csigaszerkezet : HuWord
n_csigaszerkezet = MkHu "csigaszerkezet" "csigaszerkez" ObjectRole Multiplicative 2 14
public export n_csiklandoztata2s : HuWord
n_csiklandoztata2s = MkHu "csiklandoztatás" "csiklandoztatás" ObjectRole Additive 0 15
public export n_csiklandoza2s : HuWord
n_csiklandoza2s = MkHu "csiklandozás" "csiklandozás" ObjectRole Additive 0 12
public export n_csiklandozo2 : HuWord
n_csiklandozo2 = MkHu "csiklandozó" "csiklandozó" ObjectRole Additive 0 11
public export n_csiklando2ssa2g : HuWord
n_csiklando2ssa2g = MkHu "csiklandósság" "csiklandósság" ObjectRole Additive 0 13
public export n_csillagjo2s : HuWord
n_csillagjo2s = MkHu "csillagjós" "csillagjós" ObjectRole Additive 0 10
public export n_csillagjo2sla2s : HuWord
n_csillagjo2sla2s = MkHu "csillagjóslás" "csillagjóslás" ObjectRole Additive 0 13
public export n_csillaga2sz : HuWord
n_csillaga2sz = MkHu "csillagász" "csillagász" ObjectRole Additive 0 10
public export n_csillaga2szat : HuWord
n_csillaga2szat = MkHu "csillagászat" "csillagász" ObjectRole Additive 2 12
public export n_csilloga2s : HuWord
n_csilloga2s = MkHu "csillogás" "csillogás" ObjectRole Additive 0 9
public export n_csintalan : HuWord
n_csintalan = MkHu "csintalan" "csintala" ObjectRole Additive 1 9
public export n_csintalankoda2s : HuWord
n_csintalankoda2s = MkHu "csintalankodás" "csintalankodás" ObjectRole Additive 0 14
public export n_csoda : HuWord
n_csoda = MkHu "csoda" "csoda" ObjectRole Additive 0 5
public export n_csoda2lat : HuWord
n_csoda2lat = MkHu "csodálat" "csodál" ObjectRole Additive 2 8
public export n_csoda2lkoza2s : HuWord
n_csoda2lkoza2s = MkHu "csodálkozás" "csodálkozás" ObjectRole Additive 0 11
public export n_csomag : HuWord
n_csomag = MkHu "csomag" "csomag" ObjectRole Additive 0 6
public export n_csomagola2s : HuWord
n_csomagola2s = MkHu "csomagolás" "csomagolás" ObjectRole Additive 0 10
public export n_csomagtarto2 : HuWord
n_csomagtarto2 = MkHu "csomagtartó" "csomagtartó" ObjectRole Additive 0 11
public export n_csomagte2r : HuWord
n_csomagte2r = MkHu "csomagtér" "csomagtér" ObjectRole Multiplicative 0 9
public export n_csoportvezeto4 : HuWord
n_csoportvezeto4 = MkHu "csoportvezető" "csoportvezető" ObjectRole Multiplicative 0 13
public export n_csa2klya : HuWord
n_csa2klya = MkHu "csáklya" "csáklya" ObjectRole Additive 0 7
public export n_cse2szealj : HuWord
n_cse2szealj = MkHu "csészealj" "csészeal" ObjectRole Additive 16 9
public export n_csi2k : HuWord
n_csi2k = MkHu "csík" "csí" ObjectRole Multiplicative 4 4
public export n_csi2ra2ztattata2s : HuWord
n_csi2ra2ztattata2s = MkHu "csíráztattatás" "csíráztattatás" ObjectRole Additive 0 14
public export n_csi2ra2ztata2s : HuWord
n_csi2ra2ztata2s = MkHu "csíráztatás" "csíráztatás" ObjectRole Additive 0 11
public export n_cso3rgo4dob : HuWord
n_cso3rgo4dob = MkHu "csörgődob" "csörgődob" ObjectRole Additive 0 9
public export n_cso3veshagyma : HuWord
n_cso3veshagyma = MkHu "csöveshagyma" "csöveshagyma" ObjectRole Additive 0 12
public export n_csu2nyasa2g : HuWord
n_csu2nyasa2g = MkHu "csúnyaság" "csúnyaság" ObjectRole Additive 0 9
public export n_csu3dcsont : HuWord
n_csu3dcsont = MkHu "csüdcsont" "csüdcso" ObjectRole Additive 3 9
public export n_csu3dcso3mo3r : HuWord
n_csu3dcso3mo3r = MkHu "csüdcsömör" "csüdcsömör" ObjectRole Multiplicative 0 10
public export n_cso4d : HuWord
n_cso4d = MkHu "csőd" "csőd" ObjectRole Multiplicative 0 4
public export n_cso4sz : HuWord
n_cso4sz = MkHu "csősz" "csősz" ObjectRole Multiplicative 0 5
public export n_ca2pa : HuWord
n_ca2pa = MkHu "cápa" "cápa" ObjectRole Additive 0 4
public export n_ce2l : HuWord
n_ce2l = MkHu "cél" "cél" ObjectRole Multiplicative 0 3
public export n_ce2lhata2rozo2 : HuWord
n_ce2lhata2rozo2 = MkHu "célhatározó" "célhatározó" ObjectRole Additive 0 11
public export n_ce2lpont : HuWord
n_ce2lpont = MkHu "célpont" "célpo" ObjectRole Additive 3 7
public export n_ce2lta2bla : HuWord
n_ce2lta2bla = MkHu "céltábla" "céltábla" ObjectRole Additive 0 8
public export n_ci2meztete2s : HuWord
n_ci2meztete2s = MkHu "címeztetés" "címeztetés" ObjectRole Multiplicative 0 10
public export n_ci2mzett : HuWord
n_ci2mzett = MkHu "címzett" "címze" ObjectRole Multiplicative 8 7
public export n_ci2mze2s : HuWord
n_ci2mze2s = MkHu "címzés" "címzés" ObjectRole Multiplicative 0 6
public export n_dadoga2s : HuWord
n_dadoga2s = MkHu "dadogás" "dadogás" ObjectRole Additive 0 7
public export n_dadogo2 : HuWord
n_dadogo2 = MkHu "dadogó" "dadogó" ObjectRole Additive 0 6
public export n_dagaszta2s : HuWord
n_dagaszta2s = MkHu "dagasztás" "dagasztás" ObjectRole Additive 0 9
public export n_dal : HuWord
n_dal = MkHu "dal" "dal" ObjectRole Additive 0 3
public export n_dalia : HuWord
n_dalia = MkHu "dalia" "dalia" ObjectRole Additive 0 5
public export n_danda2r : HuWord
n_danda2r = MkHu "dandár" "dandár" ObjectRole Additive 0 6
public export n_darab : HuWord
n_darab = MkHu "darab" "darab" ObjectRole Additive 0 5
public export n_deformita2s : HuWord
n_deformita2s = MkHu "deformitás" "deformitás" ObjectRole Additive 0 10
public export n_demizson : HuWord
n_demizson = MkHu "demizson" "demizs" ObjectRole Multiplicative 1 8
public export n_demonstra2la2s : HuWord
n_demonstra2la2s = MkHu "demonstrálás" "demonstrálás" ObjectRole Additive 0 12
public export n_demonstra2lo2 : HuWord
n_demonstra2lo2 = MkHu "demonstráló" "demonstráló" ObjectRole Additive 0 11
public export n_desztilla2ltata2s : HuWord
n_desztilla2ltata2s = MkHu "desztilláltatás" "desztilláltatás" ObjectRole Additive 0 15
public export n_desztilla2la2s : HuWord
n_desztilla2la2s = MkHu "desztillálás" "desztillálás" ObjectRole Additive 0 12
public export n_desztilla2lo2da2s : HuWord
n_desztilla2lo2da2s = MkHu "desztillálódás" "desztillálódás" ObjectRole Additive 0 14
public export n_dicsekedett : HuWord
n_dicsekedett = MkHu "dicsekedett" "dicsekede" ObjectRole Multiplicative 8 11
public export n_dicsekve2s : HuWord
n_dicsekve2s = MkHu "dicsekvés" "dicsekvés" ObjectRole Multiplicative 0 9
public export n_dicsekvo4 : HuWord
n_dicsekvo4 = MkHu "dicsekvő" "dicsekvő" ObjectRole Multiplicative 0 8
public export n_dicso4i2te2s : HuWord
n_dicso4i2te2s = MkHu "dicsőítés" "dicsőítés" ObjectRole Multiplicative 0 9
public export n_dinnyefo3ld : HuWord
n_dinnyefo3ld = MkHu "dinnyeföld" "dinnyeföld" ObjectRole Multiplicative 0 10
public export n_dinnyemezo4 : HuWord
n_dinnyemezo4 = MkHu "dinnyemező" "dinnyemező" ObjectRole Multiplicative 0 10
public export n_divatszalon : HuWord
n_divatszalon = MkHu "divatszalon" "divatszal" ObjectRole Additive 1 11
public export n_dob : HuWord
n_dob = MkHu "dob" "dob" ObjectRole Additive 0 3
public export n_dobo2csontocska : HuWord
n_dobo2csontocska = MkHu "dobócsontocska" "dobócsontocska" ObjectRole Additive 0 14
public export n_dolog : HuWord
n_dolog = MkHu "dolog" "dolog" ObjectRole Additive 0 5
public export n_donga2s : HuWord
n_donga2s = MkHu "dongás" "dongás" ObjectRole Additive 0 6
public export n_drusza : HuWord
n_drusza = MkHu "drusza" "drusza" ObjectRole Additive 0 6
public export n_durva : HuWord
n_durva = MkHu "durva" "durva" ObjectRole Additive 0 5
public export n_duzzaszto2mu4 : HuWord
n_duzzaszto2mu4 = MkHu "duzzasztómű" "duzzasztómű" ObjectRole Multiplicative 0 11
public export n_de2dapa : HuWord
n_de2dapa = MkHu "dédapa" "dédapa" ObjectRole Additive 0 6
public export n_di2szlet : HuWord
n_di2szlet = MkHu "díszlet" "díszl" ObjectRole Multiplicative 2 7
public export n_di2szterem : HuWord
n_di2szterem = MkHu "díszterem" "díszter" ObjectRole Multiplicative 32 9
public export n_di2szi2ttete2s : HuWord
n_di2szi2ttete2s = MkHu "díszíttetés" "díszíttetés" ObjectRole Multiplicative 0 11
public export n_di2szi2te2s : HuWord
n_di2szi2te2s = MkHu "díszítés" "díszítés" ObjectRole Multiplicative 0 8
public export n_do3fe2s : HuWord
n_do3fe2s = MkHu "döfés" "döfés" ObjectRole Multiplicative 0 5
public export n_do3lyf : HuWord
n_do3lyf = MkHu "dölyf" "dölyf" ObjectRole Multiplicative 0 5
public export n_do3lyfo3sse2g : HuWord
n_do3lyfo3sse2g = MkHu "dölyfösség" "dölyfösség" ObjectRole Multiplicative 0 10
public export n_do3nge2s : HuWord
n_do3nge2s = MkHu "döngés" "döngés" ObjectRole Multiplicative 0 6
public export n_do3rmo3ge2s : HuWord
n_do3rmo3ge2s = MkHu "dörmögés" "dörmögés" ObjectRole Multiplicative 0 8
public export n_du3nnyo3ge2s : HuWord
n_du3nnyo3ge2s = MkHu "dünnyögés" "dünnyögés" ObjectRole Multiplicative 0 9
public export n_do4lo3nge2le2s : HuWord
n_do4lo3nge2le2s = MkHu "dőlöngélés" "dőlöngélés" ObjectRole Multiplicative 0 10
public export n_eb : HuWord
n_eb = MkHu "eb" "eb" ObjectRole Multiplicative 0 2
public export n_ebihal : HuWord
n_ebihal = MkHu "ebihal" "ebihal" ObjectRole Additive 0 6
public export n_egyensu2lyoza2s : HuWord
n_egyensu2lyoza2s = MkHu "egyensúlyozás" "egyensúlyozás" ObjectRole Additive 0 13
public export n_egyse2g : HuWord
n_egyse2g = MkHu "egység" "egység" ObjectRole Multiplicative 0 6
public export n_egyu3ttes : HuWord
n_egyu3ttes = MkHu "együttes" "együttes" ObjectRole Multiplicative 0 8
public export n_ekevas : HuWord
n_ekevas = MkHu "ekevas" "ekevas" ObjectRole Additive 0 6
public export n_ekgyengi2te2s : HuWord
n_ekgyengi2te2s = MkHu "ekgyengítés" "ekgyengítés" ObjectRole Multiplicative 0 11
public export n_elaltata2s : HuWord
n_elaltata2s = MkHu "elaltatás" "elaltatás" ObjectRole Additive 0 9
public export n_elalva2s : HuWord
n_elalva2s = MkHu "elalvás" "elalvás" ObjectRole Additive 0 7
public export n_elbizakodott : HuWord
n_elbizakodott = MkHu "elbizakodott" "elbizakodo" ObjectRole Additive 8 12
public export n_elbizakodottsa2g : HuWord
n_elbizakodottsa2g = MkHu "elbizakodottság" "elbizakodottság" ObjectRole Additive 0 15
public export n_elbizakoda2s : HuWord
n_elbizakoda2s = MkHu "elbizakodás" "elbizakodás" ObjectRole Additive 0 11
public export n_elburja2nza2s : HuWord
n_elburja2nza2s = MkHu "elburjánzás" "elburjánzás" ObjectRole Additive 0 11
public export n_elburja2nze2s : HuWord
n_elburja2nze2s = MkHu "elburjánzés" "elburjánzés" ObjectRole Multiplicative 0 11
public export n_elba2gyaszta2s : HuWord
n_elba2gyaszta2s = MkHu "elbágyasztás" "elbágyasztás" ObjectRole Additive 0 12
public export n_elcsavaroda2s : HuWord
n_elcsavaroda2s = MkHu "elcsavarodás" "elcsavarodás" ObjectRole Additive 0 12
public export n_elcsendesede2s : HuWord
n_elcsendesede2s = MkHu "elcsendesedés" "elcsendesedés" ObjectRole Multiplicative 0 13
public export n_elcsendesi2ttete2s : HuWord
n_elcsendesi2ttete2s = MkHu "elcsendesíttetés" "elcsendesíttetés" ObjectRole Multiplicative 0 16
public export n_elcsendesi2te2s : HuWord
n_elcsendesi2te2s = MkHu "elcsendesítés" "elcsendesítés" ObjectRole Multiplicative 0 13
public export n_elcsiga2za2s : HuWord
n_elcsiga2za2s = MkHu "elcsigázás" "elcsigázás" ObjectRole Additive 0 10
public export n_eldo4lt : HuWord
n_eldo4lt = MkHu "eldőlt" "eldől" ObjectRole Multiplicative 2 6
public export n_eldo4le2s : HuWord
n_eldo4le2s = MkHu "eldőlés" "eldőlés" ObjectRole Multiplicative 0 7
public export n_elejte2s : HuWord
n_elejte2s = MkHu "elejtés" "elejtés" ObjectRole Multiplicative 0 7
public export n_elektor : HuWord
n_elektor = MkHu "elektor" "elektor" ObjectRole Additive 0 7
public export n_elfogyasztata2s : HuWord
n_elfogyasztata2s = MkHu "elfogyasztatás" "elfogyasztatás" ObjectRole Additive 0 14
public export n_elfogya2s : HuWord
n_elfogya2s = MkHu "elfogyás" "elfogyás" ObjectRole Additive 0 8
public export n_elfa2rada2s : HuWord
n_elfa2rada2s = MkHu "elfáradás" "elfáradás" ObjectRole Additive 0 9
public export n_elgyengi2te2s : HuWord
n_elgyengi2te2s = MkHu "elgyengítés" "elgyengítés" ObjectRole Multiplicative 0 11
public export n_elgyengu3le2s : HuWord
n_elgyengu3le2s = MkHu "elgyengülés" "elgyengülés" ObjectRole Multiplicative 0 11
public export n_elga2zola2s : HuWord
n_elga2zola2s = MkHu "elgázolás" "elgázolás" ObjectRole Additive 0 9
public export n_elhagya2s : HuWord
n_elhagya2s = MkHu "elhagyás" "elhagyás" ObjectRole Additive 0 8
public export n_elhanyagoltsa2g : HuWord
n_elhanyagoltsa2g = MkHu "elhanyagoltság" "elhanyagoltság" ObjectRole Additive 0 14
public export n_elhaszna2lo2da2s : HuWord
n_elhaszna2lo2da2s = MkHu "elhasználódás" "elhasználódás" ObjectRole Additive 0 13
public export n_elhervada2s : HuWord
n_elhervada2s = MkHu "elhervadás" "elhervadás" ObjectRole Additive 0 10
public export n_elhoma2lyosula2s : HuWord
n_elhoma2lyosula2s = MkHu "elhomályosulás" "elhomályosulás" ObjectRole Additive 0 14
public export n_elhulla2s : HuWord
n_elhulla2s = MkHu "elhullás" "elhullás" ObjectRole Additive 0 8
public export n_elhunyt : HuWord
n_elhunyt = MkHu "elhunyt" "elhuny" ObjectRole Additive 2 7
public export n_eljegesede2s : HuWord
n_eljegesede2s = MkHu "eljegesedés" "eljegesedés" ObjectRole Multiplicative 0 11
public export n_elja2ra2s : HuWord
n_elja2ra2s = MkHu "eljárás" "eljárás" ObjectRole Additive 0 7
public export n_elkeri2te2s : HuWord
n_elkeri2te2s = MkHu "elkerítés" "elkerítés" ObjectRole Multiplicative 0 9
public export n_elke2szu3le2s : HuWord
n_elke2szu3le2s = MkHu "elkészülés" "elkészülés" ObjectRole Multiplicative 0 10
public export n_elko3lttete2s : HuWord
n_elko3lttete2s = MkHu "elkölttetés" "elkölttetés" ObjectRole Multiplicative 0 11
public export n_elku3lo3ni2te2s : HuWord
n_elku3lo3ni2te2s = MkHu "elkülönítés" "elkülönítés" ObjectRole Multiplicative 0 11
public export n_elku3lo3nu3le2s : HuWord
n_elku3lo3nu3le2s = MkHu "elkülönülés" "elkülönülés" ObjectRole Multiplicative 0 11
public export n_ellenszenvesen : HuWord
n_ellenszenvesen = MkHu "ellenszenvesen" "ellenszenves" ObjectRole Multiplicative 1 14
public export n_ellustula2s : HuWord
n_ellustula2s = MkHu "ellustulás" "ellustulás" ObjectRole Additive 0 10
public export n_ellusti2ta2s : HuWord
n_ellusti2ta2s = MkHu "ellustítás" "ellustítás" ObjectRole Additive 0 10
public export n_elmeru3lt : HuWord
n_elmeru3lt = MkHu "elmerült" "elmerül" ObjectRole Multiplicative 2 8
public export n_elno3k : HuWord
n_elno3k = MkHu "elnök" "eln" ObjectRole Multiplicative 4 5
public export n_elno3kse2g : HuWord
n_elno3kse2g = MkHu "elnökség" "elnökség" ObjectRole Multiplicative 0 8
public export n_eloszta2s : HuWord
n_eloszta2s = MkHu "elosztás" "elosztás" ObjectRole Additive 0 8
public export n_elpusztula2s : HuWord
n_elpusztula2s = MkHu "elpusztulás" "elpusztulás" ObjectRole Additive 0 11
public export n_elpuszti2ttata2s : HuWord
n_elpuszti2ttata2s = MkHu "elpusztíttatás" "elpusztíttatás" ObjectRole Additive 0 14
public export n_elragadtata2s : HuWord
n_elragadtata2s = MkHu "elragadtatás" "elragadtatás" ObjectRole Additive 0 12
public export n_elsivatagosoda2s : HuWord
n_elsivatagosoda2s = MkHu "elsivatagosodás" "elsivatagosodás" ObjectRole Additive 0 15
public export n_elszege2nyede2s : HuWord
n_elszege2nyede2s = MkHu "elszegényedés" "elszegényedés" ObjectRole Multiplicative 0 13
public export n_elszinezo4de2s : HuWord
n_elszinezo4de2s = MkHu "elszineződés" "elszineződés" ObjectRole Multiplicative 0 12
public export n_elsza2ntsa2g : HuWord
n_elsza2ntsa2g = MkHu "elszántság" "elszántság" ObjectRole Additive 0 10
public export n_elso4kere2k : HuWord
n_elso4kere2k = MkHu "elsőkerék" "elsőkeré" ObjectRole Multiplicative 4 9
public export n_elterjedtse2g : HuWord
n_elterjedtse2g = MkHu "elterjedtség" "elterjedtség" ObjectRole Multiplicative 0 12
public export n_elterjede2s : HuWord
n_elterjede2s = MkHu "elterjedés" "elterjedés" ObjectRole Multiplicative 0 10
public export n_eltulajdoni2ta2s : HuWord
n_eltulajdoni2ta2s = MkHu "eltulajdonítás" "eltulajdonítás" ObjectRole Additive 0 14
public export n_eltu2lzott : HuWord
n_eltu2lzott = MkHu "eltúlzott" "eltúlzo" ObjectRole Additive 8 9
public export n_eltu2lza2s : HuWord
n_eltu2lza2s = MkHu "eltúlzás" "eltúlzás" ObjectRole Additive 0 8
public export n_eltu4ne2s : HuWord
n_eltu4ne2s = MkHu "eltűnés" "eltűnés" ObjectRole Multiplicative 0 7
public export n_elvadult : HuWord
n_elvadult = MkHu "elvadult" "elvadul" ObjectRole Additive 2 8
public export n_elvadultsa2g : HuWord
n_elvadultsa2g = MkHu "elvadultság" "elvadultság" ObjectRole Additive 0 11
public export n_elvadula2s : HuWord
n_elvadula2s = MkHu "elvadulás" "elvadulás" ObjectRole Additive 0 9
public export n_elvadi2ta2s : HuWord
n_elvadi2ta2s = MkHu "elvadítás" "elvadítás" ObjectRole Additive 0 9
public export n_elveve2s : HuWord
n_elveve2s = MkHu "elvevés" "elvevés" ObjectRole Multiplicative 0 7
public export n_elva2laszta2s : HuWord
n_elva2laszta2s = MkHu "elválasztás" "elválasztás" ObjectRole Additive 0 11
public export n_elve2geztete2s : HuWord
n_elve2geztete2s = MkHu "elvégeztetés" "elvégeztetés" ObjectRole Multiplicative 0 12
public export n_elve2gze2s : HuWord
n_elve2gze2s = MkHu "elvégzés" "elvégzés" ObjectRole Multiplicative 0 8
public export n_elzsi2rosoda2s : HuWord
n_elzsi2rosoda2s = MkHu "elzsírosodás" "elzsírosodás" ObjectRole Additive 0 12
public export n_elo3lja2ra2s : HuWord
n_elo3lja2ra2s = MkHu "elöljárás" "elöljárás" ObjectRole Additive 0 9
public export n_elo3lja2ro2 : HuWord
n_elo3lja2ro2 = MkHu "elöljáró" "elöljáró" ObjectRole Additive 0 8
public export n_elu3lso4 : HuWord
n_elu3lso4 = MkHu "elülső" "elülső" ObjectRole Multiplicative 0 6
public export n_elu3te2s : HuWord
n_elu3te2s = MkHu "elütés" "elütés" ObjectRole Multiplicative 0 6
public export n_elo4ado2terem : HuWord
n_elo4ado2terem = MkHu "előadóterem" "előadóter" ObjectRole Multiplicative 32 11
public export n_elo4fizeto4 : HuWord
n_elo4fizeto4 = MkHu "előfizető" "előfizető" ObjectRole Multiplicative 0 9
public export n_elo4leg : HuWord
n_elo4leg = MkHu "előleg" "előleg" ObjectRole Multiplicative 0 6
public export n_elo4me2lyede2s : HuWord
n_elo4me2lyede2s = MkHu "előmélyedés" "előmélyedés" ObjectRole Multiplicative 0 11
public export n_elo4rehalada2s : HuWord
n_elo4rehalada2s = MkHu "előrehaladás" "előrehaladás" ObjectRole Additive 0 12
public export n_elo4rejuta2s : HuWord
n_elo4rejuta2s = MkHu "előrejutás" "előrejutás" ObjectRole Additive 0 10
public export n_elo4remozdi2ttata2s : HuWord
n_elo4remozdi2ttata2s = MkHu "előremozdíttatás" "előremozdíttatás" ObjectRole Additive 0 16
public export n_elo4re2sze : HuWord
n_elo4re2sze = MkHu "előrésze" "előrésze" ObjectRole Multiplicative 0 8
public export n_elo4szo2 : HuWord
n_elo4szo2 = MkHu "előszó" "előszó" ObjectRole Additive 0 6
public export n_elo4to3rte2net : HuWord
n_elo4to3rte2net = MkHu "előtörténet" "előtörté" ObjectRole Multiplicative 3 11
public export n_elo4ze2s : HuWord
n_elo4ze2s = MkHu "előzés" "előzés" ObjectRole Multiplicative 0 6
public export n_elo4e2let : HuWord
n_elo4e2let = MkHu "előélet" "előél" ObjectRole Multiplicative 2 7
public export n_ember : HuWord
n_ember = MkHu "ember" "ember" ObjectRole Multiplicative 0 5
public export n_emberkeru3lo4 : HuWord
n_emberkeru3lo4 = MkHu "emberkerülő" "emberkerülő" ObjectRole Multiplicative 0 11
public export n_emberse2g : HuWord
n_emberse2g = MkHu "emberség" "emberség" ObjectRole Multiplicative 0 8
public export n_emelkede2s : HuWord
n_emelkede2s = MkHu "emelkedés" "emelkedés" ObjectRole Multiplicative 0 9
public export n_emeltete2s : HuWord
n_emeltete2s = MkHu "emeltetés" "emeltetés" ObjectRole Multiplicative 0 9
public export n_emele2s : HuWord
n_emele2s = MkHu "emelés" "emelés" ObjectRole Multiplicative 0 6
public export n_eperszedete2s : HuWord
n_eperszedete2s = MkHu "eperszedetés" "eperszedetés" ObjectRole Multiplicative 0 12
public export n_eperszede2s : HuWord
n_eperszede2s = MkHu "eperszedés" "eperszedés" ObjectRole Multiplicative 0 10
public export n_epilepszia : HuWord
n_epilepszia = MkHu "epilepszia" "epilepszia" ObjectRole Additive 0 10
public export n_epilo2gus : HuWord
n_epilo2gus = MkHu "epilógus" "epilógus" ObjectRole Additive 0 8
public export n_eredetise2g : HuWord
n_eredetise2g = MkHu "eredetiség" "eredetiség" ObjectRole Multiplicative 0 10
public export n_eredme2ny : HuWord
n_eredme2ny = MkHu "eredmény" "eredmény" ObjectRole Multiplicative 0 8
public export n_eredme2nyesse2g : HuWord
n_eredme2nyesse2g = MkHu "eredményesség" "eredményesség" ObjectRole Multiplicative 0 13
public export n_erke2ly : HuWord
n_erke2ly = MkHu "erkély" "erkély" ObjectRole Multiplicative 0 6
public export n_erko3lcstelense2g : HuWord
n_erko3lcstelense2g = MkHu "erkölcstelenség" "erkölcstelenség" ObjectRole Multiplicative 0 15
public export n_ero2zio2 : HuWord
n_ero2zio2 = MkHu "erózió" "erózió" ObjectRole Additive 0 6
public export n_ero4leves : HuWord
n_ero4leves = MkHu "erőleves" "erőleves" ObjectRole Multiplicative 0 8
public export n_ero4szak : HuWord
n_ero4szak = MkHu "erőszak" "erősz" ObjectRole Multiplicative 4 7
public export n_esku3 : HuWord
n_esku3 = MkHu "eskü" "eskü" ObjectRole Multiplicative 0 4
public export n_eszterga2la2s : HuWord
n_eszterga2la2s = MkHu "esztergálás" "esztergálás" ObjectRole Additive 0 11
public export n_ezu3st : HuWord
n_ezu3st = MkHu "ezüst" "ezüs" ObjectRole Multiplicative 2 5
public export n_ezu3stlakodalom : HuWord
n_ezu3stlakodalom = MkHu "ezüstlakodalom" "ezüstlakodal" ObjectRole Additive 32 14
public export n_ezu3stmu4ves : HuWord
n_ezu3stmu4ves = MkHu "ezüstműves" "ezüstműves" ObjectRole Multiplicative 0 10
public export n_ezu3stpatina : HuWord
n_ezu3stpatina = MkHu "ezüstpatina" "ezüstpatina" ObjectRole Additive 0 11
public export n_ezu3ste2rc : HuWord
n_ezu3ste2rc = MkHu "ezüstérc" "ezüstérc" ObjectRole Multiplicative 0 8
public export n_ezu3sto3ze2s : HuWord
n_ezu3sto3ze2s = MkHu "ezüstözés" "ezüstözés" ObjectRole Multiplicative 0 9
public export n_ezu3sto3zo3tt : HuWord
n_ezu3sto3zo3tt = MkHu "ezüstözött" "ezüstözö" ObjectRole Multiplicative 8 10
public export n_fabo2de2 : HuWord
n_fabo2de2 = MkHu "fabódé" "fabódé" ObjectRole Multiplicative 0 6
public export n_faha2ncs : HuWord
n_faha2ncs = MkHu "faháncs" "faháncs" ObjectRole Additive 0 7
public export n_faiga : HuWord
n_faiga = MkHu "faiga" "faiga" ObjectRole Additive 0 5
public export n_fajanko2 : HuWord
n_fajanko2 = MkHu "fajankó" "fajankó" ObjectRole Additive 0 7
public export n_fajdkakas : HuWord
n_fajdkakas = MkHu "fajdkakas" "fajdkakas" ObjectRole Additive 0 9
public export n_fajtalankoda2s : HuWord
n_fajtalankoda2s = MkHu "fajtalankodás" "fajtalankodás" ObjectRole Additive 0 13
public export n_fake2reg : HuWord
n_fake2reg = MkHu "fakéreg" "fakéreg" ObjectRole Multiplicative 0 7
public export n_fal : HuWord
n_fal = MkHu "fal" "fal" ObjectRole Additive 0 3
public export n_falikar : HuWord
n_falikar = MkHu "falikar" "falikar" ObjectRole Additive 0 7
public export n_falila2mpa : HuWord
n_falila2mpa = MkHu "falilámpa" "falilámpa" ObjectRole Additive 0 9
public export n_faliu2jsa2g : HuWord
n_faliu2jsa2g = MkHu "faliújság" "faliújság" ObjectRole Additive 0 9
public export n_fala2nk : HuWord
n_fala2nk = MkHu "falánk" "falá" ObjectRole Additive 5 6
public export n_fanszo4rzet : HuWord
n_fanszo4rzet = MkHu "fanszőrzet" "fanszőrz" ObjectRole Multiplicative 2 10
public export n_far : HuWord
n_far = MkHu "far" "far" ObjectRole Additive 0 3
public export n_faragatlan : HuWord
n_faragatlan = MkHu "faragatlan" "faragatla" ObjectRole Additive 1 10
public export n_faraka2s : HuWord
n_faraka2s = MkHu "farakás" "farakás" ObjectRole Additive 0 7
public export n_farkcsont : HuWord
n_farkcsont = MkHu "farkcsont" "farkcso" ObjectRole Additive 3 9
public export n_farok : HuWord
n_farok = MkHu "farok" "far" ObjectRole Additive 4 5
public export n_farokcsigolya2k : HuWord
n_farokcsigolya2k = MkHu "farokcsigolyák" "farokcsigolyá" ObjectRole Additive 4 14
public export n_farokcsont : HuWord
n_farokcsont = MkHu "farokcsont" "farokcso" ObjectRole Additive 3 10
public export n_fasor : HuWord
n_fasor = MkHu "fasor" "fasor" ObjectRole Additive 0 5
public export n_fecsego4 : HuWord
n_fecsego4 = MkHu "fecsegő" "fecsegő" ObjectRole Multiplicative 0 7
public export n_fedeztete2s : HuWord
n_fedeztete2s = MkHu "fedeztetés" "fedeztetés" ObjectRole Multiplicative 0 10
public export n_fedeze2k : HuWord
n_fedeze2k = MkHu "fedezék" "fedezé" ObjectRole Multiplicative 4 7
public export n_fede2lsze2k : HuWord
n_fede2lsze2k = MkHu "fedélszék" "fedélszé" ObjectRole Multiplicative 4 9
public export n_fede2lzet : HuWord
n_fede2lzet = MkHu "fedélzet" "fedélz" ObjectRole Multiplicative 2 8
public export n_fede2lzetmester : HuWord
n_fede2lzetmester = MkHu "fedélzetmester" "fedélzetmester" ObjectRole Multiplicative 0 14
public export n_fegyverrakta2r : HuWord
n_fegyverrakta2r = MkHu "fegyverraktár" "fegyverraktár" ObjectRole Additive 0 13
public export n_fehe2rga2rdista : HuWord
n_fehe2rga2rdista = MkHu "fehérgárdista" "fehérgárdista" ObjectRole Additive 0 13
public export n_fehe2rje : HuWord
n_fehe2rje = MkHu "fehérje" "fehér" ObjectRole Multiplicative 32 7
public export n_fehe2rje2k : HuWord
n_fehe2rje2k = MkHu "fehérjék" "fehérjé" ObjectRole Multiplicative 4 8
public export n_fehe2rnemu4 : HuWord
n_fehe2rnemu4 = MkHu "fehérnemű" "fehérnemű" ObjectRole Multiplicative 0 9
public export n_fehe2rre2pa : HuWord
n_fehe2rre2pa = MkHu "fehérrépa" "fehérrépa" ObjectRole Additive 0 9
public export n_fej : HuWord
n_fej = MkHu "fej" "fej" ObjectRole Multiplicative 0 3
public export n_fejezet : HuWord
n_fejezet = MkHu "fejezet" "fejez" ObjectRole Multiplicative 2 7
public export n_fejlesztete2s : HuWord
n_fejlesztete2s = MkHu "fejlesztetés" "fejlesztetés" ObjectRole Multiplicative 0 12
public export n_fejleszte2s : HuWord
n_fejleszte2s = MkHu "fejlesztés" "fejlesztés" ObjectRole Multiplicative 0 10
public export n_fejleszto4 : HuWord
n_fejleszto4 = MkHu "fejlesztő" "fejlesztő" ObjectRole Multiplicative 0 9
public export n_fejlett : HuWord
n_fejlett = MkHu "fejlett" "fejle" ObjectRole Multiplicative 8 7
public export n_fejlo4de2s : HuWord
n_fejlo4de2s = MkHu "fejlődés" "fejlődés" ObjectRole Multiplicative 0 8
public export n_fejlo4do4 : HuWord
n_fejlo4do4 = MkHu "fejlődő" "fejlődő" ObjectRole Multiplicative 0 7
public export n_felbolydi2ta2s : HuWord
n_felbolydi2ta2s = MkHu "felbolydítás" "felbolydítás" ObjectRole Additive 0 12
public export n_felborul : HuWord
n_felborul = MkHu "felborul" "felborul" ObjectRole Additive 0 8
public export n_felbori2ta2s : HuWord
n_felbori2ta2s = MkHu "felborítás" "felborítás" ObjectRole Additive 0 10
public export n_felbukfencezik : HuWord
n_felbukfencezik = MkHu "felbukfencezik" "felbukfencezi" ObjectRole Multiplicative 4 14
public export n_felbuzdula2s : HuWord
n_felbuzdula2s = MkHu "felbuzdulás" "felbuzdulás" ObjectRole Additive 0 11
public export n_felcsavaroda2s : HuWord
n_felcsavaroda2s = MkHu "felcsavarodás" "felcsavarodás" ObjectRole Additive 0 13
public export n_felcsavartata2s : HuWord
n_felcsavartata2s = MkHu "felcsavartatás" "felcsavartatás" ObjectRole Additive 0 14
public export n_felcsavara2s : HuWord
n_felcsavara2s = MkHu "felcsavarás" "felcsavarás" ObjectRole Additive 0 11
public export n_feldo4l : HuWord
n_feldo4l = MkHu "feldől" "feldől" ObjectRole Multiplicative 0 6
public export n_feldo4lte2s : HuWord
n_feldo4lte2s = MkHu "feldőltés" "feldőltés" ObjectRole Multiplicative 0 9
public export n_feldo4le2s : HuWord
n_feldo4le2s = MkHu "feldőlés" "feldőlés" ObjectRole Multiplicative 0 8
public export n_feleme2sztete2s : HuWord
n_feleme2sztete2s = MkHu "felemésztetés" "felemésztetés" ObjectRole Multiplicative 0 13
public export n_felesleg : HuWord
n_felesleg = MkHu "felesleg" "felesleg" ObjectRole Multiplicative 0 8
public export n_feleslegesen : HuWord
n_feleslegesen = MkHu "feleslegesen" "felesleges" ObjectRole Multiplicative 1 12
public export n_felezo4 : HuWord
n_felezo4 = MkHu "felező" "felező" ObjectRole Multiplicative 0 6
public export n_felezo4vonal : HuWord
n_felezo4vonal = MkHu "felezővonal" "felezővonal" ObjectRole Additive 0 11
public export n_felfog : HuWord
n_felfog = MkHu "felfog" "felfog" ObjectRole Additive 0 6
public export n_felfordula2s : HuWord
n_felfordula2s = MkHu "felfordulás" "felfordulás" ObjectRole Additive 0 11
public export n_felfordi2ttata2s : HuWord
n_felfordi2ttata2s = MkHu "felfordíttatás" "felfordíttatás" ObjectRole Additive 0 14
public export n_felfordi2ta2s : HuWord
n_felfordi2ta2s = MkHu "felfordítás" "felfordítás" ObjectRole Additive 0 11
public export n_felforra2s : HuWord
n_felforra2s = MkHu "felforrás" "felforrás" ObjectRole Additive 0 9
public export n_felfortyana2s : HuWord
n_felfortyana2s = MkHu "felfortyanás" "felfortyanás" ObjectRole Additive 0 12
public export n_felgomolyga2a : HuWord
n_felgomolyga2a = MkHu "felgomolygáa" "felgomolygáa" ObjectRole Additive 0 12
public export n_felgo3ngyo3ltete2s : HuWord
n_felgo3ngyo3ltete2s = MkHu "felgöngyöltetés" "felgöngyöltetés" ObjectRole Multiplicative 0 15
public export n_felgo3ngyo3le2s : HuWord
n_felgo3ngyo3le2s = MkHu "felgöngyölés" "felgöngyölés" ObjectRole Multiplicative 0 12
public export n_felgo3ngyo3li2ttete2s : HuWord
n_felgo3ngyo3li2ttete2s = MkHu "felgöngyölíttetés" "felgöngyölíttetés" ObjectRole Multiplicative 0 17
public export n_felgo3ngyo3li2te2s : HuWord
n_felgo3ngyo3li2te2s = MkHu "felgöngyölítés" "felgöngyölítés" ObjectRole Multiplicative 0 14
public export n_felgo3ngyo3lo3de2s : HuWord
n_felgo3ngyo3lo3de2s = MkHu "felgöngyölödés" "felgöngyölödés" ObjectRole Multiplicative 0 14
public export n_felhalmoza2s : HuWord
n_felhalmoza2s = MkHu "felhalmozás" "felhalmozás" ObjectRole Additive 0 11
public export n_felingerle2s : HuWord
n_felingerle2s = MkHu "felingerlés" "felingerlés" ObjectRole Multiplicative 0 11
public export n_felizgata2s : HuWord
n_felizgata2s = MkHu "felizgatás" "felizgatás" ObjectRole Additive 0 10
public export n_felizgula2a : HuWord
n_felizgula2a = MkHu "felizguláa" "felizguláa" ObjectRole Additive 0 10
public export n_feljelente2s : HuWord
n_feljelente2s = MkHu "feljelentés" "feljelentés" ObjectRole Multiplicative 0 11
public export n_felkele2s : HuWord
n_felkele2s = MkHu "felkelés" "felkelés" ObjectRole Multiplicative 0 8
public export n_felke2szi2te2s : HuWord
n_felke2szi2te2s = MkHu "felkészítés" "felkészítés" ObjectRole Multiplicative 0 11
public export n_fellazi2ttata2s : HuWord
n_fellazi2ttata2s = MkHu "fellazíttatás" "fellazíttatás" ObjectRole Additive 0 13
public export n_fellazi2ta2s : HuWord
n_fellazi2ta2s = MkHu "fellazítás" "fellazítás" ObjectRole Additive 0 10
public export n_fellendu3le2s : HuWord
n_fellendu3le2s = MkHu "fellendülés" "fellendülés" ObjectRole Multiplicative 0 11
public export n_fella2zi2ttata2s : HuWord
n_fella2zi2ttata2s = MkHu "fellázíttatás" "fellázíttatás" ObjectRole Additive 0 13
public export n_felno4tt : HuWord
n_felno4tt = MkHu "felnőtt" "felnő" ObjectRole Multiplicative 8 7
public export n_feloszta2s : HuWord
n_feloszta2s = MkHu "felosztás" "felosztás" ObjectRole Additive 0 9
public export n_felra2za2s : HuWord
n_felra2za2s = MkHu "felrázás" "felrázás" ObjectRole Additive 0 8
public export n_felszi2ta2s : HuWord
n_felszi2ta2s = MkHu "felszítás" "felszítás" ObjectRole Additive 0 9
public export n_feltekerede2s : HuWord
n_feltekerede2s = MkHu "feltekeredés" "feltekeredés" ObjectRole Multiplicative 0 12
public export n_feltekertete2s : HuWord
n_feltekertete2s = MkHu "feltekertetés" "feltekertetés" ObjectRole Multiplicative 0 13
public export n_feltekere2s : HuWord
n_feltekere2s = MkHu "feltekerés" "feltekerés" ObjectRole Multiplicative 0 10
public export n_feltu4zete2s : HuWord
n_feltu4zete2s = MkHu "feltűzetés" "feltűzetés" ObjectRole Multiplicative 0 10
public export n_feltu4ze2s : HuWord
n_feltu4ze2s = MkHu "feltűzés" "feltűzés" ObjectRole Multiplicative 0 8
public export n_felva2ga2s : HuWord
n_felva2ga2s = MkHu "felvágás" "felvágás" ObjectRole Additive 0 8
public export n_fela2ramla2s : HuWord
n_fela2ramla2s = MkHu "feláramlás" "feláramlás" ObjectRole Additive 0 10
public export n_felu3gyelet : HuWord
n_felu3gyelet = MkHu "felügyelet" "felügyel" ObjectRole Multiplicative 2 10
public export n_fense2g : HuWord
n_fense2g = MkHu "fenség" "fenség" ObjectRole Multiplicative 0 6
public export n_fene2k : HuWord
n_fene2k = MkHu "fenék" "fené" ObjectRole Multiplicative 4 5
public export n_feno4ko4 : HuWord
n_feno4ko4 = MkHu "fenőkő" "fenőkő" ObjectRole Multiplicative 0 6
public export n_festete2s : HuWord
n_festete2s = MkHu "festetés" "festetés" ObjectRole Multiplicative 0 8
public export n_feste2k : HuWord
n_feste2k = MkHu "festék" "festé" ObjectRole Multiplicative 4 6
public export n_feste2s : HuWord
n_feste2s = MkHu "festés" "festés" ObjectRole Multiplicative 0 6
public export n_festo4 : HuWord
n_festo4 = MkHu "festő" "festő" ObjectRole Multiplicative 0 5
public export n_ficam : HuWord
n_ficam = MkHu "ficam" "ficam" ObjectRole Additive 0 5
public export n_figyel : HuWord
n_figyel = MkHu "figyel" "figyel" ObjectRole Multiplicative 0 6
public export n_figyele2s : HuWord
n_figyele2s = MkHu "figyelés" "figyelés" ObjectRole Multiplicative 0 8
public export n_five2r : HuWord
n_five2r = MkHu "fivér" "fivér" ObjectRole Multiplicative 0 5
public export n_five2rek : HuWord
n_five2rek = MkHu "fivérek" "fivér" ObjectRole Multiplicative 4 7
public export n_fizete2s : HuWord
n_fizete2s = MkHu "fizetés" "fizetés" ObjectRole Multiplicative 0 7
public export n_fodormenta : HuWord
n_fodormenta = MkHu "fodormenta" "fodormenta" ObjectRole Additive 0 10
public export n_fogadalom : HuWord
n_fogadalom = MkHu "fogadalom" "fogadal" ObjectRole Additive 32 9
public export n_fogada2s : HuWord
n_fogada2s = MkHu "fogadás" "fogadás" ObjectRole Additive 0 7
public export n_fogat : HuWord
n_fogat = MkHu "fogat" "fog" ObjectRole Additive 2 5
public export n_foglala2s : HuWord
n_foglala2s = MkHu "foglalás" "foglalás" ObjectRole Additive 0 8
public export n_fogoly : HuWord
n_fogoly = MkHu "fogoly" "fogoly" ObjectRole Additive 0 6
public export n_fogsa2g : HuWord
n_fogsa2g = MkHu "fogság" "fogság" ObjectRole Additive 0 6
public export n_fogo2 : HuWord
n_fogo2 = MkHu "fogó" "fogó" ObjectRole Additive 0 4
public export n_fokhagyma : HuWord
n_fokhagyma = MkHu "fokhagyma" "fokhagyma" ObjectRole Additive 0 9
public export n_folytattata2s : HuWord
n_folytattata2s = MkHu "folytattatás" "folytattatás" ObjectRole Additive 0 12
public export n_folytata2s : HuWord
n_folytata2s = MkHu "folytatás" "folytatás" ObjectRole Additive 0 9
public export n_folya2s : HuWord
n_folya2s = MkHu "folyás" "folyás" ObjectRole Additive 0 6
public export n_fonal : HuWord
n_fonal = MkHu "fonal" "fonal" ObjectRole Additive 0 5
public export n_fonott : HuWord
n_fonott = MkHu "fonott" "fono" ObjectRole Additive 8 6
public export n_fona2lfe2reg : HuWord
n_fona2lfe2reg = MkHu "fonálféreg" "fonálféreg" ObjectRole Multiplicative 0 10
public export n_fona2s : HuWord
n_fona2s = MkHu "fonás" "fonás" ObjectRole Additive 0 5
public export n_fordula2s : HuWord
n_fordula2s = MkHu "fordulás" "fordulás" ObjectRole Additive 0 8
public export n_fordi2ttata2s : HuWord
n_fordi2ttata2s = MkHu "fordíttatás" "fordíttatás" ObjectRole Additive 0 11
public export n_fordi2ta2s : HuWord
n_fordi2ta2s = MkHu "fordítás" "fordítás" ObjectRole Additive 0 8
public export n_fordi2to2 : HuWord
n_fordi2to2 = MkHu "fordító" "fordító" ObjectRole Additive 0 7
public export n_forgata2s : HuWord
n_forgata2s = MkHu "forgatás" "forgatás" ObjectRole Additive 0 8
public export n_forgolo2da2s : HuWord
n_forgolo2da2s = MkHu "forgolódás" "forgolódás" ObjectRole Additive 0 10
public export n_forga2s : HuWord
n_forga2s = MkHu "forgás" "forgás" ObjectRole Additive 0 6
public export n_forgo2 : HuWord
n_forgo2 = MkHu "forgó" "forgó" ObjectRole Additive 0 5
public export n_forma2lt : HuWord
n_forma2lt = MkHu "formált" "formál" ObjectRole Additive 2 7
public export n_forma2la2s : HuWord
n_forma2la2s = MkHu "formálás" "formálás" ObjectRole Additive 0 8
public export n_forma2lo2 : HuWord
n_forma2lo2 = MkHu "formáló" "formáló" ObjectRole Additive 0 7
public export n_forradalom : HuWord
n_forradalom = MkHu "forradalom" "forradal" ObjectRole Additive 32 10
public export n_forraltata2s : HuWord
n_forraltata2s = MkHu "forraltatás" "forraltatás" ObjectRole Additive 0 11
public export n_forrala2s : HuWord
n_forrala2s = MkHu "forralás" "forralás" ObjectRole Additive 0 8
public export n_forra2s : HuWord
n_forra2s = MkHu "forrás" "forrás" ObjectRole Additive 0 6
public export n_forro2vi2z : HuWord
n_forro2vi2z = MkHu "forróvíz" "forróvíz" ObjectRole Multiplicative 0 8
public export n_fortyoga2s : HuWord
n_fortyoga2s = MkHu "fortyogás" "fortyogás" ObjectRole Additive 0 9
public export n_fra2zis : HuWord
n_fra2zis = MkHu "frázis" "frázis" ObjectRole Multiplicative 0 6
public export n_fro3ccsene2s : HuWord
n_fro3ccsene2s = MkHu "fröccsenés" "fröccsenés" ObjectRole Multiplicative 0 10
public export n_furfang : HuWord
n_furfang = MkHu "furfang" "furfang" ObjectRole Additive 0 7
public export n_futballcipo4 : HuWord
n_futballcipo4 = MkHu "futballcipő" "futballcipő" ObjectRole Multiplicative 0 11
public export n_futa2s : HuWord
n_futa2s = MkHu "futás" "futás" ObjectRole Additive 0 5
public export n_fuvallat : HuWord
n_fuvallat = MkHu "fuvallat" "fuvall" ObjectRole Additive 2 8
public export n_fe2ktelense2g : HuWord
n_fe2ktelense2g = MkHu "féktelenség" "féktelenség" ObjectRole Multiplicative 0 11
public export n_fe2lremagyara2za2s : HuWord
n_fe2lremagyara2za2s = MkHu "félremagyarázás" "félremagyarázás" ObjectRole Additive 0 15
public export n_fe2mbarome2ter : HuWord
n_fe2mbarome2ter = MkHu "fémbarométer" "fémbarométer" ObjectRole Multiplicative 0 12
public export n_fe2szer : HuWord
n_fe2szer = MkHu "fészer" "fészer" ObjectRole Multiplicative 0 6
public export n_fo3ldesu2r : HuWord
n_fo3ldesu2r = MkHu "földesúr" "földesúr" ObjectRole Additive 0 8
public export n_fo3ldi : HuWord
n_fo3ldi = MkHu "földi" "földi" ObjectRole Multiplicative 0 5
public export n_fo3ldiek : HuWord
n_fo3ldiek = MkHu "földiek" "földi" ObjectRole Multiplicative 4 7
public export n_fo3ldpa2t : HuWord
n_fo3ldpa2t = MkHu "földpát" "földpá" ObjectRole Additive 2 7
public export n_fo3ldsa2nc : HuWord
n_fo3ldsa2nc = MkHu "földsánc" "földsánc" ObjectRole Additive 0 8
public export n_fu2ja2s : HuWord
n_fu2ja2s = MkHu "fújás" "fújás" ObjectRole Additive 0 5
public export n_fu2ro2 : HuWord
n_fu2ro2 = MkHu "fúró" "fúró" ObjectRole Additive 0 4
public export n_fu3lke : HuWord
n_fu3lke = MkHu "fülke" "fülke" ObjectRole Multiplicative 0 5
public export n_fu3zesse2g : HuWord
n_fu3zesse2g = MkHu "füzesség" "füzesség" ObjectRole Multiplicative 0 8
public export n_fu3ze2r : HuWord
n_fu3ze2r = MkHu "füzér" "füzér" ObjectRole Multiplicative 0 5
public export n_fo4nemes : HuWord
n_fo4nemes = MkHu "főnemes" "főnemes" ObjectRole Multiplicative 0 7
public export n_fo4pap : HuWord
n_fo4pap = MkHu "főpap" "főpap" ObjectRole Additive 0 5
public export n_fo4u3gye2sz : HuWord
n_fo4u3gye2sz = MkHu "főügyész" "főügyész" ObjectRole Multiplicative 0 8
public export n_fu4 : HuWord
n_fu4 = MkHu "fű" "fű" ObjectRole Multiplicative 0 2
public export n_fu4re2sz : HuWord
n_fu4re2sz = MkHu "fűrész" "fűrész" ObjectRole Multiplicative 0 6
public export n_fu4szeru3zlet : HuWord
n_fu4szeru3zlet = MkHu "fűszerüzlet" "fűszerüzl" ObjectRole Multiplicative 2 11
public export n_fu4zfa : HuWord
n_fu4zfa = MkHu "fűzfa" "fűzfa" ObjectRole Additive 0 5
public export n_fu4zfabokor : HuWord
n_fu4zfabokor = MkHu "fűzfabokor" "fűzfabokor" ObjectRole Additive 0 10
public export n_fu4zfaha2ncs : HuWord
n_fu4zfaha2ncs = MkHu "fűzfaháncs" "fűzfaháncs" ObjectRole Additive 0 10
public export n_gabonabegyu4jte2s : HuWord
n_gabonabegyu4jte2s = MkHu "gabonabegyűjtés" "gabonabegyűjtés" ObjectRole Multiplicative 0 15
public export n_galagonya : HuWord
n_galagonya = MkHu "galagonya" "galagonya" ObjectRole Additive 0 9
public export n_gazdag : HuWord
n_gazdag = MkHu "gazdag" "gazdag" ObjectRole Additive 0 6
public export n_gazdagsa2g : HuWord
n_gazdagsa2g = MkHu "gazdagság" "gazdagság" ObjectRole Additive 0 9
public export n_gerenda : HuWord
n_gerenda = MkHu "gerenda" "gerenda" ObjectRole Additive 0 7
public export n_gerenda2zat : HuWord
n_gerenda2zat = MkHu "gerendázat" "gerendáz" ObjectRole Additive 2 10
public export n_gomb : HuWord
n_gomb = MkHu "gomb" "gomb" ObjectRole Additive 0 4
public export n_gomblyuk : HuWord
n_gomblyuk = MkHu "gomblyuk" "gomblyu" ObjectRole Additive 4 8
public export n_gombolyag : HuWord
n_gombolyag = MkHu "gombolyag" "gombolyag" ObjectRole Additive 0 9
public export n_gombolyi2ttata2s : HuWord
n_gombolyi2ttata2s = MkHu "gombolyíttatás" "gombolyíttatás" ObjectRole Additive 0 14
public export n_gombolyi2ta2s : HuWord
n_gombolyi2ta2s = MkHu "gombolyítás" "gombolyítás" ObjectRole Additive 0 11
public export n_gombostu4 : HuWord
n_gombostu4 = MkHu "gombostű" "gombostű" ObjectRole Multiplicative 0 8
public export n_gomolyga2s : HuWord
n_gomolyga2s = MkHu "gomolygás" "gomolygás" ObjectRole Additive 0 9
public export n_gondozatlansa2g : HuWord
n_gondozatlansa2g = MkHu "gondozatlanság" "gondozatlanság" ObjectRole Additive 0 14
public export n_gurula2s : HuWord
n_gurula2s = MkHu "gurulás" "gurulás" ObjectRole Additive 0 7
public export n_guri2ta2s : HuWord
n_guri2ta2s = MkHu "gurítás" "gurítás" ObjectRole Additive 0 7
public export n_gyakorlat : HuWord
n_gyakorlat = MkHu "gyakorlat" "gyakorl" ObjectRole Additive 2 9
public export n_gyapjasle2gy : HuWord
n_gyapjasle2gy = MkHu "gyapjaslégy" "gyapjaslégy" ObjectRole Multiplicative 0 11
public export n_gyengi2te2s : HuWord
n_gyengi2te2s = MkHu "gyengítés" "gyengítés" ObjectRole Multiplicative 0 9
public export n_gyeplo4 : HuWord
n_gyeplo4 = MkHu "gyeplő" "gyeplő" ObjectRole Multiplicative 0 6
public export n_gyermekla2ncfu4 : HuWord
n_gyermekla2ncfu4 = MkHu "gyermekláncfű" "gyermekláncfű" ObjectRole Multiplicative 0 13
public export n_gyilkossa2g : HuWord
n_gyilkossa2g = MkHu "gyilkosság" "gyilkosság" ObjectRole Additive 0 10
public export n_gyomorkeseru4 : HuWord
n_gyomorkeseru4 = MkHu "gyomorkeserű" "gyomorkeserű" ObjectRole Multiplicative 0 12
public export n_gyorse2tterem : HuWord
n_gyorse2tterem = MkHu "gyorsétterem" "gyorsétter" ObjectRole Multiplicative 32 12
public export n_gyullada2s : HuWord
n_gyullada2s = MkHu "gyulladás" "gyulladás" ObjectRole Additive 0 9
public export n_gye2ma2nt : HuWord
n_gye2ma2nt = MkHu "gyémánt" "gyémá" ObjectRole Additive 3 7
public export n_gyo2gyszerta2r : HuWord
n_gyo2gyszerta2r = MkHu "gyógyszertár" "gyógyszertár" ObjectRole Additive 0 12
public export n_gyo2gyula2s : HuWord
n_gyo2gyula2s = MkHu "gyógyulás" "gyógyulás" ObjectRole Additive 0 9
public export n_gyo2gyi2r : HuWord
n_gyo2gyi2r = MkHu "gyógyír" "gyógyír" ObjectRole Multiplicative 0 7
public export n_gyo2gyi2ttata2s : HuWord
n_gyo2gyi2ttata2s = MkHu "gyógyíttatás" "gyógyíttatás" ObjectRole Additive 0 12
public export n_gyo2gyi2ta2s : HuWord
n_gyo2gyi2ta2s = MkHu "gyógyítás" "gyógyítás" ObjectRole Additive 0 9
public export n_gyo3nysor : HuWord
n_gyo3nysor = MkHu "gyönysor" "gyönysor" ObjectRole Additive 0 8
public export n_gyo3trelem : HuWord
n_gyo3trelem = MkHu "gyötrelem" "gyötrel" ObjectRole Multiplicative 32 9
public export n_gyu2jto2s : HuWord
n_gyu2jto2s = MkHu "gyújtós" "gyújtós" ObjectRole Additive 0 7
public export n_gyu2le2s : HuWord
n_gyu2le2s = MkHu "gyúlés" "gyúlés" ObjectRole Multiplicative 0 6
public export n_gyu2rt : HuWord
n_gyu2rt = MkHu "gyúrt" "gyúr" ObjectRole Additive 2 5
public export n_gyu2ra2s : HuWord
n_gyu2ra2s = MkHu "gyúrás" "gyúrás" ObjectRole Additive 0 6
public export n_gyu2ro2 : HuWord
n_gyu2ro2 = MkHu "gyúró" "gyúró" ObjectRole Additive 0 5
public export n_gyu4jteme2ny : HuWord
n_gyu4jteme2ny = MkHu "gyűjtemény" "gyűjtemény" ObjectRole Multiplicative 0 10
public export n_gyu4jtete2s : HuWord
n_gyu4jtete2s = MkHu "gyűjtetés" "gyűjtetés" ObjectRole Multiplicative 0 9
public export n_gyu4jte2s : HuWord
n_gyu4jte2s = MkHu "gyűjtés" "gyűjtés" ObjectRole Multiplicative 0 7
public export n_gyu4jto4 : HuWord
n_gyu4jto4 = MkHu "gyűjtő" "gyűjtő" ObjectRole Multiplicative 0 6
public export n_gyu4lo3let : HuWord
n_gyu4lo3let = MkHu "gyűlölet" "gyűlöl" ObjectRole Multiplicative 2 8
public export n_ga2cse2r : HuWord
n_ga2cse2r = MkHu "gácsér" "gácsér" ObjectRole Multiplicative 0 6
public export n_ga2t : HuWord
n_ga2t = MkHu "gát" "gát" ObjectRole Additive 0 3
public export n_ga2zlo2 : HuWord
n_ga2zlo2 = MkHu "gázló" "gázló" ObjectRole Additive 0 5
public export n_ga2ztalani2ta2s : HuWord
n_ga2ztalani2ta2s = MkHu "gáztalanítás" "gáztalanítás" ObjectRole Additive 0 12
public export n_ge2pkocsioszlop : HuWord
n_ge2pkocsioszlop = MkHu "gépkocsioszlop" "gépkocsioszlop" ObjectRole Additive 0 14
public export n_go2lya : HuWord
n_go2lya = MkHu "gólya" "gólya" ObjectRole Additive 0 5
public export n_go3do3r : HuWord
n_go3do3r = MkHu "gödör" "gödör" ObjectRole Multiplicative 0 5
public export n_go3ndo3ri2tett : HuWord
n_go3ndo3ri2tett = MkHu "göndörített" "göndöríte" ObjectRole Multiplicative 8 11
public export n_go3ndo3ri2te2s : HuWord
n_go3ndo3ri2te2s = MkHu "göndörítés" "göndörítés" ObjectRole Multiplicative 0 10
public export n_go3ndo3ri2to4 : HuWord
n_go3ndo3ri2to4 = MkHu "göndörítő" "göndörítő" ObjectRole Multiplicative 0 9
public export n_go3ndo3ro3de2s : HuWord
n_go3ndo3ro3de2s = MkHu "göndörödés" "göndörödés" ObjectRole Multiplicative 0 10
public export n_go3ndo3ro3do3tt : HuWord
n_go3ndo3ro3do3tt = MkHu "göndörödött" "göndörödö" ObjectRole Multiplicative 8 11
public export n_go3ngyo3leg : HuWord
n_go3ngyo3leg = MkHu "göngyöleg" "göngyöleg" ObjectRole Multiplicative 0 9
public export n_go3re2ny : HuWord
n_go3re2ny = MkHu "görény" "görény" ObjectRole Multiplicative 0 6
public export n_go3ro3gdinnye : HuWord
n_go3ro3gdinnye = MkHu "görögdinnye" "görögdinnye" ObjectRole Multiplicative 0 11
public export n_gu2na2r : HuWord
n_gu2na2r = MkHu "gúnár" "gúnár" ObjectRole Additive 0 5
public export n_go4g : HuWord
n_go4g = MkHu "gőg" "gőg" ObjectRole Multiplicative 0 3
public export n_habzo2fu4 : HuWord
n_habzo2fu4 = MkHu "habzófű" "habzófű" ObjectRole Multiplicative 0 7
public export n_hadsereg : HuWord
n_hadsereg = MkHu "hadsereg" "hadsereg" ObjectRole Multiplicative 0 8
public export n_hajfu3rt : HuWord
n_hajfu3rt = MkHu "hajfürt" "hajfür" ObjectRole Multiplicative 2 7
public export n_hajlam : HuWord
n_hajlam = MkHu "hajlam" "hajlam" ObjectRole Additive 0 6
public export n_hajlando2sa2g : HuWord
n_hajlando2sa2g = MkHu "hajlandóság" "hajlandóság" ObjectRole Additive 0 11
public export n_hajle2ktalan : HuWord
n_hajle2ktalan = MkHu "hajléktalan" "hajléktala" ObjectRole Additive 1 11
public export n_hajtincs : HuWord
n_hajtincs = MkHu "hajtincs" "hajtincs" ObjectRole Multiplicative 0 8
public export n_hajta2s : HuWord
n_hajta2s = MkHu "hajtás" "hajtás" ObjectRole Additive 0 6
public export n_hajo2oldal : HuWord
n_hajo2oldal = MkHu "hajóoldal" "hajóoldal" ObjectRole Additive 0 9
public export n_halada2s : HuWord
n_halada2s = MkHu "haladás" "haladás" ObjectRole Additive 0 7
public export n_halado2 : HuWord
n_halado2 = MkHu "haladó" "haladó" ObjectRole Additive 0 6
public export n_hallgatag : HuWord
n_hallgatag = MkHu "hallgatag" "hallgatag" ObjectRole Additive 0 9
public export n_halom : HuWord
n_halom = MkHu "halom" "hal" ObjectRole Additive 32 5
public export n_halott : HuWord
n_halott = MkHu "halott" "halo" ObjectRole Additive 8 6
public export n_hala2l : HuWord
n_hala2l = MkHu "halál" "halál" ObjectRole Additive 0 5
public export n_hamisi2tva2ny : HuWord
n_hamisi2tva2ny = MkHu "hamisítvány" "hamisítvány" ObjectRole Additive 0 11
public export n_hangoskoda2s : HuWord
n_hangoskoda2s = MkHu "hangoskodás" "hangoskodás" ObjectRole Additive 0 11
public export n_hangoskodo2 : HuWord
n_hangoskodo2 = MkHu "hangoskodó" "hangoskodó" ObjectRole Additive 0 10
public export n_hanga2r : HuWord
n_hanga2r = MkHu "hangár" "hangár" ObjectRole Additive 0 6
public export n_hantmada2r : HuWord
n_hantmada2r = MkHu "hantmadár" "hantmadár" ObjectRole Additive 0 9
public export n_harasztfu4 : HuWord
n_harasztfu4 = MkHu "harasztfű" "harasztfű" ObjectRole Multiplicative 0 9
public export n_harc : HuWord
n_harc = MkHu "harc" "harc" ObjectRole Additive 0 4
public export n_harcos : HuWord
n_harcos = MkHu "harcos" "harcos" ObjectRole Additive 0 6
public export n_harmonika : HuWord
n_harmonika = MkHu "harmonika" "harmonika" ObjectRole Additive 0 9
public export n_harmonika2s : HuWord
n_harmonika2s = MkHu "harmonikás" "harmonikás" ObjectRole Additive 0 10
public export n_hasade2kvo3lgy : HuWord
n_hasade2kvo3lgy = MkHu "hasadékvölgy" "hasadékvölgy" ObjectRole Multiplicative 0 12
public export n_hastifusz : HuWord
n_hastifusz = MkHu "hastifusz" "hastifusz" ObjectRole Additive 0 9
public export n_hasznossa2g : HuWord
n_hasznossa2g = MkHu "hasznosság" "hasznosság" ObjectRole Additive 0 10
public export n_haszon : HuWord
n_haszon = MkHu "haszon" "hasz" ObjectRole Additive 1 6
public export n_haszontalansa2g : HuWord
n_haszontalansa2g = MkHu "haszontalanság" "haszontalanság" ObjectRole Additive 0 14
public export n_hasa2bfa : HuWord
n_hasa2bfa = MkHu "hasábfa" "hasábfa" ObjectRole Additive 0 7
public export n_hata2r : HuWord
n_hata2r = MkHu "határ" "határ" ObjectRole Additive 0 5
public export n_haza : HuWord
n_haza = MkHu "haza" "haza" ObjectRole Additive 0 4
public export n_hazaiak : HuWord
n_hazaiak = MkHu "hazaiak" "hazai" ObjectRole Multiplicative 4 7
public export n_hazate2re2s : HuWord
n_hazate2re2s = MkHu "hazatérés" "hazatérés" ObjectRole Multiplicative 0 9
public export n_hazug : HuWord
n_hazug = MkHu "hazug" "hazug" ObjectRole Additive 0 5
public export n_hazugsa2g : HuWord
n_hazugsa2g = MkHu "hazugság" "hazugság" ObjectRole Additive 0 8
public export n_hegygerinc : HuWord
n_hegygerinc = MkHu "hegygerinc" "hegygerinc" ObjectRole Multiplicative 0 10
public export n_hegyla2b : HuWord
n_hegyla2b = MkHu "hegyláb" "hegyláb" ObjectRole Additive 0 7
public export n_hely : HuWord
n_hely = MkHu "hely" "hely" ObjectRole Multiplicative 0 4
public export n_helyes : HuWord
n_helyes = MkHu "helyes" "helyes" ObjectRole Multiplicative 0 6
public export n_hemzsege2s : HuWord
n_hemzsege2s = MkHu "hemzsegés" "hemzsegés" ObjectRole Multiplicative 0 9
public export n_hencegett : HuWord
n_hencegett = MkHu "hencegett" "hencege" ObjectRole Multiplicative 8 9
public export n_hencege2s : HuWord
n_hencege2s = MkHu "hencegés" "hencegés" ObjectRole Multiplicative 0 8
public export n_hencego4 : HuWord
n_hencego4 = MkHu "hencegő" "hencegő" ObjectRole Multiplicative 0 7
public export n_henye2lo4 : HuWord
n_henye2lo4 = MkHu "henyélő" "henyélő" ObjectRole Multiplicative 0 7
public export n_hetvenkede2s : HuWord
n_hetvenkede2s = MkHu "hetvenkedés" "hetvenkedés" ObjectRole Multiplicative 0 11
public export n_heveskede2s : HuWord
n_heveskede2s = MkHu "heveskedés" "heveskedés" ObjectRole Multiplicative 0 10
public export n_hiba : HuWord
n_hiba = MkHu "hiba" "hiba" ObjectRole Additive 0 4
public export n_himnusz : HuWord
n_himnusz = MkHu "himnusz" "himnusz" ObjectRole Additive 0 7
public export n_hirdetme2ny : HuWord
n_hirdetme2ny = MkHu "hirdetmény" "hirdetmény" ObjectRole Multiplicative 0 10
public export n_hirdete2s : HuWord
n_hirdete2s = MkHu "hirdetés" "hirdetés" ObjectRole Multiplicative 0 8
public export n_hitetlen : HuWord
n_hitetlen = MkHu "hitetlen" "hitetl" ObjectRole Multiplicative 1 8
public export n_hia2ba : HuWord
n_hia2ba = MkHu "hiába" "hiá" ObjectRole Additive 1 5
public export n_hia2bavalo2sa2g : HuWord
n_hia2bavalo2sa2g = MkHu "hiábavalóság" "hiábavalóság" ObjectRole Additive 0 12
public export n_hiu2z : HuWord
n_hiu2z = MkHu "hiúz" "hiúz" ObjectRole Additive 0 4
public export n_hiu2zko3lyo3k : HuWord
n_hiu2zko3lyo3k = MkHu "hiúzkölyök" "hiúzköly" ObjectRole Multiplicative 4 10
public export n_holmi : HuWord
n_holmi = MkHu "holmi" "holmi" ObjectRole Multiplicative 0 5
public export n_holt : HuWord
n_holt = MkHu "holt" "hol" ObjectRole Additive 2 4
public export n_homba2r : HuWord
n_homba2r = MkHu "hombár" "hombár" ObjectRole Additive 0 6
public export n_homlokzat : HuWord
n_homlokzat = MkHu "homlokzat" "homlokz" ObjectRole Additive 2 9
public export n_homokdu4ne : HuWord
n_homokdu4ne = MkHu "homokdűne" "homokdűne" ObjectRole Multiplicative 0 9
public export n_homokfuto2 : HuWord
n_homokfuto2 = MkHu "homokfutó" "homokfutó" ObjectRole Additive 0 9
public export n_hordo2 : HuWord
n_hordo2 = MkHu "hordó" "hordó" ObjectRole Additive 0 5
public export n_hozza2adata2s : HuWord
n_hozza2adata2s = MkHu "hozzáadatás" "hozzáadatás" ObjectRole Additive 0 11
public export n_hozza2e2rte2s : HuWord
n_hozza2e2rte2s = MkHu "hozzáértés" "hozzáértés" ObjectRole Multiplicative 0 10
public export n_hulla2mza2s : HuWord
n_hulla2mza2s = MkHu "hullámzás" "hullámzás" ObjectRole Additive 0 9
public export n_ha2borgata2s : HuWord
n_ha2borgata2s = MkHu "háborgatás" "háborgatás" ObjectRole Additive 0 10
public export n_ha2la : HuWord
n_ha2la = MkHu "hála" "hála" ObjectRole Additive 0 4
public export n_ha2lyog : HuWord
n_ha2lyog = MkHu "hályog" "hályog" ObjectRole Additive 0 6
public export n_ha2lo2szoba : HuWord
n_ha2lo2szoba = MkHu "hálószoba" "hálószo" ObjectRole Additive 1 9
public export n_ha2lo2sza2ri2to2a2llva2ny : HuWord
n_ha2lo2sza2ri2to2a2llva2ny = MkHu "hálószárítóállvány" "hálószárítóállvány" ObjectRole Additive 0 18
public export n_ha2ncssepro4 : HuWord
n_ha2ncssepro4 = MkHu "háncsseprő" "háncsseprő" ObjectRole Multiplicative 0 10
public export n_ha2rfa : HuWord
n_ha2rfa = MkHu "hárfa" "hárfa" ObjectRole Additive 0 5
public export n_ha2rs : HuWord
n_ha2rs = MkHu "hárs" "hárs" ObjectRole Additive 0 4
public export n_ha2rsfa : HuWord
n_ha2rsfa = MkHu "hársfa" "hársfa" ObjectRole Additive 0 6
public export n_ha2rsfaerdo4 : HuWord
n_ha2rsfaerdo4 = MkHu "hársfaerdő" "hársfaerdő" ObjectRole Multiplicative 0 10
public export n_ha2trafordult : HuWord
n_ha2trafordult = MkHu "hátrafordult" "hátrafordul" ObjectRole Additive 2 12
public export n_ha2trafordula2s : HuWord
n_ha2trafordula2s = MkHu "hátrafordulás" "hátrafordulás" ObjectRole Additive 0 13
public export n_ha2trafordi2ta2s : HuWord
n_ha2trafordi2ta2s = MkHu "hátrafordítás" "hátrafordítás" ObjectRole Additive 0 13
public export n_ha2tra2la2s : HuWord
n_ha2tra2la2s = MkHu "hátrálás" "hátrálás" ObjectRole Additive 0 8
public export n_ha2tso2udvar : HuWord
n_ha2tso2udvar = MkHu "hátsóudvar" "hátsóudvar" ObjectRole Additive 0 10
public export n_ha2zassa2g : HuWord
n_ha2zassa2g = MkHu "házasság" "házasság" ObjectRole Additive 0 8
public export n_ha2ziko2 : HuWord
n_ha2ziko2 = MkHu "házikó" "házikó" ObjectRole Additive 0 6
public export n_ha2ziszellem : HuWord
n_ha2ziszellem = MkHu "háziszellem" "háziszell" ObjectRole Multiplicative 32 11
public export n_ha2ziszo4ttes : HuWord
n_ha2ziszo4ttes = MkHu "háziszőttes" "háziszőttes" ObjectRole Multiplicative 0 11
public export n_he2ja : HuWord
n_he2ja = MkHu "héja" "héja" ObjectRole Additive 0 4
public export n_he2t : HuWord
n_he2t = MkHu "hét" "hét" ObjectRole Multiplicative 0 3
public export n_he2tfo4 : HuWord
n_he2tfo4 = MkHu "hétfő" "hétfő" ObjectRole Multiplicative 0 5
public export n_hi2m : HuWord
n_hi2m = MkHu "hím" "hím" ObjectRole Multiplicative 0 3
public export n_hi2mharaszt : HuWord
n_hi2mharaszt = MkHu "hímharaszt" "hímharasz" ObjectRole Additive 2 10
public export n_hi2na2r : HuWord
n_hi2na2r = MkHu "hínár" "hínár" ObjectRole Additive 0 5
public export n_hi2za2s : HuWord
n_hi2za2s = MkHu "hízás" "hízás" ObjectRole Additive 0 5
public export n_ho2csizma : HuWord
n_ho2csizma = MkHu "hócsizma" "hócsizma" ObjectRole Additive 0 8
public export n_ho2d : HuWord
n_ho2d = MkHu "hód" "hód" ObjectRole Additive 0 3
public export n_ho2dko3lyo3k : HuWord
n_ho2dko3lyo3k = MkHu "hódkölyök" "hódköly" ObjectRole Multiplicative 4 9
public export n_ho2vihar : HuWord
n_ho2vihar = MkHu "hóvihar" "hóvihar" ObjectRole Additive 0 7
public export n_ho3rcso3g : HuWord
n_ho3rcso3g = MkHu "hörcsög" "hörcsög" ObjectRole Multiplicative 0 7
public export n_ho3rghurut : HuWord
n_ho3rghurut = MkHu "hörghurut" "hörghuru" ObjectRole Additive 2 9
public export n_hu2gyho2lyagh : HuWord
n_hu2gyho2lyagh = MkHu "húgyhólyagh" "húgyhólyagh" ObjectRole Additive 0 11
public export n_hu2sve2t : HuWord
n_hu2sve2t = MkHu "húsvét" "húsvé" ObjectRole Multiplicative 2 6
public export n_ho4s : HuWord
n_ho4s = MkHu "hős" "hős" ObjectRole Multiplicative 0 3
public export n_ho4siesse2g : HuWord
n_ho4siesse2g = MkHu "hősiesség" "hősiesség" ObjectRole Multiplicative 0 9
public export n_ho4sko3de2s : HuWord
n_ho4sko3de2s = MkHu "hősködés" "hősködés" ObjectRole Multiplicative 0 8
public export n_ho4stett : HuWord
n_ho4stett = MkHu "hőstett" "hőste" ObjectRole Multiplicative 8 7
public export n_hu4to4auto2 : HuWord
n_hu4to4auto2 = MkHu "hűtőautó" "hűtőautó" ObjectRole Additive 0 8
public export n_idegeskede2s : HuWord
n_idegeskede2s = MkHu "idegeskedés" "idegeskedés" ObjectRole Multiplicative 0 11
public export n_idegesi2te2s : HuWord
n_idegesi2te2s = MkHu "idegesítés" "idegesítés" ObjectRole Multiplicative 0 10
public export n_ide2zet : HuWord
n_ide2zet = MkHu "idézet" "idéz" ObjectRole Multiplicative 2 6
public export n_iga : HuWord
n_iga = MkHu "iga" "iga" ObjectRole Additive 0 3
public export n_igen : HuWord
n_igen = MkHu "igen" "ige" ObjectRole Multiplicative 1 4
public export n_ige2nytelen : HuWord
n_ige2nytelen = MkHu "igénytelen" "igénytel" ObjectRole Multiplicative 1 10
public export n_ingova2ny : HuWord
n_ingova2ny = MkHu "ingovány" "ingovány" ObjectRole Additive 0 8
public export n_integrita2s : HuWord
n_integrita2s = MkHu "integritás" "integritás" ObjectRole Additive 0 10
public export n_ira2nyi2ta2s : HuWord
n_ira2nyi2ta2s = MkHu "irányítás" "irányítás" ObjectRole Additive 0 9
public export n_istentisztelet : HuWord
n_istentisztelet = MkHu "istentisztelet" "istentisztel" ObjectRole Multiplicative 2 14
public export n_istra2ng : HuWord
n_istra2ng = MkHu "istráng" "istráng" ObjectRole Additive 0 7
public export n_isza2kos : HuWord
n_isza2kos = MkHu "iszákos" "iszákos" ObjectRole Additive 0 7
public export n_ite2lkeze2s : HuWord
n_ite2lkeze2s = MkHu "itélkezés" "itélkezés" ObjectRole Multiplicative 0 9
public export n_izga2ga : HuWord
n_izga2ga = MkHu "izgága" "izgága" ObjectRole Additive 0 6
public export n_izmok : HuWord
n_izmok = MkHu "izmok" "izm" ObjectRole Multiplicative 4 5
public export n_izom : HuWord
n_izom = MkHu "izom" "izom" ObjectRole Additive 0 4
public export n_izzadsa2g : HuWord
n_izzadsa2g = MkHu "izzadság" "izzadság" ObjectRole Additive 0 8
public export n_izzada2s : HuWord
n_izzada2s = MkHu "izzadás" "izzadás" ObjectRole Additive 0 7
public export n_javi2ttata2s : HuWord
n_javi2ttata2s = MkHu "javíttatás" "javíttatás" ObjectRole Additive 0 10
public export n_javi2ta2s : HuWord
n_javi2ta2s = MkHu "javítás" "javítás" ObjectRole Additive 0 7
public export n_jegy : HuWord
n_jegy = MkHu "jegy" "jegy" ObjectRole Multiplicative 0 4
public export n_jegyzetfu3zet : HuWord
n_jegyzetfu3zet = MkHu "jegyzetfüzet" "jegyzetfüz" ObjectRole Multiplicative 2 12
public export n_jelen : HuWord
n_jelen = MkHu "jelen" "jel" ObjectRole Multiplicative 1 5
public export n_juh : HuWord
n_juh = MkHu "juh" "juh" ObjectRole Additive 0 3
public export n_juharcse2sze : HuWord
n_juharcse2sze = MkHu "juharcsésze" "juharcsésze" ObjectRole Multiplicative 0 11
public export n_juhtu2ro2 : HuWord
n_juhtu2ro2 = MkHu "juhtúró" "juhtúró" ObjectRole Additive 0 7
public export n_ja2rom : HuWord
n_ja2rom = MkHu "járom" "jár" ObjectRole Additive 32 5
public export n_ja2romcsengo4 : HuWord
n_ja2romcsengo4 = MkHu "járomcsengő" "járomcsengő" ObjectRole Multiplicative 0 11
public export n_ja2romcsont : HuWord
n_ja2romcsont = MkHu "járomcsont" "járomcso" ObjectRole Additive 3 10
public export n_ja2rtassa2g : HuWord
n_ja2rtassa2g = MkHu "jártasság" "jártasság" ObjectRole Additive 0 9
public export n_ja2tszo2hely : HuWord
n_ja2tszo2hely = MkHu "játszóhely" "játszóhely" ObjectRole Multiplicative 0 10
public export n_ja2vorszarvas : HuWord
n_ja2vorszarvas = MkHu "jávorszarvas" "jávorszarvas" ObjectRole Additive 0 12
public export n_jo2kedv : HuWord
n_jo2kedv = MkHu "jókedv" "jókedv" ObjectRole Multiplicative 0 6
public export n_jo2s : HuWord
n_jo2s = MkHu "jós" "jós" ObjectRole Additive 0 3
public export n_jo2sla2s : HuWord
n_jo2sla2s = MkHu "jóslás" "jóslás" ObjectRole Additive 0 6
public export n_jo2sno4 : HuWord
n_jo2sno4 = MkHu "jósnő" "jósnő" ObjectRole Multiplicative 0 5
public export n_jo3vo4 : HuWord
n_jo3vo4 = MkHu "jövő" "jövő" ObjectRole Multiplicative 0 4
public export n_kafta2n : HuWord
n_kafta2n = MkHu "kaftán" "kaftá" ObjectRole Additive 1 6
public export n_kajak : HuWord
n_kajak = MkHu "kajak" "kaj" ObjectRole Additive 4 5
public export n_kakas : HuWord
n_kakas = MkHu "kakas" "kakas" ObjectRole Additive 0 5
public export n_kakascsibe : HuWord
n_kakascsibe = MkHu "kakascsibe" "kakascsi" ObjectRole Multiplicative 1 10
public export n_kakaskoda2s : HuWord
n_kakaskoda2s = MkHu "kakaskodás" "kakaskodás" ObjectRole Additive 0 10
public export n_kakastaraj : HuWord
n_kakastaraj = MkHu "kakastaraj" "kakastara" ObjectRole Additive 16 10
public export n_kakastare2j : HuWord
n_kakastare2j = MkHu "kakastaréj" "kakastaré" ObjectRole Multiplicative 16 10
public export n_kakukk : HuWord
n_kakukk = MkHu "kakukk" "kakuk" ObjectRole Additive 4 6
public export n_kaland : HuWord
n_kaland = MkHu "kaland" "kaland" ObjectRole Additive 0 6
public export n_kalandor : HuWord
n_kalandor = MkHu "kalandor" "kalandor" ObjectRole Additive 0 8
public export n_kalandorno4 : HuWord
n_kalandorno4 = MkHu "kalandornő" "kalandornő" ObjectRole Multiplicative 0 10
public export n_kalandorsa2g : HuWord
n_kalandorsa2g = MkHu "kalandorság" "kalandorság" ObjectRole Additive 0 11
public export n_kalapa2csfej : HuWord
n_kalapa2csfej = MkHu "kalapácsfej" "kalapácsfe" ObjectRole Multiplicative 16 11
public export n_kalo2ria : HuWord
n_kalo2ria = MkHu "kalória" "kalória" ObjectRole Additive 0 7
public export n_kampa2nyola2s : HuWord
n_kampa2nyola2s = MkHu "kampányolás" "kampányolás" ObjectRole Additive 0 11
public export n_kandiszno2 : HuWord
n_kandiszno2 = MkHu "kandisznó" "kandisznó" ObjectRole Additive 0 9
public export n_kandu2r : HuWord
n_kandu2r = MkHu "kandúr" "kandúr" ObjectRole Additive 0 6
public export n_kanna : HuWord
n_kanna = MkHu "kanna" "kanna" ObjectRole Additive 0 5
public export n_kanyar : HuWord
n_kanyar = MkHu "kanyar" "kanyar" ObjectRole Additive 0 6
public export n_kapca : HuWord
n_kapca = MkHu "kapca" "kapca" ObjectRole Additive 0 5
public export n_kapucni : HuWord
n_kapucni = MkHu "kapucni" "kapuc" ObjectRole Additive 8 7
public export n_kapzsi : HuWord
n_kapzsi = MkHu "kapzsi" "kapzsi" ObjectRole Multiplicative 0 6
public export n_kapzsisa2g : HuWord
n_kapzsisa2g = MkHu "kapzsiság" "kapzsiság" ObjectRole Additive 0 9
public export n_karko3to4 : HuWord
n_karko3to4 = MkHu "karkötő" "karkötő" ObjectRole Multiplicative 0 7
public export n_kartonva2szon : HuWord
n_kartonva2szon = MkHu "kartonvászon" "kartonvász" ObjectRole Additive 1 12
public export n_karvalybagoly : HuWord
n_karvalybagoly = MkHu "karvalybagoly" "karvalybagoly" ObjectRole Additive 0 13
public export n_katona : HuWord
n_katona = MkHu "katona" "katona" ObjectRole Additive 0 6
public export n_katonasa2g : HuWord
n_katonasa2g = MkHu "katonaság" "katonaság" ObjectRole Additive 0 9
public export n_kavarga2s : HuWord
n_kavarga2s = MkHu "kavargás" "kavargás" ObjectRole Additive 0 8
public export n_kecskedi2sz : HuWord
n_kecskedi2sz = MkHu "kecskedísz" "kecskedísz" ObjectRole Multiplicative 0 10
public export n_kegyelet : HuWord
n_kegyelet = MkHu "kegyelet" "kegyel" ObjectRole Multiplicative 2 8
public export n_keletkeze2s : HuWord
n_keletkeze2s = MkHu "keletkezés" "keletkezés" ObjectRole Multiplicative 0 10
public export n_keletkezo4 : HuWord
n_keletkezo4 = MkHu "keletkező" "keletkező" ObjectRole Multiplicative 0 9
public export n_kelle2k : HuWord
n_kelle2k = MkHu "kellék" "kellé" ObjectRole Multiplicative 4 6
public export n_kenderke2ve : HuWord
n_kenderke2ve = MkHu "kenderkéve" "kenderkéve" ObjectRole Multiplicative 0 10
public export n_keresztcsont : HuWord
n_keresztcsont = MkHu "keresztcsont" "keresztcso" ObjectRole Additive 3 12
public export n_kergeko2r : HuWord
n_kergeko2r = MkHu "kergekór" "kergekór" ObjectRole Additive 0 8
public export n_keringe2s : HuWord
n_keringe2s = MkHu "keringés" "keringés" ObjectRole Multiplicative 0 8
public export n_kert : HuWord
n_kert = MkHu "kert" "ker" ObjectRole Multiplicative 2 4
public export n_kerte2sz : HuWord
n_kerte2sz = MkHu "kertész" "kertész" ObjectRole Multiplicative 0 7
public export n_kere2kagy : HuWord
n_kere2kagy = MkHu "kerékagy" "kerékagy" ObjectRole Additive 0 8
public export n_keri2te2s : HuWord
n_keri2te2s = MkHu "kerítés" "kerítés" ObjectRole Multiplicative 0 7
public export n_kezdeme2nyeze2s : HuWord
n_kezdeme2nyeze2s = MkHu "kezdeményezés" "kezdeményezés" ObjectRole Multiplicative 0 13
public export n_kezde2s : HuWord
n_kezde2s = MkHu "kezdés" "kezdés" ObjectRole Multiplicative 0 6
public export n_kiada2s : HuWord
n_kiada2s = MkHu "kiadás" "kiadás" ObjectRole Additive 0 6
public export n_kibo4vi2ttete2s : HuWord
n_kibo4vi2ttete2s = MkHu "kibővíttetés" "kibővíttetés" ObjectRole Multiplicative 0 12
public export n_kibo4vi2te2s : HuWord
n_kibo4vi2te2s = MkHu "kibővítés" "kibővítés" ObjectRole Multiplicative 0 9
public export n_kicsavara2s : HuWord
n_kicsavara2s = MkHu "kicsavarás" "kicsavarás" ObjectRole Additive 0 10
public export n_kidu3llede2s : HuWord
n_kidu3llede2s = MkHu "kidülledés" "kidülledés" ObjectRole Multiplicative 0 10
public export n_kiege2szi2ttete2s : HuWord
n_kiege2szi2ttete2s = MkHu "kiegészíttetés" "kiegészíttetés" ObjectRole Multiplicative 0 14
public export n_kiege2szi2te2s : HuWord
n_kiege2szi2te2s = MkHu "kiegészítés" "kiegészítés" ObjectRole Multiplicative 0 11
public export n_kiemelkede2s : HuWord
n_kiemelkede2s = MkHu "kiemelkedés" "kiemelkedés" ObjectRole Multiplicative 0 11
public export n_kifakada2sa : HuWord
n_kifakada2sa = MkHu "kifakadása" "kifakadása" ObjectRole Additive 0 10
public export n_kifakula2s : HuWord
n_kifakula2s = MkHu "kifakulás" "kifakulás" ObjectRole Additive 0 9
public export n_kifaki2ta2s : HuWord
n_kifaki2ta2s = MkHu "kifakítás" "kifakítás" ObjectRole Additive 0 9
public export n_kifcami2ta2s : HuWord
n_kifcami2ta2s = MkHu "kifcamítás" "kifcamítás" ObjectRole Additive 0 10
public export n_kificamoda2s : HuWord
n_kificamoda2s = MkHu "kificamodás" "kificamodás" ObjectRole Additive 0 11
public export n_kificami2ttata2s : HuWord
n_kificami2ttata2s = MkHu "kificamíttatás" "kificamíttatás" ObjectRole Additive 0 14
public export n_kificami2ta2s : HuWord
n_kificami2ta2s = MkHu "kificamítás" "kificamítás" ObjectRole Additive 0 11
public export n_kifordi2ttata2s : HuWord
n_kifordi2ttata2s = MkHu "kifordíttatás" "kifordíttatás" ObjectRole Additive 0 13
public export n_kifordi2ta2s : HuWord
n_kifordi2ta2s = MkHu "kifordítás" "kifordítás" ObjectRole Additive 0 10
public export n_kifa2raszta2s : HuWord
n_kifa2raszta2s = MkHu "kifárasztás" "kifárasztás" ObjectRole Additive 0 11
public export n_kigo3mbo3lyi2te2s : HuWord
n_kigo3mbo3lyi2te2s = MkHu "kigömbölyítés" "kigömbölyítés" ObjectRole Multiplicative 0 13
public export n_kigo3mbo3lyo3de2s : HuWord
n_kigo3mbo3lyo3de2s = MkHu "kigömbölyödés" "kigömbölyödés" ObjectRole Multiplicative 0 13
public export n_kihajta2s : HuWord
n_kihajta2s = MkHu "kihajtás" "kihajtás" ObjectRole Additive 0 8
public export n_kikerekede2s : HuWord
n_kikerekede2s = MkHu "kikerekedés" "kikerekedés" ObjectRole Multiplicative 0 11
public export n_kikereki2te2s : HuWord
n_kikereki2te2s = MkHu "kikerekítés" "kikerekítés" ObjectRole Multiplicative 0 11
public export n_kimeri2te2s : HuWord
n_kimeri2te2s = MkHu "kimerítés" "kimerítés" ObjectRole Multiplicative 0 9
public export n_kimeru3le2s : HuWord
n_kimeru3le2s = MkHu "kimerülés" "kimerülés" ObjectRole Multiplicative 0 9
public export n_kipusztula2s : HuWord
n_kipusztula2s = MkHu "kipusztulás" "kipusztulás" ObjectRole Additive 0 11
public export n_kirakata2s : HuWord
n_kirakata2s = MkHu "kirakatás" "kirakatás" ObjectRole Additive 0 9
public export n_kirakodtata2s : HuWord
n_kirakodtata2s = MkHu "kirakodtatás" "kirakodtatás" ObjectRole Additive 0 12
public export n_kirakoda2s : HuWord
n_kirakoda2s = MkHu "kirakodás" "kirakodás" ObjectRole Additive 0 9
public export n_kiraka2s : HuWord
n_kiraka2s = MkHu "kirakás" "kirakás" ObjectRole Additive 0 7
public export n_kisasszony : HuWord
n_kisasszony = MkHu "kisasszony" "kisasszony" ObjectRole Additive 0 10
public export n_kisbolygo2k : HuWord
n_kisbolygo2k = MkHu "kisbolygók" "kisbolygó" ObjectRole Additive 4 10
public export n_kista2nye2r : HuWord
n_kista2nye2r = MkHu "kistányér" "kistányér" ObjectRole Multiplicative 0 9
public export n_kivesze2s : HuWord
n_kivesze2s = MkHu "kiveszés" "kiveszés" ObjectRole Multiplicative 0 8
public export n_kiva2laszta2s : HuWord
n_kiva2laszta2s = MkHu "kiválasztás" "kiválasztás" ObjectRole Additive 0 11
public export n_kiva2logattata2s : HuWord
n_kiva2logattata2s = MkHu "kiválogattatás" "kiválogattatás" ObjectRole Additive 0 14
public export n_kiva2logata2s : HuWord
n_kiva2logata2s = MkHu "kiválogatás" "kiválogatás" ObjectRole Additive 0 11
public export n_kia2lli2ta2s : HuWord
n_kia2lli2ta2s = MkHu "kiállítás" "kiállítás" ObjectRole Additive 0 9
public export n_kiu3ri2ttete2s : HuWord
n_kiu3ri2ttete2s = MkHu "kiüríttetés" "kiüríttetés" ObjectRole Multiplicative 0 11
public export n_kiu3ri2te2s : HuWord
n_kiu3ri2te2s = MkHu "kiürítés" "kiürítés" ObjectRole Multiplicative 0 8
public export n_kiu3ru3le2s : HuWord
n_kiu3ru3le2s = MkHu "kiürülés" "kiürülés" ObjectRole Multiplicative 0 8
public export n_koagula2la2s : HuWord
n_koagula2la2s = MkHu "koagulálás" "koagulálás" ObjectRole Additive 0 10
public export n_kobak : HuWord
n_kobak = MkHu "kobak" "kob" ObjectRole Additive 4 5
public export n_konkoly : HuWord
n_konkoly = MkHu "konkoly" "konkoly" ObjectRole Additive 0 7
public export n_konta2r : HuWord
n_konta2r = MkHu "kontár" "kontár" ObjectRole Additive 0 6
public export n_korallza2tony : HuWord
n_korallza2tony = MkHu "korallzátony" "korallzátony" ObjectRole Additive 0 12
public export n_korga2s : HuWord
n_korga2s = MkHu "korgás" "korgás" ObjectRole Additive 0 6
public export n_korla2t : HuWord
n_korla2t = MkHu "korlát" "korlá" ObjectRole Additive 2 6
public export n_kormora2n : HuWord
n_kormora2n = MkHu "kormorán" "kormorá" ObjectRole Additive 1 8
public export n_korma2nytagok : HuWord
n_korma2nytagok = MkHu "kormánytagok" "kormánytag" ObjectRole Additive 4 12
public export n_kosbor : HuWord
n_kosbor = MkHu "kosbor" "kosbor" ObjectRole Additive 0 6
public export n_kosa2rlabda : HuWord
n_kosa2rlabda = MkHu "kosárlabda" "kosárlabda" ObjectRole Additive 0 10
public export n_krokodil : HuWord
n_krokodil = MkHu "krokodil" "krokodil" ObjectRole Multiplicative 0 8
public export n_krumlipu3re2 : HuWord
n_krumlipu3re2 = MkHu "krumlipüré" "krumlipüré" ObjectRole Multiplicative 0 10
public export n_krumpli : HuWord
n_krumpli = MkHu "krumpli" "krumpli" ObjectRole Multiplicative 0 7
public export n_kre2ta : HuWord
n_kre2ta = MkHu "kréta" "kréta" ObjectRole Additive 0 5
public export n_kukore2kola2s : HuWord
n_kukore2kola2s = MkHu "kukorékolás" "kukorékolás" ObjectRole Additive 0 11
public export n_kultura2ltsa2g : HuWord
n_kultura2ltsa2g = MkHu "kulturáltság" "kulturáltság" ObjectRole Additive 0 12
public export n_kultu2ra : HuWord
n_kultu2ra = MkHu "kultúra" "kultú" ObjectRole Additive 1 7
public export n_kuruttyola2s : HuWord
n_kuruttyola2s = MkHu "kuruttyolás" "kuruttyolás" ObjectRole Additive 0 11
public export n_kuruzsla2s : HuWord
n_kuruzsla2s = MkHu "kuruzslás" "kuruzslás" ObjectRole Additive 0 9
public export n_kuruzslo2 : HuWord
n_kuruzslo2 = MkHu "kuruzsló" "kuruzsló" ObjectRole Additive 0 8
public export n_kutya : HuWord
n_kutya = MkHu "kutya" "kutya" ObjectRole Additive 0 5
public export n_ka2d : HuWord
n_ka2d = MkHu "kád" "kád" ObjectRole Additive 0 3
public export n_ka2da2r : HuWord
n_ka2da2r = MkHu "kádár" "kádár" ObjectRole Additive 0 5
public export n_ka2r : HuWord
n_ka2r = MkHu "kár" "kár" ObjectRole Additive 0 3
public export n_ka2ro2 : HuWord
n_ka2ro2 = MkHu "káró" "káró" ObjectRole Additive 0 4
public export n_ke2nyeskede2s : HuWord
n_ke2nyeskede2s = MkHu "kényeskedés" "kényeskedés" ObjectRole Multiplicative 0 11
public export n_ke2nyszermunka : HuWord
n_ke2nyszermunka = MkHu "kényszermunka" "kényszermunka" ObjectRole Additive 0 13
public export n_ke2pes : HuWord
n_ke2pes = MkHu "képes" "képes" ObjectRole Multiplicative 0 5
public export n_ke2pesse2g : HuWord
n_ke2pesse2g = MkHu "képesség" "képesség" ObjectRole Multiplicative 0 8
public export n_ke2pzettse2g : HuWord
n_ke2pzettse2g = MkHu "képzettség" "képzettség" ObjectRole Multiplicative 0 10
public export n_ke2rdo4i2v : HuWord
n_ke2rdo4i2v = MkHu "kérdőív" "kérdőív" ObjectRole Multiplicative 0 7
public export n_ke2rem : HuWord
n_ke2rem = MkHu "kérem" "kér" ObjectRole Multiplicative 32 5
public export n_ke2szse2g : HuWord
n_ke2szse2g = MkHu "készség" "készség" ObjectRole Multiplicative 0 7
public export n_ke2szu3le2k : HuWord
n_ke2szu3le2k = MkHu "készülék" "készülé" ObjectRole Multiplicative 4 8
public export n_ke2szu3lo4de2s : HuWord
n_ke2szu3lo4de2s = MkHu "készülődés" "készülődés" ObjectRole Multiplicative 0 10
public export n_ke2se2s : HuWord
n_ke2se2s = MkHu "késés" "késés" ObjectRole Multiplicative 0 5
public export n_ke2so4bb : HuWord
n_ke2so4bb = MkHu "később" "később" ObjectRole Multiplicative 0 6
public export n_ke2tse2gbeese2s : HuWord
n_ke2tse2gbeese2s = MkHu "kétségbeesés" "kétségbeesés" ObjectRole Multiplicative 0 12
public export n_ki2nszenvede2s : HuWord
n_ki2nszenvede2s = MkHu "kínszenvedés" "kínszenvedés" ObjectRole Multiplicative 0 12
public export n_ko2pe2 : HuWord
n_ko2pe2 = MkHu "kópé" "kópé" ObjectRole Multiplicative 0 4
public export n_ko2rha2z : HuWord
n_ko2rha2z = MkHu "kórház" "kórház" ObjectRole Additive 0 6
public export n_ko3d : HuWord
n_ko3d = MkHu "köd" "köd" ObjectRole Multiplicative 0 3
public export n_ko3do3si2te2s : HuWord
n_ko3do3si2te2s = MkHu "ködösítés" "ködösítés" ObjectRole Multiplicative 0 9
public export n_ko3ke2ny : HuWord
n_ko3ke2ny = MkHu "kökény" "kökény" ObjectRole Multiplicative 0 6
public export n_ko3lcso3nszavak : HuWord
n_ko3lcso3nszavak = MkHu "kölcsönszavak" "kölcsönszav" ObjectRole Additive 4 13
public export n_ko3lcso3nze2s : HuWord
n_ko3lcso3nze2s = MkHu "kölcsönzés" "kölcsönzés" ObjectRole Multiplicative 0 10
public export n_ko3ltse2g : HuWord
n_ko3ltse2g = MkHu "költség" "költség" ObjectRole Multiplicative 0 7
public export n_ko3nnyeze2s : HuWord
n_ko3nnyeze2s = MkHu "könnyezés" "könnyezés" ObjectRole Multiplicative 0 9
public export n_ko3nyvele2s : HuWord
n_ko3nyvele2s = MkHu "könyvelés" "könyvelés" ObjectRole Multiplicative 0 9
public export n_ko3nyvelo4 : HuWord
n_ko3nyvelo4 = MkHu "könyvelő" "könyvelő" ObjectRole Multiplicative 0 8
public export n_ko3nyvta2r : HuWord
n_ko3nyvta2r = MkHu "könyvtár" "könyvtár" ObjectRole Additive 0 8
public export n_ko3nyvta2ros : HuWord
n_ko3nyvta2ros = MkHu "könyvtáros" "könyvtáros" ObjectRole Additive 0 10
public export n_ko3nyvvitel : HuWord
n_ko3nyvvitel = MkHu "könyvvitel" "könyvvitel" ObjectRole Multiplicative 0 10
public export n_ko3pu3le2s : HuWord
n_ko3pu3le2s = MkHu "köpülés" "köpülés" ObjectRole Multiplicative 0 7
public export n_ko3pu3lo4fa : HuWord
n_ko3pu3lo4fa = MkHu "köpülőfa" "köpülőfa" ObjectRole Additive 0 8
public export n_ko3szo3net : HuWord
n_ko3szo3net = MkHu "köszönet" "kösz" ObjectRole Multiplicative 3 8
public export n_ko3szo3ru4ko4 : HuWord
n_ko3szo3ru4ko4 = MkHu "köszörűkő" "köszörűkő" ObjectRole Multiplicative 0 9
public export n_ko3teg : HuWord
n_ko3teg = MkHu "köteg" "köteg" ObjectRole Multiplicative 0 5
public export n_ko3tekede2s : HuWord
n_ko3tekede2s = MkHu "kötekedés" "kötekedés" ObjectRole Multiplicative 0 9
public export n_ko3tszer : HuWord
n_ko3tszer = MkHu "kötszer" "kötszer" ObjectRole Multiplicative 0 7
public export n_ko3te2l : HuWord
n_ko3te2l = MkHu "kötél" "kötél" ObjectRole Multiplicative 0 5
public export n_ko3te2ny : HuWord
n_ko3te2ny = MkHu "kötény" "kötény" ObjectRole Multiplicative 0 6
public export n_ko3te2s : HuWord
n_ko3te2s = MkHu "kötés" "kötés" ObjectRole Multiplicative 0 5
public export n_ko3to3zko3dik : HuWord
n_ko3to3zko3dik = MkHu "kötözködik" "kötözködi" ObjectRole Multiplicative 4 10
public export n_ko3to3ze2s : HuWord
n_ko3to3ze2s = MkHu "kötözés" "kötözés" ObjectRole Multiplicative 0 7
public export n_ko3to4ha2rtyagyullada2s : HuWord
n_ko3to4ha2rtyagyullada2s = MkHu "kötőhártyagyulladás" "kötőhártyagyulladás" ObjectRole Additive 0 19
public export n_ko3vetkezme2ny : HuWord
n_ko3vetkezme2ny = MkHu "következmény" "következmény" ObjectRole Multiplicative 0 12
public export n_ko3zgyu4le2s : HuWord
n_ko3zgyu4le2s = MkHu "közgyűlés" "közgyűlés" ObjectRole Multiplicative 0 9
public export n_ko3zlekede2selleno4rze2s : HuWord
n_ko3zlekede2selleno4rze2s = MkHu "közlekedésellenőrzés" "közlekedésellenőrzés" ObjectRole Multiplicative 0 20
public export n_ko3ze2rzet : HuWord
n_ko3ze2rzet = MkHu "közérzet" "közérz" ObjectRole Multiplicative 2 8
public export n_ku3rt : HuWord
n_ku3rt = MkHu "kürt" "kür" ObjectRole Multiplicative 2 4
public export n_ko4zetliszt : HuWord
n_ko4zetliszt = MkHu "kőzetliszt" "kőzetlisz" ObjectRole Multiplicative 2 10
public export n_laboda : HuWord
n_laboda = MkHu "laboda" "laboda" ObjectRole Additive 0 6
public export n_lakci2m : HuWord
n_lakci2m = MkHu "lakcím" "lakcím" ObjectRole Multiplicative 0 6
public export n_lako2konte2ner : HuWord
n_lako2konte2ner = MkHu "lakókonténer" "lakókonténer" ObjectRole Multiplicative 0 12
public export n_lap : HuWord
n_lap = MkHu "lap" "lap" ObjectRole Additive 0 3
public export n_lapoza2s : HuWord
n_lapoza2s = MkHu "lapozás" "lapozás" ObjectRole Additive 0 7
public export n_lapu : HuWord
n_lapu = MkHu "lapu" "lapu" ObjectRole Additive 0 4
public export n_laza : HuWord
n_laza = MkHu "laza" "laza" ObjectRole Additive 0 4
public export n_lazi2ttata2s : HuWord
n_lazi2ttata2s = MkHu "lazíttatás" "lazíttatás" ObjectRole Additive 0 10
public export n_lazi2ta2s : HuWord
n_lazi2ta2s = MkHu "lazítás" "lazítás" ObjectRole Additive 0 7
public export n_leander : HuWord
n_leander = MkHu "leander" "leander" ObjectRole Multiplicative 0 7
public export n_lebesze2le2s : HuWord
n_lebesze2le2s = MkHu "lebeszélés" "lebeszélés" ObjectRole Multiplicative 0 10
public export n_lebzsle2s : HuWord
n_lebzsle2s = MkHu "lebzslés" "lebzslés" ObjectRole Multiplicative 0 8
public export n_lecsillapoda2s : HuWord
n_lecsillapoda2s = MkHu "lecsillapodás" "lecsillapodás" ObjectRole Additive 0 13
public export n_lecsillapi2ttata2s : HuWord
n_lecsillapi2ttata2s = MkHu "lecsillapíttatás" "lecsillapíttatás" ObjectRole Additive 0 16
public export n_lecsillapi2ta2s : HuWord
n_lecsillapi2ta2s = MkHu "lecsillapítás" "lecsillapítás" ObjectRole Additive 0 13
public export n_ledo3fe2s : HuWord
n_ledo3fe2s = MkHu "ledöfés" "ledöfés" ObjectRole Multiplicative 0 7
public export n_leelo4ze2s : HuWord
n_leelo4ze2s = MkHu "leelőzés" "leelőzés" ObjectRole Multiplicative 0 8
public export n_lefoglala2s : HuWord
n_lefoglala2s = MkHu "lefoglalás" "lefoglalás" ObjectRole Additive 0 10
public export n_lefordi2ttata2s : HuWord
n_lefordi2ttata2s = MkHu "lefordíttatás" "lefordíttatás" ObjectRole Additive 0 13
public export n_legelo4 : HuWord
n_legelo4 = MkHu "legelő" "legelő" ObjectRole Multiplicative 0 6
public export n_legyeze2s : HuWord
n_legyeze2s = MkHu "legyezés" "legyezés" ObjectRole Multiplicative 0 8
public export n_legyezo4 : HuWord
n_legyezo4 = MkHu "legyező" "legyező" ObjectRole Multiplicative 0 7
public export n_legyezo4bajno2ca : HuWord
n_legyezo4bajno2ca = MkHu "legyezőbajnóca" "legyezőbajnóca" ObjectRole Additive 0 14
public export n_lehagyo2 : HuWord
n_lehagyo2 = MkHu "lehagyó" "lehagyó" ObjectRole Additive 0 7
public export n_leheto4se2g : HuWord
n_leheto4se2g = MkHu "lehetőség" "lehetőség" ObjectRole Multiplicative 0 9
public export n_lejto4 : HuWord
n_lejto4 = MkHu "lejtő" "lejtő" ObjectRole Multiplicative 0 5
public export n_leleme2nyesse2g : HuWord
n_leleme2nyesse2g = MkHu "leleményesség" "leleményesség" ObjectRole Multiplicative 0 13
public export n_lelkesede2s : HuWord
n_lelkesede2s = MkHu "lelkesedés" "lelkesedés" ObjectRole Multiplicative 0 10
public export n_lelkesi2te2s : HuWord
n_lelkesi2te2s = MkHu "lelkesítés" "lelkesítés" ObjectRole Multiplicative 0 10
public export n_lenge2s : HuWord
n_lenge2s = MkHu "lengés" "lengés" ObjectRole Multiplicative 0 6
public export n_lenke2ve : HuWord
n_lenke2ve = MkHu "lenkéve" "lenkéve" ObjectRole Multiplicative 0 7
public export n_leopa2rd : HuWord
n_leopa2rd = MkHu "leopárd" "leopárd" ObjectRole Additive 0 7
public export n_leopa2rdko3lyo3k : HuWord
n_leopa2rdko3lyo3k = MkHu "leopárdkölyök" "leopárdköly" ObjectRole Multiplicative 4 13
public export n_lepke : HuWord
n_lepke = MkHu "lepke" "lepke" ObjectRole Multiplicative 0 5
public export n_lepkefoga2s : HuWord
n_lepkefoga2s = MkHu "lepkefogás" "lepkefogás" ObjectRole Additive 0 10
public export n_lepa2rla2s : HuWord
n_lepa2rla2s = MkHu "lepárlás" "lepárlás" ObjectRole Additive 0 8
public export n_lepa2rlo2da2s : HuWord
n_lepa2rlo2da2s = MkHu "lepárlódás" "lepárlódás" ObjectRole Additive 0 10
public export n_lepa2roltata2s : HuWord
n_lepa2roltata2s = MkHu "lepároltatás" "lepároltatás" ObjectRole Additive 0 12
public export n_leromla2s : HuWord
n_leromla2s = MkHu "leromlás" "leromlás" ObjectRole Additive 0 8
public export n_leronta2s : HuWord
n_leronta2s = MkHu "lerontás" "lerontás" ObjectRole Additive 0 8
public export n_leszaki2ttata2s : HuWord
n_leszaki2ttata2s = MkHu "leszakíttatás" "leszakíttatás" ObjectRole Additive 0 13
public export n_leszaki2ta2s : HuWord
n_leszaki2ta2s = MkHu "leszakítás" "leszakítás" ObjectRole Additive 0 10
public export n_leszedete2s : HuWord
n_leszedete2s = MkHu "leszedetés" "leszedetés" ObjectRole Multiplicative 0 10
public export n_leszede2s : HuWord
n_leszede2s = MkHu "leszedés" "leszedés" ObjectRole Multiplicative 0 8
public export n_leszoka2s : HuWord
n_leszoka2s = MkHu "leszokás" "leszokás" ObjectRole Additive 0 8
public export n_letarto2ztata2s : HuWord
n_letarto2ztata2s = MkHu "letartóztatás" "letartóztatás" ObjectRole Additive 0 13
public export n_leve2ltetu4 : HuWord
n_leve2ltetu4 = MkHu "levéltetű" "levéltetű" ObjectRole Multiplicative 0 9
public export n_leve2lta2rca : HuWord
n_leve2lta2rca = MkHu "levéltárca" "levéltárca" ObjectRole Additive 0 10
public export n_leve2lta2ros : HuWord
n_leve2lta2ros = MkHu "levéltáros" "levéltáros" ObjectRole Additive 0 10
public export n_leve2lo3rv : HuWord
n_leve2lo3rv = MkHu "levélörv" "levélörv" ObjectRole Multiplicative 0 8
public export n_leza2ra2s : HuWord
n_leza2ra2s = MkHu "lezárás" "lezárás" ObjectRole Additive 0 7
public export n_lezu3lle2s : HuWord
n_lezu3lle2s = MkHu "lezüllés" "lezüllés" ObjectRole Multiplicative 0 8
public export n_lea2nyke2ro4 : HuWord
n_lea2nyke2ro4 = MkHu "leánykérő" "leánykérő" ObjectRole Multiplicative 0 9
public export n_liget : HuWord
n_liget = MkHu "liget" "lig" ObjectRole Multiplicative 2 5
public export n_likvida2la2s : HuWord
n_likvida2la2s = MkHu "likvidálás" "likvidálás" ObjectRole Additive 0 10
public export n_lilula2s : HuWord
n_lilula2s = MkHu "lilulás" "lilulás" ObjectRole Additive 0 7
public export n_lovagla2s : HuWord
n_lovagla2s = MkHu "lovaglás" "lovaglás" ObjectRole Additive 0 8
public export n_lovas : HuWord
n_lovas = MkHu "lovas" "lovas" ObjectRole Additive 0 5
public export n_lusta : HuWord
n_lusta = MkHu "lusta" "lusta" ObjectRole Additive 0 5
public export n_lustasa2g : HuWord
n_lustasa2g = MkHu "lustaság" "lustaság" ObjectRole Additive 0 8
public export n_lusta2lkoda2s : HuWord
n_lusta2lkoda2s = MkHu "lustálkodás" "lustálkodás" ObjectRole Additive 0 11
public export n_lusta2lkodo2 : HuWord
n_lusta2lkodo2 = MkHu "lustálkodó" "lustálkodó" ObjectRole Additive 0 10
public export n_la2bacska : HuWord
n_la2bacska = MkHu "lábacska" "lábacska" ObjectRole Additive 0 8
public export n_la2mpaernyo4 : HuWord
n_la2mpaernyo4 = MkHu "lámpaernyő" "lámpaernyő" ObjectRole Multiplicative 0 10
public export n_la2nc : HuWord
n_la2nc = MkHu "lánc" "lánc" ObjectRole Additive 0 4
public export n_la2p : HuWord
n_la2p = MkHu "láp" "láp" ObjectRole Additive 0 3
public export n_la2t : HuWord
n_la2t = MkHu "lát" "lát" ObjectRole Additive 0 3
public export n_la2tcso4 : HuWord
n_la2tcso4 = MkHu "látcső" "látcső" ObjectRole Multiplicative 0 6
public export n_la2thato2sa2g : HuWord
n_la2thato2sa2g = MkHu "láthatóság" "láthatóság" ObjectRole Additive 0 10
public export n_la2toma2s : HuWord
n_la2toma2s = MkHu "látomás" "látomás" ObjectRole Additive 0 7
public export n_la2ta2s : HuWord
n_la2ta2s = MkHu "látás" "látás" ObjectRole Additive 0 5
public export n_la2zada2s : HuWord
n_la2zada2s = MkHu "lázadás" "lázadás" ObjectRole Additive 0 7
public export n_la2zado2 : HuWord
n_la2zado2 = MkHu "lázadó" "lázadó" ObjectRole Additive 0 6
public export n_la2zi2ta2s : HuWord
n_la2zi2ta2s = MkHu "lázítás" "lázítás" ObjectRole Additive 0 7
public export n_le2gcso4hurut : HuWord
n_le2gcso4hurut = MkHu "légcsőhurut" "légcsőhuru" ObjectRole Additive 2 11
public export n_le2ggo3mb : HuWord
n_le2ggo3mb = MkHu "léggömb" "léggömb" ObjectRole Multiplicative 0 7
public export n_le2ghajo2 : HuWord
n_le2ghajo2 = MkHu "léghajó" "léghajó" ObjectRole Additive 0 7
public export n_le2gibomba : HuWord
n_le2gibomba = MkHu "légibomba" "légib" ObjectRole Multiplicative 33 9
public export n_le2giba2zis : HuWord
n_le2giba2zis = MkHu "légibázis" "légibázis" ObjectRole Multiplicative 0 9
public export n_le2giposta : HuWord
n_le2giposta = MkHu "légiposta" "légiposta" ObjectRole Additive 0 9
public export n_le2gita2maszpont : HuWord
n_le2gita2maszpont = MkHu "légitámaszpont" "légitámaszpo" ObjectRole Additive 3 14
public export n_le2gko3r : HuWord
n_le2gko3r = MkHu "légkör" "légkör" ObjectRole Multiplicative 0 6
public export n_le2gko3rze2s : HuWord
n_le2gko3rze2s = MkHu "légkörzés" "légkörzés" ObjectRole Multiplicative 0 9
public export n_le2gzo4ke2szu3le2k : HuWord
n_le2gzo4ke2szu3le2k = MkHu "légzőkészülék" "légzőkészülé" ObjectRole Multiplicative 4 13
public export n_le2pcso4 : HuWord
n_le2pcso4 = MkHu "lépcső" "lépcső" ObjectRole Multiplicative 0 6
public export n_le2tesi2te2s : HuWord
n_le2tesi2te2s = MkHu "létesítés" "létesítés" ObjectRole Multiplicative 0 9
public export n_le2tra : HuWord
n_le2tra = MkHu "létra" "lét" ObjectRole Multiplicative 1 5
public export n_li2zing : HuWord
n_li2zing = MkHu "lízing" "lízing" ObjectRole Multiplicative 0 6
public export n_lo2ko3ro3mfu4 : HuWord
n_lo2ko3ro3mfu4 = MkHu "lókörömfű" "lókörömfű" ObjectRole Multiplicative 0 9
public export n_lo3kha2ri2to2 : HuWord
n_lo3kha2ri2to2 = MkHu "lökhárító" "lökhárító" ObjectRole Additive 0 9
public export n_lo4re2s : HuWord
n_lo4re2s = MkHu "lőrés" "lőrés" ObjectRole Multiplicative 0 5
public export n_madzag : HuWord
n_madzag = MkHu "madzag" "madzag" ObjectRole Additive 0 6
public export n_mada2r : HuWord
n_mada2r = MkHu "madár" "madár" ObjectRole Additive 0 5
public export n_mada2rijeszto4 : HuWord
n_mada2rijeszto4 = MkHu "madárijesztő" "madárijesztő" ObjectRole Multiplicative 0 12
public export n_mag : HuWord
n_mag = MkHu "mag" "mag" ObjectRole Additive 0 3
public export n_magasztala2s : HuWord
n_magasztala2s = MkHu "magasztalás" "magasztalás" ObjectRole Additive 0 11
public export n_maga2nhangzo2 : HuWord
n_maga2nhangzo2 = MkHu "magánhangzó" "magánhangzó" ObjectRole Additive 0 11
public export n_makacs : HuWord
n_makacs = MkHu "makacs" "makacs" ObjectRole Additive 0 6
public export n_makacskoda2s : HuWord
n_makacskoda2s = MkHu "makacskodás" "makacskodás" ObjectRole Additive 0 11
public export n_makacssa2g : HuWord
n_makacssa2g = MkHu "makacsság" "makacsság" ObjectRole Additive 0 9
public export n_mamalsz : HuWord
n_mamalsz = MkHu "mamalsz" "mamalsz" ObjectRole Additive 0 7
public export n_maradva2ny : HuWord
n_maradva2ny = MkHu "maradvány" "maradvány" ObjectRole Additive 0 9
public export n_marade2k : HuWord
n_marade2k = MkHu "maradék" "maradé" ObjectRole Multiplicative 4 7
public export n_marhasu3lt : HuWord
n_marhasu3lt = MkHu "marhasült" "marhasül" ObjectRole Multiplicative 2 9
public export n_martilapu : HuWord
n_martilapu = MkHu "martilapu" "martilapu" ObjectRole Additive 0 9
public export n_masni : HuWord
n_masni = MkHu "masni" "mas" ObjectRole Additive 8 5
public export n_matro2zko3peny : HuWord
n_matro2zko3peny = MkHu "matrózköpeny" "matrózköpeny" ObjectRole Multiplicative 0 12
public export n_medence : HuWord
n_medence = MkHu "medence" "medence" ObjectRole Multiplicative 0 7
public export n_medencecsont : HuWord
n_medencecsont = MkHu "medencecsont" "medencecso" ObjectRole Additive 3 12
public export n_megalvada2s : HuWord
n_megalvada2s = MkHu "megalvadás" "megalvadás" ObjectRole Additive 0 10
public export n_megalvaszta2s : HuWord
n_megalvaszta2s = MkHu "megalvasztás" "megalvasztás" ObjectRole Additive 0 12
public export n_megbilincsele2s : HuWord
n_megbilincsele2s = MkHu "megbilincselés" "megbilincselés" ObjectRole Multiplicative 0 14
public export n_megbillene2s : HuWord
n_megbillene2s = MkHu "megbillenés" "megbillenés" ObjectRole Multiplicative 0 11
public export n_megbocsa2ta2s : HuWord
n_megbocsa2ta2s = MkHu "megbocsátás" "megbocsátás" ObjectRole Additive 0 11
public export n_megbe2ke2le2s : HuWord
n_megbe2ke2le2s = MkHu "megbékélés" "megbékélés" ObjectRole Multiplicative 0 10
public export n_megbi2zott : HuWord
n_megbi2zott = MkHu "megbízott" "megbízo" ObjectRole Additive 8 9
public export n_megdermede2s : HuWord
n_megdermede2s = MkHu "megdermedés" "megdermedés" ObjectRole Multiplicative 0 11
public export n_megdo3fe2s : HuWord
n_megdo3fe2s = MkHu "megdöfés" "megdöfés" ObjectRole Multiplicative 0 8
public export n_megdo4lt : HuWord
n_megdo4lt = MkHu "megdőlt" "megdől" ObjectRole Multiplicative 2 7
public export n_megdo4le2s : HuWord
n_megdo4le2s = MkHu "megdőlés" "megdőlés" ObjectRole Multiplicative 0 8
public export n_megelo4legeze2s : HuWord
n_megelo4legeze2s = MkHu "megelőlegezés" "megelőlegezés" ObjectRole Multiplicative 0 13
public export n_megelo4ztete2s : HuWord
n_megelo4ztete2s = MkHu "megelőztetés" "megelőztetés" ObjectRole Multiplicative 0 12
public export n_megelo4ze2s : HuWord
n_megelo4ze2s = MkHu "megelőzés" "megelőzés" ObjectRole Multiplicative 0 9
public export n_megelo4zo4 : HuWord
n_megelo4zo4 = MkHu "megelőző" "megelőző" ObjectRole Multiplicative 0 8
public export n_megemle2keze2s : HuWord
n_megemle2keze2s = MkHu "megemlékezés" "megemlékezés" ObjectRole Multiplicative 0 12
public export n_megero4si2te2s : HuWord
n_megero4si2te2s = MkHu "megerősítés" "megerősítés" ObjectRole Multiplicative 0 11
public export n_megfigyel : HuWord
n_megfigyel = MkHu "megfigyel" "megfigyel" ObjectRole Multiplicative 0 9
public export n_megfigyele2s : HuWord
n_megfigyele2s = MkHu "megfigyelés" "megfigyelés" ObjectRole Multiplicative 0 11
public export n_megfizettete2s : HuWord
n_megfizettete2s = MkHu "megfizettetés" "megfizettetés" ObjectRole Multiplicative 0 13
public export n_megfordula2s : HuWord
n_megfordula2s = MkHu "megfordulás" "megfordulás" ObjectRole Additive 0 11
public export n_megfordi2ttata2s : HuWord
n_megfordi2ttata2s = MkHu "megfordíttatás" "megfordíttatás" ObjectRole Additive 0 14
public export n_megfordi2ta2s : HuWord
n_megfordi2ta2s = MkHu "megfordítás" "megfordítás" ObjectRole Additive 0 11
public export n_meggazdagoda2s : HuWord
n_meggazdagoda2s = MkHu "meggazdagodás" "meggazdagodás" ObjectRole Additive 0 13
public export n_meggombostu4ze2s : HuWord
n_meggombostu4ze2s = MkHu "meggombostűzés" "meggombostűzés" ObjectRole Multiplicative 0 14
public export n_meggyo3kereze2s : HuWord
n_meggyo3kereze2s = MkHu "meggyökerezés" "meggyökerezés" ObjectRole Multiplicative 0 13
public export n_meggyu2jtata2s : HuWord
n_meggyu2jtata2s = MkHu "meggyújtatás" "meggyújtatás" ObjectRole Additive 0 12
public export n_meggyu2jtato2 : HuWord
n_meggyu2jtato2 = MkHu "meggyújtató" "meggyújtató" ObjectRole Additive 0 11
public export n_meggyu2jta2s : HuWord
n_meggyu2jta2s = MkHu "meggyújtás" "meggyújtás" ObjectRole Additive 0 10
public export n_meghaladtata2s : HuWord
n_meghaladtata2s = MkHu "meghaladtatás" "meghaladtatás" ObjectRole Additive 0 13
public export n_meghalada2s : HuWord
n_meghalada2s = MkHu "meghaladás" "meghaladás" ObjectRole Additive 0 10
public export n_meghala2s : HuWord
n_meghala2s = MkHu "meghalás" "meghalás" ObjectRole Additive 0 8
public export n_meghatalmazott : HuWord
n_meghatalmazott = MkHu "meghatalmazott" "meghatalmazo" ObjectRole Additive 8 14
public export n_megho2di2ta2s : HuWord
n_megho2di2ta2s = MkHu "meghódítás" "meghódítás" ObjectRole Additive 0 10
public export n_megismertete2s : HuWord
n_megismertete2s = MkHu "megismertetés" "megismertetés" ObjectRole Multiplicative 0 13
public export n_megko3to3ze2s : HuWord
n_megko3to3ze2s = MkHu "megkötözés" "megkötözés" ObjectRole Multiplicative 0 10
public export n_megko3zeli2te2s : HuWord
n_megko3zeli2te2s = MkHu "megközelítés" "megközelítés" ObjectRole Multiplicative 0 12
public export n_meglepete2s : HuWord
n_meglepete2s = MkHu "meglepetés" "meglepetés" ObjectRole Multiplicative 0 10
public export n_meglepe2s : HuWord
n_meglepe2s = MkHu "meglepés" "meglepés" ObjectRole Multiplicative 0 8
public export n_megla2ncola2s : HuWord
n_megla2ncola2s = MkHu "megláncolás" "megláncolás" ObjectRole Additive 0 11
public export n_megla2t : HuWord
n_megla2t = MkHu "meglát" "meglá" ObjectRole Additive 2 6
public export n_megmu4vele2s : HuWord
n_megmu4vele2s = MkHu "megművelés" "megművelés" ObjectRole Multiplicative 0 10
public export n_megnyugtattata2s : HuWord
n_megnyugtattata2s = MkHu "megnyugtattatás" "megnyugtattatás" ObjectRole Additive 0 15
public export n_megnyugtata2s : HuWord
n_megnyugtata2s = MkHu "megnyugtatás" "megnyugtatás" ObjectRole Additive 0 12
public export n_megnyugva2s : HuWord
n_megnyugva2s = MkHu "megnyugvás" "megnyugvás" ObjectRole Additive 0 10
public export n_megne2mula2s : HuWord
n_megne2mula2s = MkHu "megnémulás" "megnémulás" ObjectRole Additive 0 10
public export n_megne2mulo2 : HuWord
n_megne2mulo2 = MkHu "megnémuló" "megnémuló" ObjectRole Additive 0 9
public export n_megolda2s : HuWord
n_megolda2s = MkHu "megoldás" "megoldás" ObjectRole Additive 0 8
public export n_megriaszta2s : HuWord
n_megriaszta2s = MkHu "megriasztás" "megriasztás" ObjectRole Additive 0 11
public export n_megsemmisi2te2s : HuWord
n_megsemmisi2te2s = MkHu "megsemmisítés" "megsemmisítés" ObjectRole Multiplicative 0 13
public export n_megsokasoda2s : HuWord
n_megsokasoda2s = MkHu "megsokasodás" "megsokasodás" ObjectRole Additive 0 12
public export n_megszoka2s : HuWord
n_megszoka2s = MkHu "megszokás" "megszokás" ObjectRole Additive 0 9
public export n_megsze2di2te2s : HuWord
n_megsze2di2te2s = MkHu "megszédítés" "megszédítés" ObjectRole Multiplicative 0 11
public export n_megszu2ra2s : HuWord
n_megszu2ra2s = MkHu "megszúrás" "megszúrás" ObjectRole Additive 0 9
public export n_megtoldata2s : HuWord
n_megtoldata2s = MkHu "megtoldatás" "megtoldatás" ObjectRole Additive 0 11
public export n_megtolda2s : HuWord
n_megtolda2s = MkHu "megtoldás" "megtoldás" ObjectRole Additive 0 9
public export n_megte2veszte2s : HuWord
n_megte2veszte2s = MkHu "megtévesztés" "megtévesztés" ObjectRole Multiplicative 0 12
public export n_megvalo2sula2s : HuWord
n_megvalo2sula2s = MkHu "megvalósulás" "megvalósulás" ObjectRole Additive 0 12
public export n_megvalo2si2ttata2s : HuWord
n_megvalo2si2ttata2s = MkHu "megvalósíttatás" "megvalósíttatás" ObjectRole Additive 0 15
public export n_megvalo2si2ta2s : HuWord
n_megvalo2si2ta2s = MkHu "megvalósítás" "megvalósítás" ObjectRole Additive 0 12
public export n_megvetete2s : HuWord
n_megvetete2s = MkHu "megvetetés" "megvetetés" ObjectRole Multiplicative 0 10
public export n_megva2lasztata2s : HuWord
n_megva2lasztata2s = MkHu "megválasztatás" "megválasztatás" ObjectRole Additive 0 14
public export n_megva2laszta2s : HuWord
n_megva2laszta2s = MkHu "megválasztás" "megválasztás" ObjectRole Additive 0 12
public export n_mege2rt : HuWord
n_mege2rt = MkHu "megért" "meg" ObjectRole Multiplicative 1 6
public export n_mege2rte2s : HuWord
n_mege2rte2s = MkHu "megértés" "megértés" ObjectRole Multiplicative 0 8
public export n_mego3lete2s : HuWord
n_mego3lete2s = MkHu "megöletés" "megöletés" ObjectRole Multiplicative 0 9
public export n_mego3le2s : HuWord
n_mego3le2s = MkHu "megölés" "megölés" ObjectRole Multiplicative 0 7
public export n_melegha2z : HuWord
n_melegha2z = MkHu "melegház" "melegház" ObjectRole Additive 0 8
public export n_mellbimbo2 : HuWord
n_mellbimbo2 = MkHu "mellbimbó" "mellbimbó" ObjectRole Additive 0 9
public export n_mellettem : HuWord
n_mellettem = MkHu "mellettem" "melle" ObjectRole Multiplicative 40 9
public export n_melltu4 : HuWord
n_melltu4 = MkHu "melltű" "melltű" ObjectRole Multiplicative 0 6
public export n_mellu2sza2s : HuWord
n_mellu2sza2s = MkHu "mellúszás" "mellúszás" ObjectRole Additive 0 9
public export n_mela2k : HuWord
n_mela2k = MkHu "melák" "melá" ObjectRole Additive 4 5
public export n_menetjegy : HuWord
n_menetjegy = MkHu "menetjegy" "menetjegy" ObjectRole Multiplicative 0 9
public export n_menstrua2cio2 : HuWord
n_menstrua2cio2 = MkHu "menstruáció" "menstruáció" ObjectRole Additive 0 11
public export n_mentalita2s : HuWord
n_mentalita2s = MkHu "mentalitás" "mentalitás" ObjectRole Additive 0 10
public export n_menyasszonyke2ro4 : HuWord
n_menyasszonyke2ro4 = MkHu "menyasszonykérő" "menyasszonykérő" ObjectRole Multiplicative 0 15
public export n_mere2sz : HuWord
n_mere2sz = MkHu "merész" "merész" ObjectRole Multiplicative 0 6
public export n_meru3le2s : HuWord
n_meru3le2s = MkHu "merülés" "merülés" ObjectRole Multiplicative 0 7
public export n_mese : HuWord
n_mese = MkHu "mese" "mese" ObjectRole Multiplicative 0 4
public export n_meszeltete2s : HuWord
n_meszeltete2s = MkHu "meszeltetés" "meszeltetés" ObjectRole Multiplicative 0 11
public export n_meszele2s : HuWord
n_meszele2s = MkHu "meszelés" "meszelés" ObjectRole Multiplicative 0 8
public export n_metszo4fog : HuWord
n_metszo4fog = MkHu "metszőfog" "metszőfog" ObjectRole Additive 0 9
public export n_mezsgye : HuWord
n_mezsgye = MkHu "mezsgye" "mezsgye" ObjectRole Multiplicative 0 7
public export n_meztelencsiga : HuWord
n_meztelencsiga = MkHu "meztelencsiga" "meztelencsiga" ObjectRole Additive 0 13
public export n_mezo4 : HuWord
n_mezo4 = MkHu "mező" "mező" ObjectRole Multiplicative 0 4
public export n_mezo4gazdasa2g : HuWord
n_mezo4gazdasa2g = MkHu "mezőgazdaság" "mezőgazdaság" ObjectRole Additive 0 12
public export n_mezo4gazda2sz : HuWord
n_mezo4gazda2sz = MkHu "mezőgazdász" "mezőgazdász" ObjectRole Additive 0 11
public export n_mirigy : HuWord
n_mirigy = MkHu "mirigy" "mirigy" ObjectRole Multiplicative 0 6
public export n_mocsa2r : HuWord
n_mocsa2r = MkHu "mocsár" "mocsár" ObjectRole Additive 0 6
public export n_moho2 : HuWord
n_moho2 = MkHu "mohó" "mohó" ObjectRole Additive 0 4
public export n_moho2sa2g : HuWord
n_moho2sa2g = MkHu "mohóság" "mohóság" ObjectRole Additive 0 7
public export n_morga2s : HuWord
n_morga2s = MkHu "morgás" "morgás" ObjectRole Additive 0 6
public export n_mormoga2s : HuWord
n_mormoga2s = MkHu "mormogás" "mormogás" ObjectRole Additive 0 8
public export n_morzsa : HuWord
n_morzsa = MkHu "morzsa" "morzsa" ObjectRole Additive 0 6
public export n_mosle2k : HuWord
n_mosle2k = MkHu "moslék" "moslé" ObjectRole Multiplicative 4 6
public export n_motolla : HuWord
n_motolla = MkHu "motolla" "motolla" ObjectRole Additive 0 7
public export n_motorolaj : HuWord
n_motorolaj = MkHu "motorolaj" "motorola" ObjectRole Additive 16 9
public export n_motorosfu4re2sz : HuWord
n_motorosfu4re2sz = MkHu "motorosfűrész" "motorosfűrész" ObjectRole Multiplicative 0 13
public export n_motyoga2s : HuWord
n_motyoga2s = MkHu "motyogás" "motyogás" ObjectRole Additive 0 8
public export n_mozaikszo2 : HuWord
n_mozaikszo2 = MkHu "mozaikszó" "mozaikszó" ObjectRole Additive 0 9
public export n_mozga2s : HuWord
n_mozga2s = MkHu "mozgás" "mozgás" ObjectRole Additive 0 6
public export n_mozgo2bolt : HuWord
n_mozgo2bolt = MkHu "mozgóbolt" "mozgóbol" ObjectRole Additive 2 9
public export n_mumus : HuWord
n_mumus = MkHu "mumus" "mumus" ObjectRole Additive 0 5
public export n_munkakeru3lo4 : HuWord
n_munkakeru3lo4 = MkHu "munkakerülő" "munkakerülő" ObjectRole Multiplicative 0 11
public export n_munkako3zo3sse2g : HuWord
n_munkako3zo3sse2g = MkHu "munkaközösség" "munkaközösség" ObjectRole Multiplicative 0 13
public export n_munkane2lku3li : HuWord
n_munkane2lku3li = MkHu "munkanélküli" "munkanélküli" ObjectRole Multiplicative 0 12
public export n_munkane2lku3lise2g : HuWord
n_munkane2lku3lise2g = MkHu "munkanélküliség" "munkanélküliség" ObjectRole Multiplicative 0 15
public export n_mutato2ujj : HuWord
n_mutato2ujj = MkHu "mutatóujj" "mutatóuj" ObjectRole Additive 16 9
public export n_ma2gia : HuWord
n_ma2gia = MkHu "mágia" "mágia" ObjectRole Additive 0 5
public export n_ma2le2sza2ju2 : HuWord
n_ma2le2sza2ju2 = MkHu "málészájú" "málészájú" ObjectRole Additive 0 9
public export n_ma2sfele2 : HuWord
n_ma2sfele2 = MkHu "másfelé" "másfelé" ObjectRole Multiplicative 0 7
public export n_ma2sola2s : HuWord
n_ma2sola2s = MkHu "másolás" "másolás" ObjectRole Additive 0 7
public export n_ma2solo2 : HuWord
n_ma2solo2 = MkHu "másoló" "másoló" ObjectRole Additive 0 6
public export n_ma2zsa2lo2ru2d : HuWord
n_ma2zsa2lo2ru2d = MkHu "mázsálórúd" "mázsálórúd" ObjectRole Additive 0 10
public export n_me2lyede2s : HuWord
n_me2lyede2s = MkHu "mélyedés" "mélyedés" ObjectRole Multiplicative 0 8
public export n_me2lyse2g : HuWord
n_me2lyse2g = MkHu "mélység" "mélység" ObjectRole Multiplicative 0 7
public export n_me2lytengeri : HuWord
n_me2lytengeri = MkHu "mélytengeri" "mélytengeri" ObjectRole Multiplicative 0 11
public export n_me2reg : HuWord
n_me2reg = MkHu "méreg" "méreg" ObjectRole Multiplicative 0 5
public export n_me2ret : HuWord
n_me2ret = MkHu "méret" "mér" ObjectRole Multiplicative 2 5
public export n_me2rleg : HuWord
n_me2rleg = MkHu "mérleg" "mérleg" ObjectRole Multiplicative 0 6
public export n_me2sza2rla2s : HuWord
n_me2sza2rla2s = MkHu "mészárlás" "mészárlás" ObjectRole Additive 0 9
public export n_mo2d : HuWord
n_mo2d = MkHu "mód" "mód" ObjectRole Additive 0 3
public export n_mu4csali : HuWord
n_mu4csali = MkHu "műcsali" "műcsali" ObjectRole Multiplicative 0 7
public export n_mu4hely : HuWord
n_mu4hely = MkHu "műhely" "műhely" ObjectRole Multiplicative 0 6
public export n_mu4terem : HuWord
n_mu4terem = MkHu "műterem" "műter" ObjectRole Multiplicative 32 7
public export n_mu4veltse2g : HuWord
n_mu4veltse2g = MkHu "műveltség" "műveltség" ObjectRole Multiplicative 0 9
public export n_mu4ve2sz : HuWord
n_mu4ve2sz = MkHu "művész" "művész" ObjectRole Multiplicative 0 6
public export n_mu4ve2szet : HuWord
n_mu4ve2szet = MkHu "művészet" "művész" ObjectRole Multiplicative 2 8
public export n_mu4ve2szno4 : HuWord
n_mu4ve2szno4 = MkHu "művésznő" "művésznő" ObjectRole Multiplicative 0 8
public export n_nadra2g : HuWord
n_nadra2g = MkHu "nadrág" "nadrág" ObjectRole Additive 0 6
public export n_nagyapa : HuWord
n_nagyapa = MkHu "nagyapa" "nagyapa" ObjectRole Additive 0 7
public export n_nagyba2csi : HuWord
n_nagyba2csi = MkHu "nagybácsi" "nagybácsi" ObjectRole Multiplicative 0 9
public export n_nagyevo4 : HuWord
n_nagyevo4 = MkHu "nagyevő" "nagyevő" ObjectRole Multiplicative 0 7
public export n_nagykendo4 : HuWord
n_nagykendo4 = MkHu "nagykendő" "nagykendő" ObjectRole Multiplicative 0 9
public export n_nagykoru2sa2g : HuWord
n_nagykoru2sa2g = MkHu "nagykorúság" "nagykorúság" ObjectRole Additive 0 11
public export n_nagyke2pu4 : HuWord
n_nagyke2pu4 = MkHu "nagyképű" "nagyképű" ObjectRole Multiplicative 0 8
public export n_nagyke2pu4se2g : HuWord
n_nagyke2pu4se2g = MkHu "nagyképűség" "nagyképűség" ObjectRole Multiplicative 0 11
public export n_nagymama : HuWord
n_nagymama = MkHu "nagymama" "nagymama" ObjectRole Additive 0 8
public export n_nagyne2ni : HuWord
n_nagyne2ni = MkHu "nagynéni" "nagy" ObjectRole Additive 16 8
public export n_nagyobboda2s : HuWord
n_nagyobboda2s = MkHu "nagyobbodás" "nagyobbodás" ObjectRole Additive 0 11
public export n_nagyszeru4 : HuWord
n_nagyszeru4 = MkHu "nagyszerű" "nagyszerű" ObjectRole Multiplicative 0 9
public export n_nagysa2g : HuWord
n_nagysa2g = MkHu "nagyság" "nagyság" ObjectRole Additive 0 7
public export n_nagyzola2s : HuWord
n_nagyzola2s = MkHu "nagyzolás" "nagyzolás" ObjectRole Additive 0 9
public export n_nagye2tku4 : HuWord
n_nagye2tku4 = MkHu "nagyétkű" "nagyétkű" ObjectRole Multiplicative 0 8
public export n_nagyi2tott : HuWord
n_nagyi2tott = MkHu "nagyított" "nagyíto" ObjectRole Additive 8 9
public export n_nagyi2ta2s : HuWord
n_nagyi2ta2s = MkHu "nagyítás" "nagyítás" ObjectRole Additive 0 8
public export n_naplopo2 : HuWord
n_naplopo2 = MkHu "naplopó" "naplopó" ObjectRole Additive 0 7
public export n_narancs : HuWord
n_narancs = MkHu "narancs" "narancs" ObjectRole Additive 0 7
public export n_nemezcsizma : HuWord
n_nemezcsizma = MkHu "nemezcsizma" "nemezcsizma" ObjectRole Additive 0 11
public export n_neveltete2s : HuWord
n_neveltete2s = MkHu "neveltetés" "neveltetés" ObjectRole Multiplicative 0 10
public export n_nevele2s : HuWord
n_nevele2s = MkHu "nevelés" "nevelés" ObjectRole Multiplicative 0 7
public export n_nevelo4de2s : HuWord
n_nevelo4de2s = MkHu "nevelődés" "nevelődés" ObjectRole Multiplicative 0 9
public export n_nitrida2la2s : HuWord
n_nitrida2la2s = MkHu "nitridálás" "nitridálás" ObjectRole Additive 0 10
public export n_nitroge2n : HuWord
n_nitroge2n = MkHu "nitrogén" "nitrogé" ObjectRole Multiplicative 1 8
public export n_nitroge2noxidok : HuWord
n_nitroge2noxidok = MkHu "nitrogénoxidok" "nitrogénoxid" ObjectRole Multiplicative 4 14
public export n_notesz : HuWord
n_notesz = MkHu "notesz" "notesz" ObjectRole Multiplicative 0 6
public export n_nyakszirtme2lyede2s : HuWord
n_nyakszirtme2lyede2s = MkHu "nyakszirtmélyedés" "nyakszirtmélyedés" ObjectRole Multiplicative 0 17
public export n_nyerese2g : HuWord
n_nyerese2g = MkHu "nyereség" "nyereség" ObjectRole Multiplicative 0 8
public export n_nyero4 : HuWord
n_nyero4 = MkHu "nyerő" "nyerő" ObjectRole Multiplicative 0 5
public export n_nyom : HuWord
n_nyom = MkHu "nyom" "nyom" ObjectRole Additive 0 4
public export n_nyomorult : HuWord
n_nyomorult = MkHu "nyomorult" "nyomorul" ObjectRole Additive 2 9
public export n_nyomtalanul : HuWord
n_nyomtalanul = MkHu "nyomtalanul" "nyomtalanul" ObjectRole Additive 0 11
public export n_nyugtalankoda2a : HuWord
n_nyugtalankoda2a = MkHu "nyugtalankodáa" "nyugtalankodáa" ObjectRole Additive 0 14
public export n_nyugtalankoda2s : HuWord
n_nyugtalankoda2s = MkHu "nyugtalankodás" "nyugtalankodás" ObjectRole Additive 0 14
public export n_nyugtalani2ttata2s : HuWord
n_nyugtalani2ttata2s = MkHu "nyugtalaníttatás" "nyugtalaníttatás" ObjectRole Additive 0 16
public export n_nyugtalani2ta2s : HuWord
n_nyugtalani2ta2s = MkHu "nyugtalanítás" "nyugtalanítás" ObjectRole Additive 0 13
public export n_nyugtata2s : HuWord
n_nyugtata2s = MkHu "nyugtatás" "nyugtatás" ObjectRole Additive 0 9
public export n_nyu2ldomolyko2 : HuWord
n_nyu2ldomolyko2 = MkHu "nyúldomolykó" "nyúldomolykó" ObjectRole Additive 0 12
public export n_nyu3zsge2s : HuWord
n_nyu3zsge2s = MkHu "nyüzsgés" "nyüzsgés" ObjectRole Multiplicative 0 8
public export n_ne2ma : HuWord
n_ne2ma = MkHu "néma" "néma" ObjectRole Additive 0 4
public export n_ne2ma2n : HuWord
n_ne2ma2n = MkHu "némán" "némá" ObjectRole Additive 1 5
public export n_ne2na : HuWord
n_ne2na = MkHu "néna" "néna" ObjectRole Additive 0 4
public export n_ne2ni : HuWord
n_ne2ni = MkHu "néni" "néni" ObjectRole Multiplicative 0 4
public export n_no3vekede2s : HuWord
n_no3vekede2s = MkHu "növekedés" "növekedés" ObjectRole Multiplicative 0 9
public export n_no3ve2ny : HuWord
n_no3ve2ny = MkHu "növény" "növény" ObjectRole Multiplicative 0 6
public export n_no3ve2nytakaro2 : HuWord
n_no3ve2nytakaro2 = MkHu "növénytakaró" "növénytakaró" ObjectRole Additive 0 12
public export n_no3ve2nytan : HuWord
n_no3ve2nytan = MkHu "növénytan" "növényta" ObjectRole Additive 1 9
public export n_no3ve2s : HuWord
n_no3ve2s = MkHu "növés" "növés" ObjectRole Multiplicative 0 5
public export n_no4ve2r : HuWord
n_no4ve2r = MkHu "nővér" "nővér" ObjectRole Multiplicative 0 5
public export n_no4ve2rke : HuWord
n_no4ve2rke = MkHu "nővérke" "nővérke" ObjectRole Multiplicative 0 7
public export n_okirat : HuWord
n_okirat = MkHu "okirat" "okir" ObjectRole Multiplicative 2 6
public export n_okos : HuWord
n_okos = MkHu "okos" "okos" ObjectRole Additive 0 4
public export n_oldal : HuWord
n_oldal = MkHu "oldal" "oldal" ObjectRole Additive 0 5
public export n_olvaszta2r : HuWord
n_olvaszta2r = MkHu "olvasztár" "olvasztár" ObjectRole Additive 0 9
public export n_orca : HuWord
n_orca = MkHu "orca" "orca" ObjectRole Additive 0 4
public export n_oroszla2n : HuWord
n_oroszla2n = MkHu "oroszlán" "oroszlá" ObjectRole Additive 1 8
public export n_orrszarvu2boga2r : HuWord
n_orrszarvu2boga2r = MkHu "orrszarvúbogár" "orrszarvúbogár" ObjectRole Additive 0 14
public export n_orsza2ggyu4le2s : HuWord
n_orsza2ggyu4le2s = MkHu "országgyűlés" "országgyűlés" ObjectRole Multiplicative 0 12
public export n_orsza2gu2t : HuWord
n_orsza2gu2t = MkHu "országút" "országú" ObjectRole Additive 2 8
public export n_orso2fe2reg : HuWord
n_orso2fe2reg = MkHu "orsóféreg" "orsóféreg" ObjectRole Multiplicative 0 9
public export n_orvvada2sz : HuWord
n_orvvada2sz = MkHu "orvvadász" "orvvadász" ObjectRole Additive 0 9
public export n_ostoba : HuWord
n_ostoba = MkHu "ostoba" "osto" ObjectRole Additive 1 6
public export n_ostromza2r : HuWord
n_ostromza2r = MkHu "ostromzár" "ostromzár" ObjectRole Additive 0 9
public export n_oszta2lyzat : HuWord
n_oszta2lyzat = MkHu "osztályzat" "osztályz" ObjectRole Additive 2 10
public export n_out : HuWord
n_out = MkHu "out" "out" ObjectRole Additive 0 3
public export n_pacsirta : HuWord
n_pacsirta = MkHu "pacsirta" "pacsirta" ObjectRole Additive 0 8
public export n_padlizsa2n : HuWord
n_padlizsa2n = MkHu "padlizsán" "padlizsá" ObjectRole Additive 1 9
public export n_pajkos : HuWord
n_pajkos = MkHu "pajkos" "pajkos" ObjectRole Additive 0 6
public export n_pajkoskoda2s : HuWord
n_pajkoskoda2s = MkHu "pajkoskodás" "pajkoskodás" ObjectRole Additive 0 11
public export n_pajkossa2g : HuWord
n_pajkossa2g = MkHu "pajkosság" "pajkosság" ObjectRole Additive 0 9
public export n_pajzstetu4 : HuWord
n_pajzstetu4 = MkHu "pajzstetű" "pajzstetű" ObjectRole Multiplicative 0 9
public export n_palack : HuWord
n_palack = MkHu "palack" "palac" ObjectRole Additive 4 6
public export n_palacsinta : HuWord
n_palacsinta = MkHu "palacsinta" "palacsinta" ObjectRole Additive 0 10
public export n_pala2nk : HuWord
n_pala2nk = MkHu "palánk" "palá" ObjectRole Additive 5 6
public export n_panaszkoda2s : HuWord
n_panaszkoda2s = MkHu "panaszkodás" "panaszkodás" ObjectRole Additive 0 11
public export n_papa : HuWord
n_papa = MkHu "papa" "papa" ObjectRole Additive 0 4
public export n_papaga2j : HuWord
n_papaga2j = MkHu "papagáj" "papagá" ObjectRole Additive 16 7
public export n_papucs : HuWord
n_papucs = MkHu "papucs" "papucs" ObjectRole Additive 0 6
public export n_papi2r : HuWord
n_papi2r = MkHu "papír" "papír" ObjectRole Multiplicative 0 5
public export n_parancs : HuWord
n_parancs = MkHu "parancs" "parancs" ObjectRole Additive 0 7
public export n_parancsnok : HuWord
n_parancsnok = MkHu "parancsnok" "parancs" ObjectRole Additive 5 10
public export n_parancsolat : HuWord
n_parancsolat = MkHu "parancsolat" "parancsol" ObjectRole Additive 2 11
public export n_parcella : HuWord
n_parcella = MkHu "parcella" "parcella" ObjectRole Additive 0 8
public export n_parlament : HuWord
n_parlament = MkHu "parlament" "parlame" ObjectRole Multiplicative 3 9
public export n_part : HuWord
n_part = MkHu "part" "par" ObjectRole Additive 2 4
public export n_para2zna2lkoda2s : HuWord
n_para2zna2lkoda2s = MkHu "paráználkodás" "paráználkodás" ObjectRole Additive 0 13
public export n_patika : HuWord
n_patika = MkHu "patika" "patika" ObjectRole Additive 0 6
public export n_patka2ny : HuWord
n_patka2ny = MkHu "patkány" "patkány" ObjectRole Additive 0 7
public export n_pehely : HuWord
n_pehely = MkHu "pehely" "pehely" ObjectRole Multiplicative 0 6
public export n_pehelycsomo2 : HuWord
n_pehelycsomo2 = MkHu "pehelycsomó" "pehelycsomó" ObjectRole Additive 0 11
public export n_pelenka : HuWord
n_pelenka = MkHu "pelenka" "pelenka" ObjectRole Additive 0 7
public export n_pelenka2ztata2s : HuWord
n_pelenka2ztata2s = MkHu "pelenkáztatás" "pelenkáztatás" ObjectRole Additive 0 13
public export n_pelenka2za2s : HuWord
n_pelenka2za2s = MkHu "pelenkázás" "pelenkázás" ObjectRole Additive 0 10
public export n_pelyva : HuWord
n_pelyva = MkHu "pelyva" "pelyva" ObjectRole Additive 0 6
public export n_persely : HuWord
n_persely = MkHu "persely" "persely" ObjectRole Multiplicative 0 7
public export n_piac : HuWord
n_piac = MkHu "piac" "piac" ObjectRole Additive 0 4
public export n_piacte2r : HuWord
n_piacte2r = MkHu "piactér" "piactér" ObjectRole Multiplicative 0 7
public export n_pillango2 : HuWord
n_pillango2 = MkHu "pillangó" "pillangó" ObjectRole Additive 0 8
public export n_pilo2take2pzo4 : HuWord
n_pilo2take2pzo4 = MkHu "pilótaképző" "pilótaképző" ObjectRole Multiplicative 0 11
public export n_pisko2tate2szta : HuWord
n_pisko2tate2szta = MkHu "piskótatészta" "piskótatészta" ObjectRole Additive 0 13
public export n_piszkos : HuWord
n_piszkos = MkHu "piszkos" "piszkos" ObjectRole Additive 0 7
public export n_piszmoga2s : HuWord
n_piszmoga2s = MkHu "piszmogás" "piszmogás" ObjectRole Additive 0 9
public export n_pityo2ka : HuWord
n_pityo2ka = MkHu "pityóka" "pityóka" ObjectRole Additive 0 7
public export n_plaka2t : HuWord
n_plaka2t = MkHu "plakát" "plaká" ObjectRole Additive 2 6
public export n_podzol : HuWord
n_podzol = MkHu "podzol" "podzol" ObjectRole Additive 0 6
public export n_pofaszaka2ll : HuWord
n_pofaszaka2ll = MkHu "pofaszakáll" "pofaszakáll" ObjectRole Additive 0 11
public export n_pokol : HuWord
n_pokol = MkHu "pokol" "pokol" ObjectRole Additive 0 5
public export n_polga2rsa2g : HuWord
n_polga2rsa2g = MkHu "polgárság" "polgárság" ObjectRole Additive 0 9
public export n_porlada2s : HuWord
n_porlada2s = MkHu "porladás" "porladás" ObjectRole Additive 0 8
public export n_poroszka : HuWord
n_poroszka = MkHu "poroszka" "poroszka" ObjectRole Additive 0 8
public export n_posva2ny : HuWord
n_posva2ny = MkHu "posvány" "posvány" ObjectRole Additive 0 7
public export n_prefixum : HuWord
n_prefixum = MkHu "prefixum" "prefixum" ObjectRole Additive 0 8
public export n_produktivita2s : HuWord
n_produktivita2s = MkHu "produktivitás" "produktivitás" ObjectRole Additive 0 13
public export n_protekcio2 : HuWord
n_protekcio2 = MkHu "protekció" "protekció" ObjectRole Additive 0 9
public export n_pro2ba : HuWord
n_pro2ba = MkHu "próba" "pró" ObjectRole Additive 1 5
public export n_pufferoldat : HuWord
n_pufferoldat = MkHu "pufferoldat" "pufferold" ObjectRole Additive 2 11
public export n_pulykakakas : HuWord
n_pulykakakas = MkHu "pulykakakas" "pulykakakas" ObjectRole Additive 0 11
public export n_pusztasa2g : HuWord
n_pusztasa2g = MkHu "pusztaság" "pusztaság" ObjectRole Additive 0 9
public export n_pusztula2s : HuWord
n_pusztula2s = MkHu "pusztulás" "pusztulás" ObjectRole Additive 0 9
public export n_pusztule2s : HuWord
n_pusztule2s = MkHu "pusztulés" "pusztulés" ObjectRole Multiplicative 0 9
public export n_pa2lca : HuWord
n_pa2lca = MkHu "pálca" "pálca" ObjectRole Additive 0 5
public export n_pa2linkafo4ze2s : HuWord
n_pa2linkafo4ze2s = MkHu "pálinkafőzés" "pálinkafőzés" ObjectRole Multiplicative 0 12
public export n_pa2nce2lauto2 : HuWord
n_pa2nce2lauto2 = MkHu "páncélautó" "páncélautó" ObjectRole Additive 0 10
public export n_pa2nce2lge2pkocsi : HuWord
n_pa2nce2lge2pkocsi = MkHu "páncélgépkocsi" "páncélgépkocsi" ObjectRole Multiplicative 0 14
public export n_pa2nce2lvonat : HuWord
n_pa2nce2lvonat = MkHu "páncélvonat" "páncélv" ObjectRole Multiplicative 3 11
public export n_pa2nce2lzat : HuWord
n_pa2nce2lzat = MkHu "páncélzat" "páncélz" ObjectRole Multiplicative 2 9
public export n_pa2nyva : HuWord
n_pa2nyva = MkHu "pányva" "pányva" ObjectRole Additive 0 6
public export n_pa2ra : HuWord
n_pa2ra = MkHu "pára" "pára" ObjectRole Additive 0 4
public export n_pa2rolga2s : HuWord
n_pa2rolga2s = MkHu "párolgás" "párolgás" ObjectRole Additive 0 8
public export n_pa2roztata2s : HuWord
n_pa2roztata2s = MkHu "pároztatás" "pároztatás" ObjectRole Additive 0 10
public export n_pa2rza2s : HuWord
n_pa2rza2s = MkHu "párzás" "párzás" ObjectRole Additive 0 6
public export n_pa2ra2soda2s : HuWord
n_pa2ra2soda2s = MkHu "párásodás" "párásodás" ObjectRole Additive 0 9
public export n_pe2ntek : HuWord
n_pe2ntek = MkHu "péntek" "pén" ObjectRole Multiplicative 6 6
public export n_pe2nzta2rca : HuWord
n_pe2nzta2rca = MkHu "pénztárca" "pénztárca" ObjectRole Additive 0 9
public export n_po2lya2la2s : HuWord
n_po2lya2la2s = MkHu "pólyálás" "pólyálás" ObjectRole Additive 0 8
public export n_po3szo3rle2gy : HuWord
n_po3szo3rle2gy = MkHu "pöszörlégy" "pöszörlégy" ObjectRole Multiplicative 0 10
public export n_rab : HuWord
n_rab = MkHu "rab" "rab" ObjectRole Additive 0 3
public export n_rablo2 : HuWord
n_rablo2 = MkHu "rabló" "rabló" ObjectRole Additive 0 5
public export n_rabsa2g : HuWord
n_rabsa2g = MkHu "rabság" "rabság" ObjectRole Additive 0 6
public export n_radi2r : HuWord
n_radi2r = MkHu "radír" "radír" ObjectRole Multiplicative 0 5
public export n_ragadozo2 : HuWord
n_ragadozo2 = MkHu "ragadozó" "ragadozó" ObjectRole Additive 0 8
public export n_ragyoga2s : HuWord
n_ragyoga2s = MkHu "ragyogás" "ragyogás" ObjectRole Additive 0 8
public export n_rajonga2s : HuWord
n_rajonga2s = MkHu "rajongás" "rajongás" ObjectRole Additive 0 8
public export n_ravaszsa2g : HuWord
n_ravaszsa2g = MkHu "ravaszság" "ravaszság" ObjectRole Additive 0 9
public export n_rejto4zko3de2s : HuWord
n_rejto4zko3de2s = MkHu "rejtőzködés" "rejtőzködés" ObjectRole Multiplicative 0 11
public export n_remek : HuWord
n_remek = MkHu "remek" "rem" ObjectRole Multiplicative 4 5
public export n_reme2nykedo4 : HuWord
n_reme2nykedo4 = MkHu "reménykedő" "reménykedő" ObjectRole Multiplicative 0 10
public export n_rendellenesse2g : HuWord
n_rendellenesse2g = MkHu "rendellenesség" "rendellenesség" ObjectRole Multiplicative 0 14
public export n_rendetlen : HuWord
n_rendetlen = MkHu "rendetlen" "rendetl" ObjectRole Multiplicative 1 9
public export n_repu3le2s : HuWord
n_repu3le2s = MkHu "repülés" "repülés" ObjectRole Multiplicative 0 7
public export n_repu3lo4ge2p : HuWord
n_repu3lo4ge2p = MkHu "repülőgép" "repülőgép" ObjectRole Multiplicative 0 9
public export n_repu3lo4ge2pgya2r : HuWord
n_repu3lo4ge2pgya2r = MkHu "repülőgépgyár" "repülőgépgyár" ObjectRole Additive 0 13
public export n_repu3lo4ge2pmodell : HuWord
n_repu3lo4ge2pmodell = MkHu "repülőgépmodell" "repülőgépmodell" ObjectRole Multiplicative 0 15
public export n_repu3lo4ge2ptervezo4 : HuWord
n_repu3lo4ge2ptervezo4 = MkHu "repülőgéptervező" "repülőgéptervező" ObjectRole Multiplicative 0 16
public export n_repu3lo4iskola : HuWord
n_repu3lo4iskola = MkHu "repülőiskola" "repülőiskola" ObjectRole Additive 0 12
public export n_repu3lo4s : HuWord
n_repu3lo4s = MkHu "repülős" "repülős" ObjectRole Multiplicative 0 7
public export n_repu3lo4te2r : HuWord
n_repu3lo4te2r = MkHu "repülőtér" "repülőtér" ObjectRole Multiplicative 0 9
public export n_retesz : HuWord
n_retesz = MkHu "retesz" "retesz" ObjectRole Multiplicative 0 6
public export n_reteszelt : HuWord
n_reteszelt = MkHu "reteszelt" "reteszel" ObjectRole Multiplicative 2 9
public export n_robot : HuWord
n_robot = MkHu "robot" "rob" ObjectRole Additive 2 5
public export n_roham : HuWord
n_roham = MkHu "roham" "roham" ObjectRole Additive 0 5
public export n_rokon : HuWord
n_rokon = MkHu "rokon" "rok" ObjectRole Additive 1 5
public export n_romla2s : HuWord
n_romla2s = MkHu "romlás" "romlás" ObjectRole Additive 0 6
public export n_roste2lyos : HuWord
n_roste2lyos = MkHu "rostélyos" "rostélyos" ObjectRole Additive 0 9
public export n_rozsnok : HuWord
n_rozsnok = MkHu "rozsnok" "rozs" ObjectRole Additive 5 7
public export n_ruha : HuWord
n_ruha = MkHu "ruha" "ruha" ObjectRole Additive 0 4
public export n_rutin : HuWord
n_rutin = MkHu "rutin" "ruti" ObjectRole Multiplicative 1 5
public export n_rutinos : HuWord
n_rutinos = MkHu "rutinos" "rutinos" ObjectRole Additive 0 7
public export n_ra2besze2le2s : HuWord
n_ra2besze2le2s = MkHu "rábeszélés" "rábeszélés" ObjectRole Multiplicative 0 10
public export n_ra2csavaroda2s : HuWord
n_ra2csavaroda2s = MkHu "rácsavarodás" "rácsavarodás" ObjectRole Additive 0 12
public export n_ra2tekerede2s : HuWord
n_ra2tekerede2s = MkHu "rátekeredés" "rátekeredés" ObjectRole Multiplicative 0 11
public export n_ra2tekertete2s : HuWord
n_ra2tekertete2s = MkHu "rátekertetés" "rátekertetés" ObjectRole Multiplicative 0 12
public export n_ra2tekere2s : HuWord
n_ra2tekere2s = MkHu "rátekerés" "rátekerés" ObjectRole Multiplicative 0 9
public export n_re2g : HuWord
n_re2g = MkHu "rég" "rég" ObjectRole Multiplicative 0 3
public export n_re2ge2szet : HuWord
n_re2ge2szet = MkHu "régészet" "régész" ObjectRole Multiplicative 2 8
public export n_re2ma2lom : HuWord
n_re2ma2lom = MkHu "rémálom" "rémál" ObjectRole Additive 32 7
public export n_re2sz : HuWord
n_re2sz = MkHu "rész" "rész" ObjectRole Multiplicative 0 4
public export n_re2t : HuWord
n_re2t = MkHu "rét" "rét" ObjectRole Multiplicative 0 3
public export n_ro3vidi2te2s : HuWord
n_ro3vidi2te2s = MkHu "rövidítés" "rövidítés" ObjectRole Multiplicative 0 9
public export n_ru2tsa2g : HuWord
n_ru2tsa2g = MkHu "rútság" "rútság" ObjectRole Additive 0 6
public export n_ru3gy : HuWord
n_ru3gy = MkHu "rügy" "rügy" ObjectRole Multiplicative 0 4
public export n_ru3gyeze2s : HuWord
n_ru3gyeze2s = MkHu "rügyezés" "rügyezés" ObjectRole Multiplicative 0 8
public export n_ro4f : HuWord
n_ro4f = MkHu "rőf" "rőf" ObjectRole Multiplicative 0 3
public export n_sajtkukac : HuWord
n_sajtkukac = MkHu "sajtkukac" "sajtkukac" ObjectRole Additive 0 9
public export n_saja2tsa2gossa2g : HuWord
n_saja2tsa2gossa2g = MkHu "sajátságosság" "sajátságosság" ObjectRole Additive 0 13
public export n_sas : HuWord
n_sas = MkHu "sas" "sas" ObjectRole Additive 0 3
public export n_satu : HuWord
n_satu = MkHu "satu" "satu" ObjectRole Additive 0 4
public export n_seb : HuWord
n_seb = MkHu "seb" "seb" ObjectRole Multiplicative 0 3
public export n_segg : HuWord
n_segg = MkHu "segg" "segg" ObjectRole Multiplicative 0 4
public export n_sege2d : HuWord
n_sege2d = MkHu "segéd" "segéd" ObjectRole Multiplicative 0 5
public export n_segi2tse2g : HuWord
n_segi2tse2g = MkHu "segítség" "segítség" ObjectRole Multiplicative 0 8
public export n_segi2te2s : HuWord
n_segi2te2s = MkHu "segítés" "segítés" ObjectRole Multiplicative 0 7
public export n_selejt : HuWord
n_selejt = MkHu "selejt" "sele" ObjectRole Multiplicative 18 6
public export n_selejtgya2rto2 : HuWord
n_selejtgya2rto2 = MkHu "selejtgyártó" "selejtgyártó" ObjectRole Additive 0 12
public export n_selyem : HuWord
n_selyem = MkHu "selyem" "sely" ObjectRole Multiplicative 32 6
public export n_semmise2g : HuWord
n_semmise2g = MkHu "semmiség" "semmiség" ObjectRole Multiplicative 0 8
public export n_semmittevo4 : HuWord
n_semmittevo4 = MkHu "semmittevő" "semmittevő" ObjectRole Multiplicative 0 10
public export n_senki : HuWord
n_senki = MkHu "senki" "senki" ObjectRole Multiplicative 0 5
public export n_serleg : HuWord
n_serleg = MkHu "serleg" "serleg" ObjectRole Multiplicative 0 6
public export n_siker : HuWord
n_siker = MkHu "siker" "siker" ObjectRole Multiplicative 0 5
public export n_sivatag : HuWord
n_sivatag = MkHu "sivatag" "sivatag" ObjectRole Additive 0 7
public export n_skorbut : HuWord
n_skorbut = MkHu "skorbut" "skorbu" ObjectRole Additive 2 7
public export n_sminkeltete2s : HuWord
n_sminkeltete2s = MkHu "sminkeltetés" "sminkeltetés" ObjectRole Multiplicative 0 12
public export n_sminkele2s : HuWord
n_sminkele2s = MkHu "sminkelés" "sminkelés" ObjectRole Multiplicative 0 9
public export n_sokasoda2s : HuWord
n_sokasoda2s = MkHu "sokasodás" "sokasodás" ObjectRole Additive 0 9
public export n_sors : HuWord
n_sors = MkHu "sors" "sors" ObjectRole Additive 0 4
public export n_specifikussa2g : HuWord
n_specifikussa2g = MkHu "specifikusság" "specifikusság" ObjectRole Additive 0 13
public export n_spriccele2s : HuWord
n_spriccele2s = MkHu "spriccelés" "spriccelés" ObjectRole Multiplicative 0 10
public export n_steak : HuWord
n_steak = MkHu "steak" "ste" ObjectRole Multiplicative 4 5
public export n_sva2jcisapka : HuWord
n_sva2jcisapka = MkHu "svájcisapka" "svájcisapka" ObjectRole Additive 0 11
public export n_szaba2lytalansa2g : HuWord
n_szaba2lytalansa2g = MkHu "szabálytalanság" "szabálytalanság" ObjectRole Additive 0 15
public export n_szarufa : HuWord
n_szarufa = MkHu "szarufa" "szarufa" ObjectRole Additive 0 7
public export n_szarufaa2lli2ta2s : HuWord
n_szarufaa2lli2ta2s = MkHu "szarufaállítás" "szarufaállítás" ObjectRole Additive 0 14
public export n_szarvas : HuWord
n_szarvas = MkHu "szarvas" "szarvas" ObjectRole Additive 0 7
public export n_szedete2s : HuWord
n_szedete2s = MkHu "szedetés" "szedetés" ObjectRole Multiplicative 0 8
public export n_szede2s : HuWord
n_szede2s = MkHu "szedés" "szedés" ObjectRole Multiplicative 0 6
public export n_szedo4 : HuWord
n_szedo4 = MkHu "szedő" "szedő" ObjectRole Multiplicative 0 5
public export n_szege2ny : HuWord
n_szege2ny = MkHu "szegény" "szegény" ObjectRole Multiplicative 0 7
public export n_szeke2r : HuWord
n_szeke2r = MkHu "szekér" "szekér" ObjectRole Multiplicative 0 6
public export n_szeleburdi : HuWord
n_szeleburdi = MkHu "szeleburdi" "szeleburdi" ObjectRole Multiplicative 0 10
public export n_szello4 : HuWord
n_szello4 = MkHu "szellő" "szellő" ObjectRole Multiplicative 0 6
public export n_szem : HuWord
n_szem = MkHu "szem" "szem" ObjectRole Multiplicative 0 4
public export n_szemmereszte2s : HuWord
n_szemmereszte2s = MkHu "szemmeresztés" "szemmeresztés" ObjectRole Multiplicative 0 13
public export n_szemtanu2 : HuWord
n_szemtanu2 = MkHu "szemtanú" "szemtanú" ObjectRole Additive 0 8
public export n_szemtelen : HuWord
n_szemtelen = MkHu "szemtelen" "szemtel" ObjectRole Multiplicative 1 9
public export n_szemtelenkede2s : HuWord
n_szemtelenkede2s = MkHu "szemtelenkedés" "szemtelenkedés" ObjectRole Multiplicative 0 14
public export n_szeme2lyzet : HuWord
n_szeme2lyzet = MkHu "személyzet" "személyz" ObjectRole Multiplicative 2 10
public export n_szendvics : HuWord
n_szendvics = MkHu "szendvics" "szendvics" ObjectRole Multiplicative 0 9
public export n_szendvicskenye2r : HuWord
n_szendvicskenye2r = MkHu "szendvicskenyér" "szendvicskenyér" ObjectRole Multiplicative 0 15
public export n_szenilita2s : HuWord
n_szenilita2s = MkHu "szenilitás" "szenilitás" ObjectRole Additive 0 10
public export n_szent : HuWord
n_szent = MkHu "szent" "sze" ObjectRole Multiplicative 3 5
public export n_szentse2g : HuWord
n_szentse2g = MkHu "szentség" "szentség" ObjectRole Multiplicative 0 8
public export n_szenvede2ly : HuWord
n_szenvede2ly = MkHu "szenvedély" "szenvedély" ObjectRole Multiplicative 0 10
public export n_szenvede2s : HuWord
n_szenvede2s = MkHu "szenvedés" "szenvedés" ObjectRole Multiplicative 0 9
public export n_szerencse : HuWord
n_szerencse = MkHu "szerencse" "szerencse" ObjectRole Multiplicative 0 9
public export n_szerencse2tlen : HuWord
n_szerencse2tlen = MkHu "szerencsétlen" "szerencsétl" ObjectRole Multiplicative 1 13
public export n_szerkezet : HuWord
n_szerkezet = MkHu "szerkezet" "szerkez" ObjectRole Multiplicative 2 9
public export n_szerzo4 : HuWord
n_szerzo4 = MkHu "szerző" "szerző" ObjectRole Multiplicative 0 6
public export n_szesze2ly : HuWord
n_szesze2ly = MkHu "szeszély" "szeszély" ObjectRole Multiplicative 0 8
public export n_szesze2lyes : HuWord
n_szesze2lyes = MkHu "szeszélyes" "szeszélyes" ObjectRole Multiplicative 0 10
public export n_szesze2lyeskede2s : HuWord
n_szesze2lyeskede2s = MkHu "szeszélyeskedés" "szeszélyeskedés" ObjectRole Multiplicative 0 15
public export n_szesze2lyesse2g : HuWord
n_szesze2lyesse2g = MkHu "szeszélyesség" "szeszélyesség" ObjectRole Multiplicative 0 13
public export n_szifilisz : HuWord
n_szifilisz = MkHu "szifilisz" "szifilisz" ObjectRole Multiplicative 0 9
public export n_sziget : HuWord
n_sziget = MkHu "sziget" "szig" ObjectRole Multiplicative 2 6
public export n_szigetvila2g : HuWord
n_szigetvila2g = MkHu "szigetvilág" "szigetvilág" ObjectRole Additive 0 11
public export n_szigony : HuWord
n_szigony = MkHu "szigony" "szigony" ObjectRole Additive 0 7
public export n_szimula2la2s : HuWord
n_szimula2la2s = MkHu "szimulálás" "szimulálás" ObjectRole Additive 0 10
public export n_szimula2lo2 : HuWord
n_szimula2lo2 = MkHu "szimuláló" "szimuláló" ObjectRole Additive 0 9
public export n_szintvonal : HuWord
n_szintvonal = MkHu "szintvonal" "szintvonal" ObjectRole Additive 0 10
public export n_szipoga2s : HuWord
n_szipoga2s = MkHu "szipogás" "szipogás" ObjectRole Additive 0 8
public export n_szolga : HuWord
n_szolga = MkHu "szolga" "szolga" ObjectRole Additive 0 6
public export n_szomsze2d : HuWord
n_szomsze2d = MkHu "szomszéd" "szomszéd" ObjectRole Multiplicative 0 8
public export n_szorti2roza2s : HuWord
n_szorti2roza2s = MkHu "szortírozás" "szortírozás" ObjectRole Additive 0 11
public export n_sztra2jk : HuWord
n_sztra2jk = MkHu "sztrájk" "sztrá" ObjectRole Additive 20 7
public export n_sztra2jkolo2 : HuWord
n_sztra2jkolo2 = MkHu "sztrájkoló" "sztrájkoló" ObjectRole Additive 0 10
public export n_szubjektum : HuWord
n_szubjektum = MkHu "szubjektum" "szubjektum" ObjectRole Additive 0 10
public export n_szusze2k : HuWord
n_szusze2k = MkHu "szuszék" "szuszé" ObjectRole Multiplicative 4 7
public export n_szuverenita2s : HuWord
n_szuverenita2s = MkHu "szuverenitás" "szuverenitás" ObjectRole Additive 0 12
public export n_sza2dorgo2 : HuWord
n_sza2dorgo2 = MkHu "szádorgó" "szádorgó" ObjectRole Additive 0 8
public export n_sza2jharmonika : HuWord
n_sza2jharmonika = MkHu "szájharmonika" "szájharmonika" ObjectRole Additive 0 13
public export n_sza2jpadla2s : HuWord
n_sza2jpadla2s = MkHu "szájpadlás" "szájpadlás" ObjectRole Additive 0 10
public export n_sza2mtan : HuWord
n_sza2mtan = MkHu "számtan" "számta" ObjectRole Additive 1 7
public export n_sza2mi2to2ge2p : HuWord
n_sza2mi2to2ge2p = MkHu "számítógép" "számítógép" ObjectRole Multiplicative 0 10
public export n_sza2nko2 : HuWord
n_sza2nko2 = MkHu "szánkó" "szánkó" ObjectRole Additive 0 6
public export n_sza2nto2fo3ld : HuWord
n_sza2nto2fo3ld = MkHu "szántóföld" "szántóföld" ObjectRole Multiplicative 0 10
public export n_sza2razelem : HuWord
n_sza2razelem = MkHu "szárazelem" "szárazel" ObjectRole Multiplicative 32 10
public export n_sza2rny : HuWord
n_sza2rny = MkHu "szárny" "szárny" ObjectRole Additive 0 6
public export n_sze2du3le2s : HuWord
n_sze2du3le2s = MkHu "szédülés" "szédülés" ObjectRole Multiplicative 0 8
public export n_sze2kele2s : HuWord
n_sze2kele2s = MkHu "székelés" "székelés" ObjectRole Multiplicative 0 8
public export n_sze2pirodalom : HuWord
n_sze2pirodalom = MkHu "szépirodalom" "szépirodal" ObjectRole Additive 32 12
public export n_sze2t : HuWord
n_sze2t = MkHu "szét" "szé" ObjectRole Multiplicative 2 4
public export n_sze2tbonta2s : HuWord
n_sze2tbonta2s = MkHu "szétbontás" "szétbontás" ObjectRole Additive 0 10
public export n_sze2tfoszlat : HuWord
n_sze2tfoszlat = MkHu "szétfoszlat" "szétfoszl" ObjectRole Additive 2 11
public export n_sze2tfoszlata2s : HuWord
n_sze2tfoszlata2s = MkHu "szétfoszlatás" "szétfoszlatás" ObjectRole Additive 0 13
public export n_sze2tfoszla2s : HuWord
n_sze2tfoszla2s = MkHu "szétfoszlás" "szétfoszlás" ObjectRole Additive 0 11
public export n_sze2tmara2s : HuWord
n_sze2tmara2s = MkHu "szétmarás" "szétmarás" ObjectRole Additive 0 9
public export n_sze2trongyola2s : HuWord
n_sze2trongyola2s = MkHu "szétrongyolás" "szétrongyolás" ObjectRole Additive 0 13
public export n_sze2trongyolo2da2s : HuWord
n_sze2trongyolo2da2s = MkHu "szétrongyolódás" "szétrongyolódás" ObjectRole Additive 0 15
public export n_sze2tszede2s : HuWord
n_sze2tszede2s = MkHu "szétszedés" "szétszedés" ObjectRole Multiplicative 0 10
public export n_sze2tszo2ra2s : HuWord
n_sze2tszo2ra2s = MkHu "szétszórás" "szétszórás" ObjectRole Additive 0 10
public export n_sze2tte2pe2s : HuWord
n_sze2tte2pe2s = MkHu "széttépés" "széttépés" ObjectRole Multiplicative 0 9
public export n_sze2tva2laszta2s : HuWord
n_sze2tva2laszta2s = MkHu "szétválasztás" "szétválasztás" ObjectRole Additive 0 13
public export n_sze2tva2logattata2s : HuWord
n_sze2tva2logattata2s = MkHu "szétválogattatás" "szétválogattatás" ObjectRole Additive 0 16
public export n_sze2tva2logata2s : HuWord
n_sze2tva2logata2s = MkHu "szétválogatás" "szétválogatás" ObjectRole Additive 0 13
public export n_szi2n : HuWord
n_szi2n = MkHu "szín" "szí" ObjectRole Multiplicative 1 4
public export n_szi2neztete2s : HuWord
n_szi2neztete2s = MkHu "színeztetés" "színeztetés" ObjectRole Multiplicative 0 11
public export n_szi2neze2s : HuWord
n_szi2neze2s = MkHu "színezés" "színezés" ObjectRole Multiplicative 0 8
public export n_szi2ne2sz : HuWord
n_szi2ne2sz = MkHu "színész" "színész" ObjectRole Multiplicative 0 7
public export n_szi2ne2szno4 : HuWord
n_szi2ne2szno4 = MkHu "színésznő" "színésznő" ObjectRole Multiplicative 0 9
public export n_szi2vdoboga2s : HuWord
n_szi2vdoboga2s = MkHu "szívdobogás" "szívdobogás" ObjectRole Additive 0 11
public export n_szi2vvere2s : HuWord
n_szi2vvere2s = MkHu "szívverés" "szívverés" ObjectRole Multiplicative 0 9
public export n_szo2sza2tya2r : HuWord
n_szo2sza2tya2r = MkHu "szószátyár" "szószátyár" ObjectRole Additive 0 10
public export n_szo3keve2ny : HuWord
n_szo3keve2ny = MkHu "szökevény" "szökevény" ObjectRole Multiplicative 0 9
public export n_szo3ke2s : HuWord
n_szo3ke2s = MkHu "szökés" "szökés" ObjectRole Multiplicative 0 6
public export n_szo3rny : HuWord
n_szo3rny = MkHu "szörny" "szörny" ObjectRole Multiplicative 0 6
public export n_szo3rnyeteg : HuWord
n_szo3rnyeteg = MkHu "szörnyeteg" "szörnyeteg" ObjectRole Multiplicative 0 10
public export n_szo3vet : HuWord
n_szo3vet = MkHu "szövet" "szöv" ObjectRole Multiplicative 2 6
public export n_szo3vetkendo4 : HuWord
n_szo3vetkendo4 = MkHu "szövetkendő" "szövetkendő" ObjectRole Multiplicative 0 11
public export n_szo3vetkezet : HuWord
n_szo3vetkezet = MkHu "szövetkezet" "szövetkez" ObjectRole Multiplicative 2 11
public export n_szu2ra2s : HuWord
n_szu2ra2s = MkHu "szúrás" "szúrás" ObjectRole Additive 0 6
public export n_szu3le2sz : HuWord
n_szu3le2sz = MkHu "szülész" "szülész" ObjectRole Multiplicative 0 7
public export n_szu3le2szno4 : HuWord
n_szu3le2szno4 = MkHu "szülésznő" "szülésznő" ObjectRole Multiplicative 0 9
public export n_szu3lo4fo3ld : HuWord
n_szu3lo4fo3ld = MkHu "szülőföld" "szülőföld" ObjectRole Multiplicative 0 9
public export n_szu3lo4k : HuWord
n_szu3lo4k = MkHu "szülők" "szülő" ObjectRole Multiplicative 4 6
public export n_szu3net : HuWord
n_szu3net = MkHu "szünet" "szü" ObjectRole Multiplicative 3 6
public export n_szu3rku3let : HuWord
n_szu3rku3let = MkHu "szürkület" "szürkül" ObjectRole Multiplicative 2 9
public export n_szu4kszavu2 : HuWord
n_szu4kszavu2 = MkHu "szűkszavú" "szűkszavú" ObjectRole Additive 0 9
public export n_sa2rka2ny : HuWord
n_sa2rka2ny = MkHu "sárkány" "sárkány" ObjectRole Additive 0 7
public export n_sa2v : HuWord
n_sa2v = MkHu "sáv" "sáv" ObjectRole Additive 0 3
public export n_se2ta2ny : HuWord
n_se2ta2ny = MkHu "sétány" "sétány" ObjectRole Additive 0 6
public export n_si2rdoga2la2s : HuWord
n_si2rdoga2la2s = MkHu "sírdogálás" "sírdogálás" ObjectRole Additive 0 10
public export n_so2gor : HuWord
n_so2gor = MkHu "sógor" "sógor" ObjectRole Additive 0 5
public export n_so2gorno4 : HuWord
n_so2gorno4 = MkHu "sógornő" "sógornő" ObjectRole Multiplicative 0 7
public export n_su3ge2r : HuWord
n_su3ge2r = MkHu "sügér" "sügér" ObjectRole Multiplicative 0 5
public export n_su3ketne2ma : HuWord
n_su3ketne2ma = MkHu "süketnéma" "süketnéma" ObjectRole Additive 0 9
public export n_su3ti : HuWord
n_su3ti = MkHu "süti" "süti" ObjectRole Multiplicative 0 4
public export n_su4ru4so3de2s : HuWord
n_su4ru4so3de2s = MkHu "sűrűsödés" "sűrűsödés" ObjectRole Multiplicative 0 9
public export n_takaro2 : HuWord
n_takaro2 = MkHu "takaró" "takaró" ObjectRole Additive 0 6
public export n_talajfu2ra2s : HuWord
n_talajfu2ra2s = MkHu "talajfúrás" "talajfúrás" ObjectRole Additive 0 10
public export n_tala2lkoza2s : HuWord
n_tala2lkoza2s = MkHu "találkozás" "találkozás" ObjectRole Additive 0 10
public export n_tala2le2konysa2g : HuWord
n_tala2le2konysa2g = MkHu "találékonyság" "találékonyság" ObjectRole Additive 0 13
public export n_tamburin : HuWord
n_tamburin = MkHu "tamburin" "tamburi" ObjectRole Multiplicative 1 8
public export n_tanu2 : HuWord
n_tanu2 = MkHu "tanú" "tanú" ObjectRole Additive 0 4
public export n_tanu2si2t : HuWord
n_tanu2si2t = MkHu "tanúsít" "tanúsí" ObjectRole Multiplicative 2 7
public export n_tanu2si2tva2ny : HuWord
n_tanu2si2tva2ny = MkHu "tanúsítvány" "tanúsítvány" ObjectRole Additive 0 11
public export n_tapada2s : HuWord
n_tapada2s = MkHu "tapadás" "tapadás" ObjectRole Additive 0 7
public export n_tapasztalat : HuWord
n_tapasztalat = MkHu "tapasztalat" "tapasztal" ObjectRole Additive 2 11
public export n_tartale2kola2s : HuWord
n_tartale2kola2s = MkHu "tartalékolás" "tartalékolás" ObjectRole Additive 0 12
public export n_tarta2sdi2j : HuWord
n_tarta2sdi2j = MkHu "tartásdíj" "tartásdí" ObjectRole Multiplicative 16 9
public export n_tarto2oszlop : HuWord
n_tarto2oszlop = MkHu "tartóoszlop" "tartóoszlop" ObjectRole Additive 0 11
public export n_tata2r : HuWord
n_tata2r = MkHu "tatár" "tatár" ObjectRole Additive 0 5
public export n_tegnapelo4tt : HuWord
n_tegnapelo4tt = MkHu "tegnapelőtt" "tegnapelő" ObjectRole Multiplicative 8 11
public export n_tekercs : HuWord
n_tekercs = MkHu "tekercs" "tekercs" ObjectRole Multiplicative 0 7
public export n_tekinte2ly : HuWord
n_tekinte2ly = MkHu "tekintély" "tekintély" ObjectRole Multiplicative 0 9
public export n_telephely : HuWord
n_telephely = MkHu "telephely" "telephely" ObjectRole Multiplicative 0 9
public export n_telhetetlen : HuWord
n_telhetetlen = MkHu "telhetetlen" "telhetetl" ObjectRole Multiplicative 1 11
public export n_telhetetlense2g : HuWord
n_telhetetlense2g = MkHu "telhetetlenség" "telhetetlenség" ObjectRole Multiplicative 0 14
public export n_tenye2sztete2s : HuWord
n_tenye2sztete2s = MkHu "tenyésztetés" "tenyésztetés" ObjectRole Multiplicative 0 12
public export n_tenye2szte2s : HuWord
n_tenye2szte2s = MkHu "tenyésztés" "tenyésztés" ObjectRole Multiplicative 0 10
public export n_tene2ysze2s : HuWord
n_tene2ysze2s = MkHu "tenéyszés" "tenéyszés" ObjectRole Multiplicative 0 9
public export n_terhesse2gmegszaki2ta2s : HuWord
n_terhesse2gmegszaki2ta2s = MkHu "terhességmegszakítás" "terhességmegszakítás" ObjectRole Additive 0 20
public export n_terjede2s : HuWord
n_terjede2s = MkHu "terjedés" "terjedés" ObjectRole Multiplicative 0 8
public export n_terjedo4 : HuWord
n_terjedo4 = MkHu "terjedő" "terjedő" ObjectRole Multiplicative 0 7
public export n_termele2kenyse2g : HuWord
n_termele2kenyse2g = MkHu "termelékenység" "termelékenység" ObjectRole Multiplicative 0 14
public export n_termesztete2s : HuWord
n_termesztete2s = MkHu "termesztetés" "termesztetés" ObjectRole Multiplicative 0 12
public export n_termeszte2s : HuWord
n_termeszte2s = MkHu "termesztés" "termesztés" ObjectRole Multiplicative 0 10
public export n_terme2s : HuWord
n_terme2s = MkHu "termés" "termés" ObjectRole Multiplicative 0 6
public export n_teru3let : HuWord
n_teru3let = MkHu "terület" "terül" ObjectRole Multiplicative 2 7
public export n_tesse2k : HuWord
n_tesse2k = MkHu "tessék" "tessé" ObjectRole Multiplicative 4 6
public export n_testesede2s : HuWord
n_testesede2s = MkHu "testesedés" "testesedés" ObjectRole Multiplicative 0 10
public export n_testve2rek : HuWord
n_testve2rek = MkHu "testvérek" "testvér" ObjectRole Multiplicative 4 9
public export n_tettete2s : HuWord
n_tettete2s = MkHu "tettetés" "tettetés" ObjectRole Multiplicative 0 8
public export n_tetteto4 : HuWord
n_tetteto4 = MkHu "tettető" "tettető" ObjectRole Multiplicative 0 7
public export n_tik : HuWord
n_tik = MkHu "tik" "tik" ObjectRole Multiplicative 0 3
public export n_tilta2s : HuWord
n_tilta2s = MkHu "tiltás" "tiltás" ObjectRole Additive 0 6
public export n_timso2 : HuWord
n_timso2 = MkHu "timsó" "timsó" ObjectRole Additive 0 5
public export n_tisztelet : HuWord
n_tisztelet = MkHu "tisztelet" "tisztel" ObjectRole Multiplicative 2 9
public export n_tolata2s : HuWord
n_tolata2s = MkHu "tolatás" "tolatás" ObjectRole Additive 0 7
public export n_tolma2cs : HuWord
n_tolma2cs = MkHu "tolmács" "tolmács" ObjectRole Additive 0 7
public export n_tolma2csoltata2s : HuWord
n_tolma2csoltata2s = MkHu "tolmácsoltatás" "tolmácsoltatás" ObjectRole Additive 0 14
public export n_tolma2csola2s : HuWord
n_tolma2csola2s = MkHu "tolmácsolás" "tolmácsolás" ObjectRole Additive 0 11
public export n_torkos : HuWord
n_torkos = MkHu "torkos" "torkos" ObjectRole Additive 0 6
public export n_torlasz : HuWord
n_torlasz = MkHu "torlasz" "torlasz" ObjectRole Additive 0 7
public export n_torokgyullada2s : HuWord
n_torokgyullada2s = MkHu "torokgyulladás" "torokgyulladás" ObjectRole Additive 0 14
public export n_torony : HuWord
n_torony = MkHu "torony" "torony" ObjectRole Additive 0 6
public export n_trombita : HuWord
n_trombita = MkHu "trombita" "trombita" ObjectRole Additive 0 8
public export n_trombita2la2s : HuWord
n_trombita2la2s = MkHu "trombitálás" "trombitálás" ObjectRole Additive 0 11
public export n_tuda2s : HuWord
n_tuda2s = MkHu "tudás" "tudás" ObjectRole Additive 0 5
public export n_tulajdon : HuWord
n_tulajdon = MkHu "tulajdon" "tulajd" ObjectRole Additive 1 8
public export n_tulajdonne2v : HuWord
n_tulajdonne2v = MkHu "tulajdonnév" "tulajdonnév" ObjectRole Multiplicative 0 11
public export n_turka2la2s : HuWord
n_turka2la2s = MkHu "turkálás" "turkálás" ObjectRole Additive 0 8
public export n_ta2gi2ta2s : HuWord
n_ta2gi2ta2s = MkHu "tágítás" "tágítás" ObjectRole Additive 0 7
public export n_ta2l : HuWord
n_ta2l = MkHu "tál" "tál" ObjectRole Additive 0 3
public export n_ta2mada2s : HuWord
n_ta2mada2s = MkHu "támadás" "támadás" ObjectRole Additive 0 7
public export n_ta2mado2 : HuWord
n_ta2mado2 = MkHu "támadó" "támadó" ObjectRole Additive 0 6
public export n_ta2maszkoda2s : HuWord
n_ta2maszkoda2s = MkHu "támaszkodás" "támaszkodás" ObjectRole Additive 0 11
public export n_ta2ncola2s : HuWord
n_ta2ncola2s = MkHu "táncolás" "táncolás" ObjectRole Additive 0 8
public export n_ta2ncos : HuWord
n_ta2ncos = MkHu "táncos" "táncos" ObjectRole Additive 0 6
public export n_ta2rgy : HuWord
n_ta2rgy = MkHu "tárgy" "tárgy" ObjectRole Additive 0 5
public export n_ta2rgyeset : HuWord
n_ta2rgyeset = MkHu "tárgyeset" "tárgyes" ObjectRole Multiplicative 2 9
public export n_ta2volsa2g : HuWord
n_ta2volsa2g = MkHu "távolság" "távolság" ObjectRole Additive 0 8
public export n_te2lihagyma : HuWord
n_te2lihagyma = MkHu "télihagyma" "télihagyma" ObjectRole Additive 0 10
public export n_te2r : HuWord
n_te2r = MkHu "tér" "tér" ObjectRole Multiplicative 0 3
public export n_te2ri2te2s : HuWord
n_te2ri2te2s = MkHu "térítés" "térítés" ObjectRole Multiplicative 0 7
public export n_te2tel : HuWord
n_te2tel = MkHu "tétel" "tétel" ObjectRole Multiplicative 0 5
public export n_te2tlenkede2s : HuWord
n_te2tlenkede2s = MkHu "tétlenkedés" "tétlenkedés" ObjectRole Multiplicative 0 11
public export n_to3bblet : HuWord
n_to3bblet = MkHu "többlet" "többl" ObjectRole Multiplicative 2 7
public export n_to3bbse2g : HuWord
n_to3bbse2g = MkHu "többség" "többség" ObjectRole Multiplicative 0 7
public export n_to3kfilko2 : HuWord
n_to3kfilko2 = MkHu "tökfilkó" "tökfilkó" ObjectRole Additive 0 8
public export n_to3lte2s : HuWord
n_to3lte2s = MkHu "töltés" "töltés" ObjectRole Multiplicative 0 6
public export n_to3lto4toll : HuWord
n_to3lto4toll = MkHu "töltőtoll" "töltőtoll" ObjectRole Additive 0 9
public export n_to3lto4a2lloma2s : HuWord
n_to3lto4a2lloma2s = MkHu "töltőállomás" "töltőállomás" ObjectRole Additive 0 12
public export n_to3mb : HuWord
n_to3mb = MkHu "tömb" "tömb" ObjectRole Multiplicative 0 4
public export n_to3mo3ri2te2s : HuWord
n_to3mo3ri2te2s = MkHu "tömörítés" "tömörítés" ObjectRole Multiplicative 0 9
public export n_to3nkremene2s : HuWord
n_to3nkremene2s = MkHu "tönkremenés" "tönkremenés" ObjectRole Multiplicative 0 11
public export n_to3rekve2s : HuWord
n_to3rekve2s = MkHu "törekvés" "törekvés" ObjectRole Multiplicative 0 8
public export n_to3rve2ny : HuWord
n_to3rve2ny = MkHu "törvény" "törvény" ObjectRole Multiplicative 0 7
public export n_to3ro3kparadicsom : HuWord
n_to3ro3kparadicsom = MkHu "törökparadicsom" "törökparadics" ObjectRole Multiplicative 32 15
public export n_to3ru3lko3zo4 : HuWord
n_to3ru3lko3zo4 = MkHu "törülköző" "törülköző" ObjectRole Multiplicative 0 9
public export n_tu2lsza2rnyala2s : HuWord
n_tu2lsza2rnyala2s = MkHu "túlszárnyalás" "túlszárnyalás" ObjectRole Additive 0 13
public export n_tu2lsza2rnyalo2 : HuWord
n_tu2lsza2rnyalo2 = MkHu "túlszárnyaló" "túlszárnyaló" ObjectRole Additive 0 12
public export n_tu2lza2s : HuWord
n_tu2lza2s = MkHu "túlzás" "túlzás" ObjectRole Additive 0 6
public export n_tu3do4fu4 : HuWord
n_tu3do4fu4 = MkHu "tüdőfű" "tüdőfű" ObjectRole Multiplicative 0 6
public export n_tu3neme2ny : HuWord
n_tu3neme2ny = MkHu "tünemény" "tünemény" ObjectRole Multiplicative 0 8
public export n_tu3zolto2fecskendo4 : HuWord
n_tu3zolto2fecskendo4 = MkHu "tüzoltófecskendő" "tüzoltófecskendő" ObjectRole Multiplicative 0 16
public export n_tu3ze2r : HuWord
n_tu3ze2r = MkHu "tüzér" "tüzér" ObjectRole Multiplicative 0 5
public export n_tu3ze2rse2g : HuWord
n_tu3ze2rse2g = MkHu "tüzérség" "tüzérség" ObjectRole Multiplicative 0 8
public export n_udvar : HuWord
n_udvar = MkHu "udvar" "udvar" ObjectRole Additive 0 5
public export n_unokahu2g : HuWord
n_unokahu2g = MkHu "unokahúg" "unokahúg" ObjectRole Additive 0 8
public export n_untattata2s : HuWord
n_untattata2s = MkHu "untattatás" "untattatás" ObjectRole Additive 0 10
public export n_untata2s : HuWord
n_untata2s = MkHu "untatás" "untatás" ObjectRole Additive 0 7
public export n_untato2 : HuWord
n_untato2 = MkHu "untató" "untató" ObjectRole Additive 0 6
public export n_uszoda : HuWord
n_uszoda = MkHu "uszoda" "uszoda" ObjectRole Additive 0 6
public export n_usza2ly : HuWord
n_usza2ly = MkHu "uszály" "uszály" ObjectRole Additive 0 6
public export n_utcagyerek : HuWord
n_utcagyerek = MkHu "utcagyerek" "utcagyer" ObjectRole Multiplicative 4 10
public export n_uta2na : HuWord
n_uta2na = MkHu "utána" "utána" ObjectRole Additive 0 5
public export n_uta2nza2s : HuWord
n_uta2nza2s = MkHu "utánzás" "utánzás" ObjectRole Additive 0 7
public export n_uta2nzo2 : HuWord
n_uta2nzo2 = MkHu "utánzó" "utánzó" ObjectRole Additive 0 6
public export n_uto2szo2 : HuWord
n_uto2szo2 = MkHu "utószó" "utószó" ObjectRole Additive 0 6
public export n_vadorzo2 : HuWord
n_vadorzo2 = MkHu "vadorzó" "vadorzó" ObjectRole Additive 0 7
public export n_vada2llat : HuWord
n_vada2llat = MkHu "vadállat" "vadáll" ObjectRole Additive 2 8
public export n_vado2c : HuWord
n_vado2c = MkHu "vadóc" "vadóc" ObjectRole Additive 0 5
public export n_vagyon : HuWord
n_vagyon = MkHu "vagyon" "vagy" ObjectRole Additive 1 6
public export n_vajfu4 : HuWord
n_vajfu4 = MkHu "vajfű" "vajfű" ObjectRole Multiplicative 0 5
public export n_vakond : HuWord
n_vakond = MkHu "vakond" "vakond" ObjectRole Additive 0 6
public export n_vakondtu2ra2s : HuWord
n_vakondtu2ra2s = MkHu "vakondtúrás" "vakondtúrás" ObjectRole Additive 0 11
public export n_valaki : HuWord
n_valaki = MkHu "valaki" "valaki" ObjectRole Multiplicative 0 6
public export n_varrata2s : HuWord
n_varrata2s = MkHu "varratás" "varratás" ObjectRole Additive 0 8
public export n_varra2s : HuWord
n_varra2s = MkHu "varrás" "varrás" ObjectRole Additive 0 6
public export n_vara2zsla2s : HuWord
n_vara2zsla2s = MkHu "varázslás" "varázslás" ObjectRole Additive 0 9
public export n_vara2zslo2 : HuWord
n_vara2zslo2 = MkHu "varázsló" "varázsló" ObjectRole Additive 0 8
public export n_vasvilla : HuWord
n_vasvilla = MkHu "vasvilla" "vasvilla" ObjectRole Additive 0 8
public export n_vasa2rnap : HuWord
n_vasa2rnap = MkHu "vasárnap" "vasárnap" ObjectRole Additive 0 8
public export n_vedle2s : HuWord
n_vedle2s = MkHu "vedlés" "vedlés" ObjectRole Multiplicative 0 6
public export n_verejte2k : HuWord
n_verejte2k = MkHu "verejték" "verejté" ObjectRole Multiplicative 4 8
public export n_versenylo2 : HuWord
n_versenylo2 = MkHu "versenyló" "versenyló" ObjectRole Additive 0 9
public export n_veri2te2k : HuWord
n_veri2te2k = MkHu "veríték" "veríté" ObjectRole Multiplicative 4 7
public export n_vevo4 : HuWord
n_vevo4 = MkHu "vevő" "vevő" ObjectRole Multiplicative 0 4
public export n_vezete2s : HuWord
n_vezete2s = MkHu "vezetés" "vezetés" ObjectRole Multiplicative 0 7
public export n_vezeto4 : HuWord
n_vezeto4 = MkHu "vezető" "vezető" ObjectRole Multiplicative 0 6
public export n_veze2r : HuWord
n_veze2r = MkHu "vezér" "vezér" ObjectRole Multiplicative 0 5
public export n_vigasz : HuWord
n_vigasz = MkHu "vigasz" "vigasz" ObjectRole Additive 0 6
public export n_vigasztalo2 : HuWord
n_vigasztalo2 = MkHu "vigasztaló" "vigasztaló" ObjectRole Additive 0 10
public export n_viharmada2r : HuWord
n_viharmada2r = MkHu "viharmadár" "viharmadár" ObjectRole Additive 0 10
public export n_villanto2 : HuWord
n_villanto2 = MkHu "villantó" "villantó" ObjectRole Additive 0 8
public export n_vila2gegyetem : HuWord
n_vila2gegyetem = MkHu "világegyetem" "világegye" ObjectRole Multiplicative 34 12
public export n_vipera : HuWord
n_vipera = MkHu "vipera" "vipe" ObjectRole Multiplicative 1 6
public export n_vira2gza2s : HuWord
n_vira2gza2s = MkHu "virágzás" "virágzás" ObjectRole Additive 0 8
public export n_vira2gzo2 : HuWord
n_vira2gzo2 = MkHu "virágzó" "virágzó" ObjectRole Additive 0 7
public export n_vissszataszi2to2an : HuWord
n_vissszataszi2to2an = MkHu "vissszataszítóan" "vissszataszítóa" ObjectRole Additive 1 16
public export n_visszaadata2s : HuWord
n_visszaadata2s = MkHu "visszaadatás" "visszaadatás" ObjectRole Additive 0 12
public export n_visszafizettete2s : HuWord
n_visszafizettete2s = MkHu "visszafizettetés" "visszafizettetés" ObjectRole Multiplicative 0 16
public export n_visszafordula2s : HuWord
n_visszafordula2s = MkHu "visszafordulás" "visszafordulás" ObjectRole Additive 0 14
public export n_visszafordi2ta2s : HuWord
n_visszafordi2ta2s = MkHu "visszafordítás" "visszafordítás" ObjectRole Additive 0 14
public export n_visszahozata2s : HuWord
n_visszahozata2s = MkHu "visszahozatás" "visszahozatás" ObjectRole Additive 0 13
public export n_visszavont : HuWord
n_visszavont = MkHu "visszavont" "visszavo" ObjectRole Additive 3 10
public export n_visszavona2s : HuWord
n_visszavona2s = MkHu "visszavonás" "visszavonás" ObjectRole Additive 0 11
public export n_viszontla2ta2s : HuWord
n_viszontla2ta2s = MkHu "viszontlátás" "viszontlátás" ObjectRole Additive 0 12
public export n_vitatkozik : HuWord
n_vitatkozik = MkHu "vitatkozik" "vitatkozi" ObjectRole Multiplicative 4 10
public export n_vite2z : HuWord
n_vite2z = MkHu "vitéz" "vitéz" ObjectRole Multiplicative 0 5
public export n_viza : HuWord
n_viza = MkHu "viza" "viza" ObjectRole Additive 0 4
public export n_vizilo2 : HuWord
n_vizilo2 = MkHu "viziló" "viziló" ObjectRole Additive 0 6
public export n_vizsgate2tel : HuWord
n_vizsgate2tel = MkHu "vizsgatétel" "vizsgatétel" ObjectRole Multiplicative 0 11
public export n_vobla : HuWord
n_vobla = MkHu "vobla" "vobla" ObjectRole Additive 0 5
public export n_vodka : HuWord
n_vodka = MkHu "vodka" "vodka" ObjectRole Additive 0 5
public export n_vodkafo4ze2s : HuWord
n_vodkafo4ze2s = MkHu "vodkafőzés" "vodkafőzés" ObjectRole Multiplicative 0 10
public export n_vontata2s : HuWord
n_vontata2s = MkHu "vontatás" "vontatás" ObjectRole Additive 0 8
public export n_vontato2go4zo3s : HuWord
n_vontato2go4zo3s = MkHu "vontatógőzös" "vontatógőzös" ObjectRole Multiplicative 0 12
public export n_vontato2ko3te2l : HuWord
n_vontato2ko3te2l = MkHu "vontatókötél" "vontatókötél" ObjectRole Multiplicative 0 12
public export n_vontato2u2t : HuWord
n_vontato2u2t = MkHu "vontatóút" "vontatóú" ObjectRole Additive 2 9
public export n_va2go2hi2d : HuWord
n_va2go2hi2d = MkHu "vágóhíd" "vágóhíd" ObjectRole Multiplicative 0 7
public export n_va2jka2la2s : HuWord
n_va2jka2la2s = MkHu "vájkálás" "vájkálás" ObjectRole Additive 0 8
public export n_va2lasztata2s : HuWord
n_va2lasztata2s = MkHu "választatás" "választatás" ObjectRole Additive 0 11
public export n_va2laszta2s : HuWord
n_va2laszta2s = MkHu "választás" "választás" ObjectRole Additive 0 9
public export n_va2laszte2k : HuWord
n_va2laszte2k = MkHu "választék" "választé" ObjectRole Multiplicative 4 9
public export n_va2laszto2 : HuWord
n_va2laszto2 = MkHu "választó" "választó" ObjectRole Additive 0 8
public export n_va2logattata2s : HuWord
n_va2logattata2s = MkHu "válogattatás" "válogattatás" ObjectRole Additive 0 12
public export n_va2logata2s : HuWord
n_va2logata2s = MkHu "válogatás" "válogatás" ObjectRole Additive 0 9
public export n_va2nyolt : HuWord
n_va2nyolt = MkHu "ványolt" "ványol" ObjectRole Additive 2 7
public export n_va2nyola2s : HuWord
n_va2nyola2s = MkHu "ványolás" "ványolás" ObjectRole Additive 0 8
public export n_va2nyolo2 : HuWord
n_va2nyolo2 = MkHu "ványoló" "ványoló" ObjectRole Additive 0 7
public export n_va2rsorendeze2s : HuWord
n_va2rsorendeze2s = MkHu "vársorendezés" "vársorendezés" ObjectRole Multiplicative 0 13
public export n_va2sa2r : HuWord
n_va2sa2r = MkHu "vásár" "vásár" ObjectRole Additive 0 5
public export n_va2sa2rla2s : HuWord
n_va2sa2rla2s = MkHu "vásárlás" "vásárlás" ObjectRole Additive 0 8
public export n_va2sa2rlo2 : HuWord
n_va2sa2rlo2 = MkHu "vásárló" "vásárló" ObjectRole Additive 0 7
public export n_va2sa2roltata2s : HuWord
n_va2sa2roltata2s = MkHu "vásároltatás" "vásároltatás" ObjectRole Additive 0 12
public export n_va2sa2roltato2 : HuWord
n_va2sa2roltato2 = MkHu "vásároltató" "vásároltató" ObjectRole Additive 0 11
public export n_ve2g : HuWord
n_ve2g = MkHu "vég" "vég" ObjectRole Multiplicative 0 3
public export n_ve2gzet : HuWord
n_ve2gzet = MkHu "végzet" "végz" ObjectRole Multiplicative 2 6
public export n_ve2gzo4de2s : HuWord
n_ve2gzo4de2s = MkHu "végződés" "végződés" ObjectRole Multiplicative 0 8
public export n_ve2rszege2nyse2g : HuWord
n_ve2rszege2nyse2g = MkHu "vérszegénység" "vérszegénység" ObjectRole Multiplicative 0 13
public export n_vi2zfestme2ny : HuWord
n_vi2zfestme2ny = MkHu "vízfestmény" "vízfestmény" ObjectRole Multiplicative 0 11
public export n_vo3do3r : HuWord
n_vo3do3r = MkHu "vödör" "vödör" ObjectRole Multiplicative 0 5
public export n_zabage2p : HuWord
n_zabage2p = MkHu "zabagép" "zabagép" ObjectRole Multiplicative 0 7
public export n_zacc : HuWord
n_zacc = MkHu "zacc" "zacc" ObjectRole Additive 0 4
public export n_zaklata2s : HuWord
n_zaklata2s = MkHu "zaklatás" "zaklatás" ObjectRole Additive 0 8
public export n_zamat : HuWord
n_zamat = MkHu "zamat" "zam" ObjectRole Additive 2 5
public export n_zavarga2s : HuWord
n_zavarga2s = MkHu "zavargás" "zavargás" ObjectRole Additive 0 8
public export n_zavara2s : HuWord
n_zavara2s = MkHu "zavarás" "zavarás" ObjectRole Additive 0 7
public export n_zendu3la2s : HuWord
n_zendu3la2s = MkHu "zendülás" "zendülás" ObjectRole Additive 0 8
public export n_zendu3le2s : HuWord
n_zendu3le2s = MkHu "zendülés" "zendülés" ObjectRole Multiplicative 0 8
public export n_zendu3lo4 : HuWord
n_zendu3lo4 = MkHu "zendülő" "zendülő" ObjectRole Multiplicative 0 7
public export n_zsebkendo4 : HuWord
n_zsebkendo4 = MkHu "zsebkendő" "zsebkendő" ObjectRole Multiplicative 0 9
public export n_zsemle : HuWord
n_zsemle = MkHu "zsemle" "zsemle" ObjectRole Multiplicative 0 6
public export n_zsenialita2s : HuWord
n_zsenialita2s = MkHu "zsenialitás" "zsenialitás" ObjectRole Additive 0 11
public export n_zsilip : HuWord
n_zsilip = MkHu "zsilip" "zsilip" ObjectRole Multiplicative 0 6
public export n_zsu2rkenye2r : HuWord
n_zsu2rkenye2r = MkHu "zsúrkenyér" "zsúrkenyér" ObjectRole Multiplicative 0 10
public export n_zuboga2s : HuWord
n_zuboga2s = MkHu "zubogás" "zubogás" ObjectRole Additive 0 7
public export n_zuzmara : HuWord
n_zuzmara = MkHu "zuzmara" "zuzma" ObjectRole Additive 1 7
public export n_za2rko2zott : HuWord
n_za2rko2zott = MkHu "zárkózott" "zárkózo" ObjectRole Additive 8 9
public export n_za2rlat : HuWord
n_za2rlat = MkHu "zárlat" "zárl" ObjectRole Additive 2 6
public export n_za2szlo2alj : HuWord
n_za2szlo2alj = MkHu "zászlóalj" "zászlóal" ObjectRole Additive 16 9
public export n_zo3ldse2g : HuWord
n_zo3ldse2g = MkHu "zöldség" "zöldség" ObjectRole Multiplicative 0 7
public export n_zu2ga2s : HuWord
n_zu2ga2s = MkHu "zúgás" "zúgás" ObjectRole Additive 0 5
public export n_zu3mmo3ge2s : HuWord
n_zu3mmo3ge2s = MkHu "zümmögés" "zümmögés" ObjectRole Multiplicative 0 8
public export n_a2be2ce2 : HuWord
n_a2be2ce2 = MkHu "ábécé" "ábécé" ObjectRole Multiplicative 0 5
public export n_a2be2ce2sko3nyv : HuWord
n_a2be2ce2sko3nyv = MkHu "ábécéskönyv" "ábécéskönyv" ObjectRole Multiplicative 0 11
public export n_a2gy : HuWord
n_a2gy = MkHu "ágy" "ágy" ObjectRole Additive 0 3
public export n_a2gynemu4 : HuWord
n_a2gynemu4 = MkHu "ágynemű" "ágynemű" ObjectRole Multiplicative 0 7
public export n_a2gyteri2to4 : HuWord
n_a2gyteri2to4 = MkHu "ágyterítő" "ágyterítő" ObjectRole Multiplicative 0 9
public export n_a2lda2s : HuWord
n_a2lda2s = MkHu "áldás" "áldás" ObjectRole Additive 0 5
public export n_a2ll : HuWord
n_a2ll = MkHu "áll" "áll" ObjectRole Additive 0 3
public export n_a2llamfo4 : HuWord
n_a2llamfo4 = MkHu "államfő" "államfő" ObjectRole Multiplicative 0 7
public export n_a2llando2an : HuWord
n_a2llando2an = MkHu "állandóan" "állandóa" ObjectRole Additive 1 9
public export n_a2llcsont : HuWord
n_a2llcsont = MkHu "állcsont" "állcso" ObjectRole Additive 3 8
public export n_a2llkapocs : HuWord
n_a2llkapocs = MkHu "állkapocs" "állkapocs" ObjectRole Additive 0 9
public export n_a2llkapocscsont : HuWord
n_a2llkapocscsont = MkHu "állkapocscsont" "állkapocscso" ObjectRole Additive 3 14
public export n_a2lomszusze2k : HuWord
n_a2lomszusze2k = MkHu "álomszuszék" "álomszuszé" ObjectRole Multiplicative 4 11
public export n_a2mi2ta2s : HuWord
n_a2mi2ta2s = MkHu "ámítás" "ámítás" ObjectRole Additive 0 6
public export n_a2nizs : HuWord
n_a2nizs = MkHu "ánizs" "ánizs" ObjectRole Multiplicative 0 5
public export n_a2prilis : HuWord
n_a2prilis = MkHu "április" "április" ObjectRole Multiplicative 0 7
public export n_a2ramla2s : HuWord
n_a2ramla2s = MkHu "áramlás" "áramlás" ObjectRole Additive 0 7
public export n_a2ria : HuWord
n_a2ria = MkHu "ária" "ária" ObjectRole Additive 0 4
public export n_a2rok : HuWord
n_a2rok = MkHu "árok" "áro" ObjectRole Additive 4 4
public export n_a2rula2s : HuWord
n_a2rula2s = MkHu "árulás" "árulás" ObjectRole Additive 0 6
public export n_a2rulo2 : HuWord
n_a2rulo2 = MkHu "áruló" "áruló" ObjectRole Additive 0 5
public export n_a2ruoszta2lyozo2 : HuWord
n_a2ruoszta2lyozo2 = MkHu "áruosztályozó" "áruosztályozó" ObjectRole Additive 0 13
public export n_a2ruva2laszte2k : HuWord
n_a2ruva2laszte2k = MkHu "áruválaszték" "áruválaszté" ObjectRole Multiplicative 4 12
public export n_a2si2ta2s : HuWord
n_a2si2ta2s = MkHu "ásítás" "ásítás" ObjectRole Additive 0 6
public export n_a2tcsalata2s : HuWord
n_a2tcsalata2s = MkHu "átcsalatás" "átcsalatás" ObjectRole Additive 0 10
public export n_a2tcsa2bi2ttata2s : HuWord
n_a2tcsa2bi2ttata2s = MkHu "átcsábíttatás" "átcsábíttatás" ObjectRole Additive 0 13
public export n_a2tcsa2bi2ta2s : HuWord
n_a2tcsa2bi2ta2s = MkHu "átcsábítás" "átcsábítás" ObjectRole Additive 0 10
public export n_a2tfordula2s : HuWord
n_a2tfordula2s = MkHu "átfordulás" "átfordulás" ObjectRole Additive 0 10
public export n_a2tfordi2ttata2s : HuWord
n_a2tfordi2ttata2s = MkHu "átfordíttatás" "átfordíttatás" ObjectRole Additive 0 13
public export n_a2tfordi2ta2s : HuWord
n_a2tfordi2ta2s = MkHu "átfordítás" "átfordítás" ObjectRole Additive 0 10
public export n_a2tforgattata2s : HuWord
n_a2tforgattata2s = MkHu "átforgattatás" "átforgattatás" ObjectRole Additive 0 13
public export n_a2tforgata2s : HuWord
n_a2tforgata2s = MkHu "átforgatás" "átforgatás" ObjectRole Additive 0 10
public export n_a2tlapa2toltata2s : HuWord
n_a2tlapa2toltata2s = MkHu "átlapátoltatás" "átlapátoltatás" ObjectRole Additive 0 14
public export n_a2tlapa2tola2s : HuWord
n_a2tlapa2tola2s = MkHu "átlapátolás" "átlapátolás" ObjectRole Additive 0 11
public export n_a2tszele2s : HuWord
n_a2tszele2s = MkHu "átszelés" "átszelés" ObjectRole Multiplicative 0 8
public export n_a2tva2ltoztata2s : HuWord
n_a2tva2ltoztata2s = MkHu "átváltoztatás" "átváltoztatás" ObjectRole Additive 0 13
public export n_a2tva2ltoza2s : HuWord
n_a2tva2ltoza2s = MkHu "átváltozás" "átváltozás" ObjectRole Additive 0 10
public export n_e2breszto4o2ra : HuWord
n_e2breszto4o2ra = MkHu "ébresztőóra" "ébresztőó" ObjectRole Additive 1 11
public export n_e2desanya : HuWord
n_e2desanya = MkHu "édesanya" "édesanya" ObjectRole Additive 0 8
public export n_e2hes : HuWord
n_e2hes = MkHu "éhes" "éhes" ObjectRole Multiplicative 0 4
public export n_e2hse2g : HuWord
n_e2hse2g = MkHu "éhség" "éhség" ObjectRole Multiplicative 0 5
public export n_e2k : HuWord
n_e2k = MkHu "ék" "ék" ObjectRole Multiplicative 0 2
public export n_e2lcsapat : HuWord
n_e2lcsapat = MkHu "élcsapat" "élcsap" ObjectRole Additive 2 8
public export n_e2leszto4 : HuWord
n_e2leszto4 = MkHu "élesztő" "élesztő" ObjectRole Multiplicative 0 7
public export n_e2letforma : HuWord
n_e2letforma = MkHu "életforma" "életforma" ObjectRole Additive 0 9
public export n_e2letkor : HuWord
n_e2letkor = MkHu "életkor" "életkor" ObjectRole Additive 0 7
public export n_e2letmo2d : HuWord
n_e2letmo2d = MkHu "életmód" "életmód" ObjectRole Additive 0 7
public export n_e2letrajz : HuWord
n_e2letrajz = MkHu "életrajz" "életrajz" ObjectRole Additive 0 8
public export n_e2lmunka2s : HuWord
n_e2lmunka2s = MkHu "élmunkás" "élmunkás" ObjectRole Additive 0 8
public export n_e2lme2nyfu3rdo4 : HuWord
n_e2lme2nyfu3rdo4 = MkHu "élményfürdő" "élményfürdő" ObjectRole Multiplicative 0 11
public export n_e2pi2te2sz : HuWord
n_e2pi2te2sz = MkHu "építész" "építész" ObjectRole Multiplicative 0 7
public export n_e2pi2te2szet : HuWord
n_e2pi2te2szet = MkHu "építészet" "építész" ObjectRole Multiplicative 2 9
public export n_e2pi2te2szme2rno3k : HuWord
n_e2pi2te2szme2rno3k = MkHu "építészmérnök" "építészmér" ObjectRole Multiplicative 5 13
public export n_e2rdektelen : HuWord
n_e2rdektelen = MkHu "érdektelen" "érdektel" ObjectRole Multiplicative 1 10
public export n_e2rdektelense2g : HuWord
n_e2rdektelense2g = MkHu "érdektelenség" "érdektelenség" ObjectRole Multiplicative 0 13
public export n_e2rdemjegy : HuWord
n_e2rdemjegy = MkHu "érdemjegy" "érdemjegy" ObjectRole Multiplicative 0 9
public export n_e2rtekezlez : HuWord
n_e2rtekezlez = MkHu "értekezlez" "értekezlez" ObjectRole Multiplicative 0 10
public export n_e2rtelem : HuWord
n_e2rtelem = MkHu "értelem" "értel" ObjectRole Multiplicative 32 7
public export n_e2rtelmes : HuWord
n_e2rtelmes = MkHu "értelmes" "értelmes" ObjectRole Multiplicative 0 8
public export n_e2rte2k : HuWord
n_e2rte2k = MkHu "érték" "érté" ObjectRole Multiplicative 4 5
public export n_e2rv : HuWord
n_e2rv = MkHu "érv" "érv" ObjectRole Multiplicative 0 3
public export n_e2szrevesz : HuWord
n_e2szrevesz = MkHu "észrevesz" "észrevesz" ObjectRole Multiplicative 0 9
public export n_e2telba2r : HuWord
n_e2telba2r = MkHu "ételbár" "ételbár" ObjectRole Additive 0 7
public export n_e2tva2gy : HuWord
n_e2tva2gy = MkHu "étvágy" "étvágy" ObjectRole Additive 0 6
public export n_e2v : HuWord
n_e2v = MkHu "év" "év" ObjectRole Multiplicative 0 2
public export n_e2ves : HuWord
n_e2ves = MkHu "éves" "éves" ObjectRole Multiplicative 0 4
public export n_e2vko3nyv : HuWord
n_e2vko3nyv = MkHu "évkönyv" "évkönyv" ObjectRole Multiplicative 0 7
public export n_e2vszakok : HuWord
n_e2vszakok = MkHu "évszakok" "évsz" ObjectRole Multiplicative 0 8
public export n_i2rezo4anyag : HuWord
n_i2rezo4anyag = MkHu "írezőanyag" "írezőanyag" ObjectRole Additive 0 10
public export n_i2z : HuWord
n_i2z = MkHu "íz" "íz" ObjectRole Multiplicative 0 2
public export n_i2zveszte2s : HuWord
n_i2zveszte2s = MkHu "ízvesztés" "ízvesztés" ObjectRole Multiplicative 0 9
public export n_o2vo2hely : HuWord
n_o2vo2hely = MkHu "óvóhely" "óvóhely" ObjectRole Multiplicative 0 7
public export n_o2zon : HuWord
n_o2zon = MkHu "ózon" "ózo" ObjectRole Additive 1 4
public export n_o3bo3l : HuWord
n_o3bo3l = MkHu "öböl" "öböl" ObjectRole Multiplicative 0 4
public export n_o3ko3lvi2va2s : HuWord
n_o3ko3lvi2va2s = MkHu "ökölvívás" "ökölvívás" ObjectRole Additive 0 9
public export n_o3ko3lvi2vo2 : HuWord
n_o3ko3lvi2vo2 = MkHu "ökölvívó" "ökölvívó" ObjectRole Additive 0 8
public export n_o3l : HuWord
n_o3l = MkHu "öl" "öl" ObjectRole Multiplicative 0 2
public export n_o3lto3zet : HuWord
n_o3lto3zet = MkHu "öltözet" "öltöz" ObjectRole Multiplicative 2 7
public export n_o3nfeju4sko3de2s : HuWord
n_o3nfeju4sko3de2s = MkHu "önfejűsködés" "önfejűsködés" ObjectRole Multiplicative 0 12
public export n_o3nfeju4se2g : HuWord
n_o3nfeju4se2g = MkHu "önfejűség" "önfejűség" ObjectRole Multiplicative 0 9
public export n_o3nitato2 : HuWord
n_o3nitato2 = MkHu "önitató" "önitató" ObjectRole Additive 0 7
public export n_o3nkorma2nyzat : HuWord
n_o3nkorma2nyzat = MkHu "önkormányzat" "önkormányz" ObjectRole Additive 2 12
public export n_o3nko3ltse2g : HuWord
n_o3nko3ltse2g = MkHu "önköltség" "önköltség" ObjectRole Multiplicative 0 9
public export n_o3ntudat : HuWord
n_o3ntudat = MkHu "öntudat" "öntud" ObjectRole Additive 2 7
public export n_o3na2llo2sa2g : HuWord
n_o3na2llo2sa2g = MkHu "önállóság" "önállóság" ObjectRole Additive 0 9
public export n_o3ne2letrajz : HuWord
n_o3ne2letrajz = MkHu "önéletrajz" "önéletrajz" ObjectRole Additive 0 10
public export n_o3rdo3g : HuWord
n_o3rdo3g = MkHu "ördög" "ördög" ObjectRole Multiplicative 0 5
public export n_o3rdo3gfi : HuWord
n_o3rdo3gfi = MkHu "ördögfi" "ördögfi" ObjectRole Multiplicative 0 7
public export n_o3rme2ny : HuWord
n_o3rme2ny = MkHu "örmény" "örmény" ObjectRole Multiplicative 0 6
public export n_o3ro3kke2 : HuWord
n_o3ro3kke2 = MkHu "örökké" "örökké" ObjectRole Multiplicative 0 6
public export n_o3sszebara2tkoza2s : HuWord
n_o3sszebara2tkoza2s = MkHu "összebarátkozás" "összebarátkozás" ObjectRole Additive 0 15
public export n_o3sszeborzolo2da2s : HuWord
n_o3sszeborzolo2da2s = MkHu "összeborzolódás" "összeborzolódás" ObjectRole Additive 0 15
public export n_o3sszecsavaroda2s : HuWord
n_o3sszecsavaroda2s = MkHu "összecsavarodás" "összecsavarodás" ObjectRole Additive 0 15
public export n_o3sszecsavara2s : HuWord
n_o3sszecsavara2s = MkHu "összecsavarás" "összecsavarás" ObjectRole Additive 0 13
public export n_o3sszefoglala2s : HuWord
n_o3sszefoglala2s = MkHu "összefoglalás" "összefoglalás" ObjectRole Additive 0 13
public export n_o3sszego3ngyo3lo3de2s : HuWord
n_o3sszego3ngyo3lo3de2s = MkHu "összegöngyölödés" "összegöngyölödés" ObjectRole Multiplicative 0 16
public export n_o3sszego3ngyo3lo4de2s : HuWord
n_o3sszego3ngyo3lo4de2s = MkHu "összegöngyölődés" "összegöngyölődés" ObjectRole Multiplicative 0 16
public export n_o3sszeismertete2s : HuWord
n_o3sszeismertete2s = MkHu "összeismertetés" "összeismertetés" ObjectRole Multiplicative 0 15
public export n_o3sszekusza2lo2da2s : HuWord
n_o3sszekusza2lo2da2s = MkHu "összekuszálódás" "összekuszálódás" ObjectRole Additive 0 15
public export n_o3sszeko2colo2da2s : HuWord
n_o3sszeko2colo2da2s = MkHu "összekócolódás" "összekócolódás" ObjectRole Additive 0 14
public export n_o3sszeszedete2s : HuWord
n_o3sszeszedete2s = MkHu "összeszedetés" "összeszedetés" ObjectRole Multiplicative 0 13
public export n_o3sszeszede2s : HuWord
n_o3sszeszede2s = MkHu "összeszedés" "összeszedés" ObjectRole Multiplicative 0 11
public export n_o3sszetekerede2s : HuWord
n_o3sszetekerede2s = MkHu "összetekeredés" "összetekeredés" ObjectRole Multiplicative 0 14
public export n_o3sszetekertete2s : HuWord
n_o3sszetekertete2s = MkHu "összetekertetés" "összetekertetés" ObjectRole Multiplicative 0 15
public export n_o3sszetekere2s : HuWord
n_o3sszetekere2s = MkHu "összetekerés" "összetekerés" ObjectRole Multiplicative 0 12
public export n_o3sszeturka2ltata2s : HuWord
n_o3sszeturka2ltata2s = MkHu "összeturkáltatás" "összeturkáltatás" ObjectRole Additive 0 16
public export n_o3sszeturka2la2s : HuWord
n_o3sszeturka2la2s = MkHu "összeturkálás" "összeturkálás" ObjectRole Additive 0 13
public export n_o3szto3nze2s : HuWord
n_o3szto3nze2s = MkHu "ösztönzés" "ösztönzés" ObjectRole Multiplicative 0 9
public export n_u2jhagyma : HuWord
n_u2jhagyma = MkHu "újhagyma" "újhagyma" ObjectRole Additive 0 8
public export n_u2r : HuWord
n_u2r = MkHu "úr" "úr" ObjectRole Additive 0 2
public export n_u2rno4 : HuWord
n_u2rno4 = MkHu "úrnő" "úrnő" ObjectRole Multiplicative 0 4
public export n_u2szo2medence : HuWord
n_u2szo2medence = MkHu "úszómedence" "úszómedence" ObjectRole Multiplicative 0 11
public export n_u3gyes : HuWord
n_u3gyes = MkHu "ügyes" "ügyes" ObjectRole Multiplicative 0 5
public export n_u3gyesse2g : HuWord
n_u3gyesse2g = MkHu "ügyesség" "ügyesség" ObjectRole Multiplicative 0 8
public export n_u3gyinte2ze2s : HuWord
n_u3gyinte2ze2s = MkHu "ügyintézés" "ügyintézés" ObjectRole Multiplicative 0 10
public export n_u3gyinte2zo4 : HuWord
n_u3gyinte2zo4 = MkHu "ügyintéző" "ügyintéző" ObjectRole Multiplicative 0 9
public export n_u3gyno3k : HuWord
n_u3gyno3k = MkHu "ügynök" "ügy" ObjectRole Multiplicative 5 6
public export n_u3gyno3kse2g : HuWord
n_u3gyno3kse2g = MkHu "ügynökség" "ügynökség" ObjectRole Multiplicative 0 9
public export n_u3gyve2f : HuWord
n_u3gyve2f = MkHu "ügyvéf" "ügyvéf" ObjectRole Multiplicative 0 6
public export n_u3lede2k : HuWord
n_u3lede2k = MkHu "üledék" "üledé" ObjectRole Multiplicative 4 6
public export n_u3rge : HuWord
n_u3rge = MkHu "ürge" "ürge" ObjectRole Multiplicative 0 4
public export n_u3ro3m : HuWord
n_u3ro3m = MkHu "üröm" "üröm" ObjectRole Multiplicative 0 4
public export n_u3sto3ko3s : HuWord
n_u3sto3ko3s = MkHu "üstökös" "üstökös" ObjectRole Multiplicative 0 7
public export n_u3sto3ko3so3k : HuWord
n_u3sto3ko3so3k = MkHu "üstökösök" "üstökös" ObjectRole Multiplicative 4 9
public export n_u3tko3zet : HuWord
n_u3tko3zet = MkHu "ütközet" "ütköz" ObjectRole Multiplicative 2 7
public export n_u3tko3zo4 : HuWord
n_u3tko3zo4 = MkHu "ütköző" "ütköző" ObjectRole Multiplicative 0 6
public export n_u3te2s : HuWord
n_u3te2s = MkHu "ütés" "ütés" ObjectRole Multiplicative 0 4
public export n_u3veg : HuWord
n_u3veg = MkHu "üveg" "üveg" ObjectRole Multiplicative 0 4
public export n_u3vegha2z : HuWord
n_u3vegha2z = MkHu "üvegház" "üvegház" ObjectRole Additive 0 7
public export n_u3ze2rkede2s : HuWord
n_u3ze2rkede2s = MkHu "üzérkedés" "üzérkedés" ObjectRole Multiplicative 0 9
public export n_o4rbo2de2 : HuWord
n_o4rbo2de2 = MkHu "őrbódé" "őrbódé" ObjectRole Multiplicative 0 6
public export n_o4rizetlense2g : HuWord
n_o4rizetlense2g = MkHu "őrizetlenség" "őrizetlenség" ObjectRole Multiplicative 0 12
public export n_o4slakos : HuWord
n_o4slakos = MkHu "őslakos" "őslakos" ObjectRole Additive 0 7
public export n_o4sto3rte2net : HuWord
n_o4sto3rte2net = MkHu "őstörténet" "őstörté" ObjectRole Multiplicative 3 10
public export n_o4sziro2zsa : HuWord
n_o4sziro2zsa = MkHu "őszirózsa" "őszirózsa" ObjectRole Additive 0 9
public export n_u4rlap : HuWord
n_u4rlap = MkHu "űrlap" "űrlap" ObjectRole Additive 0 5
public export v_acsarkodik : HuWord
v_acsarkodik = MkHu "acsarkodik" "acsarkodi" MorphismRole Multiplicative 4 10
public export v_affekta2l : HuWord
v_affekta2l = MkHu "affektál" "affektál" MorphismRole Additive 0 8
public export v_agyonszu2r : HuWord
v_agyonszu2r = MkHu "agyonszúr" "agyonszúr" MorphismRole Additive 0 9
public export v_ajkajozik : HuWord
v_ajkajozik = MkHu "ajkajozik" "ajkajozi" MorphismRole Multiplicative 4 9
public export v_altat : HuWord
v_altat = MkHu "altat" "alt" MorphismRole Additive 2 5
public export v_ala2bbhagy : HuWord
v_ala2bbhagy = MkHu "alábbhagy" "alábbhagy" MorphismRole Additive 0 9
public export v_aranyoz : HuWord
v_aranyoz = MkHu "aranyoz" "aranyoz" MorphismRole Additive 0 7
public export v_arat : HuWord
v_arat = MkHu "arat" "ara" MorphismRole Additive 2 4
public export v_arattat : HuWord
v_arattat = MkHu "arattat" "ara" MorphismRole Additive 10 7
public export v_arroga2ns : HuWord
v_arroga2ns = MkHu "arrogáns" "arrogáns" MorphismRole Additive 0 8
public export v_bara2zda2l : HuWord
v_bara2zda2l = MkHu "barázdál" "barázdál" MorphismRole Additive 0 8
public export v_bearanyoz : HuWord
v_bearanyoz = MkHu "bearanyoz" "bearanyoz" MorphismRole Additive 0 9
public export v_becsap : HuWord
v_becsap = MkHu "becsap" "becsap" MorphismRole Additive 0 6
public export v_becsavar : HuWord
v_becsavar = MkHu "becsavar" "becsavar" MorphismRole Additive 0 8
public export v_becsavarodik : HuWord
v_becsavarodik = MkHu "becsavarodik" "becsavarodi" MorphismRole Multiplicative 4 12
public export v_becsavartat : HuWord
v_becsavartat = MkHu "becsavartat" "becsavar" MorphismRole Additive 0 11
public export v_beezu3sto3ztet : HuWord
v_beezu3sto3ztet = MkHu "beezüstöztet" "beezüstöz" MorphismRole Multiplicative 0 12
public export v_beezu3sto3zo4dik : HuWord
v_beezu3sto3zo4dik = MkHu "beezüstöződik" "beezüstöződi" MorphismRole Multiplicative 4 13
public export v_befejez : HuWord
v_befejez = MkHu "befejez" "befejez" MorphismRole Multiplicative 0 7
public export v_befejeztet : HuWord
v_befejeztet = MkHu "befejeztet" "befejez" MorphismRole Multiplicative 0 10
public export v_befejezo4dik : HuWord
v_befejezo4dik = MkHu "befejeződik" "befejeződi" MorphismRole Multiplicative 4 11
public export v_befest : HuWord
v_befest = MkHu "befest" "befes" MorphismRole Multiplicative 2 6
public export v_befog : HuWord
v_befog = MkHu "befog" "befog" MorphismRole Additive 0 5
public export v_beforr : HuWord
v_beforr = MkHu "beforr" "beforr" MorphismRole Additive 0 6
public export v_begombol : HuWord
v_begombol = MkHu "begombol" "begombol" MorphismRole Additive 0 8
public export v_begombolkozik : HuWord
v_begombolkozik = MkHu "begombolkozik" "begombolkozi" MorphismRole Multiplicative 4 13
public export v_begomboltat : HuWord
v_begomboltat = MkHu "begomboltat" "begombol" MorphismRole Additive 0 11
public export v_begyullad : HuWord
v_begyullad = MkHu "begyullad" "begyullad" MorphismRole Additive 0 9
public export v_begyullaszt : HuWord
v_begyullaszt = MkHu "begyullaszt" "begyullasz" MorphismRole Additive 2 11
public export v_begyo2gyul : HuWord
v_begyo2gyul = MkHu "begyógyul" "begyógyul" MorphismRole Additive 0 9
public export v_begyu4jt : HuWord
v_begyu4jt = MkHu "begyűjt" "begyű" MorphismRole Multiplicative 18 7
public export v_begyu4jtet : HuWord
v_begyu4jtet = MkHu "begyűjtet" "begyű" MorphismRole Multiplicative 16 9
public export v_begyu4jte2s : HuWord
v_begyu4jte2s = MkHu "begyűjtés" "begyűjtés" MorphismRole Multiplicative 0 9
public export v_bego3ngyo3l : HuWord
v_bego3ngyo3l = MkHu "begöngyöl" "begöngyöl" MorphismRole Multiplicative 0 9
public export v_bego3ngyo3ltet : HuWord
v_bego3ngyo3ltet = MkHu "begöngyöltet" "begöngyöl" MorphismRole Multiplicative 0 12
public export v_bego3ngyo3lo3dik : HuWord
v_bego3ngyo3lo3dik = MkHu "begöngyölödik" "begöngyölödi" MorphismRole Multiplicative 4 13
public export v_bego3nygyo3l : HuWord
v_bego3nygyo3l = MkHu "begönygyöl" "begönygyöl" MorphismRole Multiplicative 0 10
public export v_beheged : HuWord
v_beheged = MkHu "beheged" "beheg" MorphismRole Multiplicative 32 7
public export v_bejegesedik : HuWord
v_bejegesedik = MkHu "bejegesedik" "bejegesedi" MorphismRole Multiplicative 4 11
public export v_bekre2ta2zo2dik : HuWord
v_bekre2ta2zo2dik = MkHu "bekrétázódik" "bekrétázódi" MorphismRole Multiplicative 4 12
public export v_beko3t : HuWord
v_beko3t = MkHu "beköt" "bekö" MorphismRole Multiplicative 2 5
public export v_beko3ttet : HuWord
v_beko3ttet = MkHu "beköttet" "bekö" MorphismRole Multiplicative 10 8
public export v_beko3to3z : HuWord
v_beko3to3z = MkHu "bekötöz" "bekötöz" MorphismRole Multiplicative 0 7
public export v_beko3to3ztet : HuWord
v_beko3to3ztet = MkHu "bekötöztet" "bekötöz" MorphismRole Multiplicative 0 10
public export v_beleborul : HuWord
v_beleborul = MkHu "beleborul" "beleborul" MorphismRole Additive 0 9
public export v_belilul : HuWord
v_belilul = MkHu "belilul" "belilul" MorphismRole Additive 0 7
public export v_bepelenka2z : HuWord
v_bepelenka2z = MkHu "bepelenkáz" "bepelenkáz" MorphismRole Additive 0 10
public export v_bepelenka2ztat : HuWord
v_bepelenka2ztat = MkHu "bepelenkáztat" "bepelenkáz" MorphismRole Additive 0 13
public export v_bepiszkolo2dik : HuWord
v_bepiszkolo2dik = MkHu "bepiszkolódik" "bepiszkolódi" MorphismRole Multiplicative 4 13
public export v_bepa2ra2sodik : HuWord
v_bepa2ra2sodik = MkHu "bepárásodik" "bepárásodi" MorphismRole Multiplicative 4 11
public export v_bereteszelo4dik : HuWord
v_bereteszelo4dik = MkHu "bereteszelődik" "bereteszelődi" MorphismRole Multiplicative 4 14
public export v_besze2lget : HuWord
v_besze2lget = MkHu "beszélget" "beszélg" MorphismRole Multiplicative 2 9
public export v_besu2g : HuWord
v_besu2g = MkHu "besúg" "besúg" MorphismRole Additive 0 5
public export v_beva2sa2rol : HuWord
v_beva2sa2rol = MkHu "bevásárol" "bevásárol" MorphismRole Additive 0 9
public export v_beva2sa2roltat : HuWord
v_beva2sa2roltat = MkHu "bevásároltat" "bevásárol" MorphismRole Additive 0 12
public export v_beve2gez : HuWord
v_beve2gez = MkHu "bevégez" "bevégez" MorphismRole Multiplicative 0 7
public export v_beve2geztet : HuWord
v_beve2geztet = MkHu "bevégeztet" "bevégez" MorphismRole Multiplicative 0 10
public export v_beza2r : HuWord
v_beza2r = MkHu "bezár" "bezár" MorphismRole Additive 0 5
public export v_beza2ro2dik : HuWord
v_beza2ro2dik = MkHu "bezáródik" "bezáródi" MorphismRole Multiplicative 4 9
public export v_beza2ro2da2s : HuWord
v_beza2ro2da2s = MkHu "bezáródás" "bezáródás" MorphismRole Additive 0 9
public export v_billeg : HuWord
v_billeg = MkHu "billeg" "billeg" MorphismRole Multiplicative 0 6
public export v_billegtet : HuWord
v_billegtet = MkHu "billegtet" "billeg" MorphismRole Multiplicative 0 9
public export v_birizga2l : HuWord
v_birizga2l = MkHu "birizgál" "birizgál" MorphismRole Additive 0 8
public export v_bodori2t : HuWord
v_bodori2t = MkHu "bodorít" "bodorí" MorphismRole Multiplicative 2 7
public export v_bodrosodik : HuWord
v_bodrosodik = MkHu "bodrosodik" "bodrosodi" MorphismRole Multiplicative 4 10
public export v_bugybore2kol : HuWord
v_bugybore2kol = MkHu "bugyborékol" "bugyborékol" MorphismRole Additive 0 11
public export v_bujdosik : HuWord
v_bujdosik = MkHu "bujdosik" "bujdosi" MorphismRole Multiplicative 4 8
public export v_bukfencezik : HuWord
v_bukfencezik = MkHu "bukfencezik" "bukfencezi" MorphismRole Multiplicative 4 11
public export v_burja2nzik : HuWord
v_burja2nzik = MkHu "burjánzik" "burjánzi" MorphismRole Multiplicative 4 9
public export v_buzdi2t : HuWord
v_buzdi2t = MkHu "buzdít" "buzdí" MorphismRole Multiplicative 2 6
public export v_ba2ba2skodik : HuWord
v_ba2ba2skodik = MkHu "bábáskodik" "bábáskodi" MorphismRole Multiplicative 4 10
public export v_ba2mul : HuWord
v_ba2mul = MkHu "bámul" "bámul" MorphismRole Additive 0 5
public export v_bi2zik : HuWord
v_bi2zik = MkHu "bízik" "bízi" MorphismRole Multiplicative 4 5
public export v_bu3szke2lkedik : HuWord
v_bu3szke2lkedik = MkHu "büszkélkedik" "büszkélkedi" MorphismRole Multiplicative 4 12
public export v_ciripel : HuWord
v_ciripel = MkHu "ciripel" "ciripel" MorphismRole Multiplicative 0 7
public export v_civakodik : HuWord
v_civakodik = MkHu "civakodik" "civakodi" MorphismRole Multiplicative 4 9
public export v_csal : HuWord
v_csal = MkHu "csal" "csal" MorphismRole Additive 0 4
public export v_csavar : HuWord
v_csavar = MkHu "csavar" "csavar" MorphismRole Additive 0 6
public export v_csavarodik : HuWord
v_csavarodik = MkHu "csavarodik" "csavarodi" MorphismRole Multiplicative 4 10
public export v_csicsereg : HuWord
v_csicsereg = MkHu "csicsereg" "csicsereg" MorphismRole Multiplicative 0 9
public export v_csikland : HuWord
v_csikland = MkHu "csikland" "csikland" MorphismRole Additive 0 8
public export v_csiklandoz : HuWord
v_csiklandoz = MkHu "csiklandoz" "csiklandoz" MorphismRole Additive 0 10
public export v_csiklandoztat : HuWord
v_csiklandoztat = MkHu "csiklandoztat" "csiklandoz" MorphismRole Additive 0 13
public export v_csiklando2s : HuWord
v_csiklando2s = MkHu "csiklandós" "csiklandós" MorphismRole Additive 0 10
public export v_csillog : HuWord
v_csillog = MkHu "csillog" "csillog" MorphismRole Additive 0 7
public export v_csintalankodik : HuWord
v_csintalankodik = MkHu "csintalankodik" "csintalankodi" MorphismRole Multiplicative 4 14
public export v_csipog : HuWord
v_csipog = MkHu "csipog" "csipog" MorphismRole Additive 0 6
public export v_csoda2lkozik : HuWord
v_csoda2lkozik = MkHu "csodálkozik" "csodálkozi" MorphismRole Multiplicative 4 11
public export v_csomagol : HuWord
v_csomagol = MkHu "csomagol" "csomagol" MorphismRole Additive 0 8
public export v_csi2ra2ztat : HuWord
v_csi2ra2ztat = MkHu "csíráztat" "csíráz" MorphismRole Additive 0 9
public export v_csi2ra2ztattat : HuWord
v_csi2ra2ztattat = MkHu "csíráztattat" "csírázta" MorphismRole Additive 10 12
public export v_ci2mez : HuWord
v_ci2mez = MkHu "címez" "címez" MorphismRole Multiplicative 0 5
public export v_ci2meztet : HuWord
v_ci2meztet = MkHu "címeztet" "címez" MorphismRole Multiplicative 0 8
public export v_dadog : HuWord
v_dadog = MkHu "dadog" "dadog" MorphismRole Additive 0 5
public export v_dagaszt : HuWord
v_dagaszt = MkHu "dagaszt" "dagasz" MorphismRole Additive 2 7
public export v_degrada2l : HuWord
v_degrada2l = MkHu "degradál" "degradál" MorphismRole Additive 0 8
public export v_demonstra2l : HuWord
v_demonstra2l = MkHu "demonstrál" "demonstrál" MorphismRole Additive 0 10
public export v_desztilla2l : HuWord
v_desztilla2l = MkHu "desztillál" "desztillál" MorphismRole Additive 0 10
public export v_desztilla2ltat : HuWord
v_desztilla2ltat = MkHu "desztilláltat" "desztillál" MorphismRole Additive 0 13
public export v_desztilla2lo2dik : HuWord
v_desztilla2lo2dik = MkHu "desztillálódik" "desztillálódi" MorphismRole Multiplicative 4 14
public export v_dicsekszik : HuWord
v_dicsekszik = MkHu "dicsekszik" "dicsekszi" MorphismRole Multiplicative 4 10
public export v_dicso4i2t : HuWord
v_dicso4i2t = MkHu "dicsőít" "dicsőí" MorphismRole Multiplicative 2 7
public export v_dob : HuWord
v_dob = MkHu "dob" "dob" MorphismRole Additive 0 3
public export v_dong : HuWord
v_dong = MkHu "dong" "dong" MorphismRole Additive 0 4
public export v_donog : HuWord
v_donog = MkHu "donog" "donog" MorphismRole Additive 0 5
public export v_di2szi2t : HuWord
v_di2szi2t = MkHu "díszít" "díszí" MorphismRole Multiplicative 2 6
public export v_di2szi2ttet : HuWord
v_di2szi2ttet = MkHu "díszíttet" "díszí" MorphismRole Multiplicative 10 9
public export v_di2szi2te2s : HuWord
v_di2szi2te2s = MkHu "díszítés" "díszítés" MorphismRole Multiplicative 0 8
public export v_do3f : HuWord
v_do3f = MkHu "döf" "döf" MorphismRole Multiplicative 0 3
public export v_do3lyfo3sko3dik : HuWord
v_do3lyfo3sko3dik = MkHu "dölyfösködik" "dölyfösködi" MorphismRole Multiplicative 4 12
public export v_do3ng : HuWord
v_do3ng = MkHu "döng" "döng" MorphismRole Multiplicative 0 4
public export v_do3rmo3g : HuWord
v_do3rmo3g = MkHu "dörmög" "dörmög" MorphismRole Multiplicative 0 6
public export v_du3ho3ng : HuWord
v_du3ho3ng = MkHu "dühöng" "dühöng" MorphismRole Multiplicative 0 6
public export v_du3nnyo3g : HuWord
v_du3nnyo3g = MkHu "dünnyög" "dünnyög" MorphismRole Multiplicative 0 7
public export v_do4lo3nge2l : HuWord
v_do4lo3nge2l = MkHu "dőlöngél" "dőlöngél" MorphismRole Multiplicative 0 8
public export v_elalszik : HuWord
v_elalszik = MkHu "elalszik" "elalszi" MorphismRole Multiplicative 4 8
public export v_elaltat : HuWord
v_elaltat = MkHu "elaltat" "elal" MorphismRole Additive 0 7
public export v_elaszik : HuWord
v_elaszik = MkHu "elaszik" "elaszi" MorphismRole Multiplicative 4 7
public export v_elbizakodik : HuWord
v_elbizakodik = MkHu "elbizakodik" "elbizakodi" MorphismRole Multiplicative 4 11
public export v_elbotlik : HuWord
v_elbotlik = MkHu "elbotlik" "elbotli" MorphismRole Multiplicative 4 8
public export v_elburja2nzik : HuWord
v_elburja2nzik = MkHu "elburjánzik" "elburjánzi" MorphismRole Multiplicative 4 11
public export v_elba2gyad : HuWord
v_elba2gyad = MkHu "elbágyad" "elbágyad" MorphismRole Additive 0 8
public export v_elba2gyaszt : HuWord
v_elba2gyaszt = MkHu "elbágyaszt" "elbágyasz" MorphismRole Additive 2 10
public export v_elbu2jik : HuWord
v_elbu2jik = MkHu "elbújik" "elbúji" MorphismRole Multiplicative 4 7
public export v_elcsendesedik : HuWord
v_elcsendesedik = MkHu "elcsendesedik" "elcsendesedi" MorphismRole Multiplicative 4 13
public export v_elcsendesi2t : HuWord
v_elcsendesi2t = MkHu "elcsendesít" "elcsendesí" MorphismRole Multiplicative 2 11
public export v_elcsendesi2ttet : HuWord
v_elcsendesi2ttet = MkHu "elcsendesíttet" "elcsendesí" MorphismRole Multiplicative 10 14
public export v_elcsiga2z : HuWord
v_elcsiga2z = MkHu "elcsigáz" "elcsigáz" MorphismRole Additive 0 8
public export v_elcsiga2zo2dik : HuWord
v_elcsiga2zo2dik = MkHu "elcsigázódik" "elcsigázódi" MorphismRole Multiplicative 4 12
public export v_elejt : HuWord
v_elejt = MkHu "elejt" "ele" MorphismRole Multiplicative 18 5
public export v_elfajzik : HuWord
v_elfajzik = MkHu "elfajzik" "elfajzi" MorphismRole Multiplicative 4 8
public export v_elferdi2t : HuWord
v_elferdi2t = MkHu "elferdít" "elferdí" MorphismRole Multiplicative 2 8
public export v_elfogy : HuWord
v_elfogy = MkHu "elfogy" "elfogy" MorphismRole Additive 0 6
public export v_elfogyaszt : HuWord
v_elfogyaszt = MkHu "elfogyaszt" "elfogyasz" MorphismRole Additive 2 10
public export v_elfogyasztat : HuWord
v_elfogyasztat = MkHu "elfogyasztat" "elfogyasz" MorphismRole Additive 0 12
public export v_elfonnyad : HuWord
v_elfonnyad = MkHu "elfonnyad" "elfonnyad" MorphismRole Additive 0 9
public export v_elfordi2t : HuWord
v_elfordi2t = MkHu "elfordít" "elfordí" MorphismRole Multiplicative 2 8
public export v_elfut : HuWord
v_elfut = MkHu "elfut" "elfu" MorphismRole Additive 2 5
public export v_elfa2rad : HuWord
v_elfa2rad = MkHu "elfárad" "elfárad" MorphismRole Additive 0 7
public export v_elgennyed : HuWord
v_elgennyed = MkHu "elgennyed" "elgenny" MorphismRole Multiplicative 32 9
public export v_elgyengi2t : HuWord
v_elgyengi2t = MkHu "elgyengít" "elgyengí" MorphismRole Multiplicative 2 9
public export v_elgyengu3l : HuWord
v_elgyengu3l = MkHu "elgyengül" "elgyengül" MorphismRole Multiplicative 0 9
public export v_elga2zol : HuWord
v_elga2zol = MkHu "elgázol" "elgázol" MorphismRole Additive 0 7
public export v_elhagy : HuWord
v_elhagy = MkHu "elhagy" "elhagy" MorphismRole Additive 0 6
public export v_elhalva2nyi2t : HuWord
v_elhalva2nyi2t = MkHu "elhalványít" "elhalványí" MorphismRole Multiplicative 2 11
public export v_elhanyagol : HuWord
v_elhanyagol = MkHu "elhanyagol" "elhanyagol" MorphismRole Additive 0 10
public export v_elhaszna2lo2dik : HuWord
v_elhaszna2lo2dik = MkHu "elhasználódik" "elhasználódi" MorphismRole Multiplicative 4 13
public export v_elhervad : HuWord
v_elhervad = MkHu "elhervad" "elhervad" MorphismRole Additive 0 8
public export v_elhoma2lyosul : HuWord
v_elhoma2lyosul = MkHu "elhomályosul" "elhomályosul" MorphismRole Additive 0 12
public export v_elhoma2lyosi2t : HuWord
v_elhoma2lyosi2t = MkHu "elhomályosít" "elhomályosí" MorphismRole Multiplicative 2 12
public export v_elkeri2t : HuWord
v_elkeri2t = MkHu "elkerít" "elkerí" MorphismRole Multiplicative 2 7
public export v_elkoboz : HuWord
v_elkoboz = MkHu "elkoboz" "elkoboz" MorphismRole Additive 0 7
public export v_elkorcsosul : HuWord
v_elkorcsosul = MkHu "elkorcsosul" "elkorcsosul" MorphismRole Additive 0 11
public export v_elkorcsosi2t : HuWord
v_elkorcsosi2t = MkHu "elkorcsosít" "elkorcsosí" MorphismRole Multiplicative 2 11
public export v_elke2set : HuWord
v_elke2set = MkHu "elkéset" "elkés" MorphismRole Multiplicative 2 7
public export v_elke2sik : HuWord
v_elke2sik = MkHu "elkésik" "elkési" MorphismRole Multiplicative 4 7
public export v_elko3do3si2t : HuWord
v_elko3do3si2t = MkHu "elködösít" "elködösí" MorphismRole Multiplicative 2 9
public export v_elko3lt : HuWord
v_elko3lt = MkHu "elkölt" "elköl" MorphismRole Multiplicative 2 6
public export v_elko3lttet : HuWord
v_elko3lttet = MkHu "elkölttet" "elköl" MorphismRole Multiplicative 10 9
public export v_elku3lo3ni2t : HuWord
v_elku3lo3ni2t = MkHu "elkülönít" "elkülöní" MorphismRole Multiplicative 2 9
public export v_elku3lo3nu3l : HuWord
v_elku3lo3nu3l = MkHu "elkülönül" "elkülönül" MorphismRole Multiplicative 0 9
public export v_ellankad : HuWord
v_ellankad = MkHu "ellankad" "ellankad" MorphismRole Additive 0 8
public export v_ellankaszt : HuWord
v_ellankaszt = MkHu "ellankaszt" "ellankasz" MorphismRole Additive 2 10
public export v_ellilul : HuWord
v_ellilul = MkHu "ellilul" "ellilul" MorphismRole Additive 0 7
public export v_ellustul : HuWord
v_ellustul = MkHu "ellustul" "ellustul" MorphismRole Additive 0 8
public export v_ellusti2t : HuWord
v_ellusti2t = MkHu "ellustít" "ellustí" MorphismRole Multiplicative 2 8
public export v_elmarad : HuWord
v_elmarad = MkHu "elmarad" "elmarad" MorphismRole Additive 0 7
public export v_elne2z : HuWord
v_elne2z = MkHu "elnéz" "elnéz" MorphismRole Multiplicative 0 5
public export v_eloszt : HuWord
v_eloszt = MkHu "eloszt" "elosz" MorphismRole Additive 2 6
public export v_elpusztul : HuWord
v_elpusztul = MkHu "elpusztul" "elpusztul" MorphismRole Additive 0 9
public export v_elpuszti2t : HuWord
v_elpuszti2t = MkHu "elpusztít" "elpusztí" MorphismRole Multiplicative 2 9
public export v_elpuszti2ttat : HuWord
v_elpuszti2ttat = MkHu "elpusztíttat" "elpusztí" MorphismRole Multiplicative 10 12
public export v_elragad : HuWord
v_elragad = MkHu "elragad" "elragad" MorphismRole Additive 0 7
public export v_elrejto4zik : HuWord
v_elrejto4zik = MkHu "elrejtőzik" "elrejtőzi" MorphismRole Multiplicative 4 10
public export v_elrendezo4dik : HuWord
v_elrendezo4dik = MkHu "elrendeződik" "elrendeződi" MorphismRole Multiplicative 4 12
public export v_elriaszt : HuWord
v_elriaszt = MkHu "elriaszt" "elriasz" MorphismRole Additive 2 8
public export v_elromlik : HuWord
v_elromlik = MkHu "elromlik" "elromli" MorphismRole Multiplicative 4 8
public export v_elsaja2ti2t : HuWord
v_elsaja2ti2t = MkHu "elsajátít" "elsajátí" MorphismRole Multiplicative 2 9
public export v_elszokik : HuWord
v_elszokik = MkHu "elszokik" "elszoki" MorphismRole Multiplicative 4 8
public export v_eltata2rosodik : HuWord
v_eltata2rosodik = MkHu "eltatárosodik" "eltatárosodi" MorphismRole Multiplicative 4 13
public export v_elterjed : HuWord
v_elterjed = MkHu "elterjed" "elter" MorphismRole Multiplicative 48 8
public export v_eltunyul : HuWord
v_eltunyul = MkHu "eltunyul" "eltunyul" MorphismRole Additive 0 8
public export v_elte2ved : HuWord
v_elte2ved = MkHu "eltéved" "eltév" MorphismRole Multiplicative 32 7
public export v_eltu2loz : HuWord
v_eltu2loz = MkHu "eltúloz" "eltúloz" MorphismRole Additive 0 7
public export v_eltu4nik : HuWord
v_eltu4nik = MkHu "eltűnik" "eltűni" MorphismRole Multiplicative 4 7
public export v_elvadul : HuWord
v_elvadul = MkHu "elvadul" "elvadul" MorphismRole Additive 0 7
public export v_elvan : HuWord
v_elvan = MkHu "elvan" "elva" MorphismRole Additive 1 5
public export v_elvesz : HuWord
v_elvesz = MkHu "elvesz" "elvesz" MorphismRole Multiplicative 0 6
public export v_elva2laszt : HuWord
v_elva2laszt = MkHu "elválaszt" "elválasz" MorphismRole Additive 2 9
public export v_elve2gez : HuWord
v_elve2gez = MkHu "elvégez" "elvégez" MorphismRole Multiplicative 0 7
public export v_elve2geztet : HuWord
v_elve2geztet = MkHu "elvégeztet" "elvégez" MorphismRole Multiplicative 0 10
public export v_elve2sz : HuWord
v_elve2sz = MkHu "elvész" "elvész" MorphismRole Multiplicative 0 6
public export v_elzsi2rosodik : HuWord
v_elzsi2rosodik = MkHu "elzsírosodik" "elzsírosodi" MorphismRole Multiplicative 4 12
public export v_elzu3lleszt : HuWord
v_elzu3lleszt = MkHu "elzülleszt" "elzüllesz" MorphismRole Multiplicative 2 10
public export v_elzu3llik : HuWord
v_elzu3llik = MkHu "elzüllik" "elzülli" MorphismRole Multiplicative 4 8
public export v_elo3lja2r : HuWord
v_elo3lja2r = MkHu "elöljár" "elöljár" MorphismRole Additive 0 7
public export v_elu3ldo3ge2l : HuWord
v_elu3ldo3ge2l = MkHu "elüldögél" "elüldögél" MorphismRole Multiplicative 0 9
public export v_elu3t : HuWord
v_elu3t = MkHu "elüt" "elü" MorphismRole Multiplicative 2 4
public export v_elo4bukkan : HuWord
v_elo4bukkan = MkHu "előbukkan" "előbukka" MorphismRole Additive 1 9
public export v_elo4rejut : HuWord
v_elo4rejut = MkHu "előrejut" "előreju" MorphismRole Additive 2 8
public export v_elo4remozdi2t : HuWord
v_elo4remozdi2t = MkHu "előremozdít" "előremozdí" MorphismRole Multiplicative 2 11
public export v_elo4remozdi2ttat : HuWord
v_elo4remozdi2ttat = MkHu "előremozdíttat" "előremozdí" MorphismRole Multiplicative 10 14
public export v_elo4retol : HuWord
v_elo4retol = MkHu "előretol" "előretol" MorphismRole Additive 0 8
public export v_elo4retolat : HuWord
v_elo4retolat = MkHu "előretolat" "előretol" MorphismRole Additive 2 10
public export v_elo4z : HuWord
v_elo4z = MkHu "előz" "előz" MorphismRole Multiplicative 0 4
public export v_emel : HuWord
v_emel = MkHu "emel" "emel" MorphismRole Multiplicative 0 4
public export v_emelkedik : HuWord
v_emelkedik = MkHu "emelkedik" "emelkedi" MorphismRole Multiplicative 4 9
public export v_emeltet : HuWord
v_emeltet = MkHu "emeltet" "emel" MorphismRole Multiplicative 0 7
public export v_engedetlenkedik : HuWord
v_engedetlenkedik = MkHu "engedetlenkedik" "engedetlenkedi" MorphismRole Multiplicative 4 15
public export v_epre2szik : HuWord
v_epre2szik = MkHu "eprészik" "eprészi" MorphismRole Multiplicative 4 8
public export v_ezu3sto3z : HuWord
v_ezu3sto3z = MkHu "ezüstöz" "ezüstöz" MorphismRole Multiplicative 0 7
public export v_ezu3sto3ztet : HuWord
v_ezu3sto3ztet = MkHu "ezüstöztet" "ezüstöz" MorphismRole Multiplicative 0 10
public export v_farol : HuWord
v_farol = MkHu "farol" "farol" MorphismRole Additive 0 5
public export v_fecseg : HuWord
v_fecseg = MkHu "fecseg" "fecseg" MorphismRole Multiplicative 0 6
public export v_fedez : HuWord
v_fedez = MkHu "fedez" "fedez" MorphismRole Multiplicative 0 5
public export v_fedeztet : HuWord
v_fedeztet = MkHu "fedeztet" "fedez" MorphismRole Multiplicative 0 8
public export v_fejleszt : HuWord
v_fejleszt = MkHu "fejleszt" "fejlesz" MorphismRole Multiplicative 2 8
public export v_fejlesztet : HuWord
v_fejlesztet = MkHu "fejlesztet" "fejlesz" MorphismRole Multiplicative 0 10
public export v_fejlo4dik : HuWord
v_fejlo4dik = MkHu "fejlődik" "fejlődi" MorphismRole Multiplicative 4 8
public export v_felbillen : HuWord
v_felbillen = MkHu "felbillen" "felbill" MorphismRole Multiplicative 1 9
public export v_felbolydi2t : HuWord
v_felbolydi2t = MkHu "felbolydít" "felbolydí" MorphismRole Multiplicative 2 10
public export v_felborul : HuWord
v_felborul = MkHu "felborul" "felborul" MorphismRole Additive 0 8
public export v_felbori2t : HuWord
v_felbori2t = MkHu "felborít" "felborí" MorphismRole Multiplicative 2 8
public export v_felbukfencezik : HuWord
v_felbukfencezik = MkHu "felbukfencezik" "felbukfencezi" MorphismRole Multiplicative 4 14
public export v_felbukfenceztet : HuWord
v_felbukfenceztet = MkHu "felbukfenceztet" "felbukfencez" MorphismRole Multiplicative 0 15
public export v_felbuzdul : HuWord
v_felbuzdul = MkHu "felbuzdul" "felbuzdul" MorphismRole Additive 0 9
public export v_felcsavar : HuWord
v_felcsavar = MkHu "felcsavar" "felcsavar" MorphismRole Additive 0 9
public export v_felcsavarodik : HuWord
v_felcsavarodik = MkHu "felcsavarodik" "felcsavarodi" MorphismRole Multiplicative 4 13
public export v_felcsavartat : HuWord
v_felcsavartat = MkHu "felcsavartat" "felcsavar" MorphismRole Additive 0 12
public export v_feldagad : HuWord
v_feldagad = MkHu "feldagad" "feldagad" MorphismRole Additive 0 8
public export v_felduzzad : HuWord
v_felduzzad = MkHu "felduzzad" "felduzzad" MorphismRole Additive 0 9
public export v_feldo4l : HuWord
v_feldo4l = MkHu "feldől" "feldől" MorphismRole Multiplicative 0 6
public export v_feldo4lt : HuWord
v_feldo4lt = MkHu "feldőlt" "feldől" MorphismRole Multiplicative 2 7
public export v_feleme2szt : HuWord
v_feleme2szt = MkHu "felemészt" "felemész" MorphismRole Multiplicative 2 9
public export v_feleme2sztet : HuWord
v_feleme2sztet = MkHu "felemésztet" "felemész" MorphismRole Multiplicative 0 11
public export v_felfog : HuWord
v_felfog = MkHu "felfog" "felfog" MorphismRole Additive 0 6
public export v_felfordul : HuWord
v_felfordul = MkHu "felfordul" "felfordul" MorphismRole Additive 0 9
public export v_felfordi2t : HuWord
v_felfordi2t = MkHu "felfordít" "felfordí" MorphismRole Multiplicative 2 9
public export v_felfordi2ttat : HuWord
v_felfordi2ttat = MkHu "felfordíttat" "felfordí" MorphismRole Multiplicative 10 12
public export v_felforgat : HuWord
v_felforgat = MkHu "felforgat" "felforg" MorphismRole Additive 2 9
public export v_felforr : HuWord
v_felforr = MkHu "felforr" "felforr" MorphismRole Additive 0 7
public export v_felfortyan : HuWord
v_felfortyan = MkHu "felfortyan" "felfortya" MorphismRole Additive 1 10
public export v_felforul : HuWord
v_felforul = MkHu "felforul" "felforul" MorphismRole Additive 0 8
public export v_felgo3ngyo3l : HuWord
v_felgo3ngyo3l = MkHu "felgöngyöl" "felgöngyöl" MorphismRole Multiplicative 0 10
public export v_felgo3ngyo3ltet : HuWord
v_felgo3ngyo3ltet = MkHu "felgöngyöltet" "felgöngyöl" MorphismRole Multiplicative 0 13
public export v_felgo3ngyo3li2t : HuWord
v_felgo3ngyo3li2t = MkHu "felgöngyölít" "felgöngyölí" MorphismRole Multiplicative 2 12
public export v_felgo3ngyo3li2ttet : HuWord
v_felgo3ngyo3li2ttet = MkHu "felgöngyölíttet" "felgöngyölí" MorphismRole Multiplicative 10 15
public export v_felgo3ngyo3lo3dik : HuWord
v_felgo3ngyo3lo3dik = MkHu "felgöngyölödik" "felgöngyölödi" MorphismRole Multiplicative 4 14
public export v_felingerel : HuWord
v_felingerel = MkHu "felingerel" "felingerel" MorphismRole Multiplicative 0 10
public export v_felismer : HuWord
v_felismer = MkHu "felismer" "felismer" MorphismRole Multiplicative 0 8
public export v_felizgat : HuWord
v_felizgat = MkHu "felizgat" "felizg" MorphismRole Multiplicative 2 8
public export v_felke2szi2t : HuWord
v_felke2szi2t = MkHu "felkészít" "felkészí" MorphismRole Multiplicative 2 9
public export v_felke2szu3l : HuWord
v_felke2szu3l = MkHu "felkészül" "felkészül" MorphismRole Multiplicative 0 9
public export v_fellazul : HuWord
v_fellazul = MkHu "fellazul" "fellazul" MorphismRole Additive 0 8
public export v_fellazi2t : HuWord
v_fellazi2t = MkHu "fellazít" "fellazí" MorphismRole Multiplicative 2 8
public export v_fellazi2ttat : HuWord
v_fellazi2ttat = MkHu "fellazíttat" "fellazí" MorphismRole Multiplicative 10 11
public export v_fellobban : HuWord
v_fellobban = MkHu "fellobban" "fellob" MorphismRole Additive 1 9
public export v_fellobbant : HuWord
v_fellobbant = MkHu "fellobbant" "fellobba" MorphismRole Additive 3 10
public export v_fella2zi2ttat : HuWord
v_fella2zi2ttat = MkHu "fellázíttat" "fellází" MorphismRole Multiplicative 10 11
public export v_felmagasztal : HuWord
v_felmagasztal = MkHu "felmagasztal" "felmagasztal" MorphismRole Additive 0 12
public export v_felno4 : HuWord
v_felno4 = MkHu "felnő" "felnő" MorphismRole Multiplicative 0 5
public export v_feloszt : HuWord
v_feloszt = MkHu "feloszt" "felosz" MorphismRole Additive 2 7
public export v_felra2z : HuWord
v_felra2z = MkHu "felráz" "felráz" MorphismRole Additive 0 6
public export v_felszed : HuWord
v_felszed = MkHu "felszed" "felsz" MorphismRole Multiplicative 32 7
public export v_felszi2t : HuWord
v_felszi2t = MkHu "felszít" "felszí" MorphismRole Multiplicative 2 7
public export v_felteker : HuWord
v_felteker = MkHu "felteker" "felteker" MorphismRole Multiplicative 0 8
public export v_feltekeredik : HuWord
v_feltekeredik = MkHu "feltekeredik" "feltekeredi" MorphismRole Multiplicative 4 12
public export v_feltekertet : HuWord
v_feltekertet = MkHu "feltekertet" "felteker" MorphismRole Multiplicative 0 11
public export v_felte2telez : HuWord
v_felte2telez = MkHu "feltételez" "feltételez" MorphismRole Multiplicative 0 10
public export v_feltu4z : HuWord
v_feltu4z = MkHu "feltűz" "feltűz" MorphismRole Multiplicative 0 6
public export v_feltu4zet : HuWord
v_feltu4zet = MkHu "feltűzet" "feltűz" MorphismRole Multiplicative 2 8
public export v_felva2g : HuWord
v_felva2g = MkHu "felvág" "felvág" MorphismRole Additive 0 6
public export v_felu3lkerekedik : HuWord
v_felu3lkerekedik = MkHu "felülkerekedik" "felülkerekedi" MorphismRole Multiplicative 4 14
public export v_fen : HuWord
v_fen = MkHu "fen" "fen" MorphismRole Multiplicative 0 3
public export v_fest : HuWord
v_fest = MkHu "fest" "fes" MorphismRole Multiplicative 2 4
public export v_festet : HuWord
v_festet = MkHu "festet" "fes" MorphismRole Multiplicative 0 6
public export v_festo4dik : HuWord
v_festo4dik = MkHu "festődik" "festődi" MorphismRole Multiplicative 4 8
public export v_figyel : HuWord
v_figyel = MkHu "figyel" "figyel" MorphismRole Multiplicative 0 6
public export v_fintorog : HuWord
v_fintorog = MkHu "fintorog" "fintorog" MorphismRole Additive 0 8
public export v_flo3rto3l : HuWord
v_flo3rto3l = MkHu "flörtöl" "flörtöl" MorphismRole Multiplicative 0 7
public export v_fogatol : HuWord
v_fogatol = MkHu "fogatol" "fogatol" MorphismRole Additive 0 7
public export v_folyat : HuWord
v_folyat = MkHu "folyat" "foly" MorphismRole Additive 2 6
public export v_folyik : HuWord
v_folyik = MkHu "folyik" "folyi" MorphismRole Multiplicative 4 6
public export v_folytat : HuWord
v_folytat = MkHu "folytat" "foly" MorphismRole Additive 0 7
public export v_folytattat : HuWord
v_folytattat = MkHu "folytattat" "folyta" MorphismRole Additive 10 10
public export v_fon : HuWord
v_fon = MkHu "fon" "fon" MorphismRole Additive 0 3
public export v_fordul : HuWord
v_fordul = MkHu "fordul" "fordul" MorphismRole Additive 0 6
public export v_fordi2t : HuWord
v_fordi2t = MkHu "fordít" "fordí" MorphismRole Multiplicative 2 6
public export v_fordi2ttat : HuWord
v_fordi2ttat = MkHu "fordíttat" "fordí" MorphismRole Multiplicative 10 9
public export v_forgat : HuWord
v_forgat = MkHu "forgat" "forg" MorphismRole Additive 2 6
public export v_forgolo2dik : HuWord
v_forgolo2dik = MkHu "forgolódik" "forgolódi" MorphismRole Multiplicative 4 10
public export v_forma2l : HuWord
v_forma2l = MkHu "formál" "formál" MorphismRole Additive 0 6
public export v_forog : HuWord
v_forog = MkHu "forog" "forog" MorphismRole Additive 0 5
public export v_forr : HuWord
v_forr = MkHu "forr" "forr" MorphismRole Additive 0 4
public export v_forral : HuWord
v_forral = MkHu "forral" "forral" MorphismRole Additive 0 6
public export v_forraltat : HuWord
v_forraltat = MkHu "forraltat" "forral" MorphismRole Additive 0 9
public export v_fortyog : HuWord
v_fortyog = MkHu "fortyog" "fortyog" MorphismRole Additive 0 7
public export v_fro3ccsen : HuWord
v_fro3ccsen = MkHu "fröccsen" "fröccs" MorphismRole Multiplicative 1 8
public export v_furkos : HuWord
v_furkos = MkHu "furkos" "furkos" MorphismRole Additive 0 6
public export v_fut : HuWord
v_fut = MkHu "fut" "fut" MorphismRole Additive 0 3
public export v_futkos : HuWord
v_futkos = MkHu "futkos" "futkos" MorphismRole Additive 0 6
public export v_futtat : HuWord
v_futtat = MkHu "futtat" "fut" MorphismRole Additive 0 6
public export v_fe2lremagyara2z : HuWord
v_fe2lremagyara2z = MkHu "félremagyaráz" "félremagyaráz" MorphismRole Additive 0 13
public export v_fo3ldsa2ncot : HuWord
v_fo3ldsa2ncot = MkHu "földsáncot" "földsánc" MorphismRole Additive 2 10
public export v_gennyesedik : HuWord
v_gennyesedik = MkHu "gennyesedik" "gennyesedi" MorphismRole Multiplicative 4 11
public export v_gennyeszt : HuWord
v_gennyeszt = MkHu "gennyeszt" "gennyesz" MorphismRole Multiplicative 2 9
public export v_gombolyi2t : HuWord
v_gombolyi2t = MkHu "gombolyít" "gombolyí" MorphismRole Multiplicative 2 9
public export v_gombolyi2ttat : HuWord
v_gombolyi2ttat = MkHu "gombolyíttat" "gombolyí" MorphismRole Multiplicative 10 12
public export v_gomolyog : HuWord
v_gomolyog = MkHu "gomolyog" "gomolyog" MorphismRole Additive 0 8
public export v_gurul : HuWord
v_gurul = MkHu "gurul" "gurul" MorphismRole Additive 0 5
public export v_guri2t : HuWord
v_guri2t = MkHu "gurít" "gurí" MorphismRole Multiplicative 2 5
public export v_gyengi2t : HuWord
v_gyengi2t = MkHu "gyengít" "gyengí" MorphismRole Multiplicative 2 7
public export v_gyo2gyul : HuWord
v_gyo2gyul = MkHu "gyógyul" "gyógyul" MorphismRole Additive 0 7
public export v_gyo2gyi2t : HuWord
v_gyo2gyi2t = MkHu "gyógyít" "gyógyí" MorphismRole Multiplicative 2 7
public export v_gyo2gyi2ttat : HuWord
v_gyo2gyi2ttat = MkHu "gyógyíttat" "gyógyí" MorphismRole Multiplicative 10 10
public export v_gyo3tro4dik : HuWord
v_gyo3tro4dik = MkHu "gyötrődik" "gyötrődi" MorphismRole Multiplicative 4 9
public export v_gyu2r : HuWord
v_gyu2r = MkHu "gyúr" "gyúr" MorphismRole Additive 0 4
public export v_gyu4jt : HuWord
v_gyu4jt = MkHu "gyűjt" "gyű" MorphismRole Multiplicative 18 5
public export v_gyu4jtet : HuWord
v_gyu4jtet = MkHu "gyűjtet" "gyű" MorphismRole Multiplicative 16 7
public export v_gyu4jte2s : HuWord
v_gyu4jte2s = MkHu "gyűjtés" "gyűjtés" MorphismRole Multiplicative 0 7
public export v_gyu4lo3l : HuWord
v_gyu4lo3l = MkHu "gyűlöl" "gyűlöl" MorphismRole Multiplicative 0 6
public export v_go3ndo3ri2t : HuWord
v_go3ndo3ri2t = MkHu "göndörít" "göndörí" MorphismRole Multiplicative 2 8
public export v_go3ndo3ro3dik : HuWord
v_go3ndo3ro3dik = MkHu "göndörödik" "göndörödi" MorphismRole Multiplicative 4 10
public export v_go4go3sko3dik : HuWord
v_go4go3sko3dik = MkHu "gőgösködik" "gőgösködi" MorphismRole Multiplicative 4 10
public export v_hajt : HuWord
v_hajt = MkHu "hajt" "haj" MorphismRole Additive 2 4
public export v_halad : HuWord
v_halad = MkHu "halad" "halad" MorphismRole Additive 0 5
public export v_hangoskodik : HuWord
v_hangoskodik = MkHu "hangoskodik" "hangoskodi" MorphismRole Multiplicative 4 11
public export v_hazamegy : HuWord
v_hazamegy = MkHu "hazamegy" "hazamegy" MorphismRole Multiplicative 0 8
public export v_hazudik : HuWord
v_hazudik = MkHu "hazudik" "hazudi" MorphismRole Multiplicative 4 7
public export v_hebeg : HuWord
v_hebeg = MkHu "hebeg" "hebeg" MorphismRole Multiplicative 0 5
public export v_hegesedik : HuWord
v_hegesedik = MkHu "hegesedik" "hegesedi" MorphismRole Multiplicative 4 9
public export v_hemzseg : HuWord
v_hemzseg = MkHu "hemzseg" "hemzseg" MorphismRole Multiplicative 0 7
public export v_henceg : HuWord
v_henceg = MkHu "henceg" "henceg" MorphismRole Multiplicative 0 6
public export v_hetvenkedik : HuWord
v_hetvenkedik = MkHu "hetvenkedik" "hetvenkedi" MorphismRole Multiplicative 4 11
public export v_heveskedik : HuWord
v_heveskedik = MkHu "heveskedik" "heveskedi" MorphismRole Multiplicative 4 10
public export v_hiba2zik : HuWord
v_hiba2zik = MkHu "hibázik" "hibázi" MorphismRole Multiplicative 4 7
public export v_hirdet : HuWord
v_hirdet = MkHu "hirdet" "hird" MorphismRole Multiplicative 2 6
public export v_hozza2ad : HuWord
v_hozza2ad = MkHu "hozzáad" "hozzáad" MorphismRole Additive 0 7
public export v_hozza2adat : HuWord
v_hozza2adat = MkHu "hozzáadat" "hozzáad" MorphismRole Additive 2 9
public export v_hozza2csatol : HuWord
v_hozza2csatol = MkHu "hozzácsatol" "hozzácsatol" MorphismRole Additive 0 11
public export v_hulla2mzik : HuWord
v_hulla2mzik = MkHu "hullámzik" "hullámzi" MorphismRole Multiplicative 4 9
public export v_ha2borgat : HuWord
v_ha2borgat = MkHu "háborgat" "háborg" MorphismRole Additive 2 8
public export v_ha2trafordul : HuWord
v_ha2trafordul = MkHu "hátrafordul" "hátrafordul" MorphismRole Additive 0 11
public export v_ha2tramozdul : HuWord
v_ha2tramozdul = MkHu "hátramozdul" "hátramozdul" MorphismRole Additive 0 11
public export v_ha2tratolo2dik : HuWord
v_ha2tratolo2dik = MkHu "hátratolódik" "hátratolódi" MorphismRole Multiplicative 4 12
public export v_ha2tra2l : HuWord
v_ha2tra2l = MkHu "hátrál" "hátrál" MorphismRole Additive 0 6
public export v_hi2resztel : HuWord
v_hi2resztel = MkHu "híresztel" "híresztel" MorphismRole Multiplicative 0 9
public export v_hi2zeleg : HuWord
v_hi2zeleg = MkHu "hízeleg" "hízeleg" MorphismRole Multiplicative 0 7
public export v_hi2zik : HuWord
v_hi2zik = MkHu "hízik" "hízi" MorphismRole Multiplicative 4 5
public export v_ho4sko3dik : HuWord
v_ho4sko3dik = MkHu "hősködik" "hősködi" MorphismRole Multiplicative 4 8
public export v_idegeskedik : HuWord
v_idegeskedik = MkHu "idegeskedik" "idegeskedi" MorphismRole Multiplicative 4 11
public export v_idegesi2t : HuWord
v_idegesi2t = MkHu "idegesít" "idegesí" MorphismRole Multiplicative 2 8
public export v_igyekszik : HuWord
v_igyekszik = MkHu "igyekszik" "igyekszi" MorphismRole Multiplicative 4 9
public export v_inog : HuWord
v_inog = MkHu "inog" "inog" MorphismRole Additive 0 4
public export v_ira2nyi2t : HuWord
v_ira2nyi2t = MkHu "irányít" "irányí" MorphismRole Multiplicative 2 7
public export v_izgul : HuWord
v_izgul = MkHu "izgul" "izgul" MorphismRole Additive 0 5
public export v_izzad : HuWord
v_izzad = MkHu "izzad" "izzad" MorphismRole Additive 0 5
public export v_javi2t : HuWord
v_javi2t = MkHu "javít" "javí" MorphismRole Multiplicative 2 5
public export v_javi2ttat : HuWord
v_javi2ttat = MkHu "javíttat" "javí" MorphismRole Multiplicative 10 8
public export v_ja2tssza2k : HuWord
v_ja2tssza2k = MkHu "játsszák" "játsszá" MorphismRole Additive 4 8
public export v_jo2sol : HuWord
v_jo2sol = MkHu "jósol" "jósol" MorphismRole Additive 0 5
public export v_kakaskodik : HuWord
v_kakaskodik = MkHu "kakaskodik" "kakaskodi" MorphismRole Multiplicative 4 10
public export v_kap : HuWord
v_kap = MkHu "kap" "kap" MorphismRole Additive 0 3
public export v_kapkod : HuWord
v_kapkod = MkHu "kapkod" "kap" MorphismRole Additive 36 6
public export v_kapzsi : HuWord
v_kapzsi = MkHu "kapzsi" "kapzsi" MorphismRole Multiplicative 0 6
public export v_keletkezik : HuWord
v_keletkezik = MkHu "keletkezik" "keletkezi" MorphismRole Multiplicative 4 10
public export v_keres : HuWord
v_keres = MkHu "keres" "keres" MorphismRole Multiplicative 0 5
public export v_kering : HuWord
v_kering = MkHu "kering" "kering" MorphismRole Multiplicative 0 6
public export v_kezd : HuWord
v_kezd = MkHu "kezd" "kezd" MorphismRole Multiplicative 0 4
public export v_kiaba2l : HuWord
v_kiaba2l = MkHu "kiabál" "kiabál" MorphismRole Additive 0 6
public export v_kibondori2t : HuWord
v_kibondori2t = MkHu "kibondorít" "kibondorí" MorphismRole Multiplicative 2 10
public export v_kibe2ku3l : HuWord
v_kibe2ku3l = MkHu "kibékül" "kibékül" MorphismRole Multiplicative 0 7
public export v_kibo4vi2t : HuWord
v_kibo4vi2t = MkHu "kibővít" "kibőví" MorphismRole Multiplicative 2 7
public export v_kibo4vi2ttet : HuWord
v_kibo4vi2ttet = MkHu "kibővíttet" "kibőví" MorphismRole Multiplicative 10 10
public export v_kicsavar : HuWord
v_kicsavar = MkHu "kicsavar" "kicsavar" MorphismRole Additive 0 8
public export v_kiege2szi2t : HuWord
v_kiege2szi2t = MkHu "kiegészít" "kiegészí" MorphismRole Multiplicative 2 9
public export v_kiege2szi2ttet : HuWord
v_kiege2szi2ttet = MkHu "kiegészíttet" "kiegészí" MorphismRole Multiplicative 10 12
public export v_kifakul : HuWord
v_kifakul = MkHu "kifakul" "kifakul" MorphismRole Additive 0 7
public export v_kifaki2t : HuWord
v_kifaki2t = MkHu "kifakít" "kifakí" MorphismRole Multiplicative 2 7
public export v_kificamodik : HuWord
v_kificamodik = MkHu "kificamodik" "kificamodi" MorphismRole Multiplicative 4 11
public export v_kificami2t : HuWord
v_kificami2t = MkHu "kificamít" "kificamí" MorphismRole Multiplicative 2 9
public export v_kificami2ttat : HuWord
v_kificami2ttat = MkHu "kificamíttat" "kificamí" MorphismRole Multiplicative 10 12
public export v_kifordi2t : HuWord
v_kifordi2t = MkHu "kifordít" "kifordí" MorphismRole Multiplicative 2 8
public export v_kifordi2ttat : HuWord
v_kifordi2ttat = MkHu "kifordíttat" "kifordí" MorphismRole Multiplicative 10 11
public export v_kifa2raszt : HuWord
v_kifa2raszt = MkHu "kifáraszt" "kifárasz" MorphismRole Additive 2 9
public export v_kigyu2l : HuWord
v_kigyu2l = MkHu "kigyúl" "kigyúl" MorphismRole Additive 0 6
public export v_kigo3mbo3lyi2t : HuWord
v_kigo3mbo3lyi2t = MkHu "kigömbölyít" "kigömbölyí" MorphismRole Multiplicative 2 11
public export v_kigo3mbo3lyo3dik : HuWord
v_kigo3mbo3lyo3dik = MkHu "kigömbölyödik" "kigömbölyödi" MorphismRole Multiplicative 4 13
public export v_kihajt : HuWord
v_kihajt = MkHu "kihajt" "kiha" MorphismRole Additive 18 6
public export v_kijo2zanodik : HuWord
v_kijo2zanodik = MkHu "kijózanodik" "kijózanodi" MorphismRole Multiplicative 4 11
public export v_kijo2zani2t : HuWord
v_kijo2zani2t = MkHu "kijózanít" "kijózaní" MorphismRole Multiplicative 2 9
public export v_kijo2zai2t : HuWord
v_kijo2zai2t = MkHu "kijózaít" "kijózaí" MorphismRole Multiplicative 2 8
public export v_kikerekedik : HuWord
v_kikerekedik = MkHu "kikerekedik" "kikerekedi" MorphismRole Multiplicative 4 11
public export v_kikereki2t : HuWord
v_kikereki2t = MkHu "kikerekít" "kikerekí" MorphismRole Multiplicative 2 9
public export v_kiku3rto3l : HuWord
v_kiku3rto3l = MkHu "kikürtöl" "kikürtöl" MorphismRole Multiplicative 0 8
public export v_kipusztul : HuWord
v_kipusztul = MkHu "kipusztul" "kipusztul" MorphismRole Additive 0 9
public export v_kirak : HuWord
v_kirak = MkHu "kirak" "kir" MorphismRole Multiplicative 4 5
public export v_kirakat : HuWord
v_kirakat = MkHu "kirakat" "kira" MorphismRole Additive 6 7
public export v_kirakodik : HuWord
v_kirakodik = MkHu "kirakodik" "kirakodi" MorphismRole Multiplicative 4 9
public export v_kirakodtat : HuWord
v_kirakodtat = MkHu "kirakodtat" "kirakod" MorphismRole Additive 0 10
public export v_kisaja2ti2t : HuWord
v_kisaja2ti2t = MkHu "kisajátít" "kisajátí" MorphismRole Multiplicative 2 9
public export v_kisu3t : HuWord
v_kisu3t = MkHu "kisüt" "kisü" MorphismRole Multiplicative 2 5
public export v_kiva2laszt : HuWord
v_kiva2laszt = MkHu "kiválaszt" "kiválasz" MorphismRole Additive 2 9
public export v_kiva2lasztat : HuWord
v_kiva2lasztat = MkHu "kiválasztat" "kiválasz" MorphismRole Additive 0 11
public export v_kiva2logat : HuWord
v_kiva2logat = MkHu "kiválogat" "kiválog" MorphismRole Additive 2 9
public export v_kiva2logattat : HuWord
v_kiva2logattat = MkHu "kiválogattat" "kiváloga" MorphismRole Additive 10 12
public export v_kive2sz : HuWord
v_kive2sz = MkHu "kivész" "kivész" MorphismRole Multiplicative 0 6
public export v_kia2lt : HuWord
v_kia2lt = MkHu "kiált" "kiál" MorphismRole Additive 2 5
public export v_kii2rto2dik : HuWord
v_kii2rto2dik = MkHu "kiírtódik" "kiírtódi" MorphismRole Multiplicative 4 9
public export v_kiu3ri2t : HuWord
v_kiu3ri2t = MkHu "kiürít" "kiürí" MorphismRole Multiplicative 2 6
public export v_kiu3ri2ttet : HuWord
v_kiu3ri2ttet = MkHu "kiüríttet" "kiürí" MorphismRole Multiplicative 10 9
public export v_kiu3ru3l : HuWord
v_kiu3ru3l = MkHu "kiürül" "kiürül" MorphismRole Multiplicative 0 6
public export v_koagula2l : HuWord
v_koagula2l = MkHu "koagulál" "koagulál" MorphismRole Additive 0 8
public export v_komplika2cio2 : HuWord
v_komplika2cio2 = MkHu "komplikáció" "komplikáció" MorphismRole Additive 0 11
public export v_komplika2cio2_2 : HuWord
v_komplika2cio2_2 = MkHu "komplikáció" "komplikáció" MorphismRole Additive 0 11
public export v_komplika2cio2t : HuWord
v_komplika2cio2t = MkHu "komplikációt" "komplikáció" MorphismRole Additive 2 12
public export v_korog : HuWord
v_korog = MkHu "korog" "korog" MorphismRole Additive 0 5
public export v_kuruttyol : HuWord
v_kuruttyol = MkHu "kuruttyol" "kuruttyol" MorphismRole Additive 0 9
public export v_kuruzsol : HuWord
v_kuruzsol = MkHu "kuruzsol" "kuruzsol" MorphismRole Additive 0 8
public export v_ka2romkodik : HuWord
v_ka2romkodik = MkHu "káromkodik" "káromkodi" MorphismRole Multiplicative 4 10
public export v_ka2romol : HuWord
v_ka2romol = MkHu "káromol" "káromol" MorphismRole Additive 0 7
public export v_ke2nyeskedik : HuWord
v_ke2nyeskedik = MkHu "kényeskedik" "kényeskedi" MorphismRole Multiplicative 4 11
public export v_ke2pes : HuWord
v_ke2pes = MkHu "képes" "képes" MorphismRole Multiplicative 0 5
public export v_ke2rkedik : HuWord
v_ke2rkedik = MkHu "kérkedik" "kérkedi" MorphismRole Multiplicative 4 8
public export v_ke2sik : HuWord
v_ke2sik = MkHu "késik" "kési" MorphismRole Multiplicative 4 5
public export v_ke2szu3lo4dik : HuWord
v_ke2szu3lo4dik = MkHu "készülődik" "készülődi" MorphismRole Multiplicative 4 10
public export v_ke2tse2gbeesik : HuWord
v_ke2tse2gbeesik = MkHu "kétségbeesik" "kétségbeesi" MorphismRole Multiplicative 4 12
public export v_ki2nlo2dik : HuWord
v_ki2nlo2dik = MkHu "kínlódik" "kínlódi" MorphismRole Multiplicative 4 8
public export v_ko2borol : HuWord
v_ko2borol = MkHu "kóborol" "kóborol" MorphismRole Additive 0 7
public export v_ko2sza2l : HuWord
v_ko2sza2l = MkHu "kószál" "kószál" MorphismRole Additive 0 6
public export v_ko3lcso3no3z : HuWord
v_ko3lcso3no3z = MkHu "kölcsönöz" "kölcsönöz" MorphismRole Multiplicative 0 9
public export v_ko3nnyezik : HuWord
v_ko3nnyezik = MkHu "könnyezik" "könnyezi" MorphismRole Multiplicative 4 9
public export v_ko3szo3ru3l : HuWord
v_ko3szo3ru3l = MkHu "köszörül" "köszörül" MorphismRole Multiplicative 0 8
public export v_ko3tekedik : HuWord
v_ko3tekedik = MkHu "kötekedik" "kötekedi" MorphismRole Multiplicative 4 9
public export v_ko3to3z : HuWord
v_ko3to3z = MkHu "kötöz" "kötöz" MorphismRole Multiplicative 0 5
public export v_ko3to3zko3dik : HuWord
v_ko3to3zko3dik = MkHu "kötözködik" "kötözködi" MorphismRole Multiplicative 4 10
public export v_ko3vet : HuWord
v_ko3vet = MkHu "követ" "köv" MorphismRole Multiplicative 2 5
public export v_lazi2t : HuWord
v_lazi2t = MkHu "lazít" "lazí" MorphismRole Multiplicative 2 5
public export v_lazi2ttat : HuWord
v_lazi2ttat = MkHu "lazíttat" "lazí" MorphismRole Multiplicative 10 8
public export v_lealacsonyi2t : HuWord
v_lealacsonyi2t = MkHu "lealacsonyít" "lealacsonyí" MorphismRole Multiplicative 2 12
public export v_lebesze2l : HuWord
v_lebesze2l = MkHu "lebeszél" "lebeszél" MorphismRole Multiplicative 0 8
public export v_lebesze2ltet : HuWord
v_lebesze2ltet = MkHu "lebeszéltet" "lebeszél" MorphismRole Multiplicative 0 11
public export v_lebzsel : HuWord
v_lebzsel = MkHu "lebzsel" "lebzsel" MorphismRole Multiplicative 0 7
public export v_lecsavarodik : HuWord
v_lecsavarodik = MkHu "lecsavarodik" "lecsavarodi" MorphismRole Multiplicative 4 12
public export v_lecsillapodik : HuWord
v_lecsillapodik = MkHu "lecsillapodik" "lecsillapodi" MorphismRole Multiplicative 4 13
public export v_lecsillapi2t : HuWord
v_lecsillapi2t = MkHu "lecsillapít" "lecsillapí" MorphismRole Multiplicative 2 11
public export v_lecsillapi2ttat : HuWord
v_lecsillapi2ttat = MkHu "lecsillapíttat" "lecsillapí" MorphismRole Multiplicative 10 14
public export v_ledo3f : HuWord
v_ledo3f = MkHu "ledöf" "ledöf" MorphismRole Multiplicative 0 5
public export v_leelo4z : HuWord
v_leelo4z = MkHu "leelőz" "leelőz" MorphismRole Multiplicative 0 6
public export v_lefordi2t : HuWord
v_lefordi2t = MkHu "lefordít" "lefordí" MorphismRole Multiplicative 2 8
public export v_lefordi2ttat : HuWord
v_lefordi2ttat = MkHu "lefordíttat" "lefordí" MorphismRole Multiplicative 10 11
public export v_legyez : HuWord
v_legyez = MkHu "legyez" "legyez" MorphismRole Multiplicative 0 6
public export v_lehagy : HuWord
v_lehagy = MkHu "lehagy" "lehagy" MorphismRole Additive 0 6
public export v_lehagyat : HuWord
v_lehagyat = MkHu "lehagyat" "lehagy" MorphismRole Additive 2 8
public export v_leke2sik : HuWord
v_leke2sik = MkHu "lekésik" "lekési" MorphismRole Multiplicative 4 7
public export v_lelkesedik : HuWord
v_lelkesedik = MkHu "lelkesedik" "lelkesedi" MorphismRole Multiplicative 4 10
public export v_lelkesi2t : HuWord
v_lelkesi2t = MkHu "lelkesít" "lelkesí" MorphismRole Multiplicative 2 8
public export v_lemeru3l : HuWord
v_lemeru3l = MkHu "lemerül" "lemerül" MorphismRole Multiplicative 0 7
public export v_lenget : HuWord
v_lenget = MkHu "lenget" "leng" MorphismRole Multiplicative 2 6
public export v_lepa2rlo2dik : HuWord
v_lepa2rlo2dik = MkHu "lepárlódik" "lepárlódi" MorphismRole Multiplicative 4 10
public export v_lepa2rol : HuWord
v_lepa2rol = MkHu "lepárol" "lepárol" MorphismRole Additive 0 7
public export v_lepa2roltat : HuWord
v_lepa2roltat = MkHu "lepároltat" "lepárol" MorphismRole Additive 0 10
public export v_leszaki2t : HuWord
v_leszaki2t = MkHu "leszakít" "leszakí" MorphismRole Multiplicative 2 8
public export v_leszaki2ttat : HuWord
v_leszaki2ttat = MkHu "leszakíttat" "leszakí" MorphismRole Multiplicative 10 11
public export v_leszaki2ta2s : HuWord
v_leszaki2ta2s = MkHu "leszakítás" "leszakítás" MorphismRole Additive 0 10
public export v_leszed : HuWord
v_leszed = MkHu "leszed" "lesz" MorphismRole Multiplicative 32 6
public export v_leszedet : HuWord
v_leszedet = MkHu "leszedet" "lesz" MorphismRole Multiplicative 34 8
public export v_leszede2s : HuWord
v_leszede2s = MkHu "leszedés" "leszedés" MorphismRole Multiplicative 0 8
public export v_leszokik : HuWord
v_leszokik = MkHu "leszokik" "leszoki" MorphismRole Multiplicative 4 8
public export v_leszoktat : HuWord
v_leszoktat = MkHu "leszoktat" "leszok" MorphismRole Additive 0 9
public export v_lete2r : HuWord
v_lete2r = MkHu "letér" "letér" MorphismRole Multiplicative 0 5
public export v_leza2r : HuWord
v_leza2r = MkHu "lezár" "lezár" MorphismRole Additive 0 5
public export v_lezu3llik : HuWord
v_lezu3llik = MkHu "lezüllik" "lezülli" MorphismRole Multiplicative 4 8
public export v_lovagol : HuWord
v_lovagol = MkHu "lovagol" "lovagol" MorphismRole Additive 0 7
public export v_lusta2lkodik : HuWord
v_lusta2lkodik = MkHu "lustálkodik" "lustálkodi" MorphismRole Multiplicative 4 11
public export v_la2t : HuWord
v_la2t = MkHu "lát" "lát" MorphismRole Additive 0 3
public export v_la2tszik : HuWord
v_la2tszik = MkHu "látszik" "látszi" MorphismRole Multiplicative 4 7
public export v_la2zad : HuWord
v_la2zad = MkHu "lázad" "lázad" MorphismRole Additive 0 5
public export v_la2zi2t : HuWord
v_la2zi2t = MkHu "lázít" "lází" MorphismRole Multiplicative 2 5
public export v_maga2nosi2t : HuWord
v_maga2nosi2t = MkHu "magánosít" "magánosí" MorphismRole Multiplicative 2 9
public export v_makacskodik : HuWord
v_makacskodik = MkHu "makacskodik" "makacskodi" MorphismRole Multiplicative 4 11
public export v_malackodik : HuWord
v_malackodik = MkHu "malackodik" "malackodi" MorphismRole Multiplicative 4 10
public export v_megalvad : HuWord
v_megalvad = MkHu "megalvad" "megalvad" MorphismRole Additive 0 8
public export v_megalvaszt : HuWord
v_megalvaszt = MkHu "megalvaszt" "megalvasz" MorphismRole Additive 2 10
public export v_megbetegszik : HuWord
v_megbetegszik = MkHu "megbetegszik" "megbetegszi" MorphismRole Multiplicative 4 12
public export v_megbilincsel : HuWord
v_megbilincsel = MkHu "megbilincsel" "megbilincsel" MorphismRole Multiplicative 0 12
public export v_megbocsa2t : HuWord
v_megbocsa2t = MkHu "megbocsát" "megbocsá" MorphismRole Additive 2 9
public export v_megbotlik : HuWord
v_megbotlik = MkHu "megbotlik" "megbotli" MorphismRole Multiplicative 4 9
public export v_megbe2ke2l : HuWord
v_megbe2ke2l = MkHu "megbékél" "megbékél" MorphismRole Multiplicative 0 8
public export v_megcsal : HuWord
v_megcsal = MkHu "megcsal" "megcsal" MorphismRole Additive 0 7
public export v_megdagad : HuWord
v_megdagad = MkHu "megdagad" "megdagad" MorphismRole Additive 0 8
public export v_megdermed : HuWord
v_megdermed = MkHu "megdermed" "megderm" MorphismRole Multiplicative 32 9
public export v_megdo3f : HuWord
v_megdo3f = MkHu "megdöf" "megdöf" MorphismRole Multiplicative 0 6
public export v_megdo4l : HuWord
v_megdo4l = MkHu "megdől" "megdől" MorphismRole Multiplicative 0 6
public export v_megele2gel : HuWord
v_megele2gel = MkHu "megelégel" "megelégel" MorphismRole Multiplicative 0 9
public export v_megelo4z : HuWord
v_megelo4z = MkHu "megelőz" "megelőz" MorphismRole Multiplicative 0 7
public export v_megelo4ztet : HuWord
v_megelo4ztet = MkHu "megelőztet" "megelőz" MorphismRole Multiplicative 0 10
public export v_megfakul : HuWord
v_megfakul = MkHu "megfakul" "megfakul" MorphismRole Additive 0 8
public export v_megfigyel : HuWord
v_megfigyel = MkHu "megfigyel" "megfigyel" MorphismRole Multiplicative 0 9
public export v_megfizet : HuWord
v_megfizet = MkHu "megfizet" "megfiz" MorphismRole Multiplicative 2 8
public export v_megfizettet : HuWord
v_megfizettet = MkHu "megfizettet" "megfize" MorphismRole Multiplicative 10 11
public export v_megfogad : HuWord
v_megfogad = MkHu "megfogad" "megfogad" MorphismRole Additive 0 8
public export v_megfordul : HuWord
v_megfordul = MkHu "megfordul" "megfordul" MorphismRole Additive 0 9
public export v_megfordi2t : HuWord
v_megfordi2t = MkHu "megfordít" "megfordí" MorphismRole Multiplicative 2 9
public export v_megfordi2ttat : HuWord
v_megfordi2ttat = MkHu "megfordíttat" "megfordí" MorphismRole Multiplicative 10 12
public export v_meggazdagodik : HuWord
v_meggazdagodik = MkHu "meggazdagodik" "meggazdagodi" MorphismRole Multiplicative 4 13
public export v_meggazdagszik : HuWord
v_meggazdagszik = MkHu "meggazdagszik" "meggazdagszi" MorphismRole Multiplicative 4 13
public export v_meggombostu4z : HuWord
v_meggombostu4z = MkHu "meggombostűz" "meggombostűz" MorphismRole Multiplicative 0 12
public export v_meggyullad : HuWord
v_meggyullad = MkHu "meggyullad" "meggyullad" MorphismRole Additive 0 10
public export v_meggyo2gyul : HuWord
v_meggyo2gyul = MkHu "meggyógyul" "meggyógyul" MorphismRole Additive 0 10
public export v_meggyu2jtat : HuWord
v_meggyu2jtat = MkHu "meggyújtat" "meggyú" MorphismRole Additive 16 10
public export v_meghal : HuWord
v_meghal = MkHu "meghal" "meghal" MorphismRole Additive 0 6
public export v_meghalad : HuWord
v_meghalad = MkHu "meghalad" "meghalad" MorphismRole Additive 0 8
public export v_meghaladtat : HuWord
v_meghaladtat = MkHu "meghaladtat" "meghalad" MorphismRole Additive 0 11
public export v_megho3kkent : HuWord
v_megho3kkent = MkHu "meghökkent" "meghökke" MorphismRole Multiplicative 3 10
public export v_megismertet : HuWord
v_megismertet = MkHu "megismertet" "megismer" MorphismRole Multiplicative 0 11
public export v_megjelenik : HuWord
v_megjelenik = MkHu "megjelenik" "megjeleni" MorphismRole Multiplicative 4 10
public export v_megjo2sol : HuWord
v_megjo2sol = MkHu "megjósol" "megjósol" MorphismRole Additive 0 8
public export v_megko3to3z : HuWord
v_megko3to3z = MkHu "megkötöz" "megkötöz" MorphismRole Multiplicative 0 8
public export v_meglep : HuWord
v_meglep = MkHu "meglep" "meglep" MorphismRole Multiplicative 0 6
public export v_meglepo4dik : HuWord
v_meglepo4dik = MkHu "meglepődik" "meglepődi" MorphismRole Multiplicative 4 10
public export v_megla2ncol : HuWord
v_megla2ncol = MkHu "megláncol" "megláncol" MorphismRole Additive 0 9
public export v_megla2t : HuWord
v_megla2t = MkHu "meglát" "meglá" MorphismRole Additive 2 6
public export v_megmeru3l : HuWord
v_megmeru3l = MkHu "megmerül" "megmerül" MorphismRole Multiplicative 0 8
public export v_megmutat : HuWord
v_megmutat = MkHu "megmutat" "megmu" MorphismRole Additive 0 8
public export v_megmutattat : HuWord
v_megmutattat = MkHu "megmutattat" "megmuta" MorphismRole Additive 10 11
public export v_megnyugszik : HuWord
v_megnyugszik = MkHu "megnyugszik" "megnyugszi" MorphismRole Multiplicative 4 11
public export v_megnyugtat : HuWord
v_megnyugtat = MkHu "megnyugtat" "megnyug" MorphismRole Additive 0 10
public export v_megnyugtattat : HuWord
v_megnyugtattat = MkHu "megnyugtattat" "megnyugta" MorphismRole Additive 10 13
public export v_megne2mul : HuWord
v_megne2mul = MkHu "megnémul" "megnémul" MorphismRole Additive 0 8
public export v_megno3vekszik : HuWord
v_megno3vekszik = MkHu "megnövekszik" "megnövekszi" MorphismRole Multiplicative 4 12
public export v_megpene2szedik : HuWord
v_megpene2szedik = MkHu "megpenészedik" "megpenészedi" MorphismRole Multiplicative 4 13
public export v_megriaszt : HuWord
v_megriaszt = MkHu "megriaszt" "megriasz" MorphismRole Additive 2 9
public export v_megsokasodik : HuWord
v_megsokasodik = MkHu "megsokasodik" "megsokasodi" MorphismRole Multiplicative 4 12
public export v_megszid : HuWord
v_megszid = MkHu "megszid" "megszid" MorphismRole Multiplicative 0 7
public export v_megszokik : HuWord
v_megszokik = MkHu "megszokik" "megszoki" MorphismRole Multiplicative 4 9
public export v_megsze2di2t : HuWord
v_megsze2di2t = MkHu "megszédít" "megszédí" MorphismRole Multiplicative 2 9
public export v_megszo3kik : HuWord
v_megszo3kik = MkHu "megszökik" "megszöki" MorphismRole Multiplicative 4 9
public export v_megszu2r : HuWord
v_megszu2r = MkHu "megszúr" "megszúr" MorphismRole Additive 0 7
public export v_megtold : HuWord
v_megtold = MkHu "megtold" "megtold" MorphismRole Additive 0 7
public export v_megtoldat : HuWord
v_megtoldat = MkHu "megtoldat" "megtold" MorphismRole Additive 2 9
public export v_megun : HuWord
v_megun = MkHu "megun" "megu" MorphismRole Additive 1 5
public export v_megvalo2sul : HuWord
v_megvalo2sul = MkHu "megvalósul" "megvalósul" MorphismRole Additive 0 10
public export v_megvalo2si2t : HuWord
v_megvalo2si2t = MkHu "megvalósít" "megvalósí" MorphismRole Multiplicative 2 10
public export v_megvalo2si2ttat : HuWord
v_megvalo2si2ttat = MkHu "megvalósíttat" "megvalósí" MorphismRole Multiplicative 10 13
public export v_megvigasztalo2dik : HuWord
v_megvigasztalo2dik = MkHu "megvigasztalódik" "megvigasztalódi" MorphismRole Multiplicative 4 16
public export v_megvizsga2ltatja : HuWord
v_megvizsga2ltatja = MkHu "megvizsgáltatja" "megvizsgálta" MorphismRole Additive 34 15
public export v_megva2dol : HuWord
v_megva2dol = MkHu "megvádol" "megvádol" MorphismRole Additive 0 8
public export v_megva2laszt : HuWord
v_megva2laszt = MkHu "megválaszt" "megválasz" MorphismRole Additive 2 10
public export v_megva2lasztat : HuWord
v_megva2lasztat = MkHu "megválasztat" "megválasz" MorphismRole Additive 0 12
public export v_megzavarodik : HuWord
v_megzavarodik = MkHu "megzavarodik" "megzavarodi" MorphismRole Multiplicative 4 12
public export v_mega2ld : HuWord
v_mega2ld = MkHu "megáld" "megáld" MorphismRole Additive 0 6
public export v_mega2tkoz : HuWord
v_mega2tkoz = MkHu "megátkoz" "megátkoz" MorphismRole Additive 0 8
public export v_mege2hezik : HuWord
v_mege2hezik = MkHu "megéhezik" "megéhezi" MorphismRole Multiplicative 4 9
public export v_mege2rt : HuWord
v_mege2rt = MkHu "megért" "meg" MorphismRole Multiplicative 1 6
public export v_megi2ge2r : HuWord
v_megi2ge2r = MkHu "megígér" "megígér" MorphismRole Multiplicative 0 7
public export v_mego3l : HuWord
v_mego3l = MkHu "megöl" "megöl" MorphismRole Multiplicative 0 5
public export v_mego3let : HuWord
v_mego3let = MkHu "megölet" "megöl" MorphismRole Multiplicative 2 7
public export v_mer : HuWord
v_mer = MkHu "mer" "mer" MorphismRole Multiplicative 0 3
public export v_mered : HuWord
v_mered = MkHu "mered" "mer" MorphismRole Multiplicative 32 5
public export v_mere2sz : HuWord
v_mere2sz = MkHu "merész" "merész" MorphismRole Multiplicative 0 6
public export v_meszel : HuWord
v_meszel = MkHu "meszel" "meszel" MorphismRole Multiplicative 0 6
public export v_meszeltet : HuWord
v_meszeltet = MkHu "meszeltet" "meszel" MorphismRole Multiplicative 0 9
public export v_moho2 : HuWord
v_moho2 = MkHu "mohó" "mohó" MorphismRole Additive 0 4
public export v_mormol : HuWord
v_mormol = MkHu "mormol" "mormol" MorphismRole Additive 0 6
public export v_morog : HuWord
v_morog = MkHu "morog" "morog" MorphismRole Additive 0 5
public export v_motyog : HuWord
v_motyog = MkHu "motyog" "motyog" MorphismRole Additive 0 6
public export v_mutatkozik : HuWord
v_mutatkozik = MkHu "mutatkozik" "mutatkozi" MorphismRole Multiplicative 4 10
public export v_me2rgelo4dik : HuWord
v_me2rgelo4dik = MkHu "mérgelődik" "mérgelődi" MorphismRole Multiplicative 4 10
public export v_nagyke2pu4sko3dik : HuWord
v_nagyke2pu4sko3dik = MkHu "nagyképűsködik" "nagyképűsködi" MorphismRole Multiplicative 4 14
public export v_nagyobbodik : HuWord
v_nagyobbodik = MkHu "nagyobbodik" "nagyobbodi" MorphismRole Multiplicative 4 11
public export v_nagyzol : HuWord
v_nagyzol = MkHu "nagyzol" "nagyzol" MorphismRole Additive 0 7
public export v_nagyi2t : HuWord
v_nagyi2t = MkHu "nagyít" "nagyí" MorphismRole Multiplicative 2 6
public export v_nagyi2tani : HuWord
v_nagyi2tani = MkHu "nagyítani" "nagyíta" MorphismRole Additive 8 9
public export v_nekikezd : HuWord
v_nekikezd = MkHu "nekikezd" "nekikezd" MorphismRole Multiplicative 0 8
public export v_nevel : HuWord
v_nevel = MkHu "nevel" "nevel" MorphismRole Multiplicative 0 5
public export v_neveltet : HuWord
v_neveltet = MkHu "neveltet" "nevel" MorphismRole Multiplicative 0 8
public export v_nevelo4dik : HuWord
v_nevelo4dik = MkHu "nevelődik" "nevelődi" MorphismRole Multiplicative 4 9
public export v_nyafog : HuWord
v_nyafog = MkHu "nyafog" "nyafog" MorphismRole Additive 0 6
public export v_nyugtalankodik : HuWord
v_nyugtalankodik = MkHu "nyugtalankodik" "nyugtalankodi" MorphismRole Multiplicative 4 14
public export v_nyugtalani2t : HuWord
v_nyugtalani2t = MkHu "nyugtalanít" "nyugtalaní" MorphismRole Multiplicative 2 11
public export v_nyugtalani2ttat : HuWord
v_nyugtalani2ttat = MkHu "nyugtalaníttat" "nyugtalaní" MorphismRole Multiplicative 10 14
public export v_nyu3zso3g : HuWord
v_nyu3zso3g = MkHu "nyüzsög" "nyüzsög" MorphismRole Multiplicative 0 7
public export v_ne2z : HuWord
v_ne2z = MkHu "néz" "néz" MorphismRole Multiplicative 0 3
public export v_no3vekszik : HuWord
v_no3vekszik = MkHu "növekszik" "növekszi" MorphismRole Multiplicative 4 9
public export v_no4l : HuWord
v_no4l = MkHu "nől" "nől" MorphismRole Multiplicative 0 3
public export v_okol : HuWord
v_okol = MkHu "okol" "okol" MorphismRole Additive 0 4
public export v_pajkoskodik : HuWord
v_pajkoskodik = MkHu "pajkoskodik" "pajkoskodi" MorphismRole Multiplicative 4 11
public export v_paku4jkoskodik : HuWord
v_paku4jkoskodik = MkHu "pakűjkoskodik" "pakűjkoskodi" MorphismRole Multiplicative 4 13
public export v_parancsol : HuWord
v_parancsol = MkHu "parancsol" "parancsol" MorphismRole Additive 0 9
public export v_parancsoltat : HuWord
v_parancsoltat = MkHu "parancsoltat" "parancsol" MorphismRole Additive 0 12
public export v_para2zna2lkodik : HuWord
v_para2zna2lkodik = MkHu "paráználkodik" "paráználkodi" MorphismRole Multiplicative 4 13
public export v_pelenka2z : HuWord
v_pelenka2z = MkHu "pelenkáz" "pelenkáz" MorphismRole Additive 0 8
public export v_pelenka2ztat : HuWord
v_pelenka2ztat = MkHu "pelenkáztat" "pelenkáz" MorphismRole Additive 0 11
public export v_pitypalattyol : HuWord
v_pitypalattyol = MkHu "pitypalattyol" "pitypalattyol" MorphismRole Additive 0 13
public export v_porlad : HuWord
v_porlad = MkHu "porlad" "porlad" MorphismRole Additive 0 6
public export v_poroszka2l : HuWord
v_poroszka2l = MkHu "poroszkál" "poroszkál" MorphismRole Additive 0 9
public export v_privatiza2l : HuWord
v_privatiza2l = MkHu "privatizál" "privatizál" MorphismRole Additive 0 10
public export v_pa2rol : HuWord
v_pa2rol = MkHu "párol" "párol" MorphismRole Additive 0 5
public export v_pa2roztat : HuWord
v_pa2roztat = MkHu "pároztat" "pároz" MorphismRole Additive 0 8
public export v_pa2rzik : HuWord
v_pa2rzik = MkHu "párzik" "párzi" MorphismRole Multiplicative 4 6
public export v_po2lya2l : HuWord
v_po2lya2l = MkHu "pólyál" "pólyál" MorphismRole Additive 0 6
public export v_ragyog : HuWord
v_ragyog = MkHu "ragyog" "ragyog" MorphismRole Additive 0 6
public export v_rajong : HuWord
v_rajong = MkHu "rajong" "rajong" MorphismRole Additive 0 6
public export v_reme2nykedik : HuWord
v_reme2nykedik = MkHu "reménykedik" "reménykedi" MorphismRole Multiplicative 4 11
public export v_ra2besze2l : HuWord
v_ra2besze2l = MkHu "rábeszél" "rábeszél" MorphismRole Multiplicative 0 8
public export v_ra2besze2ltet : HuWord
v_ra2besze2ltet = MkHu "rábeszéltet" "rábeszél" MorphismRole Multiplicative 0 11
public export v_ra2csavarodik : HuWord
v_ra2csavarodik = MkHu "rácsavarodik" "rácsavarodi" MorphismRole Multiplicative 4 12
public export v_ra2teker : HuWord
v_ra2teker = MkHu "ráteker" "ráteker" MorphismRole Multiplicative 0 7
public export v_ra2tekeredik : HuWord
v_ra2tekeredik = MkHu "rátekeredik" "rátekeredi" MorphismRole Multiplicative 4 11
public export v_ra2tekertet : HuWord
v_ra2tekertet = MkHu "rátekertet" "ráteker" MorphismRole Multiplicative 0 10
public export v_ra2vesz : HuWord
v_ra2vesz = MkHu "rávesz" "rávesz" MorphismRole Multiplicative 0 6
public export v_ru3gyezik : HuWord
v_ru3gyezik = MkHu "rügyezik" "rügyezi" MorphismRole Multiplicative 4 8
public export v_segi2t : HuWord
v_segi2t = MkHu "segít" "segí" MorphismRole Multiplicative 2 5
public export v_siki2t : HuWord
v_siki2t = MkHu "sikít" "sikí" MorphismRole Multiplicative 2 5
public export v_spriccel : HuWord
v_spriccel = MkHu "spriccel" "spriccel" MorphismRole Multiplicative 0 8
public export v_szed : HuWord
v_szed = MkHu "szed" "szed" MorphismRole Multiplicative 0 4
public export v_szedet : HuWord
v_szedet = MkHu "szedet" "szed" MorphismRole Multiplicative 2 6
public export v_szede2s : HuWord
v_szede2s = MkHu "szedés" "szedés" MorphismRole Multiplicative 0 6
public export v_szemtelenkedik : HuWord
v_szemtelenkedik = MkHu "szemtelenkedik" "szemtelenkedi" MorphismRole Multiplicative 4 14
public export v_szenved : HuWord
v_szenved = MkHu "szenved" "szenv" MorphismRole Multiplicative 32 7
public export v_szenvede2lyeskedik : HuWord
v_szenvede2lyeskedik = MkHu "szenvedélyeskedik" "szenvedélyeskedi" MorphismRole Multiplicative 4 17
public export v_szerez : HuWord
v_szerez = MkHu "szerez" "szerez" MorphismRole Multiplicative 0 6
public export v_szereztet : HuWord
v_szereztet = MkHu "szereztet" "szerez" MorphismRole Multiplicative 0 9
public export v_szerteha2ny : HuWord
v_szerteha2ny = MkHu "szertehány" "szertehány" MorphismRole Additive 0 10
public export v_szesze2lyeskedik : HuWord
v_szesze2lyeskedik = MkHu "szeszélyeskedik" "szeszélyeskedi" MorphismRole Multiplicative 4 15
public export v_szesze2lyeskedtet : HuWord
v_szesze2lyeskedtet = MkHu "szeszélyeskedtet" "szeszélyesked" MorphismRole Multiplicative 0 16
public export v_szexel : HuWord
v_szexel = MkHu "szexel" "szexel" MorphismRole Multiplicative 0 6
public export v_szid : HuWord
v_szid = MkHu "szid" "szid" MorphismRole Multiplicative 0 4
public export v_szikra2zik : HuWord
v_szikra2zik = MkHu "szikrázik" "szikrázi" MorphismRole Multiplicative 4 9
public export v_szimula2l : HuWord
v_szimula2l = MkHu "szimulál" "szimulál" MorphismRole Additive 0 8
public export v_szipog : HuWord
v_szipog = MkHu "szipog" "szipog" MorphismRole Additive 0 6
public export v_sztra2jkol : HuWord
v_sztra2jkol = MkHu "sztrájkol" "sztrájkol" MorphismRole Additive 0 9
public export v_sze2du3l : HuWord
v_sze2du3l = MkHu "szédül" "szédül" MorphismRole Multiplicative 0 6
public export v_sze2kel : HuWord
v_sze2kel = MkHu "székel" "székel" MorphismRole Multiplicative 0 6
public export v_sze2tfoszlat : HuWord
v_sze2tfoszlat = MkHu "szétfoszlat" "szétfoszl" MorphismRole Additive 2 11
public export v_sze2tfoszlik : HuWord
v_sze2tfoszlik = MkHu "szétfoszlik" "szétfoszli" MorphismRole Multiplicative 4 11
public export v_sze2tku3rto3l : HuWord
v_sze2tku3rto3l = MkHu "szétkürtöl" "szétkürtöl" MorphismRole Multiplicative 0 10
public export v_sze2tmar : HuWord
v_sze2tmar = MkHu "szétmar" "szétmar" MorphismRole Additive 0 7
public export v_sze2trombol : HuWord
v_sze2trombol = MkHu "szétrombol" "szétrombol" MorphismRole Additive 0 10
public export v_sze2trongyol : HuWord
v_sze2trongyol = MkHu "szétrongyol" "szétrongyol" MorphismRole Additive 0 11
public export v_sze2trongyolo2dik : HuWord
v_sze2trongyolo2dik = MkHu "szétrongyolódik" "szétrongyolódi" MorphismRole Multiplicative 4 15
public export v_sze2tszo2r : HuWord
v_sze2tszo2r = MkHu "szétszór" "szétszór" MorphismRole Additive 0 8
public export v_sze2tte2p : HuWord
v_sze2tte2p = MkHu "széttép" "széttép" MorphismRole Multiplicative 0 7
public export v_sze2tva2laszt : HuWord
v_sze2tva2laszt = MkHu "szétválaszt" "szétválasz" MorphismRole Additive 2 11
public export v_sze2tva2lasztat : HuWord
v_sze2tva2lasztat = MkHu "szétválasztat" "szétválasz" MorphismRole Additive 0 13
public export v_sze2tva2logat : HuWord
v_sze2tva2logat = MkHu "szétválogat" "szétválog" MorphismRole Additive 2 11
public export v_sze2tva2logattat : HuWord
v_sze2tva2logattat = MkHu "szétválogattat" "szétváloga" MorphismRole Additive 10 14
public export v_szi2nez : HuWord
v_szi2nez = MkHu "színez" "színez" MorphismRole Multiplicative 0 6
public export v_szi2neztet : HuWord
v_szi2neztet = MkHu "színeztet" "színez" MorphismRole Multiplicative 0 9
public export v_szu2r : HuWord
v_szu2r = MkHu "szúr" "szúr" MorphismRole Additive 0 4
public export v_si2rdoga2l : HuWord
v_si2rdoga2l = MkHu "sírdogál" "sírdogál" MorphismRole Additive 0 8
public export v_so2va2r : HuWord
v_so2va2r = MkHu "sóvár" "sóvár" MorphismRole Additive 0 5
public export v_su4ru4so3dik : HuWord
v_su4ru4so3dik = MkHu "sűrűsödik" "sűrűsödi" MorphismRole Multiplicative 4 9
public export v_tenye2szik : HuWord
v_tenye2szik = MkHu "tenyészik" "tenyészi" MorphismRole Multiplicative 4 9
public export v_tenye2szt : HuWord
v_tenye2szt = MkHu "tenyészt" "tenyész" MorphismRole Multiplicative 2 8
public export v_tenye2sztet : HuWord
v_tenye2sztet = MkHu "tenyésztet" "tenyész" MorphismRole Multiplicative 0 10
public export v_terem : HuWord
v_terem = MkHu "terem" "ter" MorphismRole Multiplicative 32 5
public export v_terjed : HuWord
v_terjed = MkHu "terjed" "ter" MorphismRole Multiplicative 48 6
public export v_terjeszt : HuWord
v_terjeszt = MkHu "terjeszt" "terjesz" MorphismRole Multiplicative 2 8
public export v_termeszt : HuWord
v_termeszt = MkHu "termeszt" "termesz" MorphismRole Multiplicative 2 8
public export v_termesztet : HuWord
v_termesztet = MkHu "termesztet" "termesz" MorphismRole Multiplicative 0 10
public export v_tervez : HuWord
v_tervez = MkHu "tervez" "tervez" MorphismRole Multiplicative 0 6
public export v_testesedik : HuWord
v_testesedik = MkHu "testesedik" "testesedi" MorphismRole Multiplicative 4 10
public export v_tettet : HuWord
v_tettet = MkHu "tettet" "tet" MorphismRole Multiplicative 0 6
public export v_tilt : HuWord
v_tilt = MkHu "tilt" "til" MorphismRole Multiplicative 2 4
public export v_tiltat : HuWord
v_tiltat = MkHu "tiltat" "til" MorphismRole Multiplicative 0 6
public export v_tolat : HuWord
v_tolat = MkHu "tolat" "tol" MorphismRole Additive 2 5
public export v_tolma2csol : HuWord
v_tolma2csol = MkHu "tolmácsol" "tolmácsol" MorphismRole Additive 0 9
public export v_tolma2csoltat : HuWord
v_tolma2csoltat = MkHu "tolmácsoltat" "tolmácsol" MorphismRole Additive 0 12
public export v_trombita2l : HuWord
v_trombita2l = MkHu "trombitál" "trombitál" MorphismRole Additive 0 9
public export v_tud : HuWord
v_tud = MkHu "tud" "tud" MorphismRole Additive 0 3
public export v_turka2l : HuWord
v_turka2l = MkHu "turkál" "turkál" MorphismRole Additive 0 6
public export v_ta2gi2t : HuWord
v_ta2gi2t = MkHu "tágít" "tágí" MorphismRole Multiplicative 2 5
public export v_ta2ncol : HuWord
v_ta2ncol = MkHu "táncol" "táncol" MorphismRole Additive 0 6
public export v_te2tlenkedik : HuWord
v_te2tlenkedik = MkHu "tétlenkedik" "tétlenkedi" MorphismRole Multiplicative 4 11
public export v_te2ved : HuWord
v_te2ved = MkHu "téved" "tév" MorphismRole Multiplicative 32 5
public export v_to3rekszik : HuWord
v_to3rekszik = MkHu "törekszik" "törekszi" MorphismRole Multiplicative 4 9
public export v_tu2loz : HuWord
v_tu2loz = MkHu "túloz" "túloz" MorphismRole Additive 0 5
public export v_tu2lsza2rnyal : HuWord
v_tu2lsza2rnyal = MkHu "túlszárnyal" "túlszárnyal" MorphismRole Additive 0 11
public export v_tu2ltesz : HuWord
v_tu2ltesz = MkHu "túltesz" "túltesz" MorphismRole Multiplicative 0 7
public export v_un : HuWord
v_un = MkHu "un" "un" MorphismRole Additive 0 2
public export v_untat : HuWord
v_untat = MkHu "untat" "unt" MorphismRole Additive 2 5
public export v_untattat : HuWord
v_untattat = MkHu "untattat" "unta" MorphismRole Additive 10 8
public export v_varr : HuWord
v_varr = MkHu "varr" "varr" MorphismRole Additive 0 4
public export v_varrat : HuWord
v_varrat = MkHu "varrat" "varr" MorphismRole Additive 2 6
public export v_varra2s : HuWord
v_varra2s = MkHu "varrás" "varrás" MorphismRole Additive 0 6
public export v_vara2zsol : HuWord
v_vara2zsol = MkHu "varázsol" "varázsol" MorphismRole Additive 0 8
public export v_vedlik : HuWord
v_vedlik = MkHu "vedlik" "vedli" MorphismRole Multiplicative 4 6
public export v_ver : HuWord
v_ver = MkHu "ver" "ver" MorphismRole Multiplicative 0 3
public export v_verejte2kezik : HuWord
v_verejte2kezik = MkHu "verejtékezik" "verejtékezi" MorphismRole Multiplicative 4 12
public export v_veszekszik : HuWord
v_veszekszik = MkHu "veszekszik" "veszekszi" MorphismRole Multiplicative 4 10
public export v_veszi2t : HuWord
v_veszi2t = MkHu "veszít" "veszí" MorphismRole Multiplicative 2 6
public export v_vet : HuWord
v_vet = MkHu "vet" "vet" MorphismRole Multiplicative 0 3
public export v_veti2tik : HuWord
v_veti2tik = MkHu "vetítik" "vetíti" MorphismRole Multiplicative 4 7
public export v_vezet : HuWord
v_vezet = MkHu "vezet" "vez" MorphismRole Multiplicative 2 5
public export v_vigasztal : HuWord
v_vigasztal = MkHu "vigasztal" "vigasztal" MorphismRole Additive 0 9
public export v_villog : HuWord
v_villog = MkHu "villog" "villog" MorphismRole Additive 0 6
public export v_visszaad : HuWord
v_visszaad = MkHu "visszaad" "visszaad" MorphismRole Additive 0 8
public export v_visszaadat : HuWord
v_visszaadat = MkHu "visszaadat" "visszaad" MorphismRole Additive 2 10
public export v_visszafizet : HuWord
v_visszafizet = MkHu "visszafizet" "visszafiz" MorphismRole Multiplicative 2 11
public export v_visszafizettet : HuWord
v_visszafizettet = MkHu "visszafizettet" "visszafize" MorphismRole Multiplicative 10 14
public export v_visszafordul : HuWord
v_visszafordul = MkHu "visszafordul" "visszafordul" MorphismRole Additive 0 12
public export v_visszafordi2t : HuWord
v_visszafordi2t = MkHu "visszafordít" "visszafordí" MorphismRole Multiplicative 2 12
public export v_visszahoz : HuWord
v_visszahoz = MkHu "visszahoz" "vissza" MorphismRole Additive 1 9
public export v_visszahozat : HuWord
v_visszahozat = MkHu "visszahozat" "visszahoz" MorphismRole Additive 2 11
public export v_visszamegy : HuWord
v_visszamegy = MkHu "visszamegy" "visszamegy" MorphismRole Multiplicative 0 10
public export v_visszatart : HuWord
v_visszatart = MkHu "visszatart" "visszatar" MorphismRole Additive 2 10
public export v_visszate2r : HuWord
v_visszate2r = MkHu "visszatér" "visszatér" MorphismRole Multiplicative 0 9
public export v_visza2lykodik : HuWord
v_visza2lykodik = MkHu "viszálykodik" "viszálykodi" MorphismRole Multiplicative 4 12
public export v_vitatkozik : HuWord
v_vitatkozik = MkHu "vitatkozik" "vitatkozi" MorphismRole Multiplicative 4 10
public export v_vite2zkedik : HuWord
v_vite2zkedik = MkHu "vitézkedik" "vitézkedi" MorphismRole Multiplicative 4 10
public export v_vontat : HuWord
v_vontat = MkHu "vontat" "von" MorphismRole Additive 0 6
public export v_va2jka2l : HuWord
v_va2jka2l = MkHu "vájkál" "vájkál" MorphismRole Additive 0 6
public export v_va2laszt : HuWord
v_va2laszt = MkHu "választ" "válasz" MorphismRole Additive 2 7
public export v_va2lasztat : HuWord
v_va2lasztat = MkHu "választat" "válasz" MorphismRole Additive 0 9
public export v_va2logat : HuWord
v_va2logat = MkHu "válogat" "válog" MorphismRole Additive 2 7
public export v_va2logattat : HuWord
v_va2logattat = MkHu "válogattat" "váloga" MorphismRole Additive 10 10
public export v_va2nyol : HuWord
v_va2nyol = MkHu "ványol" "ványol" MorphismRole Additive 0 6
public export v_va2sa2rla2s : HuWord
v_va2sa2rla2s = MkHu "vásárlás" "vásárlás" MorphismRole Additive 0 8
public export v_va2sa2rol : HuWord
v_va2sa2rol = MkHu "vásárol" "vásárol" MorphismRole Additive 0 7
public export v_va2sa2rolgat : HuWord
v_va2sa2rolgat = MkHu "vásárolgat" "vásárolg" MorphismRole Additive 2 10
public export v_va2sa2roltat : HuWord
v_va2sa2roltat = MkHu "vásároltat" "vásárol" MorphismRole Additive 0 10
public export v_ve2gzo4dik : HuWord
v_ve2gzo4dik = MkHu "végződik" "végződi" MorphismRole Multiplicative 4 8
public export v_zaklat : HuWord
v_zaklat = MkHu "zaklat" "zakl" MorphismRole Additive 2 6
public export v_zavar : HuWord
v_zavar = MkHu "zavar" "zavar" MorphismRole Additive 0 5
public export v_zendu3l : HuWord
v_zendu3l = MkHu "zendül" "zendül" MorphismRole Multiplicative 0 6
public export v_zubog : HuWord
v_zubog = MkHu "zubog" "zubog" MorphismRole Additive 0 5
public export v_zu2g : HuWord
v_zu2g = MkHu "zúg" "zúg" MorphismRole Additive 0 3
public export v_zu3mmo3g : HuWord
v_zu3mmo3g = MkHu "zümmög" "zümmög" MorphismRole Multiplicative 0 6
public export v_a2mul : HuWord
v_a2mul = MkHu "ámul" "ámul" MorphismRole Additive 0 4
public export v_a2mi2t : HuWord
v_a2mi2t = MkHu "ámít" "ámí" MorphismRole Multiplicative 2 4
public export v_a2ramlik : HuWord
v_a2ramlik = MkHu "áramlik" "áramli" MorphismRole Multiplicative 4 7
public export v_a2ramoltat : HuWord
v_a2ramoltat = MkHu "áramoltat" "áramol" MorphismRole Additive 0 9
public export v_a2si2t : HuWord
v_a2si2t = MkHu "ásít" "ásí" MorphismRole Multiplicative 2 4
public export v_a2si2tozik : HuWord
v_a2si2tozik = MkHu "ásítozik" "ásítozi" MorphismRole Multiplicative 4 8
public export v_a2tcsal : HuWord
v_a2tcsal = MkHu "átcsal" "átcsal" MorphismRole Additive 0 6
public export v_a2tcsalat : HuWord
v_a2tcsalat = MkHu "átcsalat" "átcsal" MorphismRole Additive 2 8
public export v_a2tcsa2bi2t : HuWord
v_a2tcsa2bi2t = MkHu "átcsábít" "átcsábí" MorphismRole Multiplicative 2 8
public export v_a2tcsa2bi2ttat : HuWord
v_a2tcsa2bi2ttat = MkHu "átcsábíttat" "átcsábí" MorphismRole Multiplicative 10 11
public export v_a2tfordul : HuWord
v_a2tfordul = MkHu "átfordul" "átfordul" MorphismRole Additive 0 8
public export v_a2tfordi2t : HuWord
v_a2tfordi2t = MkHu "átfordít" "átfordí" MorphismRole Multiplicative 2 8
public export v_a2tfordi2ttat : HuWord
v_a2tfordi2ttat = MkHu "átfordíttat" "átfordí" MorphismRole Multiplicative 10 11
public export v_a2tforgat : HuWord
v_a2tforgat = MkHu "átforgat" "átforg" MorphismRole Additive 2 8
public export v_a2tforgattat : HuWord
v_a2tforgattat = MkHu "átforgattat" "átforga" MorphismRole Additive 10 11
public export v_a2tlapa2tol : HuWord
v_a2tlapa2tol = MkHu "átlapátol" "átlapátol" MorphismRole Additive 0 9
public export v_a2tlapa2toltat : HuWord
v_a2tlapa2toltat = MkHu "átlapátoltat" "átlapátol" MorphismRole Additive 0 12
public export v_a2tszel : HuWord
v_a2tszel = MkHu "átszel" "átszel" MorphismRole Multiplicative 0 6
public export v_a2tvesz : HuWord
v_a2tvesz = MkHu "átvesz" "átvesz" MorphismRole Multiplicative 0 6
public export v_a2tva2ltozik : HuWord
v_a2tva2ltozik = MkHu "átváltozik" "átváltozi" MorphismRole Multiplicative 4 10
public export v_a2tva2ltoztat : HuWord
v_a2tva2ltoztat = MkHu "átváltoztat" "átváltoz" MorphismRole Additive 0 11
public export v_e2lesi2t : HuWord
v_e2lesi2t = MkHu "élesít" "élesí" MorphismRole Multiplicative 2 6
public export v_e2szrevesz : HuWord
v_e2szrevesz = MkHu "észrevesz" "észrevesz" MorphismRole Multiplicative 0 9
public export v_o2vakodik : HuWord
v_o2vakodik = MkHu "óvakodik" "óvakodi" MorphismRole Multiplicative 4 8
public export v_o2vatoskodik : HuWord
v_o2vatoskodik = MkHu "óvatoskodik" "óvatoskodi" MorphismRole Multiplicative 4 11
public export v_o3nfeju4sko3dik : HuWord
v_o3nfeju4sko3dik = MkHu "önfejűsködik" "önfejűsködi" MorphismRole Multiplicative 4 12
public export v_o3sszebara2tkozik : HuWord
v_o3sszebara2tkozik = MkHu "összebarátkozik" "összebarátkozi" MorphismRole Multiplicative 4 15
public export v_o3sszeborzolo2dik : HuWord
v_o3sszeborzolo2dik = MkHu "összeborzolódik" "összeborzolódi" MorphismRole Multiplicative 4 15
public export v_o3sszecsavar : HuWord
v_o3sszecsavar = MkHu "összecsavar" "összecsavar" MorphismRole Additive 0 11
public export v_o3sszecsavarodik : HuWord
v_o3sszecsavarodik = MkHu "összecsavarodik" "összecsavarodi" MorphismRole Multiplicative 4 15
public export v_o3sszefoglal : HuWord
v_o3sszefoglal = MkHu "összefoglal" "összefoglal" MorphismRole Additive 0 11
public export v_o3sszeforr : HuWord
v_o3sszeforr = MkHu "összeforr" "összeforr" MorphismRole Additive 0 9
public export v_o3sszego3ngyo3lo3dik : HuWord
v_o3sszego3ngyo3lo3dik = MkHu "összegöngyölödik" "összegöngyölödi" MorphismRole Multiplicative 4 16
public export v_o3sszego3ngyo3lo4dik : HuWord
v_o3sszego3ngyo3lo4dik = MkHu "összegöngyölődik" "összegöngyölődi" MorphismRole Multiplicative 4 16
public export v_o3sszego3nygyo3lo3dik : HuWord
v_o3sszego3nygyo3lo3dik = MkHu "összegönygyölödik" "összegönygyölödi" MorphismRole Multiplicative 4 17
public export v_o3sszehu2z : HuWord
v_o3sszehu2z = MkHu "összehúz" "összehúz" MorphismRole Additive 0 8
public export v_o3sszeismertet : HuWord
v_o3sszeismertet = MkHu "összeismertet" "összeismer" MorphismRole Multiplicative 0 13
public export v_o3sszekusza2lo2dik : HuWord
v_o3sszekusza2lo2dik = MkHu "összekuszálódik" "összekuszálódi" MorphismRole Multiplicative 4 15
public export v_o3sszeko2colo2dik : HuWord
v_o3sszeko2colo2dik = MkHu "összekócolódik" "összekócolódi" MorphismRole Multiplicative 4 14
public export v_o3sszeszed : HuWord
v_o3sszeszed = MkHu "összeszed" "összesz" MorphismRole Multiplicative 32 9
public export v_o3sszeszedet : HuWord
v_o3sszeszedet = MkHu "összeszedet" "összesz" MorphismRole Multiplicative 34 11
public export v_o3sszeszede2s : HuWord
v_o3sszeszede2s = MkHu "összeszedés" "összeszedés" MorphismRole Multiplicative 0 11
public export v_o3sszeteker : HuWord
v_o3sszeteker = MkHu "összeteker" "összeteker" MorphismRole Multiplicative 0 10
public export v_o3sszetekeredik : HuWord
v_o3sszetekeredik = MkHu "összetekeredik" "összetekeredi" MorphismRole Multiplicative 4 14
public export v_o3sszetekertet : HuWord
v_o3sszetekertet = MkHu "összetekertet" "összeteker" MorphismRole Multiplicative 0 13
public export v_o3sszeturka2l : HuWord
v_o3sszeturka2l = MkHu "összeturkál" "összeturkál" MorphismRole Additive 0 11
public export v_o3sszeturka2ltat : HuWord
v_o3sszeturka2ltat = MkHu "összeturkáltat" "összeturkál" MorphismRole Additive 0 14
public export v_o3sszezavarodik : HuWord
v_o3sszezavarodik = MkHu "összezavarodik" "összezavarodi" MorphismRole Multiplicative 4 14
public export v_o3szto3no3z : HuWord
v_o3szto3no3z = MkHu "ösztönöz" "ösztönöz" MorphismRole Multiplicative 0 8
public export v_u3ldo3z : HuWord
v_u3ldo3z = MkHu "üldöz" "üldöz" MorphismRole Multiplicative 0 5
public export v_u3vo3lt : HuWord
v_u3vo3lt = MkHu "üvölt" "üvöl" MorphismRole Multiplicative 2 5
public export v_u3ze2rkedik : HuWord
v_u3ze2rkedik = MkHu "üzérkedik" "üzérkedi" MorphismRole Multiplicative 4 9
public export a_abszolu2t : HuWord
a_abszolu2t = MkHu "abszolút" "abszolú" PropertyRole Additive 2 8
public export a_absztrakt : HuWord
a_absztrakt = MkHu "absztrakt" "absztrak" PropertyRole Additive 2 9
public export a_abszurd : HuWord
a_abszurd = MkHu "abszurd" "abszurd" PropertyRole Additive 0 7
public export a_acha2t : HuWord
a_acha2t = MkHu "achát" "achá" PropertyRole Additive 2 5
public export a_adminisztrati2v : HuWord
a_adminisztrati2v = MkHu "adminisztratív" "adminisztratív" PropertyRole Multiplicative 0 14
public export a_adminisztra2cio2s : HuWord
a_adminisztra2cio2s = MkHu "adminisztrációs" "adminisztrációs" PropertyRole Additive 0 15
public export a_adzsa2r : HuWord
a_adzsa2r = MkHu "adzsár" "adzsár" PropertyRole Additive 0 6
public export a_agita2cio2s : HuWord
a_agita2cio2s = MkHu "agitációs" "agitációs" PropertyRole Additive 0 9
public export a_agita2lo2 : HuWord
a_agita2lo2 = MkHu "agitáló" "agitáló" PropertyRole Additive 0 7
public export a_agresszi2v : HuWord
a_agresszi2v = MkHu "agresszív" "agresszív" PropertyRole Multiplicative 0 9
public export a_agra2r : HuWord
a_agra2r = MkHu "agrár" "agrár" PropertyRole Additive 0 5
public export a_akade2miai : HuWord
a_akade2miai = MkHu "akadémiai" "akadémiai" PropertyRole Multiplicative 0 9
public export a_akkredita2lt : HuWord
a_akkredita2lt = MkHu "akkreditált" "akkreditál" PropertyRole Additive 2 11
public export a_akrobatikus : HuWord
a_akrobatikus = MkHu "akrobatikus" "akrobatikus" PropertyRole Additive 0 11
public export a_aktua2lis : HuWord
a_aktua2lis = MkHu "aktuális" "aktuális" PropertyRole Multiplicative 0 8
public export a_akti2v : HuWord
a_akti2v = MkHu "aktív" "aktív" PropertyRole Multiplicative 0 5
public export a_alacsony : HuWord
a_alacsony = MkHu "alacsony" "alacsony" PropertyRole Additive 0 8
public export a_algebrai : HuWord
a_algebrai = MkHu "algebrai" "algebrai" PropertyRole Multiplicative 0 8
public export a_alkotma2nyos : HuWord
a_alkotma2nyos = MkHu "alkotmányos" "alkotmányos" PropertyRole Additive 0 11
public export a_alma2sszu3rke : HuWord
a_alma2sszu3rke = MkHu "almásszürke" "almásszürke" PropertyRole Multiplicative 0 11
public export a_amerikai : HuWord
a_amerikai = MkHu "amerikai" "amerikai" PropertyRole Multiplicative 0 8
public export a_analitikus : HuWord
a_analitikus = MkHu "analitikus" "analitikus" PropertyRole Additive 0 10
public export a_anato2miai : HuWord
a_anato2miai = MkHu "anatómiai" "anatómiai" PropertyRole Multiplicative 0 9
public export a_angol : HuWord
a_angol = MkHu "angol" "angol" PropertyRole Additive 0 5
public export a_antagonisztikus : HuWord
a_antagonisztikus = MkHu "antagonisztikus" "antagonisztikus" PropertyRole Additive 0 15
public export a_antik : HuWord
a_antik = MkHu "antik" "anti" PropertyRole Multiplicative 4 5
public export a_antikva2r : HuWord
a_antikva2r = MkHu "antikvár" "antikvár" PropertyRole Additive 0 8
public export a_anyai : HuWord
a_anyai = MkHu "anyai" "anyai" PropertyRole Multiplicative 0 5
public export a_anyasa2gi : HuWord
a_anyasa2gi = MkHu "anyasági" "anyasági" PropertyRole Multiplicative 0 8
public export a_anya2s : HuWord
a_anya2s = MkHu "anyás" "anyás" PropertyRole Additive 0 5
public export a_anya2tlan : HuWord
a_anya2tlan = MkHu "anyátlan" "anyátla" PropertyRole Additive 1 8
public export a_apa2tlan : HuWord
a_apa2tlan = MkHu "apátlan" "apátla" PropertyRole Additive 1 7
public export a_archi2v : HuWord
a_archi2v = MkHu "archív" "archív" PropertyRole Multiplicative 0 6
public export a_arca2tlan : HuWord
a_arca2tlan = MkHu "arcátlan" "arcátla" PropertyRole Additive 1 8
public export a_arcu2 : HuWord
a_arcu2 = MkHu "arcú" "arcú" PropertyRole Additive 0 4
public export a_arisztokratikus : HuWord
a_arisztokratikus = MkHu "arisztokratikus" "arisztokratikus" PropertyRole Additive 0 15
public export a_aritmetikus : HuWord
a_aritmetikus = MkHu "aritmetikus" "aritmetikus" PropertyRole Additive 0 11
public export a_arsinnyi : HuWord
a_arsinnyi = MkHu "arsinnyi" "arsinnyi" PropertyRole Multiplicative 0 8
public export a_arte2ria2s : HuWord
a_arte2ria2s = MkHu "artériás" "artériás" PropertyRole Additive 0 8
public export a_arte2zi : HuWord
a_arte2zi = MkHu "artézi" "artézi" PropertyRole Multiplicative 0 6
public export a_atomi : HuWord
a_atomi = MkHu "atomi" "atomi" PropertyRole Multiplicative 0 5
public export a_augusztusi : HuWord
a_augusztusi = MkHu "augusztusi" "augusztusi" PropertyRole Multiplicative 0 10
public export a_ausztriai : HuWord
a_ausztriai = MkHu "ausztriai" "ausztriai" PropertyRole Multiplicative 0 9
public export a_autoge2n : HuWord
a_autoge2n = MkHu "autogén" "autogé" PropertyRole Multiplicative 1 7
public export a_automatikus : HuWord
a_automatikus = MkHu "automatikus" "automatikus" PropertyRole Additive 0 11
public export a_autono2m : HuWord
a_autono2m = MkHu "autonóm" "autonóm" PropertyRole Additive 0 7
public export a_avantga2rd : HuWord
a_avantga2rd = MkHu "avantgárd" "avantgárd" PropertyRole Additive 0 9
public export a_avar : HuWord
a_avar = MkHu "avar" "avar" PropertyRole Additive 0 4
public export a_azerbajdzsa2n : HuWord
a_azerbajdzsa2n = MkHu "azerbajdzsán" "azerbajdzsá" PropertyRole Additive 1 12
public export a_barack : HuWord
a_barack = MkHu "barack" "barac" PropertyRole Additive 4 6
public export a_bara2tsa2gos : HuWord
a_bara2tsa2gos = MkHu "barátságos" "barátságos" PropertyRole Additive 0 10
public export a_bara2zda2s : HuWord
a_bara2zda2s = MkHu "barázdás" "barázdás" PropertyRole Additive 0 8
public export a_basszus : HuWord
a_basszus = MkHu "basszus" "basszus" PropertyRole Additive 0 7
public export a_behavazott : HuWord
a_behavazott = MkHu "behavazott" "behavazo" PropertyRole Additive 8 10
public export a_behomokozott : HuWord
a_behomokozott = MkHu "behomokozott" "behomokozo" PropertyRole Additive 8 12
public export a_beno4tt : HuWord
a_beno4tt = MkHu "benőtt" "benő" PropertyRole Multiplicative 8 6
public export a_besze2des : HuWord
a_besze2des = MkHu "beszédes" "beszédes" PropertyRole Multiplicative 0 8
public export a_besu2go2 : HuWord
a_besu2go2 = MkHu "besúgó" "besúgó" PropertyRole Additive 0 6
public export a_bibliai : HuWord
a_bibliai = MkHu "bibliai" "bibliai" PropertyRole Multiplicative 0 7
public export a_bicska : HuWord
a_bicska = MkHu "bicska" "bicska" PropertyRole Additive 0 6
public export a_billego4 : HuWord
a_billego4 = MkHu "billegő" "billegő" PropertyRole Multiplicative 0 7
public export a_biolo2giai : HuWord
a_biolo2giai = MkHu "biológiai" "biológiai" PropertyRole Multiplicative 0 9
public export a_bioszfe2rikus : HuWord
a_bioszfe2rikus = MkHu "bioszférikus" "bioszférikus" PropertyRole Additive 0 12
public export a_bodros : HuWord
a_bodros = MkHu "bodros" "bodros" PropertyRole Additive 0 6
public export a_bogaras : HuWord
a_bogaras = MkHu "bogaras" "bogaras" PropertyRole Additive 0 7
public export a_boldog : HuWord
a_boldog = MkHu "boldog" "boldog" PropertyRole Additive 0 6
public export a_bolond : HuWord
a_bolond = MkHu "bolond" "bolond" PropertyRole Additive 0 6
public export a_bolti : HuWord
a_bolti = MkHu "bolti" "bolti" PropertyRole Multiplicative 0 5
public export a_bordo2 : HuWord
a_bordo2 = MkHu "bordó" "bordó" PropertyRole Additive 0 5
public export a_bosszanto2 : HuWord
a_bosszanto2 = MkHu "bosszantó" "bosszantó" PropertyRole Additive 0 9
public export a_botos : HuWord
a_botos = MkHu "botos" "botos" PropertyRole Additive 0 5
public export a_burzsoa2 : HuWord
a_burzsoa2 = MkHu "burzsoá" "burzsoá" PropertyRole Additive 0 7
public export a_buta : HuWord
a_buta = MkHu "buta" "buta" PropertyRole Additive 0 4
public export a_ba2li : HuWord
a_ba2li = MkHu "báli" "báli" PropertyRole Multiplicative 0 4
public export a_ba2nto2 : HuWord
a_ba2nto2 = MkHu "bántó" "bántó" PropertyRole Additive 0 5
public export a_ba2rgyu2 : HuWord
a_ba2rgyu2 = MkHu "bárgyú" "bárgyú" PropertyRole Additive 0 6
public export a_ba2rsonyos : HuWord
a_ba2rsonyos = MkHu "bársonyos" "bársonyos" PropertyRole Additive 0 9
public export a_ba2tor : HuWord
a_ba2tor = MkHu "bátor" "bátor" PropertyRole Additive 0 5
public export a_bo3dros : HuWord
a_bo3dros = MkHu "bödros" "bödros" PropertyRole Additive 0 6
public export a_bo4 : HuWord
a_bo4 = MkHu "bő" "bő" PropertyRole Multiplicative 0 2
public export a_bo4besze2du4 : HuWord
a_bo4besze2du4 = MkHu "bőbeszédű" "bőbeszédű" PropertyRole Multiplicative 0 9
public export a_bo4se2ges : HuWord
a_bo4se2ges = MkHu "bőséges" "bőséges" PropertyRole Multiplicative 0 7
public export a_csendes : HuWord
a_csendes = MkHu "csendes" "csendes" PropertyRole Multiplicative 0 7
public export a_cseneve2sz : HuWord
a_cseneve2sz = MkHu "csenevész" "csenevész" PropertyRole Multiplicative 0 9
public export a_cserkesz : HuWord
a_cserkesz = MkHu "cserkesz" "cserkesz" PropertyRole Multiplicative 0 8
public export a_csibe2sz : HuWord
a_csibe2sz = MkHu "csibész" "csibész" PropertyRole Multiplicative 0 7
public export a_csillaga2szati : HuWord
a_csillaga2szati = MkHu "csillagászati" "csillagászati" PropertyRole Multiplicative 0 13
public export a_csi2kos : HuWord
a_csi2kos = MkHu "csíkos" "csíkos" PropertyRole Additive 0 6
public export a_csu2nya : HuWord
a_csu2nya = MkHu "csúnya" "csúnya" PropertyRole Additive 0 6
public export a_ci2m : HuWord
a_ci2m = MkHu "cím" "cím" PropertyRole Multiplicative 0 3
public export a_ci2mu4 : HuWord
a_ci2mu4 = MkHu "című" "című" PropertyRole Multiplicative 0 4
public export a_dadoga2s : HuWord
a_dadoga2s = MkHu "dadogás" "dadogás" PropertyRole Additive 0 7
public export a_dadogo2 : HuWord
a_dadogo2 = MkHu "dadogó" "dadogó" PropertyRole Additive 0 6
public export a_danda2r : HuWord
a_danda2r = MkHu "dandár" "dandár" PropertyRole Additive 0 6
public export a_deres : HuWord
a_deres = MkHu "deres" "deres" PropertyRole Multiplicative 0 5
public export a_dra2ga : HuWord
a_dra2ga = MkHu "drága" "drága" PropertyRole Additive 0 5
public export a_durva : HuWord
a_durva = MkHu "durva" "durva" PropertyRole Additive 0 5
public export a_duzzadt : HuWord
a_duzzadt = MkHu "duzzadt" "duzzad" PropertyRole Additive 2 7
public export a_do3lyfo3s : HuWord
a_do3lyfo3s = MkHu "dölyfös" "dölyfös" PropertyRole Multiplicative 0 7
public export a_egyedu3la2llo2 : HuWord
a_egyedu3la2llo2 = MkHu "egyedülálló" "egyedülálló" PropertyRole Additive 0 11
public export a_egyu3gyu4 : HuWord
a_egyu3gyu4 = MkHu "együgyű" "együgyű" PropertyRole Multiplicative 0 7
public export a_ege2sz : HuWord
a_ege2sz = MkHu "egész" "egész" PropertyRole Multiplicative 0 5
public export a_ege2szse2ges : HuWord
a_ege2szse2ges = MkHu "egészséges" "egészséges" PropertyRole Multiplicative 0 10
public export a_elfajult : HuWord
a_elfajult = MkHu "elfajult" "elfajul" PropertyRole Additive 2 8
public export a_elhagyatott : HuWord
a_elhagyatott = MkHu "elhagyatott" "elhagyato" PropertyRole Additive 8 11
public export a_ellenszenves : HuWord
a_ellenszenves = MkHu "ellenszenves" "ellenszenves" PropertyRole Multiplicative 0 12
public export a_elvadult : HuWord
a_elvadult = MkHu "elvadult" "elvadul" PropertyRole Additive 2 8
public export a_elveszett : HuWord
a_elveszett = MkHu "elveszett" "elvesze" PropertyRole Multiplicative 8 9
public export a_elvont : HuWord
a_elvont = MkHu "elvont" "elvo" PropertyRole Additive 3 6
public export a_elu3lso4 : HuWord
a_elu3lso4 = MkHu "elülső" "elülső" PropertyRole Multiplicative 0 6
public export a_elo4bbi : HuWord
a_elo4bbi = MkHu "előbbi" "előbbi" PropertyRole Multiplicative 0 6
public export a_emberi : HuWord
a_emberi = MkHu "emberi" "emberi" PropertyRole Multiplicative 0 6
public export a_epilepszia2s : HuWord
a_epilepszia2s = MkHu "epilepsziás" "epilepsziás" PropertyRole Additive 0 11
public export a_eredme2nyes : HuWord
a_eredme2nyes = MkHu "eredményes" "eredményes" PropertyRole Multiplicative 0 10
public export a_eredme2nytelen : HuWord
a_eredme2nytelen = MkHu "eredménytelen" "eredménytel" PropertyRole Multiplicative 1 13
public export a_ero4s : HuWord
a_ero4s = MkHu "erős" "erős" PropertyRole Multiplicative 0 4
public export a_ero4szakos : HuWord
a_ero4szakos = MkHu "erőszakos" "erőszakos" PropertyRole Additive 0 9
public export a_esetlen : HuWord
a_esetlen = MkHu "esetlen" "esetl" PropertyRole Multiplicative 1 7
public export a_eszes : HuWord
a_eszes = MkHu "eszes" "eszes" PropertyRole Multiplicative 0 5
public export a_ezu3st : HuWord
a_ezu3st = MkHu "ezüst" "ezüs" PropertyRole Multiplicative 2 5
public export a_fako2 : HuWord
a_fako2 = MkHu "fakó" "fakó" PropertyRole Additive 0 4
public export a_fala2nk : HuWord
a_fala2nk = MkHu "falánk" "falá" PropertyRole Additive 5 6
public export a_farkas : HuWord
a_farkas = MkHu "farkas" "farkas" PropertyRole Additive 0 6
public export a_farkatlan : HuWord
a_farkatlan = MkHu "farkatlan" "farkatla" PropertyRole Additive 1 9
public export a_farkcsonti : HuWord
a_farkcsonti = MkHu "farkcsonti" "farkcsonti" PropertyRole Multiplicative 0 10
public export a_farku2 : HuWord
a_farku2 = MkHu "farkú" "farkú" PropertyRole Additive 0 5
public export a_fecsego4 : HuWord
a_fecsego4 = MkHu "fecsegő" "fecsegő" PropertyRole Multiplicative 0 7
public export a_felesleges : HuWord
a_felesleges = MkHu "felesleges" "felesleges" PropertyRole Multiplicative 0 10
public export a_felno4tt : HuWord
a_felno4tt = MkHu "felnőtt" "felnő" PropertyRole Multiplicative 8 7
public export a_felso4 : HuWord
a_felso4 = MkHu "felső" "felső" PropertyRole Multiplicative 0 5
public export a_felte2tlen : HuWord
a_felte2tlen = MkHu "feltétlen" "feltétl" PropertyRole Multiplicative 1 9
public export a_fennko3lt : HuWord
a_fennko3lt = MkHu "fennkölt" "fennköl" PropertyRole Multiplicative 2 8
public export a_ferde : HuWord
a_ferde = MkHu "ferde" "ferde" PropertyRole Multiplicative 0 5
public export a_fiatal : HuWord
a_fiatal = MkHu "fiatal" "fiatal" PropertyRole Additive 0 6
public export a_foglalt : HuWord
a_foglalt = MkHu "foglalt" "foglal" PropertyRole Additive 2 7
public export a_fokozatos : HuWord
a_fokozatos = MkHu "fokozatos" "fokozatos" PropertyRole Additive 0 9
public export a_furfangos : HuWord
a_furfangos = MkHu "furfangos" "furfangos" PropertyRole Additive 0 9
public export a_fuo2lagos : HuWord
a_fuo2lagos = MkHu "fuólagos" "fuólagos" PropertyRole Additive 0 8
public export a_fe2lreeso4 : HuWord
a_fe2lreeso4 = MkHu "félreeső" "félreeső" PropertyRole Multiplicative 0 8
public export a_fe2lrevezeto4 : HuWord
a_fe2lrevezeto4 = MkHu "félrevezető" "félrevezető" PropertyRole Multiplicative 0 11
public export a_fu3ggetlen : HuWord
a_fu3ggetlen = MkHu "független" "függetl" PropertyRole Multiplicative 1 9
public export a_fu3lesbagoly : HuWord
a_fu3lesbagoly = MkHu "fülesbagoly" "fülesbagoly" PropertyRole Additive 0 11
public export a_fu3zes : HuWord
a_fu3zes = MkHu "füzes" "füzes" PropertyRole Multiplicative 0 5
public export a_fo4u2ri : HuWord
a_fo4u2ri = MkHu "főúri" "főúri" PropertyRole Multiplicative 0 5
public export a_gazdag : HuWord
a_gazdag = MkHu "gazdag" "gazdag" PropertyRole Additive 0 6
public export a_gazdasa2gtalan : HuWord
a_gazdasa2gtalan = MkHu "gazdaságtalan" "gazdaságtala" PropertyRole Additive 1 13
public export a_gombos : HuWord
a_gombos = MkHu "gombos" "gombos" PropertyRole Additive 0 6
public export a_gomolygo2 : HuWord
a_gomolygo2 = MkHu "gomolygó" "gomolygó" PropertyRole Additive 0 8
public export a_gonosz : HuWord
a_gonosz = MkHu "gonosz" "gonosz" PropertyRole Additive 0 6
public export a_gyarlo2 : HuWord
a_gyarlo2 = MkHu "gyarló" "gyarló" PropertyRole Additive 0 6
public export a_gyenge : HuWord
a_gyenge = MkHu "gyenge" "gyenge" PropertyRole Multiplicative 0 6
public export a_gyors : HuWord
a_gyors = MkHu "gyors" "gyors" PropertyRole Additive 0 5
public export a_gyulladt : HuWord
a_gyulladt = MkHu "gyulladt" "gyullad" PropertyRole Additive 2 8
public export a_gyo2gyerta2ri : HuWord
a_gyo2gyerta2ri = MkHu "gyógyertári" "gyógyertári" PropertyRole Multiplicative 0 11
public export a_gyu4lo3letes : HuWord
a_gyu4lo3letes = MkHu "gyűlöletes" "gyűlöletes" PropertyRole Multiplicative 0 10
public export a_go3mbo3lyu4 : HuWord
a_go3mbo3lyu4 = MkHu "gömbölyű" "gömbölyű" PropertyRole Multiplicative 0 8
public export a_go3ndo3r : HuWord
a_go3ndo3r = MkHu "göndör" "göndör" PropertyRole Multiplicative 0 6
public export a_go4go3s : HuWord
a_go4go3s = MkHu "gőgös" "gőgös" PropertyRole Multiplicative 0 5
public export a_hadi : HuWord
a_hadi = MkHu "hadi" "hadi" PropertyRole Multiplicative 0 4
public export a_hajle2ktalan : HuWord
a_hajle2ktalan = MkHu "hajléktalan" "hajléktala" PropertyRole Additive 1 11
public export a_halott : HuWord
a_halott = MkHu "halott" "halo" PropertyRole Additive 8 6
public export a_hangsu2lytalan : HuWord
a_hangsu2lytalan = MkHu "hangsúlytalan" "hangsúlytala" PropertyRole Additive 1 13
public export a_hanyag : HuWord
a_hanyag = MkHu "hanyag" "hanyag" PropertyRole Additive 0 6
public export a_harcias : HuWord
a_harcias = MkHu "harcias" "harcias" PropertyRole Additive 0 7
public export a_harckocsizo2 : HuWord
a_harckocsizo2 = MkHu "harckocsizó" "harckocsizó" PropertyRole Additive 0 11
public export a_harcos : HuWord
a_harcos = MkHu "harcos" "harcos" PropertyRole Additive 0 6
public export a_hasznos : HuWord
a_hasznos = MkHu "hasznos" "hasznos" PropertyRole Additive 0 7
public export a_haszontalan : HuWord
a_haszontalan = MkHu "haszontalan" "haszontala" PropertyRole Additive 1 11
public export a_hatalmas : HuWord
a_hatalmas = MkHu "hatalmas" "hatalmas" PropertyRole Additive 0 8
public export a_hebege2s : HuWord
a_hebege2s = MkHu "hebegés" "hebegés" PropertyRole Multiplicative 0 7
public export a_hebego4 : HuWord
a_hebego4 = MkHu "hebegő" "hebegő" PropertyRole Multiplicative 0 6
public export a_holnap : HuWord
a_holnap = MkHu "holnap" "holnap" PropertyRole Additive 0 6
public export a_holt : HuWord
a_holt = MkHu "holt" "hol" PropertyRole Additive 2 4
public export a_homoklepte : HuWord
a_homoklepte = MkHu "homoklepte" "homoklepte" PropertyRole Multiplicative 0 10
public export a_hozza2e2rto4 : HuWord
a_hozza2e2rto4 = MkHu "hozzáértő" "hozzáértő" PropertyRole Multiplicative 0 9
public export a_ha2la2s : HuWord
a_ha2la2s = MkHu "hálás" "hálás" PropertyRole Additive 0 5
public export a_ha2rsfa2s : HuWord
a_ha2rsfa2s = MkHu "hársfás" "hársfás" PropertyRole Additive 0 7
public export a_ha2tso2 : HuWord
a_ha2tso2 = MkHu "hátsó" "hátsó" PropertyRole Additive 0 5
public export a_ho2bortos : HuWord
a_ho2bortos = MkHu "hóbortos" "hóbortos" PropertyRole Additive 0 8
public export a_ho2lepte : HuWord
a_ho2lepte = MkHu "hólepte" "hólepte" PropertyRole Multiplicative 0 7
public export a_hu2sos : HuWord
a_hu2sos = MkHu "húsos" "húsos" PropertyRole Additive 0 5
public export a_hu2sve2ti : HuWord
a_hu2sve2ti = MkHu "húsvéti" "húsvéti" PropertyRole Multiplicative 0 7
public export a_ho4sies : HuWord
a_ho4sies = MkHu "hősies" "hősies" PropertyRole Multiplicative 0 6
public export a_ideges : HuWord
a_ideges = MkHu "ideges" "ideges" PropertyRole Multiplicative 0 6
public export a_idegesi2to4 : HuWord
a_idegesi2to4 = MkHu "idegesítő" "idegesítő" PropertyRole Multiplicative 0 9
public export a_ido4s : HuWord
a_ido4s = MkHu "idős" "idős" PropertyRole Multiplicative 0 4
public export a_igaz : HuWord
a_igaz = MkHu "igaz" "igaz" PropertyRole Additive 0 4
public export a_igazsa2gtalan : HuWord
a_igazsa2gtalan = MkHu "igazságtalan" "igazságtala" PropertyRole Additive 1 12
public export a_ige2nytelen : HuWord
a_ige2nytelen = MkHu "igénytelen" "igénytel" PropertyRole Multiplicative 1 10
public export a_indulatos : HuWord
a_indulatos = MkHu "indulatos" "indulatos" PropertyRole Additive 0 9
public export a_ingerle2keny : HuWord
a_ingerle2keny = MkHu "ingerlékeny" "ingerlékeny" PropertyRole Multiplicative 0 11
public export a_ingyenes : HuWord
a_ingyenes = MkHu "ingyenes" "ingyenes" PropertyRole Multiplicative 0 8
public export a_intelligens : HuWord
a_intelligens = MkHu "intelligens" "intelligens" PropertyRole Multiplicative 0 11
public export a_isteni : HuWord
a_isteni = MkHu "isteni" "iste" PropertyRole Multiplicative 8 6
public export a_izmos : HuWord
a_izmos = MkHu "izmos" "izmos" PropertyRole Additive 0 5
public export a_jelente2ktelen : HuWord
a_jelente2ktelen = MkHu "jelentéktelen" "jelentéktel" PropertyRole Multiplicative 1 13
public export a_jobb : HuWord
a_jobb = MkHu "jobb" "jobb" PropertyRole Additive 0 4
public export a_jo2 : HuWord
a_jo2 = MkHu "jó" "jó" PropertyRole Additive 0 2
public export a_jo2kedvu4 : HuWord
a_jo2kedvu4 = MkHu "jókedvű" "jókedvű" PropertyRole Multiplicative 0 7
public export a_kapzsi : HuWord
a_kapzsi = MkHu "kapzsi" "kapzsi" PropertyRole Multiplicative 0 6
public export a_katona2s : HuWord
a_katona2s = MkHu "katonás" "katonás" PropertyRole Additive 0 7
public export a_kedves : HuWord
a_kedves = MkHu "kedves" "kedves" PropertyRole Multiplicative 0 6
public export a_kellemetlen : HuWord
a_kellemetlen = MkHu "kellemetlen" "kellemetl" PropertyRole Multiplicative 1 11
public export a_kerek : HuWord
a_kerek = MkHu "kerek" "ker" PropertyRole Multiplicative 4 5
public export a_keresztcsonti : HuWord
a_keresztcsonti = MkHu "keresztcsonti" "keresztcsonti" PropertyRole Multiplicative 0 13
public export a_kerti : HuWord
a_kerti = MkHu "kerti" "kerti" PropertyRole Multiplicative 0 5
public export a_keskeny : HuWord
a_keskeny = MkHu "keskeny" "keskeny" PropertyRole Multiplicative 0 7
public export a_kiaba2lo2s : HuWord
a_kiaba2lo2s = MkHu "kiabálós" "kiabálós" PropertyRole Additive 0 8
public export a_kiegyensu2lyozatlan : HuWord
a_kiegyensu2lyozatlan = MkHu "kiegyensúlyozatlan" "kiegyensúlyozatla" PropertyRole Additive 1 18
public export a_kimeru3lt : HuWord
a_kimeru3lt = MkHu "kimerült" "kimerül" PropertyRole Multiplicative 2 8
public export a_kocka2s : HuWord
a_kocka2s = MkHu "kockás" "kockás" PropertyRole Additive 0 6
public export a_koraszu3lo3tt : HuWord
a_koraszu3lo3tt = MkHu "koraszülött" "koraszülö" PropertyRole Multiplicative 8 11
public export a_korla2tlan : HuWord
a_korla2tlan = MkHu "korlátlan" "korlátla" PropertyRole Additive 1 9
public export a_koros : HuWord
a_koros = MkHu "koros" "koros" PropertyRole Additive 0 5
public export a_kora2bbi : HuWord
a_kora2bbi = MkHu "korábbi" "korábbi" PropertyRole Multiplicative 0 7
public export a_kre2ta2s : HuWord
a_kre2ta2s = MkHu "krétás" "krétás" PropertyRole Additive 0 6
public export a_ke2pzett : HuWord
a_ke2pzett = MkHu "képzett" "képze" PropertyRole Multiplicative 8 7
public export a_ke2so4i : HuWord
a_ke2so4i = MkHu "késői" "késői" PropertyRole Multiplicative 0 5
public export a_ke2tarcu2 : HuWord
a_ke2tarcu2 = MkHu "kétarcú" "kétarcú" PropertyRole Additive 0 7
public export a_ke2tszi2nu4 : HuWord
a_ke2tszi2nu4 = MkHu "kétszínű" "kétszínű" PropertyRole Multiplicative 0 8
public export a_ko2pe2 : HuWord
a_ko2pe2 = MkHu "kópé" "kópé" PropertyRole Multiplicative 0 4
public export a_ko2rha2zi : HuWord
a_ko2rha2zi = MkHu "kórházi" "kórházi" PropertyRole Multiplicative 0 7
public export a_ko3do3s : HuWord
a_ko3do3s = MkHu "ködös" "ködös" PropertyRole Multiplicative 0 5
public export a_ko3nyvele2si : HuWord
a_ko3nyvele2si = MkHu "könyvelési" "könyvelési" PropertyRole Multiplicative 0 10
public export a_ko3nyvta2ri : HuWord
a_ko3nyvta2ri = MkHu "könyvtári" "könyvtári" PropertyRole Multiplicative 0 9
public export a_ko3vetkezme2nyes : HuWord
a_ko3vetkezme2nyes = MkHu "következményes" "következményes" PropertyRole Multiplicative 0 14
public export a_ko3zo3nse2ge : HuWord
a_ko3zo3nse2ge = MkHu "közönsége" "közönsége" PropertyRole Multiplicative 0 9
public export a_lakci2m : HuWord
a_lakci2m = MkHu "lakcím" "lakcím" PropertyRole Multiplicative 0 6
public export a_laza : HuWord
a_laza = MkHu "laza" "laza" PropertyRole Additive 0 4
public export a_leguto2bbi : HuWord
a_leguto2bbi = MkHu "legutóbbi" "legutóbbi" PropertyRole Multiplicative 0 9
public export a_lejto4s : HuWord
a_lejto4s = MkHu "lejtős" "lejtős" PropertyRole Multiplicative 0 6
public export a_leleme2nyes : HuWord
a_leleme2nyes = MkHu "leleményes" "leleményes" PropertyRole Multiplicative 0 10
public export a_lelkiismeretlen : HuWord
a_lelkiismeretlen = MkHu "lelkiismeretlen" "lelkiismeretl" PropertyRole Multiplicative 1 15
public export a_leromlott : HuWord
a_leromlott = MkHu "leromlott" "leromlo" PropertyRole Additive 8 9
public export a_levego4tlen : HuWord
a_levego4tlen = MkHu "levegőtlen" "levegőtl" PropertyRole Multiplicative 1 10
public export a_leve2lta2ri : HuWord
a_leve2lta2ri = MkHu "levéltári" "levéltári" PropertyRole Multiplicative 0 9
public export a_lezser : HuWord
a_lezser = MkHu "lezser" "lezser" PropertyRole Multiplicative 0 6
public export a_lila : HuWord
a_lila = MkHu "lila" "lila" PropertyRole Additive 0 4
public export a_lusta : HuWord
a_lusta = MkHu "lusta" "lusta" PropertyRole Additive 0 5
public export a_la2gy : HuWord
a_la2gy = MkHu "lágy" "lágy" PropertyRole Additive 0 4
public export a_la2thatatlan : HuWord
a_la2thatatlan = MkHu "láthatatlan" "láthatatla" PropertyRole Additive 1 11
public export a_le2gi : HuWord
a_le2gi = MkHu "légi" "légi" PropertyRole Multiplicative 0 4
public export a_le2gko3ri : HuWord
a_le2gko3ri = MkHu "légköri" "légköri" PropertyRole Multiplicative 0 7
public export a_maga2nyos : HuWord
a_maga2nyos = MkHu "magányos" "magányos" PropertyRole Additive 0 8
public export a_mai : HuWord
a_mai = MkHu "mai" "mai" PropertyRole Multiplicative 0 3
public export a_makacs : HuWord
a_makacs = MkHu "makacs" "makacs" PropertyRole Additive 0 6
public export a_megbi2zhatatlan : HuWord
a_megbi2zhatatlan = MkHu "megbízhatatlan" "megbízhatatla" PropertyRole Additive 1 14
public export a_megdo4lt : HuWord
a_megdo4lt = MkHu "megdőlt" "megdől" PropertyRole Multiplicative 2 7
public export a_megfizethetetlen : HuWord
a_megfizethetetlen = MkHu "megfizethetetlen" "megfizethetetl" PropertyRole Multiplicative 1 16
public export a_meggyo3kerezett : HuWord
a_meggyo3kerezett = MkHu "meggyökerezett" "meggyökereze" PropertyRole Multiplicative 8 14
public export a_meghamisi2tott : HuWord
a_meghamisi2tott = MkHu "meghamisított" "meghamisíto" PropertyRole Additive 8 13
public export a_megszokott : HuWord
a_megszokott = MkHu "megszokott" "megszoko" PropertyRole Additive 8 10
public export a_mezei : HuWord
a_mezei = MkHu "mezei" "mezei" PropertyRole Multiplicative 0 5
public export a_mezo4gazdasa2gi : HuWord
a_mezo4gazdasa2gi = MkHu "mezőgazdasági" "mezőgazdasági" PropertyRole Multiplicative 0 13
public export a_mezo4gazdasa2i : HuWord
a_mezo4gazdasa2i = MkHu "mezőgazdasái" "mezőgazdasái" PropertyRole Multiplicative 0 12
public export a_mind : HuWord
a_mind = MkHu "mind" "mind" PropertyRole Multiplicative 0 4
public export a_mindennapi : HuWord
a_mindennapi = MkHu "mindennapi" "mindennapi" PropertyRole Multiplicative 0 10
public export a_modern : HuWord
a_modern = MkHu "modern" "moder" PropertyRole Multiplicative 1 6
public export a_mogorva : HuWord
a_mogorva = MkHu "mogorva" "mogorva" PropertyRole Additive 0 7
public export a_moho2 : HuWord
a_moho2 = MkHu "mohó" "mohó" PropertyRole Additive 0 4
public export a_monoton : HuWord
a_monoton = MkHu "monoton" "mono" PropertyRole Additive 3 7
public export a_munkako3zo3sse2gi : HuWord
a_munkako3zo3sse2gi = MkHu "munkaközösségi" "munkaközösségi" PropertyRole Multiplicative 0 14
public export a_munkane2lku3li : HuWord
a_munkane2lku3li = MkHu "munkanélküli" "munkanélküli" PropertyRole Multiplicative 0 12
public export a_me2ly : HuWord
a_me2ly = MkHu "mély" "mély" PropertyRole Multiplicative 0 4
public export a_me2rgezo4 : HuWord
a_me2rgezo4 = MkHu "mérgező" "mérgező" PropertyRole Multiplicative 0 7
public export a_nagy : HuWord
a_nagy = MkHu "nagy" "nagy" PropertyRole Additive 0 4
public export a_nagyevo4 : HuWord
a_nagyevo4 = MkHu "nagyevő" "nagyevő" PropertyRole Multiplicative 0 7
public export a_nagyhangu2 : HuWord
a_nagyhangu2 = MkHu "nagyhangú" "nagyhangú" PropertyRole Additive 0 9
public export a_nagyharagu2 : HuWord
a_nagyharagu2 = MkHu "nagyharagú" "nagyharagú" PropertyRole Additive 0 10
public export a_nagyszeru4 : HuWord
a_nagyszeru4 = MkHu "nagyszerű" "nagyszerű" PropertyRole Multiplicative 0 9
public export a_naplopo2 : HuWord
a_naplopo2 = MkHu "naplopó" "naplopó" PropertyRole Additive 0 7
public export a_nemes : HuWord
a_nemes = MkHu "nemes" "nemes" PropertyRole Multiplicative 0 5
public export a_nemeslelku4 : HuWord
a_nemeslelku4 = MkHu "nemeslelkű" "nemeslelkű" PropertyRole Multiplicative 0 10
public export a_nyafka : HuWord
a_nyafka = MkHu "nyafka" "nyafka" PropertyRole Additive 0 6
public export a_nyerese2ges : HuWord
a_nyerese2ges = MkHu "nyereséges" "nyereséges" PropertyRole Multiplicative 0 10
public export a_nyomorult : HuWord
a_nyomorult = MkHu "nyomorult" "nyomorul" PropertyRole Additive 2 9
public export a_nyomtalan : HuWord
a_nyomtalan = MkHu "nyomtalan" "nyomtala" PropertyRole Additive 1 9
public export a_nyugodt : HuWord
a_nyugodt = MkHu "nyugodt" "nyugod" PropertyRole Additive 2 7
public export a_nyugtalan : HuWord
a_nyugtalan = MkHu "nyugtalan" "nyugtala" PropertyRole Additive 1 9
public export a_nyugtalani2to2 : HuWord
a_nyugtalani2to2 = MkHu "nyugtalanító" "nyugtalanító" PropertyRole Additive 0 12
public export a_no3ve2nyi : HuWord
a_no3ve2nyi = MkHu "növényi" "növényi" PropertyRole Multiplicative 0 7
public export a_okos : HuWord
a_okos = MkHu "okos" "okos" PropertyRole Additive 0 4
public export a_oldalu2 : HuWord
a_oldalu2 = MkHu "oldalú" "oldalú" PropertyRole Additive 0 6
public export a_omlo2s : HuWord
a_omlo2s = MkHu "omlós" "omlós" PropertyRole Additive 0 5
public export a_ostoba : HuWord
a_ostoba = MkHu "ostoba" "osto" PropertyRole Additive 1 6
public export a_osztra2k : HuWord
a_osztra2k = MkHu "osztrák" "osztrá" PropertyRole Additive 4 7
public export a_ova2lis : HuWord
a_ova2lis = MkHu "ovális" "ovális" PropertyRole Multiplicative 0 6
public export a_pazarlo2 : HuWord
a_pazarlo2 = MkHu "pazarló" "pazarló" PropertyRole Additive 0 7
public export a_piaci : HuWord
a_piaci = MkHu "piaci" "piaci" PropertyRole Multiplicative 0 5
public export a_piszkos : HuWord
a_piszkos = MkHu "piszkos" "piszkos" PropertyRole Additive 0 7
public export a_polga2ri : HuWord
a_polga2ri = MkHu "polgári" "polgári" PropertyRole Multiplicative 0 7
public export a_poroszka : HuWord
a_poroszka = MkHu "poroszka" "poroszka" PropertyRole Additive 0 8
public export a_puha : HuWord
a_puha = MkHu "puha" "puha" PropertyRole Additive 0 4
public export a_pa2nce2los : HuWord
a_pa2nce2los = MkHu "páncélos" "páncélos" PropertyRole Additive 0 8
public export a_pa2nce2lto3ro4 : HuWord
a_pa2nce2lto3ro4 = MkHu "páncéltörő" "páncéltörő" PropertyRole Multiplicative 0 10
public export a_pa2rtonki2vu3li : HuWord
a_pa2rtonki2vu3li = MkHu "pártonkívüli" "pártonkívüli" PropertyRole Multiplicative 0 12
public export a_raga2lyos : HuWord
a_raga2lyos = MkHu "ragályos" "ragályos" PropertyRole Additive 0 8
public export a_ravasz : HuWord
a_ravasz = MkHu "ravasz" "ravasz" PropertyRole Additive 0 6
public export a_rejtett : HuWord
a_rejtett = MkHu "rejtett" "rejte" PropertyRole Multiplicative 8 7
public export a_rendetlen : HuWord
a_rendetlen = MkHu "rendetlen" "rendetl" PropertyRole Multiplicative 1 9
public export a_repu3lo4 : HuWord
a_repu3lo4 = MkHu "repülő" "repülő" PropertyRole Multiplicative 0 6
public export a_rezerva2lt : HuWord
a_rezerva2lt = MkHu "rezervált" "rezervál" PropertyRole Additive 2 9
public export a_rossz : HuWord
a_rossz = MkHu "rossz" "rossz" PropertyRole Additive 0 5
public export a_ra2meno4s : HuWord
a_ra2meno4s = MkHu "rámenős" "rámenős" PropertyRole Multiplicative 0 7
public export a_re2gebbi : HuWord
a_re2gebbi = MkHu "régebbi" "régebbi" PropertyRole Multiplicative 0 7
public export a_re2gi : HuWord
a_re2gi = MkHu "régi" "régi" PropertyRole Multiplicative 0 4
public export a_re2ge2szeti : HuWord
a_re2ge2szeti = MkHu "régészeti" "régészeti" PropertyRole Multiplicative 0 9
public export a_ro2zsaszi2n : HuWord
a_ro2zsaszi2n = MkHu "rózsaszín" "rózsaszí" PropertyRole Multiplicative 1 9
public export a_ro3vidla2to2 : HuWord
a_ro3vidla2to2 = MkHu "rövidlátó" "rövidlátó" PropertyRole Additive 0 9
public export a_ro4fnyi : HuWord
a_ro4fnyi = MkHu "rőfnyi" "rőfnyi" PropertyRole Multiplicative 0 6
public export a_saja2tsa2gos : HuWord
a_saja2tsa2gos = MkHu "sajátságos" "sajátságos" PropertyRole Additive 0 10
public export a_satnya : HuWord
a_satnya = MkHu "satnya" "satnya" PropertyRole Additive 0 6
public export a_sikeres : HuWord
a_sikeres = MkHu "sikeres" "sikeres" PropertyRole Multiplicative 0 7
public export a_sikertelen : HuWord
a_sikertelen = MkHu "sikertelen" "sikertel" PropertyRole Multiplicative 1 10
public export a_sila2ny : HuWord
a_sila2ny = MkHu "silány" "silány" PropertyRole Additive 0 6
public export a_siralmas : HuWord
a_siralmas = MkHu "siralmas" "siralmas" PropertyRole Additive 0 8
public export a_sira2nkozo2 : HuWord
a_sira2nkozo2 = MkHu "siránkozó" "siránkozó" PropertyRole Additive 0 9
public export a_sivatagi : HuWord
a_sivatagi = MkHu "sivatagi" "sivatagi" PropertyRole Multiplicative 0 8
public export a_sivatagos : HuWord
a_sivatagos = MkHu "sivatagos" "sivatagos" PropertyRole Additive 0 9
public export a_sokszi2nu4 : HuWord
a_sokszi2nu4 = MkHu "sokszínű" "sokszínű" PropertyRole Multiplicative 0 8
public export a_specifikus : HuWord
a_specifikus = MkHu "specifikus" "specifikus" PropertyRole Additive 0 10
public export a_szabad : HuWord
a_szabad = MkHu "szabad" "szabad" PropertyRole Additive 0 6
public export a_szege2ny : HuWord
a_szege2ny = MkHu "szegény" "szegény" PropertyRole Multiplicative 0 7
public export a_szemtelen : HuWord
a_szemtelen = MkHu "szemtelen" "szemtel" PropertyRole Multiplicative 1 9
public export a_szeme2lyes : HuWord
a_szeme2lyes = MkHu "személyes" "személyes" PropertyRole Multiplicative 0 9
public export a_szeme2lytelen : HuWord
a_szeme2lytelen = MkHu "személytelen" "személytel" PropertyRole Multiplicative 1 12
public export a_szeme2rmetlen : HuWord
a_szeme2rmetlen = MkHu "szemérmetlen" "szemérmetl" PropertyRole Multiplicative 1 12
public export a_szent : HuWord
a_szent = MkHu "szent" "sze" PropertyRole Multiplicative 3 5
public export a_szenvede2lyes : HuWord
a_szenvede2lyes = MkHu "szenvedélyes" "szenvedélyes" PropertyRole Multiplicative 0 12
public export a_szerencse2s : HuWord
a_szerencse2s = MkHu "szerencsés" "szerencsés" PropertyRole Multiplicative 0 10
public export a_szerzo4i : HuWord
a_szerzo4i = MkHu "szerzői" "szerzői" PropertyRole Multiplicative 0 7
public export a_szere2ny : HuWord
a_szere2ny = MkHu "szerény" "szerény" PropertyRole Multiplicative 0 7
public export a_szesze2lyes : HuWord
a_szesze2lyes = MkHu "szeszélyes" "szeszélyes" PropertyRole Multiplicative 0 10
public export a_sznet : HuWord
a_sznet = MkHu "sznet" "szn" PropertyRole Ring 2 5
public export a_szuvere2n : HuWord
a_szuvere2n = MkHu "szuverén" "szuveré" PropertyRole Multiplicative 1 8
public export a_sza2nto2fo3ldi : HuWord
a_sza2nto2fo3ldi = MkHu "szántóföldi" "szántóföldi" PropertyRole Multiplicative 0 11
public export a_sza2rnyas : HuWord
a_sza2rnyas = MkHu "szárnyas" "szárnyas" PropertyRole Additive 0 8
public export a_sza2rnyatlan : HuWord
a_sza2rnyatlan = MkHu "szárnyatlan" "szárnyatla" PropertyRole Additive 1 11
public export a_sze2tszaggatott : HuWord
a_sze2tszaggatott = MkHu "szétszaggatott" "szétszaggato" PropertyRole Additive 8 14
public export a_szi2nes : HuWord
a_szi2nes = MkHu "színes" "színes" PropertyRole Multiplicative 0 6
public export a_szo2fogadatlan : HuWord
a_szo2fogadatlan = MkHu "szófogadatlan" "szófogadatla" PropertyRole Additive 1 13
public export a_szo2sza2tya2r : HuWord
a_szo2sza2tya2r = MkHu "szószátyár" "szószátyár" PropertyRole Additive 0 10
public export a_szo3ko4 : HuWord
a_szo3ko4 = MkHu "szökő" "szökő" PropertyRole Multiplicative 0 5
public export a_szu3rke : HuWord
a_szu3rke = MkHu "szürke" "szürke" PropertyRole Multiplicative 0 6
public export a_szu4k : HuWord
a_szu4k = MkHu "szűk" "szű" PropertyRole Multiplicative 4 4
public export a_sa2r : HuWord
a_sa2r = MkHu "sár" "sár" PropertyRole Additive 0 3
public export a_so2va2r : HuWord
a_so2va2r = MkHu "sóvár" "sóvár" PropertyRole Additive 0 5
public export a_so3te2tlila : HuWord
a_so3te2tlila = MkHu "sötétlila" "sötétlila" PropertyRole Additive 0 9
public export a_talpraesett : HuWord
a_talpraesett = MkHu "talpraesett" "talpraese" PropertyRole Multiplicative 8 11
public export a_tarka : HuWord
a_tarka = MkHu "tarka" "tarka" PropertyRole Additive 0 5
public export a_tehetse2gtelen : HuWord
a_tehetse2gtelen = MkHu "tehetségtelen" "tehetségtel" PropertyRole Multiplicative 1 13
public export a_tekinte2lyes : HuWord
a_tekinte2lyes = MkHu "tekintélyes" "tekintélyes" PropertyRole Multiplicative 0 11
public export a_telet : HuWord
a_telet = MkHu "telet" "tel" PropertyRole Multiplicative 2 5
public export a_telhetetlen : HuWord
a_telhetetlen = MkHu "telhetetlen" "telhetetl" PropertyRole Multiplicative 1 11
public export a_teljes : HuWord
a_teljes = MkHu "teljes" "teljes" PropertyRole Multiplicative 0 6
public export a_telt : HuWord
a_telt = MkHu "telt" "tel" PropertyRole Multiplicative 2 4
public export a_terhes : HuWord
a_terhes = MkHu "terhes" "terhes" PropertyRole Multiplicative 0 6
public export a_termele2keny : HuWord
a_termele2keny = MkHu "termelékeny" "termelékeny" PropertyRole Multiplicative 0 11
public export a_terme2keny : HuWord
a_terme2keny = MkHu "termékeny" "termékeny" PropertyRole Multiplicative 0 9
public export a_terme2ketlen : HuWord
a_terme2ketlen = MkHu "terméketlen" "terméketl" PropertyRole Multiplicative 1 11
public export a_testve2ri : HuWord
a_testve2ri = MkHu "testvéri" "testvéri" PropertyRole Multiplicative 0 8
public export a_testve2ries : HuWord
a_testve2ries = MkHu "testvéries" "testvéries" PropertyRole Multiplicative 0 10
public export a_tiszta : HuWord
a_tiszta = MkHu "tiszta" "tiszta" PropertyRole Additive 0 6
public export a_tolakodo2 : HuWord
a_tolakodo2 = MkHu "tolakodó" "tolakodó" PropertyRole Additive 0 8
public export a_tollas : HuWord
a_tollas = MkHu "tollas" "tollas" PropertyRole Additive 0 6
public export a_torkos : HuWord
a_torkos = MkHu "torkos" "torkos" PropertyRole Additive 0 6
public export a_tra2ga2r : HuWord
a_tra2ga2r = MkHu "trágár" "trágár" PropertyRole Additive 0 6
public export a_ta2pla2lo2 : HuWord
a_ta2pla2lo2 = MkHu "tápláló" "tápláló" PropertyRole Additive 0 7
public export a_to3megta2je2koztata2si : HuWord
a_to3megta2je2koztata2si = MkHu "tömegtájékoztatási" "tömegtájékoztatási" PropertyRole Multiplicative 0 18
public export a_tu3relmetlen : HuWord
a_tu3relmetlen = MkHu "türelmetlen" "türelmetl" PropertyRole Multiplicative 1 11
public export a_tu3ze2rse2gi : HuWord
a_tu3ze2rse2gi = MkHu "tüzérségi" "tüzérségi" PropertyRole Multiplicative 0 9
public export a_unalma : HuWord
a_unalma = MkHu "unalma" "unalma" PropertyRole Additive 0 6
public export a_unalmas : HuWord
a_unalmas = MkHu "unalmas" "unalmas" PropertyRole Additive 0 7
public export a_utolso2 : HuWord
a_utolso2 = MkHu "utolsó" "utolsó" PropertyRole Additive 0 6
public export a_uto2bbi : HuWord
a_uto2bbi = MkHu "utóbbi" "utóbbi" PropertyRole Multiplicative 0 6
public export a_vagyonos : HuWord
a_vagyonos = MkHu "vagyonos" "vagyonos" PropertyRole Additive 0 8
public export a_valla2sellenes : HuWord
a_valla2sellenes = MkHu "vallásellenes" "vallásellenes" PropertyRole Multiplicative 0 13
public export a_vila2gos : HuWord
a_vila2gos = MkHu "világos" "világos" PropertyRole Additive 0 7
public export a_vila2gosbarna : HuWord
a_vila2gosbarna = MkHu "világosbarna" "világosbarna" PropertyRole Additive 0 12
public export a_visszataszi2to2 : HuWord
a_visszataszi2to2 = MkHu "visszataszító" "visszataszító" PropertyRole Additive 0 13
public export a_visza2lykodo2 : HuWord
a_visza2lykodo2 = MkHu "viszálykodó" "viszálykodó" PropertyRole Additive 0 11
public export a_vodka2s : HuWord
a_vodka2s = MkHu "vodkás" "vodkás" PropertyRole Additive 0 6
public export a_va2ltakozo2 : HuWord
a_va2ltakozo2 = MkHu "váltakozó" "váltakozó" PropertyRole Additive 0 9
public export a_ve2gso4 : HuWord
a_ve2gso4 = MkHu "végső" "végső" PropertyRole Multiplicative 0 5
public export a_zagyva : HuWord
a_zagyva = MkHu "zagyva" "zagyva" PropertyRole Additive 0 6
public export a_zavaro2 : HuWord
a_zavaro2 = MkHu "zavaró" "zavaró" PropertyRole Additive 0 6
public export a_zsebke2s : HuWord
a_zsebke2s = MkHu "zsebkés" "zsebkés" PropertyRole Multiplicative 0 7
public export a_za2rko2zott : HuWord
a_za2rko2zott = MkHu "zárkózott" "zárkózo" PropertyRole Additive 8 9
public export a_a2be2ce2s : HuWord
a_a2be2ce2s = MkHu "ábécés" "ábécés" PropertyRole Multiplicative 0 6
public export a_a2lda2sos : HuWord
a_a2lda2sos = MkHu "áldásos" "áldásos" PropertyRole Additive 0 7
public export a_a2llando2 : HuWord
a_a2llando2 = MkHu "állandó" "állandó" PropertyRole Additive 0 7
public export a_a2llhatatlan : HuWord
a_a2llhatatlan = MkHu "állhatatlan" "állhatatla" PropertyRole Additive 1 11
public export a_a2prilisi : HuWord
a_a2prilisi = MkHu "áprilisi" "áprilisi" PropertyRole Multiplicative 0 8
public export a_a2rkos : HuWord
a_a2rkos = MkHu "árkos" "árkos" PropertyRole Additive 0 5
public export a_a2rulkodo2 : HuWord
a_a2rulkodo2 = MkHu "árulkodó" "árulkodó" PropertyRole Additive 0 8
public export a_a2rva : HuWord
a_a2rva = MkHu "árva" "árva" PropertyRole Additive 0 4
public export a_a2zsiai : HuWord
a_a2zsiai = MkHu "ázsiai" "ázsiai" PropertyRole Multiplicative 0 6
public export a_e2hes : HuWord
a_e2hes = MkHu "éhes" "éhes" PropertyRole Multiplicative 0 4
public export a_e2letrajzi : HuWord
a_e2letrajzi = MkHu "életrajzi" "életrajzi" PropertyRole Multiplicative 0 9
public export a_e2pi2te2szeti : HuWord
a_e2pi2te2szeti = MkHu "építészeti" "építészeti" PropertyRole Multiplicative 0 10
public export a_e2rtelmes : HuWord
a_e2rtelmes = MkHu "értelmes" "értelmes" PropertyRole Multiplicative 0 8
public export a_e2ves : HuWord
a_e2ves = MkHu "éves" "éves" PropertyRole Multiplicative 0 4
public export a_i2ra2studatlan : HuWord
a_i2ra2studatlan = MkHu "írástudatlan" "írástudatla" PropertyRole Additive 1 12
public export a_i2zes : HuWord
a_i2zes = MkHu "ízes" "ízes" PropertyRole Multiplicative 0 4
public export a_i2zetlen : HuWord
a_i2zetlen = MkHu "ízetlen" "ízetl" PropertyRole Multiplicative 1 7
public export a_o3nfeju4 : HuWord
a_o3nfeju4 = MkHu "önfejű" "önfejű" PropertyRole Multiplicative 0 6
public export a_o3na2llo2 : HuWord
a_o3na2llo2 = MkHu "önálló" "önálló" PropertyRole Additive 0 6
public export a_o3ne2letrajzi : HuWord
a_o3ne2letrajzi = MkHu "önéletrajzi" "önéletrajzi" PropertyRole Multiplicative 0 11
public export a_o3reg : HuWord
a_o3reg = MkHu "öreg" "öreg" PropertyRole Multiplicative 0 4
public export a_o3tlettelen : HuWord
a_o3tlettelen = MkHu "ötlettelen" "ötlettel" PropertyRole Multiplicative 1 10
public export a_u2szo2s : HuWord
a_u2szo2s = MkHu "úszós" "úszós" PropertyRole Additive 0 5
public export a_u3gyes : HuWord
a_u3gyes = MkHu "ügyes" "ügyes" PropertyRole Multiplicative 0 5
public export a_u3gyetlen : HuWord
a_u3gyetlen = MkHu "ügyetlen" "ügyetl" PropertyRole Multiplicative 1 8
public export a_u3gyno3kse2gi : HuWord
a_u3gyno3kse2gi = MkHu "ügynökségi" "ügynökségi" PropertyRole Multiplicative 0 10
public export a_u3res : HuWord
a_u3res = MkHu "üres" "üres" PropertyRole Multiplicative 0 4
public export a_u3rmo3s : HuWord
a_u3rmo3s = MkHu "ürmös" "ürmös" PropertyRole Multiplicative 0 5
public export d_apra2nke2nt : HuWord
d_apra2nke2nt = MkHu "apránként" "apránké" ModifierRole Multiplicative 3 9
public export d_automatikusan : HuWord
d_automatikusan = MkHu "automatikusan" "automatikusa" ModifierRole Additive 1 13
public export d_azta2n : HuWord
d_azta2n = MkHu "aztán" "aztá" ModifierRole Additive 1 5
public export d_azuta2n : HuWord
d_azuta2n = MkHu "azután" "azutá" ModifierRole Additive 1 6
public export d_bosszanto2an : HuWord
d_bosszanto2an = MkHu "bosszantóan" "bosszantóa" ModifierRole Additive 1 11
public export d_ba2tran : HuWord
d_ba2tran = MkHu "bátran" "bátra" ModifierRole Additive 1 6
public export d_bo4se2gesen : HuWord
d_bo4se2gesen = MkHu "bőségesen" "bőséges" ModifierRole Multiplicative 1 9
public export d_csendesen : HuWord
d_csendesen = MkHu "csendesen" "csendes" ModifierRole Multiplicative 1 9
public export d_csoda2latos : HuWord
d_csoda2latos = MkHu "csodálatos" "csodálatos" ModifierRole Additive 0 10
public export d_csoda2san : HuWord
d_csoda2san = MkHu "csodásan" "csodása" ModifierRole Additive 1 8
public export d_csu2nya2n : HuWord
d_csu2nya2n = MkHu "csúnyán" "csúnyá" ModifierRole Additive 1 7
public export d_dadogva : HuWord
d_dadogva = MkHu "dadogva" "dadogva" ModifierRole Additive 0 7
public export d_darabokban : HuWord
d_darabokban = MkHu "darabokban" "darab" ModifierRole Additive 5 10
public export d_do3lyfo3sen : HuWord
d_do3lyfo3sen = MkHu "dölyfösen" "dölyfös" ModifierRole Multiplicative 1 9
public export d_egyenke2nt : HuWord
d_egyenke2nt = MkHu "egyenként" "egyenké" ModifierRole Multiplicative 3 9
public export d_egyenlo4en : HuWord
d_egyenlo4en = MkHu "egyenlően" "egyenlő" ModifierRole Multiplicative 1 9
public export d_egyforma2n : HuWord
d_egyforma2n = MkHu "egyformán" "egyformá" ModifierRole Additive 1 9
public export d_egyremegy : HuWord
d_egyremegy = MkHu "egyremegy" "egyremegy" ModifierRole Multiplicative 0 9
public export d_egyu3ve2 : HuWord
d_egyu3ve2 = MkHu "együvé" "együ" ModifierRole Multiplicative 1 6
public export d_ege2szen : HuWord
d_ege2szen = MkHu "egészen" "egész" ModifierRole Multiplicative 1 7
public export d_elegendo4en : HuWord
d_elegendo4en = MkHu "elegendően" "elegendő" ModifierRole Multiplicative 1 10
public export d_elfordulva : HuWord
d_elfordulva = MkHu "elfordulva" "elfordulva" ModifierRole Additive 0 10
public export d_elhagyatottan : HuWord
d_elhagyatottan = MkHu "elhagyatottan" "elhagyatotta" ModifierRole Additive 1 13
public export d_elke2peszto4en : HuWord
d_elke2peszto4en = MkHu "elképesztően" "elképesztő" ModifierRole Multiplicative 1 12
public export d_ellenkezo4leg : HuWord
d_ellenkezo4leg = MkHu "ellenkezőleg" "ellenkezőleg" ModifierRole Multiplicative 0 12
public export d_elso4 : HuWord
d_elso4 = MkHu "első" "első" ModifierRole Multiplicative 0 4
public export d_elo3l : HuWord
d_elo3l = MkHu "elöl" "elöl" ModifierRole Multiplicative 0 4
public export d_elo3lre : HuWord
d_elo3lre = MkHu "elölre" "elöl" ModifierRole Multiplicative 1 6
public export d_elo3lro4l : HuWord
d_elo3lro4l = MkHu "elölről" "elöl" ModifierRole Multiplicative 1 7
public export d_elo4bb : HuWord
d_elo4bb = MkHu "előbb" "előbb" ModifierRole Multiplicative 0 5
public export d_elo4bbre : HuWord
d_elo4bbre = MkHu "előbbre" "előbb" ModifierRole Multiplicative 1 7
public export d_elo4re : HuWord
d_elo4re = MkHu "előre" "elő" ModifierRole Multiplicative 1 5
public export d_elo4tte : HuWord
d_elo4tte = MkHu "előtte" "előtte" ModifierRole Multiplicative 0 6
public export d_elo4tted : HuWord
d_elo4tted = MkHu "előtted" "elő" ModifierRole Multiplicative 40 7
public export d_eredme2nyesen : HuWord
d_eredme2nyesen = MkHu "eredményesen" "eredményes" ModifierRole Multiplicative 1 12
public export d_eredme2nytelenu3l : HuWord
d_eredme2nytelenu3l = MkHu "eredménytelenül" "eredménytelenül" ModifierRole Multiplicative 0 15
public export d_erko3lcstelen : HuWord
d_erko3lcstelen = MkHu "erkölcstelen" "erkölcstel" ModifierRole Multiplicative 1 12
public export d_ezentu2l : HuWord
d_ezentu2l = MkHu "ezentúl" "ezentúl" ModifierRole Additive 0 7
public export d_felforgatva : HuWord
d_felforgatva = MkHu "felforgatva" "felforgatva" ModifierRole Additive 0 11
public export d_folyamatosan : HuWord
d_folyamatosan = MkHu "folyamatosan" "folyamatosa" ModifierRole Additive 1 12
public export d_folyton : HuWord
d_folyton = MkHu "folyton" "foly" ModifierRole Additive 3 7
public export d_folyva : HuWord
d_folyva = MkHu "folyva" "folyva" ModifierRole Additive 0 6
public export d_fona2kul : HuWord
d_fona2kul = MkHu "fonákul" "fonákul" ModifierRole Additive 0 7
public export d_fordi2tva : HuWord
d_fordi2tva = MkHu "fordítva" "fordítva" ModifierRole Additive 0 8
public export d_furfangosan : HuWord
d_furfangosan = MkHu "furfangosan" "furfangosa" ModifierRole Additive 1 11
public export d_futva : HuWord
d_futva = MkHu "futva" "futva" ModifierRole Additive 0 5
public export d_fa2jdalmasan : HuWord
d_fa2jdalmasan = MkHu "fájdalmasan" "fájdalmasa" ModifierRole Additive 1 11
public export d_fe2lreeso4en : HuWord
d_fe2lreeso4en = MkHu "félreesően" "félreeső" ModifierRole Multiplicative 1 10
public export d_fe2lreeso4n : HuWord
d_fe2lreeso4n = MkHu "félreesőn" "félreeső" ModifierRole Multiplicative 1 9
public export d_fe2lrevezeto4en : HuWord
d_fe2lrevezeto4en = MkHu "félrevezetően" "félrevezető" ModifierRole Multiplicative 1 13
public export d_gonoszul : HuWord
d_gonoszul = MkHu "gonoszul" "gonoszul" ModifierRole Additive 0 8
public export d_gyenge2n : HuWord
d_gyenge2n = MkHu "gyengén" "gyengé" ModifierRole Multiplicative 1 7
public export d_go4go3sen : HuWord
d_go4go3sen = MkHu "gőgösen" "gőgös" ModifierRole Multiplicative 1 7
public export d_hamarosan : HuWord
d_hamarosan = MkHu "hamarosan" "hamarosa" ModifierRole Additive 1 9
public export d_hanyagul : HuWord
d_hanyagul = MkHu "hanyagul" "hanyagul" ModifierRole Additive 0 8
public export d_hasznosan : HuWord
d_hasznosan = MkHu "hasznosan" "hasznosa" ModifierRole Additive 1 9
public export d_haszonnal : HuWord
d_haszonnal = MkHu "haszonnal" "haszonnal" ModifierRole Additive 0 9
public export d_hatalmasan : HuWord
d_hatalmasan = MkHu "hatalmasan" "hatalmasa" ModifierRole Additive 1 10
public export d_hazate2re2skor : HuWord
d_hazate2re2skor = MkHu "hazatéréskor" "hazatéréskor" ModifierRole Additive 0 12
public export d_hebegve : HuWord
d_hebegve = MkHu "hebegve" "hebegve" ModifierRole Multiplicative 0 7
public export d_hiba : HuWord
d_hiba = MkHu "hiba" "hiba" ModifierRole Additive 0 4
public export d_holnapi : HuWord
d_holnapi = MkHu "holnapi" "holnapi" ModifierRole Multiplicative 0 7
public export d_hozza2e2rto4en : HuWord
d_hozza2e2rto4en = MkHu "hozzáértően" "hozzáértő" ModifierRole Multiplicative 1 11
public export d_ha2tra : HuWord
d_ha2tra = MkHu "hátra" "hát" ModifierRole Additive 1 5
public export d_ha2trafele2 : HuWord
d_ha2trafele2 = MkHu "hátrafelé" "hátrafelé" ModifierRole Multiplicative 0 9
public export d_ha2tso2 : HuWord
d_ha2tso2 = MkHu "hátsó" "hátsó" ModifierRole Additive 0 5
public export d_ha2ttal : HuWord
d_ha2ttal = MkHu "háttal" "háttal" ModifierRole Additive 0 6
public export d_ha2tul : HuWord
d_ha2tul = MkHu "hátul" "hátul" ModifierRole Additive 0 5
public export d_ha2tulro2l : HuWord
d_ha2tulro2l = MkHu "hátulról" "hátul" ModifierRole Additive 1 8
public export d_ho4siesen : HuWord
d_ho4siesen = MkHu "hősiesen" "hősies" ModifierRole Multiplicative 1 8
public export d_idegesi2to4en : HuWord
d_idegesi2to4en = MkHu "idegesítően" "idegesítő" ModifierRole Multiplicative 1 11
public export d_igazsa2gtalanul : HuWord
d_igazsa2gtalanul = MkHu "igazságtalanul" "igazságtalanul" ModifierRole Additive 0 14
public export d_isme2t : HuWord
d_isme2t = MkHu "ismét" "ismé" ModifierRole Multiplicative 2 5
public export d_istenien : HuWord
d_istenien = MkHu "istenien" "iste" ModifierRole Multiplicative 9 8
public export d_jobban : HuWord
d_jobban = MkHu "jobban" "job" ModifierRole Additive 1 6
public export d_jobbra : HuWord
d_jobbra = MkHu "jobbra" "jobb" ModifierRole Additive 1 6
public export d_jobbro2l : HuWord
d_jobbro2l = MkHu "jobbról" "jobb" ModifierRole Additive 1 7
public export d_jo2cska2n : HuWord
d_jo2cska2n = MkHu "jócskán" "jócská" ModifierRole Additive 1 7
public export d_jo2l : HuWord
d_jo2l = MkHu "jól" "jól" ModifierRole Additive 0 3
public export d_jo3vo4ben : HuWord
d_jo3vo4ben = MkHu "jövőben" "jövő" ModifierRole Multiplicative 1 7
public export d_kapzsin : HuWord
d_kapzsin = MkHu "kapzsin" "kapzsi" ModifierRole Multiplicative 1 7
public export d_kellemetlenu3l : HuWord
d_kellemetlenu3l = MkHu "kellemetlenül" "kellemetlenül" ModifierRole Multiplicative 0 13
public export d_komolytalan : HuWord
d_komolytalan = MkHu "komolytalan" "komolytala" ModifierRole Additive 1 11
public export d_kora2bban : HuWord
d_kora2bban = MkHu "korábban" "koráb" ModifierRole Additive 1 8
public export d_ke2rem : HuWord
d_ke2rem = MkHu "kérem" "kér" ModifierRole Multiplicative 32 5
public export d_ke2so4 : HuWord
d_ke2so4 = MkHu "késő" "késő" ModifierRole Multiplicative 0 4
public export d_ke2so4bb : HuWord
d_ke2so4bb = MkHu "később" "később" ModifierRole Multiplicative 0 6
public export d_ko3do3sen : HuWord
d_ko3do3sen = MkHu "ködösen" "ködös" ModifierRole Multiplicative 1 7
public export d_ko3vetendo4en : HuWord
d_ko3vetendo4en = MkHu "követendően" "követendő" ModifierRole Multiplicative 1 11
public export d_ku3lo3n : HuWord
d_ku3lo3n = MkHu "külön" "kül" ModifierRole Multiplicative 1 5
public export d_lapzsin : HuWord
d_lapzsin = MkHu "lapzsin" "lapzsi" ModifierRole Multiplicative 1 7
public export d_lusta2n : HuWord
d_lusta2n = MkHu "lustán" "lustá" ModifierRole Additive 1 6
public export d_la2gyan : HuWord
d_la2gyan = MkHu "lágyan" "lágya" ModifierRole Additive 1 6
public export d_la2thato2an : HuWord
d_la2thato2an = MkHu "láthatóan" "láthatóa" ModifierRole Additive 1 9
public export d_le2lektelen : HuWord
d_le2lektelen = MkHu "lélektelen" "lélektel" ModifierRole Multiplicative 1 10
public export d_lo2ha2ton : HuWord
d_lo2ha2ton = MkHu "lóháton" "lóhá" ModifierRole Additive 3 7
public export d_maga2nyosan : HuWord
d_maga2nyosan = MkHu "magányosan" "magányosa" ModifierRole Additive 1 10
public export d_majd : HuWord
d_majd = MkHu "majd" "majd" ModifierRole Additive 0 4
public export d_makacsul : HuWord
d_makacsul = MkHu "makacsul" "makacsul" ModifierRole Additive 0 8
public export d_megbi2zhatatlanul : HuWord
d_megbi2zhatatlanul = MkHu "megbízhatatlanul" "megbízhatatlanul" ModifierRole Additive 0 16
public export d_meghamisi2tottan : HuWord
d_meghamisi2tottan = MkHu "meghamisítottan" "meghamisította" ModifierRole Additive 1 15
public export d_mellette : HuWord
d_mellette = MkHu "mellette" "mellette" ModifierRole Multiplicative 0 8
public export d_melletted : HuWord
d_melletted = MkHu "melletted" "melle" ModifierRole Multiplicative 40 9
public export d_mellettem : HuWord
d_mellettem = MkHu "mellettem" "melle" ModifierRole Multiplicative 40 9
public export d_melle2 : HuWord
d_melle2 = MkHu "mellé" "mellé" ModifierRole Multiplicative 0 5
public export d_mindegy : HuWord
d_mindegy = MkHu "mindegy" "mindegy" ModifierRole Multiplicative 0 7
public export d_mindig : HuWord
d_mindig = MkHu "mindig" "mind" ModifierRole Multiplicative 1 6
public export d_mindja2rt : HuWord
d_mindja2rt = MkHu "mindjárt" "mindjár" ModifierRole Additive 2 8
public export d_minja2rt : HuWord
d_minja2rt = MkHu "minjárt" "minjár" ModifierRole Additive 2 7
public export d_mintha : HuWord
d_mintha = MkHu "mintha" "mintha" ModifierRole Additive 0 6
public export d_moho2n : HuWord
d_moho2n = MkHu "mohón" "mohó" ModifierRole Additive 1 5
public export d_monoton : HuWord
d_monoton = MkHu "monoton" "mono" ModifierRole Additive 3 7
public export d_most : HuWord
d_most = MkHu "most" "mos" ModifierRole Additive 2 4
public export d_munkako3zo3sse2genke2nt : HuWord
d_munkako3zo3sse2genke2nt = MkHu "munkaközösségenként" "munkaközösségenké" ModifierRole Multiplicative 3 19
public export d_munkako3zo3sse2gke2nt : HuWord
d_munkako3zo3sse2gke2nt = MkHu "munkaközösségként" "munkaközösségké" ModifierRole Multiplicative 3 17
public export d_ma2sfele2 : HuWord
d_ma2sfele2 = MkHu "másfelé" "másfelé" ModifierRole Multiplicative 0 7
public export d_mo3go3tte : HuWord
d_mo3go3tte = MkHu "mögötte" "mögötte" ModifierRole Multiplicative 0 7
public export d_mo3go3tted : HuWord
d_mo3go3tted = MkHu "mögötted" "mögö" ModifierRole Multiplicative 40 8
public export d_mo3go3ttem : HuWord
d_mo3go3ttem = MkHu "mögöttem" "mögö" ModifierRole Multiplicative 40 8
public export d_mo3go3ttu3k : HuWord
d_mo3go3ttu3k = MkHu "mögöttük" "mögöttü" ModifierRole Multiplicative 4 8
public export d_nagyon : HuWord
d_nagyon = MkHu "nagyon" "nagy" ModifierRole Additive 1 6
public export d_nagyszeru4 : HuWord
d_nagyszeru4 = MkHu "nagyszerű" "nagyszerű" ModifierRole Multiplicative 0 9
public export d_nemezcsizma2san : HuWord
d_nemezcsizma2san = MkHu "nemezcsizmásan" "nemezcsizmása" ModifierRole Additive 1 14
public export d_nemre2g : HuWord
d_nemre2g = MkHu "nemrég" "nemrég" ModifierRole Multiplicative 0 6
public export d_nyomtalanul : HuWord
d_nyomtalanul = MkHu "nyomtalanul" "nyomtalanul" ModifierRole Additive 0 11
public export d_nyugodtan : HuWord
d_nyugodtan = MkHu "nyugodtan" "nyugodta" ModifierRole Additive 1 9
public export d_nyugtalanul : HuWord
d_nyugtalanul = MkHu "nyugtalanul" "nyugtalanul" ModifierRole Additive 0 11
public export d_ostoba2n : HuWord
d_ostoba2n = MkHu "ostobán" "ostobá" ModifierRole Additive 1 7
public export d_ravaszul : HuWord
d_ravaszul = MkHu "ravaszul" "ravaszul" ModifierRole Additive 0 8
public export d_rejtetten : HuWord
d_rejtetten = MkHu "rejtetten" "rejte" ModifierRole Multiplicative 9 9
public export d_rosszul : HuWord
d_rosszul = MkHu "rosszul" "rosszul" ModifierRole Additive 0 7
public export d_re2gebben : HuWord
d_re2gebben = MkHu "régebben" "régeb" ModifierRole Multiplicative 1 8
public export d_saja2tsa2gosan : HuWord
d_saja2tsa2gosan = MkHu "sajátságosan" "sajátságosa" ModifierRole Additive 1 12
public export d_sikertelenu3l : HuWord
d_sikertelenu3l = MkHu "sikertelenül" "sikertelenül" ModifierRole Multiplicative 0 12
public export d_sorja2ban : HuWord
d_sorja2ban = MkHu "sorjában" "sorjá" ModifierRole Additive 1 8
public export d_specifikusan : HuWord
d_specifikusan = MkHu "specifikusan" "specifikusa" ModifierRole Additive 1 12
public export d_szaba2lyszeru4en : HuWord
d_szaba2lyszeru4en = MkHu "szabályszerűen" "szabályszerű" ModifierRole Multiplicative 1 14
public export d_szanasze2t : HuWord
d_szanasze2t = MkHu "szanaszét" "szanaszé" ModifierRole Multiplicative 2 9
public export d_szeles : HuWord
d_szeles = MkHu "szeles" "szeles" ModifierRole Multiplicative 0 6
public export d_szenten : HuWord
d_szenten = MkHu "szenten" "sze" ModifierRole Multiplicative 2 7
public export d_szerencse2sen : HuWord
d_szerencse2sen = MkHu "szerencsésen" "szerencsés" ModifierRole Multiplicative 1 12
public export d_szertesze2t : HuWord
d_szertesze2t = MkHu "szerteszét" "szerteszé" ModifierRole Multiplicative 2 10
public export d_szinte : HuWord
d_szinte = MkHu "szinte" "szinte" ModifierRole Multiplicative 0 6
public export d_szomsze2dos : HuWord
d_szomsze2dos = MkHu "szomszédos" "szomszédos" ModifierRole Additive 0 10
public export d_szorosan : HuWord
d_szorosan = MkHu "szorosan" "szorosa" ModifierRole Additive 1 8
public export d_sze2t : HuWord
d_sze2t = MkHu "szét" "szé" ModifierRole Multiplicative 2 4
public export d_szi2ne2n : HuWord
d_szi2ne2n = MkHu "színén" "színé" ModifierRole Multiplicative 1 6
public export d_szo2fodatlanul : HuWord
d_szo2fodatlanul = MkHu "szófodatlanul" "szófodatlanul" ModifierRole Additive 0 13
public export d_szu4ken : HuWord
d_szu4ken = MkHu "szűken" "szű" ModifierRole Multiplicative 5 6
public export d_so2va2ran : HuWord
d_so2va2ran = MkHu "sóváran" "sóvára" ModifierRole Additive 1 7
public export d_tala2n : HuWord
d_tala2n = MkHu "talán" "talá" ModifierRole Additive 1 5
public export d_tegnapelo4tt : HuWord
d_tegnapelo4tt = MkHu "tegnapelőtt" "tegnapelő" ModifierRole Multiplicative 8 11
public export d_teljesen : HuWord
d_teljesen = MkHu "teljesen" "teljes" ModifierRole Multiplicative 1 8
public export d_terhesen : HuWord
d_terhesen = MkHu "terhesen" "terhes" ModifierRole Multiplicative 1 8
public export d_termele2kenyen : HuWord
d_termele2kenyen = MkHu "termelékenyen" "termelékeny" ModifierRole Multiplicative 1 13
public export d_terme2kenyen : HuWord
d_terme2kenyen = MkHu "termékenyen" "termékeny" ModifierRole Multiplicative 1 11
public export d_tettetve : HuWord
d_tettetve = MkHu "tettetve" "tettetve" ModifierRole Multiplicative 0 8
public export d_tolakodo2an : HuWord
d_tolakodo2an = MkHu "tolakodóan" "tolakodóa" ModifierRole Additive 1 10
public export d_tova2bb : HuWord
d_tova2bb = MkHu "tovább" "tovább" ModifierRole Additive 0 6
public export d_te2tlen : HuWord
d_te2tlen = MkHu "tétlen" "tétl" ModifierRole Multiplicative 1 6
public export d_tu3relmetlenu3l : HuWord
d_tu3relmetlenu3l = MkHu "türelmetlenül" "türelmetlenül" ModifierRole Multiplicative 0 13
public export d_unalmasan : HuWord
d_unalmasan = MkHu "unalmasan" "unalmasa" ModifierRole Additive 1 9
public export d_untato2an : HuWord
d_untato2an = MkHu "untatóan" "untatóa" ModifierRole Additive 1 8
public export d_utolso2ul : HuWord
d_utolso2ul = MkHu "utolsóul" "utolsóul" ModifierRole Additive 0 8
public export d_uta2na : HuWord
d_uta2na = MkHu "utána" "utána" ModifierRole Additive 0 5
public export d_uto2 : HuWord
d_uto2 = MkHu "utó" "utó" ModifierRole Additive 0 3
public export d_uto2bb : HuWord
d_uto2bb = MkHu "utóbb" "utóbb" ModifierRole Additive 0 5
public export d_vila2gve2ge : HuWord
d_vila2gve2ge = MkHu "világvége" "világvége" ModifierRole Multiplicative 0 9
public export d_vissza : HuWord
d_vissza = MkHu "vissza" "vissza" ModifierRole Additive 0 6
public export d_va2laszthato2an : HuWord
d_va2laszthato2an = MkHu "választhatóan" "választhatóa" ModifierRole Additive 1 13
public export d_va2llvetve : HuWord
d_va2llvetve = MkHu "vállvetve" "vállvetve" ModifierRole Multiplicative 0 9
public export d_va2ltakozo2an : HuWord
d_va2ltakozo2an = MkHu "váltakozóan" "váltakozóa" ModifierRole Additive 1 11
public export d_ve2glegesen : HuWord
d_ve2glegesen = MkHu "véglegesen" "végleges" ModifierRole Multiplicative 1 10
public export d_ve2gte2re : HuWord
d_ve2gte2re = MkHu "végtére" "végté" ModifierRole Multiplicative 1 7
public export d_ve2ge2rve2nyesen : HuWord
d_ve2ge2rve2nyesen = MkHu "végérvényesen" "végérvényes" ModifierRole Multiplicative 1 13
public export d_ve2gu3l : HuWord
d_ve2gu3l = MkHu "végül" "végül" ModifierRole Multiplicative 0 5
public export d_zagyva2lva : HuWord
d_zagyva2lva = MkHu "zagyválva" "zagyválva" ModifierRole Additive 0 9
public export d_zavaro2an : HuWord
d_zavaro2an = MkHu "zavaróan" "zavaróa" ModifierRole Additive 1 8
public export d_a2lda2sosan : HuWord
d_a2lda2sosan = MkHu "áldásosan" "áldásosa" ModifierRole Additive 1 9
public export d_a2llando2an : HuWord
d_a2llando2an = MkHu "állandóan" "állandóa" ModifierRole Additive 1 9
public export d_a2llhatatlanul : HuWord
d_a2llhatatlanul = MkHu "állhatatlanul" "állhatatlanul" ModifierRole Additive 0 13
public export d_a2ramolva : HuWord
d_a2ramolva = MkHu "áramolva" "áramolva" ModifierRole Additive 0 8
public export d_i2zetlenu3l : HuWord
d_i2zetlenu3l = MkHu "ízetlenül" "ízetlenül" ModifierRole Multiplicative 0 9
public export d_o3na2llo2an : HuWord
d_o3na2llo2an = MkHu "önállóan" "önállóa" ModifierRole Additive 1 8
public export d_o3ro3kke2 : HuWord
d_o3ro3kke2 = MkHu "örökké" "örökké" ModifierRole Multiplicative 0 6
public export d_o3ro3kre : HuWord
d_o3ro3kre = MkHu "örökre" "örö" ModifierRole Multiplicative 5 6
public export d_u2jra : HuWord
d_u2jra = MkHu "újra" "újra" ModifierRole Additive 0 4
public export d_u3gyesen : HuWord
d_u3gyesen = MkHu "ügyesen" "ügyes" ModifierRole Multiplicative 1 7
public export d_u3resen : HuWord
d_u3resen = MkHu "üresen" "üres" ModifierRole Multiplicative 1 6

public export
lexiconSize : Nat
lexiconSize = 3460
