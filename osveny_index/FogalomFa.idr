module FogalomFa

import MagyarNyelv
import HaromKubit
import E8E8Algebra
import Emberi.Index
import Szamitasi.Index
import Steane713

||| Fogalom-hierarchia: mély típusok lehetnek egy másik gyerekei.
||| Egészíti ki a FogalomTipust a logikai kapcsolatokkal.
||| 概念层级：哪些类型可以是另一类型的子节点。以逻辑联系补全 FogalomTipus。
|||
||| Gondolat: nem minden fogalom lehet bármélyik másik gyereke.
||| Például egy Kérdés soha nem lehet gyereke egy Cselekvésnek.
||| A 35 érvényes kapcsolat a teljes hierarchiát írja le.
||| 洞见：并非任何概念都能作任何概念的子节点。例如问题永远不能是
||| 行动的子节点。35 条有效联系描述整个层级。
|||
||| A konstruktorok neve a két fogalom összefűzése:
|||   GyokerCel = „a Gyoker gyereke lehet Cel"
||| Ez a kategóriaelméletben morfizmusnak felel meg.
||| 构造器名是两个概念的缀合：GyokerCel =「Gyoker 的子节点可以是 Cel」。
||| 这在范畴论中对应态射。
public export
data FogalomLogika : FogalomTipus -> FogalomTipus -> Type where
  Azonos          : FogalomLogika a a
  GyokerCel       : FogalomLogika Gyoker Cel
  GyokerDontes    : FogalomLogika Gyoker Dontes
  GyokerSzabaly   : FogalomLogika Gyoker Szabaly
  GyokerMegfigyeles : FogalomLogika Gyoker Megfigyeles
  GyokerKerdes    : FogalomLogika Gyoker Kerdes
  CelReszCel      : FogalomLogika Cel ReszCel
  CelFeladat      : FogalomLogika Cel Feladat
  ReszCelFeladat  : FogalomLogika ReszCel Feladat
  FeladatReszFeladat : FogalomLogika Feladat ReszFeladat
  FeladatCselekves   : FogalomLogika Feladat Cselekves
  FeladatEredmeny    : FogalomLogika Feladat Eredmeny
  ReszFeladatCselekves : FogalomLogika ReszFeladat Cselekves
  CselekvesEredmeny    : FogalomLogika Cselekves Eredmeny
  CselekvesMegfigyeles  : FogalomLogika Cselekves Megfigyeles
  DontesOk             : FogalomLogika Dontes Ok
  DontesValasztas      : FogalomLogika Dontes Valasztas
  DontesElutasitas     : FogalomLogika Dontes Elutasitas
  ValasztasOk          : FogalomLogika Valasztas Ok
  ElutasitasOk         : FogalomLogika Elutasitas Ok
  OkKavzatum           : FogalomLogika Ok Kavzatum
  OkKorlatozas         : FogalomLogika Ok Korlatozas
  MegfigyelesHiba      : FogalomLogika Megfigyeles Hiba
  MegfigyelesEredmeny  : FogalomLogika Megfigyeles Eredmeny
  MegfigyelesMinta     : FogalomLogika Megfigyeles Minta
  MegfigyelesJavitas   : FogalomLogika Megfigyeles Javitas
  MegfigyelesDontes    : FogalomLogika Megfigyeles Dontes
  HibaOk              : FogalomLogika Hiba Ok
  HibaJavitas         : FogalomLogika Hiba Javitas
  JavitasFoltozas     : FogalomLogika Javitas Foltozas
  JavitasInfra        : FogalomLogika Javitas InfraJavitas
  SzabalyKemeny       : FogalomLogika Szabaly KemenySzabaly
  SzabalyEgyezmeny    : FogalomLogika Szabaly Egyezmeny
  EszkozKeszseg      : FogalomLogika Eszkoz Kesztseg
  EszkozModellKornyezetProtokoll : FogalomLogika Eszkoz ModellKornyezetProtokoll
  KerdesMagyarazat    : FogalomLogika Kerdes Magyarazat
  GyokerReszCel       : FogalomLogika Gyoker ReszCel
  GyokerFeladat       : FogalomLogika Gyoker Feladat
  CelReszFeladat      : FogalomLogika Cel ReszFeladat
  CelCselekves        : FogalomLogika Cel Cselekves
  GyokerOk            : FogalomLogika Gyoker Ok
  GyokerValasztas     : FogalomLogika Gyoker Valasztas
  GyokerElutasitas    : FogalomLogika Gyoker Elutasitas
  GyokerHiba          : FogalomLogika Gyoker Hiba
  GyokerEredmeny      : FogalomLogika Gyoker Eredmeny
  GyokerMagyarazat    : FogalomLogika Gyoker Magyarazat
  GyokerKemenySzabaly : FogalomLogika Gyoker KemenySzabaly
  GyokerEgyezmeny     : FogalomLogika Gyoker Egyezmeny
  GyokerJavitas       : FogalomLogika Gyoker Javitas
  MegfigyelesOk       : FogalomLogika Megfigyeles Ok
  HibaKavzatum        : FogalomLogika Hiba Kavzatum
  HibaKorlatozas      : FogalomLogika Hiba Korlatozas
  HibaFoltozas        : FogalomLogika Hiba Foltozas
  HibaInfra           : FogalomLogika Hiba InfraJavitas
  ReszFeladatEredmeny : FogalomLogika ReszFeladat Eredmeny
  -- E8xE8, dualitas, kategoria
  E8xE8Dualitas      : FogalomLogika E8xE8 Dualitas
  E8xE8Kategoria     : FogalomLogika E8xE8 Kategoria
  DualitasCel        : FogalomLogika Dualitas Cel
  DualitasOk         : FogalomLogika Dualitas Ok
  DualitasKavzatum   : FogalomLogika Dualitas Kavzatum
  KategoriaSzimmetria : FogalomLogika Kategoria Szimmetria
  KategoriaTenzor     : FogalomLogika Kategoria Tenzor
  SzimmetriaFunktor   : FogalomLogika Szimmetria Funktor
  TenzorFunktor       : FogalomLogika Tenzor Funktor
  -- Kozvetlen kompoziciok a gyokerbol az uj fogalmakhoz
  GyokerE8xE8        : FogalomLogika Gyoker E8xE8
  GyokerDualitas     : FogalomLogika Gyoker Dualitas
  GyokerKategoria    : FogalomLogika Gyoker Kategoria
  -- Szamok
  GyokerTermeszetesSzam  : FogalomLogika Gyoker TermeszetesSzam
  GyokerEgeszSzam        : FogalomLogika Gyoker EgeszSzam
  GyokerValosSzam        : FogalomLogika Gyoker ValosSzam
  GyokerKomplexSzam      : FogalomLogika Gyoker KomplexSzam
  TermeszetesSzamEgesz   : FogalomLogika TermeszetesSzam EgeszSzam
  EgeszSzamRacionalis    : FogalomLogika EgeszSzam RacionalisSzam
  -- Matematika logika
  GyokerAllitas          : FogalomLogika Gyoker Allitas
  AllitasBizonyitas      : FogalomLogika Allitas Bizonyitas
  BizonyitasGodel        : FogalomLogika Bizonyitas GodelSzam
  AllitasKonzisztencia   : FogalomLogika Allitas Konzisztencia
  AllitasOnhivatkozas    : FogalomLogika Allitas Onhivatkozas
  OnhivatkozasDiagonale  : FogalomLogika Onhivatkozas DiagonaleLemma
  DiagonaleGodelElso     : FogalomLogika DiagonaleLemma GodelElsoTetel
  KonzisztenciaGodelMasodik : FogalomLogika Konzisztencia GodelMasodikTetel
  AllitasBizonyithatosag : FogalomLogika Allitas Bizonyithatosag
  GyokerKonzisztencia    : FogalomLogika Gyoker Konzisztencia
  GyokerOnhivatkozas     : FogalomLogika Gyoker Onhivatkozas
  -- Inkonzisztencia: egy vonal, ket oldalan 2 matematika, i-vel forgatva
  GodelElsoInkonzisztencia : FogalomLogika GodelElsoTetel InkonzisztenciaVonal
  GodelMasodikKonzisztencia : FogalomLogika GodelMasodikTetel InkonzisztenciaVonal
  InkonzisztenciaVonalKetto : FogalomLogika InkonzisztenciaVonal KettoMatematika
  InkonzisztenciaVonalWick  : FogalomLogika InkonzisztenciaVonal WickForgatas
  WickForgatasKomplex       : FogalomLogika WickForgatas KomplexFazis
  WickForgatasIdo           : FogalomLogika WickForgatas Ido
  KettoMatematikaAllitas    : FogalomLogika KettoMatematika Allitas
  GyokerInkonzisztencia     : FogalomLogika Gyoker InkonzisztenciaVonal
  GyokerWick                : FogalomLogika Gyoker WickForgatas
  -- Matematika alapaxiomak
  GyokerHalmazelmelet       : FogalomLogika Gyoker Halmazelmelet
  HalmazelmeletUres         : FogalomLogika Halmazelmelet UresHalmaz
  HalmazelmeletPeano        : FogalomLogika Halmazelmelet PeanoAxiomak
  HalmazelmeletZfc          : FogalomLogika Halmazelmelet ZfcAxiomak
  ZfcKivalasztas            : FogalomLogika ZfcAxiomak KivalasztasiAxioma
  PeanoTermeszetes          : FogalomLogika PeanoAxiomak TermeszetesSzam
  HalmazelmeletSzamossag    : FogalomLogika Halmazelmelet Szamossag
  SzamossagFolytonossag     : FogalomLogika Szamossag FolytonossagiHipotetikus
  UresHalmazVegtelen        : FogalomLogika UresHalmaz Vegtelen
  GyokerPeano               : FogalomLogika Gyoker PeanoAxiomak
  GyokerZfc                 : FogalomLogika Gyoker ZfcAxiomak
  -- Curry-Howard-Lambek
  GyokerChl                 : FogalomLogika Gyoker Chl
  ChlAllitas                : FogalomLogika Chl Allitas
  ChlKategoria              : FogalomLogika Chl Kategoria
  ChlSzimmetria             : FogalomLogika Chl Szimmetria
  -- 4 dimenzio
  GyokerTer              : FogalomLogika Gyoker Ter
  GyokerIdo              : FogalomLogika Gyoker Ido
  GyokerTomeg            : FogalomLogika Gyoker Tomeg
  GyokerInformacio       : FogalomLogika Gyoker InformacioMennyiseg
  TerGeometria           : FogalomLogika Ter Geometria
  IdoFazisAtalakulas     : FogalomLogika Ido FazisAtalakulas
  TomegHomerseklet       : FogalomLogika Tomeg Homerseklet
  InformacioEntropia     : FogalomLogika InformacioMennyiseg Entropia
  -- Fizikai allapot, mechanika
  GyokerFizikaiAllapot   : FogalomLogika Gyoker FizikaiAllapot
  FizikaiAllapotMezo     : FogalomLogika FizikaiAllapot Mezo
  FizikaiAllapotKlasszikus : FogalomLogika FizikaiAllapot KlasszikusMechanika
  KlasszikusLagrange     : FogalomLogika KlasszikusMechanika LagrangeFuggveny
  LagrangeHamilton       : FogalomLogika LagrangeFuggveny HamiltonFuggveny
  LagrangeTranszform     : FogalomLogika LagrangeFuggveny LagrangeTranszformacio
  -- Szimmetriak
  GyokerSzimmetriaCsoport : FogalomLogika Gyoker SzimmetriaCsoport
  GyokerGeometria        : FogalomLogika Gyoker Geometria
  SzimmetriaE8           : FogalomLogika SzimmetriaCsoport E8Szimmetria
  SzimmetriaMertek       : FogalomLogika SzimmetriaCsoport MertekCsoport
  MertekElektromagneses  : FogalomLogika MertekCsoport Elektromagneses
  MertekGyenge           : FogalomLogika MertekCsoport Gyenge
  MertekEros             : FogalomLogika MertekCsoport Eros
  ErosGluon              : FogalomLogika Eros Gluon
  E8Gravitacio           : FogalomLogika E8Szimmetria Gravitacio
  GravitacioKvantum      : FogalomLogika Gravitacio KvantumGravitacio
  KvantumEgyesitett      : FogalomLogika KvantumGravitacio EgyesitettMezo
  EgyesitettStandard     : FogalomLogika EgyesitettMezo StandardModell
  -- Anyag
  GyokerAnyag            : FogalomLogika Gyoker Anyag
  AnyagAntianyag         : FogalomLogika Anyag Antianyag
  AnyagKvark             : FogalomLogika Anyag KvarkSzin
  KvarkSzinSzin          : FogalomLogika KvarkSzin Szin
  SzinToltesAntiszin     : FogalomLogika SzinToltes AntiszinToltes
  -- Kvantum
  GyokerKvantumMechanika : FogalomLogika Gyoker KvantumMechanika
  KvantumMechanikaAllapot : FogalomLogika KvantumMechanika KvantumAllapot
  KvantumAllapotHullam   : FogalomLogika KvantumAllapot HullamFuggveny
  KvantumAllapotOperator  : FogalomLogika KvantumAllapot Operator
  OperatorMegfigyelt     : FogalomLogika Operator Megfigyelt
  KvantumAllapotUgres    : FogalomLogika KvantumAllapot KvantumUgres
  HullamFolytonos        : FogalomLogika HullamFuggveny Folytonos
  UgresNemFolytonos      : FogalomLogika KvantumUgres NemFolytonos
  -- Hullamok
  GyokerHullam           : FogalomLogika Gyoker Hullam
  HullamHang             : FogalomLogika Hullam Hang
  HullamFeny             : FogalomLogika Hullam Feny
  HullamGravitacios      : FogalomLogika Hullam GravitaciosHullam
  HullamRadio            : FogalomLogika Hullam RadioHullam
  FenyElektromagneses    : FogalomLogika Feny Elektromagneses
  GravitaciosGravitacio  : FogalomLogika GravitaciosHullam Gravitacio
  RadioInformacio        : FogalomLogika RadioHullam Informacio
  -- Termodinamika
  GyokerTermodinamika    : FogalomLogika Gyoker Termodinamika
  TermodinamikaCarnot    : FogalomLogika Termodinamika CarnotCiklus
  FluktuacioDisszipacioTetel : FogalomLogika FluktuacioDisszipacioTetele Termodinamika
  FluktuacioDisszip       : FogalomLogika Fluktuacio Disszipacio
  HőTomeg                : FogalomLogika Hő Tomeg
  MunkaTomeg             : FogalomLogika Munka Tomeg
  BelsőHő                : FogalomLogika BelsőEnergia Hő
  InformacioTorlesHő     : FogalomLogika InformacioTorles Hő
  -- Fazis
  FazisAtalakulasAtmenet  : FogalomLogika FazisAtalakulas FazisAtmenet
  FazisAtmenetFluktuacio  : FogalomLogika FazisAtmenet Fluktuacio
  FazisElolasDisszipacio  : FogalomLogika FazisElolas Disszipacio
  -- Kommunikacio
  GyokerKommunikacio     : FogalomLogika Gyoker Kommunikacio
  InformacioKommunikacio  : FogalomLogika Informacio Kommunikacio
  KommunikacioCsatorna   : FogalomLogika Kommunikacio Csatorna
  KommunikacioKod        : FogalomLogika Kommunikacio Kod
  KommunikacioJel        : FogalomLogika Kommunikacio Jel
  CsatornaZaj            : FogalomLogika Csatorna Zaj
  -- Bit = Landauer
  BitInformacio          : FogalomLogika Bit Informacio
  BitHo                  : FogalomLogika Bit Hő
  BitDisszipacio         : FogalomLogika Bit Disszipacio
  GyokerBit              : FogalomLogika Gyoker Bit
  -- Folytonossag
  GyokerFolytonos        : FogalomLogika Gyoker Folytonos
  FolytonosCodata        : FogalomLogika Folytonos Codata
  NemFolytonosSorozat    : FogalomLogika NemFolytonos Sorozat
  SorozatHatar           : FogalomLogika Sorozat Hatar
  HatarVegtelen          : FogalomLogika Hatar Vegtelen
  -- Standard Modell
  StandardElektromagneses : FogalomLogika StandardModell Elektromagneses
  StandardGyenge          : FogalomLogika StandardModell Gyenge
  StandardEros            : FogalomLogika StandardModell Eros
  StandardAnyag           : FogalomLogika StandardModell Anyag
  StandardKvantum         : FogalomLogika StandardModell KvantumMechanika
  -- Kepzetes egyseg, ij szorzat, katernio, okternio, tukrozesek
  GyokerKepzetesEgyseg    : FogalomLogika Gyoker KepzetesEgyseg
  KomplexKepzetes         : FogalomLogika KomplexSzam KepzetesEgyseg
  WickKepzetes            : FogalomLogika WickForgatas KepzetesEgyseg
  KepzetesIj              : FogalomLogika KepzetesEgyseg IjSzorzat
  IjKaternio              : FogalomLogika IjSzorzat Katernio
  KepzetesKaternio        : FogalomLogika KepzetesEgyseg Katernio
  KaternioOkternio        : FogalomLogika Katernio Okternio
  E8Okternio              : FogalomLogika E8Szimmetria Okternio
  OkternioTukor           : FogalomLogika Okternio OkternioTukor
  OkternioTukorFizika     : FogalomLogika OkternioTukor FizikaTukor
  GyokerFizikaTukor       : FogalomLogika Gyoker FizikaTukor
  FizikaTukorSzimmetria   : FogalomLogika FizikaTukor Szimmetria
  FizikaTukorDualitas     : FogalomLogika FizikaTukor Dualitas
  -- Kanti kategoriaelmelet
  GyokerKantiKategoria    : FogalomLogika Gyoker KantiKategoria
  KantiAppercepcio        : FogalomLogika KantiKategoria TranszcendentalisAppercepcio
  KantiDialektika         : FogalomLogika KantiKategoria TranszcendentalisDialektika
  AppercepcioKategoria    : FogalomLogika TranszcendentalisAppercepcio Kategoria
  DialektikaInkonzisztencia : FogalomLogika TranszcendentalisDialektika InkonzisztenciaVonal
  DialektikaDualitas      : FogalomLogika TranszcendentalisDialektika Dualitas
  -- Matematikai allandok es operatorok
  GyokerEuler             : FogalomLogika Gyoker EulerSzam
  GyokerPi                : FogalomLogika Gyoker Pi
  GyokerOsszeadas         : FogalomLogika Gyoker Osszeadas
  OsszeadasKivonas        : FogalomLogika Osszeadas Kivonas
  OsszeadasSzorzas        : FogalomLogika Osszeadas Szorzas
  SzorzasOsztas           : FogalomLogika Szorzas Osztas
  SzorzasHatvanyozas      : FogalomLogika Szorzas Hatvanyozas
  HatvanyozasGyokvonas    : FogalomLogika Hatvanyozas Gyokvonas
  PiEuler                 : FogalomLogika Pi EulerSzam
  -- Euler-azonossag: e^(i·pi) + 1 = 0
  -- A bizonyítás lánca:
  --   KepzetesEgyseg → Szorzas × Pi → Hatvanyozas(EulerSzam, _) → Osszeadas → EulerAzonossag
  EulerKepzetesSzorzas    : FogalomLogika KepzetesEgyseg Szorzas
  PiSzorzas               : FogalomLogika Pi Szorzas
  EulerHatvanyozas        : FogalomLogika EulerSzam Hatvanyozas
  SzorzasHatvany          : FogalomLogika Szorzas Hatvanyozas
  HatvanyozasOsszeadas    : FogalomLogika Hatvanyozas Osszeadas
  OsszeadasAzonossag      : FogalomLogika Osszeadas EulerAzonossag
  -- [[15,1,3]] kod, T-kapu, M-Elmelet
  GyokerTizenotKod        : FogalomLogika Gyoker TizenotKod
  TizenotTGate            : FogalomLogika TizenotKod TGate
  TGateMElmelet           : FogalomLogika TGate MElmelet
  MElmeletE8              : FogalomLogika MElmelet E8Szimmetria
  -- Pauli csoport, stabilizatorok, kapuk
  GyokerPauli             : FogalomLogika Gyoker PauliCsoport
  PauliStabilizator       : FogalomLogika PauliCsoport Stabilizator
  StabilizatorKapu        : FogalomLogika Stabilizator Kapu
  TGateKapu               : FogalomLogika TGate Kapu

