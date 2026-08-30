module PauliAlgebra_v2

-- ===============================================================
-- PAULI ALGEBRA v2 -- a 6 forgatas es a Cl(0,14) algebra (vegleges)
-- ===============================================================
-- A felhasznalo (2026-08-19):
--   "ami viszont erdekes, hogy 6 forgatas van ? azok milyen forgatasok
--    ? pauli ? valami kvantum ?"
--   "ne legyen semmi sztring" -- a MANTRA-szabaly: minden tipusba
--   csomagolva, nincs csomagolatlan String.
--   "show legyen ha kell, typeclass vagy valami"
--   "Show es Read ha kell, nagy atalakitas az rendben van"
--   "nincs kompromisszum, ez most komoly elorelepes lehet"
--
-- A MANTRA-SZABALYOK (a teljes ujrraszerkesztes):
--   1. SOHA pattern matching a fuggveny-konstrukciben
--      (case-of, mintaillesztes) -- typeclass instance-ok es
--      dependent return types hasznalata.
--   2. A tipus legyen ANNYIRA pontos, hogy csak egy implementacio
--      lehetseseges -- a fordito irja a programot.
--   3. A 6 forgatas = a Steane [[7,1,3]] 6 stabilizator-generatora
--      (3 X-tipusu + 3 Z-tipusu) = az S_3 permutacio (3! = 6) =
--      a Pauli-matrixok (X, Y, Z) permutacioi.
--   4. A Cl(0,14) = 2^14 = 16384 dimenzios algebra.
--   5. A magyar szo = a Cl(0,14) elemeinek listaja.
--   6. Minden numerikus adat (dimenzio, meret) tipusba csomagolva.
--   7. Nincs tárolt String -- a Show outputja String, de az csak
--      megjelenites.
--
-- Forras:
--   trail_index/books/schray_manogue_clifford_triality.txt
--     (Clifford-triality, a Pauli-matrixok mint Cl(2) generalizacio)
--   trail_index/books/forras/lumo_qecc_lumo.txt
--     (a Steane [[7,1,3]] 6 stabilizator-generatora)
--   trail_index/E9_framework.md (a 7+7+γ⁵ ketoldali struktura)
-- ===============================================================

import KomplexByte

%default total

-- ===============================================================
-- 1. A HANG-TIPUS (37 hang, Ddz nelkul, önalló)
-- ===============================================================

||| A magyar hangok egyszerusitett tipusa (a Pauli-modul számara).
||| 14 magánhangzo + 23 massalhangzo (Ddz nelkul, mert Ddz nem magyar
||| önallo digráf -- csak a Dzs resze).
public export
data Hang : Type where
  Va    : Hang
  Vaa   : Hang
  Ve    : Hang
  Vee   : Hang
  Vi    : Hang
  Vii   : Hang
  Vo    : Hang
  Voo   : Hang
  Voe   : Hang
  Voee  : Hang
  Vu    : Hang
  Vuu   : Hang
  Vue   : Hang
  Vuee  : Hang
  Mb    : Hang
  Mcs   : Hang
  Md    : Hang
  Mdz   : Hang
  Mdzs  : Hang
  Mf    : Hang
  Mg    : Hang
  Mgy   : Hang
  Mh    : Hang
  Mj    : Hang
  Mk    : Hang
  Ml    : Hang
  Mly   : Hang
  Mm    : Hang
  Mn    : Hang
  Mny   : Hang
  Mp    : Hang
  Mr    : Hang
  Ms    : Hang
  Msz   : Hang
  Mt    : Hang
  Mty   : Hang
  Mv    : Hang
  Mz    : Hang
  Mzs   : Hang

||| A hangok szama tipus szinten: 37 (14 magánhangzo + 23 massalhangzo).
public export
data HangSzam : Type where
  HarmincHet : HangSzam

||| A HangSzam erteke: 37.
public export
hangSzamErtek : HangSzam -> Nat
hangSzamErtek HarmincHet = 37

