module AffinE8KarakterLevezetes

import Data.List
import E8SteaneLevezetes

%default total

-- =====================================================================
-- AZ AFFIN E8 ELSŐ SZINTŰ KARAKTERÉNEK VÉGES LEVEZETÉSE
--
-- Ez a modul nem kvantumhibajavító kódot készít.
--
-- A matematikai lánc:
--
--   [8,4,4] kiterjesztett Hamming-kód
--       -> Construction A
--   E8-rács
--       -> rács-vertexoperátor-algebra
--   az affin E8 első szintű alapreprezentációja.
--
-- Az általános izomorfia a Frenkel--Kac-tétel irodalmi eredménye.
-- Az Idris-kernel itt a lánc első véges együtthatóit számolja ki:
--
--   théta-sor:       1, 240, 2160, 6720
--   oszcillátorsor:  1,   8,   44,  192
--   karakter:        1, 248, 4124, 34752
--
-- A karakter köbének első együtthatói:
--
--   1, 744, 196884, 21493760,
--
-- amelyek a q^(-1) kezdőfok eltolása után a moduláris j-invariáns
-- első együtthatói. A teljes karakterazonosság irodalmi tétel;
-- a modul csak a feltüntetett véges kezdőszeletet bizonyítja.
-- =====================================================================

-- =====================================================================
-- 1. VÉGES POLINOMARITMETIKA
-- =====================================================================

public export
listaEgyutthatonkentOsszead : List Nat -> List Nat -> List Nat
listaEgyutthatonkentOsszead [] jobb = jobb
listaEgyutthatonkentOsszead bal [] = bal
listaEgyutthatonkentOsszead
  (balElem :: tobbiBalElem)
  (jobbElem :: tobbiJobbElem) =
    (balElem + jobbElem) ::
    listaEgyutthatonkentOsszead tobbiBalElem tobbiJobbElem

public export
listaEgyutthatonkentSkalaz : Nat -> List Nat -> List Nat
listaEgyutthatonkentSkalaz szorzo =
  map (\egyutthato => szorzo * egyutthato)

public export
polinomTeljesSzorzata : List Nat -> List Nat -> List Nat
polinomTeljesSzorzata [] _ = []
polinomTeljesSzorzata (balElem :: tobbiBalElem) jobb =
  listaEgyutthatonkentOsszead
    (map (\jobbElem => balElem * jobbElem) jobb)
    (0 :: polinomTeljesSzorzata tobbiBalElem jobb)

public export
polinomCsonkoltSzorzata :
  (egyutthatokSzama : Nat) -> List Nat -> List Nat -> List Nat
polinomCsonkoltSzorzata egyutthatokSzama bal jobb =
  take egyutthatokSzama
    (polinomTeljesSzorzata bal jobb ++
     replicate egyutthatokSzama 0)

public export
polinomEgyseg : (egyutthatokSzama : Nat) -> List Nat
polinomEgyseg Z = []
polinomEgyseg (S tobbiEgyutthatoSzama) =
  1 :: replicate tobbiEgyutthatoSzama 0

public export
polinomCsonkoltHatvanya :
  (egyutthatokSzama : Nat) -> Nat -> List Nat -> List Nat
polinomCsonkoltHatvanya egyutthatokSzama Z _ =
  polinomEgyseg egyutthatokSzama
polinomCsonkoltHatvanya egyutthatokSzama (S kisebbHatvany) polinom =
  polinomCsonkoltSzorzata
    egyutthatokSzama
    polinom
    (polinomCsonkoltHatvanya
      egyutthatokSzama kisebbHatvany polinom)

public export
listaElemVagyNulla : Nat -> List Nat -> Nat
listaElemVagyNulla _ [] = 0
listaElemVagyNulla Z (elem :: _) = elem
listaElemVagyNulla (S kisebbIndex) (_ :: tobbiElem) =
  listaElemVagyNulla kisebbIndex tobbiElem

public export
binomialis : Nat -> Nat -> Nat
binomialis _ Z = 1
binomialis Z (S _) = 0
binomialis (S felso) (S also) =
  binomialis felso also + binomialis felso (S also)

