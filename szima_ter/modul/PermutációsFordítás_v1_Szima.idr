module PermutációsFordítás_v1_Szima

%default total

-- ============================================================
-- idris-mag / T4: Permutációs fordítás
-- ============================================================
-- Joco hipotézise (2026-08-24):
--   "ha a magyar nyelv tisztán permutációs, akkor a fordítás
--    egy másik nyelvre permutációs algoritmus is lehet,
--    minimalizáló függvénnyel (nem is kell szótár)"
--
-- Tesztanyag: Sub Bass Monster sorok (élő permutáció-játék):
--   "Törpének óriás, óriásnak törpe"
--   "Monokini, minikino, Kawasaki, kiwi"
--   "Hány j-vel írják, hogy Siófok?"  <- ortográfiai QEC
--
-- Modell: szó = betűmultiset; jelentés-invariáns = rendezett
-- alak; fordítási költség = inverziók száma.
-- ============================================================

-- -----------------------------------------------------------
-- 0. Alapműveletek Nat-on (teljesen redukálható alakban)
-- -----------------------------------------------------------
||| Kisebb-vagy-egyenlő, konstruktor-mintákkal
||| (fordítási időben is kiszámolható).
export
lteNat : Nat -> Nat -> Bool
lteNat Z _ = True
lteNat (S _) Z = False
lteNat (S k) (S m) = lteNat k m

||| Abszolút különbség (Nat-on nincs negatív).
export
abszKül : Nat -> Nat -> Nat
abszKül Z m = m
abszKül (S k) Z = S k
abszKül (S k) (S m) = abszKül k m

-- -----------------------------------------------------------
-- 1. Szó — betűkódok listája
-- -----------------------------------------------------------
||| Egy szó = betűkódok listája (Nat-kódolt ábécé).
public export
Szó : Type
Szó = List Nat

-- -----------------------------------------------------------
-- 2. Rendezés — a multiset-invariáns kanonikus alakja
-- -----------------------------------------------------------
||| Beszúrásos rendezés.
export
beszúr : Nat -> List Nat -> List Nat
beszúr x [] = [x]
beszúr x (y :: ys) = case lteNat x y of
  True  => x :: y :: ys
  False => y :: beszúr x ys

||| Rendezett alak — minden permutáció ugyanide fut.
export
rendez : Szó -> Szó
rendez [] = []
rendez (x :: xs) = beszúr x (rendez xs)

-- -----------------------------------------------------------
-- 3. Permutáció-ekvivalencia — a jelentés-invariáns
-- -----------------------------------------------------------
||| Két szó azonos invariáns-osztályba tartozik-e.
||| Diszkrét teszt a "szabad szórend" hipotézisére.
export
azonosInvariáns : Szó -> Szó -> Bool
azonosInvariáns x y = rendez x == rendez y

-- -----------------------------------------------------------
-- 4. Inverziószám — a permutáció költsége
-- -----------------------------------------------------------
||| Fordított sorrendű párok száma (Kendall-tau diszkréten).
export
inverziók : Szó -> Nat
inverziók [] = 0
inverziók (x :: xs) =
  nagyobbUtána x xs + inverziók xs
  where
    ||| Hány elem áll x után, ami kisebb nála (inverziópár).
    nagyobbUtána : Nat -> List Nat -> Nat
    nagyobbUtána _ [] = 0
    nagyobbUtána v (y :: többi) =
      if lteNat y v && not (y == v)
        then S (nagyobbUtána v többi)
        else nagyobbUtána v többi

-- -----------------------------------------------------------
-- 5. Távolság — két szórend közti költség
-- -----------------------------------------------------------
||| Közelítés: az inverziószámok abszolút különbsége.
||| Nulla, ha mindkettő kanonikus (rendezett).
export
távolság : Szó -> Szó -> Nat
távolság x y = abszKül (inverziók x) (inverziók y)

-- -----------------------------------------------------------
-- 6. Példa a dalszövegből: "törpe" betűi
-- -----------------------------------------------------------
||| "törpe" kódjai (kis ábécé): t=4, r=3, p=2, e=1
törpeBetűi : Szó
törpeBetűi = [4, 3, 2, 1]

||| Bizonyítás (konkrét számítás): a rendezés eredménye.
||| (Literál-lal írva — a checker a definíció-nevet nem bontja.)
bizRendezTörpe : rendez [4, 3, 2, 1] = [1, 2, 3, 4]
bizRendezTörpe = Refl

||| Bizonyítás: a rendezett szó inverziószáma nulla.
bizRendezettNulla : inverziók [1, 2, 3, 4] = 0
bizRendezettNulla = Refl

||| Bizonyítás: az eredeti fordított sorrend 6 inverziót tartalmaz.
||| (4 után: 3,2,1 — három; 3 után: 2,1 — kettő; 2 után: 1 — egy.)
bizInverziókTörpe : inverziók [4, 3, 2, 1] = 6
bizInverziókTörpe = Refl

||| Tétel: azonos multisetű szavak azonos invariánsúak.
||| Példa: "törpe" betűinek kevert sorrendje.
kevertTörpe : Szó
kevertTörpe = [1, 4, 2, 3]

||| Bizonyítás: a kevert változat ugyanabba az osztályba tartozik.
bizKevertAzonos : azonosInvariáns [4, 3, 2, 1] [1, 4, 2, 3] = True
bizKevertAzonos = Refl

-- -----------------------------------------------------------
-- 7. Fordítás — a fogalom formalizálása
-- -----------------------------------------------------------
||| Fordítás: forrás -> cél, azonos invariáns-osztályban.
||| A "fordítás szótár nélkül": az invariáns marad, a felszín
||| optimalizálódik.
export
record Fordítás where
  constructor FordításKészít
  ||| Forrás-szórend.
  forrás      : Szó
  ||| Cél-szórend.
  cél         : Szó
  ||| Költség: mennyi mozgatás kellett.
  költség     : Nat

||| Példa-fordítás: "törpe" eredeti sorrendjéből a rendezettbe.
export
mintafordítás : Fordítás
mintafordítás =
  FordításKészít törpeBetűi (rendez törpeBetűi) 6

||| A fordítás igazságosságának diszkrét ellenőrzése:
||| a forrás és a cél ugyanabba az osztályba tartozik-e.
export
helyesFordítás : Fordítás -> Bool
helyesFordítás f = azonosInvariáns (forrás f) (cél f)

||| Bizonyítás: a mintafordítás helyes (diszkrét ellenőrzés).
bizMintaHelyes : azonosInvariáns [4, 3, 2, 1] [1, 2, 3, 4] = True
bizMintaHelyes = Refl
