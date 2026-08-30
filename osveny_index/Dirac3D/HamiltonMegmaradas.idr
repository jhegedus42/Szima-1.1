module HamiltonMegmaradas

import Data.Vect
import Fazis
import CarryHoatvitel

-- =====================================================================
-- HAMILTON-MEGMARADÁS: a carry nem hőt termel — a hő a csonkolás.
--
-- A felismerés: a Hamiltoni nem termel hőt, ha semmi nem vész el.
-- A carry MEGŐRZÖTT információ (Noether-áram a helyiértékek között),
-- nem disszipáció.
--
-- A megmaradási törvény:
--   érték(a) + érték(b) = érték(eredmény) + carry × 10⁴
--
-- Amíg a carry adatként megmarad (unitér evolúció): ΔH = 0.
-- A hő EGYETLEN forrása: a csonkolás — amikor a carry kifolyik
-- az utolsó helyiértékből (9999 + 1 = 10000 → 0). Ez a nem-unitér
-- lépés, pontosan mint a kvantummérés összeomlása.
--
-- Kapcsolat a QHMC-hez: a leapfrog integrátor szimplektikus (unitér),
-- ezért H = 6.0 megmaradt 5 lépésen át — ugyanez az elv.
-- =====================================================================

%default total

-- =====================================================================
-- 1. A számjegyállapot értéke = a Hamiltoni.
-- =====================================================================

||| Számjegyállapot értéke: Σ dᵢ × 10ⁱ.
||| Ez a "Hamiltoni": az összeg, ami a helyiérték-eltolások alatt
||| invariáns kell legyen.
public export
szamjegyErtek : Szamjegyek4 -> Nat
szamjegyErtek s = ezres s * 1000 + szazas s * 100 + tizes s * 10 + egyes s

-- =====================================================================
-- 2. Összeadás carry-megőrzéssel: a carry adat, nem hő.
-- =====================================================================

||| Összeadás eredménye a kifolyó carry-val együtt.
||| A carry MEGMARAD — semmi nem vész el.
public export
record OsszegCarryval where
  constructor MkOsszegCarryval
  eredmeny : Szamjegyek4
  carry    : Nat  -- a kifolyó carry: megőrzött információ, nem hő

||| Helyiértékenkénti összeadás, a kifolyó carry megőrzésével.
public export
osszeadasCarryval : Szamjegyek4 -> Szamjegyek4 -> OsszegCarryval
osszeadasCarryval a b =
  let (dEgyes, cEgyes) = hoOsszegHelyiertek (egyes a) (egyes b) 0
      (dTizes, cTizes) = hoOsszegHelyiertek (tizes a) (tizes b) cEgyes
      (dSzazas, cSzazas) = hoOsszegHelyiertek (szazas a) (szazas b) cTizes
      (dEzres, cEzres) = hoOsszegHelyiertek (ezres a) (ezres b) cSzazas
  in MkOsszegCarryval (MkSzamjegyek4 dEzres dSzazas dTizes dEgyes) cEzres

-- =====================================================================
-- 3. A hő: csak a csonkolt rész.
-- =====================================================================

||| A hő = a kifolyó carry értéke (10⁴ súllyal).
||| Q = carry × 10000. Ha carry = 0: Q = 0, a rendszer unitér.
public export
hoMennyiseg : OsszegCarryval -> Nat
hoMennyiseg o = carry o * 10000

-- =====================================================================
-- 4. MEGMARADÁSI TÖRVÉNYEK — Refl bizonyítások konkrét esetekre.
-- =====================================================================

-- 4a. 66 + 3456: nincs kifolyó carry → Q = 0, ΔH = 0.

public export
Hatvanhat : Szamjegyek4
Hatvanhat = MkSzamjegyek4 0 0 6 6

public export
Haromezern : Szamjegyek4
Haromezern = MkSzamjegyek4 3 4 5 6

megmaradas66 : szamjegyErtek Hatvanhat + szamjegyErtek Haromezern =
               szamjegyErtek (eredmeny (osszeadasCarryval Hatvanhat Haromezern))
               + hoMennyiseg (osszeadasCarryval Hatvanhat Haromezern)
megmaradas66 = Refl

hoNulla66 : hoMennyiseg (osszeadasCarryval Hatvanhat Haromezern) = 0
hoNulla66 = Refl

-- 4b. 5 + 3: a 8-as számjegy a hő-csatornában marad, DE a teljes
-- érték megmarad: 5 + 3 = 8, semmi nem vész el.

public export
OtSzamjegy : Szamjegyek4
OtSzamjegy = MkSzamjegyek4 0 0 0 5

public export
HaromSzamjegy : Szamjegyek4
HaromSzamjegy = MkSzamjegyek4 0 0 0 3