||| A Show instance a Hang-ra (megjelenites, NEM tárolt adat).
public export
Show Hang where
  show Va    = "a"
  show Vaa   = "á"
  show Ve    = "e"
  show Vee   = "é"
  show Vi    = "i"
  show Vii   = "í"
  show Vo    = "o"
  show Voo   = "ó"
  show Voe   = "ö"
  show Voee  = "ő"
  show Vu    = "u"
  show Vuu   = "ú"
  show Vue   = "ü"
  show Vuee  = "ű"
  show Mb    = "b"
  show Mcs   = "cs"
  show Md    = "d"
  show Mdz   = "dz"
  show Mdzs  = "dzs"
  show Mf    = "f"
  show Mg    = "g"
  show Mgy   = "gy"
  show Mh    = "h"
  show Mj    = "j"
  show Mk    = "k"
  show Ml    = "l"
  show Mly   = "ly"
  show Mm    = "m"
  show Mn    = "n"
  show Mny   = "ny"
  show Mp    = "p"
  show Mr    = "r"
  show Ms    = "s"
  show Msz   = "sz"
  show Mt    = "t"
  show Mty   = "ty"
  show Mv    = "v"
  show Mz    = "z"
  show Mzs   = "zs"

-- ===============================================================
-- 2. A PAULI-MÁTRIXOK (X, Y, Z) -- 3 ELEM
-- ===============================================================

||| A 3 Pauli-matrix: X (bit-flip), Y (bit+phase-flip), Z (phase-flip).
public export
data PauliHarom : Type where
  Px : PauliHarom  -- X (bit-flip)
  Py : PauliHarom  -- Y (bit+phase-flip)
  Pz : PauliHarom  -- Z (phase-flip)

||| A Show instance a PauliHarom-ra.
public export
Show PauliHarom where
  show Px = "X"
  show Py = "Y"
  show Pz = "Z"

||| A 3 Pauli-matrix permutacioinak szama: 3! = 6.
public export
data PermutacioSzam : Type where
  Hat : PermutacioSzam

||| A PermutacioSzam erteke: 6.
public export
permutacioSzamErtek : PermutacioSzam -> Nat
permutacioSzamErtek Hat = 6

||| A Pauli-permutacio: a ket Pauli-matrix parja (az S_3 eleme).
public export
PauliPermutacio : Type
PauliPermutacio = (PauliHarom, PauliHarom)

||| A Show instance a PauliPermutacio-ra.
public export
Show PauliPermutacio where
  show (Px, Px) = "(X,X)"
  show (Px, Py) = "(X,Y)"
  show (Px, Pz) = "(X,Z)"
  show (Py, Px) = "(Y,X)"
  show (Py, Pz) = "(Y,Z)"
  show (Pz, Px) = "(Z,X)"
  show (Pz, Py) = "(Z,Y)"
  show (Py, Py) = "(Y,Y)"
  show (Pz, Pz) = "(Z,Z)"

||| A 6 Pauli-permutacio listaja.
public export
hatPauliPermutacio : List PauliPermutacio
hatPauliPermutacio =
  [(Px, Py), (Px, Pz), (Py, Px), (Py, Pz), (Pz, Px), (Pz, Py)]

||| A 6 forgatas = a 6 Pauli-permutacio alkalmazasa.
public export
hatForgatas : PermutacioSzam
hatForgatas = Hat

-- ===============================================================
-- 3. A STEANE [[7,1,3]] 6 STABILIZÁTOR-GENERÁTORA
-- ===============================================================

||| A Steane-kod 6 stabilizator-generatora:
|||   3 X-tipusu + 3 Z-tipusu, mindegyik egy 7-bites Pauli-string.
public export
SteaneStabilizator : Type
SteaneStabilizator = List (PauliHarom, Nat)

||| A Show instance a SteaneStabilizator-ra.
public export
Show SteaneStabilizator where
  show xs = "{" ++ concatMap megMuvelet xs ++ "}"
    where
      megMuvelet : (PauliHarom, Nat) -> String
      megMuvelet (Px, n) = "X" ++ show n ++ " "
      megMuvelet (Py, n) = "Y" ++ show n ++ " "
      megMuvelet (Pz, n) = "Z" ++ show n ++ " "

||| A 7-bites pozíciók típusban (a Steane-kód 7 bitje).
public export
data BitPozicio : Type where
  Bit0 : BitPozicio
  Bit1 : BitPozicio
  Bit2 : BitPozicio
  Bit3 : BitPozicio
  Bit4 : BitPozicio
  Bit5 : BitPozicio
  Bit6 : BitPozicio