-- =====================================================================
-- 2. CONSTRUCTION A THÉTA-SOR A KÓD SÚLYELOSZLÁSÁBÓL
--
-- A négy szükséges egész fokot a három kódszó-súlyosztály szerint
-- bontjuk fel. Ez ugyanaz a súlyfelsoroló-helyettesítés, de minden
-- együttható véges kombinatorikus receptként látható.
--
-- Nulla súlyú kódszó:
--   a nemnulla koordináták +-2 értékűek;
--   az n-edik fokhoz n koordinátát választunk és mindnek két előjele van.
--
-- Négy súlyú kódszó:
--   az alapállapot négy darab +-1 koordináta, ezért 2^4 lehetőség;
--   a következő fokokat a négy páros koordináta +-2 gerjesztése,
--   illetve egy páratlan koordináta +-1 helyett +-3 értéke adja.
--
-- Nyolc súlyú kódszó:
--   nyolc darab +-1 koordináta, ezért a második fokon 2^8 lehetőség.
-- =====================================================================

public export
AtvettNullaSulyuKodSzavakSzama : Nat
AtvettNullaSulyuKodSzavakSzama = 1

public export
AtvettNegySulyuKodSzavakSzama : Nat
AtvettNegySulyuKodSzavakSzama = 14

public export
AtvettNyolcSulyuKodSzavakSzama : Nat
AtvettNyolcSulyuKodSzavakSzama = 1

BizonyitasKodSulyeloszlasAtvetele :
  [ E8KodNullaSulyuSzavai
  , E8KodNegySulyuSzavai
  , E8KodNyolcSulyuSzavai
  ] =
  [ AtvettNullaSulyuKodSzavakSzama
  , AtvettNegySulyuKodSzavakSzama
  , AtvettNyolcSulyuKodSzavakSzama
  ]
BizonyitasKodSulyeloszlasAtvetele =
  trans
    (cong
      (\nullaSulyuSzavakSzama =>
        [ nullaSulyuSzavakSzama
        , E8KodNegySulyuSzavai
        , E8KodNyolcSulyuSzavai
        ])
      BizonyitasE8KodNullaSulyuSzavai)
    (trans
      (cong
        (\negySulyuSzavakSzama =>
          [ 1
          , negySulyuSzavakSzama
          , E8KodNyolcSulyuSzavai
          ])
        BizonyitasE8KodNegySulyuSzavai)
      (cong
        (\nyolcSulyuSzavakSzama =>
          [1, 14, nyolcSulyuSzavakSzama])
        BizonyitasE8KodNyolcSulyuSzavai))

public export
NullaSulyuKodSzoThetaEgeszFokSor : List Nat
NullaSulyuKodSzoThetaEgeszFokSor =
  listaEgyutthatonkentSkalaz AtvettNullaSulyuKodSzavakSzama
    [ 1
    , binomialis 8 1 * kettoHatvany 1
    , binomialis 8 2 * kettoHatvany 2
    , binomialis 8 3 * kettoHatvany 3
    ]

public export
NegySulyuKodSzoThetaEgeszFokSor : List Nat
NegySulyuKodSzoThetaEgeszFokSor =
  listaEgyutthatonkentSkalaz AtvettNegySulyuKodSzavakSzama
    [ 0
    , kettoHatvany 4
    , (binomialis 4 1 * kettoHatvany 1) * kettoHatvany 4
    , (binomialis 4 2 * kettoHatvany 2) * kettoHatvany 4 +
      4 * kettoHatvany 4
    ]

public export
NyolcSulyuKodSzoThetaEgeszFokSor : List Nat
NyolcSulyuKodSzoThetaEgeszFokSor =
  listaEgyutthatonkentSkalaz AtvettNyolcSulyuKodSzavakSzama
    [0, 0, kettoHatvany 8, 0]

public export
E8ThetaHaromFokig : List Nat
E8ThetaHaromFokig =
  listaEgyutthatonkentOsszead
    NullaSulyuKodSzoThetaEgeszFokSor
    (listaEgyutthatonkentOsszead
      NegySulyuKodSzoThetaEgeszFokSor
      NyolcSulyuKodSzoThetaEgeszFokSor)

BizonyitasE8ThetaHaromFokig :
  E8ThetaHaromFokig = [1, 240, 2160, 6720]
BizonyitasE8ThetaHaromFokig = Refl

-- =====================================================================
-- 3. NYOLCSZÍNŰ BOZONIKUS OSZCILLÁTORSOR
--
-- Nyolc megkülönböztethető oszcillátorszín között r gerjesztés
-- szétosztásainak száma:
--
--   binomiális(r + 7, 7).
--
-- A harmadik fokig csak az első három frekvenciamód kell.
-- =====================================================================

public export
nyolcSzinuElosztasokSzama : Nat -> Nat
nyolcSzinuElosztasokSzama gerjesztesekSzama =
  binomialis (gerjesztesekSzama + 7) 7