||| Fa-csomópont adatai. / 树节点的数据。
||| Minden csomópontnak van: / 每个节点都有：
|||   címke = a csomópont neve (String, mert ez megjelenítéshez kell)
|||   címke = 节点名（String——显示所需）
|||   leírás = részletes leírás (String, mert ez emberi olvasásra)
|||   leírás = 详细描述（String——供人阅读）
|||   hivatkozások = kapcsolódó referenciák listája / 相关引用
|||   bizalom = a csomópont megbízhatósága 0 és 1 között / 可信度介于 0 与 1 之间
|||
||| A String itt kivétel — a megjelenítéshez és emberi olvasáshoz
||| van, nem a logikai mag része. A mag típusok (FogalomTipus, eset)
||| nem használnak Stringet.
||| 此处的 String 是例外——为显示与阅读而设，并非逻辑核心的一部分。
||| 核心类型（FogalomTipus、格）不使用 String。
public export
record FogalomAdat where
  constructor AdatKonstruktor
  cimke : String
  leiras : String
  hivatkozasok : List String
  bizalom : Double

||| Fogalom-fa: egy csomópont, amély a FogalomTipus alapján
||| 概念树：一个节点，依据 FogalomTipus 包含其在层级中的位置。
||| tartalmazza a hierarchiában elfoglalt helyet。
|||
||| A fa kétféle lehet：（树有两种形态：叶 Level 与枝 Ag。）
|||   Level = levél (nincs gyereke)
|||   Ag = ág (van gyereke, és megadja a kapcsolat típusát is)（枝：有子节点并给出联系类型）
|||
||| Az Ag a dependens típussal biztosítja, hogy minden gyerek
||| Ag 以依赖类型保证每个子节点的联系都是合法的 FogalomLogika。
||| kapcsolata érvényes FogalomLogika legyen。
public export
data FogalomFa : FogalomTipus -> Type where
  Level  : FogalomAdat -> FogalomFa t
  Ag     : FogalomAdat
         -> List (s : FogalomTipus ** (FogalomFa s, FogalomLogika t s))
         -> FogalomFa t