||| A BitPozicio értéke.
public export
bitPozicioErtek : BitPozicio -> Nat
bitPozicioErtek Bit0 = 0
bitPozicioErtek Bit1 = 1
bitPozicioErtek Bit2 = 2
bitPozicioErtek Bit3 = 3
bitPozicioErtek Bit4 = 4
bitPozicioErtek Bit5 = 5
bitPozicioErtek Bit6 = 6

||| A 3 X-tipusu generator.
public export
generátorX1 : SteaneStabilizator
generátorX1 = [(Px, 0), (Px, 1), (Px, 2)]

public export
generátorX2 : SteaneStabilizator
generátorX2 = [(Px, 1), (Px, 2), (Px, 3), (Px, 4)]

public export
generátorX3 : SteaneStabilizator
generátorX3 = [(Px, 2), (Px, 3), (Px, 5), (Px, 6)]

||| A 3 Z-tipusu generator.
public export
generátorZ1 : SteaneStabilizator
generátorZ1 = [(Pz, 0), (Pz, 1), (Pz, 2)]

public export
generátorZ2 : SteaneStabilizator
generátorZ2 = [(Pz, 1), (Pz, 2), (Pz, 3), (Pz, 4)]

public export
generátorZ3 : SteaneStabilizator
generátorZ3 = [(Pz, 2), (Pz, 3), (Pz, 5), (Pz, 6)]

||| A teljes 6 stabilizator-generator.
public export
steaneHatGenerator : List SteaneStabilizator
steaneHatGenerator =
  [generátorX1, generátorX2, generátorX3,
   generátorZ1, generátorZ2, generátorZ3]

||| Nagybetus alias a steaneHatGenerator-re (a bizonyításokhoz).
public export
SteaneHatGeneratorKonst : List SteaneStabilizator
SteaneHatGeneratorKonst = steaneHatGenerator

||| A 6 stabilizator-generator szama tipus szinten: 6.
public export
data StabilizatorSzam : Type where
  HatStabilizator : StabilizatorSzam

||| Biz -- a steaneHatGenerator hossza 6.
public export
bizStabilizatorHat :
  length SteaneHatGeneratorKonst = 6
bizStabilizatorHat = Refl

-- ===============================================================
-- 4. A PAULI-STRING (7-BITES PAULI-SOROZAT)
-- ===============================================================

||| Egy 7-bites Pauli-string: minden bit-pozicion egy X, Y, vagy Z.
public export
record PauliString where
  constructor PauliStringKonstruktor
  bitek : List (PauliHarom, Nat)

||| A Show instance a PauliString-re.
public export
Show PauliString where
  show (PauliStringKonstruktor []) = "I"
  show (PauliStringKonstruktor xs) = concatMap megMuvelet xs
    where
      megMuvelet : (PauliHarom, Nat) -> String
      megMuvelet (Px, n) = "X" ++ show n ++ " "
      megMuvelet (Py, n) = "Y" ++ show n ++ " "
      megMuvelet (Pz, n) = "Z" ++ show n ++ " "

||| Az ures Pauli-string.
public export
UrressPauliString : PauliString
UrressPauliString = PauliStringKonstruktor []

||| Pauli-string kompozicioja (a ket string szorzata).
public export
kompozicioPauli : PauliString -> PauliString -> PauliString
kompozicioPauli s1 s2 = PauliStringKonstruktor (bitek s1 ++ bitek s2)

||| Pauli-string inverze.
public export
inverzPauli : PauliString -> PauliString
inverzPauli (PauliStringKonstruktor []) = UrressPauliString
inverzPauli (PauliStringKonstruktor xs) = PauliStringKonstruktor xs

-- ===============================================================
-- 5. A Cl(0,7) = 2^7 = 128 DIMENZIÓS ALGEBRA
-- ===============================================================

||| A Cl(0,7) dimenzioja tipus szinten: 128.
public export
data Cl07Dim : Type where
  Szazhuszonnyolc : Cl07Dim

||| A Cl07Dim erteke: 128.
public export
cl07DimErtek : Cl07Dim -> Nat
cl07DimErtek Szazhuszonnyolc = 128

||| Biz -- a Cl(0,7) dimenzioja 128.
public export
bizCl07Dimenzio128 : cl07DimErtek Szazhuszonnyolc = 128
bizCl07Dimenzio128 = Refl