public export
ElsoFrekvenciaModusSor : List Nat
ElsoFrekvenciaModusSor =
  [ nyolcSzinuElosztasokSzama 0
  , nyolcSzinuElosztasokSzama 1
  , nyolcSzinuElosztasokSzama 2
  , nyolcSzinuElosztasokSzama 3
  ]

public export
MasodikFrekvenciaModusSor : List Nat
MasodikFrekvenciaModusSor =
  [nyolcSzinuElosztasokSzama 0, 0,
   nyolcSzinuElosztasokSzama 1, 0]

public export
HarmadikFrekvenciaModusSor : List Nat
HarmadikFrekvenciaModusSor =
  [nyolcSzinuElosztasokSzama 0, 0, 0,
   nyolcSzinuElosztasokSzama 1]

BizonyitasElsoFrekvenciaModusSor :
  ElsoFrekvenciaModusSor = [1, 8, 36, 120]
BizonyitasElsoFrekvenciaModusSor = Refl

public export
NyolcSzinuOszcillatorSorHaromFokig : List Nat
NyolcSzinuOszcillatorSorHaromFokig =
  polinomCsonkoltSzorzata 4
    ElsoFrekvenciaModusSor
    (polinomCsonkoltSzorzata 4
      MasodikFrekvenciaModusSor
      HarmadikFrekvenciaModusSor)

BizonyitasNyolcSzinuOszcillatorSorHaromFokig :
  NyolcSzinuOszcillatorSorHaromFokig = [1, 8, 44, 192]
BizonyitasNyolcSzinuOszcillatorSorHaromFokig = Refl

-- =====================================================================
-- 4. AZ AFFIN E8 ELSŐ SZINTŰ KARAKTERE
--
-- A rács-vertexoperátor-algebra karakterének fokozott dimenziói a
-- théta-sor és a nyolcszínű oszcillátorsor konvolúciójából adódnak.
-- =====================================================================

public export
listaEgeszElemVagyNulla : Nat -> List Integer -> Integer
listaEgeszElemVagyNulla _ [] = 0
listaEgeszElemVagyNulla Z (elem :: _) = elem
listaEgeszElemVagyNulla (S kisebbIndex) (_ :: tobbiElem) =
  listaEgeszElemVagyNulla kisebbIndex tobbiElem

public export
affinE8KarakterRecept : List Nat -> List Nat -> List Integer
affinE8KarakterRecept thetaSor oszcillatorSor =
  [ cast (listaElemVagyNulla 0 thetaSor) *
      cast (listaElemVagyNulla 0 oszcillatorSor)
  , cast (listaElemVagyNulla 1 thetaSor) *
      cast (listaElemVagyNulla 0 oszcillatorSor) +
    cast (listaElemVagyNulla 0 thetaSor) *
      cast (listaElemVagyNulla 1 oszcillatorSor)
  , cast (listaElemVagyNulla 2 thetaSor) *
      cast (listaElemVagyNulla 0 oszcillatorSor) +
    cast (listaElemVagyNulla 1 thetaSor) *
      cast (listaElemVagyNulla 1 oszcillatorSor) +
    cast (listaElemVagyNulla 0 thetaSor) *
      cast (listaElemVagyNulla 2 oszcillatorSor)
  , cast (listaElemVagyNulla 3 thetaSor) *
      cast (listaElemVagyNulla 0 oszcillatorSor) +
    cast (listaElemVagyNulla 2 thetaSor) *
      cast (listaElemVagyNulla 1 oszcillatorSor) +
    cast (listaElemVagyNulla 1 thetaSor) *
      cast (listaElemVagyNulla 2 oszcillatorSor) +
    cast (listaElemVagyNulla 0 thetaSor) *
      cast (listaElemVagyNulla 3 oszcillatorSor)
  ]

public export
AffinE8ElsoSzintuKarakterHaromFokig : List Integer
AffinE8ElsoSzintuKarakterHaromFokig =
  affinE8KarakterRecept
    E8ThetaHaromFokig NyolcSzinuOszcillatorSorHaromFokig

BizonyitasAffinE8ElsoSzintuKarakterHaromFokig :
  AffinE8ElsoSzintuKarakterHaromFokig =
    [1, 248, 4124, 34752]
BizonyitasAffinE8ElsoSzintuKarakterHaromFokig =
  trans
    (cong
      (\thetaSor =>
        affinE8KarakterRecept
          thetaSor NyolcSzinuOszcillatorSorHaromFokig)
      BizonyitasE8ThetaHaromFokig)
    (trans
      (cong
        (affinE8KarakterRecept [1, 240, 2160, 6720])
        BizonyitasNyolcSzinuOszcillatorSorHaromFokig)
      Refl)