||| A három kubit kapcsolata a faszerkezetben。
||| 三个 kubit 在树结构中的联系。VilagFa 统一三个视角：
||| A VilagFa egyesíti a három nézőpontot:
|||   sajat = a rendszer saját fogalomfája (C = töltés)（自己：系统自身的概念树）
|||   masik = a másik fél fogalomfája  (P = paritás)（对方：他方的概念树）
|||   fazis = a kapcsolat fázisa (T = idő)（相位：联系的相位）
|||
||| Ez a három együtt adja a teljes CPT-szimmetriát。（三者合成完整的 CPT 对称。）
public export
record VilagFa where
  constructor VilagFaKonstruktor
  sajat : FogalomFa Gyoker     -- a rendszer sajat nezoPontja (C)
  masik : FogalomFa Gyoker     -- a masik fel nezoPontja (P)
  fazis : FogalomAdat          -- a kapcsolat fazisa (T)

||| Faméret: a csomópontok száma a fában。
||| 树的大小：树中节点的数目。
||| Ez egy rekurzív számlálás: minden levél 1, minden ág
||| 递归计数：每叶为 1，每枝为 1 加上子树大小之和。
||| 1 plusz a gyerekek méretének összege。
|||
||| Kategóriaelméleti értelemben ez egy funktor a
||| 范畴论意义上，这是一个从
||| FogalomFa-kategóriából a Nat-monoidba。（FogalomFa 范畴到 Nat 幺半群。）
public export
meret : FogalomFa t -> Nat
meret (Level _) = 1
meret (Ag _ gyerekek) = 1 + sum (map (\(s ** (fa, _)) => meret fa) gyerekek)