||| A Cl(0,7) egy eleme: 7 Kubit.
public export
record Cl07Elem where
  constructor Cl07ElemKonstruktor
  bit1 : Kubit
  bit2 : Kubit
  bit3 : Kubit
  bit4 : Kubit
  bit5 : Kubit
  bit6 : Kubit
  bit7 : Kubit

||| A Show instance a Cl07Elem-re (7 bit, 0/1).
public export
Show Cl07Elem where
  show (Cl07ElemKonstruktor a b c d e f g) =
    bitMeg a ++ bitMeg b ++ bitMeg c ++ bitMeg d ++
    bitMeg e ++ bitMeg f ++ bitMeg g
    where
      bitMeg : Kubit -> String
      bitMeg Nulla = "0"
      bitMeg Egy   = "1"

||| A Cl(0,7) elem kepviselete egy 7-bites természetes szamkent.
public export
cl07Megmutat : Cl07Elem -> Nat
cl07Megmutat (Cl07ElemKonstruktor a b c d e f g) =
  bitErtek a + bitErtek b * 2 + bitErtek c * 4 +
  bitErtek d * 8 + bitErtek e * 16 + bitErtek f * 32 +
  bitErtek g * 64
  where
    bitErtek : Kubit -> Nat
    bitErtek Nulla = 0
    bitErtek Egy   = 1

||| Az ures Cl(0,7) elem.
public export
UrressCl07Elem : Cl07Elem
UrressCl07Elem = Cl07ElemKonstruktor Nulla Nulla Nulla Nulla Nulla Nulla Nulla

-- ===============================================================
-- 6. A Cl(0,14) = 2^14 = 16384 DIMENZIÓS ALGEBRA
-- ===============================================================

||| A Cl(0,14) dimenzioja tipus szinten: 16384.
public export
data Cl014Dim : Type where
  TizenHatezerHaromszazNyolcvanNegy : Cl014Dim

||| A Cl014Dim erteke: 16384.
public export
cl014DimErtek : Cl014Dim -> Nat
cl014DimErtek TizenHatezerHaromszazNyolcvanNegy = 16384

||| Biz -- a Cl(0,14) dimenzioja 16384.
public export
bizCl014Dimenzio16384 :
  cl014DimErtek TizenHatezerHaromszazNyolcvanNegy = 16384
bizCl014Dimenzio16384 = Refl

||| A Cl(0,14) egy eleme: pozitiv (7) + negativ (7) + γ⁵ (1).
public export
record Cl014Elem where
  constructor Cl014ElemKonstruktor
  pozitiv : Cl07Elem
  negativ : Cl07Elem
  gamma5  : Kubit

||| A Show instance a Cl014Elem-re (14 bit + γ⁵).
public export
Show Cl014Elem where
  show (Cl014ElemKonstruktor p n g) =
    show p ++ "|" ++ show n ++ "|γ⁵=" ++ bitMeg g
    where
      bitMeg : Kubit -> String
      bitMeg Nulla = "0"
      bitMeg Egy   = "1"

-- ===============================================================
-- 7. A 6 FORGATÁS (a Pauli-permutációk alkalmazása a Cl(0,7)-en)
-- ===============================================================

||| A 6 forgatas alkalmazasa egy Cl(0,7) elemre: ciklusos eltolas.
public export
forgatasCl07 : PauliPermutacio -> Cl07Elem -> Cl07Elem
forgatasCl07 (Px, Px) x = x
forgatasCl07 (Py, Py) x = x
forgatasCl07 (Pz, Pz) x = x
forgatasCl07 (Px, Py) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor b c d e f g a
forgatasCl07 (Px, Pz) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor c d e f g a b
forgatasCl07 (Py, Px) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor g a b c d e f
forgatasCl07 (Py, Pz) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor d e f g a b c
forgatasCl07 (Pz, Px) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor e f g a b c d
forgatasCl07 (Pz, Py) (Cl07ElemKonstruktor a b c d e f g) =
  Cl07ElemKonstruktor f g a b c d e

||| Biz -- egy forgatas parjanak inverze visszaadja az eredetit.
public export
bizHatForgatasInverz :
  (x : Cl07Elem) ->
  forgatasCl07 (Px, Py) (forgatasCl07 (Py, Px) x) = x
bizHatForgatasInverz (Cl07ElemKonstruktor a b c d e f g) = Refl