public export
AtvettE8GyokokSzama : Nat
AtvettE8GyokokSzama = 240

BizonyitasE8GyokszamAtvetele :
  E8MinimalisVektorokSzama = AtvettE8GyokokSzama
BizonyitasE8GyokszamAtvetele =
  trans BizonyitasE8MinimalisVektorokSzama Refl

public export
ElsoFokGyokEsCartanUton : Integer
ElsoFokGyokEsCartanUton =
  cast AtvettE8GyokokSzama + cast E8Rang

public export
ElsoFokKarakterUton : Integer
ElsoFokKarakterUton =
  listaEgeszElemVagyNulla 1 AffinE8ElsoSzintuKarakterHaromFokig

BizonyitasElsoFokGyokEsCartanKetszazNegyvennyolc :
  ElsoFokGyokEsCartanUton = 248
BizonyitasElsoFokGyokEsCartanKetszazNegyvennyolc = Refl

BizonyitasElsoFokKetszazNegyvennyolc :
  ElsoFokKarakterUton = 248
BizonyitasElsoFokKetszazNegyvennyolc =
  cong
    (listaEgeszElemVagyNulla 1)
    BizonyitasAffinE8ElsoSzintuKarakterHaromFokig

BizonyitasElsoFokKetFuggetlenUton :
  ElsoFokGyokEsCartanUton = ElsoFokKarakterUton
BizonyitasElsoFokKetFuggetlenUton =
  trans
    BizonyitasElsoFokGyokEsCartanKetszazNegyvennyolc
    (sym BizonyitasElsoFokKetszazNegyvennyolc)

public export
masodikFokFelbontasRecept : List Nat -> List Nat -> Integer
masodikFokFelbontasRecept thetaSor oszcillatorSor =
  cast (listaElemVagyNulla 2 thetaSor) +
  cast (listaElemVagyNulla 1 thetaSor) *
    cast (listaElemVagyNulla 1 oszcillatorSor) +
  cast (listaElemVagyNulla 2 oszcillatorSor)

public export
MasodikFokFelbontasUton : Integer
MasodikFokFelbontasUton =
  masodikFokFelbontasRecept
    E8ThetaHaromFokig NyolcSzinuOszcillatorSorHaromFokig

BizonyitasMasodikFokNegyezerSzazHuszonnegy :
  MasodikFokFelbontasUton = 4124
BizonyitasMasodikFokNegyezerSzazHuszonnegy =
  trans
    (cong
      (\thetaSor =>
        masodikFokFelbontasRecept
          thetaSor NyolcSzinuOszcillatorSorHaromFokig)
      BizonyitasE8ThetaHaromFokig)
    (trans
      (cong
        (masodikFokFelbontasRecept [1, 240, 2160, 6720])
        BizonyitasNyolcSzinuOszcillatorSorHaromFokig)
      Refl)

public export
harmadikFokFelbontasRecept : List Nat -> List Nat -> Integer
harmadikFokFelbontasRecept thetaSor oszcillatorSor =
  cast (listaElemVagyNulla 3 thetaSor) +
  cast (listaElemVagyNulla 2 thetaSor) *
    cast (listaElemVagyNulla 1 oszcillatorSor) +
  cast (listaElemVagyNulla 1 thetaSor) *
    cast (listaElemVagyNulla 2 oszcillatorSor) +
  cast (listaElemVagyNulla 3 oszcillatorSor)

public export
HarmadikFokFelbontasUton : Integer
HarmadikFokFelbontasUton =
  harmadikFokFelbontasRecept
    E8ThetaHaromFokig NyolcSzinuOszcillatorSorHaromFokig

BizonyitasHarmadikFokHarmincNegyezerHetszazOtvenketto :
  HarmadikFokFelbontasUton = 34752
BizonyitasHarmadikFokHarmincNegyezerHetszazOtvenketto =
  trans
    (cong
      (\thetaSor =>
        harmadikFokFelbontasRecept
          thetaSor NyolcSzinuOszcillatorSorHaromFokig)
      BizonyitasE8ThetaHaromFokig)
    (trans
      (cong
        (harmadikFokFelbontasRecept [1, 240, 2160, 6720])
        BizonyitasNyolcSzinuOszcillatorSorHaromFokig)
      Refl)