||| Bizalom-átlag: a fa összes csomópontjának bizalom-átlaga。
||| 信任均值：树中所有节点信任的平均值。
||| Ez a koherencia egy merteke — ha alacsony, a fa reszben
||| megbízhatatlan (többszörös hiba)。（不可信（多重错误）。）
public export
bizalomAtlag : FogalomFa t -> Double
bizalomAtlag (Level adat) = adat.bizalom
bizalomAtlag (Ag adat gyerekek) =
  let sajat = adat.bizalom
      gyerekBizalom = map (\(s ** (fa, _)) => bizalomAtlag fa) gyerekek
  in (sajat + sum gyerekBizalom) / cast (1 + length gyerekek)

||| Gyerekek száma egy csomópontban。（一个节点中子节点的数目。）
public export
gyerekekSzama : FogalomFa t -> Nat
gyerekekSzama (Level _) = 0
gyerekekSzama (Ag _ gyerekek) = length gyerekek

-- ═══════════════════════════════════════════════════════════════
-- 7+7+1 KATEGORIA RENDSZER
-- ═══════════════════════════════════════════════════════════════

||| 7+7+1 kategória-típus: Emberi (7 kvantum), Szamitasi (7 klasszikus), Perem (1 Legendre)。（7+7+1 范畴类型：人类（7 量子）、计算（7 经典）、边界（1 勒让德）。）
public export
data KategoriaTipus : Type where
  KategoriaEmberi   : EmberiKategoria -> KategoriaTipus
  KategoriaSzamitasi : SzamitasiKategoria -> KategoriaTipus
  KategoriaPerem    : KategoriaTipus