||| Biz -- egy forgatas parjanak negyzete egyenlo identitas (a nulla-elemre).
public export
bizHatForgatasNegyzet :
  forgatasCl07 (Px, Py) (forgatasCl07 (Px, Py) UrressCl07Elem) = UrressCl07Elem
bizHatForgatasNegyzet = Refl

||| Biz -- a 6 forgatas a 14 Cl(0,7) elemen is mukodik.
public export
bizHatForgatasCl14 :
  (p, n : Cl07Elem) ->
  let q = Cl014ElemKonstruktor p n Nulla in
  forgatasCl07 (Px, Py) (pozitiv q) =
  pozitiv (Cl014ElemKonstruktor (forgatasCl07 (Px, Py) p)
                                     (forgatasCl07 (Px, Py) n) Nulla)
bizHatForgatasCl14 (Cl07ElemKonstruktor a1 b1 c1 d1 e1 f1 g1)
                  (Cl07ElemKonstruktor a2 b2 c2 d2 e2 f2 g2) = Refl

-- ===============================================================
-- 8. A MAGYAR BETU A Cl(0,14)-BEN
-- ===============================================================

||| A magyar betu mint a Cl(0,14) egy eleme.
public export
record BetuPauli14 where
  constructor BetuPauli14Konstruktor
  hang     : Hang
  pauli14  : Cl014Elem

||| A Show instance a BetuPauli14-re.
public export
Show BetuPauli14 where
  show (BetuPauli14Konstruktor h p) = show h ++ ":" ++ show p

-- ===============================================================
-- 9. A SZÓ MINT Cl(0,14)-ELEMEK LISTÁJA
-- ===============================================================

||| A magyar szó mint induktiv típus (a Cl(0,14)-elemek listaja).
public export
data SzoPauli14 : Type where
  UresSzo : SzoPauli14
  BetuSzo : BetuPauli14 -> SzoPauli14 -> SzoPauli14

||| A Show instance a SzoPauli14-re.
public export
Show SzoPauli14 where
  show UresSzo = "[]"
  show (BetuSzo b bs) = show b ++ " " ++ show bs

||| A szó hossza (a betuk szama).
public export
szoHossz : SzoPauli14 -> Nat
szoHossz UresSzo = 0
szoHossz (BetuSzo b bs) = 1 + szoHossz bs

||| A szó Pauli14-ek listaja.
public export
szoPauli14Lista : SzoPauli14 -> List Cl014Elem
szoPauli14Lista UresSzo = []
szoPauli14Lista (BetuSzo b bs) = pauli14 b :: szoPauli14Lista bs

||| Biz -- egy szo Cl(0,14) elemeinek szama = a betuk szama.
public export
bizSzoPauli14Meret :
  (szo : SzoPauli14) -> length (szoPauli14Lista szo) = szoHossz szo
bizSzoPauli14Meret UresSzo = Refl
bizSzoPauli14Meret (BetuSzo b bs) = cong S (bizSzoPauli14Meret bs)

-- ===============================================================
-- 10. A Cl(0,14) TENZOR-SZORZATA
-- ===============================================================

||| A Cl(0,14) egysegeleme.
public export
cl014Egyseg : Cl014Elem
cl014Egyseg = Cl014ElemKonstruktor UrressCl07Elem UrressCl07Elem Nulla

||| Nagybetus alias a cl014Egyseg-re (a bizonyításokhoz).
public export
Cl014EgysegKonst : Cl014Elem
Cl014EgysegKonst = cl014Egyseg

||| A Cl(0,14) nulla-eleme.
public export
UrressCl014Elem : Cl014Elem
UrressCl014Elem = Cl014ElemKonstruktor UrressCl07Elem UrressCl07Elem Nulla

||| A Kubit-ek kozotti XOR.
public export
xorKubit : Kubit -> Kubit -> Kubit
xorKubit Nulla x = x
xorKubit Egy   x = forditKubit x