megmaradas53 : szamjegyErtek OtSzamjegy + szamjegyErtek HaromSzamjegy =
               szamjegyErtek (eredmeny (osszeadasCarryval OtSzamjegy HaromSzamjegy))
               + hoMennyiseg (osszeadasCarryval OtSzamjegy HaromSzamjegy)
megmaradas53 = Refl

-- 4c. 9999 + 1: a carry kifolyik → Q = 10000. Itt jelenik meg a hő!

public export
Kilencez : Szamjegyek4
Kilencez = MkSzamjegyek4 9 9 9 9

public export
EgySzamjegy : Szamjegyek4
EgySzamjegy = MkSzamjegyek4 0 0 0 1

megmaradas9999 : szamjegyErtek Kilencez + szamjegyErtek EgySzamjegy =
                 szamjegyErtek (eredmeny (osszeadasCarryval Kilencez EgySzamjegy))
                 + hoMennyiseg (osszeadasCarryval Kilencez EgySzamjegy)
megmaradas9999 = Refl

hoCarry9999 : carry (osszeadasCarryval Kilencez EgySzamjegy) = 1
hoCarry9999 = Refl

-- 4d. 999 + 1: a carry a negyedik helyiértékben landol → Q = 0.

public export
Kilencs : Szamjegyek4
Kilencs = MkSzamjegyek4 0 9 9 9

megmaradas999 : szamjegyErtek Kilencs + szamjegyErtek EgySzamjegy =
                szamjegyErtek (eredmeny (osszeadasCarryval Kilencs EgySzamjegy))
                + hoMennyiseg (osszeadasCarryval Kilencs EgySzamjegy)
megmaradas999 = Refl

-- =====================================================================
-- 5. A hő NEM a Hamiltoniból jön, hanem a csonkolásból.
-- =====================================================================

||| Csonkolás: a kifolyó carry eldobása.
||| Ez a nem-unitér lépés — itt keletkezik a hő.
public export
csonkolas : OsszegCarryval -> Szamjegyek4
csonkolas = eredmeny

||| Csonkolt összeadás Hamiltoni-változása.
||| ΔH = érték(csonkolt) - (érték(a) + érték(b))
public export
hamiltoniValtozas : Szamjegyek4 -> Szamjegyek4 -> Nat
hamiltoniValtozas a b =
  let teljes = osszeadasCarryval a b
      regi = szamjegyErtek a + szamjegyErtek b
      uj = szamjegyErtek (csonkolas teljes)
  in regi `minus` uj
  where
    minus : Nat -> Nat -> Nat
    minus Z m = m
    minus n Z = n
    minus (S n) (S m) = minus n m

||| A KÖZPONTI TÖRVÉNY: ΔH = Q.
||| A csonkolás Hamiltoni-változása PONTOSAN a kifolyó hő.
||| 9999 + 1: ΔH = 10000 = Q.
deltaHamiltoniEgyenloHo9999 :
  hamiltoniValtozas Kilencez EgySzamjegy =
  hoMennyiseg (osszeadasCarryval Kilencez EgySzamjegy)
deltaHamiltoniEgyenloHo9999 = Refl

||| 66 + 3456: ΔH = 0 = Q — nincs hő, a rendszer unitér.
deltaHamiltoniEgyenloHo66 :
  hamiltoniValtozas Hatvanhat Haromezern =
  hoMennyiseg (osszeadasCarryval Hatvanhat Haromezern)
deltaHamiltoniEgyenloHo66 = Refl

||| 5 + 3: ΔH = 0 = Q.
deltaHamiltoniEgyenloHo53 :
  hamiltoniValtozas OtSzamjegy HaromSzamjegy =
  hoMennyiseg (osszeadasCarryval OtSzamjegy HaromSzamjegy)
deltaHamiltoniEgyenloHo53 = Refl

-- =====================================================================
-- 6. Az elv kimondása.
-- =====================================================================

-- A Hamiltoni-megmaradás elve:
-- amíg a carry megőrzött (unitér), nincs hő; a hő = csonkolt rész.
-- Az ELSŐ négy Refl bizonyítás igazolja:
--   megmaradas66  : 66 + 3456 = 3522 + 0    (Q = 0)
--   megmaradas53  : 5 + 3 = 8 + 0           (Q = 0)
--   megmaradas999 : 999 + 1 = 1000 + 0      (Q = 0)
--   megmaradas9999: 9999 + 1 = 0 + 10000    (Q = 10000 — itt a hő)
-- A KÖZPONTI TÖRVÉNY: ΔH = Q — a Hamiltoni-változás egyenlő a kifolyó hővel.