||| Logikai kapcsolatok a 7+7+1 kategóriák között。（7+7+1 范畴之间的逻辑联系。）
|||   Emberi belso: Ido → Oksag → Ter → Szin → Hang → Fazis → Mod
|||   Szamitasi belso: Utem → Vezerles → Adat → Tipus → Kapcsolat → Allapot → Utasitas
|||   Perem: Fazis (emberi) ↔ Allapot (szamitasi) — Legendre adjunkcio
public export
data FogalomLogika714 : KategoriaTipus -> KategoriaTipus -> Type where
  -- Emberi kategoriak kore: Ido → Oksag → Ter → Szin → Hang → Fazis → Mod
  EmberiIdoOksag     : FogalomLogika714 (KategoriaEmberi EmberiIdo) (KategoriaEmberi EmberiOksag)
  EmberiOksagTer     : FogalomLogika714 (KategoriaEmberi EmberiOksag) (KategoriaEmberi EmberiTer)
  EmberiTerSzin      : FogalomLogika714 (KategoriaEmberi EmberiTer) (KategoriaEmberi EmberiSzin)
  EmberiSzinHang     : FogalomLogika714 (KategoriaEmberi EmberiSzin) (KategoriaEmberi EmberiHang)
  EmberiHangFazis    : FogalomLogika714 (KategoriaEmberi EmberiHang) (KategoriaEmberi EmberiFazis)
  EmberiFazisMod     : FogalomLogika714 (KategoriaEmberi EmberiFazis) (KategoriaEmberi EmberiMod)

  -- Szamitasi kategoriak kore: Utem → Vezerles → Adat → Tipus → Kapcsolat → Allapot → Utasitas
  SzamUtemVezerles   : FogalomLogika714 (KategoriaSzamitasi SzamUtem) (KategoriaSzamitasi SzamVezerles)
  SzamVezerlesAdat   : FogalomLogika714 (KategoriaSzamitasi SzamVezerles) (KategoriaSzamitasi SzamAdat)
  SzamAdatTipus      : FogalomLogika714 (KategoriaSzamitasi SzamAdat) (KategoriaSzamitasi SzamTipus)
  SzamTipusKapcsolat : FogalomLogika714 (KategoriaSzamitasi SzamTipus) (KategoriaSzamitasi SzamKapcsolat)
  SzamKapcsolatAllapot : FogalomLogika714 (KategoriaSzamitasi SzamKapcsolat) (KategoriaSzamitasi SzamAllapot)
  SzamAllapotUtasitas : FogalomLogika714 (KategoriaSzamitasi SzamAllapot) (KategoriaSzamitasi SzamUtasitas)

  -- Perem: Legendre adjunkcio — Emberi.Fazis ↔ Perem ↔ Szamitasi.Allapot
  FazisPerem         : FogalomLogika714 (KategoriaEmberi EmberiFazis) KategoriaPerem
  PeremAllapot       : FogalomLogika714 KategoriaPerem (KategoriaSzamitasi SzamAllapot)

  -- Kozvetlen Legendre parok: minden emberi kategoriaban van egy szamitasi parja
  EmberiSzamitasiPar : (emberi : EmberiKategoria) -> (szamitasi : SzamitasiKategoria)
                    -> FogalomLogika714 (KategoriaEmberi emberi) (KategoriaSzamitasi szamitasi)