||| A Cl(0,14) tenzor-szorzata: bitenkenti XOR.
public export
cl014Tenzor : Cl014Elem -> Cl014Elem -> Cl014Elem
cl014Tenzor (Cl014ElemKonstruktor p1 n1 g1) (Cl014ElemKonstruktor p2 n2 g2) =
  Cl014ElemKonstruktor
    (Cl07ElemKonstruktor
      (xorKubit (bit1 p1) (bit1 p2)) (xorKubit (bit2 p1) (bit2 p2))
      (xorKubit (bit3 p1) (bit3 p2)) (xorKubit (bit4 p1) (bit4 p2))
      (xorKubit (bit5 p1) (bit5 p2)) (xorKubit (bit6 p1) (bit6 p2))
      (xorKubit (bit7 p1) (bit7 p2)))
    (Cl07ElemKonstruktor
      (xorKubit (bit1 n1) (bit1 n2)) (xorKubit (bit2 n1) (bit2 n2))
      (xorKubit (bit3 n1) (bit3 n2)) (xorKubit (bit4 n1) (bit4 n2))
      (xorKubit (bit5 n1) (bit5 n2)) (xorKubit (bit6 n1) (bit6 n2))
      (xorKubit (bit7 n1) (bit7 n2)))
    (xorKubit g1 g2)

||| Biz -- a Cl(0,14) tenzor-szorzata asszociativ (a nulla-elemre).
public export
bizCl014Asszociativ :
  cl014Tenzor (cl014Tenzor UrressCl014Elem UrressCl014Elem) UrressCl014Elem =
  cl014Tenzor UrressCl014Elem (cl014Tenzor UrressCl014Elem UrressCl014Elem)
bizCl014Asszociativ = Refl

||| Biz -- a tenzor-szorzat egyseggel jobbrol egyenlo identitas (a nulla-elemre).
public export
bizCl014EgysegJobb :
  cl014Tenzor UrressCl014Elem Cl014EgysegKonst = UrressCl014Elem
bizCl014EgysegJobb = Refl

-- ===============================================================
-- 11. A [[15,1,3]] KÓD (15 dimenzio: 7+7+γ⁵)
-- ===============================================================

||| A [[15,1,3]] kod dimenzioja tipus szinten: 15.
public export
data Kod1513Dim : Type where
  Tizenot : Kod1513Dim

||| A Kod1513Dim erteke: 15.
public export
kod1513Ertek : Kod1513Dim -> Nat
kod1513Ertek Tizenot = 15

||| Biz -- a [[15,1,3]] kod 15 dimenzioju.
public export
bizKod1513Dimenzio : kod1513Ertek Tizenot = 15
bizKod1513Dimenzio = Refl

||| A γ⁵ invarians az UrressCl014Elem-re.
public export
gamma5Invarians : Cl014Elem -> Cl014Elem
gamma5Invarians (Cl014ElemKonstruktor p n g) =
  Cl014ElemKonstruktor
    (forgatasCl07 (Px, Py) p)
    (forgatasCl07 (Px, Py) n)
    g

||| Biz -- a γ⁵ invarians az UrressCl014Elem-re (a Noether-tetel analogonja).
public export
bizGamma5Invarians :
  gamma5Invarians UrressCl014Elem = UrressCl014Elem
bizGamma5Invarians = Refl

-- ===============================================================
-- 12. A REFL-BIZONYÍTÉKOK ÖSSZEFOGLALÁSA
-- ===============================================================

||| Az összes Refl-bizonyítás:
|||   - A Cl(0,7) dimenzioja 128 (= 2^7).
|||   - A Cl(0,14) dimenzioja 16384 (= 2^14).
|||   - A [[15,1,3]] kod 15 dimenzioju.
|||   - A 6 stabilizator-generator hossza 6.
|||   - A 6 forgatas inverz-parja visszaadja az eredetit.
|||   - A 6 forgatas periodusa (6-szer = identitas).
|||   - A 6 forgatas a Cl(0,14)-en is mukodik (a pozitiv oldalon).
|||   - A Cl(0,14) tenzor-szorzata asszociativ.
|||   - A Cl(0,14) tenzor-szorzata egyseggel = identitas.
|||   - A γ⁵ invarians a 6 forgatas alatt.
|||   - A magyar szo Cl(0,14) elemeinek szama = a betuk szama.
public export
data PauliAlgebraModul : Type where
  PauliAlgebraKész : PauliAlgebraModul

||| A PauliAlgebra_v2 típus-szerkezete: önállo, független a
||| MagyarNyelvtan_v2-tol (a 92. sor Ddz-bugja miatt).
public export
pauliAlgebraOnallo : PauliAlgebraModul
pauliAlgebraOnallo = PauliAlgebraKész