-- =====================================================================
-- 5. A MODULÁRIS j-INVARIÁNS KÖBGYÖKÉNEK VÉGES ELLENŐRZÉSE
--
-- A normalizált karakter q^(-1/3) szorzójának köbe q^(-1).
-- Ezért az alábbi lista rendre a q^(-1), q^0, q^1 és q^2
-- együtthatóját adja a karakter köbében.
--
-- A köb nagy együtthatóit Integer felett normalizáljuk. Idris 2 0.8.0
-- a típusszintű Nat-szorzást Peano-alakban végzi, ezért a 248^3
-- közvetlen Nat-Refl ellenőrzése indokolatlanul nagy fordítási fát ad.
-- =====================================================================

public export
karakterKobRecept : List Integer -> List Integer
karakterKobRecept karakterSor =
  [ listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 0 karakterSor
  , 3 *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor
  , 3 *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 2 karakterSor +
    3 *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor
  , 3 *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 3 karakterSor +
    6 *
    listaEgeszElemVagyNulla 0 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor *
    listaEgeszElemVagyNulla 2 karakterSor +
    listaEgeszElemVagyNulla 1 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor *
    listaEgeszElemVagyNulla 1 karakterSor
  ]

public export
KarakterBelsoKobeHaromFokig : List Integer
KarakterBelsoKobeHaromFokig =
  karakterKobRecept AffinE8ElsoSzintuKarakterHaromFokig

BizonyitasKarakterKobeModularisJInvariansKezdete :
  KarakterBelsoKobeHaromFokig =
    [1, 744, 196884, 21493760]
BizonyitasKarakterKobeModularisJInvariansKezdete =
  trans
    (cong
      karakterKobRecept
      BizonyitasAffinE8ElsoSzintuKarakterHaromFokig)
    Refl

-- =====================================================================
-- 6. A NYOLCAS KÖZPONTI TÖLTÉS KÉT ÚTON
-- =====================================================================

public export
AffinSzint : Integer
AffinSzint = 1

public export
E8LieAlgebraDimenzio : Integer
E8LieAlgebraDimenzio = ElsoFokGyokEsCartanUton

public export
E8DualisCoxeterSzam : Integer
E8DualisCoxeterSzam = 30

public export
SugawaraKozpontiToltesSzamlalo : Integer
SugawaraKozpontiToltesSzamlalo =
  AffinSzint * E8LieAlgebraDimenzio

public export
SugawaraKozpontiToltesNevezo : Integer
SugawaraKozpontiToltesNevezo =
  AffinSzint + E8DualisCoxeterSzam

public export
RacsKozpontiToltesSzamlalo : Integer
RacsKozpontiToltesSzamlalo = cast E8Rang

public export
RacsKozpontiToltesNevezo : Integer
RacsKozpontiToltesNevezo = 1

BizonyitasKozpontiToltesKetUton :
  SugawaraKozpontiToltesSzamlalo * RacsKozpontiToltesNevezo =
  RacsKozpontiToltesSzamlalo * SugawaraKozpontiToltesNevezo
BizonyitasKozpontiToltesKetUton = Refl

BizonyitasRacsKozpontiToltesNyolc :
  RacsKozpontiToltesSzamlalo = 8
BizonyitasRacsKozpontiToltesNyolc = Refl

-- =====================================================================
-- 7. FUTTATHATÓ JELENTÉS
-- =====================================================================

public export
affinE8KarakterJelentes : IO ()
affinE8KarakterJelentes = do
  putStrLn "Affin E8 első szintű karakter:"
  putStrLn ("  Construction A théta-sor: " ++
            show E8ThetaHaromFokig)
  putStrLn ("  nyolcszínű oszcillátorsor: " ++
            show NyolcSzinuOszcillatorSorHaromFokig)
  putStrLn ("  fokozott karakter: " ++
            show AffinE8ElsoSzintuKarakterHaromFokig)
  putStrLn ("  248 két független úton: " ++
            show ElsoFokGyokEsCartanUton ++ " = " ++
            show ElsoFokKarakterUton)
  putStrLn ("  karakterköb, a moduláris j-invariáns kezdete: " ++
            show KarakterBelsoKobeHaromFokig)
  putStrLn ("  központi töltés két úton: " ++
            show SugawaraKozpontiToltesSzamlalo ++ "/" ++
            show SugawaraKozpontiToltesNevezo ++ " = " ++
            show RacsKozpontiToltesSzamlalo ++ "/" ++
            show RacsKozpontiToltesNevezo)
  putStrLn "Határ: ez affin reprezentációelmélet, nem kvantumhibajavító kód."