||| FogalomTipus → KategoriaTipus lekepezes.
||| Minden FogalomTipus besorolható a 7+7+1 rendszerbe。（每个 FogalomTipus 都可归入 7+7+1 系统。）
public export
fogalomTipusToKategoria : FogalomTipus -> KategoriaTipus
fogalomTipusToKategoria Gyoker = KategoriaEmberi EmberiIdo
fogalomTipusToKategoria Cel = KategoriaEmberi EmberiOksag
fogalomTipusToKategoria ReszCel = KategoriaEmberi EmberiTer
fogalomTipusToKategoria Feladat = KategoriaEmberi EmberiTer
fogalomTipusToKategoria ReszFeladat = KategoriaEmberi EmberiTer
fogalomTipusToKategoria Cselekves = KategoriaEmberi EmberiSzin
fogalomTipusToKategoria Eredmeny = KategoriaEmberi EmberiHang
fogalomTipusToKategoria Megfigyeles = KategoriaEmberi EmberiFazis
fogalomTipusToKategoria Hiba = KategoriaEmberi EmberiFazis
fogalomTipusToKategoria Javitas = KategoriaEmberi EmberiMod
fogalomTipusToKategoria Minta = KategoriaEmberi EmberiSzin
fogalomTipusToKategoria Foltozas = KategoriaEmberi EmberiMod
fogalomTipusToKategoria InfraJavitas = KategoriaEmberi EmberiMod
fogalomTipusToKategoria Dontes = KategoriaSzamitasi SzamVezerles
fogalomTipusToKategoria Valasztas = KategoriaSzamitasi SzamUtasitas
fogalomTipusToKategoria Elutasitas = KategoriaSzamitasi SzamUtasitas
fogalomTipusToKategoria Ok = KategoriaSzamitasi SzamAllapot
fogalomTipusToKategoria Kavzatum = KategoriaSzamitasi SzamAllapot
fogalomTipusToKategoria Korlatozas = KategoriaSzamitasi SzamVezerles
fogalomTipusToKategoria Szabaly = KategoriaSzamitasi SzamUtasitas
fogalomTipusToKategoria KemenySzabaly = KategoriaSzamitasi SzamUtasitas
fogalomTipusToKategoria Egyezmeny = KategoriaSzamitasi SzamKapcsolat
fogalomTipusToKategoria Eszkoz = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria Kesztseg = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria ModellKornyezetProtokoll = KategoriaSzamitasi SzamTipus
fogalomTipusToKategoria Kerdes = KategoriaSzamitasi SzamKapcsolat
fogalomTipusToKategoria Magyarazat = KategoriaSzamitasi SzamTipus
fogalomTipusToKategoria E8xE8 = KategoriaEmberi EmberiSzin
fogalomTipusToKategoria Dualitas = KategoriaEmberi EmberiFazis
fogalomTipusToKategoria Kategoria = KategoriaSzamitasi SzamTipus
fogalomTipusToKategoria Szimmetria = KategoriaEmberi EmberiHang
fogalomTipusToKategoria Tenzor = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria Funktor = KategoriaSzamitasi SzamVezerles
-- Szamok
fogalomTipusToKategoria Szam = KategoriaPerem
fogalomTipusToKategoria TermeszetesSzam = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria EgeszSzam = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria RacionalisSzam = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria ValosSzam = KategoriaSzamitasi SzamAdat
fogalomTipusToKategoria KomplexSzam = KategoriaSzamitasi SzamAdat
-- Minden mas
fogalomTipusToKategoria _ = KategoriaEmberi EmberiMod

