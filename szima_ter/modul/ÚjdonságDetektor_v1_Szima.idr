module ÚjdonságDetektor_v1_Szima

import Decidable.Equality

%default total

-- ============================================================
-- idris-mag / T2: Novelty-GAN típusosítása
-- ============================================================
-- A szívdobbanás GAN-diszkriminátorának (újdonság-detektor)
-- típusos modellje.
--
-- Alapgondolat: az Ujdonság konstruktorai bizonyíték-mezőt
-- követelnek. Csak olyan elemről állíthatunk újdonságot,
-- amelyről típus-szintű bizonyíték van arról, hogy NEM volt
-- a régi pillanatképben. Hamis riasztás = típushiba.
-- ============================================================

-- -----------------------------------------------------------
-- Tagja: tagsági reláció (pozitív bizonyíték)
-- -----------------------------------------------------------
||| x eleme xs-nek — induktív bizonyíték.
public export
data Tagja : (x : Nat) -> (xs : List Nat) -> Type where
  ||| A fej egyezik: x a lista eleje.
  Itt : Tagja x (x :: xs)
  ||| Farok-rekurzió: x a farkában van.
  Ott : Tagja x xs -> Tagja x (y :: xs)

%name Tagja t, t', t''

export
Uninhabited (Tagja x []) where
  uninhabited Itt impossible
  uninhabited (Ott _) impossible

-- -----------------------------------------------------------
-- NemTagja: a nem-tagság típusa
-- -----------------------------------------------------------
||| x NEM eleme xs-nek — a Tagja megtagadása.
public export
NemTagja : (x : Nat) -> (xs : List Nat) -> Type
NemTagja x xs = Not (Tagja x xs)

-- -----------------------------------------------------------
-- tagjaDontes: pozitív tagsági döntés (konstruktív mag)
-- -----------------------------------------------------------
||| Eldönti: x tagja-e xs-nek.
export
tagjaDontes : (x : Nat) -> (xs : List Nat) -> Dec (Tagja x xs)
tagjaDontes x [] = No absurd
tagjaDontes x (y :: ys) with (decEq x y)
  tagjaDontes x (x :: ys) | Yes Refl = Yes Itt
  tagjaDontes x (y :: ys) | No nemUgyanaz with (tagjaDontes x ys)
    tagjaDontes x (y :: ys) | No nemUgyanaz | Yes pm =
      Yes (Ott pm)
    tagjaDontes x (y :: ys) | No nemUgyanaz | No farokNem =
      No (\prf => case prf of
                    Itt       => void (nemUgyanaz Refl)
                    (Ott pm)  => void (farokNem pm))

-- -----------------------------------------------------------
-- nemTagjaDontes: negatív döntés a pozitívra épülve
-- -----------------------------------------------------------
||| Eldönti: x NEM tagja-e xs-nek.
export
nemTagjaDontes : (x : Nat) -> (xs : List Nat) -> Dec (NemTagja x xs)
nemTagjaDontes x xs with (tagjaDontes x xs)
  nemTagjaDontes x xs | Yes t = No (\nem => nem t)
  nemTagjaDontes x xs | No nt = Yes nt

-- -----------------------------------------------------------
-- Snapshot: a rendszer-pillanatkép
-- -----------------------------------------------------------
||| Egy szívdobbanás-pillanatkép: a figyelt halmazok.
public export
record Snapshot where
  constructor Kép
  ||| Figyelt portok.
  portok     : List Nat
  ||| Futó konténerek (névkódok).
  konténerek : List Nat
  ||| Aktív systemd-unitok (névkódok).
  unitok     : List Nat

%name Snapshot régix, mostanix, s1, s2

-- -----------------------------------------------------------
-- Ujdonság: csak bizonyítékkal létező eltérés
-- -----------------------------------------------------------
||| Egy újdonság-érzékelés. Minden konstruktor hordozza a
||| bizonyítékot: az elem nincs a régi pillanatkép megfelelő
||| listájában.
public export
data Ujdonság : Type where
  ÚjPort     : (régi : Snapshot) -> (p : Nat)
             -> NemTagja p (portok régi) -> Ujdonság
  ÚjKonténer : (régi : Snapshot) -> (c : Nat)
             -> NemTagja c (konténerek régi) -> Ujdonság
  ÚjUnit     : (régi : Snapshot) -> (u : Nat)
             -> NemTagja u (unitok régi) -> Ujdonság

%name Ujdonság u, u'

-- -----------------------------------------------------------
-- diff: a diszkriminátor magja
-- -----------------------------------------------------------
||| Összeveti a régi és az aktuális pillanatképet; csak azokat
||| az elemeket jelenti, amelyekre van nem-tagsági bizonyíték.
export
diff : (régi : Snapshot) -> (mostani : Snapshot) -> List Ujdonság
diff régi mostani = szedPort ++ szedKonténer ++ szedUnit
  where
    szedPort : List Ujdonság
    szedPort = szedP (portok mostani)
      where
        szedP : List Nat -> List Ujdonság
        szedP [] = []
        szedP (p :: maradék) with (nemTagjaDontes p (portok régi))
          szedP (p :: maradék) | Yes biz = ÚjPort régi p biz :: szedP maradék
          szedP (p :: maradék) | No _     = szedP maradék

    szedKonténer : List Ujdonság
    szedKonténer = szedC (konténerek mostani)
      where
        szedC : List Nat -> List Ujdonság
        szedC [] = []
        szedC (c :: maradék) with (nemTagjaDontes c (konténerek régi))
          szedC (c :: maradék) | Yes biz = ÚjKonténer régi c biz :: szedC maradék
          szedC (c :: maradék) | No _     = szedC maradék

    szedUnit : List Ujdonság
    szedUnit = szedU (unitok mostani)
      where
        szedU : List Nat -> List Ujdonság
        szedU [] = []
        szedU (u :: maradék) with (nemTagjaDontes u (unitok régi))
          szedU (u :: maradék) | Yes biz = ÚjUnit régi u biz :: szedU maradék
          szedU (u :: maradék) | No _     = szedU maradék

-- -----------------------------------------------------------
-- pidJavaslat: az újdonságszám határozza meg a szintet
-- -----------------------------------------------------------
||| Az újdonságok száma alapján javasolt PID-szint:
||| 0 újdonság -> nyugalom(0), 1 -> figyelés(1),
||| 2 -> óvatosság(2), 3 vagy több -> riasztás(3).
export
pidJavaslat : List Ujdonság -> Nat
pidJavaslat []      = 0
pidJavaslat [_]     = 1
pidJavaslat [_, _]  = 2
pidJavaslat _       = 3