||| [[15,1,3]] teljes állapot: 7 emberi + 7 számítási + 1 perem = 15+1 bit。（[[15,1,3]] 完整状态：7 人类 + 7 计算 + 1 边界 = 15+1 位。）
||| A perem a Legendre transzformacio: p·q̇ = Yoneda parositas.
public export
data TizenotEgyAllapot : Type where
  TizenotEgyKonstruktor : (emberi : HetesKod) -> (szamitasi : HetesKod) -> (perem : Kubit) -> TizenotEgyAllapot

||| [[15,1,3]] kodolas: |0> → (|0_e>, |0_s>, 0), |1> → (|1_e>, |1_s>, 1)
public export
tizenotEgyKodol : Kubit -> TizenotEgyAllapot
tizenotEgyKodol k = TizenotEgyKonstruktor (alapKod k) (alapKod k) k

||| [[15,1,3]] dekódolás: többségi szavazat。（[[15,1,3]] 解码：多数表决。）
|||   Ha az emberi és számítási oldal egyetért, azt adjuk。（若人类侧与计算侧一致，则取之。）
|||   Ha nem, a perem dönt (Legendre-adjunkció)。（否则由边界决定（勒让德伴随）。）
public export
tizenotEgyDekodol : TizenotEgyAllapot -> Kubit
tizenotEgyDekodol (TizenotEgyKonstruktor e s p) =
  let ke = steaneDekodol e
      ks = steaneDekodol s
  in if ke == ks then ke else p

||| [[15,1,3]] kód-törvény: kódolás majd dekódolás = azonosság。（[[15,1,3]] 码律：编码再解码 = 恒等。）
public export
tizenotEgyTorveny : (k : Kubit) -> tizenotEgyDekodol (tizenotEgyKodol k) = k
tizenotEgyTorveny Nulla = Refl
tizenotEgyTorveny Egy   = Refl
